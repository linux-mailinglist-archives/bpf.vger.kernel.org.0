Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3779572A61
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiGMAtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGMAtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 20:49:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE4BD6B2
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 17:49:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j22so17246767ejs.2
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEW+uTd/RBYCxiEUkE6M+XESEKJryNMphRsuANsRi4o=;
        b=myyFuufKVJwZNZw7kHSLirDsnLjUnN5YB8+9hTGF2aJoLxFORXYgRLyclWEbs2LvFb
         P0SWueYq5YWPESW506cEzMLMB+c+dgjhIuUXm6rsomhO6puXsBN8QEjz6zt4Gh0dMROG
         7iMfURdRWsHn2IkoY6Po5hskkTMFOAJ88Kvu9IOk7/+4D86N3b0ffRRAj8TsbqZF9mWw
         5ADLf5zJpAR65JetsKpUJagYz8NPQbZyjvIS2TzpryBYx63ScGGFWQnN3ucmOljBDuhd
         0W2NRePBz0bB3may2uOtrH6vRcDMvr3k9bKn/1ZNwoZn0EA6266HiaHERg9zMUTQb2Cp
         bZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEW+uTd/RBYCxiEUkE6M+XESEKJryNMphRsuANsRi4o=;
        b=nTk7PvctYBPacBq9nwgcQcg4CsiIK5kBLqefyv5GE+zeWgEB8xHP2SfnMtNEy8N1Wq
         1Sqnu4UWdckEVsITFkHcvdKMFLjos7UC+H+Cj3kwK4W3SVn4JGUH/G16zy7IfKdBjyvf
         7KaXIbKFmIMy9/a6ju6/1DNxJrQqdFBiBXmEumczzwfOG9Jyelxx055ev3mJ+HcBDUXp
         uuRV5gthFittHUQdCmL+g0mvXrsQYe9RbnLMPKqSZM3rdZ9TREJq2NxGPw0W7SNMt1eT
         YoScnrt9snXcYQsVPhiGU8a2wTuqVrd51elrA+NBBasIoeO/TyVt7n2++jBxBoGA7hO2
         iVyg==
X-Gm-Message-State: AJIora8hH9w+x59SohKBfE4XbkTgRVPE7n05P8JwTY/0fEG3YfL1rznC
        o6FQ3NcVgXS1iBrstMfNvKrJjtb9atxJ9E3d8JmUgpYf
X-Google-Smtp-Source: AGRyM1v5sSLHRfoyycqQVnfJbg+dcC5pE2dBxhy6QW6ovYGJ6X50KT3a4kJ5cnAGbsk+9R/Q/K8SH5hby7hj9ZL5NBM=
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id
 dd6-20020a1709069b8600b006fed37fb29dmr792085ejc.327.1657673375602; Tue, 12
 Jul 2022 17:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154457.57379-1-laoar.shao@gmail.com> <20220709154457.57379-2-laoar.shao@gmail.com>
 <CALvZod5GfxSpQBZ2Kcbv9afHhjWy+8oEgaNUrSPM7VTdWY464w@mail.gmail.com>
In-Reply-To: <CALvZod5GfxSpQBZ2Kcbv9afHhjWy+8oEgaNUrSPM7VTdWY464w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 17:49:24 -0700
Message-ID: <CAADnVQJvxoteUZdnsoyMQ53Qx1bvyBz=ybQGrsWL9-4R=aasUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Make non-preallocated allocation low priority
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>
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

On Mon, Jul 11, 2022 at 12:19 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sat, Jul 9, 2022 at 8:45 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > easily break the memcg limit by force charge. So it is very dangerous to
> > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > too much memory. There's a plan to completely remove __GFP_ATOMIC in the
> > mm side[1], so let's use GFP_NOWAIT instead.
> >
> > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > too memory expensive for some cases. That means removing __GFP_HIGH
> > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > it-avoiding issues caused by too much memory. So let's remove it.
> >
> > This fix can also apply to other run-time allocations, for example, the
> > allocation in lpm trie, local storage and devmap. So let fix it
> > consistently over the bpf code
> >
> > It also fixes a typo in the comment.
> >
> > [1]. https://lore.kernel.org/linux-mm/163712397076.13692.4727608274002939094@noble.neil.brown.name/
> >
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: NeilBrown <neilb@suse.de>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Applied to bpf-next.
