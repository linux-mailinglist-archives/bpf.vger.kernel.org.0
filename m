Return-Path: <bpf+bounces-68096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B6B52E2C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8A217D942
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447443101A5;
	Thu, 11 Sep 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd/CHr04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F32E2667
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585912; cv=none; b=jVy3nDw/zScy3aKsnArzgcuK8YMu3l33OgbwBRscUdLQdCz4+vBZ2UXCYBngZWVLLqQWqAdBJtDymGvPyoI9m4n2fm4Vq0AwcwulukDZUhj7zX14ePDWfKHbUBWHyq5Cl3OEH4CVBgmeAeCTwGg5JAdLbH0L/MzWyo4g1JRsxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585912; c=relaxed/simple;
	bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZxH05n1IJ7BPuJUAweKw6sdD6kidl1FQoG9TPLPCyEg1RFQYm2PKVZmQDcgaafcYaf8tuPtftXDWfhJKpelhwCbVsKkEoNWLJPKnPWgxIbivQbsgQntTHn+IAPdvbXViyWmU2SutRJATNRG4x97BYnwnvE15nwXeJc24S09cdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zd/CHr04; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-72226768824so4965326d6.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757585909; x=1758190709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=Zd/CHr04NiV8NK/uaWUmoo6yfow/Cm0ZQqeugNK/LjKfDLdzQSmpFAYY9SDXNibLYe
         IHyaFVfLCp0VKbQZ+lsvYirwfOp6F5tBBVsAsjb/3lrtPf9W2Vc++e19PWYXIrS7v3eP
         psh6KU0eZsU5vQ698A5+vN9NAkA6YdzJwTqvolvRWF8TI/3OC1lbSHrQGkqvrLvRpRIR
         5LrWSTomqCnvN8BOPQn9yW1VYHfGRf2+uJs++Kg/o73obEGTwlg8keD793Z8OG11Ot8w
         jjkqgYFTCmoQwkBoUXGSi9ffUqopG843/7ZrdJXLqVup9U8qQlF8mZXUdslGaeR+H5FT
         p+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585909; x=1758190709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=NYR5MfSa4WxirRDrI1ohI9v1Bqf20sJqGlSDdHc1wKet/rjhxDkn1hI8kHLHBRF/DA
         K/jtCFVbp75d1ieWXKb24HRuPbM86SLgK9fQGmWJqeYI7KOnS50XF8KmXe/SpOdBvKEq
         a1KDY5SbpBsFn8B58oAcS3Ds3+7jxcIciQ4iCUCMinKSb04dcsd0Nf9yscsuDdLgRJk6
         fwW3jirbJvGoZqUj1b6NMkW93Xh4lwmOrUgglVh17/fOBReRTJDTb/I6YCkwgB9/VxdI
         CKVFMHRR3Nb0Q7HmgOyvgrHG8F10lC5u4F8lQa1nwsTrQ5ewUKwr46Aibh1PzixD3/qw
         FYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWg2xf6lHP/ktlyZA21Gl2cxDH3JE6hW0v8R9G5sHaKboVoyW8YkjGMLdiqXTtL3x3pcUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidbJ12ImRmj5i6+p9rGBtYXuvycDfaEmWEsIPNpw5elfeeXh9
	xteuUJTH98FrgE2yKcA9UQ9wLRmNCGY/MPAzRwJXSHB5A+pSXZC/zu06beTN4eF0b0gl14UahMI
	MCmXZOBFU7bxiJYvOZld8EgWWmiFoDQ+dCi+sfJ9j
X-Gm-Gg: ASbGnctq8StwFnvNN5W7KPETBajIQ6NGpbXgkFrSKqamZq9WE8nWLm8WwEpYuSjRCpW
	vKbQ8l/wz6QHjLGPKpybCMltob9jOAjQNKE6cCnWII1ew3C/R/vzfNTrTos2xNrLojoKu2KHYES
	D9SRKKkJ+AP3EZ4BfSwqJFKCuiFPagbE5knDbJgE9VwvNh0BmLAUPX1erT7x98uSd/7y44KkDq9
	vKN+SvKBamAjXvS9HzZZZpPyzyNxJ+CZUs=
X-Google-Smtp-Source: AGHT+IEqQMhkVh/lYGalDwkpiYZ6f35/G1vtOQ2l6IDxuZ/NsAD8i3LfdKsGnA8/soxwk9WffOfYsUldgmrLaRipwNs=
X-Received: by 2002:ac8:5e49:0:b0:4b5:e822:36e0 with SMTP id
 d75a77b69052e-4b5f839047fmr204347991cf.12.1757585908196; Thu, 11 Sep 2025
 03:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:18:17 -0700
X-Gm-Features: Ac12FXyMpCAA7q3vBOdalZhfapQxJhqhSZEIpQwkhEKdjvw-ONLg3xPKC40oLaw
Message-ID: <CANn89i+2=bNkkf89RysrYxb9DW0Vw9+jSg7FotqtaHZa7tmerA@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> AccECN byte counter estimation requires delivered bytes
> which can be calculated while processing SACK blocks and
> cumulative ACK. The delivered bytes will be used to estimate
> the byte counters between AccECN option (on ACKs w/o the
> option).
>
> Accurate ECN does not depend on SACK to function; however,
> the calculation would be more accurate if SACK were there.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

