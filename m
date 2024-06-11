Return-Path: <bpf+bounces-31844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2711B903F44
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E2A1C216D2
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6812E7F;
	Tue, 11 Jun 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic/BOeqV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EA11712;
	Tue, 11 Jun 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117639; cv=none; b=VBB7sBrrFfsBZq9X1I9xEBLtvb617S9yV6DtOKLB/Liosrr8ARzERDctXEiOfefWxNLNi4GmLWhDQSGP2wSsCP11UnKa2NRLgjKIceXPem4Mf7qJzyYXdyokguVTN2kFasFTn7OAKQwM7mTub/KzyJErCN7FkhHtfmKMUyrccew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117639; c=relaxed/simple;
	bh=ZzSZpf/GI/3KLyUrgN1e5daeegCfTTeMo9Fq+wptzdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG66vcH/RJBa/b+H5txIJl38l4BKpWzQ97X/NDW1s/1YcoGmouP90iemOqILLzOMFMENSI34tTHLAokokcz8qlgvT//E57olaqm+lk3UNN4rad6vnEAW9y93jcipQtcogKhgpSH5Ae8finH/wSTcd/pITgfOHuj57b7oObeChFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic/BOeqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622F2C2BD10;
	Tue, 11 Jun 2024 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117638;
	bh=ZzSZpf/GI/3KLyUrgN1e5daeegCfTTeMo9Fq+wptzdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ic/BOeqVSiWVkhSkUeWwoH2eQXR66XJ00/cm8HgjdorHAjZ7JeXFJUmixkZN49V0x
	 oUA3tjCvfD0ygsyFAA76N8+s8TcYPvVOdaGBsgT1xdG9g1vUwH1sJyfH/t0iFgd1cR
	 3Hszxe/bQko0+df5uMVnSrvft2MwbAbsQnqZP4wEkKYfn65f42/49OaN5Wj8qrugNf
	 dzp9GMZku3xxii599qFSAMrJm6yu0JDpLawCjsIPw26OxDiuhrI3+rPw6lx341HTlq
	 cE12/Fe4R/+r0s2e7aPOvhbttk1mjukZVvm9/kY7w+Yh2udjlIvH8ieM5Lrbrx/ZTK
	 uSLDLEvrp1E1g==
Date: Tue, 11 Jun 2024 11:53:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	brauner@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
Message-ID: <ZmhlAxbVcAKoPTg8@x1>
References: <20240608172147.2779890-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240608172147.2779890-1-howardchu95@gmail.com>

On Sun, Jun 09, 2024 at 01:21:46AM +0800, Howard Chu wrote:
> This is a bug found when implementing pretty-printing for the
> landlock_add_rule system call, I decided to send this patch separately
> because this is a serious bug that should be fixed fast.
 
> I wrote a test program to do landlock_add_rule syscall in a loop,
> yet perf trace -e landlock_add_rule freezes, giving no output.
 
> This bug is introduced by the false understanding of the variable "key"
> below:
> ```
> for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> 	struct syscall *sc = trace__syscall_info(trace, NULL, key);
> 	...
> }
> ```
> The code above seems right at the beginning, but when looking at
> syscalltbl.c, I found these lines:
> 
> ```
> for (i = 0; i <= syscalltbl_native_max_id; ++i)
> 	if (syscalltbl_native[i])
> 		++nr_entries;
> 
> entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
> ...
> 
> for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
> 	if (syscalltbl_native[i]) {
> 		entries[j].name = syscalltbl_native[i];
> 		entries[j].id = i;
> 		++j;
> 	}
> }
> ```
> 
> meaning the key is merely an index to traverse the syscall table,
> instead of the actual syscall id for this particular syscall.

> So if one uses key to do trace__syscall_info(trace, NULL, key), because
> key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
> my X86_64 machine, this number is 373, it will end up neglecting all
> the rest of the syscall, in my case, everything after `rseq`, because
> the traversal will stop at 373, and `rseq` is the last syscall whose id
> is lower than 373
 
> in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
> ```
> 	...
> 	[334] = "rseq",
> 	[424] = "pidfd_send_signal",
> 	...
> ```
> 
> The reason why the key is scrambled but perf trace works well is that
> key is used in trace__syscall_info(trace, NULL, key) to do
> trace->syscalls.table[id], this makes sure that the struct syscall returned
> actually has an id the same value as key, making the later bpf_prog
> matching all correct.

Right, trace->syscalls.table holds info read from tracefs, while
trace->sctbl holds info created from per-arch syscall tables, usually
from:

⬢[acme@toolbox perf-tools-next]$ find arch -name "*.tbl"
arch/alpha/kernel/syscalls/syscall.tbl
arch/arm/tools/syscall.tbl
arch/m68k/kernel/syscalls/syscall.tbl
arch/microblaze/kernel/syscalls/syscall.tbl
arch/mips/kernel/syscalls/syscall_n32.tbl
arch/mips/kernel/syscalls/syscall_n64.tbl
arch/mips/kernel/syscalls/syscall_o32.tbl
arch/parisc/kernel/syscalls/syscall.tbl
arch/powerpc/kernel/syscalls/syscall.tbl
arch/s390/kernel/syscalls/syscall.tbl
arch/sh/kernel/syscalls/syscall.tbl
arch/sparc/kernel/syscalls/syscall.tbl
arch/x86/entry/syscalls/syscall_32.tbl
arch/x86/entry/syscalls/syscall_64.tbl
arch/xtensa/kernel/syscalls/syscall.tbl
⬢[acme@toolbox perf-tools-next]$

trace->sctbl->syscalls.entries is sorted by name and has { syscall_id,
name } as contents.

But it is loaded at the time the reuse of BPF programs is attempted,
because initially we were using libaudit for getting id, that we get
from the tracepoint payload:

root@number:~# cat /sys/kernel/tracing/events/raw_syscalls/sys_enter/format 
name: sys_enter
ID: 361
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:long id;	offset:8;	size:8;	signed:1;
                   ^^
                   ^^
                   ^^
                   ^^
	field:unsigned long args[6];	offset:16;	size:48;	signed:0;

print fmt: "NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)", REC->id, REC->args[0], REC->args[1], REC->args[2], REC->args[3], REC->args[4], REC->args[5]
root@number:~#

To syscall name.

Your analysis is perfect, great! Please take a look at the attached
patch, that I'm testing now that is a simplification of your patch, that
avoids exposing that __syscall struct, reducing patch size by
introducing this instead:

+++ b/tools/perf/util/syscalltbl.c
@@ -123,6 +123,13 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
        return sc ? sc->id : -1;
 }
 
+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
+{
+       struct syscall *syscalls = tbl->syscalls.entries;
+
+       return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
+}

And then using it to go from the index to the syscall id in the loops
traversing the sorted trace->sctbl->

> After fixing this bug, I can do perf trace on 38 more syscalls, and
> because more syscalls are visible, we get 8 more syscalls that can be
> augmented.
> 
> before:
> 
> perf $ perf trace -vv --max-events=1 |& grep Reusing
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> 
> TL;DR:

I did the above and got:

root@number:~# wc -l before after
  63 before
  71 after
 134 total
root@number:~#

> These are the new syscalls that can be augmented

Which matches the 8 more reused bpf programs.

> Reusing "openat" BPF sys_enter augmenter for "open_tree"
> Reusing "openat" BPF sys_enter augmenter for "openat2"
> Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
> Reusing "openat" BPF sys_enter augmenter for "move_mount"
> Reusing "open" BPF sys_enter augmenter for "fsopen"
> Reusing "openat" BPF sys_enter augmenter for "fspick"
> Reusing "openat" BPF sys_enter augmenter for "faccessat2"
> Reusing "openat" BPF sys_enter augmenter for "fchmodat2"

But interestingly I get this:

root@number:~# grep -E 'for "(open_tree|openat2|mount_setattr|move_mount|fsopen|fspick|faccessat2|fchmodat2)' after
Reusing "faccessat" BPF sys_enter augmenter for "faccessat2"
Reusing "faccessat" BPF sys_enter augmenter for "fchmodat2"
Reusing "access" BPF sys_enter augmenter for "fsopen"
Reusing "faccessat" BPF sys_enter augmenter for "fspick"
Reusing "faccessat" BPF sys_enter augmenter for "mount_setattr"
Reusing "faccessat" BPF sys_enter augmenter for "move_mount"
Reusing "faccessat" BPF sys_enter augmenter for "open_tree"
Reusing "faccessat" BPF sys_enter augmenter for "openat2"
root@number:~#

Which matches my expectations as the array we're traversing,
trace->sctbl->syscalls->entries is sorted by name.
 
> as for the perf trace output:

> before
> 
> perf $ perf trace -e faccessat2 --max-events=1
> [no output]
> 
> after
> 
> perf $ ./perf trace -e faccessat2 --max-events=1
>      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent")                               = 0
> 
> P.S. The reason why this bug was not found in the past five years is
> probably because it only happens to the newer syscalls whose id is
> greater, for instance, faccessat2 of id 439, which not a lot of people
> care about when using perf trace.

That and the fact that the BPF code was hidden before having to use -e,
that got changed kinda recently when we switched to using BPF skels for
augmenting syscalls in 'perf trace':

⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
a9f4c6c999008c92 perf trace: Collect sys_nanosleep first argument
29d16de26df17e94 perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h
5069211e2f0b47e7 perf trace: Use the right bpf_probe_read(_str) variant for reading user data
33b725ce7b988756 perf trace: Avoid compile error wrt redefining bool
7d9642311b6d9d31 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(augmented_arg->value) is a power of two.
262b54b6c9396823 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(saddr) is a power of two.
1836480429d173c0 perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter using &= sizeof(saddr)
cd2cece61ac5f900 perf trace: Tidy comments related to BPF + syscall augmentation
5e6da6be3082f77b perf trace: Migrate BPF augmentation to use a skeleton
⬢[acme@toolbox perf-tools-next]$ 

⬢[acme@toolbox perf-tools-next]$ git show --oneline --pretty=reference 5e6da6be3082f77b | head -1
5e6da6be3082f77b (perf trace: Migrate BPF augmentation to use a skeleton, 2023-08-10)
⬢[acme@toolbox perf-tools-next]$ 

I.e. from August, 2023.

One had as well to ask for BUILD_BPF_SKEL=1, which now is default if all
it needs is available on the system.

I'll test it together with your btf_enum work.

- Arnaldo

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c42bc608954ee08d..c4fa8191253d4880 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3354,8 +3354,6 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
-	int id;
-
 	/*
 	 * We're only interested in syscalls that have a pointer:
 	 */
@@ -3367,7 +3365,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	return NULL;
 
 try_to_find_pair:
-	for (id = 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int id = syscalltbl__id_at_idx(trace->sctbl, i);
 		struct syscall *pair = trace__syscall_info(trace, NULL, id);
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
@@ -3456,10 +3455,10 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
-	int err = 0, key;
+	int err = 0;
 
-	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		int prog_fd;
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
 
 		if (!trace__syscall_enabled(trace, key))
 			continue;
@@ -3505,7 +3504,8 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 	 * first and second arg (this one on the raw_syscalls:sys_exit prog
 	 * array tail call, then that one will be used.
 	 */
-	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int key = syscalltbl__id_at_idx(trace->sctbl, i);
 		struct syscall *sc = trace__syscall_info(trace, NULL, key);
 		struct bpf_program *pair_prog;
 		int prog_fd;
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 63be7b58761d2f33..0dd26b991b3fb513 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -123,6 +123,13 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 	return sc ? sc->id : -1;
 }
 
+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
+{
+	struct syscall *syscalls = tbl->syscalls.entries;
+
+	return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
+}
+
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
 {
 	int i;
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index a41d2ca9e4aebad5..2b53b7ed25a6affe 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -16,6 +16,7 @@ void syscalltbl__delete(struct syscalltbl *tbl);
 
 const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
 int syscalltbl__id(struct syscalltbl *tbl, const char *name);
+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
 
 int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
 

