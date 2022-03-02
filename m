Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FE4CB39E
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiCCAC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiCCAC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:02:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52563240B2
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A394617BD
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 23:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFCBC340E9;
        Wed,  2 Mar 2022 23:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646263605;
        bh=TLcvoWQtdtysbTxCfNelk4ZWdU1R8dneA5RI6VnKf3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxTQQ+8m0ZTa2bMU3evAo+eXjcpRe8ZvOjUXx1pWyjCCCnuOH5j4O9lpcdSQlzpGc
         PXgL4QGaJ9i3aDdy4zxNI0SFMtFwKl6He9iGhr7YnPGN6pCaKYmhXM8OyHtz4ma6uX
         y7hVospFUZuBQ1CZ3pP5/uOw/HC2SE4w+lzjIJ4Y3fjRSHtppU4vyHx31hHpDWkx7f
         uTabSE3McPiaDKnHvnBFnwGlKgBcP92IcwXl6uwa3M01qO5DVwCFdC8nFgy8WF/dvc
         Te1uP3s8vecr5eOtC+N+A01oKhjgJ/EeS1BuGdvSiV5Omc/KzSDT39McOeof4IP6HL
         A1pYBpA4elqKw==
Date:   Wed, 2 Mar 2022 16:26:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
Message-ID: <Yh/9LS7zc3nhTjsR@thelio-3990X>
References: <20220301065745.1634848-7-memxor@gmail.com>
 <202203011937.wMLpkfU3-lkp@intel.com>
 <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
 <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
 <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:44:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Thu, Mar 03, 2022 at 04:17:25AM IST, Alexei Starovoitov wrote:
> > On Tue, Mar 1, 2022 at 3:57 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> > > > Hi Kumar,
> > > >
> > > > Thank you for the patch! Perhaps something to improve:
> > > >
> > > > [auto build test WARNING on bpf-next/master]
> > > >
> > > > url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > > config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > >
> > > The same warning is emitted on clang for all existing definitions, so I can
> > > respin with a fix for the warning like we do for GCC, otherwise it can also
> > > be a follow up patch.
> >
> > Separate patch is fine.
> > How do you plan on fixing it?
> > What is __diag_ignore equivalent for clang?
> 
> Hmm, looks like I'll have to add those in include/linux/compiler-clang.h. Quick
> local testing suggests it will work with _Pragma("clang diagnostic ignored ...").

I have a diff that mirrors the GCC infrastructure, which should work for
this, feel free to copy it:

https://lore.kernel.org/r/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/

If you want to shut up the warning for all supported versions of clang,
switch 130000 for 110000 and __diag_clang_11() for __diag_clang_13().

Cheers,
Nathan
