Return-Path: <bpf+bounces-32925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A088391534C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC191C23038
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53B19DF58;
	Mon, 24 Jun 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKWOLXf1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D5142625
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245936; cv=none; b=Yw838i63lijNXZ1uAXqWOcTiF+2VBJ9cuABzNeOFdVVitz3iR6ETntGICRHmPdF2Jr11P29NaNAbj/At9OltRWB/GXXj2L/YoBNFIlkYLfzQ7u88+Ig31Tu6LplosyH26oOFnpE42ifpi4raYD4p9VWIKiB7nZ7ApWP4xvLC1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245936; c=relaxed/simple;
	bh=2c63Oz+z7XLVfM5xUzAQn/J7YtDxJtvNbCcudk77rD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZcLf7WAkSr2TZLuQGfMsof+hxbORtDxEKnTE/GebRTD55C2gLA+9XKJK75ov2VIrqO9bWLLF2s3OpbUvpwloE/q4HiRy42p+OqnoDy/dQGqVyQ+CYOLeZ+XdX9kuYjmuilEmoYV2mYbaH1Aah144gkztGKJZPi6pZ0DkJPQoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKWOLXf1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7dbdc83bfso3537896a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719245934; x=1719850734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qs0xiPhIWDkyXHzu8Pa8ejSkOt4rAC2t4eNYy/zPF4=;
        b=JKWOLXf1mrMpHsi6SMEOzBZe9XkdTynP4AnF679jViTI1yGHcjIdeep44lP9vAIqN2
         /GxNVqm4OwuHm/YgBHZ6ZPLdVw/C8tzEN/K83ioVSjFHefD10y3racuP3r+RGA8Mb6Fr
         ACJRZJOdz652Z//iGRmmvk8FmohNwc8BbhNowt/D+RwMRwKU5pOmbdwtW00YXxjJJ7OQ
         kpAYpDDyKqWwkjfXyx1rAa0yu3OIjELNk6hPCjudoaiewUKUbRoHA1xcNfAiz4VYCRBO
         gW18XN4LtfWcyPeW4yA+FQjWS5J7w8HXLTSPSNT0ABwzdGlvqjUXT/WCFIryrvnJnv4t
         n56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245934; x=1719850734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qs0xiPhIWDkyXHzu8Pa8ejSkOt4rAC2t4eNYy/zPF4=;
        b=WsQIlvORrF4TVmGmUPlbWs1FvwNUAhwHoP1uMDwZu0zevIKLi2dnIPWXVuCOp66eLW
         bUXuLE+k+gyhDz53m5roYOXKS7qFzoFiflfO0nck7W9AHjlgsc9kc6aMOFFfi4I5/4t2
         LrzeD0o9r6OVLjj8RfMf45mNpg0uVRo9plppoCH53XdbqTvgEZhN3F8giYQ29AcNVXpi
         QH/Q3DxmsgYJq7NUqkOOtRTiLbdrGIsOmHg9/PcsDrHYEHd8cB/gXNpjf3/REXUpdNj7
         WJZKlByXYjqnZwMYejlRyBM6RVaN9CeOLoMYmEaEOQKMRQKTiAw1fzP0AaeDuFaFnS7s
         Rbyg==
X-Forwarded-Encrypted: i=1; AJvYcCVWxyLphYnqq058xI8oInwHzi3zDVsxK5D+Ht+aU4TXGlBl/G/V6p3ucbGGF0DREQ4vBv42YmttdHi/DVfww1VVqidd
X-Gm-Message-State: AOJu0YyDMvOyN2ECTfIdg91zLJxP7/I58aU5m/6wW4XiiANcsCjZovWW
	9pkvRJr26T5UFy8PdfI+613Hof9hfl9l8tDRLosoiriHYcP3NnwSdgfGOuG+PDGL8TTw8eEBKZO
	gq9E1WcAvMkKUG04+EAnlvrB6M4A=
X-Google-Smtp-Source: AGHT+IF9y72EysQQV5SUs0dKavFuSQwCL1FsmMwynIdPHPAiSZ1NX0RAOwHyC7ffxQKTNg03nYW86aqO88KX+uBo9wY=
X-Received: by 2002:a17:90a:88d:b0:2c7:f152:bc7d with SMTP id
 98e67ed59e1d1-2c8612cec95mr3948725a91.15.1719245934378; Mon, 24 Jun 2024
 09:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624090908.171231-1-atenart@kernel.org>
In-Reply-To: <20240624090908.171231-1-atenart@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 09:18:42 -0700
Message-ID: <CAEf4BzYPU+D4_OwzqsOTm1bBTCmX98yV+_b2YHA+arvirXp4MA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: skip base btf sanity checks
To: Antoine Tenart <atenart@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 2:09=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> When upgrading to libbpf 1.3 we noticed a big performance hit while
> loading programs using CORE on non base-BTF symbols. This was tracked
> down to the new BTF sanity check logic. The issue is the base BTF
> definitions are checked first for the base BTF and then again for every
> module BTF.
>
> Loading 5 dummy programs (using libbpf-rs) that are using CORE on a
> non-base BTF symbol on my system:
> - Before this fix: 3s.
> - With this fix: 0.1s.
>
> Fix this by only checking the types starting at the BTF start id. This
> should ensure the base BTF is still checked as expected but only once
> (btf->start_id =3D=3D 1 when creating the base BTF), and then only
> additional types are checked for each module BTF.
>
> Fixes: 3903802bb99a ("libbpf: Add basic BTF sanity validation")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Makes total sense, thanks, applied!

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..142060bbce0a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -598,7 +598,7 @@ static int btf_sanity_check(const struct btf *btf)
>         __u32 i, n =3D btf__type_cnt(btf);
>         int err;
>
> -       for (i =3D 1; i < n; i++) {
> +       for (i =3D btf->start_id; i < n; i++) {
>                 t =3D btf_type_by_id(btf, i);
>                 err =3D btf_validate_type(btf, t, i);
>                 if (err)
> --
> 2.45.2
>

