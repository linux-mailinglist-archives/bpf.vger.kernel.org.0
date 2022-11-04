Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3361A07F
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 20:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKDTEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKDTEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 15:04:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D043AF9
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:04:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so15680303eja.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cum2xEz4MGoRfzOdFRMmCclq75XDisZoCNF2agR8YTc=;
        b=hVp00/IdQqTahpZlnGmkwPXWLjmBmkmyFkMUiHlg5vi9mbyI58SUvzWnKI1qPExwCP
         ejCs3GFo5WkEMNRFnoCEA1jb8IAOU0bL0MZ/rrj7O0Pjpb9qZ3Rkg5hXyn1zy3zwvCn0
         uWXi2r8kzwHWDazYJRJybONeveGYJM2SZ9tyc4rtH6t/9fp374qrzoMx0Y9+2rVd1+s3
         /wQetDZfh8XYCmSWc4jZupsMOHx5/68AP3QsjLjnUEGb/EozsSsPUlLl1y8VDfZsS0FR
         6y54ZZSe5Puqvlr4u2yz0IalDSNfIGtvsgwQr43oc/aZdya6r4YqATxvWsscxvYE+4t/
         PRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cum2xEz4MGoRfzOdFRMmCclq75XDisZoCNF2agR8YTc=;
        b=2xmvEpIsRxVbXYJDFySnMWl6dFZ7EyQyjys4a1y55Cy40Rxfox6NytDouXG+yypHBP
         ZoiUia9N559gHxlX0/HWbcx/Kl1Bwx985Cx5tBPcV5SYa0k5hkd0lBYdwWArwjcvTUXt
         F/TYp1GayEECgkxU8lvVerTb+83Fe/8usZvoTwFhPmB6lBHlvsV605Ei/jUsfOAKnd0l
         gbbw0/kUmsowChlPQUktwFSKyto8O6stvXvQ3mQKtMlSujI8E+BZj3QHsW0H+UUhoi+/
         75HUOFIEUeVyRBs4RX53JUSzP9VeEKUnH7cgxRJsaMivPDriPtqYbTzaiD4QCgU8Pi9E
         nHTw==
X-Gm-Message-State: ACrzQf1F0eIyXCBFdBs9Jy0ORam00XtjlOX5MMSclNx+SjeOe27AoCOp
        YfM5w0Sw5DqClAw3D2HOKqHo7CAzM3BInjOo2iM=
X-Google-Smtp-Source: AMsMyM6dic9t3iwhBgJikTk33h5C3UqP9ORvmpdq71sdPHuvrGS0wJEEIp2MAPnhpq6AAyBazz1ejtt6STgwh5lmuv0=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr36257566ejb.633.1667588676801; Fri, 04
 Nov 2022 12:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221104051644.nogfilmnjred2dt2@altlinux.org> <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
 <CAADnVQKUeyDwdJ9AZvbxCCVc6hyvm1wdBRg4+3RHx5u5o1wLMA@mail.gmail.com> <43fd3775-e796-6802-17f0-5c9fdbf368f5@oracle.com>
In-Reply-To: <43fd3775-e796-6802-17f0-5c9fdbf368f5@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Nov 2022 12:04:25 -0700
Message-ID: <CAADnVQKBUZx_ABSii1i+8=tQWs8N=i6Zro=AFYq=SOX+Zke3UQ@mail.gmail.com>
Subject: Re: bpf: Is it possible to move .BTF data into a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     KP Singh <kpsingh@kernel.org>, Vitaly Chikunov <vt@altlinux.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 9:12 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 04/11/2022 15:59, Alexei Starovoitov wrote:
> > On Fri, Nov 4, 2022 at 7:35 AM KP Singh <kpsingh@kernel.org> wrote:
> >>
> >> On Fri, Nov 4, 2022 at 6:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> We need to reduce kernel size for aarch64, because it does not fit into
> >>> U-Boot loader on Raspberry Pi (due to it having fdt_addr_r=0x02600000)
> >>> and one of big ELF sections in vmlinuz is .BTF taking around 5MB.
> >>> Compression does not help because on aarch64 kernels are
> >>> uncompressed[1].
> >>>
> >>> Is it theoretically possible to make sysfs_btf a module?
> >>
> >> I think so, it may need some refactoring and changes
> >> but, yeah, in theory, the module could ship with the
> >> kernel's BTF information which can then be initialized by the module.
> >>
> >> Curious to see what others think as well.
> >
> > Yeah. That request came up a few times.
> > Whoever has cycles to work on it... please go ahead :)
> >
>
> We've experimented with this a bit for the global variable patch
> series, where global variable BTF is a tristate config
> parameter, and if set to 'm' the BTF for variables ends up in
> vmlinux_btf_extra.ko instead (patch series forthcoming; it was
> stuck behind the dedup issues which took a while to uncover).
> One approach would be to extend that scheme such that
> CONFIG_DEBUG_INFO_BTF=m I guess?

makes sense.

> The only thing that might require change is the name; vmlinux_btf
> might be a more appropriate module name than vmlinux_btf_extra
> perhaps? Thanks!

yeah. vmlinux_btf as a module name should work.
libbpf can be taught to look at /sys/kernel/btf/vmlinux and vmlinux_btf.
