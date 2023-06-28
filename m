Return-Path: <bpf+bounces-3656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF774107A
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51521C204F6
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165BC13C;
	Wed, 28 Jun 2023 11:53:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE79BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:44 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD32D58;
	Wed, 28 Jun 2023 04:53:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5577900c06bso4234312a12.2;
        Wed, 28 Jun 2023 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953223; x=1690545223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wle0DCHQl+P6X6ELLOmsgvAcyzgK2/Inf7FHrehVpkk=;
        b=aYHg22W/nHRQs6gRBAdXQ8vNOcs4HhCU8F9lDxQhcVeg9uw0nQYWIcrI6KcQ3lCCN7
         ucG+Kvoyb89Grr8sheVQ8HrTjXK5criTrpQ0KvVjorOXbuPOCFKQhRyyQ6HVv4QOx+kj
         0CtvfVnLRXBiHUykkTEcuA6UArGyoxsxvhyxiwTDEe0GuJV2HTEAxhP5T1yx85Uwv1J+
         FI9o+xq59KhgEvQYdJN0WHZJb2FVDBniQqTL+8WbhIl+qKLgQFmNNZmlxmKd7vX9K4LP
         +jPKOXFPgAOMrr7eiEa4/lyFElKjsPG0zOYwDYwI7RRSJ8fJklUEd24CAe5ZMzU4rEuZ
         GLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953223; x=1690545223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wle0DCHQl+P6X6ELLOmsgvAcyzgK2/Inf7FHrehVpkk=;
        b=O77feaM9t+oVSSuJUn2aQWLMRqxoEMVLbGSOagfj7MsVLjcP4pc4g1mG19M44QeKs0
         2IQ5+otbR1hkjQDH1hKaA/y1UTOQiNEiUbUrfkHd/920B/R6Ba+n4cqKL7n/Xjup4E10
         i2bBrY/9vnxq7zH4db3I89Ds2qpG4JREzIpaYVfwTn6BOopdr3HkCvM7YEMcuaL35P27
         YWDlHqAQjMTHrgcWz+2w8IXGNIxVG28VffU8TFEQRzQ27/UTWEcBZOkYcfqHf4Vf/UsG
         r5ndwQ9z/B68SrCsMWxmtM4ZWGNKwpTqQR5W9yHt81sngckzhSvYWFYIJ3KKabSQmYgr
         AnqA==
X-Gm-Message-State: AC+VfDw5sow5k9rfzhCL8snHNxKVNu68IbtsM0qE12wOLuYDGz22XGs/
	NK7itfYNw3jTQ9DH4AccAsc=
X-Google-Smtp-Source: ACHHUZ4+bJfT4J/NPrUMEFcEGeGkkWq7flOehtrRc+a4Lpg3WHd2u81WDR8/LYIQa5NL+L/oaOlpIw==
X-Received: by 2002:a17:90a:a386:b0:261:875:c2be with SMTP id x6-20020a17090aa38600b002610875c2bemr18174261pjp.29.1687953223146;
        Wed, 28 Jun 2023 04:53:43 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:42 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
Date: Wed, 28 Jun 2023 11:53:23 +0000
Message-Id: <20230628115329.248450-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
index 1f9f78e1992f..ac9958907a7c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2382,10 +2382,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
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
2.39.3


