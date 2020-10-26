Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84342299FE3
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 01:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409979AbgJZXxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 19:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409972AbgJZXxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 19:53:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFB22151B;
        Mon, 26 Oct 2020 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756389;
        bh=lBTaitZwC3DCh27k3l38N89/0TU95O7CiRGAQNlNUdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hc2MqyvQma7Eyi++QFkJAQZsDg3fwR9BqWh7ms7fxzVR/qDTvKnusOfDlJW6JwmRV
         kscV9c2kFR++8Am3Y6SSXg6BIXhTEMKnTXgLG9+m7pIiMON6UsNjN+nEm+Y/2vXfqC
         4ZRI+nCOP0L8qFlGmo6HNtfNjWgrCzUxz6+n3A8s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.8 052/132] bpf: Permit map_ptr arithmetic with opcode add and offset 0
Date:   Mon, 26 Oct 2020 19:50:44 -0400
Message-Id: <20201026235205.1023962-52-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 7c6967326267bd5c0dded0a99541357d70dd11ac ]

Commit 41c48f3a98231 ("bpf: Support access
to bpf map fields") added support to access map fields
with CORE support. For example,

            struct bpf_map {
                    __u32 max_entries;
            } __attribute__((preserve_access_index));

            struct bpf_array {
                    struct bpf_map map;
                    __u32 elem_size;
            } __attribute__((preserve_access_index));

            struct {
                    __uint(type, BPF_MAP_TYPE_ARRAY);
                    __uint(max_entries, 4);
                    __type(key, __u32);
                    __type(value, __u32);
            } m_array SEC(".maps");

            SEC("cgroup_skb/egress")
            int cg_skb(void *ctx)
            {
                    struct bpf_array *array = (struct bpf_array *)&m_array;

                    /* .. array->map.max_entries .. */
            }

In kernel, bpf_htab has similar structure,

	    struct bpf_htab {
		    struct bpf_map map;
                    ...
            }

In the above cg_skb(), to access array->map.max_entries, with CORE, the clang will
generate two builtin's.
            base = &m_array;
            /* access array.map */
            map_addr = __builtin_preserve_struct_access_info(base, 0, 0);
            /* access array.map.max_entries */
            max_entries_addr = __builtin_preserve_struct_access_info(map_addr, 0, 0);
	    max_entries = *max_entries_addr;

In the current llvm, if two builtin's are in the same function or
in the same function after inlining, the compiler is smart enough to chain
them together and generates like below:
            base = &m_array;
            max_entries = *(base + reloc_offset); /* reloc_offset = 0 in this case */
and we are fine.

But if we force no inlining for one of functions in test_map_ptr() selftest, e.g.,
check_default(), the above two __builtin_preserve_* will be in two different
functions. In this case, we will have code like:
   func check_hash():
            reloc_offset_map = 0;
            base = &m_array;
            map_base = base + reloc_offset_map;
            check_default(map_base, ...)
   func check_default(map_base, ...):
            max_entries = *(map_base + reloc_offset_max_entries);

In kernel, map_ptr (CONST_PTR_TO_MAP) does not allow any arithmetic.
The above "map_base = base + reloc_offset_map" will trigger a verifier failure.
  ; VERIFY(check_default(&hash->map, map));
  0: (18) r7 = 0xffffb4fe8018a004
  2: (b4) w1 = 110
  3: (63) *(u32 *)(r7 +0) = r1
   R1_w=invP110 R7_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R10=fp0
  ; VERIFY_TYPE(BPF_MAP_TYPE_HASH, check_hash);
  4: (18) r1 = 0xffffb4fe8018a000
  6: (b4) w2 = 1
  7: (63) *(u32 *)(r1 +0) = r2
   R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0) R2_w=invP1 R7_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R10=fp0
  8: (b7) r2 = 0
  9: (18) r8 = 0xffff90bcb500c000
  11: (18) r1 = 0xffff90bcb500c000
  13: (0f) r1 += r2
  R1 pointer arithmetic on map_ptr prohibited

To fix the issue, let us permit map_ptr + 0 arithmetic which will
result in exactly the same map_ptr.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200908175702.2463625-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89b07db146763..2b318db54bf39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5042,6 +5042,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst, reg_type_str[ptr_reg->type]);
 		return -EACCES;
 	case CONST_PTR_TO_MAP:
+		/* smin_val represents the known value */
+		if (known && smin_val == 0 && opcode == BPF_ADD)
+			break;
+		/* fall-through */
 	case PTR_TO_PACKET_END:
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCKET_OR_NULL:
-- 
2.25.1

