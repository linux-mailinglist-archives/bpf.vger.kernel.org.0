Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F037A30836E
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhA2ByM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2ByH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:54:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29EFC061574
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:53:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so5675888pjb.0
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bohjvFQdv89225FzV+0NG9p1VBIHK23ZsDo8Re+GXmc=;
        b=UkTdRazq2mBDFQKXvr8GdFcRacYUEGg8IEL5p1SeCr5p+6F2pzwB6+LBZoh0ZeZ+iS
         8Zsy7qxk9XPrvetBJifec57KYYZiaD1XeMkaIs8DTCcRuO3n6WVVmhLE2mWByg1Kl/pP
         4lw/6SgqlrJuQiip+E5gXzAdtg+pde35o8xmQ0ZNJzissxTUdwO7DYMHKQNX0a1xzlzJ
         qfR+ekwxXeEpSsGBQ9vOUY3WbofeVDGWBpb22T5sqUnl8HtMJR6ToAuLEC01KVvU4QBp
         9E8ICoxYdaq6d/cep9F/k4Vb5MOs6ves20+Xi6U22QNaipta10S+GFWrVaVsTjO6PLzS
         q8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bohjvFQdv89225FzV+0NG9p1VBIHK23ZsDo8Re+GXmc=;
        b=NQamnxnJKzoIXtW09iaWxU6N2+sWLduiQObo9Pk6svcndBYzWd+VVVP9IXRjfcZWiR
         RGm6Eb5cbEAOO0ALd9O77scA9JoLWJv078BgJ/LvEOuhZpa3i2TGVshvJAxjf/1Gx6qi
         rVhWkgAks/3DQDOQnJvsGe1t4UbnmKFuUhHUNkmdI8tgfNlroYsMuuNHXhDHmW6q4kZ2
         +3bPuOQZHKP6Y+TWsySp01WqiRrNQ+SVNnvilu7LmE5wcoPsHu69iWxH5jbnmifAseIv
         wLpZnCXzexsdMPxPH5WbptouOmf+mqhzVw9JI1krXlDvX0A5SpgYNu5NSFKamr8e30nO
         QpJg==
X-Gm-Message-State: AOAM533D3FmiQwzZcoxp9UsFf9/GFLVCdP5maDUx+wivd4GIUEfEGXfG
        lCPWMSywEp4C5HtytKMtacA=
X-Google-Smtp-Source: ABdhPJyRaP3S/SAgv/C71Jnt0rE5XFvkWF3We+kUCDezy4Ja6UonzCG1GGVpPXaXEcqh3cKv9C10wA==
X-Received: by 2002:a17:902:9309:b029:db:c725:d19c with SMTP id bc9-20020a1709029309b02900dbc725d19cmr2200102plb.39.1611885205841;
        Thu, 28 Jan 2021 17:53:25 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id j6sm6794973pfg.159.2021.01.28.17.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:53:25 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:53:22 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129015322.wngmsmyyon2ozcj6@ast-mbp.dhcp.thefacebook.com>
References: <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
 <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
 <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 05:31:35PM -0800, Andy Lutomirski wrote:
> 
> What exactly could the fault code even do to fix this up?  Something like:
> 
> if (addr == 0 && SMAP off && error_code says it's kernel mode && we
> don't have permission to map NULL) {
>   special care for bpf;
> }

right. where 'special care' is checking extable and skipping single
load instruction.

> This seems arbitrary and fragile.  And it's not obviously
> implementable safely without taking locks, 

search_bpf_extables() needs rcu_read_lock() only.
Not the locks you're talking about.

> which we really ought not
> to be doing from inside arbitrary bpf programs. 

Not in arbitrary progs. It's only available to progs loaded by root.

> Keep in mind that, if
> SMAP is unavailable, the fault code literally does not know whether
> the page fault originated form a valid uaccess region.
> 
> There's also always the possibility that you simultaneously run bpf
> and something like Wine or DOSEMU2 that actually maps the zero page,
> in which case the effect of the bpf code is going to be quite erratic
> and will depend on which mm is loaded.

It's tracing. Folks who write those progs accepted the fact that
the data returned by probe_read is not going to be 100% accurate.

bpf jit can insert !null check before every such special load
(since it knows all of them), but it's an obvious performance loss
that would be good to avoid. If fault handler can do this
if (addr == 0 && ...) search_bpf_extables() 
at least in some conditions and cpu flags it's already a win.
In all other cases bpf jit will insert !null checks.
