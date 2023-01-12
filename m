Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6366E667A31
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjALQBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjALQAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:50 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E4643B
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:45 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g9so2142110qtu.2
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3K14TM0boLxDmRFoAT7RRQ6Ph6mAKiCi/aS411tfbA=;
        b=aU2EsvnuuPe3ZSnD50zuV9E4JG6cC0vrWHgi5vg4ikr91yqv2ZGfpwHTgtuioVbpBM
         yyzQKV9/BjIWz7exRjSTq4RarPTJ/Rlay11Cq2e4N063c8OsXOEaMwQ+s4OEoF4KoPch
         oWIcu/UkJwCVTSCFUjbild5uruartTUjGA2B+vrw7cJgwLrO1u6b2EFAn8IJTkNBc5OO
         UlJE64nia/i0LkkrFI92NE/BnSEWTF9cfEphiDZKIJzaE3S1HPXo98teauQs5sn57MMQ
         ceIE7gIKfpLLQKA7fWNK1yOatwIAlDmcEH49jqOD3eVtCUdCrdcwfOk8ScblBs3TJux0
         xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3K14TM0boLxDmRFoAT7RRQ6Ph6mAKiCi/aS411tfbA=;
        b=FR2YJ6zMeIPCta11oMDVX3IG3yt2zQdZbxtomJLo8upuoInumRhhZqUJrEoxdaRDJg
         gU5DYaSNRle52xD7avVPumx1lKQ13A7F9irLHdbFPW+THO+wGT7hS6hT7p2P1/R4lZgH
         AG4+0/eh2W0PdWuEoqb8JzORERgq2abh4hETAgXuxbAkFY8VIyScn/qjoFJdCXzEhMVU
         p4RUpuDwYIjqO234C+4P9lEFX790sguBiuUmwRc0MenbblI7gR5Z9Z4HWJCV9O1TKdlq
         Dj2tZo7HeAMlSSakZQMAXCExK8xyRyTwIv35fyH43C3rZd3LBX8LXaAYrnMV/ekCgrtR
         XWmg==
X-Gm-Message-State: AFqh2kp+oL6tPVuLGjuKseuweBsqfhOkX7FiOygI1764mqKZC48Gt4K3
        +QPNqY+fB/qMvp3pqJA1DVI=
X-Google-Smtp-Source: AMrXdXvViXPTwmFpafLglW8xYZpT4nbyGcr8EcVCNuoHszbaRFi7jBpgklWOBB6m5tYn5p20XICckQ==
X-Received: by 2002:ac8:528c:0:b0:395:396f:a519 with SMTP id s12-20020ac8528c000000b00395396fa519mr101217124qtn.0.1673538824580;
        Thu, 12 Jan 2023 07:53:44 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:43 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 08/11] bpf: use bpf_map_kzalloc in arraymap
Date:   Thu, 12 Jan 2023 15:53:23 +0000
Message-Id: <20230112155326.26902-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
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
index 4847069..e64a417 100644
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
1.8.3.1

