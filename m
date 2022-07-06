Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12B568F94
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiGFQrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiGFQrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 12:47:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D27286C0
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 09:47:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m16so4532434edb.11
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxZ1uVRXPYMhnqF7XQQhd8OulBR+8nYW/g9JzEVE+2A=;
        b=k84o+gSYpbG00hZ0Mg7hBS89md6qUTbgQvj0lOchOx0QXCQ2VRSPyiVY722TcScGwT
         Rbre9J+hNmDz93rIeAfbyaXvcuUq/uOnxQbRwTxWMlQMAHnEbd+Uc30vzcXZ4YT1zDvu
         mPz5+WtSbyJQIOQR8pSErdztxpXWa6I1CBlIURs3PqouCI9BbR0Mn5uq/GFBVplTDse2
         k0jSGeESbJVSfspWxCZWng/KL4bXagp9S537es5h81Z64LWa0Ac1nEn08BewMBbbjI7t
         bsE32uOWuYiPWaVa+0go11kPanGTtMXw/48B8v6xTCO+XppsM3mdxmYmYdzHRbx2mY+k
         tV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxZ1uVRXPYMhnqF7XQQhd8OulBR+8nYW/g9JzEVE+2A=;
        b=bh4tAlS0PNFFwUzfjeDid0Y9xIGimkuyB4jjMfBvUfGwAYVz5Qh++c2DkbxiZzFMsy
         MxdbJNo6Pi/wWkeoUNVVEFqCOjzFsnG+GZOqp9pYaLrhcmcQhTf3itjieBdCyumutav2
         HBwYeZi6Zt2n08UbF+1s04TqMpAdH8NMIfvsXJktyZ5DrB/Khjxujhs6kuwSVj5ZHfAr
         qgOb1A9Ae+7Wz6sYfSlK7Ls5rdX9VQVuA9U4ir8tg2c513kaO0sOw/137CrIIArEu8Ad
         hX3mT/Bwm7MCiM+gGEsqfwvlfw3vHR+kfUqBUTcC6/E96qTX4S84xC/+dBkytMAKStw8
         p23g==
X-Gm-Message-State: AJIora9GGD6FAgxiR/PpY88Iug/VRKk3RPbEnPepGkperD9wupUfReGw
        mwU0/Hnuw8FugEH/dHLysasjRkEPMXixj6zZakM=
X-Google-Smtp-Source: AGRyM1uifLnZXFC7DxjlD78F9165GHQ8KEcrLdeXZl+UM2dlqrrC6sbikjqBdb0xh37CNTXQHwD9i0bAsPPcTnn3hWQ=
X-Received: by 2002:a05:6402:51ce:b0:436:7dfc:4840 with SMTP id
 r14-20020a05640251ce00b004367dfc4840mr56163241edd.338.1657126064703; Wed, 06
 Jul 2022 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
In-Reply-To: <20220706155848.4939-2-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 09:47:32 -0700
Message-ID: <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> if we allocate too much GFP_ATOMIC memory. For example, when we set the
> memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> easily break the memcg limit by force charge. So it is very dangerous to
> use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> too much memory.
>
> We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> too memory expensive for some cases. That means removing __GFP_HIGH
> doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> it-avoiding issues caused by too much memory. So let's remove it.
>
> The force charge of GFP_ATOMIC was introduced in
> commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> we have to carefully verify all the callsites. Now that we can fix it in
> BPF, we'd better not modify the memcg code.
>
> This fix can also apply to other run-time allocations, for example, the
> allocation in lpm trie, local storage and devmap. So let fix it
> consistently over the bpf code
>
> __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> currently. But the memcg code can be improved to make
> __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.

Could you elaborate ?

> It also fixes a typo in the comment.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Roman, do you agree with this change ?
