Return-Path: <bpf+bounces-75827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC132C98BA1
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 19:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17233A338D
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5F221546;
	Mon,  1 Dec 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="2WgeLR/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EC21D5AF
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614062; cv=none; b=FgDPYsgbb1a68e5NbONzqLqhU/HIzfXsdyE8pCpZzkw7vUYFuj7q6PMiQ7Xfh4yMeeimw7YkEkwdMIHwgA0ki3kjCYPyNrC+H70gOh16AZULgX+t2zh4dBe3eZD5trytNcF2MnMPSOKXKKVJknXX/a9tBuL0RxFaFjV5HhPX7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614062; c=relaxed/simple;
	bh=XJ9sD0d59DxoHk/cSvAwoAY1ocvhHmsNL4f2C9HppkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErsXxmSg/6MjjX0uFNpwvM3CluZTXUjdSq5DViUJjCX+5M7AIZlGROp81/vcSerDvAWfRIWrfF6fT06ik022T7AaOCNWdI3AOCazRS0zm1OLb7txF5nNWGbdz7MR5+xjNCZW55ToMMHD4NvN17G13hZKSQgG77vb2R+g6EZce3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=2WgeLR/l; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63f9beb2730so3571341d50.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764614059; x=1765218859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KQJ/NqlyrFITG3rkF9+yb7FHjAJNpiHxsRt+2Yc1RE=;
        b=2WgeLR/lHnzYCr+sDU0zCc4PMpOpJQ3R7H3m23EZnbNv9bz5XRDy29eAgkGByKtzav
         uQVpI4ebV9A46y4i76AdyGU6p+N2p1PPgbPInHVPQErUDu6pPK9oMBnUYZrbRBVrIAId
         QOsochSmMD0bf0i307qauoW0hrOJJG415M0SzVN/r82sLfqPHGZY94YSHg/UvQ9V2+FE
         +XWSAXEBLajmYJ9xAFQNUWonUIGnKJwJcR1W987MmS5tgtkmRRdPcaInli6KNGVTjWHy
         16wn4U+n2n0m23p2GW8lD6IJ/EY6bBOx5QZ2MdSBXVuBOrJ15JyKL1rQ94bdWk42sdi3
         yQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764614059; x=1765218859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KQJ/NqlyrFITG3rkF9+yb7FHjAJNpiHxsRt+2Yc1RE=;
        b=uQAsXdyiPtCYdd4VIJz8X8rdR9SCyvNg68AfvtKjnfbbzq9htT4kCvl8J/Sp2jNEgz
         DsqrY3TZUTKJ8sSCyn24X+Do0EjAW3k6Ms6MFdxRn1VrGCQP1twgRd23vwkrYxeD+vLl
         /93I1B6IiX/GL8ezsrMAt1J2l69pWWOlqwvoNPRiG+JPJYS7xJTpok+5LU7FmvQdqZVy
         c8NGszdR1kAZuZFW98LNmOcfIlQQJ4k8PcjXfNNFrZZ/Ck1egvuJ7fyXd1H8TeT7/Zjl
         Ku+5oOLQYWp9VSsFkH15EkjdjVaO2ZdnZbVOdSkLzyH2aSWW5GTQ99TPdIjmuUJMw/fc
         lmwg==
X-Gm-Message-State: AOJu0YxAJmXqrfJlZF/H7OMEvkvmDOW0WPIH26w13GQfCxL/7y+Cowab
	tuso19M8T2/4KUmixPkwP3t7kA0+I4UVJE4rnrMxYJU+K81lgOWKqD3HNvu0hDlw3XKt+y0704a
	cdt54pMSM8yqqpl2+ixi+4dRUpk9bFU0TM5H9L5l22w==
X-Gm-Gg: ASbGncu8u/X0FLW9CdPCqZkgJXLEfSju8gXAt71OoyTtb9WNjVspq4yCQnF3teLGMhJ
	hlitg0ozNuFlydLkzK88lzh4eMfcvR7V09nowPIuSne1bSTe8i1/arUaoNyhD+yfjJUtZZGPxgC
	mf9NGxg8V81hN/c76oNvhfjixJCYKHVtwVUZojW9HknRg04ihugBuFblVQjIU8Zl+q7Q7El8SbO
	nzhmXSi1dILIhKOjZmxQ0CSaARyUF2gJh3L9Ps3ubY63vaS57pVql2oqSlpdZGS810t5gKtIxzw
	wjN8Vuqq
X-Google-Smtp-Source: AGHT+IGd1U4BTbAvV084ERVtO8kgfaAf6Bx0cVQDINK4Px3hmFUTGR/aHC3h+2f0svhbRqgEUSaBSOajFwCjMO0XXjI=
X-Received: by 2002:a05:690e:1513:b0:63f:b2e8:11b0 with SMTP id
 956f58d0204a3-64329348493mr17971176d50.40.1764614059238; Mon, 01 Dec 2025
 10:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118030058.162967-1-emil@etsalapatis.com> <20251118030058.162967-4-emil@etsalapatis.com>
 <ef19d394a7b4993a4f42fc063a9e33bf174f7035.camel@gmail.com>
In-Reply-To: <ef19d394a7b4993a4f42fc063a9e33bf174f7035.camel@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 1 Dec 2025 13:34:07 -0500
X-Gm-Features: AWmQ_bmYo4TWzf-Wa67zuye2yeScxL6jEUYFEqVRvHrohN5r1ru1yB17PHVB7DI
Message-ID: <CABFh=a6sNSrYnpmhSBjBxO9g8oLk3kY4avQ6hwoNzmX4b7aKgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena if possible
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 10:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-11-17 at 22:00 -0500, Emil Tsalapatis wrote:
> > Currently, libbpf places global arena data at the very beginning of
> > the arena mapping. Stray NULL dereferences into the arena then find
> > valid data and lead to silent corruption instead of causing an arena
> > page fault. The data is placed in the mapping at load time, preventing
> > us from reserving the region using bpf_arena_reserve_pages().
> >
> > Adjust the arena logic to attempt placing the data from an offset withi=
n
> > the arena (currently 16 pages in) instead of the very beginning. If
> > placing the data at an offset would lead to an allocation failure due
> > to global data being as large as the entire arena, progressively reduce
> > the offset down to 0 until placement succeeds.
> >
> > Adjust existing arena tests in the same commit to account for the new
> > global data offset. New tests that explicitly consider the new feature
> > are introduced in the next patch.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
>
> [...]
>
> > @@ -3006,6 +3011,17 @@ static int init_arena_map_data(struct bpf_object=
 *obj, struct bpf_map *map,
> >       memcpy(obj->arena_data, data, data_sz);
> >       obj->arena_data_sz =3D data_sz;
> >
> > +     /*
> > +      * find the largest offset for global arena variables
> > +      * where they still fit in the arena
> > +      */
> > +     for (off_pages =3D max_off_pages; off_pages > 0; off_pages >>=3D =
1) {
> > +             if (off_pages * page_sz + data_alloc_sz <=3D mmap_sz)
> > +                     break;
> > +     }
> > +
> > +     obj->arena_data_off =3D off_pages * page_sz;
> > +
> >       /* make bpf_map__init_value() work for ARENA maps */
> >       map->mmaped =3D obj->arena_data;
> >
>

Hi Eduard,

> Please correct me if I'm wrong about the goals of this change:
> a. Avoid allocating global data at NULL address
> b. Reserve some space to use by upcoming arena-KASAN functionality.
>
> For (b) wouldn't it be simpler to implicitly increase the arena map
> size by an amount needed for KASAN functionality? Then there would be
> no need to guess the necessary data offset.
>

b. isn't really an issue because we do not need to reserve the shadow
map region.
Arena ASAN uses a global variable to denote the base of the shadow
mapping, since the mapping needs to be in the last 1/8th of the address
space, and the address space size is equal to the size of the arena (and
thus configurable by the user).

(More details about how the ASAN region is reserved for reference:)
The ASAN runtime code initializes the shadow map at load time and makes the
necessary allocations for it. If the globals fall in the ASAN shadow
map region, then
ASAN will fail for now. This only happens if the arena is tiny, or the
size of the
globals is massive. Both cases are outliers and we support them later,
but the bottom line is that this is a problem for the ASAN runtime and
we don't have to worry about it in this patch.

> For (a), is there a way to move an address of first valid mmaped page
> (from BPF perspective) w/o physically allocating the first page?
>

IIUC what you mean:

This is what this change combined with bpf_alloc_reserve_pages() amounts to=
.
First, we adjust all the symbol addresses into the mapping to move the addr=
ess
out of the zero the page. Then, we call the existing bpf_alloc_reserve_page=
s()
call to prevent the first page from ever being physically allocated.

Alternatively, if you maybe mean transparently add an offset to every
arena address
 in xlated/jitted code: That would also adjust the NULL pointers we're
trying to catch
to point to the first valid page we can allocate. In general, I don't
think it's possible
to do this in the verifier/JIT because this change depends on adjusting onl=
y
the arena globals, and that is best done at load time.

> [...]

