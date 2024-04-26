Return-Path: <bpf+bounces-27920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E78B36F6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ADF1C21A46
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533C145B07;
	Fri, 26 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEx9IEAU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58E13D244;
	Fri, 26 Apr 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133641; cv=none; b=Tc/ZvjntiZB0FYtJl1/e/Zx9Es/4JDb0FHdlQGYFkD1hA/nX7Ewn+NSXoayR962KyDHjB80RcHn8hqo4pHTkIENI3kel/Yff9efQUeXmUFkRDBbokPZSMYJ/9ryQnMFVkk6SE71H/pufjQGkBO0kc2jBDX4GjzO+wOPQxuNqEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133641; c=relaxed/simple;
	bh=DxBgaKwTefQF1Qh6WVIH65YwLhtzYLsdLbNUCj6Cxbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y3PGll9sdcOoz7BGjkDTWGgdswzgmhTgS3Gtfl1/WStEgVrUGoywaiVHzFQAabHmhvKUmVmvxe1D8uUV2WalBuCSk9l+sNA2S4swqWFZe9BGn6pSD14+HeA7N20coq6yAq6T5hjwagN2ku/YwZKb7TdbSMHuHKCl3/0PdxeDXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEx9IEAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A06C113CD;
	Fri, 26 Apr 2024 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714133641;
	bh=DxBgaKwTefQF1Qh6WVIH65YwLhtzYLsdLbNUCj6Cxbw=;
	h=From:To:Cc:Subject:Date:From;
	b=CEx9IEAUBV834qasmxP80Ps5Z5rdkkglCPZFARjcKLNFuI1LOxyRoDg2urrmK0ZRT
	 XKfc2jX1kM90tB19kZBbOfZo9A60tuFtns5uczMFYtDZd/8zhvJuRY35itosqgchSV
	 RdOJ4pyx9OfgmRMy/1p/29fTr9mcPEI61SfU/K0DH+hvPlsWTtAjlEAyXYyDY1BCJh
	 s9xIzWeMn4PGnGJ9zsJ8mbLhzsqu5YkeyZAHBgsQHZ6yL20j9TG+Z/bZbPQJVuEHOx
	 7uKMZoNcbFD4erfA9eI7com+3hQndmTPO8DQ6jAWIM1uMHIj7aBI084pFOhdZgVpzo
	 6lJsXa0U8gnyw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Florent Revest <revest@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 0/2]  bpf, arm64: Support per-cpu instruction
Date: Fri, 26 Apr 2024 12:13:47 +0000
Message-Id: <20240426121349.97651-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2 -> v3:
v2: https://lore.kernel.org/all/20240424173550.16359-1-puranjay@kernel.org/
- Fixed the xlated dump of percpu mov to "r0 = &(void __percpu *)(r0)"
- Made ARM64 and x86-64 use the same code for inlining. The only difference
  that remains is the per-cpu address of the cpu_number.

Changes in v1 -> v2:
v1: https://lore.kernel.org/all/20240405091707.66675-1-puranjay12@gmail.com/
- Add a patch to inline bpf_get_smp_processor_id()
- Fix an issue in MRS instruction encoding as pointed out by Will
- Remove CONFIG_SMP check because arm64 kernel always compiles with CONFIG_SMP

This series adds the support of internal only per-CPU instructions and
inlines the bpf_get_smp_processor_id() helper call for ARM64 BPF JIT.

Here is an example of calls to bpf_get_smp_processor_id() and
percpu_array_map_lookup_elem() before and after this series.

                                         BPF
                                        =====
              BEFORE                                       AFTER
             --------                                     -------

int cpu = bpf_get_smp_processor_id();           int cpu = bpf_get_smp_processor_id();
(85) call bpf_get_smp_processor_id#229032       (18) r0 = 0xffff800082072008
                                                (bf) r0 = &(void __percpu *)(r0)
                                                (61) r0 = *(u32 *)(r0 +0)


p = bpf_map_lookup_elem(map, &zero);            p = bpf_map_lookup_elem(map, &zero);
(18) r1 = map[id:78]                            (18) r1 = map[id:153]
(18) r2 = map[id:82][0]+65536                   (18) r2 = map[id:157][0]+65536
(85) call percpu_array_map_lookup_elem#313512   (07) r1 += 496
                                                (61) r0 = *(u32 *)(r2 +0)
                                                (35) if r0 >= 0x1 goto pc+5
                                                (67) r0 <<= 3
                                                (0f) r0 += r1
                                                (79) r0 = *(u64 *)(r0 +0)
                                                (bf) r0 = &(void __percpu *)(r0)
                                                (05) goto pc+1
                                                (b7) r0 = 0


                                      ARM64 JIT
                                     ===========

              BEFORE                                       AFTER
             --------                                     -------

int cpu = bpf_get_smp_processor_id();           int cpu = bpf_get_smp_processor_id();
mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff8000ffffffff
movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, lsl #16
movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
blr     x10                                     mrs     x10, tpidr_el1
add     x7, x0, #0x0                            add     x7, x7, x10
                                                ldr     w7, [x7]


p = bpf_map_lookup_elem(map, &zero);            p = bpf_map_lookup_elem(map, &zero);
mov     x0, #0xffff0003ffffffff                 mov     x0, #0xffff0003ffffffff
movk    x0, #0xce5c, lsl #16                    movk    x0, #0xe0f3, lsl #16
movk    x0, #0xca00                             movk    x0, #0x7c00
mov     x1, #0xffff8000ffffffff                 mov     x1, #0xffff8000ffffffff
movk    x1, #0x8bdb, lsl #16                    movk    x1, #0xb0c7, lsl #16
movk    x1, #0x6000                             movk    x1, #0xe000
mov     x10, #0xffffffffffff3ed0                add     x0, x0, #0x1f0
movk    x10, #0x802d, lsl #16                   ldr     w7, [x1]
movk    x10, #0x8000, lsl #32                   cmp     x7, #0x1
blr     x10                                     b.cs    0x0000000000000090
add     x7, x0, #0x0                            lsl     x7, x7, #3
                                                add     x7, x7, x0
                                                ldr     x7, [x7]
                                                mrs     x10, tpidr_el1
                                                add     x7, x7, x10
                                                b       0x0000000000000094
                                                mov     x7, #0x0

              Performance improvement found using benchmark[1]

             BEFORE                                       AFTER
            --------                                     -------

glob-arr-inc   :   23.817 ± 0.019M/s      glob-arr-inc   :   24.631 ± 0.027M/s
arr-inc        :   23.253 ± 0.019M/s      arr-inc        :   23.742 ± 0.023M/s
hash-inc       :   12.258 ± 0.010M/s      hash-inc       :   12.625 ± 0.004M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Puranjay Mohan (2):
  arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
  bpf, arm64: inline bpf_get_smp_processor_id() helper

 arch/arm64/include/asm/insn.h |  7 +++++++
 arch/arm64/lib/insn.c         | 11 +++++++++++
 arch/arm64/net/bpf_jit.h      |  6 ++++++
 arch/arm64/net/bpf_jit_comp.c | 14 ++++++++++++++
 kernel/bpf/verifier.c         | 24 +++++++++++++++++-------
 5 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.40.1


