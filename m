Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D637EF3C
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhELXAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346984AbhELVpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3095C08C5DC
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z18so9650677plg.8
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yp+LyyA8g6ahcXFRJoFQOLwZLrnx6pHPiUCqz/iH6eA=;
        b=Kf4wDjML+1v/gss0jXRU0eOlrUd5v/qmjrAxYS+4lz55XpXBtkouu0QZRyZKxLVCTW
         n8AgPShYyxDlIO7fOqYzqUgfyCi/xMk7Ri/ttO1WswOqMhY8pdXHR8o7boqMULErFOqz
         5uSzp3Iz1OYHP9eLVBo9QVEt9ctpG6731ULGOlqEnvnlZMRnp+C5/MVSa5TUGIUviFvQ
         Mt/AIXSefGfNtDmiA0tuQUyAfuW3hf9yyNCLmLZ7ehGwShm6/Q/Cb7PcD85VA3cYgobA
         LB3YTakHBP/KMVNaT5443sI6z2sLc9xj09BKHCgm2CRRzKCI7i4spWdo7AHHD6d4C/8h
         slKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yp+LyyA8g6ahcXFRJoFQOLwZLrnx6pHPiUCqz/iH6eA=;
        b=GfNzaLzVg8/Laz9gUa5vsEGnhXrJF47gnI/6tdoMTGR5x4+K6QwPioLUipSLHOizlE
         uL1xx+FmvRiYq57Db3Rn0Mhw0saVPlcehSpXxwtz4FybiWMFdR/rtYsr2xYp+XS61gfp
         cWEfKD8AXly7m+ABgQ6sD6pd7j9zzFl4skdxSHj0zAASQiGt7afTBzTGkC0WoY5Pk5Rr
         TBTznVqdo8xuw8mtDkhkPcUvtOFs+dxf6yc4QYKw6VXCTz1wVizuEw7RLEplFdI2VsM3
         XXesuRlodEKCBIA4xpRiaE8RSO6MZeFbFeM3ZwpmX4z3t1Ib1SGiaooJtLtJaaZc0R0C
         kSmQ==
X-Gm-Message-State: AOAM532C9qqqFUqrhIYIyKjFXp508vmN2sFQLOOjthvnp8g5L/5uzVga
        DZ8zDCgk5P9nAQ/VmM7DGm0=
X-Google-Smtp-Source: ABdhPJzqJMPIbYjRA50H7jF8sb/119BOJ1yrvk0GDk5p/yCmiwi0p4mFzBcW629uWZUthOkVW7HM3Q==
X-Received: by 2002:a17:902:d718:b029:ee:cf89:57ea with SMTP id w24-20020a170902d718b02900eecf8957eamr37458431ply.3.1620855210361;
        Wed, 12 May 2021 14:33:30 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 16/21] libbpf: Introduce bpf_map__initial_value().
Date:   Wed, 12 May 2021 14:32:51 -0700
Message-Id: <20210512213256.31203-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_map__initial_value() to read initial contents
of rodata/bss maps. Note only mmaped maps qualify.
Just as bpf_map__set_initial_value() works only for mmaped kconfig.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 8 ++++++++
 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fd70f0592ad..8d3b136c6b29 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9736,6 +9736,14 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	return 0;
 }
 
+const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
+{
+	if (!map->mmaped)
+		return NULL;
+	*psize = map->def.value_size;
+	return map->mmaped;
+}
+
 bool bpf_map__is_offload_neutral(const struct bpf_map *map)
 {
 	return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8cf168f3717c..a50eab5fec0a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -471,6 +471,7 @@ LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
 LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
+LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 889ee2f3611c..dd0f24370939 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -359,6 +359,7 @@ LIBBPF_0.4.0 {
 		bpf_linker__finalize;
 		bpf_linker__free;
 		bpf_linker__new;
+		bpf_map__initial_value;
 		bpf_map__inner_map;
 		bpf_object__gen_loader;
 		bpf_object__set_kversion;
-- 
2.30.2

