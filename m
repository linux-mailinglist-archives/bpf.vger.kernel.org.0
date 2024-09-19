Return-Path: <bpf+bounces-40106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C741D97CB24
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781F91F24B94
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361E19FA72;
	Thu, 19 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdUtEPUS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A21E517;
	Thu, 19 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757030; cv=none; b=lyBm10NvcYxi6hMyNA16/eGrUC+T7cQN8h8ON1RwXTlkc8WMC6l3mEEz9r9QobetkZDo+OGldiQwbbgORdKODToK/mSQHYG5T6uUslycBzAB9WiR2GilbQR2HuUmQGbZOBP6FCc+KwXBUFElGZoi+Vextz0PReMbuKoBy+uEruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757030; c=relaxed/simple;
	bh=tKvQ4uAvdY25kkNNbkFy8qUv07VfNMSDnZOyg4vWIo8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=nJDG2olnWhjCvTrnz08OAh+pQLty4knm62IkwXoQp5WMg9tmYo23Wvpx9dlSE3ZqOQjjrxDl+jYt2/VcHYCGSi9GZ0b1bX5ZVttdcAUloEaRTN5V6vEDSOea+W6z74MzXZjl+dXKhIYM5FUwpU9sHzlsOTuMYmWvKEeDDI4XAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdUtEPUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AEFC4CEC4;
	Thu, 19 Sep 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726757030;
	bh=tKvQ4uAvdY25kkNNbkFy8qUv07VfNMSDnZOyg4vWIo8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AdUtEPUSs7OgA9Wx/FZcX3iSC7kxQMrN/ENakhiAJShnGFlIiXKoIxsqJ6h48Rz04
	 DdBbm+awJmfPT841nq+hYBOs7dRkw32urrt81eWWqC3Jtd9IFm2xZ/55op28MGsm4A
	 USoQQLhvkRWZHnQKwjmhQZN5fHnAyLYs5BdJCj9STgIWhMaZpShw7oFY1tcjKj99m5
	 e0+xVl0L+hiLuCa8UwvMB7lZaEsNMQMx7bA4s4t12JS4LqIeL2IX97aQNdpxb80K46
	 q9A0xDWGW+ENJj3sJGkC0XqUkmCZ8T4dmoRK9oXibPscr041tGYQvy5YDUupLk7z33
	 RFWv0PtIsk2tw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240919094147.328737-5-dongml2@chinatelecom.cn>
References: <20240919094147.328737-1-dongml2@chinatelecom.cn> <20240919094147.328737-5-dongml2@chinatelecom.cn>
Subject: Re: [RFC PATCH net-next 4/7] net: ip: make fib_validate_source() return drop reason
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com
Date: Thu, 19 Sep 2024 16:43:45 +0200
Message-ID: <172675702580.6616.12370018117434278479@kwain.local>

Quoting Menglong Dong (2024-09-19 11:41:44)
> =20
> @@ -2339,8 +2345,11 @@ static int ip_route_input_slow(struct sk_buff *skb=
, __be32 daddr, __be32 saddr,
>         if (!ipv4_is_zeronet(saddr)) {
>                 err =3D fib_validate_source(skb, saddr, 0, tos, 0, dev,
>                                           in_dev, &itag);
> -               if (err < 0)
> +               if (err < 0) {
> +                       err =3D -EINVAL;
> +                       __reason =3D -err;

That should be:

    __reason =3D -err;
    err =3D -EINVAL;


Also this patch should take care of the fib_validate_source call in
ip_mc_validate_source.

Thanks!
Antoine

