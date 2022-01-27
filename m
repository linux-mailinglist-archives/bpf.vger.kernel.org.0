Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9049DC89
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiA0I10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 03:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiA0I1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 03:27:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE1C061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 00:27:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso5361696wmj.0
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 00:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeXbPjradQzO8cghCb/hmFsD1HUCFpYS4RMbao56xvk=;
        b=YF4QYUOLAbgmq8opLdFrjcrQJXO4/urNoiv+Z2rKM7iOUj22DQKXCTf1St3aPctczt
         ELuPVU6HhOzuObw4/8gdtRqfE/XN1owMtA8tRiLVWN5YLWh0my0T52u+RRmdf/YS4eR5
         b9ytkRaAWZ9dtZVxXexC76kE7Pt0iFfUpZ59EGDOlB6f7fMCFUTTuw+EgNbyLf0UkG8F
         qlWvsgutJaUeIxg+doGamS32jtO8TFnhbvQpE5vrnbbi1SP6MH7uuTR8T31YS2IMzQvA
         AWo9CKHIDPZvB+6ECmzRoI9/ON1CjEkXP95+vpVGNw+3h6Oa1CkSLIMYwXLBoY6VdFzs
         ilIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeXbPjradQzO8cghCb/hmFsD1HUCFpYS4RMbao56xvk=;
        b=VM+waRgPfemTzs/ei/njW2h2qEs8jkigRkothX9yHk3r7rC1pIsjNBhu8acxjmUlhJ
         EZ6Shcva1mvoUzLfljv7qT6FbdGQ5QCP8UteP3cH7cOJF1Z3gNHyYUU7xMhE4eXsO+jD
         spHQE9qUzDBW/oi6OR+qIkJRke9BqX4ho/SFocETQ8zwZQNv2zYjhUCZlEIe4DP0itA+
         GKJ+f6gppJ2p3J6uMOMwI8jaJtlYt00wp3wTHshYiFmgtC5js3bz3zCfNtAyA1wmA1xD
         BzcVukZygSshvRSgE9F+i7JrvJ6I32C32I8oGFAIgxFXMp5kF84JrZR+22dhf2JA/Fft
         4ksA==
X-Gm-Message-State: AOAM531HZeJI0Z1887h5O55NXyuFQj95wsignJFogKjLy3S6wXi4YmOL
        GFA8IlE9t2nfruA8yIJTs+enZM/06Mxl1Q==
X-Google-Smtp-Source: ABdhPJzZqjMwn+qQZtcfFR6pOVeaxVjk+4S8a2HisEC53smwlUXCpTghsuErKgHM/Rq4zH10VTqOiw==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr2225719wmq.145.1643272043717;
        Thu, 27 Jan 2022 00:27:23 -0800 (PST)
Received: from erthalion.local (dslb-094-223-160-189.094.223.pools.vodafone-ip.de. [94.223.160.189])
        by smtp.gmail.com with ESMTPSA id d4sm1863849wri.39.2022.01.27.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:27:23 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH] bpftool: Add bpf_cookie to perf output
Date:   Thu, 27 Jan 2022 09:26:49 +0100
Message-Id: <20220127082649.12134-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
BPF perf links") introduced the concept of user specified bpf_cookie,
which could be accessed by BPF programs using bpf_get_attach_cookie().
For troubleshooting purposes it is convenient to expose bpf_cookie via
bpftool as well, so there is no need to meddle with the target BPF
program itself.

    $ bpftool perf
    pid 83  fd 9: prog_id 5  bpf_cookie: 123  tracepoint  sched_process_exec

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 include/linux/trace_events.h                  |  4 ++--
 kernel/bpf/syscall.c                          | 13 +++++++------
 kernel/trace/bpf_trace.c                      |  3 ++-
 samples/bpf/task_fd_query_user.c              | 16 ++++++++--------
 tools/bpf/bpftool/perf.c                      | 19 +++++++++++--------
 tools/lib/bpf/bpf.c                           |  3 ++-
 tools/lib/bpf/bpf.h                           |  2 +-
 tools/lib/bpf/libbpf.map                      |  1 +
 .../bpf/prog_tests/task_fd_query_rawtp.c      | 10 +++++-----
 .../bpf/prog_tests/task_fd_query_tp.c         |  4 ++--
 10 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 50453b287615..56d9929ee2dc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -734,7 +734,7 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr);
+			    u64 *probe_offset, u64 *probe_addr, u64 *bpf_cookie);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -772,7 +772,7 @@ static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static inline int bpf_get_perf_event_info(const struct perf_event *event,
 					  u32 *prog_id, u32 *fd_type,
 					  const char **buf, u64 *probe_offset,
-					  u64 *probe_addr)
+					  u64 *probe_addr, u64 *bpf_cookie)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 45c9bb932132..fc2195cd8d38 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4041,7 +4041,7 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 				    union bpf_attr __user *uattr,
 				    u32 prog_id, u32 fd_type,
 				    const char *buf, u64 probe_offset,
-				    u64 probe_addr)
+				    u64 probe_addr, u64 bpf_cookie)
 {
 	char __user *ubuf = u64_to_user_ptr(attr->task_fd_query.buf);
 	u32 len = buf ? strlen(buf) : 0, input_len;
@@ -4078,7 +4078,8 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 	if (put_user(prog_id, &uattr->task_fd_query.prog_id) ||
 	    put_user(fd_type, &uattr->task_fd_query.fd_type) ||
 	    put_user(probe_offset, &uattr->task_fd_query.probe_offset) ||
-	    put_user(probe_addr, &uattr->task_fd_query.probe_addr))
+	    put_user(probe_addr, &uattr->task_fd_query.probe_addr) ||
+	    put_user(bpf_cookie, &uattr->link_create.perf_event.bpf_cookie))
 		return -EFAULT;
 
 	return err;
@@ -4126,7 +4127,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 			err = bpf_task_fd_query_copy(attr, uattr,
 						     raw_tp->link.prog->aux->id,
 						     BPF_FD_TYPE_RAW_TRACEPOINT,
-						     btp->tp->name, 0, 0);
+						     btp->tp->name, 0, 0, 0);
 			goto put_file;
 		}
 		goto out_not_supp;
@@ -4134,18 +4135,18 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 
 	event = perf_get_event(file);
 	if (!IS_ERR(event)) {
-		u64 probe_offset, probe_addr;
+		u64 probe_offset, probe_addr, bpf_cookie;
 		u32 prog_id, fd_type;
 		const char *buf;
 
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
-					      &probe_addr);
+					      &probe_addr, &bpf_cookie);
 		if (!err)
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
 						     probe_offset,
-						     probe_addr);
+						     probe_addr, bpf_cookie);
 		goto put_file;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 25ea521fb8f1..11da2a222492 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2017,7 +2017,7 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr)
+			    u64 *probe_offset, u64 *probe_addr, u64 *bpf_cookie)
 {
 	bool is_tracepoint, is_syscall_tp;
 	struct bpf_prog *prog;
@@ -2032,6 +2032,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 		return -EOPNOTSUPP;
 
 	*prog_id = prog->aux->id;
+	*bpf_cookie = event->bpf_cookie;
 	flags = event->tp_event->flags;
 	is_tracepoint = flags & TRACE_EVENT_FL_TRACEPOINT;
 	is_syscall_tp = is_syscall_trace_event(event->tp_event);
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index c9a0ca8351fd..7479f1c4d0b1 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -92,7 +92,7 @@ static int bpf_get_retprobe_bit(const char *event_type)
 static int test_debug_fs_kprobe(int link_idx, const char *fn_name,
 				__u32 expected_fd_type)
 {
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	int err, event_fd;
 	char buf[256];
@@ -101,7 +101,7 @@ static int test_debug_fs_kprobe(int link_idx, const char *fn_name,
 	event_fd = bpf_link__fd(links[link_idx]);
 	err = bpf_task_fd_query(getpid(), event_fd, 0, buf, &len,
 				&prog_id, &fd_type, &probe_offset,
-				&probe_addr);
+				&probe_addr, &bpf_cookie);
 	if (err < 0) {
 		printf("FAIL: %s, for event_fd idx %d, fn_name %s\n",
 		       __func__, link_idx, fn_name);
@@ -124,7 +124,7 @@ static int test_debug_fs_kprobe(int link_idx, const char *fn_name,
 static int test_nondebug_fs_kuprobe_common(const char *event_type,
 	const char *name, __u64 offset, __u64 addr, bool is_return,
 	char *buf, __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
-	__u64 *probe_offset, __u64 *probe_addr)
+	__u64 *probe_offset, __u64 *probe_addr, __u64 *bpf_cookie)
 {
 	int is_return_bit = bpf_get_retprobe_bit(event_type);
 	int type = bpf_find_probe_type(event_type);
@@ -163,7 +163,7 @@ static int test_nondebug_fs_kuprobe_common(const char *event_type,
 	}
 
 	CHECK_PERROR_RET(bpf_task_fd_query(getpid(), fd, 0, buf, buf_len,
-			 prog_id, fd_type, probe_offset, probe_addr) < 0);
+			 prog_id, fd_type, probe_offset, probe_addr, bpf_cookie) < 0);
 	err = 0;
 
 cleanup:
@@ -177,7 +177,7 @@ static int test_nondebug_fs_probe(const char *event_type, const char *name,
 				  __u32 expected_ret_fd_type,
 				  char *buf, __u32 buf_len)
 {
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 prog_id, fd_type;
 	int err;
 
@@ -185,7 +185,7 @@ static int test_nondebug_fs_probe(const char *event_type, const char *name,
 					      offset, addr, is_return,
 					      buf, &buf_len, &prog_id,
 					      &fd_type, &probe_offset,
-					      &probe_addr);
+					      &probe_addr, &bpf_cookie);
 	if (err < 0) {
 		printf("FAIL: %s, "
 		       "for name %s, offset 0x%llx, addr 0x%llx, is_return %d\n",
@@ -230,7 +230,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	char buf[256], event_alias[sizeof("test_1234567890")];
 	const char *event_type = "uprobe";
 	struct perf_event_attr attr = {};
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	int err = -1, res, kfd, efd;
 	struct bpf_link *link;
@@ -280,7 +280,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	len = sizeof(buf);
 	err = bpf_task_fd_query(getpid(), kfd, 0, buf, &len,
 				&prog_id, &fd_type, &probe_offset,
-				&probe_addr);
+				&probe_addr, &bpf_cookie);
 	if (err < 0) {
 		printf("FAIL: %s, binary_path %s\n", __func__, binary_path);
 		perror("    :");
diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index 50de087b0db7..3b7746795004 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -21,7 +21,7 @@
 static int perf_query_supported;
 static bool has_perf_query_support(void)
 {
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	char buf[256];
 	int fd;
@@ -42,7 +42,7 @@ static bool has_perf_query_support(void)
 	errno = 0;
 	len = sizeof(buf);
 	bpf_task_fd_query(getpid(), fd, 0, buf, &len, &prog_id,
-			  &fd_type, &probe_offset, &probe_addr);
+			  &fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 
 	if (errno == 524 /* ENOTSUPP */) {
 		perf_query_supported = 1;
@@ -61,12 +61,14 @@ static bool has_perf_query_support(void)
 }
 
 static void print_perf_json(int pid, int fd, __u32 prog_id, __u32 fd_type,
-			    char *buf, __u64 probe_offset, __u64 probe_addr)
+			    char *buf, __u64 probe_offset, __u64 probe_addr,
+				__u64 bpf_cookie)
 {
 	jsonw_start_object(json_wtr);
 	jsonw_int_field(json_wtr, "pid", pid);
 	jsonw_int_field(json_wtr, "fd", fd);
 	jsonw_uint_field(json_wtr, "prog_id", prog_id);
+	jsonw_lluint_field(json_wtr, "bpf_cookie", bpf_cookie);
 	switch (fd_type) {
 	case BPF_FD_TYPE_RAW_TRACEPOINT:
 		jsonw_string_field(json_wtr, "fd_type", "raw_tracepoint");
@@ -111,9 +113,10 @@ static void print_perf_json(int pid, int fd, __u32 prog_id, __u32 fd_type,
 }
 
 static void print_perf_plain(int pid, int fd, __u32 prog_id, __u32 fd_type,
-			     char *buf, __u64 probe_offset, __u64 probe_addr)
+			     char *buf, __u64 probe_offset, __u64 probe_addr, __u64 bpf_cookie)
 {
 	printf("pid %d  fd %d: prog_id %u  ", pid, fd, prog_id);
+	printf("bpf_cookie: %llu  ", bpf_cookie);
 	switch (fd_type) {
 	case BPF_FD_TYPE_RAW_TRACEPOINT:
 		printf("raw_tracepoint  %s\n", buf);
@@ -150,7 +153,7 @@ static void print_perf_plain(int pid, int fd, __u32 prog_id, __u32 fd_type,
 static int show_proc(const char *fpath, const struct stat *sb,
 		     int tflag, struct FTW *ftwbuf)
 {
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	int err, pid = 0, fd = 0;
 	const char *pch;
@@ -194,16 +197,16 @@ static int show_proc(const char *fpath, const struct stat *sb,
 	/* query (pid, fd) for potential perf events */
 	len = sizeof(buf);
 	err = bpf_task_fd_query(pid, fd, 0, buf, &len, &prog_id, &fd_type,
-				&probe_offset, &probe_addr);
+				&probe_offset, &probe_addr, &bpf_cookie);
 	if (err < 0)
 		return 0;
 
 	if (json_output)
 		print_perf_json(pid, fd, prog_id, fd_type, buf, probe_offset,
-				probe_addr);
+				probe_addr, bpf_cookie);
 	else
 		print_perf_plain(pid, fd, prog_id, fd_type, buf, probe_offset,
-				 probe_addr);
+				 probe_addr, bpf_cookie);
 
 	return 0;
 }
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 94560ba31724..d8b92508918e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1090,7 +1090,7 @@ int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf, __u32 log_buf_s
 
 int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 		      __u32 *prog_id, __u32 *fd_type, __u64 *probe_offset,
-		      __u64 *probe_addr)
+		      __u64 *probe_addr, __u64 *bpf_cookie)
 {
 	union bpf_attr attr = {};
 	int err;
@@ -1108,6 +1108,7 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 	*fd_type = attr.task_fd_query.fd_type;
 	*probe_offset = attr.task_fd_query.probe_offset;
 	*probe_addr = attr.task_fd_query.probe_addr;
+	*bpf_cookie = attr.link_create.perf_event.bpf_cookie;
 
 	return libbpf_err_errno(err);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 079cc81ac51e..80bd705eca59 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -315,7 +315,7 @@ LIBBPF_API int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf,
 			    __u32 log_buf_size, bool do_log);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
-				 __u64 *probe_offset, __u64 *probe_addr);
+				 __u64 *probe_offset, __u64 *probe_addr, __u64 *bpf_cookie);
 
 enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
 LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 69bc069f0a68..ca25f33f8b48 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -106,6 +106,7 @@ LIBBPF_0.0.1 {
 		bpf_raw_tracepoint_open;
 		bpf_set_link_xdp_fd;
 		bpf_task_fd_query;
+		bpf_task_fd_query2;
 		bpf_verify_program;
 		btf__fd;
 		btf__find_by_name;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
index 17947c9e1d66..0dbe91df96ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
@@ -4,7 +4,7 @@
 void test_task_fd_query_rawtp(void)
 {
 	const char *file = "./test_get_stack_rawtp.o";
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	struct bpf_object *obj;
 	int efd, err, prog_fd;
@@ -22,7 +22,7 @@ void test_task_fd_query_rawtp(void)
 	/* query (getpid(), efd) */
 	len = sizeof(buf);
 	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
+				&fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
 		  errno))
 		goto close_prog;
@@ -36,7 +36,7 @@ void test_task_fd_query_rawtp(void)
 	/* test zero len */
 	len = 0;
 	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
+				&fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 	if (CHECK(err < 0, "bpf_task_fd_query (len = 0)", "err %d errno %d\n",
 		  err, errno))
 		goto close_prog;
@@ -48,7 +48,7 @@ void test_task_fd_query_rawtp(void)
 	/* test empty buffer */
 	len = sizeof(buf);
 	err = bpf_task_fd_query(getpid(), efd, 0, 0, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
+				&fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 	if (CHECK(err < 0, "bpf_task_fd_query (buf = 0)", "err %d errno %d\n",
 		  err, errno))
 		goto close_prog;
@@ -60,7 +60,7 @@ void test_task_fd_query_rawtp(void)
 	/* test smaller buffer */
 	len = 3;
 	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
+				&fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 	if (CHECK(err >= 0 || errno != ENOSPC, "bpf_task_fd_query (len = 3)",
 		  "err %d errno %d\n", err, errno))
 		goto close_prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
index c2a98a7a8dfc..5fbb61d52a2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -7,7 +7,7 @@ static void test_task_fd_query_tp_core(const char *probe_name,
 	const char *file = "./test_tracepoint.o";
 	int err, bytes, efd, prog_fd, pmu_fd;
 	struct perf_event_attr attr = {};
-	__u64 probe_offset, probe_addr;
+	__u64 probe_offset, probe_addr, bpf_cookie;
 	__u32 len, prog_id, fd_type;
 	struct bpf_object *obj = NULL;
 	__u32 duration = 0;
@@ -52,7 +52,7 @@ static void test_task_fd_query_tp_core(const char *probe_name,
 	/* query (getpid(), pmu_fd) */
 	len = sizeof(buf);
 	err = bpf_task_fd_query(getpid(), pmu_fd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
+				&fd_type, &probe_offset, &probe_addr, &bpf_cookie);
 	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
 		  errno))
 		goto close_pmu;
-- 
2.32.0

