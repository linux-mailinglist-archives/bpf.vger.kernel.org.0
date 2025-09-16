Return-Path: <bpf+bounces-68552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D5B5A3CA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156E81BC7E36
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7F2EB843;
	Tue, 16 Sep 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crOPvLVt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D5274FEF
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057793; cv=none; b=OUnUV/mdTUnsty7l7LNtOGRyZ6TivRMUHtTm8IXeyiC/b9LSi6G9dQvZ+KiazbqhM02qsxjSUU+UCZNCYMkawq/A1NWhfms6j8a+F2VoOryZFSA5UGPV9mWOH0z6MMkklRX7GRLEMdOvOI8V6JrFH60mX85oVAdABArUjHNLZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057793; c=relaxed/simple;
	bh=eJHt92kobk+bkmbo35/E1ASpUn4OPBiVUg/+l54JaDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le9vWc6j26EhF+Ni428g1ChQeEKLYSB+WwiAcFWPDIYioTuWo3LVRMmPfiNd/LC+nGuf/xvvs/BwbkZPDUPCmM8OYgS15C2rDS0Ax5wZpIeF6uuokaQw9erjqE8pcsTWY/711+B85ppTe04UQOCpAMqpRNNrH0tslvqg4s8bDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crOPvLVt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b13313b1bso41339415ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057791; x=1758662591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6d5m6CzbCrypwr8nA0bWrp6zw72yvoH9wXOrQtrsbY=;
        b=crOPvLVtXHlsMM4uoTir1g1y4aP3wy8e+LDhLUGRINlVPgzp6Yi/fXt2eHkix8qocX
         jNzVlOtcMKJeZo5V2g609vwN4s60gUnt2QasVYoKjnwzmX8zk5hmZmu18aCAAaWYaown
         NTpNHLFNRMCuernxJXWNkhL3FXcn7mh6ZZbJQ5AaNtVTO1aHw/AReawFIBwJlyS4XSp+
         OytEtaSDe5iz1dNJYmOhYNxYpOx3lK5zgRlHLVOhQT4riXjV7fTxy+urTZgnS3Pe9kyK
         ZMspgsJn03XAW240eWOUrWCYauElvKrGG5Cii44vEGy+gZPnsfs6pYwIZ2bNriEv3x69
         P8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057791; x=1758662591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6d5m6CzbCrypwr8nA0bWrp6zw72yvoH9wXOrQtrsbY=;
        b=U/CaqCcD9xRvlHQ1cloQQZTqO4PTkOvmuTrFo1LWsEpEtIAmqR+6TUBIBaYQKzi8jI
         JSe4AJE874JZLlmZ4A0L92AG2JiLO61rFFYjos5ftVT+U6rfNzvHNOvMK+FRbdeKm7+u
         AtTlGQxcMieNoOBFuqCHDVYorDbxmtLZvi+sk/eu36NBnMql36ETHhTF/avktrydCXHg
         Tj9iYvGNZwPV6kV9bl5hfDV2sXNAJYCjb1EpPD3LioKAScdLfsW6IUFdBWpSau9pCz+x
         EKtKUizXDvTfpuADkFz3EZFd/Dk/JrgCwPeUSz3R6oKDID08dQzL2Na0GwHsRmWITrOR
         8ROA==
X-Gm-Message-State: AOJu0YwxmB0i78lHBnUILQZnli7GUGmi5Ub96iun0uK6Hcg2a+R2syim
	cehXeYvC07FJY4kHKA48ml1yuc7G3MYGdE2cn8MQH7IXp5UcGWJbxxZso7sJHmye
X-Gm-Gg: ASbGnctANXgsIOl05HQjW+5xoNCoBCx2BrOIp32YkMDiEecw3zK46q1TPPY8y6p+giL
	XX/pngGQwvJXoucw9Vu1+U3DS4+Ar9nt5absgEZmED1JizHH+XtsDFrIwdFcbxoJ3oXalEljK70
	LL6KuE/FsuwTI3sB7vFCY/G7zdrMzoWMBqd+5T5IEcogQ1xLJWLHsMNdcDXxGgkBq54fgTu3yJj
	zIAcKqKqTif6KA7Dg2k8J8ZEw7OwBoev859AZaThJqdm8ldS73IWZzpHmj+Ojq/Yj4KSmlEg0HQ
	7DOVHjFrU+OztZdixoasFTvmmlqJaP1khJWbiKi2t8X4vLotOEHrEWsbEASlOXsniUVdUaxzIzH
	Q9BSgGqPaJeOrrzyFajBhIMHLzxfeG1yf+Y/knZqmf5pxSg==
X-Google-Smtp-Source: AGHT+IEaK6hAcrLcjhxWy4RVlp5WUSi2uDwgy2CNRSflfGqD4PDlpjJUvWstDYER5FHfryFEEqFzJw==
X-Received: by 2002:a17:903:1c9:b0:266:821a:cadb with SMTP id d9443c01a7336-266821acebdmr118463945ad.4.1758057790878;
        Tue, 16 Sep 2025 14:23:10 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267df817ef5sm23021585ad.0.2025.09.16.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:23:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: trigger verifier.c:maybe_exit_scc() for a speculative state
Date: Tue, 16 Sep 2025 14:22:51 -0700
Message-ID: <20250916212251.3490455-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916212251.3490455-1-eddyz87@gmail.com>
References: <20250916212251.3490455-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a test case minimized from a syzbot reproducer from [1].
The test case triggers verifier.c:maybe_exit_scc() w/o
preceding call to verifier.c:maybe_enter_scc() on a speculative
symbolic execution path.

Here is verifier log for the test case:

  Live regs before insn:
        0: .......... (b7) r0 = 100
    1   1: 0......... (7b) *(u64 *)(r10 -512) = r0
    1   2: 0......... (b5) if r0 <= 0x0 goto pc-2
        3: 0......... (95) exit
  0: R1=ctx() R10=fp0
  0: (b7) r0 = 100                      ; R0_w=100
  1: (7b) *(u64 *)(r10 -512) = r0       ; R0_w=100 R10=fp0 fp-512_w=100
  2: (b5) if r0 <= 0x0 goto pc-2
  mark_precise: ...
  2: R0_w=100
  3: (95) exit

  from 2 to 1 (speculative execution): R0_w=scalar() R1=ctx() R10=fp0 fp-512_w=100
  1: R0_w=scalar() R1=ctx() R10=fp0 fp-512_w=100
  1: (7b) *(u64 *)(r10 -512) = r0
  processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

- Non-speculative execution path 0-3 does not allocate any checkpoints
  (and hence does not call maybe_enter_scc()), and schedules a
  speculative jump from 2 to 1.
- Speculative execution path stops immediately because of an infinite
  loop detection and triggers verifier.c:update_branch_counts() ->
  maybe_exit_scc() calls.

[1] https://lore.kernel.org/bpf/68c85acd.050a0220.2ff435.03a4.GAE@google.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_loops1.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index e07b43b78fd2..fbdde80e7b90 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -283,4 +283,25 @@ exit_%=:						\
 	: __clobber_all);
 }
 
+/*
+ * This test case triggered a bug in verifier.c:maybe_exit_scc().
+ * Speculative execution path reaches stack access instruction,
+ * stops and triggers maybe_exit_scc() w/o accompanying maybe_enter_scc() call.
+ */
+SEC("socket")
+__arch_x86_64
+__caps_unpriv(CAP_BPF)
+__naked void maybe_exit_scc_bug1(void)
+{
+	asm volatile (
+	"r0 = 100;"
+"1:"
+	/* Speculative execution path reaches and stops here. */
+	"*(u64 *)(r10 - 512) = r0;"
+	/* Condition is always false, but verifier speculatively executes the true branch. */
+	"if r0 <= 0x0 goto 1b;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


