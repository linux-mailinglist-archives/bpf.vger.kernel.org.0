Return-Path: <bpf+bounces-53581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB114A56A78
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD618985A8
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51121C18A;
	Fri,  7 Mar 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFa1Dmuf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33521B1BC
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358121; cv=none; b=VlKR9g44JfUu4B2kRQZyAYUlEicuiLBfd2w0bsTP35/kTN3i5EaV4rKKmxjeHdMybj/9fc4PFQMFFukM4EV7zelnicp4UTmqD9eO7f+w5Xdj1lqu+73qag8U/HMmF3yKl6lxvXbOqASWQageWLC8Jux1yIzbsuJkzeYtxufPijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358121; c=relaxed/simple;
	bh=lXPuIqZpRsLXS7HTLdbt9BkY4/cOeXu6m2fmTRxBo4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOqdpdQNA0elGCBvjJWHcncF1jr7mNCMH3lRW83JLsuSRQDqkGBPQuoNEdIKXw1QxfSCLFxiGuVLYl2KdbeywGRk2AiP9AE71PGuO1tcWxR2tum1WjLuOVWnRTol/7fcKZl5DT9XdPZWeM58xHzajVjaYIO5VLib/Nvng1PM8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFa1Dmuf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741358118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXPuIqZpRsLXS7HTLdbt9BkY4/cOeXu6m2fmTRxBo4c=;
	b=aFa1Dmufojueiakm1r7BYdlqlq1Dj7HByNaXIu9n+oGaSRXE21RX+dHhvSdkl9t8XrD9gr
	wFAYV9Te/zKAAab0Wn75rdQppOAndkf1UBsOjnsI/flurMek/nKzEGLNP2l/ekHRQ6jmWe
	jLXc9EEG10aa5XtE0LwUvXu/Ddz57LY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-OffPLK7zNRepKbOybHcYbA-1; Fri, 07 Mar 2025 09:35:17 -0500
X-MC-Unique: OffPLK7zNRepKbOybHcYbA-1
X-Mimecast-MFC-AGG-ID: OffPLK7zNRepKbOybHcYbA_1741358116
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac254e4b515so109059866b.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 06:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358116; x=1741962916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXPuIqZpRsLXS7HTLdbt9BkY4/cOeXu6m2fmTRxBo4c=;
        b=qmQq5suAwEDo72Jq3na/rippCg626DYejkxhuh0RmcHxD9tunrfSZOE2Adho9nAYL1
         k8WaCRI4Eud//asmS1WRJ4ek3QvNQIX2NKiCqWbPF7aCNyLJh+qTmlEOqhjwgXwtZMdX
         Z5hNlVrN2EJ9+NNpsi4NOzeyFp58khMsN/4zEwxBSwBFKNSVbUBHEsh9Gy+upvB0re4l
         GaaUT+n9auNzArmeVilvwk6edSMONF01rKhZY0iEV0yelByzD54jpBraEK2cWpXT2/2J
         pnQ08HxzT5VlKZjQ5b1ul5Cnq06PAsgaXGiwHQiRnDJMgDaPQHYnscQ6ZdGzO7VjcMYn
         IAIg==
X-Forwarded-Encrypted: i=1; AJvYcCWnh8ZrfG0bw/8e5Himiy2znE+7CNxaLST+a63U4vrsffNDZePP6oN0Sncm/Rg5coccduQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLSlFN8OhRVmtAm6V2+n8lpwkyphH/zn7xuSJA4+xhTNxfcaG
	DiSvBrcz1uFenyZteaph0mWYVU3EsiKzYqHOjCEA+bmJPRCjO5RcpJNMPgMSgbZOaOkkZdiUd+c
	AI5Dvsrf6rultgwoSk1zq3A85EgYqahEUAhMHSHbAI1HRjYjkHA==
X-Gm-Gg: ASbGncuvX4SP9+Zk9Hp+yZUJkpXMS//sexqrXjcb5GOrenzXwitGCyFvZJiioYrKZiW
	dNOOVMNWwilOipyvfvd1REwhJMNzwx1MSsl+cyXoctuftxastlBsL7IBXei/JjWGOxbJakZwlWI
	GkpRQMo0fmFqVowVXpM+t5deIcYbJtsBPBg/SlJFdZuKhFC1inw5I9VBJyOt2jwriQDrl9NIf0i
	byAt4dCmshi+IKHj0T8MwxF6MOCPSLauUBmqUeogkFCKI53TE/S3zWeRh7JfTx52mPgzEJIfb2S
	qaTXTvHNt8t9jR97bjjsesXEzgEb4IVMRYi1DQBqa6rAdCdD2iE7ICgujr/tjRzn
X-Received: by 2002:a05:6402:4406:b0:5e4:a23c:cf60 with SMTP id 4fb4d7f45d1cf-5e5e0c75fd3mr3632025a12.15.1741358115882;
        Fri, 07 Mar 2025 06:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5XmRDSYw2pZ06YZPy8CJqObswYrJRUdc35TakQU/59g+VScncGbjG8qbB5bHHdK4wL/va0w==
X-Received: by 2002:a05:6402:4406:b0:5e4:a23c:cf60 with SMTP id 4fb4d7f45d1cf-5e5e0c75fd3mr3631967a12.15.1741358114906;
        Fri, 07 Mar 2025 06:35:14 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a9315sm2646455a12.46.2025.03.07.06.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:35:14 -0800 (PST)
Date: Fri, 7 Mar 2025 15:35:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, leonardi@redhat.com
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>

On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>> Signal delivered during connect() may result in a disconnect of an already
>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>> been placed in a sockmap before the connection was closed. We end up with a
>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>> contract. As manifested by WARN_ON_ONCE.
>
>Note that Luigi is currently working on a (vsock test suit) test[1] for a
>related bug, which could be neatly adapted to test this bug as well.

Can you work with Luigi to include the changes in that series?

Thanks
Stefano

>
>[1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>


