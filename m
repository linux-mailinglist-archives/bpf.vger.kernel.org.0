Return-Path: <bpf+bounces-76341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C3CAEE19
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 05:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C70430155F7
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 04:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C315746E;
	Tue,  9 Dec 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdbSLmo6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4Uyxwp9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAED3B8D7E
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254636; cv=none; b=fAUXmaakFWbiE7e725MtGfwdvJ6DF3hoa4Ygb1UuqLDZOMu7FkKgai51CfmuaqiJwnJ+a+PdRV9UAw2Em0Ib+TJHUJz4UYRM1JDN+uqQI9o5vXfu2E3XneQZIk3Xvvpfs31xV03vWwqkjbw9AV4UQ4yzQNIkgihbY4atpECDwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254636; c=relaxed/simple;
	bh=FqRrkq9RkhhKrp58S/BccmT+zycBzvr/ayVbPtBPhHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL+eHhgi5xi6Yumn9JYAB0bRVL4SZLTRod6D9heDxBxpgl8dNaVjguqFGvyQFbEEJrbmr3JY0/b06PSI9RxNUD3/PbZELIEY60xVbBKI5fcFyKaChas9x0y/+yR0kpydsNF0EJ0YoI2KA+aPLMPGGPh5kKgt96d9C/8rHqsZg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdbSLmo6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4Uyxwp9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
	b=GdbSLmo6IFzW3FVL6zqQGG2jc0hAzRlDWc01c20aeKCwZhfFv7lw7glrHlnnEfbt4cCdDL
	TBO4YvPOmvicosF6Bn6L6VeoPXD/uVqwDrRNDsOODE9QxqYo+ZdS2NvFkQoJ/B/dUyX0fi
	CDfx2Kwc69JjjoNWCKrVZ94i6YEHcZE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-f3pmnHflOem7wFZ6duUHFA-1; Mon, 08 Dec 2025 23:30:32 -0500
X-MC-Unique: f3pmnHflOem7wFZ6duUHFA-1
X-Mimecast-MFC-AGG-ID: f3pmnHflOem7wFZ6duUHFA_1765254631
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so5463806a91.0
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765254631; x=1765859431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
        b=E4Uyxwp9tGS1iUCji8Mu7parAvXXFR3GTTd3NEVKrML8dbkzgGikatju3VJw04hFYg
         JytuHgLrrc4/8ztE41NZ3caw67VEEqYuQMmxrOro/OJeOIpz7QGPbe9YrOVOE0u8qjiN
         SIJWjcZ96aRkUmlqyp7JPdjrpY6LvB/mDH9w39PPUGCQHInrRYx4llof58LB2ord7BPl
         ejxRGv+kt6Mp517Ht8Hu5Xw7IZrsdIg25+8cCCYTssnsf5YVlBRrP0/DSYGjJdzp/HY3
         Lag51gUWynquaIAjA9sK13TS6cUI6IK0Vr2Nxxmb94cDNRqnSQH3EKp5/kkokRaxeQOI
         6oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254631; x=1765859431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
        b=g57ZwiuSbRltys0wsPteBBd4Y/C7rCETVASKscWRkY0q2mNH/KswXHGG/STCCD+A7P
         qjPyx3DQ8GjKycpmViw2tDufCrQNu6xnpGlE3ssUXcFe/+UhIUogqzvcDF979EImQiJB
         zK4Aj8vKqhul8ghl6MFTnF2OjCHrhQheA+RdkPM/E9i3OU9n6mxJjq2jsngeP+es4bWt
         DUt3OksnlYRrLg8zQQLEfLuZr5u/Jd+bmC1aHnjBBIneC30b9zHJzKw76r11zvt4ivFg
         KCShs2UmJ8MPUfMxq/WRdHOFUCRvKJ3A/gxtRsGEGUH0zA5icaM0kB7DlBPL0lnpkXpp
         Ir3w==
X-Forwarded-Encrypted: i=1; AJvYcCVxV7/L0/iamm+mccqgvmNFwetxGZEYJAZFDlTGqUp++LAqQyxsBpMffeWi0jy/yb608tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gghvq7CPo7/9ps0O9tR9t5EZB1m9aqwXTfrhnzP9QWr29uNv
	tlqgB8+/3S6xjMa8ZzdU+0tg/mPtfSFkJGXBhbDVXCiPMZztIzd6lo9iviEDwh3Ts6iJkyhbJZ6
	a7u/abkLuyIKo7QvfQ7i54YpZL5GExEfGOe3/qbu+AynxfZNfM/7uBF/WPmTE7f/W8CC/JU1MHY
	twkI1U/EFG+nasi+zuhKlqxKhUHz3s
X-Gm-Gg: ASbGncuhfPLzjxO4vNQWEstq/121witzrVQiymHvyaoseQ5U0CKA/O4w9GsJGcJnhYd
	V2mDSiSSRTl/B268StEFTl8HL4T86rh0XUUtZY8qlPTAyXGWBlbisuTwZIQ4kKZr2J0s82kpplM
	p6lRSF4vRstxuiR6q0jqw63DhOoKwrvjuTjCmY1XsZKv6dNetQKEfU7okSYEA7cfNXgw==
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-349a256e409mr8500168a91.16.1765254630804;
        Mon, 08 Dec 2025 20:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExGqnqO+DyztHKRZgQziFfQnzweFIyxEgvKR3AsKvJmK7dcSqQvfdQGlSNvqQr39deZXVUow2OFVn3WFQTU/s=
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id
 98e67ed59e1d1-349a256e409mr8500154a91.16.1765254630384; Mon, 08 Dec 2025
 20:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
In-Reply-To: <20251208153419.18196-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:30:19 +0800
X-Gm-Features: AQt7F2pdiWKYZftUX6M208UPAFNmS9Br13quSDg8KS6iZmKHEOuykxku7dVVBJ4
Message-ID: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..f2b1ea65767d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return err !=3D -ENOMEM;
>  }
>
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +       bool schedule_refill =3D false;
> +       int i;
> +
> +       enable_delayed_refill(vi);

This seems to be still racy?

For example, in virtnet_open() we had:

static int virtnet_open(struct net_device *dev)
{
        struct virtnet_info *vi =3D netdev_priv(dev);
        int i, err;

        for (i =3D 0; i < vi->max_queue_pairs; i++) {
                err =3D virtnet_enable_queue_pair(vi, i);
                if (err < 0)
                        goto err_enable_qp;
        }

        virtnet_rx_refill_all(vi);

So NAPI and refill work is enabled in this case, so the refill work
could be scheduled and run at the same time?

Thanks


