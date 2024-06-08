Return-Path: <bpf+bounces-31655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FE9012FB
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB241C20DAF
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829B13AD8;
	Sat,  8 Jun 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0sKb6Zh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019C125D5;
	Sat,  8 Jun 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867293; cv=none; b=hkNimqDVSUXtnaV9wThK/9rR9PJZ1qX0VgbAiWWFv4+2Oj7eQ3GxlOwTJMY+fm9RmqjcM+bt0bbt5gzyIGRbA9bwNWlwdZMdV/K9Enb+0+iz1w4Pj+x3PHo1pQWqi+sF8H2oAHgsu0ASyv0FZsxGrPY28bPivHn3vTQU3vFHg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867293; c=relaxed/simple;
	bh=IrdI5sjPl5asL5nWXJNR+jzbTys2w3mwkdk7TJZKmmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+uBRtMifL+45O+bgK2H3/S0hyjnDC+2cLJ/rEfh1IH1kjVKdk+6iPxuDKpVio5y93V76aqdbh6JCeHhchUFttc6RzX4GkySZzCC7wg/xS6U44Z8BiFidy3GtqkFHTuZiESag/Y4FZ2FPXkJMSofQBhmVDt3Dg+afLqBvP+ox98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0sKb6Zh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c254d9bdd6so2725756a91.3;
        Sat, 08 Jun 2024 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717867290; x=1718472090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMy58J3QA7OYuNsqpVYU1rzQFW3lTrPyfWwmiRLgh2I=;
        b=i0sKb6Zh4UIOIvhz2pIyGvdDzUVAzz1alb6xWhZRxkSd2Pw3cK082+Zr7fdfmHc3N5
         suQW7hFfhcDbxf53B2ndzGVxnPjQwSuIPexL0enquQrlPlZRT9iNorG9f2/ffliiwTnA
         auSUIBu12XrKOQWB+qBeQbn/jSzoNp8RAN8oevPAG+mEUtvbUbpJlD9bmnDeK4G7iN9G
         R4M5hvLKH6XtfnngNiAMyCpfcX+hrCEUncYPTQt52yMZnOAzWbfR2+6kyIuv/6Pw3myA
         wQPrmeOdwhO1pF0EOmDVrYNbGQO35geJKGQ8G8N4tEAJ75G8DM1ohAqjAiZdjdB78V3s
         ggsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717867290; x=1718472090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMy58J3QA7OYuNsqpVYU1rzQFW3lTrPyfWwmiRLgh2I=;
        b=Or84dXbOTSfesmVI1MEoIYaCgmv/vHv9CC70UBS7r0caJqilXtxvHu94q6pFeZEf7Q
         WA/vzEUw3XSKCQmQGAeYm2N+yt83sEkG9n/dAf8qoNDT+NXR3HgAncRfjwSkQrq+vYR7
         FxHla9KrqunA0XCNFwP36VtiulknhSChkuwUMAbxGG9+kmsPunajmA5SMNEpqCx8zj5D
         1ZBaeUDhl7BfCGs8UdYsNytmq+u9MMlUEhj4x9j0Pvmolgt/JHVVvZgnv4UTttOrAkWV
         yXLuGfepPnSy9VcMEkLXUspaKA39ShJlFS48a/QvF2Qbs5d9S9CW4DFzsLyjGGztD9Zy
         qdhg==
X-Forwarded-Encrypted: i=1; AJvYcCU3HtZTFpEZ/AsCNpkm3ZQMYCIsidmQeCySlfz1VvCoGAhzeLivKdfCO2g8xM+hBIKY7uwastPMkjKqHrT+3O/5RwIAWH//q3jI7vO/mc5h/4bLkjY9MGPz5q21BzuOedxqD399Rz2QqkpgUv8H6MEn7nqMg3zq71jkZE87qtH0hB+I4kxtOR5nprwbeSH5VDbBEd9EzrGbpZA+SGUXZJz0NTOyb1cxNZ+twA==
X-Gm-Message-State: AOJu0YzrsVZepE2e/IPLosJRsKYKUUhldVPZ2n6ot0APL7RWkBQwTtPd
	DxKCu7+/4pGHq2DIeE/7mJS7fCwqMvcPAEEWT/3A6+o3cT8ZFF+L
X-Google-Smtp-Source: AGHT+IGc7lLd9geb8g0L1MRS9I3j9ymtsBD2HMyCZh6CZPb1b1RadJ7IIki74P8G+mW7SLIFjj+dQQ==
X-Received: by 2002:a17:90b:4b46:b0:2c2:d136:b0fb with SMTP id 98e67ed59e1d1-2c2d136b355mr3753386a91.34.1717867290398;
        Sat, 08 Jun 2024 10:21:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:8955:2e84:1464:5333:31d6:6ba3:d747])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2f8e2fbfesm32346a91.34.2024.06.08.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 10:21:30 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	mic@digikod.net,
	gnoack@google.com,
	brauner@kernel.org,
	howardchu95@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] perf trace: Fix syscall untraceable bug
Date: Sun,  9 Jun 2024 01:21:46 +0800
Message-ID: <20240608172147.2779890-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a bug found when implementing pretty-printing for the
landlock_add_rule system call, I decided to send this patch separately
because this is a serious bug that should be fixed fast.

I wrote a test program to do landlock_add_rule syscall in a loop,
yet perf trace -e landlock_add_rule freezes, giving no output.

This bug is introduced by the false understanding of the variable "key"
below:
```
for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
	struct syscall *sc = trace__syscall_info(trace, NULL, key);
	...
}
```
The code above seems right at the beginning, but when looking at
syscalltbl.c, I found these lines:

```
for (i = 0; i <= syscalltbl_native_max_id; ++i)
	if (syscalltbl_native[i])
		++nr_entries;

entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
...

for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
	if (syscalltbl_native[i]) {
		entries[j].name = syscalltbl_native[i];
		entries[j].id = i;
		++j;
	}
}
```

meaning the key is merely an index to traverse the syscall table,
instead of the actual syscall id for this particular syscall.

So if one uses key to do trace__syscall_info(trace, NULL, key), because
key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
my X86_64 machine, this number is 373, it will end up neglecting all
the rest of the syscall, in my case, everything after `rseq`, because
the traversal will stop at 373, and `rseq` is the last syscall whose id
is lower than 373

in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
```
	...
	[334] = "rseq",
	[424] = "pidfd_send_signal",
	...
```

The reason why the key is scrambled but perf trace works well is that
key is used in trace__syscall_info(trace, NULL, key) to do
trace->syscalls.table[id], this makes sure that the struct syscall returned
actually has an id the same value as key, making the later bpf_prog
matching all correct.

After fixing this bug, I can do perf trace on 38 more syscalls, and
because more syscalls are visible, we get 8 more syscalls that can be
augmented.

before:

perf $ perf trace -vv --max-events=1 |& grep Reusing
Reusing "open" BPF sys_enter augmenter for "stat"
Reusing "open" BPF sys_enter augmenter for "lstat"
Reusing "open" BPF sys_enter augmenter for "access"
Reusing "connect" BPF sys_enter augmenter for "accept"
Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
Reusing "connect" BPF sys_enter augmenter for "bind"
Reusing "connect" BPF sys_enter augmenter for "getsockname"
Reusing "connect" BPF sys_enter augmenter for "getpeername"
Reusing "open" BPF sys_enter augmenter for "execve"
Reusing "open" BPF sys_enter augmenter for "truncate"
Reusing "open" BPF sys_enter augmenter for "chdir"
Reusing "open" BPF sys_enter augmenter for "mkdir"
Reusing "open" BPF sys_enter augmenter for "rmdir"
Reusing "open" BPF sys_enter augmenter for "creat"
Reusing "open" BPF sys_enter augmenter for "link"
Reusing "open" BPF sys_enter augmenter for "unlink"
Reusing "open" BPF sys_enter augmenter for "symlink"
Reusing "open" BPF sys_enter augmenter for "readlink"
Reusing "open" BPF sys_enter augmenter for "chmod"
Reusing "open" BPF sys_enter augmenter for "chown"
Reusing "open" BPF sys_enter augmenter for "lchown"
Reusing "open" BPF sys_enter augmenter for "mknod"
Reusing "open" BPF sys_enter augmenter for "statfs"
Reusing "open" BPF sys_enter augmenter for "pivot_root"
Reusing "open" BPF sys_enter augmenter for "chroot"
Reusing "open" BPF sys_enter augmenter for "acct"
Reusing "open" BPF sys_enter augmenter for "swapon"
Reusing "open" BPF sys_enter augmenter for "swapoff"
Reusing "open" BPF sys_enter augmenter for "delete_module"
Reusing "open" BPF sys_enter augmenter for "setxattr"
Reusing "open" BPF sys_enter augmenter for "lsetxattr"
Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
Reusing "open" BPF sys_enter augmenter for "getxattr"
Reusing "open" BPF sys_enter augmenter for "lgetxattr"
Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
Reusing "open" BPF sys_enter augmenter for "listxattr"
Reusing "open" BPF sys_enter augmenter for "llistxattr"
Reusing "open" BPF sys_enter augmenter for "removexattr"
Reusing "open" BPF sys_enter augmenter for "lremovexattr"
Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
Reusing "open" BPF sys_enter augmenter for "mq_open"
Reusing "open" BPF sys_enter augmenter for "mq_unlink"
Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
Reusing "open" BPF sys_enter augmenter for "symlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
Reusing "connect" BPF sys_enter augmenter for "accept4"
Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
Reusing "open" BPF sys_enter augmenter for "memfd_create"
Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
Reusing "fremovexattr" BPF sys_enter augmenter for "statx"

after

perf $ perf trace -vv --max-events=1 |& grep Reusing
Reusing "open" BPF sys_enter augmenter for "stat"
Reusing "open" BPF sys_enter augmenter for "lstat"
Reusing "open" BPF sys_enter augmenter for "access"
Reusing "connect" BPF sys_enter augmenter for "accept"
Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
Reusing "connect" BPF sys_enter augmenter for "bind"
Reusing "connect" BPF sys_enter augmenter for "getsockname"
Reusing "connect" BPF sys_enter augmenter for "getpeername"
Reusing "open" BPF sys_enter augmenter for "execve"
Reusing "open" BPF sys_enter augmenter for "truncate"
Reusing "open" BPF sys_enter augmenter for "chdir"
Reusing "open" BPF sys_enter augmenter for "mkdir"
Reusing "open" BPF sys_enter augmenter for "rmdir"
Reusing "open" BPF sys_enter augmenter for "creat"
Reusing "open" BPF sys_enter augmenter for "link"
Reusing "open" BPF sys_enter augmenter for "unlink"
Reusing "open" BPF sys_enter augmenter for "symlink"
Reusing "open" BPF sys_enter augmenter for "readlink"
Reusing "open" BPF sys_enter augmenter for "chmod"
Reusing "open" BPF sys_enter augmenter for "chown"
Reusing "open" BPF sys_enter augmenter for "lchown"
Reusing "open" BPF sys_enter augmenter for "mknod"
Reusing "open" BPF sys_enter augmenter for "statfs"
Reusing "open" BPF sys_enter augmenter for "pivot_root"
Reusing "open" BPF sys_enter augmenter for "chroot"
Reusing "open" BPF sys_enter augmenter for "acct"
Reusing "open" BPF sys_enter augmenter for "swapon"
Reusing "open" BPF sys_enter augmenter for "swapoff"
Reusing "open" BPF sys_enter augmenter for "delete_module"
Reusing "open" BPF sys_enter augmenter for "setxattr"
Reusing "open" BPF sys_enter augmenter for "lsetxattr"
Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
Reusing "open" BPF sys_enter augmenter for "getxattr"
Reusing "open" BPF sys_enter augmenter for "lgetxattr"
Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
Reusing "open" BPF sys_enter augmenter for "listxattr"
Reusing "open" BPF sys_enter augmenter for "llistxattr"
Reusing "open" BPF sys_enter augmenter for "removexattr"
Reusing "open" BPF sys_enter augmenter for "lremovexattr"
Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
Reusing "open" BPF sys_enter augmenter for "mq_open"
Reusing "open" BPF sys_enter augmenter for "mq_unlink"
Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
Reusing "open" BPF sys_enter augmenter for "symlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
Reusing "connect" BPF sys_enter augmenter for "accept4"
Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
Reusing "open" BPF sys_enter augmenter for "memfd_create"
Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
Reusing "fremovexattr" BPF sys_enter augmenter for "statx"

TL;DR:

These are the new syscalls that can be augmented
Reusing "openat" BPF sys_enter augmenter for "open_tree"
Reusing "openat" BPF sys_enter augmenter for "openat2"
Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
Reusing "openat" BPF sys_enter augmenter for "move_mount"
Reusing "open" BPF sys_enter augmenter for "fsopen"
Reusing "openat" BPF sys_enter augmenter for "fspick"
Reusing "openat" BPF sys_enter augmenter for "faccessat2"
Reusing "openat" BPF sys_enter augmenter for "fchmodat2"

as for the perf trace output:

before

perf $ perf trace -e faccessat2 --max-events=1
[no output]

after

perf $ ./perf trace -e faccessat2 --max-events=1
     0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent")                               = 0

P.S. The reason why this bug was not found in the past five years is
probably because it only happens to the newer syscalls whose id is
greater, for instance, faccessat2 of id 439, which not a lot of people
care about when using perf trace.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c   | 32 +++++++++++++++++++++-----------
 tools/perf/util/syscalltbl.c | 21 +++++++++------------
 tools/perf/util/syscalltbl.h |  5 +++++
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c42bc608954e..5cbe1748911d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3354,7 +3354,8 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
-	int id;
+	struct __syscall *scs = trace->sctbl->syscalls.entries;
+	int id, _id;
 
 	/*
 	 * We're only interested in syscalls that have a pointer:
@@ -3368,10 +3369,13 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 
 try_to_find_pair:
 	for (id = 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
-		struct syscall *pair = trace__syscall_info(trace, NULL, id);
+		struct syscall *pair;
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
 
+		_id = scs[id].id;
+		pair = trace__syscall_info(trace, NULL, _id);
+
 		if (pair == NULL || pair == sc ||
 		    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
 			continue;
@@ -3456,23 +3460,26 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
-	int err = 0, key;
+	int err = 0, key, id;
+	struct __syscall *scs = trace->sctbl->syscalls.entries;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
 		int prog_fd;
 
-		if (!trace__syscall_enabled(trace, key))
+		id = scs[key].id;
+
+		if (!trace__syscall_enabled(trace, id))
 			continue;
 
-		trace__init_syscall_bpf_progs(trace, key);
+		trace__init_syscall_bpf_progs(trace, id);
 
 		// It'll get at least the "!raw_syscalls:unaugmented"
-		prog_fd = trace__bpf_prog_sys_enter_fd(trace, key);
-		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
+		prog_fd = trace__bpf_prog_sys_enter_fd(trace, id);
+		err = bpf_map_update_elem(map_enter_fd, &id, &prog_fd, BPF_ANY);
 		if (err)
 			break;
-		prog_fd = trace__bpf_prog_sys_exit_fd(trace, key);
-		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
+		prog_fd = trace__bpf_prog_sys_exit_fd(trace, id);
+		err = bpf_map_update_elem(map_exit_fd, &id, &prog_fd, BPF_ANY);
 		if (err)
 			break;
 	}
@@ -3506,10 +3513,13 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 	 * array tail call, then that one will be used.
 	 */
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		struct syscall *sc = trace__syscall_info(trace, NULL, key);
+		struct syscall *sc;
 		struct bpf_program *pair_prog;
 		int prog_fd;
 
+		id = scs[key].id;
+		sc = trace__syscall_info(trace, NULL, id);
+
 		if (sc == NULL || sc->bpf_prog.sys_enter == NULL)
 			continue;
 
@@ -3535,7 +3545,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 		 * with the fd for the program we're reusing:
 		 */
 		prog_fd = bpf_program__fd(sc->bpf_prog.sys_enter);
-		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
+		err = bpf_map_update_elem(map_enter_fd, &id, &prog_fd, BPF_ANY);
 		if (err)
 			break;
 	}
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 63be7b58761d..16aa886c40f0 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -44,22 +44,17 @@ const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #endif
 
-struct syscall {
-	int id;
-	const char *name;
-};
-
 static int syscallcmpname(const void *vkey, const void *ventry)
 {
 	const char *key = vkey;
-	const struct syscall *entry = ventry;
+	const struct __syscall *entry = ventry;
 
 	return strcmp(key, entry->name);
 }
 
 static int syscallcmp(const void *va, const void *vb)
 {
-	const struct syscall *a = va, *b = vb;
+	const struct __syscall *a = va, *b = vb;
 
 	return strcmp(a->name, b->name);
 }
@@ -67,13 +62,14 @@ static int syscallcmp(const void *va, const void *vb)
 static int syscalltbl__init_native(struct syscalltbl *tbl)
 {
 	int nr_entries = 0, i, j;
-	struct syscall *entries;
+	struct __syscall *entries;
 
 	for (i = 0; i <= syscalltbl_native_max_id; ++i)
 		if (syscalltbl_native[i])
 			++nr_entries;
 
-	entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
+	entries = tbl->syscalls.entries = malloc(sizeof(struct __syscall) *
+						 nr_entries);
 	if (tbl->syscalls.entries == NULL)
 		return -1;
 
@@ -85,7 +81,8 @@ static int syscalltbl__init_native(struct syscalltbl *tbl)
 		}
 	}
 
-	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), syscallcmp);
+	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct __syscall),
+	      syscallcmp);
 	tbl->syscalls.nr_entries = nr_entries;
 	tbl->syscalls.max_id	 = syscalltbl_native_max_id;
 	return 0;
@@ -116,7 +113,7 @@ const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unused, int id
 
 int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 {
-	struct syscall *sc = bsearch(name, tbl->syscalls.entries,
+	struct __syscall *sc = bsearch(name, tbl->syscalls.entries,
 				     tbl->syscalls.nr_entries, sizeof(*sc),
 				     syscallcmpname);
 
@@ -126,7 +123,7 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
 {
 	int i;
-	struct syscall *syscalls = tbl->syscalls.entries;
+	struct __syscall *syscalls = tbl->syscalls.entries;
 
 	for (i = *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
 		if (strglobmatch(syscalls[i].name, syscall_glob)) {
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index a41d2ca9e4ae..6e93a0874c40 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -2,6 +2,11 @@
 #ifndef __PERF_SYSCALLTBL_H
 #define __PERF_SYSCALLTBL_H
 
+struct __syscall {
+	int id;
+	const char *name;
+};
+
 struct syscalltbl {
 	int audit_machine;
 	struct {
-- 
2.45.2


