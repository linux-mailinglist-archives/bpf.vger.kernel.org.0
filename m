Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228FE570A92
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGKTT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 15:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKTT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 15:19:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF4E0D8
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 12:19:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l124so5563798pfl.8
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGhsbgrOdse9F6x0ACAaLskSqS3ovFUrX7+4Tn05BBc=;
        b=VbqQNIJ7oNm70/p7Vv2pDX3Lg1qXKcNUXJKYU85ZVBPtzdtkZTRmF5HM986wBWZ1Xr
         +1aZYSlXK9mJr++7ZM1Y6OsjPkpeGQ7CtcXpYMc/ZBIx2hJri8E++MduFPc5cM0dxhqu
         ZFJasQnixUKypE6z0mkUDz1n6c8Mg26VC/nwTA8PXvtlReBdbi2Sx6kS6ZucPBURq23w
         JZ44FpxsceTXzSYoRoLujG4eVcrRlfr0DpS4DmlwQ6TbEgi3g0LaReLXUCPvFUANvK4u
         j7BulOxJs3kfmlFQw0ZBOPyKFDxvdSBTm8N96VW7YGovw/zpkulTNbp0Ee+wZTbbJxwB
         4Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGhsbgrOdse9F6x0ACAaLskSqS3ovFUrX7+4Tn05BBc=;
        b=GVw7iAI7ABlLMNMT/eR0aLa0mcPf4pfzGOKBhFbeOP/3gTfqmwJUo69FCdT+uma9uT
         XH23Ui7sKnHX3VAtcfc7kZRJG2KB/xSDDw+WldH5RfgKSu2DO7Sag6SIYhqG7zOmjREE
         bt8OigpnYej0/SGN/zTVer3eXjE1tHAyIIcX0eGKQB9jofF951wwCvfNyE4UKGXdSNdz
         PSykWzimWK0QB6qqXWZPt50MTM8fbijiogNDd5TaDVIuBPdoVAcyDnUv0ee/pmqOx5NQ
         iGqKpQ7/FrpOkrozd8HYhwi9zni/AOZ08L+6XkJu9hbBnCmw6pZpzuOt8nZ5oFYVAL8X
         AE/A==
X-Gm-Message-State: AJIora+WocxWf8DyqFwcKz8xSQ3I1jYdrhw9vcNC/Z8Voeol4altbIXp
        1IzD/GGV2l//v4Y+W9gcScfY3yOHUVh3fjnr3UR2KA==
X-Google-Smtp-Source: AGRyM1tdlTXiheowl7wsp9L89MHsalGcSsELsiyAmbWmEoqldeuUja2QlD+rUze/satfSH0yxJx9oT7zRN1L2KmNylg=
X-Received: by 2002:a63:4a59:0:b0:412:8872:83dc with SMTP id
 j25-20020a634a59000000b00412887283dcmr17374282pgl.357.1657567195957; Mon, 11
 Jul 2022 12:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154457.57379-1-laoar.shao@gmail.com> <20220709154457.57379-2-laoar.shao@gmail.com>
In-Reply-To: <20220709154457.57379-2-laoar.shao@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 11 Jul 2022 12:19:45 -0700
Message-ID: <CALvZod5GfxSpQBZ2Kcbv9afHhjWy+8oEgaNUrSPM7VTdWY464w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Make non-preallocated allocation low priority
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org,
        quentin@isovalent.com, Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 9, 2022 at 8:45 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> if we allocate too much GFP_ATOMIC memory. For example, when we set the
> memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> easily break the memcg limit by force charge. So it is very dangerous to
> use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> too much memory. There's a plan to completely remove __GFP_ATOMIC in the
> mm side[1], so let's use GFP_NOWAIT instead.
>
> We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> too memory expensive for some cases. That means removing __GFP_HIGH
> doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> it-avoiding issues caused by too much memory. So let's remove it.
>
> This fix can also apply to other run-time allocations, for example, the
> allocation in lpm trie, local storage and devmap. So let fix it
> consistently over the bpf code
>
> It also fixes a typo in the comment.
>
> [1]. https://lore.kernel.org/linux-mm/163712397076.13692.4727608274002939094@noble.neil.brown.name/
>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: NeilBrown <neilb@suse.de>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
