Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92635209BF
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiEJACo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 20:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiEJACk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:02:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA722BD0F1
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:58:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f2so16989844ioh.7
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oll5CUghmQbVW85EUy7UohNMnCS5LzLiOBqs+W5Oy1E=;
        b=RzY/fOsT7nOx6CNPAlbBXomLN3UVvWBQZFs1ENw99vJhPENemzeE9MR8AUhbaJeBeX
         FB9Gx+qQ+esnqGTFxH1W4lUQ82UEsLZ2vYTeL6mcWuQfl7zRT/tMBCfciN0O8idx1xRY
         aDyMuL4Onw2vQjXTYY07xGiOOFJx3f4ZiTA0iFXUgknE1GXOmK+Uadt+mwFWPkcO0NXA
         nlY+peuiLPsuUNNSGCWrpr+sdjOtdLyLXGvdrV/Dq5cVaSMIo8UvtjKqragQ534Semrv
         0pSmDtAMvaPLxqAHY3649mumElRV+y9JSY26fbyFRmBiYCoMZ/v4qIELTh5tO7xpR80P
         RN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oll5CUghmQbVW85EUy7UohNMnCS5LzLiOBqs+W5Oy1E=;
        b=oqdQ9i/ptRXSSCuIsF758A8J22pvPVCuK3VXRUZZiZY+yiBTHvY5aafOZJgbutNxh1
         up5XfMXwKIWARY6Sjp0lYyLBz5BkCRgDbgJyz6gfBJ8aBNGMdVIabF13l4sxccObhvpH
         xf3ruAR8byoRmr14UruQwAaHc8oZcGZ/JUHzU81y45yYNjF5+Qu4P4uBylaa479/93li
         vDakMD08ilF2PEfhvmknnO88dnYOxCmY2XY1Bh6RIFBryEqF1e4eM7ce3OhwgIhtPnx2
         LOd9V1Y6zQr6W8+U1nWS/a2u8lObodmzXnePCKjKrF4KYgnUUf8VJvdgvbhtpI5vSdi+
         1kQQ==
X-Gm-Message-State: AOAM532m5Gr/sCax01dMq8UAdrzNEBoe9X3x5iHHRTrew0qlL1K7GckG
        R2CH8tyqGqnFlM/uGpECLJh+w6IIJjXLQPEJrfA=
X-Google-Smtp-Source: ABdhPJwu5pV0l2M/RfazR8aL1TqczLMSIPOqhBtcqDVnRWCYnDpn21Hth8Vv8a4G0JYriS81Xp5dJfgIwmkhPnmuOs8=
X-Received: by 2002:a02:5d47:0:b0:32b:4387:51c8 with SMTP id
 w68-20020a025d47000000b0032b438751c8mr8608828jaa.103.1652140724554; Mon, 09
 May 2022 16:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
 <202205031441.1fhDuUQK-lkp@intel.com> <c7819d752137cf93be454c117812bb1c2c1866e4.camel@fb.com>
In-Reply-To: <c7819d752137cf93be454c117812bb1c2c1866e4.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:58:33 -0700
Message-ID: <CAEf4BzaLaQ_e2XNDxoaY+8MVejrWBGrQLbKL2kSyBfMENk-H0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 3, 2022 at 10:20 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Tue, 2022-05-03 at 14:30 +0800, kernel test robot wrote:
> > Hi Delyan,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on bpf-next/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > config: i386-defconfig (https://download.01.org/0day-ci/archive/20220503/202205031441.1fhDuUQK-lkp@intel.com/config )
> > compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/cfa0f114829902b579da16d7520a39317905c502
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Delyan-Kratunov/sleepable-uprobe-support/20220503-071247
> >         git checkout cfa0f114829902b579da16d7520a39317905c502
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    kernel/trace/trace_uprobe.c: In function '__uprobe_perf_func':
> > > > kernel/trace/trace_uprobe.c:1349:23: error: implicit declaration of function 'uprobe_call_bpf'; did you mean 'trace_call_bpf'? [-Werror=implicit-function-declaration]
> >     1349 |                 ret = uprobe_call_bpf(call, regs);
> >          |                       ^~~~~~~~~~~~~~~
> >          |                       trace_call_bpf
> >    cc1: some warnings being treated as errors
>
> Hm, CONFIG_BPF_EVENTS doesn't seem to guard the callsite from trace_uprobe.c, it's
> only gated by CONFIG_PERF_EVENTS there. A PERF_EVENTS=y && BPF_EVENTS=n config would
> lead to this error.
>
> This is  a pre-existing issue and I'll send a separate patch for it.

It would probably make sense to include it as a pre-patch for your
series, so that bpf-next doesn't trigger these warnings?
