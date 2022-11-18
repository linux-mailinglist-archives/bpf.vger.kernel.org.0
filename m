Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705C62FD81
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiKRTAv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbiKRTAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:00:32 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D92D1C7
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:19 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so3560364pji.4
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Jp1cTxEPtM1BXeO8uSCx+LCd2M8aMX65q592YD0d0=;
        b=YBonu6QEoI3N+QWNkdFOwxF3ItJ9EFU+B5QfjHdU3GBc2ZSnZe5yALtB4jpeLFDc95
         Ko7GTekdRMQhho0bCqK+AxMp1/j8BB51a/wRI+vy7T+cl7YGRNwm0pb+eQDDA+wfDfpB
         9FdLLgfncKwQnhaAHnkQK1u8gFKjb1HsP3T3pTa/LqNDKrflro+9zyW4t2iR2AJADJWZ
         iROyjp+IY4lGBWoV6IPqSgDaztQmSnc3s8+CiSL2zFO/bRE8we3J5ll0YK5KW9Ow2zOj
         nV+iY3OCRdRb9c+VW18k7zFA79aHjwLJQRbN1GcJcwBih4yUs4blxHGRmx1MEVJFKWEI
         OlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+Jp1cTxEPtM1BXeO8uSCx+LCd2M8aMX65q592YD0d0=;
        b=HaP3BcWc5QPt9hLBa7sgqmua+zcI7IfLQZTdQL2KZ6Ei2EgjYoG+t244zg+IxRzl2o
         fBRcUQXpc4VUjyHDrUvUVMaZnT6ojKXdZLQW21Bhv41TxwjnpYo+wl0ChZ57LpQTaue7
         2ZyI14A820E1g2dFW1DwZd3e9pRFQ+PNF8oF6mA+niSABprppPy4tQnWfJd/j/bvmNml
         YCyCiqb3NxRCdiygA9LaUYTLqbwON7pqDO4bZ2DfOIc+FWUEc/G1bWmWsv6bU/5GhmU2
         i85D1wFdLVqIaT+zc1Txot5YQcV5/POQLvzdA1QYfrhNXodS6HrAhce3iTnq2h2IWHNK
         r3AQ==
X-Gm-Message-State: ANoB5pluIApi9xMkF1iILoqVgGD98WxmUegjWqnN81BpRPwTWe35j4xV
        tXQ4J17PfolsD8EuriI4s3Q=
X-Google-Smtp-Source: AA0mqf4KvwQZUbBIb9/SgJVncK1D3esc3Kj06gQubEQWyMB7Kjo12ZCug/JSvq3Y508MTF6QW2Br4A==
X-Received: by 2002:a17:903:491:b0:17f:73d6:4375 with SMTP id jj17-20020a170903049100b0017f73d64375mr921592plb.24.1668798018733;
        Fri, 18 Nov 2022 11:00:18 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b00186c3727294sm4034654plg.270.2022.11.18.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:00:18 -0800 (PST)
Date:   Sat, 19 Nov 2022 00:30:12 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
Message-ID: <20221118190012.cfhavzxw3ssil6nh@apollo>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-12-memxor@gmail.com>
 <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local>
 <20221118103730.nbai3gzifkjk45eo@apollo>
 <CAADnVQLxkVKggTwXQJN48yvi4mh9o8qGoF4M4VGifHzygfq+cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLxkVKggTwXQJN48yvi4mh9o8qGoF4M4VGifHzygfq+cw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 11:32:21PM IST, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, Nov 18, 2022 at 09:04:15AM IST, Alexei Starovoitov wrote:
> > > On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >                                 const struct btf *btf, u32 func_id,
> > > >                                 struct bpf_reg_state *regs,
> > > >                                 bool ptr_to_mem_ok,
> > > > -                               struct bpf_kfunc_arg_meta *kfunc_meta,
> > > >                                 bool processing_call)
> > >
> > > Something odd here.
> > > Benjamin added the processing_call flag in
> > > commit 95f2f26f3cac ("bpf: split btf_check_subprog_arg_match in two")
> > > and we discussed to remove it.
> > >
> > > >             } else if (ptr_to_mem_ok && processing_call) {
> > >
> > > since kfunc bit is gone from here the processing_call can be removed.
> > > ptr_to_mem_ok and processing_call are two bool flags for the same thing, right?
> > >
> >
> > I think so, I'll check it out and send a follow up patch.
> >
> > > > +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
> > >
> > > I fixed this bit while applying.
> > >
> >
> > Thanks.
> >
> > > > +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> > >
> > > This function looks much better now.
> > > The split of kfunc vs helper was long overdue.
> > > Thank you for doing this.
> > >
> > > I'm not convinced that KF_ARG_* is necessary, but it's much better than before.
> > > So it's a step forward.
> > >
> >
> > Yes. Eventually we should be merging checks for both helpers and kfuncs, but
> > that needs more work and would have been out of scope for this set. We can
> > probably synthesize a bpf_func_proto for the kfunc from BTF and then offload to
> > check_helper_call.
>
> Yeah. If kfunc BTFs plus KF_ flags can be synthesized to bpf_func_proto
> that would be the best. If such conversion is possible then it
> should be possible to do it in resolve_btfid in user space.
>

Yep. I'll poke at it some more later.

> One more thing that I forgot to mention earlier.
> Could you follow up with a patch to get rid of bpf_global_ma_set
> check in the run-time and variable itself?
> If bpf_mem_alloc_init fails the boot fails too.
> If we're paranoid we can add:
> special_kfunc_list[KF_bpf_obj_new_impl] = 0;
> to bpf_mem_alloc_init() to prevent bpf_obj_new to ever be called.

I did it a bit differently, but it does the same thing, and sent it out with the
s390x fix. PTAL.
