Return-Path: <bpf+bounces-70497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25005BC0CF0
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817433AA3E4
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8B288527;
	Tue,  7 Oct 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgmTK8vM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0A28467C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827947; cv=none; b=t+K5ANJgoTn0bil2h+fw56PuoWdwkbRAA3xk60Z67ECK0fiet7Gxup5T7GjwE+Ak8pnRuSF+DbPMTcZNLPdwD2xdHID8QluxbfaKXVXTfimTUrYR2L4rY9duWeNfxfJ6Jrcr4Mck1Muv0zVK2kzcLoPWXm9dME5qYmjQ6OTv9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827947; c=relaxed/simple;
	bh=9levaWjJHA7TcNU8jT56uzj+7qYLXaVXyFf+WgEeBT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8NTR7k3Khf6DDsohku4VlazbAXrKZWB438ozsV5KxY5wrNFRN6Rx+k/ijgFs/OdT7H6id8bZ4/iuFuDy2q2Y22RdXqJpKupz11NtCNxMn2VGpq5aSUR6yY1JkxDvutsBStTyB8kqd/Elo+s8kGPlD8dNKprZc74uveHWikBHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgmTK8vM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78e4056623fso49961226d6.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759827945; x=1760432745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxkYIe5lCPbXvt5LEAWJhmf35lUqskMAv390SOAEtUw=;
        b=SgmTK8vMKYX7QMxUZFnxBPsBbjGyf/Opx3B9nD/U7vCHW696STNWUVqvJi75fANRi2
         lS8RPHU4TVCeqWojLlxugAC213SVLQZknqV2nVU8dyKeTviS/8AE76u5LWXPMQ2ZYaVq
         FJZTDIEpTTxSM75mLqE3WW19/oOYhYP2hkNKspjhys6rvkROIh54D9Vnqc7JUCuBpQPT
         JYz5GL06B41Zx82dm7wEgboWHMOaxpEQ5vooCeUUEd6HtDqOfTkuNNIbIS5aAW7jK5fy
         5z98JF/X41FF5qNtDrMjXfdNX+DPLideG0YsO51c10WinV4Ro4pjNMdJWQILxb/rYEjp
         kQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759827945; x=1760432745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxkYIe5lCPbXvt5LEAWJhmf35lUqskMAv390SOAEtUw=;
        b=FfWr5N87S8+Qe9/LYO5me/lYvBslvexGsvdYl7viJN7T5UFGpvYeYSeIpuLr1bF9/a
         +pnyfa8hnJVxxtQ1QR3QRLA84bW0gsduEi8wizo0lACpjvd8RI3csqU5vf9MgpAxJEsP
         hF3simY8NZupr1x1u2q3jDcM620hZC3WFxxV5X9JNGSVRoCPv+mFkBBPYcjK9+CexFVJ
         xM2OzqZrANDqOYWntCcLSZiAwS1iX2rtCMV2+f6x+hIJiXtbKvcga+EBHzs28L7RflHq
         KsjbR6DOXxJqsStN1VZmonve+Ak/wqDlXjhH+jiUxpvCa26OyZAkohT7XyhxFzzfodxZ
         JeuA==
X-Forwarded-Encrypted: i=1; AJvYcCViuQTBA9FM73FK9iotbJxXTRlgBtMNMA4tBV6wbp57HCKqjCw569IyO6TqngNASbyzASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6JVr89Yh5v4DhxazcscBjKRFoFe44MevygjFd8hdJN3UXLma
	bM1UJJARVNCB2/xniSDhW+2SVMLcXRqRTFW4qCk3HA2BYXpnvTp+ONCVj00fSo3gWIW027K0XU3
	o9iHsTu8XxMmabIReqrTO9oZo+H7Xd1A=
X-Gm-Gg: ASbGncsKVfRlx9tFYx/LKPceWe3dVEmh4WP/JdE5Rj46yjNhfO8X1nV8vzijHnQqJzg
	eA9oONXknVSIAkeG0CIXQSm9RagxGXblwp6j2CcfwBada80UKoQJNTqoFduTTJdosUy9jdDWsYE
	nLJm+tFhPYLPcKL0ScjVwylAY8p6CY2lIYdC3u/yyw9V+GWfgp7pr018yx7ZDhynbnSOj/g5HIb
	VgNP8MgN+cIKUJnZqlD3h5kAvEY9RIO6eyxKRGj3C9Vsg6IIpWfYdpTQ2VH+g==
X-Google-Smtp-Source: AGHT+IGTSensva01uwyL1nNEvPr5059D7N0uaBb6xfNhSuXkh0+a6Mjpi5hSZUB/CGpt8XTeEb3Ofa98l86qjtZh1Ag=
X-Received: by 2002:a05:6214:ccd:b0:856:d1d4:d127 with SMTP id
 6a1803df08f44-879dc77bd7emr193257366d6.4.1759827945115; Tue, 07 Oct 2025
 02:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-8-laoar.shao@gmail.com>
 <CAEf4BzaGRDiW3fRt3i+7vvRB+oQszKjaLWVMSU6JrfmXHsJ45w@mail.gmail.com>
In-Reply-To: <CAEf4BzaGRDiW3fRt3i+7vvRB+oQszKjaLWVMSU6JrfmXHsJ45w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Oct 2025 17:05:07 +0800
X-Gm-Features: AS18NWAVWP6POrSHevBgT5yY56gEiBpWAjVVmPfMtRV7VvEgPMFL-SAZ0sgTI4U
Message-ID: <CALOAHbD5OM+_iUg3DXw+BqYU+PFae6DcQGnE1CrLoKmb9OV9Ug@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 07/11] bpf: mark vma->vm_mm as __safe_trusted_or_null
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 5:07=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 29, 2025 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thu=
s,
> > we can mark it as trusted_or_null. With this change, BPF helpers can sa=
fely
> > access vma->vm_mm to retrieve the associated mm_struct from the VMA.
> > Then we can make policy decision from the VMA.
> >
> > The "trusted" annotation enables direct access to vma->vm_mm within kfu=
ncs
> > marked with KF_TRUSTED_ARGS or KF_RCU, such as bpf_task_get_cgroup1() a=
nd
> > bpf_task_under_cgroup(). Conversely, "null" enforcement requires all
> > callsites using vma->vm_mm to perform NULL checks.
> >
> > The lsm selftest must be modified because it directly accesses vma->vm_=
mm
> > without a NULL pointer check; otherwise it will break due to this
> > change.
> >
> > For the VMA based THP policy, the use case is as follows,
> >
> >   @mm =3D @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
> >   if (!@mm)
> >       return;
> >   bpf_rcu_read_lock(); // rcu lock must be held to dereference the owne=
r
> >   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
> >   if (!@owner)
> >     goto out;
> >   @cgroup1 =3D bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);
> >
> >   /* make the decision based on the @cgroup1 attribute */
> >
> >   bpf_cgroup_release(@cgroup1); // release the associated cgroup
> > out:
> >   bpf_rcu_read_unlock();
> >
> > PSI memory information can be obtained from the associated cgroup to in=
form
> > policy decisions. Since upstream PSI support is currently limited to cg=
roup
> > v2, the following example demonstrates cgroup v2 implementation:
> >
> >   @owner =3D @mm->owner;
> >   if (@owner) {
> >       // @ancestor_cgid is user-configured
> >       @ancestor =3D bpf_cgroup_from_id(@ancestor_cgid);
> >       if (bpf_task_under_cgroup(@owner, @ancestor)) {
> >           @psi_group =3D @ancestor->psi;
> >
> >           /* Extract PSI metrics from @psi_group and
> >            * implement policy logic based on the values
> >            */
> >
> >       }
> >   }
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > ---
> >  kernel/bpf/verifier.c                   | 5 +++++
> >  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
>
> Hey Yafang,
>
> This looks like a generally useful change, so I think it would be best
> if you can send it as a stand-alone patch to bpf-next to land it
> sooner.

Sure. I will do it.

>
> Also, am I imagining this, or did you have similar change for the
> vm_file field as well? Any reasons to not mark vm_file as trusted as
> well?

Marking vm_file as trusted will directly support our follow-up work on
file-backed THP policies, where we need to apply different policies to
different files in production. I will include this change in the same
stand-alone patch. Thanks for the suggestion.

--=20
Regards
Yafang

