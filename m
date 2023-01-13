Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFE668952
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 03:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAMCD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 21:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjAMCD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 21:03:56 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92536621B2
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 18:03:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vm8so49066194ejc.2
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 18:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uU88unDcev3UQbDRH/4SIeYNT+yJwUor6ZA5gpr7d2k=;
        b=FHkn7m8Q76iYS9nACyGC0N3Q9AseOPgnbH+vCHo40/lbwYwBEWNoWEOerTCXgyyKBR
         oBS5P8lsSbbSLV1FTEhawq5N/+2TMKZhWB4ONFDvxPT1lXwdMMMu0zlqfc7lktZCfRXO
         Qd5je85Li144QL3O9iwyM+LlSv0Q9PLUKpaQYI8AsjG1+mxxIh8MQYiRzMtmGUyrD3J3
         SER+nVk1zdqi3sAfDOCsnk/T98kxtx68Z2i/YpBof18D6LkSrAwpufIszE7G7Ub3a9d4
         W8cohon5WnGF/++fAteWEkRxw7mdxmFkjHYF0ZErQ9e7IPouXXXdwr7+Wx17YGbDnbJf
         voYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU88unDcev3UQbDRH/4SIeYNT+yJwUor6ZA5gpr7d2k=;
        b=T/ATjLDOTHeEbGH55bR6tZYv6chFYzuXjvbxJjLxL9n2BbZSupg+c7LWpEzkxOlQjb
         GQpTnv/6OafnsxrE1c/4bPHVpmR6rcwn0uSiqu82rBGQLsolauc9IR3v3OZFTe3kz4Ho
         hPNGO918cc4P46oYpVAmzBJssXbrSXcfhQIhGG0w2u4v59vcDCs4R7IORfbN3+Qv0Tyn
         bNXDT3T7N+bFAHVr20SzLL4Z6HUOmV/mg5rbD6ViDZSbC0d5QM6r4zA7iQzB375pzavU
         94tnWpqE0qVeNhOu6pJcmU13I+uqXeTEeWfmHUvh+qoeM273/XIbO6/HtY/R7KgLErJf
         FdVw==
X-Gm-Message-State: AFqh2koXbc7gvZkEvD/TYCLWSJX4a7CjXLvDjSvVm3MSLTZDf6t9ShfT
        NcvSyXbbFyBOFeU56zf/LXbfgjVl9McB44lKLjY=
X-Google-Smtp-Source: AMrXdXvzcGmiMcD8mHLJKDISJWmQ6IVpRG2lA7PNDAo53FT1L1vFObp6P2EJ3X5cX2a0Uh38/CC9xbAC0ObawzsvMhI=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr5478622ejy.327.1673575433010; Thu, 12
 Jan 2023 18:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20230111092903.92389-1-tong@infragraf.org> <20230111092903.92389-3-tong@infragraf.org>
 <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
In-Reply-To: <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Jan 2023 18:03:41 -0800
Message-ID: <CAADnVQKobWCZ==027dVB8XrUr9Fa3-WhBM_6-QE_d8FOKXt2Kg@mail.gmail.com>
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     tong@infragraf.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>
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

On Thu, Jan 12, 2023 at 5:53 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/11/23 1:29 AM, tong@infragraf.org wrote:
> > +     /*
> > +      * The lock may be taken in both NMI and non-NMI contexts.
> > +      * There is a false lockdep warning (inconsistent lock state),
> > +      * if lockdep enabled. The potential deadlock happens when the
> > +      * lock is contended from the same cpu. map_locked rejects
> > +      * concurrent access to the same bucket from the same CPU.
> > +      * When the lock is contended from a remote cpu, we would
> > +      * like the remote cpu to spin and wait, instead of giving
> > +      * up immediately. As this gives better throughput. So replacing
> > +      * the current raw_spin_lock_irqsave() with trylock sacrifices
> > +      * this performance gain. atomic map_locked is necessary.
> > +      * lockdep_off is invoked temporarily to fix the false warning.
> > +      */
> > +     lockdep_off();
> >       raw_spin_lock_irqsave(&b->raw_lock, flags);
> > -     *pflags = flags;
> > +     lockdep_on();
>
> I am not very sure about the lockdep_off/on. Other than the false warning when
> using the very same htab map by both NMI and non-NMI context, I think the
> lockdep will still be useful to catch other potential issues. The commit
> c50eb518e262 ("bpf: Use separate lockdep class for each hashtab") has already
> solved this false alarm when NMI happens on one map and non-NMI happens on
> another map.
>
> Alexei, what do you think? May be only land the patch 1 fix for now.

Agree. I have the same concerns with patch 3: it may silence too much.
