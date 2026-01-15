Return-Path: <bpf+bounces-79014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F7D23EC4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43718301E991
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FD36215E;
	Thu, 15 Jan 2026 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZNbktjYW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EF35EDAB
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472688; cv=none; b=Eqnq+qnb8YxXLQjONEzQwy0xOroSUoMZ53Ojp0ckL6TimOGIyKTCTvIFA+fKpvGpNnkURt1RItigxwWRCNdiw3jsWN9bQe1TxKvrOD90+wJDfV2CHUJzJr7iEXQaGBTsIOpyAkcqjty6N2uLpBJ3hUNqw3zUu0wbrNNFQbwGIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472688; c=relaxed/simple;
	bh=T4myeQZvYSFLUPAuYC70rsVPCePsOn2xO+HTeSzspEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt/ICuAijivgN/9MOziOSQ37rhzKpD9xCdLtnI96YeWR3EPIwcLx5jn8tEY2hc2clDfMrt24t2Y2v4DxHOIcsu1/d9+QCrUfvmnTn6ef69qNq7re1r0spYvXGy09NOn+i7gT8OUQ2qywvU2qc1l13uxv3WmTPHWy02YPDWo0EUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZNbktjYW; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-430fbb6012bso475011f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472685; x=1769077485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP8rRtEvMK5KfbtDsP2vfBcfyghWq57iuvfXZ5BkugU=;
        b=ZNbktjYW+I6yqSxaFvT7cfm5HIn3bK5HfDQMOL7s+ZWunkIM5Zy3OlCMhYQBa/IvWl
         RLsne4D6AXHG+/0uoLKr2JiBuf9kdZvhU1lz8n4Sj40rZy2pip+k96rEvrzFOAahRYLW
         UprYLesOs6IBeilKu3g/60mYj2asFlr4sKT8mICBuL4RDolY/H66ge8Olc3SgKilcHkw
         ZTuVue8v3Np0aeD3njdryZ0vKrwMT8ixR/UiM67+CiFLRiua7Mh/25nSv99H+alsNazc
         IAvSVj8ujt1cu/k3Iz+/r2s2dAa4wtTDda86mNsEJoC5euGHIIaEz8eo5DHfuj4IoRlU
         X8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472685; x=1769077485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP8rRtEvMK5KfbtDsP2vfBcfyghWq57iuvfXZ5BkugU=;
        b=gJuqgoMdMVeZcU8VpYSziR/Yr4HC+l6qaQABs2lNfsUPXxO4MZhgXBp8JopV2PbQfW
         aI6mP3SFQStBBwu7b2j69iv1EhZcilXyuyNKv4l/iX2bSSUh8A6Lx4NUS1tp5uycGnC/
         v6DEl93ltvvOvxE28j/LGvvO9XOyiEanEyX4vbNSr89evKJ3zHLdvQOEuOauUnpEk0/z
         maIxpXCbHH0B1+hhl0VTg3FTmkFh9y6MKrCyujVelKTGpPbEGycb6NW8PGSxwz5zd28n
         78KCvP5E6ohDxFWOxkbE0SJ/F5I3tSx5c4D99OOx1tNW97rmCHvhgeLIs3ivQSITKGbG
         809A==
X-Forwarded-Encrypted: i=1; AJvYcCU4eRDJZlTRPiaCRwZVEbtFcdl7RTwfE//QdfdQTjYeHAiOvqHZ8bS8IX5LHr/Oa8dnPKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxrcPt7r3QBh4RxH5xQqfvpgZ64VogPwaB16yDCG5QVOllYAp
	Uxv+Yi8nIFYA6xd6qwa1CAYkQ4+pR0umcLFc1NK8ne6iYqYYAfl2u4yy8TNCjYqN+yU=
X-Gm-Gg: AY/fxX6YS0h16bwgfbBgzztSueixvt9a66UtKcIKxWE3aRA1HiHVq6z9bPzFcjSLDR7
	CykKon/lTzk/I7JIY9jG7xyt692lLT1+UBGXSkt6y86rlTUFABtCsM0S7eeh55TW/Oir185BdsC
	FvbgS1UahvRlE/yg/U3psx+zngfM+eiH/gVtO6OasK+vAZ9ao3bWhWA+FEcNOJzvblLPxwMEu9J
	bGXu0hy543e2+iTnFDsIVozNrSCI87pl8aVGfGoz+TBxX8Je1rHKHYKYQgFfYvZc78pwaApL7kC
	zJrNTCRGyBDulnZO5Gtw2zecSahoiXzFd8rtGAk3W6FOkckRFnGD96laCus+o+dXhrgwN9d/z2t
	RlZqNJKLYUxg1rIL1iqkRqEK8d9ZeRSRslgFY1FO5VrL8SKrjG2H7h9bmI3CKrP1i8mQBcVorx3
	GodzcW45krI4AzX7F8Njs2JUMtOwP2j3U=
X-Received: by 2002:a05:6000:420a:b0:430:fd0f:28fe with SMTP id ffacd0b85a97d-4342c54ace1mr7667501f8f.31.1768472684978;
        Thu, 15 Jan 2026 02:24:44 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm5006260f8f.3.2026.01.15.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:24:44 -0800 (PST)
Date: Thu, 15 Jan 2026 11:24:42 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yu.c.chen@intel.com, zhao1.liu@intel.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org, tj@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa
 balancing
Message-ID: <z5lvdg7fonhyrt4zphak6hnhlazyntyrbvcpxtr32rrksktg3j@wpvmby6yonbr>
References: <20260113121238.11300-1-laoar.shao@gmail.com>
 <20260113121238.11300-3-laoar.shao@gmail.com>
 <cfyq2n7igavmwwf5jv5uamiyhprgsf4ez7au6ssv3rw54vjh4w@nc43vkqhz5yq>
 <CALOAHbB3Ruc+veQxPC8NgvxwBDrnX5XkmZN-vz1pu3U05MXnQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgrrerx4codwdoe2"
Content-Disposition: inline
In-Reply-To: <CALOAHbB3Ruc+veQxPC8NgvxwBDrnX5XkmZN-vz1pu3U05MXnQg@mail.gmail.com>


--sgrrerx4codwdoe2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa
 balancing
MIME-Version: 1.0

Hi Yafang.

On Wed, Jan 14, 2026 at 08:13:44PM +0800, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> On Wed, Jan 14, 2026 at 5:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > On Tue, Jan 13, 2026 at 08:12:37PM +0800, Yafang Shao <laoar.shao@gmail=
=2Ecom> wrote:
> > > bpf_numab_ops enables NUMA balancing for tasks within a specific memc=
g,
> > > even when global NUMA balancing is disabled. This allows selective NU=
MA
> > > optimization for workloads that benefit from it, while avoiding poten=
tial
> > > latency spikes for other workloads.
> > >
> > > The policy must be attached to a leaf memory cgroup.
> >
> > Why this restriction?
>=20
> We have several potential design options to consider:
>=20
> Option 1.   Stateless cgroup bpf prog
>   Attach the BPF program to a specific cgroup and traverse upward
> through the hierarchy within the hook, as demonstrated in Roman's
> BPF-OOM series:
>=20
>     https://lore.kernel.org/bpf/877bwcpisd.fsf@linux.dev/
>=20
>     for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memcg)) {
>         bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
>         if (!bpf_oom_ops)
>             continue;
>=20
>           ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
>     }
>=20
>    - Benefit
>      The design is relatively simple and does not require manual
> lifecycle management of the BPF program, hence the "stateless"
> designation.
>    - Drawback
>       It may introduce potential overhead in the performance-critical
> hotpath due to the traversal.
>=20
> Option 2:  Stateful cgroup bpf prog
>   Attach the BPF program to all descendant cgroups, explicitly
> handling cgroup fork/exit events. This approach is similar to the one
> used in my BPF-THP series:
>=20
>      https://lwn.net/ml/all/20251026100159.6103-4-laoar.shao@gmail.com/
>=20
>   This requires the kernel to record every cgroup where the program is
> attached =E2=80=94 for example, by maintaining a per-program list of cgro=
ups
> (struct bpf_mm_ops with a bpf_thp_list). Because we must track this
> attachment state, I refer to this as a "stateful" approach.
>=20
>   - Benefit: Avoids the upward traversal overhead of Option 1.
>   - Drawback: Introduces complexity for managing attachment state and
> lifecycle (attach/detach, cgroup creation/destruction).
>=20
> Option 3:  Restrict Attachment to Leaf Cgroups
>   This is the approach taken in the current patchset. It simplifies
> the kernel implementation by only allowing BPF programs to be attached
> to leaf cgroups (those without children).
>   This design is inspired by our production experience, where it has
> worked well. It encourages users to attach programs directly to the
> cgroup they intend to target, avoiding ambiguity in hierarchy
> propagation.
>=20
> Which of these options do you prefer? Do you have other suggestions?

I appreciate the breakdown.
With the options 1 and 2, I'm not sure whether they aren't reinventing a
wheel. Namely the stuff from kernel/bpf/cgroup.c:
- compute_effective_progs() where progs are composed/prepared into a
  sequence (depending on BPF_F_ALLOW_MULTI) and then
- bpf_prog_run_array_cg() runs them and joins the results into a
  verdict.

(Those BPF_F_* are flags known to userspace already.)

So I think it'd boil down to the type of result that individual ops
return in order to be able to apply some "reduce" function on those.

> > Do you envision how these extensions would apply hierarchically?
>=20
> This feature can be applied hierarchically, though it adds complexity
> to the kernel. However, I believe that by providing the core
> functionality, we can empower users to manage their specific use cases
> effectively. We do not need to implement every possible variation for
> them.

I'd also look around how sched_ext resolved (solves?) this. Namely the
step from one global sched_ext class to per-cg extensions.
I'll Cc Tejun for more info.


> > Regardless of that, being a "leaf memcg" is not a stationary condition
> > (mkdirs, writes to `cgroup.subtree_control`) so it should also be
> > prepared for that.
>=20
> In the current implementation, the user has to attach the bpf prog to
> the new cgroup as well ;)

I'd say that's not ideal UX (I imagine there's some high level policy
set to upper cgroups but the internal cgroup (sub)structure of
containers may be opaque to the admin, production experience might have
been lucky not to hit this case).
In this regard, something like the option 1 sounds better and
performance can be improved later. Option 1's "reduce" function takes
the result from the lowest ancestor but hierarchical logic should be
reversed with higher cgroups overriding the lowers.

(I don't want to claim what's the correct design, I want to make you
aware of other places in kernel that solve similar challenge.)

Thanks,
Michal

--sgrrerx4codwdoe2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWjAaBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aip5wEAmBM3Eh0XmAjz2UXAxlR4
TIdMfYbIuVZcUPqJBLuuKwEBAP+Tg17ePUYbRyjXabdKqyVmbO6OT7tDGpaUncgR
wBgO
=50PV
-----END PGP SIGNATURE-----

--sgrrerx4codwdoe2--

