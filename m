Return-Path: <bpf+bounces-64222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68ADB0FC80
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CEE17D65B
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA226B748;
	Wed, 23 Jul 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhp6tHQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187412E36FB;
	Wed, 23 Jul 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308125; cv=none; b=WP3Mtfi8FbuCogo12UsVY3RyFyCTRASVi6oztGNEpcyF1Ho6BM3JXt115hmVWtt7mKk6V9TbrMRhKQ0H5txZryINHmyWqjzUSwC+3ZJU+v1zuAwIFfYVwPWP543NdqSve6djB2aFYGA70AQlelxf4B+AqCirIRbdcq+3z8SXMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308125; c=relaxed/simple;
	bh=+bG5B5KYDHC0fKywpuXNg09YwW6tT95crCpwXy4hLlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jlw+eT5bHGEjwtTHqq2By2oj/7C5z0y/bi2QN3nmYpp7ctwnkArt0MfJdzwGJsyhOnP943C0cpsh0KdK2aiC2ig8F6bNepwlaRYr5ipVyEas45KkeaMIcznSciKZrxFOc2ZLz+QM1MV9VyiLrLgjxRBiSe1RxlV4Hh/FCZRK7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhp6tHQ7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-879d2e419b9so290987a12.2;
        Wed, 23 Jul 2025 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753308123; x=1753912923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+bG5B5KYDHC0fKywpuXNg09YwW6tT95crCpwXy4hLlI=;
        b=Fhp6tHQ7xrA0NiBEgxPrS//8lUekkSRTbqOdA4GIuVQlWYh6JziTS03P93m3Lm2fvV
         OeogI3a/8Gk2nfnXBeDDDQWYc6pwC5Jd/dx5iYmIsF4CfONhk2mev5ZjIdKMXaGlaL6O
         gAIkaoE/U7sDGeTxFrFaZ5lJflLJVfoebPowp3BfCQXRPye+11RACkgreYUAuQqm/bdg
         ABUkCnI4B16onEJXwwrDxNvcEPyi6ARwOXc5W0yldEUvFeJnZ8RxBS+j7rsqAy2GmEkw
         RaWZ2lek1E098UWGriVoyRMmci5G+DwKJM4WHAsq4B/1Vd/szEfMA5gfZWECQpvunZsd
         p6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308123; x=1753912923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bG5B5KYDHC0fKywpuXNg09YwW6tT95crCpwXy4hLlI=;
        b=jg0Os2wXWu05q1JQ18KbFDUHzAScqjqVMK6egZA/AR9mYpjO3CGXA02LKRTU9fLPHw
         USv+Wy4sYtkgDzeVnGr/lNMZpkOHHxRj26Xlt2UcqRrvE15BkO1aVxt9mYpPVY42Bj8k
         FkZ4T8LusUSgm6jbswcfYwGXccIOBSgeg4IgOxFFQVwXeL0RToimj8thN5xSB0wrdsNl
         0lS7uedh5W5PmtyjntoNJTaM515EZdpbXYMU41+E3+KWKZrCQVQrwX5T5nK2tT8rXtPC
         9PmC7isKaOYewdY96LJKg1Z5uSVlXvMcg89ieyA4ti8mp/kMB4+B2OBKuPz0uYluotkw
         VHaA==
X-Forwarded-Encrypted: i=1; AJvYcCV3F7jXj4YJHxjSe84saE53Pbw/ws5HMUWlf3Ab/9Nc/cSSum0JMDZO5ypZozbYOHgQF78=@vger.kernel.org, AJvYcCX5pvC4tE15TRuV14DiU4/zqbk/0OGPcP/yGwX/yu87wlFifobCsHxu7zazCxVpk/JBkkCGoqna@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxx3U0RpWPeFbotEm7FEOiuLL+mJFQejnnRjOlzP6n2JdUdPn
	EpAzEis7vldJdjfZUh1rH5+12/KOxYcKN2sAEl0GRTlSreUNiOjkfLEe
X-Gm-Gg: ASbGnctWLJhFM6MzOgZhR0WjW+pKnArvIZ3hHTPONnbCWhICHy52zsHaMuZYWey3iJ+
	6f/1liWwBg/m3PFDvnhWsbQ5N+uDvRnxhLsr1vqWMtwZdSRMUS/r6l/22aRu8OZwU4qAjjMAZEc
	V9St7+uasaMzm8Aaf7nEEz1/WDciKjZ6w8MPIEIifTqBlAUqw218phgv0ieNIdmMItfxcv8Gdd4
	ha1MAZG8MwuQbIDQpv3weBPJMKa+aDB4NfRlzpNeZXwI4TsM+jMhAfs3ICOWeIQTlK8ePPeD1d6
	AQWGiQ0scuFRQdo/zskopmbnu6dHyBmS921w6agKLLpdu6iVNhm5kO5/eucj3IdQVVHWhLueJxh
	ahB2/YrnuqP93UUlCRfolXoVD3cPoWxvs92U18Q==
X-Google-Smtp-Source: AGHT+IEzsQDVGRwhnEx/1e98tBvTXbjplMlw8AEYNcf7PDc6qzCYtspqaMInRK/nBoIiR17dAU/Udw==
X-Received: by 2002:a17:90b:184d:b0:313:27cc:69cd with SMTP id 98e67ed59e1d1-31e5071cc7dmr7014988a91.12.1753308123228;
        Wed, 23 Jul 2025 15:02:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:c80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e639f6761sm62433a91.13.2025.07.23.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:02:02 -0700 (PDT)
Message-ID: <a529fd9c5624a0eaf902f993b94aa5defdf61cdc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Cover read/write to skb
 metadata at an offset
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
Date: Wed, 23 Jul 2025 15:02:00 -0700
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-8-a0fed48bcd37@cloudflare.com>
References: 
	<20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	 <20250723-skb-metadata-thru-dynptr-v4-8-a0fed48bcd37@cloudflare.com>
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
> Exercise r/w access to skb metadata through an offset-adjusted dynptr,
> read/write helper with an offset argument, and a slice starting at an
> offset.
>=20
> Also check for the expected errors when the offset is out of bounds.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

