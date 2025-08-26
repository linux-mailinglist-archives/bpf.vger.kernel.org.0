Return-Path: <bpf+bounces-66539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BBB35EBF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 14:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF741888057
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C32FE58A;
	Tue, 26 Aug 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv7kgF1C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18B2C0F9C;
	Tue, 26 Aug 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209832; cv=none; b=netRmJob61TrD2ymXLudFHtr6ba/cm2dTsnEagzDHn5XuYrxUSB+Gf+a0hdSWdxnp5cxbJDYqU4z9ricA7YPtFzK/VM0GowDR8ZqG7hpYcs7OoAawSm+8VLd6RKhbKS/Ylk+ADS+DKhWCWWaaMzCxfKcDY1M13hO7evZL3Tcuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209832; c=relaxed/simple;
	bh=/xKxOkXiufAOu1Mr2cS/bhhKMlAQkKW6DOWCCSz/09k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skraLkh/BGfHql4Pts82lbsi1jkLH2Eryb6acychAA1sVm8korgCcaKLDELjewXBeeP7qn1kDg2aPNZvs9JnZ5Sf897teEPyx9b6co2sdvoRcqU85A1VmQ6H4RJ8WEuGffJF1IKGSGvme+uz9lt1e5MeZNEMcArJHVbeU4oxMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv7kgF1C; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70ddadde48fso615916d6.0;
        Tue, 26 Aug 2025 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756209830; x=1756814630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nINdU7ZKfIKy1EEWB7ufRqfr8Zsb0d4U8Sl/GImC+Ww=;
        b=Lv7kgF1Ckvyvaneff32dvb19EtlBlsmrTjKc6j6AMAzBiblKkLE5Isv6DLNwFcOL2t
         JNK+gVQD/k8pHfXqq7keNfqkXxzwGAXYotSGN0HHhAR4khmG8TueDh8NHQc452Kfdk1T
         Ljep5CXMdxGN98bZa2DEgpQe2bkFIAJpUQMyGrvU7/vIICvfLUPLgspoHJFG0S/Ot7fV
         OXF6jga6RVliM7fJ1AxIrjjU7sb7GmcDIs4samvbu6NDUbnWsxc0zcSO/c3oUgfANjQc
         G5ekIus5PxrlzghNWP3cucssOfmOMx3jMLoczQvsAWx4Re8r+piqDelXUR5Zeb4D+pqQ
         U2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209830; x=1756814630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nINdU7ZKfIKy1EEWB7ufRqfr8Zsb0d4U8Sl/GImC+Ww=;
        b=aPNMWVKOf/3D52eTC6T8MoOYc4DzeDPCzeOLe+REPS4r0oBwsPFVfSBmX86i5XBTnP
         DScxAyXeXtGtVc3bgrnr2ADMOa6tnhhlubzomZq7SbfAHXh3GLkvn9gGr9Ty488UQg4G
         mzjaexwxkPDw2rHFFh+7RWypVsiOJEqQV1akRKjc7KfO2kZbNFrNWa9aCgGYEf20XX1W
         h5EmyzysKNJAL+RCgmZUUDysxNNTGj+YDvIXK6RoQP5zITMrjCJQYHIEq9VkfM77kWAT
         Z6UD6Y8A7hVBRZT8QIhPwdMo7Uf6xxzUwCM4WV+7Z91hOS0TUyDaofxNlyBNsU0SL2Uw
         KlWg==
X-Forwarded-Encrypted: i=1; AJvYcCUyItE49JslB19llYMv9J86xuDROXsE1/VVGp5fazdSnEznyy7sbyyfADQgz9ub7Nwam98=@vger.kernel.org, AJvYcCXPDDgbCFJl3ujr9M59xn+8J9Q/8NL96Yjl1wvbw225KDmYR+PgMA6r2iVvdtTbRdvOIRMDASIn6fkb@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8WBG70SaiPhRKtDXpQ2fcaV1qIE28PJyzJMFY8Ux8jQUZLDN
	vWxhpE4+IySOi1lH3MMwqgLUnXU0yE/fXklTegCr9UEGrLUjFSsrCrPDLhKBdOnPmVUFxhZVxyt
	bZXupkJYzT2oF9ksg2Jrt4L8NP80RKVY=
X-Gm-Gg: ASbGncvBC3no8Nsni39JB0ynaGFJzOCjpOY5GuOs1i/MwfHtrIS5mQOe4h1qJOe0+HG
	8JRr7wELeXf7+PeJQUWy76iHC6w+niwK5wleD3JmZ01FXkySyYwo5YitG0tqodksYHFqAVcLxq0
	UwhQl26pj4KG0+ZofJlvo0s7rEzYG2hs2skOIRoyOS4O3kBuRrJq7xB1whZxxyhn3oKex51LZUe
	Zh+yHzRQag9ywV+6h7jvSJfiLvQ3/26lQrNdI5aEDRPFyfM1XM=
X-Google-Smtp-Source: AGHT+IGfNLNHfEjbYUBZOTOvD+RrHO3QOGRLRnNPyHmbopSrERqyuL+ygoKpCg+N0F63//8tBx/jLH2XA0mYvdF5J1w=
X-Received: by 2002:a05:6214:e44:b0:70d:6de2:50d3 with SMTP id
 6a1803df08f44-70d97212ee2mr175699806d6.64.1756209829711; Tue, 26 Aug 2025
 05:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
In-Reply-To: <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 26 Aug 2025 20:03:13 +0800
X-Gm-Features: Ac12FXxAMWmgXqxqMn86i1pgaDl2fr9t1rbnFdtwuYwKZ28ngZsdmxMlz2l-U7E
Message-ID: <CALOAHbDZCyUCMYkChVtWgYJci_rXVmMMpGtpeYQWeXW1egVNAg@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	yu c chen <yu.c.chen@intel.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	libo.chen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:42=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.08.25 09:19, Yafang Shao wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Our production servers consistently configure THP to "never" due to
> > historical incidents caused by its behavior. Key issues include:
> > - Increased Memory Consumption
> >    THP significantly raises overall memory usage, reducing available me=
mory
> >    for workloads.
> >
> > - Latency Spikes
> >    Random latency spikes occur due to frequent memory compaction trigge=
red
> >    by THP.
> >
> > - Lack of Fine-Grained Control
> >    THP tuning is globally configured, making it unsuitable for containe=
rized
> >    environments. When multiple workloads share a host, enabling THP wit=
hout
> >    per-workload control leads to unpredictable behavior.
> >
> > Due to these issues, administrators avoid switching to madvise or alway=
s
> > modes=E2=80=94unless per-workload THP control is implemented.
> >
> > To address this, we propose BPF-based THP policy for flexible adjustmen=
t.
> > Additionally, as David mentioned [0], this mechanism can also serve as =
a
> > policy prototyping tool (test policies via BPF before upstreaming them)=
.
>
> There is a lot going on and most reviewers (including me) are fairly
> busy right now, so getting more detailed review could take a while.
>
> This topic sounds like a good candidate for the bi-weekly MM alignment
> session.
>
> Would you be interested in presenting the current bpf interface, how to
> use it,  drawbacks, todos, ... in that forum?

Sure.

>
> David Rientjes, who organizes this meeting, is already on Cc.

DavidR had previously reached out to me about this patchset.

Hello DavidR,

Would September 17 from 9:00=E2=80=9310:00 AM PDT (UTC-7) work for discussi=
ng
this topic? If that time isn=E2=80=99t convenient, I=E2=80=99m happy to sch=
edule a
later session=E2=80=94this will also give me some time to prepare a brief
slide.

On a related note, I=E2=80=99d like to take this opportunity to also share =
a
short proposal on BPF-based NUMA balancing.

On our AMD EPYC servers, many services experience significant
performance degradation due to cross-NUMA access. While NUMA balancing
can help mitigate this, its current global enable/disable
implementation often leads to overall system performance regression.
We are exploring the use of BPF to selectively enable NUMA balancing
only for NUMA-sensitive services, thereby minimizing unintended side
effects. A similar approach has been proposed in [0] using prctl() or
a cgroup interface. We believe this use case is particularly
well-suited for a BPF-based solution, and I=E2=80=99ll briefly outline why =
in
the slide. I=E2=80=99ve included the developers from [0] in CC for visibili=
ty,
in case they are interested in joining the discussion.

Looking forward to your thoughts.

[0]. https://lore.kernel.org/lkml/20250625102337.3128193-1-yu.c.chen@intel.=
com/

--=20
Regards
Yafang

