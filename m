Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA32A70C2
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgKDWoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732518AbgKDWod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 17:44:33 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676DC0613D2
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 14:44:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so188124lji.4
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktpmn2NX0J5OPT7QN9c8op6gbH7kVw1jxv9tLBj7cuc=;
        b=IFzi+wpry5wW+UcbEC2QWIKhQYjtR1ggicBVKASHjN2NV+62ExLtw0CYZFhffyZaXL
         4wTGZ6IFAYjBXdxC509EJd1UuJfOZjza4SMu0WCgKRO5+PLp6Z3oo3u+GOMeeADnqSx+
         E53VmeaTZqtXGiTWQogT9aH06dJf/lXRuON2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktpmn2NX0J5OPT7QN9c8op6gbH7kVw1jxv9tLBj7cuc=;
        b=TdGSpHoB2QPc7km3n5VTGLwXttf2wkdiDyD4NreATzkBqN/bxWrnBE/WlHg3OHhOQ0
         SL39tJrb5MOs2Hb8Il34IGsPMs2Pid7+wSvA78AwOb6C4uaLxpMWLEx5hmoyJ1daXvkR
         W3xYrwq0M699rHcbOl7Zv6AfbcaBNZ9BXZPpPG4yuOugm9t7vNEepW8J8ScY0ASn64vB
         dIInfhd1Eyj1pOFDPcB3ab5vULlYevA5oZ6CTUg3hzMRDZS2CodSt+Fb1wY9nx20cAau
         SWINzv/anzHlx8CjCj4nlWlEEWWg8iEjPnG734zdlFrtMisd85rH/ybitAPmm8XQ9aOW
         vt7w==
X-Gm-Message-State: AOAM53254Wx9O/7AcM7Uf/G4Bwnkft4U9F5c/SO/YzSGad1R4pleHh9j
        OC0adaWe2tleiAQsHrAU8oOxpw1J0ftRCtWy1iHoqw==
X-Google-Smtp-Source: ABdhPJzm68ST7IajXhinHgxQieZdPSWnEWAiPZh6ZuCwMd/GrrlZYyo+OqdFWO/eE/CGMKWBWkLVz2Bh2AbNfubgAM0=
X-Received: by 2002:a2e:1517:: with SMTP id s23mr71620ljd.83.1604529869714;
 Wed, 04 Nov 2020 14:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20201104164453.74390-1-kpsingh@chromium.org> <20201104164453.74390-6-kpsingh@chromium.org>
 <20201104223539.pwtwnx6penoqm37j@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201104223539.pwtwnx6penoqm37j@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 23:44:19 +0100
Message-ID: <CACYkzJ57QLF8C+b9HcSFPz4j+HYRsGZfOZ+3i1JSU+R5NkVCiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] bpf: Allow LSM programs to use bpf spin locks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 4, 2020 at 11:35 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Nov 04, 2020 at 05:44:49PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > Usage of spin locks was not allowed for tracing programs due to
> > insufficient preemption checks. The verifier does not currently prevent
> > LSM programs from using spin locks, but the helpers are not exposed
> > via bpf_lsm_func_proto.
> This could be the first patch but don't feel strongly about it.
>
> >
> > Based on the discussion in [1], non-sleepable LSM programs should be
> > able to use bpf_spin_{lock, unlock}.
> >
> > Sleepable LSM programs can be preempted which means that allowng spin
> > locks will need more work (disabling preemption and the verifier
> > ensuring that no sleepable helpers are called when a spin lock is held).
> >
> > [1]: https://lore.kernel.org/bpf/20201103153132.2717326-1-kpsingh@chromium.org/T/#md601a053229287659071600d3483523f752cd2fb
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  kernel/bpf/bpf_lsm.c  |  4 ++++
> >  kernel/bpf/verifier.c | 17 +++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 61f8cc52fd5b..93383df2140b 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >               return &bpf_task_storage_get_proto;
> >       case BPF_FUNC_task_storage_delete:
> >               return &bpf_task_storage_delete_proto;
> > +     case BPF_FUNC_spin_lock:
> > +             return &bpf_spin_lock_proto;
> > +     case BPF_FUNC_spin_unlock:
> > +             return &bpf_spin_unlock_proto;
> >       default:
> >               return tracing_prog_func_proto(func_id, prog);
> >       }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 314018e8fc12..7c6c246077cf 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9739,6 +9739,23 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >               return -EINVAL;
> >       }
> >
> > +     if (map_value_has_spin_lock(map)) {
> > +             if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
> > +                     verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (is_tracing_prog_type(prog_type)) {
> > +                     verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> > +                     return -EINVAL;
> > +             }
> It is good to have a more specific verifier log.  However,
> these are duplicated checks (a few lines above in the same function).
> They should at least be removed.
>

Thanks, I fixed this up and will move this as the first patch.

> > +
> > +             if (prog->aux->sleepable) {
> > +                     verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> >       if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
> >           !bpf_offload_prog_map_match(prog, map)) {
> >               verbose(env, "offload device mismatch between prog and map\n");
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
