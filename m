Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4235539AEB
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 03:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiFABqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 21:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 21:46:53 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6ACDEF7
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 18:46:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h18so273919ilj.7
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 18:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJc8rvsxsLu2ii86QF0HXjVPIZ4HrsBpsQpRhXpFiB0=;
        b=gMPdemgPvEbB2AaS3EZ6dyuc7ZL0V5rNHSPZHrL/SrXicBF0ToUtUfGpGVyTxo4jVg
         cUdT8pasEnn+TuwrJxhgdztl3sYf2biUFNcgK+JAzfF3ncE9K3jUMdN4dLLt8Nf6Zp27
         ld3LFvzBPrv/FzyrZO4LXmUGqfylxtQCcvsuM+L/U8au2W3AHEyTVxCkVO3xgnZRGVCP
         5LE+OiYyKunz2W8JvonMI3zQvxSnup3ZvLkkU/S8HddGfPLUep1FAYeyCCNX5d4JD8rT
         0vFUAVAG4fIi7oYEsoHKEvZgK70kTcHHASpcMuy6lgHsCO642O2p1QMMCxnRFDr86tPX
         jeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJc8rvsxsLu2ii86QF0HXjVPIZ4HrsBpsQpRhXpFiB0=;
        b=Xbatl3tpz1V7/LPchQpYKmJRkYZFz32/tJMDMMCJGpOEZ5h7e6W5a5StjXL7MKg/BC
         1ELHPqv2Rtz74TFxLLQITrAYSMUvaP8U/vJa7YXzaUOTflWpXNhdRLPB2jkD14EdgnYM
         qtrLiy/9d19PbBIXxFjviorPhD/L01a1v4Dd452BuByM70XAufSpguOHOH6LN0LsQfeS
         im43METVc0d/V73drFtoMSSgJw8REpulO8ASAlDOUGmYttnfKOC0ty+nrhHOtau+HSkA
         5sSfyTiAvLMxAEKG1PwZZEfOMKSwmuM6jKCh9ZmRuigXTzxe8TJbmCGhJuisWchDYBkE
         aQvw==
X-Gm-Message-State: AOAM532FaDjD8FyNJD3KaBOLuGuLQQKJbmA6U/vmi9kqsY9J0SXM+WDe
        YfzMYi8HPSH9FOEIG9ut+7hqJk72mAaufDB0vZim5gsYgR96awMn
X-Google-Smtp-Source: ABdhPJw6Wdl2PlJPBrRvFIVFnN8g5l6xpM20O1FpNQkRiJUfvzpi6kxAAVF3krzG0UcPRDaBvmKmsNa6VPxxpDd3AoU=
X-Received: by 2002:a92:cf01:0:b0:2cd:aeb6:b3f8 with SMTP id
 c1-20020a92cf01000000b002cdaeb6b3f8mr32377948ilo.265.1654048011208; Tue, 31
 May 2022 18:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ=PnJmZVmAszzyfc8PLUCheQk04iCATXkrLJFxHL4Z=Pc1+Zg@mail.gmail.com>
 <CAEf4BzbnpvYjCMf+kVvdd9iQaiove5hDgjHsnKG-L4fxOhM70w@mail.gmail.com>
In-Reply-To: <CAEf4BzbnpvYjCMf+kVvdd9iQaiove5hDgjHsnKG-L4fxOhM70w@mail.gmail.com>
From:   Ye ZhengMao <yezhengmaolove@gmail.com>
Date:   Wed, 1 Jun 2022 09:46:37 +0800
Message-ID: <CAJ=PnJkdBeTGKVAZvMC2yB0X1hARq9agZvBJV1pnszpGCdAC1Q@mail.gmail.com>
Subject: Re: bpftool coredump
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
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

compile it with -g argument, it`s work fine.

Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=
=881=E6=97=A5=E5=91=A8=E4=B8=89 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 25, 2022 at 1:10 PM Ye ZhengMao <yezhengmaolove@gmail.com> wr=
ote:
> >
> > i using cross compiler to compile the bpftool for aarch64 and when gen
> > skeleton for the minimal.bpf.o, bpftool core.
> >
> > libbpf: loading object 'minimal_bpf' from buffer
> > libbpf: elf: section(2) tp/syscalls/sys_enter_write, size 104, link 0,
> > flags 6, type=3D1
>
> you should have seen a message about discovering a program here. Can
> you share that .bpf.o file, somehow libbpf can't find program entry.
>
>
> > libbpf: elf: section(3) license, size 13, link 0, flags 3, type=3D1
> > libbpf: license of minimal_bpf is Dual BSD/GPL
> > libbpf: elf: section(4) .bss, size 4, link 0, flags 3, type=3D8
> > libbpf: elf: section(5) .rodata, size 28, link 0, flags 2, type=3D1
> > libbpf: elf: section(6) .symtab, size 192, link 8, flags 0, type=3D2
> > libbpf: elf: section(7) .reltp/syscalls/sys_enter_write, size 32, link
> > 6, flags 0, type=3D9
> > libbpf: looking for externs among 8 symbols...
> > libbpf: collected 0 externs total
> > libbpf: map 'minimal_.bss' (global data): at sec_idx 4, offset 0, flags=
 400.
> > libbpf: map 0 is "minimal_.bss"
> > libbpf: map 'minimal_.rodata' (global data): at sec_idx 5, offset 0, fl=
ags 480.
> > libbpf: map 1 is "minimal_.rodata"
> > libbpf: sec '.reltp/syscalls/sys_enter_write': collecting relocation
> > for section(2) 'tp/syscalls/sys_enter_write'
> > libbpf: sec '.reltp/syscalls/sys_enter_write': relo #0: insn #2 against=
 'my_pid'
> > Segmentation fault (core dumped)
> >
> > core in function find_prog_by_sec_insn
> >
> > i using gdb to found the obj->nr_programs =3D=3D 0
> > prog =3D &obj->programs[l]; can`t work fine
