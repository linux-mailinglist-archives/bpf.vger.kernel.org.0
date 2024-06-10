Return-Path: <bpf+bounces-31743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A19029FB
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CE41F220D2
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF5210E7;
	Mon, 10 Jun 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaA00p56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26506101E2
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051476; cv=none; b=r0V+5/mOsoh6CyMI7VNh5ffjShzYEDTBLKLEIkoXC+GGihdOR2fNjYJGdR4EVrqYQmXOVjexMfL4pxYMpQyz/eLoLUjqSO3tiQ8U1h6TAb9RQgnQt9uhhLLBY46xwB8SuFWot+F8ZaUHbtcLAJSG5HkthPldHBsDUwlwbz1na40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051476; c=relaxed/simple;
	bh=3yO71ob0N39fjW36VUdQKK2d5CMIRVndMpEZrZwOUAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cng0hYPAbFZmDQbjgH/heRixAUqDjczS3J8YjPdqf0pxUQLx7yhTGklEIjyO9RT6pVKmN33Vj+Q/M8BOeLt9m9tPeCzcDFbsGtld2MfhfjtqL4UIyHfTqWddjFnwcDDL+7NIheVMwi4T5Jhrvgynkuo23qg05uTwo3rmh/3wpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaA00p56; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso3903891fa.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718051473; x=1718656273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVNbNeOkayfE5gSM5h4N5u1GNbMcd57LP+MjhPMyeH4=;
        b=SaA00p56DNvEZk/wnb0bC4z+HDpJuORZSzw0JNA081qhhe82Oo0vUCvrLDUpVEbNfM
         allX6qosixV6MiTMZTh6Ip2eyEsz3WMUJkbTlt7eBI36y1TKVTFwqV8vZhO9UgUi1Hl3
         6kIoRYNmxTXi6c+LxRqemzRQkkPlqmEnoMAJwuI3aNi4fONnpXDVU9WUiZwUhC4McHIw
         jHinQLB8WI90s7aU70SnyeK6FDNs+IOgMH6lnVWSfm8EsM5//l+zfwvJWhFa96yBi7Oe
         i6j9/jMkFrefjlrozQeb0eppw1Cv0HL/6y7rf7rZLhIXxK374cV3aPTy3Q9doJQjKLz4
         eCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051473; x=1718656273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVNbNeOkayfE5gSM5h4N5u1GNbMcd57LP+MjhPMyeH4=;
        b=KcbKLrSN9dPApQkEgxzOvv2tM++K1OEUIXAEcDVsagAAuo7uriVYYArFoXkVKy0Nwy
         BBSkqIag5EV7UH2+Wyf0hnj9u6fe2E9X9VbrdGScdbcsL6eSUYk5/Bczkq8FArfbjCtx
         RrDMsQiTvoFTJe0P3WvIOfHLQiX3mORrzFiYv0BD4kQFKZY+RGhVecz/AxU4BlnXPVt9
         dyTAn8SNbfuiW8+gJ1c6cjwzkk7TKsjm4LzN2jeovgiZhBfsVtbhDBjLGj/VgNxYq2N8
         zxdCSvGqbxcR5Pss/3kUwjnvl6SMcW3+z+wNwgiIMjh3pLdSkcGDaQQLFAYqyNIVCPmB
         rfkQ==
X-Gm-Message-State: AOJu0Yw780RFb+jtk5CEKz/LICb80S1HIgeDyxsKZoi8A6U5C6K6DDeY
	M0DOK2aETIIM/GFBu+Heql1Inv2Yjxg3hLyhtY7imvdYMldgyHd6IEVUGgHAOzOUnBYGlzDYUSq
	E3cn9AcZ/6pxTzbkIERJ44w+Tmzg=
X-Google-Smtp-Source: AGHT+IEyACBxo+ZQer2JqWq7rB7tCTYO2zIghoB3ha8CrUcLJ2rtWuoZAqWnnmMGADlURu+hEyiqDRPAx6rXAt+p5eI=
X-Received: by 2002:a05:651c:231:b0:2eb:e25a:34e5 with SMTP id
 38308e7fff4ca-2ebe25a3646mr24531391fa.34.1718051472870; Mon, 10 Jun 2024
 13:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
 <20240608004446.54199-3-alexei.starovoitov@gmail.com> <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
 <53a25fb040cdda5b794a5f1f5f6ddb73571df837.camel@gmail.com>
In-Reply-To: <53a25fb040cdda5b794a5f1f5f6ddb73571df837.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 13:31:01 -0700
Message-ID: <CAADnVQLEGMvA_hNDZ4F-_ZBdbBR=ZYKmQ7cNayLOrYg2GSRJxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked" registers.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:56=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Also note that mark_precise_scalar_ids() needs to be updated
> to use mask for ->id extraction.
> (Although, that function is broken and I should spill out
>  v2 of the patch-set that removes it asap).

Ahh. Right.

I've used
 #define BPF_ADD_CONST (1U << 31)
instead of
 u32 id:31;
 u32 add_const:1;

to make sure that all ID comparisons in the rest of the verifier
are using both id and flag together and idmap stays as-is.

I missed mark_precise_scalar_ids() that needs to match
what find_equal_scalars() is doing.

What's broken in there?

