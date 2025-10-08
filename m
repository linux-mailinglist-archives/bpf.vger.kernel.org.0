Return-Path: <bpf+bounces-70576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FDBC36D7
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 08:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4464EF17C
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 06:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96412EA157;
	Wed,  8 Oct 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsJdpOkP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6371217704
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903393; cv=none; b=WgKCHxzDkfrRQjqfXFW3EZH/26lasM6CrZ+6w2Yb2F6af/mAAgRLPvQEMrTLIdVJoo6u9o2Ysr9B9jjN7e34ztP4JzhIKzuSttUkMGefazXt7zjHAePtm/3wfjjh9bbsdZCcSlYdgNSm61lFFfyjHobOCv6jobljDBl9JDYp4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903393; c=relaxed/simple;
	bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCa10+pz5UA+MkPsOcWRZITkzX5toF2r68fNElOj+6j3jBNp5/MjjqbDjKMptLoBc6Er38zc+pKC4fweym7FW7C0+Yn2zZ+0pVmVnWzeruIUZrfvtkqtng4Ov1pkaLeQ00Bf2TckVDZmhhvjomVfqlPPkWe8dZ/wkr1u0PCZlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsJdpOkP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78ea15d3489so62797446d6.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759903391; x=1760508191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
        b=GsJdpOkP8MRfjMzGckrnB3l3AUBEp0HfYB3e35W+1/zYf7QYsLkFYlh1NP34nQscsf
         mDj5Y9DCnXRWTi2oBr2rFOl4I4D4tj29V1Zspwywy8RkiaLW9CUHKUHNPeTyFWVebCWd
         7z65TO2lpJmIi5F61KYi3p4utocKlEHJMM0XJcD34bHfut0NjbUo5iDNV2ixCnmINhiz
         Yl/QVmZoTrRy+ewJFefaUXF3wo69BXsk/3c2u6xFQejLY2wdQnj5Edn/EzY0TLMehJPw
         4RFUkhwlg8ylyZ0wNdCWYpjKd7Xli54lbDLtVk5wfGU6uvlEAfQ3r9Jua8QLi7JRAXwY
         rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759903391; x=1760508191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBzereJRTdGWw5Bv4VX5a6USN6lK2ZJ/saFJPUjeViY=;
        b=oln2mG5ITm3OOIIhNhdhTEJLYnPtVASzxUhIHAg71OPnTlf+cy3+I4HryMzMXI1ZDB
         dRa/Um0h5FFoLOdvIVm7N5teBOSPOcNC0zEJomRk6m33CZOq/c0WY4XLLJwqwNCq8cvu
         QZkDz8rAP+D97ZBsWKRtQT+G9pNWc0hEvTwloM+nz1A7Z+36M3l4qdqKKSWYyPWEuScj
         FPTiZCoZHITU+H2darX1VoJhIGSv+kiI2+0yVZvZF8tX1+6Odg7mvo04RGWt2QZk7G88
         bviRvDdpK8rUcqqrKrL4DaZA38wHIq5sOg7t3cQmpvLyCzW99tYxwDaKnc+ArafFWS+Y
         gZXA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/v5mpvOF1p/CMKONVevSJqLK87VZkZ0wg6hLFhkZY5W7XPWSjfxZJlP0xhRwKU3Awyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6BwhbybSHZmIxQVWkICvms0KmafcH1QsH/wv0nsomaB9vO/Q
	aFQyJmfr7oiTpKfeXN29C9zDlvL9jmFq0KWo7w+I1vUuRvTH9g4Nw064wjDvx7a40ryrMV+my0Q
	vWch95/vX1xmMsH2kcZhCsc5R5sn0Sa4=
X-Gm-Gg: ASbGncurO/fD1oURhItqkoakTDPxSAfpOwOgux8K1DrMnnNEHnfz5zauuW2ULzaTkL3
	F6jcNn5AksA8zJITvClt3lqBKrFXCSizrQIOe2Un8TxL0Z8v3H/8wrBwq5Mx1x6kjs5NM4q9EDg
	BhQPwZmjxRLoLh+VIVNMbzrQp2aylVA61v/3smISevvABlgbd2Q+VEZsVUKWxHIIpW4MPXLUUVG
	aKAyXHA6I86GMslOw8dkpEU6uEUwGcjNT+2WiMnz8z+IMSR2aRkY8HG52lliPXPF/Wa1+hVCgM=
X-Google-Smtp-Source: AGHT+IGN1fUle74mm+Dey9XN+9R2Hgx9711f1pzgYvQjJUJA/sik2SzgKknv0h0WalhCBF/jq/ow+URmBR5p54sJHtw=
X-Received: by 2002:a05:6214:2a8a:b0:785:c20b:f602 with SMTP id
 6a1803df08f44-87b2ef94a07mr29281856d6.61.1759903390435; Tue, 07 Oct 2025
 23:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
 <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com>
 <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
 <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com>
 <CALOAHbBzS2RunZzEk8-rkU60M8jKEJ8FwiPgZqNeoXDy++L5hA@mail.gmail.com> <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
In-Reply-To: <CAADnVQKLbc4iZDGWbbhqwr8hKhAZhyLjiZuuz_RBd2f9LH45rQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 14:02:34 +0800
X-Gm-Features: AS18NWB7YAjB1_r1_mFRyGxWlvWmvmCic0bUl2k22vQ5MpJjGUViYxml_XAQVh4
Message-ID: <CALOAHbCOQ_S-b+8pMxwGsjoc9QnAdij=gjkPEm0--cR7iCRQ3w@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Wed, Oct 8, 2025 at 12:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > > > has shown that multiple attachments often introduce conflicts. =
This is
> > > > > > precisely why system administrators prefer to manage BPF progra=
ms with
> > > > > > a single manager=E2=80=94to avoid undefined behaviors from comp=
eting programs.
> > > > >
> > > > > I don't believe this a single bit.
> > > >
> > > > You should spend some time seeing how users are actually applying B=
PF
> > > > in practice. Some information for you :
> > > >
> > > > https://github.com/bpfman/bpfman
> > > > https://github.com/DataDog/ebpf-manager
> > > > https://github.com/ccfos/huatuo
> > >
> > > By seeing the above you learned the wrong lesson.
> > > These orchestrators and many others were created because
> > > we made mistakes in the kernel by not scoping the progs enough.
> > > XDP is a prime example. It allows one program per netdev.
> > > This was a massive mistake which we're still trying to fix.
> >
> > Since we don't use XDP in production, I can't comment on it. However,
> > for our multi-attachable cgroup BPF programs, a key issue arises: if a
> > program has permission to attach to one cgroup, it can attach to any
> > cgroup. While scoping enables attachment to individual cgroups, it
> > does not enforce isolation. This means we must still check for
> > conflicts between programs, which begs the question: what is the
> > functional purpose of this scoping mechanism?
>
> cgroup mprog was added to remove the need for an orchestrator.

However, this approach would still require a userspace manager to
coordinate the mprog attachments and prevent conflicts between
different programs, no ?

>
> > My position is that the only valid scope for bpf-thp is at the level
> > of specific THP modes like madvise and always. This patch correctly
> > implements that precise design.
>
> I'm done with this thread.
>
> Nacked-by: Alexei Starovoitov <ast@kernel.org>

Given its experimental status, I believe any scoping mechanism would
be premature and over-engineered. Even integrating it into the
mm_struct introduces unnecessary complexity at this stage.

--=20
Regards
Yafang

