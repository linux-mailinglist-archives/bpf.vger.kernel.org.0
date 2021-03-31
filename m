Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98DA344E17
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCVSFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:05:12 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42954 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCVSEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 14:04:46 -0400
Received: by mail-qt1-f175.google.com with SMTP id l13so13008737qtu.9
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 11:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olQWIMUZG9qgET1dHBLA9f3bnTpqRuTjzf8QHH4eIFU=;
        b=mWF6x8FwMmfFVWEgos7p3KE+T6evbQPyqy/Q3ObklIaYug6X/TE4Vzwc/bSI5OxQrp
         6iyYTgAp3qokicSdPhaBwBa1B909c2TwXX+87IW7sMzHz7v9n3FE3qhIKtfqLKkbwfu5
         OecAVwuqJek5IMAt4Wz0+cXPUWhNIOb2Rk2d8lc+wWpHBxxdZ0zeBF7bHDRbo60yyWHa
         l/tvqGhw1O4RgGnNeS9rb5S91JmhTEVRE/KUTeppjxV543MKP34rIaAn06nVWLXVi/SM
         NFfNSIWbLjXvkGZ4RTgkFWXLEmPYw+vqZnUA9pMO7bzT6F7MLmxTexX6VJRGrkYgYMvY
         jatg==
X-Gm-Message-State: AOAM533d9Mwbuyc9JJeuN6pPo8M4z7wyFsRirH01Xf0MFniITNS7aZoJ
        wRUByL+HB9xqtEOHFxvYxO/SNy03pr8BHqI=
X-Google-Smtp-Source: ABdhPJyw897UtjYquWixQpAj/aya9p13Yups/w1qbBUyJZmBl/P1tjzRHVkKNkp9nrKsjZ0Fn6foZg==
X-Received: by 2002:ac8:6ede:: with SMTP id f30mr1020278qtv.275.1616436285968;
        Mon, 22 Mar 2021 11:04:45 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id l186sm11318867qke.92.2021.03.22.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:04:45 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, rafaeldtinoco@ubuntu.com
Subject: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events support
Date:   Mon, 22 Mar 2021 15:04:41 -0300
Message-Id: <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

- This is a RFC (v2).
- Please check my reply with inline comments.
---
 src/libbpf.c | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 357 insertions(+), 5 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 3b1c79f..e9c6025 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -9465,6 +9465,10 @@ struct bpf_link {
 	char *pin_path;		/* NULL, if not pinned */
 	int fd;			/* hook FD, -1 if not applicable */
 	bool disconnected;
+	struct {
+		const char *name;
+		bool retprobe;
+	} legacy;
 };
 
 /* Replace link's underlying BPF program with the new one */
@@ -9501,6 +9505,7 @@ int bpf_link__destroy(struct bpf_link *link)
 		link->destroy(link);
 	if (link->pin_path)
 		free(link->pin_path);
+
 	free(link);
 
 	return err;
@@ -9598,6 +9603,8 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
+static inline int remove_kprobe_event_legacy(const char*, bool);
+
 static int bpf_link__detach_perf_event(struct bpf_link *link)
 {
 	int err;
@@ -9605,8 +9612,25 @@ static int bpf_link__detach_perf_event(struct bpf_link *link)
 	err = ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
 	if (err)
 		err = -errno;
-
 	close(link->fd);
+
+	return err;
+}
+
+static int bpf_link__detach_perf_event_legacy(struct bpf_link *link)
+{
+	int err;
+
+	err = bpf_link__detach_perf_event(link);
+	if (err)
+		err = -errno; // improve this
+
+	/*
+	err = remove_kprobe_event_legacy(link->legacy.name, link->legacy.retprobe);
+	if (err)
+		err = -errno;
+	 */
+
 	return err;
 }
 
@@ -9655,6 +9679,48 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_perf_event_legacy(struct bpf_program *prog,
+						       int pfd)
+{
+	char errmsg[STRERR_BUFSIZE];
+	struct bpf_link *link;
+	int prog_fd, err;
+
+	if (pfd < 0) {
+		pr_warn("prog '%s': invalid perf event FD %d\n", prog->name, pfd);
+		return ERR_PTR(-EINVAL);
+	}
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n", prog->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return ERR_PTR(-ENOMEM);
+
+	link->detach = &bpf_link__detach_perf_event_legacy;
+	link->fd = pfd;
+
+	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
+		err = -errno;
+		free(link);
+		pr_warn("prog '%s': failed to attach to pfd %d: %s\n", prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		if (err == -EPROTO)
+			pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n", prog->name, pfd);
+		return ERR_PTR(err);
+	}
+	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+		err = -errno;
+		free(link);
+		pr_warn("prog '%s': failed to enable pfd %d: %s\n", prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return ERR_PTR(err);
+	}
+
+	return link;
+}
+
 /*
  * this function is expected to parse integer in the range of [0, 2^31-1] from
  * given file using scanf format string fmt. If actual parsed value is
@@ -9685,34 +9751,242 @@ static int parse_uint_from_file(const char *file, const char *fmt)
 	return ret;
 }
 
+static int write_uint_to_file(const char *file, unsigned int val)
+{
+	char buf[STRERR_BUFSIZE];
+	int err;
+	FILE *f;
+
+	f = fopen(file, "w");
+	if (!f) {
+		err = -errno;
+		pr_debug("failed to open '%s': %s\n", file,
+			 libbpf_strerror_r(err, buf, sizeof(buf)));
+		return err;
+	}
+	err = fprintf(f, "%u", val);
+	if (err != 1) {
+		err = -errno;
+		pr_debug("failed to write '%u' to '%s': %s\n", val, file,
+			libbpf_strerror_r(err, buf, sizeof(buf)));
+		fclose(f);
+		return err;
+	}
+	fclose(f);
+	return 0;
+}
+
+#define KPROBE_PERF_TYPE	"/sys/bus/event_source/devices/kprobe/type"
+#define UPROBE_PERF_TYPE	"/sys/bus/event_source/devices/uprobe/type"
+#define KPROBERET_FORMAT	"/sys/bus/event_source/devices/kprobe/format/retprobe"
+#define UPROBERET_FORMAT	"/sys/bus/event_source/devices/uprobe/format/retprobe"
+/* legacy kprobe events related files */
+#define KPROBE_EVENTS		"/sys/kernel/debug/tracing/kprobe_events"
+#define KPROBE_LEG_TOGGLE	"/sys/kernel/debug/kprobes/enabled"
+#define KPROBE_LEG_ALL_TOGGLE	"/sys/kernel/debug/tracing/events/kprobes/enable";
+#define KPROBE_SINGLE_TOGGLE	"/sys/kernel/debug/tracing/events/kprobes/%s/enable";
+#define KPROBE_EVENT_ID		"/sys/kernel/debug/tracing/events/kprobes/%s/id";
+
+static bool determine_kprobe_legacy(void)
+{
+	struct stat s;
+
+	return stat(KPROBE_PERF_TYPE, &s) == 0 ? false : true;
+}
+
 static int determine_kprobe_perf_type(void)
 {
-	const char *file = "/sys/bus/event_source/devices/kprobe/type";
+	const char *file = KPROBE_PERF_TYPE;
 
 	return parse_uint_from_file(file, "%d\n");
 }
 
 static int determine_uprobe_perf_type(void)
 {
-	const char *file = "/sys/bus/event_source/devices/uprobe/type";
+	const char *file = UPROBE_PERF_TYPE;
 
 	return parse_uint_from_file(file, "%d\n");
 }
 
 static int determine_kprobe_retprobe_bit(void)
 {
-	const char *file = "/sys/bus/event_source/devices/kprobe/format/retprobe";
+	const char *file = KPROBERET_FORMAT;
 
 	return parse_uint_from_file(file, "config:%d\n");
 }
 
 static int determine_uprobe_retprobe_bit(void)
 {
-	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
+	const char *file = UPROBERET_FORMAT;
 
 	return parse_uint_from_file(file, "config:%d\n");
 }
 
+static int toggle_kprobe_legacy(bool on)
+{
+	static int refcount;
+	static bool initial, veryfirst;
+	const char *file = KPROBE_LEG_TOGGLE;
+
+	if (on) {
+		refcount++;
+		if (veryfirst)
+			return 0;
+		veryfirst = true;
+		/* initial value for KPROB_LEG_TOGGLE */
+		initial = (bool) parse_uint_from_file(file, "%d\n");
+		return write_uint_to_file(file, 1); /* enable kprobes */
+	}
+	refcount--;
+	printf("DEBUG: kprobe_legacy refcount=%d\n", refcount);
+	if (refcount == 0) {
+		/* off ret value back to initial value if last consumer */
+		return write_uint_to_file(file, initial);
+	}
+	return 0;
+}
+
+static int toggle_kprobe_event_legacy_all(bool on)
+{
+	static int refcount;
+	static bool initial, veryfirst;
+	const char *file = KPROBE_LEG_ALL_TOGGLE;
+
+	if (on) {
+		refcount++;
+		if (veryfirst)
+			return 0;
+		veryfirst = true;
+		// initial value for KPROB_LEG_ALL_TOGGLE
+		initial = (bool) parse_uint_from_file(file, "%d\n");
+		return write_uint_to_file(file, 1); // enable kprobes
+	}
+	refcount--;
+	printf("DEBUG: legacy_all refcount=%d\n", refcount);
+	if (refcount == 0) {
+		// off ret value back to initial value if last consumer
+		return write_uint_to_file(file, initial);
+	}
+	return 0;
+}
+
+static int kprobe_event_normalize(char *newname, size_t size, const char *name, bool retprobe)
+{
+	int ret = 0;
+
+	if (IS_ERR(name))
+		return -1;
+
+	if (retprobe)
+		ret = snprintf(newname, size, "kprobes/%s_ret", name);
+	else
+		ret = snprintf(newname, size, "kprobes/%s", name);
+
+	if (ret <= strlen("kprobes/"))
+		ret = -errno;
+
+	return ret;
+}
+
+static int toggle_single_kprobe_event_legacy(bool on, const char *name, bool retprobe)
+{
+	char probename[32], f[96];
+	const char *file = KPROBE_SINGLE_TOGGLE;
+	int ret;
+
+	ret = kprobe_event_normalize(probename, sizeof(probename), name, retprobe);
+	if (ret < 0)
+		return ret;
+
+	snprintf(f, sizeof(f), file, probename + strlen("kprobes/"));
+
+	printf("DEBUG: writing %u to %s\n", (unsigned int) on, f);
+
+	ret = write_uint_to_file(f, (unsigned int) on);
+
+	return ret;
+}
+
+static int poke_kprobe_events(bool add, const char *name, bool retprobe)
+{
+	int fd, ret = 0;
+	char probename[32], cmd[96];
+	const char *file = KPROBE_EVENTS;
+
+	ret = kprobe_event_normalize(probename, sizeof(probename), name, retprobe);
+	if (ret < 0)
+		return ret;
+
+	if (add)
+		snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p', probename, name);
+	else
+		snprintf(cmd, sizeof(cmd), "-:%s", probename);
+
+	printf("DEBUG: %s\n", cmd);
+
+	fd = open(file, O_WRONLY|O_APPEND, 0);
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
+static inline int add_kprobe_event_legacy(const char* func_name, bool retprobe)
+{
+	int ret = 0;
+
+	ret = poke_kprobe_events(true, func_name, retprobe);
+	if (ret < 0)
+		printf("DEBUG: poke_kprobe_events (on) error\n");
+
+	ret = toggle_kprobe_event_legacy_all(true);
+	if (ret < 0)
+		printf("DEBUG: toggle_kprobe_event_legacy_all (on) error\n");
+
+	ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
+	if (ret < 0)
+		printf("DEBUG: toggle_single_kprobe_event_legacy (on) error\n");
+
+	return ret;
+}
+
+static inline int remove_kprobe_event_legacy(const char* func_name, bool retprobe)
+{
+	int ret = 0;
+
+	ret = toggle_kprobe_event_legacy_all(true);
+	if (ret < 0)
+		printf("DEBUG: toggle_kprobe_event_legacy_all (off) error\n");
+
+	ret = toggle_single_kprobe_event_legacy(true, func_name, retprobe);
+	if (ret < 0)
+		printf("DEBUG: toggle_single_kprobe_event_legacy (off) error\n");
+
+	ret = toggle_single_kprobe_event_legacy(false, func_name, retprobe);
+	if (ret < 0)
+		printf("DEBUG: toggle_single_kprobe_event_legacy (off) error\n");
+
+	ret = poke_kprobe_events(false, func_name, retprobe);
+	if (ret < 0)
+		printf("DEBUG: poke_kprobe_events (off) error\n");
+
+	return ret;
+}
+
+static int determine_kprobe_perf_type_legacy(const char *func_name)
+{
+	char file[96];
+	const char *fname = KPROBE_EVENT_ID;
+
+	snprintf(file, sizeof(file), fname, func_name);
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 				 uint64_t offset, int pid)
 {
@@ -9760,6 +10034,51 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
+static int perf_event_open_probe_legacy(bool uprobe, bool retprobe, const char *name,
+					uint64_t offset, int pid)
+{
+	struct perf_event_attr attr = {};
+	char errmsg[STRERR_BUFSIZE];
+	int type, pfd, err;
+
+	if (uprobe) // legacy uprobe not supported yet
+		return -1;
+
+	err = toggle_kprobe_legacy(true);
+	if (err < 0) {
+		pr_warn("failed to toggle kprobe legacy support: %s\n", libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	err = add_kprobe_event_legacy(name, retprobe);
+	if (err < 0) {
+		pr_warn("failed to add legacy kprobe event: %s\n", libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	type = determine_kprobe_perf_type_legacy(name);
+	if (err < 0) {
+		pr_warn("failed to determine legacy kprobe event id: %s\n", libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+		return type;
+	}
+
+	attr.size = sizeof(attr);
+	attr.config = type;
+	attr.type = PERF_TYPE_TRACEPOINT;
+
+	pfd = syscall(__NR_perf_event_open,
+		      &attr,
+		      pid < 0 ? -1 : pid,
+		      pid == -1 ? 0 : -1,
+		      -1,
+		      PERF_FLAG_FD_CLOEXEC);
+
+	if (pfd < 0) {
+		err = -errno;
+		pr_warn("legacy kprobe perf_event_open() failed: %s\n", libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	return pfd;
+}
+
 struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 					    bool retprobe,
 					    const char *func_name)
@@ -9788,6 +10107,33 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_kprobe_legacy(struct bpf_program *prog,
+						   bool retprobe,
+						   const char *func_name)
+{
+	char errmsg[STRERR_BUFSIZE];
+	struct bpf_link *link;
+	int pfd, err;
+
+	pfd = perf_event_open_probe_legacy(false, retprobe, func_name, 0, -1);
+	if (pfd < 0) {
+		pr_warn("prog '%s': failed to create %s '%s' legacy perf event: %s\n", prog->name, retprobe ? "kretprobe" : "kprobe", func_name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		return ERR_PTR(pfd);
+	}
+	link = bpf_program__attach_perf_event_legacy(prog, pfd);
+	if (IS_ERR(link)) {
+		close(pfd);
+		err = PTR_ERR(link);
+		pr_warn("prog '%s': failed to attach to %s '%s': %s\n", prog->name, retprobe ? "kretprobe" : "kprobe", func_name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return link;
+	}
+	/* needed history for the legacy probe cleanup */
+	link->legacy.name = func_name;
+	link->legacy.retprobe = retprobe;
+
+	return link;
+}
+
 static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog)
 {
@@ -9797,6 +10143,9 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 	func_name = prog->sec_name + sec->len;
 	retprobe = strcmp(sec->sec, "kretprobe/") == 0;
 
+	if(determine_kprobe_legacy())
+		return bpf_program__attach_kprobe_legacy(prog, retprobe, func_name);
+
 	return bpf_program__attach_kprobe(prog, retprobe, func_name);
 }
 
@@ -11280,4 +11629,7 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->maps);
 	free(s->progs);
 	free(s);
+
+	remove_kprobe_event_legacy("ip_set_create", false);
+	remove_kprobe_event_legacy("ip_set_create", true);
 }
-- 
2.17.1

