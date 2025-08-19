Return-Path: <bpf+bounces-65998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E92B2C09D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6071BC77C5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F432BF4C;
	Tue, 19 Aug 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjFbSVQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AE32BF3E
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603232; cv=none; b=LamUOdoZabCMCMyST3VleO3pjtax/1qrjJpYUm6QlZuBLMUJ+Qzo/i76jlS1zc5bWPNt8ezeVsWSgpNEejCcNFgvReWMx4UspxTKVE5HLO74CPhqUF6IscAno4j55KvVZ8LPOIvyQBJi/9GwEC1e05EwikDs/sy+Blusjk0NUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603232; c=relaxed/simple;
	bh=VWncFiwOE3pWGhphnLV7bt5jHwLVdzT7YCLafhCLv8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcPuRIh9hgvqg0Swsp2r8DUg7fQO5upryZvRPEaLHgXkoLbsJSNZHcgYlyddRpkJyOmWqPGBAr8gF78eIjnp7QPlElGqgU/zcuZNV3hYMT5vVrgVqsoI+28M51pXiTG83/7bZncPKh9jLkTsGkI8L8R/QreDXBIYsPqhgNvfj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjFbSVQ+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e86faa158fso621047885a.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755603229; x=1756208029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE8KPxqLGvnqGcrCFM6DCzdu/oxztkK6aiFoXUkpgIY=;
        b=jjFbSVQ+OL8H/Z6M0uyPHI+z7PaSZVYMGQYeZn3dkoMmYxJDVuiITxAQwbonF+7WVr
         hXkyQ7daxrcE3+C+llm2ln/gk4G01v4PG2TZIIz4DjKc5pdaj77qpIS0vcLaW9MrCORZ
         jyigrsGtgPyKYN01aBYpPym0I4UTq/bH+rc3o8ENI67PCJJxDI7+NC2mQwi+J/JMkoWD
         pr0BU/MtA3oV09FP6XbUavswmxkUhpbokJFlcpZngMQz61jy3rKr+o+QSAOH1+yl9epU
         o4GsOeHj+8TWFEHYATJKF0VqC4Fpmn6Y9Hsm6YtD7AbgSScNospE8h9mCYOLTD1lQ6gF
         DlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603229; x=1756208029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE8KPxqLGvnqGcrCFM6DCzdu/oxztkK6aiFoXUkpgIY=;
        b=d4Nl8tMEZuvlcGSgFnc8dzqN61OSNLsATAUDenEOKFsu+kuEYe6LJ064oPezQY27LA
         +nFgbaLoxmDr6zuy+FB7lBwUjGBrnEn3Rmng62fpS/1IcNxqetbODiezKqPA+qmXeiYQ
         YXe1HBNDWWXUcQ3bQJYH6EYVZzfSYYVeThWwoUZhA1l5ShV6tzlPiF+yL+26dDVTXJ01
         tBLCMaLwcUDcs67dhYZjMZGaIiEYmqHRdOtQWDxspvL/h2OQvkMh1RIbmj6fFLdUIb+S
         qt6VhoMeeSPJ4HPByvIR2NdDIk9Iil/d7YZm0jYFoPQ9HZAg8h0aCcjUfCd7Ixx8+hiG
         aFsw==
X-Forwarded-Encrypted: i=1; AJvYcCX2nXkgzZaNT/3CFvKv4cFfkxKLitEMRkXZ5HcmayGA0+y54JgKJyXCnLlfGtMFxA4YC/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWznD+P9ziEDvhS1trGWUNOxUhSKz+nhNdGKS0rhVIzg6eGggS
	uKtc5l4D4A1KCe+R/UAas7t1gg7pCrtR8QTivMIVDHIQz3clOJBmj/MZ77deV3u+/2JWbIu2OFq
	fStTNkP8bYmx8hnmC26hJuVdbVgy0Bz9DYbci
X-Gm-Gg: ASbGncs4eqdWufU2h3+BHKZdWdg7DYnW92Koco83Cfn2WubxtRawvWVr/sWO2dZSY7o
	mIHBEPFcu1+rs6dW8+mFV+5mNToSSeHA+vuoW8F53SyIBxK0WDPIGLsms0iyK+QP6gAt+YuPKe0
	XtvBJEm63l8+1WwTp6yOhQIxqBZYXWmF67gGalndeiPM0l3ttT3v9sVy2u7dYhoEDJg7H40RLfE
	UvtI0+C
X-Google-Smtp-Source: AGHT+IHP7AvP95cDuz1oKXtouBgiB+1zSwnea+kSTjGWrEhHxsS7Ly0bT2odjaHfGCwlt9g6a8siFEX8QjU853O+P/Q=
X-Received: by 2002:a05:620a:472a:b0:7e8:71b:96ac with SMTP id
 af79cd13be357-7e9f442a1camr228046485a.11.1755603229147; Tue, 19 Aug 2025
 04:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818055510.968-1-laoar.shao@gmail.com> <36c97fc6-eaa9-44dd-a52f-0b6bf5a001d9@gmail.com>
 <CALOAHbAQ=51mfszBN+Bvb9z+ZDyTBuCW_s0EKi+5rDghFvRZzg@mail.gmail.com> <a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail.com>
In-Reply-To: <a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 19 Aug 2025 19:33:12 +0800
X-Gm-Features: Ac12FXw_UblIdxEg390DBWAF0j7IE39u3YBW_XLxywfHkQQXh4zP9W5l1I0XRPY
Message-ID: <CALOAHbA9tUVarpOnMVMViwY+1uYOFRuD6A0fDPqeqhS=LdJmhw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 mm-new 0/5] mm, bpf: BPF based THP order selection
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:44=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 19/08/2025 03:41, Yafang Shao wrote:
> > On Mon, Aug 18, 2025 at 10:35=E2=80=AFPM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>
> >>
> >>
> >> On 18/08/2025 06:55, Yafang Shao wrote:
> >>> Background
> >>> ----------
> >>>
> >>> Our production servers consistently configure THP to "never" due to
> >>> historical incidents caused by its behavior. Key issues include:
> >>> - Increased Memory Consumption
> >>>   THP significantly raises overall memory usage, reducing available m=
emory
> >>>   for workloads.
> >>>
> >>> - Latency Spikes
> >>>   Random latency spikes occur due to frequent memory compaction trigg=
ered
> >>>   by THP.
> >>>
> >>> - Lack of Fine-Grained Control
> >>>   THP tuning is globally configured, making it unsuitable for contain=
erized
> >>>   environments. When multiple workloads share a host, enabling THP wi=
thout
> >>>   per-workload control leads to unpredictable behavior.
> >>>
> >>> Due to these issues, administrators avoid switching to madvise or alw=
ays
> >>> modes=E2=80=94unless per-workload THP control is implemented.
> >>>
> >>> To address this, we propose BPF-based THP policy for flexible adjustm=
ent.
> >>> Additionally, as David mentioned [0], this mechanism can also serve a=
s a
> >>> policy prototyping tool (test policies via BPF before upstreaming the=
m).
> >>
> >> Hi Yafang,
> >>
> >> A few points:
> >>
> >> The link [0] is mentioned a couple of times in the coverletter, but it=
 doesnt seem
> >> to be anywhere in the coverletter.
> >
> > Oops, my bad.
> >
> >>
> >> I am probably missing something over here, but the current version won=
't accomplish
> >> the usecase you have described at the start of the coverletter and are=
 aiming for, right?
> >> i.e. THP global policy "never", but get hugepages on an madvise or alw=
ays basis.
> >
> > In "never" mode, THP allocation is entirely disabled (except via
> > MADV_COLLAPSE). However, we can achieve the same behavior=E2=80=94and
> > more=E2=80=94using a BPF program, even in "madvise" or "always" mode. I=
nstead
> > of introducing a new THP mode, we dynamically enforce policy via BPF.
> >
> > Deployment Steps in our production servers:
> >
> > 1. Initial Setup:
> > - Set THP mode to "never" (disabling THP by default).
> > - Attach the BPF program and pin the BPF maps and links.
> > - Pinning ensures persistence (like a kernel module), preventing
> > disruption under system pressure.
> > - A THP whitelist map tracks allowed cgroups (initially empty =E2=86=92=
 no THP
> > allocations).
> >
> > 2. Enable THP Control:
> > - Switch THP mode to "always" or "madvise" (BPF now governs actual allo=
cations).
>
>
> Ah ok, so I was missing this part. With this solution you will still have=
 to change
> the system policy to madvise or always, and then basically disable THP fo=
r everyone apart
> from the cgroups that want it?

Right.

>
> >
> > 3. Dynamic Management:
> > - To permit THP for a cgroup, add its ID to the whitelist map.
> > - To revoke permission, remove the cgroup ID from the map.
> > - The BPF program can be updated live (policy adjustments require no
> > task interruption).
> >
> >> I think there was a new THP mode introduced in some earlier revision w=
here you can switch to it
> >> from "never" and then you can use bpf programs with it, but its not in=
 this revision?
> >> It might be useful to add your specific usecase as a selftest.
> >>
> >> Do we have some numbers on what the overhead of calling the bpf progra=
m is in the
> >> pagefault path as its a critical path?
> >
> > In our current implementation, THP allocation occurs during the page
> > fault path. As such, I have not yet evaluated performance for this
> > specific case.
> > The overhead is expected to be workload-dependent, primarily influenced=
 by:
> > - Memory availability: The presence (or absence) of higher-order free p=
ages
> > - System pressure: Contention for memory compaction, NUMA balancing,
> > or direct reclaim
> >
>
> Yes, I think might be worth seeing if perf indicates that you are spendin=
g more time
> in __handle_mm_fault with this series + bpf program attached compared to =
without?

I will test it.

--=20
Regards
Yafang

