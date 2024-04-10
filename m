Return-Path: <bpf+bounces-26372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060289EB1A
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94CDB24361
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30053BB43;
	Wed, 10 Apr 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/rgaV1S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB93717D
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731348; cv=none; b=NxL26ucsJSdhfMx6ZVl2HtiwJ01VIdzXITDSDm/TtzYe8CtdCNsGGJYC+Zc9pLHADY7znmVAvgsiUbibEVP4FfRo9bK/JSZ9y7MGLBb63dm66vEN+KLLbK3dHULAsFkXWkePZZ0kc/GbMQdcBpLgv79klVr6oZFYtT3K8Gjz7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731348; c=relaxed/simple;
	bh=kq3G4kvlAr1jmXOUvJ19pO2WIvsKVHFrv5FgRUg9eTA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ym1LndEA17Kl/USeI/syasTLLWuCYYMjyPoF81nOvF3zr80wpMDY6+Cg/jFYbjGzWIUBwZtVJrCoXIMkPXFJyMwLix+mapGfKdVMC04oc4FFPxuIWaM15a/2/KNbptUNiBAegnIJQnX8Wq59sg4LAm5k2DSJnc+2StlIhMI2zwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/rgaV1S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so75962877b3.2
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731345; x=1713336145; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQW0rqIU1LOz4icGc/bRWaj/FudCS2nGdCigPgdJgSM=;
        b=L/rgaV1Sslc1Bx6GSWREb27Y/gEJsDxUUg2qFXmg0y7jeJ9XrB/2BXlg9zFBltAzj0
         sWlMfmOKyZiiQ+z4tmZB4je7HudnXKxtrUJH6UhD6jyxdcfh78nwq3bzz2fXSuANb5Aq
         3DjF+F4vck2Vl0ON6M1+y9QzBWeqLu22o7V79ESgWRrX7DHZ1KuKdgJKUx4bwnQNBxR1
         VLHVaxEtUAHTp5MV+1xXZoLhVDcdJWHyMGanjzPwusP9RC4WV8bCRE33MGyyqilOeLlH
         UbN8NzI6Z+c7e/vkfg+NRWRlvLq/+s41IkHichBB/cY74rasd79avIiy2jyHjBMLbd0u
         UE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731345; x=1713336145;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQW0rqIU1LOz4icGc/bRWaj/FudCS2nGdCigPgdJgSM=;
        b=S+mp5LJX8JFzma4A5dDoL2ujto3ygcdpHzZFiqXMdBKRZMUJlGfjahJ1ALdzATyrB+
         CrIr+uHeuqKAzkT/DHNabzcNBbqXbNkxpA9EaXI97viYxv+MDRHX9FX3vZQ4GBWMkQnp
         ZWip1X1dFt/qZH68VDChkphcucWYsYcEZdUiihXqvAXVSHTCEHmX0ep+gIHClsvXswH+
         VmCQQNKdRtd7UVM5sUko4yXiQo7seksoSCCZVkSWLA3kvhAVxH2HvbRNkpCSxGN86gVu
         MlAuLaVV84pxR3MImF7LyEwSOQElQSVS7hSnZS18uJDX65gDEAOqhU99Vx1n1HITQICo
         nm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlzIabJdmazRGDKMR+dc2DQAtmrfowuVQCQiZGXfCZnubZ6/v7fwHofsNwVIPiC2xa/BlMQyNJPv6zpwfCU56NJw81
X-Gm-Message-State: AOJu0YwafCiZOcfnxPZzvRqabOU9EYDM+a94mM0WC60TQ3EJmXFyrj3j
	tyPYz5USEyb26kvGkDMG94vjvsImXBEi0fi436bErnpzavnlvJU2eZiashrm8v3fkZmZY7dpkBy
	ZHcNCZg==
X-Google-Smtp-Source: AGHT+IEFHHZasnj2mYopC5f1pnrpW06sEqfw8QoBxN42dadZ7d85PrSB5YSFIf5ai0Iv9zBrAL8mxN9ZdExS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:690c:997:b0:617:cced:e96f with SMTP id
 ce23-20020a05690c099700b00617ccede96fmr379375ywb.8.1712731345532; Tue, 09 Apr
 2024 23:42:25 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:04 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 02/12] perf dsos: Tidy reference counting and locking
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

Move more functionality into dsos.c generally from machine, renaming
functions to match their new usage. The find function is made to
always "get" before returning a dso. Reduce the scope of locks in vdso
to match the locking paradigm.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 73 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/dsos.h    |  9 ++++-
 tools/perf/util/machine.c | 62 ++-------------------------------
 tools/perf/util/map.c     |  4 +--
 tools/perf/util/vdso.c    | 48 +++++++++++--------------
 5 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e65ef6762bed..d269e09005a7 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -181,7 +181,7 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 			 * at the end of the list of duplicates.
 			 */
 			if (!dso || (dso == this))
-				return this;	/* Find matching dso */
+				return dso__get(this);	/* Find matching dso */
 			/*
 			 * The core kernel DSOs may have duplicated long name.
 			 * In this case, the short name should be different.
@@ -253,15 +253,20 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 	if (cmp_short) {
 		list_for_each_entry(pos, &dsos->head, node)
 			if (__dso__cmp_short_name(name, id, pos) == 0)
-				return pos;
+				return dso__get(pos);
 		return NULL;
 	}
 	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
 }
 
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 {
-	return __dsos__find_id(dsos, name, NULL, cmp_short);
+	struct dso *res;
+
+	down_read(&dsos->lock);
+	res = __dsos__find_id(dsos, name, NULL, cmp_short);
+	up_read(&dsos->lock);
+	return res;
 }
 
 static void dso__set_basename(struct dso *dso)
@@ -303,8 +308,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	if (dso != NULL) {
 		__dsos__add(dsos, dso);
 		dso__set_basename(dso);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 	return dso;
 }
@@ -328,7 +331,7 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 {
 	struct dso *dso;
 	down_write(&dsos->lock);
-	dso = dso__get(__dsos__findnew_id(dsos, name, id));
+	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
 	return dso;
 }
@@ -374,3 +377,59 @@ int __dsos__hit_all(struct dsos *dsos)
 
 	return 0;
 }
+
+struct dso *dsos__findnew_module_dso(struct dsos *dsos,
+				     struct machine *machine,
+				     struct kmod_path *m,
+				     const char *filename)
+{
+	struct dso *dso;
+
+	down_write(&dsos->lock);
+
+	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true);
+	if (!dso) {
+		dso = __dsos__addnew(dsos, m->name);
+		if (dso == NULL)
+			goto out_unlock;
+
+		dso__set_module_info(dso, m, machine);
+		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_SPACE__KERNEL;
+	}
+
+out_unlock:
+	up_write(&dsos->lock);
+	return dso;
+}
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+{
+	struct dso *dso, *res = NULL;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		/*
+		 * The cpumode passed to is_kernel_module is not the cpumode of
+		 * *this* event. If we insist on passing correct cpumode to
+		 * is_kernel_module, we should record the cpumode when we adding
+		 * this dso to the linked list.
+		 *
+		 * However we don't really need passing correct cpumode.  We
+		 * know the correct cpumode must be kernel mode (if not, we
+		 * should not link it onto kernel_dsos list).
+		 *
+		 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
+		 * is_kernel_module() treats it as a kernel cpumode.
+		 */
+		if (!dso->kernel ||
+		    is_kernel_module(dso->long_name,
+				     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+			continue;
+
+		res = dso__get(dso);
+		break;
+	}
+	up_read(&dsos->lock);
+	return res;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 1c81ddf07f8f..a7c7f723c5ff 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -10,6 +10,8 @@
 
 struct dso;
 struct dso_id;
+struct kmod_path;
+struct machine;
 
 /*
  * DSOs are put into both a list for fast iteration and rbtree for fast
@@ -33,7 +35,7 @@ void dsos__exit(struct dsos *dsos);
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
@@ -48,4 +50,9 @@ size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
 
 int __dsos__hit_all(struct dsos *dsos);
 
+struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
+				     struct kmod_path *m, const char *filename);
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc8d5e410535..42e49b6ce5a7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -646,31 +646,6 @@ int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static struct dso *machine__findnew_module_dso(struct machine *machine,
-					       struct kmod_path *m,
-					       const char *filename)
-{
-	struct dso *dso;
-
-	down_write(&machine->dsos.lock);
-
-	dso = __dsos__find(&machine->dsos, m->name, true);
-	if (!dso) {
-		dso = __dsos__addnew(&machine->dsos, m->name);
-		if (dso == NULL)
-			goto out_unlock;
-
-		dso__set_module_info(dso, m, machine);
-		dso__set_long_name(dso, strdup(filename), true);
-		dso->kernel = DSO_SPACE__KERNEL;
-	}
-
-	dso__get(dso);
-out_unlock:
-	up_write(&machine->dsos.lock);
-	return dso;
-}
-
 int machine__process_aux_event(struct machine *machine __maybe_unused,
 			       union perf_event *event)
 {
@@ -854,7 +829,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
 
-	dso = machine__findnew_module_dso(machine, &m, filename);
+	dso = dsos__findnew_module_dso(&machine->dsos, machine, &m, filename);
 	if (dso == NULL)
 		goto out;
 
@@ -1663,40 +1638,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		 * Should be there already, from the build-id table in
 		 * the header.
 		 */
-		struct dso *kernel = NULL;
-		struct dso *dso;
-
-		down_read(&machine->dsos.lock);
-
-		list_for_each_entry(dso, &machine->dsos.head, node) {
-
-			/*
-			 * The cpumode passed to is_kernel_module is not the
-			 * cpumode of *this* event. If we insist on passing
-			 * correct cpumode to is_kernel_module, we should
-			 * record the cpumode when we adding this dso to the
-			 * linked list.
-			 *
-			 * However we don't really need passing correct
-			 * cpumode.  We know the correct cpumode must be kernel
-			 * mode (if not, we should not link it onto kernel_dsos
-			 * list).
-			 *
-			 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
-			 * is_kernel_module() treats it as a kernel cpumode.
-			 */
-
-			if (!dso->kernel ||
-			    is_kernel_module(dso->long_name,
-					     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
-				continue;
-
-
-			kernel = dso__get(dso);
-			break;
-		}
-
-		up_read(&machine->dsos.lock);
+		struct dso *kernel = dsos__find_kernel_dso(&machine->dsos);
 
 		if (kernel == NULL)
 			kernel = machine__findnew_dso(machine, machine->mmap_name);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a5d57c201a30..cca871959f87 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -196,9 +196,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * reading the header will have the build ID set and all future mmaps will
 			 * have it missing.
 			 */
-			down_read(&machine->dsos.lock);
-			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
-			up_read(&machine->dsos.lock);
+			header_bid_dso = dsos__find(&machine->dsos, filename, false);
 			if (header_bid_dso && header_bid_dso->header_build_id) {
 				dso__set_build_id(dso, &header_bid_dso->bid);
 				dso->header_build_id = 1;
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index df8963796187..35532dcbff74 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -133,8 +133,6 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	if (dso != NULL) {
 		__dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 
 	return dso;
@@ -252,17 +250,15 @@ static struct dso *__machine__findnew_compat(struct machine *machine,
 	const char *file_name;
 	struct dso *dso;
 
-	dso = __dsos__find(&machine->dsos, vdso_file->dso_name, true);
+	dso = dsos__find(&machine->dsos, vdso_file->dso_name, true);
 	if (dso)
-		goto out;
+		return dso;
 
 	file_name = vdso__get_compat_file(vdso_file);
 	if (!file_name)
-		goto out;
+		return NULL;
 
-	dso = __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
-out:
-	return dso;
+	return __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
 }
 
 static int __machine__findnew_vdso_compat(struct machine *machine,
@@ -308,21 +304,21 @@ static struct dso *machine__find_vdso(struct machine *machine,
 	dso_type = machine__thread_dso_type(machine, thread);
 	switch (dso_type) {
 	case DSO__TYPE_32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
 		if (!dso) {
-			dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO,
-					   true);
+			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
+					 true);
 			if (dso && dso_type != dso__type(dso, machine))
 				dso = NULL;
 		}
 		break;
 	case DSO__TYPE_X32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
 		break;
 	case DSO__TYPE_64BIT:
 	case DSO__TYPE_UNKNOWN:
 	default:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
 		break;
 	}
 
@@ -334,37 +330,33 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 {
 	struct vdso_info *vdso_info;
 	struct dso *dso = NULL;
+	char *file;
 
-	down_write(&machine->dsos.lock);
 	if (!machine->vdso_info)
 		machine->vdso_info = vdso_info__new();
 
 	vdso_info = machine->vdso_info;
 	if (!vdso_info)
-		goto out_unlock;
+		return NULL;
 
 	dso = machine__find_vdso(machine, thread);
 	if (dso)
-		goto out_unlock;
+		return dso;
 
 #if BITS_PER_LONG == 64
 	if (__machine__findnew_vdso_compat(machine, thread, vdso_info, &dso))
-		goto out_unlock;
+		return dso;
 #endif
 
-	dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
-	if (!dso) {
-		char *file;
+	dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+	if (dso)
+		return dso;
 
-		file = get_file(&vdso_info->vdso);
-		if (file)
-			dso = __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
-	}
+	file = get_file(&vdso_info->vdso);
+	if (!file)
+		return NULL;
 
-out_unlock:
-	dso__get(dso);
-	up_write(&machine->dsos.lock);
-	return dso;
+	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
 }
 
 bool dso__is_vdso(struct dso *dso)
-- 
2.44.0.478.gd926399ef9-goog


