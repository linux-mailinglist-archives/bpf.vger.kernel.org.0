Return-Path: <bpf+bounces-75201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEACC76977
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 262D629455
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A072EFD8C;
	Thu, 20 Nov 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4U3Aays"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695126158C
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680889; cv=none; b=NM84Py9UoURBKeirD/jpKssSw7YMyyne5245f991duK+X/O6+uEJNj6Em8C70dgtab0wnZmQsukMSXYXJOtJTG1mdaANVwfNZfKyyIba0NZuI1ckSc3Onknfq/l0R5N/B5ZRVd6m7d3I/dQhnpsULjGQ+GSZexPPzfljWS1Fg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680889; c=relaxed/simple;
	bh=jwTFSz/wFoVYqJTZqKg3Pda73Evv3u6zbWYZnSRNvuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHkH1KZUWnDKISVrayA2jRAjbZ5em9ipjtYyUa902gKO/mBDqiGDOA2hNL2YJpWk63VIFB90WaoGdXcbOFa3dig41vc6N4dGSE03Aa6jO8IF7e6/XbVcByWcd9fSANETqB6QOHlwwBhmcvZqEviRwz2VeSFNCBAisyGbHnQ1p4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4U3Aays; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297d4a56f97so20871995ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680887; x=1764285687; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsSwE5ME/UUbmYAp1KpleOLXISCx3uKWJqsBtcuPJeg=;
        b=j4U3AaysIrJjhv5W53PcWv7V2nLKzG5urnKVmPQc+mQfIUgqZcMBQDasTGBuXJEpZQ
         cdeThJ4MBli/CgXn3TbGKxRxb8lDZyFeSrGeNmnaQue8045gcX91cYG54Hcxy9sKB0No
         Ii/f5ftdkbyrXXk9thDHYRom8/GOKIvPdwsij2XrmdVQubmC6X7JdGpAXXyFDQayQ3Jn
         t+iSDrJQzLdIW+EMlxKvS3nQTUSYAia74bgwNpey1QBsGvzVF4HBujVMBLdMQ679rRuw
         ojHq7iliMItJmdVKnAx5U93bS0pOdo+VfRPH7NbQ186Op1Lwd5KBonh4Ez3c7SaqQ+fU
         zqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680887; x=1764285687;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsSwE5ME/UUbmYAp1KpleOLXISCx3uKWJqsBtcuPJeg=;
        b=thx/ASvfybu45Gb8tS/xLcOkBlH/PhitkTnHipcJifJSwgK1X34WMeXkQc4c5x9Fup
         nIsFaFOZnNVXzmh9dVg9BYZCOfw4VXW2Hryo7Co2o03GhfaAOMnN3uPWAKbFvfZr9HUu
         hLeX8ymBZWRp9LCn8C6SiebPFlMz7usXY1es+4kseosSQYNjGuTTRnfVEVGDlFLOC8aK
         suuua+A+Ue7T8Vn6l3IqH5zp5Q9ZBjyeSAsf9t/MD8XmybpMXajZWmX6oChJDyaCkt8M
         NefygzQZmBntg+2AL4kkJFR3yMwfwsT5apRyzcpNOgxrWn2ZTMxMEP/UQiVyODuu6MUC
         GbKA==
X-Forwarded-Encrypted: i=1; AJvYcCUMwT2H42aXOLc9HVACcKC6E9/H90StGhhK0sZT3vDrLow07XdhqvlgUcpjtNH8aiGrEZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJ51gMTNFyrNHHB6SDknyZQZCYDjPP2ggEVUPMcCyB8j19eQy
	ku58I9fxMuutDwB+1QLF91fHEejkErdUOcSmWqttTU5SRgNgZnlz/AqW
X-Gm-Gg: ASbGncvxeZFKZfGWLi1pmsQph8/pEcQquOL03y76/NKIKZR2aX7wGCKkDW7sCWS3KYQ
	ia+zFZS6c8rjH6m0ykeGjtD3fLdngGYL4f8wIkt5QZCEm3Ure5Y8PNIxZNfcWGzmr5WAIkMLvOe
	Qw+wehAgzGg+pFK0IGhgz4Lt8b1vEBetAo8D4zLNTcYKlhSMzazdqTuVkaOaLeaiiqF6dMyvHPZ
	WKNGXLpeEpewBP+7C4dpZnq5RJRpxwxSRQD0j7bx6CHIfBYcGBOsBqj97uIgUSDF5LOuRB5Fq9u
	oP7Mbw7ZwPWzZo+rjl/sbhwgnDqjYtI5RD3RiGgFRi3vBNK6wsWwlnemGqEKjF7Rf0Tvx1sH7I5
	IkZ/J23V1kd7Poxsx4Xfwh4r5/3SV618nEuxnKvKI4jdcWNuGSST8/ty23BSesV4luJB9RMWYPu
	8XVjISvlKVAR8g1ma/0JwMK299kXwGAXmedkQ4EMr2Om4i+Q==
X-Google-Smtp-Source: AGHT+IEMaz6RIQkaYX0YGtkK4RVwAAlSOXs0Ah8cum0Wxw5/t/jF7EDulTfwk1uFcZEP0XEoU2XApw==
X-Received: by 2002:a17:902:ef4c:b0:297:d741:d28a with SMTP id d9443c01a7336-29b6c574f8amr3121045ad.31.1763680887132;
        Thu, 20 Nov 2025 15:21:27 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6e69:e358:27f9:ac0? ([2620:10d:c090:500::5:61f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1584c7sm36936395ad.44.2025.11.20.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:21:26 -0800 (PST)
Message-ID: <5315c03cd97af176065c86c0640461321c818887.camel@gmail.com>
Subject: Re: [RFC PATCH v7 1/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Thu, 20 Nov 2025 15:21:25 -0800
In-Reply-To: <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-2-dolinux.peng@gmail.com>
	 <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 10:21 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:

[...]

> > +       nt =3D new_types;
> > +       for (i =3D 0; i < new_nr_types; i++) {
> > +               struct btf_field_iter it;
> > +               const struct btf_type *t;
> > +               __u32 *type_id;
> > +               int type_size;
> > +
> > +               id =3D order_map[i];
> > +               /* must be a valid type ID */
>=20
> redundant comment, please drop
>=20
> > +               t =3D btf__type_by_id(btf, id);
> > +               if (!t) {
>=20
> no need to check this, we already validated that all types are valid earl=
ier
>=20
> > +                       err =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +               type_size =3D btf_type_size(t);
> > +               memcpy(nt, t, type_size);
> > +
> > +               /* Fix up referenced IDs for BTF */
> > +               err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS=
);
> > +               if (err)
> > +                       goto done;
> > +               while ((type_id =3D btf_field_iter_next(&it))) {
> > +                       err =3D btf_permute_remap_type_id(type_id, &p);
> > +                       if (err)
> > +                               goto done;
> > +               }
> > +
> > +               nt +=3D type_size;
> > +       }
> > +
> > +       /* Fix up referenced IDs for btf_ext */
> > +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > +       if (btf_ext) {
> > +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_rem=
ap_type_id, &p);
> > +               if (err)
> > +                       goto done;
> > +       }
> > +
> > +       new_type_len =3D nt - new_types;
>=20
>=20
> new_type_len has to be exactly the same as the old size, this is redundan=
t
>=20
> > +       next_type =3D new_types;
> > +       end_type =3D next_type + new_type_len;
> > +       i =3D 0;
> > +       while (next_type + sizeof(struct btf_type) <=3D end_type) {
>=20
> while (next_type < end_type)?
>=20
> Reference to struct btf_type is confusing, as generally type is bigger
> than just sizeof(struct btf_type). But there is no need for this, with
> correct code next_type < end_type is sufficient check
>=20
> But really, this can also be written cleanly as a simple for loop
>=20
> for (i =3D 0; i < nr_types; i++) {
>     btf->type_offs[i] =3D next_type - new_types;
>     next_type +=3D btf_type_size(next_type);
> }
>

Adding to what Andrii says, the whole group of assignments is
reducible:

  +       new_type_len =3D nt - new_types;
  +       next_type =3D new_types;
  +       end_type =3D next_type + new_type_len;

=3D> end_type =3D new_types + new_type_len; // subst next_type -> new_types
=3D> end_type =3D new_types + nt - new_types; // subst new_types -> nt - ne=
w_types
=3D> end_type =3D nt

Why recomputing it in such a convoluted way?

> > +               btf->type_offs[i++] =3D next_type - new_types;
> > +               next_type +=3D btf_type_size(next_type);
> > +       }
> > +

[...]

