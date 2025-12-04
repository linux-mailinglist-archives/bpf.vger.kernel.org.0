Return-Path: <bpf+bounces-76009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF658CA20CF
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17274301AF5E
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E31D9A5F;
	Thu,  4 Dec 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELPsqEJi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD91D416E
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808994; cv=none; b=KVLIPsRAoJvsYxoA4qIJYB/5+93hZ2qZ3pd4ZBb3VzEy5QMyysg+zwqsJW/JexRj5Qt21yxJHfxdprEackdTEvVWDxfuWPpkkbGhp+NXPT+HvCPxALQLCfVdvMi0nP0RPZCujQCQxgdsl8Jy2rrFK80WOgpnhi83WLLYTLqcXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808994; c=relaxed/simple;
	bh=dk0gAInxcDeh7vYKROKULoCwr7HKkVI8HQWqKC2Yd7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5LQy+x1GW11n7wMaoN/Yr8m8rFU97QpLVmIku0tVpmDKxllAw3Jftxu8NRhhPfi7FVxMvhK/zPldxgsfa85M88O9umLSmL6NRR49uB4990bqzABZam4s3RGPGz7+MT3ctueQuBNZRfyWU/Y7SGAsMKsmizIhspFGOkTFqdld10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELPsqEJi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3438231df5fso365963a91.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764808992; x=1765413792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwV3FEkCUgw7epnBprNLYbvVpeP+wKLS305nCw34paQ=;
        b=ELPsqEJiP7ge15HsAtGddsN0U0OI783458N62vm7uoyJNxzCNJMcGUJVbN9KdzwD1j
         aZc0+b0r7Uttnl/v59UqJMc6FqojBKonMqm5fj3TQRhRMfrtmyJoqKeDKsMuckMxvvny
         +20yGTmonnLl+oLI4QdGsUFd8Te88Cr1YGHAVv8IZcEMcOHmbkOFfskNwmxUaXJTSUZV
         PNwawBLjUmbjrlY2OY8yxuAPFgztnU1wYsTeCDUPmcTKjU3irOtUtFS5bcmqKXtONfap
         5qi3E0LLqZ6vkjKS28iIX9nHq8oxVrKUlwENKfcCRx6uQa+4GvcCKSAghpfEMEzGPfMm
         2hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764808992; x=1765413792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwV3FEkCUgw7epnBprNLYbvVpeP+wKLS305nCw34paQ=;
        b=V+5EC+I7HiPi/X8ISsi0Enq9oDrnrzeWeGf+SdnpRs9dupU6V2JWCsgMCzPutMimNI
         a4DTT+IdD5AVVjQTWmT0teMO4BFjph0HPyNK2Q+xJfuM+ukp5WM8w2DvfHzwwOR6IViP
         9NrLjpCoM8e6Cc50JHWekbXcLZnOQzB89F4JKfQTg6OtQj8Ii2xfmPnwlcRnCkFgpJzO
         dho3F2KOOlqyXrpXu2A5d99AlQxfvCIjD4wmcdmCP3+27VZsltKUz0yvDRCN0RhrfLvN
         oaY+PSdiOJrvzt7EtiXCVQhsW+CUXNbVhH1oMEXMPQwj/wFbozkr5w+P45G8yhcw563T
         9Hug==
X-Forwarded-Encrypted: i=1; AJvYcCUYolgbDORKofLZMq3bJqZwaM//cDbA5tojIB4b3y1aJmZmc1QvaDJXT9lfHIsrMS42yp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKn+TIjWuBq4TwDjOVMc2Swm3+dHT5YYC8LVP8fWX9puoPbnwm
	GMCHuWoTgky7MGyI3vLpBJHNnmAllK/Z9WnDL9MnOdiPoes2qSEgVMSOK0YiqSgXx4i4QAbGoTw
	loa1mvJIjNbWe3r0V1d8XxWapEulH4DI=
X-Gm-Gg: ASbGncv/WBR7M8PtbXecwekYZkHyQ3YWLK1klzfLgb0rocPLhJtUAX0cOEn31+jvGc7
	4Ei7v7C69APmvvckZs13ADD9iLdFjYDhayPFI6p1xNGLu6mrcxjXMIaDikaEsH92VMmT98os3oX
	1KZ0ANM1xLIt+eoUIdoU8P4OGhvTJdNQODQwBPBLjTR/xfK2BNuSHWgfO56LQpUQMsuLL6WUyZM
	6ZTlVwKRSRQFMwyQJ6jauLE2dytqw3gH6NaXCYpYPQz54caS4/AuvNZKyviVlfbfkZ0QbUv3yR8
	tOZZi+inacY=
X-Google-Smtp-Source: AGHT+IESBd9sZrkuN7wKmg04Mhk+5v/JOXgUbnXmrI0HFWzsRJ1r1OCm20+QVxq0Y00Nq0qk5pZ2gs2OXf0dTm7Epv4=
X-Received: by 2002:a17:90b:3d07:b0:340:f422:fc76 with SMTP id
 98e67ed59e1d1-34947893302mr851283a91.0.1764808991905; Wed, 03 Dec 2025
 16:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-4-ihor.solodrai@linux.dev> <CAEf4Bza+L_RL_d7JFFLmzkYj2dbnT8rDgqwCat2zLOekToRm-g@mail.gmail.com>
 <3f60cb6e-a36c-44b3-b80a-3a99d013e0a3@linux.dev>
In-Reply-To: <3f60cb6e-a36c-44b3-b80a-3a99d013e0a3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Dec 2025 16:42:59 -0800
X-Gm-Features: AWmQ_blqQoRo8-wsXVXbfJMeMtJR30YBXufvPwPMau-kD9GXiPgJA6IgQqGAst8
Message-ID: <CAEf4BzbNApf0n=Bwdar7UXBmHNJWaAmzuF68yfU4W5OYbYk2Bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] resolve_btfids: introduce enum btf_id_kind
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 11:08=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/1/25 9:27 AM, Andrii Nakryiko wrote:
> > On Thu, Nov 27, 2025 at 10:53=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>
> >> Instead of using multiple flags, make struct btf_id tagged with an
> >> enum value indicating its kind in the context of resolve_btfids.
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++----------=
-
> >>  1 file changed, 42 insertions(+), 20 deletions(-)
> >
> > [...]
> >
> >>
> >> -static struct btf_id *add_set(struct object *obj, char *name, bool is=
_set8)
> >> +static struct btf_id *add_set(struct object *obj, char *name, enum bt=
f_id_kind kind)
> >>  {
> >>         /*
> >>          * __BTF_ID__set__name
> >>          * name =3D    ^
> >>          * id   =3D         ^
> >>          */
> >> -       char *id =3D name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(=
BTF_SET "__")) - 1;
> >> +       int prefixlen =3D kind =3D=3D BTF_ID_KIND_SET8 ? sizeof(BTF_SE=
T8 "__") : sizeof(BTF_SET "__");
> >> +       char *id =3D name + prefixlen - 1;
> >>         int len =3D strlen(name);
> >> +       struct btf_id *btf_id;
> >>
> >>         if (id >=3D name + len) {
> >>                 pr_err("FAILED to parse set name: %s\n", name);
> >>                 return NULL;
> >>         }
> >>
> >> -       return btf_id__add(&obj->sets, id, true);
> >> +       btf_id =3D btf_id__add(&obj->sets, id, true);
> >> +       if (btf_id)
> >> +               btf_id->kind =3D kind;
> >> +
> >> +       return btf_id;
> >>  }
> >>
> >>  static struct btf_id *add_symbol(struct rb_root *root, char *name, si=
ze_t size)
> >>  {
> >> +       struct btf_id *btf_id;
> >>         char *id;
> >>
> >>         id =3D get_id(name + size);
> >> @@ -288,7 +301,11 @@ static struct btf_id *add_symbol(struct rb_root *=
root, char *name, size_t size)
> >>                 return NULL;
> >>         }
> >>
> >> -       return btf_id__add(root, id, false);
> >> +       btf_id =3D btf_id__add(root, id, false);
> >> +       if (btf_id)
> >> +               btf_id->kind =3D BTF_ID_KIND_SYM;
> >
> > seeing this pattern repeated, wouldn't it make sense to just pass this
> > kind to btf_id__add() and set it there?
>
> I like the idea, because we could get rid the "unique" flag then.
>
> But the btf_id__add() does not necessarily create a new struct, and so
> if we pass the kind in, what do we do with existing objects?
> Overwrite the kind? If not, do we check for a mismatch?
>

no idea, don't know code well enough, but your newly added code seems
to overwrite the kind always, no?

> >
> >> +
> >> +       return btf_id;
> >>  }
> >>
> >
> > [...]
> >
> >> @@ -643,7 +656,7 @@ static int id_patch(struct object *obj, struct btf=
_id *id)
> >>         int i;
> >>
> >>         /* For set, set8, id->id may be 0 */
> >> -       if (!id->id && !id->is_set && !id->is_set8) {
> >> +       if (!id->id && id->kind =3D=3D BTF_ID_KIND_SYM) {
> >
> > nit: comment says the exception is specifically for SET and SET8, so I
> > think checking for those two instead of for SYM (implying that only
> > other possible options are set and set8) would be a bit more
> > future-proof?
>
> ok
>
> >
> >>                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n",=
 id->name);
> >>                 warnings++;
> >>         }
> >
> > [...]
>

