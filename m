Return-Path: <bpf+bounces-65768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107BB27FC2
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F7756663B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB632FF16A;
	Fri, 15 Aug 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vhFvrT5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BC137E
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259943; cv=none; b=iQ/NVieCug0By+BDa3ghP52sN9CN+2ctXUgu5rAgX1hahWRUjYz683PJ7xVKw6QKVL2oCt/LtMjwhQKvfKG9+98t5ln5s+vCVqtEB6jsfhS+TB7h2FyvdDd7Apguw5tIpvqxs6RDwF2iyxuTCSW5O1nYEbEvnF6ttuivWewZ9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259943; c=relaxed/simple;
	bh=eJYWJQBF11z0VLWX05nTM8+j9c1+/1TrZvyLZ40kLtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cU93DsEnpEqGf29SSMYJfslxgFw1Nv4O26bjvQ1DNP51OnCKQ+xzd0RRLXPbwiU0QtKECG6uaVEOcgpksdgzZMrZZW3FhWE3FqLaDzTsqVkEu278j7PrBexxPjFQiPesKkIRbG7q/sqydjomVDy4HrnJ3erHvFuKGywsuhdepmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vhFvrT5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a3ee3cso292779266b.2
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755259940; x=1755864740; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgh7P1bEIZBR17lW59I3zPrNy0CyJ0mnhNWhfTDyyyc=;
        b=2vhFvrT5CoMiG5qk+o99apc6jDrmz3LktHDXQ3HCTGf+yiad/uTPcFP+JR2ynngoQX
         s8em3it9i4184ix6jw6l9L9JxKjN89h6POclMD1tJh6nCSTtMxmM5M1qB7SnDZWWwAMx
         i3YnnY64EGXcj0GUA/mCWRyLH49rmhALfM6H1rr+qDNoc1rLFFYejMZaf0UjZ+H/x9Jx
         kB4wi8bSljimU2r+WoXfjhdPrzjM9sr5rGuqJ9KEqFj2dVRklAMVdIX11EwoBHqLWwDj
         iIsw29nfMT9rjhegHUAz1UWZsvWoCE5gkJzLaOxCNNmKzTHXg7CO+D/reMkZ96Hgzt4v
         BrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259940; x=1755864740;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgh7P1bEIZBR17lW59I3zPrNy0CyJ0mnhNWhfTDyyyc=;
        b=X2SLS2UWduYMs+MCmhNSgBMIb18r+CuI0U6wn88sY7I9XGOlXwDKlK57gzs1ErTA0P
         r1O4wBMGAG09MubsM8bi/ri22DDeBHsJNT0JqGxgfZzA7MKeTs+WmNi24GrZtC6FwSr4
         f1JYANDfCFen0KIYABLreuNxJz1IAd/gI9oOO5nv5zKEL6Vr5+nyhi7PXwqn5QehenGF
         5GBblg7xyGRNNgIMgcdS6X+n603wJ0BVw7yfVItmUpyjZbSrV0aZD2J+7TlYFq5ukg0y
         5ploe6ZbAZjccakrvlyHJWFEj7bcjxDEqYj/bHWQDfl9BBK3z6dNDvDHksM9YJIX2ZMg
         aV3A==
X-Gm-Message-State: AOJu0YyB9eJ9hhkm/7FJ3lLTthI68SuI3KWJDuTB4ccRLfgCUI4fnkBs
	LNi2lKlYQ2AqpaHnOYPpehjEVnmHtuYbfb09+kqxBmvBl2toNuh8iFUpZEK/BkARIy6sNOvG2EU
	sSF7T3Q==
X-Gm-Gg: ASbGnctTOKNzfESJBzsJKmgq7ahaBlqmfH4T/0dFaj6UP+3IjA/htx2UGjN5PmS7fdK
	T3zS0+vNg2BK9J9+PjAJogtotps5WyGEuyxN+X8armbhrLaCoQxw1fxzmhCz/dEogVZjJTjsuJE
	vpo/wV/H9uvJw3MzE3BZbjdaV0HpdC/lcY3VVHqEnf1BnE3f46Urhp1QAKftiZqR+R/jLTjYNaK
	riSwnl4b7D5YTAy9qbkLwE8CQvue/AFQ3/sYzNpzkirXlHL7QtHNuVsIG/W/5K7CTjr3eft5sfy
	mi7evuOUar2+OoWLjkmza9FKcMOhvTzgVsyP0xvwF3NXf5MzjoYqcG9hCc3qOvgKGKFMotJHXQC
	+TwT37pPTA+EDOuEIiZPGRZlHb8oEPVp4/tDYxjacz/+bR0TT0TIIMeukbO6t5Z7A/6C8dqR2hS
	3dECb4tkj5TdSuwdhQUQimBg==
X-Google-Smtp-Source: AGHT+IGgjMWBITmeVok5KFaDiK9pG8OBMHYxM+MxYXxJ0/5QA/vA5VadU3N7dKdeJVZKK/N7FWgLkg==
X-Received: by 2002:a17:907:6e9e:b0:af9:9d7b:6f44 with SMTP id a640c23a62f3a-afcdc1a5772mr175113966b.19.1755259939555;
        Fri, 15 Aug 2025 05:12:19 -0700 (PDT)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd04e0a4sm134661466b.114.2025.08.15.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:12:19 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:12:14 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf] bpf/selftests: fix test_tcpnotify_user
Message-ID: <aJ8kHhwgATmA3rLf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Based on a bisect, it appears that commit 7ee988770326 ("timers:
Implement the hierarchical pull model") has somehow inadvertently
broken BPF selftest test_tcpnotify_user. The error that is being
generated by this test is as follows:

	FAILED: Wrong stats Expected 10 calls, got 8

It looks like the change allows timer functions to be run on CPUs
different from the one they are armed on. The test had pinned itself
to CPU 0, and in the past the retransmit attempts also occurred on CPU
0. The test had set the max_entries attribute for
BPF_MAP_TYPE_PERF_EVENT_ARRAY to 2 and was calling
bpf_perf_event_output() with BPF_F_CURRENT_CPU, so the entry was
likely to be in range. With the change to allow timers to run on other
CPUs, the current CPU tasked with performing the retransmit might be
bumped and in turn fall out of range, as the event will be filtered
out via __bpf_perf_event_output() using:

    if (unlikely(index >= array->map.max_entries))
            return -E2BIG;

A possible change would be to explicitly set the max_entries attribute
for perf_event_map in test_tcpnotify_kern.c to a value that's at least
as large as the number of CPUs. As it turns out however, if the field
is left unset, then the BPF selftest library will determine the number
of CPUs available on the underlying system and update the max_entries
attribute accordingly.

A further problem with the test is that it has a thread that continues
running up until the program exits. The main thread cleans up some
LIBBPF data structures, while the other thread continues to use them,
which inevitably will trigger a SIGSEGV. This can be dealt with by
telling the thread to run for as long as necessary and doing a
pthread_join on it before exiting the program.

Finally, I don't think binding the process to CPU 0 is meaningful for
this test any more, so get rid of that.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/progs/test_tcpnotify_kern.c |  1 -
 .../selftests/bpf/test_tcpnotify_user.c       | 20 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index 540181c115a8..ef00d38b0a8d 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -23,7 +23,6 @@ struct {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(max_entries, 2);
 	__type(key, int);
 	__type(value, __u32);
 } perf_event_map SEC(".maps");
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 595194453ff8..35b4893ccdf8 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -15,20 +15,18 @@
 #include <bpf/libbpf.h>
 #include <sys/ioctl.h>
 #include <linux/rtnetlink.h>
-#include <signal.h>
 #include <linux/perf_event.h>
-#include <linux/err.h>
 
-#include "bpf_util.h"
 #include "cgroup_helpers.h"
 
 #include "test_tcpnotify.h"
-#include "trace_helpers.h"
 #include "testing_helpers.h"
 
 #define SOCKET_BUFFER_SIZE (getpagesize() < 8192L ? getpagesize() : 8192L)
 
 pthread_t tid;
+static bool exit_thread;
+
 int rx_callbacks;
 
 static void dummyfn(void *ctx, int cpu, void *data, __u32 size)
@@ -45,7 +43,7 @@ void tcp_notifier_poller(struct perf_buffer *pb)
 {
 	int err;
 
-	while (1) {
+	while (!exit_thread) {
 		err = perf_buffer__poll(pb, 100);
 		if (err < 0 && err != -EINTR) {
 			printf("failed perf_buffer__poll: %d\n", err);
@@ -78,15 +76,10 @@ int main(int argc, char **argv)
 	int error = EXIT_FAILURE;
 	struct bpf_object *obj;
 	char test_script[80];
-	cpu_set_t cpuset;
 	__u32 key = 0;
 
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
-
 	cg_fd = cgroup_setup_and_join(cg_path);
 	if (cg_fd < 0)
 		goto err;
@@ -151,6 +144,13 @@ int main(int argc, char **argv)
 
 	sleep(10);
 
+	exit_thread = true;
+	int ret = pthread_join(tid, NULL);
+	if (ret) {
+		printf("FAILED: pthread_join\n");
+		goto err;
+	}
+
 	if (verify_result(&g)) {
 		printf("FAILED: Wrong stats Expected %d calls, got %d\n",
 			g.ncalls, rx_callbacks);
-- 
2.51.0.rc1.167.g924127e9c0-goog


