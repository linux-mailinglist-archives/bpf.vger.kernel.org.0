Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352E681898
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbjA3ST6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbjA3STp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:45 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776A222FF
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:19:42 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m15so855934ilh.9
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6koqDjZbLyO9e1ckF7lYpikWSuT8kthbS112BT2kLaE=;
        b=ifDpYfM+MpeGfdjW6klRzaRavBq0sIIz7Hd2fiCXrFP8adChcc8SpalRsUjcXiMUGY
         fg8p0OrTwfF8K/d3G9n5y6vusimHlTbi3tbYVi3QhcqogijZ/OMtFjl1N3SoE+Arlli1
         qK76R8vQjsSbFi/RzLaVajjwIHuOl6vZugDTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6koqDjZbLyO9e1ckF7lYpikWSuT8kthbS112BT2kLaE=;
        b=zRiEiyZh5yxuzJMJt5nBmi6Z4ZOjQ+dhVirUr5g4DPKrwXxLCD6PTChlw0nYr+MFsZ
         EzHf4ElI21OTHeRRdMSasJf4rfbxj+k9PM6wszl5IqYzWoCQ5BE+CibpoWD+VXcyPU0i
         vWiUsC6BUHoXEwmKxuYmNLDPdq/3gtZlXw/1dnKWqDZWlejr7I63F/D4t6nIzCMa7aG7
         aWsBZ8z78PjYmKSdFRPyjzFZjYfnlDWTaE+6tuLruazH7zV1a3jVlYg8XoZ3G0J715mF
         GMh9SvyQPVm7YSzw4pHXYRPBzEieUnaaCyoIPXf53EbK0leKbs8Z5CMFdH7bMffp4uAp
         eCPQ==
X-Gm-Message-State: AO0yUKUSWZSb6eoPba6bKu/h+Ae6RcrV4EyxQOAVQ9d5tkk3JCbr6lhz
        9CpRGQjjoU4dvOg5F/lc4DfmLQ==
X-Google-Smtp-Source: AK7set8VCoxtmUCYeDMWu/WDVDGuySHRa2a43ZmUy9ljwyAym3RoiQUMue1sHzV4ZeKUz+/rB5U+5Q==
X-Received: by 2002:a05:6e02:170e:b0:310:ff6b:51d0 with SMTP id u14-20020a056e02170e00b00310ff6b51d0mr2347546ill.11.1675102782161;
        Mon, 30 Jan 2023 10:19:42 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:41 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, bpf@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH 2/9] bpf: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:08 -0700
Message-Id: <20230130181915.1113313-3-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Many comments and samples in the bpf code still refer to this older
debugfs path, so let's update them to avoid confusion.  There are a few
spots where the bpf code explicitly checks both tracefs and debugfs
(tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
those alone so that the tools can continue to work with both paths.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 include/uapi/linux/bpf.h            | 8 ++++----
 samples/bpf/cpustat_kern.c          | 4 ++--
 samples/bpf/hbm.c                   | 4 ++--
 samples/bpf/ibumad_kern.c           | 4 ++--
 samples/bpf/lwt_len_hist.sh         | 2 +-
 samples/bpf/offwaketime_kern.c      | 2 +-
 samples/bpf/task_fd_query_user.c    | 4 ++--
 samples/bpf/test_lwt_bpf.sh         | 2 +-
 samples/bpf/test_overhead_tp_kern.c | 4 ++--
 tools/include/uapi/linux/bpf.h      | 8 ++++----
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640ad2..9110163dfd70 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1634,17 +1634,17 @@ union bpf_attr {
  * 	Description
  * 		This helper is a "printk()-like" facility for debugging. It
  * 		prints a message defined by format *fmt* (of size *fmt_size*)
- * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
+ * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
  * 		limited to five).
  *
  * 		Each time the helper is called, it appends a line to the trace.
- * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
- * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
+ * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
+ * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
  * 		The format of the trace is customizable, and the exact output
  * 		one will get depends on the options set in
- * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
+ * 		*\/sys/kernel/tracing/trace_options* (see also the
  * 		*README* file under the same directory). However, it usually
  * 		defaults to something like:
  *
diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
index 5aefd19cdfa1..944f13fe164a 100644
--- a/samples/bpf/cpustat_kern.c
+++ b/samples/bpf/cpustat_kern.c
@@ -76,8 +76,8 @@ struct {
 
 /*
  * The trace events for cpu_idle and cpu_frequency are taken from:
- * /sys/kernel/debug/tracing/events/power/cpu_idle/format
- * /sys/kernel/debug/tracing/events/power/cpu_frequency/format
+ * /sys/kernel/tracing/events/power/cpu_idle/format
+ * /sys/kernel/tracing/events/power/cpu_frequency/format
  *
  * These two events have same format, so define one common structure.
  */
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 516fbac28b71..ff58ec43f56a 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -65,7 +65,7 @@ static void Usage(void);
 static void read_trace_pipe2(void);
 static void do_error(char *msg, bool errno_flag);
 
-#define DEBUGFS "/sys/kernel/debug/tracing/"
+#define TRACEFS "/sys/kernel/tracing/"
 
 static struct bpf_program *bpf_prog;
 static struct bpf_object *obj;
@@ -77,7 +77,7 @@ static void read_trace_pipe2(void)
 	FILE *outf;
 	char *outFname = "hbm_out.log";
 
-	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
+	trace_fd = open(TRACEFS "trace_pipe", O_RDONLY, 0);
 	if (trace_fd < 0) {
 		printf("Error opening trace_pipe\n");
 		return;
diff --git a/samples/bpf/ibumad_kern.c b/samples/bpf/ibumad_kern.c
index 9b193231024a..f07474c72525 100644
--- a/samples/bpf/ibumad_kern.c
+++ b/samples/bpf/ibumad_kern.c
@@ -39,8 +39,8 @@ struct {
 /* Taken from the current format defined in
  * include/trace/events/ib_umad.h
  * and
- * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_read/format
- * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_write/format
+ * /sys/kernel/tracing/events/ib_umad/ib_umad_read/format
+ * /sys/kernel/tracing/events/ib_umad/ib_umad_write/format
  */
 struct ib_umad_rw_args {
 	u64 pad;
diff --git a/samples/bpf/lwt_len_hist.sh b/samples/bpf/lwt_len_hist.sh
index 0eda9754f50b..11fa0a087db6 100755
--- a/samples/bpf/lwt_len_hist.sh
+++ b/samples/bpf/lwt_len_hist.sh
@@ -5,7 +5,7 @@ NS1=lwt_ns1
 VETH0=tst_lwt1a
 VETH1=tst_lwt1b
 
-TRACE_ROOT=/sys/kernel/debug/tracing
+TRACE_ROOT=/sys/kernel/tracing
 
 function cleanup {
 	# To reset saved histogram, remove pinned map
diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
index eb4d94742e6b..23f12b47e9e5 100644
--- a/samples/bpf/offwaketime_kern.c
+++ b/samples/bpf/offwaketime_kern.c
@@ -110,7 +110,7 @@ static inline int update_counts(void *ctx, u32 pid, u64 delta)
 }
 
 #if 1
-/* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
+/* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
 	char prev_comm[TASK_COMM_LEN];
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index a33d74bd3a4b..1e61f2180470 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -235,7 +235,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	struct bpf_link *link;
 	ssize_t bytes;
 
-	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/%s_events",
+	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/%s_events",
 		 event_type);
 	kfd = open(buf, O_WRONLY | O_TRUNC, 0);
 	CHECK_PERROR_RET(kfd < 0);
@@ -252,7 +252,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	close(kfd);
 	kfd = -1;
 
-	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/events/%ss/%s/id",
+	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/events/%ss/%s/id",
 		 event_type, event_alias);
 	efd = open(buf, O_RDONLY, 0);
 	CHECK_PERROR_RET(efd < 0);
diff --git a/samples/bpf/test_lwt_bpf.sh b/samples/bpf/test_lwt_bpf.sh
index 65a976058dd3..db5691e6637f 100755
--- a/samples/bpf/test_lwt_bpf.sh
+++ b/samples/bpf/test_lwt_bpf.sh
@@ -19,7 +19,7 @@ IPVETH3="192.168.111.2"
 
 IP_LOCAL="192.168.99.1"
 
-TRACE_ROOT=/sys/kernel/debug/tracing
+TRACE_ROOT=/sys/kernel/tracing
 
 function lookup_mac()
 {
diff --git a/samples/bpf/test_overhead_tp_kern.c b/samples/bpf/test_overhead_tp_kern.c
index 80edadacb692..a1d53b0d8476 100644
--- a/samples/bpf/test_overhead_tp_kern.c
+++ b/samples/bpf/test_overhead_tp_kern.c
@@ -8,7 +8,7 @@
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-/* from /sys/kernel/debug/tracing/events/task/task_rename/format */
+/* from /sys/kernel/tracing/events/task/task_rename/format */
 struct task_rename {
 	__u64 pad;
 	__u32 pid;
@@ -22,7 +22,7 @@ int prog(struct task_rename *ctx)
 	return 0;
 }
 
-/* from /sys/kernel/debug/tracing/events/random/urandom_read/format */
+/* from /sys/kernel/tracing/events/random/urandom_read/format */
 struct urandom_read {
 	__u64 pad;
 	int got_bits;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 51b9aa640ad2..9110163dfd70 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1634,17 +1634,17 @@ union bpf_attr {
  * 	Description
  * 		This helper is a "printk()-like" facility for debugging. It
  * 		prints a message defined by format *fmt* (of size *fmt_size*)
- * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
+ * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
  * 		limited to five).
  *
  * 		Each time the helper is called, it appends a line to the trace.
- * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
- * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
+ * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
+ * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
  * 		The format of the trace is customizable, and the exact output
  * 		one will get depends on the options set in
- * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
+ * 		*\/sys/kernel/tracing/trace_options* (see also the
  * 		*README* file under the same directory). However, it usually
  * 		defaults to something like:
  *
-- 
2.39.1.456.gfc5497dd1b-goog

