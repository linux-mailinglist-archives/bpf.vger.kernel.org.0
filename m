Return-Path: <bpf+bounces-71167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D8BE5D60
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 01:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC99E3A958F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 23:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97482E7645;
	Thu, 16 Oct 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/6pRIf0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E12DEA6B
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659104; cv=none; b=WORjecCZzFINsclPtYqcTEFsZn/SzcKMs/kBoOlTydbd2rbjxKI5d2riF92D64Mv3HWMr8hkY9zRSy/8X1c58vW2CQLfYU7cyQN8wRDaRsUcP2+vXQYDCAsbfyVe3ZNu4EBuqTHoYUQfoTvo654Ho8vKfxkr3Yppj3ltwYJ7tsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659104; c=relaxed/simple;
	bh=Aj6Wx9Bfs8RLpKxX1KtU4CbTaDX4sRwzOBAghWXMWYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfJ7xdBZ+UyOQgapAk1ZvjQ0dUhA1mmY+DhKdQHcabwuuiGIlU3IRttVI7ixP/Akph6S89dHjy4MsU0kZ5fvDfT5SKM8cc9QLtTBHH3PBC2VUpupNFAsVe9kCcU2vH1JY1y90T7HtioWVz45Owkv0naK9WbmZ2YBu8uM/hfXovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/6pRIf0; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-635401a8f5aso1204094d50.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760659101; x=1761263901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYP/+xCHunFQPFAuXuIfVqnTEnC//p2ENAg5w4UGNUg=;
        b=h/6pRIf0t2KifxZjzwrJbP75+DL52oyWTLObVvKlgK574JZCJs/xpTNc2rAguPjt3z
         +ekZcbm0AleCHFOEUco8FPJdvz+6B8M07cuLcvlmbV2hWK9V/+XMukBltVo+IIBMQFlv
         0m+TZxZ9esyTSO7ECO1gLSQPpqCs11LQu2tGDYsB2W7voo+PTZahTN6VrWXTJfnhsbKb
         TT6rPDUY+QD/H+KBBLkHtABIC4VvTS8JDrxVxHYh2TtrCKTweU8C5vdwxILos9+1pREz
         McILnZZAJij4LIGQ+SclNJ8ZV50ZnrTLRPZWiHKf79pDlGSfd8yelgCT1TjbyiBL2IHM
         yktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659101; x=1761263901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYP/+xCHunFQPFAuXuIfVqnTEnC//p2ENAg5w4UGNUg=;
        b=RbLHwl+Vf5yOyKxq8t4in42F5zW2mwHdnEarZLJ0usi74XFxuJriQIHsnSRGNbHkjT
         qOBQAyXX4dRyCIVFIpFrfFg4ZLwoQyfdEusNWiymDqTR/Ly5kzomNeS+OvwHH7f8wSGn
         I6G4P8XC0LuzB+ngrQyhixtfsDzryyl4A1HvAjh4knXaaYhoZyLB4xV1ddWI0tFhMlBr
         KeLGV+WQ21LhJz7Fypda/qcxFvbvkOoGzifYtf2VFszr7FzSjWs8svVz4ul2x1q5M/z0
         83jkYSzt67/RPBybppr4q5+xLTzWHXaZ19pPfZv043UPBrPm2xBuIuRamTHrsK4gFw+2
         G0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW9pePNg+DoWVjsSWwHOjCpZzU72PY3InM/k43GK0DPeLrn8D81um1uUS6CTc8HP65154=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBZ6aD3BeT1eUh4o5z4dIFqsF0yGZRjf37mklNkNUBD0Pn+4a
	7MV34L3R/Umkmjj2HevB5iND0Trs19SHhVQ0+vJOUniDC3rVXkt5cL+Wr3MtznfsXhLp52L8Pka
	KoX3Lzu6LApCtXuHfKyDXnIdq7jdoMtg=
X-Gm-Gg: ASbGncsetb1U4Y+3+1IlILrIftZEcGc3HhYsc4wjhb6f1Vknr7ehFK+fpKqbIRqhrbT
	DqRW8bOZfnXV0paqy+mibk3GTt/B6yhbPyDoYEUcf/Hk/C9cadl7HRAQYIpENXg1nDrXY5YXl3s
	nJfNWYSEfHlzFWNqelgaFWQSaaXDSgkTAlgzFUh4l63pq6PMCME1lCTrjIltktKgabKN+5PttCf
	rE0xWxaxCQlkOqc+oyf+FdEOx7wx8YcO47/3G6+d1JmtUBenSenQpBD5DKzVsYeSnh0utg=
X-Google-Smtp-Source: AGHT+IFxTA910sxVxAdsWMvTYjxCPSsDFmVVHsQqC0TODktXwiP/3kuOpPOw4vtMbF3RViOY4MXfba/2pIwRqoBjrjI=
X-Received: by 2002:a53:cf4d:0:b0:63e:ee8:df74 with SMTP id
 956f58d0204a3-63e16269ba6mr1313245d50.63.1760659100750; Thu, 16 Oct 2025
 16:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016204503.3203690-1-ameryhung@gmail.com> <20251016204503.3203690-3-ameryhung@gmail.com>
 <f5bf014d-46d7-44da-8a63-1982cd45d9ba@linux.dev>
In-Reply-To: <f5bf014d-46d7-44da-8a63-1982cd45d9ba@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 Oct 2025 16:58:04 -0700
X-Gm-Features: AS18NWCK6mGXJsDw8W_8tWezGpFE3ro35HJ_YJYQE86v_zJzOy9Z61dIasxXY3Y
Message-ID: <CAMB2axOe3wMFNyn_TiFrw8iRPjW5RbmkpQBXh2fPUrVF-rkHFA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:51=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
> On 10/16/25 1:45 PM, Amery Hung wrote:
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index a41e6730edcf..e060d9823e4a 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf=
_struct_ops_map *st_map)
> >       for (i =3D 0; i < st_map->funcs_cnt; i++) {
> >               if (!st_map->links[i])
> >                       break;
> > +             bpf_prog_disassoc_struct_ops(st_map->links[i]->prog);
>
> It took me some time to understand why it needs to specifically call
> bpf_prog_disassoc_struct_ops here for struct_ops programs. bpf_prog_put
> has not been done yet. The BPF_PTR_POISON could be set back to NULL. My
> understanding is the BPF_PTR_POISON should stay with the prog's lifetime?

You are right, once BPF_PTR_POISON is set, it cannot be cleared. Will
fix it in v3

> >               bpf_link_put(st_map->links[i]);
> >               st_map->links[i] =3D NULL;
> >       }
> > @@ -801,6 +802,9 @@ static long bpf_struct_ops_map_update_elem(struct b=
pf_map *map, void *key,
> >                       goto reset_unlock;
> >               }
> >
> > +             /* If the program is reused, prog->aux->st_ops_assoc will=
 be poisoned */
> > +             bpf_prog_assoc_struct_ops(prog, &st_map->map);
> > +
> >               link =3D kzalloc(sizeof(*link), GFP_USER);
> >               if (!link) {
> >                       bpf_prog_put(prog);
> > @@ -1394,6 +1398,46 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >       return err;
> >   }
> >
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap)
> > +{
> > +     struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map =
*)map;
> > +     void *kdata =3D &st_map->kvalue.data;
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&prog->aux->st_ops_assoc_mutex);
> > +
> > +     if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc !=3D kdata=
) {
> > +             if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISO=
N);
> > +
> > +             ret =3D -EBUSY;
> > +             goto out;
> > +     }
> > +
> > +     WRITE_ONCE(prog->aux->st_ops_assoc, kdata);
> > +out:
> > +     mutex_unlock(&prog->aux->st_ops_assoc_mutex);
> > +     return ret;
> > +}
> > +
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> > +{
> > +     mutex_lock(&prog->aux->st_ops_assoc_mutex);
>
> Can it check the prog type here and decide if bpf_struct_ops_put needs
> to be called?

I will move map refcount inc and dec into these two helpers.

Thanks for the suggestion

>
> > +     WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
>
>

