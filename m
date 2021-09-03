Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C303FFFC4
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349357AbhICMct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhICMcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 08:32:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FBCC061757
        for <bpf@vger.kernel.org>; Fri,  3 Sep 2021 05:31:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso3462108wmr.1
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTpqNQaM6lWYVJnHl82Fyh/O+33HHqtU4xirnSXQUYs=;
        b=p4lyLGqiJiypZqMDxYZYmOZ55pKcMEV3cwx3gZUZsyKyAGLkRDW11I9fbVJgXkrt4D
         eopoaoajV/miiQtWFmeCDwINubRea14TOZ3uIbLpu1NkKnqvoA3Vf2cjD7hUFb18SnaV
         MZVas75N3s31DFhGRByuswfj4twLv1DgvCyZuyg44q8ZTJK7Ve6ZUyrfwjHfWsW9t5Wv
         p/YSBu3agQhigfwSoJMZ7kVZZ28jpGmcaduIfi0WHK+QD8kYovKl1t9NxFcgkBgPRdsR
         ZckUki+LylHVA1TVO/o4LjjdGe2zblirLw2QdqucAzyTIV0gxTAexOdbk8wPZ7SJXoX9
         bXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTpqNQaM6lWYVJnHl82Fyh/O+33HHqtU4xirnSXQUYs=;
        b=lTjPMe7YFUjRhlvw/xc3GuCiSAlpaNQPKZZnzKrHq0yLGyRMoZ8411Q/BksIigZGJd
         CKMpp/vs08+5S5bDoAf/Gh8zF+AygXFrOJxI6TOUi35UbV7oZzr5WD7Ehh4xI3+lCXWX
         N2Q5fp2PmN254M+QrCD5M3Ly09NQA+5QnZaDmKCUPR/yO2jVI/0F7kDpIKKlPLvYBYL8
         gYG51zHf9W0w6d93bTTbJisxlASC8esvtrvNfjqm8lQIekL3//Jmgm3Fo+0al3ftJPtR
         2h7ag4YzkjTCIzsM3D8Zn0uwvs9Cdk0p9hb9J4YVLUEHWc0PE9g7Wlhi3lfP/1RvPPZ+
         rDeA==
X-Gm-Message-State: AOAM533X70OzHG/ERdZ7lScjUYjruKa8qKZjHmYzrIJXTf1osxtQnqUq
        Rdr2JfsSrkt0BjogWQDSLIsb+w==
X-Google-Smtp-Source: ABdhPJwWnw6fJtjHPeIU/KjhjOFglKmSaCXrxfWPWoUO24U0pvjCCpWFz1eU84xUCuAY5YQpA34oAQ==
X-Received: by 2002:a05:600c:3656:: with SMTP id y22mr7994102wmq.58.1630672307332;
        Fri, 03 Sep 2021 05:31:47 -0700 (PDT)
Received: from larix (19.11.114.78.rev.sfr.net. [78.114.11.19])
        by smtp.gmail.com with ESMTPSA id k1sm4758119wrz.61.2021.09.03.05.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 05:31:46 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:33:57 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of task_pt_regs tests
 for arm64
Message-ID: <YTIWNRqZ/HmHgcaE@larix>
References: <20210902090925.2010528-1-jean-philippe@linaro.org>
 <CAADnVQKwHXw7fLGpJBJBb_MW+d1Gzexo2wk9QwE2v3fy=kHDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKwHXw7fLGpJBJBb_MW+d1Gzexo2wk9QwE2v3fy=kHDRA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 12:13:40PM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 2, 2021 at 2:08 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > struct pt_regs is not exported to userspace on all archs. arm64 and s390
> > export "user_pt_regs" instead, which causes build failure at the moment:
> >
> >   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
> >   struct pt_regs current_regs = {};
> 
> Right, which is 'bpf_user_pt_regs_t'.
> It's defined for all archs and arm64/s390/ppc/risv define it
> differently from pt_regs.
> 
> >
> > Use the multi-arch macros defined by tools/lib/bpf/bpf_tracing.h to copy
> > the pt_regs into a locally-defined struct.
> >
> > Copying the user_pt_regs struct on arm64 wouldn't work because the
> > struct is too large and the compiler complains about using too much
> > stack.
> 
> That's a different issue.

It does work when doing an implicit copy (current_regs = *regs) rather
than using __builtin_memcpy(). Don't know why but I'll take it.

> I think the cleaner fix would be to make the test use
> bpf_user_pt_regs_t instead.

Right, although that comes with another complication. We end up including
tools/include/uapi/asm/bpf_perf_event.h which requires the compiler
builtins "__aarch64__", "__s390__", etc. Those are not defined with
"clang -target bpf" so I have to add them to the command line.
I'll resend with your suggestion but this patch is simpler.

Thanks,
Jean
