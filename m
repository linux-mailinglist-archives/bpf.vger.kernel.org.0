Return-Path: <bpf+bounces-6430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225A76945E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE0128157D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288461800A;
	Mon, 31 Jul 2023 11:13:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E211C94
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:13:21 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB570E53
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:13:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad907ba4so26415305ad.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801999; x=1691406799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfqZsjQyGTSU0bwRsgZK04gfvIMrCcP+ShIrBEJ4XdE=;
        b=RANsBFGZeWVdGkG859we/yMYqyfhQ0RD8QfM1JhE2QALhDcG7oJMq60LBz4X6Tpqpc
         g5rNkQQbULCQniLlSqF9G5p6xV5/gz00Wz/IPhdK0cFhs4RYdjP2+ohfMXh+Ais8c/2Y
         VuTATUNyn7Uv4n9T9UdDQtFBN5EuUxDuFIwQF9UUBzNjJMIOs5uEr2Gdcf/+chihkK33
         KfMZNaIFPfPadYAUp1u2HJXYdrnRUgYWCEHalAe8zADUQ2N/EGmfadKR5uXsOEzPm7O0
         miy0qaBvjNkCMZLwHirbmhWbkJfoAs+zl2UeUC0RVh5wCw5a+atp13/rxaPaCj4sBPBO
         C64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801999; x=1691406799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfqZsjQyGTSU0bwRsgZK04gfvIMrCcP+ShIrBEJ4XdE=;
        b=IxTgQLhshze31qXIhv8MoGyef9zC6EwKhfbCZv02fyjBlmrXo2gDJpufmLxLpddsgm
         n1iyRt241umMr/g6zJ4F8e8VSHgI6m+hvyufp8MBge6CuuU1V4+3G+exG7LbB1Y8bmMi
         8HrPPN18sIkWfiORbFunj/T/UbholB63BF/Q80GTZDhKW2gKGBjWG0S+7MXa+K9i94bJ
         ZNKWDLkwlNjemon3fvDU/WMJTdA6+WZeEYvas/Nghzc1kfU7lR52rqIvY6zWUxMO/2dP
         Mb1Is5zQkZA4OShEIt84mkT08uBqNzrEA+j9d9h2j8jlb6IpgJGkzmaCVVxyrmT1AH3R
         w0wA==
X-Gm-Message-State: ABy/qLYbqfb121OJ4nhO1am5VKvjKjvLARD6MEzQLeuw53Tiwjeey8K2
	+B2D1YHFRTA/VO1Cr/c7TdE=
X-Google-Smtp-Source: APBJJlEVDvcrWiU9UP65sXtINMg3Rxc3HMm0Tw6rKAChupp9UbpeOWCkj5g67yXwVyHivhUpJnYjAA==
X-Received: by 2002:a17:902:ab96:b0:1bb:9675:8c06 with SMTP id f22-20020a170902ab9600b001bb96758c06mr7185014plr.35.1690801999113;
        Mon, 31 Jul 2023 04:13:19 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:e1:5400:4ff:fe86:7b43])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001b8422f1000sm8293862plh.201.2023.07.31.04.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:13:18 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Mon, 31 Jul 2023 11:13:12 +0000
Message-Id: <20230731111313.3745-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230731111313.3745-1-laoar.shao@gmail.com>
References: <20230731111313.3745-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

    kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
    error: uninitialized symbol 'type'.

That can happens when uname is NULL. So fix it by verifying the uname
when we really need to fill it.

Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c3..166390f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3378,14 +3378,14 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 
 	if (!ulen ^ !uname)
 		return -EINVAL;
-	if (!uname)
-		return 0;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr);
 	if (err)
 		return err;
 
+	if (!uname)
+		return 0;
 	if (buf) {
 		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-- 
1.8.3.1


