Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D62A055E
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3MUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgJ3MTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 08:19:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4D1C0613CF;
        Fri, 30 Oct 2020 05:19:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so5088662pfn.12;
        Fri, 30 Oct 2020 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+1cvBFV+BbT045obJv5sfET1WD6zbSJq/rYiBWBg2Y=;
        b=o8Pn+YH4kcs5Ir63k+QjqV3fw1yk7AP9h/dm6/+wmJI12MR/faCDlGKXumHdYqlpoc
         Dii11zklXMChe1G6t/7sC2juQIOx4ADETdR4AK4omnqIBLrLOjmq6xzers02E18cyiEb
         gl4HgaZWY+npyq+92IagalGf1wbYrnRj6YPIdF7cHmdB6s/fBJo7i9036Srmc/K/uLva
         yyaofgMVlt1xY6CZGYzHQGZ68k5bwYeyqFfrsZcLUHqsC4LQHqdS2QyXOZ7fNyKNpYo4
         BKXPuI22ptBuocfbDtPvOcWQBHndd+4FKBG7ao1lTQKRpFDHoTwVE8FSc6eCCww62ueF
         EDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+1cvBFV+BbT045obJv5sfET1WD6zbSJq/rYiBWBg2Y=;
        b=hQgzHf5ns/tM0zAoocG5zwpgy0IaGnb7ucL/dCRmzTj4s21RlrSRbEkEILJCk3BFb5
         FCQMuEnt2/DAKWDGInHA5+FOiVGblaucCQBlGDoOebQtt1OMLuoM4dmRariMH3gLi4/x
         9unfeZQi7NLTe5/V/sQYKAshlcNOS4ZX8xrNszT7aOxRkFP+eJyqWcwLws1b7aPL/yIu
         p7jhYf1X5mb1FgOTtZmTyH+yf1cK+cnvAA5GdauhjIiKEy3Cv1C+c4B7bCq6124yZ+qC
         QGBJkjGsAohHAeayrlsFUZ1gI0n5WdGSvhu6mF1FQ1YzYnwYbbTkQk9kmE8J0GV/CPzM
         +A7w==
X-Gm-Message-State: AOAM53256OyZIoKt3VAYlfc64jr5GOGAOB9gbJoEmnW7F1CCIrj5sYW9
        ZhTU4p3TLZYBv2hLhdgHQUxitacINykuHkB7jPU=
X-Google-Smtp-Source: ABdhPJw9NKS06kO8N0f04yMRWi7OK7/vjW6hOd0bft0wy3RnoaaAGQQu8G/jHZBZdmuRZ8LiJGfLPJXZdXFVTOIOQwE=
X-Received: by 2002:a17:90a:5797:: with SMTP id g23mr2603183pji.184.1604060347403;
 Fri, 30 Oct 2020 05:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook> <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook> <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
 <202010231945.90FA4A4AA@keescook>
In-Reply-To: <202010231945.90FA4A4AA@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 30 Oct 2020 07:18:55 -0500
Message-ID: <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
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

On Fri, Oct 23, 2020 at 9:51 PM Kees Cook <keescook@chromium.org> wrote:
> Do you have a test environment where you can compare the before/after
> of repeated kernel build times (or some other sufficiently
> complex/interesting) workload under these conditions:
>
> bare metal
> docker w/ seccomp policy disabled
> docker w/ default seccomp policy
>
> This is what I've been trying to construct, but it's really noisy, so
> I've been trying to pin CPUs and NUMA memory nodes, but it's not really
> helping yet. :P

Hi, sorry for the delay. The benchmarks took a while to get.

I got a bare metal test machine with Intel(R) Xeon(R) CPU E5-2660 v3 @
2.60GHz, running Ubuntu 18.04. Test kernels are compiled at
57a339117e52 ("selftests/seccomp: Compare bitmap vs filter overhead")
and 3650b228f83a ("Linux 5.10-rc1"), built with Ubuntu's
5.3.0-64-generic's config, then `make olddefconfig`. "Mitigations off"
indicate the kernel was booted with "nospectre_v2 nospectre_v1
no_stf_barrier tsx=off tsx_async_abort=off".

The benchmark was single-job make on x86_64 defconfig of 5.9.1, with
CPU affinity to set only processor #0. Raw results are appended below.
Each boot is tested by running the build directly and inside docker,
with and without seccomp. The commands used are attached below. Each
test is 4 trials, with the middle two (non-minimum, non-maximum) wall
clock time averaged. Results summary:

                Mitigations On                  Mitigations Off
                With Cache      Without Cache   With Cache      Without Cache
Native          18:17.38        18:13.78        18:16.08        18:15.67
D. no seccomp   18:15.54        18:17.71        18:17.58        18:16.75
D. + seccomp    20:42.47        20:45.04        18:47.67        18:49.01

To be honest, I'm somewhat surprised that it didn't produce as much of
a dent in the seccomp overhead in this macro benchmark as I had
expected.

Below are commands used and outputs from time command.

Commands used to start the docker containers:
docker run -w /srv/yifeifz2/linux-buildtest \
  --tmpfs /srv/yifeifz2/linux-buildtest:exec --rm -it ubuntu:18.04

docker run -w /srv/yifeifz2/linux-buildtest \
  --tmpfs /srv/yifeifz2/linux-buildtest:exec --rm -it \
  --security-opt seccomp=unconfined ubuntu:18.04

Commands used to install the toolchain inside docker:
apt -y update
apt -y dist-upgrade
apt -y install build-essential wget flex bison time libssl-dev bc libelf-dev

Commands to benchmark on native:
for i in {1..4}; do
    mkdir -p /srv/yifeifz2/linux-buildtest
    mount -t tmpfs tmpfs /srv/yifeifz2/linux-buildtest
    pushd /srv/yifeifz2/linux-buildtest
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.9.1.tar.xz
    tar xf linux-5.9.1.tar.xz
    cd linux-5.9.1
    make mrproper
    make defconfig
    taskset 0x1 time make -j1 > /dev/null
    popd
    umount /srv/yifeifz2/linux-buildtest
done

Commands to benchmark inside docker:
for i in {1..4}; do
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.9.1.tar.xz
    tar xf linux-5.9.1.tar.xz
    pushd linux-5.9.1
    make mrproper
    make defconfig
    taskset 0x1 time make -j1 > /dev/null
    popd
    rm -rf linux-5.9.1 linux-5.9.1.tar.xz
done

==== with cache, mitigations on ====

973.52user 113.98system 18:16.51elapsed 99%CPU (0avgtext+0avgdata
239784maxresident)k
0inputs+217152outputs (0major+51937662minor)pagefaults 0swaps

973.74user 115.35system 18:18.41elapsed 99%CPU (0avgtext+0avgdata
239640maxresident)k
0inputs+217152outputs (0major+51933865minor)pagefaults 0swaps

973.31user 114.41system 18:17.37elapsed 99%CPU (0avgtext+0avgdata
239660maxresident)k
72inputs+217152outputs (0major+51936343minor)pagefaults 0swaps

971.76user 116.04system 18:17.39elapsed 99%CPU (0avgtext+0avgdata
239588maxresident)k
0inputs+217152outputs (0major+51936222minor)pagefaults 0swaps


961.44user 121.30system 18:15.30elapsed 98%CPU (0avgtext+0avgdata
239580maxresident)k
0inputs+217152outputs (0major+51555371minor)pagefaults 0swaps

961.86user 119.48system 18:13.96elapsed 98%CPU (0avgtext+0avgdata
239480maxresident)k
0inputs+217152outputs (0major+51552153minor)pagefaults 0swaps

961.68user 121.75system 18:15.78elapsed 98%CPU (0avgtext+0avgdata
239504maxresident)k
0inputs+217152outputs (0major+51559201minor)pagefaults 0swaps

960.80user 122.04system 18:18.99elapsed 98%CPU (0avgtext+0avgdata
239644maxresident)k
0inputs+217152outputs (0major+51557386minor)pagefaults 0swaps


1104.08user 124.48system 20:42.13elapsed 98%CPU (0avgtext+0avgdata
239544maxresident)k
984inputs+217152outputs (21major+51552022minor)pagefaults 0swaps

1101.78user 125.66system 20:40.80elapsed 98%CPU (0avgtext+0avgdata
239692maxresident)k
0inputs+217152outputs (0major+51546446minor)pagefaults 0swaps

1102.98user 126.03system 20:43.09elapsed 98%CPU (0avgtext+0avgdata
239592maxresident)k
0inputs+217152outputs (0major+51551238minor)pagefaults 0swaps

1103.34user 125.32system 20:42.82elapsed 98%CPU (0avgtext+0avgdata
239620maxresident)k
0inputs+217152outputs (0major+51554493minor)pagefaults 0swaps


==== without cache, mitigations on ====

967.19user 115.77system 18:17.20elapsed 98%CPU (0avgtext+0avgdata
239536maxresident)k
25112inputs+217152outputs (166major+51935958minor)pagefaults 0swaps

969.05user 114.18system 18:12.92elapsed 99%CPU (0avgtext+0avgdata
239544maxresident)k
0inputs+217152outputs (0major+51938961minor)pagefaults 0swaps

968.51user 116.50system 18:14.64elapsed 99%CPU (0avgtext+0avgdata
239716maxresident)k
0inputs+217152outputs (0major+51937686minor)pagefaults 0swaps

968.53user 115.13system 18:10.33elapsed 99%CPU (0avgtext+0avgdata
239628maxresident)k
0inputs+217152outputs (0major+51938033minor)pagefaults 0swaps


962.85user 121.56system 18:17.73elapsed 98%CPU (0avgtext+0avgdata
239736maxresident)k
0inputs+217152outputs (0major+51549715minor)pagefaults 0swaps

962.51user 121.74system 18:17.42elapsed 98%CPU (0avgtext+0avgdata
239480maxresident)k
0inputs+217152outputs (0major+51558249minor)pagefaults 0swaps

963.37user 121.24system 18:18.59elapsed 98%CPU (0avgtext+0avgdata
239224maxresident)k
0inputs+217152outputs (0major+51551031minor)pagefaults 0swaps

963.71user 120.75system 18:17.70elapsed 98%CPU (0avgtext+0avgdata
239460maxresident)k
0inputs+217152outputs (0major+51555583minor)pagefaults 0swaps


1103.35user 126.49system 20:45.59elapsed 98%CPU (0avgtext+0avgdata
239600maxresident)k
984inputs+217152outputs (21major+51557916minor)pagefaults 0swaps

1103.01user 126.69system 20:45.36elapsed 98%CPU (0avgtext+0avgdata
239708maxresident)k
232inputs+217152outputs (0major+51560311minor)pagefaults 0swaps

1102.97user 127.13system 20:44.73elapsed 98%CPU (0avgtext+0avgdata
239440maxresident)k
0inputs+217152outputs (0major+51552998minor)pagefaults 0swaps

1103.09user 127.01system 20:44.48elapsed 98%CPU (0avgtext+0avgdata
239448maxresident)k
0inputs+217152outputs (0major+51559328minor)pagefaults 0swaps


==== with cache, mitigations off ====

971.35user 114.45system 18:16.36elapsed 99%CPU (0avgtext+0avgdata
239740maxresident)k
1584inputs+217152outputs (10major+51937572minor)pagefaults 0swaps

971.75user 115.18system 18:16.04elapsed 99%CPU (0avgtext+0avgdata
239648maxresident)k
0inputs+217152outputs (0major+51944016minor)pagefaults 0swaps

972.03user 114.47system 18:16.12elapsed 99%CPU (0avgtext+0avgdata
239368maxresident)k
744inputs+217152outputs (0major+51946745minor)pagefaults 0swaps

970.59user 115.13system 18:15.21elapsed 99%CPU (0avgtext+0avgdata
239736maxresident)k
0inputs+217152outputs (1major+51936971minor)pagefaults 0swaps


964.13user 121.15system 18:17.44elapsed 98%CPU (0avgtext+0avgdata
239496maxresident)k
0inputs+217152outputs (0major+51554855minor)pagefaults 0swaps

964.46user 120.73system 18:16.89elapsed 98%CPU (0avgtext+0avgdata
239492maxresident)k
0inputs+217152outputs (0major+51563668minor)pagefaults 0swaps

964.00user 121.71system 18:18.42elapsed 98%CPU (0avgtext+0avgdata
239504maxresident)k
0inputs+217152outputs (0major+51549101minor)pagefaults 0swaps

963.99user 121.46system 18:17.72elapsed 98%CPU (0avgtext+0avgdata
239644maxresident)k
0inputs+217152outputs (0major+51561705minor)pagefaults 0swaps


993.01user 123.83system 18:47.73elapsed 99%CPU (0avgtext+0avgdata
239648maxresident)k
984inputs+217152outputs (21major+51554203minor)pagefaults 0swaps

991.53user 125.49system 18:47.28elapsed 99%CPU (0avgtext+0avgdata
239380maxresident)k
0inputs+217152outputs (0major+51557014minor)pagefaults 0swaps

992.52user 124.53system 18:47.61elapsed 99%CPU (0avgtext+0avgdata
239344maxresident)k
0inputs+217152outputs (0major+51555681minor)pagefaults 0swaps

993.47user 125.01system 18:48.98elapsed 99%CPU (0avgtext+0avgdata
239448maxresident)k
0inputs+217152outputs (0major+51558830minor)pagefaults 0swaps


==== without cache, mitigations off ====

969.87user 118.18system 18:16.82elapsed 99%CPU (0avgtext+0avgdata
239640maxresident)k
0inputs+217152outputs (0major+51937042minor)pagefaults 0swaps

971.42user 114.62system 18:14.93elapsed 99%CPU (0avgtext+0avgdata
239840maxresident)k
0inputs+217152outputs (0major+51937617minor)pagefaults 0swaps

971.73user 114.40system 18:15.39elapsed 99%CPU (0avgtext+0avgdata
239724maxresident)k
0inputs+217152outputs (0major+51937768minor)pagefaults 0swaps

969.71user 117.13system 18:15.95elapsed 99%CPU (0avgtext+0avgdata
239680maxresident)k
0inputs+217152outputs (0major+51940505minor)pagefaults 0swaps


963.51user 121.32system 18:16.91elapsed 98%CPU (0avgtext+0avgdata
239516maxresident)k
0inputs+217152outputs (0major+51561337minor)pagefaults 0swaps

963.10user 120.75system 18:17.34elapsed 98%CPU (0avgtext+0avgdata
239464maxresident)k
0inputs+217152outputs (0major+51547338minor)pagefaults 0swaps

962.27user 122.48system 18:16.59elapsed 98%CPU (0avgtext+0avgdata
239544maxresident)k
0inputs+217152outputs (0major+51552060minor)pagefaults 0swaps

962.83user 120.21system 18:15.37elapsed 98%CPU (0avgtext+0avgdata
239496maxresident)k
0inputs+217152outputs (0major+51553345minor)pagefaults 0swaps


990.69user 125.78system 18:48.93elapsed 98%CPU (0avgtext+0avgdata
239440maxresident)k
984inputs+217152outputs (21major+51558142minor)pagefaults 0swaps

990.76user 126.01system 18:48.88elapsed 98%CPU (0avgtext+0avgdata
239800maxresident)k
0inputs+217152outputs (0major+51558483minor)pagefaults 0swaps

991.06user 125.99system 18:49.30elapsed 98%CPU (0avgtext+0avgdata
239412maxresident)k
0inputs+217152outputs (0major+51556462minor)pagefaults 0swaps

992.33user 124.77system 18:49.09elapsed 98%CPU (0avgtext+0avgdata
239684maxresident)k
0inputs+217152outputs (0major+51549745minor)pagefaults 0swaps

YiFei Zhu
