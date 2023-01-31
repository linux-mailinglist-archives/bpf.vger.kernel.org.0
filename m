Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113ED683158
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjAaPVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 10:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjAaPVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 10:21:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FA59748
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 07:18:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d14so14529800wrr.9
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2O02It3bbn5FBbwbWxOrGitYhsJm8cq1WolvQpSJ05I=;
        b=CmNuxgyCqX0w4xVCZcQbpOOC/3/PE9D6FagSn0d5eFrJBMDD8E3He9c31CKyQtB7lW
         FghtF1M7CFGfLsYX3ZWIKWiCYzgR4fIK6kjoU4ZkW+md67ws6p31TYoSsXpxvaX+3YBg
         rqT81D86ICJMrjU7nuLph+NsRIvg8UwjpHYRfImCS/TFvFZzOcQeajAyWtXj16gqeb/H
         Az8uS3/IbNGYueeCMAZwYVpkk0jRnNh5wo/xG+EX+BJ13Kw5u93RhHG39uZZs2Rq3m+d
         ZhXSlPcVCjZLR+uAexlBqumVs9wJ2no+vFlYoNCv+EX69RVhPEOjIzsqL7LW0UE9aBiG
         nuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2O02It3bbn5FBbwbWxOrGitYhsJm8cq1WolvQpSJ05I=;
        b=cEs6Eb8hFvXtqWiayGBViyrWS2tYa5y6Wt9mNwU/TidurI0t9Zy+md8gK6Vcf9uYFv
         O8Z6fQmRRc/v350dsVCvbblJ73T+/o1U5souOx0WDMzuDmqDANrGEbS9SysJKVFe+AdA
         TVAhphk3Z3nZbiqfBZ2aOHgFbwrj/JzrQ9eg4/L2g2nKb2j/Qq3Mgx4kfF9BRJI8X9dp
         6BQcKDPMlRz9qPhTTZIZHBAvUpQ9ZZqZlJWm6ljfud2vYQn32QFq2/s6enkedGYr14rP
         2PlLbvdS1FDG/WciH39P24TEGzrlmiA6pa/ANVwKD3IlKMaLoujISBoKUGaWHNhktdn4
         ZIaQ==
X-Gm-Message-State: AFqh2kqTAWWMLvcDPsqwMCcDls6/IHqDK2X6aad+1FPDjis7ZkZ4KwDK
        PuGNt89cOqxE4daFr6NTc9s=
X-Google-Smtp-Source: AMrXdXsZMXa5deoft0LKyIBLqc52w0hVU3mij8inGigkhT53EuBWAF3oVlYPeiIVB1hwgWhesf3yrQ==
X-Received: by 2002:adf:e9d2:0:b0:242:800:9a7f with SMTP id l18-20020adfe9d2000000b0024208009a7fmr47557178wrn.65.1675178326332;
        Tue, 31 Jan 2023 07:18:46 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm16917469wrs.36.2023.01.31.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:18:45 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Jan 2023 16:18:43 +0100
To:     Alexandre Peixoto Ferreira <alexandref75@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Message-ID: <Y9kxUzyfpEQpnN7w@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com>
 <Y9RlpyV5JPz/hk1K@krava>
 <883a3b03-a596-8279-1278-bc622114aab5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <883a3b03-a596-8279-1278-bc622114aab5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferreira wrote:
> Jirka and Daniel,
> 
> On 1/27/23 18:00, Jiri Olsa wrote:
> > On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
> > > 
> > > On 1/24/23 00:13, Daniel Xu wrote:
> > > > Hi Jiri,
> > > > 
> > > > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
> > > > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I'm getting the following error during build:
> > > > > > 
> > > > > >           $ ./tools/testing/selftests/bpf/vmtest.sh -j30
> > > > > >           [...]
> > > > > >             BTF     .btf.vmlinux.bin.o
> > > > > >           btf_encoder__encode: btf__dedup failed!
> > > > > >           Failed to encode BTF
> > > > > >             LD      .tmp_vmlinux.kallsyms1
> > > > > >             NM      .tmp_vmlinux.kallsyms1.syms
> > > > > >             KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > >             AS      .tmp_vmlinux.kallsyms1.S
> > > > > >             LD      .tmp_vmlinux.kallsyms2
> > > > > >             NM      .tmp_vmlinux.kallsyms2.syms
> > > > > >             KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > >             AS      .tmp_vmlinux.kallsyms2.S
> > > > > >             LD      .tmp_vmlinux.kallsyms3
> > > > > >             NM      .tmp_vmlinux.kallsyms3.syms
> > > > > >             KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > > >             AS      .tmp_vmlinux.kallsyms3.S
> > > > > >             LD      vmlinux
> > > > > >             BTFIDS  vmlinux
> > > > > >           FAILED: load BTF from vmlinux: No such file or directory
> > > > > >           make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> > > > > >           make[1]: *** Deleting file 'vmlinux'
> > > > > >           make: *** [Makefile:1264: vmlinux] Error 2
> > > > > > 
> > > > > > This happens on both bpf-next/master (84150795a49) and 6.2-rc5
> > > > > > (2241ab53cb).
> > > > > > 
> > > > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
> > > > > > upstream pahole on master (02d67c5176) and upstream pahole on
> > > > > > next (2ca56f4c6f659).
> > > > > > 
> > > > > > Of the above 6 combinations, I think I've tried all of them (maybe
> > > > > > missing 1 or 2).
> > > > > > 
> > > > > > Looks like GCC got updated recently on my machine, so perhaps
> > > > > > it's related?
> > > > > > 
> > > > > >           CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
> > > > > > 
> > > > > > I'll try some debugging, but just wanted to report it first.
> > > > > hi,
> > > > > I can't reproduce that.. can you reproduce it outside vmtest.sh?
> > > > > 
> > > > > there will be lot of output with patch below, but could contain
> > > > > some more error output
> > > > Thanks for the hints. Doing a regular build outside of vmtest.sh
> > > > seems to work ok. So maybe it's a difference in the build config.
> > > > 
> > > > I'll put a little more time into debugging to see if it goes anywhere.
> > > > But I'll have to get back to the regularly scheduled programming
> > > > soon.
> > > 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
> > > in pahole when CONFIG_X86_KERNEL_IBT is set.
> > could you plese attach your config and the build error?
> > I can't reproduce that
> > 
> > thanks,
> > jirka
> 
> My working .config is available at https://pastebin.pl/view/bef3765c
> change CONFIG_X86_KERNEL_IBT to y to get the error.
> 
> The error is similar to Daniel's and is shown below:
> 
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
> btf_encoder__encode: btf__dedup failed!
> Failed to encode BTF
>   LD      .tmp_vmlinux.kallsyms1
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   NM      .tmp_vmlinux.kallsyms2.syms
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      .tmp_vmlinux.kallsyms3
>   NM      .tmp_vmlinux.kallsyms3.syms
>   KSYMS   .tmp_vmlinux.kallsyms3.S
>   AS      .tmp_vmlinux.kallsyms3.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: No such file or directory
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
> make[1]: *** Deleting file 'vmlinux'
> make: *** [Makefile:1264: vmlinux] Error 2

I can't reproduce that.. I tried with gcc versions:

  gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
  gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)

I haven't found fedora setup with 12.2.1 20230111 yet

I tried alsa with latest pahole master branch

were you guys able to get any more verbose output
that I suggested earlier?

jirka
