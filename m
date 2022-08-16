Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174D5962CD
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiHPTA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHPTA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 15:00:59 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC88868AE
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 12:00:58 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id q15so11100330vsr.0
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=m0vtaA0frmq2sfSj+MxHRwb9E8N8wixsAofze7wPJg4=;
        b=SSNsjtNgKfSTWQyxnJEueamHaxquIumd5tTTUsE+kdiUN1ds8A0YMnWI4C4esOMy7O
         HDqMBJGo2DOkOmQCQ6C3sZyv6B+ShLENWW4gG3Dmm1b3hHy5f4mfYstyqSP41P9dbzBs
         zWtkHW3revFtfazCnu0F5q0FNxS1+I7zBV8SpQUBFR2Ro2wzpd3PmG7K3pkp/2l5piqI
         qA40+y8Mk9M1CxHRH5P4cEGQ9eKefAt13bdcpsEnOVlFTrdafOxYCtwKOXPzsrS8JRW3
         ev3zPkWgb1/DOZv9emXbsG4Cq22rcbbgCJ6qF4Uthzqpp+HkMwO2N7EVJ8PoYqbjmOMX
         nKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=m0vtaA0frmq2sfSj+MxHRwb9E8N8wixsAofze7wPJg4=;
        b=ijrA0N0d2SB+KBCn205VZcYlP/r4RwlRwPZJprqnzKJaYM06uBZs7LD0pNSl+WFDse
         zRMtCXjeqqfWhYxO+zTbangt8HxU9CqZlEUHH/PDzMiWzatGkSaerYqCJksqMUUgOxc3
         nVuKCg7uZT9UCNBT12e+807PHmFO0wb6Nw3S8HL77JBSMH4Ct/luK19PUcb+Fcgaq0t+
         SqA7OZkY3HfbJuniMniyJAsMQ27X0r2mSa/xjwbY1XqOQo3PWKsNlT5SstGoNfAsszp4
         1rcSnlD1BMusdNcbh72mY1c2uMA7GrhyEn9oRSjWP++PRSmiRip4tyKqm4qCgm4uPYrc
         8QqA==
X-Gm-Message-State: ACgBeo0J9J6tVq9SAJavzxEGRH/l1WqHL+meCGAk01Ljb/Fco5ef0wDt
        od9clFzOBgcIrAbPp8yAqw4o+KWhwACZLZDoquovujlM
X-Google-Smtp-Source: AA6agR6b5ZwesE5eISBmDRV4UxxmVixHafmyr04IuE9Ya0AdAP+jntrckP1XeMEX9shvdb05tnHDai1zhUm7gZMC7dQ=
X-Received: by 2002:a67:cd18:0:b0:38a:bbb7:481d with SMTP id
 u24-20020a67cd18000000b0038abbb7481dmr5962054vsl.32.1660676456721; Tue, 16
 Aug 2022 12:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
 <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com>
 <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
 <CAK3+h2zH+KoJ1FwYsFVk3H5N0D5JdVMkEh4PzvsRQ5fymCY_Dw@mail.gmail.com> <87sflwwjdn.fsf@toke.dk>
In-Reply-To: <87sflwwjdn.fsf@toke.dk>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 16 Aug 2022 12:00:45 -0700
Message-ID: <CAK3+h2wHewqmSHCp4aEF3jhkCKUZpmP4p8C-u3PmsmRW8-d0gQ@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 3:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> >Vincent Li <vincent.mc.li@gmail.com> writes:
>
> > On Mon, Aug 15, 2022 at 5:05 PM Quentin Monnet <quentin@isovalent.com> =
wrote:
> >>
> >> On Mon, 15 Aug 2022 at 23:26, Vincent Li <vincent.mc.li@gmail.com> wro=
te:
> >> >
> >> > On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.co=
m> wrote:
> >> > >
> >> > > Hi Vincent,
> >> > >
> >> > > On Mon, 15 Aug 2022 at 18:46, Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
> >> > > >
> >> > > > Hi,
> >> > > >
> >> > > > I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my =
dev
> >> > > > machine, I also compiled bpftool from bpf-next on same machine, =
when
> >> > > > run bpftool on same machine, I got :
> >> > > >
> >> > > > ./bpftool feature probe
> >> > > >
> >> > > > Error: bug: failed to retrieve CAP_BPF status: Invalid argument
> >> > > >
> >> > > > where bpftool to retrieve CAP_BPF ? from running kernel or from =
somewhere else?
> >> > >
> >> > > Yes, bpftool calls cap_get_proc() to get the capabilities of the
> >> > > current process. From what I understand of your output, it looks l=
ike
> >> > > capget() returns CAP_BPF: I believe the "0x1c0" value at the end i=
s
> >> > > (1<<(CAP_CHECKPOINT_RESTORE-32)) + (1<<(CAP_BPF-32)) +
> >> > > (1<<(CAP_PERFMON-32)). You could probably check this with a more
> >> > > recent version of strace.
> >> > >
> >> > > Then assuming you do retrieve CAP_BPF from capget(), I don't know =
why
> >> > > cap_get_flag() in bpftool fails to retrieve the capability state. =
It
> >> > > would be worth running bpftool in GDB to check what happens. The c=
heck
> >> > > in libcap is here [0] but I don't see where we would fail to provi=
de
> >> > > valid arguments. Just in case, could you please let me know what
> >> > > version of libcap you're using when compiling bpftool?
> >> >
> >> > I think I installed libcap through centos distro
> >> >
> >> > [root@centos-dev ~]# rpm -qi libcap.x86_64
> >> >
> >> > Name        : libcap
> >> >
> >> > Version     : 2.26
> >>
> >> So we investigated this on Slack. The issue is related to libcap (and
> >> to how libcap is built on CentOS); it is fixed in libcap 2.30 and
> >> older.
> >>
> >> For the record, this is the commit that fixed it:
> >> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=3Df1f=
62a748d7c67361e91e32d26abafbfb03eeee4
> >>
> >> Before this, cap_get_flag() would compare its argument "value" (in our
> >> case, CAP_BPF =3D=3D 39) with __CAP_BITS. This __CAP_BITS constant is
> >> defined in libcap/cap_names.h, generated by libcap/_makenames.c from
> >> the list in libcap/cap_names.list.h. The latter header file is itself
> >> generated in libcap/Makefile from the UAPI header at
> >> $(KERNEL_HEADERS)/linux/capability.h, which defaults to the local
> >> libcap/include/uapi/linux/capability.h.
> >>
> >> On your CentOS, the libcap version may have been compiled without
> >> setting KERNEL_HEADERS to make it point to the correct system UAPI
> >> header (or the header could be too old, but looking at it, it seems
> >> that it does have CAP_BPF), in which case it defaulted to libcap's
> >> version of the header, which in 2.26 stops at CAP_AUDIT (37). In that
> >> case, __CAP_BITS is worth 37 and is lower than CAP_BPF, the check in
> >> cap_get_flag() fails and we get -EINVAL.
> >>
> >> The commit referenced above changed the comparison for libcap 2.30+ to
> >> compare "value" with __CAP_MAXBITS =3D=3D 64 instead, which works
> >> correctly.
> >>
> >> Thanks for the report and the shared debug session!
> >> Quentin
> >
> > Thanks Quentin for your quick response and analysis :)
>
> FYI, CAP_BPF should also be fixed in the version of libcap shipped with
> RHEL8.5 (version libcap-2.26-5.el8). This should be available in CentOS
> Stream as well, so just updating the package should be enough...
>
> -Toke

Thanks! good to know.
