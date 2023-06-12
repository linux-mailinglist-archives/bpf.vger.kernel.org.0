Return-Path: <bpf+bounces-2410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29B72C99C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063FC1C20B52
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E41D2DF;
	Mon, 12 Jun 2023 15:16:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A519511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:24 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432D10EA;
	Mon, 12 Jun 2023 08:16:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62de8bce252so12949316d6.0;
        Mon, 12 Jun 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582981; x=1689174981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0nJQfHkgsS0Ado2J2Ry48mIlQU3QhX2gvGIfIXrVgk=;
        b=QBLG5tGfrScHuOA6XFKGgn3DhpcJVq/bYjJOoCU0Y0ug5hsh3id6idicIEnJD3J9xV
         T9Qu1cpLux2areAfn7tDjMicx5YR99OFmzz6dF+1nS6b56a0xr9K9D5/WVJ2oGz/OUdK
         rYGEnBGIocxu9TLKZoI8LorQgzB3R/lk+nO/Lt1NOAltyG/4g0S0i7kgoopDUkh88gLp
         Gaif/6VUegZy/zYiI4NUneR/I88K4xXy387h2gc0WDgpfj8bTYkaPdLmaPuvTuCiP3tj
         qn+oGfk9W8ike2kQbmFAZvuHheyWB10xnlEuCFYvBsXSAiSy864EwI/zs59loAXeScSL
         LzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582981; x=1689174981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0nJQfHkgsS0Ado2J2Ry48mIlQU3QhX2gvGIfIXrVgk=;
        b=KKheDTRqwA/D8ewUlnm7N5zxHYh5dvNOmKrdbpJrpBeV+2npn87MnzXeb4sO2ZUXOC
         9SHVQrz11u3JJc7V2aN5iPj7WsSXr1H5RbUXmbcjm41GmCgNkdPT/5dlw+SMZd/hGsFe
         /J5ul8ihh6TPcmr4lwyALpMK231dCEsbWBfoQ6uh7EBj+OQ+p9Co+/kRVy2CTELx+egk
         g8mKJILSzb1T3oB7MTRJpJPPxzy5zrzaf8oN10OPE5suxqsGWMg8L2SIpcVxXK7Rrdj5
         MFyDm340jSk+8f2YbPoTesaOQHZ62dLz/myq67Vx9ri3COmIx2NXYwmRHme6XaHbpwnk
         DvHQ==
X-Gm-Message-State: AC+VfDw5XktE5mdb42WeL7ihbawM2aEnRR1U86p0YiOy+uZLW7o8XpMg
	lPcm63PPpcRTH1D4valuhoU=
X-Google-Smtp-Source: ACHHUZ5znqAnJ/eBGJjtPWzZYByiXXFtjmqWYhXvHgXNNA0ALpycV1vyfFWIcGdYhtGIV4s1dHNIsg==
X-Received: by 2002:a05:6214:e48:b0:629:78ae:80e3 with SMTP id o8-20020a0562140e4800b0062978ae80e3mr11730568qvc.24.1686582981679;
        Mon, 12 Jun 2023 08:16:21 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:20 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 05/10] bpf: Clear the probe_addr for uprobe
Date: Mon, 12 Jun 2023 15:16:03 +0000
Message-Id: <20230612151608.99661-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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
Cc: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 742047c..97a5235 100644
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


