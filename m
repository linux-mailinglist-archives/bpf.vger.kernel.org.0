Return-Path: <bpf+bounces-51319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35893A332AD
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6362E3A843C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA420550F;
	Wed, 12 Feb 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLT1C2rD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737001FFC59
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399518; cv=none; b=B7IIDCVJj0KcHbaDP4/TAjN5eqdpB5eP440Jh9TPQed6kQ8k5l5Ejv0BvttE6hb/Y6w1W/rMx9w3+gwUI/GxkMn7vJ8EbNllGWKn5YV+3llj5YIU/7CkRH7kAwCl1LtGxEP2MGmA9HZvq5V0mK6zi/tYEWPxoFL1WzgHlNR0tnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399518; c=relaxed/simple;
	bh=9xYAmC7Odj+wcG5scUKb2hxhqBVZwbTv98XQABN1UOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S65D5pvnGbmCHHUTW6kWNJoARz4rD+QXqZouaowBF5Ah9TYgDhSugZKC/WBlNfgq/jWb6Jpj/ITpoDEGV3P6S3tj+fIopOLbHTWChE73a0K/Il46+RnHpCwymF39islL3xkBQ+RiSAJ80Jqzgf6U1D9Bu9ZFfKd2saMoHdaQLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLT1C2rD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa228b4151so536769a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399517; x=1740004317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4u0lqhDVCs3kWFzXSRSy88eSlq3hW173Ud7Yk2USkk=;
        b=sLT1C2rDOEyzzLjEjuaRckKwaQ00FSPM7NcwXHLowCOWOBl7jqp258G7LJ6nhbMS3N
         3KCYLouS3RjIFHy+L6x32LYG/wvm4gdvQ92X3Lmf7eeRZvMcIMZUiPFq1iHrpdJM7sj+
         /1Vq/Ul3gknf1Q9T1DviNgGoT67r/Dxz8Ce4oOBWyvjPqeLT2+ihOMXr6AXpngEJjxPL
         om5whT5SD6ile3O21yTz2NxFZLQTTgjVruCtLeSUCT7bXdF2X9OD+6lf8AEH+0pi6oo0
         n7IvgLC7MsPON58ug2Ah5HAjyUAdwUGb0kwtbZGAo2PibTzeWSmYid8jA/Yqd8zmavmg
         2hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399517; x=1740004317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4u0lqhDVCs3kWFzXSRSy88eSlq3hW173Ud7Yk2USkk=;
        b=qDxPfJziMZdb3m6LzQsI0aA0xHjMaCDd47wmSbZ6CwYzsmRE1wYAe9zejMOPLkQwAY
         Lf4bvWZv7WSu3JLilKoeCSmAGDPJucJ6VfgbRxRAhdeuAf+qF14VrAjVpjHskN0xs/DK
         qW/h7WD17nxRSqcmvwyf4dp58Exs8TfUMiA4ubqU1rhDg+esUVuRwQMukWWcYc+iCJSh
         R+4dj6VU+1qGIt2lanBmfY1zDtPUXqJ3Ufkb9Ql6+8+k6L2/NLiefSxZtnyoG0q3jHsw
         i0M6P3wDb2BTGiSZntS/ZDiehLYp1bnUyHzzBYCZB3r3WmYj/FDLs1+UytbdxDUXbujh
         7n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVObRsZ1n8nHy+cnwQkm4H7fx/YLPazukB/FhTuofEHkDf2osVnXdrwwwo5stlgCZrwjQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJ87D8xY6n6FPY6NL2W9Cp2NP/iCim1p3GawFvdO21Y44jxMw
	6/oy5gY39wrHtoGD3BibB7DjywZ20Rzl4Cy1j0IOKl8Zdnf1ozLehVCwLmmCjgT35QsMEztmoP0
	f8g==
X-Google-Smtp-Source: AGHT+IHCkcBnyBvA5rBqb0nlmu6y/i7b8JGoyzx+WFgpOL9irq8xmcP/AfVCc/JAi46e7AZbhgN0hE+xX1s=
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:2ef:7af4:5e8e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c04:b0:2fa:f8d:65e7
 with SMTP id 98e67ed59e1d1-2fbf5bb574fmr8098207a91.2.1739399516973; Wed, 12
 Feb 2025 14:31:56 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:56 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-6-ctshao@google.com>
Subject: [PATCH v5 5/5] perf lock: Update documentation for -o option in
 contention mode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch also decouple -o with -t, and shows warning to notify the new
behavior for -ov.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3dc100cf30ef..e16bda6ce525 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1817,7 +1817,7 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
-	if (con->owner && con->save_callstack) {
+	if (con->owner && con->save_callstack && verbose > 0) {
 		struct rb_root root = RB_ROOT;
 
 		if (symbol_conf.field_sep)
@@ -1978,6 +1978,11 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
+	if (show_lock_owner && !show_thread_stats) {
+		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
+		pr_warning("Please use -t option too to keep the old behavior.\n");
+	}
+
 	return 0;
 }
 
@@ -2569,7 +2574,8 @@ int cmd_lock(int argc, const char **argv)
 		     "Filter specific address/symbol of locks", parse_lock_addr),
 	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
 		     "Filter specific function in the callstack", parse_call_stack),
-	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
+	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters.\n"
+		"\t\t\tThis option can be combined with -t, which shows owner's per thread lock stats, or -v, which shows owner's stacktrace"),
 	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
 		   "print result in CSV format with custom separator"),
 	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
-- 
2.48.1.502.g6dc24dfdaf-goog


