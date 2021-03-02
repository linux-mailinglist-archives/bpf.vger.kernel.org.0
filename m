Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E832B354
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352533AbhCCDuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577326AbhCBSug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3EC061B3F;
        Tue,  2 Mar 2021 10:46:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d11so20985760wrj.7;
        Tue, 02 Mar 2021 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ThaGPSpZZau2nMCUkolf5Z7vGgepqzdKOwfuY68ukvQ=;
        b=t1GqZbcXhaj1YT+Garr+1EhoLnjxkgM+JUHpcyERacTSaMQMZjGLWIJooA/iAiDnun
         ZGFoh0xbGMNxojP3GxvBw8XyYn6uQoRbwDbl8gmE/F2EyFGbeW5u4A1Fdu9lms+G1i26
         RQVleTZyC7Yx4uS1vXbiot3RC/etO/OKtd6zHpyZar3AyKIncyAJeD4GRQvp67rI781n
         7DGtVA7ZO2EvndAY430ZY9aGF4bj8BRAaOUJYR6fS6C2lqKgUVpEbUsAbaUA80k2sDLQ
         TMUl9eHfyAWbEaTmkAWvoSw0rav2roc8zy7UWlWrvJWI6fdMQ5KWgXBHQFR1/nXlfc5y
         Jv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ThaGPSpZZau2nMCUkolf5Z7vGgepqzdKOwfuY68ukvQ=;
        b=YkYx/JA1wmjAb16knQzRfTVdQbkljsh5KkjyweGd71lfU1AmK5xluUJSADUJRCZV2P
         O0EMTFBTaaUL73N2SoPmrZxPctESTJEEu6RIMgJZt2rhjy6HjK/Ve1kpMvEUx4906s7Y
         S2eKSXLx+s86mdCD3sImXiFJX0v4bQbNRTGF1mL5kzN48mh5eJZbKMbJ4R50owkeMGcn
         +TZSylS5hoFRPOn2kI+lH8uT3o7gmwk9gZQJmCS16uWGF9Q7MEScQJm7N4l9sUTd2nuq
         cFzWDvZsNlw5+WV/V9S0bcIxEbTgEhJVEepTjoBL8tSGqYkBKO8P+zzBT812lGW+sUPB
         4KiA==
X-Gm-Message-State: AOAM533+V9V7TH/ZDaSukc/78axJtUhNYWPQ42ZchbKQdY4E8IpyK7cN
        4O+Cx+/LHrOHfEiWiwRNo9hte0WDSfqIhEuvufleVKICZHbfGw==
X-Google-Smtp-Source: ABdhPJxgfzFOSuV6fv4WQpW4rUzbYiF+W3o8crUDzd0upfW81o73O5QiQsqUQjnO5tR4YK/Le4vOU3Zi3r5T1Zc8Fxk=
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr20718463wrs.160.1614710798680;
 Tue, 02 Mar 2021 10:46:38 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 2 Mar 2021 19:46:27 +0100
Message-ID: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
Subject: XDP socket rings, and LKMM litmus tests
To:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

Firstly; The long Cc-list is to reach the LKMM-folks.

Some background; the XDP sockets use a ring-buffer to communicate
between the kernel and userland. It's a
single-consumer/single-producer ring, and described in
net/xdp/xsk_queue.h.

--8<---
/* The structure of the shared state of the rings are the same as the
 * ring buffer in kernel/events/ring_buffer.c. For the Rx and completion
 * ring, the kernel is the producer and user space is the consumer. For
 * the Tx and fill rings, the kernel is the consumer and user space is
 * the producer.
 *
 * producer                         consumer
 *
 * if (LOAD ->consumer) {           LOAD ->producer
 *                    (A)           smp_rmb()       (C)
 *    STORE $data                   LOAD $data
 *    smp_wmb()       (B)           smp_mb()        (D)
 *    STORE ->producer              STORE ->consumer
 * }
 *
 * (A) pairs with (D), and (B) pairs with (C).
...
-->8---

I'd like to replace the smp_{r,w,}mb() barriers with acquire-release
semantics [1], without breaking existing userspace applications.

So, I figured I'd use herd7 and the LKMM model to build a litmus test
for the barrier version, then for the acquire-release version, and
finally permutations of both.

The idea is to use a one element ring, with a state machine outlined
in the litmus test.

The basic test for the existing smp_{r,w,}mb() barriers looks like:

$ cat spsc-rb+1p1c.litmus
C spsc-rb+1p1c

// Stupid one entry ring:
// prod cons     allowed action       prod cons
//    0    0 =3D>       prod          =3D>   1    0
//    0    1 =3D>       cons          =3D>   0    0
//    1    0 =3D>       cons          =3D>   1    1
//    1    1 =3D>       prod          =3D>   0    1

{ prod =3D 1; }

// Here, we start at prod=3D=3D1,cons=3D=3D0, data=3D=3D0, i.e. producer ha=
s
// written data=3D0, so from here only the consumer can start, and should
// consume data=3D=3D0. Afterwards, producer can continue and write 1 to
// data. Can we enter state prod=3D=3D0, cons=3D=3D1, but consumer observer=
d
// the write of 1?

P0(int *prod, int *cons, int *data)
{
    int p;
    int c;
    int cond =3D 0;

    p =3D READ_ONCE(*prod);
    c =3D READ_ONCE(*cons);
    if (p =3D=3D 0)
        if (c =3D=3D 0)
            cond =3D 1;
    if (p =3D=3D 1)
        if (c =3D=3D 1)
            cond =3D 1;

    if (cond) {
        smp_mb();
        WRITE_ONCE(*data, 1);
        smp_wmb();
        WRITE_ONCE(*prod, p ^ 1);
    }
}

P1(int *prod, int *cons, int *data)
{
    int p;
    int c;
    int d =3D -1;
    int cond =3D 0;

    p =3D READ_ONCE(*prod);
    c =3D READ_ONCE(*cons);
    if (p =3D=3D 1)
        if (c =3D=3D 0)
            cond =3D 1;
    if (p =3D=3D 0)
        if (c =3D=3D 1)
            cond =3D 1;

    if (cond =3D=3D 1) {
        smp_rmb();
        d =3D READ_ONCE(*data);
        smp_mb();
        WRITE_ONCE(*cons, c ^ 1);
    }
}

exists( 1:d=3D1 /\ prod=3D0 /\ cons=3D1 );

--

The weird state changing if-statements is because that I didn't get
'&&' and '||' to work with herd.

When this is run:

$ herd7 -conf linux-kernel.cfg litmus-tests/spsc-rb+1p1c.litmus
Test spsc-rb+1p1c Allowed
States 2
1:d=3D0; cons=3D1; prod=3D0;
1:d=3D0; cons=3D1; prod=3D1;
No
Witnesses
Positive: 0 Negative: 2
Condition exists (1:d=3D1 /\ prod=3D0 /\ cons=3D1)
Observation spsc-rb+1p1c Never 0 2
Time spsc-rb+1p1c 0.04
Hash=3Db399756d6a1301ca5bda042f32130791

Now to my question; In P0 there's an smp_mb(). Without that, the d=3D=3D1
can be observed from P1 (consumer):

$ herd7 -conf linux-kernel.cfg litmus-tests/spsc-rb+1p1c.litmus
Test spsc-rb+1p1c Allowed
States 3
1:d=3D0; cons=3D1; prod=3D0;
1:d=3D0; cons=3D1; prod=3D1;
1:d=3D1; cons=3D1; prod=3D0;
Ok
Witnesses
Positive: 1 Negative: 2
Condition exists (1:d=3D1 /\ prod=3D0 /\ cons=3D1)
Observation spsc-rb+1p1c Sometimes 1 2
Time spsc-rb+1p1c 0.04
Hash=3D0047fc21fa77da9a9aee15e35ec367ef

In commit c7f2e3cd6c1f ("perf: Optimize ring-buffer write by depending
on control dependencies") removes the corresponding smp_mb(), and also
the circular buffer in circular-buffers.txt (pre commit 6c43c091bdc5
("documentation: Update circular buffer for
load-acquire/store-release")) is missing the smp_mb() at the
producer-side.

I'm trying to wrap my head around why it's OK to remove the smp_mb()
in the cases above? I'm worried that the current XDP socket ring
implementation (which is missing smp_mb()) might be broken.


If you read this far, thanks! :-)
Bj=C3=B6rn


[1] https://lore.kernel.org/bpf/20210301104318.263262-2-bjorn.topel@gmail.c=
om/
