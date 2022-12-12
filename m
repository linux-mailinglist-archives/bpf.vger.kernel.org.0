Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0364976D
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiLLAiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiLLAiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01DB87D
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so10401257plb.13
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gn9WpBDEDaKUZZ8QU8b0wRBxnaqWXKyRBa/KIthXAc=;
        b=TWn91mBr7aKw/ejdDKR8YL7ViEiJcmwoPO13rsfGRzSRZE90vZVGrc6m64SxoME0rZ
         E9fh4oE0UPZADwjceaLGA4JaZzdz/IgvhYVJ9gkZbU1JRYUvBeN0VVWTtH9Aj110I2Tr
         4fM0+PLVoB0u4oFlIsTnJqhY6GjykrCYTJW1LQaZ754Nr8tOqlv2pMi6C+kKF2+EIKno
         kHiEl3JnREg8e5EjK8s+1wLeoI9rT4QwKporT6WDsvXLGG3UZoLK8SJnszfUYecDX4VX
         kEpaWZ1S1SrCVl8ShKGHFUKaEAiSFq6nWM/byd0bd7dRnm2NTps4eMiA3pf3enuIC8qT
         4edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gn9WpBDEDaKUZZ8QU8b0wRBxnaqWXKyRBa/KIthXAc=;
        b=xV13hXc6Pa25nzuGV8UzU1lZKt5/WChMjuypjE6zawIvE4+svHVZhSpIrX2hEGqciv
         K7YuwlFW1RUHdjCDqMmTqijkuyHDmdf+jFmvINXecE78ZZG1pClrtoGXZ3PlkdrgOJel
         BiTsKjS6veXv99PjmOFj0BHjTyj7EKwNeJ4u26WCZgRpOgcS9jVQ2l9aOya0hzPR9NLg
         56VphSdHZmJLyqTrNE0u92j25EvtteV38mrGG0ROKkuNX+zsmqORc5Ezam1roqLhoVjs
         xZtk1ZKzZcXDZTHMioaZV33liAEyyHv7HHlqjPZ5Ff2qKr/bkN9sOiCwl9XJdCYjiF1B
         i3gA==
X-Gm-Message-State: ANoB5pneptHGwFJLUl5bi7iak2eLw1q3Fc/gJRSOYyVSJYlhWvEPfnjz
        Qrkjapjb1aDnQ2wMvXFOjeM=
X-Google-Smtp-Source: AA0mqf4aXVqdAlSTQEp8cHa2whCkSMepIO+xNKgkOlasHFVjqEnA9uC4JbLlGFLM9jtxp3TZIyO5fg==
X-Received: by 2002:a17:902:ed85:b0:185:441e:2d9f with SMTP id e5-20020a170902ed8500b00185441e2d9fmr12716619plj.54.1670805492169;
        Sun, 11 Dec 2022 16:38:12 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:38:11 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 7/9] bpf: Use bpf_map_kzalloc in arraymap
Date:   Mon, 12 Dec 2022 00:37:09 +0000
Message-Id: <20221212003711.24977-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allocates memory after map creation, then we can use the generic helper
bpf_map_kzalloc() instead of the open-coded kzalloc().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/arraymap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 484706959556..e64a4178d92d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1102,20 +1102,20 @@ static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
 	struct bpf_array_aux *aux;
 	struct bpf_map *map;
 
-	aux = kzalloc(sizeof(*aux), GFP_KERNEL_ACCOUNT);
-	if (!aux)
+	map = array_map_alloc(attr);
+	if (IS_ERR(map))
 		return ERR_PTR(-ENOMEM);
 
+	aux = bpf_map_kzalloc(map, sizeof(*aux), GFP_KERNEL);
+	if (!aux) {
+		array_map_free(map);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	INIT_WORK(&aux->work, prog_array_map_clear_deferred);
 	INIT_LIST_HEAD(&aux->poke_progs);
 	mutex_init(&aux->poke_mutex);
 
-	map = array_map_alloc(attr);
-	if (IS_ERR(map)) {
-		kfree(aux);
-		return map;
-	}
-
 	container_of(map, struct bpf_array, map)->aux = aux;
 	aux->map = map;
 
-- 
2.30.1 (Apple Git-130)

