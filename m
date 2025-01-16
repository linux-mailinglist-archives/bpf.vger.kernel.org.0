Return-Path: <bpf+bounces-49129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB92A14565
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C516BA44
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9C241688;
	Thu, 16 Jan 2025 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRx4kore"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EB2361D6
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069520; cv=none; b=VGOUsS38HcNmpwNxH1ZpWbs0IY6WHbP+HeVfmAJiYYwDm5epKUgdOgbR/sp4nttUeG6dON+yj2I7Yy3Y2tMhXlOnedonxnNUfyY5SbOMqCezwv+8mxVeNTMQs43wC2qD8B6TSWTGnvwjWFuuOXUH+HdeX1lTL3nW1arl2qBJLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069520; c=relaxed/simple;
	bh=7SUjvQlKnFxpl0lL2ixtHe0v6c+fIxnnn+lSHqCoQt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5/otxCK60shhF2bRMJaU/bcGfRlSezPGC+PejUEr4MmwZKnhH04ZFPIy06V60x8cTg+BCCzPawYUlpuMLHKDmA5Fk33RhBuRtEUJKmuduUBKsZVMtZOL8hQsJZgVowRpaN8hVIq9e+7iTDOvEq5Jn8bQYPDpJi/2MAdzHLNxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRx4kore; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso33644115ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 15:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737069518; x=1737674318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P8nGCgo764qf3TsXqf9RZU/1CnZzd5SCT221NSAfL1o=;
        b=TRx4koredan5UTOAKIwJRHuZSJPuXZeld2sHX0SHy33awSql7XPg6i2PsZvdKW6KSt
         KPQM7QZoRz3k2gNM3YU330YQkTodD4+7TQ0ZudTZbtNVfAiAJx03pb2M1VEDrUKZK2nX
         TY4AwhcrMa+1C5xsyehcBdLTyW4Xt9jpG4vuwUqY6jIFTETzMgAFXfAbMiTfo7qEHxFv
         LAFasrgi0tAZ4iW6p7QupcEteXL98Z/zXuQBdOBNlxgU6B5rPjJLHiTVfjZqhDt9j66v
         A06AQv7nsKqXRQnnV9qEiY7A5eDkc2oz89vslBC3JO4wQzjK3zL09JL+VFW2gt8AenvY
         WQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069518; x=1737674318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8nGCgo764qf3TsXqf9RZU/1CnZzd5SCT221NSAfL1o=;
        b=xMVe0EXZGzUehmmnxFvhfRiPKfy6ai3QRvYpib2ED25y+Fy/pjN0bPHvYrM8s/2WL3
         qn1ILwxSJEhH7OocuHiYmpOPreb3PgJIqQiJpS/11Gv/yhysT5xWXfNLwPgDKwFZIQ0N
         ainILX1KPbvA8edEYPeNoerX4q5/BVqryOKxXm6+vCr4EbSFQBwTkFYn/4r/xQtmYxtk
         SY6nen0V006XIJBQnNffOb6XT4SwThkeHvToqBXrXhYxwQmFNQztX0DDH+LXXJpOUO2E
         aqMO3ty+Ka9Qk3iKlo1QwZitXYHfccWJExOpHO79zcCs1YJPL2YJBZ4SEuv/Z3+figBx
         VEWA==
X-Gm-Message-State: AOJu0YypyMMd5eOvhcnUEwCrrAYepEwEYf6gQKHaCagPUCRQWq+8mKyK
	+OlwcSp+R3I/3oZ/J0u0GvwHKlHtzArjR4gh99O+8xiFtRYpnPwp
X-Gm-Gg: ASbGncsT3TUij7xRsZz0oA4ybkXd5gdvdBzFyhlKLvt4DnplkaAwmK7vyS/NVDW9HH5
	/REhi8eV7YQfs0Rig7MFbLqLxW2Yw+pD8lE5sWNI64YH+t3xlxDGUbf+0fblFp+0RqIXNkQrGG/
	TwvcCni/Wz3CqnpONmau2S7UrpcHsfh/rEnEwfnHy7Qglg3chRG/rjxOZ3HRe7gS3uxZFv++x6C
	GHr20+55BZkQDSte/GOBZN9DVSb5YDVod7WVlsC5gEq/Row/LT23Q==
X-Google-Smtp-Source: AGHT+IHaWn1RHknaKeKJiZRr3rcjQD+/eCx69j1Qh/J+WDoGa4Oqhd/6+UT2w9D8rU2lguiM4r5UOg==
X-Received: by 2002:a05:6a00:858b:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-72d8c756d22mr14710095b3a.8.1737069518451;
        Thu, 16 Jan 2025 15:18:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9ae0sm554158b3a.93.2025.01.16.15.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:18:37 -0800 (PST)
Message-ID: <39fd5e3ffdf54483bafab59abb9183275f558177.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] veristat: load struct_ops programs only once
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	yatsenko@meta.com
Date: Thu, 16 Jan 2025 15:18:32 -0800
In-Reply-To: <CAEf4BzYctSGEU3jELirr50W3Mxf0zBt6s2GpCSsdjDY6bva0Tw@mail.gmail.com>
References: <20250115223835.919989-1-eddyz87@gmail.com>
	 <CAEf4BzYctSGEU3jELirr50W3Mxf0zBt6s2GpCSsdjDY6bva0Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 15:15 -0800, Andrii Nakryiko wrote:

[...]

> > +/* Make sure only target program is referenced from struct_ops map,
> > + * otherwise libbpf would automatically set autocreate for all
> > + * referenced programs.
> > + * See libbpf.c:bpf_object_adjust_struct_ops_autoload.
> > + */
> > +static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
> > +                                           struct bpf_map *map,
> > +                                           struct bpf_program *prog)
> > +{
> > +       struct btf *btf =3D bpf_object__btf(obj);
> > +       const struct btf_type *t, *mt;
> > +       struct btf_member *m;
> > +       int i, ptr_sz, moff;
> > +       size_t data_sz;
> > +       void *data;
> > +
> > +       t =3D btf__type_by_id(btf, bpf_map__btf_value_type_id(map));
> > +       if (!btf_is_struct(t))
> > +               return;
> > +
> > +       data =3D bpf_map__initial_value(map, &data_sz);
> > +       ptr_sz =3D min(btf__pointer_size(btf), sizeof(void *));
>=20
> btf__pointer_size() for .bpf.o should always be 8, so this min is
> pointless, I think. I can simplify to just ptr_sz =3D sizeof(void *)
> while applying, if you agree. Let me know.

I wanted to be pedantic, but am ok if you prefer to switch it to
'ptr_sz =3D sizeof(void *)'. Can send v2, or if you change it when
applying, that would be great.

>=20
> Other than that looks good.
>=20
> > +       for (i =3D 0; i < btf_vlen(t); i++) {
> > +               m =3D &btf_members(t)[i];
> > +               mt =3D btf__type_by_id(btf, m->type);
> > +               if (!btf_is_ptr(mt))
> > +                       continue;
> > +               moff =3D m->offset / 8;
> > +               if (moff + ptr_sz > data_sz)
> > +                       continue;
> > +               if (memcmp(data + moff, &prog, ptr_sz) =3D=3D 0)
> > +                       continue;
> > +               memset(data + moff, 0, ptr_sz);
> > +       }
> > +}
> > +

[...]


