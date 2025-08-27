Return-Path: <bpf+bounces-66699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DFB389FB
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E457C4D98
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70032EF651;
	Wed, 27 Aug 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZZkdnTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B551C5F1B
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321108; cv=none; b=k5825dIXlTG5rGsUzd2yTmRVa72XPgkcDoDhdu1ApG0uKJ1DCiuTflFglPtu+puzK9kXXdlczwzCsd/8VkUNlrZlMzD5tKTO4bZjbkxLNcktalXvnaHEcfeuZAz/o6vLzDJJRvrDbeSesownrBhY/4F390sAo/LnO07eKB+KqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321108; c=relaxed/simple;
	bh=kxH59FQr3bbqqMhdpnJz2UaaJ9ltMVXHDeNOvvoNdFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGYn2vaJdxEpzO5cQZwNeqoes2uNbd9ALaZ8/egmqcWa2YQuduRJ0onTQ9YNF8K8ml8F79LZ2UscZyz4GkoiON4ENd4crLe9YezMbfXyRbTcSwv/+TlVcQjYTpbAQ+bWhWH0Hs59RcA4iBnhcNUGYaZjx/nYrTShhlLmCRBVqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZZkdnTi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-770d7dafacdso239622b3a.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756321106; x=1756925906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UkoX4ywcNy1K5cF3ICYZeBbypwuLyU+HtIhvxne7OII=;
        b=bZZkdnTi59BTGE+YSuy2OmSbJO7myrDj7TqDJWKfZjdZ2XA+wh/3Ue0M4eZ3I1t5/G
         ud7Q/GEcev2OzRFHQItIQRoyyrpRZOa1IJ2pK9ntylWJplNpMTit++gg25HlybSvw/Xa
         z1/hCX5WPrz83S6OPuJvj4WtIaJ3fwKF3m6tefoiMKDaYX/oUiGya7pbbTY0TMVefI6D
         NxcFlJEdGyYvL3u1guz7uC1ZO/nFvru3XxEr22Iy/V/QVJ5oeEB+TQsObqBF3/582KsV
         y8Z1MkLrOgMiby1lBSmD2nB96QZAOvVq04lNojyQ0VkZMUsVO5v+KB073FJrQdJbULeV
         sKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756321106; x=1756925906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkoX4ywcNy1K5cF3ICYZeBbypwuLyU+HtIhvxne7OII=;
        b=k97c91NY4FIwIqLBCZuK5JbuKDjqEsm0WsW/V1p8QqYX6vDslYrKIBXF5QonOYigSH
         5W1vtqVd7o9nfU7GrtvHXiGkqRLKuTvix+Enz1f8SW35VwsMdUN73gMovuIbMD0ryF71
         YUfjeJfhoL7uiubm+zqoz1KbaWG+yYWUqP9tA34B5ff6QUUAKdAxWdylf4OoT32ojjr2
         0mylZxTtYcvK45hyfPwOupWiJQWBJZ3u2Ml9pZ+VR9a6oORkK7GYnYFPobo4pmgK2NGF
         +3PpWMZU9Frg3IVuxbYF1A7v3xtCHrWYU9Qor0/QOCVWIFS5q7zSSbHv8iCU+dxuhgO8
         G12A==
X-Gm-Message-State: AOJu0Yy8bKIH+GF4Tphj/IrBESrdOVhih7We4X/7i8JLWOkBa0hQTG2x
	sgyWLZRUqtRcip7tnroOVF9QNDJaQCOulTCJTfTrC1ffeJfm9o/ynUQNzd3w8tW7
X-Gm-Gg: ASbGncu35qt0Q7mp9lFi22arkiSGHsZTUfOjElX8J4jx7R8iK6idyRGGQZQGAGqUE77
	UgzJlChFsvTHXuxlXkCqDngEI695h13h/wgaAiYAAp26sI/EesH6We7NUVX6RZiCI7SF9iGLYYD
	u9KzX+L0IKukB0qZVjZ2kuJEfeX2L20xEK/YdTgj/brgILMpnVo36ojm8hmVcH001f8UWHmWxfb
	+4Ker5g9Rcs1SZ8kQeygBMsZXBTwnpDHOixDEyYHtW2nrDclWbPVjK+AFetta141R38soYp7PGL
	DRrqEh4PTT3z21tn0oKLot0v1TOE26n1A0QPIi9eo8uCAeDwzX78+1eVIAFWbEFQLBdrn84Ie3c
	RU2vY41UPJf8LJRsmMzy6NrFinPRXCQlK9FtO3duHp1G2/cca
X-Google-Smtp-Source: AGHT+IFUEIkJr+PaMtxdhou+rDqWAriaKPSR8btk3BhbUR2DJItr4axGfjxUkcdYeWmYxlJD2QlKzQ==
X-Received: by 2002:a17:903:943:b0:240:5549:7094 with SMTP id d9443c01a7336-2462ee53d7dmr259937125ad.18.1756321105962;
        Wed, 27 Aug 2025 11:58:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6ed5:bfbc:8f3d:6d63? ([2620:10d:c090:500::4:16a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1542sm127540105ad.41.2025.08.27.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:58:25 -0700 (PDT)
Message-ID: <7a04c9c9d40387219daa53d98202151b0a775bd1.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 27 Aug 2025 11:58:23 -0700
In-Reply-To: <aK8lhDi+LybnjdfG@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-9-a.s.protopopov@gmail.com>
	 <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
	 <aK8lhDi+LybnjdfG@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 15:34 +0000, Anton Protopopov wrote:

[...]

> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index aca43c284203..6e68e0082c81 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -77,7 +77,15 @@ struct bpf_reg_state {
> > >  			 * the map_uid is non-zero for registers
> > >  			 * pointing to inner maps.
> > >  			 */
> > > -			u32 map_uid;
> > > +			union {
> > > +				u32 map_uid;
> > > +
> > > +				/* Used to track boundaries of a PTR_TO_INSN */
> > > +				struct {
> > > +					u32 min_index;
> > > +					u32 max_index;
> >=20
> > Could you please elaborate why these fields are necessary?
> > It appears that .var_off/.{s,u}{32_,}{min,max}_value fields can be
> > used to track current index bounds (min/max fields for bounds,
> > .var_off field to check 8-byte alignment).
>=20
> I thought it is better readable (and not wasting memory anymore).
> They clearly say "pointer X was loaded from an instruction pointer
> map M and can point to any of {M[min_index], ..., M[max_index]}".
> Those indexes come from off_reg, not ptr_reg. In order to use
> ptr_reg->u_min/u_max instead, more checks should be added (like those
> in BPF_ADD for min/max_index) to check that registers doesn't point
> to outside of M->ips. I am not sure this will be easier to read.
>=20
> Also, PTR_TO_INSN is created by dereferencing the address, and right
> now it looks easier just to copy min/max_index. As I understand,
> normally this register is set to ips[var_off] and marked as unknown,
> so there will be additional code to use u_min/u_max to keep track of
> boundaries.
>=20
> Or do you think this is still more clear?
>=20
> I will try to look into this again in the morning.

The main point is uniformity. For other pointer types current
boundaries are tracked via .var_off/.{s,u}{32_,}{min,max}_value,
out of range access is reported at the point of actual access.
Imo, preserving this uniformity simplifies reasoning about the code.

[...]

> > > @@ -173,6 +172,20 @@ static u64 insn_array_mem_usage(const struct bpf=
_map *map)
> > >  	return insn_array_alloc_size(map->max_entries) + extra_size;
> > >  }
> > > =20
> > > +static int insn_array_map_direct_value_addr(const struct bpf_map *ma=
p, u64 *imm, u32 off)
> > > +{
> > > +	struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> > > +
> > > +	if ((off % sizeof(long)) !=3D 0 ||
> > > +	    (off / sizeof(long)) >=3D map->max_entries)
> > > +		return -EINVAL;
> > > +
> > > +	/* from BPF's point of view, this map is a jump table */
> > > +	*imm =3D (unsigned long)insn_array->ips + off / sizeof(long);
> > > +
> > > +	return 0;
> > > +}
> > > +
> >=20
> > This function is called during main verification pass by
> > verifier.c:check_mem_access() -> verifier.c:bpf_map_direct_read().
> > However, insn_array->ips is filled by bpf_jit_comp.c:do_jit()
> > bpf_insn_array.c:bpf_prog_update_insn_ptr(), which is called *after*
> > main verification pass. Do I miss something, or this can't work?
>=20
> This gets an address &ips[off], not the address of the bpf program.
> Ad this moment ips[off] contains garbage. Later when
> bpf_prog_update_insn_ptr() is executed, ips[off] is populated with
> the real IP. The running program then reads it by dereferencing the
> [correct at this time] address, i.e., *(&ips[off]).

Ack, missed the address part, thank you for explaining

[...]

