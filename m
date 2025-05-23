Return-Path: <bpf+bounces-58850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F718AC28B0
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E0C1BA62F6
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C0297108;
	Fri, 23 May 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5nNNYdV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73481749;
	Fri, 23 May 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021602; cv=none; b=UYdsj58/Qd/kJMYKZfsGSGVK/MPYmqch6fxbgzRsslw0bsjyKlcJNlUe9y7PZJsmGxOLliB6n+odXUCCn6V7XVgz1UON5UFurg7PdUwmKkNCf4+o6vIHLE415QB/lTdD0/5Y0QveawK65yYmg9ARyUcjCAtk2u6/1VGoSv8CNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021602; c=relaxed/simple;
	bh=8cUmFzXJyLokvGzIcZeJLDKLC2JgEM55P5f9ca4aHrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9VXRmjqm7c0hZL7yDsBZVyy+nlze3C9W+jLAkG9MJSontYPwqXU+YlX5MvP6pfLrq50069y1983k9jwsJatvfi7WZ/UfCgBNES0Ft7sJ1fqZT+q6npL1vJSvQEY/WWrGIKwWTtS9FewWNzEElJ/64p1E5qL5Z7v6RMc56crnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5nNNYdV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-443a787bd14so8568425e9.1;
        Fri, 23 May 2025 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748021599; x=1748626399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLRX0CTtTbvhK3E8TIvdNJVRfccaOySP3rKAzrfL/0A=;
        b=B5nNNYdVc1gb2sLJwPZqwHENsRJs9iDtfwoQhVp20o+FqCkcJBqTfOxhouaa70KV6z
         Y4pRIzgjVm4aEFxMEvFcTIzbXtAVzD7zPFL3Ex/3oBMJxyoKy6srKLErb6KgCL+f8uuM
         SHIBr0mt8UnuJNmqsIdGMj3EKIBlTT/DqGORqTug/Q5+LzQXZH+pztpaekfJvD9/ofBs
         rnEfGL7iB8tNdyMKG+UjUqRW904NgriGMOCP1YElhYazeC8gsIuxfL5/JHzI1CfP4icr
         XQNVLvNXhMdkvT6yB9X9vpy6IOCfbz6sHEgzwWUHtBxeokAX7tKYfeQZJ/Z4vQm0edE6
         r4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021599; x=1748626399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLRX0CTtTbvhK3E8TIvdNJVRfccaOySP3rKAzrfL/0A=;
        b=vsvFEzT8z8BeysVeDeg5etvY/+aIxMTXRjLZJJFKebfpQ/MHidQFswOpeLh8sx7lJ7
         q7xXMs8y0ZqDVHryUTTytMBSNHxvdQNHocCfikFDWtne6IHVIHSmiLSJCnULhuNIaczR
         qlg9rAXL9Td5CGqC0m2t20tiERo9FZAB5q6y+hvu9tCG3FUQ3/zFrHgsqPEjJpuKE9Wq
         CHtLlv9GM9YEqgSANsyTlc73Kr7xDSFvX5VaFO/bwKVGVozc9sbaQTWbgn5TSR0yuCM3
         9QDV1itonryN2Fx++SalqLaVQYOfevTU38xjkCT652b4r7sXHITA4xV1eCf+axoEPV9o
         Uxfg==
X-Forwarded-Encrypted: i=1; AJvYcCUSng43aNe7Fmx269T6aTpXcDI7SYL4DvvVWfuegcC+KQ8vVYqwFcnyFdAUj2oWfK9bGaY=@vger.kernel.org, AJvYcCXhBdzN5AYoFygxPGMvqRm/x+wqfiTtzHNbJzOTVQ5Um00IS9xDzvastHLKHdb8iOIxLmxD09iPfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGU1Rm4qulKzmrZj/yMnlpM21Eobu8RXKYO2VSws09x6GLr5H
	ICiidOBT3RUmhbCkyFZe50W7NClWHo7ClVupcQgLDj/7EmUbTwXuTN26/pEh+1ay5M1VIb7D/wI
	jyvOOvJfZ/1QQkU8EFvVq4Ic5rjjhEUI=
X-Gm-Gg: ASbGncvlkGlYjRAeTYyGUqwg5dk81onURfBgoUlSKKjvZ9GTyqp9A5JSSwm6fk7r5CC
	Nd6jmrEDFTA0G2reHjum041x2bPAeUE8JPibuZYMcNgkPZi+72E+zosumSWjlu3VM9UguZIJ1uY
	VBoXAu2Fq79r3D51s+zwldMuhpasu8nmRaUrq8Fn1K9PerHHc=
X-Google-Smtp-Source: AGHT+IE4/AXONzWxzI5HfkceV2q1e460C8kXlT3p5DMKK5UOn1nc8iom9PoP1F0X38YW5sK59NOeX3TSl0gwBHiL4Hs=
X-Received: by 2002:a05:6000:2289:b0:3a3:7bad:2b95 with SMTP id
 ffacd0b85a97d-3a4ca756cc2mr315122f8f.29.1748021598698; Fri, 23 May 2025
 10:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com> <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
In-Reply-To: <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 May 2025 10:33:07 -0700
X-Gm-Features: AX0GCFuGEosiiat32kgEGusi3wy6GBcTkB4BFfF-YRg7AmBMKPHUZlpP5GRRnXE
Message-ID: <CAADnVQ+SeJfjTRSdz=UYjYNhS9HMDriWfYyd==fLB1XBMSMdxg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Thierry Treyer <ttreyer@meta.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>, Yonghong Song <yhs@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>, 
	Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>, Daniel Xu <dlxu@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:56=E2=80=AFAM Thierry Treyer <ttreyer@meta.com> =
wrote:
>
> Hello everyone,
>
> Here are the estimates for the different encoding schemes we discussed:
> - parameters' location takes ~1MB without de-duplication,
> - parameters' location shrinks to ~14kB when de-duplicated,
> - instead of de-duplicating the individual locations,
>   de-duplicating functions' parameter lists yields 187kB of locations dat=
a.
>
> We also need to take into account the size of the corresponding funcsec
> table, which starts at 3.6MB. The full details follows:
>
>   1) // params_offset points to the first parameter's location
>      struct fn_info { u32 type_id, offset, params_offset; };
>   2) // param_offsets point to each parameters' location
>      struct fn_info { u32 type_id, offset; u16 param_offsets[proto.arglen=
]; };
>   3) // locations are stored inline, in the funcsec table
>      struct fn_info { u32 type_id, offset; loc inline_locs[proto.arglen];=
 };
>
>   Params encoding             Locations Size   Funcsec Size   Total Size
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   (1) param list, no dedup         1,017,654      5,467,824    6,485,478
>   (1) param list, w/ dedup           187,379      5,467,824    5,655,203
>   (2) param offsets, w/ dedup         14,526      4,808,838    4,823,364
>   (3) param list inline            1,017,654      3,645,216    4,662,870

I feel u16 offset isn't really viable. Sooner or later we'd need to bump it=
,
and then we will have a mix of u32 and u16 offsets.

The main question I have is why funcsec size is bigger for (1) ?
struct fn_info { u32 type_id, offset, params_offset; };

this is fixed size record and the number of them should be the same
as in (2) and (3), so single u32 params_offset should be smaller
than u16[arg_cnt], assuming that on average arg_cnt >=3D 2.

Or you meant that average arg_cnt <=3D 1,
but then the math is suspicious, since struct fn_info should
be 4-byte aligned as everything in BTF.

Also for (3), if locs are inlined, why "Locations Size" is not zero ?
Or the math for (3) is actually:
struct fn_info { u32 type_id, offset } * num_of_funcs ?

