Return-Path: <bpf+bounces-75672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3BAC909C7
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 03:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C175D348FAE
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CECC272805;
	Fri, 28 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtayZEB/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B02qwrLb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A472236FC
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296439; cv=none; b=IkwbCSAyNCRXDAE5iGdQmgb+oIdR+mRxvLsXnJBpx/Ry6umAPjPKal2ze9cseApdFzfQbJKjFreXeRc4J4mxbd9GtFUJDKR7sc5ab8Rg+nRWzfqQOjAkJvj/OK3JcEPl2u9AyCZ79Hw7cHc7XuHLGVExxhD7MOm4nUVG/3x4M8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296439; c=relaxed/simple;
	bh=juuT2szlDhnZah03azTXrfo8JNzsr8IYomevmrOodCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shmzG9P/+Kvo/h7OnuJxx+e8Q95v3ODTmi2IoRx0bkz9s2dTa14bNfavfXZk63u5RUEEIPbeghNXO6KktuzRKG4jZfop252r0pcIZKv2x3P+7ZytGaMIpRqoX0zorTNh0LS5JEoxNHk+SZCT5SCqp6asOJNJXBw9mkOst+oUoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtayZEB/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B02qwrLb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764296437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
	b=YtayZEB/+YjqB89mnp4TEoxhNisoD2sfXCKw8/wPZheDi2g5cTFdmdEEFaPRNaUT9VYOQB
	0zJVCCEgfIIKy0pJRXcoP3/Q72UiWgiwd8WAO3dXShPpTSrn7MPqLx5UG143ghBKgB5Sye
	ydnyTPkWjb4nvyXY7K51vIedLxORfyA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-JmPHPz0gN7iAfKN08QEh3Q-1; Thu, 27 Nov 2025 21:20:34 -0500
X-MC-Unique: JmPHPz0gN7iAfKN08QEh3Q-1
X-Mimecast-MFC-AGG-ID: JmPHPz0gN7iAfKN08QEh3Q_1764296433
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c07119bfso2048884a91.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 18:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764296433; x=1764901233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
        b=B02qwrLb5nhgd4pMuoFjAfOlr+HCondXLOpVNI4lQ2Vh/7U3F/7jfxzETDRiIOGpsZ
         tigohUpVBlQILpKhfZsj15HDFRZld6kzMkKB8wL5+a9kmDtafBw1o49tz7eCm/OEI+qC
         a89rRfpEzXXrbhaIxzYHYfmQtgaRcLJZMB7FxPkBe6moM9LCwIKOkw3ctmjxUmFaLD1f
         BBtDGCRFSmQ8BXgmhnTzWzW3sUGW2H6Upcc6mXVGIFEo7F5RvIyuHF1PjaT6W86Bxok6
         ragXWyqT6WrO83SLjG/Dldk5BO8raVsjYNMj4lSV4OaArbVynEDeOhaej11xqCwrKpox
         gxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764296433; x=1764901233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
        b=O+jfKQV51LA9hWesHwZUjafkjaitIgx6sTZUtGps9piRzjwynuvV0Jw1p41WaPFPhK
         3gI6GWFNJFYjEhzNHbX8Lqbg8qNiMt3cksSy4hqEKeqQuP5X3mJ8pxCw6tMzlL5SRNST
         XNTBKo0FAN+0poAMBpK9otWB72ER8zVNqDRxCDToV4l22kHvqOcbvxee++3f6K6T5gZA
         p+3zxS9/QftxQnBcfu0VLJ82VrFde9yILWO0WDMZeVXpO/BGqMCevfGnanGc61xMdRhA
         vyV/zpbwiU+EWWHHmq3WattuXiqI49H/tGv7hDt2G/Pk6ZSxLmbDCCQ/9NvOeN6nVNK+
         SyDw==
X-Forwarded-Encrypted: i=1; AJvYcCWJT6JvsWx0ib9vZ2CAlcHJZCXTBnQGO18pXDoA5JNMo8MYI261XAKxmThb34Oi2PZTpnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHE3U4n0Zm73XnxhHsx0VaNX1uoTA8CvU8yEBfAwJoPdjn3PWq
	dINVYT1CqxPMOYcpTkTibXf1O7u598F/5aUt4vtd16U01m6PLVcHWFHRy0hT9rqCi6BVqkQdNx6
	tHYrohufbuUfvuZ/Ji5+Vwjzp2fMBHBm/2G8OUhCBURqhyXLhWJDDyRzYcszXkwLpIu/44DIqkv
	35pjzL7IkrU669P8oxjZNMLWVhXpH3
X-Gm-Gg: ASbGncvtuRVO6A+xlkMQ/v5dBEagO3DQQ8I+TFMTwz1DY+JGeFC1X6xQJ+AJBC8a4lN
	cMaAPxh8t+SIKaunZLpfH9fDeGKUdIgIf3l0Mdel10jPJjrzgXjvWB1s434YwCyAK8t8d0xd/eu
	gsXxgDu9q4AHJPr/MjWjTQlhjb27tIht5CnWo65j715rtLF54AB4Fc4sQvAUvuhZe9
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-34733e4cd33mr24799060a91.5.1764296433351;
        Thu, 27 Nov 2025 18:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv94V6EgbFiEIs81QepFX0mRMFn3g2NyGux1CLfN5JgtlXv14IqI7OOH8tWGprrDA/aklgfN72ym5w+o80QPw=
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34733e4cd33mr24799030a91.5.1764296432936; Thu, 27 Nov 2025
 18:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
In-Reply-To: <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:20:21 +0800
X-Gm-Features: AWmQ_bkpiNIqEJYMSebVvAaf2aLCflDbTnLMVmn819Q7sJ2u-A2teXvBbKmJ7ag
Message-ID: <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> I think the the requeue in refill_work is not the problem here. In
> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
> will disable work -> flush work -> enable again. So if the work requeue
> itself in flush work, the requeue will fail because the work is already
> disabled.

Right.

>
> I think what triggers the deadlock here is a bug in
> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> __virtnet_rx_resume() which calls napi_enable() and may schedule
> refill. It schedules the refill work right after napi_enable the first
> receive queue. The correct way must be napi_enable all receive queues
> before scheduling refill work.

So what you meant is that the napi_disable() is called for a queue
whose NAPI has been disabled?

cpu0] enable_delayed_refill()
cpu0] napi_enable(queue0)
cpu0] schedule_delayed_work(&vi->refill)
cpu1] napi_disable(queue0)
cpu1] napi_enable(queue0)
cpu1] napi_disable(queue1)

In this case cpu1 waits forever while holding the netdev lock. This
looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
NAPI enablement with netdev_lock()")?

>
> The fix is like this (there are quite duplicated code, I will clean up
> and send patches later if it is correct)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..892aa0805d1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   {
>       int i;
> +    bool schedule_refill =3D false;
> +
> +    for (i =3D 0; i < vi->max_queue_pairs; i++)
> +        __virtnet_rx_resume(vi, &vi->rq[i], false);
>
>       enable_delayed_refill(vi);
> -    for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -        if (i < vi->curr_queue_pairs)
> -            __virtnet_rx_resume(vi, &vi->rq[i], true);
> -        else
> -            __virtnet_rx_resume(vi, &vi->rq[i], false);
> -    }
> +
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +            schedule_refill =3D true;
> +
> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);
>   }
>
>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_q=
ueue *rq)
>   {
> -    enable_delayed_refill(vi);
>       __virtnet_rx_resume(vi, rq, true);
> +    enable_delayed_refill(vi);

This seems to be odd. I think at least we need to move this before:

> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);

?

>   }
>
>   static int virtnet_rx_resize(struct virtnet_info *vi,
>
> I also move the enable_delayed_refill() after we __virtnet_rx_resume()
> to ensure no refill is scheduled before napi_enable().
>
> What do you think?

This has been implemented in your patch or I may miss something.

Thanks

>
> Thanks,
> Quang Minh
>


