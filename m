Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC868731E
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjBBBmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBBBmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6577DD9
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l4-20020a17090a850400b0023013402671so4119255pjn.5
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7K+pfryiakj921NmwDDKHUHNMkRDDlwHdec1/AfuAw=;
        b=o9C1yU0qRyxMb+8TjyXQNQmbHix8uSyQey7fMxpn7WB3cyhyXbe0esxvoUn/cYcC7l
         sRqr6UOS4MgqlhVNJRLusBxIqf2SRvOxbmza/2MFH/T3TF2WgsTf6ulZlLcAwUF6noqE
         LxckguhCFANPYNBI/kmrCtTki8+ZuXh6cl7LgJfEj+IgzOCGCsl3vAxhecbvBrHF5Xr4
         gJ83wFUazvetJ8aKBIL9iUUqPe4ISRtDM3HOpIrVKZ5J6qbBRaYs8m95ZQHH06AR6Frc
         N5t/S45+9qe+JRQr/EubCBbF+2wBXVShFKEz7oMxUh6Hu6SELFnKpfc5AkwS+THIeB6m
         AALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7K+pfryiakj921NmwDDKHUHNMkRDDlwHdec1/AfuAw=;
        b=RT/4zBgJH9BXoSfedHuhXrllM3vIXgI/2vxC3WbWYPvk8aoRA2nmp1TgqyXwNxIL/b
         01zmEfoGNNiQkbA4TQ7A+MZqojSQ5OX82V+uq2ZaoT9mBay9KttdPtfekoGi1WoICQkD
         mjWlvBMZ9Ev5e3V7BDn5N0Yafv+SCfnjvsX6IOm/mW/86AjyqkOaIOLqxwp1M9h9mbVJ
         XzTlnZHv22FDm9fKS5kwczUbZDOY6Reg4uYkMA9//PAITQC9ElEY2eGYKAq7xkJdJu1r
         WbIazPKcM2SXbcT5h1BuaiK9xsZCgDH0qLuo79DUa5FWhOi0vrEsyH1lby2vq6ottkQH
         6vWg==
X-Gm-Message-State: AO0yUKX5p1QTDwKIvqLepwtiwRjG+Xa1oWh6tMIXbh3+CuAEbc9pEveE
        GISMafydgx6abvf8ej0+Q9Q=
X-Google-Smtp-Source: AK7set/GHLWgQK5/vzlqcUo2kY9V/MdT1dT0WTXwTEy8hgxP1zeDjhfySKsD37XrNnwjv0OVSqcuSg==
X-Received: by 2002:a05:6a20:1605:b0:bf:40b:2db with SMTP id l5-20020a056a20160500b000bf040b02dbmr5874632pzj.22.1675302137265;
        Wed, 01 Feb 2023 17:42:17 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:16 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Vasily Averin <vvs@openvz.org>
Subject: [PATCH bpf-next 1/7] mm: percpu: fix incorrect size in pcpu_obj_full_size()
Date:   Thu,  2 Feb 2023 01:41:52 +0000
Message-Id: <20230202014158.19616-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
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

The extra space which is used to store the obj_cgroup membership is only
valid when kmemcg is enabled. The kmemcg can be disabled via the kernel
parameter "cgroup.memory=nokmem" at runtime.
This helper is also used in non-memcg code, for example the tracepoint,
so we should fix it.

It is found by code review. No real issue happens in production
environment.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vasily Averin <vvs@openvz.org>
---
 mm/percpu-internal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 70b1ea2..2a95b1f 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
+#include <linux/memcontrol.h>
 
 /*
  * pcpu_block_md is the metadata block struct.
@@ -125,7 +126,8 @@ static inline size_t pcpu_obj_full_size(size_t size)
 	size_t extra_size = 0;
 
 #ifdef CONFIG_MEMCG_KMEM
-	extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+	if (!mem_cgroup_kmem_disabled())
+		extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
 #endif
 
 	return size * num_possible_cpus() + extra_size;
-- 
1.8.3.1

