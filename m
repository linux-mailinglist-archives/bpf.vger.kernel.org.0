Return-Path: <bpf+bounces-72367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D8C11481
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 408D43522BE
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2230BB85;
	Mon, 27 Oct 2025 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkV0gjLe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AC2DCF46
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594976; cv=none; b=sVIIKG+pu67B5ZIV3rB9q/TWHORpmVBezmy/KHVDvwlREURDcOhDk5C/83h+Sdfy2s3YOFGRmiTkIKLxG/OuAXy8D+B26pkIDjS6e1gNiwcqlfOgfPRIiFPAVeGsHFO3MunBiwglGPdlscApvu+fTH7LcC+Q2j7hPB2sv4P/Nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594976; c=relaxed/simple;
	bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByqxUq77p08uCBR9aWfQ9UY/FFOH/+CpB9OvpEpJaaZcSRHKybQstDuE/j3qxnpjcRc19fb+f6ISAyww5OSnDQifLmNRbpdm83cLPqiFNJlhzUWE7CHPv93RVOVZmDSbpV1xr/B7T7Hy/YHjMZkNbW+DBNRcNxXYNNswpdXZiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkV0gjLe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bca51so4724705f8f.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594973; x=1762199773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
        b=TkV0gjLePAiR9NVnGk0Ebkp8ltL6D1pW8xT3+0GVNZnMCEvF8UbggHtCA7+hVU/KWT
         wCc+CeNX9Nb4sZ45MID5qYrtTlePJS0XJjl/N6oobWa/8nCD+CAqhTzmlf/Hg/aiu14a
         jx85C2CNleixLgywFw4Z3U1iO8440DPa8cWR94M13lfX+1qvMLPZq2eqh9CMF9mpz2cI
         1E5TuBD8EZoS3wuUglXCscQVVvez6JQuFsbYd82ZQZchMPUgC/+Okrd9zfAgwgTvxr3D
         73L9Q574gv+C2wb+9rJbaBXTjyiwEyshoZQgb2KgBp4VWiIfH33ISwC0apYgGujfQONi
         OfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594973; x=1762199773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av/b87o60kt4fRKuXDsBRbb4urtiij5xxToz7XJ6ECA=;
        b=CtQPlqyx3bjkyRnKn5Ob6VjXst0R1jewtrpNiyWx4LUa9PkvAIepagMr28Oqv9Os6t
         I6rJ7jhezEJ3iA7hDIeGBaFxeYKRGtDpJeY7rXNkbRcdM1kJhI+uWFBxFUjYFaB1PADX
         DLhciP0KOIOnnlvUe8x7O7fyUwV1aj3ljaqK04lDP+9mh76O7lV9poRlVz5YCkBQiTpf
         bXUTI7OdL8eH4utxRWPxyHuG6cooa37Nr0ufSyZmLLsUz6adN9CfHvfTlXpCUmkGEDhv
         UZhpxTtQbGDJxhBMiAjTLF5zdMYdmYgKU9yHpNwTa5xZKeH8BWcCiZpiw8K3fIr3Gm71
         Cptg==
X-Forwarded-Encrypted: i=1; AJvYcCW1D1Ikgt2QjjzA6NmP8gCKHDs4XVd9yB19SxZxj89Ai9ydIzpacSAwadV/fS+saLedbog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU5c3jv1teGSlOcjX/ETeV+8fc4dMktTETUMNgPNzc2otEXwz
	XTmaydt5e8/NysQPR9O0nHhPTpZCOGpRmPlI3/6aOnN0FioiXWaSsR9dRv5D53nL1o3z9zpcYXT
	igQ/idQizyEurZy6lGd0Op6cML6QbY7m+Nw==
X-Gm-Gg: ASbGncvdrD9t2NLFmX6fW1gSXhKnapPbwLdPgYnm7yQ65tUiK6gEnBrhWpNSx6yt5vx
	yAzlOluIyZECUB4MB9PNuJHAOCpqr7WYBIhvQPYytegV2bNzsBDojUi5U3SX3yTyLC63gmpz2ZP
	hZYT46tS6KktVkwPuNBX3EW3j/U/yhp7MSd8S87h0TUq0Z9Qy2VcxJqHw+JM0Lm9v442KBFEBHw
	P3k8/uVBvz/l63Ul/qaO+5D5Us+mlNJC3TEwR7L1NxoGA7tMGb7/Jg6CYS7UoJOX/yBGzrwVWKM
	LVtiqQdhAwY=
X-Google-Smtp-Source: AGHT+IGkJe6IxQG3ZzGtCnUTzisW5p8uuoW+35RXoa4Vr2RavhP+QJRYfvEMxbh86JMQ6VV/YhWT8jH06guakc/3B9k=
X-Received: by 2002:a05:6000:2383:b0:429:8d28:4079 with SMTP id
 ffacd0b85a97d-429a7e86f31mr788123f8f.62.1761594972792; Mon, 27 Oct 2025
 12:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com> <20251027135423.3098490-4-dolinux.peng@gmail.com>
In-Reply-To: <20251027135423.3098490-4-dolinux.peng@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Oct 2025 12:55:59 -0700
X-Gm-Features: AWmQ_blwlF2Rd-fsxsnykdevc7MNfMtJZXyA0h87WpXOe2WdLWBp8FO-pfhQLEc
Message-ID: <CAADnVQLdN1mU-jR70WkkrWcfHXU1OOKDfWLdHS5Ji3-Fe++-xA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> +
> +/*
> + * btf_sort.c is included directly to avoid function call overhead
> + * when accessing BTF private data, as this file is shared between
> + * libbpf and kernel and may be called frequently (especially when
> + * funcgraph-args or func-args tracing options are enabled).
> + */
> +#include "../../tools/lib/bpf/btf_sort.c"

function call overhead? I don't believe it's measurable.

Don't do it on libbpf side either.

pw-bot: cr

