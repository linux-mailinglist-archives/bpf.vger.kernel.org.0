Return-Path: <bpf+bounces-68286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE5BB55AC5
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5869AC8ADF
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5F3BBF2;
	Sat, 13 Sep 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qs+ZNIi9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110F11185
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723787; cv=none; b=RepZMhfVqg4NyaURnTNoTbUXbmqxWFuOyPzuVXdxl7gnsfI9XI4WK71Up3roUGgW0tUY8wpCMR0SEMPplMNSuRmH4WUASZ5hiFexmqEYiYc54lB75tVbkQ2g7t2ysGWLn/LjhxhGEi+ZR4AE5KkOolSgFo0neXZ8MOSWzbqYVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723787; c=relaxed/simple;
	bh=BTGvAihZ6BETdXtXPsW5MVTIa9k2b62N1Fv/ESHFdsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSQ05VByv2k9wPFDEbq4PwJ/Ub695PKbbSCoNLwyORUYF857P4dVkppSf5VLL/JFYJYb1t3Z+W4roVhjam8yVkJZ0HgTU/JZY2wh6Saeh6+SKek4x5T6A8dfls+j610AI8+6UhB0hEqXVQkFXGHK7+2OWYaRra0DuxlSh4Oukx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qs+ZNIi9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b4bcb9638aso104211cf.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757723784; x=1758328584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wan4Z3V9G+Yu/kG1/ZnuX3JBevOSUX+l3Jo1t5U2io=;
        b=qs+ZNIi9z3UaoDKzO826cF1bxxqruuhAguwVLtT3nZB43UrV8s0ciYKU06uWFwSUzQ
         o5geN0MLqJIi3h0p4djtpur0AeFeiDWru3cpo3v8ln8ldQVcWzSBr1AMGnLm8fscRMTF
         7HM6BgS2A7iWxHqFHLJ1tB9jylDhZOlXsp2wTlAUAte3+J+8H+Irpvpkfyz8YikWnKsF
         cKcHFBxclP7fZuJOp4VoLTpHegPn5KW+4oq9ov0wAW1oOFJ744/LzPfc0dnuCytUgXJ3
         q1o2G2tM6WS/ebK6n+5QeZlzSh/XNvqwRKrnZr6OvXrQ2nGjvOxG7V6/Pi57iVWeyik8
         aqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723784; x=1758328584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wan4Z3V9G+Yu/kG1/ZnuX3JBevOSUX+l3Jo1t5U2io=;
        b=QSkTJTyILRi2AISJFEN5lLnu+Rjc6GRiRcSCZXUX8GfRVhazAm+xVD7sPLmb+4XZji
         8a8A33sbG6BQ3dsK1oVfx5bOLaK/QCKOP3SF7Azt2Rr3tn5QoSLgn7V81DWiOyAl+gzT
         xH5XEeTOFlcpnj/nqkA3y+XVzB+yvVTNGTgsrnx0EgjNepCz1oac95m6GkrLa0E6MJVv
         uz3+RZQ8qDcgelyv0P2dHJQ9k1DahKl8sITncYxste833NHdC2fL2HWLLM2g6shCZULH
         MAO6Uo/y41VndERstDxIUxEG3itcqCztBlc7kcPm2pxTejqfc2sP4IrdwqkbCtOdQxx/
         VgeA==
X-Forwarded-Encrypted: i=1; AJvYcCXprYZ83UoZ2XBJRGx35AK+DBKHVLjSw1StZ2CGheHNggoj+ysrOiV6epddaZ9yrNvv5kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rtHi5qjoSlr8OXOVqj+XynZAJJRbX3BqFE5aY86SFIGD9dof
	f8598H/3XrJ3IwxLMcZZjJxmxqjyyGTYkbCq3JaeWVkhY4IqFlblLT75QRsgjtiN8jJAhUHHibz
	3ziQ/8KQQICAvjNXuyc4CO+j5wPNfYdkbhMSHjFSn
X-Gm-Gg: ASbGncsuEiVmkYF9GNQJfkD0pVj9kKcMdctBnWBVdf9s7XZmBb1FloNrDykqP5dHh86
	RB+KNzBhySrY53ekgqZAv4IhahrF4cdzzDJBjcwCEY4uW8mOze67Edgqa/zyWu5N4GEvTzyFYEa
	2pBOZ84FRjhTwK6Daj5EnTckms7eHbQbBdSZfh52RnZ2xOP+cmNyEpcR2fXK/8hfIE5sU0SB2Of
	xiIxGpOiI6sCKML6O3TwVA=
X-Google-Smtp-Source: AGHT+IFjG8vIiW+56UbAo0I3E5fAj5f02Da+QCHTuQCtweYt/HXvNwzme/tdanRWJGZZnJXNkHXrnhitPMAtBKAkNs8=
X-Received: by 2002:ac8:5715:0:b0:4b3:1617:e616 with SMTP id
 d75a77b69052e-4b78c61e620mr1215981cf.16.1757723783978; Fri, 12 Sep 2025
 17:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
 <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
 <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com> <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x>
In-Reply-To: <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Sep 2025 17:36:12 -0700
X-Gm-Features: AS18NWBAOP8pYtIGHCZnkTwegvOoC88LO41POkcXbpJwFGUAlXXbIlzzwU7_iKc
Message-ID: <CAJuCfpHJEUypV2HWRHqE598kr-1Nz_DokMz_UgrUnq8YkFcb9w@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 12, 2025 at 05:07:59PM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 12, 2025 at 5:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Fri, Sep 12, 2025 at 02:59:08PM -0700, Alexei Starovoitov wrote:
> > > > On Fri, Sep 12, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > > >
> > > > > On Fri, Sep 12, 2025 at 02:31:47PM -0700, Alexei Starovoitov wrot=
e:
> > > > > > On Fri, Sep 12, 2025 at 2:29=E2=80=AFPM Shakeel Butt <shakeel.b=
utt@linux.dev> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov =
wrote:
> > > > > > > > On Fri, Sep 12, 2025 at 2:03=E2=80=AFPM Suren Baghdasaryan =
<surenb@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <sh=
akeel.butt@linux.dev> wrote:
> > > > > > > > > >
> > > > > > > > > > +Suren, Roman
> > > > > > > > > >
> > > > > > > > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starov=
oitov wrote:
> > > > > > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > > > >
> > > > > > > > > > > Since the combination of valid upper bits in slab->ob=
j_exts with
> > > > > > > > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > > > > > > > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic =
sentinel
> > > > > > > > > > > instead of (1ull << 2) to free up bit 2.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > > >
> > > > > > > > > > Are we low on bits that we need to do this or is this g=
ood to have
> > > > > > > > > > optimization but not required?
> > > > > > > > >
> > > > > > > > > That's a good question. After this change MEMCG_DATA_OBJE=
XTS and
> > > > > > > > > OBJEXTS_ALLOC_FAIL will have the same value and they are =
used with the
> > > > > > > > > same field (page->memcg_data and slab->obj_exts are alias=
es). Even if
> > > > > > > > > page_memcg_data_flags can never be used for slab pages I =
think
> > > > > > > > > overlapping these bits is not a good idea and creates add=
itional
> > > > > > > > > risks. Unless there is a good reason to do this I would a=
dvise against
> > > > > > > > > it.
> > > > > > > >
> > > > > > > > Completely disagree. You both missed the long discussion
> > > > > > > > during v4. The other alternative was to increase alignment
> > > > > > > > and waste memory. Saving the bit is obviously cleaner.
> > > > > > > > The next patch is using the saved bit.
> > > > > > >
> > > > > > > I will check out that discussion and it would be good to summ=
arize that
> > > > > > > in the commit message.
> > > > > >
> > > > > > Disgaree. It's not a job of a small commit to summarize all opt=
ions
> > > > > > that were discussed on the list. That's what the cover letter i=
s for
> > > > > > and there there are links to all previous threads.
> > > > >
> > > > > Currently the commit message is only telling what the patch is do=
ing and
> > > > > is missing the 'why' part and I think adding the 'why' part would=
 make it
> > > > > better for future readers i.e. less effort to find why this is be=
ing
> > > > > done this way. (Anyways this is just a nit from me)
> > > >
> > > > I think 'why' here is obvious. Free the bit to use it later.
> > > > From time to time people add a sentence like
> > > > "this bit will be used in the next patch",
> > > > but I never do this and sometimes remove it from other people's
> > > > commits, since "in the next patch" is plenty ambiguous and not help=
ful.
> > >
> > > Yes, the part about the freed bit being used in later patch was clear=
.
> > > The part about if we really need it was not obvious and if I understa=
nd
> > > the discussion at [1] (relevant text below), it was not required but
> > > good to have.
> > > ```
> > >         > I was going to say "add a new flag to enum objext_flags",
> > >         > but all lower 3 bits of slab->obj_exts pointer are already =
in use? oh...
> > >         >
> > >         > Maybe need a magic trick to add one more flag,
> > >         > like always align the size with 16?
> > >         >
> > >         > In practice that should not lead to increase in memory cons=
umption
> > >         > anyway because most of the kmalloc-* sizes are already at l=
east
> > >         > 16 bytes aligned.
> > >
> > >         Yes. That's an option, but I think we can do better.
> > >         OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
> > > ```
> > >
> > > Anyways no objection from me but Harry had a followup request [2]:
> > > ```
> > >         This will work, but it would be helpful to add a comment clar=
ifying that
> > >         when bit 0 is set with valid upper bits, it indicates
> > >         MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it =
indicates
> > >         OBJEXTS_ALLOC_FAIL.
> > >
> > >         When someone looks at the code without checking history it mi=
ght not
> > >         be obvious at first glance.
> > > ```
> > >
> > > I think the above requested comment would be really useful.
> >
> > ... and that comment was added. pretty much verbatim copy paste
> > of the above. Don't you see it in the patch?
>
> Haha it seems I am blind, yup it is there.
>
> >
> > > Suren is
> > > fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). With thi=
s
> > > patch, I think, that condition will need to be changed again.
> >
> > That's orthogonal and I'm not convinced it's correct.
> > slab_obj_exts() is doing the right thing. afaict.
>
> Currently we have
>
> VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS))
>
> but it should be (before your patch) something like:
>
> VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS | OBJEXTS_ALL=
OC_FAIL)))
>
> After your patch, hmmm, the previous one would be right again and the
> newer one will be the same as the previous due to aliasing. This patch
> doesn't need to touch that VM_BUG. Older kernels will need to move to
> the second condition though.

Correct. Currently slab_obj_exts() will issue a warning when (obj_exts
=3D=3D OBJEXTS_ALLOC_FAIL), which is a perfectly valid state indicating
that previous allocation of the vector failed due to memory
exhaustion. Changing that warning to:

VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
OBJEXTS_ALLOC_FAIL)))

will correctly avoid this warning and after your change will still
work. (MEMCG_DATA_OBJEXTS | OBJEXTS_ALLOC_FAIL) when
(MEMCG_DATA_OBJEXTS =3D=3D OBJEXTS_ALLOC_FAIL) is technically unnecessary
but is good for documenting the conditions we are checking.

