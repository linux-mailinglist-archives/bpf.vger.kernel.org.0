Return-Path: <bpf+bounces-26378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62589EB26
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CEE1C22EC1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7A4653C;
	Wed, 10 Apr 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0TUY4za"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03D4595B
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731362; cv=none; b=Q/rU9nzYfdtJML4LhQw6BGE73yLr6R7QOht1qeJcH3C5qaKxdmSHJf9e9MX6ahkK+nQ4d372H+VP86wjDhAPXcE6BnBTgVONLYaZDjh0OWbjZcPbTG3j+0P4BnpUyIEPhue/lsh+aq2xRyxuXcj67aCylUAuOjQxLr/vyMEFVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731362; c=relaxed/simple;
	bh=dwCbXSBkyN1tjpd7bzfYoUeghUZbbRswLH6hJGs5tmM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RzLNXoToztmf8CwBdrfSDGLnk9XRNwnSI1cXHVjjEW/55xR/yzjEwLBPkMnGAhHKTMh8enmiNYmM+G28HDDBLXQjNrY+qy4rPqT2/MnUw6sguNUnPWRgdDzvYi6sTzP0iRRo/enhd4iC3tYBhZSQdveqfsyz4DI5+Ur04jVMgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0TUY4za; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso9048199276.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731360; x=1713336160; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5opaBKRcpgr2SRgC+tjQWe+Ct2Hc4/DX4VPdNRiD/yg=;
        b=O0TUY4zaQkQjQBoDXMCHsjpT36jXFmBcXGUsg2+0hJLmfcxQCw83Au/Kxd95bL5NtV
         IVDVQbWjmDw8kbCOmUEq6VxcmeoCoNfIMnon2m5T7wG/jfK81seMBgVyPzxYHwMujh7/
         C4HshHMW/QCU/ds0wG7S4o8Wr+t1LwsdG/px3wdJtHxmciWaVLGhxFTShdeg8xOLVlYu
         jhD2+NcBpMG6jcHMxzdTbCQFZ9SNDeI6+Ss1LIMV5dBtB0eg5BUVOblmnkVRU7MEXylz
         /1LFYwIh6DN6bWhQ5ctbXKdWcwR3s9zQCp/wVQ7QcEXINIzaLpcoUjuD6PT2io284OSO
         skiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731360; x=1713336160;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5opaBKRcpgr2SRgC+tjQWe+Ct2Hc4/DX4VPdNRiD/yg=;
        b=g/hP/DuQSaPfo+Z3J4Nu1ouBQOgl1ZVKjpMl5ko5/Tl+UjLk0RYsh7tcUOSv9QBdfU
         go7sMDbw9jS1kHZKOH769JDJU8s/K8ukQsgasdRaku7+wS3EVXnB3KKn3NxgJ1DsXo/2
         /oG3HIQyCqHbedoJCFs88vm3cn5eDAKqAPC8ZL2gbuWl87IqfOM5Re/C3NNGft+9YZHZ
         8N7f4t3FXedfDduX4MoUe/Gvgu6GanrOFKZ8YAedig+y6jws/PmdovIoBxXJXyBa9OOw
         9Nm+9ErCv3sHKlt7n3Q2s/mLspkQ/EnByr8nQANUkQ/X7r92bR/coMxV36JxLQ3zAQ73
         Ay0A==
X-Forwarded-Encrypted: i=1; AJvYcCWF3EloiWalCVgJGSQEbKumu8NDxysBQHqhM2sIUFacBav/hNCKgTtIskdWLsOnHaPQTK7sVxTcxUyf1LTVy7raiRh4
X-Gm-Message-State: AOJu0YzCfF9GyphtDgP+9cKOtyC37Q4oyH/yMkSj3I1Tljfc0M+c6wgi
	LugeGahbhLthN8ok7ir38QgXJ5GLna+OoE+msnvhGU1qjppK+aYnFpd+lHP1znliG4MjuU5I4dN
	fDtr2EA==
X-Google-Smtp-Source: AGHT+IEPqmUn4JO5oi5XwZ0hilUpENXJLwGzXxcygUdyPkYXGj1YaZoAHhXKHFi1kNnMFjP0IPYIh0y0xQxC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a25:4b42:0:b0:dce:30f5:6bc5 with SMTP id
 y63-20020a254b42000000b00dce30f56bc5mr197862yba.4.1712731359774; Tue, 09 Apr
 2024 23:42:39 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:10 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 08/12] perf dsos: Remove __dsos__findnew_link_by_longname_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function was only called in dsos.c with the dso parameter as
NULL. Remove the function and specialize for the dso being NULL case
removing other unused functions along the way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 51 +++++++++---------------------------------
 tools/perf/util/dsos.h |  6 -----
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1495ab1cd7a0..e4110438841b 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -119,11 +119,6 @@ static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, stru
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int dso__cmp_short_name(struct dso *a, struct dso *b)
-{
-	return __dso__cmp_short_name(a->short_name, &a->id, b);
-}
-
 static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
@@ -143,20 +138,21 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked)
+static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
+					       const char *name,
+					       struct dso_id *id,
+					       bool write_locked)
 {
 	int low = 0, high = dsos->cnt - 1;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
+			struct dso *dso;
+
 			up_read(&dsos->lock);
 			down_write(&dsos->lock);
-			dso = __dsos__findnew_link_by_longname_id(dsos, dso, name, id,
-								  /*write_locked=*/true);
+			dso = __dsos__find_by_longname_id(dsos, name, id,
+							  /*write_locked=*/true);
 			up_write(&dsos->lock);
 			down_read(&dsos->lock);
 			return dso;
@@ -166,9 +162,6 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	if (!name)
-		name = dso->long_name;
-
 	/*
 	 * Find node with the matching name
 	 */
@@ -178,31 +171,13 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		int rc = __dso__cmp_long_name(name, id, this);
 
 		if (rc == 0) {
-			/*
-			 * In case the new DSO is a duplicate of an existing
-			 * one, print a one-time warning & put the new entry
-			 * at the end of the list of duplicates.
-			 */
-			if (!dso || (dso == this))
-				return dso__get(this);	/* Find matching dso */
-			/*
-			 * The core kernel DSOs may have duplicated long name.
-			 * In this case, the short name should be different.
-			 * Comparing the short names to differentiate the DSOs.
-			 */
-			rc = dso__cmp_short_name(dso, this);
-			if (rc == 0) {
-				pr_err("Duplicated dso name: %s\n", name);
-				return NULL;
-			}
+			return dso__get(this);	/* Find matching dso */
 		}
 		if (rc < 0)
 			high = mid - 1;
 		else
 			low = mid + 1;
 	}
-	if (dso)
-		__dsos__add(dsos, dso);
 	return NULL;
 }
 
@@ -240,12 +215,6 @@ int dsos__add(struct dsos *dsos, struct dso *dso)
 	return ret;
 }
 
-static struct dso *__dsos__findnew_by_longname_id(struct dsos *dsos, const char *name,
-						struct dso_id *id, bool write_locked)
-{
-	return __dsos__findnew_link_by_longname_id(dsos, NULL, name, id, write_locked);
-}
-
 struct dsos__find_id_cb_args {
 	const char *name;
 	struct dso_id *id;
@@ -279,7 +248,7 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
 		return args.res;
 	}
-	res = __dsos__findnew_by_longname_id(dsos, name, id, write_locked);
+	res = __dsos__find_by_longname_id(dsos, name, id, write_locked);
 	return res;
 }
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index d1497b11d64c..6c13b65648bc 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -36,12 +36,6 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked);
-
 size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
 size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
-- 
2.44.0.478.gd926399ef9-goog


