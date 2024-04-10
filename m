Return-Path: <bpf+bounces-26374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B662389EB1E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84741C22DF4
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A104405E5;
	Wed, 10 Apr 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnoOY4Xl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C13F9CC
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731353; cv=none; b=ZTWHYzQoISNfdKAfpLwRos6JQC/0f8RE3oWhWPVFLcrlgwa5epQbMrebWFttsbhtRKyalMHh72bi8Jnf5Wi628bFqD2huko8t/f7KjPQe35XRqrBk45MU7lHlTrRm5xJjFhWqbQs9mNUaLyjIB5/bxiINUdXOAcZpYONvs5lCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731353; c=relaxed/simple;
	bh=mAnPFVdlaWL/tFApwYeeagh4y1+c8q5INRTVB6MPKOs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C0TPj1UY5Ko8/5FI7V3v8/ZJrfdlrKCmHVnuEAlLRflAgSIIJcOkajjWmhDUMESOBiP6/eCE7RmnHtBiy2by62z3wTidKIyZORvzm8gUhSibHExZj1y7ajXo9ZMAKryEoX/N3+In0icbe4YVUvm4NkGGIu+v8AKOtZgdVyqkMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnoOY4Xl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6167463c60cso73668637b3.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731350; x=1713336150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfDRhS4iVAGbl5UNPK+Y2BwcdlYkvyvjTNethl/uYBs=;
        b=ZnoOY4XlOa760KyxZffeazDvqKPPTRiOyRHiMi3tVQvyawiMXa7F0IwsUgBPqVQU36
         aay056mPk7WCE0BvF2gtt7BjI8RQ3W/vIZiIT7sYpinmPCA8G+fqV5tjc6AT5ed9vC3Y
         cNmegPFW9cq0oe5LW17UTZHp6Ina6+Lk00bGZLtdl2o/DaOYNtcm4ygGAkYVX1jlKvif
         Dbc6u+rodx23qAwTgqw8GTGn+E4dvEDSuoJtXLIso/BdLa5Do3LKJ+BOgVmFtfUFfnK+
         vSxrT2Nh5qNx8KBKUQa/gpalrbG/SbcydeGuvDY+HUVYGSD8wYuFQvTfqq9WWfwkQcV1
         H9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731350; x=1713336150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfDRhS4iVAGbl5UNPK+Y2BwcdlYkvyvjTNethl/uYBs=;
        b=o/5ftJxag3j6UrkF2m0k2TbT3FrGVTEQsG2BhdJKwDgYz3srhhvqAbfU2qrsq0Ksyt
         ew0KuPgW9t2u1r2eKDLl3OKeZZFzKisfWZqrvuYZaACKhEdmSgMf2/0LaieeZr+uCt2y
         YfHElmnb/NIIb4X5qh4+Q7+H93VT1Kd9RDuZHeI7QvUMBXlQRFk1zrWakYFdhol3qgJw
         Qt9uB0jJMbHwWrpZLJEv8M+VbI1m9rNS2/zZ1aavKS9DXtppsCbq27CtmyQtAkKB+4Ya
         YIPlv5A5pNxOooRaMt8vxVPY0+KMoRXg3c6RQqLqHhDtYoyF7c8nRdirI12SA1pgFJJ+
         lmVA==
X-Forwarded-Encrypted: i=1; AJvYcCUmOs2fbu86MjuqWYnYat65cxPmD1GKYYpJDrvRdJGkwI4C+BsOPqe9cnQk2L2LiTL6rEy8bUNBQW1TibiHdBRgcHaR
X-Gm-Message-State: AOJu0YyHB3HpfEFSFeuLWTc8PFnWKmVDTPUTYfODfH497j1cq9O2keOM
	ZXL11e8j7WCyoekUhYQmABC35cmyKKMU9BRHnDO28fzMSRNelfmbFNWxJO93c3AFI3smBILPTQP
	Lcs5scw==
X-Google-Smtp-Source: AGHT+IHIQuO6GXANAbFhDK4hK1bML6XNxeMNvLF+7KpKn9WoubdbMQqUEGaJu6Jnq6h9i1d883Pi2AS2t0UL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a0d:cb81:0:b0:618:29dd:b96b with SMTP id
 n123-20020a0dcb81000000b0061829ddb96bmr503841ywd.3.1712731350299; Tue, 09 Apr
 2024 23:42:30 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:06 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 04/12] perf dso: Move dso functions out of dsos
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

Move dso and dso_id functions to dso.c to match the struct
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 61 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h  |  4 +++
 tools/perf/util/dsos.c | 61 ------------------------------------------
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6e2a7198b382..ad562743d769 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1269,6 +1269,67 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_
 		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
 }
 
+static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	/*
+	 * Synthesized MMAP events have zero ino_generation, avoid comparing
+	 * them with MMAP events with actual ino_generation.
+	 *
+	 * I found it harmful because the mismatch resulted in a new
+	 * dso that did not have a build ID whereas the original dso did have a
+	 * build ID. The build ID was essential because the object was not found
+	 * otherwise. - Adrian
+	 */
+	if (a->ino_generation && b->ino_generation) {
+		if (a->ino_generation > b->ino_generation) return -1;
+		if (a->ino_generation < b->ino_generation) return 1;
+	}
+
+	return 0;
+}
+
+bool dso_id__empty(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+void dso__inject_id(struct dso *dso, struct dso_id *id)
+{
+	dso->id.maj = id->maj;
+	dso->id.min = id->min;
+	dso->id.ino = id->ino;
+	dso->id.ino_generation = id->ino_generation;
+}
+
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (dso_id__empty(a) || dso_id__empty(b))
+		return 0;
+
+	return __dso_id__cmp(a, b);
+}
+
+int dso__cmp_id(struct dso *a, struct dso *b)
+{
+	return __dso_id__cmp(&a->id, &b->id);
+}
+
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	dso__set_long_name_id(dso, name, NULL, name_allocated);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3d4faad8d5dc..2c295438226d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -238,6 +238,9 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+bool dso_id__empty(struct dso_id *id);
+
 struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
@@ -245,6 +248,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+void dso__inject_id(struct dso *dso, struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d43f64939b12..f816927a21ff 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,67 +41,6 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	if (a->maj > b->maj) return -1;
-	if (a->maj < b->maj) return 1;
-
-	if (a->min > b->min) return -1;
-	if (a->min < b->min) return 1;
-
-	if (a->ino > b->ino) return -1;
-	if (a->ino < b->ino) return 1;
-
-	/*
-	 * Synthesized MMAP events have zero ino_generation, avoid comparing
-	 * them with MMAP events with actual ino_generation.
-	 *
-	 * I found it harmful because the mismatch resulted in a new
-	 * dso that did not have a build ID whereas the original dso did have a
-	 * build ID. The build ID was essential because the object was not found
-	 * otherwise. - Adrian
-	 */
-	if (a->ino_generation && b->ino_generation) {
-		if (a->ino_generation > b->ino_generation) return -1;
-		if (a->ino_generation < b->ino_generation) return 1;
-	}
-
-	return 0;
-}
-
-static bool dso_id__empty(struct dso_id *id)
-{
-	if (!id)
-		return true;
-
-	return !id->maj && !id->min && !id->ino && !id->ino_generation;
-}
-
-static void dso__inject_id(struct dso *dso, struct dso_id *id)
-{
-	dso->id.maj = id->maj;
-	dso->id.min = id->min;
-	dso->id.ino = id->ino;
-	dso->id.ino_generation = id->ino_generation;
-}
-
-static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (dso_id__empty(a) || dso_id__empty(b))
-		return 0;
-
-	return __dso_id__cmp(a, b);
-}
-
-int dso__cmp_id(struct dso *a, struct dso *b)
-{
-	return __dso_id__cmp(&a->id, &b->id);
-}
-
 bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
 	struct list_head *head = &dsos->head;
-- 
2.44.0.478.gd926399ef9-goog


