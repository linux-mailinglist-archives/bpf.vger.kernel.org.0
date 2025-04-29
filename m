Return-Path: <bpf+bounces-57009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A43AA3E96
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C0A4A7AD1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB1231857;
	Tue, 29 Apr 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrj/4LtP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2B1D7E35;
	Tue, 29 Apr 2025 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971114; cv=none; b=mkWTltIZ3nPEyd3E4Xh4FxWZUkervu4Hv7eA0Db0/EEfl1ZRNGAcWmyDn4yCWoKlTT3n27Q1e0axz+cHuS1IQ0yRyeByT1g6OWa3en7jwmdCSPL+GyS37p27PMVyjqMj/A1EpEJDa0ybmjFHbGpWgrta6F7ujENyQsCovBO9Mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971114; c=relaxed/simple;
	bh=iqnTYDmiTjRgfK3u/aUrzt5/5Q+gPJ2f+omyQFghhuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0ldEl3qL7nvUnj18moVyRzD8mB0DSYWCghtaCnUWz2v9RJBKhIVbgaX4q7Hcd0yYxWqlF20PvggchQNOhfxGce09fTuvWMaLaBNdmISID/CVM74H8AE/g6CdWMTYINNnNrIXzdJEqVK4h+P6VqfI1SXfHOxBxnegIZE9BeLOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrj/4LtP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efc457bso4844991f8f.2;
        Tue, 29 Apr 2025 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745971111; x=1746575911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlOXSV/LS6Wq6Zi28K/GY5AymAcLPtqx1WKW0bjot14=;
        b=mrj/4LtPC304ulZBqFMmNUUbwiP0G0DsVAF/RH4Kj2DbMv43xKwQpOZ7pM4zt702IX
         Sgbd0yr0yV6wSzccj5XgXibNQfsJ8KmQK3wjwteDbZr3gvhonS/ocnhOeTRhT9luTeqT
         Rb1kbUYCu+H6u+wm/ivO6iMYrjbJoq24FBeX7X6QG3y0ZLHrc9w3pV3uhLUktzpsjLe2
         XVBZjTAI8KJy/G17NzDTbEWB7TpeWZPnvQMgbF0Ex6vy0o3vujn+WlUAo5lOjCVUcUjC
         /g86gtQj6cLKwjFMcD3wbLVfk8H0XfiDvhCwq+s1U9sa9CyeP194B7bn1nQQ6X/uufV4
         wd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971111; x=1746575911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlOXSV/LS6Wq6Zi28K/GY5AymAcLPtqx1WKW0bjot14=;
        b=pKe+LZN6DlsoxOqAercpIMTvk2aipkQHT+K8p62TOg8LCqUFjXYr0b+ckuw7S9jNVD
         ReLo231bK8K9xW01Lh8LhnEsaQLO3DxgTajrIEBokm1355IBbmG4yQN3QoORrOdloH7U
         1d85zwC5gGAj3P98wc57/DXpBRTx9AsXw+H47vNQSlj0lqG6nbitlo2vyXwhU6bZqTpz
         Hy3F3sLFCTFMO0klpGgcnraXOtndiIPFoKNMOhcdPDR/7Kgf/r8rrdNOCOLfFzDWav3P
         VEizhmCK7r/vAXRv5xlKNpGCl1eGlJwuuzHSkbvej2dIoxYffmEdqiGbN8/C5TfmANd0
         T/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG4DKHSS52WFAkgj7N3e3iiCt7qU97xF4iWXTgS38vQ6Ij2TOVOpBDAMAYJui5RQxhybk=@vger.kernel.org, AJvYcCUpiNeemyAzqPiNtF7TtMD12+ygSgwM5jpJuiKUw18B6pkAaMQ+yxfnnS7MnxLyFkqxxytoLYz5FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsjeJSAKhxgKZIEL/HedpepLoL2ZWHnwPL2TIRxb0+Ohmi6MF
	rdp11k8jH6JE37aoEJD5jfyvHGaVYjkXJGRXO759NSKUKgGyBhs2mK6GpC8aY0IeG+kMCI/SMsW
	MczdKdZcOlRJQ/NQJkMmk66Uicc4=
X-Gm-Gg: ASbGnct0c6M4BagOo0vXokydjSwN7CdZJsLb99n314uAlLO4BpSCGU4bJSbmiKVQcP9
	84QUzYYzFaitoWy6JinhrBKd/MVLMYnou5pgfqecQIZQIWg3R6/yOmlKA3RgH6AOleG3rthYFe1
	jN7f68jomadzRPnaYiJmlziiJmR7bLSXyxQK+Dhb7vh8eVf8Qy
X-Google-Smtp-Source: AGHT+IGyHp8MouUJrcf0MLECDO1OlQtEeiMDNr4s8n4KnB0vT3uHxvxC4sUSNMZLjL9sGl8MKGcrJkP70xSXpIGGyuk=
X-Received: by 2002:a05:6000:1844:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-3a08ff34cb5mr269882f8f.5.1745971111023; Tue, 29 Apr 2025
 16:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <fcjioco2rdnrupme4gixd4vynh52paudcc7br7smqhmdhdr4js@5uolobs4ycsi>
 <CAADnVQJ1y1ktKDgORynENQLC73FZ162XXL2qMSshpb2gKXHBjw@mail.gmail.com> <D250DE71-922F-44B3-A123-9AFFBDC8051C@meta.com>
In-Reply-To: <D250DE71-922F-44B3-A123-9AFFBDC8051C@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 16:58:19 -0700
X-Gm-Features: ATxdqUGs0YtR9SphoYkAC395_OdAmP0hUasPd8l7SBgw_omBhzum-NRYB62o-V8
Message-ID: <CAADnVQLseJTeYWGCU6o7L6Rb_NdymAPfg-_nMuZhwx077YfmKw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Thierry Treyer <ttreyer@meta.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Song Liu <songliubraving@meta.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Mykola Lysenko <mykolal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:14=E2=80=AFPM Thierry Treyer <ttreyer@meta.com> =
wrote:
>
> > It looks to me we only need:
> > - register
> > - load_from_reg_plus_offset
> > - constant
>
> In that case, we can shorten the list of operators:
>
> ### | Operator Name          | Operands[...]
> ----+------------------------+-------------------------------------------
>   1 | LOC_SIGNED_CONST_1     |  s8: constant's value
>   2 | LOC_SIGNED_CONST_2     | s16: constant's value
>   3 | LOC_SIGNED_CONST_4     | s32: constant's value
>   4 | LOC_SIGNED_CONST_8     | s64: constant's value
>   5 | LOC_UNSIGNED_CONST_1   |  u8: constant's value
>   6 | LOC_UNSIGNED_CONST_2   | u16: constant's value
>   7 | LOC_UNSIGNED_CONST_4   | u32: constant's value
>   8 | LOC_UNSIGNED_CONST_8   | u64: constant's value
>   9 | LOC_REGISTER           |  u8: DWARF register number from the ABI
>  10 | LOC_REGISTER_OFFSET    |  u8: DWARF register number from the ABI
>                              | s64: offset added to the register's value

Since we want to make the format compat let's use s32 for offset.
We can even consider s16.
Since that's typically stack and kernel stack is rarely above 2k.

>
> > register vs register_offset is another artifact of dwarf.
> > ...
> > - load_from_reg_plus_offset
>
> What is the difference between LOC_REGISTER_OFFSET
> and load_from_reg_plus_offset?

Just a different name, because LOC_REGISTER_OFFSET is confusing.
LOC_REGISTER means that the value of the argument is in that register.
LOC_REGISTER_OFFSET can be interpreted that the argument value
is in the register plus constant.
But that's not the case. reg+const is an address in memory when
value is stored.
So we need a different name.
Probably load_from_reg_plus_offset is confusing too.
How about
LOC_ADDR_REGISTER_OFFSET

