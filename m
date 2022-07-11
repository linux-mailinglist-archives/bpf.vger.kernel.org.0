Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A156D833
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiGKIfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiGKIfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 04:35:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9E1FCE0
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 01:34:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so5328610edb.6
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVsdFhUo/y1FuxKjOyMz039zl2+UqQrPtby1P9RoyAM=;
        b=T/UklHYdaG8UESRyYnk3lIeSGKWvgP4jDScMbIkxjZvZn/SkM9I6t8/aM6j/tR/jsk
         Rn9+8fhm5OSNbh1oAmYBS1ikHBA5lFbeILfAxJrWUME1xwkRtpCIdSpjFU5n/uLS6UMo
         J1b9Ob7Ee+6w8c/1UBNDE75SBZoFReFX9WggrIiyBECeqv654be/ODUJzARNcsgONGCa
         xXgU3vS3Kyw7WHqLcketz1YAW6mSwr1WdAETUAh5wVfKvK4c/dNz35DuEU17dg72QX64
         Pnh/9eF81MgKq1MQBaWfUT40lz7+MDaKZA7ww5TO1Q8xoV9gABfij3xc8cpBl4u67BZ5
         nBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVsdFhUo/y1FuxKjOyMz039zl2+UqQrPtby1P9RoyAM=;
        b=zEuMGN8/OFfQtMrN38JEQzHtmx/n13N+eMcqVjtn1S3lEzeqk4Ym8qMdGJkapyIyTP
         8Xlh1aQRnTVpgheBdRAHuywG5+vCb3jktK7xKdSbBtp1jtPcTNnssNOv+XUEhtH/iNDh
         u9GuSJLLsm++09bBBH6R0MXycAUauTQtd/lNSWin5PNfyJ8wxKLfA8q/aK6myV65HVVR
         gwTeuCUsbjA+N5RRTkdQsJUF+75I51tiCX4hrof+puniTz6/FWNoRDIF8aZ12otnk65x
         gYxEc8rKvf7RiL+44pThZZdplER8osZNJLLsVq2Vabr/c9T8ae4fH8rfx+elVLiZptu6
         XZig==
X-Gm-Message-State: AJIora/KBvBvOIpIooDsctaYmGpK1b3R5gtH3ghuI5pEC+4wUBrIFOs7
        OMS16ilaAhkGmWTnvbMyjqA=
X-Google-Smtp-Source: AGRyM1ttv1bKQzJDpv5ESKuU9NIyYpnL49rUVDcELnlcWMZAKhM4AJHtfXYwaqXKl2D3tWYA7Tn25w==
X-Received: by 2002:a05:6402:2812:b0:43a:9041:d5db with SMTP id h18-20020a056402281200b0043a9041d5dbmr22806155ede.208.1657528475458;
        Mon, 11 Jul 2022 01:34:35 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0043a75f62155sm3951577edr.86.2022.07.11.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:34:35 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 10:34:32 +0200
To:     Donald Chan <hoiho.chan@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Subject: Re: Missing .BTF section in vmlinux (x86_64) when building on Yocto
Message-ID: <YsvgmAK0LJbpCQ/G@krava>
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
 <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
 <YsvPDfSE6wflDtpA@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsvPDfSE6wflDtpA@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 09:19:45AM +0200, Jiri Olsa wrote:
> On Sun, Jul 10, 2022 at 10:57:01PM -0700, Donald Chan wrote:
> > Hi,
> > 
> > I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
> > Yocto-based Linux kernel....but it is failing with this error:
> > 
> > |   LD      .tmp_vmlinux.btf
> > |   BTF     .btf.vmlinux.bin.o
> > |   LD      .tmp_vmlinux.kallsyms1
> > |   KSYMS   .tmp_vmlinux.kallsyms1.S
> > |   AS      .tmp_vmlinux.kallsyms1.S
> > |   LD      .tmp_vmlinux.kallsyms2
> > |   KSYMS   .tmp_vmlinux.kallsyms2.S
> > |   AS      .tmp_vmlinux.kallsyms2.S
> > |   LD      vmlinux
> > |   BTFIDS  vmlinux
> > | FAILED: load BTF from vmlinux: No such file or directory
> > 
> > I dug deeper and it seems that the resolve_btfids utility is not able
> > to find any relevant .BTF section (at btf__parse from function
> > symbols_resolve).
> > 
> > Dumped the vmlinux and also confirmed there is only .BTF_ids section:
> > 
> >   [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
> >        0000000000000048  0000000000000018   I      22807   2992     8
> >   [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
> >        00000000000000fc  0000000000000000   A       0     0     1
> > 
> > What could be wrong? Sample config is available at
> > https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056

I compiled x86_64 bpf-next/master kernel with your config with no problems,
could you share more details? like:
  - version of dwarves/pahole
  - clang/gcc? versions
  - V=1 compile log
  - command line options
  - tree/branch you're on
  - anything else ;-)

thanks,
jirka

> > 
> > The issue exists on x86_64, I also have tried armv7 with the same
> > result so doesn't seem to be arch-specific.
> 
> hi,
> do you use any special command line options?
> what tree/branch are you on?
> 
> thanks,
> jirka
> 
> > 
> > Thanks
> > Donald
