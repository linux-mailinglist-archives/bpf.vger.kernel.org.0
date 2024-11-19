Return-Path: <bpf+bounces-45172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8829D250B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F24FB22744
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD21C9EC4;
	Tue, 19 Nov 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O9z+BpMg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49A1C879A
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016447; cv=none; b=hB4pMFTwesl2IArbei5jgTiDwAJP44pRbwqTlMUlLtwgKKlxfeGpZ64jBqfO5Ee4hCaQ7rLGQ0K3qYXhtPYbT/B+wkOCnBWAN+cfOUStnIu4Y47DhF6GzQfIpNYrD3b8XKEOLAo3mr9cfaoRjWjlcUawJpRnnWWsgYRlmCHLyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016447; c=relaxed/simple;
	bh=o3Q1xFnk31WTbi2tjItKocJyFSmVb84tEgKl5Vkvbgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gijjBX49jalKTWxyW7pbt4kZTYC/YosFvdhtqoFuLBldBuTM0j9idydv0e/6ahy+oy2jlauyk7iDi+ElHLNzu8upzjv9MK0mTTmH1ab6O4z67AIKYn6/jP9kABjGM9T/UBka0/PNMtjyhxKrxfuKY5shsZe2f1eHLtmLz4FZaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O9z+BpMg; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53da209492cso5020878e87.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 03:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016443; x=1732621243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLuBCtGW4O6bkunfCcNvcqRBo/39Igf6vJl0V3Y75ro=;
        b=O9z+BpMg9bQA3SKrwOLRHXdvB3Tl52JpKzLQWSNMfGVxt0gdZfW75fA1VyIzA5dP7k
         RPCg3cOCCgRZ776H/Rwb5EwsiXTWLx139WcuY5OuIW147xLCKJxb5QGwvsftXf/KIZRM
         gwwoLYGnmSBibLCYA63OivVFoNPjA8UR0fCFwTM35q4gTOoqAsawCAhM+/QMx9lIRpPQ
         rijXBJP3NML5xabc49lQlmAux3+TmRDM1xX9DpzDLVKo8OCBLure2MSnNMMZxvGaoIWt
         GMT3YfxC1AUHs/nZdGUTB16ZqvaUs7aRTgMT/hdREUNgh+SjvNScA8fRRIzxd/rPFsJp
         8JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016443; x=1732621243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLuBCtGW4O6bkunfCcNvcqRBo/39Igf6vJl0V3Y75ro=;
        b=QdYxTY8aDdlICph6UCVXwAIulFYAKXSTs186ORPv9jyZF4cwsTI+cUEdd/rWOslZNb
         AVzln7m14H0fjCsQdAutZp0MpfC+gAODsBMTGFP6fwAh4ZNGYdG8mlKewHACvw+kCHfG
         WKWpn5wGS1io5+wh3rlztFyy4RUM8riRWvs8cNw01iO4O8tsvhyk7yA4brTY8mrrEQfu
         AXG4FKi4ANJLvs+c9QYtjXdN4cQCkcLI/5RBq2YCLwbzWL8AwT7WsTi9M13gWcQgYn7m
         /OaZDWogJkr9lKkjbLyXpPBZ2MehbRMaOqShahCmFzs1viif1UT5vWUR2/jLuzsUJBTj
         0ytQ==
X-Gm-Message-State: AOJu0Ywhjy0mWDRdAHOJgw7rYZzpSq+cl0tgY8nmnNGplTdvvZVDQIWV
	GJyh+A49NUnQuMbj4vBWplagZKItGwpdqYEpWUVH+qwXBoYTHvnYpXVFFodBN+VG24Hklhw7Nli
	VUfZeaA==
X-Google-Smtp-Source: AGHT+IFluW8UtoeB1GZNt9gRrL1EUmGLwGS2IjTrhtjRmLwNosdvZ0028H6Qv79dVxUxS1z6tsctZQ==
X-Received: by 2002:a05:6512:b1e:b0:539:f51e:2457 with SMTP id 2adb3069b0e04-53dab3c50c2mr6418382e87.52.1732016443546;
        Tue, 19 Nov 2024 03:40:43 -0800 (PST)
Received: from localhost (2001-b011-fa04-f863-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f863:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea31f14300sm6084923a91.4.2024.11.19.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:40:43 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next v2 3/3] selftests/bpf: add more verifier tests for signed range deduction of BPF_AND
Date: Tue, 19 Nov 2024 19:40:21 +0800
Message-ID: <20241119114023.397450-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119114023.397450-1-shung-hsi.yu@suse.com>
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more specific test cases into verifier_and.c to test against signed
range deduction.

WIP, Test failing.
---
The GitHub action is at https://github.com/kernel-patches/bpf/actions/runs/11909088689/

For and_mixed_range_vs_neg_const()

  Error: #432/8 verifier_and/[-1,0] range vs negative constant @unpriv
  ...
  VERIFIER LOG:
  =============
  0: R1=ctx() R10=fp0
  0: (85) call bpf_get_prandom_u32#7    ; R0_w=Pscalar()
  1: (67) r0 <<= 63                     ; R0_w=Pscalar(smax=smax32=umax32=0,umax=0x8000000000000000,smin32=0,var_off=(0x0; 0x8000000000000000))
  2: (c7) r0 s>>= 63                    ; R0_w=Pscalar(smin=smin32=-1,smax=smax32=0)
  3: (b7) r1 = -13                      ; R1_w=P-13
  4: (5f) r0 &= r1                      ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R1_w=P-13
  5: (b7) r2 = 0                        ; R2_w=P0
  6: (6d) if r0 s> r2 goto pc+4         ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R2_w=P0
  7: (b7) r2 = -16                      ; R2=P-16
  8: (cd) if r0 s< r2 goto pc+2 11: R0=Pscalar() R1=P-13 R2=Pscalar() R10=fp0

	Somehow despite the verifier knows that r0's smin=-16 and smax=0,
	and r2's smin=-16 and smax=-16, it does determine that
	[-16, 0] s< -16 is always false.

  11: (61) r1 = *(u32 *)(r1 +0)
  R1 invalid mem access 'scalar'

Felt like this is something obvious, but I just couldn't see where the
problem lies.

---
 .../selftests/bpf/progs/verifier_and.c        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index e97e518516b6..56c362f99a21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -104,4 +104,60 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("[-1,0] range vs negative constant")
+__success __success_unpriv __retval(0)
+__naked void and_mixed_range_vs_neg_const(void)
+{
+	/* Use ARSH with AND like compiler would */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 <<= 63;					\
+	r0 s>>= 63; /* r0 = [-1, 0] */			\
+	r1 = -13;					\
+	r0 &= r1;					\
+	/* [-1, 0] & -13 give either -13 or 0. So	\
+	 * ideally this should be a tight range of	\
+	 * [-13, 0], but verifier is not advanced enough\
+	 * to deduce that. just knowing result is in	\
+	 * [-16, 0] is good enough.			\
+	 */                                             \
+	r2 = 0;						\
+	if r0 s> r2 goto l0_%=;				\
+	r2 = -16;					\
+	if r0 s< r2 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:  r1 = *(u32*)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit [-1,0] range vs negative constant")
+__success __success_unpriv __retval(0)
+__naked void and32_mixed_range_vs_neg_const(void)
+{
+	/* See and_mixed_range_vs_neg_const() */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 <<= 31;					\
+	w0 s>>= 31;					\
+	w1 = -13;					\
+	w0 &= w1;					\
+	w2 = 0;						\
+	if w0 s> w2 goto l0_%=;				\
+	w2 = -16;					\
+	if w0 s< w2 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:  r1 = *(u32*)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0


