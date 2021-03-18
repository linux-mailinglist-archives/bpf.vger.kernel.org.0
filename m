Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B6F33FF81
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 07:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCRGZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 02:25:46 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35866 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCRGZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 02:25:25 -0400
Received: by mail-qk1-f177.google.com with SMTP id n79so995941qke.3
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkA5vz1PcvRfiWqET79I8fLN+sCtVUmZ1qgcwklJSZc=;
        b=E76zpX48TVfabUyZ+fgQYnuO8E6EZ+GlbUhZ2qFl9E9l1mhU3wC5tjdgA7vEi7l5Bp
         CC/ue0zs6Zeo6sOKkGB18DrxGCJ+ZTGwsK8GC5ruNEMFfuyO4NX71yghBevD+EW7TCLu
         ZWnCMGhMmJtMakQWEj6JHCn4P2MYve5m49b3+UNA5Ow3HLuYrlucJBHF8NISSiCoyzWO
         1hhokuGAwg5Iymi+7wc9a0Rl+OcqRJie7JZIsLL3l9apk5HTrH4bdn+h1MXObXTTtQAU
         rWF5smN/ST/proIVFeFq+gDQh5JQlpcb7DDsQPqJ8XxgKg01lR/zMVvtdS7rT/A04RVU
         JgIA==
X-Gm-Message-State: AOAM531fWiu3+T6uZlTiGyXGiCkdecHYz5A0vvPE/JyeNaqrAHGOxB6I
        6wGRZ2UkiMmB/PmwyMKOv9HExzahShYwPuY=
X-Google-Smtp-Source: ABdhPJzTGjp2xULOC1qEnTOy43xOZM6u+ahp+tCTgzA7j95hmvO639XnUSEccsReGKwmXJIPDTmY3A==
X-Received: by 2002:a05:620a:954:: with SMTP id w20mr2946412qkw.208.1616048724873;
        Wed, 17 Mar 2021 23:25:24 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id h11sm819327qtp.24.2021.03.17.23.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:25:24 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     andrii.nakryiko@gmail.com
Cc:     rafaeldtinoco@ubuntu.com, bpf@vger.kernel.org
Subject: [RFC][PATCH] libbpf: support kprobe/kretprobe events in legacy environments
Date:   Thu, 18 Mar 2021 03:25:20 -0300
Message-Id: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 * Request for comments version (still needs polishing).
 * Based on Andrii Nakryiko's suggestion.
 * Using bpf_program__set_priv in attach_kprobe() for kprobe cleanup.

Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
---
 src/libbpf.c | 100 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 2f351d3..4dc09d3 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -9677,8 +9677,14 @@ static int parse_uint_from_file(const char *file, const char *fmt)
 
 static int determine_kprobe_perf_type(void)
 {
+	int ret = 0;
+	struct stat s;
 	const char *file = "/sys/bus/event_source/devices/kprobe/type";
 
+	ret = stat(file, &s);
+	if (ret < 0)
+		return -errno;
+
 	return parse_uint_from_file(file, "%d\n");
 }
 
@@ -9703,25 +9709,87 @@ static int determine_uprobe_retprobe_bit(void)
 	return parse_uint_from_file(file, "config:%d\n");
 }
 
+static int determine_kprobe_perf_type_legacy(const char *func_name)
+{
+	char file[256];
+	const char *fname = "/sys/kernel/debug/tracing/events/kprobes/%s/id";
+
+	snprintf(file, sizeof(file), fname, func_name);
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int poke_kprobe_events(bool add, const char *name, bool kretprobe)
+{
+	int fd, ret = 0;
+	char given[256], buf[256];
+	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+
+	if (kretprobe && add)
+		snprintf(given, sizeof(given), "kprobes/%s_ret", name);
+	else
+		snprintf(given, sizeof(given), "kprobes/%s", name);
+	if (add)
+		snprintf(buf, sizeof(buf),"%c:%s %s\n", kretprobe ? 'r' : 'p', given, name);
+	else
+		snprintf(buf, sizeof(buf), "-:%s\n", given);
+
+	fd = open(file, O_WRONLY|O_APPEND, 0);
+	if (!fd)
+		return -errno;
+	ret = write(fd, buf, strlen(buf));
+	if (ret < 0) {
+		ret = -errno;
+	}
+	close(fd);
+
+	return ret;
+}
+
+static inline int add_kprobe_event_legacy(const char* func_name, bool kretprobe)
+{
+	return poke_kprobe_events(true /*add*/, func_name, kretprobe);
+}
+
+static inline int remove_kprobe_event_legacy(const char* func_name, bool kretprobe)
+{
+	return poke_kprobe_events(false /*remove*/, func_name, kretprobe);
+}
+
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 				 uint64_t offset, int pid)
 {
 	struct perf_event_attr attr = {};
 	char errmsg[STRERR_BUFSIZE];
 	int type, pfd, err;
+	bool legacy = false;
 
 	type = uprobe ? determine_uprobe_perf_type()
 		      : determine_kprobe_perf_type();
 	if (type < 0) {
-		pr_warn("failed to determine %s perf type: %s\n",
-			uprobe ? "uprobe" : "kprobe",
-			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
-		return type;
+		if (uprobe) {
+			pr_warn("failed to determine %s perf type: %s\n",
+				uprobe ? "uprobe" : "kprobe",
+				libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+			return type;
+		}
+		err = add_kprobe_event_legacy(name, retprobe);
+		if (err < 0) {
+			pr_warn("failed to add legacy kprobe events: %s\n",
+				libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			return err;
+		}
+		type = uprobe ? type : determine_kprobe_perf_type_legacy(name);
+		if (type < 0) {
+			remove_kprobe_event_legacy(name, retprobe);
+			pr_warn("failed to determine kprobe perf type: %s\n",
+				libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+		}
+		legacy = true;
 	}
-	if (retprobe) {
+	if (retprobe && !legacy) {
 		int bit = uprobe ? determine_uprobe_retprobe_bit()
 				 : determine_kprobe_retprobe_bit();
-
 		if (bit < 0) {
 			pr_warn("failed to determine %s retprobe bit: %s\n",
 				uprobe ? "uprobe" : "kprobe",
@@ -9731,10 +9799,14 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 		attr.config |= 1 << bit;
 	}
 	attr.size = sizeof(attr);
-	attr.type = type;
-	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
-	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
-
+	if (!legacy) {
+		attr.type = type;
+		attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
+		attr.config2 = offset;		 /* kprobe_addr or probe_offset */
+	} else {
+		attr.config = type;
+		attr.type = PERF_TYPE_TRACEPOINT;
+	}
 	/* pid filter is meaningful only for uprobes */
 	pfd = syscall(__NR_perf_event_open, &attr,
 		      pid < 0 ? -1 : pid /* pid */,
@@ -9750,6 +9822,11 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
+void bpf_program__detach_kprobe_legacy(struct bpf_program *prog, void *retprobe)
+{
+	remove_kprobe_event_legacy(prog->name, (bool) retprobe);
+}
+
 struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 					    bool retprobe,
 					    const char *func_name)
@@ -9766,6 +9843,9 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(pfd);
 	}
+
+	bpf_program__set_priv(prog, (void *) retprobe, bpf_program__detach_kprobe_legacy);
+
 	link = bpf_program__attach_perf_event(prog, pfd);
 	if (IS_ERR(link)) {
 		close(pfd);
-- 
2.27.0

