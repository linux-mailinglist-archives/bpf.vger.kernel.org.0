Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DDF569FE7
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 12:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiGGK2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiGGK2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 06:28:36 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554F2F64E
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 03:28:35 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id r184so1856163vkg.9
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jEVdpbvqQRSNIv0th7cTYiMXpo4mnpeXk5Jx9vXc6A=;
        b=c6SGCzZUWXWpcQ/dc2iZFuXm7QnCRInKAoYhk4Xln25UlRThSvkhHl2OogHcqXcmsF
         uZdcXwd8rn7qqgA9A6XbbEGFnhj9q6jwYx2NKWHYMVVnDQ+igRyzV1o1JuxQxkbWSyUp
         jCg5W5nnDUM5J/LF/v09sKXfwIjaRk7L4AzfQsoXhv2JqU1XO/qOpT9uhnJkFijdJrZf
         tmsvwL4mDGjUIALs/jyhbr2MvrZrhF+SC7drgWztn2hMCOAlCp4exYDUbpEZGTFXYXw5
         s/6/WI8QjelD/w9Ja0DoiCzZXkfWIcZ0d7ezmt1auPev1BTRI5Tl3FxbxyinPKg/iq/i
         e26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jEVdpbvqQRSNIv0th7cTYiMXpo4mnpeXk5Jx9vXc6A=;
        b=10C60OlK6CnLxHMUFgECGmnJbtTCm8yGRuEW5pLMpUmDcyHZwKVF9Y0zd/1Iy6rzY2
         7UZcS9NsTZgeD7fGhXDeZUpakkAaspU1oSRGu9y8tpgwHqAppjtn3hiKK/TBN8ZDbcmR
         m22bSv+0wzTwkeiIKfyeb1K0badJ9+6EIeTrGJuLNMuHuy9qwTS8RvAQXWYx/tdFCDxh
         9AOdCAIC9uWuTZvMnIJvFr0hgw7AYh9CHctqoILeGtPUfxqBah3v7XkFILXgtBYYJS1I
         H2Fx2CKW661OBYm7ZbdLH9Oo6NvL9pqXsBKstWutDwkD4eSQ9eDTdrKHX7LfFpv1VCy2
         n0cg==
X-Gm-Message-State: AJIora+LBezih1jUBzBAvWS0KOZMElnVEFJdlhMtE4m3e6QHGAbxZD74
        9sZ6VhBlbQt0zs4UxAgo9xSMAsh0v5uUTpVGvlQ=
X-Google-Smtp-Source: AGRyM1tBtowXYd5lLM+Pntndrj091k2gteG2hyYSLebqnYBWJJFmiE+1vjRbe6ECBC7bfQjZ554a+jYwNnZaRPsUjYA=
X-Received: by 2002:ac5:ccc1:0:b0:374:61a7:e99f with SMTP id
 j1-20020ac5ccc1000000b0037461a7e99fmr307279vkn.14.1657189714511; Thu, 07 Jul
 2022 03:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com>
In-Reply-To: <20220707000721.dtl356trspb23ctp@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Jul 2022 18:27:57 +0800
Message-ID: <CALOAHbC4RG_G2wjU0Nj_A9MhrHiQ7GXR7Yp7BCr+7dDmXwR-4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
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

On Thu, Jul 7, 2022 at 8:07 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > easily break the memcg limit by force charge. So it is very dangerous to
> > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > too much memory.
>
> Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> already have a patch for that.
>

After reading the discussion[1], it looks good to me to use GFP_NOWAIT
instead. I will update it.

[1]. https://lore.kernel.org/linux-mm/163712397076.13692.4727608274002939094@noble.neil.brown.name/

> >
> > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > too memory expensive for some cases. That means removing __GFP_HIGH
> > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > it-avoiding issues caused by too much memory. So let's remove it.
> >
> > The force charge of GFP_ATOMIC was introduced in
> > commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> > __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> > commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> > checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> > __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> > we have to carefully verify all the callsites. Now that we can fix it in
> > BPF, we'd better not modify the memcg code.
> >
> > This fix can also apply to other run-time allocations, for example, the
> > allocation in lpm trie, local storage and devmap. So let fix it
> > consistently over the bpf code
> >
> > __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> > currently. But the memcg code can be improved to make
> > __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> >
>
> IMO there is no need to give all this detail and background on
> GFP_ATOMIC and __GFP_KSWAPD_RECLAIM. Just say kernel allows GFP_ATOMIC
> allocations to exceed memcg limits which we don't want in this case. So,
> replace with GFP_NOWAIT which obey memcg limits. Both of these flags
> tell kernel that the caller can not sleep.
>

Sure, thanks.

-- 
Regards
Yafang
