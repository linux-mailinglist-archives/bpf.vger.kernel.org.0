Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4408E4E49A4
	for <lists+bpf@lfdr.de>; Wed, 23 Mar 2022 00:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiCVX3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbiCVX3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 19:29:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39D47048
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 16:28:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 17so26082364lji.1
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrKQ1FTZYlEYmNkvs41fOfGaRASstgid/Hjia8sOE08=;
        b=co+3iqj6EskHwhZgoG8RoHfhynPe/8x2093yFGdAYm1QrGEGTDkcQS3ixG5KqUpjMI
         BHd+671do1F+PQcQ1/XIKLkNwR6UeYTq3Vv6KV8aEE2AY97ywDihC85Aje+sAXCuoxRo
         sURJjhtYjgyTlF6Tm579S6upuwTHsbVUPf9crkMaR5N0uotdYeIhiWpXK1vIJylqq0vC
         evn/NKxfRaRixi3sQfu2dU9MI6g2bUMHF1fyoABM4p2MLVU2UGI9aPtxazHCIRXSySvn
         v/fblBlaPY+uz5uM1gh4erOXG42lMVAX6uAEIVpG/lpPbIw3xz30umQgtnjhaf7O2cwa
         wjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrKQ1FTZYlEYmNkvs41fOfGaRASstgid/Hjia8sOE08=;
        b=Jm1TxsuzmrKZ1o2nmh9MCkN10gmeWq090a/+omNsOZy4QtIgYtS0lB88/Bsgtoi4qC
         xJq+EW0D6DQA2HEaQhwkUyz8Ffj4RgdwsR+FnbRoLJiU7kLA3oF5/uh2+b9T9vQyAwXp
         2olofodn/8AYwgD9puNeRmo/hy27BmYT9XYjl/fkSFKchBlTbggivj2BCe0zT76hrCPB
         qle7zqq6X0kRyyjoBoft4JbsKJhL24GnWuF9glcyDbuqBe+BXMfavZ6W8kot52dsp/5T
         /KyLkjuiy66MX2lsPZjbq9Hs8+jGb0r9o5L0cHsnkThvbs5s1WsNzVYJY3FlAhgbS0wb
         A/xg==
X-Gm-Message-State: AOAM533iNnWA+Dma7NNAFlw9hT1T642bktStx5dfIwI87iCSFH8CBXu5
        i70z3KiFP+PLIxFA2gwmdaFBn2teTcDae/619CNm8vKZIRfeYg==
X-Google-Smtp-Source: ABdhPJzw8B+KXfx7FREb4kZCCNxof73KJ8eYpv0OiBJ1ZcjZRs8t82uk8FX/IKJSbuohztLq4/unZVPv7kIuIwUrlDE=
X-Received: by 2002:a2e:a7ce:0:b0:249:862b:503 with SMTP id
 x14-20020a2ea7ce000000b00249862b0503mr8119180ljp.369.1647991695251; Tue, 22
 Mar 2022 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220322211513.3994356-1-joannekoong@fb.com> <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1aRAXeDQKQq7zUPoJSb8oOFbb+jgtdF2_ttjcQL+Oo13A@mail.gmail.com> <20220322230734.oph7ijzmymwmknjk@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220322230734.oph7ijzmymwmknjk@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 22 Mar 2022 16:28:04 -0700
Message-ID: <CAJnrk1ZxScExcEAViNNT9Uw3rHJsTMeCmwYBwbzX5hBGthaFiQ@mail.gmail.com>
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

On Tue, Mar 22, 2022 at 4:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Mar 22, 2022 at 03:38:29PM -0700, Joanne Koong wrote:
> > On Tue, Mar 22, 2022 at 2:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Mar 22, 2022 at 02:15:13PM -0700, Joanne Koong wrote:
> > > > From: Joanne Koong <joannelkoong@gmail.com>
> > > >
> > > > This fixes two things in bpf_local_storage_update:
> > > >
> > > > 1) A memory leak where if bpf_selem_alloc is called right before we
> > > > acquire the spinlock and we hit the case where we can copy the new
> > > > value into old_sdata directly, we need to free the selem allocation
> > > > and uncharge the memory before we return. This was reported by the
> > > > kernel test robot.
> > > >
> > > > 2) A charge leak where if bpf_selem_alloc is called right before we
> > > > acquire the spinlock and we hit the case where old_sdata exists and we
> > > > need to unlink the old selem, we need to make sure the old selem gets
> > > > uncharged.
> > > >
> > > > Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  kernel/bpf/bpf_local_storage.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > > index 01aa2b51ec4d..2d33af0368ba 100644
> > > > --- a/kernel/bpf/bpf_local_storage.c
> > > > +++ b/kernel/bpf/bpf_local_storage.c
> > > > @@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >       if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > > >               copy_map_value_locked(&smap->map, old_sdata->data, value,
> > > >                                     false);
> > > > -             selem = SELEM(old_sdata);
> > > > -             goto unlock;
> > > > +             raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > +             if (selem) {
> > > There is an earlier test ensures GFP_KERNEL can only
> > > be used with BPF_NOEXIST.
> > >
> >
> > I agree, we currently will never run into this case (since the
> > GFP_KERNEL case will error out if old_sdata exists), but my thinking
> > was that maybe in the future it may not always hold that GFP_KERNEL
> > will always be coupled with BPF_NOEXIST, so this change would
> > defensively protect against that.
> Then the earlier GFP_KERNEL and BPF_NOEXIST check is enough
> to guard the future change without considering other implications first.
>
> It is better to fail early for the cases that it does not support (like
> the existing GFP_KERNEL and BPF_NOEXIST check).
>
> or make it truely work for all other cases (if there is a use case).
>
> > > The check_flags() before this should have error out.
> > >
> > > Can you share a pointer to the report from kernel test robot?
> > >
> > I'm unable to find a link to the report, so I will copy/paste the contents:
> >
> > From: kernel test robot <lkp@intel.com>
> > Date: Tue, Mar 22, 2022 at 11:36 AM
> > Subject: [bpf-next:master] BUILD SUCCESS
> > e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643
> > To: BPF build status <bpf@iogearbox.net>
> >
> >
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > master
> > branch HEAD: e52b8f5bd3d2f7b2f4b98067db33bc2fdc125643  selftests/bpf:
> > Fix kprobe_multi test.
> >
> > Unverified Warning (likely false positive, please contact us if interested):
> It is indeed a false positive.  I am not very convinced this needs
> to be silenced in the expense of adding unneeded logic in
> this function and makes it harder to read.

Sounds good, I will abandon this patch then. Thanks for your input,
Martin and KP.

>
> >
> > kernel/bpf/bpf_local_storage.c:473:2: warning: Potential leak of
> > memory pointed to by 'selem' [clang-analyzer-unix.Malloc]
> >
> > Warning ids grouped by kconfigs:
> >
> > clang_recent_errors
> > `-- i386-randconfig-c001
> >     `-- kernel-bpf-bpf_local_storage.c:warning:Potential-leak-of-memory-pointed-to-by-selem-clang-analyzer-unix.Malloc
> >
> > elapsed time: 723m
> >
> > > > +                     mem_uncharge(smap, owner, smap->elem_size);
> > > > +                     kfree(selem);
> > > > +             }
> > > > +             return old_sdata;
> > > >       }
> > > >
> > > >       if (gfp_flags != GFP_KERNEL) {
> > > > @@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >       if (old_sdata) {
> > > >               bpf_selem_unlink_map(SELEM(old_sdata));
> > > >               bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > > > -                                             false);
> > > > +                                             gfp_flags == GFP_KERNEL);
> > > >       }
> > > >
> > > > -unlock:
> > > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > >       return SDATA(selem);
> > > >
> > > > --
> > > > 2.30.2
> > > >
