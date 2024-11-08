Return-Path: <bpf+bounces-44355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EAD9C1F3A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FEE1F237F8
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0ED1F4718;
	Fri,  8 Nov 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPYvT929"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A891E0B66;
	Fri,  8 Nov 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076140; cv=none; b=cUr6hXaJg20AXhkHNSquHhS3bm6v1xl8lvKu+TBNtho8qKMtr0rwYa1pR5IaE1lTV4Gb1HwCmVXh59PfDlDRr8lQdSDC817x9rIR1qHQeEu466wj72NWpCacF2yjBVl/dNS8p2H6O67IMbBeEiiwLkp9gp4XhoAhVCIhhc44mHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076140; c=relaxed/simple;
	bh=CVlKtPTJPj5cw4OXUdgTcPWkwG8CN1HBZUq22gYcIHk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=rjZT8wTqRmXqdX3Hm4HCuUPrFyiZ+BNRSEyN/8TaLh4HcfdIg4HptsyZ9YAESU4GrRkuuRiEDt1UBGkjUgzMjPHakOb3VazC54l+eqB4EJpCpPYd+KGVfna3NIqnHqkhktAPOq4LXkW5RK8OXsa8683h5245npfAFgL6sVndaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPYvT929; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso265865a91.3;
        Fri, 08 Nov 2024 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731076138; x=1731680938; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVlKtPTJPj5cw4OXUdgTcPWkwG8CN1HBZUq22gYcIHk=;
        b=GPYvT9290SZ6Jv60zlQ4TqnyGnPUHrhMbT4yKAgvn0dU/dJWByil7i74uK4ecAdz5t
         cw4wCVxil/t0DbDncyKIIjOTvQVYVY6FzGHP0n6u5+AHXxePQ1fd7I7p5szI3AFsZUmi
         jYRFnuQ3Css3sahBogtNWupdUcL7W24cXVbh3SmQ4myRWcpzD+cwOZTeaOGSBewjXdYk
         fBShymrZQ5Wm+gbXw1TbSPTrRkexl5NRtCxOWwHMLGTatXYzyqpvXA0mpvJMjrWo86YE
         NieshLvYt2Zv/dzip0OEBk9wCVLtzFUxJ3g2FmEyAFlo4u8Okmj0g5yDOHR3vDj6z9BS
         wghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731076138; x=1731680938;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVlKtPTJPj5cw4OXUdgTcPWkwG8CN1HBZUq22gYcIHk=;
        b=h42nadWfn4Ur6Dlof6UocUrbQ4/qhMCEAbb1mI7oVn2tJRv+I+c6DRYvvBZuwh9xqF
         S2P9YthZP2NByP0i8nrYZeB2kLkxe1uS9EDEMI+/bkp247/poKU+30Z0H53SrdeezKho
         YWtaveN8fHwWn7GooAgs7brjtTNqrZSeBxoXKnvROTJmNF+qShYSYJCc7CiYXc0X9yAP
         3PS4xjWxPDKssU8ZHc0fk9E85tLz/bPvZrllcjavhVJaKaTRlsM22Ufen84KJQ1gQCzd
         cUChA5Xd8RXgk+sPlSUYz6F3r6Bz2ksfzKZ1GWXhiu9UEn2TebuuJQgCa9PIEAhv1bth
         1Atg==
X-Forwarded-Encrypted: i=1; AJvYcCUIyXSKFAZZS6fZ4qg5ObAj4QMFmZPh4N9jKD1ENuUhi9MzYtm7YvKW++jp4Nywxv9FTZ9yApZUF89ZV6cI@vger.kernel.org, AJvYcCVsRQhqdxpXCoCez4j8tkBQnUTEPBQyZsGwmmZ01uxQVyv6sLyEJSfYmyxnDaJxY96jSyw=@vger.kernel.org, AJvYcCVwxOW748obWL7MUKHlsXJEpPo1rvbaswYjxi0nvbbAL/HJIekw1Pqqox7l8GhP1EdgLMYzH/ur@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9FXXStWB8i7PEe5GR8W5uBmsC3TStIDzVM8PVZi4FviuxOAa
	DSnlZnbRQCdAPk4DT85sfZyW7+b6ghQGKvkvSHVtpypG0J0sSWoLY/6CqQ==
X-Google-Smtp-Source: AGHT+IF51+D6iuALSmokF+Xqbg69q8e7XaMH0FNmyTHAtDUnQYVu5B4Yuv6xImEuRhZ75seULLrkvA==
X-Received: by 2002:a17:90b:33c9:b0:2e2:b20b:59de with SMTP id 98e67ed59e1d1-2e9b16aa2cdmr1862671a91.3.1731076138263;
        Fri, 08 Nov 2024 06:28:58 -0800 (PST)
Received: from smtpclient.apple ([137.132.216.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52d4csm3559685a91.7.2024.11.08.06.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:28:57 -0800 (PST)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: [BUG] WARNING: at lib/vsprintf.c:2659 format_decode+0x121a/0x1c00
Message-Id: <D47BDD2E-217F-4F16-A74C-ADE4DA025FED@gmail.com>
Date: Fri, 8 Nov 2024 22:28:44 +0800
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 bonan.ruan@u.nus.edu
To: "jakub@cloudflare.com" <jakub@cloudflare.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)

Hi there,
A warning is triggered in lib/vsprintf.c due to an unsupported '%' in a =
format string. This issue occurs in the function format_decode at line =
2659 of kernel version 6.12.0-rc3-gb22db8b8befe. A proof-of-concept is =
available, and I have manually reproduced this bug.

Report:
```
Please remove unsupported % in format string
WARNING: CPU: 1 PID: 29307 at lib/vsprintf.c:2659 =
format_decode+0x121a/0x1c00 lib/vsprintf.c:2659
Modules linked in:
CPU: 1 UID: 0 PID: 29307 Comm: syz.5.9298 Not tainted =
6.12.0-rc3-gb22db8b8befe #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
RIP: 0010:format_decode+0x121a/0x1c00 lib/vsprintf.c:2659
Code: 8b 9c 24 80 00 00 00 48 89 d8 48 c1 e8 03 42 8a 04 30 84 c0 0f 85 =
d5 09 00 00 0f b6 33 48 c7 c7 00 bd eb 92 e8 b7 59 67 fc 90 <0f> 0b 90 =
90 4d 89 f7 48 8b 5c 24 18 e9 d7 fc ff ff 89 d1 80 e1 07
RSP: 0018:ffff888041197600 EFLAGS: 00010246
RAX: ea46d93351edcc00 RBX: ffff88804119792c RCX: ffff888009a78000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880411976f0 R08: ffffffff8ebc8e3b R09: 1ffff1100d9e515a
R10: dffffc0000000000 R11: ffffed100d9e515b R12: ffff0000ffffff00
R13: ffff888041197700 R14: dffffc0000000000 R15: dffffc0000000000
FS: 00007fbe06321640(0000) GS:ffff88806cf00000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020a8c000 CR3: 00000000404b6005 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
bstr_printf+0x136/0x1260 lib/vsprintf.c:3232
____bpf_trace_printk kernel/trace/bpf_trace.c:389 [inline]
bpf_trace_printk+0x1a1/0x220 kernel/trace/bpf_trace.c:374
bpf_prog_7ee8fe4dad0c4460+0x4e/0x50
bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
__bpf_prog_run include/linux/filter.h:692 [inline]
bpf_prog_run include/linux/filter.h:708 [inline]
bpf_test_run+0x7a9/0x910 net/bpf/test_run.c:433
bpf_prog_test_run_skb+0xc47/0x1750 net/bpf/test_run.c:1094
bpf_prog_test_run+0x2df/0x350 kernel/bpf/syscall.c:4247
__sys_bpf+0x484/0x850 kernel/bpf/syscall.c:5652
__do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
__x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xd8/0x1c0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fbe07ccd72d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe06320f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fbe07ea5f80 RCX: 00007fbe07ccd72d
RDX: 0000000000000050 RSI: 0000000020000700 RDI: 000000000000000a
RBP: 00007fbe07d57584 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbe07ea5f80 R15: 00007fbe06301000
</TASK>
irq event stamp: 39314
hardirqs last enabled at (39324): [<ffffffff8ed766cb>] __up_console_sem =
kernel/printk/printk.c:344 [inline]
hardirqs last enabled at (39324): [<ffffffff8ed766cb>] =
__console_unlock+0xfb/0x130 kernel/printk/printk.c:2844
hardirqs last disabled at (39335): [<ffffffff8ed766b0>] __up_console_sem =
kernel/printk/printk.c:342 [inline]
hardirqs last disabled at (39335): [<ffffffff8ed766b0>] =
__console_unlock+0xe0/0x130 kernel/printk/printk.c:2844
softirqs last enabled at (38482): [<ffffffff9195aaea>] =
bpf_test_run+0x31a/0x910
softirqs last disabled at (38484): [<ffffffff9195aaea>] =
bpf_test_run+0x31a/0x910
---[ end trace 0000000000000000 ]---
```

Poc.c:
```
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static void sleep_ms(uint64_t ms)
{
usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] =3D 0;
int len =3D strlen(buf);
int fd =3D open(file, O_WRONLY | O_CLOEXEC);
if (fd =3D=3D -1)
return false;
if (write(fd, buf, len) !=3D len) {
int err =3D errno;
close(fd);
errno =3D err;
return false;
}
close(fd);
return true;
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
for (int i =3D 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
return;
usleep(1000);
}
DIR* dir =3D opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent =3D readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=3D =
0)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd =3D open(abort, O_WRONLY);
if (fd =3D=3D -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) !=3D pid) {
}
}

static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void setup_sysctl()
{
int cad_pid =3D fork();
if (cad_pid < 0)
exit(1);
if (cad_pid =3D=3D 0) {
for (;;)
sleep(100);
}
char tmppid[32];
snprintf(tmppid, sizeof(tmppid), "%d", cad_pid);
struct {
const char* name;
const char* data;
} files[] =3D {
{"/sys/kernel/debug/x86/nmi_longest_ns", "10000000000"},
{"/proc/sys/kernel/hung_task_check_interval_secs", "20"},
{"/proc/sys/net/core/bpf_jit_kallsyms", "1"},
{"/proc/sys/net/core/bpf_jit_harden", "0"},
{"/proc/sys/kernel/kptr_restrict", "0"},
{"/proc/sys/kernel/softlockup_all_cpu_backtrace", "1"},
{"/proc/sys/fs/mount-max", "100"},
{"/proc/sys/vm/oom_dump_tasks", "0"},
{"/proc/sys/debug/exception-trace", "0"},
{"/proc/sys/kernel/printk", "7 4 1 3"},
{"/proc/sys/kernel/keys/gc_delay", "1"},
{"/proc/sys/vm/oom_kill_allocating_task", "1"},
{"/proc/sys/kernel/ctrl-alt-del", "0"},
{"/proc/sys/kernel/cad_pid", tmppid},
};
for (size_t i =3D 0; i < sizeof(files) / sizeof(files[0]); i++) {
if (!write_file(files[i].name, files[i].data)) {
}
}
kill(cad_pid, SIGKILL);
while (waitpid(cad_pid, NULL, 0) !=3D cad_pid)
;
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter =3D 0;
for (;; iter++) {
int pid =3D fork();
if (pid < 0)
exit(1);
if (pid =3D=3D 0) {
setup_test();
execute_one();
exit(0);
}
int status =3D 0;
uint64_t start =3D current_time_ms();
for (;;) {
sleep_ms(10);
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
break;
if (current_time_ms() - start < 5000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_one(void)
{
intptr_t res =3D 0;
if (write(1, "executing program\n", sizeof("executing program\n") - 1)) =
{
}
*(uint32_t*)0x200013c0 =3D 4;
*(uint32_t*)0x200013c4 =3D 0xc;
*(uint64_t*)0x200013c8 =3D 0x20000600;
memcpy(
(void*)0x20000600,
=
"\x18\x00\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\xff\xff\xff\xff\x85\x00"=

=
"\x00\x00\x07\x00\x00\x00\x18\x01\x00\x00\x78\x6c\x6c\x25\x00\x00\x00\x00"=

=
"\x00\x20\x20\x20\x7b\x0a\xf8\xff\x00\x00\x00\x00\xbf\xa1\x00\x00\x00\x00"=

=
"\x00\x00\x07\x01\x00\x00\xf8\xff\xff\xff\xb7\x02\x00\x00\x08\x00\x00\x00"=

"\xb7\x03\x00\x00\x05\x00\x00\x00\x85\x00\x00\x00\x06\x00\x00\x00\x95",
89);
*(uint64_t*)0x200013d0 =3D 0x20000200;
memcpy((void*)0x20000200, "GPL\000", 4);
*(uint32_t*)0x200013d8 =3D 9;
*(uint32_t*)0x200013dc =3D 0;
*(uint64_t*)0x200013e0 =3D 0;
*(uint32_t*)0x200013e8 =3D 0x41000;
*(uint32_t*)0x200013ec =3D 0;
memset((void*)0x200013f0, 0, 16);
*(uint32_t*)0x20001400 =3D 0;
*(uint32_t*)0x20001404 =3D 6;
*(uint32_t*)0x20001408 =3D -1;
*(uint32_t*)0x2000140c =3D 0;
*(uint64_t*)0x20001410 =3D 0;
*(uint32_t*)0x20001418 =3D 0;
*(uint32_t*)0x2000141c =3D 0;
*(uint64_t*)0x20001420 =3D 0;
*(uint32_t*)0x20001428 =3D 0;
*(uint32_t*)0x2000142c =3D 0;
*(uint32_t*)0x20001430 =3D 0;
*(uint32_t*)0x20001434 =3D 0;
*(uint64_t*)0x20001438 =3D 0;
*(uint64_t*)0x20001440 =3D 0;
*(uint32_t*)0x20001448 =3D 0;
*(uint32_t*)0x2000144c =3D 1;
*(uint32_t*)0x20001450 =3D 0;
res =3D syscall(__NR_bpf, /*cmd=3D*/5ul, /*arg=3D*/0x200013c0ul, =
/*size=3D*/0x94ul);
if (res !=3D -1)
r[0] =3D res;
syscall(__NR_bpf, /*cmd=3D*/0ul, /*arg=3D*/0ul, /*size=3D*/0x48ul);
*(uint32_t*)0x20000700 =3D r[0];
*(uint32_t*)0x20000704 =3D 0;
*(uint32_t*)0x20000708 =3D 0xe;
*(uint32_t*)0x2000070c =3D 0;
*(uint64_t*)0x20000710 =3D 0x20000300;
memcpy((void*)0x20000300,
"\x8f\x41\x3f\x07\x00\x00\x00\x7e\xfb\xe3\xd9\xb2\x48\xb6", 14);
*(uint64_t*)0x20000718 =3D 0;
*(uint32_t*)0x20000720 =3D 0x2a12;
*(uint32_t*)0x20000724 =3D 0;
*(uint32_t*)0x20000728 =3D 0;
*(uint32_t*)0x2000072c =3D 0;
*(uint64_t*)0x20000730 =3D 0;
*(uint64_t*)0x20000738 =3D 0;
*(uint32_t*)0x20000740 =3D 0;
*(uint32_t*)0x20000744 =3D 0;
*(uint32_t*)0x20000748 =3D 0;
syscall(__NR_bpf, /*cmd=3D*/0xaul, /*arg=3D*/0x20000700ul, =
/*size=3D*/0x50ul);
}
int main(void)
{
syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, =
/*prot=3D*/0ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-1,
/*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
/*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-1,
/*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, =
/*prot=3D*/0ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-1,
/*offset=3D*/0ul);
setup_sysctl();
const char* reason;
(void)reason;
loop();
return 0;
}
```=

