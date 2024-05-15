Return-Path: <bpf+bounces-29742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13428C6114
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8F28259C
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F340875;
	Wed, 15 May 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbczvxH4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AA3A8E4
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756169; cv=none; b=AfK9zp50XEa7Wd6M/df3q6UgRkOyWrdEtkWGLAowZt1/CQZVUOnMxXRWVMGKuEVkzg86C2uLCwldKSsaxuEa7h2Mq2EObQ6RFq4JxUJR6xZwByt0DEzKPgv+sjnsuxXUu5Jgdns5WUCVMaV2QY4ewe7I2urlsskc5t9EP1x40Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756169; c=relaxed/simple;
	bh=LxcAjbNWG8PquyKmHv3N0sOWIcNZhF6O/1bY8JY4Saw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYe9zyf+7CEYhgN2LXfJ7o1MF3fgY/dFa+Jl4jzVsobhhKVs3roPsk3oRw1PomfmZXw6UvCARZR2qJgrY+HuCO/v2I5Pi6Wi3fV5EZYNyiRZ59/VYWoTDM0KvJsbXRJNGPd5NVM63MyM8fIFY36Lg3IENFo9bi+LgM5WDrpQmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbczvxH4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed0abbf706so47848425ad.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715756168; x=1716360968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yydg59swC1qsiaVvrGtnOXNnQAoMQfA1MP53DbjUAdc=;
        b=SbczvxH4S3aHMNe2Qfms1NiJ5e1z8tWfv6nUBrTnIk2MAOJ4d/hMqG6NPTI764l8ya
         c0GiIdXoMGRLyFkuj4ElcQR8UU/3KHUCzivGPhnz4AdRloC6Cs6cXyIKV3aZryYex7d5
         Taf7g3K6zTB66MDV6XvLxFcVloc+Dv9HsEX7fxr8LbV9S0UKb2D+6ZC+X+SIicXK5QV6
         VAPoXr8evrdXTwVazaitQJlQnVTPhjJQzhewPyXSldw5iv/IM25WMGrEJstOJOuJoqH+
         s2DvWjyGx9WGeI49EvTjZiR12sAhbnI7fLXPAcFNHw73hxxezzWi17ZVa5amnBS18nj2
         qTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715756168; x=1716360968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yydg59swC1qsiaVvrGtnOXNnQAoMQfA1MP53DbjUAdc=;
        b=J7nlaEzhmM83Pi8Te+V4iJp5T+XimvxsuiQ0md6bVK4C+d48m9+GKG9velOrfIAkqi
         UvAF7DMY0Re2KtUL2lNYN3Mp+LOjxeMtd5kfQMd1Sjz70mGN4CMcc0BY21lwCXWT7ehy
         fDtsgclszkkjqOu+mOYlt5PX6GGDzbL8lUQq9nXoI5S+/zFp8Dgx/FdcVQTih2BstGQw
         SrBXInJuCLCHwVAzpRlQfbcYJuu7UhAtSwGcFm6LKqEbxNzCKIvwcOBhVEbakYaBfOYT
         8R2pMUWqgMAgdOeh5kXhwGeTcjmmtO+JUyXw0KNBS9NYNQkvYXecPBuNOsGrUnu49UYy
         OJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUfTqG43H/axMQbFbqQFfPu5y19zmQkynJjuY8XUFqT2vdzWWHnPjKh9FMHCslgY7w9el2gkoUEBen42spHMw/5GKdB
X-Gm-Message-State: AOJu0YybseaWkSqgdAEfenuiJ2KzxFNfaLCPY2atJgxI38HITbNxklku
	xTsjD3TLuy8/ikYTbql0VCheG/eDL9Z5086lUBGqOccJGCa3UXK/
X-Google-Smtp-Source: AGHT+IEVXLDyCFx29eDGmVmHH4J2IIDOa7KfeXlViDKTtRJHCIc1l5MxL7wG+nPM0lYH40bxNWLQCg==
X-Received: by 2002:a17:902:d4c2:b0:1ec:ad62:fe87 with SMTP id d9443c01a7336-1ef44059628mr219680895ad.56.1715756167812;
        Tue, 14 May 2024 23:56:07 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1899sm109712095ad.21.2024.05.14.23.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 23:56:07 -0700 (PDT)
Message-ID: <36ddc5553a7edafbb090bd507cf19b437334007c.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] libbpf,bpf: share BTF
 relocate-related code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Tue, 14 May 2024 23:56:06 -0700
In-Reply-To: <819d1223-a7e7-4b42-b454-d80422fca32d@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-11-alan.maguire@oracle.com>
	 <2e5472ba5b96118b11872a869b251132ca49dabd.camel@gmail.com>
	 <819d1223-a7e7-4b42-b454-d80422fca32d@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-14 at 17:14 +0100, Alan Maguire wrote:
> On 11/05/2024 02:46, Eduard Zingerman wrote:
> > On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 821063660d9f..82bd2a275a12 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -274,6 +274,7 @@ struct btf {
> > >  	u32 start_str_off; /* first string offset (0 for base BTF) */
> > >  	char name[MODULE_NAME_LEN];
> > >  	bool kernel_btf;
> > > +	__u32 *base_map; /* map from distilled base BTF -> vmlinux BTF ids =
*/
> > >  };
> > > =20
> > >  enum verifier_phase {
> > > @@ -1735,7 +1736,13 @@ static void btf_free(struct btf *btf)
> > >  	kvfree(btf->types);
> > >  	kvfree(btf->resolved_sizes);
> > >  	kvfree(btf->resolved_ids);
> > > -	kvfree(btf->data);
> > > +	/* only split BTF allocates data, but btf->data is non-NULL for
> > > +	 * vmlinux BTF too.
> > > +	 */
> > > +	if (btf->base_btf)
> > > +		kvfree(btf->data);
> >=20
> > Is this correct?
> > I see that btf->data is assigned in three functions:
> > - btf_parse(): allocated via kvmalloc(), does not set btf->base_btf;
> > - btf_parse_base(): not allocated passed from caller, either vmlinux
> >   or module, does not set btf->base_btf;
> > - btf_parse_module(): allocated via kvmalloc(), does set btf->base_btf;
> >=20
> > So, the check above seems incorrect for btf_parse(), am I wrong?
> >=20
>=20
> You're right, we need to check btf->kernel_btf too to ensure we're
> dealing with vmlinux where the btf->data was assigned to __start_BTF.

Maybe add a flag saying if .data needs freeing?
Tbh, following the callgraph to check when conditions are true or
false is a bit time consuming for someone reading the code.

[...]

> > > +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
> > > +{
> > > +	struct btf_rewrite_strs *r =3D ctx;
> > > +	const char *s;
> > > +	int off;
> > > +
> > > +	if (!*str_off)
> > > +		return 0;
> > > +	if (*str_off >=3D r->str_start) {
> > > +		*str_off +=3D r->str_diff;
> > > +	} else {
> > > +		s =3D btf_str_by_offset(r->old_base_btf, *str_off);
> > > +		if (!s)
> > > +			return -ENOENT;
> > > +		if (r->str_map[*str_off]) {
> > > +			off =3D r->str_map[*str_off];
> > > +		} else {
> > > +			off =3D btf_find_str(r->btf->base_btf, s);
> > > +			if (off < 0)
> > > +				return off;
> > > +			r->str_map[*str_off] =3D off;
> > > +		}
> >=20
> > If 'str_map' part would be abstracted as local function 'btf__add_str'
> > it should be possible to move btf_rewrite_strs() and btf_set_base_btf()
> > to btf_common.c, right?
> >=20
>=20
> We can minimize the non-common code alright, but because struct btf is
> locally declared in btf.c we need a few helper functions. I'd propose we
> add (to both btf.c files):
>=20
> struct btf_header *btf_header(const struct btf *btf)
> {
>         return btf->hdr;
> }
>=20
> void btf_set_base_btf(struct btf *btf, struct btf *base_btf)
> {
>         btf->base_btf =3D base_btf;
>         btf->start_id =3D btf__type_cnt(base_btf);
>         btf->start_str_off =3D base_btf->hdr->str_len;
> }
>=20
> ...and use common code for the rest. As you say, we'll also need a
> btf__add_str() for the kernel side. What do you think?

Sounds good, thank you.

[...]

