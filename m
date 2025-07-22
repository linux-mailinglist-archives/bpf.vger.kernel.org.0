Return-Path: <bpf+bounces-64102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11359B0E4FA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4E76C8103
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13B285C8F;
	Tue, 22 Jul 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUKkRAhS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CD284678;
	Tue, 22 Jul 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216209; cv=none; b=AH79ZobLKOxkRRhpHLIe1zx0B4ba9ILlOi0lMF2SDKyvsdMD2PosQ7pxdsf0ojf4JORJJSrtsp8lsjChLQcUvPbJ8KqzHjY7KfF780+aI5jaBLO0FhiCvVpCuvw+n07pSqOYMFTaFm0Gu5GAoQznSpTPEoCzOsuA2yMRG0p/WHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216209; c=relaxed/simple;
	bh=F1ORnkS2ZRXD5Zafjm8DnqQVEDOZ11ibI9BgiW4IXtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4JbzCAwfaLfvOLSJcPimvCRJMu/uHED1baLWMFDsC7XUCtvamlsnYG35SV4CJRkAUHn1fm29bkbXf8EIMrhNHx2XlSZOQVF3jIThBpWuQN8KEUxXyFIA+444AnXRat66iSIMBozp5EDhNlm/acvAEK+FAByJ+LgkxAdg+fYUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUKkRAhS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237e6963f63so36038405ad.2;
        Tue, 22 Jul 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216207; x=1753821007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F1ORnkS2ZRXD5Zafjm8DnqQVEDOZ11ibI9BgiW4IXtk=;
        b=BUKkRAhSKsTBO/0zQ32qkaPRg+Zkf7OJquKf/KHSWY8EL9AYXVuUa50YYqlZG6y9yB
         90XJQ4k4s2CyBlPyn3JJYsExFuN6Mxk2d5fIqYOiukbtFoP15B4aGsUVX4SpEUftVTQM
         sZBjxoMnv0mPiHyokLIs8G0tcq5bjBw9JNeZdObeZs/S4VpH+K8bjP5bB7FcwI//sBW8
         /qYKybfJyLU2bBCCJJrXFI5vW/ALy4kMY2zPfYxWSfshL3gAISOuaafF9CYYv3hAXlpo
         OTFkb2B0Ml/LF91M74YztpfC7aX++wF/OvBJ8HsuiT5K6LF1HIFfp7JQ1q3mk44y027i
         sJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216207; x=1753821007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1ORnkS2ZRXD5Zafjm8DnqQVEDOZ11ibI9BgiW4IXtk=;
        b=UNqeEAvJD7QYOrHapT7LZsr37ALAqb76yTVH0gq3OL7YOZ6Xgo2bRpPIg+8Sh3ER8n
         TcVWZWZVA0NX8HJ4hPiH4NYCiqVfOLLUv5wOwIesisnulzbIqPu0lbZgqc53KEszSAmg
         ncDVaC2t0u+/il7+WZSh+VcZllmoC96zwGawQ0UdDRE5WeZy/C7Gh4X30hlsQuP4UHco
         94ysigdBlvAodB2wpxnDZhbsT8/QAZfq1z7uP9K1KXmyRmPFsFkyxwx0NLxfHlpp1wcv
         2/dqEEEGbGuFtfxYGHh/bpHq/SPnVno20yzI6tFq4T5KqieQkxKDDu7qyI0zU11Hw6S/
         kJDg==
X-Forwarded-Encrypted: i=1; AJvYcCUesG6rcL2P90CQri/weBUyZA0s6pe9w5H8SD/+qmQUELYbliXdszTstP6abjKuwSTMOrJroK/f@vger.kernel.org, AJvYcCUryBeW8vEXOFGzSK7bqck+syqBdam7jJ43y72QYkAiLthEK1Cm5GC4Bmzu3nVFtaK9Okk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknOf0AUJ68ia+x3VDY4bii6sIBnkop2tGm8z8Wqzs/XPIKQrs
	0Alsr8BjTHqNJZrNW0EaKQ3oZxARsgHiVEQh+x6JBp9YSK8l30IvTvPh
X-Gm-Gg: ASbGncte4/CYh2WBOthxcOblQKnFM2FJSt083hUfXrfZiWaVhqSw7uTuLqMcjTjeJwS
	kSnj4DXk7CGh7H0B0HTk+ZrPX1aW39ggqJidfPOAoRiU7LrCYvHeiFCfIAiQzwE0uARFUsfpZJ8
	9+b0V8WaOg1Kdc8POuTHFzhuUyfUh99T4rjnqrcifIyMc2IWgh68b7KpMvPj5gbfkURvz0AZ+XD
	JL9oz1K00+IfEt4Hbgl6Y2mRQzwqJ9tV6asZ93FOV44usFZT0lUSj/ugVc0yJ+ezxoL2sE7mn7v
	LprqZFjgZ8WaucG2HzITjvDTHrnT7KW02WUbLW0ikSuBT7Qm8w87uHrUGXwOFuwkPCJ2W+avfgk
	AdnIURuE1zEesEFBh9zF8JBG9dAc1
X-Google-Smtp-Source: AGHT+IHfitxi0LoViDqo2L2Y44f2y4/6nPw0DKh00QAmQdO5O8qVIorEXQvg8jvpDaAp//HManXZaQ==
X-Received: by 2002:a17:903:46c6:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23f981d24f0mr3951395ad.44.1753216207444;
        Tue, 22 Jul 2025 13:30:07 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51876dfasm47801a91.0.2025.07.22.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:30:07 -0700 (PDT)
Message-ID: <addca8ce8c3c51bbd147175406e9da84fbc9c1e7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: Cover read/write to
 skb metadata at an offset
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
Date: Tue, 22 Jul 2025 13:30:05 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> Exercise r/w access to skb metadata through an offset-adjusted dynptr,
> read/write helper with an offset argument, and a slice starting at an
> offset.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Maybe also add a test case checking error conditions for out of bounds
metadata access?

[...]

