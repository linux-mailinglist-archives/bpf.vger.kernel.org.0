Return-Path: <bpf+bounces-31159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1B8D77A5
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F31C1F213BD
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035974047;
	Sun,  2 Jun 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbJy1tI2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700F10795
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357854; cv=none; b=vCIkzsQoP4AGI9gquu3KuJklHDGBBZo8u4cJEXXnf3THjbIiVatmCliTF9VTIwkglze/TtKGuWM2mwvotytSyD6kljpw/lg/mSfQbbfnMNYZkg3MIV3rR+ZIq7yuwHR8rJOd49F++MjS61u53StmDcJiKxLeYNLuhE14wHw/f/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357854; c=relaxed/simple;
	bh=gPFTxi1ykAQRIrBq4wXHZNf/fKBP3xSqjBeWh75o0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hESspoQE9IBiMwwAztJxwYtbFI5QeJopJA9kqyk48XyqH3lvjrZB5u57a7QV/Hd0gqReg1//Do+Ssu7VAgyK/XKTJ2R7DI1JJLt+VQTJdu6xsQP1fQS7q5Og2YlbFzYZ4Hdhfg7nz1RtUy/iCYirkMNHB3XOV8g7ZjpJF86P+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbJy1tI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717357852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
	b=FbJy1tI25i5I1byssos/ARNtvEBlCjxVdgXeZv5OxA2EvWnUUULcQGL8yaIbHcfo2pGfbm
	g9Hq7bHXhgZHlpRKzNNgyjlf09rPNNKecS5xbPM8etqaHhZthDZVAhgqOIoZ6buBucLZ70
	Gh9q0Ae+0vXPJsQaMET1CbIVw/GzG4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-_ga3wpehP0qlEBlxCsLLIw-1; Sun, 02 Jun 2024 15:50:49 -0400
X-MC-Unique: _ga3wpehP0qlEBlxCsLLIw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4210cd005b3so22029625e9.2
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 12:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357848; x=1717962648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
        b=IMnqqwFvi+lnooEij1q0RudH7HwK/BWge7fia/Qoe4fUQ+ITdkCyIz1LJyjxzFeFmf
         Sd/gD//gz7/VhWEs2O9RzB4vK+rAy7fsj6C+3NNTBroDr0sapqeU4CXOFmsc3pKxluh+
         DZLyss8EJnLi3Oha10nIqHPFbLWIeDFephFYF0WYPNtpAvF9dPhxTftQPcfleDhi3QW9
         DctI2p3WedNSK9iJ0W3B1kcdGPphufV4Paxv/jzNQfvKOv7gO4CNIDdrDNCobDM3ImYC
         KoKynmG/znJT1sJDZ3ESYYI2QZ5yHNoKJ5X3xufvjSEow+SH/LEw/IKfK1jocYqmgz/Z
         LWEw==
X-Forwarded-Encrypted: i=1; AJvYcCXQn7ikTzgdNdcqSIykKS+69n8i+xr5zkIiWIeljq5m284VKsXuvJMEVRkFZABCsXnXH/G7zRl32PhfRnayX/LFeVfV
X-Gm-Message-State: AOJu0Yw+Isf7wCqBiwflaAGW2jTlXa3/w8Zb8jMc4+6mGaEa5+zD8kKE
	3cdike7IZPsTFwK7uRkRzs5vtZ7+u/X8uu/RLW+ncXr2ClWOmstsOyqPYolQsiAMjhnxgj1Z5TS
	fEokO6hc8CIslsPhgHAgo9r2pzVpR1jkfF7TxvWw1HWTvvM3BVA==
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109655e9.35.1717357848064;
        Sun, 02 Jun 2024 12:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYqsXbQOYD23JV0Nxts22Ok3ofm37UBzuKMoSngQUM7XRrHtQ+KzJlWwXOOHAHTXv0enXVpQ==
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109505e9.35.1717357847536;
        Sun, 02 Jun 2024 12:50:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d98sm6838419f8f.24.2024.06.02.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:50:46 -0700 (PDT)
Date: Sun, 2 Jun 2024 15:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/12] virtio_net: refactor the xmit type
Message-ID: <20240602154943-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>

On Thu, May 30, 2024 at 07:24:06PM +0800, Xuan Zhuo wrote:
> +enum virtnet_xmit_type {
> +	VIRTNET_XMIT_TYPE_SKB,
> +	VIRTNET_XMIT_TYPE_XDP,
> +};
> +
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)

No idea how this has any chance to work.
Was this tested, even?

-- 
MST


