Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C460FCFE
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiJ0QYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiJ0QYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 12:24:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD8192B8F
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 09:23:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p184so1965320iof.11
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nc5Y/XzFUKnUSi/b7mjany2KRDS6a+xSXsnXqLv27T8=;
        b=icUmqWU8qf73kN6g+hN5oPITiQVubfKn8PiYpRhMyeH/wK8vgO+I6VkIV0Yetlkguj
         RNldjPWaJ7XbK+hNIKyJhuSbCN+DqiYjprJai1m8KKGR0rugIsNQpUTqLdwzrnibxiju
         p+3fujJ0AQukvBa2khFVSbiSRoWFxaEhjbbOzYz3TEY0pzTm2dvhy56YQXHLUzs0iq+e
         YtN2vyiU3Ox9DX2sV5tQnUvvTLugBefC8au4skGr06I+8908ue+iwqBIYUNK4V3IkHKr
         yKdBe00pKg/M2u8c9uLrAeMV5kP0PGOfEGKB5GTVZGrPijAQKms2/0UWR+wm4azEOG4P
         +AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc5Y/XzFUKnUSi/b7mjany2KRDS6a+xSXsnXqLv27T8=;
        b=7CRNr7zu+vuP6ztjY1oQtMT2Xbxv5Xee5YPVJ62qU9kgxnuFHSo6Z661dagybOGZmO
         eCPo2MfHdDSaplN4Z4qNRqcAr0HfqMoZ2z8oa0CVcea4IUnwLtxxQl5V093r2Pkumt0Y
         phk36r9+tLTI1y3LrAd+9UAZiZFJRftD0TxourrldECWnTRlMHTR3u3kZrO+OW2sbX/B
         17ot2OiYK9p4/UB0O2iNLPyaLpiCX0M/VPJNv/ndHqcZhmVKXgZjuBsB9icJNwp4q8ya
         S57RD8vF5AwYR/15HXWxsxJ4c2n6pTKR0zHJmVkX6ByBliRIbXqMgqBKmzIPU1+A4DU2
         zPUA==
X-Gm-Message-State: ACrzQf0A0ZrD8Xzur7BvDYes0NC4skGfOz6EAtjKRO4vLQ6EmmZuWPQY
        dz+XNRHkygHcahGT3v/EfqF/y9RBo15RTGWoPa7sRMut2JL60Q==
X-Google-Smtp-Source: AMsMyM7Rudle7J1oMt6TpG0P4ouD5T9eakM/tJV3DTCX0F08DFATxrvJJCYaSdzKh1cMdTcjEpXlj5YCsRRRn/qVL0Q=
X-Received: by 2002:a05:6638:19c4:b0:363:afc3:b403 with SMTP id
 bi4-20020a05663819c400b00363afc3b403mr34140974jab.144.1666887798780; Thu, 27
 Oct 2022 09:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
 <CAKH8qBu7OXptKF46SQSEfueKXRUkBxix3K0qmucgREP4h_rQJQ@mail.gmail.com> <41284964-123d-704b-2802-24a857a7a989@linux.dev>
In-Reply-To: <41284964-123d-704b-2802-24a857a7a989@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 27 Oct 2022 09:23:07 -0700
Message-ID: <CAKH8qBsNZL0YrML5duNebqjMXtBDnB6L05zsMHCe==-UcRa9JA@mail.gmail.com>
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

On Wed, Oct 26, 2022 at 11:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/26/22 7:03 PM, Stanislav Fomichev wrote:
> > On Wed, Oct 26, 2022 at 6:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
> >> The bpf prog usually just handles a few specific optnames and ignores most
> >> others.  For the optnames that it ignores, it usually does not need to change
> >> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
> >> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
> >> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
> >> because the bpf prog only expects error returning to userspace when it has
> >> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
> >> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
> >> prog in the same cgroup may want to change/look-at it.
> >>
> >> Would like to explore if there is an easier way for the bpf prog to handle it.
> >> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
> >> before returning -EFAULT to the user space when ctx.optlen > max_optlen?
> >
> > Good point on chaining being broken because of this requirement :-/
> >
> > With tracking, we need to be careful, because the following situation
> > might be problematic:
> > Suppose setsockopt is larger than 4k, the program can rewrite some
> > byte in the first 4k, not touch optlen and expect this to work.
>
> If the bpf prog rewrites the first 4k, it must change the ctx.optlen to get it
> work.  Otherwise, the kernel will return -EFAULT because the ctx.optlen is
> larger than the max_optlen (or optval_end - optval).
>
> > Currently, optlen=0 explicitly means "ignore whatever is in the bpf
> > buffer and use the original one" > If we can have a tracking that catches situations like this - we
> > should be able to drop that optlen=0 requirement.
> > IIRC, that's the only tricky part.
>
> Ah, I meant, in __cgroup_bpf_run_filter_setsockopt, use "!ctx.optlen_changed &&
> ctx.optlen > max_optlen" test to imply "ignore whatever is in the bpf
> buffer and use the original one".  Add 'bool optlen_changed' to 'struct
> bpf_sockopt_kern' and set ctx.optlen_changed to true in
> cg_sockopt_convert_ctx_access() whenever there is BPF_WRITE to ctx.optlen.
> Would it work or may be I am still missing something in the writing first 4k
> case above?

What if the program wants to keep optlen as is? Here is the
hypothetical case: ctx->optlen is 8k, we allocate/expose only the
first 4k, the program does ctx->optval[0] = 0xff and doesn't change
the optlen. It wants the rest of the payload to be passed as is with
only the first byte changed.
The condition "!ctx.optlen_changed && ctx.optlen > max_optlen" is
true, so, if we treat this as explicit optlen=0, we ignore the
program's changes.
But this is not what the program has intended, right? It wants to
amend something and pass the rest as is.

It seems like we need to have both optlen_changed and optval_changed.
If both are false, we should be able to safely do optlen=0 equivalent.
Tracking only optlen seems to be problematic?
