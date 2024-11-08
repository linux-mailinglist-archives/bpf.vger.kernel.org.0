Return-Path: <bpf+bounces-44354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39D9C1F2F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F41F2403C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72F1F4292;
	Fri,  8 Nov 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTWXWxgk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64E1F12FD;
	Fri,  8 Nov 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075992; cv=none; b=ExsBnl9dAjrALjAcK5hlS2d24JscopSOpTRLprXunIsN2E+Etc2/Rzh+XupltTa3OzlwXwWLTINgu598M5/3jXQMC1TpcXeKNQ8Mia1mlnWhN0jBW+a6bLOF2X13h1At+UjF6tUB7YAVL7K6UJRpdpFiEgWuJSxk1KC1OSeM5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075992; c=relaxed/simple;
	bh=x/VrvVkZGV0ZCzP4vusRlpYaCC1FBTpGuMvAtlq4SfI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CZej/zFSf6xv+cQ3+hFxeO6QAlSZGqEemmuIPa6L0AkKSXFPJ8Q+OYDuurQ+TA3xutvQgmLH9jQPnAPUmoEtddYbd7O9MsPhd/bHahkpKXHZ4VWbpCiz2YFUtjGGIVb4ZtGv4xDa6IADMZsN3n1R31deYqddfVg0CyQ+HGrRD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTWXWxgk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4c2e36d5so264360b3a.2;
        Fri, 08 Nov 2024 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731075989; x=1731680789; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/VrvVkZGV0ZCzP4vusRlpYaCC1FBTpGuMvAtlq4SfI=;
        b=iTWXWxgkpOrJf6FNeu/O0iDLp4rEtlvtkKfNlADq57Y1t6jeAGSFuMCzrqoH4E7nEe
         UncCQH7y2HasCWcE9UBhzwBA8H6UqPlP4YoMRBlHG4QvZkqtoWVcBSggs5wx3eZWmMhd
         a2kDzZ/uI8RaK8LNmqdf3HxC4glIWQqB9QKzyfXlxxMxqb1W5qjDL3kEKoVsAfHytf+z
         22lm0/2ke3qCp4iJiHE6j66Fpns8kHp9RYiWlonnUEm95g2a+MJ2YZRqoaBg7YfdBXhd
         FzuvK4rNWZ1qj2/9dtlHiU7tVHEJyRmTFFI2G8eOWH1kG+tvGUpT+q7apg7yVZ5BUnjm
         JNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075989; x=1731680789;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/VrvVkZGV0ZCzP4vusRlpYaCC1FBTpGuMvAtlq4SfI=;
        b=dJVmlasMAlaLb6oaOBoAK9djf/LrA7kBRJXAzOS0KJWA3OJlr6Yio4axxhtAHb/ds/
         RnobEIqx5aKZStUrvbp6qXGAVBZljP8kmuCGmns/Bqj7McIxPz5Q1QHWafN6qAQI4x0A
         +Gy2wtb5rCaOnJ4rLubHikN+6tOMliW3GwGsKv9FYN5R2RkYuVe91rSPIK1J026xRBXR
         OfzVODoxBRiRarvks1wq6m0oca1mcg9SAERzgdlps87AYgONH1q0GuENZuCOzEUIeWXE
         4BV1FIULL14LqqzFY80oQP0Qsj6gWXdTEW+z66OquLdi1Teug1zHlSXaPXvboq27I5hR
         UemA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4BjF5i7Pv3KygoGGAHYMmaIyV/hG5Gv9zZ8rRdNwQO7vy1GI73kUiH+V3eNuv5PySOEBzV6q@vger.kernel.org, AJvYcCV7eTHHSGBTgEx6CgJXazyLJi0Xu2+U70fHsnoVoMMYNNKF8dt2ICuT4J0kKxI9UJXiEMfqURYGzZj9CZcj@vger.kernel.org, AJvYcCVmIz6aaU+D1d8Q/m2g0NIbsyMGIk0JDYV1OEZuEvFuvoZF9FWTyA4mTDdykLhhMY/OExc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUMTViAjsp88KWsGu9UABlK3230cE9OmkzlcPrzoTsoxhvFSd
	nqo7krcRE9GHsJNlb6gUlSzjMRSCgr6upBtth43osID7LUER+y69
X-Google-Smtp-Source: AGHT+IFbOdrPam/CchrvgBdVRbumHcF//gK6cYRpZGct/e7SaPZndRzxH1h1rmuPDv8qk7flbTsLuQ==
X-Received: by 2002:a05:6a00:1828:b0:71e:66ed:7bd4 with SMTP id d2e1a72fcca58-72413263f12mr1757583b3a.1.1731075989117;
        Fri, 08 Nov 2024 06:26:29 -0800 (PST)
Received: from smtpclient.apple ([137.132.216.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm3822171b3a.127.2024.11.08.06.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:26:28 -0800 (PST)
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
Subject: [BUG] BUG: unable to handle page fault for address: ffffffffa6df0480
Message-Id: <B80BDA8B-4F1C-4293-8E98-AF78AEA7B3FA@gmail.com>
Date: Fri, 8 Nov 2024 22:26:14 +0800
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
A kernel page fault occurred at address ffffffffa6df0480 due to a =
supervisor read access in kernel mode. The error indicates a =
"not-present page" issue, leading to an Oops in the system. The fault =
address appears to be an invalid memory access, possibly due to =
incorrect handling of pointers or memory allocation within the BPF JIT =
compilation path.
A proof-of-concept is available, and I have manually reproduced this =
bug.

Report:
```
BUG: unable to handle page fault for address: ffffffffa6df0480
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 75a87067 P4D 75a87067 PUD 75a88063 PMD 43c4063 PTE 800fffff8920f062
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 11294 Comm: syz.0.3563 Not tainted =
6.12.0-rc3-gb22db8b8befe #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
RIP: 0010:__arch_prepare_bpf_trampoline+0x53d/0x3810 =
arch/x86/net/bpf_jit_comp.c:2974
Code: 8b 44 24 18 48 8b 5c 24 30 e9 a4 00 00 00 4c 89 f0 48 c1 e8 03 48 =
b9 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 77 28 00 00 <41> 8b 1e =
bf 66 0f 1f 00 89 de e8 24 d6 3d 00 81 fb 66 0f 1f 00 75
RSP: 0018:ffff888029b072e0 EFLAGS: 00010246
RAX: 1ffffffff4dbe000 RBX: 0000000000000006 RCX: dffffc0000000000
RDX: ffff88800b053780 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff888029b074c0 R08: ffffffffa099ba3a R09: 0000000000000006
R10: fffffbfff8095000 R11: ffffed100020a30d R12: ffff888029b07440
R13: 0000000000000030 R14: ffffffffa6df0480 R15: 0000000000000008
FS: 00007fba28dc1640(0000) GS:ffff888065800000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa6df0480 CR3: 00000000281b4006 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
arch_bpf_trampoline_size+0xd3/0x150 arch/x86/net/bpf_jit_comp.c:3212
bpf_trampoline_update+0x78b/0x1020 kernel/bpf/trampoline.c:435
__bpf_trampoline_link_prog+0x50a/0x6c0 kernel/bpf/trampoline.c:565
bpf_trampoline_link_prog+0x2d/0x40 kernel/bpf/trampoline.c:578
bpf_tracing_prog_attach+0x9e4/0xe50 kernel/bpf/syscall.c:3432
bpf_raw_tp_link_attach+0x3ec/0x630 kernel/bpf/syscall.c:3798
bpf_raw_tracepoint_open+0x172/0x1e0 kernel/bpf/syscall.c:3861
__sys_bpf+0x3ae/0x850 kernel/bpf/syscall.c:5676
__do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
__x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xd8/0x1c0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fba2a76d72d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba28dc0f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fba2a945f80 RCX: 00007fba2a76d72d
RDX: 0000000000000010 RSI: 0000000020000a80 RDI: 0000000000000011
RBP: 00007fba2a7f7584 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fba2a945f80 R15: 00007fba28da1000
</TASK>
Modules linked in:
CR2: ffffffffa6df0480
---[ end trace 0000000000000000 ]---
RIP: 0010:__arch_prepare_bpf_trampoline+0x53d/0x3810 =
arch/x86/net/bpf_jit_comp.c:2974
Code: 8b 44 24 18 48 8b 5c 24 30 e9 a4 00 00 00 4c 89 f0 48 c1 e8 03 48 =
b9 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 77 28 00 00 <41> 8b 1e =
bf 66 0f 1f 00 89 de e8 24 d6 3d 00 81 fb 66 0f 1f 00 75
RSP: 0018:ffff888029b072e0 EFLAGS: 00010246
RAX: 1ffffffff4dbe000 RBX: 0000000000000006 RCX: dffffc0000000000
RDX: ffff88800b053780 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff888029b074c0 R08: ffffffffa099ba3a R09: 0000000000000006
R10: fffffbfff8095000 R11: ffffed100020a30d R12: ffff888029b07440
R13: 0000000000000030 R14: ffffffffa6df0480 R15: 0000000000000008
FS: 00007fba28dc1640(0000) GS:ffff888065800000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa6df0480 CR3: 00000000281b4006 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
note: syz.0.3563[11294] exited with irqs disabled
----------------
Code disassembly (best guess):
0: 8b 44 24 18 mov 0x18(%rsp),%eax
4: 48 8b 5c 24 30 mov 0x30(%rsp),%rbx
9: e9 a4 00 00 00 jmp 0xb2
e: 4c 89 f0 mov %r14,%rax
11: 48 c1 e8 03 shr $0x3,%rax
15: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
1c: fc ff df
1f: 8a 04 08 mov (%rax,%rcx,1),%al
22: 84 c0 test %al,%al
24: 0f 85 77 28 00 00 jne 0x28a1
* 2a: 41 8b 1e mov (%r14),%ebx <-- trapping instruction
2d: bf 66 0f 1f 00 mov $0x1f0f66,%edi
32: 89 de mov %ebx,%esi
34: e8 24 d6 3d 00 call 0x3dd65d
39: 81 fb 66 0f 1f 00 cmp $0x1f0f66,%ebx
3f: 75 .byte 0x75
```

Poc.c
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

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len) \
*(type*)(addr) =3D \
htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
(((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

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

uint64_t r[4] =3D {0xffffffffffffffff, 0x0, 0xffffffffffffffff,
0xffffffffffffffff};

void execute_one(void)
{
intptr_t res =3D 0;
if (write(1, "executing program\n", sizeof("executing program\n") - 1)) =
{
}
memcpy((void*)0x200007c0,
"\x1b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04", 15);
res =3D syscall(__NR_bpf, /*cmd=3D*/0ul, /*arg=3D*/0x200007c0ul, =
/*size=3D*/0x48ul);
if (res !=3D -1)
r[0] =3D res;
*(uint32_t*)0x20000680 =3D 0;
res =3D syscall(__NR_bpf, /*cmd=3D*/0x17ul, /*arg=3D*/0x20000680ul, =
/*size=3D*/8ul);
if (res !=3D -1)
r[1] =3D *(uint32_t*)0x20000684;
*(uint32_t*)0x20000640 =3D r[1];
res =3D syscall(__NR_bpf, /*cmd=3D*/0x13ul, /*arg=3D*/0x20000640ul, =
/*size=3D*/4ul);
if (res !=3D -1)
r[2] =3D res;
*(uint32_t*)0x20000ac0 =3D 0x1a;
*(uint32_t*)0x20000ac4 =3D 0xf;
*(uint64_t*)0x20000ac8 =3D 0x200000c0;
*(uint8_t*)0x200000c0 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x200000c1, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000c1, 0, 4, 4);
*(uint16_t*)0x200000c2 =3D 0;
*(uint32_t*)0x200000c4 =3D 2;
*(uint8_t*)0x200000c8 =3D 0;
*(uint8_t*)0x200000c9 =3D 0;
*(uint16_t*)0x200000ca =3D 0;
*(uint32_t*)0x200000cc =3D 0xae4;
*(uint8_t*)0x200000d0 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x200000d1, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000d1, 1, 4, 4);
*(uint16_t*)0x200000d2 =3D 0;
*(uint32_t*)0x200000d4 =3D r[0];
*(uint8_t*)0x200000d8 =3D 0;
*(uint8_t*)0x200000d9 =3D 0;
*(uint16_t*)0x200000da =3D 0;
*(uint32_t*)0x200000dc =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x200000e0, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x200000e0, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x200000e0, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000e1, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000e1, 0, 4, 4);
*(uint16_t*)0x200000e2 =3D 0;
*(uint32_t*)0x200000e4 =3D 0x14;
STORE_BY_BITMASK(uint8_t, , 0x200000e8, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x200000e8, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x200000e8, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000e9, 3, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000e9, 0, 4, 4);
*(uint16_t*)0x200000ea =3D 0;
*(uint32_t*)0x200000ec =3D 0;
*(uint8_t*)0x200000f0 =3D 0x85;
*(uint8_t*)0x200000f1 =3D 0;
*(uint16_t*)0x200000f2 =3D 0;
*(uint32_t*)0x200000f4 =3D 0x83;
STORE_BY_BITMASK(uint8_t, , 0x200000f8, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x200000f8, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x200000f8, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000f9, 9, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000f9, 0, 4, 4);
*(uint16_t*)0x200000fa =3D 0;
*(uint32_t*)0x200000fc =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000100, 5, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000100, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000100, 5, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000101, 9, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000101, 0, 4, 4);
*(uint16_t*)0x20000102 =3D 1;
*(uint32_t*)0x20000104 =3D 0;
*(uint8_t*)0x20000108 =3D 0x95;
*(uint8_t*)0x20000109 =3D 0;
*(uint16_t*)0x2000010a =3D 0;
*(uint32_t*)0x2000010c =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000110, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000110, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000110, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000111, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000111, 9, 4, 4);
*(uint16_t*)0x20000112 =3D 0;
*(uint32_t*)0x20000114 =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000118, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000118, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000118, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000119, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000119, 0, 4, 4);
*(uint16_t*)0x2000011a =3D 0;
*(uint32_t*)0x2000011c =3D 0;
*(uint8_t*)0x20000120 =3D 0x85;
*(uint8_t*)0x20000121 =3D 0;
*(uint16_t*)0x20000122 =3D 0;
*(uint32_t*)0x20000124 =3D 0x84;
STORE_BY_BITMASK(uint8_t, , 0x20000128, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000128, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000128, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000129, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000129, 0, 4, 4);
*(uint16_t*)0x2000012a =3D 0;
*(uint32_t*)0x2000012c =3D 0;
*(uint8_t*)0x20000130 =3D 0x95;
*(uint8_t*)0x20000131 =3D 0;
*(uint16_t*)0x20000132 =3D 0;
*(uint32_t*)0x20000134 =3D 0;
*(uint64_t*)0x20000ad0 =3D 0x20000340;
memcpy((void*)0x20000340, "GPL\000", 4);
*(uint32_t*)0x20000ad8 =3D 2;
*(uint32_t*)0x20000adc =3D 0;
*(uint64_t*)0x20000ae0 =3D 0;
*(uint32_t*)0x20000ae8 =3D 0x41100;
*(uint32_t*)0x20000aec =3D 0x29;
memset((void*)0x20000af0, 0, 16);
*(uint32_t*)0x20000b00 =3D 0;
*(uint32_t*)0x20000b04 =3D 0x19;
*(uint32_t*)0x20000b08 =3D r[2];
*(uint32_t*)0x20000b0c =3D 8;
*(uint64_t*)0x20000b10 =3D 0;
*(uint32_t*)0x20000b18 =3D 0;
*(uint32_t*)0x20000b1c =3D 0x10;
*(uint64_t*)0x20000b20 =3D 0;
*(uint32_t*)0x20000b28 =3D 0;
*(uint32_t*)0x20000b2c =3D 0x17b23;
*(uint32_t*)0x20000b30 =3D r[2];
*(uint32_t*)0x20000b34 =3D 0;
*(uint64_t*)0x20000b38 =3D 0;
*(uint64_t*)0x20000b40 =3D 0;
*(uint32_t*)0x20000b48 =3D 0x10;
*(uint32_t*)0x20000b4c =3D 0x3d;
*(uint32_t*)0x20000b50 =3D 0;
res =3D syscall(__NR_bpf, /*cmd=3D*/5ul, /*arg=3D*/0x20000ac0ul, =
/*size=3D*/0x94ul);
if (res !=3D -1)
r[3] =3D res;
*(uint64_t*)0x20000940 =3D 0;
*(uint32_t*)0x20000948 =3D r[3];
syscall(__NR_bpf, /*cmd=3D*/0x11ul, /*arg=3D*/0x20000940ul, =
/*size=3D*/0x10ul);
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
const char* reason;
(void)reason;
loop();
return 0;
}
```=

