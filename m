Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9A5221A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 06:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFYEgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 00:36:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34519 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYEgb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 00:36:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so17053322qtu.1;
        Mon, 24 Jun 2019 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYGdSGrmZfmtMRAQeIjWMBRqIG6xDBFrIGVgAav8rHY=;
        b=OP2fTXcd/ihtKT1lLknC8yi44n3afuwSvoSaIF1wAyKbyK6hhd6gBuO2CYdhc9KhrQ
         Bfehrx8MHErPpXAPIVhZbZwz20A0W0eenHtiehfwhn0dSzUDO1hMfyV9kIbxe+ik0xTL
         R5F0KEAUGynXOhnOKac00ItRST+tcBSb5wmWd6aYAjl/OzqbR/GSGJ0ElzI8Yh0oksQm
         GYGN8gbQnqpfpbWqkb3dALvol0VTsRS6UahcDwfzBOcwJzkCrj6srQOPs77Hani8myaS
         xwqfZL1S9R8w6/HZsIkv9TaxPdlXC9Sg6cmQAo0WM4vokv5MuMHW9XQMJ9fAa8UDCk5U
         puNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYGdSGrmZfmtMRAQeIjWMBRqIG6xDBFrIGVgAav8rHY=;
        b=pMsQndvuF3hJjsbTVtEliZHU3KSQrknoBy2yifhDz9gNPwBs9raC6/i6L4fleAYa3X
         ybCVSB8lZk+/9eSr95t8pgIJuIpLqD9AKGPiaU97gQV6LMmOxGlwThJDgeA9JI+JEvWd
         nfM41VV1m4fN9gq/bYRiS88LT9RaaIoDQds8UXKAQGSdDErNf6xrmz0w2i5YY5uZKGkI
         aGWcQCILNGRBRWj83a4GDWpK3de8Mr1BnrcZRmpJROWAWGyHk9RXEf3quxFrJXQU1soz
         nVLFZotYelsJrXHCV9SIeCEwnG9x1dGPRhsWE2f1QOR4iLYEXuM1Pw7mNxHQzrlGVVOx
         zxCQ==
X-Gm-Message-State: APjAAAWM/rC55axgDE1fC7by+92kIktI6vjmIjEWadCvazGHcghjmIlH
        lYBbRNIddQFDXSjMdJL5zmwZEt2C1BbrTQA7T1+qXEXqKHY=
X-Google-Smtp-Source: APXvYqwxd0iiNsB1bFrX8O3LalR5IW+ONRR/Hpb7naEqRQfTuoVI5DCl1U393mEgzv1sf982/7UhTWsAQMYO0onl0DU=
X-Received: by 2002:ac8:2fb7:: with SMTP id l52mr105916304qta.93.1561437389900;
 Mon, 24 Jun 2019 21:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190621084040.GU7221@shao2-debian> <20190621161039.GF1383@mini-arch>
 <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
 <20190621222745.GH1383@mini-arch> <f3aa0dc2-c959-1166-8b09-84781363f0e0@intel.com>
 <CAEf4BzaNBboGeU8xOxyW-aDzEPUQq-LidRzj8V08O=_TynkQOQ@mail.gmail.com> <20190624212422.GA10487@mini-arch>
In-Reply-To: <20190624212422.GA10487@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jun 2019 21:36:18 -0700
Message-ID: <CAEf4BzY5oSY_mzgEr7Jy7+mTUYvg8XeohjHRMZ5GJV7VbrEJ1w@mail.gmail.com>
Subject: Re: [selftests/bpf] 69d96519db: kernel_selftests.bpf.test_socket_cookie.fail
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 24, 2019 at 2:24 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/24, Andrii Nakryiko wrote:
> > On Sun, Jun 23, 2019 at 5:59 PM Rong Chen <rong.a.chen@intel.com> wrote:
> > >
> > > On 6/22/19 6:27 AM, Stanislav Fomichev wrote:
> > > > On 06/21, Andrii Nakryiko wrote:
> > > >> )
> > > >>
> > > >> On Fri, Jun 21, 2019 at 9:11 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >>> On 06/21, kernel test robot wrote:
> > > >>>> FYI, we noticed the following commit (built with gcc-7):
> > > >>>>
> > > >>>> commit: 69d96519dbf0bfa1868dc8597d4b9b2cdeb009d7 ("selftests/bpf: convert socket_cookie test to sk storage")
> > > >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >>>>
> > > >>>> in testcase: kernel_selftests
> > > >>>> with following parameters:
> > > >>>>
> > > >>>>        group: kselftests-00
> > > >>>>
> > > >>>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > > >>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > > >>>>
> > > >>>>
> > > >>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > > >>>>
> > > >>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > >>>>
> > > >>>>
> > > >>>> If you fix the issue, kindly add following tag
> > > >>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > >>>>
> > > >>>> # selftests: bpf: test_socket_cookie
> > > >>>> # libbpf: failed to create map (name: 'socket_cookies'): Invalid
> > > >>>> # argument
> > > >>> Another case of old clang trying to create a map that depends on BTF?
> > > >>> Should we maybe switch those BTF checks in the kernel to return
> > > >>> EOPNOTSUPP to make it easy to diagnose?
> > > >> For older compilers that don't generate DATASEC/VAR, you'll see a clear message:
> > > >>
> > > >> libbpf: DATASEC '.maps' not found.
> > > >>
> > > >> So this must be something else. I just confirmed with clang version
> > > >> 7.0.20180201 that for ./test_socket_cookie that's the first line
> > > >> that's emitted on failure.
> > > > Thanks for checking, I also took a look at the attached kernel_selftests.xz,
> > > > here is what it has:
> > > > 2019-06-21 11:58:35 ln -sf /usr/bin/clang-6.0 /usr/bin/clang
> > > > 2019-06-21 11:58:35 ln -sf /usr/bin/llc-6.0 /usr/bin/llc
> > > > ...
> > > > # BTF libbpf test[1] (test_btf_haskv.o): SKIP. No ELF .BTF found
> > > > # BTF libbpf test[2] (test_btf_nokv.o): SKIP. No ELF .BTF found
> > > > ...
> > > > # Test case #0 (btf_dump_test_case_syntax): test_btf_dump_case:71:FAIL
> > > > # failed to load test BTF: -2
> > > > # Test case #1 (btf_dump_test_case_ordering): test_btf_dump_case:71:FAIL
> > > > # failed to load test BTF: -2
> > > > ...
> > > >
> > > > And so on. So there is clearly an old clang that doesn't emit any
> > > > BTF. And I also don't see your recent abd29c931459 before 69d96519dbf0 in
> > > > linux-next, that's why it doesn't complain about missing/corrupt BTF.
> >
> > Ah, ok, that would explain it. But in any case, clang 6&7 is too old.
> > Clang 8 or better yet clang 9 (for global data, datasec/var-dependent
> > stuff) would be great.
> While we are it: I think I have resolved the BTF story internally,
> so if you want to go ahead and convert the rest of the tests to
> BTF format, I would not object anymore ;-)

Glad Clang update went so smooth for you :) I'm going to post an
update to BTF-defined maps (see my updated proposal for updated
approach), so might do the rest of conversion at that time.

>
> (I didn't expect it to be that easy initially, so sorry if I wasted
> everyones time arguing about it).

no worries :)

>
> > > >
> > > > We need to convince lkp people to upgrade clang, otherwise, I suppose,
> > > > we'll get more of these reportings after your recent df0b77925982 :-(
> > >
> > > Thanks for the clarification, we'll upgrade clang asap.
> >
> > Thanks Rong!
> >
> > >
> > > Best Regards,
> > > Rong Chen
> > >
> > >
> > > >
> > > >>>> # libbpf: failed to load object './socket_cookie_prog.o'
> > > >>>> # (test_socket_cookie.c:149: errno: Invalid argument) Failed to load
> > > >>>> # ./socket_cookie_prog.o
> > > >>>> # FAILED
> > > >>>> not ok 15 selftests: bpf: test_socket_cookie
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> To reproduce:
> > > >>>>
> > > >>>>          # build kernel
> > > >>>>        cd linux
> > > >>>>        cp config-5.2.0-rc2-00598-g69d9651 .config
> > > >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> > > >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> > > >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> > > >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> > > >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> > > >>>>
> > > >>>>
> > > >>>>          git clone https://github.com/intel/lkp-tests.git
> > > >>>>          cd lkp-tests
> > > >>>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Rong Chen
> > > >>>>
> > > >> <mega snip>
