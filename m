Return-Path: <bpf+bounces-57585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3312AAD1A0
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A6500B52
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD021D3E7;
	Tue,  6 May 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8I+sUb6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495153D994
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574940; cv=none; b=eSn/OtLbRqXftbqE14c0ZDcj8Xc3CBnsuI8XRT9JvVDYl1DglBj3SmCOMqRqWyysxJTEBX9i0T6Jzn4BBAdo2wUflCiX5UlNZsOsiKVx3hSWiMgA2BOC4T4pJIdiGqocjCmIDHQhz9MQwI+syLrw5zPRxoV7juU17kV+CSRzURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574940; c=relaxed/simple;
	bh=Xlws3IFX+QTJmj+pAK22806H4P9aPVRJwBpyBnhHXWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBZD8Va9pB3Nc47kU5M6z7mdQDO4vK7kw45UWpdMJSXziN2nXA0Tk98b7UiE3QmU69ZSWDQi+y+ZafnmA7DAZuyqy/Sg/eJlBtpQYWFug8C2UUlI2CKKjljfaAi+TiCNUXAShoKBjI5msCWHtHs/pDRwibCN9CICL8DCG7E7ZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8I+sUb6; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so561523166b.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746574935; x=1747179735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RoPAhtGpRCTBrddVifllERVp2EL4jyGM5xd+AHR+x3U=;
        b=d8I+sUb6vzbVLwQgTEX6g7i5vqXQ+jf9aaX5H63WXz93d9TbqPkSUJrAtJ+QLUeIZp
         goE/O2RpZQCHhdV2j3eZ/s9I/uB9gf7hTM5a6p2vFXiFIYLewr+A4vGsdsOni5kbRAY3
         9Yp3OxH7KcoxKVDUZJekfBSntbRlUBjElSvUNV5cf1r2lasQAfK/MNVFj8ttAvJzM2Lb
         cntHsNONkXONp/niFFKEB1HYLBFUDuzFNeNxJFTV0LDmbEI9VzVjN6YjGZd87j13MttG
         yeMJtDs7MOxyecrtANiZS/YZOlVqfma5ldakE0eM6jRwud2OVcc61k9iYZYn06pnstc2
         AVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746574935; x=1747179735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoPAhtGpRCTBrddVifllERVp2EL4jyGM5xd+AHR+x3U=;
        b=kWaVv3XzzHtqhJnaOIP6mCo2vX9rWR9hag+KoY2F15t6xrp0skvUpC7HvarArddb5D
         Ky1jgFsQHilyamkBADLYa93MwSMNmb6HypfhvPSJ0rZkoj6qmroXiN+kJmAJY16hAkXI
         xBNSNU1nHbPNspZtiTtAKZYx+EgIjoQODJqJjKXbWnwKl9y+N5vjVFwwkFRYYMShx2wn
         rug4IgiSDMfGfqpg1apBaqm8KCCN5wTvoOUSw4URnmySoyFSjwPJfA3hjyN7kKvih6vU
         onQZ6VfWt7qXQTzGww735hcXrXBaoevh5J4BCiYgVAAws0DWLqLbdG/Fn1blE8/F2sHQ
         B1Pg==
X-Gm-Message-State: AOJu0YymS+/fRTo4mie7ALSzAFMMG+xnB1FKS3QrbfDWij8QGa1murCx
	elsA37KPVSs11yhDsuLwS7otNTIiYQ2N+Ydqskr/5JnA0TX4oo1XC1qPH7+xx5OqdQjqKj6ml9n
	OEb4IN92Xhg7DDRjShOY/Ey8C1Pc=
X-Gm-Gg: ASbGnctF3ZuRGtsc+7oaTSZxAwgg0YLOWpXp2QSOI7uvyxgv6HZS4nqp+ps6KCUeegJ
	Qua2eUeYr84zlyVpgG/EG4zjpDp6PeaQpLidLLYEb8mwBo9nBMCx5hAUXKdnSsJinn9NvkpnbFp
	Av3LTUUf0iMDvKa91dPN7//KVZc7AdekNnbKQRVWDg4c9/dqILn77ayTVe
X-Google-Smtp-Source: AGHT+IHkGmPkUw97in8gu8KGKSeVm2v94oSDaJaj87C4a2UOck7ICIPvtqTaapswhjdAhZHAJsM68Eug36ZAZabaxYM=
X-Received: by 2002:a17:907:7e8c:b0:ace:d994:3cc3 with SMTP id
 a640c23a62f3a-ad1e8d9b3a6mr113578466b.51.1746574935415; Tue, 06 May 2025
 16:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506232313.1752842-1-andrii@kernel.org>
In-Reply-To: <20250506232313.1752842-1-andrii@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 01:41:38 +0200
X-Gm-Features: ATxdqUGn6iEmZLQQVIGmSJ5qo-HzEzM6hcW9GXK1M4D_KScVZnvErm7LhyfUmPI
Message-ID: <CAP01T77a2iJbq7OBn2J1bY55AagsGZZPhAM3YsT42gvWvbZu+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: document open-coded BPF iterators
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 01:23, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Extract BPF open-coded iterators documentation spread out across a few
> original commit messages ([0], [1]) into a dedicated doc section under
> Documentation/bpf/bpf_iterators.rst. Also make explicit expectation that
> BPF iterator program type should be accompanied by a corresponding
> open-coded BPF iterator implementation, going forward.
>
>   [0] https://lore.kernel.org/all/20230308184121.1165081-3-andrii@kernel.org/
>   [1] https://lore.kernel.org/all/20230308184121.1165081-4-andrii@kernel.org/
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Some typos below, but:

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  Documentation/bpf/bpf_iterators.rst | 115 +++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
> index 385cd05aabf5..f3e9c8894c30 100644
> --- a/Documentation/bpf/bpf_iterators.rst
> +++ b/Documentation/bpf/bpf_iterators.rst
> @@ -2,10 +2,119 @@
>  BPF Iterators
>  =============
>
> +--------
> +Overview
> +--------
> +
> +BPF supports two separate entities collectively known as "BPF iterators": BPF
> +iterator *program type* and *open-coded* BPF iterators. The former is
> +a stand-alone BPF program type which, when attached and activated by user,
> +will be called once for each entity (task_struct, cgroup, etc) that is being
> +iterated. The latter is a set of BPF-side APIs implementing iterator
> +functionalirt and available across multiple BPF program types. Open-coded

typo: functionality

> +iterators provide similar functionality to BPF iterator programs, but gives
> +more flexiblity and control to all other BPF program types. BPF iterator

typo: flexibility

> +programs, on the other hand, can be used to implement anonymous or BPF
> +FS-mounted special files, whose contents is generated by attached BPF iterator

typo: contents are generated?

> +program, backed by seq_file functionality. Both are useful depending on
> +specific needs.
> +
> +When adding a new BPF iterator program, it is expected that similar
> +functionality will be added as open-coded iterator for maximum flexibility.
> +It's also expected that iteration logic and code will be maximally shared and
> +reused between two iterator API surfaces.
>
> -----------
> -Motivation
> -----------
> +------------------------
> +Open-coded BPF Iterators
> +------------------------
> +
> +Open-coded BPF iterators are implemented as tightly-coupled trios of kfuncs
> +(constructor, next element fetch, destructor) and iterator-specific type
> +describing on-the-stack iterator state, which is guaranteed by the BPF
> +verifier to not be tampered with outside of the corresponding
> +constructor/destructor/next APIs.
> +
> +Each kind of open-coded BPF iterator has its own associated struct
> +bpf_iter_<type>, where <type> denotes a specific type of iterator. struct
> +bpf_iter_<type> state is supposed to live on BPF program stack, so there will
> +be no way to change its size later on without breaking backwards
> +compatibility, so choose wisely! But given this struct is specific to a given
> +<type> of iterator, this allows a lot of flexibility: simple iterators could
> +be fine with just one stack slot (8 bytes), like numbers iterator is, while
> +some other more complicated iterators might need way more to keep their
> +iterator state. Either way, such design allows to avoid runtime memory
> +allocations, which otherwise would be necessary if we fixed on-the-stack size
> +and it turned out to be too small for a given iterator implementation.
> +
> +All kfuncs (constructor, next, destructor) have to be named consistenly as

typo: consistently

> +bpf_iter_<type>_{new,next,destroy}(), respectively. <type> represents iterator
> [...]

