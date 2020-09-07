Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93125FA4B
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIGMRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgIGMRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 08:17:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1941BC061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 05:17:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r25so2777044ioj.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vwOOmw9tstGvTf6vFC2P7sMk3cFJX7OX6RvOSix9iXQ=;
        b=ssW3OjeWlVahDPLEw5mBiMyqbHqnL8bD/3gAfz3/2nhqg5Qen2dz19e+UBkiYiYFGk
         A0qK5m8Rc0Nn2NaUT5Pc0W2476igVXKD4idvAUkGZjkmCnThry8GejZAenXG2zj53UVJ
         Wf/3qKIrL0bYb9ngzAlPWHshBP0ORXwUL2xtsWvtTwDgyD89l52fAAO0kv3z8PgkvaFE
         A9Ua51kTfNu7BfANr/gg4FlNasRUvtCA+diEkVZ91xUBdH/eZ5TedkhnKQ3AvNkw0q5V
         VYyjLCcGTQ6wwysqyVoOUgofLicIa2fEnZUU3nA61D8Lj/VpG8CO/DxYTGpPoU2nEi61
         K+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vwOOmw9tstGvTf6vFC2P7sMk3cFJX7OX6RvOSix9iXQ=;
        b=qcFJ4CDy6yfCKJ64CBFxPAx+PtDwx/MgaT0pNJGRPTK4cktAHYvpZemjEDvlgLdmTj
         vkWmK1StRb171/kScxRZU1lu1wu74id892JJG5nCP5COGze7JPQ5D6A/mkHTnkg4av/h
         pFfv5m8ixWxFR2KgMPZvMz3ywlia8r05TeauPSO/Jgh5emiIpOSgxHqkQvtNAIDJ9Cbw
         YavAvBETDMPvWFr+HAXsTfMyyQBMiedl0QcWnhZRSx+lYg3XJ6N/okR1MLUmNQfKBN2Y
         VvRv0s1cBcDvyY1zDKxgmcs8qj5zV846dJLg2C5ienlU3fEaBavOcKGsxnfa3GBlrL9X
         OM6A==
X-Gm-Message-State: AOAM531cHh9L5VOKgszKcF5r6nnbGAryUykG2SKYmhscx8CfTctKo8u8
        4PUbr3XZkckLDKRZM0cjMovqvJG6vKyg0d6KQ/JZ1EzClu7lbQ==
X-Google-Smtp-Source: ABdhPJzHcDVRek2iLS8DXyh0uwootyIP9rHN4FQxfjdDaVGNfsIyxHn9+tK4mt0+5JyEBZTM2Gdmbrf+F+wGwoXPRrQ=
X-Received: by 2002:a6b:8f8e:: with SMTP id r136mr17125645iod.63.1599481019761;
 Mon, 07 Sep 2020 05:16:59 -0700 (PDT)
MIME-Version: 1.0
From:   David Marcinkovic <david.marcinkovic@sartura.hr>
Date:   Mon, 7 Sep 2020 14:16:48 +0200
Message-ID: <CAO__=G6kqajLdP_cWJiAUjXMRdJe2xBy2FJGiM1v4h6YquD3kg@mail.gmail.com>
Subject: Problem with atomic operations on arm32 with BPF
To:     bpf@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

I am trying to run a simple BPF example that uses the
`__sync_fetch_and_add` built-in function for atomic memory access.  It
fails with `libbpf: load bpf program failed: ERROR:
strerror_r(524)=3D22` error message.

This error does not seem to occur on the amd64 architecture. I am
using clang version 10 for both, compiling on amd64 and
cross-compiling for arm32.

I am aware that those built-in functions are available for arm32. [0].
Why is this error occurring?

To demonstrate I have prepared one simple example program that uses
that built-in function for atomic memory access.

Any input is much appreciated,

Best regards,
David Mar=C4=8Dinkovi=C4=87

[0] https://developer.arm.com/documentation/dui0491/c/compiler-specific-fea=
tures/gnu-builtin-functions?lang=3Den

example.c
-------------------

#include <stdio.h>
#include <bpf/libbpf.h>
#include <sys/resource.h>
#include <fcntl.h>
#include <unistd.h>

#include "example.skel.h"

void read_trace_pipe(void)
{
    int trace_fd;

    trace_fd =3D open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
    if (trace_fd < 0)
        return;

    while (1) {
        static char buf[4096];
        ssize_t sz;

        sz =3D read(trace_fd, buf, sizeof(buf) - 1);
        if (sz > 0) {
            buf[sz] =3D 0;
            puts(buf);
        }
    }
}

int main()
{
    struct example_bpf *obj;
    int err;

    struct rlimit rlim_new =3D {
            .rlim_cur    =3D RLIM_INFINITY,
            .rlim_max    =3D RLIM_INFINITY,
    };

    err =3D setrlimit(RLIMIT_MEMLOCK, &rlim_new);
    if (err) {
        fprintf(stderr, "failed to increase rlimit: %d\n", err);
        return 1;
    }

    obj =3D example_bpf__open();
    if (!obj) {
        fprintf(stderr, "failed to open and/or load BPF object\n");
        return 1;
    }

    err =3D example_bpf__load(obj);
    if (err) {
        fprintf(stderr, "failed to load BPF object: %d\n", err);
        goto cleanup;
    }

    err =3D example_bpf__attach(obj);
    if (err) {
        fprintf(stderr, "failed to attach BPF programs\n");
        goto cleanup;
    }

    read_trace_pipe();

    cleanup:
    example_bpf__destroy(obj);

    return err !=3D 0;
}


example.bpf.c
-------------------

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

SEC("tracepoint/syscalls/sys_enter_execve")
int tracepoint__syscalls__sys_enter_execve(struct
trace_event_raw_sys_enter *ctx)
{
    u32 variable =3D 0;
    __sync_fetch_and_add(&variable, 1);
    bpf_printk("Value of variable is: %u\n", variable);
    return 0;
}

char LICENSE[] SEC("license") =3D "GPL";
