Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08051A7B
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFXS0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 14:26:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfFXS0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 14:26:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so15553823qtl.3;
        Mon, 24 Jun 2019 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9uoR+KIuE1II8mD60iebYIvLAFwPjD50xd1uMdBmX4=;
        b=HsJf5K+XiynaUtH0EQHleY1DehgR5I73UNWc4B8ezA8f+JAS0PbGbiGzZgdWd6cQXy
         wJmtHrGPeWD5KCUPKvtBWJfDuB93b+afyICO/Ix3bGKGbot2piuwd8nQckRFs3sVhv3F
         4tr0dtv1KkJh9Efc5VGIWljCb4AHVAgdVcMcUwD5RSs6K70Hf539f0eJv7F8Mfe4Eux8
         02kBt8M2tlsDqBN6o1CyI40spDnYU3pblJZF6PT2ITHApVLJR0wK5v8pERXKPTnFkTRb
         jKzs9+7+ZRVHdZd047MqXUVhAaDM1vPpVYqXoHFdywewLzg1Jk6lDrdn/dlX178HBHBn
         wsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9uoR+KIuE1II8mD60iebYIvLAFwPjD50xd1uMdBmX4=;
        b=gilwWx9zS/qqUYYps17sgGvt/qPODa5UDc/+bafy6GEAtwZ6ofChpgE6Tlmz3F2Uxj
         wboMAbjk4ijiYbTXcbAxBShonKEHNqa4AU0nfkAMuC6OswvSy1srVSvH7p4e19Ag48ka
         Nd5FlvrhND6mbRNJbSXvZjb0fzIqjAZH29OXEXjieOMQbI7JatvJjHg/mham3b0dOmyc
         aQ8cgVLKnCZbqw+fA1keFWj3yYlW31pv1TjHNF82iV7pKtVYgkpbaNm2CkvDtAKg6Gz1
         kPQb9svCdIwWa7MJGzi5e/whrswDHUOFVXznuS9+WidOYsO/XVgaqJo4xXfHq+iLDMPa
         2RQg==
X-Gm-Message-State: APjAAAXr7DOJI8JyCBazS753vVKKagvw1w7p6X5VAgHTxyqQ9B8WDlah
        K16UGvw6VYegYNSJ2zb2YSHUsIuRTU0H3uAZ9Eo=
X-Google-Smtp-Source: APXvYqyX7Yqi62/9W21qqWsZBV0Zu1HZmK4IeRtasql6wmRV4UqjV0hD5sevr26Ix9vyKLwGEVpUKaKxqEg/Q5I8zVU=
X-Received: by 2002:a0c:ae50:: with SMTP id z16mr57345303qvc.60.1561400771509;
 Mon, 24 Jun 2019 11:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190621084040.GU7221@shao2-debian> <20190621161039.GF1383@mini-arch>
 <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
 <20190621222745.GH1383@mini-arch> <f3aa0dc2-c959-1166-8b09-84781363f0e0@intel.com>
In-Reply-To: <f3aa0dc2-c959-1166-8b09-84781363f0e0@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jun 2019 11:26:00 -0700
Message-ID: <CAEf4BzaNBboGeU8xOxyW-aDzEPUQq-LidRzj8V08O=_TynkQOQ@mail.gmail.com>
Subject: Re: [selftests/bpf] 69d96519db: kernel_selftests.bpf.test_socket_cookie.fail
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
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

On Sun, Jun 23, 2019 at 5:59 PM Rong Chen <rong.a.chen@intel.com> wrote:
>
> On 6/22/19 6:27 AM, Stanislav Fomichev wrote:
> > On 06/21, Andrii Nakryiko wrote:
> >> )
> >>
> >> On Fri, Jun 21, 2019 at 9:11 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >>> On 06/21, kernel test robot wrote:
> >>>> FYI, we noticed the following commit (built with gcc-7):
> >>>>
> >>>> commit: 69d96519dbf0bfa1868dc8597d4b9b2cdeb009d7 ("selftests/bpf: convert socket_cookie test to sk storage")
> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >>>>
> >>>> in testcase: kernel_selftests
> >>>> with following parameters:
> >>>>
> >>>>        group: kselftests-00
> >>>>
> >>>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> >>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >>>>
> >>>>
> >>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> >>>>
> >>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>>>
> >>>>
> >>>> If you fix the issue, kindly add following tag
> >>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>>>
> >>>> # selftests: bpf: test_socket_cookie
> >>>> # libbpf: failed to create map (name: 'socket_cookies'): Invalid
> >>>> # argument
> >>> Another case of old clang trying to create a map that depends on BTF?
> >>> Should we maybe switch those BTF checks in the kernel to return
> >>> EOPNOTSUPP to make it easy to diagnose?
> >> For older compilers that don't generate DATASEC/VAR, you'll see a clear message:
> >>
> >> libbpf: DATASEC '.maps' not found.
> >>
> >> So this must be something else. I just confirmed with clang version
> >> 7.0.20180201 that for ./test_socket_cookie that's the first line
> >> that's emitted on failure.
> > Thanks for checking, I also took a look at the attached kernel_selftests.xz,
> > here is what it has:
> > 2019-06-21 11:58:35 ln -sf /usr/bin/clang-6.0 /usr/bin/clang
> > 2019-06-21 11:58:35 ln -sf /usr/bin/llc-6.0 /usr/bin/llc
> > ...
> > # BTF libbpf test[1] (test_btf_haskv.o): SKIP. No ELF .BTF found
> > # BTF libbpf test[2] (test_btf_nokv.o): SKIP. No ELF .BTF found
> > ...
> > # Test case #0 (btf_dump_test_case_syntax): test_btf_dump_case:71:FAIL
> > # failed to load test BTF: -2
> > # Test case #1 (btf_dump_test_case_ordering): test_btf_dump_case:71:FAIL
> > # failed to load test BTF: -2
> > ...
> >
> > And so on. So there is clearly an old clang that doesn't emit any
> > BTF. And I also don't see your recent abd29c931459 before 69d96519dbf0 in
> > linux-next, that's why it doesn't complain about missing/corrupt BTF.

Ah, ok, that would explain it. But in any case, clang 6&7 is too old.
Clang 8 or better yet clang 9 (for global data, datasec/var-dependent
stuff) would be great.

> >
> > We need to convince lkp people to upgrade clang, otherwise, I suppose,
> > we'll get more of these reportings after your recent df0b77925982 :-(
>
> Thanks for the clarification, we'll upgrade clang asap.

Thanks Rong!

>
> Best Regards,
> Rong Chen
>
>
> >
> >>>> # libbpf: failed to load object './socket_cookie_prog.o'
> >>>> # (test_socket_cookie.c:149: errno: Invalid argument) Failed to load
> >>>> # ./socket_cookie_prog.o
> >>>> # FAILED
> >>>> not ok 15 selftests: bpf: test_socket_cookie
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> To reproduce:
> >>>>
> >>>>          # build kernel
> >>>>        cd linux
> >>>>        cp config-5.2.0-rc2-00598-g69d9651 .config
> >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> >>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> >>>>
> >>>>
> >>>>          git clone https://github.com/intel/lkp-tests.git
> >>>>          cd lkp-tests
> >>>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> >>>>
> >>>>
> >>>>
> >>>> Thanks,
> >>>> Rong Chen
> >>>>
> >> <mega snip>
