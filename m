Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F456D693
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGKHTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGKHTs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 03:19:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951CDF03
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 00:19:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oy13so2449376ejb.1
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qsm1Z77l6Jxscq3wVdGeSuWq8+SKVlz/k5aZFRpgxsQ=;
        b=fmiiKp9445kwMB3vAxW2nb5/MCJkpIhbSFoXctjzqkL7OvRmGddCMQg5a1ezYDKX2H
         jA6STgfH+cXY8bgO4sYvy03Zlyv/T1uOAJOrxn/nvfUq+zGk0hCnbhNIvXHMgzTKhaaV
         C3yyDfm845Q98mAuGL/fuENmNhhTyHdMGj+E0qf0Sg1A8pmErzpA0OM0YS4ZQGxel/Bf
         CAEB/5/e3oV7duH+3r7YN1W5cOT59xM1CDVB8QFh1D23PEei2q/n4NCoQmhDBz/I1z8B
         ZL/1Bq5qP9TSxsez6cazfs2FkTRxKDbh9DA110JblciyWoQJru2r7ms8TsoPkcQtPbkn
         r1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qsm1Z77l6Jxscq3wVdGeSuWq8+SKVlz/k5aZFRpgxsQ=;
        b=L9B7tqv7MVLboNpo1iZCjbpIta706FMnyxp3mahOmYOBCwIozo7yEtA2UpedkH6bl7
         Aos+g55fiYtJPeUkuU3nO3yGI14u2QuRSEofesMOyn7+PjkIfKoJVuTLQg+DEMtYyFPu
         aZS+Vv+vOfgibfTKXYLsXR1XKxq/DJhLgG/bFixxfJDmQ1K+FdPtz55XYnvbvaqlC1uc
         DO+VDM9tSguBfmRxJrRSgesh543dZys6RjXW4z5toMLmZTIdBr4bAWJLkI7pPrSlzZ6w
         brGirGN6rxIPcQ8fOJdBVgFIhT8rwZ2P+e+0vf5a9TaoC5bV/Tm7V6/qs1hc05PaB2mm
         D0Lw==
X-Gm-Message-State: AJIora9mkbm1JYz3VZYfc0ArrWFyisS7IoXnhTro7stE93KrDbn8P+t1
        EmAeWBToaIMfKvAfgaTwszA=
X-Google-Smtp-Source: AGRyM1tJIOLXYx7k9avNumWz8dumgaCTAFSGcIOQmQ+1uENR2nSDzRkwezn2oVbbydY8da2qEsD7sQ==
X-Received: by 2002:a17:907:7f8e:b0:726:41df:cbc6 with SMTP id qk14-20020a1709077f8e00b0072641dfcbc6mr17444768ejc.230.1657523985083;
        Mon, 11 Jul 2022 00:19:45 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id bd27-20020a056402207b00b0043a21e3b4a5sm3863111edb.40.2022.07.11.00.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:19:44 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 09:19:41 +0200
To:     Donald Chan <hoiho.chan@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Subject: Re: Missing .BTF section in vmlinux (x86_64) when building on Yocto
Message-ID: <YsvPDfSE6wflDtpA@krava>
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
 <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 10, 2022 at 10:57:01PM -0700, Donald Chan wrote:
> Hi,
> 
> I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
> Yocto-based Linux kernel....but it is failing with this error:
> 
> |   LD      .tmp_vmlinux.btf
> |   BTF     .btf.vmlinux.bin.o
> |   LD      .tmp_vmlinux.kallsyms1
> |   KSYMS   .tmp_vmlinux.kallsyms1.S
> |   AS      .tmp_vmlinux.kallsyms1.S
> |   LD      .tmp_vmlinux.kallsyms2
> |   KSYMS   .tmp_vmlinux.kallsyms2.S
> |   AS      .tmp_vmlinux.kallsyms2.S
> |   LD      vmlinux
> |   BTFIDS  vmlinux
> | FAILED: load BTF from vmlinux: No such file or directory
> 
> I dug deeper and it seems that the resolve_btfids utility is not able
> to find any relevant .BTF section (at btf__parse from function
> symbols_resolve).
> 
> Dumped the vmlinux and also confirmed there is only .BTF_ids section:
> 
>   [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
>        0000000000000048  0000000000000018   I      22807   2992     8
>   [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
>        00000000000000fc  0000000000000000   A       0     0     1
> 
> What could be wrong? Sample config is available at
> https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056
> 
> The issue exists on x86_64, I also have tried armv7 with the same
> result so doesn't seem to be arch-specific.

hi,
do you use any special command line options?
what tree/branch are you on?

thanks,
jirka

> 
> Thanks
> Donald
