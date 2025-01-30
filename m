Return-Path: <bpf+bounces-50107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B39A2288F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4FE3A4662
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4191184540;
	Thu, 30 Jan 2025 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQbWsjfW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C214EC73
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214940; cv=none; b=e8lnz0lSs0DwtH4imgkw38eL28D7kklAuzzHWLhuArS7MqeLHqYYwJ0YCrNUIrvCMQ/W8+GANojVUx+1EpvVndDBaSARhAdt2r2HqcWuggNipWWYDzZ9j27i3fu/cjjLghC71zl9M+M0PRxJN6V8onz5hw5FWuw2gahMf/V5lwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214940; c=relaxed/simple;
	bh=u6YkVusD/Op7sqnbvcd5wk9G8T1i8o928y5G6z6230Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5jRlLzbb8a7bAVUcFLQruwh3wOBMfm5HHMMVVntMS567eiWifbMsZSFc1lf2huBB+GtYPhCzeE6G9GKpULJFgKygpuJrirMAhKLHWir/RV3KPf831Ca9Zgdwbceir8LOqF8tBtDqNV95G75AwYVdUPqr887S6PHVBRnuZMbI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQbWsjfW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso2992764a91.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214938; x=1738819738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0ShH9N5Xn6KPuPHJxS7CDMVtVwzvZCJ66gbSr17EIs=;
        b=bQbWsjfWDiiBc437PwMiY3W+X8Y/xqCxzfik1FMZyZUl6M51Ih+YjNrC0IK1t5UinZ
         jtjjHe+P0wQY/0iE0OH7V8SxZHGwzgVNcXS9fSypWtb8S4xccVXxn43SK3n5TmrcKNNP
         bo0Df8pSmrb2Gupahpnfp9nCXbNF1CP5gl3SsrP89voqqH0KC1FDT+NdVB1CcOcBuLtL
         k7+18RZ8NQ1CO+sip31TCI+hbDQHfY9nR8+0OlEr+XivwEw2Zw4S5No0EwScsBrs88iG
         n8YZArMzpR/rnOiypT4IvF17QjyDUX6P6GPL4QOyTqHOyvDYYneaNXuAEi40uYeTMRNq
         XEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214938; x=1738819738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0ShH9N5Xn6KPuPHJxS7CDMVtVwzvZCJ66gbSr17EIs=;
        b=mSxHnnr83RTtiM4PTydg09qUYjxODh1ptB78xZO05vYnH4iWy0CgbkrlZRi/U3XOCm
         mL8y3je7+zjct/9HCxVKMKtmOQ+51Fz83CrJ1vWs3OJwUomE3H4CD2yGGeM+LuT1MJFf
         qhWZt6PSVCxJXbKiBabXswdt8qStzklSR64TJaC2IeQu7mfYA1ajN+HUSsjOQ+kL0YVT
         PQeEiEx+g0qrW27tInbCDgpkiMLQ7ZIZqKkUcBAcoYeGhlGt9lo4GuckwdizNPolvcGl
         BLnkFfbJXllCSuBdrsUvYdu6mv7xKSZ5BAWwIj7WQaFynEeOE1UIpVG7tg+pHoYM4QSQ
         YtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaflqxTnCd6lsQVk9rhbRG/GsdSwcGJ0NfAZyd0b05maTI+bVelJbmEOIBA2kEcPRgT3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9I74DGY5PD1XOhIDE30NOEycXqDCA3DAPCpBHL+jybGi86zyI
	5qltjfKM0hoYKIgLNy87/rqvSwRiWHwmJBncnsdlCjnL1XvDtJCgxo7ePEG6pie+Yw105D91CDj
	UEg==
X-Google-Smtp-Source: AGHT+IGAa4sALHMHuka14HUWGEWJicF6lkEI38f6YBOpiimEmEVwBwfSoQdPngmhzipeF6VwLNy0lnnvIIA=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2da:5868:311c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:518b:b0:2ee:8cbb:de28
 with SMTP id 98e67ed59e1d1-2f846388b5cmr3469102a91.8.1738214938246; Wed, 29
 Jan 2025 21:28:58 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:39 -0800
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-6-ctshao@google.com>
Subject: [PATCH v4 5/5] perf lock: Update documentation for -o option in
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
2.48.1.362.g079036d154-goog


