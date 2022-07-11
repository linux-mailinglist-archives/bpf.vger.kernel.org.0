Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8478570D08
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGKVyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiGKVyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:54:11 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC42AE25
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:54:10 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a20so3809773ilk.9
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vwh3j5D/s/m1OT260Ynf3yT7SGJd+4B73l1+gefPwHc=;
        b=Ecsx+aG+HttpsksUNVidhE5CsiHGgl1/qLiHkVoZVPgN4NJULcGbjGKhax3oEVpkk+
         HYI4hJeCp5wQNofRFJl+0wAMWWf/gIBs2Tpfoz33URo0cpELWehPi1gkYKfwM88grwRg
         Sj8gxL5lj0rgwFEiglN1BDOcCDiGDNZMxi8Zubgj+hE0NLWabgIo5wTVhRzMxSCifigm
         oh1Sx9KXhsyETNiqkIZgeV7KKcheBEryeSaDnqCkg6DcSaAhyYPJFz478zpoRFtmoeLy
         N+91V1H7TgebEez60KuvXPaZNc4W9s7FUbkBS3ZyCy7zGUhiF1N8rtmcPv94CyC9leZS
         Nv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vwh3j5D/s/m1OT260Ynf3yT7SGJd+4B73l1+gefPwHc=;
        b=CXrLxqrpdbBU1gCd8I/rzg4b57N1JAB6R6plsn6uf0ciHYynB+e5btQ9ZPHtK5rkSb
         Lyp/yLQXK1JyRLskVRC2goYfPMEUWyefYIv4OqnUi5DC9YgrrYOI4VdtCosSuBUw+h/O
         sZu10nJ6lNqS0jz74JuX8RdiWYtFJoJrG1QPrWSSyeuCcTZVtWW4RNNDnqFCf3JtwVR0
         guQFI00ERnrcvi+TApdcVY4bdP988i1Sl0NhZW71G6ZTONxYpvVJNgNMMX82wvTVB+dd
         +iSDzLrAhBmF4ugKKuXHRHvVkaHqVKuRoitpNUEmTiEYCIqOFiZbRDDszBQxA9h5J15b
         YrUw==
X-Gm-Message-State: AJIora+i0A8df3aqa5EYJ7+cN0V+gZXJ5gGt7eY4eGjJx5YhXSuyHXxa
        xCnO83OBYstsj53d5y8mtzTKSHD2vYB5menILUE=
X-Google-Smtp-Source: AGRyM1spqj5AEKtGGPqd4eJsuUr7XMPEhu7eFTooUUJTKG8GGOg2BfdE/0ijUfHG3vHpu2P04rNhrS/kkNqOSFho2vo=
X-Received: by 2002:a05:6e02:141:b0:2dc:16f0:fa43 with SMTP id
 j1-20020a056e02014100b002dc16f0fa43mr10797657ilr.65.1657576450021; Mon, 11
 Jul 2022 14:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
 <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
 <YsvPDfSE6wflDtpA@krava> <YsvgmAK0LJbpCQ/G@krava>
In-Reply-To: <YsvgmAK0LJbpCQ/G@krava>
From:   Donald Chan <hoiho.chan@gmail.com>
Date:   Mon, 11 Jul 2022 14:53:58 -0700
Message-ID: <CAJQ9wQ-9WR4RY-Fb-22Y-0Tcwri_v7FVRYMNiJCJMrqqiAU9Rw@mail.gmail.com>
Subject: Re: Missing .BTF section in vmlinux (x86_64) when building on Yocto
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
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

On Mon, Jul 11, 2022 at 1:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 09:19:45AM +0200, Jiri Olsa wrote:
> > On Sun, Jul 10, 2022 at 10:57:01PM -0700, Donald Chan wrote:
> > > Hi,
> > >
> > > I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
> > > Yocto-based Linux kernel....but it is failing with this error:
> > >
> > > |   LD      .tmp_vmlinux.btf
> > > |   BTF     .btf.vmlinux.bin.o
> > > |   LD      .tmp_vmlinux.kallsyms1
> > > |   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > |   AS      .tmp_vmlinux.kallsyms1.S
> > > |   LD      .tmp_vmlinux.kallsyms2
> > > |   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > |   AS      .tmp_vmlinux.kallsyms2.S
> > > |   LD      vmlinux
> > > |   BTFIDS  vmlinux
> > > | FAILED: load BTF from vmlinux: No such file or directory
> > >
> > > I dug deeper and it seems that the resolve_btfids utility is not able
> > > to find any relevant .BTF section (at btf__parse from function
> > > symbols_resolve).
> > >
> > > Dumped the vmlinux and also confirmed there is only .BTF_ids section:
> > >
> > >   [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
> > >        0000000000000048  0000000000000018   I      22807   2992     8
> > >   [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
> > >        00000000000000fc  0000000000000000   A       0     0     1
> > >
> > > What could be wrong? Sample config is available at
> > > https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056
>
> I compiled x86_64 bpf-next/master kernel with your config with no problems,
> could you share more details? like:
>   - version of dwarves/pahole

$ pahole --version
v1.22

>   - clang/gcc? versions
>   - V=1 compile log
>   - command line options

I will need some more time to gather the logs. Hopefully the pahole
and kernel branch will give some initial clue.

>   - tree/branch you're on

This is from Yocto and they use 5.15 -
https://git.yoctoproject.org/linux-yocto/tree/?h=v5.15/standard/base&id=ebfb1822e9f9726d8c587fc0f60cfed43fa0873e

>   - anything else ;-)
>
> thanks,
> jirka
>
> > >
> > > The issue exists on x86_64, I also have tried armv7 with the same
> > > result so doesn't seem to be arch-specific.
> >
> > hi,
> > do you use any special command line options?
> > what tree/branch are you on?
> >
> > thanks,
> > jirka
> >
> > >
> > > Thanks
> > > Donald
