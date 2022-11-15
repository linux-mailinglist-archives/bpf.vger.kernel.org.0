Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7262A216
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKOTlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKOTlS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:41:18 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3B2F652
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:41:18 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso14818138pjc.2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x8pvvmHHGSgsbnVY/+UThDLA4lb0Y6REXc0sN06JDA=;
        b=DzvsRwbOmqlZKPva2jWoKuisq0RV69BEf3uyyT7Aj+DmzlaD1bjeZ04IAA0cJ6YmUF
         j+f6In+wXlk52RZvVFqWy/2J2Qb/P6JF/I3/RBdc1M5TztgNL4xj1sOV0C49VCQ9tkLt
         dyn6nZovvNJC69+oyGGyUBEBjxlbsOfXtouUGMDrb1hQRGvL+3GTi3ZNsWtJILLQFGtU
         2GBZ+PN/QFtOn7vPaCRWIpDiJ7wQNC3yKu4l4OVuM+8NqrSOHfmXsb9YnP1T7bbbV3Yr
         MfrwKF7Hl4sdfimg004OMLPKZKYqsFKQX2iOL+uZmq07BmUB163gPzVXAxE+Iw85aWlB
         +T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x8pvvmHHGSgsbnVY/+UThDLA4lb0Y6REXc0sN06JDA=;
        b=qz8nUOY8Tb31WC3Ssbwo1v4ZaYuEGurQDTF83arYkKyPOSlUWQBk4+wxAY0rmjUucg
         NOhEVHQK30zYQs6WE3p6CF3ILPNhdCgVDyn147q0HPfsrFm/ilyUV4U751SwBcnneXK5
         cJMP2JLj7pc/fflR/xJ27O4fcSjGM6gqhzXdOacSYrUmYsz1gClfmd1OpuHtyk4m/HXh
         wYewROE0M4MqHG/DYZ3vbIuA1ZJKHxbBKfcpBLSVoL91MfcGn/jEldEZjq7vGi0yKsvq
         l9yjMicNBICia5p5g616zhNK/Vb9I5dR5tJw4WV73oeaRssCxgJRVh6K25U8cmt0bSRt
         J2Pg==
X-Gm-Message-State: ANoB5pl+BsDcZmi6sRCFYIDNyX8xWRYK/+AEp2wld0RG6/G42AOcg1Bh
        MXWC3NzXF/7xEzHNrwUETeM=
X-Google-Smtp-Source: AA0mqf7xTea/VKrSVnu/wN65LHZMbBNC9V8Asg3XVsH0CC3DY+ldUBah9M3J4UBMxd3jVe1B4r2lzw==
X-Received: by 2002:a17:902:ed41:b0:175:105a:3087 with SMTP id y1-20020a170902ed4100b00175105a3087mr5660591plb.65.1668541277542;
        Tue, 15 Nov 2022 11:41:17 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id n63-20020a17090a5ac500b00200461cfa99sm11936119pji.11.2022.11.15.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:41:17 -0800 (PST)
Date:   Wed, 16 Nov 2022 01:11:13 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: Add test for dynptr
 reinit in user_ringbuf callback
Message-ID: <20221115194113.ag6pocm2hvrskd3i@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-8-memxor@gmail.com>
 <CAJnrk1aynT73OZJauUEn_OFkVBsZ0wGSZHjnDSKwUG_wYd1Opw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aynT73OZJauUEn_OFkVBsZ0wGSZHjnDSKwUG_wYd1Opw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 12:06:36AM IST, Joanne Koong wrote:
> On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The original support for bpf_user_ringbuf_drain callbacks simply
> > short-circuited checks for the dynptr state, allowing users to pass
> > PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
> > dynptr. This bug would have also surfaced with other dynptr helpers in
> > the future that changed dynptr view or modified it in some way.
> >
> > Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
> > bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
> > Without the fix, both of these programs load and pass verification.
> >
> > Acked-by: David Vernet <void@manifault.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
>
> Left a small comment below.
>
> > ---
> >  .../selftests/bpf/prog_tests/user_ringbuf.c   |  2 ++
> >  .../selftests/bpf/progs/user_ringbuf_fail.c   | 35 +++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> > index 39882580cb90..500a63bb70a8 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> > @@ -676,6 +676,8 @@ static struct {
> >         {"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
> >         {"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
> >         {"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
> > +       {"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
> > +       {"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
> >  };
> >
> >  #define SUCCESS_TEST(_func) { _func, #_func }
> > diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> > index 82aba4529aa9..7730d13c0cea 100644
> > --- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
> > @@ -18,6 +18,13 @@ struct {
> >         __uint(type, BPF_MAP_TYPE_USER_RINGBUF);
> >  } user_ringbuf SEC(".maps");
> >
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +       __uint(max_entries, 2);
> > +} ringbuf SEC(".maps");
> > +
> > +static int map_value;
> > +
> >  static long
> >  bad_access1(struct bpf_dynptr *dynptr, void *context)
> >  {
> > @@ -175,3 +182,31 @@ int user_ringbuf_callback_invalid_return(void *ctx)
> >
> >         return 0;
> >  }
> > +
> > +static long
> > +try_reinit_dynptr_mem(struct bpf_dynptr *dynptr, void *context)
> > +{
> > +       bpf_dynptr_from_mem(&map_value, 4, 0, dynptr);
> > +       return 0;
> > +}
> > +
> > +static long
> > +try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
> > +{
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, dynptr);
> > +       return 0;
> > +}
> > +
> > +SEC("?raw_tp/sys_nanosleep")
> > +int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
> > +{
> > +       bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
> > +       return 0;
> > +}
> > +
> > +SEC("?raw_tp/sys_nanosleep")
>
> nit: here and above, I think this should just be "?raw_tp/" without
> the nanosleep, since there is no nanosleep tracepoint.
>

True, looks like it's the same for all prior cases in this file as well. I will
drop sys_nanosleep for all of them.
