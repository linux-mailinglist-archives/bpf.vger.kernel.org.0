Return-Path: <bpf+bounces-51727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27FA3811E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759611895D2E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B795217737;
	Mon, 17 Feb 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMxQKzGr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860C218587
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790017; cv=none; b=ukxoTeZAmmhqwY/pAPHbiuu8y6n/QCIlG9qwoSuw2xtG7LndNa7/TuJEdyXku6DLqRII8WAwlWUApLTOUjqcrkw3uCw9Ty4NUI3ZFlNQobUJyRp8RPdps+r7Wwx9I6bbCypEpHFHDRSJ6H2a0ImPSUAvEVAQQ2cnG5yC4uHuo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790017; c=relaxed/simple;
	bh=dR+rep/57L3EWMjPfigCxhlyG9swRKpij/Px8i1KymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc7Il1Aba4wstBaFQrWGVeXUSs1KGQHwZbHWTG22rU7QUsV1XcCrFKmQ18AmbnjEkdEId1bee6xF3GzLw9XNWqQCbJ7DZWm8qGjFk84rXMBuX19vshTLXIbD9BIt+ASgrj9y4NyD+/S3wPVdUnjatPd704RRt3F/Au4zSrJSWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMxQKzGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739790012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqQYFCaTchuW6lwmeMd3sJwEjkrnpuASKdjJ1fvZwRE=;
	b=XMxQKzGrFzfPk1/aGeIeIuJrV9hPxGsKIrf85yOIn4b8JR1fE7QTrXH1ZYCcxI8UduP34L
	4xQarnSPn2/xRcMh0CbLruipE+NjLCcnQyO72P4heInOo6WP6Cd5zq0bbbltC6RCBaR5IG
	d4Q7nygeIZglRXVzwFiJH6rLDBRmCAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Ckkm-XTIOvWSpgWh3t_ZTw-1; Mon, 17 Feb 2025 06:00:10 -0500
X-MC-Unique: Ckkm-XTIOvWSpgWh3t_ZTw-1
X-Mimecast-MFC-AGG-ID: Ckkm-XTIOvWSpgWh3t_ZTw_1739790009
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so80826f8f.2
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 03:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790009; x=1740394809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqQYFCaTchuW6lwmeMd3sJwEjkrnpuASKdjJ1fvZwRE=;
        b=D99tX5/aTt7o/r2gIYuwKgu+2pIo2W7XHsotWIQWFPXmpXk+GM1ac8pj3ne3q+DiCE
         7+szWVo0FPmqNcuB6UmW13e+etPS22z61muTcSkSsJgwYh6wTehmEPIiAVznDGJwhGRR
         xYfdcRanq2XStSiP6RU6bNH6R1x5SmkIcRifqLS7Y6FyiFKE87H/PGzCo76ou3zXDazT
         gfc4w9BS3H7wFGYlnvnOZaLEhaWoxNO4Gyq9A0zCYgjOn2WPipMBowgKQpmtZcLCgCLF
         3V6Odl3BFe+706ote7e2yERRV7YcxObeE87Za7QVymZA3uZcLAaBcPbir8mckyjIZz/B
         P36Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR/xUSpFHrZb7oglB14QPmErz9z7hXfshclXymF8qfNEUANkQRdM/hr4JI8aG4pwqLL7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2XnLpEEIz0gKfgVytnllBRwNknF/bteYRIALYZCdYCsO6+vJ
	OCdXnctNo3NCnpzsNhhE250loBlQ9vjYDnhbwaRio0+sHXhOCiQlZDChsw+ds/WU+2BL6o07LeJ
	znMpwPqknUTBRpJoOgPgGho2o4xWCNZM0wvMfr03S5swDXUXXOQ==
X-Gm-Gg: ASbGncvDoYOmeaaacP5b79vpQqetj6XvKpfwvk2iB6sM7XWOEbqfWFfb2S/OF5Pddvh
	z73ZwKGwadKpJN3EXIWHyTsO001KXAbrraWdCZQZgkzbGbqsx2LkRME6gKRco7s0vVRiRh6Uzvh
	SBVCXcTenga8RdHWVgqbsoXmwazTbTCTQRfJVU63PrtEWl8Z/NlgMGAw0QUhKNhO2d/mbF34nYe
	vS3orcKYjKgAIKDIk1lAaLwimm6Ji2td+CvuG0ol6OMe64Ywkocktxi0dXMcMy4uTmBQ6AzFhDd
	GjEOk7Bc2sxRllzANwnMgaLVoPJg3bf/wPFxK4E3xn+i+Wpi5FM+2g==
X-Received: by 2002:a5d:6dae:0:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-38f3b41cb92mr4017234f8f.11.1739790009222;
        Mon, 17 Feb 2025 03:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfTNMRvG7FzvFEHCD6J1+67oFasR/KEYRPfOfLOQYRJI8pdpwKgXLv4Rl4Qdj++N4APKt7UQ==
X-Received: by 2002:a5d:6dae:0:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-38f3b41cb92mr4017163f8f.11.1739790008461;
        Mon, 17 Feb 2025 03:00:08 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5b40sm12047690f8f.68.2025.02.17.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:00:07 -0800 (PST)
Date: Mon, 17 Feb 2025 11:59:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/4] vsock/bpf: Warn on socket without transport
Message-ID: <ygqdky4py42soj6kovk5z3l65h6xpglcse4mp37jsmlm6rjwzu@dcntngtsygj3>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>

On Thu, Feb 13, 2025 at 12:58:50PM +0100, Michal Luczaj wrote:
>In the spirit of commit 91751e248256 ("vsock: prevent null-ptr-deref in
>vsock_*[has_data|has_space]"), armorize the "impossible" cases with a
>warning.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c  | 3 +++
> net/vmw_vsock/vsock_bpf.c | 2 +-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 53a081d49d28ac1c04e7f8057c8a55e7b73cc131..7e3db87ae4333cf63327ec105ca99253569bb9fe 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1189,6 +1189,9 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>+	if (WARN_ON_ONCE(!vsk->transport))
>+		return -ENODEV;
>+
> 	return vsk->transport->read_skb(vsk, read_actor);
> }
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index f201d9eca1df2f8143638cf7a4d08671e8368c11..07b96d56f3a577af71021b1b8132743554996c4f 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -87,7 +87,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	lock_sock(sk);
> 	vsk = vsock_sk(sk);
>
>-	if (!vsk->transport) {
>+	if (WARN_ON_ONCE(!vsk->transport)) {
> 		copied = -ENODEV;
> 		goto out;
> 	}

I'm not a sockmap expert, so I don't understand why here print an
error.

Since there was already a check, I expected it to be a case that can 
happen, but instead calling `rcvmsg()` on a socket not yet connected is 
impossible?

Thanks,
Stefano


