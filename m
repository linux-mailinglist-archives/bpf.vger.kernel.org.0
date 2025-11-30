Return-Path: <bpf+bounces-75781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C62C94FCE
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 14:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B543A3658
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57F23A98E;
	Sun, 30 Nov 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWVJKA1u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D2AD5A
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508030; cv=none; b=mqO2RadFR/m3cBjySChp4x12RQYSwGRNukdkb4xDattLIwJ/GkXTyEwmj32byFbvLS2l56Mbxg+MtUxCDpwLuGb2CnYwhFWlgR8nj7HYUPtvMkVO9IPEjrDHJzJqGBojrsDww83MKuBK2yf8V7Lt2pRCDUwnBqObihgMwzrlxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508030; c=relaxed/simple;
	bh=GY1Log6/HWz6GOTAAMQ7sev8fgeYLrJA/CnuPPNnkp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTxqSGS0BP1m7ZxJLkJJB9MrgjI5QPy98Bi1oF2TuASn6A4VugjbOH26VXF5upL6pk+LCkZR/CcM2/bWXNPwDxy6iCDlvH1HO1Go572pElIu9psj6RHphNbgxxwuYjAd8Ts+irXJrEhYwYaoFKllgNJtTlej5IUPfecK+A0ifps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWVJKA1u; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so3809775d50.3
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764508026; x=1765112826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT4Rq7P4A3WhyG68wBlMG6ufg9ZGrBHjt76GqgBqzDA=;
        b=cWVJKA1ubF2CJeLlz2G8QrXNkz5L5gbz4YGx1nJSYpqmW37DLaijcokUktWhIlTFc1
         v1I4aTFWcT8UtSzavqcFk5/Sj+TgWn0tpX34CZPhA2kO/0lrFKgkOiez/M0eCAPjxvH6
         /+UvBV51jPtRb4e4bxSjaM0nbGJmMy68LIUU6J3JDKKKcNMjNGsmK73L0Bsae0n8OABY
         T2GROS+5Yc+Gl4/8HyTtV4FAQPJtprfGsRW5LGZC6KEN1EJ+n03OWIEtSDfUyXhT6clu
         h25Ek8kjSX0cfvYAiWgd2PEDm7n67VvC7F041Vn+MAQXP9DImD2knFPT5kk99+UdDbe+
         uyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764508026; x=1765112826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BT4Rq7P4A3WhyG68wBlMG6ufg9ZGrBHjt76GqgBqzDA=;
        b=u/68MeXtVpQE8LVufj3wDkO6AGHiKI/t0C1OkUgqlPwx5LBEH1rxpVzD+wROa9MLvz
         WbCX+UtZoFV0heqKxO5EIG56zVM3COloaXqS5wHA815i4cHOh5vOaknCUTsjf79ZFA4C
         wlYFcjz4YYiwxtJDyYcKXhsYbQ6t0K7uw35OXFJExprpQsSAKKMKHDh9pVOc7ENxSeCG
         2TRJsxjkdD8L1troTa05w83GnAmisQa9w/JbawMPPntejY1Nh16O30ViFlutiBGhVgYR
         DbDDIjrsOvJ2JEBMWyQZrWExsCGmiitgbKgZ98teifarPzjHyCVjdENIHx8TVH7NECga
         8zmA==
X-Forwarded-Encrypted: i=1; AJvYcCUp49XxbV+oWpxSBC7XJsV0YvvVxO2ziyH+tSasLa16HwGM9VhldPalq82kMAvhTdgTZRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyHL9SBzotJqeBDCiNj15DX7CFfT5BMtjtgN4BvNwBLWHGzNn
	SxbpElhPld46thLiU00XJAkAwiWfjS+PUFfpqrKY+6sD628mR8gpMLWqSdPpJ+odHvRkMTGb/jp
	mVvy/MJIRdh0RMMQFa/MzXtPvu0sVExM=
X-Gm-Gg: ASbGncs56IuC0csXXbE6X5K1RoixJ54VRHlOwW11A8gv3xfN1AjrmmPc7mX/RCFlU7B
	hy/MZkPTAB6AGGsQqWbdsxG8KlWNiJE/vrouSFG/pcUr6xJ4pSjaU2AHJYAfiEFMI8wPSVdwDt3
	3xNpP9ckFXDPwn4ll877PLKwSZO8LGSdmJvvHA7UK5r1+SOV5frxmx4NHqhEtAlgxgncbZ5nduO
	FEClcCCl2NXKaFnZO82Jzl7duImDbCvIOq5OPBxBRUJJcUJrDTu6NHdDWVt6Y44iNjs+EkS
X-Google-Smtp-Source: AGHT+IHe4gpW2rnysS8Axkwa9KFfNd5Fu71oRNIKhnWe9BfoTt6LNW6knSwpzboU35F4JllhsGWATsqb7Va8p6z+raU=
X-Received: by 2002:a05:690e:10ce:b0:63f:b545:9972 with SMTP id
 956f58d0204a3-64302a4b44bmr19684711d50.26.1764508025721; Sun, 30 Nov 2025
 05:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org> <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
 <e52bf30d-e63b-44ed-9808-ee3e612e0ba1@kernel.org>
In-Reply-To: <e52bf30d-e63b-44ed-9808-ee3e612e0ba1@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 30 Nov 2025 21:06:29 +0800
X-Gm-Features: AWmQ_bmlDYm6Hdx_mMDkDofr-6TD5bKPAmPyTccM1lbk9VM2QxtXVjgWMf1ZI9A
Message-ID: <CALOAHbCy_-5FbF9TJvnCdR8+_u3G60-uPxhbSmJzKEn=DR5Adw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:39=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 11/28/25 03:53, Yafang Shao wrote:
> > On Thu, Nov 27, 2025 at 7:48=E2=80=AFPM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
>
> Lorenzo commented on the upstream topic, let me mostly comment on the
> other parts:
> >>> Attaching st_ops to task_struct or to mm_struct is a can of worms.
> >>> With cgroup-bpf we went through painful bugs with lifetime
> >>> of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
> >>> problems are behind us. With st_ops in mm_struct it will be more
> >>> painful. I'd rather not go that route.
> >>
> >> That's valuable information, thanks. I would have hoped that per-MM
> >> policies would be easier.
> >
> > The per-MM approach has a performance advantage over per-MEMCG
> > policies. This is because it accesses the policy hook directly via
> >
> >    vma->vm_mm->bpf_mm->policy_hook()
> >
> > whereas the per-MEMCG method requires a more expensive lookup:
> >
> >    memcg =3D get_mem_cgroup_from_mm(vma->vm_mm);
> >    memcg->bpf_memcg->policy_hook();
> > > This lookup could be a concern in a critical path. However, this
> > performance issue in the per-MEMCG mode can be mitigated. For
> > instance, when a task is added to a new memcg, we can cache the hook
> > pointer:
> >
> >    task->mm->bpf_mm->policy_hook =3D memcg->bpf_memcg->policy_hook
> >
> > Ultimately, we might still introduce a mm_struct:bpf_mm field to
> > provide an efficient interface.
>
> Right, caching is what I would have proposed. I would expect some
> headakes with lifetime, but probably nothing unsolvable.
>
>
> >> Sounds like cgroup-bpf has sorted
> >> out most of the mess.
> >
> > No, the attach-based cgroup-bpf has proven to be ... a "can of worms"
> > in practice ...
> >   (I welcome corrections from the BPF maintainers if my assessment is
> > inaccurate.)
>
> I don't know what's right or wrong here, as Alexei said the "mm_struct"
> based one would be a can of worms and that the the cgroup-based one
> apparently solved these issues ("All these problems are behind us."),
> that's why I asked for some clarifications. :)
>
> [...]
>
> >>
> >> Some of what Yafang might want to achieve could maybe at this point be
> >> maybe achieved through the prctl(PR_SET_THP_DISABLE) support, includin=
g
> >> extensions we recently added [1].
> >>
> >> Systemd support still seems to be in the works [2] for some of that.
> >>
> >>
> >> [1] https://lwn.net/Articles/1032014/
> >> [2] https://github.com/systemd/systemd/pull/39085
> >
> > Thank you for sharing this.
> > However, BPF-THP is already deployed across our server fleet and both
> > our users and my boss are satisfied with it. As such, we are not
> > considering a switch. The current solution also offers us a valuable
> > opportunity to experiment with additional policies in production.
>
> Just to emphasize: we usually don't add two mechanisms to achieve the
> very same end goal. There really must be something delivering more value
> for us to accept something more complex. Focusing on solving a solved
> problem is not good.
>
> If some company went with a downstream-only approach they might be stuck
> having to maintain that forever.
>
> That's why other companies prefer upstream-first :)

The upstream kernel process is often too slow for our users' needs and
frequently results in the rejection of our submissions.
Therefore, we maintain a set of local features that, despite being
rejected upstream, are critical for delivering user benefits.

>
>
> Having that said, the original reason why I agreed that having bpf for
> THP can be valuable is that I see a lot more value for rapid prototyping
> and policies once you can actually control on a per-VMA basis (using vma
> size, flags, anon-vma names etc) where specific folio orders could be
> valuable, and where not.

agreed.

> But also, possibly where we would want to waste
> memory and where not.

This is a challenge we have also encountered since enabling THP  for
production services. We are continuing to develop our BPF-THP system
to make it more automated.

>
> As we are speaking I have a customer running into issues [1] with
> virtio-balloon discarding pages in a VM and khugepaged undoing part of
> that work in the hypervisor. The workaround of telling khugepaged to not
> waste memory in all of the system really feels suboptimal when we know
> that it's only the VM memory of such VMs (with balloon deflation
> enabled) where we would not want to waste memory but still use THPs.
>
> [1] https://issues.redhat.com/browse/RHEL-121177

This is an excellent analysis=E2=80=94thank you for sharing it.

I don't have a better solution than your current approach of setting
max_ptes_none to 0. However, I believe this situation serves as a
compelling example for why we should implement a per-process control
for `/sys/kernel/mm/transparent_hugepage/` parameters, such as
`khugepaged/max_ptes_none`. This direction also aligns perfectly with
our roadmap for evolving the BPF-THP system on our production servers.

--=20
Regards
Yafang

