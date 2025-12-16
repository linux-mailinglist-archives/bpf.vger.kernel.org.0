Return-Path: <bpf+bounces-76721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E577ACC46F3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C41753020DD3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245A635965;
	Tue, 16 Dec 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFwqTmBO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805422A4F1
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903943; cv=none; b=qdBtTxRWe12pkKRktWGp6aVvJ6NHJGiInwJFg06WzaZn9aWLhZM1oaIlxff1Yn3pIWM/E7GfcKIZeMu02nU86l3mcNzgPPwLhBENbvhezK92YJILI40lv6ui0jhp/dQXoGCqRlKt2VH7jX8VngbNJjgxTUZ0PX6cTj9HcJPNuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903943; c=relaxed/simple;
	bh=p+mwzo4LW6TjNymtRc5flAr6xEszu3AaaQbrS94a8Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntv/VYDwkUnq+AvnSFUoZJ9D4XyIBD/0T+RxdVELu0JpF9E+Yu57cI8o48gKESEyxfFIKx/qekyfc7evudKAKf0YDjS5FJOz9Fx902sFGcVvSXrGYAPZLY9gUOoVrLYJOiw+bQUZlOzrMgfNyYkCHSo40Ey64+5v7hEDnRW70tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFwqTmBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69848C4AF09
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903942;
	bh=p+mwzo4LW6TjNymtRc5flAr6xEszu3AaaQbrS94a8Mk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tFwqTmBOp64LTC22z87SodJ2FaPcZNnkA1Ws59kobNRFW+wawKffH65/pQviAlSg9
	 r3wPNAHYQ74Obcc1yIM/og4I6OcYWEjZ9bdSj4ZCy8WSrQIuvXeOCZ6zMD7ZDmS0mp
	 c0oXKYdIiOcUjKEvGhvkWAk6QbutEjp+/Hp8jH5hj5wRgh5ehhbVQ31yhthpWzKyCD
	 DOXLgFhNgU0cr5cC3wE6oJKSeBDWFluT2rWD2Jfn2hRZNNmI78ZN3XQz1Iy51wfS50
	 plJXsCaCFbCpnJShhTnSANdhecvRVj/yyl0/KwvXOqxttTKI8XiqSPoP5F+yvAKBch
	 m4cTBs5jxfCQw==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8887ac841e2so38971026d6.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 08:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFm1cyOG6PMYeNTW1b8URkvBrUSjiFdkppmGdf/A8yZ1GX/EwX2UpO0nmegusJKcvuoNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNQ2FRB0sqCK07VMxIKjenlyfsB6UqQ+Io7q0HHGI4rj2P7Gj
	WhDXktQeU+KwIFTmgfFp7R3i0c23kW/9mb+Km+G0Ld+P7DU2Jtes7lzwOA42PCSoBXQhhq6kElS
	hAtiOi9J74tcDGdkFWx08BQ7Jg/0VqHQ=
X-Google-Smtp-Source: AGHT+IFKJlJWpAYiYlV34dtBN9MYhhWlCzslRmXjeVal8tjgtg4C8vB2wSS7RHv2fb44UYWa2J0Xwm+WUoG5toJgfq8=
X-Received: by 2002:a05:6214:766:b0:88a:4694:5922 with SMTP id
 6a1803df08f44-88a4694595cmr42944206d6.23.1765903941606; Tue, 16 Dec 2025
 08:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
 <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
 <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
 <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com> <af630740-eada-4a2b-8846-3d1a17f198f4@oracle.com>
In-Reply-To: <af630740-eada-4a2b-8846-3d1a17f198f4@oracle.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 01:52:10 +0900
X-Gmail-Original-Message-ID: <CAPhsuW5P7Ska9e+vWt3emuW8m5PXbbzmNsFT3Gj_VhrUSkrozQ@mail.gmail.com>
X-Gm-Features: AQt7F2riW2ihlcbeMdqPzjWHi1woLPO9eJNLv8ida8VrtIeFLBRyMRtj0mgWXGA
Message-ID: <CAPhsuW5P7Ska9e+vWt3emuW8m5PXbbzmNsFT3Gj_VhrUSkrozQ@mail.gmail.com>
Subject: Re: fms-extensions and bpf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 5:08=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
[...]
> i.e. the embedded struct ns_tree is anonymized.
>
> So we end up preserving type access, size etc; the only thing missing is
> the name for the nested "struct ns_tree". We could add an option to bpfto=
ol
> to relax this restriction if needed for users specifying -fms-extension.
>
> Not sure though if this might create any issues for CO-RE accesses to the
> fields? i.e. does the fact that the vmlinux.h representation diverges fro=
m
> the actual BTF have any subtle implications? I don't think so but just in=
 case..
>
> I have a working patch for the above which I can send out if it sounds li=
ke the
> right approach. Thanks!

This feels like the best option to keep backward compatibility. Please send
the patch so we can test and discuss more.

Thanks,
Song

