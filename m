Return-Path: <bpf+bounces-79175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A687D2A509
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6791F301D0F9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 02:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94933EB10;
	Fri, 16 Jan 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJbPJDla"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D233C1A7
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531580; cv=none; b=sEVDVtyybTLmvOkg6xbnP6HeMi28L2J2B758PTVrvQllIFhRrCpfxjrCs3kGC2ZslviK9+D1tOK8e8BjEJBdE5THdcCB3qOWnW7mYhv/VsMfo1EZoslA1eoSaaLl0XZzRWuELAwk/0Kgu1e3/k5lGjJh+uLkNXiLK/yjfzrCHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531580; c=relaxed/simple;
	bh=MsJSlwhaDwdAgVaD2CEF80Db8ObtInXZTdt+40jU7y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1Ja+1lsrocBi0rWM8ULYHsMC4+viKtL08cReL7i6LCsduHTihEw7mMuu4kC7dOlx/lk/uw49v1OAG9v+fFA8JOCfUplmGsbTIVLjbKrXUkcGd5bht+PQPImQNrmktubmbsVRKzpaedfRl3eHKM+d14ijG6y2RRw8b6uoz+7GGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJbPJDla; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6455a60c12bso1351340d50.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768531575; x=1769136375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iLfr6zxGJEG58Kvc0xfNij+bbtw3AC3a06yEsC6GPw=;
        b=LJbPJDlaZJIPLxQSRREzyfHyLglWHSzmp+zaPkVjKnKBbukd3EffGmGxs7oH1vE84f
         1R+zbzn5CJvxvUSwno4uDFSBtGwDZlsAdkwM0iQ1Dgnx0jFDsmPA/CYZ8SwLUjoH5q6I
         225FPJM1qkKPEB5tWfe6O+O6eosu5ofPmhR8mJuXU8stYruDoAisdOmkK+cjDx50YnHL
         H4hxwTgwLKLOX2MJYdDph+DtnthZIED5lnBi9xvqRvGxMEs9W08zIGvjVFtrf86F3CfH
         qQRzY3MzYGFRCvuVzGNpx7V8dpVr32XcUdpfnkWD5BhQZqcKx8lv/vnQwsOapzZm/DSD
         Uplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768531575; x=1769136375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iLfr6zxGJEG58Kvc0xfNij+bbtw3AC3a06yEsC6GPw=;
        b=Ax/jFVvlPMxj/Y7kyMe2/guPEZGWEWO0byJt79orUsOMA59Z4eZEa1Do3m1SMPNnUD
         TOpuZ5CFgggTiiw52u1u5Lunqf2stWz61C1KTeAfdH+DJ1OLms0zX8p/WGfuGwvLMeIq
         s50j12bzbvdB3etXHs5YKIzQwimEKvt48Ky2RmFpp8m821cDrgl4Gf9CadBKoyRsOL28
         /2z7golwMExDS8vg/ilHZfuDgYjWNle43BGwdavpFdXGKoA5xXoLvWm12KUjOqo0OZMM
         YOpyIUbiyLqRCyC7K2xRbSYoTNCcZld/cNlXX7UWqorBwmfScAR9aRiG5StFT3QHJavD
         KvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSkRTQPMv52huxdjIUbo5+4xvzt0z6xcgcHe4yUefZXC0QX5xClFGm3sPSePfnCikWJ00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGfIWQDdIyZYwqRVQAS72sL/E/11ytDqjtEWnAj6zVBm/EK9U
	KHdvpAUFBowcqdqhJpcdY3PJypvjdp2tCmO2ArvA5cJOsObt3npB2JOnhKAKt2NG2+mKeXcXxSD
	e7SUCRkHWYmmd3e7sumlK06oG6zYMN3o=
X-Gm-Gg: AY/fxX5AE4O4OgrDLiXDz4X1FI42MVhAzpwYh3Hv0pjtPuiKIeQCNOQsJrHg551QYFd
	HJh6BufLAVIlXmMsELzQ1XD6wR9AI/Q3zQWi/CdH3iB4+jq+RW1xQ4a6KsctEngy3rP0+NMtOo6
	Og/8PW8HxLfmIhfpbHqs8fDpM+Ru28jQOPTuPwcx/GN7elVPc9FGyRoJr7TbQb2FfUo0JkCY2fp
	JWFPxa682KUOrvUDyAV4BceZaMEkFhyQ2Hiv2RwKJnpmIRmklN5LkSqVxLPtLbfIfGKrT8O+Q2w
	4WNHYMw=
X-Received: by 2002:a05:690e:14c1:b0:644:6af1:1922 with SMTP id
 956f58d0204a3-64917750ad0mr954132d50.53.1768531574746; Thu, 15 Jan 2026
 18:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113121238.11300-1-laoar.shao@gmail.com> <20260113121238.11300-3-laoar.shao@gmail.com>
 <cfyq2n7igavmwwf5jv5uamiyhprgsf4ez7au6ssv3rw54vjh4w@nc43vkqhz5yq>
 <CALOAHbB3Ruc+veQxPC8NgvxwBDrnX5XkmZN-vz1pu3U05MXnQg@mail.gmail.com> <z5lvdg7fonhyrt4zphak6hnhlazyntyrbvcpxtr32rrksktg3j@wpvmby6yonbr>
In-Reply-To: <z5lvdg7fonhyrt4zphak6hnhlazyntyrbvcpxtr32rrksktg3j@wpvmby6yonbr>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Jan 2026 10:45:38 +0800
X-Gm-Features: AZwV_Qi734cMheGGVfT0zVq47Af0xUAhmTx3ESSteVqYaYSvbPDCEQaPtDUfC_k
Message-ID: <CALOAHbAVcCv_1-yYp7QpEidxPm6vx2p6nzFdKEt61TF8LMCUPw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa balancing
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yu.c.chen@intel.com, zhao1.liu@intel.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:24=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hi Yafang.
>
> On Wed, Jan 14, 2026 at 08:13:44PM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > On Wed, Jan 14, 2026 at 5:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
> > >
> > > On Tue, Jan 13, 2026 at 08:12:37PM +0800, Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > bpf_numab_ops enables NUMA balancing for tasks within a specific me=
mcg,
> > > > even when global NUMA balancing is disabled. This allows selective =
NUMA
> > > > optimization for workloads that benefit from it, while avoiding pot=
ential
> > > > latency spikes for other workloads.
> > > >
> > > > The policy must be attached to a leaf memory cgroup.
> > >
> > > Why this restriction?
> >
> > We have several potential design options to consider:
> >
> > Option 1.   Stateless cgroup bpf prog
> >   Attach the BPF program to a specific cgroup and traverse upward
> > through the hierarchy within the hook, as demonstrated in Roman's
> > BPF-OOM series:
> >
> >     https://lore.kernel.org/bpf/877bwcpisd.fsf@linux.dev/
> >
> >     for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memcg)=
) {
> >         bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> >         if (!bpf_oom_ops)
> >             continue;
> >
> >           ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >     }
> >
> >    - Benefit
> >      The design is relatively simple and does not require manual
> > lifecycle management of the BPF program, hence the "stateless"
> > designation.
> >    - Drawback
> >       It may introduce potential overhead in the performance-critical
> > hotpath due to the traversal.
> >
> > Option 2:  Stateful cgroup bpf prog
> >   Attach the BPF program to all descendant cgroups, explicitly
> > handling cgroup fork/exit events. This approach is similar to the one
> > used in my BPF-THP series:
> >
> >      https://lwn.net/ml/all/20251026100159.6103-4-laoar.shao@gmail.com/
> >
> >   This requires the kernel to record every cgroup where the program is
> > attached =E2=80=94 for example, by maintaining a per-program list of cg=
roups
> > (struct bpf_mm_ops with a bpf_thp_list). Because we must track this
> > attachment state, I refer to this as a "stateful" approach.
> >
> >   - Benefit: Avoids the upward traversal overhead of Option 1.
> >   - Drawback: Introduces complexity for managing attachment state and
> > lifecycle (attach/detach, cgroup creation/destruction).
> >
> > Option 3:  Restrict Attachment to Leaf Cgroups
> >   This is the approach taken in the current patchset. It simplifies
> > the kernel implementation by only allowing BPF programs to be attached
> > to leaf cgroups (those without children).
> >   This design is inspired by our production experience, where it has
> > worked well. It encourages users to attach programs directly to the
> > cgroup they intend to target, avoiding ambiguity in hierarchy
> > propagation.
> >
> > Which of these options do you prefer? Do you have other suggestions?
>
> I appreciate the breakdown.
> With the options 1 and 2, I'm not sure whether they aren't reinventing a
> wheel. Namely the stuff from kernel/bpf/cgroup.c:
> - compute_effective_progs() where progs are composed/prepared into a
>   sequence (depending on BPF_F_ALLOW_MULTI) and then
> - bpf_prog_run_array_cg() runs them and joins the results into a
>   verdict.
>
> (Those BPF_F_* are flags known to userspace already.)

My understanding is that struct-ops-based cgroup bpf serves as a more
efficient replacement for the legacy cgroup bpf. For instance:

  Legacy Feature                                                 New replac=
ement
  BPF_F_ALLOW_OVERRIDE/REPLACE          ->update()
  BPF_F_BEFORE/BPF_F_AFTER                    a priority in the struct-ops?
  BPF_F_ALLOW_MULTI                                    a simple for-loop
  bpf_prog_run_array_cg()                                  a simple ->bpf_h=
ook()

IOW, all control flow can be handled within the struct bpf_XXX_ops{}
itself without exposing any uAPI changes.
I believe we should avoid adding new features to the legacy cgroup bpf
(kernel/bpf/cgroup.c) and instead implement all new functionality
using struct-ops. This approach minimizes changes to the uAPI, since
the kAPI is easier to maintain than the uAPI.

Alexei, Daniel, Andrii, I'd appreciate your input to confirm or
correct my understanding.

>
> So I think it'd boil down to the type of result that individual ops
> return in order to be able to apply some "reduce" function on those.
>
> > > Do you envision how these extensions would apply hierarchically?
> >
> > This feature can be applied hierarchically, though it adds complexity
> > to the kernel. However, I believe that by providing the core
> > functionality, we can empower users to manage their specific use cases
> > effectively. We do not need to implement every possible variation for
> > them.
>
> I'd also look around how sched_ext resolved (solves?) this. Namely the
> step from one global sched_ext class to per-cg extensions.

We're planning to experiment sched_ext (especially the LLC-aware
scheduler) in our k8s environment this year to tackle LLC performance
on AMD EPYC. I might work on it later, but I'm new to it right now.

> I'll Cc Tejun for more info.
>
>
> > > Regardless of that, being a "leaf memcg" is not a stationary conditio=
n
> > > (mkdirs, writes to `cgroup.subtree_control`) so it should also be
> > > prepared for that.
> >
> > In the current implementation, the user has to attach the bpf prog to
> > the new cgroup as well ;)
>
> I'd say that's not ideal UX (I imagine there's some high level policy
> set to upper cgroups but the internal cgroup (sub)structure of
> containers may be opaque to the admin, production experience might have
> been lucky not to hit this case).
> In this regard, something like the option 1 sounds better and
> performance can be improved later.

Agreed.
In option 1, if a performance bottleneck emerges that we can't handle
well, the user can always attach a BPF prog directly to the leaf
cgroup ;)
This way, we avoid premature optimization for performance.

> Option 1's "reduce" function takes
> the result from the lowest ancestor but hierarchical logic should be
> reversed with higher cgroups overriding the lowers.

The exact definition of the =E2=80=9Creduce=E2=80=9D function isn=E2=80=99t=
 fully clear to me
at this point. That said, if multiple hierarchical attachment becomes
a real use case, we can always refactor it into a more generic
solution later.

>
> (I don't want to claim what's the correct design, I want to make you
> aware of other places in kernel that solve similar challenge.)

Understood.
Thanks a lot for your review.

--=20
Regards
Yafang

