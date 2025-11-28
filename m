Return-Path: <bpf+bounces-75686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C885BC911FF
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EA83AADF7
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778B52BE05F;
	Fri, 28 Nov 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYGHo0Rw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557922DC79D
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317931; cv=none; b=lojI4AaFAAuuaMd5HuL9pLE9devw7zqEUT4hn7DUqKnjyk072fknNlV9nLGweRXshBcplfpcQjdcRVrTRduBlK10tEWrSWX5UwhUMOY+3+voYH9IJl8jSxgJJbXLmIEAP2t6WTwNgZuNcdKzFo6CjSBdOQCkgwoBabuYvMkYEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317931; c=relaxed/simple;
	bh=El+DHDdiu4HEs/8uueXLQseM6o0zWxW5fRbqDOUC3Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzXImRawV1766L90QJcF4/83g8lrL3tIloER8yvilavaOy8yC+U3GDAg5Z7SYX9U5mdNtdpsA1HsW4PFPPkQ4up2HB9yk9/w3+fDkdmkuVGpJUI6JHnf0yBTyMzN3YWMF0qGyVTbucDJt6Q+U/lY8oNpYlESayHNNfqG4KIli6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYGHo0Rw; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e19642764so1137607d50.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317928; x=1764922728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El+DHDdiu4HEs/8uueXLQseM6o0zWxW5fRbqDOUC3Q4=;
        b=BYGHo0Rw19xuLctnAfurxFeFP9Ul8zCIQoTiYXOxKLuqOB9SiUA5JRQ1s1GScsqvyk
         kTnaopJj4uGzNn22NiE1FN/TlNdmA6DlIvRbAV6k4qb6uBfu/O86A8mokEC764jusY5p
         NUReuLWj0Cyvv8uwAliPa0PWH+nVXjUBNaenOmArCX/fQ7YrEKN82d7zVeMICRAmOOAP
         v+y5RJdbtqex2qwVaKpdDfx689NW1e5DAYeJv4r8FzbQVJjWBivokp1u+/WL6aPU4AVz
         NYGY+xlGj2uYE1V12I13vm9upqSX++MFGGV/zh0aVSv6HIky++uN0eY8jx2eXxeDAhA6
         /WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317928; x=1764922728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=El+DHDdiu4HEs/8uueXLQseM6o0zWxW5fRbqDOUC3Q4=;
        b=gKdSjIl3J/+TGbsQKPCWdWLGsQQKmQBHwlZeLOYy7Q5S3WjUIubWGuWOuKEqCY3VCy
         2wNZiX4eifwETuXCNX96YECqwD6pF+qU7I6nSfPRbTKKPVuiebECZTXXL0/Gh6tIh9UD
         WVPENzgbuNxhIgNlcClJpqP0+iKlz2dvtVmXOdkzpKqu+Mc4Na6dG0GYXq5rv7pTy9aS
         Aj743CsieqPaJATh0ic2KUbC9DRmOMrZEkRYX9xums//PFJtVCr/22uqB4QzMnenqequ
         bG7nQgokpU+0lVhfdWH2Yq94KaUA7y+6Tec1sNi4+eg2ZTdiXuz0UcUROknZUNMQGDVG
         wGqA==
X-Forwarded-Encrypted: i=1; AJvYcCVwF2+FjtG2357aYtbAvGQdS8J/Go8x4KbJKm5M5sE3m0hRjkrDA9a6wUf/pXm/Ge7F+8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkpJEsE7/Fu2rrNK/t1sFxh8QtWDDdMpASe17jc38E+/LTkkX
	dWk5hFZP4pp0BlTuOGVPsRJM0CkmiWHHI7CiC1A+GCxLx7hm4Z+VAswAfd9cW/XJQ9kKkYlS03l
	gCJ9Yw/SV6dNiXZWg/ItyjQTET+Ui5m0=
X-Gm-Gg: ASbGnctVV60/NWeyBdRQgxU3vBonb/tyq3e7Z/f9UcEzi0v0BzrSXqi2qazGn08fkCh
	fEUJApW+NKq02ZHntiRi+E65EIxGgupIwnhum4K610HBbX2pmGKgLVS3sf9NSlDUAqfQZ6cVYO6
	+9oTj/Xboubfxl2uisOjndpvnd2dTUyB6xMPUF0vxAy6oF7Gus50dCNvDI1qaD6hGDD/upHjUq+
	zR3rkwE5bYsLWoLzu3LQtOhSpybsRa0aFt8P0SnjTkdrtzqDPEwESfGbedSOjUqhFQT0kRd
X-Google-Smtp-Source: AGHT+IH7ZIRX3n+soL0DbxqkevgQ8TnMBFNiXExpRFGs92A8/MBZOgZWt5uwDwEOF1ptbv4DflBTQ0ByEzHecDfr17o=
X-Received: by 2002:a05:690c:368d:b0:788:20a1:4895 with SMTP id
 00721157ae682-78a8b49758fmr220819517b3.22.1764317928293; Fri, 28 Nov 2025
 00:18:48 -0800 (PST)
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
 <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local>
In-Reply-To: <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Nov 2025 16:18:10 +0800
X-Gm-Features: AWmQ_bl511PROfTv9XwN26WJ99s_VVN0B0oHDwCXD5Z70W8ZkfNX396eT4h2J60
Message-ID: <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
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

On Fri, Nov 28, 2025 at 3:57=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> TL;DR - NAK this series as-is.
>
> On Fri, Nov 28, 2025 at 10:53:53AM +0800, Yafang Shao wrote:
> > Thank you for sharing this.
> > However, BPF-THP is already deployed across our server fleet and both
> > our users and my boss are satisfied with it. As such, we are not
> > considering a switch. The current solution also offers us a valuable
> > opportunity to experiment with additional policies in production.
>
> Sorry Yafang, this isn't how upstream works.
>
> I've not been paying attention to this series as I have been waiting for
> you and Alexei to reach some kind of resolution before diving back in.
>
> But your response here is _very_ concerning to me.
>
> Of course you're welcome to deploy unmerged arbitrary patches to your
> kernel (as long as you abide by the GPL naturally).
>
> But we've made it _very_ clear that this is an - experimental - feature,
> that might go away at any time, while we iterate and determine how useful
> it might be to users in general.
>
> Now it seems that exactly the thing I feared has already happened - peopl=
e
> ignoring the fact we are hiding this behind an, in effect,
> CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag.

Thank you for your concern. We have a dedicated kernel team that
maintains our runtime. Our standard practice for new kernel features
is to first validate them in our production environment. This ensures
that any feature we propose to upstream has been proven in a
real-world, large-scale use case.

>
> This means that I am no longer confident this approach is going to work,
> which inclines me to reject this proposal outright.
>
> The bar is now a lot higher in my view, and now we're going to need
> extensive and overwhelming evidence that whatever BPF hook we provide is
> both future proof as to how we intend THP to develop and of use to more
> than one user.
>
> Again as David mentioned, you seem to be able to achieve what you want to
> achieve via the extensions we added to PR_SET_THP_DISABLE.

We see no compelling reason to switch to PR_SET_THP_DISABLE. BPF-THP
has proven to be perfectly stable across our production fleet, and we
have the full capability to maintain it.

>
> That then reduces the number of users of this feature to 0 and again
> inclines me to reject this approach entirely.

I understand your concern. Our intention is simply to contribute a
feature that we have found valuable in production, in the hope that it
may benefit others as well. We of course respect the upstream process
and are fully prepared for the possibility that it may not be
accepted.

>
> So for now it's a NAK.
>
> >
> > In summary, I am fine with either the per-MM or per-MEMCG method.
> > Furthermore, I don't believe this is an either-or decision; both can
> > be implemented to work together.
>
> No, it is - the global approach is broken and we won't be having that.

Let me rephrase for clarity: I see the per-MM and per-MEMCG approaches
as compatible. They can be implemented together, potentially as a
hybrid approach.

--=20
Regards
Yafang

