Return-Path: <bpf+bounces-68855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A3B86C71
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867261CC3DDB
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411F2ECE8B;
	Thu, 18 Sep 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXUOmst9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C662ECD2E
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225170; cv=none; b=agMJJNKkJ0TYqv1lsnU7q0fakRbJvrUj4qUQWiSsTBGREH/haPABvwrIWL7dzND87e1lI21EE8wJy3I9q/0fTP/yc8Wyzo94E39NzdPpqrDu/7x0yB/jnC+5LzTGsBZ85wudxQDt9jMUadNSPO8o5n3kcP63xpxandpvIV3UsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225170; c=relaxed/simple;
	bh=mIOvxHVdRTtTSGTgG5hAn2Zd5FH/hqC7ydygZHLhI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJmofvV2OrCJ2z2M8uQkWUUaZ4MUKMWLvnQYds2/kCvNVeGXXcl6cucGwFbUXNxjPahXXpvFAkQMoB6lclYHMwZ12vE9YOERk5hLHXQBy0dGCclYCP08JiCNdd+3I9tb77QxM25UOJA/jNexAdEzjCNP/RJFAQx0iPYK9VuJSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXUOmst9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d93e562so948427a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758225167; x=1758829967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHOQdpAFrq178/sOB2C5OMWHbJdjZ8duJL6ZZ4I7Ax0=;
        b=IXUOmst99ZDBSmwtRX9F1COWXKMHoTvN5mUP+uI3V9a0Z+RR9WuXOcmvZyy7j0JGB3
         xYvRYqdXePMBfaAuATju0ouFM624fuGo3aLMZQI2nldqwPBdC/EzH4NDsPweWXl6N1qA
         8KHHTdd08xGow2gNz6jBaD18Tq3pbtnsMUq1N/djOj8yMDcgExWChtyQ/eSoVagCohUT
         MeEG9rRHZY4Gy+E1lEm+WmuJ4QYES3yxT8JxpmX+0jPk349fDi4dWhyzCJL6WY+CzNAk
         GjpPuKkUSQtcnGQij2bSBioaDP1RaSuJWg88yVwh5+c1kpG3AuAEm7jRDSNdY4YDj7NC
         DZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225167; x=1758829967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHOQdpAFrq178/sOB2C5OMWHbJdjZ8duJL6ZZ4I7Ax0=;
        b=QyHmEukcBcc9/GmtO7ZNLQL6WOPdmjPyg6dbH7LXIYQPiGgO86cDFfbrO9tOgLzYyQ
         f2Wevr2WLfNdyt8WBIXvPNJs8oRKf6zb/wD8H5liZrmywqS530gFYfpoxZYiCV9ueEPY
         BKGFJB+DvPHiC8bGBwWKRsBT6xtIBK212O8fZhq6G2yXAAYIH4tcfDVmItb/8lI7WhZ8
         UWNarSLyXbbEwm1zDE18T6m9GbLfDCsFa0c4RD75Hk078C3tTdaBvPpZ/sz6wbQJtQs5
         npbd6vaoS0wSJAY0Ek5Pi2md+zowigldvCOxko3LGl8/wRR1VblKeiSGhtIXfE0FXtQx
         gIEw==
X-Gm-Message-State: AOJu0YwDyaDk0Mrao4WoJ4t6FunW0Sl1gfRwu0/E+PqDkkn92JoE7s6W
	j8NxnjOBG/3nixoW6uqnGOy+NRZwQnEgJaGaxe0Oipu0CtYrW66EYkWVnEseNHVzuoqKVph63Rg
	Y4eyc/YQGl965UCH13WToxCm50bFO4fQ=
X-Gm-Gg: ASbGncsJBRl6NAMw11K96yySOafuQ2J5ns70XvcjCXZBaWOjcNx+VoaW9PB3LUCl/Ry
	s4JicGJtPGlqmguWDkTeq2AvhZku056owgaAQhwNG5abOszV6cJH5HdOi+C0zmd0DkBD9nxH2Ly
	cuAuiy9EZkR+zzIx3yDTydgMsciMNh1onTkKa9B7EFfSbRm8u5Zsrm4b1lQWG6Hxmci4LWcYmOz
	Mre1t+x25wtU/x91gyu/zHkHfc5w8C+FNGYdWhi1g==
X-Google-Smtp-Source: AGHT+IGPMrhhDUKLpnWP+A2D3j2K0nfsC3UrflR+kG8PCX9NG2k1j3xa7Z+jAHMdASdOmu1qA4lZ9iQISiwpf+h+oJg=
X-Received: by 2002:a17:90b:2d0c:b0:32d:fce9:283a with SMTP id
 98e67ed59e1d1-33097fdc427mr704400a91.3.1758225166863; Thu, 18 Sep 2025
 12:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <DCV6E0U82WFC.2GU139G1W4KMA@linux.dev> <CAEf4BzZeVcae2rcTc0o7q8xFH5-gb1hLG8RAXSgi_Cf-u--Xpg@mail.gmail.com>
 <DCW20D1KYRVK.3F0XX08AWICGT@linux.dev>
In-Reply-To: <DCW20D1KYRVK.3F0XX08AWICGT@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Sep 2025 12:52:32 -0700
X-Gm-Features: AS18NWAl5vZj3j58g7s_BdccmHdFGjIyFxJX-TdwPkzMgExrSakOwm6K5R_bhiI
Message-ID: <CAEf4BzZfd3Lm2MhOdZVeZzVzTvTO6K+8eUP+6Cb8cQW9x=syCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:07=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> >> >> @@ -1698,9 +1709,16 @@ __htab_map_lookup_and_delete_batch(struct bp=
f_map *map,
> >> >>         int ret =3D 0;
> >> >>
> >> >>         elem_map_flags =3D attr->batch.elem_flags;
> >> >> -       if ((elem_map_flags & ~BPF_F_LOCK) ||
> >> >> -           ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field=
(map->record, BPF_SPIN_LOCK)))
> >> >> -               return -EINVAL;
> >> >> +       if (!do_delete && is_percpu) {
> >> >> +               ret =3D bpf_map_check_op_flags(map, elem_map_flags,=
 BPF_F_LOCK | BPF_F_CPU);
> >> >> +               if (ret)
> >> >> +                       return ret;
> >> >> +       } else {
> >> >> +               if ((elem_map_flags & ~BPF_F_LOCK) ||
> >> >> +                   ((elem_map_flags & BPF_F_LOCK) &&
> >> >> +                    !btf_record_has_field(map->record, BPF_SPIN_LO=
CK)))
> >> >> +                       return -EINVAL;
> >> >> +       }
> >> >
> >> > partially open-coded bpf_map_check_op_flags() if `do_delete ||
> >> > !is_percpu`, right? Have you considered
> >> >
> >> > u32 allowed_flags =3D 0;
> >> >
> >> > ...
> >> >
> >> > allowed_flags =3D BPF_F_LOCK | BPF_F_CPU;
> >> > if (do_delete || !is_percpu)
> >> >     allowed_flags ~=3D BPF_F_CPU;
> >> > err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
> >> >
> >> >
> >> > This reads way more natural (in my head...), and no open-coding the
> >> > helper you just so painstakingly extracted and extended to check all
> >> > these conditions.
> >> >
> >>
> >> My intention was to call bpf_map_check_op_flags() only for lookup_batc=
h
> >> on *percpu* hash maps, while excluding lookup_batch on non-percpu hash
> >> maps and the lookup_and_delete_batch API.
> >>
> >> I don=E2=80=99t think we should be checking op flags for non-percpu ha=
sh maps or
> >> for lookup_and_delete_batch cases.
> >
> > Can you elaborate on why?
> >
>
> I=E2=80=99ve reconsidered your suggestion, and I agree.
>
> With your approach, CPU flags and the CPU number won=E2=80=99t be checked=
 when
> '(do_delete || !is_percpu)', which makes sense.
>
> I=E2=80=99d like to update the code as follows:
>
> allowed_flags =3D BPF_F_LOCK;
> if (!do_delete && is_percpu)
>     allowed_flags |=3D BPF_F_CPU;
> err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
>

sure, lgtm

> This way, CPU flags and the CPU number are only validated for the
> lookup_batch API on percpu hash maps.
>
> Thanks,
> Leon

