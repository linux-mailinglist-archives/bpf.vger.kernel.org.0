Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092AD594F1F
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiHPDjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiHPDiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 23:38:52 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F531E9EE
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:10:29 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q15so8734643vsr.0
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WUwQUmm86mrg7jfd67SR7hvLt+P/EPMPpiu5qcCEU9Q=;
        b=DugmTmCfgSIZMobBDrFpw+1hjqm+tCxikmr09GDxF6IEnCqGFIfKr9YR71/fRRv+RU
         hD3O/AJ0g+/X+LvbrzI/DaUzHkY5HrZ9vcfaBO2I8U+5tJAu6ERtmQXIX3GScSkEfHby
         mzbNLlBZMu0L9Z2x5ATZQq1x3BCDqzTXpgQYEYXipHfDKlhTZnp3Hzt0vrxg7LKdXE8W
         RBdQL2hAZmaSVi53Npp11S65EIeNlfJ5oqDuTGJzrARPzlqJg+eUmpffX/0X40Wsppuy
         2dyMD8Pm2/0oHb71nYYZFvr67JwBtth6ZryclekTp5V1EIKq3IYRNOJ9cha0k5qmnw5l
         IpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WUwQUmm86mrg7jfd67SR7hvLt+P/EPMPpiu5qcCEU9Q=;
        b=pYVJESkNJfJd9ouEvo5+K7wWMNF0vg1S5kmRbWT2GFFGqt3Cp8inJXxJkRocIj/0a0
         +tPmB16px6T0f+O/Igl+brDxjUces84UlEwq32r1Z7T8GffRJVbElFFryf9YiR7l4GqE
         lKRbEi1iV/kcjEbD6TkB6S7Kdyz1MlChmL6djsWanPCh+UknKT9msmUpfU221C2RoBwx
         sz2XovnGiomf1tn5sf3s0+H0Myqy/FbfOr0JoSmQcIAsYfOwfQkANm7GvVFQc/MHTNN9
         woWFbiHZbgbKkMKtHN6tzELNjnfvsGOAPgTAk1fwT11pKB9FhzMm6K+e9RcXzVXObJ9p
         om/w==
X-Gm-Message-State: ACgBeo3A849QuzDmTffrxjCzcdPRZdPtDMaVM29u1poqrtbQN3mRzktM
        tltY1ExbXUbQaKkeGaUUiH5C1K8iIAXYE15D6P5kEnlM
X-Google-Smtp-Source: AA6agR68HRa6sTQ1U6HWBQ4+EiQ/Gq3OUpCCB5mH3Hz1AieeKatpQeZBRXUOLgXZsjFOYdlewdbER9b8tO1+aGwmSlg=
X-Received: by 2002:a05:6102:3119:b0:388:713c:7eb6 with SMTP id
 e25-20020a056102311900b00388713c7eb6mr7748711vsh.34.1660608626418; Mon, 15
 Aug 2022 17:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
 <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com> <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
In-Reply-To: <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 15 Aug 2022 17:10:15 -0700
Message-ID: <CAK3+h2zH+KoJ1FwYsFVk3H5N0D5JdVMkEh4PzvsRQ5fymCY_Dw@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 5:05 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Mon, 15 Aug 2022 at 23:26, Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
> > > > machine, I also compiled bpftool from bpf-next on same machine, when
> > > > run bpftool on same machine, I got :
> > > >
> > > > ./bpftool feature probe
> > > >
> > > > Error: bug: failed to retrieve CAP_BPF status: Invalid argument
> > > >
> > > > where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere else?
> > >
> > > Yes, bpftool calls cap_get_proc() to get the capabilities of the
> > > current process. From what I understand of your output, it looks like
> > > capget() returns CAP_BPF: I believe the "0x1c0" value at the end is
> > > (1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
> > > (1<<(CAP_PERFMON-32)). You could probably check this with a more
> > > recent version of strace.
> > >
> > > Then assuming you do retrieve CAP_BPF from capget(), I don't know why
> > > cap_get_flag() in bpftool fails to retrieve the capability state. It
> > > would be worth running bpftool in GDB to check what happens. The check
> > > in libcap is here [0] but I don't see where we would fail to provide
> > > valid arguments. Just in case, could you please let me know what
> > > version of libcap you're using when compiling bpftool?
> >
> > I think I installed libcap through centos distro
> >
> > [root@centos-dev ~]# rpm -qi libcap.x86_64
> >
> > Name        : libcap
> >
> > Version     : 2.26
>
> So we investigated this on Slack. The issue is related to libcap (and
> to how libcap is built on CentOS); it is fixed in libcap 2.30 and
> older.
>
> For the record, this is the commit that fixed it:
> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f1f62a748d7c67361e91e32d26abafbfb03eeee4
>
> Before this, cap_get_flag() would compare its argument "value" (in our
> case, CAP_BPF == 39) with __CAP_BITS. This __CAP_BITS constant is
> defined in libcap/cap_names.h, generated by libcap/_makenames.c from
> the list in libcap/cap_names.list.h. The latter header file is itself
> generated in libcap/Makefile from the UAPI header at
> $(KERNEL_HEADERS)/linux/capability.h, which defaults to the local
> libcap/include/uapi/linux/capability.h.
>
> On your CentOS, the libcap version may have been compiled without
> setting KERNEL_HEADERS to make it point to the correct system UAPI
> header (or the header could be too old, but looking at it, it seems
> that it does have CAP_BPF), in which case it defaulted to libcap's
> version of the header, which in 2.26 stops at CAP_AUDIT (37). In that
> case, __CAP_BITS is worth 37 and is lower than CAP_BPF, the check in
> cap_get_flag() fails and we get -EINVAL.
>
> The commit referenced above changed the comparison for libcap 2.30+ to
> compare "value" with __CAP_MAXBITS == 64 instead, which works
> correctly.
>
> Thanks for the report and the shared debug session!
> Quentin

Thanks Quentin for your quick response and analysis :)
