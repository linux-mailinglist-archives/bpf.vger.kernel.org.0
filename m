Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2F5873CE
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiHAWO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiHAWO2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:14:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50F422E7
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:14:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so2758979edd.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xw4lCew3jp4W2i4xDtJj3gSW1mtdQdGU0rZBNP+94ec=;
        b=Rs1LoY02ZanOWZNqlPO/pZOGvKdVLlj4ASP/qT+AVqFiFcknS60LA1dhnFbMCFee8T
         sxjv8KCbTUXQAnl+X/nLzHvH4IggICkGnjn9nY3SI4IYn1NEgNKQV8t27U/GTArprmeo
         UVS5L+Iz3dDdmTzMowd9HlJIAqPxjY/vbPCtw90Y2QXWE1BxMhqz5ok7mH0opFl5uUwm
         RA2y3XYH+BN0v5S345/dcgEJNbV47Tak7fky2s4bzI7xoVuESG+z8QvKVJlXIs/Q8JN6
         0TjaoYJTzIWXAFsH9wxQWvV9zufcKIn4ytuJ7kMOY3jxHmKr2zA4IwC0CDtkoHBV+S10
         qRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xw4lCew3jp4W2i4xDtJj3gSW1mtdQdGU0rZBNP+94ec=;
        b=AC5f9FbnyCG7qPhoCpzMf82XiqYDRh95BmxB368EXlkGEXtPoZzaB0qtojQFoHb26L
         B/HH6vmhbleO621aE1823du7VhlXRkliU9agrEZfCBLg7HKROj7B6C9nlXVCedGVDEmF
         N65odEAJ1fZMsvY/t4bN4mZplIuRx7lqEJsj8aSANsOK1bW7QVpRVLoIPdr7YTzfofQn
         iR8LT2RPnzLd3Gb94jnCh2qcqQ6qIar7qZzGP+ZlJ7Kxgppcp57LKsc8ExTCD8EQFCOW
         O07vvFWW01v2xLSd01+uVrMCkKMsKdh/Nvfs1LzD8RQxYtt+yS8D/5zs+0NuxsI5oFIM
         jwsg==
X-Gm-Message-State: AJIora+PyaUTSbui+ft3NwduKWV0IJPyy6+18PqHM2IpGA21j1Gm3cD5
        4M33Zw7KZyv4/FA5k1wAok4amsyF/UbqvAl1oQaMXmrd
X-Google-Smtp-Source: AGRyM1v7hEOYc4xVnPeIN/16yb0Vbg/BRMM+PS5Pa22A37eTeK9VQOSch4ATHgVyUqchC2/gPaWmNOGRqLMC4DMQDi0=
X-Received: by 2002:a05:6402:5108:b0:43b:e395:d2fb with SMTP id
 m8-20020a056402510800b0043be395d2fbmr18177237edd.260.1659392065481; Mon, 01
 Aug 2022 15:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
 <20220801193850.2qkf6uiic7nrwrfm@kafai-mbp.dhcp.thefacebook.com> <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZCQ5nRB=jBUxPFyS4OhMvDX1t4ddFYX2LqkepMZg-12w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 15:14:14 -0700
Message-ID: <CAEf4BzZHkVtibiROT=HP1AW1FQm0cJi7AM+CY5FUNnVWBXZkNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
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

On Mon, Aug 1, 2022 at 2:16 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 12:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Aug 01, 2022 at 10:52:14AM -0700, Joanne Koong wrote:
> > > > Since we are on bpf_dynptr_write, what is the reason
> > > > on limiting it to the skb_headlen() ?  Not implying one
> > > > way is better than another.  would like to undertand the reason
> > > > behind it since it is not clear in the commit message.
> > > For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
> > > may be writes that pull the skb, so any existing data slices to the
> > > skb must be invalidated. However, in the verifier we can't detect when
> > > the data slice should be invalidated vs. when it shouldn't (eg
> > > detecting when a write goes into the paged area vs when the write is
> > > only in the head). If the prog wants to write into the paged area, I
> > > think the only way it can work is if it pulls the data first with
> > > bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
> > > the commit message in v2
> > Note that current verifier unconditionally invalidates PTR_TO_PACKET
> > after bpf_skb_store_bytes().  Potentially the same could be done for
> > other new helper like bpf_dynptr_write().  I think this bpf_dynptr_write()
> > behavior cannot be changed later, so want to raise this possibility here
> > just in case it wasn't considered before.
>
> Thanks for raising this possibility. To me, it seems more intuitive
> from the user standpoint to have bpf_dynptr_write() on a paged area
> fail (even if bpf_dynptr_read() on that same offset succeeds) than to
> have bpf_dynptr_write() always invalidate all dynptr slices related to
> that skb. I think most writes will be to the data in the head area,
> which seems unfortunate that bpf_dynptr_writes to the head area would
> invalidate the dynptr slices regardless.

+1. Given bpf_skb_store_bytes() is a more powerful superset of
bpf_dynptr_write(), I'd keep bpf_dynptr_write() in such a form as to
play nicely with bpf_dynptr_data() pointers.

>
> What are your thoughts? Do you think you prefer having
> bpf_dynptr_write() always work regardless of where the data is? If so,
> I'm happy to make that change for v2 :)
>
> >
> > Thinking from the existing bpf_skb_{load,store}_bytes() and skb->data perspective.
> > If the user changes the skb by directly using skb->data to avoid calling
> > load_bytes()/store_bytes(), the user will do the necessary bpf_skb_pull_data()
> > before reading/writing the skb->data.  If load_bytes()+store_bytes() is used instead,
> > it would be hard to reason why the earlier bpf_skb_load_bytes() can load a particular
> > byte but [may] need to make an extra bpf_skb_pull_data() call before it can use
> > bpf_skb_store_bytes() to store a modified byte at the same offset.
