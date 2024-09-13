Return-Path: <bpf+bounces-39840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0B9784EB
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861611C238D9
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7747F4D;
	Fri, 13 Sep 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COR649q3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3829CE7;
	Fri, 13 Sep 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241460; cv=none; b=loJ7ONIaSReMeTWy5G+9JSQ5OG/xtS3tA6Alnz3c0H31/70Blh2XVgYUE19dZ+oNjheozxxynYmNoiu53RHIk9DttiFE38gUKceC2KY5KwSB3HPSoCmLtcZwoztf20aMortB8DFQzQ9j0HR8ZGGL83mpNQ3ledAoBQEqMueicgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241460; c=relaxed/simple;
	bh=Zs8jXu1GSTFwPDVRtTjkCXLw7MLHEjBftzn6rgAN/a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gf96K6JzoKUfCb5m2+CzETconjeJeJPN0dU+Y/9ltDxz2c8OMsXNI73W+KTozk1nbiljo8Od9YPvIpaKlpllIB219WQ/o9OFoy/lAE+bDUhzb9FWdiA2FImWCSgyK+PKBmv78xhdubmh3qDbmYA8GAx2DJfGrLAjKH2x5b5EDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COR649q3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053525bd90so9909045ad.0;
        Fri, 13 Sep 2024 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726241458; x=1726846258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEN5fmrvWiNlJYIKIruWABEynOJ6u5Ud3VxIE3/KHkM=;
        b=COR649q3CkqzVtK8tNZaAsxeEdlDkZKNSKKtyWaaPDZQH8D1rK9rwCuSFx1j3fANI4
         26YfkUeI4KvSDl0JR6RkW5xZqgOoGWjHNOm8ytuC7Ei+hqN1Ci+p7AS9KtcpmyVKC+oQ
         doeE3qVupFkq3yjx/tG4bm1Aia07OWv0hKvF+wGkiK1eH0nRVkWT1phr9PUXf+zGVVGK
         8pxrE3mijCgB9rBw2Os2R8UY33sJsUXfWol5N06NOEdHhsNGYlac3DwM/476pROJ/9BU
         2sp5prAjZEgp3SAbP3HSd+xPB4FgfOQT7Vr4Bv57wIoKXvElGUVtqpQVeF4CGophC2qB
         xgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241458; x=1726846258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEN5fmrvWiNlJYIKIruWABEynOJ6u5Ud3VxIE3/KHkM=;
        b=NUdxVpeCPEFrZqi4E4ztcL4j7fOwP34iZHvcjhJJFoZc9MqoHWrM0jEJ2lnQ4WwHdV
         K5tUslcbF1u6u3yr5eYDcE9B8etMtCPjleG2dlcitdLH1UReP3c7g0DpwszHjNl/Ye3l
         O++Lok+JDp1wkOVjSs2hrTvJrbOHbi0n4loFrMqxP31AGBzZAgpZorjXgAqDvpuPUkLl
         rSk+03CiAxkvgWODoIuSDb0DxMACD+c9n/arjwXwuShhV5A4tuTDZl/Fljl0DjGcQRcI
         KdS1PgaB2C0b5Tlyn9falGo65Ssunrl+3jt0SwbpF8/qt+rfT+U5Zlypb9QzrVptuRqX
         THeg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8OZ9TzdaunP3F1Vv/RVazAN4T3nLGZwVqZ7aJiCqO95z4Uu3fK3yAwsyBscMfdMWumt9jonVIbHJ/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFQXDB7ArynbFOjK/P/oUUmS7/PmhOcyDZAWv+55B1HsU3FlB
	FOf5wcNvbmoA+MYqWTikCCaekIlM6vq8QGniPaZz2k5RJttG6X35
X-Google-Smtp-Source: AGHT+IE2rGR/3Dt6wxOTkxVHKrsbt90vhNYQcKsY6uKNavUKlX8njBKQdY/xaJHFHSTR2/cfjvVAxg==
X-Received: by 2002:a17:90b:278b:b0:2cf:c9ab:e747 with SMTP id 98e67ed59e1d1-2dbb9dbd720mr4112837a91.1.1726241457544;
        Fri, 13 Sep 2024 08:30:57 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ccb87dsm1898033a91.32.2024.09.13.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:30:57 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH v2] libbpf: Fix expected_attach_type set when kernel not support
Date: Fri, 13 Sep 2024 23:30:52 +0800
Message-Id: <20240913153052.169572-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "5902da6d8a52" set expected_attach_type again with
filed of bpf_program after libpf_prepare_prog_load, which makes
expected_attach_type = 0 no sense when kenrel not support the
attach_type feature, so fix it.

Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")

Change list:
- v1 -> v2:
    - restore the original initialization way suggested by Jiri

Co-authored-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..df2244397ba1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
-		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
@@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
@@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
-	/* allow prog_prepare_load_fn to change expected_attach_type */
-	load_attr.expected_attach_type = prog->expected_attach_type;
-
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
-- 
2.25.1


