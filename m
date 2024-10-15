Return-Path: <bpf+bounces-42086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF099F52B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF67C1C2359B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB1206E74;
	Tue, 15 Oct 2024 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5NuTO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB51FC7DE;
	Tue, 15 Oct 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016726; cv=none; b=DhOPxJsmbxRDt+6SkZHC5Dky0OosR5U6b2xMocOgu33rdouNqZ7GHFUYxmIif54z2IIXw93kApGwg1NBWwut91Iz9+ya+AKsRKcXC8sv1SIhKQzkZwn1SjSOt0V0zgdVg75ac3JDP27WdyE/ux6rBxp4TNB58lLiyI1f1sxTGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016726; c=relaxed/simple;
	bh=uHQi+OYLUTp0oZzUmnJmlaDD6INIaffwodKQ/uKV9MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gal9IgGKmIu8l7qG1gbCEg33+sXA2NXK7SgMNhhq8r8rOXR0o6BwgY9nfNNM99GxWgYrhQIVcQNRU8ur5LGZ/noRU4am2FYcj3mTFA656b8L5/Sc8f/OY1O3aYWmnkODZpRATeTtAkf82jLlFsYkbshe6bStcHV2CHUeftT2Yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5NuTO3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d533b5412so2823313f8f.2;
        Tue, 15 Oct 2024 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016723; x=1729621523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITxKiVu0AJ4+io6d3gJTaa3Or2O5JgC3rt9u2kwLrO0=;
        b=dG5NuTO338wAM+7oXG/ewP6I5A3Ys65xoLa4oG7BbCT/buJhHg/DEf0o81qQxa5+LK
         WSbiveqNf1LNk9jxPb9P8q8Zvcd1NqJwDRmm9sN2RDljOVFxt754u+IXwMJCy0hI7jah
         +ASwbip1un37ANYWD99te9HbJ1XjeQ2dsRwdihXA6xaqGIwpxhiuIXtbr7v16bG/n+TL
         Uyh+My9AGCLVElhpGG+YHPOP0XzPYxSzcgLlPlpojF6us6rAR05/1J0sNu+4SytdZ+B1
         tmoMF74A/BEv7UmZoysgkrYrsgAKLfLDYmeuHtf+udn03Hx0CB7MKY9BoLr/kHAw50L3
         kakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016723; x=1729621523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITxKiVu0AJ4+io6d3gJTaa3Or2O5JgC3rt9u2kwLrO0=;
        b=qrG9w3upsVaP/Oaw8BdVG3btovcqJ2at7aOIO2lkkX+LBpRJqQiByFOVQ16TsM85i6
         WyFnSxY0lqurEla+K2P4OqR9S5NSAiMYnDVNg2yQj2Pdg8pZxKpeqFHt/RnyN5YWR0+b
         bSF5h9XMaGcEbLFrZpGiiefqFjm1yctBlOgIoNGBeJgY5vN0+ugO3l8edMVUzKMbjErt
         Qxu89p6149UduiciP+WQ/OHp2DVfWF6KB3tmb9F4/98l0wYMqUgdfxmvV+BrGTFwNuQV
         gIdh3xnOc5NX5z5t4MFc5KlLRaRzA9/xKUEww1UpSopuDMgKxINYaMayAPxOSy51T68G
         grkA==
X-Forwarded-Encrypted: i=1; AJvYcCU8YpCseXcuTLNNUYePNHwQSxHaL1nLUbZPJs+3jWd99yh8Q0b69P8WboMSTfrODPhNJig=@vger.kernel.org, AJvYcCXFphJHXgsAr2agQ907JzqXKlTdVPLn7S6iUiYpBkZ7Gad5GIQIj09R40R1+euNffn+VIJ9nWbxg6ygVnLN@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTWAp2YlBiheFJbVH2gMPoX3s0ThMi3p864ouHDLiH0zg1/IZ
	dkj82UGHr7YFS9UuZAlt2gQ1M6JrXOZAYUeQYm6bqiNPWzyyJyGzzOXvDdXvMJMCCgZsETOOrqq
	gwT904pq4r31yuzl6hkI/FYW/PFg=
X-Google-Smtp-Source: AGHT+IGX0N+4Fs+UmGEyD0ArP3gM2Itw+hfw3twUo3F0NHNdaQtjUxWuszfeOZayS3V6VAv+qbBT4OtQz0dHZ+NeE5w=
X-Received: by 2002:a05:6000:b4b:b0:37d:5436:49b with SMTP id
 ffacd0b85a97d-37d86bb9547mr896088f8f.13.1729016722875; Tue, 15 Oct 2024
 11:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
 <Zwl5BkB-SawgQ9KY@google.com> <Zw1fN1WqjvoCeT_s@google.com>
 <CAADnVQJ2M953da8_gnGgWR9x6_-ztqFO8xvRU=bKcwmsH4ewvg@mail.gmail.com> <Zw6yToBbtOBPvUWx@google.com>
In-Reply-To: <Zw6yToBbtOBPvUWx@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Oct 2024 11:25:11 -0700
Message-ID: <CAADnVQ+Y8BG80=8vcipKVnOL0Htd7W60f4LOPB5shG4eSORVcg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:20=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Oct 14, 2024 at 06:50:49PM -0700, Alexei Starovoitov wrote:
> > On Mon, Oct 14, 2024 at 11:13=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hi Alexei,
> > >
> > > On Fri, Oct 11, 2024 at 12:14:14PM -0700, Namhyung Kim wrote:
> > > > On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> > > > > On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > The bpf_get_kmem_cache() is to get a slab cache information fro=
m a
> > > > > > virtual address like virt_to_cache().  If the address is a poin=
ter
> > > > > > to a slab object, it'd return a valid kmem_cache pointer, other=
wise
> > > > > > NULL is returned.
> > > > > >
> > > > > > It doesn't grab a reference count of the kmem_cache so the call=
er is
> > > > > > responsible to manage the access.  The returned point is marked=
 as
> > > > > > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab =
object
> > > > > > might be protected by RCU.
> > > > >
> > > > > ...
> > > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> > > > >
> > > > > This flag is unnecessary. PTR_UNTRUSTED can point to absolutely a=
ny memory.
> > > > > In this case it likely points to a valid kmem_cache, but
> > > > > the verifier will guard all accesses with probe_read anyway.
> > > > >
> > > > > I can remove this flag while applying.
> > > >
> > > > Ok, I'd be happy if you would remove it.
> > >
> > > You will need to update the bpf_rcu_read_lock/unlock() in the test co=
de
> > > (patch 3).  I can send v6 with that and Vlastimil's Ack if you want.
> >
> > Fixed all that while applying.
> >
> > Could you please follow up with an open-coded iterator version
> > of the same slab iterator ?
> > So that progs can iterate slabs as a normal for/while loop ?
>
> I'm not sure I'm following.  Do you want a new test program to iterate
> kmem_caches by reading list pointers manually?  How can I grab the
> slab_mutex then?

No.
See bpf_iter_task_new/_next/_destroy kfuncs and
commit c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs").

