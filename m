Return-Path: <bpf+bounces-77642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2206CEC819
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A90FF300994E
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C230BF6C;
	Wed, 31 Dec 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPv23OVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F632253EE
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210363; cv=none; b=sRFxSHqdjqeT6b662iGpjZjwUQnWd26i/gfJpcQsAe/+3017mxknxsiGVhAE//GfXf7jPefxcFgKNKprn0M8T0OfJnE5QnTMVmwJSh8r2HTioxhnduxxzUC0ezZ9KjIeb+EU2eLqyMdUGB4CxIcvB7AHDn4wgInIPk99thv6T8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210363; c=relaxed/simple;
	bh=xM1KzgcpSm3ZvfcLg8zwlFkeqwJ0o/YGR0MoyOnZYac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b8sfIGK55NUQ6kNdwyV8yUcea/w9IG91t2XfIzJ3NUHdEh1P6koJ4SB9INSFEXUSrH8P7AQRIVG9zVty8cSxt/QZn32HrDKYKjd2jvq8jWAA1bdW5w9wcaRbIQorw9qcfqnjyZJFbU3TwRRinKwHr6Rye1102OysLWpTOz9P0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPv23OVN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso8785312b3a.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767210361; x=1767815161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXNiI0uXXeNeukQw6fSLK55WijOCQ03jua8loUABo2I=;
        b=KPv23OVNiOhje47Nk24s8TOEDEur1G6Lp43J5oy7VnoO1eEjNRpnqFRot00bHRLqp7
         Bs4RVE64H9A914gy6lb/vdftdFNfOWNeV6uFAmxJP4G8/Rs8dYPPRDFkZ7xr7AMqD0y7
         FcvUzO+p9lYUAfREcIimzUp/K6vAuA5N97guY2zZ9qQ7Tf6xV3mKXw2C0/gTcxrDenQi
         x+YNSn8uJZcxe6F7MeDgM5umxqSedJd3gLRiQn9+5rQpt9IaCsC/XOQcmGpU+kt1dBD9
         l59nO+aLiSANPIN4/3Nr5/pkWFy3v+1B9VCuCuJqIe5UEc8ouQ81RXs9zMe5VUERaxmm
         2zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210361; x=1767815161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXNiI0uXXeNeukQw6fSLK55WijOCQ03jua8loUABo2I=;
        b=uxhx3/wmTQPbMhj9Z8Znoj+4+SCbd/4ZLetXSVqlmtsNIcO0MU7flouGmfP+pXried
         ZxBIcpdOwn7dlm+FUK/Ga/JRi5rY94AzFLCe5JWpvOEezvj3LNuFjeLRn9jJ5MapMEA/
         6EFPuQSlLnNKPANKVpbVzvFNwGwyIhm2SupikbkNeHlMIHiH5zK61p/QkKSXhzb50tkv
         kgxaLJKpeWzSlQTFu3sUc+rov74qB4tbYjXUt8n+bS6rBd6+iAG0nufh1aNS9yBQFSsu
         qjdeeKsDMJz76KsI9pYJIETbDik0s0mp3HqFsgeWuHV00SXTzgKPTCp7MtQ/CMVe4dCY
         yNHw==
X-Gm-Message-State: AOJu0Yz6erJduHwNMXTrZvKBYzf3JoGiat9O2pRo2gcMKxcickc3DDHz
	dxRVWtTRoeVCB/3qjEr2OlLitvKSucNaBNJupOOdeJPd2bfh0L9yhfuw
X-Gm-Gg: AY/fxX5QOfhfuLTQJe3Yh41GdvgoTFlBr7sWWqPuQt3eSXo7CSvGDtnexW369zRMIx+
	XnUYHSye2JF9A18XCGi56Gbmvdif7GXZphh7V9ZCSBOE9HzoMgxIEDEI1Xztqce9J+xWJG4znYo
	cVk8qkXDmD81PSMOV9y1Jr5w1keFzmKCD1kIAOeb3pJOKI3mrKOGvMnUHYJ/DWKg011l1KNcn+R
	PAC/mUj21p0rd/bZOFiAImIpGON2eHOM6t0glpwbsvageBUYu0SRp39Wqa98VFvLxsGKq1zqWpy
	VeLS5F1sIiMY23bh1jkQvoP58YTSjKacRFDi424a3jrH9XzdBGabmWnM4P07fxKi1cl1tEJ1ktk
	u/Y/Kucj7Fsyl1zX0/gu+zMfKJ2s5GWuOz3zOwt/2U0S/aJ1xJUEkUSM1QZt2mVWFIew1h1GYkF
	4SKF9+Lje6
X-Google-Smtp-Source: AGHT+IGDaoNIkDEaq0S0JViADGCgl820OjvDzWrUi//3A0RdjpLW9P26uFdo/kWBEWxRGGIx33PQXg==
X-Received: by 2002:a05:6a20:6a03:b0:35d:d477:a7e0 with SMTP id adf61e73a8af0-376a75f5b36mr32690267637.15.1767210361183;
        Wed, 31 Dec 2025 11:46:01 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e77285111sm18726653a91.5.2025.12.31.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:46:00 -0800 (PST)
Message-ID: <5a7adb5b2627b4572e86ab76fa4099e34c5c300a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] selftests: bpf: Update failure message
 for rbtree_fail
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:45:57 -0800
In-Reply-To: <CANk7y0gt3NSQooG4FactYh-q7bD9zf77B6ZiQg4nEhNAq1ro-Q@mail.gmail.com>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-6-puranjay@kernel.org>
	 <158a0c1b46418130cd8e3a7b67775f3bd00caa16.camel@gmail.com>
	 <CANk7y0gt3NSQooG4FactYh-q7bD9zf77B6ZiQg4nEhNAq1ro-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 19:44 +0000, Puranjay Mohan wrote:
> On Wed, Dec 31, 2025 at 7:27=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > > The rbtree_api_use_unchecked_remove_retval() selftest passes a pointe=
r
> > > received from bpf_rbtree_remove() to bpf_rbtree_add() without checkin=
g
> > > for NULL, this was earlier caught by __check_ptr_off_reg() in the
> > > verifier. Now the verifier assumes every kfunc only takes trusted poi=
nter
> > > arguments, so it catches this NULL pointer earlier in the path and
> > > provides a more accurate failure message.
> > >=20
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > >  tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/=
testing/selftests/bpf/progs/rbtree_fail.c
> > > index 4acb6af2dfe3..70b7baf9304b 100644
> > > --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > > +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > > @@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
> > >  }
> > >=20
> > >  SEC("?tc")
> > > -__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=3D1=
6 disallowed")
> > > +__failure __msg("Possibly NULL pointer passed to trusted arg1")
> > >  long rbtree_api_use_unchecked_remove_retval(void *ctx)
> > >  {
> > >       struct bpf_rb_node *res;
> >=20
> > Do you happen to know how did it infer off=3D16 for R2?
> > From the test I would infer that the off is zero.
>=20
> I thought about that too,
>=20
> struct node_data {
>     long key;
>     long data;
>     struct bpf_rb_node node;
> };
>=20
> the node is at an offset of 16 and bpf_rbtree_remove() returns the
> pointer to this node.

Oh, makes sense, thank you.

