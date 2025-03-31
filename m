Return-Path: <bpf+bounces-54923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA88A75E40
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F281683B9
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989D13C816;
	Mon, 31 Mar 2025 03:38:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B31FC3
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743392326; cv=none; b=HgZOrfTpR9hcMI1ZllvFZPmawou3KNUtWU+FuKNY8p5XiS1DbVciolioYjZAITIhlwpBKm/liXKk85v0Zk+Su6ZK7MVnMMlkyeAXZBvKxzscQW1rqIITATnnYZKcwsf8TTBBQOqN5f954cqTOA2jZe3ClcDB3Gx3S1I9WTaoEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743392326; c=relaxed/simple;
	bh=iZHuc41bOpRLxZQoZmLkGNAWhlAlmVIh2Km+bTzFQxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xov9ouxRW4itwsQexpBL5cSioBSPZGybVUQwQ9KtIwBWX7n2uNPYLVh6FcJKMgEvSIUvSmak8a3mZcHKsLu6vHNYHOuj904fiSEPm/blpPqwvyN3259e2WeNc6FegrXhl7cWSFGe8mwygSIeO9XMJ/c60DVWL5nZoOdi0QfK9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7DC8544C31A3; Sun, 30 Mar 2025 20:38:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix verifier_private_stack test failure
Date: Sun, 30 Mar 2025 20:38:28 -0700
Message-ID: <20250331033828.365077-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several verifier_private_stack tests failed with latest bpf-next.
For example, for 'Private stack, single prog' subtest, the
jitted code:
  func #0:
  0:      f3 0f 1e fa                             endbr64
  4:      0f 1f 44 00 00                          nopl    (%rax,%rax)
  9:      0f 1f 00                                nopl    (%rax)
  c:      55                                      pushq   %rbp
  d:      48 89 e5                                movq    %rsp, %rbp
  10:     f3 0f 1e fa                             endbr64
  14:     49 b9 58 74 8a 8f 7d 60 00 00           movabsq $0x607d8f8a7458=
, %r9
  1e:     65 4c 03 0c 25 28 c0 48 87              addq    %gs:-0x78b73fd8=
, %r9
  27:     bf 2a 00 00 00                          movl    $0x2a, %edi
  2c:     49 89 b9 00 ff ff ff                    movq    %rdi, -0x100(%r=
9)
  33:     31 c0                                   xorl    %eax, %eax
  35:     c9                                      leave
  36:     e9 20 5d 0f e1                          jmp     0xffffffffe10f5=
d5b

The insn 'addq %gs:-0x78b73fd8, %r9' does not match the expected
regex 'addq %gs:0x{{.*}}, %r9' and this caused test failure.

Fix it by changing '%gs:0x{{.*}}' to '%gs:{{.*}}' to accommodate the
possible negative offset. A few other subtests are fixed in a similar way=
.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b=
/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index b1fbdf119553..fc91b414364e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -27,7 +27,7 @@ __description("Private stack, single prog")
 __success
 __arch_x86_64
 __jited("	movabsq	$0x{{.*}}, %r9")
-__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	addq	%gs:{{.*}}, %r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x100(%r9)")
 __naked void private_stack_single_prog(void)
@@ -74,7 +74,7 @@ __success
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
-__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	addq	%gs:{{.*}}, %r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
@@ -122,7 +122,7 @@ __jited("	pushq	%rbp")
 __jited("	movq	%rsp, %rbp")
 __jited("	endbr64")
 __jited("	movabsq	$0x{{.*}}, %r9")
-__jited("	addq	%gs:0x{{.*}}, %r9")
+__jited("	addq	%gs:{{.*}}, %r9")
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
--=20
2.47.1


