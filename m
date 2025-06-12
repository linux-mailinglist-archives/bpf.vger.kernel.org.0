Return-Path: <bpf+bounces-60525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD8AAD7C9B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7746B3A79DE
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61932D8787;
	Thu, 12 Jun 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2iLAhFz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5D2D6615
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761099; cv=none; b=ct9FurU4lPPAcopCmdpttfVLMXOUjWjN7ZOesL2i/l3lQmxVtCopAXlwpBKqHHq+LUDeN5PdrgSNO+OA1vzVDZKvtsJvXoyQh+QFgU2+mDlB6C1rB527c2Qr4kke/xWClx5i/twANhLBWZSvgMuewaIeGLxbYISV9jJYbh2+gGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761099; c=relaxed/simple;
	bh=0shdeU3Nmns13gIvSpekGMtrKZaAuIpc2PTkyCP2Tbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRlNRXm5RX6dJ2LwP3i/gnq/XBoE0HMT7ynmhLJgP/gXWmcGdwCwNeLdYUOsnUFC2eNT3EdOVuRBhYhSHfhknZjou9Ow2U6mZQjea2osx9XTzyFr+u4a0dZ0bRFjass39Hct8hCyk2MBhHunApjmC8209zXEFAHYr0MT8ukP3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2iLAhFz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ca5eba8cso56925ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749761097; x=1750365897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0shdeU3Nmns13gIvSpekGMtrKZaAuIpc2PTkyCP2Tbc=;
        b=I2iLAhFzijgdQ1YNvUeyvqvftSrEFW1ueLbsQMK8NMgetrYBJj7Fs12MvPJ7zbLifs
         yq0SZMlQb66p/GwBtC96c2S/vj+n/byGC/IwccATCNzh3ECLtciyKj+5tVyn/TePniAb
         R52oTb2kv0+g3xSj3bL1ANoWy1SFuhWqTi7ISqoArdOjj0I9pH8A+izFsDGdvhE6JEHn
         9VbBRTuGnjqfK23IPzFhmuNgtxCyzw75erN4u18qqlrQraVBNIsnzFgTBYg6oke6I9lB
         6hqiGgR8nCGG9NZU7zwDzKG4NDYaBt9nPoPJnwTCHEJ9Cry7Xe1VuDmfs4DW1a6Hf1zh
         oB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749761097; x=1750365897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0shdeU3Nmns13gIvSpekGMtrKZaAuIpc2PTkyCP2Tbc=;
        b=M3oTRmw0I76gxXiVU8qfu27WGE/pJfWlxJSG7wM9co3uCRjX8iaJft8aC3+LEjSsM6
         uvPfCVUxDUeS9xXJxODMwb4hKXzSUPRzRP7AV6Vp/ChhnmqxX2OHMdl8+PcaQqjilw2/
         EMqRDRWfYcgV1A34Dcbni0kGKU/42Q0wkWHPmRBsT7yVaqcmhBMS0K3Vn9VWliGsOv9Z
         5l6Gm1YZnYMcz+cw3Kn1KhV4cUeaJ9USCw+8oFdIG4ujeWXDo8NS4bzcyuXoT+bQFJXp
         HiHv77PpvCMVbGgJTSSB2eT0EHXTgvziAWyJESov9KOk6tySDUaMll9/To4LgAH0egp7
         Cmbg==
X-Forwarded-Encrypted: i=1; AJvYcCWk4VZqGKsxqDDdSA0zygCbwQH5GYaKcNd9Pqyi0i9f24V6rpwT5CnW5Gw7v7izv+bz3SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlisP3M4aQ7/Kwow0oCkMkKVUM7RePn7VZAW/N161ECewi7cSZ
	3xQxyInA1T7ED+Ir2guJWbToJdRWy+zHDuLsFwM1SLAIEv0BuTp7pzBeWuJyOqvR+CRH0bM/tiG
	x35yoz2RzXUEZvcZJYJ3fN+qR/yoa4MQy+1JeXXZo
X-Gm-Gg: ASbGnctqyou1qAUF8xI1V8Jl58ATFsTq23cGph95xy2FWxGpEsnGzUF3WUxB6zK0e6n
	9b3WSSi7L8qLhuZBhmNCBXlxlZe4a+nM1PfNkQ8szkmgn8LZdr8Cu4m8k9QRbrcOs3zKgfHQT6W
	ebcPNUVWkUyxcECa/8Gt7kmzzuBoJDu4LEXOLpgBhVITs211F++grFoJFJwjSFUTk9SpfeaSaou
	A==
X-Google-Smtp-Source: AGHT+IFQpp/hgcePI2xWrpQ53G9VWOawnMErUaqEJq2tPNn7M+/QfKB23VjAX85ytCeOgogiZvSGZYySA5m/hlCuyso=
X-Received: by 2002:a17:902:d48d:b0:223:ff93:322f with SMTP id
 d9443c01a7336-2365e8c8cf4mr545805ad.2.1749761096753; Thu, 12 Jun 2025
 13:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609145833.990793-1-mbloch@nvidia.com> <20250609145833.990793-11-mbloch@nvidia.com>
 <CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com> <9107e96e488a741c79e0f5de33dd73261056c033.camel@nvidia.com>
In-Reply-To: <9107e96e488a741c79e0f5de33dd73261056c033.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Jun 2025 13:44:44 -0700
X-Gm-Features: AX0GCFsbgTfnHYCyryWuORz2W8YB0hxZo0nQDPNGkYposr4yQdjwdikAQJMpVe0
Message-ID: <CAHS8izOG+LoJ-GvyRu6zSVCUvoW4VzYX5CEdDhCdVLimOSP0KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org" <hawk@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"leon@kernel.org" <leon@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"ast@kernel.org" <ast@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>, 
	Leon Romanovsky <leonro@nvidia.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Gal Pressman <gal@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:05=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wr=
ote:
>
> On Wed, 2025-06-11 at 22:33 -0700, Mina Almasry wrote:
> > Is this really better than maintaining uniformity of behavior between
> > the drivers that support the queue mgmt api and just doing the
> > mlx5e_deactivate_priv_channels and mlx5e_close_channel in the stop
> > like core sorta expects?
> >
> > We currently use the ndos to restart a queue, but I'm imagining in
> > the
> > future we can expand it to create queues on behalf of the queues. The
> > stop queue API may be reused in other contexts, like maybe to kill a
> > dynamically created devmem queue or something, and this specific
> > driver may stop working because stop actually doesn't do anything?
> >
>
> The .ndo_queue_stop operation doesn't make sense by itself for mlx5,
> because the current mlx5 architecture is to atomically swap in all of
> the channels.
> The scenario you are describing, with a hypothetical ndo_queue_stop for
> dynamically created devmem queues would leave all of the queues stopped
> and the old channel deallocated in the channel array. Worse problems
> would happen in that state than with today's approach, which leaves the
> driver in functional state.
>
> Perhaps Saeed can add more details to this?

I see, so essentially mlx5 supports restarting a queue but not
necessarily stopping and starting a queue as separate actions?

If so, can maybe the comment on the function be reworded to more
strongly indicate that this is a limitation? Just asking because
future driver authors interested in implementing the queue API will
probably look at one of mlx5/gve/bnxt to see what an existing
implementation looks like, and I would rather them follow bnxt/gve
that is more in line with core's expectations if possible. But that's
a minor concern; I'm fine with this patch.

FWIW this may break in the future if core decides to add code that
actually uses the stop operation as a 'stop', not as a stepping stone
to 'restart', but I'm not sure we can do anything about that if it's a
driver limitation.

--=20
Thanks,
Mina

