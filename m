Return-Path: <bpf+bounces-16517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C280801E35
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B51F211E0
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BC20B2E;
	Sat,  2 Dec 2023 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtpCkO7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF1124
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:19:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50be3611794so1142943e87.0
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701544789; x=1702149589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn9w9ZpUJ64xlUNS7Z31Bu8OL5DsLbGaFyGKEHTyr0I=;
        b=EtpCkO7YEdHnWwvdSVHgQxk1vzSoHfU/x7ETFY5ladJkVpn9ryTgoX61sPRpADuXwP
         ZoMUiZGaKWgj7XnxsokK9ORbA9TzxNcLUfGgJ0oyMb8vsLQK9gsPMFZ23I+vogLXcaGM
         m0lYOsd6apBY7shAbVgGft/NWzu065uvOs9rb9IjglHyVPmjsuVjdsjWzT4s78nTIiPP
         lPqU93htM+rCN08RzNWlPCnmpYndeAjYOCJ5qJAFhRWme9J78VOn8iyST491vScA7JJL
         T50tTDB9gpWtW5bM21g8bi2OfmC4+galEJvDOeUlCTUTOaSP+DCVN5uxRi6h2VhsV39W
         mCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701544789; x=1702149589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn9w9ZpUJ64xlUNS7Z31Bu8OL5DsLbGaFyGKEHTyr0I=;
        b=l7vSEjvJb3UshnsM0OKdivY55qcSgfomGUsT+MB7/7uwDokoqsrZied66lFZONrLUN
         qk0RE7Ebtw7pUQLHMu1/dyVTa3H+8P0x0/1QJjyR6u18Etf7x0cRNd+3dagsgkhy1r4h
         wwV9a+cDY3dl+sU8hzUVETQfQqb7zxkkArQFUnyTVcVau1y24BK+ljzV7ODdFwojfUrC
         WYv14uFmMmBz/yynAtWFA/3TVEOf1PubkMnvP1uY7nt3FayqZm6uvRa2NcIrfg5a5qvX
         ovLjxIy3qAYVec5uZTsMkYQ50ZtMsd1JgHZAOP8zvjUh5r2qWeFlZQpqfqQPDbYywzlO
         5CnQ==
X-Gm-Message-State: AOJu0Yy2/LLMUV3vStXFhABZ/X/h0bLsIN1a/i9GNL8o4QXl6Y8VLgLi
	sPGz3A/mtvHuSfcPl39mSBeR1qUzjKcNRA==
X-Google-Smtp-Source: AGHT+IEvFyFoeMm3QIxLp4RZ8dhaGrMmaJAyGfssI7SH1uO7sH/oMUWpZSOX0m7uqxJY8ml14WW/cA==
X-Received: by 2002:a19:7517:0:b0:50b:e764:d029 with SMTP id y23-20020a197517000000b0050be764d029mr457659lfe.107.1701544788384;
        Sat, 02 Dec 2023 11:19:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:6008:6fb9:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a18ed83ce42sm3127814eja.15.2023.12.02.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 11:19:48 -0800 (PST)
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
Subject: [PATCH bpf-next v6 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Sat,  2 Dec 2023 20:15:49 +0100
Message-ID: <20231202191556.30997-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231202191556.30997-1-9erthalion6@gmail.com>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
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
index 9c56b5970d7e..82bb1be4dca2 100644
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


