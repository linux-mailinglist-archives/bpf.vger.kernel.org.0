Return-Path: <bpf+bounces-18619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A8581CC03
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB980B22182
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC4928DB9;
	Fri, 22 Dec 2023 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMHb21Of"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7428DAE
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a233bf14cafso244742066b.2
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257928; x=1703862728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SesBmbcj4xK1eFdkEVl6hQ5kghkvNy+eA0d83HDbuJM=;
        b=JMHb21OfUFsFlg+xcQhkZJRYFxRWvcn0lYnqpy1ODVRqlt+GyQzaHFcxUbd4KXoQlA
         Qr54fX559gip1iSknMVfOHdNZZNDYCm87gYqjpGttZqVWmovqJ4B/TBGRqDTc/0uCHQp
         2GN41jTK6KPpy7DeKJyzbUDXn/ZP40rm9FDNVR1zCesDuu5O6MmynHxkgFufJsHqW6mN
         4t35rycZUeBTWIBAGNlSjl6L/DZZgJzqkUm/Eq+unaIrMiWEqovt23KKfcG/lTkrZUah
         hOu5kSlKm76oB6Fkd8soWNnUf5ZCCvN9fgAv1JNIh4A3e1Q6cAAUKzGmu9E85T40Gt5o
         1nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257928; x=1703862728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SesBmbcj4xK1eFdkEVl6hQ5kghkvNy+eA0d83HDbuJM=;
        b=QXPl2Nr/03UsWywTEdLxxGPZPjzlVwK9saHL4oN96EzI6ly84x1LHapj+FO3tvNImy
         /zzOl7R2sg/L5rQtqvH9mbaIUKuA9dtM3IC4JCjvTlywoQkJkQfCGCPTJPjCoQsF79kA
         jkGj6gFD3C6s/VhKQY2LjkDQhSNmifCfnnn1PByWKyezRLsaE5JJlWi2VOog3TjdO7pz
         mLIYXWf6Z2U/uZkLRcuEUz/zCsEHGqBta+6TRjoz9vs9rA5ThWsYCS+Auby8KE0KJNf6
         FHujiXExW/4dg1nVk48qgvD+i+uEjBdAOZp9/AtxL/KrQ1+pfMgx8nXva3AkaB2ZEjz9
         RMBQ==
X-Gm-Message-State: AOJu0YwtUKVyj98AIqUwsp3M+lioloSezrT85giLjZmo+9Q9K5Z7kyru
	6P41g7yjlv6w7J90mNP9IwF0+6grtA+N4Q==
X-Google-Smtp-Source: AGHT+IF2zqhOONmJvrXTFkDTsuhhqBOuxntHzGznr0j8i2CX2HlZNnb5zKwCLBOdiYXmEUN14zlbzg==
X-Received: by 2002:a17:906:fac1:b0:a23:6050:eec5 with SMTP id lu1-20020a170906fac100b00a236050eec5mr894707ejb.136.1703257927486;
        Fri, 22 Dec 2023 07:12:07 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a236f815a1fsm2111162ejb.200.2023.12.22.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:07 -0800 (PST)
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
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v11 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Fri, 22 Dec 2023 16:11:49 +0100
Message-ID: <20231222151153.31291-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222151153.31291-1-9erthalion6@gmail.com>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
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
Acked-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 kernel/bpf/syscall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c40cad8886e9..5096ddfbe426 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3201,6 +3201,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
@@ -3214,6 +3218,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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


