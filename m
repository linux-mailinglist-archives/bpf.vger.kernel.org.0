Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4480E65DD57
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjADUDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjADUDu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 15:03:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60918E2E
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 12:03:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so28104727pjk.3
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzN+oMHIfRgACxWpLkmUJs3cnzpDW33cOOLbrj6J1pQ=;
        b=P06eJw5moXraEqbbIKw33PxqphL5eJbmFxkk2nGVq6OQK1Iq2Koj590LaeaBKvrn39
         VR+sBKkq/fa1hINKb3I7vEmtwHgMI0Da3JIclZpPPVjszI/CbDKerL9n9fLgykVJiUyH
         jEJehQNEuvBBqS4/z25lMR3AqtCkouSrvpk93ctYIRdSX+A5MZHyoReZs/cDCykxbFYY
         AaRt2/QKEJLlsdfltBPK+Px1tjDwPWukWyZ34fgGDbhkx4eikrXCyBsNvAiD87x1FSUI
         hnshHWjba30I7AWxEJR9GRMKr5pb4qvTM3im3yz+I3FEDRse1yytstHVHhxqWPXZxlgv
         7JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzN+oMHIfRgACxWpLkmUJs3cnzpDW33cOOLbrj6J1pQ=;
        b=cOfCE134zhdG11CU5EbTLtkzS8JY6yPpaY6KcxcSAcdhLuW/ZayoM5uunq8n+P563+
         Rlzy12XVZXgNER++bdwrcvLunSN+kXn8FYqPAQgX2MCOqD8Z1EsWd4PhS7fgaMCWDzna
         SZZMPbtlzZLh2AJQADeiakQeopn8qxLijsu/9Ygd5jbGHGeW1gTvypYxIGzzwxS32DC/
         uNcl/dl/ClHWsmT5beXtWru+CdbThSjaW7Pqh/IiOCeNYwr8p843VPoJ00Cv2+s6wclv
         hUifEqa0uZLLCV1DqkR9P8rew5s3GQphxEDIunZwVP0e1FgQqGTK3M28tmn2ppNz9Bml
         CbNQ==
X-Gm-Message-State: AFqh2krxzBYyVpuX64ppqcVrerrrdUGAU8zlyXTX0BPLPg5jqRxE+usL
        /PPh3ePT5r6dobmfj52cUEk=
X-Google-Smtp-Source: AMrXdXvvLsMsm4RoFABsavn4ZquAiBMqcDykYyurDmeb5wd86UjDekwcHQHExABSc1XbD+zUu0GdXw==
X-Received: by 2002:a17:90a:1345:b0:226:1495:3dca with SMTP id y5-20020a17090a134500b0022614953dcamr27092858pjf.45.1672862629036;
        Wed, 04 Jan 2023 12:03:49 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a3d8500b002191a64b5d5sm22966838pjc.18.2023.01.04.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:03:48 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:03:45 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230104200345.ir6karrn3gfd3iu5@macbook-pro-6.dhcp.thefacebook.com>
References: <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
 <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
 <CAEf4BzYXpJtUy9yp_jE-BYG-goAC-5QGwwFM+cPDOHEEKT4kYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYXpJtUy9yp_jE-BYG-goAC-5QGwwFM+cPDOHEEKT4kYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 10:59:15AM -0800, Andrii Nakryiko wrote:
> 
> > >> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> > >> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> > >
> > > "Proper BPF helper" model is broken.
> > > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> > >
> > > is a hack that works only when compiler optimizes the code.
> > > See gcc's attr(kernel_helper) workaround.
> > > This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> > > And because it's uapi we cannot even fix this
> > > With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> > > These tools don't exist yet, but we have a way forward whereas with helpers
> > > we are stuck with -O2.
> >
> 
> But specifically about how the BPF helper model is broken, that's at
> least an exaggeration. BPF helper call is defined at BPF ISA level, it
> has to be a `call <some constant>;`, and as long as compiler generates
> such code, it's all good. From C standpoint UAPI is just a function
> call:
> 
> bpf_map_lookup_elem(&map, ...);
> 
> As long as this compiles and generates proper `call 1;` assembly
> instruction, we are good. If/when both Clang and GCC support an
> alternative way to define helper and not as a static func pointer, -O0
> builds (at least in the aspect of calling BPF helpers, I suspect other
> stuff will break still) will just work. And what's better,
> bpf_helper_defs.h would be able to pick the best option based on
> compiler's support with end users not having to care or notice the
> difference.

Right and that's what gcc did with attribute((kernel_helper(1)),
but we didn't like it because gcc and clang would diverge.
Now you're arguing it's just a bpf_helper_defs.h change and we should
have allowed it?

Also consider that 'call <some constant>' or more precise 'call absolute_address'
as an instruction exist in only one CPU architecture. It's BPF ISA.
It's a mistake that I made 8 years ago and inability to fix it bothers me.
Now we have 100 times more developers than we had 8 years ago.
I expect 100 time more UAPI and ABI mistakes.
Minimizing unfixable mistakes is what I'm after.
