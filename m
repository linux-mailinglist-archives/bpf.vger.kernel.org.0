Return-Path: <bpf+bounces-48332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1867A06B51
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BC43A52C2
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971331898EA;
	Thu,  9 Jan 2025 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1m44lcJD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75717F4F2
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390208; cv=none; b=cqDOEWNi3BRt5L7Sk3LqphOZ+l8ehBlpayDGn0y85cukbnlVJqwtBmk2h6HJ9GW6k/cY4ivf/76bndzcVjtdFmFUc2b4qMFmFhB28W2AzIccSBDsUeRusW4AbFqnW3bpWjxDXSu6KE60kV+GELW/JNkDOVSt538Fj/1OEqPaMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390208; c=relaxed/simple;
	bh=VjXhJfMyk3UvkjC/oBdg3tewQeKzphgeDxP3cTE3S90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXELYCBhXgRCFTVXe3/Q4eLnKBBezjPIuLyHvXslFSYDaPF3g4PfbUGX1bLMtfpxwwuBv6WSQv3yXKPMbBrZMta4n0M8q4Iw3M5MywwkoV/XBaTaAC1JNhG2N5d4q9qnEoMonWEn6Xr3EYeXHpOJWsZnaTL09KrAgYBbYrKRHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1m44lcJD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so7255525ad.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390205; x=1736995005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8oyxbfemppXVxsCJG5v+2lUdw7mPaSoevT+d8pgIhY=;
        b=1m44lcJDthhXFMeoHcDcLOp64ZHdi/bBltxUU5FNWE2VSTTMwi+qKYurhjmVSmh3gv
         tFYwZd97FHvrhBEPhUcbum+rXrDbxjHVfwb0jIclXx46NrHJ/1gGGrMFbwaJ4Aoev9ST
         bD+s+xM/yq3CX6//A9Z6EDftl/3qLm87J2EM7gtJoBew6YX7llCQD6OpBoW4ykTAapb6
         TIMWD11mLAQ6rQYFRLl+O4OQRh7aboz9Zeho39nlmhYo9euUo7s3aMBMZOjcPlirkYaK
         074mytCdS5mv9qfvKyREq7VFFaSW7uLk9myqYPuvhadTOoWljpFjpXZM+zsfU0PuDKj+
         l7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390205; x=1736995005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8oyxbfemppXVxsCJG5v+2lUdw7mPaSoevT+d8pgIhY=;
        b=mx0jaTvHoxnmDx1p/BF3VipAA/hro2Ks5+qUedWRSmyy+MuF8ax8W+qreNjQn8ziUx
         +HcvIQHySbmekdUhUTe1IRRn6sNsDP+jUM2Ruai0AMH39fGX0YFzrvOtDEIJHHbx9Xxg
         XMlpVR+HwUvXtHDXoOyGEuXhDIWWHw4pLl2QUECEcvlh/GoEFvqnWUhk9fUcoIiaDrec
         d8/3H2phLiGMuBHRuCDMHskSQrJjTzsYTcfXROkmNMsSm2Xajjr0GB+WSHSQlYKtjJLG
         k35A0+DmyNGJoJ13Wizv9g+Dt+YgRsANkMaYvOgR0AmXxgLaofZvzqNL3RsaUielseIX
         YGNg==
X-Forwarded-Encrypted: i=1; AJvYcCVGf+SJXMS4qgCxa/Eg0HorKSTKvN8QWhkgptjXXXFcDVfqIDJi92CUUGOt92SmZzYOM/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsYb6OQ9lxbdmrQxwMJI+VsTBn2c+sT9aUVuFBy4GmI/m2J8F
	5XzCLPeCRID0A0ZkuBoRFIp420HAIq4elPFjIL9bT5e9RLMjJ/2Pu1A86esib2s=
X-Gm-Gg: ASbGncvXny/L7HvJrP1hjlCrBpYnbn3wDJd+uf8iUAk/QbKtDZcFjLTdA+FG3/UWBB1
	dnncsAsSPYGOQG0yxZqEs7SSeFIkwQBhsYp5FbA5ceqMmm2JwJcaeILT0Pq3UF8KNtm53MRSWNr
	l8nj+zrz40ZssKpOzwrpFWJDUQNPmnQ03iY422SuHubemI0Dv217grKdAojLHMdQimkJfGjpyeM
	elFfC8KywJNv5/0OyCgj8Twi0WaZqc7HgpuVgue7n7j4H6y+8wtycJjzDh2rBScxfUHcjjH
X-Google-Smtp-Source: AGHT+IElDkeMy+E0plKVSV0arQAIfDn1Ot+zJi/8pmqBkckZap32kRATjl5QkK0VnQKZgY62RmCIaA==
X-Received: by 2002:a17:902:d18a:b0:215:742e:5cff with SMTP id d9443c01a7336-21a8d6918f7mr22594505ad.16.1736390205084;
        Wed, 08 Jan 2025 18:36:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:36:44 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:19 -0800
Subject: [PATCH v6 04/16] perf tools: arm: Support syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-4-7543b5293098@rivosinc.com>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
In-Reply-To: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22074; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=VjXhJfMyk3UvkjC/oBdg3tewQeKzphgeDxP3cTE3S90=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9mc4uk1jR3xEMP2Z0rO6cxrBh+ZbYY5deXT98MKVYN
 Osvd+ubjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACYSncfIcOixB/v+cPbQqceT
 2D7YrpFbHbKjRSXVvt9pi7svf1ZgJ8N/j+UyHOv/7dSeZ7SD5c8Ur4uKD9J2Hdz8Z1PhEblFbcJ
 mbAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

arm uses a syscall table, use that in perf instead of requiring
libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++++
 tools/perf/arch/arm/include/syscall_table.h        |   2 +
 tools/perf/check-headers.sh                        |   1 +
 6 files changed, 493 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3fe47bd21c0ea39473c584c82383ca5d4daf580f..4e92322f45c93f2a7c5ddf68f4a7cae051209066 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky
+generic_syscall_table_archs := riscv arc csky arm
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/arm/entry/syscalls/Kbuild b/tools/perf/arch/arm/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9d777540f08987908a6532c5ece66553dffc52df
--- /dev/null
+++ b/tools/perf/arch/arm/entry/syscalls/Kbuild
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += oabi
+syscalltbl = $(srctree)/tools/perf/arch/arm/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
new file mode 100644
index 0000000000000000000000000000000000000000..49eeb2ad8dbd8e074c6240417693f23fb328afa8
--- /dev/null
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -0,0 +1,483 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# Linux system call numbers and entry vectors
+#
+# The format is:
+# <num>	<abi>	<name>			[<entry point>			[<oabi compat entry point>]]
+#
+# Where abi is:
+#  common - for system calls shared between oabi and eabi (may have compat)
+#  oabi   - for oabi-only system calls (may have compat)
+#  eabi   - for eabi-only system calls
+#
+# For each syscall number, "common" is mutually exclusive with oabi and eabi
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open
+6	common	close			sys_close
+# 7 was sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve
+12	common	chdir			sys_chdir
+13	oabi	time			sys_time32
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown16
+# 17 was sys_break
+# 18 was sys_stat
+19	common	lseek			sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+22	oabi	umount			sys_oldumount
+23	common	setuid			sys_setuid16
+24	common	getuid			sys_getuid16
+25	oabi	stime			sys_stime32
+26	common	ptrace			sys_ptrace
+27	oabi	alarm			sys_alarm
+# 28 was sys_fstat
+29	common	pause			sys_pause
+30	oabi	utime			sys_utime32
+# 31 was sys_stty
+# 32 was sys_gtty
+33	common	access			sys_access
+34	common	nice			sys_nice
+# 35 was sys_ftime
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times
+# 44 was sys_prof
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid16
+47	common	getgid			sys_getgid16
+# 48 was sys_signal
+49	common	geteuid			sys_geteuid16
+50	common	getegid			sys_getegid16
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+# 53 was sys_lock
+54	common	ioctl			sys_ioctl
+55	common	fcntl			sys_fcntl
+# 56 was sys_mpx
+57	common	setpgid			sys_setpgid
+# 58 was sys_ulimit
+# 59 was sys_olduname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	sigaction		sys_sigaction
+# 68 was sys_sgetmask
+# 69 was sys_ssetmask
+70	common	setreuid		sys_setreuid16
+71	common	setregid		sys_setregid16
+72	common	sigsuspend		sys_sigsuspend
+73	common	sigpending		sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit
+# Back compat 2GB limited rlimit
+76	oabi	getrlimit		sys_old_getrlimit
+77	common	getrusage		sys_getrusage
+78	common	gettimeofday		sys_gettimeofday
+79	common	settimeofday		sys_settimeofday
+80	common	getgroups		sys_getgroups16
+81	common	setgroups		sys_setgroups16
+82	oabi	select			sys_old_select
+83	common	symlink			sys_symlink
+# 84 was sys_lstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_uselib
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+89	oabi	readdir			sys_old_readdir
+90	oabi	mmap			sys_old_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate
+93	common	ftruncate		sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown16
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+# 98 was sys_profil
+99	common	statfs			sys_statfs
+100	common	fstatfs			sys_fstatfs
+# 101 was sys_ioperm
+102	oabi	socketcall		sys_socketcall		sys_oabi_socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer
+105	common	getitimer		sys_getitimer
+106	common	stat			sys_newstat
+107	common	lstat			sys_newlstat
+108	common	fstat			sys_newfstat
+# 109 was sys_uname
+# 110 was sys_iopl
+111	common	vhangup			sys_vhangup
+# 112 was sys_idle
+# syscall to call a syscall!
+113	oabi	syscall			sys_syscall
+114	common	wait4			sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo
+117	oabi	ipc			sys_ipc			sys_oabi_ipc
+118	common	fsync			sys_fsync
+119	common	sigreturn		sys_sigreturn_wrapper
+120	common	clone			sys_clone
+121	common	setdomainname		sys_setdomainname
+122	common	uname			sys_newuname
+# 123 was sys_modify_ldt
+124	common	adjtimex		sys_adjtimex_time32
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask
+# 127 was sys_create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was sys_get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_ni_syscall
+135	common	sysfs			sys_sysfs
+136	common	personality		sys_personality
+# 137 was sys_afs_syscall
+138	common	setfsuid		sys_setfsuid16
+139	common	setfsgid		sys_setfsgid16
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents
+142	common	_newselect		sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_ni_syscall
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	common	nanosleep		sys_nanosleep_time32
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid16
+165	common	getresuid		sys_getresuid16
+# 166 was sys_vm86
+# 167 was sys_query_module
+168	common	poll			sys_poll
+169	common	nfsservctl
+170	common	setresgid		sys_setresgid16
+171	common	getresgid		sys_getresgid16
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper
+174	common	rt_sigaction		sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend
+180	common	pread64			sys_pread64		sys_oabi_pread64
+181	common	pwrite64		sys_pwrite64		sys_oabi_pwrite64
+182	common	chown			sys_chown16
+183	common	getcwd			sys_getcwd
+184	common	capget			sys_capget
+185	common	capset			sys_capset
+186	common	sigaltstack		sys_sigaltstack
+187	common	sendfile		sys_sendfile
+# 188 reserved
+# 189 reserved
+190	common	vfork			sys_vfork
+# SuS compliant getrlimit
+191	common	ugetrlimit		sys_getrlimit
+192	common	mmap2			sys_mmap2
+193	common	truncate64		sys_truncate64		sys_oabi_truncate64
+194	common	ftruncate64		sys_ftruncate64		sys_oabi_ftruncate64
+195	common	stat64			sys_stat64		sys_oabi_stat64
+196	common	lstat64			sys_lstat64		sys_oabi_lstat64
+197	common	fstat64			sys_fstat64		sys_oabi_fstat64
+198	common	lchown32		sys_lchown
+199	common	getuid32		sys_getuid
+200	common	getgid32		sys_getgid
+201	common	geteuid32		sys_geteuid
+202	common	getegid32		sys_getegid
+203	common	setreuid32		sys_setreuid
+204	common	setregid32		sys_setregid
+205	common	getgroups32		sys_getgroups
+206	common	setgroups32		sys_setgroups
+207	common	fchown32		sys_fchown
+208	common	setresuid32		sys_setresuid
+209	common	getresuid32		sys_getresuid
+210	common	setresgid32		sys_setresgid
+211	common	getresgid32		sys_getresgid
+212	common	chown32			sys_chown
+213	common	setuid32		sys_setuid
+214	common	setgid32		sys_setgid
+215	common	setfsuid32		sys_setfsuid
+216	common	setfsgid32		sys_setfsgid
+217	common	getdents64		sys_getdents64
+218	common	pivot_root		sys_pivot_root
+219	common	mincore			sys_mincore
+220	common	madvise			sys_madvise
+221	common	fcntl64			sys_fcntl64		sys_oabi_fcntl64
+# 222 for tux
+# 223 is unused
+224	common	gettid			sys_gettid
+225	common	readahead		sys_readahead		sys_oabi_readahead
+226	common	setxattr		sys_setxattr
+227	common	lsetxattr		sys_lsetxattr
+228	common	fsetxattr		sys_fsetxattr
+229	common	getxattr		sys_getxattr
+230	common	lgetxattr		sys_lgetxattr
+231	common	fgetxattr		sys_fgetxattr
+232	common	listxattr		sys_listxattr
+233	common	llistxattr		sys_llistxattr
+234	common	flistxattr		sys_flistxattr
+235	common	removexattr		sys_removexattr
+236	common	lremovexattr		sys_lremovexattr
+237	common	fremovexattr		sys_fremovexattr
+238	common	tkill			sys_tkill
+239	common	sendfile64		sys_sendfile64
+240	common	futex			sys_futex_time32
+241	common	sched_setaffinity	sys_sched_setaffinity
+242	common	sched_getaffinity	sys_sched_getaffinity
+243	common	io_setup		sys_io_setup
+244	common	io_destroy		sys_io_destroy
+245	common	io_getevents		sys_io_getevents_time32
+246	common	io_submit		sys_io_submit
+247	common	io_cancel		sys_io_cancel
+248	common	exit_group		sys_exit_group
+249	common	lookup_dcookie		sys_ni_syscall
+250	common	epoll_create		sys_epoll_create
+251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
+252	common	epoll_wait		sys_epoll_wait
+253	common	remap_file_pages	sys_remap_file_pages
+# 254 for set_thread_area
+# 255 for get_thread_area
+256	common	set_tid_address		sys_set_tid_address
+257	common	timer_create		sys_timer_create
+258	common	timer_settime		sys_timer_settime32
+259	common	timer_gettime		sys_timer_gettime32
+260	common	timer_getoverrun	sys_timer_getoverrun
+261	common	timer_delete		sys_timer_delete
+262	common	clock_settime		sys_clock_settime32
+263	common	clock_gettime		sys_clock_gettime32
+264	common	clock_getres		sys_clock_getres_time32
+265	common	clock_nanosleep		sys_clock_nanosleep_time32
+266	common	statfs64		sys_statfs64_wrapper
+267	common	fstatfs64		sys_fstatfs64_wrapper
+268	common	tgkill			sys_tgkill
+269	common	utimes			sys_utimes_time32
+270	common	arm_fadvise64_64	sys_arm_fadvise64_64
+271	common	pciconfig_iobase	sys_pciconfig_iobase
+272	common	pciconfig_read		sys_pciconfig_read
+273	common	pciconfig_write		sys_pciconfig_write
+274	common	mq_open			sys_mq_open
+275	common	mq_unlink		sys_mq_unlink
+276	common	mq_timedsend		sys_mq_timedsend_time32
+277	common	mq_timedreceive		sys_mq_timedreceive_time32
+278	common	mq_notify		sys_mq_notify
+279	common	mq_getsetattr		sys_mq_getsetattr
+280	common	waitid			sys_waitid
+281	common	socket			sys_socket
+282	common	bind			sys_bind		sys_oabi_bind
+283	common	connect			sys_connect		sys_oabi_connect
+284	common	listen			sys_listen
+285	common	accept			sys_accept
+286	common	getsockname		sys_getsockname
+287	common	getpeername		sys_getpeername
+288	common	socketpair		sys_socketpair
+289	common	send			sys_send
+290	common	sendto			sys_sendto		sys_oabi_sendto
+291	common	recv			sys_recv
+292	common	recvfrom		sys_recvfrom
+293	common	shutdown		sys_shutdown
+294	common	setsockopt		sys_setsockopt
+295	common	getsockopt		sys_getsockopt
+296	common	sendmsg			sys_sendmsg		sys_oabi_sendmsg
+297	common	recvmsg			sys_recvmsg
+298	common	semop			sys_semop		sys_oabi_semop
+299	common	semget			sys_semget
+300	common	semctl			sys_old_semctl
+301	common	msgsnd			sys_msgsnd
+302	common	msgrcv			sys_msgrcv
+303	common	msgget			sys_msgget
+304	common	msgctl			sys_old_msgctl
+305	common	shmat			sys_shmat
+306	common	shmdt			sys_shmdt
+307	common	shmget			sys_shmget
+308	common	shmctl			sys_old_shmctl
+309	common	add_key			sys_add_key
+310	common	request_key		sys_request_key
+311	common	keyctl			sys_keyctl
+312	common	semtimedop		sys_semtimedop_time32	sys_oabi_semtimedop
+313	common	vserver
+314	common	ioprio_set		sys_ioprio_set
+315	common	ioprio_get		sys_ioprio_get
+316	common	inotify_init		sys_inotify_init
+317	common	inotify_add_watch	sys_inotify_add_watch
+318	common	inotify_rm_watch	sys_inotify_rm_watch
+319	common	mbind			sys_mbind
+320	common	get_mempolicy		sys_get_mempolicy
+321	common	set_mempolicy		sys_set_mempolicy
+322	common	openat			sys_openat
+323	common	mkdirat			sys_mkdirat
+324	common	mknodat			sys_mknodat
+325	common	fchownat		sys_fchownat
+326	common	futimesat		sys_futimesat_time32
+327	common	fstatat64		sys_fstatat64		sys_oabi_fstatat64
+328	common	unlinkat		sys_unlinkat
+329	common	renameat		sys_renameat
+330	common	linkat			sys_linkat
+331	common	symlinkat		sys_symlinkat
+332	common	readlinkat		sys_readlinkat
+333	common	fchmodat		sys_fchmodat
+334	common	faccessat		sys_faccessat
+335	common	pselect6		sys_pselect6_time32
+336	common	ppoll			sys_ppoll_time32
+337	common	unshare			sys_unshare
+338	common	set_robust_list		sys_set_robust_list
+339	common	get_robust_list		sys_get_robust_list
+340	common	splice			sys_splice
+341	common	arm_sync_file_range	sys_sync_file_range2
+342	common	tee			sys_tee
+343	common	vmsplice		sys_vmsplice
+344	common	move_pages		sys_move_pages
+345	common	getcpu			sys_getcpu
+346	common	epoll_pwait		sys_epoll_pwait
+347	common	kexec_load		sys_kexec_load
+348	common	utimensat		sys_utimensat_time32
+349	common	signalfd		sys_signalfd
+350	common	timerfd_create		sys_timerfd_create
+351	common	eventfd			sys_eventfd
+352	common	fallocate		sys_fallocate
+353	common	timerfd_settime		sys_timerfd_settime32
+354	common	timerfd_gettime		sys_timerfd_gettime32
+355	common	signalfd4		sys_signalfd4
+356	common	eventfd2		sys_eventfd2
+357	common	epoll_create1		sys_epoll_create1
+358	common	dup3			sys_dup3
+359	common	pipe2			sys_pipe2
+360	common	inotify_init1		sys_inotify_init1
+361	common	preadv			sys_preadv
+362	common	pwritev			sys_pwritev
+363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
+364	common	perf_event_open		sys_perf_event_open
+365	common	recvmmsg		sys_recvmmsg_time32
+366	common	accept4			sys_accept4
+367	common	fanotify_init		sys_fanotify_init
+368	common	fanotify_mark		sys_fanotify_mark
+369	common	prlimit64		sys_prlimit64
+370	common	name_to_handle_at	sys_name_to_handle_at
+371	common	open_by_handle_at	sys_open_by_handle_at
+372	common	clock_adjtime		sys_clock_adjtime32
+373	common	syncfs			sys_syncfs
+374	common	sendmmsg		sys_sendmmsg
+375	common	setns			sys_setns
+376	common	process_vm_readv	sys_process_vm_readv
+377	common	process_vm_writev	sys_process_vm_writev
+378	common	kcmp			sys_kcmp
+379	common	finit_module		sys_finit_module
+380	common	sched_setattr		sys_sched_setattr
+381	common	sched_getattr		sys_sched_getattr
+382	common	renameat2		sys_renameat2
+383	common	seccomp			sys_seccomp
+384	common	getrandom		sys_getrandom
+385	common	memfd_create		sys_memfd_create
+386	common	bpf			sys_bpf
+387	common	execveat		sys_execveat
+388	common	userfaultfd		sys_userfaultfd
+389	common	membarrier		sys_membarrier
+390	common	mlock2			sys_mlock2
+391	common	copy_file_range		sys_copy_file_range
+392	common	preadv2			sys_preadv2
+393	common	pwritev2		sys_pwritev2
+394	common	pkey_mprotect		sys_pkey_mprotect
+395	common	pkey_alloc		sys_pkey_alloc
+396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
+398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents_time32
+400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat
diff --git a/tools/perf/arch/arm/include/syscall_table.h b/tools/perf/arch/arm/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/arm/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 692f48db810ccbef229e240db29261f0c60db632..542f3bee1501c751a831df460c4e585ab756c8fc 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -202,6 +202,7 @@ check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscall
 check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
+check_2 tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
 
 for i in "${BEAUTY_FILES[@]}"
 do

-- 
2.34.1


