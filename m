Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFE3B3BB8
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 06:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFYErZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 00:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYErZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Jun 2021 00:47:25 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CCC061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 21:45:04 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m15so4552095qvc.9
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 21:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgCbpPmE0R9K+y4SzwV9wF0RRrmvvs/E6Wj/xmnh054=;
        b=JdFrnKimciFdo4Umf4jkKeJ36nhiCMvHLUTby+sudAGj++oG/7gXakYV5CEMJjU4Go
         eRMeb33UQ0LMz1RKNpeJyfhRtJIgFm/G8w2Jqjs1ew7VvSABHtuQGUaClX4tX5wESPke
         FgBg12yRWWdr0CgPrS07atL2zTx2/gX5H+ttW6fK7W24Mz1LeHsUAJj/VDDKcenvNlmr
         1zzA/jq0ISKp93viiSQLfF4/ntXAIaWLQKGb/n7MG8RRnaxxfJ/Qbn3PtIbl0SGZv3kf
         V7xtcpjlQM0Zz6iNalT8XijWY8LALBNG0BSPsrzpZcpOKYL6cs7GHVqx4EAUyGUyrDh3
         jFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgCbpPmE0R9K+y4SzwV9wF0RRrmvvs/E6Wj/xmnh054=;
        b=GTYxyOinsEKKsIK2OvFcndrR3GBSbD7+YTeSK205no9b88VtCRiaIB8sXh/mgkvKj8
         ieiJqLZxRI7igpqw2ldUoXIn95VHDUoXCHHYfgynvaDO7OpltE9cyBNp5i6tRDm6A8/P
         WLfu7i1D7HCK1wvF3F1JiNbkPUhJjoU5HRE7w7KF0Somf33dAJgyxejAfOiBweQlQnJn
         UUwXzQ+wpDnbbUo3RxbLNZy0oQLHQo1bqCsRdxIvFOVJ1A90aScacLAddlhzK69GEzfK
         4MAR6VU6PeMK3SVsazPjGoZVuUuIN3Dv786zQj/fULvzr2SP1czbOzcqBhXWQ3K4fgDt
         +/lw==
X-Gm-Message-State: AOAM5319GPxKkSmONL2t748OpXMvTA4hlgIG6siUX4tZ3aCHPOyyajtk
        xOPVOE/O58byAMCeQN9bYw/9usc/whPI
X-Google-Smtp-Source: ABdhPJxORvaf3lt4OakKxiGL8t2PV9pWZt3K5ktCL4WsTkibaT4UJw5KO1ZfrC66Jek88UZdprwqxw==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr8875482qvi.44.1624596303225;
        Thu, 24 Jun 2021 21:45:03 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([191.177.175.120])
        by smtp.gmail.com with ESMTPSA id q2sm4168752qkc.77.2021.06.24.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 21:45:02 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
To:     bpf@vger.kernel.org
Cc:     rafaeldtinoco@gmail.com, andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v3] libbpf: introduce legacy kprobe events support
Date:   Fri, 25 Jun 2021 01:44:59 -0300
Message-Id: <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow kprobe tracepoint events creation through legacy interface, as the
kprobe dynamic PMUs support, used by default, was only created in v4.17.

This enables CO.RE support for older kernels.

Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
---
 tools/lib/bpf/libbpf.c | 125 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..72a22c4d8295 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10007,6 +10007,10 @@ struct bpf_link {
 	char *pin_path;		/* NULL, if not pinned */
 	int fd;			/* hook FD, -1 if not applicable */
 	bool disconnected;
+	struct {
+		char *name;
+		bool retprobe;
+	} legacy;
 };
 
 /* Replace link's underlying BPF program with the new one */
@@ -10143,6 +10147,47 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
+static int poke_kprobe_events(bool add, const char *name, bool retprobe)
+{
+	int fd, ret = 0;
+	char probename[32], cmd[160];
+	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+
+	memset(probename, 0, sizeof(probename));
+
+	if (retprobe)
+		ret = snprintf(probename, sizeof(probename), "kprobes/%s_ret", name);
+	else
+		ret = snprintf(probename, sizeof(probename), "kprobes/%s", name);
+
+	if (ret <= strlen("kprobes/"))
+		return -EINVAL;
+
+	if (add)
+		snprintf(cmd, sizeof(cmd),"%c:%s %s", retprobe ? 'r' : 'p', probename, name);
+	else
+		snprintf(cmd, sizeof(cmd), "-:%s", probename);
+
+	if (!(fd = open(file, O_WRONLY|O_APPEND, 0)))
+		return -errno;
+	if ((ret = write(fd, cmd, strlen(cmd))) < 0)
+		ret = -errno;
+
+	close(fd);
+
+	return ret;
+}
+
+static inline int add_kprobe_event_legacy(const char* name, bool retprobe)
+{
+	return poke_kprobe_events(true, name, retprobe);
+}
+
+static inline int remove_kprobe_event_legacy(const char* name, bool retprobe)
+{
+	return poke_kprobe_events(false, name, retprobe);
+}
+
 static int bpf_link__detach_perf_event(struct bpf_link *link)
 {
 	int err;
@@ -10152,6 +10197,12 @@ static int bpf_link__detach_perf_event(struct bpf_link *link)
 		err = -errno;
 
 	close(link->fd);
+
+	if (link->legacy.name) {
+		remove_kprobe_event_legacy(link->legacy.name, link->legacy.retprobe);
+		free(link->legacy.name);
+	}
+
 	return libbpf_err(err);
 }
 
@@ -10229,6 +10280,23 @@ static int parse_uint_from_file(const char *file, const char *fmt)
 	return ret;
 }
 
+static bool determine_kprobe_legacy(void)
+{
+	const char *file = "/sys/bus/event_source/devices/kprobe/type";
+
+	return access(file, 0) == 0 ? false : true;
+}
+
+static int determine_kprobe_perf_type_legacy(const char *func_name)
+{
+	char file[96];
+	const char *fname = "/sys/kernel/debug/tracing/events/kprobes/%s/id";
+
+	snprintf(file, sizeof(file), fname, func_name);
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
 static int determine_kprobe_perf_type(void)
 {
 	const char *file = "/sys/bus/event_source/devices/kprobe/type";
@@ -10304,6 +10372,43 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
+static int perf_event_open_probe_legacy(bool uprobe, bool retprobe, const char *name,
+					uint64_t offset, int pid)
+{
+	struct perf_event_attr attr = {};
+	char errmsg[STRERR_BUFSIZE];
+	int type, pfd, err;
+
+	if (uprobe) // unsupported
+		return -EINVAL;
+
+	if ((err = add_kprobe_event_legacy(name, retprobe)) < 0) {
+		pr_warn("failed to add legacy kprobe event: %s\n",
+		libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		return err;
+	}
+	if ((type = determine_kprobe_perf_type_legacy(name)) < 0) {
+		pr_warn("failed to determine legacy kprobe event id: %s\n",
+		libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
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
 struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 					    bool retprobe,
 					    const char *func_name)
@@ -10311,9 +10416,18 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
+	bool legacy = false;
 
-	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
-				    0 /* offset */, -1 /* pid */);
+	if (!(legacy = determine_kprobe_legacy()))
+		pfd = perf_event_open_probe(false /* uprobe */,
+					    retprobe, func_name,
+					     0 /* offset */,
+					    -1 /* pid */);
+	else
+		pfd = perf_event_open_probe_legacy(false /* uprobe */,
+					    retprobe, func_name,
+					     0 /* offset */,
+					    -1 /* pid */);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
@@ -10329,6 +10443,13 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(err);
 	}
+
+	if (legacy) {
+		/* needed history for the legacy probe cleanup */
+		link->legacy.name = strdup(func_name);
+		link->legacy.retprobe = retprobe;
+	}
+
 	return link;
 }
 
-- 
2.27.0

