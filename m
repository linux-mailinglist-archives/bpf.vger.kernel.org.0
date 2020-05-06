Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB01C7B8F
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgEFUxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729194AbgEFUxF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 16:53:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF5C0610D6
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 13:53:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o134so4105778yba.18
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SB+0qR8XBn8IFJQ/MG0Miycx8pxpjR3L5u9CDE0na6s=;
        b=Xr+iZOjvxcNqSpKCGofVocwfNYahKeswTd3EUNRVcV6W1+/yk6KkvpVOHowLJgRnTQ
         +bm+jG/e2f0TpEX6VaspQ3/LKIOohlS4DZ++8/cjk/v9az6hCTs3spdYcclANMkZiUJu
         btxV+qnCtPj1EJlGIMCYVCcebOTMKbdwOxAthGT/iJXib711W+dOlmFgR/63Q4KCMH9e
         oCcVtnM8qQd0qqRA4Oq5laRGzDKX2NFtzoUOjys9BfzK3a2DXZpH9C1YgZ7XebptGl6x
         Wl1uyB+UjheCRiRevb5m+IiXrOQv1LUxb7q8yiRFdFPCFwyFKgmoxpZKS90b9TYrDPiN
         Ae+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SB+0qR8XBn8IFJQ/MG0Miycx8pxpjR3L5u9CDE0na6s=;
        b=jvdZpj9yYIGxJJxWD2RDk76l++h22lfyWmVCYUYzoPEc53uqHE1unDRBhDKC9aMIWc
         55SWaN7QrHqEX0lATPGtnGIwH+9ZVynx/uZE4WZh3IF8BpmdOPfoTHr/cskfgMYlzAla
         cZdpdkxQecD1cIFLYV9rjv4y6XRwG0C3OcKvXk+fAlGv0oDR7eMJq7Dcza21VhIhuXu1
         8psmkyBjG1VNsTYkIXeub03luiQjOxz8ePjn6fUdFuOT4pbjiTQrO7RayZKJ5yDSt5tw
         1zSEot1AAYn1kPh59dUFoB3J0OeZU6qnMfbuvQiqeXWut/CqkjIUcCtbZzJZkbJKeevM
         gHfg==
X-Gm-Message-State: AGi0PuZmsZJHCiTotteZyP7MfAUaJaMNIVLWAVtEIsUPmQWlWjZ9QH4a
        gkar1oD+D0pKxVpHkF9k/kItj3o4Hj7S
X-Google-Smtp-Source: APiQypIK8JSaVfoCzIrg6e3WCCDvIPqs+/RQUmEbxLMoi1zTKYaJYw7eV7fYGNtJKA8UWjfLwBNT6BzkrEvd
X-Received: by 2002:a25:9384:: with SMTP id a4mr16176208ybm.79.1588798384256;
 Wed, 06 May 2020 13:53:04 -0700 (PDT)
Date:   Wed,  6 May 2020 13:52:57 -0700
In-Reply-To: <20200506205257.8964-1-irogers@google.com>
Message-Id: <20200506205257.8964-3-irogers@google.com>
Mime-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 2/2] lib/bpf hashmap: fixes to hashmap__clear
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hashmap_find_entry assumes that if buckets is NULL then there are no
entries. NULL the buckets in clear to ensure this.
Free hashmap entries and not just the bucket array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..1a1bca1ff5cd 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,13 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt)
+		free(cur);
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.26.2.526.g744177e7f7-goog

