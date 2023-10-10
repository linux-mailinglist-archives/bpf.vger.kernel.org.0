Return-Path: <bpf+bounces-11787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71E7BF266
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9A1C20D6A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 05:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA12591;
	Tue, 10 Oct 2023 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzzwIQd8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9D63C4;
	Tue, 10 Oct 2023 05:46:23 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8647CC;
	Mon,  9 Oct 2023 22:46:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c760b34d25so35879715ad.3;
        Mon, 09 Oct 2023 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696916781; x=1697521581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZV2ZA/8PD3wKvcF+YbrnJdD7O9iGtRQwpgfooTt3pA=;
        b=fzzwIQd87dTpeLC+oIE5/L6NbJr4fyGlaF8OMHSxuvDfwTR495GN+B194401LbaclD
         OJTOr2FhJqL4l+ZMgsnuCvvCbfj2QQxTwfdVkMttUBnBve/oYrTesjM7lPX18P3IWDrr
         z6o9Sq9Ci8fYsWDhr8qcU8zsibUsdlQrrqhmzUOWZ/TSBjD9UM15dw1Q+TWl4eVR5XeT
         F5LNR8Y6PzZpcLv4HumjPhwgOPQe2wNOLEAGMN9NKvuIGRMPX+nY7uTyMRakrI4P7iQv
         A3ALL9n51OvDzMWpz3xMIiAwdUU49VpPreR2J1DB55n+xgs/HJDTrtzPn1x6NSAMD9BF
         7J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916781; x=1697521581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZV2ZA/8PD3wKvcF+YbrnJdD7O9iGtRQwpgfooTt3pA=;
        b=dHM3CxonBTWSq2RNIbc3JeYfmUa+pWgskgHcAfUNOW3pIKMuMjFO1RFr3HSfy4RFxW
         piiwlvZeXgDvhJNmECfcxx2EgxmLzpnqj/a8YpGrFoguNELkV4jDV6AjmHOzCsVckarR
         pSq+Xfozuqt/fa7gUq/Xie5RuUn99lYu3EdSp3ELKy0GHAYfF1l6xF4S9+BB9yIkFAA/
         t5MP8ly72HbWvLM0tIYgGpZsyztCeXnLXCWHjZUlLPamnFS47RdrzTqHJXE4AiHzUy3P
         PxCiDc9A+bIekWSM8cQeHtsiB/x3h0KWKxCaf4R0khccqU1rvniUvauoztXO8ZyiG52H
         F7YQ==
X-Gm-Message-State: AOJu0Yz6jGNG34oi3crszq7QcqA9Jj4yh9lAJGYgAF8KBZsOtEOo6zxw
	5DLhKLGI8Vin+qi/D77t9dM=
X-Google-Smtp-Source: AGHT+IGgwGdDAROMc9rbopS3EWpWn4e/KTwUWLS+/exKVAfJ/dS8C+Y6v8zEnWJU3rCBrhg6eGwfNA==
X-Received: by 2002:a17:902:aa05:b0:1bf:c59:c944 with SMTP id be5-20020a170902aa0500b001bf0c59c944mr14195900plb.22.1696916781099;
        Mon, 09 Oct 2023 22:46:21 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:2749:d38c:68c4:434f])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm10590084plr.134.2023.10.09.22.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:46:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/2] perf lock contention: Check tstamp elem creation
Date: Mon,  9 Oct 2023 22:46:17 -0700
Message-ID: <20231010054617.1901616-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010054617.1901616-1-namhyung@kernel.org>
References: <20231010054617.1901616-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To be more conservative, let's check the return value of
bpf_map_update_elem() for the tstamp map for a task and change
the flag to BPF_NOEXIST so that it cannot update any existing
element.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index b11179452e19..69d31fd77cd0 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -328,7 +328,11 @@ int contention_begin(u64 *ctx)
 	if (pelem == NULL) {
 		struct tstamp_data zero = {};
 
-		bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
+		if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST) < 0) {
+			__sync_fetch_and_add(&task_fail, 1);
+			return 0;
+		}
+
 		pelem = bpf_map_lookup_elem(&tstamp, &pid);
 		if (pelem == NULL) {
 			__sync_fetch_and_add(&task_fail, 1);
-- 
2.42.0.609.gbb76f46606-goog


