Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD44CB30C
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 00:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiCBXqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiCBXp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:45:58 -0500
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70F42A3B
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:43:41 -0800 (PST)
Received: by mail-vk1-f193.google.com with SMTP id j201so1776687vke.11
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 15:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MZZKg76Uu6fTeP2WHxUNaLYjEwH0+kMrpeM8QvcEII=;
        b=U4dIHcJcXSEFAeFXkdMSfZz/MtfWZqMJXt9E25MWjxZMEeP1k6D06SGlMKkd9CtCPs
         Ork45JxwruKDiYOjZx9EEq/jLWS9GxZE12P8QrMJpYidS/1SUj4XG0QYnOmJ08klyn04
         tJPflyEjVYIfQ3GFloTEt0vZ7XXT3twXQS+lJPCetvjCr6Lc6SGtx0cNLTsDX+1+gLz6
         A0PRZFAS+ICMrw4fF/Jq1ntJfnByBBvufk+Qf5mf1YQO5TtBbJlIFxr64f1VSJgxbBOT
         zJQglD2O2ut9yFY3QSt99TofTcAH/TSHpdQOK+f1eFoL6Th/n+qDqcDVJd6nfyhOHJO4
         bEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MZZKg76Uu6fTeP2WHxUNaLYjEwH0+kMrpeM8QvcEII=;
        b=1cW50D+TZyxSTbx/Cc/mh47VlgTLX8bm8AN9fF4/6i3TrC7WO61eNXfgtM/ESdiDh+
         /ed4ODMGL+awI6pmdInuh56ftcPPViW/706wZuFRSwnmEO2HnRWK5vvF6/f0Mwl5aECe
         ljhdidB/Vthj4D3N0p4DC348bV+ouwntU89JI3eGlefq0M/+Z8v+p0ABSnFwNM5j+Zay
         5Xpv6kOXMuNd5l1n9FCf0T0M+QXn8ooEByVq9i6nioOPeFZ93a8a8zFPdq6zMxqjm9N4
         nD7bC1Tk48QRdp8K4jwm0yfBOGDqs+8DL6V7OCvuw+ZOyMRW04jxYCrAzwPZpsncqgX/
         E2PA==
X-Gm-Message-State: AOAM530h5OsSOul/RFok03BD2YsMWYRBxqCVl1X3+6OKoqt7u3TG4sQi
        y/RuIVqy3QBalRiH1fDohNA2ryKvCps=
X-Google-Smtp-Source: ABdhPJwsMinvFGIELcISd8wwBPadUVTyfGzpYvf/+AaFc3t1W920rGxSNlDx2+/+eEZEVK+j+VdEPQ==
X-Received: by 2002:a17:902:7b8d:b0:14f:1aca:d95e with SMTP id w13-20020a1709027b8d00b0014f1acad95emr32781546pll.122.1646262843965;
        Wed, 02 Mar 2022 15:14:03 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm182683pgb.73.2022.03.02.15.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:14:03 -0800 (PST)
Date:   Thu, 3 Mar 2022 04:44:01 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
Message-ID: <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
References: <20220301065745.1634848-7-memxor@gmail.com>
 <202203011937.wMLpkfU3-lkp@intel.com>
 <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
 <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 04:17:25AM IST, Alexei Starovoitov wrote:
> On Tue, Mar 1, 2022 at 3:57 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> > > Hi Kumar,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on bpf-next/master]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> >
> > The same warning is emitted on clang for all existing definitions, so I can
> > respin with a fix for the warning like we do for GCC, otherwise it can also
> > be a follow up patch.
>
> Separate patch is fine.
> How do you plan on fixing it?
> What is __diag_ignore equivalent for clang?

Hmm, looks like I'll have to add those in include/linux/compiler-clang.h. Quick
local testing suggests it will work with _Pragma("clang diagnostic ignored ...").

--
Kartikeya
