Return-Path: <bpf+bounces-66764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56AB3903C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9397A7265
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986C1991B6;
	Thu, 28 Aug 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHtBKe5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CCE3FC2
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342262; cv=none; b=EY1RBmXMclOAI/wLzLRmKADTAy9DETxN8LbaanuLv8AVGh+bYBH3Z9/FwoE354t7qLFiH6ob0umOuSrPAiQFnDnU6/XjltmGESfZcdDIN0TPHeKqwGZXDP6Oi+17j0yzBbDqzJxrlz1dtQNptMzHeyfmbeBzj3JV1I/rRSaAb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342262; c=relaxed/simple;
	bh=7248RPAsz3Z95KnnWFSLZDi9b4+19CVOrBLqZb/shPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSTUy0NdRL/Q1mchcWMc7mR/LtGHWFZUMh9g0fQzIS2sGU7rKuQXJA31Y4NUm3ccL3LOvrGZrJCyrpvx++G+H2vmDT969K9P/OUehFczKOrdVpCKXgRoRiVfUnSKbx2UM82ES/Wfs+OSY4RuTaNAtRnT2O34lvfGg1P8HDvuogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHtBKe5m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso2110205e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756342259; x=1756947059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evBlsihqgOHXWNsnXc1g19w6kdk7SfPMM3+YSTIV5EA=;
        b=YHtBKe5mXrk0MmAfM/7doJUZ8Bf1IOHiNxqpjvSrcWnIiDuOPZnqCWHyE+QfQPMvh6
         4+6VtT3457GZBWNay90A45EzFfluWWMcO3Xj72EmU1+0Fru78vee07Pm4YRJCQsUEjus
         qv1h2FxpWTFkG4XSuD/18QjUAhlnpizsKOwQ1wlcoy/tqtLL5ePu5H0z9q6ZjbBwgSdK
         7CrvT6FD3HirQdnfn8PlNY5VByG7GpZlODujPpUR2w8t82czTKvEAXR+CzUz6z0fjRQ3
         saIQ7Oc+U+ZZYIgJYXIMXvQ7l1Hb/AzykAz8WiPvL9d3nlrG16ze2SzTi8BWN16IoTFD
         M+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756342259; x=1756947059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evBlsihqgOHXWNsnXc1g19w6kdk7SfPMM3+YSTIV5EA=;
        b=MlVf5d7HgW2OwllACPCWiaK4XwI8CJFhTGpCvaQ9Fz3uPKBcYJRNZJlthAHBj7ABOU
         zpHCJuu7ISYv20w5lkY5nwwNL8GbLb5K32KV3besJv2NkFwVuRQf1H9UDyEL9BYYeHDf
         pDbZrySvY4M6RVWwbHO9G0MM8Wssl2YVUbvhRe8arhc0mIjpMRnqUYgy55winK3oZwyf
         8f4pvptmPbhMGyO8VXuD3Omlz3H59HP4plB7Vq7+iLcAua9k72nJ6fs+ehNBnDhRlYXd
         xpsss5BXi9zzBzxARpJiI1MefKGZzmCcHIqTubZR9mo/RQT71pKWAlpI0j2F80fu1wLk
         mu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4QkWtUlG0t1/zCK/xUHLB/+Nc4s8AIGA1X/Lkq9QdKfHNe6gDuG2HcsfSUZw31E7Qfdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzA33Uql3aZj3mNftd16cN+zSvFmB/Znoz8aVSZwTYoekFiv6g
	+8StVRoAYxcXl3WiutyfEIyyKKZCG5XRXRatQH9siPM3XEHZ+YLfbniu3XmLAvzZLgBwKLvZ0Dc
	LUblNUKOnDPR8pRirfE7EBg/sHLKyYP4=
X-Gm-Gg: ASbGncsUnjxKKPLWMUGQjgv1E01EIzknnlt+rdAoIyaIUqj6p08wagJiXxoY64WrX39
	Llj/HSNqp57UMieMogBSw9FzNb2UsQi/T29d1cCqGoJ3XCD57tWvY7a5K8gDMx+Yl6E6NPEKCt5
	0BVnaWjUoyNdL9lzGVAiV4d448Vry/RaGNFH+tK9FlLcGNm/SCMUfCZh68j8pxDKg8dURPrQoWu
	SZ+QiWSxbNl0P/6rw7LWDDExdFMS7suvNxg
X-Google-Smtp-Source: AGHT+IGAY4apCDizd+/wTwdGZHUcLwv3aQAVXsZPKpx2M+J5r4asNbE8H0nKFnIOL2jH788sWGQNFGBgJ0UItbBkfzE=
X-Received: by 2002:a05:600c:4f83:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45b517d077amr214155965e9.30.1756342258631; Wed, 27 Aug 2025
 17:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827194929.416969-1-iii@linux.ibm.com> <20250827194929.416969-2-iii@linux.ibm.com>
 <ac3eabcb-934d-40a4-b725-6a4684ef48a0@linux.dev>
In-Reply-To: <ac3eabcb-934d-40a4-b725-6a4684ef48a0@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 17:50:47 -0700
X-Gm-Features: Ac12FXxdy2ybQH1PXPp1n-1qOf_vGZG5NTIUVnRIp0Qd5oGmY458W6s-2bQVFRA
Message-ID: <CAADnVQLgqL9eu_mA8Lq=wA12GXCaFzxm5ZXsieOkL9xeOYaoaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 2:38=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
> index 6438982b928b..35616b5c9b9e 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
> @@ -227,7 +227,7 @@ SEC("?tc")
>   int obj_new_no_struct(void *ctx)
>   {
>
> -       bpf_obj_new(union { int data; unsigned udata; });
> +       (void)bpf_obj_new(union { int data; unsigned udata; });
>          return 0;
>   }
>
> @@ -252,7 +252,7 @@ int new_null_ret(void *ctx)
>   SEC("?tc")
>   int obj_new_acq(void *ctx)
>   {
> -       bpf_obj_new(struct foo);
> +       (void)bpf_obj_new(struct foo);
>          return 0;
>   }
>
> I think this probably will address your icecc issue.

Ilya,

does above fix it ?

If so we should probably do that and hold on __must_check,
since if we're getting pedantic __alloc_size__ is a better tag
than __must_check, but it will be even harder to get through pahole.

