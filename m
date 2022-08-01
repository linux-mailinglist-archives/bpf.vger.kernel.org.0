Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198B587429
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiHAW6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHAW6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:58:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D422AC73
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:58:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dc19so248724ejb.12
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PSHCPJedwMWJ5PbWXEJGUX9vimS2FtSoSAATWEZ6zCU=;
        b=Dy8Mcvn4RMue/sNnr3cgzxk2E5KvFohjnFnTwtxbrFXF2pOA3DdgX2QEucYfcv5sgn
         y3BCLyIbiMvA4BgdzWmc/ffpi2fcqylPSALFP+omhjVy7MVHRiLFO/ljQEwbzp2SJJzF
         a92U3JD3vwZSLgyTqzQhxHyb1VRijbwccFzILbX6kJm3WZ4pi4q21mQpvafQDCcyl19X
         EDLJS1QACJCyuWFL5q1lzu7HujySwhe3iEyMrmBgApJtFD7GqRqNrEgokXN8XO4Tg81E
         AcGHy/JbDwQJlp69K5T2WKlmgocIrrI7xkOeSxWYUbLCgcmhF0QSM65emWaYkqiokQeU
         WQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PSHCPJedwMWJ5PbWXEJGUX9vimS2FtSoSAATWEZ6zCU=;
        b=lp4vWZqgF/EZSplZgeQf5S1pDZGurIjnXI+y1bgwo9GiAeXuE20t7rqP9kOtmfimIQ
         +4ca06Od75kAsBhFHdf4ICWbD0s/IUURw2TNGfgnxqknK31H03K73CYQcY2oPPvs1Y2V
         K8XuMIbAJbH8xMEto81Pkp5MJ/yqku4FlfLxYV+B5ZFLrMATQCpqFHyo/4tL/TgfEFWE
         2Xeoc3nDZV+5Du1tCVGvOeeg9mG/go9AF5g+5hEuZZbC5tDac7v1x3KCCk8LZ1/7RdOB
         OZXgZUu7f2ighmMz9q0jM962EkyCXbgLczEcF+TwottGAviws69ruV6cgwNItaH4Zt7C
         My7g==
X-Gm-Message-State: AJIora+ml0RVSR6s/5jIiXdCKd1yaSPFpaiu5yASUgsBR/Ws8uZt2AiA
        at0DwiY1fAIA3V1N7vIIMHw9B/BjVO9D01J4rCs=
X-Google-Smtp-Source: AGRyM1tjbIod1naftXoAhyQ1mHHtsIgCNuX9Q0igFloY8m+5gwoUHsldfe8N1kl1TdnCrzEyj1VzfFALHnxgmYRMwvE=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr13617472ejj.302.1659394732504; Mon, 01
 Aug 2022 15:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
 <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com> <20220801223239.25z2krjm6ucid3fh@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220801223239.25z2krjm6ucid3fh@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 15:58:41 -0700
Message-ID: <CAEf4BzbjFOXFYeRHwnny1p-GWfMDiOqC6zGMSBjGkjY8RQi5Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 3:33 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Aug 01, 2022 at 02:16:23PM -0700, Joanne Koong wrote:
> > On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > > > Since we are on bpf_dynptr_write, what is the reason
> > > > > on limiting it to the skb_headlen() ?  Not implying one
> > > > > way is better than another.  would like to undertand the reason
> > > > > behind it since it is not clear in the commit message.
> > > > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > > > may be writes that pull the skb, so any existing data slices to the
> > > > skb must be invalidated. However, in the verifier we can't detect when
> > > > the data slice should be invalidated vs. when it shouldn't (eg
> > > > detecting when a write goes into the paged area vs when the write is
> > > > only in the head). If the prog wants to write into the paged area, I
> > > > think the only way it can work is if it pulls the data first with
> > > > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > > > the commit message in v2
> > > Note that current verifier unconditionally invalidates PTR_TO_PACKET
> > > after bpf_skb_store_bytes().  Potentially the same could be done for
> > > other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> > > behavior cannot be changed later, so want to raise this possibility here
> > > just in case it wasn't considered before.
> >
> > Thanks for raising this possibility. To me, it seems more intuitive
> > from the user standpoint to have bpf_dynptr_write() on a paged area
> > fail (even if bpf_dynptr_read() on that same offset succeeds) than to
> > have bpf_dynptr_write() always invalidate all dynptr slices related to
> > that skb. I think most writes will be to the data in the head area,
> > which seems unfortunate that bpf_dynptr_writes to the head area would
> > invalidate the dynptr slices regardless.
> >
> > What are your thoughts? Do you think you prefer having
> > bpf_dynptr_write() always work regardless of where the data is? If so,
> > I'm happy to make that change for v2 :)
> Yeah, it sounds like an optimization to avoid unnecessarily
> invalidating the sliced data.
>
> To be honest, I am not sure how often the dynptr_data()+dynptr_write() combo will
> be used considering there is usually a pkt read before a pkt write in
> the pkt modification use case.  If I got that far to have a sliced data pointer
> to satisfy what I need for reading,  I would try to avoid making extra call
> to dyptr_write() to modify it.
>
> I would prefer user can have similar expectation (no need to worry pkt layout)
> between dynptr_read() and dynptr_write(), and also has similar experience to
> the bpf_skb_load_bytes() and bpf_skb_store_bytes().  Otherwise, it is just
> unnecessary rules for user to remember while there is no clear benefit on
> the chance of this optimization.
>

Are you saying that bpf_dynptr_read() shouldn't read from non-linear
part of skb (and thus match more restrictive bpf_dynptr_write), or are
you saying you'd rather have bpf_dynptr_write() write into non-linear
part but invalidate bpf_dynptr_data() pointers?

I guess I agree about consistency and that it seems like in practice
you'd use bpf_dynptr_data() to work with headers and stuff like that
at known locations, and then if you need to modify the rest of payload
you'd do either bpf_skb_load_bytes()/bpf_skb_store_bytes() or
bpf_dynptr_read()/bpf_dynptr_write() which would invalidate
bpf_dynptr_data() pointers (but that would be ok by that time).


> I won't insist though.  User can always stay with the bpf_skb_load_bytes()
> and bpf_skb_store_bytes() to avoid worrying about the skb layout.
>
> > >
> > > Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
> > > If the user changes the skb by directly using skb->data to avoid calling
> > > load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
> > > before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
> > > it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
> > > byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
> > > bpf_skb_store_bytes() to store a modified byte at the same offset.
