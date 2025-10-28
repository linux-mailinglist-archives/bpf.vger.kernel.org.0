Return-Path: <bpf+bounces-72639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC9C17224
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5232B1B23C63
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27C3557F4;
	Tue, 28 Oct 2025 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF+kY4sp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B0354ACC
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689284; cv=none; b=arQk3uOrbfRgTG9OZCeiKCrzGxUmctuKUou8pkPzuDCis7zlx3HIc/+1CeIEhILDy3bBZLHrx35sJ1QO++E9FRsW6Mk/1digfUetEas8r+6aVyclbyJjmukvacYqZjMQsL/lUsZEzPKTSrDgC34vb6RZybO6v3DpRZB6R88Qgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689284; c=relaxed/simple;
	bh=xxLjTcs49KVHsuBWJBp8+5TQJEuXYXCZzLvCqnDtD3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVOI75l9SHULHUi1u5hs0i17hJUrS3zZae3aUIAxeCkOp4tRwsysyNxLX6rO3YfwWKOw+yWnDsfMjZsR344/fWcLGD4vEXZSQJIgxdLOSGZZs3QA6/tfPFqFW48xEoV+UTW2rW8MMj99ELMeGzxboYIj4RNOtw4Spd9MzwzUSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF+kY4sp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4270491e9easo5366889f8f.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761689281; x=1762294081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=lF+kY4spAEP0CrGbZfaCAYVN7tjQyJ5/IL8S82YAu/KyjKTunYI52v+6qy/xg2iw//
         2Pi2f7HzzYPuj1lhyuMfD8Rx2xK+JiCvtEJyPmXulM0ugiz773sMLNM4Z2uzDz0LtMQz
         R1D9Hs53WOC11wBg9ld1ltuUSCRYYkHvQMcQYu0F44xXeWnmoldnNqbTPjdDPxjuoZFc
         jeber4tOBrgqsoJ/Pcvxy6biJejoZFO5BGnMLtHxMuxh5OxB7JnnuDWextrF1tC/8s2M
         4653WgUejRDf3dfmvisPN3TAONI0sLwUwAjRtC8ZUqKPjWS8ZxYKQziRHPSMuCOOvEYA
         +xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689281; x=1762294081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=A8LHN1NBWmkRbiLE0rwbfMLpU7mxZ4c/kcdBv/Uyi/2eXYYYyzUKXD6bsbW0DZGIri
         uZbrQ2vK+oEI0yM67rWvrobJDXL+wUF7Zc+qaNn0MO49kRnevfjIqWZCe4svY+nqIZOy
         wNE2G/mzAONu9CDFj9S5/3GI3ZzG8TjK7t8nkpgY7DH8H6lhlMMlcQZZntXsReOXijJ6
         3HdHNw6WJH8PRsEYgCAsjuwk6hQBZuWNv8xZTsyBMtwCvhH/NroaiadT1dis7A7rq63i
         pqsOJwJbzUtgeQ0bDRlOkjZGBfi4tjoIcikr1plJB2QiQ0zLeUPV+PeomSb0p7ZigGaj
         piHw==
X-Forwarded-Encrypted: i=1; AJvYcCUh8+Y2e9c2P95o6y76IhNn4rptODSSxdR343vg2zfH1XND8WnflXFhHzEIAA1OHTRB0Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFR7X2+JYNdVxMy1xE5TWiY5E93UaYDS0D+h9C6qRmxTKE2Ts
	NRcxhbQu4ScqA2MPWqmFkk5ocWhuKc/UVfd4lYGAC0hpDvMUKzXiR8+6olHnxGuusiPO/p2DtR7
	HrysTwJA0L+QRud0bK6P0jCltM/VBLHo=
X-Gm-Gg: ASbGncvtp1ugv6WBq5I4ByPn1N9M/rRHUzTYa3pCOf+yTqQSQ4ppzH1CdQQLJWS65U1
	+INXK9dwAdu0u6bkmzGaPUflQaJrHaYTcAj+nQEQ1wQ1w3IyCvYsYKGcW8r+gf/0VCM/km+JWk6
	DyM9BNj38GcLvj3kf8S5e583MFEDm4HW7KjkbffD9fvaIx0sBg9COzp+3QeO4RJlrRyIkjEjdF6
	sS0y+Nd86zF/KS4XLJ9qCf2CLRv79i+4iLg6JPgjbpVuJQTDVu9AGdSx/j4pQpfRJNDC8PXeYag
	M53sU6MfNr4enjYPdQ==
X-Google-Smtp-Source: AGHT+IGICaO3BvlkXeLb+EbVNUOXQ0U63xZwGPTFrBoahOPE5MZiS6EG5jxPBtr1ZSjP3nUamu+JhVo3r42lsbR/Cqg=
X-Received: by 2002:a5d:5849:0:b0:426:ff7c:86d3 with SMTP id
 ffacd0b85a97d-429aef78c90mr552970f8f.13.1761689280869; Tue, 28 Oct 2025
 15:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev> <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
 <87qzumq358.fsf@linux.dev>
In-Reply-To: <87qzumq358.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 15:07:49 -0700
X-Gm-Features: AWmQ_bn1qYp03A-J3vHinawzwNNuHcAYrjS8vVp0NbrkX9UuC4qoOTSYxLLTXTE
Message-ID: <CAADnVQ+iEcMaJ68LNt2XxOeJtdZkCzJwDk9ueovQbASrX7WMdg@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:42=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> >>
> >> +bool bpf_handle_oom(struct oom_control *oc)
> >> +{
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> >> +       struct mem_cgroup __maybe_unused *memcg;
> >> +       int idx, ret =3D 0;
> >> +
> >> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu=
 */
> >> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> >> +
> >> +#ifdef CONFIG_MEMCG
> >> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upw=
ards */
> >> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(m=
emcg)) {
> >> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> >> +               if (!bpf_oom_ops)
> >> +                       continue;
> >> +
> >> +               /* Call BPF OOM handler */
> >> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >> +               if (ret && oc->bpf_memory_freed)
> >> +                       goto exit;
> >> +       }
> >> +#endif /* CONFIG_MEMCG */
> >> +
> >> +       /*
> >> +        * System-wide OOM or per-memcg BPF OOM handler wasn't success=
ful?
> >> +        * Try system_bpf_oom.
> >> +        */
> >> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> >> +       if (!bpf_oom_ops)
> >> +               goto exit;
> >> +
> >> +       /* Call BPF OOM handler */
> >> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> >> +exit:
> >> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> >> +       return ret && oc->bpf_memory_freed;
> >> +}
> >
> > ...
> >
> >> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> >> +{
> >> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, st=
ruct bpf_struct_ops_link, link);
> >> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> >> +       struct mem_cgroup *memcg =3D NULL;
> >> +       int err =3D 0;
> >> +
> >> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> >> +               /* Attach to a memory cgroup? */
> >> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id)=
;
> >> +               if (IS_ERR_OR_NULL(memcg))
> >> +                       return PTR_ERR(memcg);
> >> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> >> +       } else {
> >> +               /* System-wide OOM handler */
> >> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> >> +       }
> >
> > I don't like the fallback and special case of cgroup_id =3D=3D 0.
> > imo it would be cleaner to require CONFIG_MEMCG for this feature
> > and only allow attach to a cgroup.
> > There is always a root cgroup that can be attached to and that
> > handler will be acting as "system wide" oom handler.
>
> I thought about it, but then it can't be used on !CONFIG_MEMCG
> configurations and also before cgroupfs is mounted, root cgroup
> is created etc.

before that bpf isn't viable either, and oom is certainly not an issue.

> This is why system-wide things are often handled in a
> special way, e.g. in by PSI (grep system_group_pcpu).
>
> I think supporting !CONFIG_MEMCG configurations might be useful for
> some very stripped down VM's, for example.

I thought I wouldn't need to convince the guy who converted bpf maps
to memcg and it made it pretty much mandatory for the bpf subsystem :)
I think the following is long overdue:
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..af60be6d3d41 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -34,6 +34,7 @@ config BPF_SYSCALL
        select NET_SOCK_MSG if NET
        select NET_XGRESS if NET
        select PAGE_POOL if NET
+       depends on MEMCG
        default n

With this we can cleanup a ton of code.
Let's not add more hacks just because some weird thing
still wants !MEMCG. If they do, they will survive without bpf.

