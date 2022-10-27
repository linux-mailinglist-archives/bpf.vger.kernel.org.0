Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409D60FF7E
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiJ0RlN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiJ0RlG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 13:41:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4963865
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 10:41:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id q5so1450009ilt.13
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AsUeU8BoSnAy5qgT7dPRtnG60BIPnFXMJoLmBkQyYaM=;
        b=kp71sjKD5zSY29zlxdpOK7ytGztJEmWOjXmg7l2WX7bn6knPB/4hDkAFpw6o1ivocq
         ttTutaiigmTQ1TAuu33fhqvbkb/bK2VV/WWRkWhp+u4M+eDfH/VGXzxfCnYA8DXVE3b5
         V5Pq83j5HqnIZLehXYyQZ1XLbzwE3KhEQgeSKMnbYk85cdyj7vSI6DJ3oRYI8FODed36
         M4WuwkUPhkVtWpWtTxLycwyA/VGoGvTpIltKcXN4Wwj/RTYmYdfmWUKsWr2E2XFaBqcp
         gK1Qbzil+gvs4PskF1utc/OEYGoyj1FlqWjS6UFMBYu1TCui0lf7al7t4jPk5SZqkdXF
         Kv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsUeU8BoSnAy5qgT7dPRtnG60BIPnFXMJoLmBkQyYaM=;
        b=wwjYwu1wIm7AFmxaeyST7J6/Xhyv2LccV9IqgakboQE2j3gn9VSqeHq+c1AIFtTIFd
         eV+g57pRej4o7Vpqeqg2vA+o6X3E/6hjqbmn46Dqs1QhQLxksQSoOtLhWWPiEFK6gznP
         9ZTaX9j4+Kz/ltpG6Ge8ShQHiGyNYeRZqpbTZWhQzjS4WYcOZlNQIgyg6BjeJapQUMbW
         pZIAePuL9160lN3khU1mPdxDzXGZ2X28V6Ka0PESpaXzMthFPreK/kxZ18sldj/6/gb5
         U9w+39VkG755hX+ST05aWnTzdgh8jRsXL69rVP1tl+MD3iAGL+q4SYj7VP/X9VvQqBjp
         fhBQ==
X-Gm-Message-State: ACrzQf34Ry7++Pr4zBjM43vYj6PLrncA8Hlk7zYIaeI8M8Mx3ItFlgxs
        qBq6OzSgbty3YbDQDHyrJGdLCNB3pjzNjP5uT33Q3VJ5M5w=
X-Google-Smtp-Source: AMsMyM5akMVr5Qls8CVhVkwaVYftTVtLEYwwZPB3ZCHSyZg0YbTkYPovrgEF9DHcvEnSH8ArU8gXOYUVsaPpN9Oz/NU=
X-Received: by 2002:a92:db03:0:b0:300:5dc4:d111 with SMTP id
 b3-20020a92db03000000b003005dc4d111mr6257919iln.257.1666892460241; Thu, 27
 Oct 2022 10:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
 <CAKH8qBu7OXptKF46SQSEfueKXRUkBxix3K0qmucgREP4h_rQJQ@mail.gmail.com>
 <41284964-123d-704b-2802-24a857a7a989@linux.dev> <CAKH8qBsNZL0YrML5duNebqjMXtBDnB6L05zsMHCe==-UcRa9JA@mail.gmail.com>
 <1d37564e-cf00-a1ea-a0b2-817b439734a3@linux.dev>
In-Reply-To: <1d37564e-cf00-a1ea-a0b2-817b439734a3@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 27 Oct 2022 10:40:49 -0700
Message-ID: <CAKH8qBtvqVz3wJu-g5+DH0fEpauy8Dc+Zh-UQL==TEhDUv-wSA@mail.gmail.com>
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

On Thu, Oct 27, 2022 at 10:29 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/27/22 9:23 AM, Stanislav Fomichev wrote:
> > On Wed, Oct 26, 2022 at 11:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 10/26/22 7:03 PM, Stanislav Fomichev wrote:
> >>> On Wed, Oct 26, 2022 at 6:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>
> >>>> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
> >>>> The bpf prog usually just handles a few specific optnames and ignores most
> >>>> others.  For the optnames that it ignores, it usually does not need to change
> >>>> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
> >>>> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
> >>>> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
> >>>> because the bpf prog only expects error returning to userspace when it has
> >>>> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
> >>>> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
> >>>> prog in the same cgroup may want to change/look-at it.
> >>>>
> >>>> Would like to explore if there is an easier way for the bpf prog to handle it.
> >>>> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
> >>>> before returning -EFAULT to the user space when ctx.optlen > max_optlen?
> >>>
> >>> Good point on chaining being broken because of this requirement :-/
> >>>
> >>> With tracking, we need to be careful, because the following situation
> >>> might be problematic:
> >>> Suppose setsockopt is larger than 4k, the program can rewrite some
> >>> byte in the first 4k, not touch optlen and expect this to work.
> >>
> >> If the bpf prog rewrites the first 4k, it must change the ctx.optlen to get it
> >> work.  Otherwise, the kernel will return -EFAULT because the ctx.optlen is
> >> larger than the max_optlen (or optval_end - optval).
> >>
> >>> Currently, optlen=0 explicitly means "ignore whatever is in the bpf
> >>> buffer and use the original one" > If we can have a tracking that catches situations like this - we
> >>> should be able to drop that optlen=0 requirement.
> >>> IIRC, that's the only tricky part.
> >>
> >> Ah, I meant, in __cgroup_bpf_run_filter_setsockopt, use "!ctx.optlen_changed &&
> >> ctx.optlen > max_optlen" test to imply "ignore whatever is in the bpf
> >> buffer and use the original one".  Add 'bool optlen_changed' to 'struct
> >> bpf_sockopt_kern' and set ctx.optlen_changed to true in
> >> cg_sockopt_convert_ctx_access() whenever there is BPF_WRITE to ctx.optlen.
> >> Would it work or may be I am still missing something in the writing first 4k
> >> case above?
> >
> > What if the program wants to keep optlen as is? Here is the
> > hypothetical case: ctx->optlen is 8k, we allocate/expose only the
> > first 4k, the program does ctx->optval[0] = 0xff and doesn't change
> > the optlen. It wants the rest of the payload to be passed as is with
> > only the first byte changed.
>
> I think we are talking about the same case but we may have different
> understanding on how the current __cgroup_bpf_run_filter_setsockopt() is
> handling it.
>
> I don't see the current kernel supports this now.  If the bpf prog does not
> change the ctx->optlen from 8k to something that is <= 4k, the kernel will just
> return -EFAULT in here, no?
>         else if (ctx.optlen /* 8k */ > max_optlen /* 4k */ || ctx.optlen < -1) {
>                 /* optlen is out of bounds */
>                  ret = -EFAULT;
>          }
>
> or you meant the future change needs to consider this new case and also support
> gluing the first 4k (that was exposed to the bpf prog) with the second 4k (that
> was not exposed to the bpf prog)?
>
> > The condition "!ctx.optlen_changed && ctx.optlen > max_optlen" is
> > true, so, if we treat this as explicit optlen=0, we ignore the
> > program's changes.
> > But this is not what the program has intended, right? It wants to
> > amend something and pass the rest as is.

Right, I'm not talking about how it's handled now. Now optlen >
max_optlen triggers EFAULT.
But in the future, if we add tracking, we want 'optlen > max_optlen'
to behave as explicit 'optlen = 0' as long as the user hasn't changed
the optlen _and_ also hasn't changed anything in the buffer.

> > It seems like we need to have both optlen_changed and optval_changed.
> > If both are false, we should be able to safely do optlen=0 equivalent.
> > Tracking only optlen seems to be problematic?
>
