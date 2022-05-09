Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B652098A
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiEIXrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiEIXrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:47:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7826085F
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:38:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg25so9191766wmb.4
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zghuCGHkc6a+SvxDoH06AuPeBjqhtbj285hmjbg59/s=;
        b=A2kjtRM+KbV4UyjxuOfHYeI7X6S0FBX7g9PBz/cecgSZesyQa53UGc87ngZOJDzlE0
         C1lgQc2435bOnm1R86VuR71bFzmKntlz8nCnoPZL7pQszOFpxpGiXJLr6k235qlXhLwy
         TQ8HUtNuQ49nkc4hujtww9O85N09sw9YvKfdMEaX0vIIc5uYLBtoGUWgWja733q1iYgv
         x+gXoCpJmU53MIIzqs7JdG0JUK9drkISIdTqdPoc8pp9QSt47bM+2ZjuICnOXEFm9pRh
         vW2AFyfy9hq+AlbuMS/rcObJ6XOaWrWpO0o188SxB0S54lm9Jke/97q85xXatM/ivHn0
         6Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zghuCGHkc6a+SvxDoH06AuPeBjqhtbj285hmjbg59/s=;
        b=CDtKLX7KITTKhzBH0HPH7q7WcqTN8cqldz8sRDIFipCzfUs50oab1iWcKwcf+FJJL5
         acX8kYuElpKQ0tCXkO4goWL0vFCyXP9zPE3XMl4GKI8NQ6NW5/IT/MXuTgTykq8v85Xr
         LS/v2yd2qDnfy/ZugflHVLjAQhnWLUKFRk72X4/Ls1st5AHHXpVdF/AI1Me0UHFhnydw
         7XUvLkpdJ+j0HbV3kU+4CYVGXCAEPrSll0dGuGlanmEHLgSFN+WUQcS2gPiUGS4yf2vP
         e4lThJRz6KCCUtSVnhLRC5jTjB1flrSrL6AA780vsxikMpqNEtXFgijZsPGoFjL+SBuP
         dPDg==
X-Gm-Message-State: AOAM532qEmiQFm61NLzt9Sjnp3O65RNTlJac2eX0Yd2dQzYbd4EhP6YM
        x/gAA/sDtUoll2pQ1Ye39exxADDjpoc+bW0PkKbmUw==
X-Google-Smtp-Source: ABdhPJylHBoOsp+4zmH4s5XX0sGZApTpSs7lY2YhsWcRPbjovAaEdG8W7TX7RDESE6AMRJtvSbQrWqb0T4NRyZnsqHc=
X-Received: by 2002:a05:600c:1f08:b0:394:9060:bb54 with SMTP id
 bd8-20020a05600c1f0800b003949060bb54mr7335899wmb.73.1652139508395; Mon, 09
 May 2022 16:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220429211540.715151-1-sdf@google.com> <20220429211540.715151-6-sdf@google.com>
 <20220507001250.yhisk4otoas7h4gx@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220507001250.yhisk4otoas7h4gx@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 9 May 2022 16:38:16 -0700
Message-ID: <CAKH8qBsGr+466B23ExBixwcriKxNrFa3v47st-S3qUggNP2Q5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/10] bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
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

On Fri, May 6, 2022 at 5:12 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Apr 29, 2022 at 02:15:35PM -0700, Stanislav Fomichev wrote:
> > We have two options:
> > 1. Treat all BPF_LSM_CGROUP as the same, regardless of attach_btf_id
> > 2. Treat BPF_LSM_CGROUP+attach_btf_id as a separate hook point
> >
> > I'm doing (2) here and adding attach_btf_id as a new BPF_PROG_QUERY
> > argument. The downside is that it requires iterating over all possible
> > bpf_lsm_ hook points in the userspace which might take some time.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/cgroup.c            | 43 ++++++++++++++++++++++++----------
> >  kernel/bpf/syscall.c           |  3 ++-
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  tools/lib/bpf/bpf.c            | 42 ++++++++++++++++++++++++++-------
> >  tools/lib/bpf/bpf.h            | 15 ++++++++++++
> >  tools/lib/bpf/libbpf.map       |  1 +
> >  7 files changed, 85 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 112e396bbe65..e38ea0b47b6a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1431,6 +1431,7 @@ union bpf_attr {
> >               __u32           attach_flags;
> >               __aligned_u64   prog_ids;
> >               __u32           prog_cnt;
> > +             __u32           attach_btf_id;  /* for BPF_LSM_CGROUP */
> If the downside/concern on (1) is the bpftool cannot show
> which bpf_lsm_* hook that a cgroup-lsm is attached to,
> how about adding this attach_btf_id to the bpf_prog_info instead.
> The bpftool side is getting the bpf_prog_info (e.g. for the name) anyway.
>
> Probably need to rename it to attach_func_btf_id (== prog->aux->attach_btf_id)
> and then also add the attach_btf_id (== prog->aux->attach_btf->id) to
> bpf_prog_info.
>
> The bpftool then will work mostly the same and no need to iterate btf_vmlinux
> to figure out the btf_id for all bpf_lsm_* hooks and no need to worry about
> the increasing total number of lsm hooks in the future while
> the latter bpftool patch has a static 1024.
>
> If you also agree on (1), for this patch on the kernel side concern,
> it needs to return all BPF_LSM_CGROUP progs to the userspace.

I was exploring this initially but with this scheme I'm not sure how
to export attach_flags. I'm assuming that one lsm hook can, say, be
attached as BPF_F_ALLOW_OVERRIDE and the other one can use
BPF_F_ALLOW_MULTI. Now, if we return all BPF_LSM_CGROUP programs (1),
we have a problem because there is only one attach_flags field per
attach_type.

I can extend BPF_PROG_QUERY with another user-provided pointer where
the kernel can put per-program attach_flags, doesn't seem like there
would be a problem, right?

> Feel free to put the bpf_prog_info modification and bpftool changes as a follow up
> patch.  In this same set is also fine.  Suggesting it because this set is
> getting long already.

SG. Let's discuss it first. I can do a follow up series to add this
query api, the series is getting long indeed :-(
