Return-Path: <bpf+bounces-39175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9A96FD6E
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EC3288EFC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3EE159571;
	Fri,  6 Sep 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyIUYlmv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9131B85DD;
	Fri,  6 Sep 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658396; cv=none; b=LKG63wZFJ/1JZnvuR796+9EHfzh4W3hJzkVb2Uve0uvL9GchEca4ibOh/BigZH876qhTdjazznm6iQYccP5ZkjJ6jjj/E+G4srEgskZCr29WkcOGky4dfqKnhSRGYN16rX1Z/z1Gtj395xG3wUtaUQ61hCZzav8v+IAFku7WAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658396; c=relaxed/simple;
	bh=uJKam6jPMw4x0tkCq1Wv5b+nDcpay/P4TMv2sEL9ehs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtzIS2Pujo0im3DNHPMLR3/V06o537NuA1cYp94wGdZFvS9Rkq//3cTHdvu0S3QdP9AN75K9QO7eSntzKdCANsZIpq8DrmpDrz0BZcx36e5KgEDfRg2+47B3XS3JbRDAE6rZEYFyDXRPYHgpU2YFfmN6SrxWuRGHfzerQ40R6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyIUYlmv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so1824552a91.1;
        Fri, 06 Sep 2024 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658394; x=1726263194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9hn2gQDY7jNcjnAxVl7c1x3AiF6ONVr7RgLozr+YhI=;
        b=GyIUYlmvlITawL/E8JLcHdyZ/eA5jbCfHJ2m3inKX/YtApeZHXegKo84L63sc5vBNT
         Vj9rZO9gyjcjdfbd735Ys+IUbOtUz1krBEGq2I8YtUk396ATw869hwbG/4+WwnQE+UhT
         gaq/OrTk2dn4rt5SqfKOWJolYGILuHlLMsb/KlsNypc23HgTXHbWBugJjt48KDLS7O0X
         PzfCItV1B09w7YpF/wIjvoIodBu33yOXIh/vzTyeg+oceKBz/QCZ6anfSmhRfbSQlnXm
         LqmsgZ1LjbvNtyDnPK4L6RtHUS3QX6HFhuFPj6Mzq0p/XmbjQEfBtl8HCf88WhhX4YTz
         BKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658394; x=1726263194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9hn2gQDY7jNcjnAxVl7c1x3AiF6ONVr7RgLozr+YhI=;
        b=R17BqUlX3EPDJo0ddbYpmAFc4iUzfXUuWCqPwABFRQwJyGa9KQOZdvw7sDTb39P7nQ
         SOyiQz1ddazH5OWzXe2C1GQKaSh0gESobP8aQ2uGZr3nQIfs2c7NXFHehd8gmV0zRAGf
         hr9pGK6lCdubRbC+7c16wehvm58hAIZ/OuW18CdFBAZG6laTdIoJyvAE/HS1aJD2GfJV
         tCg/vj4yytcXQvU05FL6c4zY2z/4A3jJU1umX37P8w4D7RTD0jI8Hu8WCxoBbSrz6QI9
         uPASuvcPdtlKg+CcWBKMCtnluNZvNNjuIkSNxCpw+52I8sgoH7KpljMzFMntP2Pg9HNt
         F0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1RIdTL01J5yQkuem/WrQzVAoStZIZpwB6J7XX3owVYFFlawOr3VpTWlOSKvNWpEv0toI=@vger.kernel.org, AJvYcCUkTCGcoeHGZcP9Ld3jcKNNoN9v1AmIuVZZttjsJj1l2gBLzfPrXozadf7PsWpalWGwn9upJakdNh0woXLT@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/gdAHyE0ZQmsiUiFk0AMZeQeMU8v48TqSjpzUfYhjGt2d7BE
	8Yz5Y0p85FMMLwt0BwGH2YXmgD6HHIA7Laiw8SzkRuzrBwe4uZ01GaJTfUd8Ndtfa7RZPVHoqRK
	KJ8vP2KVLyXH7lCtWf9I4tFEk/eQ=
X-Google-Smtp-Source: AGHT+IFFOWa72y8qrOiqm3FHOHXqU2l5nWRQM2lPo/swzIjGBh1pP5BfTSmSEX43wqy9PBkVUcQo8KQL73xzmeba+T0=
X-Received: by 2002:a17:90b:ec6:b0:2d8:d58b:52c8 with SMTP id
 98e67ed59e1d1-2dad505d5a0mr4562878a91.19.1725658394121; Fri, 06 Sep 2024
 14:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848C2304B17658423B4B81D99932@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848C2304B17658423B4B81D99932@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:33:02 -0700
Message-ID: <CAEf4BzYW9NM5WeFMpJwS0krsHgV9TfkXNon3PVfBC_+XYKWqVw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add open-coded style iterator
 kfuncs for bpf dynamic pointers
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:08=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> This patch adds open coded style bpf dynamic pointer iterator kfuncs
> bpf_iter_dynptr_{new,next,destroy} for iterating over all data in the
> memory region referenced by dynamic pointer.
>
> The idea of bpf dynamic pointer iterator comes from skb data iterator
> [0], we need a way to get all the data in skb. Adding iterator for bpf
> dynamic pointer is a more general choice than adding separate skb data
> iterator.
>
> Each iteration (next) copies the data to the specified buffer and
> updates the offset, with the pointer to the length of the read data
> (errno if errors occurred) as the return value. Note that the offset
> in iterator does not affect the offset in dynamic pointer.
>
> The bpf dynamic pointer iterator has a getter kfunc,
> bpf_iter_dynptr_get_last_offset, which is used to get the offset
> of the last iteration.
>
> The bpf dynamic pointer iterator has a setter kfunc,
> bpf_iter_dynptr_set_buffer, which is used to set the buffer and buffer
> size to be used when copying data in the iteration.
>
> [0]: https://lore.kernel.org/bpf/AM6PR03MB5848DE102F47F592D8B479E999A52@A=
M6PR03MB5848.eurprd03.prod.outlook.com/
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/helpers.c | 110 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>

Why can't you implement all this using just normal numbers iterator
(bpf_for() loop) and using bpf_dynptr_size(), bpf_dynptr_slice(), etc,
generic helpers.

Seeing that you have to add bpf_iter_dynptr_set_buffer() and
bpf_iter_dynptr_get_last_offset() suggests that this might not be the
best fit for an open-coded iterator. But again, there doesn't seem to
be a real need. dynptr API is generic and usable enough to do whatever
you need without adding more code to the kernel.


[...]

