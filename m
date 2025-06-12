Return-Path: <bpf+bounces-60533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032EAD7DAF
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42EF3B3012
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E422FE17;
	Thu, 12 Jun 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S69mlxp7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFD79E1
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764577; cv=none; b=A/PzlPB06qz/T267NkPUFXF+wkoT2cYXMZ/vvuLduUWRzgx5W4TwSHjmEus2X3YXNo2e2IelK5aPN29b9gXD2dgT5hhNOzin3Jp++Y3DYGWKrPUGVNqPxVOtRnYaEVIBkAkN7y6QZhVF+hwNzfiAEBWWz/M43FJRx/8v5jsyT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764577; c=relaxed/simple;
	bh=LheihJJE8xELNQoHk9PMiV1HePcVudC3HlPaQGOTNDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqJz1ccmDQrPYoycNshqTYqDAIElzRy5hRiI0NZK1ELR4FNUk/EMBZpcmPc0Kr5dLKXgVSuOD/qQ4lPouPeM3oadtaFyVdi5kNBIlsFiJeSho8f6g66KwXyKN7rZ8IPizO0eimide8SN954djrbkLK3nTOcUWoClZjZp2aeimYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S69mlxp7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f71831abso1367317f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764574; x=1750369374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LheihJJE8xELNQoHk9PMiV1HePcVudC3HlPaQGOTNDI=;
        b=S69mlxp7ZX8gvAVVdsx/Z8OIHZdUBV2LK9w0FyQ0TCWX/8KVr7EXqulTUgeSzp0CtJ
         J/Bhs0VM0HnB3xOwpN/tcsCMtmWBuFRv/n3RGcWSwI2Yfuv8+yydIYw5+JCJhU0YfTp/
         2PdNcuWT6hX5AEzDdvalX4R95Ps55fI85eC3xAwdfGjSGTeJDdXv3LlgworzvvFpxSV5
         Ddpssb2VK+BHRAAAF7fbz9ZEtCqbVZDLNAUb6SxleDf9lZYkrRotPcZj8JFm83TTtxNV
         J2eFweaskur1gNvG8a7yrkaPps5i6eliwWsewZA+9Los+MC02hZ1/I2ZpN1SXOfOI3gw
         BbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764574; x=1750369374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LheihJJE8xELNQoHk9PMiV1HePcVudC3HlPaQGOTNDI=;
        b=YYVrARXCG+OjkK952fkQBJBQG/jtfXnkU6oFtq3egNVNNJh1z+kxvRLnp+HCEkFmpx
         kEuJvkwyJPSskdpz3F1KUkLR88kAKQcFWxNR+2pmDAiW4E5yAIjp3oiGn8+ScuS7Ftte
         byWWpAhoFkxhhQABqz0Hjfo2E+8hCNWgtUeKpkDGr942HE40RDhO1OM70henJXiXM4gR
         9JRAsAZfFlPlb0qiOYvVMFOfsuqswTgU/joKZrV28Jw93urabieUwnNc1BBIvubxRb3m
         0szQ51TvyOAUYOnWrmOe6G+5p6eJWnCyAj3+aNNs8jqcp8VEpJQK/vsfLZ3YP7IduEej
         8WAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5uStAPmxCaPrKXSzpS4zZXO2hhywUZoSNHpjnWHpdICvaxJn4C/XxKJKeT4Rd8VdRHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYOGX+/nYKEWQBQUtIxUUrjcOG1+qhW3d6o54gg3Ji/kIlEoy
	tZlu52LIsSdVYx49HbN/MjZGmgIc65V/64QBXmbMBxjoiqkg2v13Q4puJerelasRhFENibd/ty4
	ZzAL03qyC2Wa6KEETwzDaHyGffVhLB0A=
X-Gm-Gg: ASbGncvhBFSnbSWtqc4+E+Z0wPt8u2tXrXd2mOIyGGusEUfVspbMGQ0FeGWRNMLcWER
	2NhuJbTLXAt1c9zB2bNh9hC9KEwVvevn9kgyHsxrrZt/EsK6HK2pbcvExgteIYbdXvEkjp3RzXh
	P6u4b0BGL8KScUXspkIGroURFPchRQuklzatsDuya+ynXSAsxiq66H3ZY34TfW5e68FGo1h3wBg
	V1Ob7/ftSc=
X-Google-Smtp-Source: AGHT+IGKl3Ey95Vkmx/olECEYr5KdO3UGLIhKpIpMHQpxijqVbGH5qtQsojq352guDHQW8TY1eQKzqPJ6gBIefBzAzo=
X-Received: by 2002:a05:6000:4010:b0:3a4:bfda:1e9 with SMTP id
 ffacd0b85a97d-3a56877c2a9mr719191f8f.46.1749764573691; Thu, 12 Jun 2025
 14:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev> <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
 <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com> <9665f3b3-1c8e-4dae-b8df-c3147b119ff2@linux.dev>
In-Reply-To: <9665f3b3-1c8e-4dae-b8df-c3147b119ff2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 14:42:42 -0700
X-Gm-Features: AX0GCFvUGb9wKamUhkLdWzurQamh_zZnd_Yq6dVB6ngqmQdmravNuChyn2fkoGg
Message-ID: <CAADnVQL+xOejJySjwuL3X0M_Ysurwcuf5zRJq5K4E9CVMcq8gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm codes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:39=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 6/12/25 2:15 PM, Alexei Starovoitov wrote:
> > On Thu, Jun 12, 2025 at 12:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> >> On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:
> >>
> >> [...]
> >>
> >>>> Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
> >>>> llvm should probably accept 0xffffFFFFdeadbeef as imm32.
> >>> In llvm, the value is represented as an int64, we probably
> >>> can just check the upper 32bit must be 0 or 0xffffFFFF.
> >>> Otherwise, the value is out of range.
> >> I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
> >> rejecting things like 0x8000FFFFdeadbeef would require changes to the
> >> assembly parser to behave differently for literals of length 8 (signe
> >> extend them) and >8 (zero extend them), which might be surprising in
> >> some other ways.
> > Ok. So what's the summary?
> > No selftest changes needed and we add a check to llvm
> > to warn when upper 32 bits !=3D0 and !=3D 0xffffFFFF ?
>
> I did a little more checking, I think the value range
> in [INT_MIN, UINT_MAX] is what we want. This is also my v1 of
> llvm patch.

and that's buggy because it will reject 0xffffFFFFdeadbeef

> Support we have 64bit value, 0xffffFFFF00000001,
> truncating the top 32bit, it becomes 1 and this value 1
> won't be able to sign extension properly to 0xffffFFFF00000001.

well, yeah, 0xfff.. case should match 31-bit, of course.

