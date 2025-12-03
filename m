Return-Path: <bpf+bounces-75972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E571C9FD04
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D762D300096B
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C7313E03;
	Wed,  3 Dec 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="IG6hr7vF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF8313546
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778056; cv=none; b=fcuFyUUYIqC8W06Q+IB0BVEy1b8JuxM/5cNyUN2KZGka6XmcM5f6vxFBElKA+wZBwePwHOQ+vqZwPCV3rZ2KbtB++ugM4z6Io+xQJ6Mji9xlVV6oiI96v/DU3vf6rzLCr8rUZz8xqP5V6YjOMdmEqTVr6xq98AkxctnLbjTuwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778056; c=relaxed/simple;
	bh=NdojDrflSmvnKaQ/UXEjahax46kAOQkMeN+jDpl+ASE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn0VpGjjBuzCo7yycTamzTeAYXimOQLob3CAUuZdOFPrP4Vt8Kz3CfJZIgImsEMVzSXPSi+8bOKmarOg4LRjoLIp+9g+Yb9/S3y6SZKEZgtTL9WPg6Bx7GL3mgXQuprYMFgoHhZsO1VeAWgGJm/FIZw5lK0qKfLyUBxZnKgm3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=IG6hr7vF; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6432842cafdso6300085d50.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764778053; x=1765382853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/7AcLly1IHTn+BH42uIiRCVU6VVOHt2ez2Zu8qOrzk=;
        b=IG6hr7vF4rqLO9RzjS0HE7u1xTTeAL9guQRo7UQetyRgr+1UFwzDYHhHdwwn8eBBzQ
         pGbsnh0ZvZ1A6aQr78+3nUICef6/D53IYPs//dyqm/PdFFA4YD7eb8Q8oJHNM0W3Ryd5
         bZyAfuRGymrk2v1cQdWwBYAryVwp5nI6McviJdAtwNX4JXF3wprZIOhG3lkuXlFeCRNC
         ZmOWK1kwiXVTaRUijxftYqMvBCKCawZJFN9sp/Fc6EFKedc5vAbXGC06Nd/SnLRgo7wK
         MVhh1FxJ4ahlQUb4b43ZZWDSJo/x/YNoxK3lkvlbs6ctjc5aKpKvi6kFQB3jc/0pXBQb
         pumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778053; x=1765382853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/7AcLly1IHTn+BH42uIiRCVU6VVOHt2ez2Zu8qOrzk=;
        b=Fk5/bPd7+57OSzVF7LnIpRDtnZ6Stlu+T2nvQlo3Jum/fucoomlXFkM5pqkC+9Fh3n
         2wMqTVuSFYy9kzGuy1mIQU8V7/1G2g38aNeGx+vVcDqFLK98CRczgVjMXm3jI+T/1xYk
         uyBqDPk622FH/qBGNo2YcBjXELai5lTLg/FlcIGohnx6ZAq4Ghs27kj3kn3rau39eDnA
         5CVXIlS51mnMzubKqUETDXXARbsjAVXlvdtVjeJAP+wVjTwD5qFiYotk2JzSoQe1Jnl5
         GJxw+nIbPJNX/4IqncdBxFjUnPAzeyW734D7J2lJeBXp7SHXGHk4JO0u/ridqsCCB4Cg
         Dxcg==
X-Gm-Message-State: AOJu0Yw43/a9uvizUUAxWJ2UFmPudBpHW57ZO/B3tVLOx8ukgVXPWro7
	fbBLTmSJJfQlKoqkhwDvb1UIjUl396HqTqWTF+/fwM8IWkFRSIgtppZptkEDYLa6hFbkUIR3y/b
	QBefVz7Tcl+Yh0g4sFWVD5XZF34A200op/I46q1As1A==
X-Gm-Gg: ASbGnctkx4+I2MGf8LaGD9nvMXalzpykdp/mYPG8x/FNPqmC8/KMhbFjbthVazcVT+/
	2HgXRfdQVtndQnu8yMh3MceBtNrDB7LmcqCmcEOOiVRPTTsw6PFwH5arwpwLVEvmdYI5T88JBUp
	jS7nCxpInPE5w+EFotvO3/ut37TbP9HSV+tWdJerJ2GFr+jjWb7xqp1UWv3aVO2UuqomBpk7W9R
	Mf0EGSgSAdbhiId+rCAlvLy1E7W2RXsodyg/PIdoTkOfxmrhnfIW/dGTxyJAqXa6JBnNMbc2w==
X-Google-Smtp-Source: AGHT+IETB29d67wF5Uva3TUKiHQnRvDhM7iyiexVl7b0jraxxN8kiaNg1mOZfPBfdQKoU23IesjrVrgPId8xmh3I2hE=
X-Received: by 2002:a05:690e:1489:b0:641:f5bc:695c with SMTP id
 956f58d0204a3-6443708a4eemr1756242d50.72.1764778051631; Wed, 03 Dec 2025
 08:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
 <ef19d394a7b4993a4f42fc063a9e33bf174f7035.camel@gmail.com>
 <CABFh=a6sNSrYnpmhSBjBxO9g8oLk3kY4avQ6hwoNzmX4b7aKgA@mail.gmail.com> <9a224465dc5cf8642673e633885057bb61b8fd31.camel@gmail.com>
In-Reply-To: <9a224465dc5cf8642673e633885057bb61b8fd31.camel@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 3 Dec 2025 11:07:20 -0500
X-Gm-Features: AWmQ_bnKGM6vhP1UDLdl1uSM7cvY4bz5z-GBMUmweNqlujaCyM_NBSld6fP_8Pc
Message-ID: <CABFh=a4B2HCrV6mZM=gd0ZhD=qPjDk14M90HSTmZrqgqhgVqzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-12-01 at 13:34 -0500, Emil Tsalapatis wrote:
>
> [...]
>
> > > For (a), is there a way to move an address of first valid mmaped page
> > > (from BPF perspective) w/o physically allocating the first page?
> > >
> >
> > IIUC what you mean:
> >
> > This is what this change combined with bpf_alloc_reserve_pages() amount=
s to.
> > First, we adjust all the symbol addresses into the mapping to move the =
address
> > out of the zero the page. Then, we call the existing bpf_alloc_reserve_=
pages()
> > call to prevent the first page from ever being physically allocated.
>
> libbpf.c:bpf_object__create_maps() allocates arena memory region as
> follows:
>
>   map->mmaped =3D mmap(addr: (void *)(long)map->map_extra, ...);
>
> Where 'map_extra' comes from fill_map_from_def() / parse_btf_map_def().
> The latter even provides a flag:
>
>   map_def->parts |=3D MAP_DEF_MAP_EXTRA;
>
> On the kernel side arena.c:arena_map_alloc() uses this 'map_extra' as
> a starting arena address:
>
>   arena->user_vm_start =3D attr->map_extra;
>
> arena.c:arena_alloc_pages() uses 'user_vm_start' as follows:
>
>   uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
>   ...
>   return clear_lo32(val: arena->user_vm_start) + uaddr32;
>
> Returned value is what BPF program sees as an address, right?
> Is there a way to tweak arena_alloc_pages() implementation or arena
> creation at libbpf side, such that arena_alloc_pages() never returns
> value smaller then 16 * PAGE_SIZE?
> E.g. by tweaking the attr->map_extra value in
> bpf_object__create_maps() if it was not specified directly by user?
>

Turns out that we can move the globals to the end of the arena by moving
the shadow map, so the following is moot: But we could always call
bpf_reserve_alloc_pages() from libbpf when we first set up the arena.

It turns out that it's trivial to move the ASAN shadow map around the
address space so we can remove most of the issues in the patchset (
extra libbpf call, globals in the middle of the address space complicating
the logic). I will send an updated version.

> > Alternatively, if you maybe mean transparently add an offset to every
> > arena address
> >  in xlated/jitted code: That would also adjust the NULL pointers we're
> > trying to catch
> > to point to the first valid page we can allocate. In general, I don't
> > think it's possible
> > to do this in the verifier/JIT because this change depends on adjusting=
 only
> > the arena globals, and that is best done at load time.
>
> For sure, it does not make sense to do it on verifier side.
> It might even be impossible in general case.

