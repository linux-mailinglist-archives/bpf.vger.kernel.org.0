Return-Path: <bpf+bounces-40015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4A97AAC7
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 06:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58025285A74
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF74436E;
	Tue, 17 Sep 2024 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QinRfGhV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD727473;
	Tue, 17 Sep 2024 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726548015; cv=none; b=sYmkEjoxaCbCn5B8hTp3SfMbtWSSQRpS2DXXS/4GY78G6evOMJMVyQMaTHo9zFsmrTg+x2bUpycAbw+xNJqUFlvF3IQyNnWC32B8rRXpQjwaZ39UJmosNPSrkzeXuXddkEwNpi/f+W89Ng1JCSSxv6R8JicCRdoyXGgT1Y6M3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726548015; c=relaxed/simple;
	bh=CG9TYl6xocSzcYJJoi1xTaKGt4Fy2IBNRupoEwgeoTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJrJhIxoEPB3FN1mCY8IgIvN89xKXpxxVedny9zKbha0LOrdi//XSAlmj+jfhBxcYSyMVEIp8Sj2yAlimDhkO8oowHskz1L091mSYV4V7O9maZCJAQkQOI1EWYbLKx8NDxEjPdCJppET+2tTV9q3nYe4kEfEjAMz8qa4yBMvHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QinRfGhV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053525bd90so35047065ad.0;
        Mon, 16 Sep 2024 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726548013; x=1727152813; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Xi3Le89ZCorv8WOuDMesnSd+PNRXsJ+vYBCnGClhdg=;
        b=QinRfGhVkad4kzXEjDn/jGAm/hPgU/PMfsnKQ/uTQu2FlJCkGAawKWWYu98YeJ5VR2
         27jZ0YxGYvGzWGWbR7m1bSsSzmrlWa9xxhey5ZTpPM1iMc/6GpXsARNrsMLaFgt44SpE
         F8iKQs6jAC+PsR44g+hFC5BZ3fKEcgCbq/rfn1wQin7i3UwKIOFvTWqWwtLBRc7QpOOO
         Yh57MhU5iw7HZHsE8MAOt+UPZ5OGsEX5OblJJc44/cwXpv0wyPow8qUg7I/w12v0VJpS
         JklWEM4bli1o2XzjXoujP5yWBE53NwuSojkKNmF//ik/ezhdgXpCnwp2mq+pZzoFfXSB
         u6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726548013; x=1727152813;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Xi3Le89ZCorv8WOuDMesnSd+PNRXsJ+vYBCnGClhdg=;
        b=ugMxi2OlQvfn2b7iwsDiAT1jFU6XCNXtouuKN2pZtIIkFP3uT8+qiKLzzdVqrzkbnP
         MdxifvDRbF5dVreSiwNauLdeTmvLqgHMWmNfc3lN5KgAU6Cx5m7Ct8Ng+y+JRNrBM6An
         moD72A9r06eGZa0aNwKqKucZLwruF+LLgJUOlDu0EnE3vw34GuhmdFjtnqwB1wZysbhC
         3Jkp2vE/21shiXPwJTocCntJVRwuoo7mGeekPy7qDEB7MsFZLzycZFr/YsLUXOKUYlQW
         nlN5d+t57aMfHI3OcWJa0iOQjnv02OgkhihJrliUd9KQ7a/5mWF2gviBxnQRnfnbEAAr
         WTsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGKVicsbqLkOagqPnSxORcEl8RMS3fOEnfJWMeb+b5zYmjCq1YALjShxnm0zM2MjY4SVtA90P5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tvbvzoKZGosZ6Ho7WRIWiAdQY+uvwC+jvP1tOuln1cUmoy26
	AOqTyJhVHYpToeKMTn+VBh7STawacB+pqHoeR8+yT+ka0YdPFFtg
X-Google-Smtp-Source: AGHT+IGqdeLeQsB5OnpU8yF2oIlfkjGO+qPJU2oc1cqdrn52ml71uSDVcw5XqBQ1cJdRp6ww5Nf6GA==
X-Received: by 2002:a17:903:41c9:b0:206:b915:58e with SMTP id d9443c01a7336-20781d6197emr212058305ad.22.1726548012769;
        Mon, 16 Sep 2024 21:40:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d4eadsm43355235ad.124.2024.09.16.21.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 21:40:12 -0700 (PDT)
Message-ID: <fc3059de61eeeff33af1b22cb68edcad6759b25f.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags
 for eligible kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net,  andrii@kernel.org, yonghong.song@linux.dev,
 martin.lau@linux.dev
Date: Mon, 16 Sep 2024 21:40:07 -0700
In-Reply-To: <dcaf46c8-68d2-455f-955b-311785cf2827@oracle.com>
References: <20240916091921.2929615-1-eddyz87@gmail.com>
	 <dcaf46c8-68d2-455f-955b-311785cf2827@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 11:16 +0100, Alan Maguire wrote:

[...]

> hi Eduard,
>=20
> you've added support for multiple declaration tags as part of this, but
> I wonder if we could go slightly further to simplify any additional
> future KF_* flags -> decl tag needs?
>=20
> Specifically if we had an array of <set8 flags, tag name> mappings such
> that we can add support for new declaration tags by simply adding a new
> flag and declaration tag string. When checking flags value in
> btf_encoder__tag_kfunc(), we'd just walk the array entries, and for each
> matching flag add the associated decl tag. Would that work?

Hi Alan,

That would be something like below.
It works, but looks a bit over-complicated for my taste, wdyt?

--- 8< ----------------------------------------
iff --git a/btf_encoder.c b/btf_encoder.c
index ae059e0..b6178c3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -39,7 +39,6 @@
 #define BTF_ID_SET8_PFX                "__BTF_ID__set8__"
 #define BTF_SET8_KFUNCS                (1 << 0)
 #define BTF_KFUNC_TYPE_TAG     "bpf_kfunc"
-#define BTF_FASTCALL_TAG       "bpf_fastcall"
 #define KF_FASTCALL            (1 << 12)
=20
 struct btf_id_and_flag {
@@ -1534,6 +1533,15 @@ static int add_kfunc_decl_tag(struct btf *btf, const=
 char *tag, __u32 id, const
        return 0;
 }
=20
+enum kf_bit_nums {
+       KF_BIT_NUM_FASTCALL =3D 12,
+       KF_BIT_NUM_FASTCALL_NR
+};
+
+static const char *kfunc_tags[KF_BIT_NUM_FASTCALL_NR] =3D {
+       [KF_BIT_NUM_FASTCALL] =3D "bpf_fastcall"
+};
+
 static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobu=
ffer *funcs, const char *kfunc, __u32 flags)
 {
        struct btf_func key =3D { .name =3D kfunc };
@@ -1559,8 +1567,11 @@ static int btf_encoder__tag_kfunc(struct btf_encoder=
 *encoder, struct gobuffer *
        err =3D add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id=
, kfunc);
        if (err < 0)
                return err;
-       if (flags & KF_FASTCALL) {
-               err =3D add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->t=
ype_id, kfunc);
+
+       for (uint32_t i =3D 0; i < KF_BIT_NUM_FASTCALL_NR; i++) {
+                if (!(flags & (1u << i)) || !kfunc_tags[i])
+                       continue;
+               err =3D add_kfunc_decl_tag(btf, kfunc_tags[i], target->type=
_id, kfunc);
                if (err < 0)
                        return err;
        }
---------------------------------------- >8 ---

>=20
> > ---
> >  btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 43 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 8a2d92e..ae059e0 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -39,15 +39,19 @@
> >  #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> >  #define BTF_SET8_KFUNCS		(1 << 0)
> >  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> > +#define BTF_FASTCALL_TAG	"bpf_fastcall"
> > +#define KF_FASTCALL		(1 << 12)
> > +
>=20
> probably need an #ifndef KF_FASTCALL/#endif here once this makes it into
> uapi.

kfunc flags are defined in include/linux/btf.h so these should not be
visible in the uapi/linux/btf.h, unless I'm confused.

>=20
>=20
> > +struct btf_id_and_flag {
> > +        uint32_t id;
> > +        uint32_t flags;
> > +};

[...]


