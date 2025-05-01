Return-Path: <bpf+bounces-57173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE61AA6797
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 01:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A086189BA61
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD95265626;
	Thu,  1 May 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsmo8Oov"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC533987
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143839; cv=none; b=okRHyjQAyRlswVzOy0wijwLLscxPTFkr3vkYsWrAUrm450Rfl4D1pEW5uV87NXlOp2hjAKrSDdu0c0NaI7LOYfawpV3cLgwVGKNqcwWB0i7ainmEKsB3pfF8NqsaUN3gS4WHcns7niPMPBXEjstWy+oX0e3JyWFWU0qctDEijKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143839; c=relaxed/simple;
	bh=yXLqclV2ePmFLjsqDI0mp6bA9aYxAlNtkG7OPn7nns8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2DMXqXwfxRTKVIvZrXlL3Ks/cGH7Fd3CoLpekHRVTSIOUwylQCObJe45dIDXaG5o49NKJwQOY6Saa119t2DN60nwk2rqfzetcEtp6MTZN85ESjutsLe8tH6Wz6m3RFdPHhMpmWBGMiaxxiJNfNDaZ6e/J34EAIeQpaY6mZmuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zsmo8Oov; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so1011115a12.0
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746143836; x=1746748636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xasm23hyK6mND8siq+Gd3ztHXg1FjfJ+qXQ+hxz3eYc=;
        b=Zsmo8OovLb0fmnmcNRklVYzdHduXAl+tYduPAaugRAPt7K7Mv1zJM+4xZUlHfBsgm/
         bsJG6mt0ZEvP4amdd3KX5O4/Jztm5S0vnBMTQktTzgjxUNm1BWSWSsCgmypjqZhF8uA7
         TjklWAeLO8HcKV26wEjDBZNJNI14y+u3cq94joYCLncjDJ2nQCYn2JBMM6aVpdrxRaA0
         Guimnj5EIXCAWelhxaQvZaeQ5i2Bf21k8fa5OM32vMfSrS5Og+a/XOusKdamhZFtUayq
         mghVFTvnckbdOyW4wA5WZsqfpbj3/OES4iqTLNT0xwNAl2z5RVENT+3cA5kSg1llJWL7
         A8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746143836; x=1746748636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xasm23hyK6mND8siq+Gd3ztHXg1FjfJ+qXQ+hxz3eYc=;
        b=Jm52Rr/W0cCThEFSDQ1c+h7aJ+lLJQQvhWsrTYf2HWkPiargRlD/Hxrm5OpycBr2dU
         jYe6YMLZGuYtOXDLDn1v71+1pyacLJw6xLhuDZWpA5J96TW8dpeLRA91N1GzsxNR0Lyi
         yxu1zgZSasnhwUiSzKawPCgCbJw/ASjRS0VtLwW/jxKwe4b4sqU8yK6wD16aYRnQKNMT
         uEIZeR2dXNUCzkqOK8XNyJfL/lgBkIv6ADUSLvfAEVFfy6doOYzMZ3fy5NeYNc7VITsS
         pg+Pt2i11FQV2QaQr4WpREsDwBLomM3gViNK8lTPg7VcD0DdWGNkdzW+Pd10UxHl0Y/s
         FUbg==
X-Gm-Message-State: AOJu0YxO3sa62Rtzvz8AvRR0bHRbCWw/oqHLJpz+eKcWbCb+NsRJ6tJr
	IJ0fVdnY8en+NKutG+2SPg0ctetOZFZ+Bt1LFJ9ZLYgfRXP1DLCQsOQhIl/2v5VErAxXDx7yXjb
	H2vuYpMdT0DvEZoiEaRgsmNJWMxc=
X-Gm-Gg: ASbGncuvir6UmEP63s1dvKBXWdWaTI8QFFiVpBjnb7AGoKk5zD4wkbx8UYOBf7NAEw9
	bQDIIGI5A3CtAm+GnG4989u/xUsxs1hvdwLq360TMgzSn+3bVHTrRZrzbqoafXybXPEXHh7OMS6
	YGDVbAnePdsjtsuBHskwGaMLcpkmgcouakJJoHYyDx9iFaGLcA
X-Google-Smtp-Source: AGHT+IHtOfhQJXTccKdseAtqbz8Gj+3GXMv9u9ox6fkqmyZ2XyKoS5ugjD15XXTlc7I8D1IrN029mR73SwDmYhfmmHw=
X-Received: by 2002:a17:90b:5211:b0:2ff:6e72:b8e2 with SMTP id
 98e67ed59e1d1-30a4e67f6eemr1315819a91.31.1746143836292; Thu, 01 May 2025
 16:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501235231.1339822-1-andrii@kernel.org>
In-Reply-To: <20250501235231.1339822-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 16:57:01 -0700
X-Gm-Features: ATxdqUHGxLKVG3HrKabIGlhJY5SGhnzaiDIRMS3692Nwl8b319EAEqOLj2O7On0
Message-ID: <CAEf4BzbesQJq9UNpQ5O3z_66E4c=WnRXjZJDYqVaFtjbKWxk9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 4:52=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> BTF dedup has a strong assumption that compiler with deduplicate identica=
l
> types within any given compilation unit (i.e., .c file). This property
> is used when establishing equilvalence of two subgraphs of types.
>
> Unfortunately, this property doesn't always holds in practice. We've
> seen cases of having truly identical structs, unions, array definitions,
> and, most recently, even pointers to the same type being duplicated
> within CU.
>
> Previously, we mitigated this on a case-by-case basis, adding a few
> simple heuristics for validating that two BTF types (having two
> different type IDs) are structurally the same. But this approach scales
> poorly, and we can have more weird cases come up in the future.
>
> So let's take a half-step back, and implement a bit more generic
> structural equivalence check, recursively. We still limit it to
> reasonable depth to avoid long reference loops. Depth-wise limiting of
> potentially cyclical graph isn't great, but as I mentioned below doesn't
> seem to be detrimental performance-wise. We can always improve this in
> the future with per-type visited markers, if necessary.
>
> Performance-wise this doesn't seem too affect vmlinux BTF dedup, which
> makes sense because this logic kicks in not so frequently and only if we
> already established a canonical candidate type match, but suddenly find
> a different (but probably identical) type.
>
> On the other hand, this seems to help to reduce duplication across many
> kernel modules. In my local test, I had 639 kernel module built. Overall
> .BTF sections size goes down from 41MB bytes down to 5MB (!), which is

Forgot to mention that vmlinux BTF size itself didn't change at all.

> pretty impressive for such a straightforward piece of logic added. But
> it would be nice to validate independently just in case my bash and
> Python-fu is broken.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 137 ++++++++++++++++++++++++++++----------------
>  1 file changed, 89 insertions(+), 48 deletions(-)
>

[...]

