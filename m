Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC81574428
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiGNFGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiGNFGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:06:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77E1EECB
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:01:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b17so509155iof.4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaxedIrPSgElF4LbnDsbKKinZNNusK1Y1uSoRNSN99Y=;
        b=NqQGjTZsQKNUODUkd0v6C8i55zSH2vPuDN+5BPKjn+0cEDtrmmqPg7S/PV6c2W9rW1
         Tbc3GROZvIRnoXfYmYWezTTf81s5GVmvWy2JSs0x/QUW72itJMCFQph4Chk6Mg6ULa09
         DagF+9drvSEcmpjrEGOROt+uhH3pPyTT3StOZDOZkTkHvC/ZSB4B6m/q/bmsJJYwkcZP
         JiviozL8xktfV272xAQQhrOJSEnVYHWwAbwI2SvNRqVmCCGhegCvMVPanixL6fpfCMUc
         cKdE9qc+xiz1tnPPZIT3ULSqAiA+q5UYrrBXxByjVyQptf0AxfdV/lp1UowJA1TmZO9Y
         AHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaxedIrPSgElF4LbnDsbKKinZNNusK1Y1uSoRNSN99Y=;
        b=3fVKcMNtdlvMKh6/TH9zeJXsMy4C5do7c8vC+LWG26g1ieFsh+ARJzLVYBDQd7LWnP
         cRGeJeLVuOiTAIO7Jj+EQqIWdgDviq9Zud3xfzyV7n5Cnox9CEHry1h4gxMpg0Nf4hmD
         u7RJ+M6ef9InQY3KAsz3DYNlejnEHpWA6G3EUmDPofLkHYhQgmitulzjzNSSi8S2daxS
         NEOXiw9bgA/xAmiSaagNlooo2nWW0UPrg2jEYRfQWu3rU/x27/GM5VzcscVrevWuBDrQ
         ZbzvVN+UR2LU7IDJQsjtnG5L8jFFYs2KrsmjvWDzW9sbjkTb+eGzKPQuOk+ovT4PwzZ1
         1E6g==
X-Gm-Message-State: AJIora/Z7btfFokeT1eD8+AC1vRTrj9TDf4N/2EBX6UwBB6et0h5YrIr
        awUM9pZdxwQDHFgkTv32WyMibumO5yEQIoEI3p63JQ60bcU=
X-Google-Smtp-Source: AGRyM1tboBO57GOE7q2u2eDAWniX6rZUwvSCjbVX8abCfxPPfPYGG43cmIYz1FECAXw5K++NWOiXPMEGqRe7QMc46c4=
X-Received: by 2002:a05:6638:1a89:b0:33f:7184:1eff with SMTP id
 ce9-20020a0566381a8900b0033f71841effmr4106942jab.100.1657774912830; Wed, 13
 Jul 2022 22:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
 <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
 <YsvPDfSE6wflDtpA@krava> <YsvgmAK0LJbpCQ/G@krava> <CAJQ9wQ-9WR4RY-Fb-22Y-0Tcwri_v7FVRYMNiJCJMrqqiAU9Rw@mail.gmail.com>
 <Ys064c3WpREp+Lem@krava>
In-Reply-To: <Ys064c3WpREp+Lem@krava>
From:   Donald Chan <hoiho.chan@gmail.com>
Date:   Wed, 13 Jul 2022 22:01:41 -0700
Message-ID: <CAJQ9wQ-0UUAqzyB5P9Xy_0=hpxg9m+2OEzAmk2nWnoX9es9Gnw@mail.gmail.com>
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

On Tue, Jul 12, 2022 at 2:12 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 02:53:58PM -0700, Donald Chan wrote:
> > On Mon, Jul 11, 2022 at 1:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Jul 11, 2022 at 09:19:45AM +0200, Jiri Olsa wrote:
> > > > On Sun, Jul 10, 2022 at 10:57:01PM -0700, Donald Chan wrote:
> > > > > Hi,
> > > > >
> > > > > I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
> > > > > Yocto-based Linux kernel....but it is failing with this error:
> > > > >
> > > > > |   LD      .tmp_vmlinux.btf
> > > > > |   BTF     .btf.vmlinux.bin.o
> > > > > |   LD      .tmp_vmlinux.kallsyms1
> > > > > |   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > |   AS      .tmp_vmlinux.kallsyms1.S
> > > > > |   LD      .tmp_vmlinux.kallsyms2
> > > > > |   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > |   AS      .tmp_vmlinux.kallsyms2.S
> > > > > |   LD      vmlinux
> > > > > |   BTFIDS  vmlinux
> > > > > | FAILED: load BTF from vmlinux: No such file or directory
> > > > >
> > > > > I dug deeper and it seems that the resolve_btfids utility is not able
> > > > > to find any relevant .BTF section (at btf__parse from function
> > > > > symbols_resolve).
> > > > >
> > > > > Dumped the vmlinux and also confirmed there is only .BTF_ids section:
> > > > >
> > > > >   [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
> > > > >        0000000000000048  0000000000000018   I      22807   2992     8
> > > > >   [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
> > > > >        00000000000000fc  0000000000000000   A       0     0     1
> > > > >
> > > > > What could be wrong? Sample config is available at
> > > > > https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056
> > >
> > > I compiled x86_64 bpf-next/master kernel with your config with no problems,
> > > could you share more details? like:
> > >   - version of dwarves/pahole
> >
> > $ pahole --version
> > v1.22
> >
> > >   - clang/gcc? versions
> > >   - V=1 compile log
> > >   - command line options
> >
> > I will need some more time to gather the logs. Hopefully the pahole
> > and kernel branch will give some initial clue.
> >
> > >   - tree/branch you're on
> >
> > This is from Yocto and they use 5.15 -
> > https://git.yoctoproject.org/linux-yocto/tree/?h=v5.15/standard/base&id=ebfb1822e9f9726d8c587fc0f60cfed43fa0873e
>
> could you test that on either bpf/master or bpf-next/master tree?
>
> jirka

Finally figured out the mystery - I was building on Ubuntu 18.04, and
libelf/elfutils was too old (0.170).

After upgrading to Ubuntu 22.04, I was able to build.

Many thanks!

>
> >
> > >   - anything else ;-)
> > >
> > > thanks,
> > > jirka
> > >
> > > > >
> > > > > The issue exists on x86_64, I also have tried armv7 with the same
> > > > > result so doesn't seem to be arch-specific.
> > > >
> > > > hi,
> > > > do you use any special command line options?
> > > > what tree/branch are you on?
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > > >
> > > > > Thanks
> > > > > Donald
