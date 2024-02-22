Return-Path: <bpf+bounces-22524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D63860383
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B3928A83B
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649246E5EC;
	Thu, 22 Feb 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpgNyOUd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4C6AFA8
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632585; cv=none; b=o3H3HnFXY2V/tkcvX7rmuKtxgl51TJiygxsTs9AT9Hhf+7J8F8mYAsGXs6P7+HsI2Ftd1kM7zAy/Mg8r4sFnV7K8wYi8Bq2awNN8IA83ktj/aBfrb2W1Qb6/OixBlNyjMObIKdpRAarYxKIfOzFtd3Xudja5lgqS+hsAGwRGmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632585; c=relaxed/simple;
	bh=MUh8YfHrKxE6d0K57Aj/QEX++RrUQWnSkrgdmAMCmE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ/r8Vdgvcxt4OtjHQp4NsO0ktAdzEggWRuK3NzRcNta+jA3HBva34eFxuwqOAyoi8UcNdalSDI815si7E3fCybDDcVFRt9uFbX8pJln8uOpp6L1ETwR/MNYcM3AEc9ANNE8wY1ABOORQ/ArtTHQg4DOP8VvAPDjoao1aeIVjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpgNyOUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708632583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFX/VxquyBe6kZjKVY9YcvfWbrOo8BBreb/hc5PTjz8=;
	b=OpgNyOUdzJzAKafe7LzBOFQ7j87jwqi95RSqVXj27sTCF9jRyCJkMAQ5AYHmAUwuFuTtXd
	3oazDeEbI1Gaq4yRhwIJuV8IUqz6Ij0maau0YZKa4LsorHqiGcyV2Gif4Udg8L0PZ0V7D8
	ZTZycbT6S6q6ckoS+5DEgcS9Y+wbIe8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-n3VmcgcgMgC8pnTEyWtukw-1; Thu, 22 Feb 2024 15:09:41 -0500
X-MC-Unique: n3VmcgcgMgC8pnTEyWtukw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41225d3b3d1so603715e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 12:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632580; x=1709237380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFX/VxquyBe6kZjKVY9YcvfWbrOo8BBreb/hc5PTjz8=;
        b=SagLbQMLZcgzezGra6PbzqF4t2eWCOPht7pIiMsiAJA36ZsVn03pJq+XCI656hxEw8
         rWNZ6LRd6EBJHlXCEGbBIOLDQbAdVsloc+dmtRXOX/hbNRfexO4gNFXlmMvNxLcJQZPY
         E9yvhhkA+7nT9q9DXVKngwpqxtLhxomFhZwioSyScKA1fKdm5yFZm9omBj2kZt+D9yAz
         tpdIO+i0/0ggiRQM5SYIj5vFRI1QVKWKwcof/FX1BTJOCogjcs+b/QDSbgoUWgrEN4NE
         JHnns/GwBjN+n4IHkmkJs9N/S7mNgNvWNpOy5CEVXi6L0aWCd4uT1tJWIOcj/RHeUhM5
         iSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVdiMt+O2AcKZBwiZfOYGW55dNSiXRIaxGKTYUXamYopAk9UojhsMsg1C3OgVNmOHlq03V02+9YYacE0SJlGdf0vGPg
X-Gm-Message-State: AOJu0YylkNNnbP9IMDbl0pzXbA6RIRz0TReTfSGN7OjoDpt6WC7vZro/
	NcOCQ8dTsZdzwEfsFcgPCoKXTM3XzkK1+prowg3akmOIlY6W8yRPEtgPOgAJv38wnV9QLV5MVBr
	+9tN3bnocJi4spEM9TEvpvwvlno0prNY5PSMMH3W15PULMANrhA==
X-Received: by 2002:a05:600c:4ed1:b0:412:64ea:8f5a with SMTP id g17-20020a05600c4ed100b0041264ea8f5amr9544717wmq.34.1708632580364;
        Thu, 22 Feb 2024 12:09:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9yY8JjO1FoyqvU2lpiTSUbR0Lk0HQjJedlMjs+5XSlzThoRsvA8lNTPP+zy0EkH73CKE3zA==
X-Received: by 2002:a05:600c:4ed1:b0:412:64ea:8f5a with SMTP id g17-20020a05600c4ed100b0041264ea8f5amr9544703wmq.34.1708632579992;
        Thu, 22 Feb 2024 12:09:39 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b00410add3af79sm7550030wms.23.2024.02.22.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:09:39 -0800 (PST)
Date: Thu, 22 Feb 2024 15:09:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Liang Chen <liangchen.linux@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Message-ID: <20240222150850-mutt-send-email-mst@kernel.org>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>

On Fri, Feb 09, 2024 at 01:57:25PM +0100, Paolo Abeni wrote:
> On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > On Wed, Feb 7, 2024 at 10:27 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > 
> > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > On Tue, Feb 6, 2024 at 6:44 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > > > 
> > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > On Sat, Feb 3, 2024 at 12:20 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > [...]
> > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> > > > > > > >       }
> > > > > > > >   }
> > > > > > > > 
> > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
> > > > > > > > +                                  struct net_device *dev,
> > > > > > > > +                                  struct virtio_net_hdr_v1_hash *hdr_hash)
> > > > > > > > +{
> > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > +             virtnet_xdp->hash_value = hdr_hash->hash_value;
> > > > > > > > +             virtnet_xdp->hash_report = hdr_hash->hash_report;
> > > > > > > > +     }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > 
> > > > > > > Would it be possible to store a pointer to hdr_hash in virtnet_xdp_buff,
> > > > > > > with the purpose of delaying extracting this, until and only if XDP
> > > > > > > bpf_prog calls the kfunc?
> > > > > > > 
> > > > > > 
> > > > > > That seems to be the way v1 works,
> > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@gmail.com/
> > > > > > . But it was pointed out that the inline header may be overwritten by
> > > > > > the xdp prog, so the hash is copied out to maintain its integrity.
> > > > > 
> > > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > > contents/buffer?
> > > > > 
> > > > 
> > > > Normally, an XDP program accesses only the packet data. However,
> > > > there's also an XDP RX Metadata area, referenced by the data_meta
> > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > > > point somewhere ahead of the data buffer, thereby granting the XDP
> > > > program access to the virtio header located immediately before the
> > > 
> > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data before
> > > xdp->data_hard_start:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4210
> > > 
> > > and virtio net set such field after the virtio_net_hdr:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L1218
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L1420
> > > 
> > > I don't see how the virtio hdr could be touched? Possibly even more
> > > important: if such thing is possible, I think is should be somewhat
> > > denied (for the same reason an H/W nic should prevent XDP from
> > > modifying its own buffer descriptor).
> > 
> > Thank you for highlighting this concern. The header layout differs
> > slightly between small and mergeable mode. Taking 'mergeable mode' as
> > an example, after calling xdp_prepare_buff the layout of xdp_buff
> > would be as depicted in the diagram below,
> > 
> >                       buf
> >                        |
> >                        v
> >         +--------------+--------------+-------------+
> >         | xdp headroom | virtio header| packet      |
> >         | (256 bytes)  | (20 bytes)   | content     |
> >         +--------------+--------------+-------------+
> >         ^                             ^
> >         |                             |
> >  data_hard_start                    data
> >                                   data_meta
> > 
> > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
> > towards 'data_hard_start', it would point to the inline header, thus
> > potentially allowing the XDP program to access the inline header.
> 
> I see. That layout was completely unexpected to me.
> 
> AFAICS the virtio_net driver tries to avoid accessing/using the
> virtio_net_hdr after the XDP program execution, so nothing tragic
> should happen.
> 
> @Michael, @Jason, I guess the above is like that by design? Isn't it a
> bit fragile?
> 
> Thanks!
> 
> Paolo

I agree it is all a bit fragile, not sure how to do better without extra
copies though ...

-- 
MST


