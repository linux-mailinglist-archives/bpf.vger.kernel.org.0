Return-Path: <bpf+bounces-21860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93D8536D9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FC9B23CF3
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C55FBAB;
	Tue, 13 Feb 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFS0t7yT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FCC5FB9D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844138; cv=none; b=NblK9+joEHtavRcjOZb0I+w022AgeUpLIFd/RQJ8val57uSRHeEXJ3b4MbH9G+iHLsSGqCo+JSrCRT7S/jmQvGCRHIksz+gjbkYn9haG/kFsTYVUHNIDWTinp5MxveBfbpNFmDIIvbMPwhauT5LxNBnQ3Dl/UAxYTvua5+8dNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844138; c=relaxed/simple;
	bh=m8tvFQ5iC4b438QIvAlpTuJxsrTh8BuF0Wnuvtz68fs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9vru1CCZksrIA02jcvPzLwvHomJXtd442Euuo73kb1BF6s4G3UFiFIo6/xdUNkfXQQu5gZ9fWkCOkPfGLlLETF9ZIKmqXrJxil7bmDC6ngHuNw9n73LVs9JCKTmvWR+9yy3V5e/ePZf/NCSsKaVQtJquilXVoj0fJzmWYLhzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFS0t7yT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511831801f3so3423490e87.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844135; x=1708448935; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+p16PpCM9hS6iamLtBeluA7gzsLHXj3lrPdNYGizEM=;
        b=RFS0t7yT+kAzfJqxW308oTKTaGq5o6sFwYyC6JKlalVpNyRKtSxI2Bo7sgaGX+PqgK
         X4LPCFAX3zeIxPEOSQ1lqQDZsaNlCAhmMGS8n93tJQ3LZdF4ssM801PMkOYLNp/dRRJQ
         5MN4gxaApiAn3CcpgzV7uXlKow3Gauoq5yJrp8gxGYvLdrISALCB4qrJ6f8AjGTp4s1x
         14+RjaZK8wjZiPunmlZI/4BRbTE/5/8ViyRuWuLnrzlZH+cdLCmcu5WFXeE9XIWKcwhC
         ji2yRDaxlW/+SlEKAfpe7j+LmuAdYixbCUj6GXV2anZPJqGdtSnL7wi+yaXla4qsQBly
         YCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844135; x=1708448935;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+p16PpCM9hS6iamLtBeluA7gzsLHXj3lrPdNYGizEM=;
        b=GrSiazRuSfvdFDQR65BxRks7/n3oG4BMsOgOTZzhRL4PbyvWGdld/7VtxsWEWXCWDq
         MMazENp6NdHjx6lyPVHF0EF7nhpnwDefyhu5br4iW9nwjKYdsWPQ++mGnj+GrfGyRVPc
         5K410NTQfwHOzLua0U2WXQ8UeXrur0VzeBkxBuA0YxGpq3TAFw7jjXU/cQYA0c8IJZye
         +S2dErTGvhfsfqVb6jgiHyOnY5tD0oIYag/CRgHAfaVfMeSt3ssp2OVPtdiWWjQOQqxp
         X5BnKieQjaH7m2JAxlKv4ChGUmMcU/3a+G8xI/xHl6MhOU35J/HbIhtIo0Wbp1z0LBuU
         yJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWhMVFbDgewraxwq2hCgiohL+KlN68yCR/0/ZDI2qi3Qh1zmbT84f+pI3u2liXd3hD05OETn7WvkpJ5BqWQIMhiBiHQ
X-Gm-Message-State: AOJu0Yxgzi9pM/xsRYjcPkeiuX4oXwMJMvsS4jq+VfH1fGNdUqM8Klxe
	LDZcacWusmohmMNG3RQt9MDTcQyswKn1TEz9yVpwJKfTNb2LF8Hj
X-Google-Smtp-Source: AGHT+IE/lD7WTVLQbJITIXi+wsN4L5kyuBWIm9uZaWMokGDGymfS4kA2kkOMZQV4D9kw7OYmUFNEIw==
X-Received: by 2002:a19:ca54:0:b0:511:81ed:394d with SMTP id h20-20020a19ca54000000b0051181ed394dmr126420lfj.29.1707844134758;
        Tue, 13 Feb 2024 09:08:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHswzNZMpfq4Fv+bTTbmZ4BAhfyJZzaQF/GAXf6nxDBRBL7rGH5N9O9kCVhZygwk1FU/CYGs1goiFH1iw+KRv/xijp5OjOopO6DWG7o5OO7dFuMawXosy6kzIzFYH6hrIP4gNLJaLpvHPN4CI4xXyHh/LblYWvM2srwLL4bpT5X6w7yQ7HdxpYlgMqtyVwbUHYPoDeh7w=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ca20-20020a170906a3d400b00a3c49c5aa85sm1464186ejb.126.2024.02.13.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:08:54 -0800 (PST)
Message-ID: <4950b053549136fbf852160aa64676e2003c4255.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Tue, 13 Feb 2024 19:08:53 +0200
In-Reply-To: <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com>
References: <20240212233221.2575350-1-andrii@kernel.org>
	 <20240212233221.2575350-3-andrii@kernel.org>
	 <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
	 <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 09:02 -0800, Andrii Nakryiko wrote:
[...]

> >         t =3D btf_type_by_id(btf, t->type);
> > -       while (btf_type_is_modifier(t))
> > -               t =3D btf_type_by_id(btf, t->type);
> > -       if (!btf_type_is_struct(t)) {
> > +
> > +       /* Skip modifiers, but stop if skipping of typedef would
> > +        * lead an anonymous type, e.g. like for s390:
> > +        *
> > +        *   typedef struct { ... } user_pt_regs;
> > +        *   typedef user_pt_regs bpf_user_pt_regs_t;
> > +        */
> > +       t =3D __btf_type_skip_qualifiers(btf, t);
> > +       while (btf_type_is_typedef(t)) {
> > +               const struct btf_type *t1;
> > +
> > +               t1 =3D btf_type_by_id(btf, t->type);
> > +               t1 =3D __btf_type_skip_qualifiers(btf, t1);
> > +               tname =3D btf_name_by_offset(btf, t1->name_off);
> > +               if (!tname || tname[0] =3D=3D '\0')
> > +                       break;
> > +               t =3D t1;
> > +       }
> > +       if (!btf_type_is_struct(t) && !btf_type_is_typedef(t)) {
>=20
> and now we potentially are intermixing structs and typedefs and don't
> really distinguish them later (but struct abc is not the same thing as
> typedef abc), which is probably not what we want.

Yes, need a condition in the end to check that 'ctx_type' and 't' have
same kind.

> Also, we resolve typedef to its underlying type *or* typedef, right?
> So if I have typedef A -> typedef B -> struct C, we won't get to
> struct C, even if struct C is the expected correct context type for a
> given program type (and it should work).

For code above we would get to 'struct C'.

> So in general, yes, I think this code could be changed to not ignore
> typedefs and do the right thing, but we'd need to be very careful to
> not allow unexpected things for all program types. Given only kprobes
> define context as typedef, it's simpler and more reliable to special
> case kprobe, IMO.

Maybe, I do not insist.

