Return-Path: <bpf+bounces-22592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81938861643
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA681C24150
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B182D6D;
	Fri, 23 Feb 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVSadoHE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E771823A8;
	Fri, 23 Feb 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703349; cv=none; b=m/90rrOyVtIb1xkM/9o82K72HJGgTzG/v0qMuGrf2Du5/VUBUBP1T5pX82qBH0qXEvXkH/sJ5uO+TR+TZAT6QsMviNZgVV1NeF0eoEFqmTMx5SpUExkgwj4d/B4xr+zndx8LHRA1bJisTCxDZ4HORplE8nUylVkd5WDGY4+aJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703349; c=relaxed/simple;
	bh=GA/t2eXPPyn/enBlNXpFv1MbcnxHochUO0CFOXM3BOA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qRUdY0uL67moNs+Ub8MvnqBJcJBQJCWoi4MRbUKRD/uZA9uaKsk9Oz4Y5XkjzWqQ1WeiXsRpQyaSTzV8ll96AOTeLRspDUej4THYhIxSk7ElLFXoQqS3I3ZvOjFbpOPsDu+sJOtjn9l/To7WzPZnC9k/W+J4UKJtslCQa6ZgVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVSadoHE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da9c834646so810219b3a.3;
        Fri, 23 Feb 2024 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708703347; x=1709308147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUt+9rpdb+662CTo5C0RxFuDPiJrBOz3gSVa106GR5o=;
        b=EVSadoHEGyUAbRkknxmO35yZ5EoXvHCDx/Llo1+t6FUKVgtTFt2oCJTcfRZR6jgQmU
         fMkhhPA9jwn07QD61GPxnf95WuETsnw78wOV1q05xEI+UzKFEDvhg8z4UST5HuvHBTLq
         GOc681kjn1GK9f3BgCZrqIUVjiWp8A1UViHo2hjzANyKTUb3uFs4khvM5Z2DEIBo4iC5
         W6bAf8dAZtow3xYhdyvY7GYI/RLkl+QrgyE4jbxvqisDMPPzkw5bo821koxtIiMKVxmQ
         ubDlhlVnevHY1nx87kVjU/67v3kibJ3dexZDWnLdIJqUmvtmrY+H11vZFdiO2Qro2lYt
         6L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703347; x=1709308147;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUt+9rpdb+662CTo5C0RxFuDPiJrBOz3gSVa106GR5o=;
        b=YCr0wn6Mh5T+6YcJf1n15QeKWiL0FbWvYzFXc49Zr4zaG0ALGl+JR1MTne8LAKHqsx
         w8V23IRbrt4qYntnKOdd5ec4aZNCECu+b4XaCIbrlr3yBc1yaBt+ogGcWfQyVgvoVff8
         7sFmwZ8NUJkh2F2X5fgG/8Paci++eCi22zfpWe2AEmOrywdX/lMrOAW7ZTr6Oh5hyovg
         S43C8WV//6yzhe+S4ib3u37JmrX/UzGlTYLj/5esLoq4+FY6f9yn+Mii4mR7MyeHgG6x
         /Jzv4Clw4a8yeMdRJMVUO280KFcu99MyNGrdS28Was1wADaCTv5pH9M0L3GmWW6880Xj
         PKGA==
X-Forwarded-Encrypted: i=1; AJvYcCUsY7Bz1wOWS7+efy6EMPtLJDRVExu8l/yqK3SNo5iN3QVvnUuvDLb8LRlV8oQvnlO0x9Y+txi1PchjC5Wj0R+cRUjm8ueUOCyg6wuevmjXftShan2R8sWkAy7F/to8nhvf
X-Gm-Message-State: AOJu0YwS6C6z8gDjAU68CAvsD7DpyudsyMph8gXQ3nh8YUxyTR1UDERT
	94uQFk8plamfu7x9AeuIuSr6ZQoQkaXFHf3mV518zmPwz5DuCQL2isHy/TkZgGXNYnDPHP9/nXC
	RmY478VlQ2BQwwApN/PA91SywuxI=
X-Google-Smtp-Source: AGHT+IHPAR9EQcLiGc3nF62vOLCCMjOqpVIsbBefj8RVxnnkw9Nt0KE1uiFpUDtS118rwOaOo1Y5K8a5xeHOSsPNUiQ=
X-Received: by 2002:a05:6a20:a989:b0:19e:98a1:1160 with SMTP id
 cc9-20020a056a20a98900b0019e98a11160mr187500pzb.28.1708703346602; Fri, 23 Feb
 2024 07:49:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Fri, 23 Feb 2024 23:48:55 +0800
Message-ID: <CABOYnLzyjj_OhVHO2d31_=6PQheyFyPJhPnVvwp2E_zHrP-L-w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in bpf_bprintf_prepare
To: syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug in the upstream linux.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

Notice: I use the same config with syzbot dashboard.
kernel version: c1ca10ceffbb289ed02feaf005bc9ee6095b4507
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e3dd779fba027968
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

=====================================================
BUG: KMSAN: uninit-value in bpf_bprintf_prepare+0x22f1/0x2950
kernel/bpf/helpers.c:934
bpf_bprintf_prepare+0x22f1/0x2950 kernel/bpf/helpers.c:934
____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
bpf_snprintf+0x15e/0x3a0 kernel/bpf/helpers.c:1044
___bpf_prog_run+0x232b/0xe6a0 kernel/bpf/core.c:1986
__bpf_prog_run288+0xc0/0xf0 kernel/bpf/core.c:2226
bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
__bpf_prog_run include/linux/filter.h:651 [inline]
bpf_prog_run include/linux/filter.h:658 [inline]
bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
bpf_flow_dissect+0x13c/0x490 net/core/flow_dissector.c:991
bpf_prog_test_run_flow_dissector+0x78c/0xad0 net/bpf/test_run.c:1359
bpf_prog_test_run+0x74c/0xb90 kernel/bpf/syscall.c:4107
__sys_bpf+0x73b/0xfe0 kernel/bpf/syscall.c:5475
__do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
__x64_sys_bpf+0xa9/0xf0 kernel/bpf/syscall.c:5559
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
__bpf_prog_run288+0x50/0xf0 kernel/bpf/core.c:2226
bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
__bpf_prog_run include/linux/filter.h:651 [inline]
bpf_prog_run include/linux/filter.h:658 [inline]
bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
bpf_flow_dissect+0x13c/0x490 net/core/flow_dissector.c:991

CPU: 2 PID: 11419 Comm: syz-executor.3 Not tainted
6.8.0-rc4-00331-gc1ca10ceffbb-dirty #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
=====================================================



=* repro.c =*
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

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] = 0;
 int len = strlen(buf);
 int fd = open(file, O_WRONLY | O_CLOEXEC);
 if (fd == -1)
   return false;
 if (write(fd, buf, len) != len) {
   int err = errno;
   close(fd);
   errno = err;
   return false;
 }
 close(fd);
 return true;
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i = 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) == pid)
     return;
   usleep(1000);
 }
 DIR* dir = opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent = readdir(dir);
     if (!ent)
       break;
     if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd = open(abort, O_WRONLY);
     if (fd == -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) != pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter = 0;
 for (;; iter++) {
   int pid = fork();
   if (pid < 0)
     exit(1);
   if (pid == 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status = 0;
   uint64_t start = current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff,
                0xffffffffffffffff};

void execute_one(void) {
 intptr_t res = 0;
 *(uint32_t*)0x20000340 = 2;
 *(uint32_t*)0x20000344 = 4;
 *(uint32_t*)0x20000348 = 8;
 *(uint32_t*)0x2000034c = 1;
 *(uint32_t*)0x20000350 = 0x80;
 *(uint32_t*)0x20000354 = 0;
 *(uint32_t*)0x20000358 = 0;
 memset((void*)0x2000035c, 0, 16);
 *(uint32_t*)0x2000036c = 0;
 *(uint32_t*)0x20000370 = -1;
 *(uint32_t*)0x20000374 = 0;
 *(uint32_t*)0x20000378 = 0;
 *(uint32_t*)0x2000037c = 0;
 *(uint64_t*)0x20000380 = 0;
 res = syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x20000340ul, /*size=*/0x48ul);
 if (res != -1)
   r[0] = res;
 *(uint32_t*)0x20000180 = r[0];
 *(uint64_t*)0x20000188 = 0x20000100;
 *(uint32_t*)0x20000100 = 0;
 *(uint64_t*)0x20000190 = 0x20000140;
 memcpy((void*)0x20000140, "%pi6   \000", 8);
 *(uint64_t*)0x20000198 = 0;
 res = syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x20000180ul, /*size=*/0x20ul);
 if (res != -1)
   r[1] = *(uint32_t*)0x20000180;
 *(uint32_t*)0x200000c0 = r[1];
 res = syscall(__NR_bpf, /*cmd=*/0x16ul, /*arg=*/0x200000c0ul, /*size=*/4ul);
 if (res != -1)
   r[2] = *(uint32_t*)0x200000c0;
 *(uint32_t*)0x200004c0 = 0x16;
 *(uint32_t*)0x200004c4 = 0x10;
 *(uint64_t*)0x200004c8 = 0x20000040;
 memcpy((void*)0x20000040,
        "\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb7"
        "\x08\x00\x00\x00\x00\x00\x00\x7b\x8a\xf8\xff\x00\x00\x00\x00\xb7\x08"
        "\x00\x00\xff\xff\x0b\x86\x7b\x8a\xf0\xff\x00\x00\x00\x00\xbf\xa1\x00"
        "\x00\x00\x00\x00\x00\x07\x01\x00\x00\xf8\xff\xff\xff\xbf\xa4\x00\x00"
        "\x00\x00\x00\x00\x07\x04\x00\x00\xf0\xfe\xff\xff\xb7\x02\x00\x00\x08"
        "\x00\x00\x00\x18\x23\x00\x00",
        92);
 *(uint32_t*)0x2000009c = r[2];
 memcpy((void*)0x200000a0,
        "\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x05\x00\x00\x08\x00\x00\x00\x85"
        "\x00\x00\x00\xa5\x00\x00\x00\x95",
        25);
 *(uint64_t*)0x200004d0 = 0x20000600;
 memcpy((void*)0x20000600, "GPL\000", 4);
 *(uint32_t*)0x200004d8 = 0;
 *(uint32_t*)0x200004dc = 0;
 *(uint64_t*)0x200004e0 = 0;
 *(uint32_t*)0x200004e8 = 0;
 *(uint32_t*)0x200004ec = 0;
 memset((void*)0x200004f0, 0, 16);
 *(uint32_t*)0x20000500 = 0;
 *(uint32_t*)0x20000504 = 0;
 *(uint32_t*)0x20000508 = 0;
 *(uint32_t*)0x2000050c = 0;
 *(uint64_t*)0x20000510 = 0;
 *(uint32_t*)0x20000518 = 0;
 *(uint32_t*)0x2000051c = 0;
 *(uint64_t*)0x20000520 = 0;
 *(uint32_t*)0x20000528 = 0;
 *(uint32_t*)0x2000052c = 0;
 *(uint32_t*)0x20000530 = 0;
 *(uint32_t*)0x20000534 = 0;
 *(uint64_t*)0x20000538 = 0;
 *(uint64_t*)0x20000540 = 0;
 *(uint32_t*)0x20000548 = 0;
 *(uint32_t*)0x2000054c = 0;
 res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200004c0ul, /*size=*/0x90ul);
 if (res != -1)
   r[3] = res;
 *(uint32_t*)0x20000640 = r[3];
 *(uint32_t*)0x20000644 = 0;
 *(uint32_t*)0x20000648 = 0xe;
 *(uint32_t*)0x2000064c = 0;
 *(uint64_t*)0x20000650 = 0x20000000;
 memcpy((void*)0x20000000,
        "\x40\xf0\x53\x8e\xf0\x47\xb2\x1f\xb6\x00\x68\x30\x55\x00", 14);
 *(uint64_t*)0x20000658 = 0;
 *(uint32_t*)0x20000660 = 0;
 *(uint32_t*)0x20000664 = 0;
 *(uint32_t*)0x20000668 = 0;
 *(uint32_t*)0x2000066c = 0;
 *(uint64_t*)0x20000670 = 0;
 *(uint64_t*)0x20000678 = 0;
 *(uint32_t*)0x20000680 = 0;
 *(uint32_t*)0x20000684 = 0;
 *(uint32_t*)0x20000688 = 0;
 syscall(__NR_bpf, /*cmd=*/0xaul, /*arg=*/0x20000640ul, /*size=*/0x50ul);
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 loop();
 return 0;
}



Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt.

=* repro.txt =*
r0 = bpf$MAP_CREATE_CONST_STR(0x0, &(0x7f0000000340)={0x2, 0x4, 0x8,
0x1, 0x80, 0x0}, 0x48)
bpf$MAP_UPDATE_CONST_STR(0x2, &(0x7f0000000180)={{r0,
<r1=>0xffffffffffffffff}, &(0x7f0000000100), &(0x7f0000000140)='%pi6
\x00'}, 0x20)
bpf$BPF_MAP_CONST_STR_FREEZE(0x16, &(0x7f00000000c0)={r1,
<r2=>0xffffffffffffffff}, 0x4)
r3 = bpf$PROG_LOAD(0x5, &(0x7f00000004c0)={0x16, 0x10,
&(0x7f0000000040)=ANY=[@ANYBLOB="18000000000000000000000000000000b7080000000000007b8af8ff00000000b7080000ffff0b867b8af0ff00000000bfa100000000000007010000f8ffffffbfa400000000000007040000f0feffffb70200000800000018230000",
@ANYRES32=r2, @ANYBLOB="0000000000000000b70500000800000085000000a500000095"],
&(0x7f0000000600)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
0x90)
bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f0000000640)={r3, 0x0, 0xe, 0x0,
&(0x7f0000000000)="40f0538ef047b21fb60068305500", 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0}, 0x50)

and see also in
https://gist.github.com/xrivendell7/707f897c1d4c261a33a877c047ae3b1e.
BTW, this bug maybe similar to this one KMSAN: uninit-value in
bstr_printf(https://syzkaller.appspot.com/bug?extid=f0d29b273acdcd3a2562)
I hope it helps.
Best regards!
xingwei Lee

