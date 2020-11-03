Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73972A45F4
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 14:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgKCNAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 08:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCNAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 08:00:34 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CAC0613D1;
        Tue,  3 Nov 2020 05:00:33 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z3so7746865pfz.6;
        Tue, 03 Nov 2020 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLOijGoctpVii6lG3GNscCwHl4zBjRguK02Pj+vC7Bo=;
        b=Lnt8Hjmu9dGoSLDAasF005iIBbNvJDUDXT2QOAwpwOqhEQdjNHVxckiiJFr8mU4us4
         ZfvZURxeeV5pnQwRthC7wy5OhPHWgFUG+/dOdwLIl0starUECLJ9LsqKhehkbUNWbd+W
         Gk40A7rI2KRJIH1RbJpPY9GOqOxSiWOz5ua9ugFXxzjUDbUsv8kMQdEWKNvX6VsLw7n/
         Z/wiuG6cRq9ieuH87Rmjj6KfKi8oWILHkl2ewcbROaYc73EbRg5fyydXWz+3H1wFoUe9
         y7HhwZtgPvyA5h3Hv1fhVJNm3akcVlQ9BYdE+WTW2Dmb7vNqchZ5wD9Su7dBPwQn1Tdu
         8I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLOijGoctpVii6lG3GNscCwHl4zBjRguK02Pj+vC7Bo=;
        b=tmQCwqwjUTvMkEI+P1Ie/5YLDEaRu4NijUMGdNk5k8sau8EW3sAUC91rsG5c9CGd44
         Q7UbrXHgwW+C8d1susSVAuGOCaxLY5OS9k/fw39c0Vtj9z3/CvxDaWZ4WInVOmI3++3m
         YIqhcYl85l2yW22/vU15bqLmba9z6684y9QgdkOCDICx37OYJwPYu8zpWOpa8cg+Z6Jr
         woG6FQLguuQvvNBdqsXwkHM/vDTewpNztaNnNb7hkA79/So/Ll5IauKvbBwY5RQ5CyXn
         LlOgyLQZXYBPgy7Kwwzdbl1ICuhjyfnI4bUIuJAaZLjZP4NYsaCDUz/d7WtkV9FA1DIj
         Pr0Q==
X-Gm-Message-State: AOAM530ohaxqJy0wbtyom/6WBGwabHu4WTlsKX99K1DC7yC5YLyq9d0o
        eGqdT4jUXGm6nrlct0AUT95G3HIPEjeLWkKBwQo=
X-Google-Smtp-Source: ABdhPJw+ttTwVOHCreEYANGBLEJOjyklNontnw0owjnvgHA5/sZlnEhBwxgZCZadbjBWnXjZWUz50lU3Vv1QK1Vv3D4=
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr3599635pjb.1.1604408433473;
 Tue, 03 Nov 2020 05:00:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook> <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook> <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
 <202010231945.90FA4A4AA@keescook> <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
In-Reply-To: <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Tue, 3 Nov 2020 07:00:22 -0600
Message-ID: <CABqSeATiV0sQvqpvCuqkOXNbjetY=1=6ry_SciMVmo63W9A88A@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 7:18 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> I got a bare metal test machine with Intel(R) Xeon(R) CPU E5-2660 v3 @
> 2.60GHz, running Ubuntu 18.04. Test kernels are compiled at
> 57a339117e52 ("selftests/seccomp: Compare bitmap vs filter overhead")
> and 3650b228f83a ("Linux 5.10-rc1"), built with Ubuntu's
> 5.3.0-64-generic's config, then `make olddefconfig`. "Mitigations off"
> indicate the kernel was booted with "nospectre_v2 nospectre_v1
> no_stf_barrier tsx=off tsx_async_abort=off".
>
> The benchmark was single-job make on x86_64 defconfig of 5.9.1, with
> CPU affinity to set only processor #0. Raw results are appended below.
> Each boot is tested by running the build directly and inside docker,
> with and without seccomp. The commands used are attached below. Each
> test is 4 trials, with the middle two (non-minimum, non-maximum) wall
> clock time averaged. Results summary:
>
>                 Mitigations On                  Mitigations Off
>                 With Cache      Without Cache   With Cache      Without Cache
> Native          18:17.38        18:13.78        18:16.08        18:15.67
> D. no seccomp   18:15.54        18:17.71        18:17.58        18:16.75
> D. + seccomp    20:42.47        20:45.04        18:47.67        18:49.01
>
> To be honest, I'm somewhat surprised that it didn't produce as much of
> a dent in the seccomp overhead in this macro benchmark as I had
> expected.

My peers pointed out that in my previous benchmark there are still a
few mitigations left on, and suggested to use "noibrs noibpb nopti
nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable
no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off".
Results with "Mitigations Off" updated:

                        Mitigations On            Mitigations Off
                With Cache      Without Cache   With Cache      Without Cache
Native          18:17.38        18:13.78        17:43.42        17:47.68
D. no seccomp   18:15.54        18:17.71        17:34.59        17:37.54
D. + seccomp    20:42.47        20:45.04        17:35.70        17:37.16

Whether seccomp is on or off seems not to make much of a difference
for this benchmark. Bitmap being enabled does seem to decrease the
overall compilation time but it also affects where seccomp is off, so
the speedup is probably from other factors. We are thinking about
using more syscall-intensive workloads, such as httpd.

Thugh, this does make me wonder, where does the 3-minute overhead with
seccomp with mitigations come from? Is it data cache misses? If that
is the case, can we somehow preload the seccomp bitmap cache maybe? I
mean, mitigations only cause around half a minute slowdown without
seccomp but seccomp somehow amplify the slowdown with an additional
2.5 minutes, so something must be off here.

This is the raw output for the time commands:

==== with cache, mitigations off ====

947.02user 108.62system 17:47.65elapsed 98%CPU (0avgtext+0avgdata
239804maxresident)k
25112inputs+217152outputs (166major+51934447minor)pagefaults 0swaps

947.91user 108.20system 17:46.53elapsed 99%CPU (0avgtext+0avgdata
239576maxresident)k
0inputs+217152outputs (0major+51941524minor)pagefaults 0swaps

948.33user 108.70system 17:47.72elapsed 98%CPU (0avgtext+0avgdata
239604maxresident)k
0inputs+217152outputs (0major+51938566minor)pagefaults 0swaps

948.65user 108.81system 17:48.41elapsed 98%CPU (0avgtext+0avgdata
239692maxresident)k
0inputs+217152outputs (0major+51935349minor)pagefaults 0swaps


932.12user 113.68system 17:37.24elapsed 98%CPU (0avgtext+0avgdata
239660maxresident)k
0inputs+217152outputs (0major+51547571minor)pagefaults 0swap

931.69user 114.12system 17:37.84elapsed 98%CPU (0avgtext+0avgdata
239448maxresident)k
0inputs+217152outputs (0major+51539964minor)pagefaults 0swaps

932.25user 113.39system 17:37.75elapsed 98%CPU (0avgtext+0avgdata
239372maxresident)k
0inputs+217152outputs (0major+51538018minor)pagefaults 0swaps

931.09user 114.25system 17:37.34elapsed 98%CPU (0avgtext+0avgdata
239508maxresident)k
0inputs+217152outputs (0major+51537700minor)pagefaults 0swaps


929.96user 113.42system 17:36.23elapsed 98%CPU (0avgtext+0avgdata
239448maxresident)k
984inputs+217152outputs (22major+51544059minor)pagefaults 0swaps

929.73user 115.13system 17:38.09elapsed 98%CPU (0avgtext+0avgdata
239464maxresident)k
0inputs+217152outputs (0major+51540259minor)pagefaults 0swaps

930.13user 112.71system 17:36.17elapsed 98%CPU (0avgtext+0avgdata
239620maxresident)k
0inputs+217152outputs (0major+51540623minor)pagefaults 0swaps

930.57user 113.02system 17:49.70elapsed 97%CPU (0avgtext+0avgdata
239432maxresident)k
0inputs+217152outputs (0major+51537776minor)pagefaults 0swaps

==== without cache, mitigations off ====

947.59user 108.06system 17:44.56elapsed 99%CPU (0avgtext+0avgdata
239484maxresident)k
25112inputs+217152outputs (167major+51938723minor)pagefaults 0swaps

947.95user 108.58system 17:43.40elapsed 99%CPU (0avgtext+0avgdata
239580maxresident)k
0inputs+217152outputs (0major+51943434minor)pagefaults 0swaps

948.54user 106.62system 17:42.39elapsed 99%CPU (0avgtext+0avgdata
239608maxresident)k
0inputs+217152outputs (0major+51936408minor)pagefaults 0swaps

947.85user 107.92system 17:43.44elapsed 99%CPU (0avgtext+0avgdata
239656maxresident)k
0inputs+217152outputs (0major+51931633minor)pagefaults 0swaps


931.28user 111.16system 17:33.59elapsed 98%CPU (0avgtext+0avgdata
239440maxresident)k
0inputs+217152outputs (0major+51543540minor)pagefaults 0swaps

930.21user 112.56system 17:34.20elapsed 98%CPU (0avgtext+0avgdata
239400maxresident)k
0inputs+217152outputs (0major+51539699minor)pagefaults 0swaps

930.16user 113.74system 17:35.06elapsed 98%CPU (0avgtext+0avgdata
239344maxresident)k
0inputs+217152outputs (0major+51543072minor)pagefaults 0swaps

930.17user 112.77system 17:34.98elapsed 98%CPU (0avgtext+0avgdata
239176maxresident)k
0inputs+217152outputs (0major+51540777minor)pagefaults 0swaps


931.92user 113.31system 17:36.05elapsed 98%CPU (0avgtext+0avgdata
239520maxresident)k
984inputs+217152outputs (22major+51534636minor)pagefaults 0swaps

931.14user 112.81system 17:35.35elapsed 98%CPU (0avgtext+0avgdata
239524maxresident)k
0inputs+217152outputs (0major+51549007minor)pagefaults 0swaps

930.93user 114.56system 17:37.72elapsed 98%CPU (0avgtext+0avgdata
239360maxresident)k
0inputs+217152outputs (0major+51542191minor)pagefaults 0swaps

932.26user 111.54system 17:35.36elapsed 98%CPU (0avgtext+0avgdata
239572maxresident)k
0inputs+217152outputs (0major+51537921minor)pagefaults 0swaps

YiFei Zhu
