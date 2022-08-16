Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3B595A30
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiHPLdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiHPLcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 07:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF419030
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 03:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D30AB8169C
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B8C433C1;
        Tue, 16 Aug 2022 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660647143;
        bh=akFmCyQTW6LSo0XRAuEr92evm+Lp8AoGLKIuEvbzwkY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i61g6lB2uocqJPk5OWE4MQMtwOlP+SL2GZnFU8apErEHbN4m6sGfDN6wilPXvG6ob
         dYpHV4FedO9nYVq5XdAmRK0LuJGFUJzTDOqHDjlPu0EZw2krVEC2Fe/hhkXmy8iq4t
         vrlRSKWFVADrvo6DcajdyMwPWMpRmxsShYuSwEJt1Cu80Eun2PTPLgDdddcMkmuHb2
         W6AY/cSj3ls0/BkxVwnGwDyxbqt7X4RcBahSFJbHlbY/8FhFCTPASlMq96M/FgTAce
         2Yyt2+boWP7dARfjqQDVy6nM+Iis34liVn642k3ZipnDmWJxj1rDhN7yRxGSnohTmp
         xwemwkNLE4nyA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 945B455F601; Tue, 16 Aug 2022 12:52:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Vincent Li <vincent.mc.li@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
In-Reply-To: <CAK3+h2zH+KoJ1FwYsFVk3H5N0D5JdVMkEh4PzvsRQ5fymCY_Dw@mail.gmail.com>
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
 <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com>
 <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
 <CAK3+h2zH+KoJ1FwYsFVk3H5N0D5JdVMkEh4PzvsRQ5fymCY_Dw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 16 Aug 2022 12:52:20 +0200
Message-ID: <87sflwwjdn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>Vincent Li <vincent.mc.li@gmail.com> writes:

> On Mon, Aug 15, 2022 at 5:05 PM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> On Mon, 15 Aug 2022 at 23:26, Vincent Li <vincent.mc.li@gmail.com> wrote:
>> >
>> > On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.com> wrote:
>> > >
>> > > Hi Vincent,
>> > >
>> > > On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com> wrote:
>> > > >
>> > > > Hi,
>> > > >
>> > > > I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
>> > > > machine, I also compiled bpftool from bpf-next on same machine, when
>> > > > run bpftool on same machine, I got :
>> > > >
>> > > > ./bpftool feature probe
>> > > >
>> > > > Error: bug: failed to retrieve CAP_BPF status: Invalid argument
>> > > >
>> > > > where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere else?
>> > >
>> > > Yes, bpftool calls cap_get_proc() to get the capabilities of the
>> > > current process. From what I understand of your output, it looks like
>> > > capget() returns CAP_BPF: I believe the "0x1c0" value at the end is
>> > > (1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
>> > > (1<<(CAP_PERFMON-32)). You could probably check this with a more
>> > > recent version of strace.
>> > >
>> > > Then assuming you do retrieve CAP_BPF from capget(), I don't know why
>> > > cap_get_flag() in bpftool fails to retrieve the capability state. It
>> > > would be worth running bpftool in GDB to check what happens. The check
>> > > in libcap is here [0] but I don't see where we would fail to provide
>> > > valid arguments. Just in case, could you please let me know what
>> > > version of libcap you're using when compiling bpftool?
>> >
>> > I think I installed libcap through centos distro
>> >
>> > [root@centos-dev ~]# rpm -qi libcap.x86_64
>> >
>> > Name        : libcap
>> >
>> > Version     : 2.26
>>
>> So we investigated this on Slack. The issue is related to libcap (and
>> to how libcap is built on CentOS); it is fixed in libcap 2.30 and
>> older.
>>
>> For the record, this is the commit that fixed it:
>> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f1f62a748d7c67361e91e32d26abafbfb03eeee4
>>
>> Before this, cap_get_flag() would compare its argument "value" (in our
>> case, CAP_BPF == 39) with __CAP_BITS. This __CAP_BITS constant is
>> defined in libcap/cap_names.h, generated by libcap/_makenames.c from
>> the list in libcap/cap_names.list.h. The latter header file is itself
>> generated in libcap/Makefile from the UAPI header at
>> $(KERNEL_HEADERS)/linux/capability.h, which defaults to the local
>> libcap/include/uapi/linux/capability.h.
>>
>> On your CentOS, the libcap version may have been compiled without
>> setting KERNEL_HEADERS to make it point to the correct system UAPI
>> header (or the header could be too old, but looking at it, it seems
>> that it does have CAP_BPF), in which case it defaulted to libcap's
>> version of the header, which in 2.26 stops at CAP_AUDIT (37). In that
>> case, __CAP_BITS is worth 37 and is lower than CAP_BPF, the check in
>> cap_get_flag() fails and we get -EINVAL.
>>
>> The commit referenced above changed the comparison for libcap 2.30+ to
>> compare "value" with __CAP_MAXBITS == 64 instead, which works
>> correctly.
>>
>> Thanks for the report and the shared debug session!
>> Quentin
>
> Thanks Quentin for your quick response and analysis :)

FYI, CAP_BPF should also be fixed in the version of libcap shipped with
RHEL8.5 (version libcap-2.26-5.el8). This should be available in CentOS
Stream as well, so just updating the package should be enough...

-Toke
