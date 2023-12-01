Return-Path: <bpf+bounces-16399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB82800ED4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F11DB21289
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370AD4BA90;
	Fri,  1 Dec 2023 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmBlsV9N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D9194
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 07:51:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a18c001f305so269017266b.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445882; x=1702050682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEQ0gUKcwTIoDziAcQRsW23OYUXikRKjSamoddaYGx8=;
        b=CmBlsV9NpPaLo4VUYaAKnOSTW/994WQZBqrJ7fjcNzHBhrxoL0CSpfAZtIT63m7OW8
         CYgdUNTqfVwR1bpNrmj+XdBxvNEQ/uX0lOI8bTmGdF/2G1cJGBCKPqwpOD3qBMHRgDix
         7rnAQwdgAz4RDztwUIn6jgVgVWoJNTW9KGV3XabkhDDRjcn9eX6AwLgLmmrACyHSnC9j
         uwXfohRu3KoFZwouIc0xSXtK0VJXvvVpGVjFYS8VhMCgJx14nqRpR4WFwm7PM3zAwuNR
         j2tMqDYoqNnsg/A3/7OiCvrfIaImi7T9iMDJ1OGy8NnRE0+aMugGhtuaR2Qa5noLZuWg
         HnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445882; x=1702050682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEQ0gUKcwTIoDziAcQRsW23OYUXikRKjSamoddaYGx8=;
        b=ZZYCkMjVIzgVl49UVKR4ueuHR/vwae2dpR7QI6887VXtPLOm0V1Ou7tqBVdp+3jbw5
         i+zCjFiIlz9FvkWt6Qx6vg1WC36JdDi/A91eWlCZOEhAH/Z/pwudC/aA+2lIPEyomVVq
         oLVT9Oi8CrxJFDYoyjUEdtibLfoFQzXxkc6Dr2hr+EYC5yE61O/EnZKo0AJCvVhlTbnp
         bE5b7jICatKO6n1GSeeGli+Toi2Wz8wKxM/j5d2RM6KCMNlh15mIKhtcok24t+ZCndDX
         rSmIwr7lR0qRbTMGwT1sIGcDEO/orpDjYq2fAR/u9rmFOedg/TNq/XqJKsxe3MTxURni
         Daiw==
X-Gm-Message-State: AOJu0YwV2li21AtvSYr1iiKUWfrN1649ex+bnkhin+KdrQdJvtuk3YCA
	mjJEbiTXn2NwqWDu02nqfe9KfRV7PS24wg==
X-Google-Smtp-Source: AGHT+IHr8/JKGKaYZZL1+hgxGl6zAo4y9JcluO1Fm1MLxbBfGtQ5rskut7vBwaYyDNSFd3/DyLUhpg==
X-Received: by 2002:a17:907:924f:b0:a00:773c:3f09 with SMTP id kb15-20020a170907924f00b00a00773c3f09mr1507466ejb.17.1701445881874;
        Fri, 01 Dec 2023 07:51:21 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906159600b00a16c1716a20sm2033118ejd.115.2023.12.01.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:51:21 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v5 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Fri,  1 Dec 2023 16:47:32 +0100
Message-ID: <20231201154734.8545-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201154734.8545-1-9erthalion6@gmail.com>
References: <20231201154734.8545-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

The following case can cause a crash due to missing attach_btf:

1) load rawtp program
2) load fentry program with rawtp as target_fd
3) create tracing link for fentry program with target_fd = 0
4) repeat 3

In the end we have:

- prog->aux->dst_trampoline == NULL
- tgt_prog == NULL (because we did not provide target_fd to link_create)
- prog->aux->attach_btf == NULL (the program was loaded with attach_prog_fd=X)
- the program was loaded for tgt_prog but we have no way to find out which one

    BUG: kernel NULL pointer dereference, address: 0000000000000058
    Call Trace:
     <TASK>
     ? __die+0x20/0x70
     ? page_fault_oops+0x15b/0x430
     ? fixup_exception+0x22/0x330
     ? exc_page_fault+0x6f/0x170
     ? asm_exc_page_fault+0x22/0x30
     ? bpf_tracing_prog_attach+0x279/0x560
     ? btf_obj_id+0x5/0x10
     bpf_tracing_prog_attach+0x439/0x560
     __sys_bpf+0x1cf4/0x2de0
     __x64_sys_bpf+0x1c/0x30
     do_syscall_64+0x41/0xf0
     entry_SYSCALL_64_after_hwframe+0x6e/0x76

Return -EINVAL in this situation.

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 kernel/bpf/syscall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2b56952acf1d..be010f1d0d62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3181,6 +3181,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 *
 	 * - if prog->aux->dst_trampoline and tgt_prog is NULL, the program
 	 *   was detached and is going for re-attachment.
+	 *
+	 * - if prog->aux->dst_trampoline is NULL and tgt_prog and prog->aux->attach_btf
+	 *   are NULL, then program was already attached and user did not provide
+	 *   tgt_prog_fd so we have no way to find out or create trampoline
 	 */
 	if (!prog->aux->dst_trampoline && !tgt_prog) {
 		/*
@@ -3194,6 +3198,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			err = -EINVAL;
 			goto out_unlock;
 		}
+		/* We can allow re-attach only if we have valid attach_btf. */
+		if (!prog->aux->attach_btf) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
 		btf_id = prog->aux->attach_btf_id;
 		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
 	}
-- 
2.41.0


