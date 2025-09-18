Return-Path: <bpf+bounces-68735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE10B82E74
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 06:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397B97B9452
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68A274641;
	Thu, 18 Sep 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4l3eKoY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464B218580
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170876; cv=none; b=MWF9R5PgxYuLh8pdK/xXfPWJjDW243SoVq/PDmsClSHJd+CAsKQWsnhcfJHIvA8n4uh8LxC7+MxrrOATdA02r5B65xnqE5XfAOcr9tyFfcnMOozfSGIeVh+9AcBWQ33dFDruRvKdsS9/b1sFa4Uj72Eljl9MxQbWisg2wZuTdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170876; c=relaxed/simple;
	bh=/EotVPQ2fazO+q333eMMFjQICAKBRdVhGAXoakK7FcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKrMcIZm+8gB2IxFASb8vpMBeoUyyStIbZKkdVWkb9koCI/srF2sekY8711zN5cfi4rZciaEXz1znw7qlm0aKkP68xZFSAuN8pGFeLBBFnrMGOUbCswJkHneiwT3j2yOtRUkDF0kaqUFP4N4kAgkHcQR00kQde2XIbZBQA03i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4l3eKoY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b7a8ceace8so5904401cf.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758170873; x=1758775673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=c4l3eKoYjuDmUAFTsSr1mDFjNG/4EseR6OrYvrDeqeDrqt9Uk4Mj0CDVdH6kyTThpr
         4kMFlv1sxJNhLq6m0tOx19k9N9jTUuF9h3DZJtn2MkpXvxLIyKIXS5oimXB4CUQiLNhx
         VDZbJous2PRdOGps36gRUTTuRwqbg94l3tZOBSB/E34rJ/TXJ6QnjkVlAsvoUY0UhSs/
         tJsf/9rS0XG3GnOH2bwcHO1sQMEsaT/V+6Nt+WLsRUkhAiucb7rRzxuaNgv28b8/FPyE
         bTnRNF3ifIIcJexJHPD/Nu4FainRaoW+gL/iVp9Bicz+oS4YIWoQ69fRlDbowOIG4anF
         BSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170873; x=1758775673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=AgAEJJqjAxQerbwsb25b2oHFuTxYCfinO0W0J98oKmn5mLQ3MiFTyjLDMFGJDiNKV4
         XJaEB8J9rOfRfuMsxEgouTMVjy1UTJAQeiM3Bxy3w9wL4PrpLSiX4dlHu6PuY79J0z+G
         Qsr5PU3xXAFAvqC13KletsI7S2F/lRA3YzQny54Ds2fcTkqj0Ls+poqNEXr4uuxZInYJ
         xUMhuy9DRkMz3C3uJKWWkMwJp6vHvy4PhZdILLTUA7lPspaWnflfPvrHI2uvPB/1coEo
         001Gj8bCbAzErwfCHGTh2KlB+eAAN6L1hezzzgVa72I+OOGLzTG54ae6fvk1Ff5xv2mX
         lisA==
X-Forwarded-Encrypted: i=1; AJvYcCWWhkCRq2X7DX3Dxk+c4tR97rTWRC8FcpBCZA8wguaUl+IWyLRhs/bHJNffu49boigntMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJecnKihXuzSOfIAzeMPc/hi0pCheVgZHz5xLofH4hL5//kHJW
	DbkEAjGEjXiqm9TkaK41inta4iIslZbZ0cF8iN3AkAkJjVr1SZ3fqYh8d/bqQeNY84lLICp1PVj
	16HzMoBDe3iHhEubYZ5cAZibF6qmcrmJLZn/btAxB
X-Gm-Gg: ASbGncuFMPVvMsct6YDSh8/p9DRDpZkSwcCO/iIBUiSAXmobKLz//4RttkYCRByGcSj
	bM5Yj0qTp+MVGu8qrci64i8nKhWB/8En0jzKbAtRGNIO95peRgXtGoIDa8QlyFPL9Z6sOiUDEBq
	hlpuImsVuqHYsYYjWzLbqeCXbvDl8XH4faQOZdE96dadU3L5OcSFa6g3KYIH5f/GfDhpUO6Jl01
	ZFvN54HGICEdSOxVDNme9w3IaTDYjo7
X-Google-Smtp-Source: AGHT+IEE3vW50mN+g7sjB3JgnHPpFDaaYz8tXLvVhOdGDaDQ1ipJAp2C5Ss5TYurb7YYRKBrUGBk9/H1VW7xYygqNI8=
X-Received: by 2002:a05:620a:710c:b0:80b:b8aa:5c44 with SMTP id
 af79cd13be357-8311334b681mr607648285a.39.1758170872886; Wed, 17 Sep 2025
 21:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com> <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:47:41 -0700
X-Gm-Features: AS18NWDnsTzobqovaqJgXSNsHC41dTN6DzbIFMvP6OalmtSpwFDjRSKr7Mn4RAo
Message-ID: <CANn89iK9Ro517nbmNTRfOr3q5-T7iuJUN1QXU2p_5CWKE1aprw@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 08/10] tcp: accecn: AccECN option failure handling
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

On Tue, Sep 16, 2025 at 1:25=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

