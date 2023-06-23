Return-Path: <bpf+bounces-3268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D473B9BA
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51F21C21259
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D4AD4A;
	Fri, 23 Jun 2023 14:16:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE6AD3B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:25 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60A1FF7;
	Fri, 23 Jun 2023 07:16:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-341c81d71f6so2493965ab.0;
        Fri, 23 Jun 2023 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529783; x=1690121783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv+tPT5eAlvNoQ80V3EmyTwHswl30O9kG2EfoBAZWRg=;
        b=A98VvmhhRgKal2Xwydck3qqcSj5Uc9sK6yv+OTJRvdpBq/Pg3nCLWU5paYBbveCs0P
         XjpOwlqbeyPiIRqu19BL6MwkgAJKRaW9mcQnRt1BpO71Tc6IiHTMzF3AqlYW/Lf+kqa2
         dHDFqh3cjXmCYVEq00prb011XYDhNHz++ZZd9N/N+PuK0xF9jcWno2N20E/n06OFHQN5
         8E906y//EtbBTE0anwFLwb+vE+XsWcAkNSHqe+7DjwkIAEoTEapNtCilbjH7UO5kAgST
         INcEP7mozcrv0T6/vy4KziHhHQ4QTcmAJT9a5kdf2JZEHlgutF5L3nKf5Mbp3BC05WcQ
         /Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529784; x=1690121784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv+tPT5eAlvNoQ80V3EmyTwHswl30O9kG2EfoBAZWRg=;
        b=eZ2sQiwl4NOYfC7ztaQxaR1f8uEeCMryj5j0OB8QbovmzuW6Wb4YW7V5qI65OYTpkk
         Ah3tXw3l00yANxxs+fWSENcz++ITFDlV1lEQgoR9Gq7MyQYLrHtYoShdSncfLalrrQD+
         RkIRkmVM5Ad+Kd4NPRMezXpb41Zys4je/mSowu7WrLVO0zDTyQ0DdHggc/afKurO8QGq
         tlYGW7MpqGZ/wxZiKyy96zozC2iepPZRqDwTHXOV2Oy81MaNc6tSl/tqcvTlwyOF4wG3
         FAhsCkc3HMaGR/FGP9RFYFRKHSiX8tLowPbM0mNbMvTwk6Do//Y2IFg8OUU+WGPawipO
         /jxQ==
X-Gm-Message-State: AC+VfDyeY57E07D2wxOz95rJKWbeZQA7xBnGSZH6e+seh1u6c58kROYh
	doGwDOncU4mLRAcPatXLo4Lqw1ogCsbRUqDMln0=
X-Google-Smtp-Source: ACHHUZ7SpwJpEwFCBkFbsemwIHOCNqBb+UaB8QDb3Ht2TGuVUzNAK4YdN4B+IggRiG4UzIgZjWtVLg==
X-Received: by 2002:a92:d249:0:b0:342:55d2:d3bb with SMTP id v9-20020a92d249000000b0034255d2d3bbmr15655638ilg.28.1687529783741;
        Fri, 23 Jun 2023 07:16:23 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:23 -0700 (PDT)
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
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
Date: Fri, 23 Jun 2023 14:15:40 +0000
Message-Id: <20230623141546.3751-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To avoid returning uninitialized or random values when querying the file
descriptor (fd) and accessing probe_addr, it is necessary to clear the
variable prior to its use.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2123197b..45ee111 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2372,10 +2372,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-		if (flags & TRACE_EVENT_FL_UPROBE)
+		if (flags & TRACE_EVENT_FL_UPROBE) {
 			err = bpf_get_uprobe_info(event, fd_type, buf,
 						  probe_offset,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
+			*probe_addr = 0x0;
+		}
 #endif
 	}
 
-- 
1.8.3.1


