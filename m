Return-Path: <bpf+bounces-73942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF902C3EB35
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A12A349842
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15373307AF0;
	Fri,  7 Nov 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EacKgLBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7F308F18
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499322; cv=none; b=pByo2WkJlEm0nB+SvyXVO8F+zZCs/go+QOTCNK+AIROSzKfrzFDMWFMaT/kjRzZGCCGODCu5KQn7rqFVU/nH4QLaybk22MIR+7icFZgW3RMfvfMqzvRuQGOd+n9C6UP2COLHQ81EOivCK/PJW57wLa4l/h2lbF/T5Y6E/skQHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499322; c=relaxed/simple;
	bh=XsDDITV8OWmQdCapUaa2dsxiNW0QLHRYrY4nSY8eIBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba/YNSVUp5RT3JBFQrh4ht9D3sFGIzmpw3CF8v6d+RsegoX/y3SSl0Hf9DRa9XXN/LDuN/ekHJJj2w+5Ria68KW9Zg4IQOGhxE/XPKsmXinoPhNrAJPAGyk/DC9h1TPj8dtl2fZXBX7ZNIyZb4SFXinMxn9uhtzSArzMoKeq79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EacKgLBs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso739101a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762499319; x=1763104119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kkkoa0Qtmx3EewntMjJGazvW7ZNLbuHZXYNylL6HWdY=;
        b=EacKgLBs/Km8PdU4SQOIYrLzY06I87tOqLMeQryBT5sMmHRlRe91jrSodI79khJYdZ
         bSfUCLYuBfjGpC/7YTQcDMaLc/a2zfNA3rZMUrx0fcS4ZM7aYkjmt0zjI4NSK2YknJpQ
         iEvWF7YexpLRr6LGfUyOPVqcvnEZxaDOy517ooh/BXzDck/ylk/e5zmfsgXqGQaQ4LEh
         XVCgNN456IpnSmyproE3X/02t09lxKiAZE5oH/qh1spgo7AYgCoRnZEkCO0qGoUiUBTu
         j4HcrgMLL0Z76rIl0QXv+8PSQTm3uHR7Y3XUg8sqckDynrDwo6qZG8ULUVwS+fjXuTJL
         7FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499319; x=1763104119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kkkoa0Qtmx3EewntMjJGazvW7ZNLbuHZXYNylL6HWdY=;
        b=Rc7ExfhgM0KyyZD0WtLEyCy+Yt5HyTLqpn0Ft7uGSOGfkqph66v7zrRf2e80FWzY4m
         by10JN/xvdXvp5/AinP+kdcNgbyYygZu7AB2YJ2tnyvuyCItrjLKSj+B4gBw54v6PAQU
         D7XicP0rnjO6qB6sW9eoLOoSHSki9CZeZvgrGOKSfKN17/mQEVukynXo8Ro4YIHWTdXX
         IHrsk1q0y0Uk0/s1jnJfau3CUcNvbNpuphueLuO9loMRCLQfRYbPiGWNfKKiSTiAROjg
         BYJl8MaXdN9jsANtkDBOjltV5P4tUPjvMZk1uRpc+wgvEhzI1AK06qXhYV4MwQmIKtTV
         5RyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6lYgdMi/OrMxNY5VWH8wK/xaPDBCOMdFb5Pyd9eQfQ2HoJoZAFFXW1Xyn/ZFObg84WsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAfCzX2xWctlC1E+zMJLtUXsP/9/9JdAZHjAWo3W00lTX4kr8
	HFXLJCTM5iYI5lyqpXfL0+6MFcp4FAKpkzeC3kCbNCzR2AFGhRHI5AMeyk/4ajKZLpK0qaG4zQb
	DSMDmVdI3/tuu5MmEqhQNM61pMEFKZWQ=
X-Gm-Gg: ASbGncuD+UnSfFWuJvaJXWjRCkgJTUIVPpCBjG0SshdxIY88tkl/AxdowPdYLAKo2Mz
	Il3WbkvjjC6HhncJcs5uKRVdEWnch9jLdmNf0c9CsigWw8uQPuXGHdWQnXmXzpmXE2jeO2qDJGj
	EMwWMrdCOEXNZpXdCkjyhTSp2L72pHmLeQ8xQJOd++aU0GZrdATikvg3Z5m7SdHjfkeK32TjFEP
	82Yu4uuf04JmKHYT6cGKFJzjQ2C36x1b2TJkj6VYhsIlYIca0smvHRcqc6pTPX/wHKCN5Es
X-Google-Smtp-Source: AGHT+IEta83ao05iVpNzKODH8xVEHJalzn8VVP1Sd2bSnfeqnAj1ZAytCVOc5BXM7WjM0JApQ6Cm2A38MOUKcYS6tV8=
X-Received: by 2002:a17:907:d91:b0:b6d:6b56:bd7d with SMTP id
 a640c23a62f3a-b72c078d4d7mr197261466b.16.1762499319040; Thu, 06 Nov 2025
 23:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com> <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
In-Reply-To: <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 15:08:27 +0800
X-Gm-Features: AWmQ_bmYxR0hfZziNSab6vyfXndKEp02ZgMWIAFGdrY3CGiXT8463JKVPu3nV5I
Message-ID: <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, alan.maguire@oracle.com, song@kernel.org, 
	pengdonglin@xiaomi.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 66cb739a0..33c327d3c 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +/* Verifies that BTF types are sorted in ascending order according to =
their
> > + * names, with named types appearing before anonymous types. If the or=
dering
> > + * is correct, counts the number of named types and updates the BTF ob=
ject's
> > + * nr_sorted_types field.
> > + *
> > + * Return: true if types are properly sorted, false otherwise
> > + */
> > +static bool btf_check_sorted(struct btf *btf)
> > +{
> > +     const struct btf_type *t;
> > +     int i, n, k =3D 0, nr_sorted_types;
> > +
> > +     if (likely(btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK))
> > +             goto out;
> > +     btf->nr_sorted_types =3D 0;
>                             ^
>
> Can multiple threads race when writing to btf->nr_sorted_types here?
> Looking at btf_find_by_name_kind()->btf_check_sorted(), I see that
> btf_find_by_name_kind() receives a const pointer but casts away the const
> to call btf_check_sorted(). The function bpf_find_btf_id() calls
> btf_find_by_name_kind() without holding any locks (line 737), and later
> explicitly unlocks before calling it again (lines 756-757).
>
> This means multiple threads can concurrently enter btf_check_sorted() and
> write to btf->nr_sorted_types. While the validation logic is idempotent
> and all threads would compute the same value, the concurrent writes to th=
e
> same memory location without synchronization could trigger KCSAN warnings=
.
>
> Should this use atomic operations, or should the validation be performed
> under a lock during BTF initialization before the BTF becomes visible to
> multiple threads?

Hi, is it necessary to address this issue?
For example, by using atomic_try_cmpxchg or WRITE/READ_ONCE? Using
atomic_try_cmpxchg can prevent race conditions on writes but requires an at=
omic
variable, while WRITE_ONCE/READ_ONCE can avoid KCSAN warnings. Since
the race condition is unlikely to cause critical issues, I suggest using
WRITE_ONCE/READ_ONCE.

>
> > +
> > +     if (btf->nr_types < 2)
> > +             goto out;
> > +
> > +     nr_sorted_types =3D 0;
> > +     n =3D btf_nr_types(btf) - 1;
> > +     for (i =3D btf_start_id(btf); i < n; i++) {
> > +             k =3D i + 1;
> > +             if (btf_compare_type_names(&i, &k, btf) > 0)
> > +                     goto out;
> > +
> > +             t =3D btf_type_by_id(btf, i);
> > +             if (t->name_off)
> > +                     nr_sorted_types++;
> > +     }
> > +
> > +     t =3D btf_type_by_id(btf, k);
> > +     if (t->name_off)
> > +             nr_sorted_types++;
> > +     if (nr_sorted_types)
> > +             btf->nr_sorted_types =3D nr_sorted_types;
>                              ^
>
> The same race condition applies to this write of nr_sorted_types as well.
>
> > +
> > +out:
> > +     return btf->nr_sorted_types > 0;
> > +}
>
> [ ... ]
>
> > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, co=
nst char *name, u8 kind)
> >                       goto out;
> >       }
> >
> > -     if (btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK) {
> > +     if (btf_check_sorted((struct btf *)btf)) {
>                                   ^
>
> The const cast here enables the concurrent writes discussed above. Is
> there a reason to mark the btf parameter as const if we're modifying it?

Hi team, is casting away const an acceptable approach for our codebase?

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/191371=
95500

