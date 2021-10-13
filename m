Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0D42B45A
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 06:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhJMEwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 00:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhJMEwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Oct 2021 00:52:02 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68171C061570
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 21:49:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m67so2199645oif.6
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HetMShZlo5L0ubgQGDoD/q+lthMa8OLkJVbtJLyEt5w=;
        b=fx47GyPi2brQfOzFNvPB0//0n6LVyR/yxSUg8uh7Y7esBriGQ8t0qhFtLggXAe2tDN
         MqG1zmHJJmLJcUw06i0yeVoI6eEVNgg0cnMdzAU2wA54xj36NPZzr3OS8AVeMItdHEwQ
         3MRTIT28AGcbAuRL/x7mrU9pALccjAHNdFCI7kv+gFfqMgHuV1W+KXwQaiYcIU26eUn1
         Dxy5OLsXCe24t1tmIeOhGjWoPIFgF0BUiQWz9vGC4Zsba20tURU9Y/kbckf9AAj9nmdc
         qGh/3ZHHMw/V/w7w9Z5SWL/dhYuASs8CZVsCcox7A1Wh1APwWDbQa++YE2IZuGzQKgaf
         60lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HetMShZlo5L0ubgQGDoD/q+lthMa8OLkJVbtJLyEt5w=;
        b=7gattx3kEooq4LqwCnlF1+BqZi2829WWliuoAXcK0w1hCPGUt1DFOlSuOc0QAk9QIj
         ElyfwFObtvzBrsArJ+FQrpENF9PBtgjK8LPTPEurLoCvLYrEWVfOx4jKAsHgKjY2S+sy
         FAFxiG1p5erVnhtGVJsMl5jp6LwO7G94xDWW/hzpHjZrzuJ3X84nHonJx0CtqOjAy6Dc
         De0lF8svsNddfMovvXPybaUjUptGBccLd1ZKSGdS8GZ9k1w8GJ2AAEEDVZJkgKXvYthP
         KgBxCi/R2UOPsEG5gdJLBE+oUe50vpDwB9U7+ZCx0T68Alm+bC0aiy9HfQ13YJTiT6Q6
         SIuA==
X-Gm-Message-State: AOAM531iCV3LfJiMFr3gwJ674uDyYa/hilo8F0Nz908cvez3pmGzMarS
        eeKNUrvH+0KgA5lvO4adyMQuQ3I/aEy3CDez6i2BA+l1q+g=
X-Google-Smtp-Source: ABdhPJwixbjwmkdcWRD/W/eMC6zWwT+hW94j9xreC8rG0Y4GzxakfuA8c1emiry9q0Jej6ui1bgsjWHLlQuULrLQ1m4=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr6503526oig.120.1634100598337;
 Tue, 12 Oct 2021 21:49:58 -0700 (PDT)
MIME-Version: 1.0
From:   Pony Sew <poony20115@gmail.com>
Date:   Wed, 13 Oct 2021 12:49:47 +0800
Message-ID: <CAK-59YHAX2unv=0tq7yZz_J7wkkObMRPPt2jbVs9nBus76CmHQ@mail.gmail.com>
Subject: Is it possible to install libbpf on kernel 3.19.8?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello.
I compiled kernel 3.19.8 on Debian 8 (amd64) then installed it to
enable more BPF options. With libelfg0-dev (0.8.13-5 amd64) and
pkg-config (0.28-1 amd64). When I compiled libbpf from github, I got
some errors. Here are some system informations:

root@debian# uname -r
3.19.8

root@debian# make --version
GNU Make 4.0
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <f*&$ gmail on this part>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

root@debian# gcc --version
gcc (Debian 4.9.2-10+deb8u2) 4.9.2
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

root@debian# grep BPF /boot/config-3.19.8
CONFIG_BPF=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
CONFIG_NET_CLS_BPF=3Dm
CONFIG_BPF_JIT=3Dy
CONFIG_HAVE_BPF_JIT=3Dy
# CONFIG_TEST_BPF is not set

root@debian# make
  MKDIR    staticobjs
  CC       bpf.o
  CC       btf.o
  CC       libbpf.o
libbpf.c: In function =E2=80=98bpf_program__attach_perf_event_opts=E2=80=99=
:
libbpf.c:9190:18: error: =E2=80=98PERF_EVENT_IOC_SET_BPF=E2=80=99 undeclare=
d (first
use in this function)
   if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
                  ^
libbpf.c:9190:18: note: each undeclared identifier is reported only
once for each function it appears in
libbpf.c: In function =E2=80=98perf_buffer__new=E2=80=99:
libbpf.c:10303:16: error: =E2=80=98PERF_COUNT_SW_BPF_OUTPUT=E2=80=99 undecl=
ared (first
use in this function)
  attr.config =3D PERF_COUNT_SW_BPF_OUTPUT;
                ^
Makefile:113: recipe for target 'staticobjs/libbpf.o' failed
make: *** [staticobjs/libbpf.o] Error 1

My future goal is to run a simple BPF CO-RE program on linux kernel
3.19.8. So is it possible to install libbpf on kernel 3.19.8?
Furthermore, is it possible to run BPF CO-RE programs on kernel
3.19.8?

Sincerely,
Poony.
