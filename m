Return-Path: <bpf+bounces-19627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365ED82F5B8
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237881C2402D
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833B1EB5C;
	Tue, 16 Jan 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJnRrSCe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556691EB4F;
	Tue, 16 Jan 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434171; cv=none; b=SQ2QAG8MEHhHTKDUeoT+GXyxx7SsXWSUQ1HvNNUJFmGwGpRsxf64si6jwfae0Ij9T6er49VVR7BF+7dIudCCq1X2XUBvABk2qQfl6jZvpzHbeEm5AvKV2O0eHdFLuR/EXYVXdMLl5kVuzQFHfXr1/qURlbos7He8bncYskqHp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434171; c=relaxed/simple;
	bh=VLPD9k6rnpYEto5RbuNi8aqGwxQuGvH9H86d70Wgxbw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=QHqAs+HVz9F+OClcB3h8SXoN5uAQa6bR0y3bF7dmsQqr8zAlFFTfnAbPXWNIJikNoZV3/R1CN4WzOfcPBqPmYDMVntJHoVQE/HPz7P9Bc6H7XL73+vQOYTK/eteymwMXT13D9caIUHQyMRP331TVEQMDb+LC8rrHi9WtwL+96Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJnRrSCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878D8C43390;
	Tue, 16 Jan 2024 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434170;
	bh=VLPD9k6rnpYEto5RbuNi8aqGwxQuGvH9H86d70Wgxbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJnRrSCeQyl5JJInPLxKbH/3iBAIvWXlHgYY32nr7yMIKTmTxT11xFv6BtrUVLgb5
	 4FH5snjCs4wx53j8V//zMHXaN5WvBKRl+Zb/yINglstsXMp6aPZkRXxltE/t/I4m+p
	 iSkeMcMDfbbNZihf3LHp754aZ/8BP5yqOQaYB1pD+TZAtFXQvP0IgIdMAGwPUwtmby
	 6UQZLp1ld3QeqOiBQqSV4wNK3kiZyuI5A9P+OFFcHLta6mxpWIvV0nPsBfHvsdpApk
	 GW3IeRvSFl7oP9lDbs7+sZU7qSPe7qyprWx60uJQumcMi5gIGM0Ii4o5V1XGuzyo9/
	 4LxpyTAtkUv2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 005/108] libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
Date: Tue, 16 Jan 2024 14:38:31 -0500
Message-ID: <20240116194225.250921-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 7f7c43693c1b46652cfafb7af67ba31726d6ec4e ]

Martin reported that there is a libbpf complaining of non-zero-value tail
padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
to have a 4-byte tail padding. This only happens to clang compiler.
The commend line is: ./test_progs -t tc_netkit_multi_links
Martin and I did some investigation and found this indeed the case and
the following are the investigation details.

Clang:
  clang version 18.0.0
  <I tried clang15/16/17 and they all have similar results>

tools/lib/bpf/libbpf_common.h:
  #define LIBBPF_OPTS_RESET(NAME, ...)                                      \
        do {                                                                \
                memset(&NAME, 0, sizeof(NAME));                             \
                NAME = (typeof(NAME)) {                                     \
                        .sz = sizeof(NAME),                                 \
                        __VA_ARGS__                                         \
                };                                                          \
        } while (0)

  #endif

tools/lib/bpf/libbpf.h:
  struct bpf_netkit_opts {
        /* size of this struct, for forward/backward compatibility */
        size_t sz;
        __u32 flags;
        __u32 relative_fd;
        __u32 relative_id;
        __u64 expected_revision;
        size_t :0;
  };
  #define bpf_netkit_opts__last_field expected_revision
In the above struct bpf_netkit_opts, there is no tail padding.

prog_tests/tc_netkit.c:
  static void serial_test_tc_netkit_multi_links_target(int mode, int target)
  {
        ...
        LIBBPF_OPTS(bpf_netkit_opts, optl);
        ...
        LIBBPF_OPTS_RESET(optl,
                .flags = BPF_F_BEFORE,
                .relative_fd = bpf_program__fd(skel->progs.tc1),
        );
        ...
  }

Let us make the following source change, note that we have a 4-byte
tailing padding now.
  diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
  index 6cd9c501624f..0dd83910ae9a 100644
  --- a/tools/lib/bpf/libbpf.h
  +++ b/tools/lib/bpf/libbpf.h
  @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
   struct bpf_netkit_opts {
        /* size of this struct, for forward/backward compatibility */
        size_t sz;
  -       __u32 flags;
        __u32 relative_fd;
        __u32 relative_id;
        __u64 expected_revision;
  +       __u32 flags;
        size_t :0;
   };
  -#define bpf_netkit_opts__last_field expected_revision
  +#define bpf_netkit_opts__last_field flags

The clang 18 generated asm code looks like below:
    ;       LIBBPF_OPTS_RESET(optl,
    55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
    55e7: 31 f6                         xorl    %esi, %esi
    55e9: ba 20 00 00 00                movl    $0x20, %edx
    55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_netkit_multi_links_target+0x18d3>
    55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
    55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
    5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
    5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_netkit_multi_links_target+0x18ee>
    560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
    5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
    561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
    5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
    563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
    563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
    5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
    5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
    5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
    ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

At -O0 level, the clang compiler creates an intermediate copy.
We have below to store 'flags' with 4-byte store and leave another 4 byte
in the same 8-byte-aligned storage undefined,
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
and later we store 8-byte to the original zero'ed buffer
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)

This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
may be garbage.

gcc (gcc 11.4) does not have this issue as it does zeroing struct first before
doing assignments:
  ;       LIBBPF_OPTS_RESET(optl,
    50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
    5104: ba 20 00 00 00                movl    $0x20, %edx
    5109: be 00 00 00 00                movl    $0x0, %esi
    510e: 48 89 c7                      movq    %rax, %rdi
    5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_netkit_multi_links_target+0x1522>
    5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
    511a: 48 8b 40 18                   movq    0x18(%rax), %rax
    511e: 48 89 c7                      movq    %rax, %rdi
    5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_netkit_multi_links_target+0x1532>
    5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp)
    5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp)
    513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp)
    5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp)
    5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rbp)
    515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
    5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
  ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

It is not clear how to resolve the compiler code generation as the compiler
generates correct code w.r.t. how to handle unnamed padding in C standard.
So this patch changed LIBBPF_OPTS_RESET macro to avoid uninitialized tail
padding. We already knows LIBBPF_OPTS macro works on both gcc and clang,
even with tail padding. So LIBBPF_OPTS_RESET is changed to be a
LIBBPF_OPTS followed by a memcpy(), thus avoiding uninitialized tail padding.

The below is asm code generated with this patch and with clang compiler:
    ;       LIBBPF_OPTS_RESET(optl,
    55e3: 48 8d bd 10 fd ff ff          leaq    -0x2f0(%rbp), %rdi
    55ea: 31 f6                         xorl    %esi, %esi
    55ec: ba 20 00 00 00                movl    $0x20, %edx
    55f1: e8 00 00 00 00                callq   0x55f6 <serial_test_tc_netkit_multi_links_target+0x18d6>
    55f6: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
    5601: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
    5608: 48 8b 78 18                   movq    0x18(%rax), %rdi
    560c: e8 00 00 00 00                callq   0x5611 <serial_test_tc_netkit_multi_links_target+0x18f1>
    5611: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
    5617: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
    5621: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
    562c: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
    5636: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
    563d: 48 89 45 98                   movq    %rax, -0x68(%rbp)
    5641: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
    5648: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
    564c: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
    5653: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
    5657: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565e: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
    ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

In the above code, a temporary buffer is zeroed and then has proper value assigned.
Finally, values in temporary buffer are copied to the original variable buffer,
hence tail padding is guaranteed to be 0.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/bpf/20231107201511.2548645-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf_common.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index b7060f254486..8fe248e14eb6 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -79,11 +79,14 @@
  */
 #define LIBBPF_OPTS_RESET(NAME, ...)					    \
 	do {								    \
-		memset(&NAME, 0, sizeof(NAME));				    \
-		NAME = (typeof(NAME)) {					    \
-			.sz = sizeof(NAME),				    \
-			__VA_ARGS__					    \
-		};							    \
+		typeof(NAME) ___##NAME = ({ 				    \
+			memset(&___##NAME, 0, sizeof(NAME));		    \
+			(typeof(NAME)) {				    \
+				.sz = sizeof(NAME),			    \
+				__VA_ARGS__				    \
+			};						    \
+		});							    \
+		memcpy(&NAME, &___##NAME, sizeof(NAME));		    \
 	} while (0)
 
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
-- 
2.43.0


