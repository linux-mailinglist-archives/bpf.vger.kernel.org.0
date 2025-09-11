Return-Path: <bpf+bounces-68077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4CB5267A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 04:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5277AFB00
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770931A9FBA;
	Thu, 11 Sep 2025 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyGXj0YT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE43FB1B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557903; cv=none; b=Cgyn6epGbubQ877ZcfjlYQJwnHik/IuZXHp2IXC4QqH8YpROuwKf+mUB3Fz/2KIo0NequgtpSAuiC89TecMpzwXNNeFQUv7HPJH0+CR7WAHlRCRrxEsKhFZ/s2tN/R3j0Rn/nqmI+i+3qIFC/mim+F8i4jc1zIniHCYAr/8SOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557903; c=relaxed/simple;
	bh=3kMZvO/i1tMADDZmcxyr2hcCoOpPCD99OHYl0BnTlw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftV3HCNK0Y1090JWerWTYZs91oIhtee1n1rKmlHXFxLSlhBDXuESXTxKRWLKfWXwtE5Z+dagSKwsV6dLpOgi91rokcyOL+T8sSFilvgOD2kr8hQ3iEGFfL80j1x16dKfVqh3xunbDxnTz4QuDF7/gMWe7F5Bl6deV4DWY5Avxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyGXj0YT; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7220d7dea27so1831206d6.1
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757557900; x=1758162700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP6wbCxq9x6mQLQiBSlqIUPtCF+SQ7XDDNdAR44nPo4=;
        b=NyGXj0YTUsqeLmnpjwI9ipgQh/enhVcnFvPPeHgVCgZRPk5KgP8SUYbOCP9SgBHno3
         Th62xNGfXiN1IcpWGcilPfbKZro5X1WWlOG/3vCR8V8nki4u3UMEea+IP9ZHPvMJ+Ph3
         27e1AT0L1qSrhkgjB+uiN4Y+drM3/k7PLWcnCp6l2Lh2IX1hkRcaYYx01Um8+YTcygSb
         l4Q4SG9ZKAICSHsbTd/8Da/AL+d67d9y+W2PV7BNmV+qchyCog5igv7Q4QjJm5eh36Zd
         X2e4xV9QqUCoFCp6cu7s2iu4EsYXviNga/bGh7vZDwuyxUUWzgw3GKkqQgNVB/o5WAlO
         sY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757557900; x=1758162700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nP6wbCxq9x6mQLQiBSlqIUPtCF+SQ7XDDNdAR44nPo4=;
        b=HVAuGCccBVxGj34Qm7abcrbz+6tItgy/TwoT+E41bvFEsvVzMji62R7zeAG8zSoCp+
         F22T/7HdSprcKJE5arw+xm3NVsJeDstLHLXOz6yUOmmsC0C5TOKIWXcMLY1aR4L+E0tQ
         CtPWONVkfYMvojs7Ku9DFR+EMHdfDyyaVeLsV60zeZEiQmjsIcdBbdLfAhQ6YBjQLzTL
         ooNUR4GWGJUfTpxGyMo3VdiqQslVhSJ1Xplbq+qP+BO16qptea+LCDOxFqA3/tkeMvnb
         13L9BTeRes0QJE0NYKkZ3f/hTLWohlFu4yIjeEZVKczLyz1PWUfNSe2vp4A4Sj5d2Es5
         FGXg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdlH5eEHrMwuJmn9iDdSoDHtFI+ta8j7PBxNyytfdOgPX9lbCN4PVwLPNz/BlpRFekEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwa1aalYOZhIXj688XYQ8vamse0NWmlc+FTZim3Omi0keDg+km
	6axR1KhmKxuCQWWR72skKn7CAVISvb47akTkwWYNE2O12Tm6L+/b4OhwjmaTZEIH3wmtvDeePq8
	n2rjiKcw/OXhs+hf7/3W7R8i8OSz54/w=
X-Gm-Gg: ASbGncuSi3NHTGckeZnbBw7dSWybOkF4X/xO5hR+lxN0DsC3b+v/jnrJ50E9/iOKt/A
	F/en6RDjDLXgOlrPmUoOo4bubx9KONEWTecBC6CeU3NqSOCFG299rLJS7hF9BaI78WAJVbkPdE/
	6dj9LlvCqm2O8S1x5cbUNSkQJIaccRLFkhrReqRAcb0pT6JGH03UeIRjdko87Y39e9IJvB+eE84
	grMDbexYxlgxkYw9J6K1x2+ssX1PQP1leBqpFTH
X-Google-Smtp-Source: AGHT+IFv4549Bjlkb1Z6NZ8k1soS7TwcDklPSqOEtK13et4tNf5IIQCCxGt2xPSm81jmjCgBMMBrH+SVQoPZVCSMjkU=
X-Received: by 2002:ad4:5dcb:0:b0:722:f52a:1bd4 with SMTP id
 6a1803df08f44-7393e0991f3mr201672756d6.63.1757557899833; Wed, 10 Sep 2025
 19:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-8-laoar.shao@gmail.com>
 <CAADnVQJF6YtzOojGV16hmUpFCiZGxuJAi6=Q4TK=VPH=_93eJA@mail.gmail.com>
In-Reply-To: <CAADnVQJF6YtzOojGV16hmUpFCiZGxuJAi6=Q4TK=VPH=_93eJA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Sep 2025 10:31:02 +0800
X-Gm-Features: AS18NWBQamtUOb14Z7OXpCMF7HjTdLWXm-KLhQksJqZVjzlAf4LNyGFT7O4xrGk
Message-ID: <CALOAHbBvwT+6f_4gBHzPc9n_SukhAs_sa5yX=AjHYsWic1MRuw@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 07/10] selftests/bpf: add a simple BPF based THP policy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > +/* Detecting whether a task can successfully allocate THP is unreliabl=
e because
> > + * it may be influenced by system memory pressure. Instead of making t=
he result
> > + * dependent on unpredictable factors, we should simply check
> > + * bpf_hook_thp_get_orders()'s return value, which is deterministic.
> > + */
> > +SEC("fexit/bpf_hook_thp_get_orders")
> > +int BPF_PROG(thp_run, struct vm_area_struct *vma, u64 vma_flags, enum =
tva_type tva_type,
> > +            unsigned long orders, int retval)
> > +{
>
> ...
>
> > +SEC("struct_ops/thp_get_order")
> > +int BPF_PROG(alloc_in_khugepaged, struct vm_area_struct *vma, enum bpf=
_thp_vma_type vma_type,
> > +            enum tva_type tva_type, unsigned long orders)
> > +{
>
> This is a bad idea to mix struct_ops logic with fentry/fexit style.
> struct_ops hook will not be affected by compiler optimizations,
> while fentry depends on a whim of compilers.
> struct_ops can be scoped, while fentry is always global.
> sched-ext already struggles with the later, since some scheds
> need tracing data from other parts of the kernel and they cannot
> be grouped together. All sorts of workarounds were proposed, but
> no good solution in sight. So don't go this route for THP.
> Make everything you need to be struct_ops based and/or pass
> whatever extra data into these ops.

will change it.

>
> Also think of scoping for bpf-thp from the start.
> Currently st_ops/thp_get_order is only one and it's global.
> It's ok for prototypes and experiments, but not ok for landing upstream.
> I think cgroup would a natural scope and different cgroups might
> want their own bpf based THP hints. Once you do that, think through
> how delegation of suggested order will propagate through hierarchy.

+ Tejun

As Johannes Weiner previously explained [[0]], cgroups are designed as
nested hierarchies for partitioning resources. They are a poor fit for
enforcing arbitrary, non-hierarchical policies.

: Cgroups are for nested trees dividing up resources. They're not a good
: fit for arbitrary, non-hierarchical policy settings.

[0] https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/

The THP  policy is a quintessential example of such an arbitrary
setting. Even within a single cgroup, it is often necessary to enable
THP for performance-critical tasks while disabling it for others to
avoid latency spikes. Implementing this policy through a cgroup
interface that propagates hierarchically would eliminate the crucial
ability to configure it on a per-task basis.

While the bpf-thp mechanism has a global scope, this does not limit
its application to a single system-wide policy. In contrast to a
hierarchical cgroup-based setting, bpf-thp offers the flexibility to
set policies per-task, per-cgroup, or globally. Fundamentally, it is a
more powerful variant of prctl(), not a variant of cgroup interface
file.

>
> bpf-oom seems to be aligning toward the same design principles,
> so don't reinvent the wheel.

Since bpf-oom's role is to select a task to kill from within **a
defined group of tasks**, it is inherently well-suited for
cgroup-based management.

--=20
Regards
Yafang

