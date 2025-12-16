Return-Path: <bpf+bounces-76752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DACC5025
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473EC303FA75
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7493242D8;
	Tue, 16 Dec 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHUilc3/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194916D9C2
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913053; cv=none; b=diUyOnfFO24zLnXYb0vsNjH3VKmAdk9/soX2SijjTmjDLaLl5ghjydjMX0h/JvSnVb/0gGTSTvU7NPOOltx1DINOlQHHA5OIbrzfAkZlEGAKJXJFX29zLpJCvHUNGWN5v+a0QskSDj6S4/EGk4lDtAQHq0Qez8Jm4AcAm/0CZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913053; c=relaxed/simple;
	bh=ooZ0QfKUBYA6shRv2CRc6MFKQQBfLYgGe2Cf4cQjEQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihzDJucvqHdOcWvObs78B5kGxULZKNvwDwyBuQjnO4zhnHy2B3QbmUcMKzzsSrPJ98xsAUzjJuCNt3kxBei7T/kXO5gBHNcxp7qR24WOytO0K8eKj1obS2cQPHEpcUWDYT+Tj/2FG+mzNel8hD2dtExZi1pMGeKnXvKss8+r6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHUilc3/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f1bc40b35so71907335ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913051; x=1766517851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OFLb+PyTjJ/zhmEb+HAMOWfwVfqn7xB1EKids03e+E=;
        b=HHUilc3/j8hjkib3Xv4+9z2ZGT/Fo+U7J3Z0PmZ7yWbp3tP8kW4CYrh4eivAjg9Ap9
         EMOV8nMDVnqZHEs9Sm3tuxvhYnN68Y3mLw7cWGvs9fIvVAL7FffPSSG/7yt+GfCtsw5L
         IzebzNlONsRSUBBva2n6CL7JuPsNdVZ397OFerqiozpujB/w8k0v66J+Zt5MUhI3ucAb
         SHom4ajmcEgEMxmgnnXKEIg5PDSSNRacYqK7kTmFoacy5wyZZ/XeP1qzUiFOdAvBOToD
         4+k2vFTauL/KOYivrc/Hi8zWjToO+B5hbfX2tptTl/BIjlJKFXWl3CfgxT6CmWRYbj2M
         P9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913051; x=1766517851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OFLb+PyTjJ/zhmEb+HAMOWfwVfqn7xB1EKids03e+E=;
        b=C3xmf7OWDVOKoc7ErX5woNlHNBjdLR7W5O+Bjso1SyCbcrMcKFtG1PnGW1wNihPIZR
         6smxMYzm2Cnmp5mYohSmpGOOkpw3JcfmZzkTSOUNlR217I6pLFS4CG9rGRCzkTl643uA
         mosYxPftyZkVJ/7eqSOMbbyUZ4/rEv84PfiP3a+AsnWVGDBLbD0SqVKQJ36F/DoydGDE
         QhJUX1DTaW3rVFRNMbKgoD/6jYrh/ELsFTG+F4FFGpDKDPlIO0S2m99BuGPahzR6dOnF
         QesN8uQO5tAQnWyJIff8Z4zd99bU8bjh/X1NL3kaRPNYJ524LkHINAZMflzuI4iqdAVm
         /kCA==
X-Forwarded-Encrypted: i=1; AJvYcCWp6ypExtqThbyT5zhmW+nF7AT92BRqzzsfJjoPkTqOOfYg+gYMSdYO66+2DhcNOStdT3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf6JtZtQOXDmJLIwMusQeyrYX+Nrj0XchH/3uLdI/QJEhgZpe
	K8rXQc7LJRb1CjXbkclhce8gtklddB0JlVTYYcSEurZiFFolK90gcZwIGIrcm8xxscYs1zp52nr
	R/3ToAvUlhhYQ8j7fkCr4hQ5y6hh1SAo=
X-Gm-Gg: AY/fxX4cFTGS+m2MenDaT5d/va/etlDVXb63DEN7a1wTIDazZk1BLAHb0VyKsP6vLUP
	dZDCFBkmRJKCSFtgvRT1wqn3dQlXYBQKUUEIbD1VZ/ac0BXBE1kqfz+Ejx/khYI7nuipQB0sNgm
	JKc/4r0JRMkMQOj/9G5T10/vNf8okpEe3QByr9XLL45XSsX0ktRgNREGpg6rS4U3GmYd0WhQL0O
	6sBXfms5eCtS0I2D4eutivigF63HjfdP0I9c0WBFX9EhaXeP2uMw++njCmW7BMTSOVOPtcKNbub
	qivTTrBNYlo=
X-Google-Smtp-Source: AGHT+IHIx8dDm+HwHh/VEesDGa9Gc+/UFGspgdGg2mVgFc0+CunoiqlWIh2QtpZgYBRdgVlPWvS6uysXNQvo4CKjptY=
X-Received: by 2002:a17:903:2350:b0:29f:3a57:ba7a with SMTP id
 d9443c01a7336-29f3a57cd8fmr131776335ad.19.1765913050293; Tue, 16 Dec 2025
 11:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-2-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:23:58 -0800
X-Gm-Features: AQt7F2oNfULt3jn1QW5lR7kfBJeeWWTmPXgFNySNwWJJijvNSYos0_6ZraaCyV8
Message-ID: <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> BTF kind layouts provide information to parse BTF kinds. By separating
> parsing BTF from using all the information it provides, we allow BTF
> to encode new features even if they cannot be used by readers. This
> will be helpful in particular for cases where older tools are used
> to parse newer BTF with kinds the older tools do not recognize;
> the BTF can still be parsed in such cases using kind layout.
>
> The intent is to support encoding of kind layouts optionally so that
> tools like pahole can add this information. For each kind, we record
>
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
>
> The ideas here were discussed at [1], [2]; hence
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=3D=
Nuc1g8JPFC34MA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@ora=
cle.com/
> ---
>  include/uapi/linux/btf.h       | 11 +++++++++++
>  tools/include/uapi/linux/btf.h | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..c1854a1c7b38 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,15 @@
>  #define BTF_MAGIC      0xeB9F
>  #define BTF_VERSION    1
>
> +/*
> + * kind layout section consists of a struct btf_kind_layout for each kno=
wn
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +       __u8 info_sz;           /* size of singular element after btf_typ=
e */
> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/

So Eduard pointed out that at some point we discussed having a name of
a kind (i.e., "struct", "typedef", etc). By now I have no recollection
what were the arguments, do you remember? I'm not sure how I feel now
about having extra 4 bytes per kind, but that's not really a lot of
data (20*4 =3D 80 bytes added), so might as well add it, I suppose?

I think we were also discussing having flags per kind to designate
some extra semantics, where applicable. Again, don't remember
arguments for or against, but one case where I think this would be
very beneficial is when we add something like type_tag, which is
inevitably used from "normal" struct and will be almost inevitable in
normal vmlinux BTF. Think about it, we have some field which will be
CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
totally break (old) bpftool's dump, as it really can be easily ignored
**if we know TYPE_TAG can be ignored and it is just a reference
type**. That reference type means that there is another type pointed
to using struct btf_type::type field (instead of that field being a
size).

So I think it would be nice to encode this as a flag that says a) kind
can be ignored without compromising type integrity (i.e., memory
layout is preserved) which will be true for all kinds of modifier
kinds (const/volatile/restrict/type_tag, even for typedef that should
be true) and b) kind is reference type, so struct btf_type::type is a
"pointer" to a valid other underlying type.

Thoughts?

> +};
> +
>  struct btf_header {
>         __u16   magic;
>         __u8    version;
> @@ -19,6 +28,8 @@ struct btf_header {
>         __u32   type_len;       /* length of type section       */
>         __u32   str_off;        /* offset of string section     */
>         __u32   str_len;        /* length of string section     */
> +       __u32   kind_layout_off;/* offset of kind layout section */
> +       __u32   kind_layout_len;/* length of kind layout section */

nit: kind_layout is a bit mouthful, have you considered "descr" (for
description/descriptor) or just "layout" as a name designator?



>  };
>
>  /* Max # of type identifier */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/bt=
f.h
> index 266d4ffa6c07..c1854a1c7b38 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -8,6 +8,15 @@
>  #define BTF_MAGIC      0xeB9F
>  #define BTF_VERSION    1
>
> +/*
> + * kind layout section consists of a struct btf_kind_layout for each kno=
wn
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +       __u8 info_sz;           /* size of singular element after btf_typ=
e */
> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> +};
> +
>  struct btf_header {
>         __u16   magic;
>         __u8    version;
> @@ -19,6 +28,8 @@ struct btf_header {
>         __u32   type_len;       /* length of type section       */
>         __u32   str_off;        /* offset of string section     */
>         __u32   str_len;        /* length of string section     */
> +       __u32   kind_layout_off;/* offset of kind layout section */
> +       __u32   kind_layout_len;/* length of kind layout section */
>  };
>
>  /* Max # of type identifier */
> --
> 2.39.3
>

