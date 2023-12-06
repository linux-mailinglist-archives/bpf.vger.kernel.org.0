Return-Path: <bpf+bounces-16881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822D8071F9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65591F215CA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F03DBB5;
	Wed,  6 Dec 2023 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UeL9oCgS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F150D5F
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso5333515e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872027; x=1702476827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLj/TJoOLretkQGY8Iwvu8Sot+mgIa4XdPhJoK6i32M=;
        b=UeL9oCgSLo8L9QHIqAb+tuKgTpDGYk67RxyJs+mOUhULs8VFP2UX1UIVz0ZXukDnVI
         YgaITdOIYorgIG3eRxsnBddvtlCCRccQlt7VWBUiQyBKXl3+oPxHfKLlozCzACM3I/Dx
         cZpH4U9V4y/Lclqaremivi7ZTllghlzrOYz5p9ER2bZiFRhwy728N6wVdKvcAdcluVV2
         r6R3xVikoldLHhOquixzC7GXqLTPlZrBq2/9imade6/hdp4DrjxUx3UkZ2J83QaN8whi
         Ui+V8mBhIzbcbpy6uykckcWxdgiHiEAHmVnbmWeVXHNQennsAUVzn0ye8+eta1wblWaT
         uxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872027; x=1702476827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLj/TJoOLretkQGY8Iwvu8Sot+mgIa4XdPhJoK6i32M=;
        b=JvVh8uWu+et/7WfXTeZsBHswX5JGIdHsizdtrV8Jo9xvtM7aOYPjnMvbpxjFrbQ8ek
         AGQYCc5j+Vc5lk5rgD6hDsS/8YL+4yOQDM/1Bx59cs+25eubq8FDIarXsbKYA7u3WZhC
         BiLNDyYXG6vaACUhUV6SIcyHWmg5YRiewzuyInpsxCiXgbd0fLsYM+N44plSRb+AmUT7
         m5TersZiZo0HnCJBwX7voLKJIsF4rVFqu0gqB+SEEfepL3d7WCPLHcbbzJASACx5APZS
         4nn22SVW/XkwmV9DlnBGn1hy0bPs37yVuW+b3cF6eFb5rKatC5wHNuPFi7sPZdKCbKEX
         gYZw==
X-Gm-Message-State: AOJu0YxyHNCg6aClgHE37lpexZ3UylTO+VQqdVHqClbFTTwwccpm76BK
	e4QcsJhdlVKY4X8xyGYmA3vwfqFoCeGolEK5LWc=
X-Google-Smtp-Source: AGHT+IGdwueU9m73Uz3PYTqxjd6915dJwCWmOK/ltDEMwJRgFw6rcmXzvWARKnedLW5vjNBDqmcdKA==
X-Received: by 2002:a1c:7c0f:0:b0:40b:5e4a:2359 with SMTP id x15-20020a1c7c0f000000b0040b5e4a2359mr1720762wmc.91.1701872026541;
        Wed, 06 Dec 2023 06:13:46 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:45 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 2/7] bpf: rename and export a struct definition
Date: Wed,  6 Dec 2023 14:10:25 +0000
Message-Id: <20231206141030.1478753-3-aspsk@isovalent.com>
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

There is a structure, struct prog_poke_elem, defined in the k/b/array.c.
It contains a list_head and a pointer to a bpf_prog_aux instance, and its
purpose is to serve as a list element in a list of bpf_prog_aux instances.
Rename it to struct bpf_prog_aux_list_elem and define inside the i/l/bpf.h
so that it can be reused for similar purposes by other pieces of code.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h   |  5 +++++
 kernel/bpf/arraymap.c | 13 ++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb84caf133df..8085780b7fcd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3227,4 +3227,9 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+struct bpf_prog_aux_list_elem {
+	struct list_head list;
+	struct bpf_prog_aux *aux;
+};
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..7e6df6bd7e7a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -956,15 +956,10 @@ static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
-struct prog_poke_elem {
-	struct list_head list;
-	struct bpf_prog_aux *aux;
-};
-
 static int prog_array_map_poke_track(struct bpf_map *map,
 				     struct bpf_prog_aux *prog_aux)
 {
-	struct prog_poke_elem *elem;
+	struct bpf_prog_aux_list_elem *elem;
 	struct bpf_array_aux *aux;
 	int ret = 0;
 
@@ -997,7 +992,7 @@ static int prog_array_map_poke_track(struct bpf_map *map,
 static void prog_array_map_poke_untrack(struct bpf_map *map,
 					struct bpf_prog_aux *prog_aux)
 {
-	struct prog_poke_elem *elem, *tmp;
+	struct bpf_prog_aux_list_elem *elem, *tmp;
 	struct bpf_array_aux *aux;
 
 	aux = container_of(map, struct bpf_array, map)->aux;
@@ -1017,7 +1012,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 				    struct bpf_prog *new)
 {
 	u8 *old_addr, *new_addr, *old_bypass_addr;
-	struct prog_poke_elem *elem;
+	struct bpf_prog_aux_list_elem *elem;
 	struct bpf_array_aux *aux;
 
 	aux = container_of(map, struct bpf_array, map)->aux;
@@ -1148,7 +1143,7 @@ static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
 
 static void prog_array_map_free(struct bpf_map *map)
 {
-	struct prog_poke_elem *elem, *tmp;
+	struct bpf_prog_aux_list_elem *elem, *tmp;
 	struct bpf_array_aux *aux;
 
 	aux = container_of(map, struct bpf_array, map)->aux;
-- 
2.34.1


