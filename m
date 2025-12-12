Return-Path: <bpf+bounces-76517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32434CB812F
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 08:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7404301D9D5
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FB2D663F;
	Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdYVYhXq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13930F7F1
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523429; cv=none; b=GoRtyuAPzuIlEE/MoZZyKkw011AqVa4A5Kum8yx2ceRRjELxU0Ura1YWCSM82zVGy/rU1lRyoP1U7KNNHzF6RfaNnyN9lK3/GsTGHPIu1vNRhYbGZnSR2ng9BEY30psW119CZ5BHhVRHDSQeX/rhkGZgKGaSI1N7VEfYUOIuLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523429; c=relaxed/simple;
	bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajjex9vgX1cSXU4rbe2+i+CKwpocJoLQm/Ar+UvJmUQs5+NOJ0tB9/IWIaZAm58yM2bJjCONTT+zkmRupwZ5IVdgJsXJ0g2Qi6r4zPXS/Lz81szyxXrS3YygTwSBCCx2ZsvKwH1tNGFdwkTneEZ8jUHN/xTsALLcTf15L7/oRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdYVYhXq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34374febdefso954093a91.0
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765523426; x=1766128226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
        b=kdYVYhXqwt4Vp7WzR2Q3Ynwt+4xcxM1ONflrrKsrY9nMGzVZdCkhv2dfB2w8mRsLID
         9DuTzfN8qEdSvSjMfhTr0SBGj797Lw6iCvZL3HCY9Wi+0eYyP4m8tahPt2etrSpnY+Ff
         gpz5kuONXKwpSsW13HeIkzbqyUNkpHZqBnBkvhtdwgSFmMX6ClB7RLMMs5eTQjpi3qBa
         zBRFKybMsPpTRMKSZ/TCHmEnAM9Ft+EggdE04lSqtrOk2LNufzQkhpwuhYj4b/n53GZp
         iYplcDZWs1xOcuzBlq9UtMcx25iGatvbMu1ubh+4gTDKxXFLNKj4mJ4a/AzFkheZCnxq
         oRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523426; x=1766128226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
        b=ajAsSIyzDJGUjlsd1HwHKAZOPk/F5evMudFiKlCj+bHS6o5+E+sApj2yCUxSyx5saw
         FblSwSQJD9V1w8oclouC2LMt53XzQ5ZJloWFXwyPbWx/13xEWSjKLtT57iSst5jzIM/0
         Y+HCldqNPlMAn4mGB0PA89HkBezNnkCsXEii0tHhp2Xnuy8h6VgZ7+uEMNDHPtfMAN/7
         Sr6OjMmiZkQgYdWzOOVBaPt1IHtlutkg1OlzoglemuUMcIMugeygzHj68PXmGxj2DdZR
         uClvQq4e7lzwxzogebhtemE7uNwryxrVATmnntR8LNma3kz+mHzFDBcEIQz3wBNOURgJ
         ZF5w==
X-Gm-Message-State: AOJu0Yzb+5PKQwkrCC2Q4noc5aPhEW6msWsFvxrVFXr2P37jnsEw3CZq
	cDoHbAoy7eaa44cjAPbnpKhEKwoJq/VtE0pdiCy4J4puQ9Q4XTMyuYou
X-Gm-Gg: AY/fxX7FGRmA0JQxu0Krjx0ZpA9xyF45BQeQ2uMv0wrWNdNGCEGmgUfkY++ciGjqy+b
	8Ul6XcTTnKNKCeBQD6aqcIuEpOhVg8KzRcn2g/z+JZ5f4NxfuMBa5r3mHdMeMZh2Ch6EMi0s8UM
	i8cPkO1r6CUDRGMitnOJXYS6REzApDbIUSIIqywW7Q0wc4+oQGP3iRaMTxZ5AzIQUG/jRKT/5Af
	uiNonbERDrrn2qA/5mrWGm5YFO7UJimj5Y/qQzbw9ElLJyAElv+Rpr8otOfpn69BFvM/ouP7tjH
	f5+2J6F6geXiEa3lCnw9w3KsaFH7Et11hN49M++rrbKGfbi/rLtrssLBRMoNL8JaVILxsoe5Tig
	kH1d1zfeANKPOChOv7FLn9BQv0hCyIlgcxCJFAUAlKYRt/kxrbSCBFNKU74RcSazux/WSJZVl/6
	hf9D504oAkJQYoHyFQmvg9297VICSWgs91ZqrfAp6b6Uc=
X-Google-Smtp-Source: AGHT+IFABMRkw8oyKCgA0tVnnLIaZDoEoQW4VZmuiRYNtTWUY/AN8gGPDAFTfjKFmICcMWMfhDD3Cw==
X-Received: by 2002:a17:90b:3b50:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-34abd6b5d46mr1284217a91.1.1765523426298;
        Thu, 11 Dec 2025 23:10:26 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2aa5c8sm976435a91.15.2025.12.11.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:10:25 -0800 (PST)
Message-ID: <bf7ed4cf0254fb3fa707ad49f3b2ed0be6b500c2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:10:19 +0900
In-Reply-To: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Increase the lifetime of parsed BTF in resolve_btfids by factoring
> load_btf() routine out of symbols_resolve() and storing the base_btf
> and btf pointers in the struct object.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


