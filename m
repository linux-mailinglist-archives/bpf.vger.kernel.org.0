Return-Path: <bpf+bounces-22591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331EA861623
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9828A1F25EE6
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6082D76;
	Fri, 23 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhUOVkET"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76E8287B;
	Fri, 23 Feb 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703059; cv=none; b=BGSbJLKos5SRSWbzVLKgEZIH2Bu6VyR0cmaJPu0/0yC9tA3gzriBXiCLWtrmdQoqGKaSCmZazvNTMJyQiPjKo+OAIdEIs82FRC7QotQBHeJ7n+ucplfwQ9uKKMctRlosBMTRVZ976cw/Ly2p+AUfyWsE9SlcCtteTDchNWJ0Msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703059; c=relaxed/simple;
	bh=4fipwBYhiHXE2wxO28ZsIXW9GjFkeIOLp156fBxjWc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gk+lstt2cBquJ/BYGVzBhCCEOREQg0ffu3TSUb9jvK8a2mroBz/x7fmznzkA/gQhQ447t8h0d7YMm/OCXjI7csMyuwPTBfmEi5SpOS9cyH3TuOHHb7iiDGYQ7BZJhZ6ggPdIcYqv/gmsxxjn63VqWV5lOslO4MfBiv7kzS0s7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhUOVkET; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29a950152bcso44948a91.1;
        Fri, 23 Feb 2024 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708703057; x=1709307857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9V7hE3AZX/3FFRy/idPtRDewp/+IdMnphVtz0uymLGY=;
        b=GhUOVkETxTIXC4iAVnKTDV6Em+NoMJSbjdmQUbyUQJ8VE7flM7/1t9/C7BtA2/NYKE
         um4chhrZtdsYcIVYY4/ziAtXMejCIt6Q4MaiqD9E5mxNf+ADjDegxaIvIrk01FaiYaKz
         2w5GzQNgVLcG1o6PPdq1rKK14Hmr9VBJutDBIMhGt2aXgvZARmXgWFmmwRw45BC9y6bg
         eEDmbo8CSCNnFdtPEZvCHy0shsY/EbEkc5G4jjM1Z01NiJQOE9uuTWAZejzvIIRUMAXE
         nNMEVCeR3hOUFI3c+PlOqqzkxkXqEc8n6y3MazNrIriS4kSSwV64c4VV14JyWALow6ja
         9oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703057; x=1709307857;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9V7hE3AZX/3FFRy/idPtRDewp/+IdMnphVtz0uymLGY=;
        b=X4Zk4gwOE4lvDOAANb7NYur26salGImixd84bfVTb9ijtG+yGy0USKjqe1CL3vwFvL
         2a/9jPZm2BOwC1k94+G2E01ZrvHyeElKlteqN58fHgTT42NIj9ZSV+vL/im8B/cPRSHM
         3JoCMX3OSGFYbeaIFq3MVpdZ62ntN1sd26L0vKMJZZ5lZkhGCB4BCabdekFTiqZ0bAXG
         jwcHUCcWncfb25wWAhRPIgLL+z9myp1EXxPsMrE2BrBdk2m6jyY0GfJSJ1d/wnAWGdqw
         LQME+mzT6MajJBPuDOdFzvH06UszMAXmqOtagYzNdfkVN8lw7Wx6nFgs6F/00+Ue4bfr
         iO5w==
X-Forwarded-Encrypted: i=1; AJvYcCUN2+VoUwlg2hTyNKQIKvPrkPk8spfOIX5s2Uj6vF4eP09ycpqBoY7uZPcmWmi0mVjSWqr0KUZu8xO5FeOeL/bFEriMuzhM0+Q9GByl40QFsyUL/hZoVk41ZlfUcFgU1XFF
X-Gm-Message-State: AOJu0YyoL/dCsDOze8CKXzrLsIyplcYI1xsMUPrZGkScvz9BnG17Nt3i
	rxlZmmsl7FR1vEgrc30GJ7KpmhYSKbq90ncpLzelgACHoQ9o+HynttMLRtNIGkxrIKu1gZzjcXB
	rOm6hOnAu2YNOQP4ZHpIxtGkRJyQ=
X-Google-Smtp-Source: AGHT+IFSfaS/aa4d9/h82ZQGms8iAe0kBpFsVP9cgR24ni7huipmsi0BfhvHtVa7fGyFNAS1VHsXndhOBRBSnUy7pdY=
X-Received: by 2002:a17:90b:4c49:b0:29a:9316:6f4f with SMTP id
 np9-20020a17090b4c4900b0029a93166f4fmr159969pjb.23.1708703057488; Fri, 23 Feb
 2024 07:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Fri, 23 Feb 2024 23:44:06 +0800
Message-ID: <CABOYnLx3-Ge3=7UGHCFitjKhYY3V5NnmxGgxKg6-aJ7OdbUcNg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in bstr_printf
To: syzbot+f0d29b273acdcd3a2562@syzkaller.appspotmail.com
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
BUG: KMSAN: uninit-value in bstr_printf+0x1c57/0x1e30 lib/vsprintf.c:3334
 bstr_printf+0x1c57/0x1e30 lib/vsprintf.c:3334
 ____bpf_snprintf kernel/bpf/helpers.c:1064 [inline]
 bpf_snprintf+0x1eb/0x3c0 kernel/bpf/helpers.c:1044
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


=* repro.c =*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
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

#include <linux/futex.h>

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

static void thread_start(void* (*fn)(void*), void* arg) {
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev) {
  ev->state = 0;
}

static void event_reset(event_t* ev) {
  ev->state = 0;
}

static void event_set(event_t* ev) {
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
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

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void) {
  int i, call, thread;
  for (call = 0; call < 6; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
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

void execute_call(int call) {
  intptr_t res = 0;
  switch (call) {
    case 0:
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
      res =
          syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x20000340ul, /*size=*/0x48ul);
      if (res != -1)
        r[0] = res;
      break;
    case 1:
      *(uint32_t*)0x20000180 = r[0];
      *(uint64_t*)0x20000188 = 0x20000100;
      *(uint32_t*)0x20000100 = 0;
      *(uint64_t*)0x20000190 = 0x20000140;
      memcpy((void*)0x20000140, "%pi6   \000", 8);
      *(uint64_t*)0x20000198 = 0;
      res =
          syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x20000180ul, /*size=*/0x20ul);
      if (res != -1)
        r[1] = *(uint32_t*)0x20000180;
      break;
    case 2:
      *(uint32_t*)0x20000440 = r[1];
      *(uint64_t*)0x20000448 = 0x200002c0;
      *(uint32_t*)0x200002c0 = 0;
      *(uint64_t*)0x20000450 = 0x20000400;
      memcpy((void*)0x20000400, "%pS    \000", 8);
      *(uint64_t*)0x20000458 = 0;
      syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x20000440ul, /*size=*/0x20ul);
      break;
    case 3:
      *(uint32_t*)0x200000c0 = r[1];
      res =
          syscall(__NR_bpf, /*cmd=*/0x16ul, /*arg=*/0x200000c0ul, /*size=*/4ul);
      if (res != -1)
        r[2] = *(uint32_t*)0x200000c0;
      break;
    case 4:
      *(uint32_t*)0x200004c0 = 0x16;
      *(uint32_t*)0x200004c4 = 0x10;
      *(uint64_t*)0x200004c8 = 0x20000040;
      memcpy((void*)0x20000040,
             "\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
             "\xb7\x08\x00\x00\x00\x00\x00\x00\x7b\x8a\xf8\xff\x00\x00\x00\x00"
             "\xb7\x08\x00\x00\xff\xff\x0b\x86\x7b\x8a\xf0\xff\x00\x00\x00\x00"
             "\xbf\xa1\x00\x00\x00\x00\x00\x00\x07\x01\x00\x00\xf8\xff\xff\xff"
             "\xbf\xa4\x00\x00\x00\x00\x00\x00\x07\x04\x00\x00\xf0\xfe\xff\xff"
             "\xb7\x02\x00\x00\x08\x00\x00\x00\x18\x23\x00\x00",
             92);
      *(uint32_t*)0x2000009c = r[2];
      memcpy((void*)0x200000a0,
             "\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x05\x00\x00\x08\x00\x00\x00"
             "\x85\x00\x00\x00\xa5\x00\x00\x00\x95",
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
      res =
          syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200004c0ul, /*size=*/0x90ul);
      if (res != -1)
        r[3] = res;
      break;
    case 5:
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
      break;
  }
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
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
bpf$MAP_UPDATE_CONST_STR(0x2, &(0x7f0000000440)={{r1},
&(0x7f00000002c0), &(0x7f0000000400)='%pS    \x00'}, 0x20)
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
https://gist.github.com/xrivendell7/baaee5029b1b1d05c66888c29fc1843f.
BTW, this bug maybe similar to this one:
https://syzkaller.appspot.com/bug?extid=c2dc95f7d0825a145992

I hope it helps.
Best regards!
xingwei Lee

