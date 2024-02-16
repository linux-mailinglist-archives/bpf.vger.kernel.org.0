Return-Path: <bpf+bounces-22145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3D857C74
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FAB1C2254A
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9A78B47;
	Fri, 16 Feb 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAQzC+Ej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDD2CCB4
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086089; cv=none; b=QcMsIiQODpiz+8WfT0Z7PbsBU241V0lhbF9GU/K8V4PBgr+U04lRIQ8R8XgAmgjrTRbd301PBVemJj5sBdI+QOw7NpxG89TqIaD6r/yozTAiwVvybWK0csrmm1rgcbO0nUpQrtMABaGyt21k9Py4n2Acc+QfI0/K3xPVRI9e+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086089; c=relaxed/simple;
	bh=pgj0J2urv+q58xWVfT8iIHFMGjCuAbXlCAmwKxxAkmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XUrSD2i0Rx6bj8fRIxaUiaITIQxc4+T6nxgzyl1PcynOyk0AyHM0sW7yRWyL4ey+BHd68eg2VfQ5xlUikm/D66YP4uLYhrC6B9Z1RJ7DLXMYJFnLSCHmldH2tGM3xUnYCpLgMvK0s4TWyeARhu1NCbDXPesHbCHIp3XmMxh6U8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAQzC+Ej; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d094bc2244so25429131fa.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 04:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708086086; x=1708690886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgj0J2urv+q58xWVfT8iIHFMGjCuAbXlCAmwKxxAkmA=;
        b=SAQzC+EjtF5fNGzJ5GAAsdHuu0e+5Sx5Q3UrIzPBBqujiL8mgDLd3s0+m8whH7p+TG
         UQ+1/Jl3LS/fkR4qB4gbwCKW1t2BlJwFfwVcWzKVrw7dTwa6lwJAilCTjs5p442x4GgE
         j9oHQu+40tihOlOBZjYgDDQFhqci4KchGv1FaLqslciinWm6Ep9WP9lGwnlgT+LpmgjC
         Nh/0KbAfsda2a3u34AVgtg6KhyNVyrGElctxLT/tQtH4fACzcCy/SXjUedMYHDfX6eEf
         mLYVOXHBubc4Me7gkQwm2v9H9ea6sQSNXCZrFNWj6DOdZws0JP6dpQ0d2VVF2TIDnbTf
         C/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708086086; x=1708690886;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgj0J2urv+q58xWVfT8iIHFMGjCuAbXlCAmwKxxAkmA=;
        b=kcvEXZuvQEWc1+UFLq8LPSYv9IT7byVee1OjU9+p5h3jY1WPEZNFwQlP8+huv6teJw
         zyOKROw1e9ia5KIqdEwNPY+cugZZfwAIWsJQ5n8x7J7/ynZzAYMJFGeTNUY+q0UeOJH1
         YG3wVXScFrvGfxfO4cdBmpoCXdrPxTOjjoMAThh/8ffVz/HiYNF8nuLrtzI28zCxMWHw
         WcrxUIKP6qP6gkAV3Azov0gGnLMTdBRLTBfa2Hk2n0DC7r0cPaup+O/hVH3eUyFNQlEq
         zzkbw2JCoum59v6drhXwbNtXWAyCenhmocz0sgsCTM4lw/hjzF1Xt4KVWiRr6iwW+dvD
         0CsA==
X-Forwarded-Encrypted: i=1; AJvYcCXx9BnKO2WhuO4NY7FixNd1CJpeRStAO/SXPUZqqO/YaiFkwFsHXT+Gb/3/4jJh6t1AytOcvObzOAP78lSt+FAM1En8
X-Gm-Message-State: AOJu0YyAB7s8RDdGO4pNVaWKO7ZsAx3fsx5+F0jBOo2tMICp2UCTU7xj
	FWFk7uATZDHChOmyDpgAN99Vj4SMeZbGcB6tv4WdjwGJEg9m1N2v
X-Google-Smtp-Source: AGHT+IFkDLXBLtGXJJGxLs2R/50g91NkjLhaTcctQut7y4BdufhGQY4JkFZt0JY09Ak3UHeVARsVNA==
X-Received: by 2002:a05:6512:488b:b0:511:86c0:dad2 with SMTP id eq11-20020a056512488b00b0051186c0dad2mr3356393lfb.62.1708086085765;
        Fri, 16 Feb 2024 04:21:25 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id nb16-20020a1709071c9000b00a3ce8093f6esm1511802ejc.179.2024.02.16.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:21:25 -0800 (PST)
Message-ID: <3cdf91559113af0a707e20e6650eaff5168f305e.camel@gmail.com>
Subject: Re: [RFC PATCH v1 11/14] bpf: Release references in verifier state
 when throwing exceptions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 14:21:24 +0200
In-Reply-To: <20240201042109.1150490-12-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-12-memxor@gmail.com>
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
> Reflect in the verifier state that references would be released whenever
> we throw a BPF exception. Now that we support generating frame
> descriptors, and performing the runtime cleanup, whenever processing an
> entry corresponding to an acquired reference, make sure we release its
> reference state. Note that we only release this state for the current
> frame, as the acquired refs are only checked against that when
> processing an exceptional exit.
>=20
> This would ensure that for acquired resources apart from locks and RCU
> read sections, BPF programs never fail in case of lingering resources
> during verification.
>=20
> While at it, we can tweak check_reference_leak to drop the
> exception_exit parameter, and fix selftests that will fail due to the
> changed behaviour.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

