Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248895B22F1
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHP7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIHP7k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 11:59:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A724F01
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 08:59:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b35so7076897edf.0
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qdI2ln8Mst1j5RClurG9QEOr/r/jjcrfXVmx4v9cj70=;
        b=f7iyy1+/rlxq5VabzWklomR+sxLzYuK+SJlLCatviwbrOwlqxVVVfTYoXPALYpNu4/
         0ZojKFgLUCYIPXCmPaxlVMtHQER8BHCuBnnV3mAynpBw4Ud3NYI9rAtRbYUmDGFThXPB
         +06wvMFmD9gqKxtRzK2cI3qqldcEFYhZRCp9IKsYtBF0PiNnuejsvBD7iUllKD0Ai0ZW
         nFWiGRAGdVNUtZ4JgecnLiQSqhkK+qLCVCxekmxqhjbhx/WHZ6z4G1sIDzNpknpqXBPx
         bd7Fihf2UvLaz1c/Zuq/JNlRFllpjUfB/9vc942sEqAprUIVchFmlEuWLW4PoxQFNjck
         6kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qdI2ln8Mst1j5RClurG9QEOr/r/jjcrfXVmx4v9cj70=;
        b=GNLct1FU2pc6/G3lpeK9pQtBnWHDFyXfOYaeqlKD0LMUP4URKKTSddMSivX3ea9z6y
         R+pMLOGMycc9E7j6ktlyE68W0EBZQZBAH6MTQVDQgILNDLPiIrDmcogHB8ShpGQDf2y0
         TGS9NcpflCFX3+u0C9YiZBrlhHA9nSLnvqlsiW7X1RKGqNn/5JsEEKfQu4E5dtJG0lr3
         BOA8NuUzDaxa6zEKzB02jQ6XysQ20FCbXuRmhhydDUF499WRHti673xC6QCt4YjnRwIE
         jT7hdVG+VNJdiFTz4BoEKFc0cFZCFgRRilI9Df9CnfzRk4LUPNF+7mubb7R6n/QMd8kE
         v2MA==
X-Gm-Message-State: ACgBeo2O+40zRRPQLtusR2eL1HJdn0ld0n7v06CnQ+FAymNXWJC9FQJh
        ky9HNFbCAFEP3v/999nmxo5oujxl/xXwtVaqg2o=
X-Google-Smtp-Source: AA6agR66a2T11K3J57n5bFQNXsx0LfHMFQ6b8Kp1/+niTuQQTWllRvuEnjyDpYv7Gva4A+nFvAc/t2BnAKyCaUu5H3I=
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id
 et15-20020a056402378f00b0043ad3f579f2mr7889450edb.338.1662652777977; Thu, 08
 Sep 2022 08:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com>
 <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com>
 <CAADnVQ+hgprNMCSk0bjZnRveEzv=t8zoZXH44Gy8tVPJKoPt_A@mail.gmail.com>
 <CAP01T74cHVp4SNfyS+XERU-51z+Sr2L=HMRKaQWRHn5ZKREpzg@mail.gmail.com>
 <CAADnVQLc6bWuyknq_ZqLqEyMmkgg3nia6VW7+9MvgDPTOvJ=kQ@mail.gmail.com> <CAP01T75s+d9Ko7V5dqe94_DbehRv5RXCPGOkjb2CG+wxCe_uvA@mail.gmail.com>
In-Reply-To: <CAP01T75s+d9Ko7V5dqe94_DbehRv5RXCPGOkjb2CG+wxCe_uvA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 08:59:26 -0700
Message-ID: <CAADnVQK+LGziA_eOfobgM2VwNE=OXCMUBfY7YfXj9quOT9kWPQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
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

On Thu, Sep 8, 2022 at 8:38 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Are you expecting the verifier to insert zero inits
> > as actual insns after 'call bpf_kptr_new' insn ?
> > Hmm. I imagined bpf_kptr_new helper will do it.
> > Just a simple loop that is inverse of zero_map_value().
> > Not the fastest thing, but good enough to start and can be
> > optimized later.
> > The verifier can insert ST insn too in !null branch,
> > since that insn only needs one register and it's known
> > in that branch.
> > It's questionable that a bunch of ST insns will be faster
> > than a zero_map_value-like loop.
>
> I would definitely think a bunch of direct 0 stores would be faster.
> zero_map_value will access some kind of offset array in memory and
> then read from it and loop over to do the stores.
> Does seem like more work to do, even if it's hot in cache those are
> unneeded extra accesses for information we know statically.
> So I'll most likely emit a bunch of ST insns zeroing it out in v1.

Premature optimization is ...
