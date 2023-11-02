Return-Path: <bpf+bounces-13999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA07DF98F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FC31C20FB7
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769772110F;
	Thu,  2 Nov 2023 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1+zlry6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC4208A4
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAE4C433C8;
	Thu,  2 Nov 2023 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698948480;
	bh=v5iQKregefZzHTwNFBmzoRUYo+qJWZHBvG9xV3HJYEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a1+zlry649dBIvxM364r/a0VMSOeJD7kP+r+LNkzPJ5cL8PGi6zbOiysOrRWixe30
	 kmYU9yrnOwS0snNxj4jV+WkahVfw3IWcT9FGKGTck/Fbx9KAKMjh6n8jvFdylXMumx
	 qxfFQl4uiPxdZiVy+9Xkn7cMkrc/VFdfbpkZCi5IUXxDVp0ZcPUIwXCDBSx5VqGJAQ
	 15U6XvuhWKq1J+dAkw1Q0g0Gl9xOVQFunT48RnH4WGLNTeBxmardPzFk7B4KsY1scW
	 wMRGvdAEIBu4OOiCKsCn0Ow8Fbcmc5ckjt8iojOBaG9kA8Ta0QFLgSz1sEuQTlXbox
	 lxOYiN7LLfy0w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1ADEDEE637C; Thu,  2 Nov 2023 19:07:58 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on
 erro
In-Reply-To: <CAEf4Bzb4VbH56S2D_5Sc3u9V=OXOy20JTr4wsObBOiUA32Md2Q@mail.gmail.com>
References: <20231102172640.3790869-1-andrii@kernel.org>
 <877cn011mj.fsf@toke.dk>
 <CAEf4Bzb4VbH56S2D_5Sc3u9V=OXOy20JTr4wsObBOiUA32Md2Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 02 Nov 2023 19:07:58 +0100
Message-ID: <874ji4111d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Nov 2, 2023 at 10:55=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
>> > Let's fix it for real this time. It shouldn't just detect ERR_PTR()
>> > return from bpf_xdp_pointer(), but also turn that into NULL to follow
>> > bpf_dynptr_slice() contract.
>> >
>> > Fixes: 5426700e6841 ("bpf: fix bpf_dynptr_slice() to stop return an ER=
R_PTR.")
>> > Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_r=
dwr")
>> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> > ---
>> >  kernel/bpf/helpers.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> > index 56b0c1f678ee..04049097176c 100644
>> > --- a/kernel/bpf/helpers.c
>> > +++ b/kernel/bpf/helpers.c
>> > @@ -2309,7 +2309,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct =
bpf_dynptr_kern *ptr, u32 offset
>> >       {
>> >               void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset=
 + offset, len);
>> >               if (!IS_ERR_OR_NULL(xdp_ptr))
>> > -                     return xdp_ptr;
>> > +                     return NULL;
>>
>> Erm, the check in the if is inverted - so isn't this 'return xdp_ptr'
>> covering the case where bpf_xdp_pointer() *does* in fact return a valid
>> pointer?
>>
>
> Ah, you are right, I missed the ! part... Ok, then I don't think we
> have an issue, great. Thanks for double checking!
> Perhaps we should add a simple comment "/* we got a valid direct
> pointer, return it */", as this looks like an error-handling case.

Yup, totally agree it's confusing, I had to look at the code three or
four times as well just now, to be sure that it wasn't buggy. Adding a
comment would certainly be useful! :)

-Toke

