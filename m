Return-Path: <bpf+bounces-26381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3289EB2E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF461F21CF4
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1314CE09;
	Wed, 10 Apr 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYztm3/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E54AEF6
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731372; cv=none; b=eWx6LMxWNfttYNSBD6eBDdoLZu+UoLYgOLHOWHl9Bk/nOoO4UjrND893kbTIYg3xQ/NXgVwJZSY9YepXZlDmqg4BuJoAVnq57TOUkxyjsiCny/aDWQFCw9JlgpnLq1HU4w8WHX+PmDSxdk/kx0ghP0apK5eYiIFWQdKqF1cD3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731372; c=relaxed/simple;
	bh=stlsOvNZR5kKA5ZGAa5n1sW9k9O90zrgRv6XYZC/ynM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OFRMrm9nnrXIUxWzDV+YNXNHKTRLN7N0KnFc06U/mcIGf98tYaX0lsdvMbAtvZOApB9Papa3ZrZLWL+8cxjVFBsmeHOBxOzfgHSMfDa8YXxWUoipjIdj0NN4iIdiVmY2k7Qlt9GbbRkMyq7KZgaExYXh8OhjAArN05ZWkyQPp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYztm3/4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso97397897b3.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731370; x=1713336170; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gt4hEtTYJQGx7TR6Ig+dNAOXBQM6B+4eUduBrSY/GiI=;
        b=SYztm3/47cj7J6Ur43aPOna4OunTeJbgOiC3w72MR33U1WXaYH76u+wiRCLMPZFHrE
         MR+JtTQe5SQpzSxRROxczQbFqXe+lS0kIiOsgEtcXdK4s4reHEAkLhcH8VF78ifCWHt9
         h1Tv9WHZ/om39d8AoT4Iobinm480+Wpg4HPhnZxu8YEoNQkKXeSJk1v+VXdl94s5HFLn
         OaGB/JQG3Emm5v1ejpx3lxhhRdEZqcdFTA0AMxHVstSB4Do5hnHE6vSgY32KIfo2ao/P
         0eeCehvM/50L36R1JiDQ8Gy6Vhtoq6EikWnZdVHziAWBodH6MuWlNTEvRFp+pkMYENqt
         zD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731370; x=1713336170;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt4hEtTYJQGx7TR6Ig+dNAOXBQM6B+4eUduBrSY/GiI=;
        b=KiJJUL3B0mUWGmOvSOrztRJG2i4RDvNF+vb7QMi++kHwPpRd1epVhGN1lyTDEPTGVm
         uYU19vS+4kP2Y4f05bBcP4k22Skwkn8G4aNHjq8KcQnhuhkgcnEHgLXNF0/4ncmWABFy
         4JD17VHmhkYC8H1nBg8J3amJmqYTvNkcLacqWHUIkzuiaAfHu3pwZ8n3/kUbdi/sov3q
         /RFRRQxnJFxXnSp6MRjoIVMqA5N6aFLATAaON9x9b54fOMczD14QLSfl4L1QZlInbXwt
         u26JrpW8OshGsEkAt+UacqoEnJnjpmhRr2uySSqu22Tf9FiZTGL8KIlwec1lOJntwsGX
         D3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM6K6QpP8+D95OYSAsmou6WVXLwnwbd7ofUS+o4JRGPlXD8oaYpimgOLE/Dkhgeobgsd2Xsu8Sx+z5EoMRWIo/soNb
X-Gm-Message-State: AOJu0YwGMf7JVnlc7zXlMILOwJ9ffLAJr1sy4h2ntZ4bkL4nu72Tdl/0
	SkMkInwt6UxeQ61yVpd6p08vtTBj8AWOiVAZv2s1+/fjN+ipwFHuDv5v2UQpubnYsyzSLdiDJHU
	wM7ZbKQ==
X-Google-Smtp-Source: AGHT+IEzCd93s0df+4HJkQ4c60pBxfLWpsr61diK2eUqCkjd4VCzSdphPGWJY/UAhked51MOF1j2Sh6Vn9vO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a81:ff08:0:b0:614:74e4:a290 with SMTP id
 k8-20020a81ff08000000b0061474e4a290mr406138ywn.3.1712731369897; Tue, 09 Apr
 2024 23:42:49 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:14 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 12/12] perf dso: Use container_of to avoid a pointer in dso_data
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

The dso pointer in dso_data is necessary for reference count checking
to account for the dso_data forming a global list of open dso's with
references to the dso. The dso pointer also allows for the indirection
that reference count checking needs. Outside of reference count
checking the indirection isn't needed and container_of is more
efficient and saves space.

The reference count won't be increased by placing items onto the
global list, matching how things were before the reference count
checking change, but we assert the dso is in dsos holding it live (and
that the set of open dsos is a subset of all dsos for the
machine). Update the DSO data tests so that they use a dsos struct to
make the invariant true.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c | 60 ++++++++++++++++++-------------------
 tools/perf/util/dso.c       | 16 +++++++++-
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index fde4eca84b6f..5286ae8bd2d7 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -10,6 +10,7 @@
 #include <sys/resource.h>
 #include <api/fs/fs.h>
 #include "dso.h"
+#include "dsos.h"
 #include "machine.h"
 #include "symbol.h"
 #include "tests.h"
@@ -123,9 +124,10 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	TEST_ASSERT_VAL("No test file", file);
 
 	memset(&machine, 0, sizeof(machine));
+	dsos__init(&machine.dsos);
 
-	dso = dso__new((const char *)file);
-
+	dso = dso__new(file);
+	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
 	TEST_ASSERT_VAL("Failed to access to dso",
 			dso__data_fd(dso, &machine) >= 0);
 
@@ -170,6 +172,7 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	}
 
 	dso__put(dso);
+	dsos__exit(&machine.dsos);
 	unlink(file);
 	return 0;
 }
@@ -199,41 +202,35 @@ static long open_files_cnt(void)
 	return nr - 1;
 }
 
-static struct dso **dsos;
-
-static int dsos__create(int cnt, int size)
+static int dsos__create(int cnt, int size, struct dsos *dsos)
 {
 	int i;
 
-	dsos = malloc(sizeof(*dsos) * cnt);
-	TEST_ASSERT_VAL("failed to alloc dsos array", dsos);
+	dsos__init(dsos);
 
 	for (i = 0; i < cnt; i++) {
-		char *file;
+		struct dso *dso;
+		char *file = test_file(size);
 
-		file = test_file(size);
 		TEST_ASSERT_VAL("failed to get dso file", file);
-
-		dsos[i] = dso__new(file);
-		TEST_ASSERT_VAL("failed to get dso", dsos[i]);
+		dso = dso__new(file);
+		TEST_ASSERT_VAL("failed to get dso", dso);
+		TEST_ASSERT_VAL("failed to add dso", !dsos__add(dsos, dso));
+		dso__put(dso);
 	}
 
 	return 0;
 }
 
-static void dsos__delete(int cnt)
+static void dsos__delete(struct dsos *dsos)
 {
-	int i;
-
-	for (i = 0; i < cnt; i++) {
-		struct dso *dso = dsos[i];
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
 
 		dso__data_close(dso);
 		unlink(dso__name(dso));
-		dso__put(dso);
 	}
-
-	free(dsos);
+	dsos__exit(dsos);
 }
 
 static int set_fd_limit(int n)
@@ -267,10 +264,10 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	/* and this is now our dso open FDs limit */
 	dso_cnt = limit / 2;
 	TEST_ASSERT_VAL("failed to create dsos\n",
-		!dsos__create(dso_cnt, TEST_FILE_SIZE));
+			!dsos__create(dso_cnt, TEST_FILE_SIZE, &machine.dsos));
 
 	for (i = 0; i < (dso_cnt - 1); i++) {
-		struct dso *dso = dsos[i];
+		struct dso *dso = machine.dsos.dsos[i];
 
 		/*
 		 * Open dsos via dso__data_fd(), it opens the data
@@ -290,17 +287,17 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	}
 
 	/* verify the first one is already open */
-	TEST_ASSERT_VAL("dsos[0] is not open", dso__data(dsos[0])->fd != -1);
+	TEST_ASSERT_VAL("dsos[0] is not open", dso__data(machine.dsos.dsos[0])->fd != -1);
 
 	/* open +1 dso to reach the allowed limit */
-	fd = dso__data_fd(dsos[i], &machine);
+	fd = dso__data_fd(machine.dsos.dsos[i], &machine);
 	TEST_ASSERT_VAL("failed to get fd", fd > 0);
 
 	/* should force the first one to be closed */
-	TEST_ASSERT_VAL("failed to close dsos[0]", dso__data(dsos[0])->fd == -1);
+	TEST_ASSERT_VAL("failed to close dsos[0]", dso__data(machine.dsos.dsos[0])->fd == -1);
 
 	/* cleanup everything */
-	dsos__delete(dso_cnt);
+	dsos__delete(&machine.dsos);
 
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
@@ -325,9 +322,9 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
 	int fd, fd_extra;
 
-#define dso_0 (dsos[0])
-#define dso_1 (dsos[1])
-#define dso_2 (dsos[2])
+#define dso_0 (machine.dsos.dsos[0])
+#define dso_1 (machine.dsos.dsos[1])
+#define dso_2 (machine.dsos.dsos[2])
 
 	/* Rest the internal dso open counter limit. */
 	reset_fd_limit();
@@ -347,7 +344,8 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	TEST_ASSERT_VAL("failed to set file limit",
 			!set_fd_limit((lim)));
 
-	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
+	TEST_ASSERT_VAL("failed to create dsos\n",
+			!dsos__create(3, TEST_FILE_SIZE, &machine.dsos));
 
 	/* open dso_0 */
 	fd = dso__data_fd(dso_0, &machine);
@@ -386,7 +384,7 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 
 	/* cleanup everything */
 	close(fd_extra);
-	dsos__delete(3);
+	dsos__delete(&machine.dsos);
 
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 27db65e96e04..dde706b71da7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -497,14 +497,20 @@ static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
 static void dso__list_add(struct dso *dso)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
+#ifdef REFCNT_CHECKING
 	dso__data(dso)->dso = dso__get(dso);
+#endif
+	/* Assume the dso is part of dsos, hence the optional reference count above. */
+	assert(dso__dsos(dso));
 	dso__data_open_cnt++;
 }
 
 static void dso__list_del(struct dso *dso)
 {
 	list_del_init(&dso__data(dso)->open_entry);
+#ifdef REFCNT_CHECKING
 	dso__put(dso__data(dso)->dso);
+#endif
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
@@ -654,9 +660,15 @@ static void close_dso(struct dso *dso)
 static void close_first_dso(void)
 {
 	struct dso_data *dso_data;
+	struct dso *dso;
 
 	dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
-	close_dso(dso_data->dso);
+#ifdef REFCNT_CHECKING
+	dso = dso_data->dso;
+#else
+	dso = container_of(dso_data, struct dso, data);
+#endif
+	close_dso(dso);
 }
 
 static rlim_t get_fd_limit(void)
@@ -1449,7 +1461,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		data->fd = -1;
 		data->status = DSO_DATA_STATUS_UNKNOWN;
 		INIT_LIST_HEAD(&data->open_entry);
+#ifdef REFCNT_CHECKING
 		data->dso = NULL; /* Set when on the open_entry list. */
+#endif
 	}
 	return res;
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f9689dd60de3..df2c98402af3 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -147,7 +147,9 @@ struct dso_cache {
 struct dso_data {
 	struct rb_root	 cache;
 	struct list_head open_entry;
+#ifdef REFCNT_CHECKING
 	struct dso	 *dso;
+#endif
 	int		 fd;
 	int		 status;
 	u32		 status_seen;
-- 
2.44.0.478.gd926399ef9-goog


