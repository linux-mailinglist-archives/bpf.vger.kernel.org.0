Return-Path: <bpf+bounces-18037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AC8150E7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030381F20582
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053645C09;
	Fri, 15 Dec 2023 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnUzSNSM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EA45BE1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33621d443a7so991893f8f.3
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671069; x=1703275869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9ZltJNSOg//D5wWVxy3VWiuM60QvoxxNdL/OCIqEqg=;
        b=LnUzSNSM3ErSBZx6Vq8xq8x+wtRky2D10ERGbcrjMZEbTRmME/6g72O5AwINIw7Cuk
         FBZTxybAk/fx1cYKAomT5i6Az92pjaGWGcLnkDb1RChh9TgVCj7EJSnwolCueBttS0dM
         0V4A3qScEA+OChYkGcH0SnxY2Mz56itcNRmWiuAAp2TUHmGpEfWZpJq0PqSOMZ87UR+o
         OjdWDkZJYNpRWKUB2z1HdtxBR/AQDw1tq1FZTRMmuIMc9KmqNL3Cwtxk+Jl+QU4DV0gC
         b+AFWjaaSIyVHOnijrb4yKn+uI18Yqq3NDbnhu7JtrbAtN9njxuhjHzH18w/rKsM6Bht
         5wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671069; x=1703275869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ZltJNSOg//D5wWVxy3VWiuM60QvoxxNdL/OCIqEqg=;
        b=klxLKsTYiAdpywQrfMCABQITxNs0NQtdC9L+K42YTDFyPGucQDWuwL+HYBneAP/b7y
         7qaPnlS1MY7c0BNBbfR/9tIrGPnxID6SXCOMSHpew5+hHZEfgOVrXXN0tJxv0gj+Ztm0
         EsmyNdYR6H1d1ZqxLUtA5tmnF8TKwpjawhBfFgRWGpJH9wrc99dzqYtrSgwZBVQqrb1S
         K0XH+fpdrpQiPepIClqteWT0bhGhOeVWp9QdS9Rw/rhbeESmnOTpFxXPvEniIRwIVVuc
         6KWd/uF9Md+KIy2bfh9Xe+jjvp8QLTKszNhl+r0e6j3IOwD5lyKgLYKxAR7bfe3/ai1D
         EU+g==
X-Gm-Message-State: AOJu0Yzrcb9GDbyhmn9Bb8yGfCh+Xcy8juQHaEUkbziFYVgcJa0up+NJ
	Vx24ZhQjg0uY/iSAwowaJLOPmpvV31BENA==
X-Google-Smtp-Source: AGHT+IEpdIphuH8jKOHQiZ09ltbslkO4TxVb0eZGEnnJJ4UP1tpC22nw8sWP+52zOlyn3uw6aKfSfg==
X-Received: by 2002:a05:600c:2259:b0:40c:1e66:4dca with SMTP id a25-20020a05600c225900b0040c1e664dcamr5890862wmm.175.1702671069111;
        Fri, 15 Dec 2023 12:11:09 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm11031490ejd.28.2023.12.15.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:11:08 -0800 (PST)
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
Subject: [PATCH bpf-next v9 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Fri, 15 Dec 2023 21:07:09 +0100
Message-ID: <20231215200712.17222-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215200712.17222-1-9erthalion6@gmail.com>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
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
index bcc5d5ab0870..e07c3c1086aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3182,6 +3182,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
@@ -3195,6 +3199,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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


