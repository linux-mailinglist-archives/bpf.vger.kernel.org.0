Return-Path: <bpf+bounces-36949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5A94F8B4
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF11F21CDD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51C16BE01;
	Mon, 12 Aug 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="UQPKgpy+"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430A152199
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496627; cv=none; b=N1o34K4w0fg115eqxEmE7nsYH6ZD3k0p7bn5TI/gA5VtvMWX6jkSjKFuOrLa0n0ar0rAAftFBt8nvtPiIDAvbvFadN0E2imOWv97/HOXjDtILv3nUGKyDT7i0/sHsh/mhKRC4qsbAcZjrN+jLkjA+1qgvUxTo7tRPpv4ozrWh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496627; c=relaxed/simple;
	bh=imCPl7VJv8TVQxRebXV5mone1MYvFgZ87Sat2+q4YAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulO9qBnUwywdRCWzMxKw7IuhYAWnuXu6Ue00Emzfw7RYPK13BM+N4AAArPlbz5CLdUr86cmFsxwlCT+HJ8+TIRxRTNoEjNG58g4f6uPJKQ7QNK0kJCw0SLUT5zi0LtA9saBePN8ceFUtvGHn7kJNsRho9HNqdbHIsfXinRcJIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=UQPKgpy+; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723496623; x=1724101423; i=linux@jordanrome.com;
	bh=WdKOvsDHheZsFknp1VwqWcFtfV/qLrCxkb7Q+nhLedM=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UQPKgpy+fuuT2CZ7jVMwZiJk6PiweYu1l49jh1y0RwqmPrHMomVVbK82xm2gIaWX
	 q8U8XltcO8/Yw3f6OnjD8SlTNUFOheES5TLFxrzJ/diMxke16XCt0qL2kL6RYRrG9
	 /DDgzXnb2TWQKeytKcL8dgNEO9ij+m7ctqKkzS4Cflg8RGuuZB8FyUpqoguWpV6/N
	 2A6HVnrU/keUV8kPki9i+R0hZf5HCjZLVVYJaD2jAB58moMY/y1k2fWYV3zpGMRrS
	 I9IQucDvpk3I70fJiIxPCkQnZh3b7VUaxGK8vAJFnoFNzE80lwZXY95xBnIKTIrGk
	 Us942/ZvCAFYj8eXbA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f178.google.com ([209.85.166.178]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MfWg9-1soFT232pH-00Ix51 for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:03:43
 +0200
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39b06af1974so17618975ab.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 14:03:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw856IHpTmaaAHVAdXHIKCkxXtTbPZKTGzbsk8nUrjkozh6hvSs
	hZ9WKHS36rE/pgmpb2oK2WGTMIXzlvi4QZyYb46ppTPHrOkjuthhyQ5N9RLETfBLxOlQARxZABp
	9mQt/arTKjyfmUhGROr9fpzHHFgo=
X-Google-Smtp-Source: AGHT+IExUA+aGDmN5A16HEcHZaytOdP8ly+RGcNZSfn2rXnd8EmVvAHtyjDOPgn5T1D4ynx1RxK1vDoZTKqfSZZykcE=
X-Received: by 2002:a05:6e02:1a6e:b0:398:fc12:d701 with SMTP id
 e9e14a558f8ab-39c478fb86amr16285455ab.24.1723496623298; Mon, 12 Aug 2024
 14:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811235439.1862495-1-linux@jordanrome.com> <0be2afc8-1845-4c0b-b61b-d523e017d237@gmail.com>
In-Reply-To: <0be2afc8-1845-4c0b-b61b-d523e017d237@gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Mon, 12 Aug 2024 17:03:32 -0400
X-Gmail-Original-Message-ID: <CA+QiOd788n27m9V43+uiemN6zyUMQFAoA=WzXzGnZrMstDn_pA@mail.gmail.com>
Message-ID: <CA+QiOd788n27m9V43+uiemN6zyUMQFAoA=WzXzGnZrMstDn_pA@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:izcCwU9GmxciT15Xs1f+PHVIbujKfeTVQG36FYZMxWusjKVHAus
 /XagV1YWs+Y5rIQMc8raLuzjEIzKPPY3D8DEUQG9PSH3B6mnEccJfnebS8UscEoi5e3BI1R
 70niqUw8eL7WkTPYOI8VQ1CgxdTDzGzTnIQclVuAJ0MQC67kML+nbpziNqst1gljDxzT/wb
 SMGwghgCydhyjXc2tViSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tp87SlywX8o=;Bxgb3rbGvTqteOyaPIF3czZmbtW
 /oXNSOFeiRSnjZv5OgbCjchO6wdgFDJmd7EcrZKqnEOoF5xUg7VHvT4UPyC4jQndjVJxZwW92
 gGOyBU3pvcmD45iGwdyBIJG10V9SH0AQG2cY9KZsBzIWm5I7c+l68+8EXPdsIRhifn3oddGAk
 3EQy//KkJeuww/smE53YyqHEUOCwFGcv7dCauQ5v26C++WOBC4KWh95VXtlA4vImT5HWW2DVT
 /s+5TBkzd1u4gdKer/lAz7ePd181sbR1Pyl8d/t1MGCDA+EgQRHL08myhqM2EYAWgitAvn/AS
 wMvYdAVSk/2v1Szfe4fgtCGjTzoAEDap+vKCTaWGI/V9rPBt3y+++pELHcinbqwopledayX6G
 cu981K1mASweEDNhvUUIJ4BN0cUMkgNATUaqYwn3EwSAhKS4OjbXhqhwaz3qJmhpFU1i81VrI
 TpoT7e3zVL0M8wpa+qaj45JsXDEVVbRs/8WKnI70G7Z6QXa6NklCD3ofbC0uln3MogsmGt/Kd
 NfnuWpHNMolvXh0Q0KuPxa90RuITKu0LJRguexZVW419uUSedPQuYoWx5w0v2wSJ7Pz4aTakh
 gpEXB86Sp27asULntoDW/7uglNNKLGwNHsVnOcZRzgK///HEViar0NuB/2lXnjmDPbtCpQDyX
 yMdkuDgnhk9oZ3vyEYYcOH/E6l1XcGHLkF910rvJd27fKuMLjEcR9s7E3MZHrcvgkRNFxdT5Z
 VTXLNxmBJaLnBJv0pfhhFovpg2cg8MvYg==

On Mon, Aug 12, 2024 at 11:55=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 8/11/24 16:54, Jordan Rome wrote:
> > This adds a kfunc wrapper around strncpy_from_user,
> > which can be called from sleepable BPF programs.
> >
> > This matches the non-sleepable 'bpf_probe_read_user_str'
> > helper.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >   kernel/bpf/helpers.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index d02ae323996b..5eeb7c2ca622 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2939,6 +2939,37 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bp=
f_iter_bits *it)
> >       bpf_mem_free(&bpf_global_ma, kit->bits);
> >   }
> >
> > +/**
> > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addres=
s
> > + * @dst:             Destination address, in kernel space.  This buffe=
r must be at
> > + *                   least @dst__szk bytes long.
> > + * @dst__szk:        Maximum number of bytes to copy, including the tr=
ailing NUL.
> > + * @unsafe_ptr__ign: Source address, in user space.
> > + *
> > + * Copies a NUL-terminated string from userspace to BPF space. If user=
 string is
> > + * too long this will still ensure zero termination in the dst buffer =
unless
> > + * buffer size is 0.
> > + */
> > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const =
void __user *unsafe_ptr__ign)
> > +{
> > +     int ret;
> > +
> > +     if (unlikely(!dst__szk))
> > +             return 0;
> > +
> > +     ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);
> > +     if (unlikely(ret < 0)) {
> > +             memset(dst, 0, dst__szk);
> > +     } else if (ret >=3D dst__szk) {
> > +             ret =3D dst__szk;
> > +             ((char *)dst)[ret - 1] =3D '\0';
> > +     } else if (ret > 0) {
> > +             ret++;
>
> I prefer to keep consistent with strncpy_from_user().
> Considering ret >=3D dst__szk, it is not actually copying dst__szk bytes.
> The last byte is generated by this function, not copying from
> the source buffer.
>
> Copying at most dst__szk - 1 bytes is more concise.
> The code could be simpler with this concept.
>
>    ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst_szk - 1);
>    ((char *)dst)[max(ret, 0)] =3D 0;
>
> WDYT?
>

Makes sense. No need to copy extra data if we're just going to overwrite it=
.

> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   BTF_KFUNCS_START(generic_btf_ids)
> > @@ -3024,6 +3055,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >   BTF_KFUNCS_END(common_btf_ids)
> >
> >   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.44.1
> >

