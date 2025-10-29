Return-Path: <bpf+bounces-72664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F7C17D2B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A64425B61
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2B2C029A;
	Wed, 29 Oct 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ7DpnPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401653208
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700539; cv=none; b=DlZ6T5XS7g68O91vHz6UXS8yC3+ZFH4CJKgTzE9+xpqrj0fUJFKma/xJ7zFy3niHpy3XvokyiGtOEks3O8iJnbIh8sGlDKLHKD4rAwIY8fYg8Sogo5oocrD/vyYQJ3BTWC0qy9PJHYrNNp+kkOok2jDc8GCN1PXckRGbrGNAVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700539; c=relaxed/simple;
	bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvaAIbIwoYwRPeCzJsHyeM3ccwj/OnfdkOROtk3oYyZMiviO7jb/ragCszzqAXrGZq60+IcKOX3psmDr7IQWmWxGZnzMPyt4bXPG2+AE1UquNHfAPhU7oxs9jI4m9jRsm3jf4jHcRgH4uXHiskp5TrAgqrqnzD4obZP8K8/axcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ7DpnPm; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430bf3b7608so70673595ab.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761700537; x=1762305337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
        b=VQ7DpnPmfLx7aYyZENorGeYM/OM0Nwr2zU2PfjeAymNqqocUiK2xa6U/LAZFPI2bnn
         Gg2h17qh2hl5CxbwrdE1zZrlFs4RD1+/Kt5SdrAN5g78zNDDh6Z7oDkPBhC/xZFTsPKJ
         cML1uWD5L0jxygteNRIshkAmqhT7Yqu6GV1wDF4pfeCN5O0bRk6UYpFMcyvVzDGpIMB1
         GPmEAkNQgVStL2np+Lkp6zYT83BhHioF22wb8y+g3iWaGaHaxafvJBw4dullQEXHijzK
         yZeclln+6NDDV1KOaUL8bVfUck04nLZXv1fQMG9iHDdWgwWBNtS6x1tFqKsW1lKaz+gj
         eS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700537; x=1762305337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
        b=KveAP/eL2VWmPOkouZDk2TUdeXZk9lF99NMuHBX0VUPOHMRQtcWp0yVJBabFhdwv0T
         N+CD5gYpdwNVe6ocItFSvJxQtLfxcCqrzayXnFSlrLG32NlZP7OPoFElzwaWAGG0N1CG
         Gj90/JSxecncQrcBMKaC/yAOVIdaqt2azOcJXENu3+DIYcnXQwf/oCtsLzQ3pkEOmvG3
         kwgmuwS5+smyVa/6HDjV3shmnR9uvTXV3nYd67WZnNz9mykkQJV6Jlqc7WcZM2/yVuwm
         oaFIcFrZqKfbYLLcWAUIAFak6JBEE27vyW4Efe9tDxg+b3QqaxsHhfsURGGncle3MAgg
         Uy5w==
X-Forwarded-Encrypted: i=1; AJvYcCUcZHn5Aco1c8i0PKTzXcJIlDc6nkjrXdHvfgEADKg3rvYqAd/iYsQ/7zOk/i0sjAfJ24M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIgIMh6pqG8huzx0J+6c/QB6OPbgqY0XZE3OM3NceBGgtyVN6
	WfB1QSypfTTqCncJORFpbixXpq6X6WOR9zEId0r/aPanPht8kgol6kzcOT1Kz7m9YgVoAhdKfjX
	o2s8HrTU9Wdyav3rWNGKTfE612MsiY6M=
X-Gm-Gg: ASbGncsveDW0Ukg2Ony3V17KzG8UBagEnJDIRMfUk/2vIzJ2Pq6s0e4ueJm0pJG8CsJ
	bnk1llZCSk0r3F2Jv79E4cvqWPT2wtsQIVu/A1buEQIC/9QeBLhuzkoOzhAinr9XPHty8yYcJFl
	BcrRktg7uPehnrVpCJUr7fpMjN/sNKccheVnGpFxQFy4TwgmeB2ZjXyq6UD6jjObdTfSRyxORvj
	cJttCV1pTnRl8GnzQibq8xvnvJofhiQtsYcDJ4zvAjLqhWUD5qtWuy2pPse
X-Google-Smtp-Source: AGHT+IGiTSMMyX80MwBvdBR0ghaukKH7fS110FJqqJ8ZxCiPcuPSoWH+ji1CTUUWndqjYmj4Pup8RGzvh7LCZfvqkk8=
X-Received: by 2002:a05:6e02:23c6:b0:431:d951:ab9b with SMTP id
 e9e14a558f8ab-432f8ea46a6mr21449745ab.0.1761700537269; Tue, 28 Oct 2025
 18:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com> <20251028173055.17466418@kernel.org>
In-Reply-To: <20251028173055.17466418@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 09:15:01 +0800
X-Gm-Features: AWmQ_bmwqhoq-4WYQNMDo9zMLuaF-Guktg_P0v5-8sNZ8cZZn80tUr4S6FrawBo
Message-ID: <CAL+tcoANtmLDuAHeW4JynJqiXoeTwNL2cVcGB5Ff0AxJMkR7mw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 26 Oct 2025 22:58:24 +0800 Jason Xing wrote:
> > Since Eric proposed an idea about adding indirect call for UDP and
> > managed to see a huge improvement[1], the same situation can also be
> > applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> > will be magnified. I applied this patch on top of batch xmit series[2],
> > and was able to see <5% improvement from our internal application
> > which is a little bit unstable though.
> >
> > Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> > be when the mitigation config is off.
>
> FTR I don't think this code complication is worth "stable 1%" win
> on the slowpath. But maybe it's just me so I'll let Paolo decide.

For xdp or af_xdp, the best practice is to turn off mitigation since
it has a noticeable impact. But in some cases we still keep this
config on for safety. This patch is one of small optimizations that
mitigate the impact because I'm trying to optimize the af_xdp in every
possible aspect. Besides, adding this one will not disrupt the benefit
which Eric brought in his commit. Please review.

Thanks,
Jason

