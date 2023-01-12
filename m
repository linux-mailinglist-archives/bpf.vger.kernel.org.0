Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A0667A29
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjALQBK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjALQAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F163116C
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a25so9626779qto.10
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeqvHlFMdqUrdKwM3stpBCHG4LxLYAKLvc5cbQKfD2M=;
        b=S4nLopOsJYZ3zGIfDTyNZtVttayMeAqM2OAGWJeYz+rJMZVqUtVZ0qeVdz0pGGdEYp
         RzXgIUgsGXuNW8ou5ahVgC9fDgvc/45xslOlfcZli/PwOeMzS+n1kz+fmj3tjM/kLFtc
         nb4GiTTMVuRQ1ZWPYviO0Uist+d648cnZJPgSW46ZSvXWmr8vzq9TZ6460qWupRfItmj
         QKGQLPzzCq/dWgpurqXSuDZFF9iwxaklOhCOG10RsQ45JSoQ++tBJCXDzXdGERYUaad8
         OIIXmK+OLBSqpMmBhOFcKxnWNUTcRJNYwEm/1BdWY4tAKYsaLSIrvLhwbcTxUT0bgNvL
         vtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeqvHlFMdqUrdKwM3stpBCHG4LxLYAKLvc5cbQKfD2M=;
        b=fuD5A18PeKSmHlmiM8BZobnx6HfZJVdTrrevus19OPtIcDYFY2MTie7V430sR/75r/
         b5dl45/Aa3/iCqGR5+seWKGXpG8tdPMv8+zeBKfn8024mWZqjkiXZDbZDS6+6wGeQFyc
         imd32AFQe1zWtzZdvOx10NRO7MMpWVVPmHbUBbdAHGmEwGXCr/CJCvr/wefdd0ETzWpU
         QGQ8KM+1Uq+fuvcQsgOjnrLELbNqftVtXtkCk9WfVliqYM7671H226RH8a01iGytNZ8E
         t0kTD5LHUKAtrXofSaHRAKM13zZbsAbh22t9R7o1Rj+o4aQd+DbkfWz4ocsCuQ5tbI5E
         09Ow==
X-Gm-Message-State: AFqh2kqoeKuz31e7pYFurQy1cj5Iw27HENmr9V/YRl8rMQvF76h+5qgb
        QWneWIR/DtHXBgHODyKp+wI=
X-Google-Smtp-Source: AMrXdXsWmJxHSdOEBgnVEWIwQ0w62GOgHxRERmvpZuOPy7H7cm6CcasScRmQoJH25sfjpEi+fxKE+Q==
X-Received: by 2002:ac8:12ca:0:b0:3a8:2d6:521e with SMTP id b10-20020ac812ca000000b003a802d6521emr15089349qtj.37.1673538814596;
        Thu, 12 Jan 2023 07:53:34 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:33 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Vasily Averin <vvs@openvz.org>
Subject: [RFC PATCH bpf-next v2 01/11] mm: percpu: count memcg relevant memory only when kmemcg is enabled
Date:   Thu, 12 Jan 2023 15:53:16 +0000
Message-Id: <20230112155326.26902-2-laoar.shao@gmail.com>
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

The extra space which is used to store the obj_cgroup membership is only
valid when kmemcg is enabled. The kmemcg can be disabled via the kernel
parameter "cgroup.memory=nokmem" at runtime.
This helper is also used in non-memcg code, for example the tracepoint,
so we should fix it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

