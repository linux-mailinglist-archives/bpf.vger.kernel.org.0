Return-Path: <bpf+bounces-49005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD82A12F73
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4F165E67
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B41DDC10;
	Wed, 15 Jan 2025 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBcyUCyx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093141DAC95;
	Wed, 15 Jan 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985462; cv=none; b=lBAElbC95SGKh6UbDSmNAXRkIAANzNSaRVWdTIGpb76e/kIB4qAUiaVlhJFDDj2ttEhAsPZBdOufOqRyMB86AFtQC06KoWqOc/c/FeA6/j/R6ejmBsKFSl6beGcaC6Qi4dkz6QftHEw2HwJPKvnOLDyWGoouZKZ0MW3Ko8aIKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985462; c=relaxed/simple;
	bh=jvHAnyevVCEUpEPj1NTJRKHqokYZyU4TPBSqzLZ2vEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liAgxH0PMhHPjF5FJhew9rt9VFcmpt+Y6yuFAiUkZDcOCUeG7t/AaVKN1N9EUjpOQUCRXQPNy5kM5AXYawCNS1m762/OOmTag5tpQUZt8Q5n51dEJA0lSb6zZrsBh0U+sOovtTHOLuvNA7I3T/3cniIgZTIQuwCXz7rUNK/42qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBcyUCyx; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso2741435ab.1;
        Wed, 15 Jan 2025 15:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736985460; x=1737590260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvHAnyevVCEUpEPj1NTJRKHqokYZyU4TPBSqzLZ2vEA=;
        b=UBcyUCyxw67SSwwk4/xjonK6nbk1Ak2AiqBu8j7S1nARwzc6/LorznDSbXzEza+YhH
         2DobnXm/F89FtR41unoMUHPMMy6QYD/r0ijPQcruXmFYj4OcpLdSzehHOy2SMlTYP5p4
         N6P/EqqgS4fMz28RO5LEQZzdIcBN9BqMtBOX2dkvUT4ngadXWljli19V2m+beFigvOB4
         genjU1dZgdJXHEzG1J290uWmu5vueCGeSTA8vHPPL9bcsUQYpDH+0WV7QpcONb3pKl//
         ljnAlzYGC1PjL1/4T/8J4LL4aXRhY01TouTrVLTUrxEVu54zQwQiIDh3m83Mrj/hlAz5
         5+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985460; x=1737590260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvHAnyevVCEUpEPj1NTJRKHqokYZyU4TPBSqzLZ2vEA=;
        b=f5krGlg24VTZXgH9AaR9CmD/tH9g3ZvjlRLQljDzOa1y5kgCBYGpTwQBXljqzpI8+X
         ojBGdmLwyCedXIwW+6uxCzXAn/LAuc4/bGgbskoKeDR8M5ujlr+WjTnz4YfB7dIzvusT
         kRt72T4amYu7po/v5B1vNFxp03oxwpBAXBoEVBefrEgoc3fauVQ+k6+QqeKBsaKs5Zms
         SBcFA+HILUYIc1sIE/pdcYkX1HfNKcC5lhPxEHP9+lv1q5yxfPN6J8MTIu4t7PnoSDYW
         EPOHzEDt7x7lzyiBByC68ZWlwL6IboTSdzd0T2ZOqXeFy4K01Y15nV2q5sMAX3NTDkwj
         ektQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf6l32Krb4mPAAH5ddbA2tRiihGutBJBM/ei9AgYfuZRPz+D3dNJ1rkAQ8uTNEnudIDA0=@vger.kernel.org, AJvYcCXDj4cdnMqZghiK+I+Nw195A68p7wZGfpX8e9gIL4p3XoZOTnTe+wNa0hJstuG/I3YJS2NDsRyS@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhp8a/Ep172Kdj1VosQ7AQIUK17Kb/ZZy7g0BcmKcrTvCjFkp
	tHaCAqVA/7ds55WaQUrDUQER7sH/cbjvA/15dbWvXpIyyWYDAeyswKNE3H2/TqJx24X47JrLRej
	6HU4GK5mxaa2Qy+nnUqKpvlCjNcc=
X-Gm-Gg: ASbGncuSq/CjT16S1J2JGXYYzq0MVcHc6FKiwIJmGWxcyEptnlRMzo+ldzaywPHP/yR
	/DhOey/r6YNUO+0ETgcNacuP7RJBnCp9pYKr1
X-Google-Smtp-Source: AGHT+IHyndVsia2zem5c6n4Ov7u0AnMinxZMvSEzsOh++Ud06bk8o1l6zpG2Bd0TWLkDA3OUln3mDGHYQDW0SNAGMOI=
X-Received: by 2002:a05:6e02:1d86:b0:3ce:5a89:326e with SMTP id
 e9e14a558f8ab-3ce5a893465mr169953985ab.13.1736985460066; Wed, 15 Jan 2025
 15:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-8-kerneljasonxing@gmail.com> <a0071f8d-b7c8-48c2-b4c6-96074f4c4849@linux.dev>
In-Reply-To: <a0071f8d-b7c8-48c2-b4c6-96074f4c4849@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:57:03 +0800
X-Gm-Features: AbW1kvb6qdanX__7Ly-rb5RVxC0RzIhDJeo9MGcRy2BJ7yHaSWt5zCxrCzfa7j4
Message-ID: <CAL+tcoB6_FZ7f_cN1wYiFHAM99+qFegydy1Bh_p7d39RFpGoKg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/15] net-timestamp: support SCM_TSTAMP_SCHED
 for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:32=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > +static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, =
int tstype)
>
> nit. Remove the "__" prefix. There is no name conflict.

Got it, thanks!

