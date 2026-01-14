Return-Path: <bpf+bounces-78885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE7D1EB43
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5899030770E4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D761396D19;
	Wed, 14 Jan 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6V4hzFY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57027396B70
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392863; cv=none; b=LXOsMVDLP6kS/6Qb1VHRluUQ9mjpx64fdnCUsOyjYftrs5lsGTwuvOJ8+zVVNyGJB6hSjpuIAZjmkLLCC/UXVDHen+aLS3CJwlw6dNvMGoenOc6kf4nqITC/rruxl218L8+k6OF599SnZCI5gneHdbUD1KWhmDbUVWui81arlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392863; c=relaxed/simple;
	bh=2cli1wpMP8LgnPh7GFLLV4lw4gaYJEa4OZgsRpeZi1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHouDVgbfImX3MB5pHBwAmi/KdaP2JUjwuD6rfmGDmQ0P2LNCIryXCZOhXwR3uwaBMVZH+CzsK95G+vB6mESJ17LQ1GGt6i3Nn7iKjOUsatp8hKyqCPLyL5SU9WORskGEeUYaoY6+X9khsH5xg3a+4pCY/SECPdaYutURjCs2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6V4hzFY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c6a53187dso52566717b3.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768392861; x=1768997661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpgn9moKDBgyCKhNw842q28BORTy5OVetihmiI3/j9Q=;
        b=a6V4hzFYhpgBKoHTtm+KMAlqEnDPi79ImOcTPCJS0w4McdanDTYtl6OWTe/7Wg4Pfq
         Lj/pFN8VabStN1pCbLd5ZoIMfmmhAa8b52iQ+Z8UDqSobE8i/sWw2yM+Xu5bWoulDioY
         3aPUNHkBppIMJ+MnO7l5YHdwrtiLWDuPulDwk088LUkVjtoBx1X/dnrx9cFHx2vtenxy
         5rCr0CyeIhck3KhpivmoWiCsk0CE/nnuFDMHlYXNGdIkztH/U/P714Q2yaj1gzddLP8R
         fw6NZ/k8Xq8rWfuvsoAAM3oRfni6QFLIOnDqD1t3KF+WcDhyQ/7AMuiWtLNVxaa9X0He
         5IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392861; x=1768997661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vpgn9moKDBgyCKhNw842q28BORTy5OVetihmiI3/j9Q=;
        b=vlSLfc+om4m9YpO1F1zUKFyvfkGVh8HbfwkB3JbK4VZXN9vRgIgsBtLeWjLFZ6CV9m
         ZYhJ6CXYEdy6U7YfC5Zwp1k3rr2xAUINMLv6J3zXNk2pg9nAlnxedYIX8HFw19Jiv8Pt
         jYSLse+rVcMikklGrH3Ks8UvoDTPeZFe1gw7BqhpOvPWqKoZFLEh9RJ893FDilpe3mQE
         sbp0xXGA7DPTGzWB5mnCvU0nMr+xKVVFtfShnIXIRPY7ARo69CII4EEaYRck3J++CmBk
         MLJ6QmCzcS+lglL6PKf5KVpunUQ8DZ3VDnGG3r8OTG+Atv6msyj6z2B09Lnj45SCmpxd
         xMZw==
X-Forwarded-Encrypted: i=1; AJvYcCWiYf13ZmKK7ssn0pzOQmZExl8atqU4u6ODa7nuFyddOLjJ6DyLnYihmmdFL39oDvC4z1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmL0P9Sc4l8at4mTvdJwM0HkKzvNaOUVsgeAXDpvvLDeC8s9l
	1lX7UrH0znPU2OoCwceXAftjfrcNPf3euVDfHC+0gDiCUB+odT7AgjlJCEcFJdNFHxTzCXBIEM3
	beknRd6ShOhG8ogxono9TZmB2Rco38jU=
X-Gm-Gg: AY/fxX7jdJvN/q49GognoGya2gjy2t/2SW0rw8d5THiP4U0Hbc6G1WPgNep7IZIDw5Z
	yRy9MPMwiPpcuD6+kvQKwThI4vsan6q4O5sUAZ06LF3ybqOzukvoUDbbZaZbSGVgxPIWKfzovBb
	4bZQOZitT5Vd+eGMod+adY/X6LbDIHLwCx+sZ7ihDN33Kie8pEaromtgB0qIx+vhJi9PY5akyjB
	Yya5I+Z+yLymH8XRJyLr668JqoNV0WcQX0//bd2pnSWS4zVzCDV879dLICly0WKnSAaDWJS
X-Received: by 2002:a05:690e:11ce:b0:646:5019:f3ee with SMTP id
 956f58d0204a3-64901aaceaamr1895854d50.5.1768392861312; Wed, 14 Jan 2026
 04:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113121238.11300-1-laoar.shao@gmail.com> <20260113121238.11300-3-laoar.shao@gmail.com>
 <cfyq2n7igavmwwf5jv5uamiyhprgsf4ez7au6ssv3rw54vjh4w@nc43vkqhz5yq>
In-Reply-To: <cfyq2n7igavmwwf5jv5uamiyhprgsf4ez7au6ssv3rw54vjh4w@nc43vkqhz5yq>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Jan 2026 20:13:44 +0800
X-Gm-Features: AZwV_QhhO9LftRha77JGtQk2VGHz1UfT0zHqtdmTUKBENe25a-mZ75XFm7_6Qes
Message-ID: <CALOAHbB3Ruc+veQxPC8NgvxwBDrnX5XkmZN-vz1pu3U05MXnQg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa balancing
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yu.c.chen@intel.com, zhao1.liu@intel.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Jan 13, 2026 at 08:12:37PM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > bpf_numab_ops enables NUMA balancing for tasks within a specific memcg,
> > even when global NUMA balancing is disabled. This allows selective NUMA
> > optimization for workloads that benefit from it, while avoiding potenti=
al
> > latency spikes for other workloads.
> >
> > The policy must be attached to a leaf memory cgroup.
>
> Why this restriction?

We have several potential design options to consider:

Option 1.   Stateless cgroup bpf prog
  Attach the BPF program to a specific cgroup and traverse upward
through the hierarchy within the hook, as demonstrated in Roman's
BPF-OOM series:

    https://lore.kernel.org/bpf/877bwcpisd.fsf@linux.dev/

    for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(memcg)) {
        bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
        if (!bpf_oom_ops)
            continue;

          ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
    }

   - Benefit
     The design is relatively simple and does not require manual
lifecycle management of the BPF program, hence the "stateless"
designation.
   - Drawback
      It may introduce potential overhead in the performance-critical
hotpath due to the traversal.

Option 2:  Stateful cgroup bpf prog
  Attach the BPF program to all descendant cgroups, explicitly
handling cgroup fork/exit events. This approach is similar to the one
used in my BPF-THP series:

     https://lwn.net/ml/all/20251026100159.6103-4-laoar.shao@gmail.com/

  This requires the kernel to record every cgroup where the program is
attached =E2=80=94 for example, by maintaining a per-program list of cgroup=
s
(struct bpf_mm_ops with a bpf_thp_list). Because we must track this
attachment state, I refer to this as a "stateful" approach.

  - Benefit: Avoids the upward traversal overhead of Option 1.
  - Drawback: Introduces complexity for managing attachment state and
lifecycle (attach/detach, cgroup creation/destruction).

Option 3:  Restrict Attachment to Leaf Cgroups
  This is the approach taken in the current patchset. It simplifies
the kernel implementation by only allowing BPF programs to be attached
to leaf cgroups (those without children).
  This design is inspired by our production experience, where it has
worked well. It encourages users to attach programs directly to the
cgroup they intend to target, avoiding ambiguity in hierarchy
propagation.

Which of these options do you prefer? Do you have other suggestions?

> Do you envision how these extensions would apply hierarchically?

This feature can be applied hierarchically, though it adds complexity
to the kernel. However, I believe that by providing the core
functionality, we can empower users to manage their specific use cases
effectively. We do not need to implement every possible variation for
them.

> Regardless of that, being a "leaf memcg" is not a stationary condition
> (mkdirs, writes to `cgroup.subtree_control`) so it should also be
> prepared for that.

In the current implementation, the user has to attach the bpf prog to
the new cgroup as well ;)

>
> Also, I think (please correct me) that NUMA balancing doesn't need
> memory controller (in contrast with OOM),

Correct.

> so the attachment shouldn't be
> through struct mem_cgroup but plain struct cgroup::bpf. If you could
> consider this or add some details about this decision, it'd be great.

That's a good suggestion. By removing the dependency on memcg, we can
simplify the design.

--=20
Regards
Yafang

