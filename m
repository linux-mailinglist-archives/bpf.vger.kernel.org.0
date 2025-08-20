Return-Path: <bpf+bounces-66089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB40B2DDA6
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289C3725FE5
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3491F31DDA9;
	Wed, 20 Aug 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9TiqeGB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB431DDA1
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695959; cv=none; b=nedyhsT1u3Oi6Lx5oNAbKBqzRo8jowgOnYI4r+5G0axOzhEkqblPN7twq22ggFxFFDvfYJGEBGPduLlrw4MmW1MzqUck7WY0/3bCVnLtgriBu935rJfO4PkWKB/agK5D4oYFZP9qjrSRta69U17dwVAAoFHx3XjadHEPcJOy7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695959; c=relaxed/simple;
	bh=47pj++R0fp5Qst7N7uqrZ6Hm1SS9JWbwV7F5UJfFsgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5g4k25MIamEk/pBbinPZfVCAeUhiqe2EXKlisWFgwNKltKjxUPxhxpdiiI+pSc6LzcHp4kv7wTjvXwBAgh/7pqlAYFDZbszEeI1eZFREx7ijV5RzkaDiFBRfLQZPcBMQJXwNMeWzmer37ew9xIrs7/qIhyafvTbB531PL7sqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9TiqeGB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so47859165e9.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755695956; x=1756300756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WcZU4w1VVhh4nhNd5YoneFxOEftwNElTq4wn9P5syE=;
        b=E9TiqeGBBkg6gnfJcqZ3AaeZX1Eiykvu+zYgtxPxZo71KID2982yOxDrMvW5NHq4Bh
         /j1rJKnYlLjowmuawbebZ+QFxY6pSeWvlWq1jTKtOJJb5vcvtnmvli1/8ko9RYDgLkCK
         i6Ia8Xh2mJkGIqtcGtfrO2DDO/KNwVEVZdxqiCWQmWI2/oQbgMuvOAM8cYtsEx3PMbRH
         8Oy6rzie40y3K5hcUmCsBwTo9CGkNnPxndfB5/EGLRxLHSGjcP+JJFO9i3cOK8cC9Uln
         62EPW6xkL3Mcs4P81skbWm87PPHcPWc7tz0hlksvtBnuBaOnetN0ZSEZ/W8xTNJ9ZR1O
         RUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695956; x=1756300756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WcZU4w1VVhh4nhNd5YoneFxOEftwNElTq4wn9P5syE=;
        b=LYcXToYWUpTvm+Gu5na9zQhSg6o07Cv9sqOnH+HluVweJAgbIw3KYDiGKdSXbqB6fI
         zwcX/0PpfTut1LeViNjRWZx3qozm1Ms52F1UUt+tmiV1TgivLh9UrrkWOm7KwOAboUUO
         aoubkZ3fKhvGoGFETC041snDYfMq/NzY89948Umng0/pvWdr5KG+rebLk5creIddwjRM
         mqrYLvoHWmI6Bb9kui8fpkFMbG079F1bLekzJUwgwl4HKRQlkkvZ8pXArWSFC8rFqjB3
         QleKhTjLV6WYTYrygZCl+Bh/jAInZ9Sy55Bc72atQJwFbjmDNIPwzWWZRqxSebV05hmR
         YSlw==
X-Gm-Message-State: AOJu0YwPhXs5UM4VS1z9+2fxGKeMUHWpgus8MycKioLICSkEmhG1+jDi
	m9WmQ03M23HqkU9UoMgMvU2/ZmG80LtLMxK99egJxxSYs6H3lJzsMC3ACdbnqEXF/ZU=
X-Gm-Gg: ASbGncuQDQe9v3zBPeou1SBRh6Vp8u4HRWSwfmJVIiJf0v8idoXWrV5hrrJjps32kqu
	EXAc5vBiB4+EKgdYPrRa4h/c0b/oyAv8JIlxd959pFt/L4EjGPxmSuViLZukLZ1drArn5ijctye
	64hk3S2vIJ2NaU/buTVUPmlvM//MSZK0WYXjZ4fOiELAzlQGXL+abreBIPWUE7iz2BVsfVGZ2qE
	XHJQm/CrvDFwriXOervQp7SuPtn+4iFxq+QmGPkBqObZUnZO05ZaBvpY9YeCyCKNzMyA2RrvLsZ
	vLznsnFiN1z/1uvRjvKI1W1Frdr6SiNJ7AA3vASen/wXen08cqOmXGxADWTGlOXyuZNfn+gw9CE
	fFefw+WWc5vb/0urHD309dhD/9FSiDSUTBXBN6kTowMX3zT7ADfOgUwMZAYH/TtZTkhdyixUNEr
	sXcFy0a5QHlRob+c3Mamqw
X-Google-Smtp-Source: AGHT+IHE7MUnNRe8FLXBM0NfSBPyMaZShoyuDCt/dXriroPX2EJqzoBTfhBRj4EBTwpy6TM+LQPA7A==
X-Received: by 2002:a05:600c:4707:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-45b479ebf46mr23462385e9.18.1755695956148;
        Wed, 20 Aug 2025 06:19:16 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008d321cde1f4699b8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8d32:1cde:1f46:99b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b43d31b95sm37372175e9.2.2025.08.20.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:19:15 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:19:13 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Tests for
 is_scalar_branch_taken tnum logic
Message-ID: <550004f935e2553bdb2fb1f09cbde7d0452112d0.1755694148.git.paul.chaignon@gmail.com>
References: <be3ee70b6e489c49881cb1646114b1d861b5c334.1755694147.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3ee70b6e489c49881cb1646114b1d861b5c334.1755694147.git.paul.chaignon@gmail.com>

This patch adds tests for the new jeq and jne logic in
is_scalar_branch_taken. The following shows the first test failing
before the previous patch is applied. Once the previous patch is
applied, the verifier can use the tnum values to deduce that instruction
7 is dead code.

  0: call bpf_get_prandom_u32#7  ; R0_w=scalar()
  1: w0 = w0                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  2: r0 >>= 30                   ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3))
  3: r0 <<= 30                   ; R0_w=scalar(smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000))
  4: r1 = r0                     ; R0_w=scalar(id=1,smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000)) R1_w=scalar(id=1,smin=0,smax=umax=umax32=0xc0000000,smax32=0x40000000,var_off=(0x0; 0xc0000000))
  5: r1 += 1024                  ; R1_w=scalar(smin=umin=umin32=1024,smax=umax=umax32=0xc0000400,smin32=0x80000400,smax32=0x40000400,var_off=(0x400; 0xc0000000))
  6: if r1 != r0 goto pc+1       ; R0_w=scalar(id=1,smin=umin=umin32=1024,smax=umax=umax32=0xc0000000,smin32=0x80000400,smax32=0x40000000,var_off=(0x400; 0xc0000000)) R1_w=scalar(smin=umin=umin32=1024,smax=umax=umax32=0xc0000000,smin32=0x80000400,smax32=0x40000400,var_off=(0x400; 0xc0000000))
  7: r10 = 0
  frame pointer is read only

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Rebased.

 .../selftests/bpf/progs/verifier_bounds.c     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 87a2c60d86e6..fbccc20555f4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1668,4 +1668,45 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead jne branch due to disagreeing tnums")
+__success __log_level(2)
+__naked void jne_disagreeing_tnums(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w0 = w0;			\
+	r0 >>= 30;			\
+	r0 <<= 30;			\
+	r1 = r0;			\
+	r1 += 1024;			\
+	if r1 != r0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("dead jeq branch due to disagreeing tnums")
+__success __log_level(2)
+__naked void jeq_disagreeing_tnums(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w0 = w0;			\
+	r0 >>= 30;			\
+	r0 <<= 30;			\
+	r1 = r0;			\
+	r1 += 1024;			\
+	if r1 == r0 goto +1;		\
+	exit;				\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


