Return-Path: <bpf+bounces-55461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4CA80DAF
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FB03B1F2F
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CD1DC05F;
	Tue,  8 Apr 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aP+dfGPS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E491D7E50
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121813; cv=none; b=YFANrQ4OOHSc1NEMSVRKglEbrRHbj6lKejSrpmEjlWCtoYQLEB2zt0EZVwMbOmb+TcQmHyFwLBDKVLWOdla3QoRHmjnkbxC/cjGM8VHkGw1HZKyvJDlbb1SkrJjdNALOuIlFSXgaB+hkNaLQLFdxWenEJ2j1fuesXpv+BsQdvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121813; c=relaxed/simple;
	bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usTqQPeJ1HxHGuPoKKYDIxDwlItwRD3LE8Ihv+sDGlsZifIJHyLR9qU8l3/ZsILbWXgn69XmdQumcKLMfuxNPu8qLCiU8Cn9oUbApTCq0lvxK7WL4xLwspEw1CvXSfKs9BTF2jXtAYrrP6x+N+PpJQyc7Lf1ls9IagDHy3UFjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aP+dfGPS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47691d82bfbso111629781cf.0
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744121811; x=1744726611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
        b=aP+dfGPSKmirZPV8tjGdr3KDeDyNcXmfHJs1Aip61R5A5tf+2prq/TK02tGnfLn0TT
         +fgVZvYgflJyv+wh2El/jm1zMoHTH1lCNd2h6dHcqWSm5NM8/QK9c8yPLJIa75esu0q2
         y1N6SD8saKUtGGfNgHt29N7ph6ahbQhbNBwPZwmfRz88Nx6DeERpcgc5Gu1xhY7tyFd1
         jADaiI6cebEcthFF3zrfYDgZP8VvKOT3D+e3gio9pXCeKvbB6LiEI55g3YZvy89C7X+h
         QKfsavgYPxJuLmlImr4m2WsK7VFdxuHJgVXwVsdSAHmRAdrTQmqV9zue7y52ZeBcq0f/
         GFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121811; x=1744726611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPJ5DC/qJdNwC6BaugmZeWV0dPB1/Q4W000XRyMqt98=;
        b=D9fawrL/coEH3VGqjAiVY/kLdWDj/NTQO8ztRpXql1zdehoYPVBxFGTPo6BTHBmba2
         1LihDMI6Vgji8c6E4AL3qAVhFAHt0jalPPKlXBExgOkX5c2Nn1MW6/Us71x+QbURMoNB
         UnRqU9IP2CI2fOii+6EBuUHyZ44ZvEVldeFDeNDhcsH2cR2Gf9olx+LuhYM3aoQhNSKw
         f+A60HvFq3N9T/QwhsQweeNGUjpqupo659YzbyhQHWR3F4p0ipdn9JTBni2OGFPOwZXc
         kVb46ZK4lU7kbaIx+rSiNFoweb4ZFkd7qXWVmz1QXRQGrGVYVikuh84zJOehyi3eLs3f
         5WtQ==
X-Gm-Message-State: AOJu0YxJKnCJldzUDdqBMBZ4li3dXyFlgpnDYqrFkXtL1tR0H2Jwt+KD
	I0jgnnHDjHNLpUBdJiMIZ0VHZz9eaGL1XIqCyRzCHU3ELJmRWGk5cP/H5RX3CRV8vyl9DH5TH1I
	iEYg7dtO9O9PAXmMrq6DA42bRl8WA7E3hR3m5
X-Gm-Gg: ASbGncul5kpJj5y7YsM7/WDO/Z6+l1MwwD+9Bek0YsQJdZKhNQJ8Yp5+i6SNh1YJtyg
	04ERuq4rPInu6RDh8xT4zcSu+/eQD9dbWj1G+RuKpUVN6ukbU4RYxlUeQ2PyoUgRlTpN75XuDyo
	lm1+jaoXMPk1L++6DnwTohfTV7Z/E=
X-Google-Smtp-Source: AGHT+IHUjVyFD7izpuiUpvmNnf+FDUH75moOoGezgMNusboh88UNsivDmQCcYc+G4RahQGt7lDjXkGMaNSEWhyim3Q0=
X-Received: by 2002:a05:622a:20b:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-479249bd49dmr285747491cf.46.1744121810231; Tue, 08 Apr 2025
 07:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407140001.13886-1-jiayuan.chen@linux.dev> <20250407140001.13886-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250407140001.13886-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 16:16:39 +0200
X-Gm-Features: ATxdqUGjCQjPmmLIhcLV4VA-4isczJrM0_7BiR56nk0Heb7yBGKhT8w790UEEEE
Message-ID: <CANn89i+a2tbuEJgzQ-yvSt-jqXq6S5y6=C90jNB4QXGseg0mDw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3 1/2] tcp: add TCP_RFC7323_TW_PAWS drop reason
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Antony Antony <antony.antony@secunet.com>, Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:00=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> PAWS is a long-standing issue, especially when there are upstream network
> devices, making it more prone to occur.

This sentence is quite confusing. I do not think PAWS is an issue at all.

>
> Currently, packet loss statistics for PAWS can only be viewed through MIB=
,
> which is a global metric and cannot be precisely obtained through tracing
> to get the specific 4-tuple of the dropped packet. In the past, we had to
> use kprobe ret to retrieve relevant skb information from
> tcp_timewait_state_process().

>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

