Return-Path: <bpf+bounces-50005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425CA215A3
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02841888812
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CFF16DEB3;
	Wed, 29 Jan 2025 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvRFGquY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F815534E
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110462; cv=none; b=K+a4mh7iQIcObzJds2VrB1mepmT/UprO/OwSPAknGfF6zSlLaa+Ux897KtiPI1XV7u3v0O+h5MaUmHu/3evmjxPMF7s3ksdMoerbbCcfnGO6PNWxSUi0zU1xO9umz0dxfnKoj0/Oy4EOtGJn1RdW85WueJ4IKRFkba8FAiEwm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110462; c=relaxed/simple;
	bh=JXR8T33WgTBIEDVxRbVK0LNxlccdzx4b2VLjaRPQh0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gRqzm4NMfhrgy8MtWtQqcFzypuYhq6NU9bkZdGb47fU1F+y9JRdg1qgxfi87WIYQNL/knI0xALy+rqhdL1ws1tUbcSOO+VDPlXL9XNRGx5eDJqqV4wy3SpyYYyujLTgPcTkp2E1IzuIceI+pRkRyuPZhXrP6lgPoN2xkOSo4doQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvRFGquY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so11575084a91.2
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110460; x=1738715260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kZ7iqAFWEW/1CVmn2pzdj8BRoAIsJA95X92RXs36J8=;
        b=nvRFGquYQypX/GMKG5jfKGxtDChsO1vDSr9GUI/hHLe7/D0oI9eS1PosoMoJPE1BEP
         dX6OVnkNdthZoOTx38OqagAzRcrgQ6546uoSjyKRzD3nzI9AE8UpVTKNG/4yn8HNlnqo
         n0iLhZGVNlaieHPmDkvL3P246sFVHGauFsb9B4W9zz8gJXwKJBMGFM9UFe4QtNZb8eqr
         Od3wq84AxXsrIBn1xfoO/eI0IyT6RdnvMIYlNW5r/K26ISmq2oDLSLVtqjd8fo5aRYcW
         Jr9h1MzBAVv0pQ1ilGxkoxyyUUZ2+zJIcoXa/hX1TJHbyZC0lMQvf9KKEdPKOjwvW/QT
         Iatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110460; x=1738715260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kZ7iqAFWEW/1CVmn2pzdj8BRoAIsJA95X92RXs36J8=;
        b=Gd3YnwPaBQzxrFVIpmg5RZ3JvGeLc+Hbox0lpSGWuVY0acmfqyZNwaCW4iTqIakMHi
         OoH0WJi2GRpwr7tCDf5AK3hRl0phtzyF37IQFjANPh1AJRvpDGbv/xYYTRoRnCounOnm
         Lb64OWP/PhgE4hx8sSk0mAK1CSxMJWp/rRg+gwakTX3TRG2uhslimkwD2/+q2FJ6i22T
         3//a7Gm0UAXNHghHCixnF6GpC4aEdHxZT+pFU07yoiCtgOzLow7bspu4b5EeVEVcEpO+
         jhWzbz2/WiBTEPLgEImXH1farZ+UDKuqTe1QXlT7iKaKWmG2XOGBIO0/8vpG/ISwXioM
         1i3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtqD7OaTt8SGTgoPI9H3NE+y+SRYFfbjJ/lS/pkr2csXgJby+7y9yM7FUjV+nUNUdtSoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4vTCoc9EaRQEcdaVcPUf1nqzGYI0nceUGzssgBJDYPpbQRQh
	6HBRqB1zE2PaWqvuuVaHQhspC+uvzsy77dqWfypYCf8vDxKMhpbte+LFdgQlmFqqQzX9hLW+/ol
	FWQ==
X-Google-Smtp-Source: AGHT+IHuivb002Myaw3lnKxSivwCEVIBuEWsY7r6mdBhKNiyiCBu9zbawayIbipZdTXtPqU4Sr6JtaI2KY0=
X-Received: from pjyr14.prod.google.com ([2002:a17:90a:e18e:b0:2e5:5ffc:1c36])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5190:b0:2ee:d63f:d8f
 with SMTP id 98e67ed59e1d1-2f83abb91d4mr1576644a91.13.1738110460020; Tue, 28
 Jan 2025 16:27:40 -0800 (PST)
Date: Tue, 28 Jan 2025 16:15:01 -0800
In-Reply-To: <20250129001905.619859-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129001905.619859-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-6-ctshao@google.com>
Subject: [PATCH v3 5/5] perf lock: Update documentation for -o option in
 contention mode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This patch also decouple -o with -t, and shows warning to notify the new
behavior for -ov.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d9b0d7472aea..b925be06b0d8 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1818,7 +1818,7 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
-	if (con->owner && con->save_callstack) {
+	if (con->owner && con->save_callstack && verbose > 0) {
 		struct rb_root root = RB_ROOT;
 
 		if (symbol_conf.field_sep)
@@ -1979,6 +1979,11 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
+	if (show_lock_owner && !show_thread_stats) {
+		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
+		pr_warning("Please use -t option too to keep the old behavior.\n");
+	}
+
 	return 0;
 }
 
@@ -2570,7 +2575,8 @@ int cmd_lock(int argc, const char **argv)
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
2.48.1.262.g85cc9f2d1e-goog


