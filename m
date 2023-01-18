Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471D6713C6
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjARGUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjARGSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:18:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8A1D921;
        Tue, 17 Jan 2023 22:06:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d8so3576686pjc.3;
        Tue, 17 Jan 2023 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Zh73XBwb5RMlMiLWpYbNBMevrlhNdfAXS0S1zywoE=;
        b=BtwVgukY8p2esH90r+fFnX1sw/xNf3PzZDpleVXeJjNvYBea8dbKTD5knI16ZPYgok
         oWn2fv24+g5U8shpZzCUvHcGQU/61rPmRCn9+RfJ85ha/rMs3/KosTyQVgV7NtrmyCz9
         k0NtzMhxCIPQA9rL3f3cKv4MdNW7MzBGeEZf6HWSeogLiXicdsFcOly6Ywmq6L1TuMJG
         NgEl5ocR60OBqguMRShxpuyN+LS7xyEX+uO4TYUyfI8n92g67XLuUVs/F5eWkkkkilZB
         V4p+vpsyyHfWexwQcDIf13zJQKJT3g/x0gCQyEZzkJfC/9eLVI6H25KIajRv/tGPCvFH
         y38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8Zh73XBwb5RMlMiLWpYbNBMevrlhNdfAXS0S1zywoE=;
        b=LiCoUyz5/UQtCXdByEOVEyWfTrecc+QWrDluUWQ12AFSt/JzDj5v1X1ChROOfRTbYx
         Ba5CDXcMR1g4aDdOy1pmmTrqPbzKiJgh+sXJQSXFgLwknloF05RtwRziaq8wDTnCWvim
         rymU+tCsg695RMyTVR4QdKgozee418FiLakAaA+a/XlQoChgq7gklRL4A+wLqURrS7n0
         moWjkNtUKh7Y0wCLnQu/ID4BkS9OKGNob0oi2D9TRBcgTm6YHj+hacY2wKDR6wzPpD47
         6mc1wmRVFlUJgRzA+ctHSK7sMjkRLzKgyfgnjHpoUPrqXUTVi9Foo93R19DHjDXN00+X
         fzPA==
X-Gm-Message-State: AFqh2kqIzgMK/HP5IdJIda5uwa+KkN8gnL9xABDqhkCMrliPPHi2MYfM
        ES1PNz1RwpM2wNxhm/5vy1dMjREWO+A=
X-Google-Smtp-Source: AMrXdXvkfnz1J7DHVrGh6RTHUkvCSRa6QIx8Z/ooE0eq7g2D+h/j4uU3f32SZT52U2utilzNSaBNRQ==
X-Received: by 2002:a05:6a20:b925:b0:9d:efbf:8156 with SMTP id fe37-20020a056a20b92500b0009defbf8156mr29465355pzb.31.1674021969212;
        Tue, 17 Jan 2023 22:06:09 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:08 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 6/8] perf/core: Do not pass header for sample id init
Date:   Tue, 17 Jan 2023 22:05:57 -0800
Message-Id: <20230118060559.615653-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230118060559.615653-1-namhyung@kernel.org>
References: <20230118060559.615653-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The only thing it does for header in __perf_event_header__init_id() is
to update the header size with event->id_header_size.  We can do this
outside and get rid of the argument for the later change.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1384137a90f7..9cc55122188f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7061,14 +7061,12 @@ static void perf_aux_sample_output(struct perf_event *event,
 			     PERF_SAMPLE_ID | PERF_SAMPLE_STREAM_ID |	\
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
 
-static void __perf_event_header__init_id(struct perf_event_header *header,
-					 struct perf_sample_data *data,
+static void __perf_event_header__init_id(struct perf_sample_data *data,
 					 struct perf_event *event,
 					 u64 sample_type)
 {
 	data->type = event->attr.sample_type;
 	data->sample_flags |= data->type & PERF_SAMPLE_ID_ALL;
-	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
 		/* namespace issues */
@@ -7095,8 +7093,10 @@ void perf_event_header__init_id(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event)
 {
-	if (event->attr.sample_id_all)
-		__perf_event_header__init_id(header, data, event, event->attr.sample_type);
+	if (event->attr.sample_id_all) {
+		header->size += event->id_header_size;
+		__perf_event_header__init_id(data, event, event->attr.sample_type);
+	}
 }
 
 static void __perf_event__output_id_sample(struct perf_output_handle *handle,
@@ -7584,7 +7584,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	u64 filtered_sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size;
+	header->size = sizeof(*header) + event->header_size + event->id_header_size;
 
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
@@ -7602,7 +7602,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
-	__perf_event_header__init_id(header, data, event, filtered_sample_type);
+	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
 		data->ip = perf_instruction_pointer(regs);
-- 
2.39.0.314.g84b9a713c41-goog

