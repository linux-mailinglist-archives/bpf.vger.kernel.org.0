Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A06407C13
	for <lists+bpf@lfdr.de>; Sun, 12 Sep 2021 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhILGuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhILGuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Sep 2021 02:50:04 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3AC061574
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 23:48:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id r18so4122091qvy.8
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqA+GhTdKgbP5iwEJTrX5RyHbopdafyDd8DR8CnqJjU=;
        b=k5wnAcwn4UtzfKry4XI1YoeKuzwHgSQgTCKSlZOiGn37VXaVA0Mciy7rzOxY3te+VP
         DRyZ8qppJR5uPWv3HHAEjheljFXry7oGtFHfw/+L7r+h04uxvNgvMRhKCeSO9HooIDsL
         eIWSx2CGfHMJCdV93NEykf8puhoti+VlxLgEVD+bDh1Cvr1Vzk+3gcD51xihrM/4oTii
         4Cuhk0DchjENlaY+PaRXUD4RQNnUL8qOaZjiFYFNlknVLlMG9pFNxI/7m8sjXu/kXVr6
         gEd+1AmNuXyACpsraA6YqClX1pIDE5la0k+JtY7dkQi3F+gcP2YFFiu1aN+55RAsccp4
         IMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqA+GhTdKgbP5iwEJTrX5RyHbopdafyDd8DR8CnqJjU=;
        b=Xc8HO+o2/Ut/HlMEbyW/qKGNj494EjfdzCHrBgyt23ENyt4YaeQ9n79ecXoU4IO121
         n8K0PTohQ6hh681AUKk9naxgqHfU5YMWA9apOQT4inMFU0jEZIcme7N9o7FZ2NG5tp1k
         wh5OMofqwaFzIhyVE3lICWuWTXPaaX5K1muXu300m3Q/tjZT+nczUP3w6IKBOGP6MX3V
         pJW5uX6TJyIS67oowNNYzzt/dgLyuDyVyx3Hl7P+Kl9uhbQgkiGG3vVLusnv1o4fHBNa
         yxT6o3YQ0I4cinkJs/yfQdOexJZtafhoHbJ2YGuOB0ciFbVqcHSVkk7A4FGpC+cSzNEj
         CPdQ==
X-Gm-Message-State: AOAM530X+qGD0QcGyluHic1hQb/1YOojEjV7rMqWt+SKJppyNJWQ4QWn
        rC/8iTuWRY1HbNWUX/YdjOtDBp+AlH8heCU=
X-Google-Smtp-Source: ABdhPJy3tI7USkFQRaPkBlRSszbH0MnwZ+4Mp50phvNRH5xQmujgmo0rkq08CDj7MJc6U4FYUk1j+g==
X-Received: by 2002:a0c:fb4f:: with SMTP id b15mr4942196qvq.20.1631429328288;
        Sat, 11 Sep 2021 23:48:48 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([185.153.176.244])
        by smtp.gmail.com with ESMTPSA id 21sm2720803qkk.51.2021.09.11.23.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 23:48:47 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com, rafaeldtinoco@gmail.com
Subject: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events support
Date:   Sun, 12 Sep 2021 03:48:44 -0300
Message-Id: <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
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

This enables CO-RE support for older kernels.

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
---
 tools/lib/bpf/libbpf.c | 141 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..780a45e54572 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8987,9 +8987,57 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
+static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset)
+{
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
+	/* legacy kprobe support: keep track of probe identifier and type */
+	char *legacy_probe_name;
+	bool legacy_is_retprobe;
 };
 
 static int bpf_link_perf_detach(struct bpf_link *link)
@@ -8997,20 +9045,26 @@ static int bpf_link_perf_detach(struct bpf_link *link)
 	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
 	int err = 0;
 
-	if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
-		err = -errno;
+	ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0);
 
 	if (perf_link->perf_event_fd != link->fd)
 		close(perf_link->perf_event_fd);
 	close(link->fd);
 
-	return libbpf_err(err);
+	/* legacy kprobe needs to be removed after perf event fd closure */
+	if (perf_link->legacy_probe_name) {
+		err = remove_kprobe_event_legacy(perf_link->legacy_probe_name,
+						 perf_link->legacy_is_retprobe);
+	}
+
+	return err;
 }
 
 static void bpf_link_perf_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
 
+	free(perf_link->legacy_probe_name);
 	free(perf_link);
 }
 
@@ -9124,6 +9178,25 @@ static int parse_uint_from_file(const char *file, const char *fmt)
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
@@ -9206,6 +9279,41 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
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
@@ -9215,8 +9323,9 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	unsigned long offset;
-	bool retprobe;
+	bool retprobe, legacy;
 	int pfd, err;
+	char *legacy_probe = NULL;
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -9225,8 +9334,21 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
-	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
-				    offset, -1 /* pid */, 0 /* ref_ctr_off */);
+	legacy = determine_kprobe_legacy();
+	if (!legacy) {
+		pfd = perf_event_open_probe(false /* uprobe */,
+					    retprobe, func_name,
+					    offset, -1 /* pid */,
+					    0 /* ref_ctr_off */);
+	} else {
+		legacy_probe = strdup(func_name);
+		err = libbpf_get_error(legacy_probe);
+		if (err)
+			return libbpf_err_ptr(err);
+		pfd = perf_event_kprobe_open_legacy(retprobe, func_name,
+						   0 /* offset */,
+						   -1 /* pid */);
+	}
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
@@ -9242,6 +9364,13 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(err);
 	}
+	if (legacy) {
+		struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
+
+		perf_link->legacy_probe_name = legacy_probe;
+		perf_link->legacy_is_retprobe = retprobe;
+	}
+
 	return link;
 }
 
-- 
2.30.2

