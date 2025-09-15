Return-Path: <bpf+bounces-68397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1FB58011
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B0D1A223B5
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEB32A83C;
	Mon, 15 Sep 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1T+KQ85I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2805324B01
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948801; cv=none; b=atIPDcNoWVb/QrGAWRoTBpbfzU+xCTbOiCFxr74Ak3VcfEzMadO81pFhznG6gvWwh4P2uGGyUquy38+DayopncStOr7krZJ8t9/aViVYrNMwzIpjlu8mimzz7Ow7qWMlKtqEFBUPmkwTOSwlDlGzfJC8FRWGJWJkC+VN0xcRErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948801; c=relaxed/simple;
	bh=z9WWi/ihcO4oKOZe+uMVsUK9rCWPwUBkVuax2VPkCyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEgWsLgPzTO1203RsujlBoH7yLZP+Ygqe3khkWoG5DEwqSDaW6thYrmlxVF8AQOK1fZgP8dTeJKQ3iKJsTNes2ktJ6WenMvNmwggyItXk941N84E2LYaoweHTOgvB8P1OQBiF7dlBVjGggpU03LP53UheJ3RO3JVfghNcLW9yEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1T+KQ85I; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f37300fcbso7781a12.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757948798; x=1758553598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9WWi/ihcO4oKOZe+uMVsUK9rCWPwUBkVuax2VPkCyw=;
        b=1T+KQ85IGvYxptojX1Poy1U+SLGD1YavbmsJZ4MK0Vx6VHLybpMSnxLf1zzOAHtKvt
         ow97z2ifRNzJYA2cnzoMc7SdBDyQtc9N9XS8ygRyQWPwkzvRo2QZpPJVEHWVrW8n7v62
         FZQnfo/aT/bpAmLs348neK8qS9dYb0D6tpXaWE34Y2/vt2cOiRk1g81BSzyOLpGyV99F
         OiqKKBEHxib2BOdQ1NeBZ+VqFOBA7rWbXN4/7ub3HEPpi14gixKO390A+0JNW9pD69LG
         KCXbJf5GHt8eOShqK0KPXciw5AMSEU1ZZPmafrO9FJlal3V5eeoONp+tb7PQ5QwijOjg
         0jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948798; x=1758553598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9WWi/ihcO4oKOZe+uMVsUK9rCWPwUBkVuax2VPkCyw=;
        b=J7d2JxA2rd5OemHk3jIPD9VzBoN6W6bso5kVN4RKLJNo2AkbOVMzTvzhKic5EFhwfY
         WFDmGPNPQsReLhcOBsmlkf6dlOGjqAk6V8Pid1EfpwGWnbFSi2NK38kxmSc5ETZOQkiO
         UmkWhlYfrehlcN/a/zvEAhMTIGrEWTNp+ksrjtmuF0Bi74gokTYXFRFG1An3K+mdcSX/
         j1dnlkUzl6sMZkDt5jezmvi0srot6HjFtKdFjozHfhKld0qnX319Frjb/izTYUMs1ojD
         jvW28FgZ3z/93uv9SvTJAYknukhIGUGK+ygtqi3JzZ15xTqie2oYUp6q7oLc+2SPKQCe
         RPsw==
X-Forwarded-Encrypted: i=1; AJvYcCVr0nyloXVMWyPSb1go9OjfH0yAt4Ftw8YivTXLwOKaU9WQEuJk4xmzSUSxDG/mO2sdKtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDKdM8UnF+hUk1ri2Y8Xis3QaNR/uyqcLXEYgBxP3ox3YP+a/
	3NWwS9PqSbB/us6A01or1RJ8mRFY66+8nFl4DXUQtFAZrI39u/vPrFqwhjhzIBFEmOTDFtzdmga
	qPAFZew2eGtZVyuMZmmaeAh/Ul0wI9Mt4PnIyLAh36mgju2cZNnoLvTzR4QY=
X-Gm-Gg: ASbGncsUEKtEZ9HQa47F5zYY/K4EVIIwoOeT7K5xMFdps9onMH1Wac4h2YyBRlvAmQM
	ZQuGsZlTrzpwTtCaWzsJFlSydzxIp/dMJ94m4gquoyi0P4VegaCocvpajJNk6llzLvaPXuYdTBg
	9XGMnMAQT3WuNXzvGx9G246Q8dKki3W5vGPmu459qaBOYkG/Oyl3TCHRlmVIoZoOsCyrdq3j2ut
	2rMoxjcFuMm
X-Google-Smtp-Source: AGHT+IGjXi1PFjJ4mYxVJND0ubUCMLSxglAxJpNOn5/9ShV7QOetbvNvu0dB8FJs+cORTcGH5C8xzIQjtHMDsoJbcW8=
X-Received: by 2002:a05:6402:562f:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-62f02779419mr123720a12.7.1757948797375; Mon, 15 Sep 2025
 08:06:37 -0700 (PDT)
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
 <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
 <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x>
 <CAJuCfpHJEUypV2HWRHqE598kr-1Nz_DokMz_UgrUnq8YkFcb9w@mail.gmail.com>
 <CAADnVQJQo6+AwJ_LxARVu37J-5T-7tyn1kA5hMVDGDfEyjF6mQ@mail.gmail.com> <e166705a-e838-4c8f-a8cf-64913e120caa@suse.cz>
In-Reply-To: <e166705a-e838-4c8f-a8cf-64913e120caa@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 08:06:24 -0700
X-Gm-Features: AS18NWB87vwLHWOm_ZFhLCV5OSwUHRhJoQJhrbB2IlJ2yzZsuK8epBGSVT0Yb4c
Message-ID: <CAJuCfpGR2tHhUu=p4X2YKPNot4TJbhuFPRiT8BgOHvtcw=j-Ug@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:51=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 9/13/25 03:12, Alexei Starovoitov wrote:
> > On Fri, Sep 12, 2025 at 5:36=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> > > > Suren is
> >> > > > fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). Wit=
h this
> >> > > > patch, I think, that condition will need to be changed again.
> >> > >
> >> > > That's orthogonal and I'm not convinced it's correct.
> >> > > slab_obj_exts() is doing the right thing. afaict.
> >> >
> >> > Currently we have
> >> >
> >> > VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS))
> >> >
> >> > but it should be (before your patch) something like:
> >> >
> >> > VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS | OBJEXT=
S_ALLOC_FAIL)))
> >> >
> >> > After your patch, hmmm, the previous one would be right again and th=
e
> >> > newer one will be the same as the previous due to aliasing. This pat=
ch
> >> > doesn't need to touch that VM_BUG. Older kernels will need to move t=
o
> >> > the second condition though.
> >>
> >> Correct. Currently slab_obj_exts() will issue a warning when (obj_exts
> >> =3D=3D OBJEXTS_ALLOC_FAIL), which is a perfectly valid state indicatin=
g
> >> that previous allocation of the vector failed due to memory
> >> exhaustion. Changing that warning to:
> >>
> >> VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
> >> OBJEXTS_ALLOC_FAIL)))
> >>
> >> will correctly avoid this warning and after your change will still
> >> work. (MEMCG_DATA_OBJEXTS | OBJEXTS_ALLOC_FAIL) when
> >> (MEMCG_DATA_OBJEXTS =3D=3D OBJEXTS_ALLOC_FAIL) is technically unnecess=
ary
> >> but is good for documenting the conditions we are checking.
> >
> > I see what you mean. I feel the comment in slab_obj_exts()
> > that explains all that would be better long term than decipher
> > from C code. Both are fine, I guess.
>
> I guess perhaps both, having "(MEMCG_DATA_OBJEXTS | OBJEXTS_ALLOC_FAIL)" =
in
> the code (to discover where OBJEXTS_ALLOC_FAIL is important to consider, =
in
> case the flag layout changes again), and a comment explaining what's goin=
g on.

Yes, exactly what I had in mind.

>
> Shakeel or Suren, will you sent the fix, including Fixes: ? I can put in
> ahead of this series with cc stable in slab/for-next and it shouldn't aff=
ect
> the series.

I will post it today. I was planning to include it as a resping of the
fixup patchset [1] but if you prefer it separately I can do that too.
Please let me know your preference.

Another fixup patch I'll be adding is the removal of the `if
(new_slab)` condition for doing mark_failed_objexts_alloc() inside
alloc_slab_obj_exts() [2].

[1] https://lore.kernel.org/all/20250909233409.1013367-1-surenb@google.com/
[2] https://elixir.bootlin.com/linux/v6.16.5/source/mm/slub.c#L1996

