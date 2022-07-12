Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913AF571568
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGLJML (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGLJMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 05:12:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FEC9CE29
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 02:12:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m16so9250734edb.11
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcU10Oc13Ma8WmzWLlaWLrS5D5s+as3wCo0nvvq46k0=;
        b=cJZTDn2H0RfCFScGvHtGuEeHOPvQBYHknliZU3fQ1B73tfhi7pmjnFVlbkbhhUjIh1
         sfZms2buwqSCNrIvG77EBxUoX4r/dtokoRm+LpA6cD7qTUV3b3SBxr066VXAjLfKJdIX
         IIQO1Sw32m65mrLV6csITMatqbstsOyrIvnOQivM5kvgs+xnJkC5S0HTaFiNRTb8JVDv
         owqdBel14LSSgJMsY6S2MVyk3QW1O+Nc5vL0XBpJk75VMpPwUi33CHRVKlrV28O9Elgl
         hisbC/Zy5j+AJWjafCjc8PZsY7Vf9uj+RLNoXRSlqOhR48KiXckpZLjRsm9KL2XPMCHt
         R7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcU10Oc13Ma8WmzWLlaWLrS5D5s+as3wCo0nvvq46k0=;
        b=1sw9L/A0LFfIGnJhzBFdhpiLvJAZRVN80PCh7TEDVEshUfm8KG/sz2cwyuDZ4TkMA4
         LEXMmI4nCnLuQWP9FNEqfYXpEfPKIE2rH7js3/H+T+m8GdXQAfYVLB0TXlA19wPeHBli
         rOlq/fRCIi+ekDCAjq0oTA682sMjMT1ADlhOtaH3PbHv+avDscAgbOIKF+PkCu7SNJpE
         QZSnNY/OF75zotSuq1j4+HnXH+9hekEgcXdEbx6Zk+Wb0LztyflkyHHhMcIDsS2q+lao
         6r6PUwbeDlwwpbU0hMZNeHQcgrMpX4AN3y+RsLHJmGuf91KaaRXQkhvz1eeQi0Yxx9M1
         C9Qg==
X-Gm-Message-State: AJIora8yRPjD4GmXR/V68jW5UPASAEt+07bD872ca5FABXctheSpy/8B
        +rEymkzX9Y1Wx4ItY8ML/zI=
X-Google-Smtp-Source: AGRyM1vVitQ2a1J2jhr2B9GasGXrG49nXuk3nR+M5cni0pZk2j54SiJOgRujq6XZyEKHWmotC8EYgg==
X-Received: by 2002:a05:6402:50d0:b0:43a:df6d:6f4d with SMTP id h16-20020a05640250d000b0043adf6d6f4dmr8307257edb.72.1657617124987;
        Tue, 12 Jul 2022 02:12:04 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906a20b00b0072b2378027csm3550955ejy.26.2022.07.12.02.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:12:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 11:12:01 +0200
To:     Donald Chan <hoiho.chan@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: Missing .BTF section in vmlinux (x86_64) when building on Yocto
Message-ID: <Ys064c3WpREp+Lem@krava>
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
 <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
 <YsvPDfSE6wflDtpA@krava>
 <YsvgmAK0LJbpCQ/G@krava>
 <CAJQ9wQ-9WR4RY-Fb-22Y-0Tcwri_v7FVRYMNiJCJMrqqiAU9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJQ9wQ-9WR4RY-Fb-22Y-0Tcwri_v7FVRYMNiJCJMrqqiAU9Rw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 02:53:58PM -0700, Donald Chan wrote:
> On Mon, Jul 11, 2022 at 1:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jul 11, 2022 at 09:19:45AM +0200, Jiri Olsa wrote:
> > > On Sun, Jul 10, 2022 at 10:57:01PM -0700, Donald Chan wrote:
> > > > Hi,
> > > >
> > > > I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
> > > > Yocto-based Linux kernel....but it is failing with this error:
> > > >
> > > > |   LD      .tmp_vmlinux.btf
> > > > |   BTF     .btf.vmlinux.bin.o
> > > > |   LD      .tmp_vmlinux.kallsyms1
> > > > |   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > |   AS      .tmp_vmlinux.kallsyms1.S
> > > > |   LD      .tmp_vmlinux.kallsyms2
> > > > |   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > |   AS      .tmp_vmlinux.kallsyms2.S
> > > > |   LD      vmlinux
> > > > |   BTFIDS  vmlinux
> > > > | FAILED: load BTF from vmlinux: No such file or directory
> > > >
> > > > I dug deeper and it seems that the resolve_btfids utility is not able
> > > > to find any relevant .BTF section (at btf__parse from function
> > > > symbols_resolve).
> > > >
> > > > Dumped the vmlinux and also confirmed there is only .BTF_ids section:
> > > >
> > > >   [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
> > > >        0000000000000048  0000000000000018   I      22807   2992     8
> > > >   [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
> > > >        00000000000000fc  0000000000000000   A       0     0     1
> > > >
> > > > What could be wrong? Sample config is available at
> > > > https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056
> >
> > I compiled x86_64 bpf-next/master kernel with your config with no problems,
> > could you share more details? like:
> >   - version of dwarves/pahole
> 
> $ pahole --version
> v1.22
> 
> >   - clang/gcc? versions
> >   - V=1 compile log
> >   - command line options
> 
> I will need some more time to gather the logs. Hopefully the pahole
> and kernel branch will give some initial clue.
> 
> >   - tree/branch you're on
> 
> This is from Yocto and they use 5.15 -
> https://git.yoctoproject.org/linux-yocto/tree/?h=v5.15/standard/base&id=ebfb1822e9f9726d8c587fc0f60cfed43fa0873e

could you test that on either bpf/master or bpf-next/master tree?

jirka

> 
> >   - anything else ;-)
> >
> > thanks,
> > jirka
> >
> > > >
> > > > The issue exists on x86_64, I also have tried armv7 with the same
> > > > result so doesn't seem to be arch-specific.
> > >
> > > hi,
> > > do you use any special command line options?
> > > what tree/branch are you on?
> > >
> > > thanks,
> > > jirka
> > >
> > > >
> > > > Thanks
> > > > Donald
