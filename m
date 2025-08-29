Return-Path: <bpf+bounces-66929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA03B3B187
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E18D206B78
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DB21B9E2;
	Fri, 29 Aug 2025 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3UFwnRl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C09184524;
	Fri, 29 Aug 2025 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437357; cv=none; b=kL41R0Q6pG3QmNOODlylxWOD0ZkuOBvu9UpTGMAQK5x8WuP77KNz+aI5NORnb/0kf2oYUBtqAXIEBJiSyDv91M31snfHFW4tyY772GZHHOCJ9KghZDadoFXU8aKsb917aIPfHqJDTzhpB+Im6eX12hmI5sIkw0LbNilXhHi2R5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437357; c=relaxed/simple;
	bh=KzbAE2VJuwRhKDSVM/iO53LZi0SBGogGYFZZC0ve7gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO8wz0pfa7wU2ry0oQ7isRG8FVvL56qncgaw6iSf7rZ9y2GqRVJT28MXSZCFI0au485wzsmmDrpThkmOlNObkWiBVuYms+B3H9JSjRCIJBJBdVZYnvYd3f0s+fsqBfjQ1DpKJ5xO8Vu84xIr9MUMoswHqbW5tS4IygUzpYU9kC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3UFwnRl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70dfa0a9701so12309456d6.2;
        Thu, 28 Aug 2025 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756437354; x=1757042154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFS0xCiAMj/Aabl302HWl4K8lW2JEHc6RtxJGL4xl4c=;
        b=N3UFwnRlXA/jHeM7m5rapwHhSdml6qQhTfGMBV/WoyE+xY22jSOYr37hT3h76kI+fB
         f/Wi13kDHMQjLoYLrJIbZdRJCxluniIJ4O8mrCmizR97LD7vfBreXP2k/qOSl/a4lAU9
         LbP7l/q4PVbQ6R1NsUriZ+q3+UbZWKI58n3swlpYBA+QTaJWOysWkyxtzwnT5aa0JcqE
         oN+9VrYmHQm0O37WrbUvaHexjhSfMam7TsNwE69Y310VZwq8BimsXmzEIKfPyDfYBsnh
         WwfjVlEm2RzS6Gf8mXsI8+tew2OIT9H7jL9q4lDQCkX1J89QQpEdGdveNjM516w1QXYj
         v+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756437354; x=1757042154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFS0xCiAMj/Aabl302HWl4K8lW2JEHc6RtxJGL4xl4c=;
        b=g7Wuhx131eX+2zno3laPMQuboNFbWwkU9p4iRACl9YDFOl25RvT3uaH1lVt24oqInS
         UPfDJUqVJFP/4P/UXxmSritxVQnOiXWkSEEpvOw53/RVpHMVO3uBhTZ2c/kW2NhTD/eW
         elmBjzcqT+RjA4sXHxRvsCk/mKwFw0+X7WZD2GoJbcd7r+XLBNt4NwcaT8elg4JBswOa
         JISyP0mqT1K+J1yKkD5x69k+qjPt1bkY2eJXXCd+0rBHnbi75EGWzV9AH2Jk4tuVEK7f
         5VG5hTiQqBjDwjA6AjQBsriyHgWNIE+Mby6dv0UV0+eYGM2qRiNKJQn1HlJsdJ3OLkbJ
         0r0g==
X-Forwarded-Encrypted: i=1; AJvYcCVdRk2ao+bj5oqLqKY26uvDFiwJJtY9YqzAYdJnaGZ35yW0V8dbaI6oloPNVHTheMsj2GE=@vger.kernel.org, AJvYcCVlC3MTPjFIc+kEx3xigBcTLglClNtfrRZG1vjAxspeUD9lJQNXTC3U2+zVkV+w2OpOczzgDm5h+Cpd@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNQEVzHRQRlQE6bzCAQn8gXogx0P6ujaTjSMwwtMH3NbDCtZM
	DIbXiJdAbDHsMxSQy0BaY1oc603Gxw6QXZBUKnTjD0urQ/uCh9JMbLlPCn4rDH9vt5UU1xsnL7V
	XddXK3kZ28dEmSjX0LeP4+igYv0rixAc=
X-Gm-Gg: ASbGncvSNuWEiHv9O+67REKy8s2jKj6rcG5mhNZ4Th9jrli45GMqRpHJCBLow5FMm7q
	YLl0ZuYBqlEuWqKfT504yoQKZbovCdhqrjxku24YS0sKevX2Y+ff2z4wrZwJHrHLStvPWeQI4pn
	QJTixEP1x272bPzjx1ViiX7j3Uts1aDo7hmvKx/lte7PR2jjgFzPR7OqjtQ7+JyeU7z8000QGAV
	fbA/7mr6sMhn9mvBF6hqaNptGzbdQXA99SHuTbbv/7btP9RrSs=
X-Google-Smtp-Source: AGHT+IFFAjUELcmzEUUIYc8SHA/xvC9uJFbqt/nPTvZ1yb5BBrEZja9lEGaS63h6U3LHxjGEGcjgnnXdq8S/DdNl+yo=
X-Received: by 2002:ad4:4e13:0:b0:70d:fd26:f22e with SMTP id
 6a1803df08f44-70dfd26fbd6mr27305636d6.15.1756437354406; Thu, 28 Aug 2025
 20:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local> <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
 <4ee47412-2a33-431e-b667-2daf25bf0b38@lucifer.local>
In-Reply-To: <4ee47412-2a33-431e-b667-2daf25bf0b38@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 11:15:17 +0800
X-Gm-Features: Ac12FXw78zOh0YCbOC1DZdJk9pXKNjEimCM6h54y2oGXNzxpBZAFFy6hpw6Sz_U
Message-ID: <CALOAHbBUCKTO+LX=5r_hW3+uBHO-J_gcQXyJEkasM7Em+37b+Q@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc bpf_mm_get_task()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:51=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Aug 27, 2025 at 02:50:36PM -0700, Andrii Nakryiko wrote:
> > On Wed, Aug 27, 2025 at 8:48=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > > > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > > > associated task_struct from the given @mm. The obtained task_struct=
 must
> > > > be released by calling bpf_task_release() as a paired operation.
> > >
> > > You're basically describing the patch you're not saying why - yeah yo=
u're
> > > getting a task struct from an mm (only if CONFIG_MEMCG which you don'=
t
> > > mention here), but not for what purpose you intend to use this?
> > >
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 34 insertions(+)
> > > >
> > > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > > index b757e8f425fd..46b3bc96359e 100644
> > > > --- a/mm/bpf_thp.c
> > > > +++ b/mm/bpf_thp.c
> > > > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct me=
m_cgroup *memcg)
> > > >  #endif
> > > >  }
> > > >
> > > > +/**
> > > > + * bpf_mm_get_task - Get the task struct associated with a mm_stru=
ct.
> > > > + * @mm: The mm_struct to query
> > > > + *
> > > > + * The obtained task_struct must be released by calling bpf_task_r=
elease().
> > >
> > > Hmmm so now bpf programs can cause kernel bugs by keeping a reference=
 around?
> >
> > BPF verifier will reject any program that cannot guarantee that
> > bpf_task_release() will always be called. So there shouldn't be any
> > problem here.
>
> Ah that's nice!
>
> What specifically here is enforcing that? Apologies again - BPF is new to=
 me.

The KF_ACQUIRE and KF_RELEASE flags enforce resource management. If a
BPF helper function (e.g., bpf_mm_get_task()) is marked with
KF_ACQUIRE, the pointer it returns must be released by a corresponding
helper marked with KF_RELEASE (e.g., bpf_task_release()). The BPF
verifier will reject any program that fails to pair these calls
correctly.

--=20
Regards
Yafang

