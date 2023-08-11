Return-Path: <bpf+bounces-7624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6E779B66
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D68C1C20BA5
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2C3D3B1;
	Fri, 11 Aug 2023 23:36:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A1329D4
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:36:23 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AE10E6;
	Fri, 11 Aug 2023 16:36:20 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5841be7d15eso26499487b3.2;
        Fri, 11 Aug 2023 16:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796980; x=1692401780;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14eo0zaK9Rph8DnLjALuas7VJduBawJMaKLyXhDKwYc=;
        b=ClU16SiRiMPIw75epzPxtizLkTyNwXIcJNb/WD+s7RqZpiVS8kfmINuB5Y6FzyMpI3
         QMITx4KE/oNbh38WatO4YA9aQ4BgFRDx4+qg3D15tB9MXn6nZCJB8hdnOUKM26i/pwbi
         NAnieJg0LNsVT73cV4LwirKKGgXl/Pd8267ZyZav3B7d1HWXVK1NUkoEG8a0JFZYFU8M
         eOBKK96gDZfetsRrT2sojzNaxdXnmmC1wci+Dg2qJCSX11KnD2hUxuVYopFQtCaM8Uy3
         lQiQT4dxy98uiE2NWnsCGvIElsjle47Svfz3XPlj01LLm9djjsZ/O6yy7NDceo8oMilj
         +c8A==
X-Gm-Message-State: AOJu0YwdPFcJ2MWR/Nh8dT+Jg95zOe3b1Tez8FGc2bxb1TBhP0oL/WU1
	PSaERe12YyFkBnrEQdbXK+g=
X-Google-Smtp-Source: AGHT+IGuGOnl4A4FIOmFqBLTHdUUr9oJ0t5qVwnUVDf43ER3G+A8sDLeTGyuZ9x055HnTmBngCF11w==
X-Received: by 2002:a0d:f842:0:b0:586:9ce4:14e8 with SMTP id i63-20020a0df842000000b005869ce414e8mr2783383ywf.52.1691796979562;
        Fri, 11 Aug 2023 16:36:19 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id a123-20020a0dd881000000b00570589c5aedsm1299786ywe.7.2023.08.11.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:36:18 -0700 (PDT)
Date: Fri, 11 Aug 2023 18:36:16 -0500
From: David Vernet <void@manifault.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, tj@kernel.org, clm@meta.com,
	thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230811233616.GE542801@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com>
 <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
 <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 03:49:34PM -0700, Martin KaFai Lau wrote:
> On 8/11/23 1:19 PM, David Vernet wrote:
> > On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
> > > On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
> > > > On 08/10, David Vernet wrote:
> > > > > On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
> > > > > > On 08/10, David Vernet wrote:
> > > > > > > Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> > > > > > > define the .validate() and .update() callbacks in its corresponding
> > > > > > > struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> > > > > > > in its own right to ensure that the map is unloaded if an application
> > > > > > > crashes. For example, with sched_ext, we want to automatically unload
> > > > > > > the host-wide scheduler if the application crashes. We would likely
> > > > > > > never support updating elements of a sched_ext struct_ops map, so we'd
> > > > > > > have to implement these callbacks showing that they _can't_ support
> > > > > > > element updates just to benefit from the basic lifetime management of
> > > > > > > struct_ops links.
> > > > > > >
> > > > > > > Let's enable struct_ops maps to work with BPF_F_LINK even if they
> > > > > > > haven't defined these callbacks, by assuming that a struct_ops map
> > > > > > > element cannot be updated by default.
> > > > > >
> > > > > > Any reason this is not part of sched_ext series? As you mention,
> > > > > > we don't seem to have such users in the three?
> > > > >
> > > > > Hi Stanislav,
> > > > >
> > > > > The sched_ext series [0] implements these callbacks. See
> > > > > bpf_scx_update() and bpf_scx_validate().
> > > > >
> > > > > [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
> > > > >
> > > > > We could add this into that series and remove those callbacks, but this
> > > > > patch is fixing a UX / API issue with struct_ops links that's not really
> > > > > relevant to sched_ext. I don't think there's any reason to couple
> > > > > updating struct_ops map elements with allowing the kernel to manage the
> > > > > lifetime of struct_ops maps -- just because we only have 1 (non-test)
> > >
> > > Agree the link-update does not necessarily couple with link-creation, so
> > > removing 'link' update function enforcement is ok. The intention was to
> > > avoid the struct_ops link inconsistent experience (one struct_ops link
> > > support update and another struct_ops link does not) because consistency was
> > > one of the reason for the true kernel backed link support that Kui-Feng did.
> > > tcp-cc is the only one for now in struct_ops and it can support update, so
> > > the enforcement is here. I can see Stan's point that removing it now looks
> > > immature before a struct_ops landed in the kernel showing it does not make
> > > sense or very hard to support 'link' update. However, the scx patch set has
> > > shown this point, so I think it is good enough.
> >
> > Sorry for sending v2 of the patch a bit prematurely. Should have let you
> > weigh in first.
> >
> > > For 'validate', it is not related a 'link' update. It is for the struct_ops
> > > 'map' update. If the loaded struct_ops map is invalid, it will end up having
> > > a useless struct_ops map and no link can be created from it. I can see some
> >
> > To be honest I'm actually not sure I understand why .validate() is only
> > called for when BPF_F_LINK is specified. Is it because it could break
>
> Regardless '.validate' must be enforced or not, the ->validate() should be
> called for the non BPF_F_LINK case also during map update. This should be
> fixed.

Thanks for clarifying (and also to Kui-Feng), this makes more sense to
me.

> > existing programs if they defined a struct_ops map that wasn't valid
> > _without_ using BPF_F_LINK? Whether or not a map is valid should inform
> > whether we can load it regardless of whether there's a link, no? It
> > seems like .init_member() was already doing this as well. That's why I
> > got confused and conflated the two.
>
> I think the best is to look at bpf_struct_ops_map_update_elem() and the
> differences between BPF_F_LINK and the older non BPF_F_LINK behavior.
>
> Before the BPF_F_LINK was introduced, the map update and ->reg() happened
> together, so the kernel can reject at the map update time through ->reg()
> because '->reg()' does the validation also. If the earlier map update
> failed, the user space can do a map update again.
>
> With the BPF_F_LINK, the map update and ->reg are two separated actions. The
> ->reg is done later in the link creation time (after the map is updated). If
> the BPF_F_LINK struct_ops is not validated as a whole (like ops1 and ops2
> must be defined) during map update, it will only be discovered during the
> link creation time in bpf_struct_ops_link_create() by ->reg(). It will be
> too late for the userspace to correct that mistake because the map cannot be
> updated again. Then it will end up having a struct_ops map loaded in the
> kernel that cannot do anything. I don't think it is the common case but at
> least the map should not be left in some unusable state when it did happen.

I see, thanks for explaining. This is why sched_ext doesn't really work
with the BPF_F_LINK version of map update. We can't guarantee that a map
can be updated if we can't succeed in ->reg(), because we can also race
with e.g. sysrq unloading the scheduler between ->validate() and
->reg(). In a sense, it feels like ->reg() in "updateable" struct_ops
implementations should be void, whereas in other struct_ops
implementations like scx() it has to be int *. If validate() is meant to
prevent the scenario you outlined, can you help me understand why we
still check the return value of ->reg() in bpf_struct_ops_link_create()?
Or at the very least it seems like we should WARN_ON()?

> It is why the validation part has been separated from the '.reg', so
> '.validate' was added and enforced.  and ->validate() is called during the
> map update.
>
> '.init_member' is for validating individual ops/member but not for
> validating struct_ops as a whole, like if ops_x is implemented, then ops_y
> must be implemented also.

Got it, this makes sense.

> > > struct_ops subsystem check all the 'ops' function for NULL before calling
> > > (like the FUSE RFC). I can also see some future struct_ops will prefer not
> > > to check NULL at all and prefer to assume a subset of the ops is always
> > > valid. Does having a 'validate' enforcement is blocking the scx patchset in
> > > some way? If not, I would like to keep this for now. Once it is removed,
> >
> > No, it's not blocking scx at all. scx, as with any other struct_ops
> > implementation, could and does just implement these callbacks. As
> > Kui-Feng said in [0], this is really just about enabling a sane default
> > to improve usability. If a struct_ops implementation actually should
> > have implemented some validation but neglected to, that would be a bug
> > in exactly the same manner as if it had implemented .validate(), but
> > neglected to check some corner case that makes the map invalid.
> >
> > [0]: https://lore.kernel.org/lkml/887699ea-f837-6ed7-50bd-48720cea581c@gmail.com/
> >
> > > there is no turning back.
> >
> > Hmm, why there would be no turning back from this? This isn't a UAPI
> > concern, is it? Whether or not a struct_ops implementation needs to
>
> hmm...at least, map update success in one kernel and then map update failure
> in a later kernel is a different behavior. yeah, the succeeded map is
> unusable anyway but still no need to create this inconsistency to begin with
> if it does not have to.

I was under the impression that we didn't provide any of those UAPI
guarantees for struct_ops. The sched_ext struct_ops API can change at
any time because it's a kernel <-> kernel API (though we don't expect
that to happen very often at all). IMO this would fall under that
umbrella as well.

> > implement .validate() or can just rely on the default behavior of "no
> > .validate() callback implies the map is valid" is 100% an implementation
> > detail that's hidden from the end user. This is meant to be a UX
> > improvement for a developr defining a struct bpf_struct_ops instance in
> > the main kernel, not someone defining an instance of that struct_ops
> > (e.g. struct tcp_congestion_ops) in a BPF prog.
>
> The UX here is about the subsystem doing the very first time struct_ops
> implementation in the kernel, so yes it is the internal details of the
> kernel and one time cost.
>
> Multiple struct_ops bpf prog can then be developed and the bpf developer is
> not affected no matter .validate is enforced or not.

I don't think this is or should be a guarantee that we provide to BPF
developers using struct_ops, though. In my opinion it's the exact same
thing as the kfunc API deprecation story. These are purely kernel <->
kernel APIs, so you get no hard guarantees.

> I think I weighted the end-user space experience more. Having map in
> unusable state is a bad userspace experience. Yes, the way it is enforcing
> it now looks bureaucratic. I think it took two emails to explain the
> internal details of the struct_ops update and the difference between doing
> validation in .validate vs in .reg. I am not sure if the subsystem
> implementer wants to know all this details or just go ahead to implement
> validation in '.validate' and put an empty one for the subsystem does not
> need to check anything.

Yeah, it's definitely subjective. I can certainly understand the
sentiment for requiring it to be implemented for the sake of forcing the
developer to "know what they're doing".

In general I do think the subsystem developer should probably know how
all of this works, and that we should document the struct bpf_struct_ops
API regardless of what we decide to do for this patch specifically.

My personal opinion is that the UX is more intuitive and representative
of the actual feature if we don't force a subsystem implementer to
implement those callbacks, but it is what it is. FWIW, I actually think
the decoupling of ->validate() and ->reg() is what's most confusing,
because in different contexts ->reg() is actually serving the same
purpose as ->validate(). That's beside the point though, I guess.

> I think enough words have exchanged on this subject. I am not going to
> insist. If it is still preferred to have this check removed, please add
> details description to the '.validate' of struct bpf_struct_ops in bpf.h and
> also the commit message to spell out the details for the future subsystem
> struct_ops kernel developer to follow:

Sure thing, happy to do this, and thank you for taking the time to
explain this stuff.

> If it needs to validate struct_ops as a while,
>
> 1. it must be implemented in .validate instead of .reg. Otherwise, it may
> end up having an unusable map.

Some clarity on this point (why we check ->reg() on the ->validate()
path) would help me write this comment more clearly.

> 2. if the validation is implemented in '.reg' only, the map update behavior
> will be different between BPF_F_LINK map and the non BPF_F_LINK map.

Ack, this is good to document regardless.

I'll send a v3 on Monday with these comments added both to the code, and
to the commit summary.

Thanks,
David

