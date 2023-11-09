Return-Path: <bpf+bounces-14550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E97E6380
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 07:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C99BB20C8F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DCD287;
	Thu,  9 Nov 2023 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OawGmaT1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EECD289
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 06:03:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA926A4
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 22:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699509816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
	b=OawGmaT1SxUL+OEdSDYoRxhE4eNQ6XaVlowMKU0UREvSnHEJ06OceHT6SVE7aV/n/oAl1E
	bP8tHkN6uhETRGuxVBjNGKZh+82JZDUx/aOYr5bs+UeXK2iZleSzxKzl+zvtthWd0fDEfA
	jkN5LZr0zrLk+LqyzDt88Gic3JdxJJA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-vKg4QFdUPxKvf1STWq8XLw-1; Thu, 09 Nov 2023 01:03:35 -0500
X-MC-Unique: vKg4QFdUPxKvf1STWq8XLw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5090b916b7fso487417e87.1
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 22:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699509813; x=1700114613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
        b=N/geNZ5fTJXix40c8UZLledY7c9V7aP2aaKzvQbSY9VZa7C8V8pbQG5UX/KNyF8cS9
         /SnLWR6vri96r9wTXylM7v4xl4aTVZHlR2UG4P3SlPpCEZleMQgTTNnXztGLORbKCx+t
         F1mSelzG3jo8D8ip2UyhL4fCgjXGMf5yCSxYrc1i/VTliErrA18g8WcSAI4VHWMPfwrW
         AmTqFdzcV0MWPE3p85EWE7aRB+vnSNFdxEQasmdEW9qXtaEZrcpTtzAJP4LgZJuUJzcY
         Gpewupbw+ymryUospk0BBISZgr/dEo8TdPkMpiWy2dLbvypafAWsNIVzeEhKBBnFKx/v
         cmuA==
X-Gm-Message-State: AOJu0YxqbTiRLXHz49ymn9A0ayFgA1O+T8lUoF28y71rdKVh4I0/4MBE
	VmxTXCumam61zlQEa95YvEnc5kTidhRQLtVJLWYipyNRiD2jU7NlcI/Bz9ZW4any4l+cMATf0Ns
	dxCy/IIelKXtNxqB5q3nYFD1fzTyg
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id d23-20020a194f17000000b005032debbbc1mr411131lfb.22.1699509813667;
        Wed, 08 Nov 2023 22:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYsjgTD24MZnXktKx7aRviir9RZpQgol0T8Q0VdFoaD8xNFvxps4WomMhc0qsMn/K7CszOgRlSkSBitpfIyVI=
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id
 d23-20020a194f17000000b005032debbbc1mr411106lfb.22.1699509813388; Wed, 08 Nov
 2023 22:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:03:22 +0800
Message-ID: <CACGkMEss6=0ZcmEV-YNSVXiH48TzT1A_VdqrUHbLNn=qW5835g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/21] virtio_net: move core structures to virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:13=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Move some core structures (send_queue, receive_queue, virtnet_info)
> definitions and the relative structures definitions into the
> virtio_net.h file.
>
> That will be used by the other c code files.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


