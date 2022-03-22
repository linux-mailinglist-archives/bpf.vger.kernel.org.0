Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279144E493A
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiCVWkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 18:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCVWkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 18:40:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ACA3335A
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 15:38:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so12638652ljc.12
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TgYlWmM7uhnWN+D8arI0fqEIh0rS+ISe+Ck+JBkN2o=;
        b=K4wRLnurTCZOQfG6VzbSyzlgcCV52Rj8JxMEmfotNPafyNxGsMHFaHgQVO+rddyOH7
         x/sWvPpGvpS5Pb6QF47ymdOOW1CWg/pD88hbkCzCsI5JW9jXiHxi6RTHcEL59RRR7ecQ
         idMAC/GnbOu5uiJcnLXsXZcS9dMx+HDMwTLY5BbL8ZAPs1k7m4nUYMNU9PN9WNrQnTrF
         bQ2Mf6T7PuU9XPl+yr+Yur/QNlD/SWpRCVXGJmrvNwco+mxGYHpQc7g0nKxiDdxhS2Yo
         6X9uAY/RO4IPy+EeVhNuO7BE0SHljI9Erfs14RIhILxDJh914Jck7HzKW5PxmGSQXsIZ
         45tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TgYlWmM7uhnWN+D8arI0fqEIh0rS+ISe+Ck+JBkN2o=;
        b=lgRLNE39p13jrxTLYXKeedCY7bkjUSLqKFP/qqMMbA5ocpyXkEQYS4MQc2HRc0pYvp
         BputedDQ/MCdncmxnOvKNzRYPeXmVk5eAwDEEsukhavOGiO8c3bp6hHAA78kMUSIy9U7
         jNAMTVPYhn7MD1dj3TRKJJVWZNj3/OHUSHgxSO6xkUBKgh0b3wEIzrbX865Gx1bszlp/
         S8SEnguJ6jvHE9q1pI0sfw2PBJwuQ4/xJKx6CpDuvuJrpNnGE9RJHZGzM+a6vCMgB8bG
         X7d3TEgszfS6xjGaNz5R61mxtRZbkWzjZ8tKLrJ4+v+L3rS+dFLzlrnKXGiYAAsOG26b
         n5bQ==
X-Gm-Message-State: AOAM532s+MfduMzBEqrghI8U5CKrzEDh/IBPGo9ltjEb4M4IKfLyedDM
        IvJJ/U0BOvwueztQZ02wL/TwUf+As0IQ2XN8ROU=
X-Google-Smtp-Source: ABdhPJwlEgfMlJkQ7ZUnRtL4KiehESBFDTni4/ii7yhxJG4CiL1bhgj/ZoYKGs+//W64YqfTK08YpJfDB0k/QkH65jM=
X-Received: by 2002:a2e:b946:0:b0:244:beb1:72b2 with SMTP id
 6-20020a2eb946000000b00244beb172b2mr20466224ljs.240.1647988720949; Tue, 22
 Mar 2022 15:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220322211513.3994356-1-joannekoong@fb.com> <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 22 Mar 2022 15:38:29 -0700
Message-ID: <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: bpf_local_storage_update fixes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel test robot <lkp@intel.com>
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

On Tue, Mar 22, 2022 at 2:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Mar 22, 2022 at 02:15:13PM -0700, Joanne Koong wrote:
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > This fixes two things in bpf_local_storage_update:
> >
> > 1) A memory leak where if bpf_selem_alloc is called right before we
> > acquire the spinlock and we hit the case where we can copy the new
> > value into old_sdata directly, we need to free the selem allocation
> > and uncharge the memory before we return. This was reported by the
> > kernel test robot.
> >
> > 2) A charge leak where if bpf_selem_alloc is called right before we
> > acquire the spinlock and we hit the case where old_sdata exists and we
> > need to unlink the old selem, we need to make sure the old selem gets
> > uncharged.
> >
> > Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/bpf_local_storage.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 01aa2b51ec4d..2d33af0368ba 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >       if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >               copy_map_value_locked(&smap->map, old_sdata->data, value,
> >                                     false);
> > -             selem = SELEM(old_sdata);
> > -             goto unlock;
> > +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +             if (selem) {
> There is an earlier test ensures GFP_KERNEL can only
> be used with BPF_NOEXIST.
>

I agree, we currently will never run into this case (since the
GFP_KERNEL case will error out if old_sdata exists), but my thinking
was that maybe in the future it may not always hold that GFP_KERNEL
will always be coupled with BPF_NOEXIST, so this change would
defensively protect against that.

> The check_flags() before this should have error out.
>
> Can you share a pointer to the report from kernel test robot?
>
I'm unable to find a link to the report, so I will copy/paste the contents:

From: kernel test robot <lkp@intel.com>
Date: Tue, Mar 22, 2022 at 11:36 AM
Subject: [bpf-next:master] BUILD SUCCESS
e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643
To: BPF build status <bpf@iogearbox.net>


tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
master
branch HEAD: e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643  selftests/bpf:
Fix kprobe_multi test.

Unverified Warning (likely false positive, please contact us if interested):

kernel/bpf/bpf_local_storage.c:473:2: warning: Potential leak of
memory pointed to by 'selem' [clang-analyzer-unix.Malloc]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- i386-randconfig-c001
    `-- kernel-bpf-bpf_local_storage.c:warning:Potential-leak-of-memory-pointed-to-by-selem-clang-analyzer-unix.Malloc

elapsed time: 723m

> > +                     mem_uncharge(smap, owner, smap->elem_size);
> > +                     kfree(selem);
> > +             }
> > +             return old_sdata;
> >       }
> >
> >       if (gfp_flags != GFP_KERNEL) {
> > @@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >       if (old_sdata) {
> >               bpf_selem_unlink_map(SELEM(old_sdata));
> >               bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > -                                             false);
> > +                                             gfp_flags == GFP_KERNEL);
> >       }
> >
> > -unlock:
> >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >       return SDATA(selem);
> >
> > --
> > 2.30.2
> >
