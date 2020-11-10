Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2682E2AD68A
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 13:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgKJMmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKJMmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 07:42:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE991C0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:42:41 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so12502145wrl.7
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PnPpkH9CClw/k67BaWoQxGlCw9zj+tkK05wu9JdvN8c=;
        b=MjHOfC3vUZsleellf07yAu8/8coWI7HszTPxznXTW3BT3X2tsl526wvvIBATlWFM/R
         1RfwAp9AgMBquxdjHWGRkQ9f8Xc7spWYtxi+YxIiLt0oIZ7AQUHg+mWG5SUCWo0zWTjf
         D6bieda5LosLap6FBt4o4/lz1QbbEsJL+H5dTSTmuCg7N0DmHX9iLFM8+nqdjied4QqM
         Uvy2oIioGVt3SO2dhSSpb1sRUfm2vezYy/CM08FgK95BU7p7kO6Yl1sd9WaOaMKfMueW
         QDhiP4MK1OWdyYqsqWKA6o+jazceaT3oftyAgs9VHe9GVOFfi46ywVWB2dq7zCP3MfjM
         +FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PnPpkH9CClw/k67BaWoQxGlCw9zj+tkK05wu9JdvN8c=;
        b=oWKP3c1yiXPrszgVZ0WCDkXawhfzKlowEGDY1z5dd+ocW8G36UuKVVBrmi1HkjV9lT
         YdCeGzIKHSgUp1WwyENiW9bpyTspUnQT3+ckPnEfDjO2UNgjNYEecf1drIB8j23Cg61q
         nvQTAUBNHzrurSIYGI8HFfLVCgYHDL3sZwJElSBMUC+8/stsyC+KE8QtoPGuVTAVl/CP
         OgdUo+XeflKcDXUOzvgxsUW7bCdqnmO7DYJFR1fxt9x3bXO7xOpkkTxpkBYBUajldDa2
         8DfOqNiDUqPcfrsgYD5E+P+8BgCN0RABj1f2WJ19V7ASQS3dq3GW0bv4BF7LNG86zTaO
         N86Q==
X-Gm-Message-State: AOAM532hKEZTfJBA6TZUr9ukx3IV/vW+hp7hbBTW++LfkIVDGT1gNyeH
        bBjEx2TAgwsuuxAU+brMUPCBsw==
X-Google-Smtp-Source: ABdhPJwY0SfpPfCmPfoA72NE9tJCbw8+CfuMV0w9kX1DDOuSy0gNzjOaMKmWQ53BRBXW062WncbPeg==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr6077376wrs.170.1605012160455;
        Tue, 10 Nov 2020 04:42:40 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a17sm17082155wra.61.2020.11.10.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:42:39 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:42:20 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next v2 0/6] tools/bpftool: Fix cross and out-of-tree
 builds
Message-ID: <20201110124220.GA1521675@myrica>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
 <CAEf4BzZeymUUNSp-wg1_UVUH_7-N3JaXWT7qArqT612459nLmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZeymUUNSp-wg1_UVUH_7-N3JaXWT7qArqT612459nLmA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 09, 2020 at 10:11:52AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > A few fixes for cross and out-of-tree build of bpftool and runqslower.
> > These changes allow to build for different target architectures, using
> > the same source tree.
> >
> > I sent [v1] ages ago but haven't found time to resend. No change except
> > rebasing on the latest bpf-next/master.
> >
> > [v1] https://lore.kernel.org/bpf/20200827153629.3820891-1-jean-philippe@linaro.org/
> >
> 
> While you are looking at bpftool builds... Seems like it regressed
> recently and doesn't honor -jX setting. Either way the build is
> sequential (and rather slow). Do you mind checking if your changes
> could fix the regression (I haven't had a chance to bisect the
> offending change causing regression).

I bisected it to ba2fd563b740 ("tools/bpftool: Support passing
BPFTOOL_VERSION to make"), in v5.9. As BPFTOOL_VERSION became a recursivly
expanded variable, the shell function is evaluated on every expansion of
CFLAGS. I'll add the fix to v3:

-BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
+ifeq ($(BPFTOOL_VERSION),)
+BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
+endif

Thanks,
Jean
