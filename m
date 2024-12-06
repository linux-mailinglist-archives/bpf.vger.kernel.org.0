Return-Path: <bpf+bounces-46325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1819E7A24
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 21:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CE31672E8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41041FFC73;
	Fri,  6 Dec 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx4uj7QK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B61C54AF
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517827; cv=none; b=CLZrTE9IONiBIPoSOCpBGGUCm+xeiBC37a0EjZzakZUFMmXnDYB4wlzASAtZANVN6Ce9xs0g8OxbJ5/q42uSYb1IH1CvAuor9EM0EtPZsmvX2S+YYhsEUVmM+ASepgOTJ04Fzsvsf+uvOWA/9JYdwYivjVJq6eAMRx2OJh8eZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517827; c=relaxed/simple;
	bh=kXeCcEX1DXiFjuOHOIwfqmuVYlgRfQ7zjPV1Sv4n6bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paJCyeoNsGD9f0k7qjwVpOIYP3I+j0hdDjq4+51pY9HVlAvokTsDF1XEihYO3AYI0QP/4MKba5JG9GEeo+SV2Hr3v/1qH74vKniuAsQH3EOMavz2BKwiJBGCS2NQoGdxIGlE3xdX6/vV/VGYedcyl6O9Jiil9biRF6cW5jDCYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx4uj7QK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so1358840f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517824; x=1734122624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQt1rBcIHPhEPzbPUlIRhHHkqMbKMgHqZ+Uf3Ly9w/Q=;
        b=Qx4uj7QKQrZrDNAiJn9PDrFdzpDIILwlD6mKZYIuhJwJwi+s04S+q6X9BNJ7QQh1N4
         oDk+8QANaDl5vcFbLvSU1589cTMVCuItmhkLL4yrKRK9RV5cIYBlmHhhPDvbHJHyDvqm
         J3KXnL9q+4G0TquIhIYv20FI5C8EYdNGMXG0oguEsYaO/0YQILkDT2si/iYnUHL9Docw
         8+5XYnDiszojh0pk1+Y/5dmzcpPS+OXEwrSUpmRvsUjWJvFnqr3/hs5qcYOnlA/27r+H
         7WQkVriW9ZdKC9DYEnP7C8NFryhFTVzryJSoqHVTBWMyxUjP9iftASbs/18dHRWuFH+T
         yKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517824; x=1734122624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQt1rBcIHPhEPzbPUlIRhHHkqMbKMgHqZ+Uf3Ly9w/Q=;
        b=jn9K70WwI1l0XPnz26Tte14qU5XAb3UDySVPRNtTFt8aLC6EoUvb5SjEo+5GDfesJl
         Y2VUHSnhdHP1Lz4WsIthNnwnbsAhe5OhG+5hSsz/mvylHCw1BGUJPaBDCWydPXTulXvH
         0wv3zJKr4FRrdke3biVG09EG7Ipzh1SesmklJCCYjnEA89gWzr1Bfd6579IMcO/ZoFdZ
         5vqP0NViBr8b0aTPgJjEtWtvsTkxK8nqTJOIszko0BuGN4NEI1PxXsjhOccOHzYEDrDJ
         F6vGw3UEaUexHTIn6TQGQmmqBczLbY44EBVmuKc4DXHFEIObOjRvuEbzfhgTaREUqurO
         k5Og==
X-Gm-Message-State: AOJu0Yx7vtX83TzDibTsD57g8Br2N9pd9MLqo4loIedKYja110cXUfWK
	xIJlgV6yXOSkW5yK4KmWvoB4eu6Xp9jJpFJpkF5+tovgNpi70JeKMAbuvX+4U/ucZHLzyqUljOB
	IUKqLBAVC1HhGUcJm0G0DXU/32sVxk9x+
X-Gm-Gg: ASbGncu5KO4XFtera6HuXIHsoywd4G4ODiV02lfXPQ1i8cBIzZzCjkOMSDJB57eaPmj
	tanL1apPivq0ewWOUr4PHD6lfUa64j8F+baHEdEZdEm2Tkis=
X-Google-Smtp-Source: AGHT+IFUeCLxsZKVmkxP+dBl1Bnvxf+3nKMWld+++oa6sTvyzvGo+V6t3iJJ8aB1O4cjqca6N3TieIuAkzhofMxAE1w=
X-Received: by 2002:a05:6000:1543:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-3862b3d09c9mr2849024f8f.46.1733517823826; Fri, 06 Dec 2024
 12:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206040307.568065-1-eddyz87@gmail.com> <20241206040307.568065-4-eddyz87@gmail.com>
In-Reply-To: <20241206040307.568065-4-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 12:43:32 -0800
Message-ID: <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global functions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f4290c179bee..48b7b2eeb7e2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -659,6 +659,7 @@ struct bpf_subprog_info {
>         bool args_cached: 1;
>         /* true if bpf_fastcall stack region is used by functions that ca=
n't be inlined */
>         bool keep_fastcall_stack: 1;
> +       bool changes_pkt_data: 1;

since freplace was brought up in the other thread.
Let's fix it all in one patch.
I think propagating changes_pkt_data flag into prog_aux and
into map->owner should do it.
The handling will be similar to existing xdp_has_frags.

Otherwise tail_call from static subprog will have the same issue.
xdp_has_frags compatibility requires equality. All progs either
have it or don't.
changes_pkt_data flag doesn't need to be that strict:
A prog with changes_pkt_data can be freplaced by prog without
and tailcall into prog without it.
But not the other way around.

