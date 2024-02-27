Return-Path: <bpf+bounces-22790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD786A0FD
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239A81F23EEE
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE714E2D0;
	Tue, 27 Feb 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knMQsf7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197F14C5B6
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066795; cv=none; b=GowQ4iJLvW4LcQKsOqu/s6t/QoDko+9Enw8DDT+LFt63MsYW5M7NBa+2keoMfDhsCPGHA2aQkmSmxH2H4psKC9F5Bvg0+JKbTlG41d+o8hZ+LNn5+kPq40zKI1d79fNoFu0w9bS0PPALIa0y0M7W81nGgIpDzdQ7a3//OMx+Afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066795; c=relaxed/simple;
	bh=VxymEpJKHlGJlVgkg1ah8INJrTbJsBszLUr9EQZI2oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrlBPDqBZqli4TJqt1cu7aqZLHTBd0FuwlMdTzjCl/xC6t+r8Ik44VzOVflcWWukemvLNvzU35FDPPI+iRWo0c4Xr1mIhk+rfon+fZq//v3uuKxZfTWE/ykjtwukABsRyr2l4NE7VaWVU9UPiDcocVZwAFvGnU0KVgaBySdfLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knMQsf7n; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a43488745bcso396822766b.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066792; x=1709671592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMVSlIlXMxyBF4/KRZ18vJJTozTm9olW/1R0gUR4hbA=;
        b=knMQsf7nTUI0LagqpPt5CcSjkDRuyD6WbO8J+PVgCiKcWDnAVATvJYdzjPRT5LSjSQ
         xSLBhg7EH6TivqHROFyWRrQxarZNvPeHZCcxyJEcxhyVSJdJaCVft6FAAZiYCuUEIhPZ
         wnKBNplaUIlLmFB/Nzli00OwsBr8m3bS1pydu++e5sCRfgvcegMzhi2PySsg/0BjJyiJ
         yOJEMVi+XAhch2ZML6XJ+q8n4pIH5dM+DqjdJh79Dz/qXIWA8bOnzXwmnjohDvZqjeks
         IdwTUujlc/DhDzf8QfkFiAW+OXHVnxSLo8pp8bQ5lLdpQ6oyURgeWrZ1nsFIU+N22Ht4
         15xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066792; x=1709671592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMVSlIlXMxyBF4/KRZ18vJJTozTm9olW/1R0gUR4hbA=;
        b=Daz/LAaIlVJ3dwI0zAXG+rvt11LGMABPSliJRygwokIWAK2jn0FWZmRbW8UsGPiqf6
         SHbxPzV8lStDWSc1nKZw0oC0qZ9evHswTTy5OTiRLH0V1o6+WmkBoSh2bVowIN25Np2t
         Pjd3uITJ+iuNqqYtK9siS6sveo7HxdeDpGEAUDh276T6dZmwJrfPQl4FwHSKYAeh7h6O
         E5TUjNQ1ziQFDdmirADzesLCXfRvU66XMWpnpKeSCvwH9o+eZSP0K1KyxJVSx5fkdJH7
         RoyPVUDu4etJtvjUDplI+LFysNK5lBUv39XOTmjd9MJWSDDty+T5/4gnwDY9XMKf15hZ
         L1iw==
X-Gm-Message-State: AOJu0YyPWNT1IMfS5e0w8CJM+rPwkGlQq1eNyqxncQBSJPZ43LKsjmzX
	jkBo4EmEyR2GxmvnsvFfiK+uGOQ6kkFrTs3mnnXz1y49Q7VCIpVsB1z5NMGKGhw=
X-Google-Smtp-Source: AGHT+IFBYEgmQ1esj2kCZ3WbL0zxkGQsleeEPJ71Vhl+R6+K9fINFZNKeHVjomuP9lm3RsOGI4cIDw==
X-Received: by 2002:a17:906:3c05:b0:a3f:db30:8999 with SMTP id h5-20020a1709063c0500b00a3fdb308999mr8335751ejg.4.1709066791816;
        Tue, 27 Feb 2024 12:46:31 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:31 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 3/8] libbpf: honor autocreate flag for struct_ops maps
Date: Tue, 27 Feb 2024 22:45:51 +0200
Message-ID: <20240227204556.17524-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip load steps for struct_ops maps not marked for automatic creation.
This should allow to load bpf object in situations like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct test_ops___v1 {
    	int (*foo)(void);
    };

    struct test_ops___v2 {
    	int (*foo)(void);
    	int (*does_not_exist)(void);
    };

    SEC(".struct_ops.link")
    struct test_ops___v1 map_for_old = {
    	.test_1 = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_for_new = {
    	.test_1 = (void *)foo,
    	.does_not_exist = (void *)bar
    };

Suppose program is loaded on old kernel that does not have definition
for 'does_not_exist' struct_ops member. After this commit it would be
possible to load such object file after the following tweaks:

    bpf_program__set_autoload(skel->progs.bar, false);
    bpf_map__set_autocreate(skel->maps.map_for_new, false);

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c239b75d5816..b39d3f2898a1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1192,7 +1192,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
-		if (!bpf_map__is_struct_ops(map))
+		if (!bpf_map__is_struct_ops(map) || !map->autocreate)
 			continue;
 
 		err = bpf_map__init_kern_struct_ops(map);
@@ -8114,7 +8114,7 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	int i;
 
 	for (i = 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_struct_ops(&obj->maps[i]))
+		if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[i].autocreate)
 			bpf_map_prepare_vdata(&obj->maps[i]);
 
 	return 0;
-- 
2.43.0


