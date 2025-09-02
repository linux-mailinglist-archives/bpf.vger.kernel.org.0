Return-Path: <bpf+bounces-67204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B9B40AA7
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807F5481F0F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F533EB10;
	Tue,  2 Sep 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AtemeozV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0364335BC9
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830661; cv=none; b=qwOz2DjWQiOXmwOkdhNG336WjkOTUtlI8Y7fQOrxL6BD878ZhkxLK9vr7Nz6xv/28Yn97EAs6yIHeQYtokOa/zI04fE8aQx2sx2wrP2gLRhiMNPRGS2mchPn3ANtvyttLQQ6PyW8E5i2BkpZ2qZQ1SbmGKTlJ/aNBrVnWfv2Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830661; c=relaxed/simple;
	bh=ARoLZXERdB/aZyOgVzhxxJVRiL6oqZtJT/TLCTB0tUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXgOrUo33IuQyKQZGJtiUuqiJmBBumu4ab5RlKSTQERc1oGthnOKr0g4bWX5ChgyH+IEGkpxz/mnXV6aYAHhOPIwEC/shZEaT3txVm7ULAqklw6Gz15jaoIJNJ9q+b+71+m2DiJCpAI4m5MppfcEHgAj/FzqpzrAi/i0g/bVkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AtemeozV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336d3e4df3eso22529551fa.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756830657; x=1757435457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB11qWoSG55ssqg9L7jWSrZS/svWEW6aXYtvrwkQCkU=;
        b=AtemeozVsARKSX6AShZYiYm8HHSfJylgOnSsgMkc8UKukzxpe3SJRcmAuxRgC3AIA2
         J95QHIGGeFaCK1BOfTqUq+Aq5tapPlIukXbOXvw21ISHeGJj8Eo+OfdarolPlwDfKzl5
         DXZadv0n+82qWpLXqIvw6tcZ0HoiDbl3zl9KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830657; x=1757435457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB11qWoSG55ssqg9L7jWSrZS/svWEW6aXYtvrwkQCkU=;
        b=I8Edj8Dy/WBraTDu7nlOxX5h/ALCP+uGP5J/utV/NF87sxPoxS8oRf/Bl9RL3AV4Nr
         yRSe7nN0kc/PQMqQOmR4PiOHTPkVU56S1gsRej6ohqmTVdFmTtpprAzfw6paWIEqqy98
         DoBUbxEXioNqlRUofxg8yVMWm3xvLJVCK9wIWnKSQn+LAVqPrGtKZK5n0mVcLYn0/P9N
         /itoux5j5lYF2x5xM9z6z3NdrLe/wYjl1DfXszTRbTmoU0i/uuQbrMuJCNCZbitddRke
         eeqklTV5e7uiyRky5zIJ1fj1ZPxXE6XxCdSYzyL7LRR7eS9oCzCumEakc7BTWhY6Lt9H
         k6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWZG4YoyZNNhG4hUGqsD6nEVQ0f2h+q92OtqIhGf+KSpIiGLO8h9LZ1nBjbr49rOwXeWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKkXVr6YBhk2jQoBvLq9Nbf08rf0mizjMBAx7wyK2chi5F47k
	WDM4R307UDJa210QoK6/3vCDP3agp/LNr2kI9J/S9Zk2kc9cebjwuhQmM3vF5Vz6OdsHUNiP15s
	9taryZyjdxpup75XOiyVBx5pqzGhOcx8AKFJ0j3mFTw==
X-Gm-Gg: ASbGncsnVDriTpDL3GTvqh8sMubEpuS3KqIGdSwY2cHv/87jB4TeECd8w/EASSDLve4
	t+VPFJvnHEGhMF1nxsIaK6kBSKJLGURgX/1e6A11H0lMstJ7L/1g68cB8FvCpm3vk64PxzgndOe
	xyK3Uo4Lo5D+m31kwwyilzXPn3+4j/AFffnSuR1OLhfUVfOuKq3TUo6qDqafdE7Z/9hNZ8cQ0ZZ
	wa/tvGbXicA1E/jYv5DaKZi8qn9NPwDXRNUmRH/aDuXivFm+B9GMMWT4Q24xWP9SQ==
X-Google-Smtp-Source: AGHT+IEY1emCS4KLy2sUFVVtxJL75GD2C2A2GUQWvQJS8Zc/fUeZh1ps3yYw2O7b/xss9wIr7NLvyq/eA/SlDgeyMKQ=
X-Received: by 2002:a2e:bea4:0:b0:336:de55:9d9e with SMTP id
 38308e7fff4ca-336de55ab28mr32198131fa.20.1756830656990; Tue, 02 Sep 2025
 09:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130> <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
 <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com> <aLcYO4kWn1nMnEJp@x130>
In-Reply-To: <aLcYO4kWn1nMnEJp@x130>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 09:30:45 -0700
X-Gm-Features: Ac12FXxmaa2ONu42q8m48UuJA8eyWlqEwJ8-fPl1sFkNxAlFPde701qIWwwhBRg
Message-ID: <CADg4-L-irVisgCA46sXkaoqH+XKZX+b0nEmcp8HMFr30XV32Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:15=E2=80=AFAM Saeed Mahameed <saeed@kernel.org> wr=
ote:
>
> On 02 Sep 08:51, Christoph Paasch wrote:
> >Hello Tariq,
> >
> >On Sun, Aug 31, 2025 at 2:28=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmai=
l.com> wrote:
> >>
> >>
> >>
> >> On 30/08/2025 1:43, Saeed Mahameed wrote:
> >> > On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
> >> >> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> >> >> copies parts of the payload to the linear part of the skb.
> >> >>
> >> >> This triggers suboptimal processing in GRO, causing slow throughput=
,...
> >> >>
> >> >> This patch series addresses this by using eth_get_headlen to comput=
e the
> >> >> size of the protocol headers and only copy those bits. This results=
 in
> >> >> a significant throughput improvement (detailled results in the spec=
ific
> >> >> patch).
> >> >>
> >> >> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >> >
> >> > LGTM, I would love to take this to net-next-mlx5 and submit it back =
to
> >> > netdev after regression testing if that's ok? Christoph? Anyway I wi=
ll
> >> > wait for Jakub to mark this as "awaiting-upstream" or if he
> >> > applies it directly then fine.
> >> >
> >> >
> >> >
> >>
> >> Hi,
> >>
> >> I recall trying out similar approach internally a few years ago.
> >>
> >> eth_get_headlen() function didn't work properly for non-Eth frames
> >> (ipoib). I believe this is still the case.
> >>
> >> Extra care is needed for the ipoib flow, which I assume gets broken he=
re.
> >
> >Are you actually sure that ipoib goes through
> >mlx5e_skb_from_cqe_mpwrq_nonlinear() ? Because, as far as I can see,
> >IPoIB disables striding in mlx5i_build_nic_params().
> >
> >It's rather mlx5e_skb_from_cqe_nonlinear() that handles both, ethernet
> >and ipoib.
> >
> correct,
>
> const struct mlx5e_rx_handlers mlx5i_rx_handlers =3D {
>         .handle_rx_cqe       =3D mlx5i_handle_rx_cqe,
>         .handle_rx_cqe_mpwqe =3D NULL, /* Not supported */
> };
>
> I see that the patches are "awaiting-upstream" so I applied it to our int=
ernal
> queue, will let you know if we find any issues, otherwise, will repost as
> part of our upcoming submissions.

Sounds good! Thanks, Saeed!

Christoph

