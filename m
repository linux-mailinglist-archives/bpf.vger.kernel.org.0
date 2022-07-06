Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A9569513
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 00:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiGFWMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiGFWMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 18:12:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3C2A430
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 15:11:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so29308696ejj.12
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2seMBdUCNd9lkwUpWfSizm/4BlRcABqRSozYyXF50E=;
        b=ZfwpTK03Wo4ML6HpI6A3X8CcNFeMmO4AEmA4QWmrwEHZ0VoyWyLjjbCRUNSlDn8vPl
         NVsI3KYRKbhBx0fPkrTQC4g7eZSh8QGubOH1H8cta/ogwn2NeggVrsnBu9sv+9Qi5Sms
         w3sS6L53aF1VXpUKHOOpcbv1+gd0zFp8+p5QCNIk3GOre1mX+BuTKAMbVo7DQeq8e+Bd
         ZD3u7Yf0YNeM3nGs57IH+bvK7GyHSzPgrWS+HHyBDvN/9R1tbKArX3ClV8TAMXiEbFsX
         cKcS5YQJ63zamuiuO8UelLro30FvQA94LT9L/qw1h6uf8CC9vZU/2dG4VwThTsy5d/e5
         XzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2seMBdUCNd9lkwUpWfSizm/4BlRcABqRSozYyXF50E=;
        b=NRiBNNfBjsR+sV/Wdqik+ggApoxumx4f9AK/NZ4ZoeiAnT4DftMSqOpZ/9OEbgA0XF
         1OWQjaRwGc0LN7D8aTC0bECkyvgvszVtASxywo0MZsUDsaKoOBNln4WCOTDhe7ge9JHG
         ISQbxSkA6elIRjdfyhGAynj48TcDCZQ4J2EYXy72/zmHfdmO7i16Lo0GJfE/APDZXHq+
         +9L68egOGGP48lZRnxxNYPeB90jf7JWa7HSEpJyr+T3Zv3jBln+YmxgN/UbvYZqI6/Wp
         wXfM+R9PkVBN8WP+y2t1e9vlGWxGV3z0suKQgAvmWG1atc9orP0pamFW/z2XQ5cBmMBU
         q2FQ==
X-Gm-Message-State: AJIora9mU5TuG6ogzrLQ60RyX5ILMMnAN9IUnYs+LJmnE72eXZLNvtyy
        fbJkHlLscsSsaohpVcmUDVah9zxNQfSavPR/3aI=
X-Google-Smtp-Source: AGRyM1uuHUKmzMHU/3+birBCRNj94wTTZv/olVbyjxU+t348hHCDIcHEzGXwXDCd0+FDcT1chOQNADVsyL/3lGicqIA=
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id
 p6-20020a170906614600b00722f8c4ec9bmr43656408ejl.708.1657145517968; Wed, 06
 Jul 2022 15:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com> <YsXd2Tah+irhth9t@castle>
In-Reply-To: <YsXd2Tah+irhth9t@castle>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 15:11:46 -0700
Message-ID: <CAADnVQ+c_2Q6GxH3E0iD0RkOy2H2-UhuYL4V3v2BTQ6sZNxQAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

On Wed, Jul 6, 2022 at 12:09 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Jul 06, 2022 at 09:47:32AM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > easily break the memcg limit by force charge. So it is very dangerous to
> > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > too much memory.
> > >
> > > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > > too memory expensive for some cases. That means removing __GFP_HIGH
> > > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > > it-avoiding issues caused by too much memory. So let's remove it.
> > >
> > > The force charge of GFP_ATOMIC was introduced in
> > > commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> > > __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> > > commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> > > checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> > > __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> > > we have to carefully verify all the callsites. Now that we can fix it in
> > > BPF, we'd better not modify the memcg code.
> > >
> > > This fix can also apply to other run-time allocations, for example, the
> > > allocation in lpm trie, local storage and devmap. So let fix it
> > > consistently over the bpf code
> > >
> > > __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> > > currently. But the memcg code can be improved to make
> > > __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> >
> > Could you elaborate ?
> >
> > > It also fixes a typo in the comment.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > Roman, do you agree with this change ?
>
> Yes, removing __GFP_HIGH makes sense to me. I can imagine we might want
> it for *some* bpf allocations, but applying it unconditionally looks wrong.

Yeah. It's a difficult trade-off to make without having the data
to decide whether removing __GFP_HIGH can cause issues or not,
but do you agree that __GFP_HIGH doesn't cooperate well with memcg ?
If so it's a bug on memcg side, right? but we should probably
apply this band-aid on bpf side to fix the bleeding.
Later we can add a knob to allow __GFP_HIGH usage on demand from
bpf prog.
