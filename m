Return-Path: <bpf+bounces-77277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D9CD47FB
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B7F3006A4C
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC721CFFA;
	Mon, 22 Dec 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsuhsrN6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75508217F53
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364980; cv=none; b=IY805iJnbbDmqHwNuplFiieAnNsd+QoYXt9eJChnCnMswyRIyPOSjjlsamsqe/hg9uqJyTdXRpszNn+jHYhgQWURiAR1qpDQT0SVXhcgUDjhhwHauXqD6i4+QyaZTeNu87SbRY4hm4OEOdstawASOPxzskJ6U6k7Pjw3FE2oamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364980; c=relaxed/simple;
	bh=vjVBjCW7dPTMjPIoykQAbOyY8tcN2Nkd7xpLAdrazng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbasSKKEhKS+01cU67z9tsvHhfiOLpU4kTj3R8NvqZ2+hDjo47dBDVE5cXFxNvFicNpJyLMd6fOOKRCSzjD9DSAM7SHb8pDbde3jawEypiEWA0LgSs9Hx4Kr8+IH97AinceZxv6wWYa12eox5vxDu8dtfQwiHYsH2s/TaZvsm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsuhsrN6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305552so2824885f8f.0
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364977; x=1766969777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbmfXY83p8KW2JQuGmZUJzsTMuehLwNTWwDjBfuwcWo=;
        b=KsuhsrN6GUvcH7gb0q4CV1E8hHsCKyzfYJ/xibxoeT31BSwe2uVYEE+tUOamXxBLmu
         KUwoVjZYcf2t1ntGgYw2j8y2QDmLw4417sJVSDWRjijWfKtO0OMdRPPBagQugeqpI4ft
         ivGgYGgY8HVsMTC1zwUK+9pe2bZjjujruDKMOghUCyYRUCZt1z16WD8uty4ziDR72JCb
         gEb71+I0Gt5Bvlr/qwOdfxP77t2kxGlxojisfeuF5BNXS95zfwyx7hbzh449AJQ26nKW
         6m8gWMHTBdIlyLUdghqR1js6xfloZjBzyTTWse6UO5rlMvYHoHRHfQHZpLpRf6GLN2tx
         sHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364977; x=1766969777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbmfXY83p8KW2JQuGmZUJzsTMuehLwNTWwDjBfuwcWo=;
        b=iDWJ9a55mciYU7nPQfIUVws+jJfQnu9+DryRhOaVSaAjmp94rT5kKhu53RmJjeKnYW
         Q2wKu0PmWzjpEiiXl43i4aM4j10jzuwf361K3hLVsRXCkcPd2d6rD27u1hEenR2Uyq9x
         8+jhn0S2UHmnAvAz42sdDiVCBRwAUfDGCRBWWl2foGcQYjOM/8eeH0HrkCtFCiXPmak4
         NO8F07lBzlhiGOC5VwldEzexIeFgZjmQ+JJ1DxPTd+u1+s6Gkru77ElhbRmBun11yDEG
         +auTpOKp60nUOWlTN+vOl7/KpSNgP7NyGPRfZ72jAhYQCBQbH1jvQSfXTy4sUJkqMtas
         d27w==
X-Gm-Message-State: AOJu0YzbwCL+xWZwKIu3HMkBTq3J71wQxkMmwVKnjDA+LyOXJm8eMpvf
	/jt+YtnPzL5P301g4ScVHz9rPx6TI23KZMPplLYkcigYo5F/5duenNSGVIP4WMCWs0Xnw+Y0IO0
	c9xWpxNC7wGtMciXi/fhUBNjTVfk8zq0=
X-Gm-Gg: AY/fxX5JevZ9TuNSeT8eO87qDupEbvGeFo0ADzeDDlbj9oR8jnxtN6A6ImhiGKnH4LN
	N+7pZdwQUCgvx5Unt3UDiNqQzhOtQKM7iC1eUMiivWRsK/jDneBWfCcAJ5V3Q7RScZOB0X2Dg4z
	RsPEDMFVwiLd5yL3/rqWKM9d+u9ykRg0ALFedp4ML0yzNKsj17EcekiBjNLi26VeugeTs2c9O9s
	pCJ6YCOFw6T3qvkkFNy6XGvhRSKwkTSnmSUdhpCbYCljYwtImyhoKZARAR9y8+GpLpgrpMA
X-Google-Smtp-Source: AGHT+IFVpOlYu6rwqUvB01N3ZGdvOSogwX3LkA9Njb1aN9bkPDwZcc5SlLI3acgMUMLiKHrowirOrtAkSS4k2fZd0YI=
X-Received: by 2002:a5d:58e9:0:b0:432:5b81:480 with SMTP id
 ffacd0b85a97d-4325b810a80mr3849482f8f.24.1766364976667; Sun, 21 Dec 2025
 16:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216133000.3690723-1-mattbobrowski@google.com>
In-Reply-To: <20251216133000.3690723-1-mattbobrowski@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:56:04 -0800
X-Gm-Features: AQt7F2qST9UM3aCBm8CxpwLBRSB9D3aGXJehztniXIuEgb_lZj5eq-fiGE714dE
Message-ID: <CAADnVQJ=1e9W92cgO+sUbToATE=6Rjt4GHKaXjBAfNvToksy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: annotate file argument as __nullable
 in bpf_lsm_mmap_file
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 3:30=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> As reported in [0], anonymous memory mappings are not backed by a
> struct file instance. Consequently, the struct file pointer passed to
> the security_mmap_file() LSM hook is NULL in such cases.
>
> The BPF verifier is currently unaware of this, allowing BPF LSM
> programs to dereference this struct file pointer without needing to
> perform an explicit NULL check. This leads to potential NULL pointer
> dereference and a kernel crash.
>
> Add a strong override for bpf_lsm_mmap_file() which annotates the
> struct file pointer parameter with the __nullable suffix. This
> explicitly informs the BPF verifier that this pointer (PTR_MAYBE_NULL)
> can be NULL, forcing BPF LSM programs to perform a check on it before
> dereferencing it.
>
> [0] https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.kaiya=
nm@hust.edu.cn/
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.k=
aiyanm@hust.edu.cn/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
> v2:
>  - Updated the comment against the new strong definition for
>    bpf_lsm_mmap_file(), clarifying the need for using the __nullable
>    suffix annotation against the struct file pointer parameter name.

It was applied.
pw-bot is asleep.

