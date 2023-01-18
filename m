Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588736713D1
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjARGWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjARGTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:19:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF41E5C2;
        Tue, 17 Jan 2023 22:06:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 200so19187999pfx.7;
        Tue, 17 Jan 2023 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUmpjVqBBhi1SGzypxOnduAfDJL57JgsOCLfCSRMLnM=;
        b=gMYlUezqD4qdnPjzfuEndSrnOUf+/3VDb7WsD0wt6b1eQ/7cmXmHEoMuaO8AJymobm
         VE2rRZgaEtg4NN4R2aR+6OBouY8AG0013mcrh0nOlrsF6i7c0epALpEKg3dAlzlC7ORP
         TGTmfKyyf0uKhOeV0jAhC3mzXc3ocd5P/oKZay0kHtTt1a0zQyWb2hsmfNp///3MPZo9
         aXUm6e0H+VG5DmwjFhuQXBPuhLAUQ8ApezyyT7h3yd2hHy7msmnHingkccsYoZEWvjP4
         myQROjtlZDFxXNlOd2k2OfSgZUESDLjXcuz7R4/xzFNWHr4hGpbZuU3dTtZnjMc4Y0AY
         yh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUmpjVqBBhi1SGzypxOnduAfDJL57JgsOCLfCSRMLnM=;
        b=5iz+RMzBBME9gRJHdBJWKfdRDSFZehYUT8id016Ho+FJ2AfMBSVguEHcI+daxLKBNr
         6pg2s3vOngMiKZX4cBBWxyKSDsDZrfx8rZ90Ii0dKOPW9C/zAGke6jLmVF/7U/8AhXY2
         57LcQIJ+ChIkx/ocd2JLSSA5K4c9vF3QMT9C+LQG58QDPCVxTjJ9mDWcMkCTa8YK9E9a
         50hDkCzaXPuPllHfVUnERZSz7qzyCnLJ2Nx7lOmG6GhoZBP7U/3NVocPh3r5xS69fUMA
         srw2HLZfS75WEGmSDkE6Baa9ZMB9qk5ES+VylIb2wnjDSe0IDcgwVbncMXEHRbX1v0Be
         vX6g==
X-Gm-Message-State: AFqh2kqQnEMYDBoYx3z3nq8rkfQdiBzKPPHPl0Z4WBwweJuNr2+jTsf3
        W7XjdVg4V+p5YXICrkOvMkcvNBeVAPk=
X-Google-Smtp-Source: AMrXdXsdPLCheZ3jUOMo/Qj75/URZVynP1f95P6cPTisA/avRtODJkMMK3ZtPoOUZ/EoHsZLSnMV0A==
X-Received: by 2002:a62:1615:0:b0:587:df0a:804d with SMTP id 21-20020a621615000000b00587df0a804dmr6672554pfw.27.1674021972075;
        Tue, 17 Jan 2023 22:06:12 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3749:9eb3:dfb5:f449])
        by smtp.gmail.com with ESMTPSA id b126-20020a62cf84000000b00574e84ed847sm10990180pfg.24.2023.01.17.22.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:06:11 -0800 (PST)
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
Subject: [PATCH 8/8] perf/core: Call perf_prepare_sample() before running BPF
Date:   Tue, 17 Jan 2023 22:05:59 -0800
Message-Id: <20230118060559.615653-9-namhyung@kernel.org>
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

As BPF can access sample data, it needs to populate the data.  Also
remove the logic to get the callchain specifically as it's covered by
the perf_prepare_sample() now.

Cc: bpf@vger.kernel.org
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 73c40ce84c48..5af61d0292ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10363,13 +10363,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
-		if (prog->call_get_stack &&
-		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
-		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
-			data->callchain = perf_callchain(event, regs);
-			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-		}
-
+		perf_prepare_sample(data, event, regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
-- 
2.39.0.314.g84b9a713c41-goog

