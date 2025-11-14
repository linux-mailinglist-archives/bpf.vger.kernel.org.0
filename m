Return-Path: <bpf+bounces-74453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24EFC5B113
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 04:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B224B3AF7C8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3732580D7;
	Fri, 14 Nov 2025 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2gkRzhr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1982571B8
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089846; cv=none; b=f+ZQ+1UwAd0IsYvxfgMnSD92S2k8A0eSEAY+NF5kgIteidwWVQUeUVfAwsfdNrKqPohTxpx035mdircFTQYNcifbld+SSvyftq97bm6EQRT5YnAL0z/RXZlP8KAqgv5bXzy/N+S0WOGdg82GsbuFY9UdeiO3tXGgFuuEIpYfVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089846; c=relaxed/simple;
	bh=zwaKRrTyVktSW0pkhcr4zLK6+WimidyjeiTbA02zmpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvuFVsRiBKXHZrrWu10B/3MXyIxJQLB43+YhSL21r0cEgADPMcdjUUFzzQoMNIwPl8A+OyVivirCoCNlEaI7SbmOwa7a5+22kvqgokHfNO8TY24MFfNNrj89hu8heYiJsLZIqcx4dJw+r4jMIM4a7XB48ct8WzX/991VbrDBi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2gkRzhr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso1910851b3a.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 19:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763089844; x=1763694644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRIcmUUYoVAKKTSpsJuU8juvDXCguqp/HSALRy4qhPM=;
        b=D2gkRzhrY5BFMO19UjIN7G2KB7ELs5MUBMmUPGtn5IKDPPLiGzuz7k0Zam75Uf098r
         JKLFH4emN10N4PkwfdDoVjDAMpv0BGQIHYDFPUq6zl19d3MlF+FSQrwRAYD/mpThuo9l
         ltfWL8t4y8dZd/b+PGRhpcIRLaBwKdZo6oUeRuF/sNhHZdtDS7meC/Cf8n6GwftOFjoL
         UrjEzAa6ZxRbYwCToq4d4qdnRj7yBb+U0Gt4k2hgotK9KXxPAlXHYicx/D5NOQ6sX+YJ
         Tg0DhI7kFWBEGwhbz9DlcikEK4AiTMgmFGgfb4dygEi1blhhy2acmNk7Tyn4HlM6XvpY
         pRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089844; x=1763694644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRIcmUUYoVAKKTSpsJuU8juvDXCguqp/HSALRy4qhPM=;
        b=h5gFniLkbm8u+09m3A7fnLDHOsTEOFCM37qF8fSPQtM3pDhY8JnDPmvV4lCxd9un6b
         iHpDwhPLmMAAwRi+VthTejiiLNynx/NMUqkb01D1S8beok09Qh7AWCcH+IarxYbkoyIv
         AMk0+6XUHLEK3q2sbZPNejJdp195BTHk+e3IQgau2kttGH0p549zrsqfiwvossrSO6GD
         ShU86jU6cII93eN6SB7v6Qkv0Oj7nbPYli9X7kT4HAdKeefB4QFtsVwm8tPkb88OIaaz
         SMuCEsUP1zrO1hGJENLG65zc6GF1PK0XLFXZgHUm7ORgxA2PiO+kUtO9yUlCnsQnEwCe
         KvcQ==
X-Gm-Message-State: AOJu0YzOJCuyYMIDFFhfBo50gwvYE5QVtwSp2sU/CwvmKip1Rx4KdotS
	dV0K1+8Z41sxd0u8Zj9PWrA4tUpTA4vLVREI9i2ZNUo2+PquAUo8Xr8+AEC2GQ==
X-Gm-Gg: ASbGncvegffoF7X6c6w2nUWMUzI4cf/UPbCGS5shlSRhZpRJJOkBlYpoYpEexYW9xli
	ffaKvsOuLHsvt+E9gCELVy1LcD9IUORcPClmJt0/wZy5N7Io4nxWSTgY9x8ozkFvuen4bfH6IIZ
	8c/tHQJDxUSk4qKgsQb4E/1cu1vgecY7dhUEl1QHZTTqQHx4hJwcSURtRFrfLW6Z01EDdqMrOAJ
	8kX7K+6pbtGYtXJwtITNVraNr2refu20+NSY2y2vugCprpop1gbcYxPVafRJ2qj15IbHRdqBfib
	g8FRZpVMRXQHjb2INnoY5BaAZnI94mTml+niz4wHGbV93++JiADQHVPDaLCNB6uf6fl0PPuXJ2/
	U71Ybh7kJWgynk8xuVh84ac0aah9vso64vLH0z3A1TQddbP01luI3ZDqNhqKkiwpwJBo0cwx7Rr
	gXZGzRLnCUvvb4zliqpn4RcaxwqEHUFqF46wmuAoy8hFcPjoKTSThT9PM=
X-Google-Smtp-Source: AGHT+IG+dYni6egPQ1gYuFZis3kS6tCVHbuTbH5dVoPziRySe9gj8QOzWi97JH9btRoV6XVpWA3jJg==
X-Received: by 2002:a05:6a00:4fcf:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7ba3b89ed15mr2382185b3a.24.1763089844128;
        Thu, 13 Nov 2025 19:10:44 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b921cb6f44sm3686048b3a.0.2025.11.13.19.10.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 19:10:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sunhao.th@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
Date: Thu, 13 Nov 2025 19:10:39 -0800
Message-ID: <20251114031039.63852-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for special arithmetic shift right.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..b18b75c532bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -670,4 +670,45 @@ __naked void ldx_w_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("s>>=31")
+__success __success_unpriv __retval(0)
+__naked void arsh_31(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 s>>= 31;					\
+	w2 &= -134;					\
+	if w2 s> -1 goto +2;				\
+	if w2 != 0xffffff78 goto +1;			\
+	w0 /= 0;					\
+	w0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("s>>=63")
+__success __success_unpriv __retval(0)
+__naked void arsh_63(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 <<= 32;					\
+	r2 s>>= 63;					\
+	r2 &= -134;					\
+	if r2 s> -1 goto +2;				\
+	if r2 != 0xffffff78 goto +1;			\
+	r0 /= 0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


