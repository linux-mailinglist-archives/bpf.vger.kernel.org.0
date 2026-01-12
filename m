Return-Path: <bpf+bounces-78610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09308D14CB8
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 992B73011036
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A02E1EF4;
	Mon, 12 Jan 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw8I5bXZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8D500953
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243556; cv=none; b=b2pFI5LRQqycjPDaMvXqPNex2A6EDPrnUXBBDcddFVbPxtz+539m1fOjL/Z09IAGECyRwwNGCB1eHG711WlozmkG4V0xkGZ6e9OfdVJSznq96cBABK+GOr1wfH49v3bvxmyu+g5/sgtMl3WlzxTO8wC/bOpBs7XzriqO2jIjMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243556; c=relaxed/simple;
	bh=HQMMkDbyMecrvmFNIGiO4WMQ2qFyv5NB+etWkTIWzoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6TyvDbmlywHlv4hh8vylUpMuHvhPf0fdVIx0N68FT97qxC5spxYUk7AVRTQmTg1LZDWdty7qhKMIZl8IsSq0TriGTAsGEylcMmg8eXPCn3ue7K/n9r2fDt0T24QUZsSWhz799lPLQix7t3pQav+LjafIMtXncv3r9GC0Mz3ORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw8I5bXZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fb5764382so71434117b3.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768243554; x=1768848354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bkpZS15J+hY6WH2SVrR58uTL066wnHNE27qIMNpOqQ=;
        b=fw8I5bXZRHyoj563ovIE435WZeGQh1/1zqlm8DA1/BgkfYSIlWJ9SxKajXtfe2+330
         IXTMuaNt+474Ej8mokxo+T6HXmKXeQU2hktkdd/lCSdAquS4tyzcjIgI+3sfmuVTek8s
         Fr21wzQzjT25igRyrDpfbzuWIctP/xFOGW1nEvwOKMtabjrvRSm/mbZkax6HBE1Y+D7Z
         qKxMb20T2gewhETeTqEemEb1l53c2pPmLnVltu/d4g1ALgUJElE0Lk3he+gLqPJbUTB2
         Cl0H05tXuv8zOGGMSam46Vcgq6JhyPjGIOrRGBMzDC7sdRZrEqxS3//RkCw5dkYKoKA1
         8+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768243554; x=1768848354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bkpZS15J+hY6WH2SVrR58uTL066wnHNE27qIMNpOqQ=;
        b=D1H/bY1YhRR0aJADGexL73WyoYAtVmNKh00Xy2lEHrhIhhhI8FuXmciqtqcI762vOk
         kPL8uXeftick7su7fwCOXQYrbMjTars5vEYOiJ7vO1tzOWUh1b9STtyFgt1CmxXzGQeI
         ZOeOv+5Bh4POe9LamyHkZbkE3pJyhwVxGeEZnWkZQBgAQEbkyIb4lCTnN6X1IflPnTwz
         wVRNq+4qxsHFSHXn/++5PL7/2Z0FXbwuaLuI99QFfNxBvRAdM6y1cInn9+ZeEdc5/IwH
         H1yRysFNyLETEdtOmuH5pfokfpSgKNZLas86xWa4FHGsUvZGtufeq9jZcziXjw7rpjvA
         Ankg==
X-Gm-Message-State: AOJu0Yxs27CtOkUm1urfp6MyxV88UZW40tjXryeR+UBJ5Y2pesi7qLAx
	HgIZFnVOTdMbqakaD5P4FiG/2koIcuxE5wbApf0cmJcCqszSn6o3uwUDcuYaDLkD0Fu6fy3ymyB
	k7vCqhbDG73RI+KULypjjomhplIS7OlQ=
X-Gm-Gg: AY/fxX5mCGAf4mSiyLqF/tZLFZeDJbzylX8sxT5pHGBNFG0Muq26ulCoi6yflKlsMZV
	gXxVl4jXjzfHcOnoZsA5WqGuWJJdBH4nzXZC5Nb+hO6S+ZztpNm7DLicbZyft50gZxWNTf/Va7s
	9/3GP6XDWx0HjlnRH0Ze1Galh3FsK3ILN5fPmSr30msm3uPmm5TjoQVJvlgDk9K9KutDnMK08a1
	RF08LINClmeQbH0YxZrsLc2dJmByYX8478HmfB4GZ1Uk0Pd36n5kNrUSJ1GSJippffoDG2aNDG5
	TVe7cUvDyxbTf+SpIxUl9T7fpVo1QHr0YHqp
X-Google-Smtp-Source: AGHT+IEMmNHOIH/e7SlQmK1zeXkV+XcUP0N3iiHHmsm3ocE9tJEfL8cxo17jFOGW1BHMx0RiAMAY8n59K+jchIYbPUE=
X-Received: by 2002:a05:690e:14c8:b0:640:d174:3839 with SMTP id
 956f58d0204a3-64716bb9758mr13781514d50.36.1768243554224; Mon, 12 Jan 2026
 10:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
 <20260111153047.8388-3-a.s.protopopov@gmail.com> <DFMS1OCR2VM0.30PBICO8ECI9O@etsalapatis.com>
In-Reply-To: <DFMS1OCR2VM0.30PBICO8ECI9O@etsalapatis.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Mon, 12 Jan 2026 19:45:43 +0100
X-Gm-Features: AZwV_Qg02VhDy1gnlsbLbuP8Yk3J8M59wIAbywiK4Y9ak3zFBzIXk8Gaeel9ICo
Message-ID: <CAGn_itxu+pCwxBZ4rmXqEjzynmObD8gnbFrQC_Xn5Z_uxYgJ3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: insn array: return EACCES for incorrect
 map access
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:12=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Sun Jan 11, 2026 at 10:30 AM EST, Anton Protopopov wrote:
> > The insn_array_map_direct_value_addr() function currently returns
> > -EINVAL when the offset within the map is invalid. Change this to
> > return -EACCES, so that it is consistent with similar boundary access
> > checks in the verifier.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  kernel/bpf/bpf_insn_array.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 37b43102953e..c0286f25ca3c 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -123,7 +123,7 @@ static int insn_array_map_direct_value_addr(const s=
truct bpf_map *map, u64 *imm,
> >
> >       if ((off % sizeof(long)) !=3D 0 ||
> >           (off / sizeof(long)) >=3D map->max_entries)
> > -             return -EINVAL;
> > +             return -EACCES;
>
> -EACCES is reasonable but the other .direct_valud_addr() methods use
> -EINVAL (array) and -ERANGE (arena). If we're going for consistency
> can we change them all to the same error code?

Would be nice, but I doubt this is possible, as this should break
plenty of existing user space progs (for insn array userspace code
with off !=3D 0 actually don't exist afaik).

(I am also pretty fine with not doing s/EINVAL/EACCESS for insn array,
but without this change selftests in the third patch look kinda
weird.)

> >
> >       /* from BPF's point of view, this map is a jump table */
> >       *imm =3D (unsigned long)insn_array->ips;
>

