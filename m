Return-Path: <bpf+bounces-17581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421680F752
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56EA1C20DAD
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822EE52771;
	Tue, 12 Dec 2023 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z15ui5rJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E1C8E
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so7879728e87.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702411093; x=1703015893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1klgP+18nY+AER+DBb3BxvAjBOjuo5C6vf8ZendDUY=;
        b=Z15ui5rJglnyyhUxHQ1d9f2JjoMrwaROlRTx+5leap9pHXKbFTEp1tL/pkAseFx+/5
         lFR12Z53UUtlFaBGPnPrMPqgHKGieRX0XtWAIiGRfaqQ3dVYvtoDCQyyz0kto7LlRdO/
         m5LRDvk+1UFwrWve9icKagzszPyUzm8zGpX9Ua1VpOLnI076YBSeoT1OugKkdQQmjw+H
         UQOV9KluUkkDYOUHKD10TmLHRqIALTdMlfZKwBWIajhPJRbwEU7RfZVhgl8bH88DEUXU
         O0L5iczcDdSKL9oF+F7ceMiHellw+76+2XMUvLcuPdKm/E5QHxBhV4YoOr8UGlx9VpwR
         0Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411093; x=1703015893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1klgP+18nY+AER+DBb3BxvAjBOjuo5C6vf8ZendDUY=;
        b=Rrw59SnuhBzmY7B3cSqXZiy/znp2ULhnJQLbEBI1CIhdPBJpFovb6PQl2oDUkhM4m3
         gJ0yGeJqO04yo7yzhkV/krR4IkQ6D0O7ruV80jl/DnWyAEvjMuJ5aadnuKQeXJIABfH9
         uCCC9aitUDm040wcKMiMN/SUcRGOLPS+3hZj3qAry/TVUbuqJj3rAUljPNCDZ4zNWpN+
         HwCrMwjKWHNQ+PZe6So09bnMgffG6+GvTUlkDyZPd2+VBLyFNZXrXiot8Fq+KoUS2E6M
         kD3tBHD5yAwdWz8ENM94Jmbzo1InCEScKBKtx4UPYdsEo0f3ulMDFqI3xkneknO0Jcnk
         6ROQ==
X-Gm-Message-State: AOJu0Yx0CvkpsNx3Pjr1OfRGtV0XFPx1RBNc4mcS5nHIvlUF5iLB2buf
	MtKCha/NX0nIa4xVh9LxinaxNTH58aoSmw==
X-Google-Smtp-Source: AGHT+IGC9ST1FIrfraR3IO6FZbsXnEceOabmusIrZlLpyHk2nM307iY6GZ12tD62ExpD7n0gt04gcQ==
X-Received: by 2002:ac2:4c4a:0:b0:50b:ef70:8d66 with SMTP id o10-20020ac24c4a000000b0050bef708d66mr4577186lfk.26.1702411092569;
        Tue, 12 Dec 2023 11:58:12 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:608d:69b3:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm6677386ejc.73.2023.12.12.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:12 -0800 (PST)
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
Subject: [PATCH bpf-next v8 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Tue, 12 Dec 2023 20:54:08 +0100
Message-ID: <20231212195413.23942-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212195413.23942-1-9erthalion6@gmail.com>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
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
index af51e97c2c28..2eb5c032d2a9 100644
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


