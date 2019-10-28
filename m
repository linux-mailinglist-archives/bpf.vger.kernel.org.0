Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2143E767B
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2019 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfJ1QfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 12:35:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38294 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1QfF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Oct 2019 12:35:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id e2so509875qkn.5;
        Mon, 28 Oct 2019 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+aaQaPqwGlljXNVka1r+JhSy4Zf+a+9Gc7qygXgWUc=;
        b=itcaaYE+6GYl7pYCTNs783iHbnIXCBRhBT5HZoTDKGLtfzAmiJNHHZsE4VFqtDZx7T
         UqJ5M23i3aReXLRLW3WGspIaS+/ocHq9m7583tJgeZnU7eY/Qh125Nr/w8wiCbtU67Cw
         dWYE/5gZRtPf7EvpL/YdTqqvIYg3+PCr/Tkyonte6symJr172CQ6zldSCfZatb4WPSy2
         C7NcLPS1mvVB61RuZV9BzUj5JjlDNhH3qaXE1luUZu8LXHSWsInDhnv3RGQZCX5ZfCRj
         GQiVUxdKOilZEoi7zjvyQyztqEHWtj9KrpvsHkGklyjP9le1t3HkthmY7aiVJMT41Wuh
         0n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+aaQaPqwGlljXNVka1r+JhSy4Zf+a+9Gc7qygXgWUc=;
        b=ASMMI/+Srf43jWZCru+Cp3fSQEduxmVe6h/KJfsIoFPYFiMXY27W5BsNlMa7Sa4+sk
         8dkJEHQdqNHrXnLWu7XDoOdyvVg5jviiMpafsXrEc2hb0FJ6caGY9T95vMEiSRfEdITc
         2t4wjBRVbfjovqmwLelQEnKQpGuD/vGVb9L/OUi8SlSDEExYCgRO2VFj25cED1zUX36d
         G2y+qu5Q00V6RmizSda9o0/ir+Z6B5KggheoxY2Rbtr1IR9d1subgBO2ZB5DCDdjCOMS
         fx0KpXbgdbPY8zxhofudy7t2i5eVVi7G6d4tM8g75JvyYhtqs+ynyQNSg0zsPrYagi5v
         eonA==
X-Gm-Message-State: APjAAAWxrDxssT/lc/hfLcqHVj1opDeWVqrvJEBtf3ZIlk24x4KCcURw
        kEVY2sGj8CSawsQt7HayUXIbmpBbFkXld8KElPk=
X-Google-Smtp-Source: APXvYqz0dPnDdjILrb5YtPndmQYL57MVOTiyyCF/W1X8UTqB8VyxmZorl20aGamjoPhIGXNrrvpfAqtAA09M6XH9vJA=
X-Received: by 2002:a37:8f83:: with SMTP id r125mr17141253qkd.36.1572280503386;
 Mon, 28 Oct 2019 09:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191027052042.GK29418@shao2-debian>
In-Reply-To: <20191027052042.GK29418@shao2-debian>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Oct 2019 09:34:52 -0700
Message-ID: <CAEf4BzabWfxxCwxLUbcAyTSZuc-qMd2ROBvVo8kgCg1cUx7r7w@mail.gmail.com>
Subject: Re: [libbpf] dd4436bb83: kernel_selftests.bpf.test_section_names.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 26, 2019 at 10:28 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: dd4436bb838338cfda253d7f012610a73e4078fd ("libbpf: Teach bpf_obje=
ct__open to guess program types")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: kernel_selftests
> with following parameters:
>
>         group: kselftests-00
>
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>


This was already fixed in 9bc6384b3644 ("selftests/bpf: Move
test_section_names into test_progs and fix it"), does this robot
automatically pick fixes like this and resolves the issue?

>
>
> # selftests: bpf: test_section_names
> # libbpf: failed to guess program type based on ELF section name 'InvAliD=
'
> # libbpf: supported section(type) names are: socket kprobe/ uprobe/ kretp=
robe/ uretprobe/ classifier action tracepoint/ tp/ raw_tracepoint/ raw_tp/ =
tp_btf/ xdp perf_event lwt_in lwt_out lwt_xmit lwt_seg6local cgroup_skb/ing=
ress cgroup_skb/egress cgroup/skb cgroup/sock cgroup/post_bind4 cgroup/post=
_bind6 cgroup/dev sockops sk_skb/stream_parser sk_skb/stream_verdict sk_skb=
 sk_msg lirc_mode2 flow_dissector cgroup/bind4 cgroup/bind6 cgroup/connect4=
 cgroup/connect6 cgroup/sendmsg4 cgroup/sendmsg6 cgroup/recvmsg4 cgroup/rec=
vmsg6 cgroup/sysctl cgroup/getsockopt cgroup/setsockopt
> # test_section_names: prog: unexpected rc=3D-3 for InvAliD
> # libbpf: failed to guess program type based on ELF section name 'cgroup'
> # libbpf: supported section(type) names are: socket kprobe/ uprobe/ kretp=
robe/ uretprobe/ classifier action tracepoint/ tp/ raw_tracepoint/ raw_tp/ =
tp_btf/ xdp perf_event lwt_in lwt_out lwt_xmit lwt_seg6local cgroup_skb/ing=
ress cgroup_skb/egress cgroup/skb cgroup/sock cgroup/post_bind4 cgroup/post=
_bind6 cgroup/dev sockops sk_skb/stream_parser sk_skb/stream_verdict sk_skb=
 sk_msg lirc_mode2 flow_dissector cgroup/bind4 cgroup/bind6 cgroup/connect4=
 cgroup/connect6 cgroup/sendmsg4 cgroup/sendmsg6 cgroup/recvmsg4 cgroup/rec=
vmsg6 cgroup/sysctl cgroup/getsockopt cgroup/setsockopt
> # test_section_names: prog: unexpected rc=3D-3 for cgroup
> # Summary: 38 PASSED, 2 FAILED
> not ok 18 selftests: bpf: test_section_names
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.4.0-rc1-00595-gdd4436bb83833 .config
>         make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Dx86_64 olddefconfig prepare=
 modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in =
this email
>
>
>
> Thanks,
> Rong Chen
>
