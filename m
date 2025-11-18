Return-Path: <bpf+bounces-74844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DAC67032
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AECB7360111
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8030FF24;
	Tue, 18 Nov 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="W3rPYQ3s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2C28F5
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432805; cv=none; b=Juue0qca0aqVrfya5sgkSoUKMiP/blfiu/U00rFY6QuCY3jFS82N9BTkZ2erJ3hxk3Wi4mSw3d/6mb4ZJuMSeQ4IOYVO/DwW2+YCQIIVDbAL14UB3GGxm/ertzeM1PA8pyG12kc8KCiwgZ3pE0Vhdsrff1Y4UdOBFQuD3oL9fDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432805; c=relaxed/simple;
	bh=O/qG1u8B+7T8lnkh2mSdgbfp4I1Cr431IdisVJM8j1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja7QEudFnHq/vWU0v12q+mtagkJnd6Vi+zf9Y3EWd5Cwc9VUvbd6l0Ek8sF9VtHzWxd1UW+cU0qTirwY3LhZwA2l023ytlogpwyTsvah5tn5Ir3mSVIRelnSu9/l1N1Zp6e0QMpXgLpzh94P28ytR9NryzC4lPNfjiCuFEuKb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=W3rPYQ3s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7866bca6765so46726437b3.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763432801; x=1764037601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLtjSxnCETvXjOrmImF9CDMd/BEJkqRfs7UCiiZ7LrA=;
        b=W3rPYQ3sm14HrQwLxF7gL9B5suppQHlKYPPXUFsOMAWsucB7Beqz0xlWVuuuh4rA6s
         a0VJd/OeWEpCcf+WfJt8vQtCwFLRofLJ0gPIlRKg7M/61S4VPyc8XfTApwAuBdrx9ol/
         +hL5pzuG/ozTQsXzL3iE6cSzcBXmZyhkgGuP97v3y0lKlrNhQJJl0/tWh7TqfdtfSoUd
         9SO4SHBi9NsEyIGIomNLPLBDegxXCajzix9sF8IVV8Rsqjv0vVykzXANicQb3hZLqMcE
         TbCMU42rLXGUEqXvHMcpAo3hJOZkzdQe107FCpXwVFz+NOVGVWwfyPH+IP0/LwpQTa89
         yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432801; x=1764037601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLtjSxnCETvXjOrmImF9CDMd/BEJkqRfs7UCiiZ7LrA=;
        b=nCmzLkaQcy2CwUhnlGzvRJpODkno0JJ+dTVV+77EYBR3qkb3hOJKPEELsh6INHMa3z
         VA8fTDH4sDN4MYmwPFZOvQbrTQk4EvLdG+NnRaL+bjXCZeApBszxHFFZ95VC4443QS5R
         igHV6bdSKk34XYkhKUCurdE7eJ/nYXO7xMDLfK5MbRmw3Oe0htIe53BQF8SBSocB/Dgh
         G0UIBUy4yRlwJ6YeswRm0teLpbtu29la77Q4ca3wEGunCXQSSLl21aeM0kzw3Fy1SL4B
         QftU+bzPchGjeAnGTsyTyRJGbYgEE+3LrawvEH2Nthb0U2or/QK0FKsxsYbp981AY7uX
         5qhA==
X-Gm-Message-State: AOJu0YxM0CCJv+p72YuATNJDl62TRsTlHyPdy1CjwTErytYVjINhWA85
	6kFSE65ZgRKTH5YNYo7xH3K1OLM4iGvu+PRWvW6C4tUW5NTPk65k+yUCy6F15d/4kn6FpMmwgJI
	QwGuZ6uwBgmWce2eE2zvPyVpBVgBtlfSrzx1PS2Ca5w==
X-Gm-Gg: ASbGncvtDNu3mGS57dm9mBGgvsF0YGfAnI19u75Zv60WpiyP0KAywxXqTvhKzTAku8Z
	qTL9rXqp24m50MX3IYtS9lm1l9ca2RwVprWrJEWsw5ivHb/TQPPB1XfNJAkBE94WyEphnZgwa8l
	TK9293IFCLPtJnfjnS6lWeYw8/7Ds4GmzG8f9iFEC+MyChUq640ATAkJWSVOpYL+PaUNUAeyfdX
	TA6PYa/fe1BLCq7/JbMD6w3XzRc2VWjq32caYHXaVBwE+lj2RKEmxAaKCzdOJPiDimnpgZiEw==
X-Google-Smtp-Source: AGHT+IHLsAmK2nUCoftwgcN/+IDQ+Q8F8MpmxltXrUOuB8jzRnIXydMeoxmBob3gB3adhtnnzzIRQBbpaXFN1Z7dGz8=
X-Received: by 2002:a05:690c:688a:b0:787:d456:2e80 with SMTP id
 00721157ae682-78929ed9839mr131923177b3.50.1763432801558; Mon, 17 Nov 2025
 18:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117235636.140259-4-emil@etsalapatis.com> <059daf735c7afa0eb6abe7b77cebe3fb96a227722721e6e4001661262308446b@mail.kernel.org>
In-Reply-To: <059daf735c7afa0eb6abe7b77cebe3fb96a227722721e6e4001661262308446b@mail.kernel.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 17 Nov 2025 21:26:30 -0500
X-Gm-Features: AWmQ_bkABREo93T8ZcRlfFeMhQHGiXict63B0uR0v1JGmE8Rkrw8thwfudtXNAQ
Message-ID: <CABFh=a7hx-mm9wB0P37Sf2DatLcO6K2R+VX9CZhsCJXJraV=-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] libbpf: offset global arena data into the arena if possible
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 32dac36ba..6f40c6321 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -757,6 +757,7 @@ struct bpf_object {
> >       int arena_map_idx;
> >       void *arena_data;
> >       size_t arena_data_sz;
> > +     __u32 arena_data_off;
> >
> >       void *jumptables_data;
> >       size_t jumptables_data_sz;
>
> [ ... ]
>
> > @@ -2991,10 +2992,14 @@ static int init_arena_map_data(struct bpf_objec=
t *obj, struct bpf_map *map,
> >                              void *data, size_t data_sz)
> >  {
> >       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > +     const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
> > +     /* default offset into the arena, may be resized */
> > +     const long max_off_pages =3D 16;
> >       size_t mmap_sz;
> > +     long off_pages;
> >
> >       mmap_sz =3D bpf_map_mmap_sz(map);
> > -     if (roundup(data_sz, page_sz) > mmap_sz) {
> > +     if (data_alloc_sz > mmap_sz) {
> >               pr_warn("elf: sec '%s': declared ARENA map size (%zu) is =
too small to hold global __arena variables of size %zu\n",
> >                       sec_name, mmap_sz, data_sz);
> >               return -E2BIG;
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
> >                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Can the multiplication overflow __u32 on systems with large page sizes?
> On a system configured with 1GB huge pages as the default,
> 16 pages * 1GB =3D 16GB, which exceeds 2^32. The result would be
> truncated when stored in arena_data_off (declared as __u32), causing
> the offset calculation to wrap around.
>
> While this configuration is rare, the truncation would cause arena data
> to be placed at an incorrect offset, breaking the intended behavior. The
> three uses of arena_data_off (in init_arena_map_data,
> bpf_program__record_reloc, and bpf_object__create_maps) would all use
> the truncated value consistently, so if truncation occurs to 0, the code
> would fall back to the original behavior of placing data at offset 0.
>
> Should arena_data_off be changed to size_t or __u64 to handle larger
> page sizes, or is __u32 considered sufficient for expected arena usage?
>

The off_pages * page_sz product is bound by the loop right above it. If it
were > 4 GiB,  then so would the mmap_sz, and arena map creation would fail=
.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/194488=
68610

