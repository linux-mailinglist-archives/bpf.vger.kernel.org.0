Return-Path: <bpf+bounces-48337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F0A06B6A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A573A2F0D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45119ADB0;
	Thu,  9 Jan 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="deIavcs0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE911925B6
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390223; cv=none; b=ocsX7cVhf/0/VedTywK1NG4XI5+dPcsDyJs3J7bnwpwMbgXaZLUh6EfS2ueUWpg2hueACxZl5i8LhBBL/NiKSK+Y3pmRJ5PXEy8omIN0owILKU+iVsk0ezJNngV6J9owWs/yeNFCAjYPNSPAbD00EthXgXZIfiwiS77Hj0j1dGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390223; c=relaxed/simple;
	bh=P5khRSBJp5bYReCT1sBp0+W+8QWeQmxCCUUT+nXFbVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iF+/S18CpsGB9j3KywMxtFPKEKI/fRHa9atbphEMcFgyPJ/Wx6qmDuEekxg6NSHmYOcCqVTyio020iyQKkYrKd3O14HlgJVGEvMlcb1avTffWKi3r27H/04nUb3bJzW/WabJWlwOnPxp1Eh0v/Pyi5k76EMKxcZKKiZxUD9pU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=deIavcs0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21634338cfdso7872995ad.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390218; x=1736995018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7jIPtWb6k+BeNxt+CRSlpLVlBypEB4ZorhyWeuJAi8=;
        b=deIavcs0uOuNiCYCpOaR4KHuJKHTPOBx3xCeyvsjxCLWG19Mnqgpbu+g8DR0Ah7pqo
         V/r9yp4QZ9AJEFZMGHkpef/JOhx+5ulZK9xuBb9cvfMGp5xALlLKtOFNtDqu4oCJUO/n
         B6e/fgljznrXgJnAzcSGra/2NKnRohAcqUOn3J2eFH0LmTNIw4gx010RekIAsPF/wZxh
         j3eunsEnIwlE9ubOdcNj/VeyAw0zMRipptEyGXwLNYO7FXMBnMLaYlkEGP9SHlxqoL3H
         cPdtLCRXngAgudOs42YuFr8vZSZfFXYEKZolRcHYtrZKSIjo2xPxmb2tqrch1v3ggRBb
         coIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390218; x=1736995018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7jIPtWb6k+BeNxt+CRSlpLVlBypEB4ZorhyWeuJAi8=;
        b=JMUFOnL6+KpNHCIFiDGZBI98oiMLAhYay11c+F5/23Y17HWN5nvdpdDJc5warcIFFF
         jK5gAwixVlp8TR7KpTmPOgXx/t+5BdFnUSC58RwU7y7UssxESzej3vDCknnMftJeT8yz
         +1ZDv6ZZzbuXltvG5F+zb4mYoHZXveqyftsRo93eIU+l+6psZbb1StrBMgbWCrDBBIvt
         eRlfWXUVkCMskO/k6jNIEjdCMyTNyBmKxDB9+AXHEbJyIABcN4Hx0JmLAIjhKyxlDQAR
         yZNrWAKB1ErabWvqMiZs1iQxpomrcjg9gE2wWehOeFbB1OLnANuZhWY/aBw1JuZxYxoa
         l/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSuov55aNE4ar/3N/7gYngJxH/O8YZUL1B9N+Ztu7/m58ah6zhbfFPFVnYChSAyx3G5Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eFEvKXa4Hj46T3T2MIx1AVvE/Ffi0wAcd+TQa9NE0mBs5no3
	E+AXJF75BdxOADtlISGR7ToRJ1fYdUDd5ZV+XrSt2mNmIrcL+Yh5x4P+otbcamc=
X-Gm-Gg: ASbGncsZbjGnCC0iPKrfM+/AjcvtlZPzpv0rubmlej1ZmjbDSGfnJ0l3ZCznoHKPRjB
	UJJDwd7kIblIDjV/+05/qzSSMY7H1SHzqLIvJhgCdwiEtpuvktYkXM1xXAgmVFh5ZR1288aAvo+
	lzbO4x/cFwp0KYY+wzI8xBjj5CbhxVUpL2BESKcWI4wYJflqsRY8EtlDjKvmrxXSozGUm/GTdhT
	XdVy/r9Tb50SwmmbPGXF8JMrRqFRh4GOsqdf5HQsx8aDocg2kKIrTDtupUSIaUi5i8VRSSi
X-Google-Smtp-Source: AGHT+IGAxz11TIXQNhytMh1v/VSZfTj3CgNKIWsv0QH0VjwCOlx4sbemFAK4/8RqpQTUb2x8Xy4f5g==
X-Received: by 2002:a17:902:d2c2:b0:21a:87d1:168a with SMTP id d9443c01a7336-21a87d11b43mr55082905ad.41.1736390218433;
        Wed, 08 Jan 2025 18:36:58 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:36:57 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:24 -0800
Subject: [PATCH v6 09/16] perf tools: alpha: Support syscall header
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-9-7543b5293098@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23802; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=P5khRSBJp5bYReCT1sBp0+W+8QWeQmxCCUUT+nXFbVw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9ma5PQibPicjSqlWGidtu5Yj815y1x1beN+RrGy//v
 00lunkdpSwMYhwMsmKKLDzXGphb7+iXHRUtmwAzh5UJZAgDF6cATKRkCiPDeSO5Z9dqV8+U1Drf
 9u0594vHdqon2aOPXwv8qZf28C4DIyPDd5dt02Utamq3bbDb03X4wN+V56JO2nzpL5gjcTbtTZ8
 6MwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

alpha uses a syscall table, use that in perf instead of requiring
libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 +++++++++++++++++++++
 tools/perf/arch/alpha/include/syscall_table.h      |   2 +
 tools/perf/check-headers.sh                        |   1 +
 6 files changed, 515 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 51282ee096f53718c8311a392a410b4e580cb76b..06fa8332baa638bd8b46515bd3d464489a27efda 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/alpha/entry/syscalls/Kbuild b/tools/perf/arch/alpha/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/alpha/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls b/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..690168aac34db9f1b96346210993675defcfc300
--- /dev/null
+++ b/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64  +=
+
+syscalltbl = $(srctree)/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/alpha/entry/syscalls/syscall.tbl b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
new file mode 100644
index 0000000000000000000000000000000000000000..74720667fe091768800a22fd4ce68b5324abff09
--- /dev/null
+++ b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
@@ -0,0 +1,504 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for alpha
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "common" for this file
+#
+0	common	osf_syscall			alpha_syscall_zero
+1	common	exit				sys_exit
+2	common	fork				alpha_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	osf_old_open			sys_ni_syscall
+6	common	close				sys_close
+7	common	osf_wait4			sys_osf_wait4
+8	common	osf_old_creat			sys_ni_syscall
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	common	osf_execve			sys_ni_syscall
+12	common	chdir				sys_chdir
+13	common	fchdir				sys_fchdir
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	chown				sys_chown
+17	common	brk				sys_osf_brk
+18	common	osf_getfsstat			sys_ni_syscall
+19	common	lseek				sys_lseek
+20	common	getxpid				sys_getxpid
+21	common	osf_mount			sys_osf_mount
+22	common	umount2				sys_umount
+23	common	setuid				sys_setuid
+24	common	getxuid				sys_getxuid
+25	common	exec_with_loader		sys_ni_syscall
+26	common	ptrace				sys_ptrace
+27	common	osf_nrecvmsg			sys_ni_syscall
+28	common	osf_nsendmsg			sys_ni_syscall
+29	common	osf_nrecvfrom			sys_ni_syscall
+30	common	osf_naccept			sys_ni_syscall
+31	common	osf_ngetpeername		sys_ni_syscall
+32	common	osf_ngetsockname		sys_ni_syscall
+33	common	access				sys_access
+34	common	osf_chflags			sys_ni_syscall
+35	common	osf_fchflags			sys_ni_syscall
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	osf_old_stat			sys_ni_syscall
+39	common	setpgid				sys_setpgid
+40	common	osf_old_lstat			sys_ni_syscall
+41	common	dup				sys_dup
+42	common	pipe				sys_alpha_pipe
+43	common	osf_set_program_attributes	sys_osf_set_program_attributes
+44	common	osf_profil			sys_ni_syscall
+45	common	open				sys_open
+46	common	osf_old_sigaction		sys_ni_syscall
+47	common	getxgid				sys_getxgid
+48	common	osf_sigprocmask			sys_osf_sigprocmask
+49	common	osf_getlogin			sys_ni_syscall
+50	common	osf_setlogin			sys_ni_syscall
+51	common	acct				sys_acct
+52	common	sigpending			sys_sigpending
+54	common	ioctl				sys_ioctl
+55	common	osf_reboot			sys_ni_syscall
+56	common	osf_revoke			sys_ni_syscall
+57	common	symlink				sys_symlink
+58	common	readlink			sys_readlink
+59	common	execve				sys_execve
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	osf_old_fstat			sys_ni_syscall
+63	common	getpgrp				sys_getpgrp
+64	common	getpagesize			sys_getpagesize
+65	common	osf_mremap			sys_ni_syscall
+66	common	vfork				alpha_vfork
+67	common	stat				sys_newstat
+68	common	lstat				sys_newlstat
+69	common	osf_sbrk			sys_ni_syscall
+70	common	osf_sstk			sys_ni_syscall
+71	common	mmap				sys_osf_mmap
+72	common	osf_old_vadvise			sys_ni_syscall
+73	common	munmap				sys_munmap
+74	common	mprotect			sys_mprotect
+75	common	madvise				sys_madvise
+76	common	vhangup				sys_vhangup
+77	common	osf_kmodcall			sys_ni_syscall
+78	common	osf_mincore			sys_ni_syscall
+79	common	getgroups			sys_getgroups
+80	common	setgroups			sys_setgroups
+81	common	osf_old_getpgrp			sys_ni_syscall
+82	common	setpgrp				sys_setpgid
+83	common	osf_setitimer			compat_sys_setitimer
+84	common	osf_old_wait			sys_ni_syscall
+85	common	osf_table			sys_ni_syscall
+86	common	osf_getitimer			compat_sys_getitimer
+87	common	gethostname			sys_gethostname
+88	common	sethostname			sys_sethostname
+89	common	getdtablesize			sys_getdtablesize
+90	common	dup2				sys_dup2
+91	common	fstat				sys_newfstat
+92	common	fcntl				sys_fcntl
+93	common	osf_select			sys_osf_select
+94	common	poll				sys_poll
+95	common	fsync				sys_fsync
+96	common	setpriority			sys_setpriority
+97	common	socket				sys_socket
+98	common	connect				sys_connect
+99	common	accept				sys_accept
+100	common	getpriority			sys_osf_getpriority
+101	common	send				sys_send
+102	common	recv				sys_recv
+103	common	sigreturn			sys_sigreturn
+104	common	bind				sys_bind
+105	common	setsockopt			sys_setsockopt
+106	common	listen				sys_listen
+107	common	osf_plock			sys_ni_syscall
+108	common	osf_old_sigvec			sys_ni_syscall
+109	common	osf_old_sigblock		sys_ni_syscall
+110	common	osf_old_sigsetmask		sys_ni_syscall
+111	common	sigsuspend			sys_sigsuspend
+112	common	osf_sigstack			sys_osf_sigstack
+113	common	recvmsg				sys_recvmsg
+114	common	sendmsg				sys_sendmsg
+115	common	osf_old_vtrace			sys_ni_syscall
+116	common	osf_gettimeofday		sys_osf_gettimeofday
+117	common	osf_getrusage			sys_osf_getrusage
+118	common	getsockopt			sys_getsockopt
+120	common	readv				sys_readv
+121	common	writev				sys_writev
+122	common	osf_settimeofday		sys_osf_settimeofday
+123	common	fchown				sys_fchown
+124	common	fchmod				sys_fchmod
+125	common	recvfrom			sys_recvfrom
+126	common	setreuid			sys_setreuid
+127	common	setregid			sys_setregid
+128	common	rename				sys_rename
+129	common	truncate			sys_truncate
+130	common	ftruncate			sys_ftruncate
+131	common	flock				sys_flock
+132	common	setgid				sys_setgid
+133	common	sendto				sys_sendto
+134	common	shutdown			sys_shutdown
+135	common	socketpair			sys_socketpair
+136	common	mkdir				sys_mkdir
+137	common	rmdir				sys_rmdir
+138	common	osf_utimes			sys_osf_utimes
+139	common	osf_old_sigreturn		sys_ni_syscall
+140	common	osf_adjtime			sys_ni_syscall
+141	common	getpeername			sys_getpeername
+142	common	osf_gethostid			sys_ni_syscall
+143	common	osf_sethostid			sys_ni_syscall
+144	common	getrlimit			sys_getrlimit
+145	common	setrlimit			sys_setrlimit
+146	common	osf_old_killpg			sys_ni_syscall
+147	common	setsid				sys_setsid
+148	common	quotactl			sys_quotactl
+149	common	osf_oldquota			sys_ni_syscall
+150	common	getsockname			sys_getsockname
+153	common	osf_pid_block			sys_ni_syscall
+154	common	osf_pid_unblock			sys_ni_syscall
+156	common	sigaction			sys_osf_sigaction
+157	common	osf_sigwaitprim			sys_ni_syscall
+158	common	osf_nfssvc			sys_ni_syscall
+159	common	osf_getdirentries		sys_osf_getdirentries
+160	common	osf_statfs			sys_osf_statfs
+161	common	osf_fstatfs			sys_osf_fstatfs
+163	common	osf_asynch_daemon		sys_ni_syscall
+164	common	osf_getfh			sys_ni_syscall
+165	common	osf_getdomainname		sys_osf_getdomainname
+166	common	setdomainname			sys_setdomainname
+169	common	osf_exportfs			sys_ni_syscall
+181	common	osf_alt_plock			sys_ni_syscall
+184	common	osf_getmnt			sys_ni_syscall
+187	common	osf_alt_sigpending		sys_ni_syscall
+188	common	osf_alt_setsid			sys_ni_syscall
+199	common	osf_swapon			sys_swapon
+200	common	msgctl				sys_old_msgctl
+201	common	msgget				sys_msgget
+202	common	msgrcv				sys_msgrcv
+203	common	msgsnd				sys_msgsnd
+204	common	semctl				sys_old_semctl
+205	common	semget				sys_semget
+206	common	semop				sys_semop
+207	common	osf_utsname			sys_osf_utsname
+208	common	lchown				sys_lchown
+209	common	shmat				sys_shmat
+210	common	shmctl				sys_old_shmctl
+211	common	shmdt				sys_shmdt
+212	common	shmget				sys_shmget
+213	common	osf_mvalid			sys_ni_syscall
+214	common	osf_getaddressconf		sys_ni_syscall
+215	common	osf_msleep			sys_ni_syscall
+216	common	osf_mwakeup			sys_ni_syscall
+217	common	msync				sys_msync
+218	common	osf_signal			sys_ni_syscall
+219	common	osf_utc_gettime			sys_ni_syscall
+220	common	osf_utc_adjtime			sys_ni_syscall
+222	common	osf_security			sys_ni_syscall
+223	common	osf_kloadcall			sys_ni_syscall
+224	common	osf_stat			sys_osf_stat
+225	common	osf_lstat			sys_osf_lstat
+226	common	osf_fstat			sys_osf_fstat
+227	common	osf_statfs64			sys_osf_statfs64
+228	common	osf_fstatfs64			sys_osf_fstatfs64
+233	common	getpgid				sys_getpgid
+234	common	getsid				sys_getsid
+235	common	sigaltstack			sys_sigaltstack
+236	common	osf_waitid			sys_ni_syscall
+237	common	osf_priocntlset			sys_ni_syscall
+238	common	osf_sigsendset			sys_ni_syscall
+239	common	osf_set_speculative		sys_ni_syscall
+240	common	osf_msfs_syscall		sys_ni_syscall
+241	common	osf_sysinfo			sys_osf_sysinfo
+242	common	osf_uadmin			sys_ni_syscall
+243	common	osf_fuser			sys_ni_syscall
+244	common	osf_proplist_syscall		sys_osf_proplist_syscall
+245	common	osf_ntp_adjtime			sys_ni_syscall
+246	common	osf_ntp_gettime			sys_ni_syscall
+247	common	osf_pathconf			sys_ni_syscall
+248	common	osf_fpathconf			sys_ni_syscall
+250	common	osf_uswitch			sys_ni_syscall
+251	common	osf_usleep_thread		sys_osf_usleep_thread
+252	common	osf_audcntl			sys_ni_syscall
+253	common	osf_audgen			sys_ni_syscall
+254	common	sysfs				sys_sysfs
+255	common	osf_subsys_info			sys_ni_syscall
+256	common	osf_getsysinfo			sys_osf_getsysinfo
+257	common	osf_setsysinfo			sys_osf_setsysinfo
+258	common	osf_afs_syscall			sys_ni_syscall
+259	common	osf_swapctl			sys_ni_syscall
+260	common	osf_memcntl			sys_ni_syscall
+261	common	osf_fdatasync			sys_ni_syscall
+300	common	bdflush				sys_ni_syscall
+301	common	sethae				sys_sethae
+302	common	mount				sys_mount
+303	common	old_adjtimex			sys_old_adjtimex
+304	common	swapoff				sys_swapoff
+305	common	getdents			sys_getdents
+306	common	create_module			sys_ni_syscall
+307	common	init_module			sys_init_module
+308	common	delete_module			sys_delete_module
+309	common	get_kernel_syms			sys_ni_syscall
+310	common	syslog				sys_syslog
+311	common	reboot				sys_reboot
+312	common	clone				alpha_clone
+313	common	uselib				sys_uselib
+314	common	mlock				sys_mlock
+315	common	munlock				sys_munlock
+316	common	mlockall			sys_mlockall
+317	common	munlockall			sys_munlockall
+318	common	sysinfo				sys_sysinfo
+319	common	_sysctl				sys_ni_syscall
+# 320 was sys_idle
+321	common	oldumount			sys_oldumount
+322	common	swapon				sys_swapon
+323	common	times				sys_times
+324	common	personality			sys_personality
+325	common	setfsuid			sys_setfsuid
+326	common	setfsgid			sys_setfsgid
+327	common	ustat				sys_ustat
+328	common	statfs				sys_statfs
+329	common	fstatfs				sys_fstatfs
+330	common	sched_setparam			sys_sched_setparam
+331	common	sched_getparam			sys_sched_getparam
+332	common	sched_setscheduler		sys_sched_setscheduler
+333	common	sched_getscheduler		sys_sched_getscheduler
+334	common	sched_yield			sys_sched_yield
+335	common	sched_get_priority_max		sys_sched_get_priority_max
+336	common	sched_get_priority_min		sys_sched_get_priority_min
+337	common	sched_rr_get_interval		sys_sched_rr_get_interval
+338	common	afs_syscall			sys_ni_syscall
+339	common	uname				sys_newuname
+340	common	nanosleep			sys_nanosleep
+341	common	mremap				sys_mremap
+342	common	nfsservctl			sys_ni_syscall
+343	common	setresuid			sys_setresuid
+344	common	getresuid			sys_getresuid
+345	common	pciconfig_read			sys_pciconfig_read
+346	common	pciconfig_write			sys_pciconfig_write
+347	common	query_module			sys_ni_syscall
+348	common	prctl				sys_prctl
+349	common	pread64				sys_pread64
+350	common	pwrite64			sys_pwrite64
+351	common	rt_sigreturn			sys_rt_sigreturn
+352	common	rt_sigaction			sys_rt_sigaction
+353	common	rt_sigprocmask			sys_rt_sigprocmask
+354	common	rt_sigpending			sys_rt_sigpending
+355	common	rt_sigtimedwait			sys_rt_sigtimedwait
+356	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+357	common	rt_sigsuspend			sys_rt_sigsuspend
+358	common	select				sys_select
+359	common	gettimeofday			sys_gettimeofday
+360	common	settimeofday			sys_settimeofday
+361	common	getitimer			sys_getitimer
+362	common	setitimer			sys_setitimer
+363	common	utimes				sys_utimes
+364	common	getrusage			sys_getrusage
+365	common	wait4				sys_wait4
+366	common	adjtimex			sys_adjtimex
+367	common	getcwd				sys_getcwd
+368	common	capget				sys_capget
+369	common	capset				sys_capset
+370	common	sendfile			sys_sendfile64
+371	common	setresgid			sys_setresgid
+372	common	getresgid			sys_getresgid
+373	common	dipc				sys_ni_syscall
+374	common	pivot_root			sys_pivot_root
+375	common	mincore				sys_mincore
+376	common	pciconfig_iobase		sys_pciconfig_iobase
+377	common	getdents64			sys_getdents64
+378	common	gettid				sys_gettid
+379	common	readahead			sys_readahead
+# 380 is unused
+381	common	tkill				sys_tkill
+382	common	setxattr			sys_setxattr
+383	common	lsetxattr			sys_lsetxattr
+384	common	fsetxattr			sys_fsetxattr
+385	common	getxattr			sys_getxattr
+386	common	lgetxattr			sys_lgetxattr
+387	common	fgetxattr			sys_fgetxattr
+388	common	listxattr			sys_listxattr
+389	common	llistxattr			sys_llistxattr
+390	common	flistxattr			sys_flistxattr
+391	common	removexattr			sys_removexattr
+392	common	lremovexattr			sys_lremovexattr
+393	common	fremovexattr			sys_fremovexattr
+394	common	futex				sys_futex
+395	common	sched_setaffinity		sys_sched_setaffinity
+396	common	sched_getaffinity		sys_sched_getaffinity
+397	common	tuxcall				sys_ni_syscall
+398	common	io_setup			sys_io_setup
+399	common	io_destroy			sys_io_destroy
+400	common	io_getevents			sys_io_getevents
+401	common	io_submit			sys_io_submit
+402	common	io_cancel			sys_io_cancel
+405	common	exit_group			sys_exit_group
+406	common	lookup_dcookie			sys_ni_syscall
+407	common	epoll_create			sys_epoll_create
+408	common	epoll_ctl			sys_epoll_ctl
+409	common	epoll_wait			sys_epoll_wait
+410	common	remap_file_pages		sys_remap_file_pages
+411	common	set_tid_address			sys_set_tid_address
+412	common	restart_syscall			sys_restart_syscall
+413	common	fadvise64			sys_fadvise64
+414	common	timer_create			sys_timer_create
+415	common	timer_settime			sys_timer_settime
+416	common	timer_gettime			sys_timer_gettime
+417	common	timer_getoverrun		sys_timer_getoverrun
+418	common	timer_delete			sys_timer_delete
+419	common	clock_settime			sys_clock_settime
+420	common	clock_gettime			sys_clock_gettime
+421	common	clock_getres			sys_clock_getres
+422	common	clock_nanosleep			sys_clock_nanosleep
+423	common	semtimedop			sys_semtimedop
+424	common	tgkill				sys_tgkill
+425	common	stat64				sys_stat64
+426	common	lstat64				sys_lstat64
+427	common	fstat64				sys_fstat64
+428	common	vserver				sys_ni_syscall
+429	common	mbind				sys_ni_syscall
+430	common	get_mempolicy			sys_ni_syscall
+431	common	set_mempolicy			sys_ni_syscall
+432	common	mq_open				sys_mq_open
+433	common	mq_unlink			sys_mq_unlink
+434	common	mq_timedsend			sys_mq_timedsend
+435	common	mq_timedreceive			sys_mq_timedreceive
+436	common	mq_notify			sys_mq_notify
+437	common	mq_getsetattr			sys_mq_getsetattr
+438	common	waitid				sys_waitid
+439	common	add_key				sys_add_key
+440	common	request_key			sys_request_key
+441	common	keyctl				sys_keyctl
+442	common	ioprio_set			sys_ioprio_set
+443	common	ioprio_get			sys_ioprio_get
+444	common	inotify_init			sys_inotify_init
+445	common	inotify_add_watch		sys_inotify_add_watch
+446	common	inotify_rm_watch		sys_inotify_rm_watch
+447	common	fdatasync			sys_fdatasync
+448	common	kexec_load			sys_kexec_load
+449	common	migrate_pages			sys_migrate_pages
+450	common	openat				sys_openat
+451	common	mkdirat				sys_mkdirat
+452	common	mknodat				sys_mknodat
+453	common	fchownat			sys_fchownat
+454	common	futimesat			sys_futimesat
+455	common	fstatat64			sys_fstatat64
+456	common	unlinkat			sys_unlinkat
+457	common	renameat			sys_renameat
+458	common	linkat				sys_linkat
+459	common	symlinkat			sys_symlinkat
+460	common	readlinkat			sys_readlinkat
+461	common	fchmodat			sys_fchmodat
+462	common	faccessat			sys_faccessat
+463	common	pselect6			sys_pselect6
+464	common	ppoll				sys_ppoll
+465	common	unshare				sys_unshare
+466	common	set_robust_list			sys_set_robust_list
+467	common	get_robust_list			sys_get_robust_list
+468	common	splice				sys_splice
+469	common	sync_file_range			sys_sync_file_range
+470	common	tee				sys_tee
+471	common	vmsplice			sys_vmsplice
+472	common	move_pages			sys_move_pages
+473	common	getcpu				sys_getcpu
+474	common	epoll_pwait			sys_epoll_pwait
+475	common	utimensat			sys_utimensat
+476	common	signalfd			sys_signalfd
+477	common	timerfd				sys_ni_syscall
+478	common	eventfd				sys_eventfd
+479	common	recvmmsg			sys_recvmmsg
+480	common	fallocate			sys_fallocate
+481	common	timerfd_create			sys_timerfd_create
+482	common	timerfd_settime			sys_timerfd_settime
+483	common	timerfd_gettime			sys_timerfd_gettime
+484	common	signalfd4			sys_signalfd4
+485	common	eventfd2			sys_eventfd2
+486	common	epoll_create1			sys_epoll_create1
+487	common	dup3				sys_dup3
+488	common	pipe2				sys_pipe2
+489	common	inotify_init1			sys_inotify_init1
+490	common	preadv				sys_preadv
+491	common	pwritev				sys_pwritev
+492	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+493	common	perf_event_open			sys_perf_event_open
+494	common	fanotify_init			sys_fanotify_init
+495	common	fanotify_mark			sys_fanotify_mark
+496	common	prlimit64			sys_prlimit64
+497	common	name_to_handle_at		sys_name_to_handle_at
+498	common	open_by_handle_at		sys_open_by_handle_at
+499	common	clock_adjtime			sys_clock_adjtime
+500	common	syncfs				sys_syncfs
+501	common	setns				sys_setns
+502	common	accept4				sys_accept4
+503	common	sendmmsg			sys_sendmmsg
+504	common	process_vm_readv		sys_process_vm_readv
+505	common	process_vm_writev		sys_process_vm_writev
+506	common	kcmp				sys_kcmp
+507	common	finit_module			sys_finit_module
+508	common	sched_setattr			sys_sched_setattr
+509	common	sched_getattr			sys_sched_getattr
+510	common	renameat2			sys_renameat2
+511	common	getrandom			sys_getrandom
+512	common	memfd_create			sys_memfd_create
+513	common	execveat			sys_execveat
+514	common	seccomp				sys_seccomp
+515	common	bpf				sys_bpf
+516	common	userfaultfd			sys_userfaultfd
+517	common	membarrier			sys_membarrier
+518	common	mlock2				sys_mlock2
+519	common	copy_file_range			sys_copy_file_range
+520	common	preadv2				sys_preadv2
+521	common	pwritev2			sys_pwritev2
+522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
+524	common	pkey_mprotect			sys_pkey_mprotect
+525	common	pkey_alloc			sys_pkey_alloc
+526	common	pkey_free			sys_pkey_free
+527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
+# all other architectures have common numbers for new syscall, alpha
+# is the exception.
+534	common	pidfd_send_signal		sys_pidfd_send_signal
+535	common	io_uring_setup			sys_io_uring_setup
+536	common	io_uring_enter			sys_io_uring_enter
+537	common	io_uring_register		sys_io_uring_register
+538	common	open_tree			sys_open_tree
+539	common	move_mount			sys_move_mount
+540	common	fsopen				sys_fsopen
+541	common	fsconfig			sys_fsconfig
+542	common	fsmount				sys_fsmount
+543	common	fspick				sys_fspick
+544	common	pidfd_open			sys_pidfd_open
+545	common	clone3				alpha_clone3
+546	common	close_range			sys_close_range
+547	common	openat2				sys_openat2
+548	common	pidfd_getfd			sys_pidfd_getfd
+549	common	faccessat2			sys_faccessat2
+550	common	process_madvise			sys_process_madvise
+551	common	epoll_pwait2			sys_epoll_pwait2
+552	common	mount_setattr			sys_mount_setattr
+553	common	quotactl_fd			sys_quotactl_fd
+554	common	landlock_create_ruleset		sys_landlock_create_ruleset
+555	common	landlock_add_rule		sys_landlock_add_rule
+556	common	landlock_restrict_self		sys_landlock_restrict_self
+# 557 reserved for memfd_secret
+558	common	process_mrelease		sys_process_mrelease
+559	common  futex_waitv                     sys_futex_waitv
+560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	cachestat			sys_cachestat
+562	common	fchmodat2			sys_fchmodat2
+563	common	map_shadow_stack		sys_map_shadow_stack
+564	common	futex_wake			sys_futex_wake
+565	common	futex_wait			sys_futex_wait
+566	common	futex_requeue			sys_futex_requeue
+567	common	statmount			sys_statmount
+568	common	listmount			sys_listmount
+569	common	lsm_get_self_attr		sys_lsm_get_self_attr
+570	common	lsm_set_self_attr		sys_lsm_set_self_attr
+571	common	lsm_list_modules		sys_lsm_list_modules
+572	common  mseal				sys_mseal
diff --git a/tools/perf/arch/alpha/include/syscall_table.h b/tools/perf/arch/alpha/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/alpha/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e9e352579e6d33085a1d863441432c81d2353f49..a821df1fd4c0e78c9706304e5b8974cbc5ef4437 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -206,6 +206,7 @@ check_2 tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tb
 check_2 tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl
+check_2 tools/perf/arch/alpha/entry/syscalls/syscall.tbl arch/alpha/entry/syscalls/syscall.tbl
 
 for i in "${BEAUTY_FILES[@]}"
 do

-- 
2.34.1


