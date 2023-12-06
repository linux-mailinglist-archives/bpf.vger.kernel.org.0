Return-Path: <bpf+bounces-16880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DEB8071F8
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4448B1C20C47
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00023DBAF;
	Wed,  6 Dec 2023 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Rs6CoZ5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C2D64
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c039e9719so50776185e9.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872025; x=1702476825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvykMix2y/s2nVs/JtoBvl97FF1Y8Yf3PLdO8JbbZe4=;
        b=Rs6CoZ5UE9jva99W5OLW4YD5sxSi9GcgKkp1iW1Ycv94FHFSdi+SpuxLAdVd87dvUI
         eja0Q7YXCjhiXJrK1mn4OSjhHUHL7Ix1AGnbBuXEUyy8rTiR6MQ3WNpdh8FPOM68GJr4
         2dU34DVMTVvntmssPErW9GHSl+uqzcsuNOXD5XtEhANmqyRF9JF30c/rob3rzIXqy3mx
         CLS+MD736sUzNxKW6WbJhLJopU9Pefashz4OX0JyG6Yxa23nbpmixdJjvHKGD9C2IzEA
         8IbEAnLrMygsGKhQD88QDu6WHxC5BnlBB/Cltoen0pI7HpcUr3Hm+sOeOYrN5r0BS7M/
         yaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872025; x=1702476825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvykMix2y/s2nVs/JtoBvl97FF1Y8Yf3PLdO8JbbZe4=;
        b=PqN2Gf4x4kYf0Y6Ctz8D+MwXZsn8AokQwU93AqYJdw6EKZFq3Jq2SzTIWZbs+VnVRO
         Lo8Ug76a5fHrd0GpAQxtXCZhO/cq7fA1lU0s5ILsYxoiqiAurz2NmiIdZ+3RUkFiFrlM
         6Nmfn45lPOE5UQqAcYcGMGzGODhX+RqPnmO8uDKBra+a4CMOgQpz3a/fOWfIB9NcbtpE
         JPx7xFTFNaXtsTFtyokl+sPPXdVp7NcEJIENfWlJKeMMJ5cyHhND4jCCXQdoA0+lAgqr
         OE/l4ebwMCeQO0Sg/KvdsbW022cphe2cDRS942pcEIVmXZAqG4Lxv22ge+Hok7vGIGOh
         H22Q==
X-Gm-Message-State: AOJu0YzdKXhPZQshsEfLKxaeyF33ANoOiSna2yAZv1XJDk+z8rX0jIqN
	8JWhd7woQCki1gvax8syqiK4aw==
X-Google-Smtp-Source: AGHT+IHJ7azeEp7QtYQ5l0uQFMCbC0alzcXxcidhuHD1h2OSTvfbRcT8xgRuHe7VJRP4VLNKUocauA==
X-Received: by 2002:a05:600c:45d5:b0:40b:5e21:ec37 with SMTP id s21-20020a05600c45d500b0040b5e21ec37mr676160wmo.105.1701872024920;
        Wed, 06 Dec 2023 06:13:44 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:43 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 1/7] bpf: extract bpf_prog_bind_map logic into an inline helper
Date: Wed,  6 Dec 2023 14:10:24 +0000
Message-Id: <20231206141030.1478753-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new inline function __bpf_prog_bind_map() which adds a new map to
prog->aux->used_maps. This new helper will be used in a consequent patch.
(This change also simplifies the code of the bpf_prog_bind_map() function.)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/syscall.c | 58 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..81625ef98a7d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2366,6 +2366,28 @@ struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 }
 EXPORT_SYMBOL_GPL(bpf_prog_get_type_dev);
 
+static int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map)
+{
+	struct bpf_map **used_maps_new;
+	int i;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++)
+		if (prog->aux->used_maps[i] == map)
+			return -EEXIST;
+
+	used_maps_new = krealloc_array(prog->aux->used_maps,
+				       prog->aux->used_map_cnt + 1,
+				       sizeof(used_maps_new[0]),
+				       GFP_KERNEL);
+	if (!used_maps_new)
+		return -ENOMEM;
+
+	prog->aux->used_maps = used_maps_new;
+	prog->aux->used_maps[prog->aux->used_map_cnt++] = map;
+
+	return 0;
+}
+
 /* Initially all BPF programs could be loaded w/o specifying
  * expected_attach_type. Later for some of them specifying expected_attach_type
  * at load time became required so that program could be validated properly.
@@ -5285,8 +5307,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 {
 	struct bpf_prog *prog;
 	struct bpf_map *map;
-	struct bpf_map **used_maps_old, **used_maps_new;
-	int i, ret = 0;
+	int ret = 0;
 
 	if (CHECK_ATTR(BPF_PROG_BIND_MAP))
 		return -EINVAL;
@@ -5305,37 +5326,16 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	}
 
 	mutex_lock(&prog->aux->used_maps_mutex);
-
-	used_maps_old = prog->aux->used_maps;
-
-	for (i = 0; i < prog->aux->used_map_cnt; i++)
-		if (used_maps_old[i] == map) {
-			bpf_map_put(map);
-			goto out_unlock;
-		}
-
-	used_maps_new = kmalloc_array(prog->aux->used_map_cnt + 1,
-				      sizeof(used_maps_new[0]),
-				      GFP_KERNEL);
-	if (!used_maps_new) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	memcpy(used_maps_new, used_maps_old,
-	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
-	used_maps_new[prog->aux->used_map_cnt] = map;
-
-	prog->aux->used_map_cnt++;
-	prog->aux->used_maps = used_maps_new;
-
-	kfree(used_maps_old);
-
-out_unlock:
+	ret = __bpf_prog_bind_map(prog, map);
 	mutex_unlock(&prog->aux->used_maps_mutex);
 
 	if (ret)
 		bpf_map_put(map);
+
+	/* This map was already bound to the program */
+	if (ret == -EEXIST)
+		ret = 0;
+
 out_prog_put:
 	bpf_prog_put(prog);
 	return ret;
-- 
2.34.1


