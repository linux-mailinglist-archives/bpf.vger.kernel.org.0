Return-Path: <bpf+bounces-56039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E16A90467
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E3E17E5E7
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644A4174A;
	Wed, 16 Apr 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feYyS6ms"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC134409
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810341; cv=none; b=k2UugJUNGZ1bMuWBs3a7GwNMoud3WG2uqxaUUahvFdNXlNm52pPw+qUxuZJU1O1Va+L36M+NivXtri+odeptamON/Wa2JVFECi4i+s2fPZoIC+olJ5NXMBH3G2GvbLw27G6PS5RYg3eFmebagAR9aKWDzAW2qp9ypHkk0yaQWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810341; c=relaxed/simple;
	bh=+Bprm+jQzK2Qk5tEcCyXJHdixjHkT+diGVHI+2AhPjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YSAvxTc87nLUyL4yoAmfKRAEzIcYONvHI6dRvXlSM7Mx/F3degSWWsbzu+gCrt7OsMP/MNUm+uJHT33qliw2cDnc/nnf66W1dUt8+SHcloGqeZSl31wiEvPo3L0yCWYBR7RYV5ClPllKqW6wcbutyZx1eHuOcV3825az6fRXgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feYyS6ms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744810333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=457zR3h8UGkE04gyb0Jb3zcqH2gPSSk6srV8sYhzz3U=;
	b=feYyS6msNMNVRz6itsiu/uFx1rWJoVS38THbtOWr4VbRq3vGJ00SHOWP5whCU84iWVtmUe
	d+FLLDWY+m3snEUuzPR6ij8Bi4MlKKAVexp8npSEaKb/Gvh05KhVyAet/RJmSdlaF3Xv8j
	JkAQ/Z06Xv4/u2Oh+hoQUIm/4ELhSw4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-YI8nRAqWNQuBLIGtX-5qzw-1; Wed, 16 Apr 2025 09:32:10 -0400
X-MC-Unique: YI8nRAqWNQuBLIGtX-5qzw-1
X-Mimecast-MFC-AGG-ID: YI8nRAqWNQuBLIGtX-5qzw_1744810328
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c04c54f11so33999291fa.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 06:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810328; x=1745415128;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=457zR3h8UGkE04gyb0Jb3zcqH2gPSSk6srV8sYhzz3U=;
        b=VRcxwS0GwOPhr48aqbY20Ot+iTEP62QqLElWkQgLaXDjUBQhLD6CMb16oKTJHfkzvA
         Ya6cc96RulTmABi99hq6mm6DzpOCpkQzYexua5UO5qVcfrcHMhRh9I5tK8kLeJ36LeZu
         AXzDKUNhFMu1JniGjCMquorxwk4QbPUq5eOK50WxuBeQxIv6J1cijUW27XgqsRw+EbpJ
         DfrXvbAN08utD8/6BPAQD8U01JVkThnsSTBMVJUl7lKg4rkmK+p1s4LWO+XlpeNzclpb
         ielgV3mI6Q8wSV3t5jaLzdey1EcP3jeOSWmx5iCzbDvLmkcKZxJdR8j60Hsru1YfSB1t
         3KSw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaf8vxP8SSW0v1cF0gmibisFqg9sV3TeSDQnfGba14cj9rOlcxw7X1pK3IOnjBnIOQc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+aATdG0gE8QQ4W4qPqY8WJ8LwJpgfars00m0gCpQwrETWouZ
	PbdPn26u86ZcrGLvZ5MRLVGWgOJ1A2NDd3EYMxRDfl2M/gfbjOmuJ3WI3TeC/1Z9UkRT1tHntUU
	963RhcMmpyFdr6zPvr0TsbYxk24uOx7Z8z5yWtANbcpo/Box/fw==
X-Gm-Gg: ASbGncv7Mv3ihlY29sEBxBsTv93jAj5U87092zh/MijK7vlt+RjoK8p5GpQsF94jQqz
	O3ty6UGGo1gW11Hts22p5oC7npgbHNlZ5yCfIM9osWQFs+upJpCAGpFTmYAskMGYE6fwR+7tDsj
	Q+r7dPAXnMGlDv/CcO/K0ZyKnS33wCPJTJp/yxG6ATYnyHnsfdJTIQnhFqwCZ3IjxiG/GG44my2
	WpFJWLQkUsFjADQYKw8oV+O7QqVhoXP2ddMv0SNj6ASm+AZW2dOrF30Mea2tIIYeA6ymtYnlHyV
	fLz8ZT+9
X-Received: by 2002:a05:651c:884:b0:30b:a187:44ad with SMTP id 38308e7fff4ca-3107f718b00mr6731521fa.26.1744810328188;
        Wed, 16 Apr 2025 06:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElnOK3S9qd1KXpmFsBs94VTvypJz/yoSSnw9dvy8ZTso1V7fPWo4L2fDiSjHn120HodO1hjg==
X-Received: by 2002:a05:651c:884:b0:30b:a187:44ad with SMTP id 38308e7fff4ca-3107f718b00mr6731411fa.26.1744810327763;
        Wed, 16 Apr 2025 06:32:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cc461sm23907401fa.32.2025.04.16.06.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:32:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2B5101992930; Wed, 16 Apr 2025 15:32:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 1/2] net: sched: generalize check for
 no-queue qdisc on TX queue
In-Reply-To: <174472469906.274639.14909448343817900822.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472469906.274639.14909448343817900822.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:32:05 +0200
Message-ID: <87wmbki65m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The "noqueue" qdisc can either be directly attached, or get default
> attached if net_device priv_flags has IFF_NO_QUEUE. In both cases, the
> allocated Qdisc structure gets it's enqueue function pointer reset to
> NULL by noqueue_init() via noqueue_qdisc_ops.
>
> This is a common case for software virtual net_devices. For these devices
> with no-queue, the transmission path in __dev_queue_xmit() will bypass
> the qdisc layer. Directly invoking device drivers ndo_start_xmit (via
> dev_hard_start_xmit).  In this mode the device driver is not allowed to
> ask for packets to be queued (either via returning NETDEV_TX_BUSY or
> stopping the TXQ).
>
> The simplest and most reliable way to identify this no-queue case is by
> checking if enqueue =3D=3D NULL.
>
> The vrf driver currently open-codes this check (!qdisc->enqueue). While
> functionally correct, this low-level detail is better encapsulated in a
> dedicated helper for clarity and long-term maintainability.
>
> To make this behavior more explicit and reusable, this patch introduce a
> new helper: qdisc_txq_has_no_queue(). Helper will also be used by the
> veth driver in the next patch, which introduces optional qdisc-based
> backpressure.
>
> This is a non-functional change.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


