Return-Path: <bpf+bounces-22926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F286B9B7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A7828A49D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9F86278;
	Wed, 28 Feb 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr5BBDME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1C86241
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155008; cv=none; b=ZfVKyWAcpSAm9YPUgpL7i9Gh+X5zSFTp6AzmawTfhDxD1u0Am92YLqRyX5xA6E1eE6zc7xLhXAL5Q8gsbh76WUwFupKc83/tveK0AfgR6yCM+CNrPak+xKv4URzbEqt+Rvqzm7CDCozQnzKDZbXoYiSZq10eAlzTD6m8+eMOB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155008; c=relaxed/simple;
	bh=vyolngf3BkVcmWMh++CdSxfIys8wZSrpZFO93NGzvRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvXSLutuE2lTOVi9aWHs23pZkGzCAWUzgtn3lkUMnl34cwQZQ5j2buKuGQGwfOPH4TFhXK/vUetcUHWOV/QGHVd5QgWLCddFnJKJi2WLkN3yU0ELR+QFzZXNUJDd6BMEitaExoL/qq+3TcjOJaAuZGpR+jv+vK9AvFN5VhzPZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr5BBDME; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51320ca689aso144253e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155005; x=1709759805; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PbNozaNCl24q3K8rxQOyKyQFDVm9XnuhjKTDhB/ZZFM=;
        b=Fr5BBDMEmW9yUtMBqMP+/uC9sU6RB89L3edXPMntUagBZALbicJsanPXIHy7nPUx6c
         iMApUygGoH+BYbczaq2LFXjoc6y36jV+puMRBwqe4KzV0dkaT5DKyUBm0ISTEwwNAA60
         D7pb5setpIRMipilUBGBnddRfdXIP3kfAsNkXSdOXE5v6TKPWq/Qi5t6OdD2fw8fi7MR
         Cgkbf8FBNq5KcjbLvT4hYPDnYzm0Egb+UlUR/DQhNI9CD/ReUxE9zQY8Y0biMT1kAr5i
         61TzPqXvd3TBlPPOSvcblHvZQ9GWRJOuBpZneIQ0J4yRPqcJPqn4V1omOWsZZ+iuc7I6
         ARpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155005; x=1709759805;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbNozaNCl24q3K8rxQOyKyQFDVm9XnuhjKTDhB/ZZFM=;
        b=mwkC+8JB27PrXCzihXYgbEDtFJqImlmwNYshH6zPMo9Y0Xw0dSmBCidPe4tpdTLloQ
         +vnQ23+JaMiOIFr9uaV1Hndp/he9zfnG8lhQzug/6aFnRTF3ulKs5CRE0Hqryn/f4y1u
         ZdBViTsE1W2+lBRMUkgX5/Hmq2Qn075qgzQbhUsIt8ZhPgfW8kSL/9KTM4auXDCBPqJB
         GWDaBp2TJmgikhx3m2lrwenMTmit/434oS2F+G1x+rpu5YM7ttbmSPJsgJP4c5nBTqEH
         bPxfW9hzcWJxYtoMpCPtbcvR3OGQ2sCKL+IGuPh1fAIAYyZrrReHBxGSphqSauEBx5QD
         eM8g==
X-Gm-Message-State: AOJu0Yxv61dVlR7SS45CMAqNAOIVt6hjNemZAN8H5KxpOYkT5tdyQaYU
	2rj7epiSPML4Awu2FiuMmlcMNhhIscVO3KC//o6AIByK+MaQiGyn
X-Google-Smtp-Source: AGHT+IGD5xUJJG/wb0CJeXqPCvdogr1B5J3f0QWn4p70YYzVcgRg4njVkXds0NkbK4dzpmLW1mvl/g==
X-Received: by 2002:a05:6512:250f:b0:512:f679:665b with SMTP id be15-20020a056512250f00b00512f679665bmr134318lfb.42.1709155004977;
        Wed, 28 Feb 2024 13:16:44 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512048300b005131cacde5esm40467lfq.249.2024.02.28.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:16:44 -0800 (PST)
Message-ID: <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Wed, 28 Feb 2024 23:16:43 +0200
In-Reply-To: <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
	 <20240222005005.31784-3-eddyz87@gmail.com>
	 <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com>
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

On Wed, 2024-02-28 at 11:58 -0800, Andrii Nakryiko wrote:
[...]

> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index cbfb235984c8..26e32555711c 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
> >         u32 prev_idx : 22;
> >         /* special flags, e.g., whether insn is doing register stack sp=
ill/load */
> >         u32 flags : 10;
> > +       u64 equal_scalars;
>=20
> nit: should we call this concept as a bit more generic "linked
> registers" instead of "equal scalars"?

It's a historical name for the feature and it is present in a few commit an=
d tests.
Agree that "linked_registers" is better in current context.
A bit reluctant but can change it here.

[...]

> I'm wondering if this pop/push set of primitives is the best approach?

I kinda like it :)

> What if we had pack/unpack operations, where for various checking
> logic we'd be working with "unpacked" representation, e.g., something
> like this:
>=20
> struct linked_reg_set {
>     int cnt;
>     struct {

Will need a name here, otherwise iteration would be somewhat inconvenient.
Suppose 'struct reg_or_spill'.

>         int frameno;
>         union {
>             int spi;
>             int regno;
>         };
>         bool is_set;
>         bool is_reg;
>     } reg_set[6];
> };
>=20
> bt_set_equal_scalars() could accept `struct linked_reg_set*` instead
> of bitmask itself. Same for find_equal_scalars().

For clients it would be

        while (equal_scalars_pop(&equal_scalars, &fr, &spi, &is_reg)) {
                if ((is_reg && bt_is_frame_reg_set(bt, fr, spi)) ||
                    (!is_reg && bt_is_frame_slot_set(bt, fr, spi)))
                    ...
        }

    --- vs ---
=20
        for (i =3D 0; i < equal_scalars->cnt; ++i) {
                struct reg_or_spill *r =3D equal_scalars->reg_set[i];

                if ((r->is_reg && bt_is_frame_reg_set(bt, r->frameno, r->re=
gno)) ||
                    (!r->is_reg && bt_is_frame_slot_set(bt, r->frameno, r->=
spi)))
                    ...
        }

I'd say, no significant difference.

> I think even implementation of packing/unpacking would be more
> straightforward and we won't even need all those ES_xxx consts (or at
> least fewer of them).
>=20
> WDYT?

I wouldn't say it simplifies packing/unpacking much.
Below is the code using new data structure and it's like
59 lines old version vs 56 lines new version.

--- 8< ----------------------------------------------------------------

struct reg_or_spill {
	int frameno;
	union {
		int spi;
		int regno;
	};
	bool is_reg;
};

struct linked_reg_set {
	int cnt;
	struct reg_or_spill reg_set[6];
};

/* Pack one history entry for equal scalars as 10 bits in the following for=
mat:
 * - 3-bits frameno
 * - 6-bits spi_or_reg
 * - 1-bit  is_reg
 */
static u64 linked_reg_set_pack(struct linked_reg_set *s)
{
	u64 val =3D 0;
	int i;

	for (i =3D 0; i < s->cnt; ++i) {
		struct reg_or_spill *r =3D &s->reg_set[i];
		u64 tmp =3D 0;

		tmp |=3D r->frameno & ES_FRAMENO_MASK;
		tmp |=3D (r->spi & ES_SPI_MASK) << ES_SPI_OFF;
		tmp |=3D (r->is_reg ? 1 : 0) << ES_IS_REG_OFF;

		val <<=3D ES_ENTRY_BITS;
		val |=3D tmp;
	}
	val <<=3D ES_SIZE_BITS;
	val |=3D s->cnt;
	return val;
}

static void linked_reg_set_unpack(u64 val, struct linked_reg_set *s)
{
	int i;

	s->cnt =3D val & ES_SIZE_MASK;
	val >>=3D ES_SIZE_BITS;

	for (i =3D 0; i < s->cnt; ++i) {
		struct reg_or_spill *r =3D &s->reg_set[i];

		r->frameno =3D  val & ES_FRAMENO_MASK;
		r->spi     =3D (val >> ES_SPI_OFF) & ES_SPI_MASK;
		r->is_reg  =3D (val >> ES_IS_REG_OFF) & 0x1;
		val >>=3D ES_ENTRY_BITS;
	}
}

---------------------------------------------------------------- >8 ---

