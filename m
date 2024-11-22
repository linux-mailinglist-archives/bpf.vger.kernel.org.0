Return-Path: <bpf+bounces-45477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92D9D63FA
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55AAB29D16
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32F1DF98F;
	Fri, 22 Nov 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVbimtH4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C91DF96C;
	Fri, 22 Nov 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298906; cv=none; b=jKC2oNTiq14jX1nvXPhlDojjO1ieloyvQhmG15olpGG6FgPi0buGtxWua9A/xjBDipqTcCTgiTiVFAmmmpmvFN/JPEMw3fNfObLqYnEtPajTZTb0i/F6nsrpM1zFsBbjc+JQ0TADCYUAyuAIoRoiM/frclIa5Q78eiuedEmmVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298906; c=relaxed/simple;
	bh=GIWDY+XCcynk33gAKpOdaVyYZkej746j+7PMisDY70k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpRUW8rGGw4mfK7hB37hFIlGIpKa/LQjVHQQyca9ntqC2rNSpO9s28FfYMkVm26pNmu+z6NZR1LVHMG4Xuyna+J42JOH3X/LS2tZn6ZYx42eGtf9xEqMCbIlbTLj9GQw9Bm3/IjvDqpRzchqq7jic2PH2VvOedIR3oa0qItaKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVbimtH4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so2090079a12.2;
        Fri, 22 Nov 2024 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732298903; x=1732903703; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILUx4nFBkzLSIP3Zz0k/oAUW7rEao6gh/DngijhT/Hc=;
        b=OVbimtH4E6mcuLt92sWJwUqab02sRBPGUt9VWp+W4VAL0k9ovfZ/HkrJlpPQqCEc5X
         LpL3tTbksVhFrlmOLd31m0veZaErDF/VwK45xCm3K0qRbVJupGRGRa8zItrGnwjXnNct
         mj2uKRiUI/QeXL9B+P9XHYuFIG1WJnWrnV8HqR4eMTREj5wxfA4QlypY41WBw9TOOKS2
         yOQrCuHIfC04/GJJUAGf/exuXeWY90hD7A3tM2QUvOXpbDgfll+25FWyfW13go+TVoZw
         TyClKCQUPlyp80QxLwKmppPpHnVByeYZURBXeeeTRzirXe1987xp+her0PS+6D3JwwI3
         5Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298903; x=1732903703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILUx4nFBkzLSIP3Zz0k/oAUW7rEao6gh/DngijhT/Hc=;
        b=KINepauy3SRdbBxuEQO29GJ+BdQ+W95EKPpSpcGAPu3e6DdMPsS248CUpnNBAvsQrY
         KR6sSvFDsMny5+77X6I3Jga/I7dv8wtaqyRNgU6sk1F0kQaG4kz8NhBOauVUA9tLAusb
         ano34/zpU4errgE6H4g2ues2b2cX8q8VA1dCsd9mPw9Ssf12J1vrXf5jt5Rx/lZtarql
         YqGoQuAhgF6S5VxhchnbIUUXTzM9PyLNI86nocZ7jJi1mCA3wsQkuYII0H5eaJKqWBDg
         iO16GJGZCs6CXeFhTvXnwZBGjz6rYTSMPxxS7MiHJkOoofz2Axw4qyk3zTMQbZfCFdjI
         Jxhg==
X-Forwarded-Encrypted: i=1; AJvYcCUApGie2tRErycKRWdlhh5M2141CwgTPLJ8fpBbOcvTENf+KDaVdrunrJ8RvIakQ29UwOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++bzjwqBjY1y6cwFpRQ8quFZVE3tiwFcyj5y05ejQ8GVQr0uo
	ZYLELpD/KxR2eSvIl+CVMgLDROvSBK55d0n/EA2p1i5x1B7XMYbD
X-Gm-Gg: ASbGncvCQeQ0jxw7E7viXBdToFPj+PGsiW8bWc7LfexwwrnKsxovVXnBxpVW7Lb7y2/
	JblcUEM8vgkmXrEqHH2IXc91Yknb7k491MY83JrLuM1ahPz1fX/Ap+W1TG6tMjwXi/T72sBaq4f
	uBNQU6Uva4LFE04bTnNQizqf91ZQJkYqE1QKMwPYyKfvZhHqrGvEZRKEG5VPjFRpV+d/isN5o98
	IbZweXBQolhrPSHNTYkhzvxvAL4i93oaoZ2Y0/391tbo9I=
X-Google-Smtp-Source: AGHT+IHL0bXvAx+b40NPeFE2c0uDYbPfWRUHeVqvbSXSTeriSsvkZRxi+ggvhKnKFL7e3Ut1IV5DNw==
X-Received: by 2002:a05:6a21:7881:b0:1db:b780:5a8c with SMTP id adf61e73a8af0-1e09e46b0c6mr5010073637.20.1732298903319;
        Fri, 22 Nov 2024 10:08:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc0dbcefsm1949148a12.18.2024.11.22.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:08:22 -0800 (PST)
Message-ID: <ba19c9a020f2f3d9895493930bdd3a7d7a58f1cd.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu	 <dxu@dxuuu.xyz>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Vadim Fedorenko	 <vadfed@meta.com>
Date: Fri, 22 Nov 2024 10:08:17 -0800
In-Reply-To: <Z0CfBQR8zxgJv_AP@krava>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
	 <Z0CfBQR8zxgJv_AP@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-22 at 16:11 +0100, Jiri Olsa wrote:
> On Thu, Nov 21, 2024 at 11:02:18PM -0800, Eduard Zingerman wrote:
> > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > kfuncs present in the ELF being processed. This section consists of
> > records of the following shape:
> >=20
> >   struct btf_id_and_flag {
> >       uint32_t id;
> >       uint32_t flags;
> >   };
>=20
> it contains pairs like above and also just id arrays with no flags, but
> that does not matter for the patch functionality, because you swap by
> u32 values anyway

Right, I'll update the description, thank you.

[...]

> > @@ -1847,11 +1848,47 @@ static int btf_encoder__tag_kfunc(struct btf_en=
coder *encoder, struct gobuffer *
> >  	return 0;
> >  }
> > =20
> > +/* If byte order of 'elf' differs from current byte order, convert the=
 data->d_buf.
> > + * ELF file is opened in a readonly mode, so data->d_buf cannot be mod=
ified in place.
> > + * Instead, allocate a new buffer if modification is necessary.
> > + */
> > +static int convert_idlist_endianness(Elf *elf, Elf_Data *data, bool *c=
opied)
> > +{
> > +	int byteorder, i;
> > +	char *elf_ident;
> > +	uint32_t *tmp;
> > +
> > +	*copied =3D false;
> > +	elf_ident =3D elf_getident(elf, NULL);
> > +	if (elf_ident =3D=3D NULL) {
> > +		fprintf(stderr, "Cannot get ELF identification from header\n");
> > +		return -EINVAL;
> > +	}
> > +	byteorder =3D elf_ident[EI_DATA];
> > +	if ((BYTE_ORDER =3D=3D LITTLE_ENDIAN && byteorder =3D=3D ELFDATA2LSB)
> > +	    || (BYTE_ORDER =3D=3D BIG_ENDIAN && byteorder =3D=3D ELFDATA2MSB)=
)
> > +		return 0;
> > +	tmp =3D malloc(data->d_size);
> > +	if (tmp =3D=3D NULL) {
> > +		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", data->d_siz=
e);
> > +		return -ENOMEM;
> > +	}
> > +	memcpy(tmp, data->d_buf, data->d_size);
> > +	data->d_buf =3D tmp;
>=20
> will the original data->d_buf be leaked? are we allowed to assign d_buf l=
ike that? ;-)

Well, before sending I checked using address sanitizer, and it did not comp=
lain.
As far as I understand elfutils elf_getdata.c / elf_end.c [0]:
- elf_getdata() allocates memory for full section (elf_getdata.c:333),
  before setting d_buf field of Elf_Data;
- elf_end() frees memory for full section (elf_end.c:174).

So I assumed that this is hacky but not that bad.
Given that current patch depends on implementation details it is
probably better to switch to one of the alternatives:
a. allocate new Elf_Data object using elf_newdata() API;
b. just allocate a fake instance of Elf_Data on stack in btf_encoder__tag_k=
funcs().

(a) seems to be an Ok option, wdyt?

[0] b2f225d6bff8 ("Consolidate and add files to clean target variables")
    git://sourceware.org/git/elfutils.git

[...]

> >  	if (fd !=3D -1)
> > diff --git a/lib/bpf b/lib/bpf
> > index 09b9e83..caa17bd 160000
> > --- a/lib/bpf
> > +++ b/lib/bpf
> > @@ -1 +1 @@
> > -Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
> > +Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
>=20
> I think this should not be part of the patch

Sorry, didn't notice this thing.


