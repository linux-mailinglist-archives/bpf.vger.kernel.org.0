Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC1595268
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiHPGQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 02:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHPGQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 02:16:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8F169C77
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:05:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l18so6793101qvt.13
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RU77Jendo2kic39xt1Kby8MDy4zJtFP6/Th0ed1ko1A=;
        b=BhdoTuQYWMZU9APY/ZhzMYpQDSQCCTsxlamnEwLuIu7QhHHgAfqPdTvc1Y+f+pi/gc
         PtHRluCzQNgi/dQdX17GhSVg7T0O6wuudVZ2STltA8ux4UXwtNUOy/+6yMLEveT6N2y9
         6Fb1gbzCyu00ZEI6eA1bDEyDuFhxzFiQvQ6eyn75swI7RA5Yc5RUcWFoBQPiqzjGgSj6
         sDqnCW4uWGvmWFowvkHmAVR+HR06v80XusvKrwdNC791qN0D4awA5m7FbxjUpKwDsbRK
         sFOkxYX4O92yof/UOx+mG5SU0p8c9n81UD3fYormxcyGe5AYuLvOHL7o7pILprf9iQ0B
         kg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RU77Jendo2kic39xt1Kby8MDy4zJtFP6/Th0ed1ko1A=;
        b=DzTUWnmBntzX3G4k6fBYYXo2DDmk3/8tt3uIfFHywd98QL/TyTGckgLp5IV64NWVVi
         7+IByY0g7faiVnixLknDLDLNla+UrRcUiHGy4RiVcl8F7zs/cxzPfYqzpF51xNC5ACA+
         Dgi0I+scQWN8athh+gUKr3ORvfYvWy3glHg2hJpgItDo4eZMy99dOLO1YyuzrcWXuJRo
         V9WH8gbxpaWikWOiQL9yMokOHABKVMKwrMIA4+TJIy6gPmjxTDILFa5o+LgZ4y0y1oUZ
         ZXTaVveiLDtMDtOEBvLdA5/sehPWxfSyfeY7aQaBdox8Dpr+4ir5OmklZYj9bNRmDtEk
         CsVg==
X-Gm-Message-State: ACgBeo1fBhFCbRfVNU3iSckQkTe3ZwBxLLWSjggsvWSSKU8oaYl9YUr2
        pqiEe2yS+xnY/z4YnMe9ZEl2Cu4gd//5V1Mq/U9rnA==
X-Google-Smtp-Source: AA6agR7Ne06P8DazkV9STsjl4ZFM4DVsi2UNPCDHrgWd72pT4jRIz6sHg9LfbM9aTHEzh3H7d60OkDjDNvOrGzfssoU=
X-Received: by 2002:a05:6214:2485:b0:474:8008:c433 with SMTP id
 gi5-20020a056214248500b004748008c433mr15685480qvb.12.1660608326200; Mon, 15
 Aug 2022 17:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com> <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com>
In-Reply-To: <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 16 Aug 2022 01:05:14 +0100
Message-ID: <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 at 23:26, Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > Hi Vincent,
> >
> > On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
> > > machine, I also compiled bpftool from bpf-next on same machine, when
> > > run bpftool on same machine, I got :
> > >
> > > ./bpftool feature probe
> > >
> > > Error: bug: failed to retrieve CAP_BPF status: Invalid argument
> > >
> > > where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere else?
> >
> > Yes, bpftool calls cap_get_proc() to get the capabilities of the
> > current process. From what I understand of your output, it looks like
> > capget() returns CAP_BPF: I believe the "0x1c0" value at the end is
> > (1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
> > (1<<(CAP_PERFMON-32)). You could probably check this with a more
> > recent version of strace.
> >
> > Then assuming you do retrieve CAP_BPF from capget(), I don't know why
> > cap_get_flag() in bpftool fails to retrieve the capability state. It
> > would be worth running bpftool in GDB to check what happens. The check
> > in libcap is here [0] but I don't see where we would fail to provide
> > valid arguments. Just in case, could you please let me know what
> > version of libcap you're using when compiling bpftool?
>
> I think I installed libcap through centos distro
>
> [root@centos-dev ~]# rpm -qi libcap.x86_64
>
> Name        : libcap
>
> Version     : 2.26

So we investigated this on Slack. The issue is related to libcap (and
to how libcap is built on CentOS); it is fixed in libcap 2.30 and
older.

For the record, this is the commit that fixed it:
https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f1f62a748d7c67361e91e32d26abafbfb03eeee4

Before this, cap_get_flag() would compare its argument "value" (in our
case, CAP_BPF == 39) with __CAP_BITS. This __CAP_BITS constant is
defined in libcap/cap_names.h, generated by libcap/_makenames.c from
the list in libcap/cap_names.list.h. The latter header file is itself
generated in libcap/Makefile from the UAPI header at
$(KERNEL_HEADERS)/linux/capability.h, which defaults to the local
libcap/include/uapi/linux/capability.h.

On your CentOS, the libcap version may have been compiled without
setting KERNEL_HEADERS to make it point to the correct system UAPI
header (or the header could be too old, but looking at it, it seems
that it does have CAP_BPF), in which case it defaulted to libcap's
version of the header, which in 2.26 stops at CAP_AUDIT (37). In that
case, __CAP_BITS is worth 37 and is lower than CAP_BPF, the check in
cap_get_flag() fails and we get -EINVAL.

The commit referenced above changed the comparison for libcap 2.30+ to
compare "value" with __CAP_MAXBITS == 64 instead, which works
correctly.

Thanks for the report and the shared debug session!
Quentin
