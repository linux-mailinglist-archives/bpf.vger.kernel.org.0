Return-Path: <bpf+bounces-75249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43288C7B705
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 20:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07B2B4E400E
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16D2F60D8;
	Fri, 21 Nov 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlnGPzvt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7A224B04
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752041; cv=none; b=LaaoCsSihjCeIvOMuGQ01bF9BhE7omWPpFs2rrZaGGkh9xoOR5e9uDv3aIxHeOVgJ+g1vwFc1J1ziV6Uvt7uh08nVqbVEnKfibCGJgMfjnOEUKRuhJ1LPfF6P7W05QbpaE64F++VA04dTQJyLDVUfs2hfgUTXi0dIY4g91QIC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752041; c=relaxed/simple;
	bh=uqWASsXtMVNvIE/b8RtH6D4Zx0dCrIWYExxw3yYddf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9OgdoSX+cnXKNdiMQ3CpVoor1fl8WbxMH+uWF3Um4QUIOXtTfdR0djJlvbLlpw7P/WLCfa11EK3ogaUQI+tfsnp5HA7u26PyYeE1/Dc5+fiVoR59XTdq5e0aufJt8HZx1f/K+YilhY3J8CpODLMwccLHx3aps9je9ho7OYvETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlnGPzvt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so2818934b3a.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763752039; x=1764356839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rh2XIAdVbNhxFVkkvJ9+3DUwtRlk2cx7BiD1x/hM3qQ=;
        b=BlnGPzvt3Uu+IImeFlZ2+7jVmWxFIk/hjoPbPeHYzdkt6MCkgdGcu5wBeHvm0Gm5ph
         vEDbVHLb9hmEl49cDK+VFvZ7JefPGEA1uh8QCfnjwhoKRtRHQHjj4sstxc9ggFto5w83
         ZUiJ+5V+5xtDl2jt2VOQwUTHOpckw1PIJQZ7j7FALovvSdJBbkzELG/Fl01sLC1oqwHH
         iPMjFQlv94O4DXH0Mf4c9YFxCqpBDEdssk77aoOACj+o5Rb38BlX/ChKPHGBq+M4ZYhY
         03TQwSuCTSq00jp9csP/oEQCDBHK9SeOzn3NRwM5ndN151629ZVyo7HmDgCmQZewFT1t
         8GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763752039; x=1764356839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh2XIAdVbNhxFVkkvJ9+3DUwtRlk2cx7BiD1x/hM3qQ=;
        b=jPk8k881pTPTnrO4KNs1Wi5ZiW/JMDXQnr7sipU5pgE6NNmPEydtQVojzrrqt7XJoL
         C3SuTObYwWaqIjY5+j8z/ws4PIy6HWajJfUr8r2k1OlSw5NctEtt6L4fI03mAKoGnj5R
         CXcam9K93yBdtQR7+BGjRX1Q8pIGT6jGRCNAG0p3AQUv0MQFEa4rS9YmpNQbpbYdCeP6
         /T0Hl0uJO/lV5fvBORAGsY6j8D4rfUFS2qbhz3QIjP+uk+vJk3ITJPRhVfqmoa5ZL3Uw
         h5PjqdZTttDy9iZ4gz9tGi8oaYyau/0SbweqSBbtsmSsUP41BMgByWjEz0NZkrLcgLm1
         aJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXKAeNFkRZRW+rrZ3A4ov7m3P3ngM533NPOSYRifcKVzI9rO6wFvdf1jqs8NqLc9OOt1dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFB19Cs23nQNdcup8HyCkYaJsKX9lOoDL/BcjUtqcAYNxMhPrW
	SfZ+qSQEvAP+LV6prqcGQrsb89LeW0qcFsFdosc0vTikLBkAfEk/QHkp
X-Gm-Gg: ASbGncvwRMPLsVrYj3W7JDhh5DobsArpQTKV4mXSnWaXeU3QEgjVJ+/bk5/Dlx94E8j
	zjTMg7ugA3OSJ03Y6wfCAIBkvHTYwQS5/XQmSeECQcWrVBy0nywdwnL4sDasMpRc3N5+gJqDLYe
	0jukZB78fRGyUISKoA4X+sECoaBs9IFAl7ugh9bV+7asickLCMRdEErjm85+F+dFj3MORNOgwSZ
	gFfVVX7f56f/9s7hcMGVVVoa4iyy1vEqsmaDddOIUL0gOixCSahnlGMMYa7LEkgreO6k6qTgMUP
	p7j7eE+DTzV1LdotgwSP+WNpJjgkRV0NNIorXoFhyy6BPlUUvQ8NUdATMqDoku45tFmdfy41dV/
	LrMFi/gywNQHWzxLNoG0Z1jW/phCZkV1UWFir/YZcQVhj6ezsTEfxEvBougthDZwupdhjkzrdH2
	tN3qSJk/fULYaiIBDshA==
X-Google-Smtp-Source: AGHT+IHHq2DnTf89fQCrmBcnk/raRWHKS25dZh1IOS0Gw7/eUOGt74LouX3lR9fgOoNqV1MzICS46w==
X-Received: by 2002:a05:6a20:a108:b0:361:2d0c:fd74 with SMTP id adf61e73a8af0-3614ed96341mr4006951637.47.1763752039091;
        Fri, 21 Nov 2025 11:07:19 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4c73a2sm6103194a12.8.2025.11.21.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:07:18 -0800 (PST)
Message-ID: <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Fri, 21 Nov 2025 11:07:16 -0800
In-Reply-To: <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-6-dolinux.peng@gmail.com>
	 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
	 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
> On Thu, Nov 20, 2025 at 3:50=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >=20
> > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > >=20
> > > This patch adds validation to verify BTF type name sorting, enabling
> > > binary search optimization for lookups.
> > >=20
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > > ---
> > > =C2=A0tools/lib/bpf/btf.c | 59 ++++++++++++++++++++++++++++++++++++++=
+++++++
> > > =C2=A01 file changed, 59 insertions(+)
> > >=20
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 1d19d95da1d0..d872abff42e1 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, __u=
32 type_id)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return type_id;
> > > =C2=A0}
> > >=20
> > > +/* Anonymous types (with empty names) are considered greater than na=
med types
> > > + * and are sorted after them. Two anonymous types are considered equ=
al. Named
> > > + * types are compared lexicographically.
> > > + */
> > > +static int btf_compare_type_names(const void *a, const void *b, void=
 *priv)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btf *btf =3D (struct btf=
 *)priv;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btf_type *ta =3D btf_typ=
e_by_id(btf, *(__u32 *)a);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btf_type *tb =3D btf_typ=
e_by_id(btf, *(__u32 *)b);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *na, *nb;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool anon_a, anon_b;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 na =3D btf__str_by_offset(btf, =
ta->name_off);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb =3D btf__str_by_offset(btf, =
tb->name_off);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 anon_a =3D str_is_empty(na);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 anon_b =3D str_is_empty(nb);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (anon_a && !anon_b)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!anon_a && anon_b)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (anon_a && anon_b)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > any reason to hard-code that anonymous types should come *after* named
> > ones? That requires custom comparison logic here and resolve_btfids,
> > instead of just relying on btf__str_by_offset() returning valid empty
> > string for name_off =3D=3D 0 and then sorting anon types before named
> > ones, following normal lexicographical sorting rules?
>=20
> Thanks. I found that some kernel functions like btf_find_next_decl_tag,
> bpf_core_add_cands, find_bpffs_btf_enums, and find_btf_percpu_datasec
> still use linear search.

- btf_find_next_decl_tag() - this function is called from:
  - btf_find_decl_tag_value(), here whole scan over all BTF types is
    guaranteed to happen (because btf_find_next_decl_tag() is called
    twice);
  - btf_prepare_func_args(), here again whole scan is guaranteed to
    happen, because of the while loop starting from id =3D=3D 0.
- bpf_core_add_cands() this function is called from
  bpf_core_find_cands(), where it does a linear scan over all types in
  kernel BTF and then a linear scan over all types in module BTFs.
  (Because of how targ_start_id parameter is passed).
- find_bpffs_btf_enums() - this function does a linear scan over all
  types in module BTFs.
- find_btf_percpu_datasec() - this function looks for a DATASEC with
  name ".data..percpu" and returns as soon as the match is found.

Of the 4 functions above only find_btf_percpu_datasec() will return
early if BTF type with specified name is found. And it can be
converted to use btf_find_by_name_kind().

So, it appears that there should not be any performance penalty
(compared to current state of affairs) if anonymous types are put in
front. Wdyt?

> Putting named types first would also help here, as
> it allows anonymous types to be skipped naturally during the search.
> Some of them could be refactored to use btf_find_by_name_kind, but some
> would not be appropriate, such as btf_find_next_decl_tag,
> bpf_core_add_cands,find_btf_percpu_datasec.

Did you observe any performance issue if anonymous types are put in
the front?

> Additionally, in the linear search branch, I saw there is a NULL check fo=
r
> the name returned by btf__name_by_offset. This suggests that checking
> name_off =3D=3D 0 alone may not be sufficient to identify an anonymous ty=
pe,
> which is why I used str_is_empty for a more robust check.
>=20
> >=20
> > [...]

