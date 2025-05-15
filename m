Return-Path: <bpf+bounces-58265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FEFAB7A8D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 02:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE023BC230
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 00:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5501CD1F;
	Thu, 15 May 2025 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLEnrm2p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307534B1E49;
	Thu, 15 May 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268796; cv=none; b=HaD/Rpr60u/iIX28q69dYp4B1uAryZfT5LkXC6GlYacYM7dCNlATxMtjwUEOGxbbF+H/umpvBJiIe4Xz0ivee1x3Vm6Kvf7YPpY1BrWn2fMrZlGAZVr2ZQUJ6AZTCQjT716D1LEh1FCtr21DPQh503euk40NV3d0X8V569dn2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268796; c=relaxed/simple;
	bh=Iag1cz9o4k407fJ7LuFn6oEhYeJdBnncqWkZ5d9YBco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu6TXpPoBQFLxjBQXA6xbnoT30Z/FVzsfyoBSW6O+MYolsU4G3ItFH5G9hGZtwrIF2JApw/3ddZ6CvPX5LAbcGfHsw///iQAzeljBEOHtdm+k2TYTPD/7G5yIDTzm0bjI5q0frxqKo2HS3cMI9ZExev6p2XIgxXvNVRMZEL+tnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLEnrm2p; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0b9303998so264876f8f.0;
        Wed, 14 May 2025 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268793; x=1747873593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD8UvdHZRLcoNM/UCrvtesOfzU243m+dv7TXAwV5SLQ=;
        b=hLEnrm2pwZDLBL7DJ2EkoQl8+LGnnqoEcrhpWafCXFb0p92GqbD+hPY1R99ipe2Gej
         mPbLKbofaJBi7vD2Z6sVzG7m2JssyxSFZaAY7X86rRJV+lOf3vRcYzXvgvAhnFPdOg+6
         nvqBmayJskFfaCaYTUxflARBLmqawl5XgxvMzr33Ro1ICBAg7Cn5p9oQc/dANIU2DpmV
         GcrsR8/Jvxy7C4QfwlqR9tcRxd7KKXadKEjP+wfc2RzLO77CyRBnYSbAg6Xo7ATWDOVP
         Un78WP+0XRQog2py455wRADSzYop5CtvIhujnwZ9NZNA13ifTe0q/adrSGcHMCwAt+Zc
         B+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268793; x=1747873593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD8UvdHZRLcoNM/UCrvtesOfzU243m+dv7TXAwV5SLQ=;
        b=r4aROkivKUyc2IY6o4uFDDx5bgDwhkrl+XsTzGmAuLtHEZROTV42D/8oRWLkDCAdet
         MTRubeJqK2ftI9aMHvRAGgrsPnnTDSkr7ojLqqWIJ7RmJKzIurQLRbrWuN+UOsrPfNBP
         zyRZBZxUfTSXvMd/XxVN/NL7FZeY6zMXgEawYJN47IoSdrZWvTabj2hufcOYoGWL1jkH
         DvuSNo7MG3+BmsQxiVi1WCKitSRL9PAu7bhvnr1qUJ60yfkjfjMkWbaaE3fCOgSZ88yS
         5ZVYmsuybQTsl3feeI1ADfo1CN8g6vq0W5xuOaGbFz24HCHeEpSNOoDROdb2YIZzXPFS
         fhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW96qzXyvl4U027t75CnK+irUTy2ROPV1SQLPdafEE/5bd0owCkttb+/GeHZmoisMyWUmo=@vger.kernel.org, AJvYcCWEWBV2H8TPGP7HELHSNZxJjL8TPYu4/PcW15wWyVddGaY1aGlq9tcEWOPSdCKYOg/WTey9I/24QBFcvrg5@vger.kernel.org, AJvYcCXYvwkoDMGWB2Aw3s9wl8e98AjDfVTb1kSIKQvJfrgjOSEddm8IYL/JaNvdHkStzmEoeRxkhVF4@vger.kernel.org, AJvYcCXxxx/C1yz76N6VEg/fwYOTQ8HkRzZx/u323a1k33YIwZZw679QtchqCnLBXzgZgxJ6uG9hKzgN0bifuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPAq9QLNfaHE9MvNBMf51cyJgkiugXnmVsfS0NpMajotGOb0e
	s07lkY5hnB+XdZ2agwFLbSK1ZSVSLqMKuBxKSNck3RW9yNziwm8D9BRp9Aj8ClC4KHzd1S/I/OS
	Ji2OKZQSSMCJzsewA2IrMMw56AhQ=
X-Gm-Gg: ASbGncvhkp/O9NMawgCxmyA/Gi5iE01XZiMqPTq5OaiC1f4PvbX8PzO08+WoDi4/jS9
	854IKFXRa6Z2y2AOmGLLTVT8P1I555RVCxJsQ2XYFx2MclPWjh89lQqbbRO/ta11v0XBJJcvdp5
	i6YTZrK/O5WcJ+WNPLojsYnp31KjHRhMqMqfaj0Yb1W4yhmw8Z/XZKCqSl1ftzkQ==
X-Google-Smtp-Source: AGHT+IE+HZtZ8YzQvVA5KORcVG830Q/KkDJreHLn/VSPYa/IsnTDh9JyEuOeA5868CcZFr3bt0O3oqGXAz6+b18BS6w=
X-Received: by 2002:a5d:59a6:0:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a3511ae523mr1489281f8f.1.1747268793180; Wed, 14 May 2025
 17:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 May 2025 17:26:22 -0700
X-Gm-Features: AX0GCFuVyinZR-I2bjnzO6FUnVs95bvM6FFjH-AQVx4_GVmrDQbqAT7tVn9SH4E
Message-ID: <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 1:04=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Carolina Jubran <cjubran@nvidia.com>
>
> CONFIG_INIT_STACK_ALL_ZERO introduces a performance cost by
> zero-initializing all stack variables on function entry. The mlx5 XDP
> RX path previously allocated a struct mlx5e_xdp_buff on the stack per
> received CQE, resulting in measurable performance degradation under
> this config.
>
> This patch reuses a mlx5e_xdp_buff stored in the mlx5e_rq struct,
> avoiding per-CQE stack allocations and repeated zeroing.
>
> With this change, XDP_DROP and XDP_TX performance matches that of
> kernels built without CONFIG_INIT_STACK_ALL_ZERO.
>
> Performance was measured on a ConnectX-6Dx using a single RX channel
> (1 CPU at 100% usage) at ~50 Mpps. The baseline results were taken from
> net-next-6.15.
>
> Stack zeroing disabled:
> - XDP_DROP:
>     * baseline:                     31.47 Mpps
>     * baseline + per-RQ allocation: 32.31 Mpps (+2.68%)
>
> - XDP_TX:
>     * baseline:                     12.41 Mpps
>     * baseline + per-RQ allocation: 12.95 Mpps (+4.30%)

Looks good, but where are these gains coming from ?
The patch just moves mxbuf from stack to rq.
The number of operations should really be the same.

> Stack zeroing enabled:
> - XDP_DROP:
>     * baseline:                     24.32 Mpps
>     * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)

This part makes sense.

