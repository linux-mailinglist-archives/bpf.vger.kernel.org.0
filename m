Return-Path: <bpf+bounces-63677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3EB098C2
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E574C587D61
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 00:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61093AD21;
	Fri, 18 Jul 2025 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGcjHtFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D027137E
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797361; cv=none; b=m2jdr+mq1fpSK6TNvsza/8BiEGG5E7ZY7BJtgf0dFdZ5e1jbIyuV3BoHlYfX9F9Fh3MWaTO8euWwYOiswd8oBwU0XhGvUOM4NP55nnWaspnhQjSh11gxyaeFxF6ZPnFhVkeywUqhOsqcBLu1U/gGbTT1GQGJFlmcbi8ozPLF5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797361; c=relaxed/simple;
	bh=dlXAKFkSwNCkyqyH5NucpCFYtKH3bdQYFBpaLQRgPsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU43iKltuly34VKtkQaH3PBTab7I24WjQpXKRLHQYLn8/ZiMeY18UdNZfv7D+15gJXPvuNiFzdu5KCKWRTbZh/wrjES0RlvJaAtxOi3OQqO9hXKo3ffbvd7n5FCw/gq/NfCbF87IU5gEoq3cm4F68joDyf1O6Hy4UdNNoLGtuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGcjHtFo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4560d176f97so17390975e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752797359; x=1753402159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFPWUEY/toVDVNd2k/LREoggH1XAsJ0FDgoZbNXOeEw=;
        b=mGcjHtFoVr6L31afm3WO2QOXisqQ7zkgbXxW8NQpFgxULj0pZ6f2FwQ2emcQplF7LI
         kEJRPpFbUHx5nILJAQ2nBjVm3CtprbkKfmlut11ak7NjL2qam5N01N+BHlYNprIiLuOm
         JpFY/Mj7bQBqewy0AkF+NBBEHggpyMFRDqob4qVveVVmR3WnrhICH24SKudrJrRlSwzZ
         eGiegzM6lZ++k+ctZuMuDsX+2opw06gX0ochJX6dqaK8+CjMBkLH5TwE2/yAJIGuEAWo
         80MLoDNIkf7bzQRenr4HW2ya1O3jTUpjXdlJAOA7QKOSxDigRHEPE2yTGznNfXQc2OIK
         aOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797359; x=1753402159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFPWUEY/toVDVNd2k/LREoggH1XAsJ0FDgoZbNXOeEw=;
        b=HsFes89C6Re1rGMsfNrfewhHRjMm1Zwy1/cTMiqrFZQ7lqUIqhq1FthYAwUbbQ/d4G
         tlzDeY9D1rjsQXxJ2bxYja+lQy7u5f6fqxxa7quD8f1dIecPNJ/8bLuRPghsmPAkmrdG
         HIiyuuNEKwNh5fIitE0ZsfZXvmp14uYr2F3xUsyO6g23O8Tr/n/QI2VJuPRVQtTlRbBF
         jsdc1P5a8X7UtmL7AA9wSaWSOTRilizP7S39ciygZLKot3Q5oxw9nlN7krUh3+UtPdYA
         QikvWPEuXd0AQwfQyTmPC0kRceFtawHVHCV49Iwf4j4clVd06z5T/KYgZQ9/lTZbbvAN
         3HMA==
X-Gm-Message-State: AOJu0Yw/8jinA3FD2WnayLTP82nSLCkYySRRi+2FITWSTco4wjvVHed+
	60wePqhT9kcoIcKkXb4ctK+aC7y64dCQPsIGjyy1geTpz21OeWUzyczRkC7zwGNH2FmEcINsFgV
	vq0VIlDTF7FiSjt+/FSDfEw0KxtANuNo=
X-Gm-Gg: ASbGncumDHkDQmZM+eHoJtURSLHsWsZS20+r5dV2OOcn50W/xuXV+TiT5bQcOc4HGFo
	pjiUmL46j7A5qNEABS7y0Fp9RjPSaeYdD9baItfSDpbmWLYJvK/Xmt3uv4LIIN0NVX+GQntvpSc
	qu2qELDHBNOBcbvklPkgORj2zhZ/CT61rFm563cx9HM4lcwQp2KhbWBqk2Jy5vA2MnwvpRGd3gw
	EhaQA5dKGby5no3j7E5CHnxnkWAdEDB8tXz
X-Google-Smtp-Source: AGHT+IGYVqyNSH5VcHb5xfEd4kdi0HK7d5DKZtBzqRjqBNAznkd+mV06DBV510d5MK9IAuovfULZzPgCJqPyRuMqsyM=
X-Received: by 2002:a05:6000:4383:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3b60e50ff53mr6669743f8f.43.1752797358393; Thu, 17 Jul 2025
 17:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com> <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
 <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com>
In-Reply-To: <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 17:09:07 -0700
X-Gm-Features: Ac12FXx_Iq-pygiU7pxgIINcF_KXSgBWin1TYT6Y-FBrGuzcHLrtq2k27mccSzc
Message-ID: <CAADnVQL2fZ56MNGFniyjbMRj6BSE0axv9psFp8V7R+uRoUMPVA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > > +#ifndef CONFIG_SLUB_TINY
> > > +     if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> > > +#endif
> > > +             ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_,=
 size);
> >
> > Nit: use IS_DEFINED(CONFIG_SLUB_TINY) to make this look better?
>
> ok.

Will take it back. That doesn't work since s->cpu_slab doesn't exist
with SLUB_TINY.
So I kept the ifdef.
Addressed the rest of comments and will send v4 soon.

