Return-Path: <bpf+bounces-21300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179784B2A9
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 11:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A41F25B6C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650DC12EBC8;
	Tue,  6 Feb 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbpgzcux"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606851EA6E
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216246; cv=none; b=slKxX3pOmgtcY8FR0SUHZVZJ6hJHJ7iJuwaFIfEFWnNcvuoAAxutD6JzJp98RuOKXIYSWY/fcXp3uraQVteVFtBM8yFtQTH7IYgmJ0mcNAW27TOWM8FcJfOJLM0tw4/KjNU4uGprA9HqGgKlwGlo769/DbTV3KSA0S1fOlLtJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216246; c=relaxed/simple;
	bh=3PO9HqabKlTeIf2oJndo4GKhZNWrhzSwkIySYL7yM4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/vfjBrtUYJ2rnBoK1QknzX3TCg7C3ZEvIjPZ3WWXeeNBvxLChNSIUY48HWAkm+tGbLepZ16pZYYPKlHiNQ3g3iGwlI+tL5lo1CDpPCgfMKy4vt/qUZfpUcO2srnPMkeL/k4RxBe+FAvv71ra6Abj5bI4kasbhtomY0t1h9+vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbpgzcux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707216244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GUF0RwSqdPkltRDROFKguYIVUTaltKVb3IJtt9hFPTs=;
	b=bbpgzcuxuwIgrd9i/pNpGfy1jt/lnMwuFtABpfFMZxFykOibX2kk5WID94ExzjZZmPJGWi
	QYaSS0sgtkfHgkEfaYKb6dfG/pT/tAfMUZCAvU3mTvliRRYd+raW4RYPKj0itad907eNPt
	uiOMrBWHFs4lVqlrYfD0s7SbWLfNjik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-eKSdmc-9NMi_6bxQzZZNqA-1; Tue, 06 Feb 2024 05:44:01 -0500
X-MC-Unique: eKSdmc-9NMi_6bxQzZZNqA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fc2c5818aso3424255e9.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 02:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216241; x=1707821041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUF0RwSqdPkltRDROFKguYIVUTaltKVb3IJtt9hFPTs=;
        b=NhMz1IVOlEwTDc74rp97Y9lhCTNOLOBAqy5h2JMgj18k6cgahf/PGgmVwYYu9vE1yv
         a3hwk4F1fHfWbMGmY85ILRk6tLnJtfPlIvtdFgYYIcJSrn583EDBp0gAAbtYcJprfsdM
         ZgkLExvkya6+NhiQzNgb5qtKu4Yut089vx91t65emMVAvrWqbOKfIFwnAsIXvQHAM4JJ
         OKJb1oW0UtOjGyz6WYk8i55VDiUnvmgq2YTe8hTiAJ3lsGukOOWfmBBeB/qen/kYOBpG
         BHHa3ntwjbbrTyjqW5gQA6fpN8aYy32nEUzSPCUOnyhsqj4wnxjQ300T0g7YaAQvPn6e
         3whQ==
X-Gm-Message-State: AOJu0YyCptB0eDgC3cbg/XXDPBYRknfSCNth56rzH89xGfb28lbP4B0u
	YJwZOwGw9odlUMifvmEvre9oL6wC54z8FTGp4yp/bfqFWzM2zOpE6JRu3ukHYKydJrFh9fZVh3I
	bZGO1bfcFPIB67AYsyvdFWx253xTzb4FG06VNMGfim3gvA7GV7w==
X-Received: by 2002:a05:600c:3b8f:b0:40e:e9dd:c290 with SMTP id n15-20020a05600c3b8f00b0040ee9ddc290mr1927191wms.0.1707216240740;
        Tue, 06 Feb 2024 02:44:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0MIt8c0drvzNqUWklMcwdZFOc9WkhWGGhOkXSqaBVOw1OKYd0DgsREwjUGPkk8B4c4L5brA==
X-Received: by 2002:a05:600c:3b8f:b0:40e:e9dd:c290 with SMTP id n15-20020a05600c3b8f00b0040ee9ddc290mr1927182wms.0.1707216240402;
        Tue, 06 Feb 2024 02:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD4Iyw4GA1rjha+/SnnJhNMfoByPZdOihJX1I0X+AVMj616Jp65SGXAfE/dxo11kFGfl2vv9h4rKb1lS6dqbdA1pdPl9sXJwpxoBos0cMvDSueCZRorqxk3rjbeYpmZ0agpCnLzjIGApiSI62LardTmjH94J+iWlBiLN8hiNOa4244A6JI50l1IBV76sNK6AcDrELN28j77mLP/93TgClCm1U1Ofk89tGuEZ9P4e91UQGGla+61Vx5ab5nSLvJNWhOqdYU3tpCmpJmeSB+34Vh/d+v/kpoHxKYUSYeI04STfzQ/1mA/eqJ8o/TxiPu4Yhm9V44pKzXRo1OMHUAy7v/g1U6BGMufFKfsb/ngPWGfqqiFxU2zphx+vbVJ578NWqHv39iA8HxGDUmQE0qAOn88eNYmvsIl+OwF3RfY72Lru7Lu3ylun5PQ0MK9lQ8Pih+KAI9f8dySeNP6MEvBRXAt0LdPRn6eDfMbsTy7yG/QA==
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b0040feb8c71a0sm744646wmb.13.2024.02.06.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:43:59 -0800 (PST)
Message-ID: <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
From: Paolo Abeni <pabeni@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>, Jesper Dangaard Brouer
	 <hawk@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
 hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com,  daniel@iogearbox.net, ast@kernel.org
Date: Tue, 06 Feb 2024 11:43:58 +0100
In-Reply-To: <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
	 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
	 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <hawk@kern=
el.org> wrote:
> > On 02/02/2024 13.11, Liang Chen wrote:
[...]
> > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp=
)
> > >       }
> > >   }
> > >=20
> > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtne=
t_xdp,
> > > +                                  struct net_device *dev,
> > > +                                  struct virtio_net_hdr_v1_hash *hdr=
_hash)
> > > +{
> > > +     if (dev->features & NETIF_F_RXHASH) {
> > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_report;
> > > +     }
> > > +}
> > > +
> >=20
> > Would it be possible to store a pointer to hdr_hash in virtnet_xdp_buff=
,
> > with the purpose of delaying extracting this, until and only if XDP
> > bpf_prog calls the kfunc?
> >=20
>=20
> That seems to be the way v1 works,
> https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@gmail=
.com/
> . But it was pointed out that the inline header may be overwritten by
> the xdp prog, so the hash is copied out to maintain its integrity.

Why? isn't XDP supposed to get write access only to the pkt
contents/buffer?

if the XDP program can really change the virtio_net_hdr, that looks
potentially dangerous/bug prone regardless of this patch.

Thanks,

Paolo


