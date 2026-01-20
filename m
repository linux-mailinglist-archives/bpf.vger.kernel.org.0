Return-Path: <bpf+bounces-79579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95695D3C3D8
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9952A330
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BE2EFD81;
	Tue, 20 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFtTGZHF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680D3BFE5B
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901265; cv=pass; b=kRIjkcgMQa86shmcsCvsBB5//jivlX+OnDBYkSBYMPy9I+OlGSfTRzEZcRk8ccKOnN6Q3TgWFcqmckd1pC9+3XcwwjdW+LCBjR7dJ0fWg/MpDjRb1hHfIwcQjlZMg8BS8aTFwbI3ReSL78fgWDjxVawict30RAsJqHlYjjxggsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901265; c=relaxed/simple;
	bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKHcrbV5gOWpYsl3sIF/zDnGb98vAnuw4sc7cJXzeEBMy5PY7ATzsE/f1BLUZGtRTZhSjCOdCGfpsyUN99R3G2MpU774ceFVSODScBBZ/WaViLChc8Iy5Un3vwjmm07jhg4G/Fzf0zad9g2IaOAsIf23AkFQeWmOML9b8UtA97o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFtTGZHF; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-501506f448bso29287411cf.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901262; cv=none;
        d=google.com; s=arc-20240605;
        b=Ne3MQJkKmy3X3FPm7l8ZtbtfZDAYdA2h69qj7PM6+ur/XkFm+3hprHbhrLh1RGpKJT
         jB8ipX6ob+SGYy9bE7XSZGv5jHuAn2Da+E/TqLWWj1X5hl7d97uq1HcfxlZGbwTxPyLF
         x1cdxCFffHXjynFomokUVgdXCZXNC4ldzbmRXeGJbqzC+azxkAl2LUtCZ5838SeaVobC
         z1uIDC+TH8SczTHqu9f1kydl4kr4XoConquwGnbSL1kVwjCVXPPjPb3kSjDnbzKUJNXE
         GfElUxdh8ovjUcoYCNSopg3OLzM8Md0BpDZSMnTevwl/fIj8d61NI47ixcXpWzffXKcC
         xPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        fh=jelvj37MPoqCjgvpAdLWE+tiBYT9093RRR0twkyxkfg=;
        b=dIeIY+etQWEgN6nOc7C/4kaBhsOUSo4KNuQeD45I7sSrsyDs40ViEu0ThCayTkuBUk
         d8tVzy/NvI/Q1+Tu51fMNmOm9yPo58Fufd+ONrW0bJBEnOadTVfMrP+1PdgN4H0GfUxe
         gZQqkTQGKIVEOaBj5LDErry7Qks88rrOrln2lYDlAgrs94QPGWSA1FznRJ5AT5+NO+h5
         ZyaQkyCcqjZDpmBnFkoF6FKeKZCg1hDUzq4T3aIsV6zd8cIhcnXFqvKy4mFIXhs6ssJ1
         ltSznnZFEQs2j3iFhJqj1bAD7BUApQkIE02a0p6I8e/gzIGQm/VhCoc4LHX6Z5dNHAbK
         bJYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901262; x=1769506062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=SFtTGZHF9NsJIabBnvYroZCzVEpdC2Hb+eE2ztAAX+AP/pxQ2GQn7gUzykX3xJE1T9
         Ic3+0XhwYEuVO/+V7CTqq8bK8EbVBGm14wXQZAdOhxbgZZMUMf9Znai9ninsnRo+wuBU
         tu+6U1tkqdA6QIiB0ZZEWgrBSf0CwqLCg11DMnxlCHHx1KnfwFltcwLKdvLS81XGy3Ib
         L/g09oZlVwkvnAM5lZhMgbe4I3ro46YYjP41sN8IevjoS/Ikjp6uK/5GoMwOTCddfmBZ
         od9r0TIDu2IfiN9us/4iZw1g2e/ZpWXGGBJWpcln/Gof4PS9uLDQvaUkilSORvAE5IYo
         jpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901262; x=1769506062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFm+9wwtgk8aq4k8dQkzu3uNUhmEdxvmn8yiOGHPluU=;
        b=FHUBx8Uq+wq8CH6RJbPD7s2vxLXzHnsZsZdqBWyRtTpbmQs0rTYWDlRMU+A6P26+ag
         OqtfUYAUad1Cfo4AyDAufuJ9tg2MGgEzeu6oeU/sm8IFXfXGAktxDzdfdbU+9VdVus+T
         1DbzsbPfov/bzLFcVJVH/rOklv6LBbMSpZg8cA0SQ+qRsgU1QWKiBk5zBeNOxskLHOg+
         Zptu4HhYGNNkfjoN5U//sAvgz09snaJe8NtwT4JvAASyHW7/dCOW7n4HSHFJqFZMIwd4
         8kqqFnbWYIVQTSBf4BQCUKatLxVhUPZce9DJ4t9pZxtX0U56zjACSJMpw4RG4EEmrDn+
         Tqyg==
X-Forwarded-Encrypted: i=1; AJvYcCWIvagQsONpsbN+Os6D4H0lEKBGenp4Jx4HDRzb0NB+aoOdDWw0pQ30LC19v16DbeNnwjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Q7jH66gC1yKUMnRtcc4OMs9x2XsoZVgV9VKk5doAoZ81Gmoz
	xjtl2IVDT7Qrax30LQcGCi/J5I4/QJYxrYnvhqnpt1p2FXfSt9PpEiAc1kEFJC2+w4NKy/TZLB9
	MDHbwRrzMcmmN6dviK7NI5Ma+MsrGAExyZWMgqp+9
X-Gm-Gg: AY/fxX6LjXViyOshZxt8thxtYJN6py6hVDpYciFOJM8W3/ECPlyFV81p+AN3hLa6q0I
	vcQ95Ig4t7cEcCSboUq7otp5bKW/QkXwq9KJavMyl7EBfyFAfLeOjU7tosf1clCkQaVWbWShbL0
	gRZTjvRHFa2yKAQq2Yhw/8vso5Y9BJc5HYrfhXnBz0/e1w19/q8J8cxqbGRSbaAtE8hJSSSTzFP
	u2cgrHwtIEAH+9CPqdqGERGRUqWP+pvelrx2AjdSc+X831w32YoqhB9luW/5R/0pgmToY0=
X-Received: by 2002:a05:622a:180e:b0:501:47d3:217a with SMTP id
 d75a77b69052e-502d829a969mr10411241cf.25.1768901262067; Tue, 20 Jan 2026
 01:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-2-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:27:30 +0100
X-Gm-Features: AZwV_Qh2C6qterbUps9ipHoZiFx2JUtmLIyzTtH8Kko470SyemAziOwyIlRmsJc
Message-ID: <CANn89i+44At=GtWMjksjjMmARZONeVAAiDgqAP2jXWSK3BxJLQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
>
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>

