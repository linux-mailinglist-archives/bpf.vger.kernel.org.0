Return-Path: <bpf+bounces-66209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FCB2F93E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D83AAC491D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0A322DD3;
	Thu, 21 Aug 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0v9oDKlh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85631E0F8
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780955; cv=none; b=OV7qyDnN3pY01cX1HyupbyK3B3nqn20yumrUl85VlZ+ZmJnSVf4G1Hjn7ePnNUQXr4cdW10bUDskUoKi8shiiXKMAhh7Jy1q7JU8TYu9VsbLYzjKySpBvJz+Vi3qgIH/k8im6jE7z6adj0kzdHRGM/29j1RmsyGQKdNTBCyV0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780955; c=relaxed/simple;
	bh=yP4uFd+CVN8QmVu0Qh7N2PPSnM2w3mGXDGkAjb/uMEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtFyRUd8HTugXRBmETwF/TL4mgA+xCjcdaW0NfLM/Cc9d5dNSvJwyiGcAL63GtYH34tU2hQeymTAalNHxumD+H2jHLJv78jrLczFNg78jgOpRsfmAUiyrKifz0zWpxqvK1/8KpvMtfkMb1cIsdnbupyfHtTweY9SUSKoP3FMAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0v9oDKlh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2979628f9so11319931cf.2
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755780953; x=1756385753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5528SypKxmfUKQp47IYx/CNrd7NN62FARpZB0q9InII=;
        b=0v9oDKlhRpjnuMvP16A2EZtSRJmnIUAzPrkFiknLNjiksyODNmtE5ZUHemXXP8cNVo
         +nWpxM4EhCNHrH+9ykjIKmFA+n0yQY/pFJ+4oqcJ33n8KqC9qRuBljoPXKKzSChHQPGb
         FC8PpKql0hhlMF1UPYzhYMnoUn5FlH+HBiKG30NYdYerqzbKni0ucCZVH7Dil/1Uheoc
         ylMPlpX9UXXs7hkojeuXmJsvCj+WexH49ki8M15XE5ZggqZVEgcC6apRqZfp3g/4zyJh
         HnLxGKxlkhfzI9yNlnc+OhrqjZgRJi5wKoHS9DV2dkL0OxCUS0mEpG1xKiv928QRi5Z5
         GC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780953; x=1756385753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5528SypKxmfUKQp47IYx/CNrd7NN62FARpZB0q9InII=;
        b=hT7Aa3abbsKw8o7GQqyS5ukQeFfYEOZmM4q6aec6qPqf4dAa/80m9n/YzPvMMgAXhh
         JckgiErysORigAnIHsVSYwtD6nMNz+iMOb2wPNZVPRcvCLJLyLssAKqw7UxEwo9ILF1c
         8v6Tl6UFvND1RF/NlGyP9Nli8HHGCsxwAMbi4ZEIJ+LWbiy8RVBCiRgwK9HkyeHFASku
         RFIR1NqT8OuRMcax4vySO8zCtM/RTfnn2FmoFIuj0Qw/D4y2kFclLNJ5X3/Kp9ay5R+5
         iYMaPL/TmADlI34ZFivhhn83Dv9xBl+Cp/Dpw9Nj8Mw6O9eoLRJCd6sr0NrQW9TiFnV5
         rsKw==
X-Forwarded-Encrypted: i=1; AJvYcCUApi6HELU/shXhOTJ7hVFmHBg8owMpf01n+cYx3ayIHBEQfO8BqLQ3rbHE+gRpmOHT3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsRWDDWz7pTcByIYUO7wsM0kQss3oRD3DrhzqG0JeJrE9dhnV
	HwEHJHknAP0WdDGgKhkMVI4DfFwlnJ59ua3EYSJShieEwBALdWflF/kNznqK21PBVKbLvwgYNnU
	Y/Db0sKfxP5Rnr6jSrStz6WrJ2WjNHnlKn/15OtmP
X-Gm-Gg: ASbGncvTJdepS3A5jFaH35oZqZHZDyx2cRWFSyE3/OlbhBGt1gW/n8OAX7DBGP/uvct
	1028hfsVScxHK5JCH63zun2ntRuKDnMfngbGjSBRkg1APJJ0h3TmN2buPzvoHlAGT/jTfB5CGpx
	fRwszdgQ+oxma2CgtTFLdZEaB/bWbmLHfpVnRreA84p8nBdBheEXMV13bSfMPcBefU81Ne/fvrO
	YaJcmGWTh5ezPg=
X-Google-Smtp-Source: AGHT+IGxDBe1t3tqBTBMYOGbwfPoYLNM6YX1F3rAdQHXVgz1RYTgaAusYj182uyw4hmqn9/ToW6pADpoA8RYUEd0S3w=
X-Received: by 2002:a05:622a:5917:b0:4b0:f059:74a0 with SMTP id
 d75a77b69052e-4b29fe8f3b0mr29953531cf.38.1755780952620; Thu, 21 Aug 2025
 05:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:55:41 -0700
X-Gm-Features: Ac12FXzVorC3Kl9sEMZivEmtWbDbh3dePBwk2mL_884gL-t00rnVrn0sX3b2dM8
Message-ID: <CANn89i+xNs7jfc3OF42J0jat=-ivrQgTfycJPyKW28yTJPaaDg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 12/14] tcp: accecn: AccECN option failure handling
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
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

Truly invasive changes, what can I say....

Not sure why you CC so many folks which will very unlikely give any feedbac=
k.

What is the purpose of WARN_ON_ONCE() in tcp_accecn_option_init() ?

Just to feed syzbot ?

