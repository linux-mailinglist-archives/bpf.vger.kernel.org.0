Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC74CB2E5
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 00:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiCBXr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCBXr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:47:58 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BB23F3C0
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:47:04 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q5so3289006oij.6
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 15:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/ld2l1QfhZw5fycHIZhicQmUAincS/ed7DfQS4GrJo=;
        b=ViefEvfMbLhz6Ctu96GokkwMfCpWEne+ktDvFtkT3qkLrh7gfDs9PfaXYkJDEYrtui
         49WDWIvwvvM6gXpGSZsTB/qPnuPrCIRuQy/XCvrR9PmShSwCO13rPkuZAXJUbvumZUnB
         AMYP1KPCsbk/ve2rSrCawBXNkTTeUJUizFoGHdL2cdPqwBW37AwuNDjENUvqaQu+AhUl
         LlPEarJcQ0aawr+1TgicF+xm1Dl3GILQ5WUlRoilbnNUUG2EQIntvKG/NSHEEW8KEOwU
         MFHmF8y8gkT0DwbMtzKUHTohkZSJ6sIZOd2feeMygKXKIxhVJlI5kFwUybtmuaDB2UEt
         9eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/ld2l1QfhZw5fycHIZhicQmUAincS/ed7DfQS4GrJo=;
        b=1yHdZCn7aIQ+c7lLCKsG7LTKRt5OvTF4a0pjl5OltDicsaMJyhTjYiVVsGEPggG6dd
         IYutYbVOtV6n1saqdvoCZ+0kfqxXFafqzKwA+9EJwi5+eBNRZ+hoRgKlZSISC0xi5wAj
         Jr1i/aPtXw7mhsynV1nkmKf1SV7/Fr0HU8yUCjzrw9tbYC7aK0aFptEQwyoPj9sglrQp
         0QPHSZmZXUMcW2aqD6QxhY9D6RkpV3Oa1WOoAoNpzGBRJfQ50yl4m5NLUKA0dnSs31Ha
         tsfjC0LABzhAxlqef0wLJbOsmSSuFbxRL5pZevWHosvJB6F2+PHF1suvvY5UX3x5GfDD
         s+kA==
X-Gm-Message-State: AOAM531EWg9g2ZQ0uDTvKtDf49s11TAh2dWftdHTVAz3X4i2PlGmrIFa
        D+zj6rp//T1S/GSyacQ1i/tpf5hJinA=
X-Google-Smtp-Source: ABdhPJzB/6ywPQ1g5j9dJIjdvx9LpP29jILx7t9+/tzYvRREY7LhT7NAaRPZxLwQNGC4YnwLN9MDHA==
X-Received: by 2002:a17:90a:6404:b0:1b9:28a8:935f with SMTP id g4-20020a17090a640400b001b928a8935fmr2231073pjj.197.1646264280108;
        Wed, 02 Mar 2022 15:38:00 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id nk5-20020a17090b194500b001bf01e6e558sm152612pjb.29.2022.03.02.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:37:59 -0800 (PST)
Date:   Thu, 3 Mar 2022 05:07:57 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
Message-ID: <20220302233757.plavf56gm2uhhneu@apollo.legion>
References: <20220301065745.1634848-7-memxor@gmail.com>
 <202203011937.wMLpkfU3-lkp@intel.com>
 <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
 <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
 <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
 <Yh/9LS7zc3nhTjsR@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/9LS7zc3nhTjsR@thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:56:37AM IST, Nathan Chancellor wrote:
> On Thu, Mar 03, 2022 at 04:44:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Mar 03, 2022 at 04:17:25AM IST, Alexei Starovoitov wrote:
> > > On Tue, Mar 1, 2022 at 3:57 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> > > > > Hi Kumar,
> > > > >
> > > > > Thank you for the patch! Perhaps something to improve:
> > > > >
> > > > > [auto build test WARNING on bpf-next/master]
> > > > >
> > > > > url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > > > config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> > > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > > >
> > > > The same warning is emitted on clang for all existing definitions, so I can
> > > > respin with a fix for the warning like we do for GCC, otherwise it can also
> > > > be a follow up patch.
> > >
> > > Separate patch is fine.
> > > How do you plan on fixing it?
> > > What is __diag_ignore equivalent for clang?
> >
> > Hmm, looks like I'll have to add those in include/linux/compiler-clang.h. Quick
> > local testing suggests it will work with _Pragma("clang diagnostic ignored ...").
>
> I have a diff that mirrors the GCC infrastructure, which should work for
> this, feel free to copy it:
>
> https://lore.kernel.org/r/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/
>
> If you want to shut up the warning for all supported versions of clang,
> switch 130000 for 110000 and __diag_clang_11() for __diag_clang_13().
>

That's great, Nathan! I'll add your Signed-off-by to it.

> Cheers,
> Nathan

--
Kartikeya
