Return-Path: <bpf+bounces-27153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF98AA1ED
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BB51C21D41
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A069917920C;
	Thu, 18 Apr 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V5wkZh2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56F15FD07
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464352; cv=none; b=MKrmlEZkZzF+w3m+ZX3tQ2A3BEb9X+xdXpVdMFY1WPlSAf8wUWsVyiZSaIlgel6G5NBXSzucYYIWxCc7UX1e0PMsQHP2Rn1bFcUjVsZo4a2uIivQbNdQiHW0fpPQNdxNjuc9D/c9cUh8sEqEu9w2rgK8DRmv32syXiASlKmIPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464352; c=relaxed/simple;
	bh=TY5RGHkR1B7VcpcfxqCvb9vWA9VGta9DEB9gTtPVOa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n5Y5uxo4XbTaNUKSc6fqy+78kIG3YvH5xjQbCJLeiYezZOXRBjUAwRkQHuOWS7LL+4ISlY89paI6y1muYkznjuJeWxqG6n5WV+JHLgsdoHMBnF9Pl7d1AmJJYCAvLRKaHM/LUqP/vkGFuPD5Hirgo+aPnuKyqR+YN3k4yS51txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V5wkZh2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so1226408a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713464350; x=1714069150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUve054mJbbxeZoYsSoxx0U8HsMmYEGyCpud/vdlqV8=;
        b=0V5wkZh2FPchxVlnN+0I4E+UBTL5gr2eZQow8cgO9Xrf2ZN+hrpR5n1BBZOGKLQ0SB
         YyVSiH/rw6zeQbpt0fYY3DMmm2C9pnDxBsotkj7UOLd0AxFVjZvIkY0RILMK0xBDrzbP
         40DfmJzb2BWf3PA4s2n5GZAHyd2xwyHwkpn/bgMHXj59iXUIFmFTR1ZNVpQKT8hD9r6o
         U52VRrVzC0sCjFOPxbfKEMnHOh0ID4KCRwgUE4P2pvO+D799qvdN4FPsARLcXiyDOpAT
         PHV2x2KfF52i7NjdSR3JgxsMsky89KxkzsV/822XPlGlNrx2rWmIvSf79aPRiivTwh/z
         ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464350; x=1714069150;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUve054mJbbxeZoYsSoxx0U8HsMmYEGyCpud/vdlqV8=;
        b=UHcOzJCyYSD6vUkjk05AnwhKsLO9FAzheq6BDcrxgBEOjEUO5ebBA0vMXL7ghvNPgR
         GfpJT+05yPNa7tmHlH5pTVTi8p9XruaByyj/wOb5CWnpFquSPOegfaA0oDNRWleDwZ4n
         RMuUeV9nUQr+sautvEDtvyGXcqJq7+dYVAZUWnVZsRt2TIH8LzgwdhKO0vd+T5Fk5tZ5
         a9Q6/MoIZEQ//A01Nl96dhw3PsX5L5rT8HPyqy3SW4PCcUR6QG43sk1vXohJVxGdHWnn
         L/aEGAbKy7z/I9Vagklx8GkwcFDk7SLfM6uoVwPzq9LGoCLe5JLnPKyNWlJ7IHbb4V4E
         oxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzA154feibn1bhmLsQEC/24kQa5M6VMOeDpLaBy+BgLMP3tJh2jvKzWyB4OU+QveZhOsjC0vG/5uPLjw962spJLqID
X-Gm-Message-State: AOJu0Yxackl0gOBnm/xOZ3cBPRfh0S492jf7RfHrsRfrOJk2RkJnxmJD
	Fva/l51f40BkQwG6yFRpGqiu01/JVZfdjOWNffVjnl0+McN7++o6Y9e16LlQ9Jxc4g==
X-Google-Smtp-Source: AGHT+IGxDU7FDxGzk6bfcmDHyNPVZ5xo+1i4YxyLBmGSxyOwhMUghLftH40BiFVm20GJ86ROa2AHxmo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:6a97:0:b0:5dc:2368:a9f2 with SMTP id
 q23-20020a656a97000000b005dc2368a9f2mr8951pgu.3.1713464350052; Thu, 18 Apr
 2024 11:19:10 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:19:07 -0700
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418071840.156411-1-toke@redhat.com>
Message-ID: <ZiFkG45wi9AO3LEs@google.com>
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast redirect
From: Stanislav Fomichev <sdf@google.com>
To: "Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	syzbot+af9492708df9797198d6@syzkaller.appspotmail.com, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> When redirecting a packet using XDP, the bpf_redirect_map() helper will s=
et
> up the redirect destination information in struct bpf_redirect_info (usin=
g
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pas=
s
> the frame on to the right redirect destination.
>=20
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide wheth=
er
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, th=
e
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect=
()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
>=20
> To fix this, change xdp_do_redirect() to react directly to the presence o=
f
> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
> to disambiguate between a single-target and a broadcast redirect. And onl=
y
> read the 'map' pointer if the broadcast flag is set, aborting if that has
> been cleared out in the meantime. This prevents the crash, while keeping
> the atomic (cmpxchg-based) clearing of the map pointer itself, and withou=
t
> adding any more checks in the non-broadcast fast path.
>=20
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail=
.com
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 786d792ac816..8120c3dddf5e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_fram=
e(struct bpf_redirect_info *ri,
>  	enum bpf_map_type map_type =3D ri->map_type;
>  	void *fwd =3D ri->tgt_value;
>  	u32 map_id =3D ri->map_id;
> +	u32 flags =3D ri->flags;

Any reason you copy ri->flags to the stack here? __bpf_xdp_redirect_map
seems to be correctly resetting it for !BPF_F_BROADCAST case.

