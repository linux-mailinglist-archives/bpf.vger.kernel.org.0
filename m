Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBA2107D1
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgGAJQJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgGAJQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 05:16:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83943C03E979
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 02:16:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so9970204wmi.4
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU8SA1O8Jv6Te10+ekIri7BfJviqp+FfrfyfU+sHV5I=;
        b=PArRIUIP3oLxFSKLYX84rMRie9XkyLd9uwGa84vRBkwRCfxG6u/Ciol2bf46f65mKr
         gS/uBH5bVkxwk2INmeY9XdXQleq5AZogmib5AvlUZ7ZO3JaeRR0MsvgT16jCV2MFJyu6
         4HLt4K4YsiEgaSv63OhHurhWFuNZU5xblW+6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU8SA1O8Jv6Te10+ekIri7BfJviqp+FfrfyfU+sHV5I=;
        b=F8Hb0BVtSC/JcOFAwezqBJToSvQIUqbxe49pZ/mFyN+vpSWmrZ/okzD5iqD8JXShAX
         a4GmX32CdBcCliiM930sV2ck9SpIVAFtXqlclDWhBzfOssM4vkFVLfo32rnGjmwTX479
         5cywUh2EHjQ6F2Xm6Vu9oVarUJIxFiPDuSDQiQ+K9MxAHzQVqEma6/f62qSKP1WHeUSr
         l2sB8XmVi1S1kpl/UAtyHlBLFXmU73Qt7kT2w5GrRFfuDoZJ1Ijskhy9V52XttBRZ0s0
         0buAShEVLYmWlM7BpfF2i336An4PiG8Rr1wLf+VtgIIzB45Lrc145hsd1kkqObvqZPdl
         IH4g==
X-Gm-Message-State: AOAM53255GsqzmDIfX6iZUkk+24fNKanjVW1sZ8tkFMfRHkvttMGoLEC
        mLegC6qXmIKUOXBCUsbjvnut7ZO0UGxOwTz5apkILQ==
X-Google-Smtp-Source: ABdhPJyqhKkeC3WFoi3duBSAsO8e02uwCpFbGA/A+tGFkJAdC9zXZ1MHmQJaNg81SWF7ip1T+T0ahSMkEw6XtxE5KGA=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr25620717wml.170.1593594965921;
 Wed, 01 Jul 2020 02:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200630043343.53195-1-alexei.starovoitov@gmail.com>
 <20200630043343.53195-3-alexei.starovoitov@gmail.com> <d0c6b6a6-7b82-e620-8ced-8a1acfaf6f6d@iogearbox.net>
 <20200630234117.arqmjpbivy5fhhmk@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200630234117.arqmjpbivy5fhhmk@ast-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 1 Jul 2020 11:15:55 +0200
Message-ID: <CACYkzJ5kGxxA1E70EKah_hWbsb7hoUy8s_Y__uCeSyYxVezaBA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/5] bpf: Introduce sleepable BPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, paulmck@kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 1:41 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 01, 2020 at 01:26:44AM +0200, Daniel Borkmann wrote:
> > On 6/30/20 6:33 AM, Alexei Starovoitov wrote:
> > [...]
> > > +/* list of non-sleepable kernel functions that are otherwise
> > > + * available to attach by bpf_lsm or fmod_ret progs.
> > > + */
> > > +static int check_sleepable_blacklist(unsigned long addr)
> > > +{
> > > +#ifdef CONFIG_BPF_LSM
> > > +   if (addr == (long)bpf_lsm_task_free)
> > > +           return -EINVAL;
> > > +#endif
> > > +#ifdef CONFIG_SECURITY
> > > +   if (addr == (long)security_task_free)
> > > +           return -EINVAL;
> > > +#endif
> > > +   return 0;
> > > +}
> >
> > Would be nice to have some sort of generic function annotation to describe
> > that code cannot sleep inside of it, and then filter based on that. Anyway,
> > is above from manual code inspection?
>
> yep. all manual. I don't think there is a way to automate it.
> At least I cannot think of one.
>
> > What about others like security_sock_rcv_skb() for example which could be
> > bh_lock_sock()'ed (or, generally hooks running in softirq context)?
>
> ahh. it's in running in bh at that point? then it should be added to blacklist.
>
> The rough idea I had is to try all lsm_* and security_* hooks with all
> debug kernel flags and see which ones will complain. Then add them to blacklist.
> Unfortunately I'm completely swamped and cannot promise to do that
> in the coming months.
> So either we wait for somebody to do due diligence or land it knowing
> that blacklist is incomplete and fix it up one by one.
> I think the folks who're waiting on sleepable work would prefer the latter.
> I'm fine whichever way.

Chiming in since I belong to the folks who are waiting on sleepable BPF patches:

1. Let's obviously add security_sock_rcv_skb to the list.
2. I can help in combing through the LSM hooks (at least the comments)
     to look for any other obvious candidates.
3. I think it's okay (for us) for this list to be a WIP and build on it with
    proper warnings (in the changelog / comments).
4. To make it easier for figuring out which hooks cannot sleep,
     It would be nice if we could:

    * Have a helper say, bool bpf_cant_sleep(), available when
       DEBUG_ATOMIC_SLEEP is enabled.
    * Attach LSM programs to all hooks which call this helper and gather data.
    * Let this run on dev machines, run workloads which use the LSM hooks .

4. Finally, once we do the hard work. We can also think of augmenting the
    LSM_HOOK macro to have structured access to whether a hook is sleepable
    or not (instead of relying on comments).

- KP
