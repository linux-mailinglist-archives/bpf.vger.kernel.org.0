Return-Path: <bpf+bounces-18894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C4823554
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8AA281AF0
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F331CAB2;
	Wed,  3 Jan 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED4EYALO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470B1CA91;
	Wed,  3 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556eadd5904so364965a12.2;
        Wed, 03 Jan 2024 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308781; x=1704913581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MujXAg1oOYVyqkGSKRh6GK1WBnkxbMKscNlpJ+fe4U=;
        b=ED4EYALO4QrK8El/NuH/HkNZVmoG4Md5tZQsk2rzGMW4Klj9vMPtBY3Z26cxj583RS
         Gfv1JHdGKTqa7xXQjpgRLJe5joPzS4Td1Hhe/9sTIQjcF2p9ALTVqNiEGjPoAgR79gIe
         0oduIUa1GIJJXFC0I1b+WKqGIergkr91muIiDRhDE/H/XRnqI313MBoxhwU0rGoyniP5
         U0N6RCkzTRwjOEkqEpoZj0IE9ZVSdFmV8u3zlv3ytnPszwEbORFCBBeXzM1bjcF647m2
         NDl9Ij7q2a8plgcn1CbL/yxqFnDrQ4EhOwwq3ttL29P0b4RGPUF13w/0OzZmwdXleKeo
         wKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308781; x=1704913581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MujXAg1oOYVyqkGSKRh6GK1WBnkxbMKscNlpJ+fe4U=;
        b=kwmuRADJ4dqrsDl8+3jEhoJzkWovZtKwnW370MNMOMj6HoIccgYycR/hCuMvaqhgAy
         rpQvNePR2HkqXHjEQIN4IodQkFnEObmDKshhyI4p1ZoXBT1LUhjavxn9WmSAS4eGzTdf
         v4PT1yGVhEZHyg8QTM2caCMbJPuwQoTP6v8Basjzj6ejC8ooCBHyUF/8wtg3z4wdEXkI
         c0BsbgJEr7dYrX9Sf7WBUR/e0IFmmtOZYitEbex4emxxPeG2uhIrJJbjj7M1ErOwHNUI
         y62VRnej0nbHzi7crIQOjguqMTmSSIWSYKmU2CF7orw2eFsJXZXyfBzqnylqNpSZNVzI
         ODag==
X-Gm-Message-State: AOJu0YxKjyMwzDhMGKQ3tbqNgIrA65iEQBZldetpuMNqghoELwdvWM4L
	1EuotCCj4RBFz+Gk9tHA8s5oKr1n1m4VGA==
X-Google-Smtp-Source: AGHT+IGhjUZ4Kpie8BQGy1ajv8Pb3MNibWT7BUClt1JEtdUba/J0BCmZKPgq7D9R2IbEJKSHIcgCAA==
X-Received: by 2002:a17:906:bc4a:b0:a28:addc:5f7d with SMTP id s10-20020a170906bc4a00b00a28addc5f7dmr231398ejv.121.1704308781047;
        Wed, 03 Jan 2024 11:06:21 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id wj20-20020a170907051400b00a28a8a7de10sm605772ejb.159.2024.01.03.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:06:20 -0800 (PST)
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
	stable@vger.kernel.org,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v12 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Wed,  3 Jan 2024 20:05:46 +0100
Message-ID: <20240103190559.14750-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103190559.14750-1-9erthalion6@gmail.com>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
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

Fixes: f3a95075549e0 ("bpf: Allow trampoline re-attach for tracing and lsm programs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Song Liu <song@kernel.org>
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


