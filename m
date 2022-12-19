Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6627D6513AC
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiLSURl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLSURi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4741D4B;
        Mon, 19 Dec 2022 12:17:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o12so10234576pjo.4;
        Mon, 19 Dec 2022 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laFGg4zCVR1KZhPUCJ4Z8IBvPLNSm6yToKYeukylBe4=;
        b=JSaw3AL5Qs/aLLEIhZkGlWQjtbiLd6reqEJgtPQtVZWqk0tC2naigv64Nj8txbOkSY
         Ax7iDwwirwjgjoQmbAT3Igf0talaUi9NfsHRvHsVAu4ZNe/1jo1+GFuDCSxuQQjwDh2n
         Xqz7Gm0IcbnJEv6jFEDYDpxWgJq4m9sCItnJgKTRzBN4CROcbvX83Uvokjg/Y7DRymCC
         Un1Av0URxnapT46oZmGXG9OgyYbfmUaYCrs6crzX6mA8EQ+qpw8Rzzif1JA8SA4SFRAQ
         yshDpe7EWXwsL/hV+KWZq0NM4mRCP7IXrfQQ6QOnbdaZmVg/6HJhORL9RF1FgHrFZaR5
         Fj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laFGg4zCVR1KZhPUCJ4Z8IBvPLNSm6yToKYeukylBe4=;
        b=2qoOZGi55D28aaDryMlCe6JxvXND4Rdw9ao+HfnHyBFshdKcxlICS3aDDUcmTcAtsr
         qlgfLiSDI4z15eV2vvCHqDgr9gp3oWLhYQhrfGzkd1nhkwlAm01090nE2QjbQJws5c8P
         Ask2JItfU4mOI4/5nui1J9qjWfsWloFjl3twac397u+okLOaai2uKYS9RAzn612SqApt
         R+ov0PzEzZ7tLJ7QYMi2fIGvDtCiQVg2rMaJvhWMsXWQdeknbcBFNOIqLygYZbb6uEcm
         xWFqxhEMq62wYeWhrRgj41EXe1JhfnZNIQMacf2xvONADwDjFXmRL+gFEt2YF+Adscsa
         biiQ==
X-Gm-Message-State: ANoB5pl9oPAc0rhfH+jngTPG4WdsblRS29Uj5FkTurJnMBiFXKyVrsXZ
        51q+8TGCAbQkb5CmgtZzUGE=
X-Google-Smtp-Source: AA0mqf7TTcW05+NqmqIunPoYnOIUVQuwXu7tpi2V6Az2fSsxUN4be9vsep2gtzl9dVmsNipX4iHYow==
X-Received: by 2002:a17:90b:1d05:b0:219:f993:7f0f with SMTP id on5-20020a17090b1d0500b00219f9937f0fmr45744797pjb.11.1671481057295;
        Mon, 19 Dec 2022 12:17:37 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 1/6] perf lock contention: Factor out lock_type_table
Date:   Mon, 19 Dec 2022 12:17:27 -0800
Message-Id: <20221219201732.460111-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219201732.460111-1-namhyung@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move it out of get_type_str() so that we can reuse the table for others
later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 25c0a5e5051f..548d81eb0b18 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1437,30 +1437,30 @@ static void sort_result(void)
 	}
 }
 
-static const char *get_type_str(struct lock_stat *st)
-{
-	static const struct {
-		unsigned int flags;
-		const char *name;
-	} table[] = {
-		{ 0,				"semaphore" },
-		{ LCB_F_SPIN,			"spinlock" },
-		{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R" },
-		{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W"},
-		{ LCB_F_READ,			"rwsem:R" },
-		{ LCB_F_WRITE,			"rwsem:W" },
-		{ LCB_F_RT,			"rtmutex" },
-		{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R" },
-		{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W"},
-		{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R" },
-		{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
-		{ LCB_F_MUTEX,			"mutex" },
-		{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
-	};
+static const struct {
+	unsigned int flags;
+	const char *name;
+} lock_type_table[] = {
+	{ 0,				"semaphore" },
+	{ LCB_F_SPIN,			"spinlock" },
+	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R" },
+	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W"},
+	{ LCB_F_READ,			"rwsem:R" },
+	{ LCB_F_WRITE,			"rwsem:W" },
+	{ LCB_F_RT,			"rtmutex" },
+	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R" },
+	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W"},
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
+	{ LCB_F_MUTEX,			"mutex" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
+};
 
-	for (unsigned int i = 0; i < ARRAY_SIZE(table); i++) {
-		if (table[i].flags == st->flags)
-			return table[i].name;
+static const char *get_type_str(unsigned int flags)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		if (lock_type_table[i].flags == flags)
+			return lock_type_table[i].name;
 	}
 	return "unknown";
 }
@@ -1514,7 +1514,7 @@ static void print_contention_result(struct lock_contention *con)
 
 		switch (aggr_mode) {
 		case LOCK_AGGR_CALLER:
-			pr_info("  %10s   %s\n", get_type_str(st), st->name);
+			pr_info("  %10s   %s\n", get_type_str(st->flags), st->name);
 			break;
 		case LOCK_AGGR_TASK:
 			pid = st->addr;
-- 
2.39.0.314.g84b9a713c41-goog

