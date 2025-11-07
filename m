Return-Path: <bpf+bounces-73975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E3C41444
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0944B3BFE21
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA2339719;
	Fri,  7 Nov 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbIqRCGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB02F83BC
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539580; cv=none; b=m/UGauyeW+8/mM4xG3tZY8PRO3YvoC1254t6XQmWQpM/uTzEWFXImCKMqyLB9Sjhl7IUZ9509KxKY008GeInXW8qx0Ce/fqHN1OsoZ9KoVRfMPpKXPV6/1p5ugGR1VI7Ggj3EQbPn4B7P88xoLobYwsMp37fK5jpF385rTK9Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539580; c=relaxed/simple;
	bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqbAS+MmimPA3wiLEwbp661Ja8pgFFU9zKGS7fRKlaLMF3k5l5acvd1N60eJpRnzljjXFtR6UcWg5hrM4d2z56pUbywxUPFtllRCHXyqd+evZeqK90Q5jc4rFYe0B7thdO+SZioNgk/znud3NEccX/gAXmUVn4EUC7m0HYizMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbIqRCGv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29524abfba3so10563715ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762539578; x=1763144378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
        b=bbIqRCGvsm5SgJnmK1OeHVeQXYBrxc/Mc2P1C9XF4II1wOpZggGjUJ8Qd6KDE5dm9v
         9wVCwD9fTzcPDjPHQeQTWKhCO8nhD7LyyWuOxUksoj8G6Obl6tySUMNkpusKeB6v7wYH
         bGqFzP/nHqMIuCUBLcGNcNeRHFo54h6GM8hAhoA6R4YdKIR1gnuAe9BaM3A/d28sGrhv
         80nUSPMOToiS7zMHF7D1GM0yz2Ypeu+KbHeDS0VocJk9BaRvFwcVGEM3fjywgjkGsxoJ
         xZwYn7LTuQrWoWCJ9AgyMwxsQZne+D0Ex3fsyGRnggqRXvgzb1otaVLz37GgvorCc6ni
         UElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539578; x=1763144378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
        b=GME/cOn4OOymKpzY8EcCOk+8bBBp2+g4fumuvSVhJupBmEbg18WnzggM3aEevdTDft
         0RQAkwUPittDxW3zKS/XfETGCPtq1pHbzr/xFUhYlsOF+oS3vbqUGBvVH08lVqwJOlBG
         nNuXEYHLEA07+7SkzBo5QH4FMFVmfNEb/nk7Yt6lmaKZnmZjxcy91fvCGc7i+u6Ax9bQ
         z2SthxO6tuR/KRyFpgfPERDiAyzw+InrrPttWzSbDnvdfxAYpXj8kN5M4tOeCO+KbpDx
         NFGCpSR1iP86RwdVUA8xC3UJqWnfupjTWnAtWKu0/fyd/oHMHElbg17YwZYMkRAeX0vz
         OKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa2QRHRk50tzcyPfiJWu4ymhbWSIDjj5uToxC4EPbfz+hOZsHh4UOfkPwoOhnsB4C6gRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY/1gqFAhrnlPN2Sa7ya7c7yu47B8Hsar6k2afH32uweBDtDn
	Rfewuf4NvFIaOB7n0s0xGEFv4o8OyXWnJfoAqdgmlUt3PqcM4QC2S+vJ
X-Gm-Gg: ASbGnctfSeS1ZBUJQBvjHUJ7Pq+IWtc5myiaRBbMWp5rqr7ZxqlYnfPoNe4xRkgMYIy
	ZmP63PVWfSS5lzG2Mz5NX4bPSD9W2xGICtAl4kP7SbLx6BkdCQT/+rGEXAhiGp8KaSmOW0+oPSP
	S/vJddG33mSA1LzDNEnaehY+vxpm8lBYGU+VXEDz8z1Xgq4yGKEUdRcMsptHKg1GqMExjH9Zc+r
	9j8ylNh1fEih90msZ49OH3aNMBTEXHNpmzMxmPznmeuxZoAX7G0Nky5/gnHA66GavUry/qaF8gr
	lgdrz1s7SYdO0d7lLny0wfhIqfQ9bRAiAChex5vMFj3Zt5AeRHlfQXw5UX1hKP5bcMvSWstoKR7
	9F5puPp8JmeX6dEfPI/VAkU936PRsMtU5ehgEKY3Pd1GVvHT5Tp0jtbeCT1nKx9Bd5sFFWXJMxn
	mOnTzweNE=
X-Google-Smtp-Source: AGHT+IFOtcW0FjrNxyzQVAwg8/hsWcVkY2/+FOGxCrw+aG6ME/j+PMfoUflj60UThewImLHLIJQRzg==
X-Received: by 2002:a17:903:3848:b0:294:def6:5961 with SMTP id d9443c01a7336-297e56d0868mr419605ad.45.1762539578179;
        Fri, 07 Nov 2025 10:19:38 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93e5dsm68382615ad.81.2025.11.07.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:19:37 -0800 (PST)
Message-ID: <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, 
	ast@kernel.org, andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	alan.maguire@oracle.com, song@kernel.org,
 pengdonglin@xiaomi.com, 	andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, 	yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Fri, 07 Nov 2025 10:19:33 -0800
In-Reply-To: <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 15:08 +0800, Donglin Peng wrote:
> On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 66cb739a0..33c327d3c 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return total;
> > > =C2=A0}
> > >=20
> > > +/* Verifies that BTF types are sorted in ascending order
> > > according to their
> > > + * names, with named types appearing before anonymous types. If
> > > the ordering
> > > + * is correct, counts the number of named types and updates the
> > > BTF object's
> > > + * nr_sorted_types field.
> > > + *
> > > + * Return: true if types are properly sorted, false otherwise
> > > + */
> > > +static bool btf_check_sorted(struct btf *btf)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct btf_type *t;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int i, n, k =3D 0, nr_sorted_types;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(btf->nr_sorted_types !=3D BTF_NE=
ED_SORT_CHECK))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 btf->nr_sorted_types =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> >=20
> > Can multiple threads race when writing to btf->nr_sorted_types
> > here?
> > Looking at btf_find_by_name_kind()->btf_check_sorted(), I see that
> > btf_find_by_name_kind() receives a const pointer but casts away the
> > const
> > to call btf_check_sorted(). The function bpf_find_btf_id() calls
> > btf_find_by_name_kind() without holding any locks (line 737), and
> > later
> > explicitly unlocks before calling it again (lines 756-757).
> >=20
> > This means multiple threads can concurrently enter
> > btf_check_sorted() and
> > write to btf->nr_sorted_types. While the validation logic is
> > idempotent
> > and all threads would compute the same value, the concurrent writes
> > to the
> > same memory location without synchronization could trigger KCSAN
> > warnings.
> >=20
> > Should this use atomic operations, or should the validation be
> > performed
> > under a lock during BTF initialization before the BTF becomes
> > visible to
> > multiple threads?
>=20
> Hi, is it necessary to address this issue?
> For example, by using atomic_try_cmpxchg or WRITE/READ_ONCE? Using
> atomic_try_cmpxchg can prevent race conditions on writes but requires
> an atomic
> variable, while WRITE_ONCE/READ_ONCE can avoid KCSAN warnings. Since
> the race condition is unlikely to cause critical issues, I suggest
> using
> WRITE_ONCE/READ_ONCE.

Probably use WRITE_ONCE/READ_ONCE?

> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_types < 2)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 nr_sorted_types =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 n =3D btf_nr_types(btf) - 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D btf_start_id(btf); i < n; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 k =3D i + 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (btf_compare_type_names(&i, &k, btf) > 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 t =3D btf_type_by_id(btf, i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (t->name_off)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_sorted_types++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 t =3D btf_type_by_id(btf, k);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (t->name_off)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr_sorted_types++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (nr_sorted_types)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btf->nr_sorted_types =3D nr_sorted_types;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >=20
> > The same race condition applies to this write of nr_sorted_types as
> > well.
> >=20
> > > +
> > > +out:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return btf->nr_sorted_types > 0;
> > > +}
> >=20
> > [ ... ]
> >=20
> > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf
> > > *btf, const char *name, u8 kind)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_sorted_types !=3D BTF_NEED_SORT=
_CHECK) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf_check_sorted((struct btf *)btf)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >=20
> > The const cast here enables the concurrent writes discussed above.
> > Is
> > there a reason to mark the btf parameter as const if we're
> > modifying it?
>=20
> Hi team, is casting away const an acceptable approach for our
> codebase?

Casting away const is undefined behaviour, e.g. see paragraph 6.7.3.6
N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.

Both of the problems above can be avoided if kernel will do sorted
check non-lazily. But Andrii and Alexei seem to like that property.

>=20
> >=20
> >=20
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's
> > not a bug.
> > See:
> > https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.m=
d
> >=20
> > CI run summary:
> > https://github.com/kernel-patches/bpf/actions/runs/19137195500

