Return-Path: <bpf+bounces-57626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFCAAD484
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153803B48BD
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6041D7E5C;
	Wed,  7 May 2025 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbzYG7om"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58AFBF6
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592742; cv=none; b=nDOEvXicgSgRXsJd6PvIoWdNXrtG6cS1WR/FCaruSIQppYt5FD16J4AZDIfT5WGsG/yauvqxrppTRzhddjpTax97fCkDrPNXZH7HNFIyuj9HehiyX9RQsuzukgeJkWYjAFnO4USF3iV/msg8GVr+2UyQcbyC42xM5PjgK0K4iXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592742; c=relaxed/simple;
	bh=wbvgiNZ8j4uW1tRLx+Z1/3Xl5HEbg2TIGMagSDKaxFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojftKJqRxBay0qntp0s78eAN0XuuJDdbwJs27EODC5DjnaWOYTuTuYFRuCWuFguEH8+fzQ4J3A63bdT8w91QmQBCsx+0GiEaxqrjLXUn8UcL7SXGxdbo71xSw6JvL06xSKbIkls1VX1wzjrSL6hFzeLpKKQHT7pk+KNwuOADhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbzYG7om; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441ab63a415so64076585e9.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746592739; x=1747197539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbvgiNZ8j4uW1tRLx+Z1/3Xl5HEbg2TIGMagSDKaxFg=;
        b=AbzYG7omianWoSf5t5pHorkCiqCTGeku5NDQsnlmJttAzf8gYWZweJ1hHXwY9uLWhr
         lkkikoMezNDcRlfBF8DmVJkj3Konyw145kZwKAsVJEB0QH5/7gfUW4XpLt8EN1C0BZbZ
         m5dcBN/0P/emfOZ+DFqWQHFd9GGr78j1C5pKPN9tyUQ3XLnNzhGaOAfadlnzKNDodRz1
         wZED41+5cDDPHaiushgzfvVNbDd6eshxT2ly/4ZYwl0xEVcTxEQ7B/uFDkNpfpFSowza
         7wZC98g9K8rYnSYei7htRXhk1geSXmwWt1e6ZXEm3aOROsUhHJmv8Mt9VcM/OiL721gw
         Injg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746592739; x=1747197539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbvgiNZ8j4uW1tRLx+Z1/3Xl5HEbg2TIGMagSDKaxFg=;
        b=qVUNA36JAgXmPFYNzLextGeDfl+y0wudZ/wmUvGHTGNkXTzfOlJ7rqoKaOWBVBzhMx
         xuvMVcL8+Zylm7TdWrwcHdxdupqGy9TU5epe+fPbuDVh8/TsAddHEcPtKdLSNJ1NI4yY
         zwqJJC1Jd6jRcF53mQ1/nYyhXaGzb4g8+PBzrDrEyYxeHOHQdlsruqjjxgKURvlV7e4B
         XupGyU5832q5cfau6rx5+bHQiHNJIMnywNFuTNW9yukWkNAGaHi4Ka63nEQJiSIRZfZa
         NwKa9z+jLrnw0NahOJSYbZRHutkcLKmLli218rjU4ZLqUzqvf7FjcO/vDxVRH7R2yoRy
         Vffg==
X-Gm-Message-State: AOJu0YxypIMtokxLzjEisS3ww2Vc/BXcIL93nwwkJU4+N68b/H6NIDX7
	TNOdXJy5wFu27poY9SpLnF4zIAWPEfjAXLqV/8iC1ICG7S/tmapZAPDvhl4fhFQqx79O3zjF9DU
	cpE4dVO98OD4/h/twaQ+4x5cpOuo=
X-Gm-Gg: ASbGnctc/Dc9iaVafP4FCU50zwbUtTiw0GfU8ocVC0Xt9N8yWBO/geaH2nBu67ADdKo
	Ca7cwedWxMtrtxi0kh8juJsIRXOMIXJh1zV7c7PS4W4uM0jyHx5Dt7oxaVGgEurV9fRu+XEQrAr
	+RoGJA2zkVg4wDTkNOQXULDxqpuPvvciEGSfRqGzUv+yqGHehTVO+6j0tzRPyw
X-Google-Smtp-Source: AGHT+IFVxpz8decI1WdrYOU4zVDUzelCK1q5QGiG9yzgBmW4/W1mlqo3U8xojIJVUhPrKQlLwk5b2O6QY6ztmJNuXss=
X-Received: by 2002:a05:600c:3115:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441d44e0c7fmr9914965e9.29.1746592739240; Tue, 06 May 2025
 21:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506232313.1752842-1-andrii@kernel.org>
In-Reply-To: <20250506232313.1752842-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 21:38:47 -0700
X-Gm-Features: ATxdqUFgJoUuL7vtOXbtTbvcp10jt2apDp5EXo3KLETSxbIaIxC6IboO0nASNBY
Message-ID: <CAADnVQKTeZ_M+9fXNuLpXmukaV4e7qwQQAySax7S9j1=29+66w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: document open-coded BPF iterators
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> +be fine with just one stack slot (8 bytes), like numbers iterator is, wh=
ile
> +some other more complicated iterators might need way more to keep their
> +iterator state. Either way, such design allows to avoid runtime memory
> +allocations, which otherwise would be necessary if we fixed on-the-stack=
 size
> +and it turned out to be too small for a given iterator implementation.

This part is a bit unclear.
I think in "if we fixed on-the-stack size" you meant that
"if all iterator types had fixed on stack size ..." ?

I think it's too much information. The doc can just say that
sizeof(struct bpf_iter_<type>) should be small enough to fit
in the bpf prog stack.
It probably can also recommend that _new() should avoid memory
allocation when possible and use the stack, but it can allocate
if there is no other option and the state is big.

