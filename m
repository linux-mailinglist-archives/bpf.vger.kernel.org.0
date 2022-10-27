Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1961012D
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiJ0TLg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiJ0TLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 15:11:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86E6F56C
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 12:11:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p141so2522295iod.6
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lxj0Z6x9qtnYiW8qXHivi2ryjxdJP7Oq6pB+5oiEQ=;
        b=P0nzLoCDoNJQbDAqKygRlmToZ2jmMmcTka+PuQpHyy971vXWnoKB6EBVkfAn8Pf6FY
         AGBTYI1qKOZCzFFCLmQ+Ru8gXi0d8blTzx8gOROq76mg4i+3asgEsVYrYeQ94aQ9uNaU
         Q3Sf4Q788ilL59l+f5I+dlTdmIgsQnkyCThYyv87CrJuxxS+CXk8jBRSv8cgnZO2fpEL
         daSoPx4FWFJzctl404yiO8LGpIDP/O4MX+Ze232U440xJOIeiouAnLpz1Eg753ykHUFs
         WxNftxTVDpRZ5HRvNzssFEhPbWEW3FOM2nU+Ppdt3HMNv3yNiXQ/aRuQLfDZLgjkO60T
         R2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/lxj0Z6x9qtnYiW8qXHivi2ryjxdJP7Oq6pB+5oiEQ=;
        b=xXVSuwEUrEk8q2jlCTCZzzu4MUZMDn0l3vfNkV/niOu+b1JyCGtiQ+lPT5CBtZRg2g
         uWc0CatqXIsI1NwVvSJQ4LlqCxM+dZmv/N+L6ka4ywLE6Td9uBJ4D1mdLL39MkcnWreb
         AudUEcBQIyvGAwfzjpcTh4Xeay6ZUEKNPYmkYgV3DBQWND4M6FIahwMt5NvYQbIb/tf9
         1498ISt4TV2m5Ob6BTo4vuS063oD/CyQleNvx7T138Em0wJ57CSCqS7yCEdkwwMcdyau
         NB3HBYgVooxJV7daH7TbXqkUHm10uOtbiaVL/Nyyktrteds0CfAb/fI1zPJ/9W4sDEZI
         hUjg==
X-Gm-Message-State: ACrzQf3AXMzShUegYNUe0jtEqbOYxrcn4cpQiuFxQnrvstu84UEbLQJy
        smJ25XwYhp3gL9jric2T25Lj1JQ/XlkNgC8KBvzcGJGwRhwdpg==
X-Google-Smtp-Source: AMsMyM5S2eE6J0pohx7Vb7yGguobiGXH1ElDewoiAgqO3tsZaBzbz6owjiH0Q9RnF4483+S86fd9Mh3MHz3WqISq1cI=
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr29305229ion.186.1666897893099; Thu, 27
 Oct 2022 12:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
 <CAKH8qBu7OXptKF46SQSEfueKXRUkBxix3K0qmucgREP4h_rQJQ@mail.gmail.com>
 <41284964-123d-704b-2802-24a857a7a989@linux.dev> <CAKH8qBsNZL0YrML5duNebqjMXtBDnB6L05zsMHCe==-UcRa9JA@mail.gmail.com>
 <1d37564e-cf00-a1ea-a0b2-817b439734a3@linux.dev> <CAKH8qBtvqVz3wJu-g5+DH0fEpauy8Dc+Zh-UQL==TEhDUv-wSA@mail.gmail.com>
 <81d70549-9d58-45a0-568c-3286c2cc0dce@linux.dev>
In-Reply-To: <81d70549-9d58-45a0-568c-3286c2cc0dce@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 27 Oct 2022 12:11:22 -0700
Message-ID: <CAKH8qBugeyM2mZ7BaB8wh=Ft8QkUey7HoYSc6msM+JYkSek9gA@mail.gmail.com>
Subject: Re: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen > PAGE_SIZE
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf <bpf@vger.kernel.org>
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

On Thu, Oct 27, 2022 at 11:48 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/27/22 10:40 AM, Stanislav Fomichev wrote:
> > On Thu, Oct 27, 2022 at 10:29 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 10/27/22 9:23 AM, Stanislav Fomichev wrote:
> >>> On Wed, Oct 26, 2022 at 11:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>
> >>>> On 10/26/22 7:03 PM, Stanislav Fomichev wrote:
> >>>>> On Wed, Oct 26, 2022 at 6:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>>>
> >>>>>> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
> >>>>>> The bpf prog usually just handles a few specific optnames and ignores most
> >>>>>> others.  For the optnames that it ignores, it usually does not need to change
> >>>>>> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
> >>>>>> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
> >>>>>> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
> >>>>>> because the bpf prog only expects error returning to userspace when it has
> >>>>>> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
> >>>>>> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
> >>>>>> prog in the same cgroup may want to change/look-at it.
> >>>>>>
> >>>>>> Would like to explore if there is an easier way for the bpf prog to handle it.
> >>>>>> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
> >>>>>> before returning -EFAULT to the user space when ctx.optlen > max_optlen?
> >>>>>
> >>>>> Good point on chaining being broken because of this requirement :-/
> >>>>>
> >>>>> With tracking, we need to be careful, because the following situation
> >>>>> might be problematic:
> >>>>> Suppose setsockopt is larger than 4k, the program can rewrite some
> >>>>> byte in the first 4k, not touch optlen and expect this to work.
> >>>>
> >>>> If the bpf prog rewrites the first 4k, it must change the ctx.optlen to get it
> >>>> work.  Otherwise, the kernel will return -EFAULT because the ctx.optlen is
> >>>> larger than the max_optlen (or optval_end - optval).
> >>>>
> >>>>> Currently, optlen=0 explicitly means "ignore whatever is in the bpf
> >>>>> buffer and use the original one" > If we can have a tracking that catches situations like this - we
> >>>>> should be able to drop that optlen=0 requirement.
> >>>>> IIRC, that's the only tricky part.
> >>>>
> >>>> Ah, I meant, in __cgroup_bpf_run_filter_setsockopt, use "!ctx.optlen_changed &&
> >>>> ctx.optlen > max_optlen" test to imply "ignore whatever is in the bpf
> >>>> buffer and use the original one".  Add 'bool optlen_changed' to 'struct
> >>>> bpf_sockopt_kern' and set ctx.optlen_changed to true in
> >>>> cg_sockopt_convert_ctx_access() whenever there is BPF_WRITE to ctx.optlen.
> >>>> Would it work or may be I am still missing something in the writing first 4k
> >>>> case above?
> >>>
> >>> What if the program wants to keep optlen as is? Here is the
> >>> hypothetical case: ctx->optlen is 8k, we allocate/expose only the
> >>> first 4k, the program does ctx->optval[0] = 0xff and doesn't change
> >>> the optlen. It wants the rest of the payload to be passed as is with
> >>> only the first byte changed.
> >>
> >> I think we are talking about the same case but we may have different
> >> understanding on how the current __cgroup_bpf_run_filter_setsockopt() is
> >> handling it.
> >>
> >> I don't see the current kernel supports this now.  If the bpf prog does not
> >> change the ctx->optlen from 8k to something that is <= 4k, the kernel will just
> >> return -EFAULT in here, no?
> >>          else if (ctx.optlen /* 8k */ > max_optlen /* 4k */ || ctx.optlen < -1) {
> >>                  /* optlen is out of bounds */
> >>                   ret = -EFAULT;
> >>           }
> >>
> >> or you meant the future change needs to consider this new case and also support
> >> gluing the first 4k (that was exposed to the bpf prog) with the second 4k (that
> >> was not exposed to the bpf prog)?
> >>
> >>> The condition "!ctx.optlen_changed && ctx.optlen > max_optlen" is
> >>> true, so, if we treat this as explicit optlen=0, we ignore the
> >>> program's changes.
> >>> But this is not what the program has intended, right? It wants to
> >>> amend something and pass the rest as is.
> >
> > Right, I'm not talking about how it's handled now. Now optlen >
> > max_optlen triggers EFAULT.
> > But in the future, if we add tracking, we want 'optlen > max_optlen'
> > to behave as explicit 'optlen = 0' as long as the user hasn't changed
> > the optlen _and_ also hasn't changed anything in the buffer.
>
> Ah, ic.
>
> Tracking the runtime buffer change will be hard as of the current state through
> the ctx->optval.  I don't think we need to track that either.  If the existing
> bpf prog wants the changed buf to be used, it must have changed the optlen
> already.  Thus, tracking optlen only should be as good.

I might be still missing something on why tracking optlen is enough?

Consider this BPF program:

SEC("cgroup/setsockopt")
int _setsockopt(struct bpf_sockopt *ctx)
{
    __u8 *optval_end = ctx->optval_end;
    __u8 *optval = ctx->optval;

    if (optval + 1 > optval_end) return 0;

    optval[0] = 0xff;
    return 1;
}

And the userspace doing the following:

__u32 buf[4096*2] = {};
ret = setsockopt(fd, SOME_LEVEL, SOME_OPTLEN, &buf, sizeof(buf));

Right now, without explicit 'optlen = 0' in the BPF program, we'll get
-1/EFAULT here (unarguably, this is a bad interface, but still better
than ignoring program's buf?).
If we track only optlen in the program, we'd get success, but the
changed buffer will be ignored by the kernel. (what am I missing
here?)

> If the bpf prog is depending on the kernel to do implicit -EFAULT like this,
> yes, it will break even the buffer change is tracked.
>
> if (ctx->optlen > ctx->optval_end - ctx->optval)
>      return 1;  /* 0 will be -EPERM, so 1 here to make kernel return -EFAULT for
> us */

[..]

> I would argue that it is more like a surprise than a feature if the bpf prog
> depends on ctx.optlen > max_optlen (only for the > 4k case though) to do an
> implicit reject (through EFAULT) instead of directly using the 'return 0' or
> bpf_set_retval() which is exactly how it should be done to reject other "normal"
> integer optval.

That all comes from the issue above. We want to have a contract with
the bpf program: when optlen>4k, it has to do something with the
optlen (set it to 0 to ignore, set it to <4096 to pass to the kernel).
It can't just change something in the 4k of the exposed buffer and
assume this data will be passed to the kernel.

> I am also not sure how useful it is to expose partial data to the bpf prog and
> have a way for the bpf prog to tell the kernel to join the remaining.  Instead,
> it would be more useful to have API for the bpf prog to have access to the whole
> data instead.

That seems like a better way to go? We didn't do that initially
because the data is in the __user memory and we can't pass it to bpf;
we had to do this extra copy/allocation :-( I think we decided against
copying everything because this can be abused due to no sane limit on
the setsockopt value size. Nothing prevents userspace from passing a
huge buffer when doing, say, SO_MARK; the kernel will read the first
int and be happy with it.

> >>> It seems like we need to have both optlen_changed and optval_changed.
> >>> If both are false, we should be able to safely do optlen=0 equivalent.
> >>> Tracking only optlen seems to be problematic?
> >>
>
