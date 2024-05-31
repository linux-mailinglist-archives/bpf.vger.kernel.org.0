Return-Path: <bpf+bounces-30986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCB8D56EA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93633283B55
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D664C9A;
	Fri, 31 May 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5Fex2i1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5A1848
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115194; cv=none; b=g/1gj88w621jbZ0uwhbOuocZxYCTBxj5Dohp7PEGygAr/hJe2hv8OLJAcBe5JF5RWbz7S7vN9EQlDydU41OqBQxeWmRSs2R3mIZq+FFn65ZvXWBGX2o/i68DhyveuWg+ukCdANmAzrrXFlrv0rg+6aUMJSFt+Zx2utGSKiBmupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115194; c=relaxed/simple;
	bh=yF+ay1y7SPCrJDKzpmXB3jKBVDA5cGjvnwHThdq9z8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs0thwNqZ5/38YhtlahQ4nTF9oqK9bJxWIHyvbuhNWOpwE1BWXsz2V57A1nQ34NCW20cB6Kcc9bmfjNFDWV36FsV4M+vnYWd0KeRdN9mdeRk2jGP1gT8cFgKhgAmNfLNYK8CE1XWPZ5vZAOjtZLxrBm3ArDxaHtDHKJ//iiq3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5Fex2i1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717115192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aipVkvfwSPi3x65R9DjuBZzar5P1bHnBi9T0bdxSFnE=;
	b=a5Fex2i1nv1Xi3jt6+8pozREehmm5AqQWTqEkiYwYDUnWtpA8lS28UTmJZuPufTCkDQMhA
	vWJYdjHLY81546HUhLgZl3/jqiVojXjgJ0k6wsPk3QxkKvU9mG/RsGxfdfrIYMN2na1TFN
	pfHoOrGdEkGX0BXZZU9CZAc9QD0HgZ8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-G9UY5faXN1isB62wU2AAHg-1; Thu, 30 May 2024 20:26:30 -0400
X-MC-Unique: G9UY5faXN1isB62wU2AAHg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6507e2f0615so1263854a12.1
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 17:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717115189; x=1717719989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aipVkvfwSPi3x65R9DjuBZzar5P1bHnBi9T0bdxSFnE=;
        b=py/wyF+xfnid+lpZXyGz0v62AmOxSUa5N3r9qg67VgIvo48ZeE8ttlX9n6Trnk9Y+G
         k8W/ux7UhZvBujVs1XMxf/uDkMi7pgU26xwfMRCpkKdeIH4WMr56cTXcWX2kRcSGiJ1O
         SaCD71ArUDFwPYn6kfvV6NhjKtWs1Y7gJL0mBYHP/sArfMmO+2hbHXfJc392x7L+Ixe0
         FSYrMP9jK+Hi7yCG4rHVyIrgrrJGEn3nUyhaNV9NjfZ/F6m300gaG5RI+gFfUJy23Y9S
         PAlf2t+uw180qILWy1G8UlpH01t6s1s4F+bxe4e0DZ2D7V5UMRuFI6TdUbpViSWKaqOP
         wTGw==
X-Forwarded-Encrypted: i=1; AJvYcCVAUVIK3qR6iec82hW0Cv4lNXYam9l8QZ5YVDo5v7E23q2pT+8eA6wPzbj+bjcyChtspVlVm/s7Y95rh+notcCMif7y
X-Gm-Message-State: AOJu0YzYrtawMRPZyQlSODn0Ii+Jm1Xl0VIMHok8A1XCjnALcbzJXKR6
	3fnPxC5j1V2kXNX7ni2yvjqWrRdT4hEHjgqRVPX9tUrmxTJul1TKyiHz8fO2KVyK/FX0FQUBsqI
	93SqLi2Mx+xmvyl9+WtVFpu4vEI0Z8RskFu2NWDiN/Ook7cBC214qnyt28hHLIOarDu4S71ju46
	nPk/U4ptplNbpg/be09FserBLZyl0cY3zPl5w=
X-Received: by 2002:a17:90a:ee8d:b0:2c1:903a:70c0 with SMTP id 98e67ed59e1d1-2c1dc56da0cmr314185a91.7.1717115188994;
        Thu, 30 May 2024 17:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+FKtWSIuvG8wEVIw8VPXf4nzjC1uorNnBomYozkOp7iti04ZRCzNVR/yD4JfFeLec7XdUQrES9X+D7O9driQ=
X-Received: by 2002:a17:90a:ee8d:b0:2c1:903a:70c0 with SMTP id
 98e67ed59e1d1-2c1dc56da0cmr314157a91.7.1717115188478; Thu, 30 May 2024
 17:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717026141-25716-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEugdcKjxMA_3+-gfh4wKOP5vTvYOb2V+MP7VxDiZ6EhiA@mail.gmail.com> <490d42c8-5361-4db4-a5d1-3f992f4b8003@oracle.com>
In-Reply-To: <490d42c8-5361-4db4-a5d1-3f992f4b8003@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 May 2024 08:26:17 +0800
Message-ID: <CACGkMEvdyFxL1dW81H+=uEqZWqH5-AVOE_0y3DCO-pK4ap==fg@mail.gmail.com>
Subject: Re: [PATCH] net: tap: validate metadata and length for XDP buff
 before building up skb
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com, 
	boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:05=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 5/29/2024 7:26 PM, Jason Wang wrote:
> > On Thu, May 30, 2024 at 8:54=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> The cited commit missed to check against the validity of the length
> >> and various pointers on the XDP buff metadata in the tap_get_user_xdp(=
)
> >> path, which could cause a corrupted skb to be sent downstack. For
> >> instance, tap_get_user() prohibits short frame which has the length
> >> less than Ethernet header size from being transmitted, while the
> >> skb_set_network_header() in tap_get_user_xdp() would set skb's
> >> network_header regardless of the actual XDP buff data size. This
> >> could either cause out-of-bound access beyond the actual length, or
> >> confuse the underlayer with incorrect or inconsistent header length
> >> in the skb metadata.
> >>
> >> Propose to drop any frame shorter than the Ethernet header size just
> >> like how tap_get_user() does. While at it, validate the pointers in
> >> XDP buff to avoid potential size overrun.
> >>
> >> Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendms=
g()")
> >> Cc: jasowang@redhat.com
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/net/tap.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index bfdd3875fe86..69596479536f 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -1177,6 +1177,13 @@ static int tap_get_user_xdp(struct tap_queue *q=
, struct xdp_buff *xdp)
> >>          struct sk_buff *skb;
> >>          int err, depth;
> >>
> >> +       if (unlikely(xdp->data < xdp->data_hard_start ||
> >> +                    xdp->data_end < xdp->data ||
> >> +                    xdp->data_end - xdp->data < ETH_HLEN)) {
> >> +               err =3D -EINVAL;
> >> +               goto err;
> >> +       }
> > For ETH_HLEN check, is it better to do it in vhost-net?
> Not sure. Initially I thought about this as well, but changed mind.
> Although the TUN_MSG_PTR interface was specifically customized for
> vhost-net in the kernel, could there be any userspace app do sendmsg()
> also with customized TUN_MSG_PTR control message over tap's fd? If
> that's possible in reality, I guess limiting the fix to only vhost-net
> in the kernel is narrow scoped.

I think not, sendmsg() can't be used for tuntap.

>
> Additionally, it seems just the skb delivery path in the tap driver (or
> tuntap) that populates the relevant skb field needs the ETH_HLEN check,
> the XDP fast path can just transmit or forward xdp buff as-is without
> having to check the (header) length of payload data. That said, it may
> break some guest applications that intentionally send out short frames
> (for test purpose?)

I don't think so, various hypervisors will just drop short ethernet frames.

> if unconditionally drop all of them from the vhost-net.
>
> > It seems tuntap suffers from this as well.
> True, theoretically I can fix tuntap as well, but I don't have a setup
> to test out the code change thoroughly. Any volunteer here to do so
> (test it or fix it)?

It should be easier than the tap. If you can't find one, I can test.

>
> >
> > And for the check for other xdp fields, it deserves a BUG_ON() or at
> > least WARN_ON() as they are set by vhost-net.
> Hmmm, WARN_ON may be fine (I don't see userspace is prevented from
> fabricating such invalid addresses through the TUN_MSG_PTR uAPI).

Tap doesn't export socket objects to userspace, so it's not an uAPI.

Thanks

>
> -Siwei
> >
> > Thanks
> >
> >> +
> >>          if (q->flags & IFF_VNET_HDR)
> >>                  vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
> >>
> >> --
> >> 2.39.3
> >>
>


