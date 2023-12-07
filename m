Return-Path: <bpf+bounces-16986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542C807F71
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 05:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD241F212F3
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6F5685;
	Thu,  7 Dec 2023 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnypx7Hr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A9D73
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 20:12:17 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3644ca426so2462467b3.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701922335; x=1702527135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZVIPLfCvSCDiu0dICZQDlpADC4uzsTyBFadpnSqTwA=;
        b=Pnypx7Hri02a4JysVga44JLmb0+CNoTqM9ShhFdS8hNy3SbtOibQTogIGgMzaFRm2I
         iWa/8xQftdLZ5bGPvKsbiEozb+0/JmQ/hx2s72VXdfmGwSTwsfgaHGw/FRx4J3s6TkNn
         0LgZBYcWt7aWIB2q1vH6UXIplWc/Vgkdtogm3jrCBBOvoVZeTYBrjic2LgHSu3SwstqR
         +rZasw1IzaYblMQsxGPRPUeEoV/ghoY8rB9jBu6oCc1R4gIU79oPUTWbniEJuA+TqLTb
         W1IbKjRyNwGey6um5dhI1059nQQAfSQK0ejDsGMU95VLrRZczyXR/6l8W5S4ML6xqItU
         rmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922335; x=1702527135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZVIPLfCvSCDiu0dICZQDlpADC4uzsTyBFadpnSqTwA=;
        b=UTL6v4nGoQJTjEv7+DGGVJBJ0Wbnckq9RaRf06tH43NuUAGYA7J+l4t/gXoPpvFRp7
         z+z0Q8JTMALOfQ24z1Yl+mkJ6iMsQqbUj4rm9B2dBZjsM5MQqXv1nEOZbp0BN/37O2yP
         JPKN1jW2epdtWjW9/HQ0r1sY2b7WE6wUhcybOI45YhAJ2Muf0Our1LX54t5ueK/dwF/M
         38gDPL5KtuY34jWaP8iYvZLAcobN4Um1ZgLJqPvuQ03/DM90kHnIRdZXD/yo+5J8GGxx
         J2mL0HqnlVACLhBaGFjvqcqKvkdzWDJ441tqSTBsVLKFNT+GUSr3zWuPzp2/xRyvwdm2
         dGCA==
X-Gm-Message-State: AOJu0YxIQUGi1YSFPZvFvm0vlWFe8iFOP9RHL98FntDZ3Ct5DDfPwGF1
	+hnMu0cPAEejQl0Jw7AxjNAh3A92nVRbLQ==
X-Google-Smtp-Source: AGHT+IHXtdXdFYbMFeEKI8PVSssNtX2wDSrXHajQQ6upbi2X0ByU8vqyiOPkvW/kP/qfvEV+pHbC0A==
X-Received: by 2002:a81:b71f:0:b0:5d8:17bf:c50f with SMTP id v31-20020a81b71f000000b005d817bfc50fmr1826619ywh.5.1701922335273;
        Wed, 06 Dec 2023 20:12:15 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:225d:9ebb:8c9b:7326])
        by smtp.gmail.com with ESMTPSA id o6-20020a056214108600b0066cf4fa7b47sm172808qvr.4.2023.12.06.20.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:12:14 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v5 2/3] bpf: add verifier regression test for previous patch
Date: Wed,  6 Dec 2023 23:11:49 -0500
Message-Id: <20231207041150.229139-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207041150.229139-1-andreimatei1@gmail.com>
References: <20231207041150.229139-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for var-off zero-sized reads.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_var_off.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 83a90afba785..b7bdd7db3a35 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -224,6 +224,35 @@ __naked void access_max_out_of_bound(void)
 	: __clobber_all);
 }
 
+/* Similar to the test above, but this time check the special case of a
+ * zero-sized stack access. We used to have a bug causing crashes for zero-sized
+ * out-of-bounds accesses.
+ */
+SEC("socket")
+__description("indirect variable-offset stack access, zero-sized, max out of bound")
+__failure __msg("invalid variable-offset indirect access to stack R1")
+__naked void zero_sized_access_max_out_of_bound(void)
+{
+	asm volatile ("                      \
+	r0 = 0;                              \
+	/* Fill some stack */                \
+	*(u64*)(r10 - 16) = r0;              \
+	*(u64*)(r10 - 8) = r0;               \
+	/* Get an unknown value */           \
+	r1 = *(u32*)(r1 + 0);                \
+	r1 &= 63;                            \
+	r1 += -16;                           \
+	/* r1 is now anywhere in [-16,48) */ \
+	r1 += r10;                           \
+	r2 = 0;                              \
+	r3 = 0;                              \
+	call %[bpf_probe_read_kernel];       \
+	exit;                                \
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
 SEC("lwt_in")
 __description("indirect variable-offset stack access, min out of bound")
 __failure __msg("invalid variable-offset indirect access to stack R2")
-- 
2.40.1


