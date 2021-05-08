Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDC376F42
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhEHDuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEHDuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22EC061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b21so2168965pft.10
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h6twfkm2IowZKnyKauWBMVhaQnG35VJ+1j0h2W+eISk=;
        b=JpDDcZjMcH6shPLSxZkTgbk9NoJbxpLfkv3wTPxZiiqoGEvsSYK32fODVVoE2nCUQS
         RwLjrmlqIIUxUBXf0gZURMXRx9rrme2EN2hfHP3BfXJVS4rVvJ0N5JqOnYjVT48v1/u5
         BkfG3P7jcXUguJ8MrjxHyMl0q+8gYEZatjn9NEVvib0bd8FVfr9zQ6R5JPHhEuogBDwF
         zSZzvc5GuMh/bLG/gwVtQgAA0++wYOhp0HTQ4Gae8Nm3hfsbAe6+pQ5XPOWO6mwVsG5p
         THFq0u0vzuguAffQ6DzNJBxAIcYMDEi78Hh9Q9JBSHxfqTdaGacf1QpdVbYs7BHxEAlO
         qsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h6twfkm2IowZKnyKauWBMVhaQnG35VJ+1j0h2W+eISk=;
        b=ad5ikLd/BqarLYHh39lcmYtyTXy0rzJEqslS7hkPQ/xvWvYQtn2E4NGsX5TZp3XeA/
         6WZLFw8A+IRtOLBFcleqLppdrpUw19yVngEWbWIHh+lZL9Ocaijq71aS+1sFdFwKOOJG
         fC+joJeyMI+KbNZqUAniERuoq9FotR8rnGtDs8O4XYKQGiHnzWxVk3D5m4uJA5N4U+Y1
         aK3qIulTQemVo8Ua2SYRvEpY5rmtqdI0iwAcwSo1IWdhsVkSJFzAIWgpA34AqeGJKQPO
         dNizjBr0PtSRezMvmZWU1pXm7moUX5yQBLcJ9hYAa8X5WQTLr8PCdsdmiFFHOCIs62cM
         MOHg==
X-Gm-Message-State: AOAM530Dslj+NayMNZBe6cvopNeKI5iSeNuLUt/XMhfVSTfT3se5Wx6V
        HffKTqDvE4o7Q9+Ohq25/do5+P9ekHM=
X-Google-Smtp-Source: ABdhPJy/h4JY1MDxwj6XB6VKzNFLICMv0h8XtNCVsr8SzWtkaGaJk1cqzP9b96iuGT5i98UrkGs6Sg==
X-Received: by 2002:a62:84d2:0:b029:27c:bbd5:6c0d with SMTP id k201-20020a6284d20000b029027cbbd56c0dmr13505250pfd.32.1620445752313;
        Fri, 07 May 2021 20:49:12 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:11 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 17/22] libbpf: Introduce bpf_map__get_initial_value().
Date:   Fri,  7 May 2021 20:48:32 -0700
Message-Id: <20210508034837.64585-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_map__get_initial_value() to read initial contents
of rodata/bss maps. Note only mmaped maps qualify.
Just as bpf_map__set_initial_value() works only for mmaped kconfig.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 24a659448782..f7cdbb0e1faf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9763,6 +9763,16 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	return 0;
 }
 
+int bpf_map__get_initial_value(struct bpf_map *map,
+			       const void **pdata, size_t *psize)
+{
+	if (!map->mmaped)
+		return -EINVAL;
+	*psize = map->def.value_size;
+	*pdata = map->mmaped;
+	return 0;
+}
+
 bool bpf_map__is_offload_neutral(const struct bpf_map *map)
 {
 	return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index fb291b4529e8..f8976a30586f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -471,6 +471,8 @@ LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
 LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
+LIBBPF_API int bpf_map__get_initial_value(struct bpf_map *map,
+					  const void **pdata, size_t *psize);
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 889ee2f3611c..44285045ddf4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -360,6 +360,7 @@ LIBBPF_0.4.0 {
 		bpf_linker__free;
 		bpf_linker__new;
 		bpf_map__inner_map;
+		bpf_map__get_initial_value;
 		bpf_object__gen_loader;
 		bpf_object__set_kversion;
 } LIBBPF_0.3.0;
-- 
2.30.2

