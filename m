Return-Path: <bpf+bounces-64220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9958B0FC65
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999E57B6EEC
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50C2727F0;
	Wed, 23 Jul 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdk+C9aH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511326C39B;
	Wed, 23 Jul 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307924; cv=none; b=KFajO3ixM1kwuQ5iBSr4c5DhGKfaLbmqI+MMjcFxrOMKQTzSqeAPcZRql4q/DKEhJY8ufC1sQP72mJs/dgXCp7IDCK83la+qbj9Z4yT9/U/IoirSMvP8AdyKa4+QiOH00QFStuQMZGNt6DJjXqVWiF8E3z0YtvwujuuHBNAAqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307924; c=relaxed/simple;
	bh=vvQNuzd/90fjryU83rqAW0G/i2+2KfayvVSsH0PGeXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOf7T//XaAGLdvp5ia73Gqe3sFDElTyWhZJTM4jdoB9JzrX35gw5oMzo8P+Xt6qNUqmy6JgpjN9LR6wMg7V/ka0cf+MflshnkGueWpl90gHoZrq9JsRrIFNs7i4ob+rr//czE5oJzDQuMlOHh28adXqr0TDqZqD2iU0i9dG2+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdk+C9aH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23e210ebd5dso11471835ad.1;
        Wed, 23 Jul 2025 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753307921; x=1753912721; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvQNuzd/90fjryU83rqAW0G/i2+2KfayvVSsH0PGeXw=;
        b=Hdk+C9aHLE2P0G94czm8WAGnQNT8Hm1VAttPI292OkqY8JzHhpSwl5YAV4PVee6YcY
         wsQOOn9o89MvyuIE6aL+vUbSCy87HfjYw1L1L7kZqyj6LMGgHRNHbVJo98vT179rG3zu
         DpQCDF/gqf/Qtfj9UKwZKXJFXqnKawYbIvKVmFTZOs2SO1u+zL44Hi60ubI2uZyImxp0
         GcdciSxzBuPJnVAX9qHAIgdk4OKsWvErIP7MriNs2diaODR0c48y93/P7h2WyPl3HVNr
         0yEewFSDb+ZmnFlZ+gFH7oF9P1Ls5hk7MIIAlg5IKnV0xiHxWaNej9hxkyVnfZPMuhBE
         1b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307921; x=1753912721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvQNuzd/90fjryU83rqAW0G/i2+2KfayvVSsH0PGeXw=;
        b=aS3jEl+Sanu6yCfcf8iA2T5MmCsjVXwCdPsSBTVEQK1pG70/LcUaglDqa+jM3ALy+b
         ySAuF2WO54KuLa27s5rXJO3JGOrrftE2YU0sY6EyYoJ57I2cgFgJuXda0lNHw1WnRbem
         YkdB9wnpdhHTZY/YgX7+drYwvO7jQmne9osk9Wxat5qrVHjDrbSiZpMl5a8i+StbiS3s
         FkrBOjy6Bye4DaQ1fAI0Zj9H2CZucFxqopVq/c0MKJBJ3253w794p0ng/IxnyuuOo9nq
         Wl1nB0ex8AOxNstVMjFoR3ACIr86OVZCdZ5Xk+c4fwIjGX8/46cTHgir36/kEDPyU0k6
         sDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCULh28ifn7ODzvuOMKYGO/VQ/9omjR2GBmWsfxGqa6me0Io8L8XqTwrMdEAuEkWopFkdV/v07ag@vger.kernel.org, AJvYcCXEL3kcpvJJKpM/weAiiZfuUMjGqFQaVg8awYGb9BIb2+mDa52xuQg5Bsil6OHYLIIyV0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWy1nZ3rDTHyJDgpq4pH9LMRrvdJJI49E88NgFeEeqYxupIeER
	LbyTYK47MRPUmx/Ma156Y4Z4r4j56R6EduxNN15KZznTiRao2VddlwQ2LoGSTA4F
X-Gm-Gg: ASbGncvOVhOo9F2w6N/xP0OB5+ujfSFrsNU72RPis4zPUmuPwShnPVq1KxhChMnCOGa
	VwWE4eqVEYKXW/LJ8VUF5HeaDEdz6LUbD7lR7+2t4qoo5d81Asvo1+p656w/hV36F+bIMrrlIfX
	yjNzQd+gM8OQ1ivVoY/jkMGpo2x+Qkje3GTQgL6bo0JwxJnH4mooVfrxwk6keg+nN9nYTKKJN/O
	50FFRJHDMTMJeUWuRon70+jznbsv0jhfnTTQkAbUlz+h2jJmGG2ChfppRZXBHmld+TUolUbHta4
	nkeiZStjKUA+Nu0/q06G52hRuQ0cMHX6otxa7eVskIm5jnzvk8Kcktd/QBXjy65t76cfS7RE1KG
	wFisCB2KjC2i96CcgqdC4UcQJERA=
X-Google-Smtp-Source: AGHT+IFkBd0BD5eAOTD/41sW/e5I/WSv3VYclQKqhgj6HhJ2YJ1qoFfxQrQh8UWHsfKjutocRor2UA==
X-Received: by 2002:a17:903:2384:b0:236:71a5:4417 with SMTP id d9443c01a7336-23f8abef75cmr134041305ad.5.1753307921431;
        Wed, 23 Jul 2025 14:58:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:c80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f857sm497105ad.29.2025.07.23.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 14:58:40 -0700 (PDT)
Message-ID: <e3d50326c3dca79f5f9827b6b76385a880a92e0b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Wed, 23 Jul 2025 14:58:38 -0700
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
References: 
	<20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	 <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 19:36 +0200, Jakub Sitnicki wrote:
> Now that we can create a dynptr to skb metadata, make reads to the metada=
ta
> area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
> make writes to the metadata area possible with bpf_dynptr_write() or
> through a bpf_dynptr_slice_rdwr().
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

