Return-Path: <bpf+bounces-78678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E88D17A0C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F503029C17
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2534575A;
	Tue, 13 Jan 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdO/DjdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EC38F958
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296424; cv=none; b=OVN6/zmeN8LAvDaQIxyFN6DQs0LcjQOBP18diDBFtkjOosIZ/kPZKtzZcE0bO2YITMgRgIaT6eqlbgTiYvaEk+V30xSOqdLj7Q9uWcZ/SUe5vTZbdBneUPnBs7MZIbNeYG2vrePVtJaOTwfycMXA0y3J4hJCW1SYI3Mcnn2KOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296424; c=relaxed/simple;
	bh=Li/6ZtGzkU4sXjoBIBEdcwQmFYGSGYqarHmbd/DRUzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuEGKShYuD+brapDJvhQZA2ZX9gZLdjAKrH9te7Nj1e3JseuaNOVQEnxfse9CQ03XdG4JpePkcSp6n+FYJkSgMHd+Ef6n5BSkQWy+odW6U4cEiUh5rkByjYa2xxubH7hqgHzAo6ogAoQQkGCsZvmFdJekCyFui0PR+0WbtlMLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdO/DjdG; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3927352f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296416; x=1768901216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Li/6ZtGzkU4sXjoBIBEdcwQmFYGSGYqarHmbd/DRUzI=;
        b=gdO/DjdGuZBAAU4Jzx5sC1Qzh8pMkm2iifVL17+V1boF8+iGgtL32ziQwfKY36l+BS
         ik5q0XlBbpZyCtgnhhK7pc5DtyjEg9NQqS3WW3rrq4fK/TMfLHCwlmOERgmMDn1bww4l
         amJmjnvlMiK8r2HueSUxjgPvKfcnWVrF6dmrqJdxl1+KOlyeX1SEvteyoAcffuv3EM/Z
         ub5du+oueqV/r7PYtQKgwbOoWjmoSvhetvImJ0+y/T53gC8EJj/90VaEs53U+v4OH4JO
         4KC4EH91kiNT583uVL0l46m6mqwZsP8A/adWFkMM5UZzvUXoM26aWQIuVrmg25sI4hdl
         CEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296416; x=1768901216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li/6ZtGzkU4sXjoBIBEdcwQmFYGSGYqarHmbd/DRUzI=;
        b=l5DSnUx6+rKhXbWNdJfUhApYSqjHXL0y2sqeT1DUh4DdreSuKdHxp4oTc9++EyakGQ
         9Jsd21+ftM/FeCEvhd9rBBgf0HBCsizYw4VJRv5U6jyKuO96WMAloKuIQpj6Ib8xtoSQ
         0iTavLoG6cbNKhhRC/oOwiR1yqCLCHQZnN54zUQdoLItqTDgmoC4FKwqj+/0FGu1nYcA
         hyJLAL273JbQhQcwkEcBoNADgNSru3OTKgNaKXtA8y8FVXheq/9w+fIZsOTn0CD0cQ2P
         jZ1ejtZEIoH69sYut9cIY8VguBs5omH85qdNKnrrGKMcpPBG/g+x0fPUpvpk74m+BexG
         4K3w==
X-Gm-Message-State: AOJu0Yy2MOBP7Nhx+Wu+/KEC+1Ds1wcUhXa1+SkXylKmE/kunFZ5o9io
	oFAQqRBq5fYpj/LmTq8EeVpnI+l0iaUSH8Ec6+PBWEB2z1/WAf+fiCeSlTjkYAMmf+9MxPXQ4rJ
	jGp9pWaLtLGsZu8+oxX3IubZZNQWyYbc=
X-Gm-Gg: AY/fxX4K12D3HLuJcd1UQWqzU5cIUHBMLOhNWZ9np6y3nqGOaoDbhCb71DiFik9sNRv
	R8PqyNgsriDaRLAyZefpwK7EI/ZPaWZ1H1P7Vclyy0xunPckauL40lFbRYsNbik/tKTkAk9QMLj
	cdb5ErgPq0doornfiInfQ7et/MyAwcuoBChOjCwsPKsldABYzK6ziQZaHsPVkir0TImavAXRakb
	n6YYiVxB6Y1VOcJBuTzEMRZnM9WPI9XgSwbD1jujoduTKd+GLCKpuJg5Co4cgizD9oIMgf7km2j
	PoHpSKbVLF2X9A8Y2wJACa7esHBfeQ==
X-Google-Smtp-Source: AGHT+IEhzhnx6LXemVyEAI/nx/T09LYUVOndK6DOOrS29b6ULuDG65tJNzONzAjxcGJmDY2/NJ4C1ueMFL+B1zTXTJY=
X-Received: by 2002:a05:6000:438a:b0:431:a38:c2f9 with SMTP id
 ffacd0b85a97d-432c37c4161mr25444338f8f.63.1768296416130; Tue, 13 Jan 2026
 01:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-1-mattbobrowski@google.com> <20260113083949.2502978-2-mattbobrowski@google.com>
In-Reply-To: <20260113083949.2502978-2-mattbobrowski@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Jan 2026 10:25:00 +0100
X-Gm-Features: AZwV_QgZtq0WeYvoQ3nY39ZSrKyqEJc6XKnx7BgJdJQ8E-Vg4EBXHlKZ843mXW4
Message-ID: <CAP01T77z-4+-64VN36qW8hcvaTZYUevELJYNbO_0aPdVUgdMVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 09:39, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> With the BPF verifier now treating pointers to struct types returned
> from BPF kfuncs as implicitly trusted by default, there is no need for
> bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.
>
> bpf_get_root_mem_cgroup() does not acquire any references, but rather
> simply returns a NULL pointer or a pointer to a struct mem_cgroup
> object that is valid for the entire lifetime of the kernel.
>
> This simplifies BPF programs using this kfunc by removing the
> requirement to pair the call with bpf_put_mem_cgroup().
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

