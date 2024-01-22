Return-Path: <bpf+bounces-19982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC965835A0D
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 05:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395F4282A5E
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 04:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA94A39;
	Mon, 22 Jan 2024 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuc6rNBf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4352F3F
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897486; cv=none; b=Aei++TYuY2i0+nABp+aK6HDXUCJVwpzddjaVAgeDlizwECF9YggOkUjIzbYYeiWJVhTnslSd8+lx1oXqedXHu5yvBJ++lC72+oxYO9g0uEqsPxaYVCIkVYy5Sym3V4GpZnXdGS/ATyZsQjRhKOK592PXM0b30qRR+NICQqsLWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897486; c=relaxed/simple;
	bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJrF0nUqclNCD2kp1l2j2/fDHbLIN/C6wkjwKYRxqpQo203zX42FRPT6MuQ6ANPZx+OM7lGJn8QrOYb4VG5yhQrA/Rnerf4FR1EbihqE138BEAkQvjAndBu80hRZjxvZ2eDlowqHvaNzJ6hPyU1Mk7pgC+UYdCn73veX2mKtQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuc6rNBf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705897484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
	b=fuc6rNBfeAnw/U3TgGPy79J1w4hLFRZencs5fIQSARANfVmSJfr00a29NXpbRRpMOcREIt
	weqz/CXKd5YqGbGkXckbLIQoGlxDtCleH/xMPbg0zo8hTztBMEGKP7p0xaeWOte5imVq+Q
	+RlROvr8nNuz+GyKOR1eM8E2c8XTKrU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-NEHKtqiSNGC3l65Hyrv5Cg-1; Sun, 21 Jan 2024 23:24:42 -0500
X-MC-Unique: NEHKtqiSNGC3l65Hyrv5Cg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd97c17091so3912346b6e.3
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 20:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897482; x=1706502282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
        b=tc323nMyLzX5OvrfSzmG/lFrz3c0JC9eGR+RfVpl8cAJquzHQH/6xJIFsQfdgsji6V
         JcMxpSSDXG0XGGcTr3YvA3uJkGO9pOKHLWcKTRMMHuDMWMBiE/aGwP/D80ecvt2KtNWA
         vUUbh/T77hX4mlaE3KAHCKQkDMSVuk2AjLbKcpW5EvxaBSzse3cp0Vv0SiZNdYFUEtRR
         +v0GJCdU2v6DgzeXWl4cHh8gge1AMV062HNQE6AeUgB4+ZvWuQdWwna5A6iXPO31dQ2p
         o9RzXpSLYyyMVKl44dJttGPnwmwstvkNfkv2PzigyeTajB18hjBOTwr9YIykATs80nT9
         NFYA==
X-Gm-Message-State: AOJu0Yzgj2P0P+KMIJIXeigkR6v1nR9v2sNfPcazMkWduh+wqpnDnscz
	Ersj5QqyVLeSfyRYSZXQAyOuxC3cjfwoAfxMlGPFyzuU6CLUdG1+ZGQX2lwxga336oB72YTSL0m
	Wj7IW7smBTAuQoL+XYa2Xnh3vaVC0KpY9wz2uewts1UgIebGH81j/L+CZE91K8GX3lAAgXkYgQD
	J6oQMkzotjt+aB40JSolx1uxd+
X-Received: by 2002:a05:6808:2894:b0:3bd:a931:1ef5 with SMTP id eu20-20020a056808289400b003bda9311ef5mr3928380oib.102.1705897481911;
        Sun, 21 Jan 2024 20:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcclYxoVeJMQr66ohKfMqG/HqQhC8z6Bv7aCKxODnkszFjbS5NTwWx+X95pACBk9h1PlJs6+xsmHV/vDibbAk=
X-Received: by 2002:a05:6808:2894:b0:3bd:a931:1ef5 with SMTP id
 eu20-20020a056808289400b003bda9311ef5mr3928367oib.102.1705897481744; Sun, 21
 Jan 2024 20:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org> <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:24:30 +0800
Message-ID: <CACGkMEuc=F46N-3PRZrnOT17byWVqt5AZc=pc6RrHNLj-uKN+g@mail.gmail.com>
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 16 Jan 2024 07:07:05 -0800, Jakub Kicinski <kuba@kernel.org> wrot=
e:
> > On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > > For future submission it would be better if you split this series in
> > > smaller chunks: the maximum size allowed is 15 patches.
> >
> > Which does not mean you can split it up and post them all at the same
> > time, FWIW.
>
>
> I hope some ones have time to reivew the other parts.

Will review those this week.

Thanks

> In the future, I will post one after the last one is merged.
>
> Thanks.
>


