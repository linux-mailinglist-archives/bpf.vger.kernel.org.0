Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD24C69EC87
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBVBr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB2732E65
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a26so3673426pfo.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcpM//UKIAW1ZQQm0nQY95pG6OE3zU7MKvM5PtfO9N4=;
        b=Or5MTmCH/rH6K3N5US40bmr7KEA9Rc8U/mrEhDKi/xf8MEoQTQnx3DOVQUt3zqN6w2
         r5veMZxnLCQGEoqq55y1H+NHkqxjCDHqEuSLNH9a1U/XxXOGWrXW5atZDzNmf/ml9P6u
         niedfI0sXhy4ShGzv2+zVyTTf+AKcfM7CLIXMH6p/lDlzbHtT0xoLU0R3hgfWCGtZueM
         ulhonukBk1+hjIVQGfmp+ORKmpgZHM+qw3mlw22FKUDoBVQdQ7JG3WvoA6SWGC9MGn5d
         aILcSYbXh6pAPBFplH97zPgYHr5pDRCt0+g6UUA/fjVM0iUPldFodapFBsHbW3fti/cW
         +wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcpM//UKIAW1ZQQm0nQY95pG6OE3zU7MKvM5PtfO9N4=;
        b=eV51s5mAaIiGfJo5Mxs4tXwnhljXuDxdVrPtaxL7vWfqJJIlKQ1SjQm0rMItUVbkp8
         HtyXttVIdva/yYM9eJZi+TnJn8T6pEl5fvgdOswQP2Eg4jPDBh4P+hLSATn/OdxyTULG
         KTmr05ZtJWuiTq/+QeHgrV/TmAaIWWyuOcE7smIZNHclCsTys/tqEnBkGH0Rdj+dBXDR
         5+rB/8VSA1IVY0h2phvYL5NqWZog+nlZ0iR4Cxk9ENJ89UE9pp9mg69LibhFl08Ydd7l
         jsejZZQ/euxhgz8Weg4xd8Fw1UzNDQwioEDomKUFoj1c2/edrxZwQH53lgrkFu3lZAeg
         C5mw==
X-Gm-Message-State: AO0yUKU8FFbv1B6MRRAoT6Jxc/Vp06Db4Y1MgCBaKGuIDF4L/yZedfQZ
        RmaHVietQwjYflqvE7MyVrE=
X-Google-Smtp-Source: AK7set+sGhB05eCm8Kmyaup/AGZ/r60iCURbTQ3v6SY1hGj1jvukmoNwNjFDGlLQcQ7WvLH6Kjr4sA==
X-Received: by 2002:a05:6a00:18a9:b0:594:1f1c:3d3b with SMTP id x41-20020a056a0018a900b005941f1c3d3bmr9161148pfh.16.1677030445096;
        Tue, 21 Feb 2023 17:47:25 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:24 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 18/18] bpf: enforce all maps having memory usage callback
Date:   Wed, 22 Feb 2023 01:45:53 +0000
Message-Id: <20230222014553.47744-19-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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

We have implemented memory usage callback for all maps, and we enforce
any newly added map having a callback as well. Show a warning if it
doesn't have.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e12b03e..d814d4e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -775,13 +775,9 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 /* Show the memory usage of a bpf map */
 static u64 bpf_map_memory_usage(const struct bpf_map *map)
 {
-	unsigned long size;
-
-	if (map->ops->map_mem_usage)
-		return map->ops->map_mem_usage(map);
-
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
-	return round_up(map->max_entries * size, PAGE_SIZE);
+	if (WARN_ON_ONCE(!map->ops->map_mem_usage))
+		return 0;
+	return map->ops->map_mem_usage(map);
 }
 
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
-- 
1.8.3.1

