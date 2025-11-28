Return-Path: <bpf+bounces-75695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB5C91ED5
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584993B0704
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F538320A02;
	Fri, 28 Nov 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCtEQTKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5156313540
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331055; cv=none; b=olXOq6XXoTLS2ZjNSyNaWi+wAwd26zMm+Z0LkRgwQ6WZjrXW1vPSee0LAmCxeN961DA/7SqvcoSjZAKcqxJwJruVumBxh5SVSBA+q8ERTn3IojMbVj7MN+hMHOk3xRPjeanMQqGIGw5yuBRcQzEzhbF1OPHQNChxM2DVJUhsBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331055; c=relaxed/simple;
	bh=L4xgNVZ65zB7BRE9fG0oMucfexLw054vBDKC6nOeuko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSPyNJp+R5HsGVce2Wd4ec16CB+8fceTax4lh4qzPDGYWjGTUH3EmZx5yqpLlDHohZOsk19Za+zv+5puRzD+E5bA5Z5ip0+Zl7En47wtZfUKMh9ZwzR6Nze6g38nqzzyACvOMVqaWOuY+tirUTgbTlIkD24lqiroEMQm/s/JIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCtEQTKf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-641e4744e59so1824750d50.2
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 03:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764331053; x=1764935853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSoz5mQr0C5gRN2Ge/i9Yo5+y9sk31wpTRrQrK2SkC8=;
        b=PCtEQTKfWJy4u4bdtJnQANHUTtgSkteQCD3v4MHMXohCWwMfBE6Kk3t3xzrYaezydy
         kJ+g2swSKvBvhmcbjbnUsFWxJkT+8YK/hgLyMY1e2nz7S2z7r21IgrTLXLnRxCZMK5up
         MQdoXhjNTme7KJ1JBCAnE2R1v15m9whjjIEsrg1rd3ueaOKRA4zsyvHEhTorZlfnSvum
         98T5CEiRb3L9EQPUcJu8TDNiy3Z6EoapoKKzYSt5enK/p//FztXMIyS39ahDGM3uO1mi
         kihs2yNPuE26G/CGxzYMyFpnA4GsvF1QQNdKv3Cxxyudp/b8KLe4c/GMZ9lCxgpiIFlA
         j/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331053; x=1764935853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSoz5mQr0C5gRN2Ge/i9Yo5+y9sk31wpTRrQrK2SkC8=;
        b=gLmatb3aUUmZjz8Isy8uauVzI0MvWW2VbyfSknFynwU0k7P2MVbgfIdfEeUG1I+jfC
         sGvUarV+DYzKx5TImPp7gjtvIxjFruCFwj5E6ODrJ6MsArFfeMK/EyNEdG1ZFWjiW8Ta
         uCFmNRwQGFqjuqlLCmUoODHbFvbnjXP0yEJzgNoZ840axDw7O22Z42A3xQu7snzvOC0s
         u6+KdKU8giBvMwPWHbq1SFX8C6pE5wE2sboIS5nimx6Lp0Yex6Mr5CmXLz6qGrhwhTXQ
         igxPSZNOkBDpsZ2wr5xzCksgovCbA75xChcHbHhoFDVXjdFC/G0h4w2icWGBokBKilJ/
         eNqA==
X-Forwarded-Encrypted: i=1; AJvYcCU1/iS7afnqeyfkJl/DMr1WfdjwzvdnE2sPtuD4szG5Kl4Fc7U2l3kTdn7CSFdkHECA0Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxypn2kUTSrbIeoz1+9u33Vw+GleCnXjjaM+JrSdmesypbR3fQj
	u/D5VqyJ+jwsd4/KkjhbEx/kcm9dG1rerDFIFr+N0xlr25rcO7TwiaTAThlBpdZxWOdH6YjyF8P
	jFntwn3rZQJKgZ5FBV2pxHX9BlDxOgTY=
X-Gm-Gg: ASbGnctBSCcOkzuqjcazbzlr/09/LkBDC7F2EAZfeI5tr2zrPvddcA6ZdYOnHXLDCk6
	jdX+PSSc01tBhl0pbtZ0+pwfREWFx7tQ29xnk+sGzMFRznAYdZl8Nsc2UU4d8ybvocZKFSx62py
	UQTl8Bm5cWtFq99BoWg5YHzbiLx0nORoS0l+J/WLj8CkSMHxML/eTuE3Y9MrsAGLaAedATlABwT
	0zGD3V7hOun6DvMYX4O8ZBUovkuGTdL+ndkGjKI0LefQM8snmDxKGw4Nn1cDkbZqqibZTVr
X-Google-Smtp-Source: AGHT+IFRUZUm0H2b+bWVRr2BWpWoFVKWpDn3PfEUe6fVjR2EnnNFYAQAFqsnu6tHnPe8vua5E8J/KHecd//puPJ1jS8=
X-Received: by 2002:a05:690c:fd5:b0:786:6ea6:aead with SMTP id
 00721157ae682-78a8b529371mr246113467b3.38.1764331052571; Fri, 28 Nov 2025
 03:57:32 -0800 (PST)
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
 <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local> <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
 <f60522c2-e10f-45b1-9501-9b1e4223d8ce@lucifer.local>
In-Reply-To: <f60522c2-e10f-45b1-9501-9b1e4223d8ce@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Nov 2025 19:56:48 +0800
X-Gm-Features: AWmQ_bnqWwXTq4TuyG2RQq6Xi3n6bW3cclMnGJoiJQyROyofbb3HErIQ1NShStw
Message-ID: <CALOAHbCVGX3C6mbbH+e5bB2=Cnz-UVbEVBXZWP3fvhqGe9LSXg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
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

On Fri, Nov 28, 2025 at 4:31=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Nov 28, 2025 at 04:18:10PM +0800, Yafang Shao wrote:
> > On Fri, Nov 28, 2025 at 3:57=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > TL;DR - NAK this series as-is.
> > >
> > > On Fri, Nov 28, 2025 at 10:53:53AM +0800, Yafang Shao wrote:
> > > > Thank you for sharing this.
> > > > However, BPF-THP is already deployed across our server fleet and bo=
th
> > > > our users and my boss are satisfied with it. As such, we are not
> > > > considering a switch. The current solution also offers us a valuabl=
e
> > > > opportunity to experiment with additional policies in production.
> > >
> > > Sorry Yafang, this isn't how upstream works.
> > >
> > > I've not been paying attention to this series as I have been waiting =
for
> > > you and Alexei to reach some kind of resolution before diving back in=
.
> > >
> > > But your response here is _very_ concerning to me.
> > >
> > > Of course you're welcome to deploy unmerged arbitrary patches to your
> > > kernel (as long as you abide by the GPL naturally).
> > >
> > > But we've made it _very_ clear that this is an - experimental - featu=
re,
> > > that might go away at any time, while we iterate and determine how us=
eful
> > > it might be to users in general.
> > >
> > > Now it seems that exactly the thing I feared has already happened - p=
eople
> > > ignoring the fact we are hiding this behind an, in effect,
> > > CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag.
> >
> > Thank you for your concern. We have a dedicated kernel team that
> > maintains our runtime. Our standard practice for new kernel features
> > is to first validate them in our production environment. This ensures
> > that any feature we propose to upstream has been proven in a
> > real-world, large-scale use case.
>
> This strictly contradicts the intent of the config flag. I seem to recall
> asking to put 'experimental' in the flag name also to avoid people assumi=
ng
> this is permanent or at least permanently implemented as-is. But this
> iteration of the series doesn't...

Ah, I understand your point now.

The CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag was changed in v9:

  https://lore.kernel.org/linux-mm/20250930055826.9810-1-laoar.shao@gmail.c=
om/

The change was suggested by Randy and Usama:

  https://lwn.net/ml/all/a5015724-a799-4151-bcc4-000c2c5c7178@infradead.org=
/

At that time, you were on holiday, so you may have missed this update.

>
> I no longer believe this flag achieves the stated goal, which is to give =
us
> latitude to make changes in the future based on internal changes to THP
> (which so sorely needs them).
>
> I fear we will end up with users depending on it should we ship any form =
of
> BPF hook that we aren't 100% certain is 'future proof', so it raises the
> bar for this work very substantially.
>
> So I am really of a mind that we shouldn't be taking any such series at
> this point in time.

understood.

>
> >
> > >
> > > This means that I am no longer confident this approach is going to wo=
rk,
> > > which inclines me to reject this proposal outright.
> > >
> > > The bar is now a lot higher in my view, and now we're going to need
> > > extensive and overwhelming evidence that whatever BPF hook we provide=
 is
> > > both future proof as to how we intend THP to develop and of use to mo=
re
> > > than one user.
> > >
> > > Again as David mentioned, you seem to be able to achieve what you wan=
t to
> > > achieve via the extensions we added to PR_SET_THP_DISABLE.
> >
> > We see no compelling reason to switch to PR_SET_THP_DISABLE. BPF-THP
> > has proven to be perfectly stable across our production fleet, and we
> > have the full capability to maintain it.
>
> Again, this is entirely your prerogative, but it doesn't imply that other
> users will need this feature themselves.

Right, we=E2=80=99re not trying to force anyone else to use it.
We=E2=80=99re simply sharing our use case with upstream.
It=E2=80=99s up to the maintainers to decide whether to accept it.

>
> >
> > >
> > > That then reduces the number of users of this feature to 0 and again
> > > inclines me to reject this approach entirely.
> >
> > I understand your concern. Our intention is simply to contribute a
> > feature that we have found valuable in production, in the hope that it
> > may benefit others as well. We of course respect the upstream process
> > and are fully prepared for the possibility that it may not be
> > accepted.
>
> Right.
>
> >
> > >
> > > So for now it's a NAK.
> > >
> > > >
> > > > In summary, I am fine with either the per-MM or per-MEMCG method.
> > > > Furthermore, I don't believe this is an either-or decision; both ca=
n
> > > > be implemented to work together.
> > >
> > > No, it is - the global approach is broken and we won't be having that=
.
> >
> > Let me rephrase for clarity: I see the per-MM and per-MEMCG approaches
> > as compatible. They can be implemented together, potentially as a
> > hybrid approach.
>
> OK sorry I think I misread this/misinterpreted you here - the objection w=
as
> to the global approach.
>
> Yes sure perhaps we could.
>
> I mean we end up back in the silly 'THPs are not a resource' argument the
> cgroup people put forward when it comes to memcg + THP (I don't
> agree...). But let's not open that can of worms again :)
>
> >
> > --
> > Regards
> > Yafang
> >
>
> Sorry to push back so harshly on this, but I do it out of concern for our
> future ability to tame THP into something more sensible than the - frankl=
y
> - mess we have now.
>
> I feel like we must defend against painting ourselves into any kind of
> corner worse than we already have :)

Understood.

--
Regards

Yafang

