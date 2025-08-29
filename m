Return-Path: <bpf+bounces-67000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98317B3C0D7
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014D816473F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71A327798;
	Fri, 29 Aug 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZzcFSeT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A830DED4
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485248; cv=none; b=dKTbht1PbKXiXYHOH5g6jhoFrTQIr+fVGQeH/XNAYTTtXMjJB/0F+8JrCngZga5X7DswMoiiKEz4xrVFbL/7ZBZEPI6x/8YWuPG9OwvFniHx38tKvdiIAr/IsvP3TR/Ua4+eYrQ7hfxzdRDO7M7h6AScFpZS6NtYBmbWf/D60XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485248; c=relaxed/simple;
	bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubLl8pLRnzdP5ZUBlVYgTgkiK8DPRx99Hfdqd8exF2a04zCP4+hxumyaS56vmfo4eEPjd8UuUqIzb4WxLzKP+eu1A7hih6lsPAvff8LkOEQyWXV8hoLb8eZ8hFIHlPBMqQW7N6vFHzUSTyiukXGmBX2zPcZTc15ohKDL3AqYklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZzcFSeT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e86faa158fso241487285a.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485246; x=1757090046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=yZzcFSeTDXtfG7Io66w+4NDacXOOjav1C0B35w5lxY6j1aX9bK3x//As59NIOj7xJi
         /JxrPS7mMQhVF3xl1MZOQWk9G66ugVlwYd90mG31i4G4Mepfwo2NyFJdiHq77idXJEez
         X8EV+uUto469lwnDZ0OqjuEwkG5N4nRYf5x1iWSYdOehIW2vpzgrds1LlMGhSkIOGhGE
         Di6gDbSYB1J57eHce+omAmcBqHDvXve+hQqkY95p+3tOxrQf87PyBu3Ry7SEosgPsQFK
         XQoFrCxN0Dthwz9ZHeaiF6h55KteB+uHgeuz3Ra3p8wS7xUGNotxBULYzYAxCYWORXKI
         +rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485246; x=1757090046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=Y0lT214Lj7vY8KRlYNxgZeiGhx+4bcV78QZZjogCoTVqNqQ2XeaEY5ad2xan8iPgbs
         T2vaDDPfHcygSpbdaL8sx3IulOEibffHSZtaFigZs3OKu6gdK83dIyd9ClEVM6CbPK35
         1Sq1Cxv0sDDcEdTDgIvMQb9YRFKnMUWsNB8UrKVlwWHwUE8MQ/Qoz2n9nKhhyPwWudpf
         ZD/0wj3Wi5DkSvVBtWHzg6V1RcEz2HNv6zJ94xf8SCE3T2CtQccbKFh79UDiHN2OkQY+
         aQyCZHDL3nYWFd1eUUsC2zYMT+3fOLoDD5bQFfoWp91GA3tA8hWij5FSTlkviLC3MaqS
         Blfw==
X-Forwarded-Encrypted: i=1; AJvYcCVWBx60VHAYAAJfrWt7a1DrWzcUd3KQN4zXV8Rd97UJ/1XLQuIKR6yvOkkWtEy+SFgyNdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm0FdOChXHbcGj5OXqrB206VdQ4T84ocN6e03o2jHNteWd1T1
	78YFmLlk5gjGIFPXcvu1Dje+n8IuRAU5nuZzu46YwC8iEUNjzIb/Z/4Ymw0/mw6wy/cTKPmnfkP
	nOp6/ucihFWAjvZMIVTqJxtKpYcdSFS6H8jF8YcKr
X-Gm-Gg: ASbGncuadcPgakok04h2kVeJfHKzg/L+FyTGPeg1Y7Dk9mflvc9nGn1En3qYfemC3rX
	lc8ixQ4xBN0e53yxtKWAwLLoP8VuIkvoFtwM5sKX7EJh71Ikm1Oed9mSUCasUa1yIJU+LODNs5r
	9JX1EpiSK7W0pGfH9jG+f4jfACqbQcEl7r5nFWxSV+Rek6CI4f/nReizMAqkko8ILPg5UKCkDV0
	6CLV2jmghn/hvMRfsFxSiaKpZcpNmnQQPdHsEKo9eUFodDEeKijbKB+zzM=
X-Google-Smtp-Source: AGHT+IHtYMp7MaCT41dAq1EckC1KoVCTKnXamBjtK+0KAq3RniwlNivEAWcGZmijh3OPLqGjBp/iT2msuf372hEp+iY=
X-Received: by 2002:a05:620a:a80a:b0:7f6:f290:d7a2 with SMTP id
 af79cd13be357-7f6f290d81emr1339269085a.26.1756485245616; Fri, 29 Aug 2025
 09:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:33:54 -0700
X-Gm-Features: Ac12FXzVKBKIpycRTThoYnOUy1NOmMvnFdIRovbc3ZCcjbrQ-vjmY06SJZt7nbo
Message-ID: <CANn89i+Zw7o+iGoN4Qf+wS-hL==DSZn8sMTT_7HerNuVd+uVPw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net/mlx5: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:36=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> Doing the call to dma_sync_single_for_cpu() earlier will allow us to
> adjust headlen based on the actual size of the protocol headers.
>
> Doing this earlier means that we don't need to call
> mlx5e_copy_skb_header() anymore and rather can call
> skb_copy_to_linear_data() directly.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

