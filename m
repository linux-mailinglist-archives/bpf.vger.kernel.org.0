Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F76A60BC
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1UwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 15:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1UwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 15:52:23 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05B4680
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 12:52:22 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id n4so2182403ual.13
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677617541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHFlUhkJtcXe7XZxKdususSSue1DV4ZWbeqUg0cyQlE=;
        b=FgUeZDWfbr/qDX1O2qlF+A+atb5L3k3mrCiRc8On/We+mULlWwmM2UCPwOl+tzkhee
         sezziYiYzLFisDIgWPaaYbLQOhCY63CifMlG2GV8xvP62A2A+rypcgGuBXwzWQ/VGsaJ
         XBMeV+RwV4HRiUOBGb3yjZoE+4/ja0xlTEIDwA46dXCVhyOGYCkSHKDgV+rvL2B0AmRu
         mHH17fuO+GpE4VhETYl5dtgI/eeFf80HmltEtlCrZa2Ua6rc57deLZRgD09SuhcUAx1v
         hSXgq+dGKdQ9uQHfememLfb1Ji3PjNhs4TM7L+820xULzq+kG6YrNSJHE3RwyF053LFV
         Wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHFlUhkJtcXe7XZxKdususSSue1DV4ZWbeqUg0cyQlE=;
        b=4zoREyH6Ntu/RMALjbcyifSyE8qwvJMLIX/bsOXGffKKrVx+Dn0gEVlyNY8vW366IN
         CBNmYMwDGZra6Pp5XPnb6k5L9UguG2logY1U2ccT3yGdr9mrRP739eWOlfLI+Pa+ndCV
         kxKfpEGCWOSHHSF7mPULyx2hFP1hbCzumqc84FB+9me2FbLoZ+CoP6RcINtMie5tY/KD
         fY5sVjakaMi7vEFIMlp7pDzJXkkJjy67fSsRp31/sGdyazFyWAMHFUK7mCmXzN6xQVG3
         BvYwtJKpMzPE2Y9pTmtbBZKEGSvjExfiXG4E+mLWgIRw99ShvQltB3YjLAQpRqlVIbCe
         vGYw==
X-Gm-Message-State: AO0yUKWvNvY2S7ZObLtqWUHB+9pP1LK4aShI0q0gtJHcri3kPFzwiehO
        dtb/0epupDmHuTJpejIjrUv1RitP7GbT/EbM/2Lxx8+jPEdnkxa/
X-Google-Smtp-Source: AK7set8fXGo3sSX/SLl/MXgAl1vQYsEFAPsC1CHLCFO9XbxO1KDytcwW8aKkxIKuefxNLUVBdmhQ9YehIVRhbMlROOk=
X-Received: by 2002:a05:6122:e6b:b0:412:611a:dce5 with SMTP id
 bj43-20020a0561220e6b00b00412611adce5mr2057278vkb.0.1677617541239; Tue, 28
 Feb 2023 12:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-2-aditi.ghag@isovalent.com> <Y/k68KV9GDakrKQ1@google.com>
 <d3517701-7027-3750-3ac3-aeb9ac8600c8@linux.dev>
In-Reply-To: <d3517701-7027-3750-3ac3-aeb9ac8600c8@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 28 Feb 2023 12:52:05 -0800
Message-ID: <CAKH8qBvd7K=kVFaZpQAAe5d4ExgK=Vmgp6+BiquCCcLWu59oVg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Implement batching in UDP iterator
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 12:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/24/23 2:32 PM, Stanislav Fomichev wrote:
> >> +    unsigned int cur_sk;
> >> +    unsigned int end_sk;
> >> +    unsigned int max_sk;
> >> +    struct sock **batch;
> >> +    bool st_bucket_done;
> >
> > Any change we can generalize some of those across tcp & udp? I haven't
> > looked too deep, but a lot of things look like a plain copy-paste
> > from tcp batching. Or not worth it?
>
> The batching has some small but subtle differences between tcp and udp, so not
> sure if it can end up sharing enough codes.
>
> >>   static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
> >>                    struct udp_sock *udp_sk, uid_t uid, int bucket)
> >>   {
> >> @@ -3172,18 +3307,34 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq,
> >> void *v)
> >>       struct bpf_prog *prog;
> >>       struct sock *sk = v;
> >>       uid_t uid;
> >> +    bool slow;
> >> +    int rc;
> >
> >>       if (v == SEQ_START_TOKEN)
> >>           return 0;
> >
> >> +    slow = lock_sock_fast(sk);
> >
> > Hm, I missed the fact that we're already using fast lock in the tcp batching
> > as well. Should we not use fask locks here? On a loaded system it's
> > probably fair to pay some backlog processing in the path that goes
> > over every socket (here)? Martin, WDYT?
>
> hmm... not sure if it is needed. The lock_sock_fast was borrowed from
> tcp_get_info() which is also used in inet_diag iteration. bpf iter prog should
> be doing something pretty fast also. In the future, it could allow the bpf-iter
> program to acquire the lock by itself only when it is necessary if the current
> always lock strategy is too expensive.

Cool, thx!
