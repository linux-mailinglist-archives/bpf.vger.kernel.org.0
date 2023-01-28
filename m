Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7B67F28F
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjA1AAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjA1AAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:00:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123AD82415
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:00:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y19so6120885edc.2
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BEkRvRBZ5YIL2Ww1srVhE8xsOAWOFNBdglcse33OXEE=;
        b=FvCzBKqC+9A4wrZqdE7eg6sPjB/Way7ew4uVJfKlyDPrx12cm+KoewrhAQ+Q0yDLMI
         mG0aMVsbR6eP9SA+B/5ZVNiiAJoBn2oHgu4jCFWASiCuqZ4w6cyENIh2Lg6RD7ry7ceH
         66/LNQAbUk+XCA1TAneANEMPj1BlQe91hdnnBYnGXVRd5iepXKKmsYtwrEgxjLkbYUcb
         lgZEMtlP6ZDwOgGYpyJYivxwgeKBuTH5eLkaEFWKIVfZvjqR+GedOPlLo6jnfHklvB9Q
         SX2fabNOJbO9zcgQej2VOmxkj1H84q/Fzv+aMDcbs2K8cXb2dfQzC7aCN3pG+zH1PSKE
         Ylrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEkRvRBZ5YIL2Ww1srVhE8xsOAWOFNBdglcse33OXEE=;
        b=qg3JJtsTbvuXm0NoaDYOwWhG+Nnv2Ydq/IYxpW5lSpTXSR5J3aNlZGvdk0SilRtJdm
         HnE0gdIXj6+ayas6yBYINsFBVq+VkKidZf4rcbGaEvvXY2zYmX1D0lXm8qet0zesklLq
         KT0Jz0mne+kUvM6y2CGplKOfrAoPrBfc+dFmA5TJmEZzER/IyOABxZ31v72b8LVBzxH3
         aSHwHeLkkkMejcRW/g99tbtulQQwO6IodIQTgz8C8LWdFl7OyalfYHsfn5Qr2QWPOqG5
         bhUmoMVglmGUVOkMmFMY8/pglaR/ZvJkypv4ZZvR/RB7BmDv1Zl6AYFkRJhxC6gufoci
         NuAA==
X-Gm-Message-State: AO0yUKUYAk9PrvtKUrYoovXgVcAqUtev2tdTDJDyiCXfP6aWqT87g7Pq
        a32oGuDVRGcIQ+bKCLTex5oLAp59R/hbdg==
X-Google-Smtp-Source: AK7set+tR2bQ2b8AYHPpQTpwm9QPPdqvWXI/hvlSjRcHq2PvamoikZF9uJ3EGft4vHtAzuuREDRj1A==
X-Received: by 2002:a05:6402:1388:b0:4a2:1a65:f0c4 with SMTP id b8-20020a056402138800b004a21a65f0c4mr2074237edv.35.1674864041487;
        Fri, 27 Jan 2023 16:00:41 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id cm17-20020a0564020c9100b004a21263bbaasm1255374edb.49.2023.01.27.16.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:00:41 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 28 Jan 2023 01:00:39 +0100
To:     Alexandre Peixoto Ferreira <alexandref75@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Message-ID: <Y9RlpyV5JPz/hk1K@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb569967-d33a-7252-964b-a36501b3366a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
> 
> 
> On 1/24/23 00:13, Daniel Xu wrote:
> > Hi Jiri,
> > 
> > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
> > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
> > > > Hi,
> > > > 
> > > > I'm getting the following error during build:
> > > > 
> > > >          $ ./tools/testing/selftests/bpf/vmtest.sh -j30
> > > >          [...]
> > > >            BTF     .btf.vmlinux.bin.o
> > > >          btf_encoder__encode: btf__dedup failed!
> > > >          Failed to encode BTF
> > > >            LD      .tmp_vmlinux.kallsyms1
> > > >            NM      .tmp_vmlinux.kallsyms1.syms
> > > >            KSYMS   .tmp_vmlinux.kallsyms1.S
> > > >            AS      .tmp_vmlinux.kallsyms1.S
> > > >            LD      .tmp_vmlinux.kallsyms2
> > > >            NM      .tmp_vmlinux.kallsyms2.syms
> > > >            KSYMS   .tmp_vmlinux.kallsyms2.S
> > > >            AS      .tmp_vmlinux.kallsyms2.S
> > > >            LD      .tmp_vmlinux.kallsyms3
> > > >            NM      .tmp_vmlinux.kallsyms3.syms
> > > >            KSYMS   .tmp_vmlinux.kallsyms3.S
> > > >            AS      .tmp_vmlinux.kallsyms3.S
> > > >            LD      vmlinux
> > > >            BTFIDS  vmlinux
> > > >          FAILED: load BTF from vmlinux: No such file or directory
> > > >          make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> > > >          make[1]: *** Deleting file 'vmlinux'
> > > >          make: *** [Makefile:1264: vmlinux] Error 2
> > > > 
> > > > This happens on both bpf-next/master (84150795a49) and 6.2-rc5
> > > > (2241ab53cb).
> > > > 
> > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
> > > > upstream pahole on master (02d67c5176) and upstream pahole on
> > > > next (2ca56f4c6f659).
> > > > 
> > > > Of the above 6 combinations, I think I've tried all of them (maybe
> > > > missing 1 or 2).
> > > > 
> > > > Looks like GCC got updated recently on my machine, so perhaps
> > > > it's related?
> > > > 
> > > >          CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
> > > > 
> > > > I'll try some debugging, but just wanted to report it first.
> > > hi,
> > > I can't reproduce that.. can you reproduce it outside vmtest.sh?
> > > 
> > > there will be lot of output with patch below, but could contain
> > > some more error output
> > Thanks for the hints. Doing a regular build outside of vmtest.sh
> > seems to work ok. So maybe it's a difference in the build config.
> > 
> > I'll put a little more time into debugging to see if it goes anywhere.
> > But I'll have to get back to the regularly scheduled programming
> > soon.
> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
> in pahole when CONFIG_X86_KERNEL_IBT is set.

could you plese attach your config and the build error?
I can't reproduce that

thanks,
jirka
