Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965683DCA12
	for <lists+bpf@lfdr.de>; Sun,  1 Aug 2021 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhHAFLg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Aug 2021 01:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHAFLg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Aug 2021 01:11:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B13C06175F
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 22:11:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c18so13640061qke.2
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tu+g1PbF2qC1dgZLK4PaRMVsVFJ5AJPHZu8bzgWwdLQ=;
        b=rKreJpcwgWwT7Hcw8UF2wVDno4rrxsFCYBPz15FtPOTVU7C26i3kI08etquKI9owg2
         GICv72vsr5msALS2lPo1mVFhV7lBF4wExvprEk6VeCp5O1TTocARMDhGp6UN6qt8DKmS
         oHWoiyWhcvZZXjy2DOeUK0NBtR9CJV8aXx+kY74HzRztpzDgPznYMFgyqcjKkdIoM3RR
         RWLRgHLPIwXRVTTGZirc+WP52k6tTDQqah/MYnB2lIhzmDdoFoEFv3JjXImx+QmbqBR7
         5jFOVZ2h+IJ5y9XQshqGkx3qt2QR9PzTYjh+tJgeY+lKCtjLQQZgmTjM6iSkpBQS167o
         DU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tu+g1PbF2qC1dgZLK4PaRMVsVFJ5AJPHZu8bzgWwdLQ=;
        b=j7MnkVhCZuhvzy03QM3Ef0/csvzwrHP/bTKkwaEOs1RQrR29iVjSdSvYwzMmF52S5h
         y4agEtXxET/PJbkVYJdpCuv/t7FDyxXTy4lT2d1qmtBEFH8EepzSQwDVHjsyvp9ImCPH
         wV2aJ7mB/oOzqNp1g0wncwFrQROcpdnSaORqBLqn3157t1LE3D/UjL7qe5F/sWu9uZb3
         mmvunGdvh92S9ODKNN23lNLz6MZy2+af8u+R02uNgIjVZ2nLI6ZhjS4lm6YK/Jqm7Alq
         OvR4lKr7JElesjUKLeJuumgPVKaYbLruAiHT+s7umDawxxtIeHIIRvx+RhBpeBPLm0q7
         4Jvw==
X-Gm-Message-State: AOAM530jAu2XEf3h2w6v1/Bg8cml2/HfvI5aB51Gf3l/0SdpTmhH671b
        7UdDK0QcmVDWwmxCLlE9A8gAuV323TyM
X-Google-Smtp-Source: ABdhPJzlR2tEP3e/ICtIF+fTdU412JvLwdFYg6p2TB3wOWSp0tfSGnu+XSVGpd8A1NTRcZUc8OH8Wg==
X-Received: by 2002:ae9:e315:: with SMTP id v21mr9542362qkf.81.1627794687245;
        Sat, 31 Jul 2021 22:11:27 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([191.177.175.120])
        by smtp.gmail.com with ESMTPSA id h2sm3903345qkf.106.2021.07.31.22.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 22:11:26 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
To:     bpf@vger.kernel.org
Cc:     rafaeldtinoco@gmail.com, andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v4] libbpf: introduce legacy kprobe events support
Date:   Sun,  1 Aug 2021 02:11:23 -0300
Message-Id: <20210801051123.3822498-1-rafaeldtinoco@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730053413.1090371-1-andrii@kernel.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow kprobe tracepoint events creation through legacy interface, as the
kprobe dynamic PMUs support, used by default, was only created in v4.17.

After commit "bpf: implement minimal BPF perf link", it was allowed that
some extra - to the link - information is accessed through container_of
struct bpf_link. This allows the tracing perf event legacy name, and
information whether it is a retprobe, to be saved outside bpf_link
structure, which would not be optimal.

This enables CO.RE support for older kernels.

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
---
 tools/lib/bpf/libbpf.c | 127 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e1b7b2b6618c..40037340a3e7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8985,9 +8985,55 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
+static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset) {
+	int fd, ret = 0;
+	pid_t p = getpid();
+	char cmd[192] = {}, probename[128] = {}, probefunc[128] = {};
+	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+
+	if (retprobe)
+		snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, p);
+	else
+		snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, p);
+
+	if (offset)
+		snprintf(probefunc, sizeof(probefunc), "%s+%lu", name, offset);
+
+	if (add) {
+		snprintf(cmd, sizeof(cmd), "%c:%s %s",
+			 retprobe ? 'r' : 'p',
+			 probename,
+			 offset ? probefunc : name);
+	} else {
+		snprintf(cmd, sizeof(cmd), "-:%s", probename);
+	}
+
+	fd = open(file, O_WRONLY | O_APPEND, 0);
+	if (!fd)
+		return -errno;
+	ret = write(fd, cmd, strlen(cmd));
+	if (ret < 0)
+		ret = -errno;
+	close(fd);
+
+	return ret;
+}
+
+static inline int add_kprobe_event_legacy(const char *name, bool retprobe, uint64_t offset)
+{
+	return poke_kprobe_events(true, name, retprobe, offset);
+}
+
+static inline int remove_kprobe_event_legacy(const char *name, bool retprobe)
+{
+	return poke_kprobe_events(false, name, retprobe, 0);
+}
+
 struct bpf_link_perf {
 	struct bpf_link link;
 	int perf_event_fd;
+	char *legacy_name;
+	bool is_retprobe;
 };
 
 static int bpf_link_perf_detach(struct bpf_link *link)
@@ -9002,6 +9048,10 @@ static int bpf_link_perf_detach(struct bpf_link *link)
 		close(perf_link->perf_event_fd);
 	close(link->fd);
 
+	/* legacy kprobe needs to be removed after perf event fd closure */
+	if (perf_link->legacy_name)
+		remove_kprobe_event_legacy(perf_link->legacy_name, perf_link->is_retprobe);
+
 	return libbpf_err(err);
 }
 
@@ -9009,6 +9059,9 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
 
+	if (perf_link->legacy_name)
+		free(perf_link->legacy_name);
+
 	free(perf_link);
 }
 
@@ -9122,6 +9175,26 @@ static int parse_uint_from_file(const char *file, const char *fmt)
 	return ret;
 }
 
+static bool determine_kprobe_legacy(void)
+{
+	const char *file = "/sys/bus/event_source/devices/kprobe/type";
+
+	return access(file, 0) == 0 ? false : true;
+}
+
+static int determine_kprobe_perf_type_legacy(const char *func_name, bool is_retprobe)
+{
+	char file[192];
+
+	const char *fname = "/sys/kernel/debug/tracing/events/%s/%s_libbpf_%d/id";
+
+	snprintf(file, sizeof(file), fname,
+		 is_retprobe ? "kretprobes" : "kprobes",
+		 func_name, getpid());
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
 static int determine_kprobe_perf_type(void)
 {
 	const char *file = "/sys/bus/event_source/devices/kprobe/type";
@@ -9197,6 +9270,41 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
+static int perf_event_kprobe_open_legacy(bool retprobe, const char *name, uint64_t offset, int pid)
+{
+	struct perf_event_attr attr = {};
+	char errmsg[STRERR_BUFSIZE];
+	int type, pfd, err;
+
+	err = add_kprobe_event_legacy(name, retprobe, offset);
+	if (err < 0) {
+		pr_warn("failed to add legacy kprobe event: %s\n",
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	type = determine_kprobe_perf_type_legacy(name, retprobe);
+	if (type < 0) {
+		pr_warn("failed to determine legacy kprobe event id: %s\n",
+			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+		return type;
+	}
+	attr.size = sizeof(attr);
+	attr.config = type;
+	attr.type = PERF_TYPE_TRACEPOINT;
+
+	pfd = syscall(__NR_perf_event_open, &attr,
+		      pid < 0 ? -1 : pid, /* pid */
+		      pid == -1 ? 0 : -1, /* cpu */
+		      -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
+	if (pfd < 0) {
+		err = -errno;
+		pr_warn("legacy kprobe perf_event_open() failed: %s\n",
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	return pfd;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 				const char *func_name,
@@ -9208,6 +9316,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	unsigned long offset;
 	bool retprobe;
 	int pfd, err;
+	bool legacy;
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -9216,8 +9325,16 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.user_ctx = OPTS_GET(opts, user_ctx, 0);
 
-	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
-				    offset, -1 /* pid */);
+	legacy = determine_kprobe_legacy();
+	if (!legacy) {
+		pfd = perf_event_open_probe(false /* uprobe */,
+					    retprobe, func_name,
+					    offset, -1 /* pid */);
+	} else {
+		pfd = perf_event_kprobe_open_legacy(retprobe, func_name,
+						    0 /* offset */,
+						   -1 /* pid */);
+	}
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
@@ -9233,6 +9350,12 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(err);
 	}
+	if (legacy) {
+		struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
+		perf_link->legacy_name = strdup(func_name);
+		perf_link->is_retprobe = retprobe;
+	}
+
 	return link;
 }
 
-- 
2.30.2

