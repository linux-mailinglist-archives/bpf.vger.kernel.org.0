Return-Path: <bpf+bounces-54165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13EA63FD0
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E3016EA93
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455B219319;
	Mon, 17 Mar 2025 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="SLlVMw93"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0519ABD1;
	Mon, 17 Mar 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189949; cv=none; b=HZclYLMFvBHKs6m9Pk7RdZkh2Wkd25V9AosS559S1sbTrs8IK094ckGj1MPF4c7F2CJMRjO+gzcXWO45wGlmFgGzWFH/0L9kXyfzcPn9vrRqSIB96PH9fTzb6tCj6oXYcx3E04wrh1ZFFDhprEKapRdxSLvEiBUMveT36lIkLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189949; c=relaxed/simple;
	bh=avvAm3TfVmPXqQzOZzdus2bewNPLEU/HczMySDIdZmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noZ8OG7HMy+n7yM6JecKGbu0JJIBOTxvoFPKyL7ymOQ4Ny73gi7Kibz7k08Dj9LuodmJRfiKAaoewQIosM2Bn5wnmZp8Mnv34KVakwAr4WcP6RyM9soPIYrHzzQkFPJjLL7J980ihiRRs7edO72XnUSmEPs8lUu/hNrZQ1rL8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=SLlVMw93; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742189934;
	bh=zK+WlBZ7bfUFhV22HGI+VQBZQaODHmIrst6qLkeokfc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=SLlVMw93lQ0pjnKON9JSVNeWfLyY4Wr+dPv3F/5SylHHgCrA0PYOnRnYdB5pJIqYK
	 nZtSlNovZQYoA4Too4xZ2Rw7WbPw6PsSdmlm/rcXP5xAbTSotOb1DE1MlCoNMk7+8a
	 0X0O3tM0o6bhEZ8l7U5jO2zgV4RtXLZSefIpa1KI=
X-QQ-mid: bizesmtpsz10t1742189929t6cm00
X-QQ-Originating-IP: s6iNHhpCw/0D1fPrZxK1dUONPmxCWlDy9tVvffz7Spg=
Received: from mail-yb1-f171.google.com ( [209.85.219.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 13:38:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12359778561293452305
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e63fd2b482fso1789105276.1;
        Sun, 16 Mar 2025 22:38:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjC/9KNuzCwmLZtOeujkOyXju1sxXFwq+Qi/ocOkYYaKe8p184+zMQfE/LN/6/cHXU8xMEWPNY@vger.kernel.org, AJvYcCWirzynfBHu5E7xa1Atlh/lRgY6la5p6dIX5mdULli4s+3tihJt3BXh4E9/s7qQf2SXOJs=@vger.kernel.org, AJvYcCXhZfWzuzvn2+T/BHQ8OBED1+h0yIWrCqO8xeVX5XMbE8fSl2OTa0rXhqLksPPBYTBvMEN+k5oKkdBWqhnD@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5L//6H44Hhh/xXDILNtKbtXXNIOip2cm2iwnhFCh6Z6Rmigi
	xYvXFgDwwAUEHEUPZblixnogk+R4mKrURkib+6carE2dlifygXP0AciAAHFTw+kpo2DTC0zvnZU
	YMj23IAS2kuQZf9odC6BoyUjBiVA=
X-Google-Smtp-Source: AGHT+IG9QcE+zk+CQT1TeMx4mbEkt+HkxFBWSzkmmibRNOjKnTS9z2gqmQyqlPyCZj8eKRE+CfVQsZ4ngcPpsidtPzc=
X-Received: by 2002:a05:6902:2190:b0:e60:87a0:6216 with SMTP id
 3f1490d57ef6-e63f64d177emr13808887276.5.1742189927117; Sun, 16 Mar 2025
 22:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>
 <2025031759-sacrifice-wreckage-9948@gregkh> <CAC1kPDNNBj3Hd6s72mA3qxwxC0B69aE7qhM+Az5msvjPy41N5w@mail.gmail.com>
 <2025031743-haunt-masculine-afb4@gregkh>
In-Reply-To: <2025031743-haunt-masculine-afb4@gregkh>
From: Chen Linxuan <chenlinxuan@deepin.org>
Date: Mon, 17 Mar 2025 13:38:36 +0800
X-Gmail-Original-Message-ID: <1A817481715D4A86+CAC1kPDN-cwLyJgXY2DUZuhUf+guFS7u8OWJx_3G8s6RMua1NJQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrmjGnqdeXyssT6bNuZRCuqD15-5c3YjGNNWgoH8z4a5CDXQ1DtFJAE3l4
Message-ID: <CAC1kPDN-cwLyJgXY2DUZuhUf+guFS7u8OWJx_3G8s6RMua1NJQ@mail.gmail.com>
Subject: Re: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@deepin.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Jann Horn <jannh@google.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NBkE/PP8DpFYcxWPOUcuHNHVU2DSA7vQ2zAXl/+KP76gCyYiNiIcCPr0
	gWKfQWaOBTdFAHn8Pm0J0ex8Z5Lah8CMzhlkuDecysTT6WqM2R4OiNJcLamMFdykKh6OOi6
	Q5l6B5UJpHR83n/lGg7da2m9kQt9WJLMH1zXefvHss65gahGr1ejdI/x8jh4B56qZ+e1x7k
	aBEDGI7AXK+BLxtIrc4NjODPaF65DgDrtN4RaoFeSJ3nmL32FtEVnKhWqDQUcBR5khXbpjh
	klBqTg9AyGlu+0XBi0XZijXMX2OYot6KyXpQumsszmRaXsgMJqO0aFEThmK1T3b3h+amXTJ
	VoLxHZuGfP9Ps3IDkQsCTlLuFBC/Ukqqmw4Awih+e/muf07eRE2GJTYT2Ih8s1hYWxEC2xU
	wwzL1UptnGdgGfDnu9VZtQGp4z0H3aTokyiFQtv/HVGzyfIHFuQX6AAsJMLUO/nVNePl0kE
	MZU9byRR29rJt+zJvsVMqvg34BKkEO0rxdfS7ZATCYU8i2aAIiSYagL1B6UriNz6hztnJIu
	t+GgHduwwXr8SU5RwiMrIdkkK+b4ZeSp+c7YXQ+p3m+xvprtSJB//uB5iQ3YmGO6/mdUjAe
	vSsgaZSY5nuNJyfM/uJqUAs9uYwsS8DZ9e5h3SKkoQYgHi5LWbwvIiv/6JRdsEx3jbN3dU3
	ubcdAk1NtvLHWx6VGiTJMdDKClQj5rT7JfbWWD+2cfdA62yS6kelW/e7RifKdSZAc7HgJmb
	r99/ZufVIGXD85ioXGnLPb2ujSYYLZLRc/OqzG47VdIAfIzWWG3Mpofvzw3eGoP/sW1cOwf
	df2fc8ReXOaJMshTiLCOL4GXwU5sWv2QL4u+Qd5DIi4DaI4G0hZivHDQqD/cOPbyY9uWn5m
	EjvzD6dRGULFuYn2uG8RVjTvFNS5Ww6944RvkSouew06ZYw3azTBtX304m3HqOjnh0DEGqv
	5dDOzmATAUnQisYFVkxXmS0N8LkOLa1fMMv2S7sPTBLQu1ucEl18vgGnX8+Dhx7xVBK+4hV
	mYwLnhFJDk9wPwbBYzSf+DnUZLXt7LlbILxwquet2v+37eCOcnQn5efyIqZgZhSIYaJE4+K
	XQLxPWeDlru
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B43=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 13:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 17, 2025 at 01:04:41PM +0800, Chen Linxuan wrote:
> > Greg KH <greg@kroah.com> =E4=BA=8E2025=E5=B9=B43=E6=9C=8817=E6=97=A5=E5=
=91=A8=E4=B8=80 12:20=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Mar 17, 2025 at 09:16:04AM +0800, Chen Linxuan wrote:
> > > > [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
> > > >
> > > > >>From memfd_secret(2) manpage:
> > > >
> > > >   The memory areas backing the file created with memfd_secret(2) ar=
e
> > > >   visible only to the processes that have access to the file descri=
ptor.
> > > >   The memory region is removed from the kernel page tables and only=
 the
> > > >   page tables of the processes holding the file descriptor map the
> > > >   corresponding physical memory. (Thus, the pages in the region can=
't be
> > > >   accessed by the kernel itself, so that, for example, pointers to =
the
> > > >   region can't be passed to system calls.)
> > > >
> > > > We need to handle this special case gracefully in build ID fetching
> > > > code. Return -EFAULT whenever secretmem file is passed to build_id_=
parse()
> > > > family of APIs. Original report and repro can be found in [0].
> > > >
> > > >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation=
/
> > > >
> > > > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file read=
er abstraction")
> > > > Reported-by: Yi Lai <yi1.lai@intel.com>
> > > > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.i=
bm.com
> > > > Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@k=
ernel.org
> > > > [ Chen Linxuan: backport same logic without folio-based changes ]
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > > > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> > > > ---
> > > > v1 -> v2: use vma_is_secretmem() instead of directly checking
> > > >           vma->vm_file->f_op =3D=3D &secretmem_fops
> > > > ---
> > > >  lib/buildid.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > > index 9fc46366597e..34315d09b544 100644
> > > > --- a/lib/buildid.c
> > > > +++ b/lib/buildid.c
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/elf.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/pagemap.h>
> > > > +#include <linux/secretmem.h>
> > > >
> > > >  #define BUILD_ID 3
> > > >
> > > > @@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma,=
 unsigned char *build_id,
> > > >       if (!vma->vm_file)
> > > >               return -EINVAL;
> > > >
> > > > +     /* reject secretmem */
> > >
> > > Why is this comment different from what is in the original commit?  S=
ame
> > > for your other backports.  Please try to keep it as identical to the
> > > original whenever possible as we have to maintain this for a very lon=
g
> > > time.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > >
> >
> > Original comment is in a function named freader_get_folio(),
> > but folio related changes has not been backported yet.
>
> That's fine, but the logic is the same so keep the original code as
> close as possible.  Otherwise it looks like this is a totally different
> change and we would have to reject it for obvious reasons.
>
> thanks,
>
> greg k-h
>
>

V3 has been sent.

Thanks,
Chen Linxuan

