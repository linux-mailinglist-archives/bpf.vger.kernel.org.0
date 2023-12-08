Return-Path: <bpf+bounces-17226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897280AC92
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50933281A1D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0834A98C;
	Fri,  8 Dec 2023 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Pken3q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFD10C4
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 11:00:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso294515466b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702062001; x=1702666801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIOrIL9rWr2VFead8lajeIOWrTYK01JoRdEl1PChsiY=;
        b=a+Pken3qnVGUJPQtIhb+cRPxBj+zDSXUPygfmnRutYNRjtA3+iA3RiwTHgYN95ihxP
         avPUGhWReFqiY1fR0oy+iIKMjAC1vQ8wA1LeL5+vZgNEhdgN3675IPh9xwrdBlLCtAx1
         4EzevpwtnF9/IkH4xwjqEfdJWfWPooXiw7lH8MoCVFDHWt7XUgg0YRAkFHY1HqxaT1YK
         FfBmswAafj3+dfRZEwmykHde1JtOrcwx+H3Qwx3MfCH3UMY7OCug7EEWiBAGkkoNljfD
         kx+VKoFH53xvoMxqYFcZ93QVfFQiaLNCCQHTrVvPfjEYyiTYo0ldnchKkSRHzSMcFcYO
         rVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062001; x=1702666801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIOrIL9rWr2VFead8lajeIOWrTYK01JoRdEl1PChsiY=;
        b=YZgVAsaFHSynSjaeq2dxIlQ7Xz8jXtFAdE7WS7xZa//YCU6ciCtWYojlJiLCK/2zFC
         1Lq15U5W5g8aHew99P0uWnJAuaZ4/F/CvD6nqbjvVIVsawhooLfQ4djXE4QKM2Mkwzpa
         WxZLMAsUdsUgcABikqyUmD9R86QHBfqGk3J0YTM89Mc9VTb7o5MDQMlEbamyNzsuISJJ
         0YhBDyRO3i2ES9iLCyHPuUsmiLRNENAcPEfTZyfN3pgcv0bs7PG73U9j//F4UxFRTKF6
         M7GVO8nnNQq3Jaae+8IuMJKFAJYQYIaqUetC/q/G4wKfTc9Yw/Xj6j1HvlOeCdkhqtc0
         88Xw==
X-Gm-Message-State: AOJu0YzhXPxVtwAyRBc0EtiwbPKBFJF+p91ZQEebfftHlAM+3r3CADOl
	gqfk5kSXWYVYaICW6W1l9BpFSOrIq+0EMA==
X-Google-Smtp-Source: AGHT+IGZxBQYS7sUsT9aR0aLUjISj9UF2Ol8DhgKEiL62ht3IvNqdPJszEmwTWQWYk6OXwF0x9w7Sg==
X-Received: by 2002:a17:906:7c44:b0:a19:a19b:78cc with SMTP id g4-20020a1709067c4400b00a19a19b78ccmr191893ejp.143.1702062001013;
        Fri, 08 Dec 2023 11:00:01 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id le9-20020a170907170900b00a1e2aa3d090sm1295702ejc.206.2023.12.08.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:00:00 -0800 (PST)
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
Subject: [PATCH bpf-next v7 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Fri,  8 Dec 2023 19:55:55 +0100
Message-ID: <20231208185557.8477-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208185557.8477-1-9erthalion6@gmail.com>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
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
index d5470a5c8c6d..2b111fa7637d 100644
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


