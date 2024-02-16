Return-Path: <bpf+bounces-22144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94821857C3F
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 13:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0162845F7
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017AA7869F;
	Fri, 16 Feb 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUleLgpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872778694
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084958; cv=none; b=a0OG//BLjEmgTw/O8yFTR1/E/d3Hvg385CGzvApSxuwDHU16BRDoljHxRIIOcVLJKJjI5Ww/qCcy4CybjTuy8XrFEHrcTUJ+Ug3OZNyC/85X7MgYoDitLvg5ralb5UciP3j7AZcKaEdY3oIfkKjxGofG5nafWhz7vp9gsOHaPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084958; c=relaxed/simple;
	bh=PmmwG61p0wPJ2VRQio0BFXYZuwohfEaxJS22XPMVhfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nv7QwAqlmbcKgII58qirBus/kBtm8iXQGVSrr/dUM2uY5s29XhJ74EkPPjCLBQF1sdTH19JH6uWieIM7JGKpSztDbtHfyTxA0tayrEyLbYMTsVFug2NPyR12XkPITiuQ7lVgeEFs/wbAPOG5aJOJ47u/WbZ3Z67O2cVKC5V9DHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUleLgpa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563a6656c46so3017458a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708084955; x=1708689755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtXqNbW9XxidIOzd2qMeWuk4ehmWW5nz70QIPAPyLYA=;
        b=TUleLgpa34FxI6bHiTsd8xNBEeXB1P1I4JA5ILFNTkQF7g/RQL86sh8NIB7YVShNL9
         0XmjclpBuEudf1lY6JM5p/fHsv4c7ZnK8S8QukpOcATpIthpfY9rxLjUmFQMGK7TWLUr
         dXGvwVY4a0xHCB6YeW0JQo8zMolqi7gqGHdzMfXw/DrlqFamcgoYPfALUNP6iyV1X4AW
         sYGrto6i9j+qIe3ratVKWmT68A6BMwGQkq1e+5JfeBZ9uj0sMhqE2eqgUXAyESFJjjOG
         VhrhB9KwefXY/vqUzcgZk6VvE+mq1qs3FlePq7t9HokST1T4YZowLLZIM47UwpJ+IGFH
         0how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708084955; x=1708689755;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtXqNbW9XxidIOzd2qMeWuk4ehmWW5nz70QIPAPyLYA=;
        b=xE+pkE6kPRSiZxloH3N8dtAN3fWWSLAIOnLcz1mdSjLv6Xmr2X/8BiyvfM7e1A55zp
         wFJTYbPbfklAdIxKJPvSAXdAZusMhDq+PLX0hChzRIriommbw22zn/XUbrwieM5n1WYC
         J7EIokWP0lcAqkxIrEqi6kT2Z5rIBpLsiiDE/56g3kF9uYxCvr/TptDYCz9hWFPRLQs0
         JrCBPUODnc1Hf+wjwbDjPewMpOvM4iHOBBwXomAJaNQS5561+wJSA5KEz61itsey233L
         YqmxHdL25VuexEpYra9lCoj6AKtV4oOKsA4AMFaaSAKTr4mFbEyinIpKVc9M8FP979+0
         hPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVvQqdIM18h10LoCvEuM0Xx6Vjl5sP7MKfEUhVe4Bw3Y+SQ8yTO4R8/IPDJKbr1ndgJZZdLUCutYzVI+I7qJwCtaKyk
X-Gm-Message-State: AOJu0YxFQgjTboVEODjjvosBxDVyt9JeO04DKjbNWxE30ziOPtso301w
	K9k+lDqUYveMLrkzhQcJgIpBouBWbLkc24tcRC/+DKbgqXdojWxa
X-Google-Smtp-Source: AGHT+IEjt3Na3acfRmiufEUFkl7QXFSQRsDEhUkaKiMxCI5Z9x0nyjc9Ga82CIm+72rQx/yNP50n6g==
X-Received: by 2002:a05:6402:542:b0:564:cb6:50a2 with SMTP id i2-20020a056402054200b005640cb650a2mr23583edx.23.1708084954888;
        Fri, 16 Feb 2024 04:02:34 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402501100b0055c60ba9640sm1436448eda.77.2024.02.16.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:02:34 -0800 (PST)
Message-ID: <4c3b58902d28550551c61a2a001d3ec54beac65d.camel@gmail.com>
Subject: Re: [RFC PATCH v1 10/14] bpf, x86: Implement runtime resource
 cleanup for exceptions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 14:02:32 +0200
In-Reply-To: <20240201042109.1150490-11-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-11-memxor@gmail.com>
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

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:

[...]

> +int bpf_cleanup_resource_reg(struct bpf_frame_desc_reg_entry *fd, void *=
ptr)
> +{

Question:
Maybe I missed something in frame descriptor construction process,
but it appears like there is nothing guarding against double cleanup.
E.g. consider a program like below:

   r6 =3D ... PTR_TO_SOCKET ...
   r7 =3D r6
   *(u64 *)(r10 - 16) =3D r6
   call bpf_throw()

Would bpf_cleanup_resource_reg() be called for all r6, r7 and fp[-16],
thus executing destructor for the same object multiple times?

> +	u64 reg_value =3D ptr ? *(u64 *)ptr : 0;
> +	struct btf_struct_meta *meta;
> +	const struct btf_type *t;
> +	u32 dtor_id;
> +
> +	switch (fd->type) {
> +	case PTR_TO_SOCKET:
> +	case PTR_TO_TCP_SOCK:
> +	case PTR_TO_SOCK_COMMON:
> +		if (reg_value)
> +			bpf_sk_release_dtor((void *)reg_value);
> +		return 0;

[...]

