Return-Path: <bpf+bounces-70803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05122BD3236
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 15:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E9BD34BE21
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8882EC08B;
	Mon, 13 Oct 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBOITBKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0E26CE15
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360887; cv=none; b=NiFM9jZs/MAJhqqKI+gqG1zc6xHdLe5WqnmOZ9OQ9hMhadWP/Bs+BxbEA8ccFISCDmD5SqpX4C0/9i0ge8pXQ61Vv4pTdND5vftNEmeDxFh0pRH3dss5aL6XAHQhRbdJK6CB3gUV7DYXgMVx3HyE0IJm2D/2XupxwZGzGAawwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360887; c=relaxed/simple;
	bh=ezMBebfglcjXR4WCpqnRZyhjdDDfwSug2JivoEcwJSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/YQUAvVwssIv8KHhxld3Sx694dA6mZYZgQKhZBxCLEDUz1ipo3WF62l2tVoe+KpNEPBS7cfqyXx6Ozhfw8rLkZYjFxiwcjiULq6SJauTlK+5oc18JOoQHAKODRWOK6kObCDimD/r5u5tf360X8WFvhjzmwDYWK8cknlxRwMS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBOITBKe; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78f15d5846dso68603696d6.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760360884; x=1760965684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezMBebfglcjXR4WCpqnRZyhjdDDfwSug2JivoEcwJSY=;
        b=MBOITBKexbSOM1l2106X0HN5/6DrJske9DpAXWrJIQUBgGvY0Ff2WoNwjHm0XlWKR+
         2eP7znYowh9OyVMblZd1hCNZQzxSp6eGw3xaz+N15vu4m4NO6EKfBy51hVFV1x0CpreP
         NoACA94PgSd9QVKMOjQtd1p1fqSC9J0+Kh7XrOxrDrJ3QCXSg/QVJuppIUNjCWadOblv
         8Woo4XWhEeyw7wKJj/1KT/xgutRjckc0WBNHUBRt9BjYf74rj1XDtjiWySJFuL7CSgkW
         onv+gnQjnrOpZCBqhtBkaGmjT+YykBD/4RNSMuu0x+gOAlWvR2FKMwar5MBrNqmZHvuC
         1W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360884; x=1760965684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezMBebfglcjXR4WCpqnRZyhjdDDfwSug2JivoEcwJSY=;
        b=gFpHzhpfDrj37hRJSLNiALhhDAnUP4z4DuSA3CZPn/OAwLrPSc3c6JId6BPZK2Itdn
         5ebs7yz7fHp+HdEg101X6bJ7yi1mYp3PETF2YTD0xHw3XKIp9wScQmZqRUyl77uaxmwJ
         yjMwrL8TQhHOm3Xs5n3jXi3ShmvWlxUFnSQWDSlDAPSmu9ULIMzTEbelUHru7Kn9F4uz
         r9zHbDt7y1J3Wmo0jkuddXCPOC0qajQNlKNLWHNZIFhZDfDnjm8h0PR+WCpPPYUKaASO
         rugVHWxkp7sDEWPDQ3dK8MX/hbGQzx4EthfvaLhzWwzKToqNMsKoGe3b3BaJW5SMp2Yg
         lyEw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdgiBbuMHXeRbsPRODJB0R9MtKv2xBL0jzoadRhGh4QU+WH8giAiUBCbKJYKqSSW/+is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QC2bWoo5EAIas3yDhgNq8p+A3XMfA9ajmzrEbXPZgkPfeAna
	RhQuXP91LNMYEKph12U0EqMIoX9gk8371kVyRjNASVb1TwIi82YTYjaCr6BoMxoGzUS5REoDTCe
	Cla4AfWSwan0gjhRqaBayVVbNChJlp7w=
X-Gm-Gg: ASbGncuFfZfHqDtvH2xra5QmvbE/vvZdGWWdlk7lc581LeynUke1n+CcgHjuV8YVLwu
	hF62igSbmHz3eFyUhie11X7mPUFVsJHtIQSMTEICx0qRMW963SfgBZiy5iLlWhohqAjnAFtnmoF
	RL1+kOpqFvAia/14AwUj60wSZA1xuJPj5jdbbKtR38C5KWLDU56mWcgiwVQnwTfjQSQl4MY1EK1
	QgZJzNU4brTQZKSnD4D+LBum3o4875+MzV++g==
X-Google-Smtp-Source: AGHT+IGm0oKxFc4T/QZjCy+NGutfmN3uHvswZSHDi9nqJU7JDX84TgvXkCDG/QBma6yTwwDWrVtFnLsmlV0W2zzJh/o=
X-Received: by 2002:a05:6214:f08:b0:7a9:3d3b:fe95 with SMTP id
 6a1803df08f44-87b2101d562mr345171496d6.19.1760360884347; Mon, 13 Oct 2025
 06:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com> <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com> <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com> <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
 <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com> <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
 <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com> <CALOAHbAeS2HzQN96UZNOCuME098=GvXBUh1P4UwUJr0U-bB5EQ@mail.gmail.com>
 <7176597b-006f-40ad-9421-860d80d7e696@redhat.com>
In-Reply-To: <7176597b-006f-40ad-9421-860d80d7e696@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 13 Oct 2025 21:07:27 +0800
X-Gm-Features: AS18NWCBr7_RxNHr1I-K75akWBIPcxKG4UcwhU5giQn6IEnh0jqmkdU7wZH1l1w
Message-ID: <CALOAHbDqP3fH2_4r+5_9D46qrFiaRYHYGzW7M-fwwt4_qW9Npw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:42=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I came to the same conclusion. At least it's a valid start.
> >>
> >> Maybe we would later want a global fallback BPF-THP prog if none was
> >> enabled for a specific MM.
> >
> > good idea. We can fallback to the global model when attaching pid 1.
> >
> >>
> >> But I would expect to start with a per MM way of doing it, it gives yo=
u
> >> way more flexibility in the long run.
> >
> > THP, such as shmem and file-backed THP, are shareable across multiple
> > processes and cgroups. If we allow different BPF-THP policies to be
> > applied to these shared resources, it could lead to policy
> > inconsistencies.
>
> Sure, but nothing new about that (e.g., VM_HUGEPAGE, VM_NOHUGEPAGE,
> PR_GET_THP_DISABLE).
>
> I'd expect that we focus on anon THP as the first step either way.
>
> Skimming over this series, anon memory seems to be the main focus.

Right, currently it is focusing on anon memory. In the next step it
will be extended to file-backed THP.

>
> > This would ultimately recreate a long-standing issue
> > in memcg, which still lacks a robust solution for this problem [0].
> >
> > This suggests that applying SCOPED policies to SHAREABLE memory may be
> > fundamentally flawed ;-)
>
> Yeah, shared memory is usually more tricky: see mempolicy handling for
> shmem. There, the policy is much rather glued to a file than to a process=
.

For shared THP we are planning to apply the THP policy based on vma->vm_fil=
e.

Consequently, the existing BPF-THP policies, which are scoped to a
process or cgroup, are incompatible with shared THP. This raises the
question of how to effectively scope policies for shared memory. While
one option is to key the policy to the file structure, this may not be
ideal as it could lead to considerable implementation and maintenance
challenges...

--=20
Regards
Yafang

