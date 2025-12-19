Return-Path: <bpf+bounces-77168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60950CD10D4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC8F8301DC1C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3375E33A023;
	Fri, 19 Dec 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+nEfzM4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAF338926
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164065; cv=none; b=YPp2qPvD1R/5OqYdiQejXNNfZ/OUdZJ3jR5PkAl6Lh+h8m04TFHefvQV/xJUBXicmNJ3gS4eDxkAYaGHXUnSt6i/zqcqHgFSy/L+E3w5Qnyk7WHOgS9BzuH/DCi0gTaRuyqem+XlIJF1aaJcrRvOWY91YialmyeBmMeoIKA9pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164065; c=relaxed/simple;
	bh=IrmIQYX/WoDma3ByN4AdMi33RvKB7zffiKncd6fK24E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo7A+tZm67IpSMxBSHLknDoMGhInwq+a6Kjw8TGkNifcrefrZlb8NLYBl7Afr+QPQBGOX7Ro88+3MOw4nY8yhylvLsVAIOQxBKNA+F/HwN1JRrEoCgLsXCYK9UyB1kvUrObbLmXDGb+tDxJxGCQvgOPniVkCwB2nl6xWvq+UfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+nEfzM4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso1682383a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766164063; x=1766768863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO3ZlqaG1yuSYul9P12Gcsh65zBxNsLTdXYhAp0VIhg=;
        b=a+nEfzM4bsF35hEV/EfDSSmEyIugQBHsSZyea8ck5flJ/g8Tj03wVfSkaL19lyuGQU
         yyAuvWLCmdrJRA5bVpLRGaFsomW6c10dMZzT+jVVB+CLI5aJQkpuS/BZHEzWD85MdYwO
         v7nBvkicVvzM9wyHzatoSa0XjVoqSGPOxAVGQOhDYhiVFlkNxGz4ZP6QfsexRXYQ4RE9
         a6miv7GTUWlMFeNyTUaWcTY8VXwAzv7Zp2o7S6KDOM93z7ryxvQpfoD0iFN1+Ta3GZLQ
         pzB6FD0QLHSaCoH5gHLDSO3eiIPH8RfwlK6Qq75MuxR+ug9nIhDCV4mGcHf6B23tPNkV
         hivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164063; x=1766768863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fO3ZlqaG1yuSYul9P12Gcsh65zBxNsLTdXYhAp0VIhg=;
        b=I5eHm73GxxILWn0RuyZ1YFg/EZ0qOJ37pikHtLfLijf1FrIChgPVE+hdZK76NNcW6+
         8oQDCCpJGJnN5GfOM7YPFMgNayY1qUEfKpVoy5clfTer/zdHulC92g/wxPnGoIs5NiWH
         GS9ieg4FoX/peIQ5Sigskt4mOpIQeyng651xWCSa3hsWeMBXEWxtqCwu4LDlvkZVVOCl
         ZC80xn9zk9lmepP4JrytzHXewad2P3xs2P24ih1i+mg9uLGfX8kc9lRXE80vi1jStwNi
         NuJA250A4aX9kJxyjB1oBnPw740HrmHRtil8weOMhJl5ZGN6HisW22+TGU1K04FP2kcj
         iQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUaK9Jlust5WimDbAqOxXfEsAr57uybvFaIUP0wDpgukjqZY8vQDyMh2/+QUGZGJq7D6so=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFAmHksBdtqZo8OiPXKN8yV15z8tp6B4ZjJf0SIeInGTuQiKB
	VXnxVh/wo49VjWP+CY4j4GRNOlyPxLUmhuttzWZ69Q0uL73pcGmM56pOVjzQrqsT0BT3cFVL8V+
	74jzQXAD9CMQcINWl26oNprpfaq8o0UU=
X-Gm-Gg: AY/fxX6pWEI2yBWSkWOM0677rm4x9dFgHA1q0458hyJGm6BMn7758UTxm23u1UTi4qs
	MRfI/C8+tSEeUXv941FSEXlBVSyAifZcu6xCLlKwdUQ73bV5W1RLiYgrARtxQoIOYzXaIa0n6Uk
	AOMA2bk7lpGC4njz3bTgrVx7TMeFtY2fPKQsLoqQaKAvZas/sqvOSd+LaBUtXT3G8IO+WRLO8az
	WHcsu1ZP+IEneuaoTubq7t2fYFj9L7L69zRxel/K9LF3jW71lDHKAz/pcYuA3TlovNiHOQ=
X-Google-Smtp-Source: AGHT+IHz/O6Tm5Qk9oOvPnTQFbNGNo2T8nzOwFn2sQNP7wBv4zgveIbBJ3QTn2BfsfFM8JQ7wxo99BlvjysZRDloGOE=
X-Received: by 2002:a17:90b:582c:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-34e92113697mr3043275a91.6.1766164062658; Fri, 19 Dec 2025
 09:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-2-dolinux.peng@gmail.com> <CAEf4BzYJpw+yEv=g9P1z0NS8Qw8PdFf7039MT0PSv30DwkjBzw@mail.gmail.com>
 <CAErzpmu4K3rF3JLycEYNqzNcBkSgBxijj1RAYBPuprvBU6LHmQ@mail.gmail.com>
In-Reply-To: <CAErzpmu4K3rF3JLycEYNqzNcBkSgBxijj1RAYBPuprvBU6LHmQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:07:30 -0800
X-Gm-Features: AQt7F2qaNmkU9TpPDUVszmHhbYN5j7fpdwft-jegmYQBE2AnsjfD3ixGgZceeJE
Message-ID: <CAEf4BzYN5NwSJO1QDXu6Mq_pZXQO9-5iyJm0vZeJSmyrQBNJ3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 01/13] libbpf: Add BTF permutation support
 for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:15=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Dec 19, 2025 at 7:02=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Introduce btf__permute() API to allow in-place rearrangement of BTF t=
ypes.
> > > This function reorganizes BTF type order according to a provided arra=
y of
> > > type IDs, updating all type references to maintain consistency.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++++=
++
> > >  tools/lib/bpf/btf.h      |  36 ++++++++++++
> > >  tools/lib/bpf/libbpf.map |   1 +
> > >  3 files changed, 156 insertions(+)
> > >

[...]

> > > +/**
> > > + * @brief **btf__permute()** performs in-place BTF type rearrangemen=
t
> > > + * @param btf BTF object to permute
> > > + * @param id_map Array mapping original type IDs to new IDs
> > > + * @param id_map_cnt Number of elements in @id_map
> > > + * @param opts Optional parameters for BTF extension updates
> > > + * @return 0 on success, negative error code on failure
> > > + *
> > > + * **btf__permute()** rearranges BTF types according to the specifie=
d ID mapping.
> > > + * The @id_map array defines the new type ID for each original type =
ID.
> > > + *
> > > + * @id_map must include all types from ID `start_id` to `btf__type_c=
nt(btf) - 1`.
> > > + * @id_map_cnt should be `btf__type_cnt(btf) - start_id`
> > > + * The mapping is defined as: `id_map[original_id - start_id] =3D ne=
w_id`
> >
> > Would you mind paying attention to the feedback I left in [0]? Thank yo=
u.
>
> Apologies for the delayed response, I would like to hear if someone has a
> different idea.

Delayed response?.. You ignored my feedback and never even replied to
it. And then posted a new revision two days later, while still not
taking the feedback into account. This is not a delayed response, it's
ignoring the feedback. You don't have to agree with all the feedback,
but you have to respond to the feedback you disagree with and provide
your arguments, not just silently disregard it.

>
> >
> > The contract should be id_map[original_id] =3D new_id for base BTF and
> > id_map[original_id - btf__type_cnt(base_btf)] =3D new_id for split BTF.
> > Special BTF type #0 (VOID) is considered to be part of base BTF,
> > having id_map[0] =3D 0 is easy to check and enforce. And then it leaves
> > us with a simple and logical rule for id_map. For split BTF we make
> > necessary type ID shifts to avoid tons of wasted memory. But for base
> > BTF there is no need to shift anything. So mapping the original type
> > #X to #Y is id_map[X] =3D Y. Literally, "map X to Y", as simple as that=
.
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzY_k721TBfRSUeq5mB-7fgJhVKCeXVK=
O-W2EjQ0aS9AgA@mail.gmail.com/
>
> Thanks. I implemented the approach in v6, but it had inconsistent interna=
l
> details for base and split BTF. It seems we prioritize external contract
> consistency over internal inconsistencies, so I=E2=80=99ll revert to the =
v6 approach
> and refine it for clarity.

Yes, we always prioritize external contract consistency, of course!
You are overpivoting on *internal implementation detail* of base BTF's
start_id being set to 1, which is convenient in some other places due
to type_offs shifted by one mapping due to &btf_void special handling.
We can always change that, if we wanted, but this shouldn't spill into
public API though. But conceptually BTF types start at type #0, which
is defined to be VOID and is not user controlled.


This is not much of a complication or inconsistency:

type_shift =3D base_btf ? btf__type_cnt(base_btf) : 0;
id_map[type_id - type_shift] =3D ...


>
> >
> > > + *
> > > + * For base BTF, its `start_id` is fixed to 1, i.e. the VOID type ca=
n
> > > + * not be redefined or remapped and its ID is fixed to 0.
> > > + *
> > > + * For split BTF, its `start_id` can be retrieved by calling
> > > + * `btf__type_cnt(btf__base_btf(btf))`.
> > > + *
> > > + * On error, returns negative error code and sets errno:
> > > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-=
of-range)
> > > + *   - `-ENOMEM`: Memory allocation failure
> > > + */
> > > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id=
_map_cnt,
> > > +                           const struct btf_permute_opts *opts);
> > > +
> > >  struct btf_dump;
> > >
> > >  struct btf_dump_opts {
> > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > index 84fb90a016c9..d18fbcea7578 100644
> > > --- a/tools/lib/bpf/libbpf.map
> > > +++ b/tools/lib/bpf/libbpf.map
> > > @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
> > >                 bpf_map__exclusive_program;
> > >                 bpf_prog_assoc_struct_ops;
> > >                 bpf_program__assoc_struct_ops;
> > > +               btf__permute;
> > >  } LIBBPF_1.6.0;
> > > --
> > > 2.34.1
> > >

