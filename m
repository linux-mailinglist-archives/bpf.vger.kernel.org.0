Return-Path: <bpf+bounces-30874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5658D408A
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C54F284691
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7A1C9EBA;
	Wed, 29 May 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5dzknKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C81667EB;
	Wed, 29 May 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019597; cv=none; b=AmoK0PyF14DfZvoPgsGswirZ2dfrvw6SOQoja0ijTr3HH42hGDiu9WXPnsmJFRcgKHndXtvaHKbQZOWTfNqUczzFXnsJKboPjii/6Eb4l9f09cUws1WXG/Q7R34W/Dha4nlOlBp1A//4c2MPSBPId1oayd/XQwor8KeDdAEh6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019597; c=relaxed/simple;
	bh=oyFIqEg5ZHqGxpxppH6pOXHhNaBV7a5BVW45aXMxU04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cChAy58SO6agkRw0ye8G0CcWMCz/XADt7AYGWWTOypWoKKnwc43gg2swtq3wawg9JP5FF+FxSlt/MCeyJXRLVpJ7FIGSg4UhY1RXW+VvhXGsTgC7KrYlQybaJ8A3k1jjvkwbPZSmuNFmh24FLub6Xf97c08IUk7Hzm3woW2QJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5dzknKj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35507dfe221so113418f8f.1;
        Wed, 29 May 2024 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717019594; x=1717624394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyFIqEg5ZHqGxpxppH6pOXHhNaBV7a5BVW45aXMxU04=;
        b=K5dzknKjVemx5BoWmzfBeA0B0a3joLgaUt6OijLUM+ShJopAjuhpGoip+Ckq3onV25
         df26pXKssHTUOILSFWI0fis7PN24o7si1WwgsMuecIpVhFwXFuK/NYwzjRQiQK42gRhW
         dOlY9mgHWQmuclbn5epRX/v6Au4EikNqU7RHrhzaerPutdmjYhY2DTeklvARQfBVpVrJ
         dmwX59csmPcTLHfn2OS6h5hydLBnXcPwEnVLY76M4TvzDaJ3HxAVw2d64wU13AMc9IKs
         Wx+Zg0MJ5VemKD4Lz21LXDk94x75mE2WiW9yc7ctU/ucF1zQdkIp2sI9hpYKv7N24zyC
         Hu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019594; x=1717624394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyFIqEg5ZHqGxpxppH6pOXHhNaBV7a5BVW45aXMxU04=;
        b=dpGf5Fe+JAV//BLQ9UqxmMp4i0QfhrlKC9/5gmhwf/XddkXBoFy/U9cPTnGnIzygkY
         tu+8XzXJPK2tSPIu0aZsj+kBcxGHKGc6huRLay4NKFjtrXlvWub4Dn8GdIKc1m6B9u+w
         GYLjwWOOqH2SRflDsN6CXlB2rLugvQFdfMQMiWTIAukkILjb74t2IZz7yyFxhmDLr0PP
         1ka0wlEo7Fg4SzGk016gJvWoduAiBXRUIEDHm8BSxPGPuj6WnHEVq5CieXDE+kf/xQgT
         pg7zt+tgq97vQQKCWIBhi/bPK1/AweECZwL3DlrV8K+ek7GlLUFty7K8irQaNNkrRRjm
         ZlxA==
X-Forwarded-Encrypted: i=1; AJvYcCW6BGaDS7Qo47Ok8yK/XgTlJKswjXuba0eMwns7c1whCI8tn1+saE08WFgOxckJdqsq2MmzXJCiD3zUB4mWU2N5lqgNQ+fh6ebvID6x6p4x7O8b/myg6ov0UcEczWUmOYtWYEQxKwUM
X-Gm-Message-State: AOJu0YwZyOzD09Q0wkss8byFv3xtTpj5ouHxGeFdHjSyftj0PnJf/5HP
	aU3OdUvMPlVkOinXa9CCkBGSeglMmMcTCL4LPISsyFcHTehkmRw+LA+CBFO4WnsxozrAgnFRFvZ
	znjivLxc+YdmEw91oQ3eQCiEVEi+aEQ==
X-Google-Smtp-Source: AGHT+IFxSQvyEgkGQpK+qlE4c5kmPromFru7Y1V/80+NkY7erAfKldAzbD5wMiTwc2/hZwb4og+nxOGw0etzAmYD9G0=
X-Received: by 2002:adf:e50c:0:b0:349:bccc:a1e7 with SMTP id
 ffacd0b85a97d-35dc0092445mr391102f8f.19.1717019594137; Wed, 29 May 2024
 14:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716987534.git.lorenzo@kernel.org> <db46e0e2abd192c7db498046f5ce170a742a0e95.1716987534.git.lorenzo@kernel.org>
In-Reply-To: <db46e0e2abd192c7db498046f5ce170a742a0e95.1716987534.git.lorenzo@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 14:53:03 -0700
Message-ID: <CAADnVQJ_Wur5bmMsgOC7YvZ-D5GNzO9Fm2_4=L3eYkuQVpcg8g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] netfilter: add bpf_xdp_flow_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, donhunte@redhat.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:04=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup
> of a given flowtable entry based on a fib tuple of incoming traffic.
> bpf_xdp_flow_lookup can be used as building block to offload in xdp
> the processing of sw flowtable when hw flowtable is not available.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

lgtm
Waiting for the Ack from netfilter folks...

So we can land it through bpf-next and pass it to net-next
a week or so later.

