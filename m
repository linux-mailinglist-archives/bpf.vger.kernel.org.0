Return-Path: <bpf+bounces-79157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCFD28FAF
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 23:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29E13013E80
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7102EA158;
	Thu, 15 Jan 2026 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwhRLRbg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5021FF26
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515559; cv=none; b=SRYh+bufl3RiCH5o09A9GmaaJBQINMyY+gDjp7uV+ThUNMQ2PaLnloKXlb8nZmslo238NzZED//3Ak5X8OWl3yvxPsIQpAPqBC9TZM3Dob1f//vvGFVUS3mM/JKio5YH6BvhtuLT/f3XQX/0q4RU2EMN8WmNS144eYYGbrUaO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515559; c=relaxed/simple;
	bh=T6Lgg9a/5XVucFCCZ1Yw6kpQKQvBfhYYcFv1/a88uZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5YK+7BohzZ9BVZ5NpqqG643nPPL7k/aEr+NPiHPIP/aHE8LuGeA9mM8cC4c9OjpN78YgnFBxWanbau5OcirMwiqLIkVdAgB5W8B8edcXQD9y0uBkl9vxAGJNKt/+piq7k7VJ6J8MEJxrauSQvDvSkW5MYJ4PjYIaFlkbhkhTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwhRLRbg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2af7d09533so940609a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768515557; x=1769120357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4u2OraJFS48JZUuYAsCnwY9O9MHo1JMnBl7LuswIzg=;
        b=bwhRLRbgOrHRB9r1vICHyCSz5x3ftatxVXQIx4cp2mdk3WIBido+B8b7hgK6HvuagO
         v9zsycQobmeIxoMddK0Kcwswmw53aNHRNXbSQSvL8AvQQgLv4BLsTqNV+7g3b6ca/nWw
         UsJJ6f5VLn1gYJS+X8ICD4Zfbk7tNqVkr4c28EVbJ4ydijVPpGt/yOh9h/qKk7J0/2Cm
         Zsuy0gTIsa/FAWFqNtGpvPpZ5jPga8BynBvJVUxIJmxqn7EI/6E0D1EiHMPniLq8u1cj
         xq4WQjeAgDxxXATVQ4NqQZPxxc77qAGexc0oGKhHVHH0yZyDbgFe8w2OTEx+MqF0gqNP
         g6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515557; x=1769120357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4u2OraJFS48JZUuYAsCnwY9O9MHo1JMnBl7LuswIzg=;
        b=cIoXUh72FATEnGSrB1vPRdaBFOBV0X+F0XTa6Aa7ytKNS0CE/p7yVR0HWzd+UyiW+f
         w1lh5K5V3Pt3O8h4x77JYM6IWsMKByt8JxjYHZbP1CG/runivq0+Z88mULbFCnVmuDHh
         WfHn8OhtVRYJjCNjjsU8ZszPdbA9x/M48MnifOEma9B/jgenVjRf+VeMnMcmfWj3GBH3
         gma0nkfKrcxwjqLQ30eZkE00IV4WLYoP07LJu4OCyytlNrpDmTrr78i5uxjQEDEUdJWL
         iezzlb6sy+QdhntRWyYEgzYfG9XgUuGR6c/RgYgRw3sqRB7ljBt3403E5GBweQSmDIBU
         Pt4w==
X-Forwarded-Encrypted: i=1; AJvYcCWHQiWHKlx6Uuc6jXyspyvv5K5IM1rix/ZUP3biSaI9jGsZ6X31Wp04QeuLIGI73goDroE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvYGJlJggWbL/u32r898MLffGO3Q74lzcQhZP0jht4b6hvxen
	PxRhRSRHLQNFRbmkVFG486prF4weOUIlEjVloz5wWvBa+6G14U5WfB16iJNR+3FC7q2zRse7sZ5
	cMv0vBICN/BPAqg2cSuxXMayd1BUnkBs=
X-Gm-Gg: AY/fxX6zazcs6Or2C87r/IlG4s03pJ1i8ufaITC6oM5Df1a46MYSLhS1Rb9rdrj/iuK
	+jzVLFjRxz8crf3y5Fj9w3frrCrx3gFOuL1X7c9G7xu+4b71POnn5uQMc5WNpiFMLXjanBb76dI
	5d0mJ3BExZKQOuHnoCxys5rsysj2sTQY4aVTRnxuB1pnL8ZHT97PMl/LcY46wcTYxasWN6WAhLD
	9ixRz/V8Fda1xAokmD2PvqcJ7KLPy1v4gPDUSSxXAJTbRN29TsxY+j3RLHJKrjzx/zzZbvzQl6H
	4RQnJkHI/ywgufPk8ac=
X-Received: by 2002:a17:90a:da86:b0:349:3fe8:e7df with SMTP id
 98e67ed59e1d1-35272f9237fmr620044a91.22.1768515557477; Thu, 15 Jan 2026
 14:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115144946.439069-1-realwujing@gmail.com> <fe21bddcc1c46ecd18a28cf76db4de78c5ef314e.camel@gmail.com>
In-Reply-To: <fe21bddcc1c46ecd18a28cf76db4de78c5ef314e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 14:19:04 -0800
X-Gm-Features: AZwV_Qg3rfX-fW3QAZxN9k-BdJ8wS6VhJlll_4nw5WIUGI41VRI-JaBbDFbevnQ
Message-ID: <CAEf4Bzb79hesJiPWK3hoNb8LrpmWv+OmqSCE284cXMHHQUWJew@mail.gmail.com>
Subject: Re: [PATCH] bpf/verifier: optimize ID mapping reset in states_equal
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: wujing <realwujing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-01-15 at 22:49 +0800, wujing wrote:
> > The verifier uses an ID mapping table (struct bpf_idmap) during state
> > equivalence checks. Currently, reset_idmap_scratch performs a full mems=
et
> > on the entire map in every call.
> >
> > The table size is exactly 4800 bytes (approx. 4.7KB), calculated as:
> > - MAX_BPF_REG =3D 11
> > - MAX_BPF_STACK =3D 512
> > - BPF_REG_SIZE =3D 8
> > - MAX_CALL_FRAMES =3D 8
> > - BPF_ID_MAP_SIZE =3D (11 + 512 / 8) * 8 =3D 600 entries
> > - Each entry (struct bpf_id_pair) is 8 bytes (two u32 fields)
> > - Total size =3D 600 * 8 =3D 4800 bytes
> >
> > For complex programs with many pruning points, this constant large mems=
et
> > introduces significant CPU overhead and cache pressure, especially when
> > only a few IDs are actually used.
> >
> > This patch optimizes the reset logic by:
> > 1. Adding 'map_cnt' to bpf_idmap to track used slots.
> > 2. Updating 'map_cnt' in check_ids to record the high-water mark.
> > 3. Making reset_idmap_scratch perform a partial memset based on 'map_cn=
t'.
> >
> > This improves pruning performance and reduces redundant memory writes.
> >
> > Signed-off-by: wujing <realwujing@gmail.com>
>                  ^^^^^^
>                  Please use your full name.
> > Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> > ---
>
> I think this is an ok change.
> Could you please collect some stats using 'perf stat' for some big selfte=
st?
>
> >  include/linux/bpf_verifier.h |  1 +
> >  kernel/bpf/verifier.c        | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 130bcbd66f60..562f7e63be29 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -692,6 +692,7 @@ struct bpf_id_pair {
> >
> >  struct bpf_idmap {
> >       u32 tmp_id_gen;
> > +     u32 map_cnt;
> >       struct bpf_id_pair map[BPF_ID_MAP_SIZE];
> >  };
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 37ce3990c9ad..6220dde41107 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18954,6 +18954,7 @@ static bool check_ids(u32 old_id, u32 cur_id, s=
truct bpf_idmap *idmap)
> >                       /* Reached an empty slot; haven't seen this id be=
fore */
> >                       map[i].old =3D old_id;
> >                       map[i].cur =3D cur_id;
> > +                     idmap->map_cnt =3D i + 1;
> >                       return true;
> >               }
> >               if (map[i].old =3D=3D old_id)
> > @@ -19471,8 +19472,13 @@ static bool func_states_equal(struct bpf_verif=
ier_env *env, struct bpf_func_stat
> >
> >  static void reset_idmap_scratch(struct bpf_verifier_env *env)
> >  {
> > -     env->idmap_scratch.tmp_id_gen =3D env->id_gen;
> > -     memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map)=
);
> > +     struct bpf_idmap *idmap =3D &env->idmap_scratch;
> > +
> > +     idmap->tmp_id_gen =3D env->id_gen;
> > +     if (idmap->map_cnt) {
>
> Nit: this condition is not really necessary.
>
> > +             memset(idmap->map, 0, idmap->map_cnt * sizeof(struct bpf_=
id_pair));

the whole memset is not necessary if we have map_cnt and use that when
searching IDs, no? I'd also call the field just idmap->cnt

> > +             idmap->map_cnt =3D 0;
> > +     }
> >  }
> >
> >  static bool states_equal(struct bpf_verifier_env *env,

