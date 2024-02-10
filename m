Return-Path: <bpf+bounces-21685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB70850273
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B3F1C2492B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B072364CB;
	Sat, 10 Feb 2024 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueZrGJ0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF90360AE
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535093; cv=none; b=aGVMbUQeAe44xO2Vrdjh5iQttEb+osLq12RFBpJfcL9q26J/jayPrU0rtWVmtMJO/OrbGUpKMLiVdSGS+1ineXu3emo3UigpQr3ZTWxhNh85tO9o/foKZLJX/AqjoX605VOvIbFS0gqzI6W4lQtZ98I0V53aVC5omS736bjQZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535093; c=relaxed/simple;
	bh=fmY7OGiQyoafs0dUqE06bQrvTXGFG0wOIGJr3qrBCDk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=b3dzlblQ8CCEmmcIstBhZTLoL7ms8kFVZs8lrD6Sx6sYkL2fh64OP2O4W5BFHvw8sgcFxs2vDM1h61NZ/TshgBcRLEpSrm4FDr9ng1+7XVjyIY2lrdtFnBjNvCS490UMJowsJjTcEl7iUTFVCbdo++qaQGRSBR+NfKXE/KZ0pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueZrGJ0I; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso31743027b3.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 19:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535090; x=1708139890; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ie89sB6IlXpvkiQnUaYF5PTvKc7dfqYdcE9ndiylfmM=;
        b=ueZrGJ0IuPfGlwXCKjovy5gGGS30jkNrGtsNC8pnicR1KIk7lhl7dwkZUTTREAOoJn
         NztsMiVXbJgsmEcNLj4vd4HNyYmGU6iDVlGEsEDePPLWhfY0MrnR1rsXNVEXNnrUx7Xq
         Ya6tpJEpWKjWuLP/CZ7d5tmfZU0ulM+GHc7NbiuEBH9vpd/pt/jYMMkvWMnni+Zhlab1
         x7qQZ8ux3//bPdqmSGd+SC2MqMA0k3M7nDu8yY6UgHEBm/SlbSS5PKGXZnL/lP0dawbD
         gMm2dlCbtU9N4Rx+SXav2XKoBtqnExXgy4hn2CCnLJNAsuhuna7RTGWqy4QthZpYDbwg
         Iv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535090; x=1708139890;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie89sB6IlXpvkiQnUaYF5PTvKc7dfqYdcE9ndiylfmM=;
        b=T7Hgt3CBRwImiqHvWLtKho1iQVFThAOIlvj6VgPCtIxvuY04mL2/+/aqDdMG2T+xAB
         3mhc7ptUHrL0opoy6DDI5AUyIRDQ9oEC5pGuv28loh5eBKbk7QS5H0f0gLYIpJgReuqb
         4cpd7Ijzjk4zowGa0a4dLrnsl5hpKVJQtDrX3oWx9EsulW7xzqWS6NQTfXPcJZz3i6I+
         UMT1O6L5Ya94W0iGRmMcTbBgIYq3WSPKy0FyN3O65AeIPP7PogKcrsgEbksnx/AkrNim
         MKv0psSjP4202v+cggbMfyGJFNj3Mndx+MGYttF01Qy+h6xn8rVgogW1hCYBXMMixdD0
         9+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXsYjfoc12jrHaYigdG20bpXqhZqZ40ww0eeP3x6DjWvhZaaDMRgR+HtQ79Tdksuxs9Mi8pdVqpKvMA5HZILk+c9f9C
X-Gm-Message-State: AOJu0Yx/V4mP3rmq4yMtJBHmlufnm9BnN/2f+hYf9SO24SbATP5pofvK
	yej2tMd5Ze9NIC1MpER4/55XmRo1QwHZoC5Q4DViBgHXE44XzboMci0pyV62k+W9xwpw3mMf9oL
	Nc8NJgw==
X-Google-Smtp-Source: AGHT+IFrn1CHZlVjSpwmvdN+dl+BaRe9nkKsGon6NJpS0hJXAXYFpUNu2G/yduT8mliL5SE1aGM0Nbh2LJ+v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a0d:d549:0:b0:604:499:fee1 with SMTP id
 x70-20020a0dd549000000b006040499fee1mr191533ywd.6.1707535090579; Fri, 09 Feb
 2024 19:18:10 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:46 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 6/6] perf maps: Locking tidy up of nr_maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4911734411b5..3da92f18814a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -440,7 +440,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 439cefab112a..53aea6d2ef93 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -541,7 +541,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -871,7 +877,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.687.g38aa6559b0-goog


