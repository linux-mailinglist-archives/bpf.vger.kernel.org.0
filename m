Return-Path: <bpf+bounces-31351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428248FB8B0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94B0286D50
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D1487CC;
	Tue,  4 Jun 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfEtLhqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE08147C90
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517906; cv=none; b=SuhDBdJ7BsGm5nkfH+tvPGtokbrg0/LmjxEm7bA7cxCMfEOXF+0tcROUsmeFBOpAn2IpTU90WeY3/ltf05r0FDdpgxg6sUotqIl6Jobw7wjp7exEdGtuIbel01AiN6FEJCWPeJq5FgP5uqd0k2Aq/1oI2mWx8EqcoPjYNjRo430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517906; c=relaxed/simple;
	bh=nPqXATH3gJO0xG3OcvVlRB8VrvjY/FhA0oPoFQeHE5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR4cLdSGd2XJm5TNlIikI+KcYy7o82hXp+r/R9bnezNHqR2vGWccM7JgNv7sn5aof/xXFaYK72Mud9Qd9pjvGX0xGfQlzBh9yal/nk+NaPrc/1Rmz8nERRqg/GdNe7HCQrCvHtaIZY/F00X2Z+wZXoOqIq14N2JJYNuabxM6daw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfEtLhqw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-702442afa7dso3750518b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717517903; x=1718122703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdfqg+XI8I+MI3h2wU8ZL/dAxG9QlNacDO9P7kZI7gM=;
        b=MfEtLhqw5YqEBo5Z/gPPho2xFh4bZEyajq85qVR+voM+VZTYNdpr4vGmaOb5tkzYvb
         hjZHUkTlq+vx7jtXBqDnDNWXAuUX6J+2JXXVe86fssXzMO7DQy5sCV8ejaMYd/MIsNKL
         QIdn+At/RtcKaHGBo0rPKgfZIX7hsSzcZXxZdX+P9jVaMZZl31k+iwbogPhwvD0BBFjw
         DWL027nMZD3ELu7L9gnh4V31Nlk+GzzXyR7phhkdzPypf+tcwA7jCScPIAzjzRkmPn0a
         s637czL131zlJCy+FcHMX7UzLZDMlvKUhqvgBD7QktPKMbD2ljgZC397sGbza0bFJzUr
         Uirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517903; x=1718122703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdfqg+XI8I+MI3h2wU8ZL/dAxG9QlNacDO9P7kZI7gM=;
        b=SA+GYfJDym2ru9RCbYw8TyzT86djEPxUvPzsMR4odS+ERcmfJnQcOx01vEpwYmgDku
         28GayQbefe5qSbGoyy8V/7I7sFxTLoQZbNKIXDgPGCc11HiYcZAM8wpvFF44x/MpG3QS
         kr3V4mnBjqXE/NbVf+co/1Lb+Zllz+EgRy93l0VQ+NuiW4Y+U0qXo7Ns1yk1+rCSYcbS
         SwtqUcwlbh3a40um68BkmuH8kP4V+VqE7xCp9CwqLmqTjYkelLhQp/+NEvTWXQCxk+wQ
         +d98f3CRXr8NUFJX+Kg/0e6Zcc4Ox0iPUXCzAxVwDp3zHnyFWp0Uv81PNcjeGaXkkKZt
         cacA==
X-Forwarded-Encrypted: i=1; AJvYcCWecRhZf7lPXOJR6FlMwKCy14UF/bSgz70T/eAIveeSfgcYzfeupLgkiWwNswc8s/KjxHz+4VtjoMDFg03f+21bls0n
X-Gm-Message-State: AOJu0Yynfp2lNYKrS7mZe90boqQ9PyhWUuYmmVvL3NSfEEZlDq3xhUy9
	563p6MasJYS2wIQdj3sTCcpuPGYQQ+c0Y57bvFGYjTUKKkkcnxpYAdWKAI+nZd6cc8pDn6zyroC
	4VmngwBuWhXX9b7m4AnlJsHCNHXK08spZ4LCJ
X-Google-Smtp-Source: AGHT+IHH8BcDT51//iJobaXt0VIzNrVR1B4YFM/qgQyKNVEvfCFBn+scD7t29ulO1UCUwWCXKi767BV3CuTLWi/kpUY=
X-Received: by 2002:a05:6a20:3d94:b0:1ad:90dc:4a65 with SMTP id
 adf61e73a8af0-1b2b6fba62amr92507637.27.1717517903068; Tue, 04 Jun 2024
 09:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
In-Reply-To: <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 18:17:44 +0200
Message-ID: <CAG_fn=Wv4Tw8guW=mFYyV9T18C_qPZOxr3fwKcRkDVXm1e+iXg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c
> > index 8e81b01e0735..f9f772e85a38 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct
> > vring_virtqueue *vq)
> >  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct
> > scatterlist *sg,
> >                           enum dma_data_direction direction,
> > dma_addr_t *addr)
> >  {
> > +     if (vq->premapped) {
> > +             *addr =3D sg_dma_address(sg);
> > +             return 0;
> > +     }
> > +
>
> I wonder if something needs to be done for KMSAN here, like it's done
> by the next block in this function? I'm looking into what seems to be a
> KMSAN false positive on s390x:
>
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
>  receive_buf+0x45ca/0x6990
>  virtnet_poll+0x17e0/0x3130
>  net_rx_action+0x832/0x26e0
>  handle_softirqs+0x330/0x10f0
>  [...]

I think there's a similar problem on x86 as well:
https://syzkaller.appspot.com/bug?extid=3Dc5336dcd1b741349d27a

I was going to look closer this week.

