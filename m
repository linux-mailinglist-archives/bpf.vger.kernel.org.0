Return-Path: <bpf+bounces-77433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55934CDD733
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 08:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87455302B122
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B72F691B;
	Thu, 25 Dec 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsFJiT9+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSCsE2df"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9E2F7444
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648028; cv=none; b=gH8Ww3m3KC+XxfDa2Rp7QOJ4OlpZP7rHQ/Coh1xnZOg+KqXVC9RXDD7kCPtwkd1N2UaANRcG1VICpX3ihig9l3yrK3BadNAD23Zk/obVyuufi0MEC5rEZWtYONrt8y8SXydwFfeeZmCI3o+LteT3/S0G9WM2SYQbOM7QwvoyS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648028; c=relaxed/simple;
	bh=+iyjwmBV87ktkSqNEIqB4ESqTnXUiOMV88fHerMRrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW56YXzhzK9rmsBmwIc1Wl6zDzGnc1EZWMTXMMe4nclhx5NIZe/2NzdJE3nkVKFisUCspJdkXyqAe9e64lW6NT/r8Q+DxwgSJoqV6vfsE2FddWguSGMdbxdytfLLEAtIdRjXLUO8Ee/puSkvtBbu9XFtOt/K30rxo1V9SMlei7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsFJiT9+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSCsE2df; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766648024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
	b=gsFJiT9+1e0vHTCKUAVGUoRD13YnAk3RcyVRwulmy5xqCT3EvB+osoLDuX/uaYVRdIXscH
	qFOaah88X2sMPUbd34pp0OwN3agx4mrmultP6SmsJUZYDaT8cNCY595oFI4kJJHr/qOIh4
	gNHN99UxZ5awNMc+hASQqU9I2Ui47+c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-OfDgl9BIMme55Ag8rZgVkQ-1; Thu, 25 Dec 2025 02:33:42 -0500
X-MC-Unique: OfDgl9BIMme55Ag8rZgVkQ-1
X-Mimecast-MFC-AGG-ID: OfDgl9BIMme55Ag8rZgVkQ_1766648021
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c38781efcso12558048a91.2
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 23:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766648021; x=1767252821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
        b=gSCsE2df1YPFNh3vhMEMnO2ZSm2F2w5G3zYWQSca7AbN31/FwKjU25cnGDQO9W2NRz
         xGCBgb5hbmcwQcC78WgkceIKvxmv+8NpODWRokZifT9tMEcFHdC0Ah4SG0nGRsskYB0x
         g9fD457JcyFf6xvqf0RedBeIB/qlQbKWIXEQW8sGsLG0Z5kUjrkDKgXEH0VUC7TT3uos
         vbQJ/B63rwNwf/9VGZoXdPMpIQMvE/kh4TwJRDhYUy4UsFB9a7OLDVCFcRiYvTn4hlBm
         jIlcBn41btNKIVcMvoItxOE1cezhDneobYs3ui3r2fiEkrSDi7sG3YkgScX00HRXoerp
         OMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648021; x=1767252821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
        b=L0Zmnm+cSYpXDe8Cbrp2NwoXKuK4E0FnTaL4B0EYryvjsPV5zpJwcusYAN3GSL6Dr6
         07P+qZZZIlziWdedbQHVqnLuWMOH1BGgj6cncCdATtg3rJIJvnJ9y5bVDadL4r6+x8q4
         S6BEefl3dCkPYFOFe+mmVgtEg0BItLn8mfhi9//rvxrSIsciwBSWdEsHI8K/PF6J1PUy
         I3WITjMpDeGf71ioIlZJaz0Yy8ZbawN24aXWZbYcF6ed/lTJcSezTdkl0+LMPb7XDnr2
         3ZKvNU4VbjWEKUO1z5I6umcl+6WMNgAIaP+5xnTJya7c0wTdmer+LUOvKjNxz+3Uvztw
         Oudw==
X-Forwarded-Encrypted: i=1; AJvYcCUX7m09tc8eJUdygh/of+Zyrctd/NGoXEjabCb3udv8aTnT0yxbf3tvVwZM8McI/yUIX38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36FP0svG8rM9GwNZM9WeZgxZcNSooQXX5cbxS8LKveEzstnuC
	pFkKnokztlsLUlTUyjaHNHEfJTLhr40MVL7yVW1ht7ikzkSGEe+dGwqD6vMWhWkvj0Xjwvrlykh
	JYcC9TLHyVUaZKL5tbu4pN8Kqgrz2nepUJEjzPZJRs0++Y7oMX5IjyH6fsg+X6Yy/GXXJLSqCK5
	26YO9agdrQZBjU8H9jsb5pww7/el8R
X-Gm-Gg: AY/fxX745WIybw2qZ1GkiAxaOwtZQBHvXIasFm0EZzGojme4/KFM+i55+kMHaQNvE2q
	EwJDgxbZZNCiJw6bFTqRt09yPEeG7Gt2++3VGpRXcoiV731fmulEo3n11Nm6/BjHZIhBpteb+0s
	VV+Dw+ifl//jj3KQ4ZKpTWAIKS+Ed4B7rjET9mjof7Vl7k+HjdpCN3YeM4TfFlz5aaDb4=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id 98e67ed59e1d1-34e921d0d76mr15800479a91.28.1766648021160;
        Wed, 24 Dec 2025 23:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyl5vR43OkL/hDfKBDmGKAR37cMOZ8Ka1DFFBdJlFQKrUA0x40DEd0hamphs8/qa8tc2gRbIfcXUfzzGSd0U=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-34e921d0d76mr15800458a91.28.1766648020802; Wed, 24 Dec 2025
 23:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 15:33:29 +0800
X-Gm-Features: AQt7F2oZsDAy5UzUdBbuKS6sbUPRqmYTSaTWpVnvwoETb7rBpSLDuU-0lomm-PA
Message-ID: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bui Quang Minh <minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> >
> > Hi Jason,
> >
> > I'm wondering why we even need this refill work. Why not simply let NAP=
I retry
> > the refill on its next run if the refill fails? That would seem much si=
mpler.
> > This refill work complicates maintenance and often introduces a lot of
> > concurrency issues and races.
> >
> > Thanks.
>
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea=
.

Btw, I see some drivers are doing things as Xuan said. E.g
mlx5e_napi_poll() did:

busy |=3D INDIRECT_CALL_2(rq->post_wqes,
                                mlx5e_post_rx_mpwqes,
                                mlx5e_post_rx_wqes,

...

if (busy) {
         if (likely(mlx5e_channel_no_affinity_change(c))) {
                work_done =3D budget;
                goto out;
...

>
> Not saying refill work is a great hack, but that is the reason for it.
> --
> MST
>

Thanks


