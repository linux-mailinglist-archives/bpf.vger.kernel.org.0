Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E988380139
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhENAiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F31C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso463040pjj.0
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhS6f0TBVhBSteU8T+tVYe7ZhZP7o6mZ2Kg9sIpgYK4=;
        b=Aqki5JNj4WrAqiNyqo+rhP9GBE5XxVww/oSQtp/gmDXw7nvxdFosyv46h2S7aJiRmB
         NLkF2SKlO5uxbXn0/Raxz44wJdJgXv/IqNIZn6hbAZi3TJ+Et25NOiYrjCu1E8ilpJoy
         tDrdaO/sHG2pqWRtE6jMnFvN9so+q5DvDu+eUdNZWYHP6FhxW65gqrJgxIHYM2DaeumI
         z0xi/Pj8YBI8MgtaGRzIktY5e9ckYwK7EZYO2PI9fvYv5P0ZTslGVPirZ8/6GRGLE0EQ
         M9HqcPWKAy6jQw8Hw+6jl07yo+5K6UDmxe3PUlnwoamdY6voOr3mW3QQN9Tjfn1yrnmg
         BoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fhS6f0TBVhBSteU8T+tVYe7ZhZP7o6mZ2Kg9sIpgYK4=;
        b=lbWtSHYJwyU09hhxRAoH5HtMJ9dcu8nXj4oiL/GwwRZTqAiyFa8pNC5fNgGxt8MWcN
         ACnkLClW9SOG/fMzcWSzyOFHyKY+9o4xC8Jnk00C/BQShEz9c+L93s5Wq2tOkDVPDPcL
         w7s6r3eaTyoP7WxCHrMSoLCCYOOSiD7bqdEfb4S8Z53G7lroDD/sPuXRwNwz5C1EdeW4
         FeX9664FsG+WcbGWfiTUYl3Yutqf/sLtsUzFycvoLcXZqQCDL7MhkZW3JRxDSGKLlpHu
         8Qnc8qBqV9Xs0ETuvXzLEy0slb6Q7g7qMFUK7akFU311LorxqYtJs8APh8d6aQVXLxyn
         JiAw==
X-Gm-Message-State: AOAM533tsAGwSf9TNJd1MzIFpQFziNRhvKEyOhZKRc9gsq9lMkbBEGEr
        ww9JomOdJZUwodWHNo1WhD8=
X-Google-Smtp-Source: ABdhPJzcYh0L5UJMJ8y7PIa/QUDJPZ+04f9wBMVPWdJYihtg3aVaTDrs6Gb88XTRR7t5Joy9X/v59A==
X-Received: by 2002:a17:90a:a40a:: with SMTP id y10mr10682753pjp.151.1620952616149;
        Thu, 13 May 2021 17:36:56 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:55 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 16/21] libbpf: Introduce bpf_map__initial_value().
Date:   Thu, 13 May 2021 17:36:18 -0700
Message-Id: <20210514003623.28033-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_map__initial_value() to read initial contents
of mmaped data/rodata/bss maps.
Note that bpf_map__set_initial_value() doesn't allow modifying
kconfig map while bpf_map__initial_value() allows reading
its values.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 8 ++++++++
 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f7d184c7e3a..a8089e3e4da4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9750,6 +9750,14 @@ int bpf_map__set_initial_value(struct bpf_map *map,
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

