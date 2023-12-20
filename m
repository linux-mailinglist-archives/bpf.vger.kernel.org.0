Return-Path: <bpf+bounces-18410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536981A6AF
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8832D1C24C80
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7F482E5;
	Wed, 20 Dec 2023 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPSXemS+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BF482D6
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-553a65b6ad4so2790830a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095703; x=1703700503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X9XhtzyKSudOJsIjdbC4SXtbIF4n6QZd+9QeYoIMJs=;
        b=KPSXemS+/nAWwH3Bbc0gd4BuMsjr/m9gZQkPbY6vNN3w06+u+OJ4YMAt3jpRZ7Dkad
         TUgDZRULLoe/+R78WJxK8yvNagd+ENz6vIpd0NljhJifMNclQRmwDjy307Qjp9X0ikIb
         TweQFT335kpXdFbmxJLxxXDq5hjOi4FzpySkrHzL3e7qT1N539EuIObkNMC126IUKwSg
         v5I2njHpN5HdRBkmWtTxBq24m0eWipybR25KXFRyENg73LY6Yuo4R8rHCVBIFa6yet79
         FHFT4liJPLRuLFvakGz3m5IQD3y+dFbDc2OdvGfebgJO7fk5cTekSFwudnphz65Aguu6
         GgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095703; x=1703700503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X9XhtzyKSudOJsIjdbC4SXtbIF4n6QZd+9QeYoIMJs=;
        b=lxfgJ1qzL4qa04fsoXtYy5r/7+2KUE6yO9GTcUp1LtvYxAksCW0FiXDlg8GEFWeMzJ
         a/DGmGST7Y4iXervwfd8adOdxev767OVlSkGwtTNlkw5XD0MF8+YnP//02qrFCaeMnlD
         YjtP68x+5FvUY7UKdKP81y9zBcx45EwDODiOghIhzTpcIR2/f7BCvF5GW/FrL2R5ppV6
         9v95ENw3xRNMpTltLmc9a5ABun5EF1YJGymVffYFnzCljLi1l61dH0UoiG85ItkiHJGD
         nqyZF6zbzK84Ap1717FhdI3HR7QKbemmTuhMJsKlwZC8HfxtSdL3ug936L1M0DSdy45M
         GJgA==
X-Gm-Message-State: AOJu0YxbXBXcJYCC5uTfarYMkMJ0vAt0i7aMdU0Pksl4NSLIEDEVR8LD
	mfRlW2TIPPVV4rauxtaRkTU1qgEoqVXHOg==
X-Google-Smtp-Source: AGHT+IFQkA5ynp0DPKXorb6DgkAHMrRilDwLGhwJ92Yx0K2rWkbp9CH8EctrL8WVJPIgobgJVN72JQ==
X-Received: by 2002:a50:8759:0:b0:553:3537:ffb6 with SMTP id 25-20020a508759000000b005533537ffb6mr1463154edv.75.1703095702681;
        Wed, 20 Dec 2023 10:08:22 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm83786edr.43.2023.12.20.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:08:22 -0800 (PST)
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
Subject: [PATCH bpf-next v10 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Wed, 20 Dec 2023 19:04:18 +0100
Message-ID: <20231220180422.8375-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220180422.8375-1-9erthalion6@gmail.com>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
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


