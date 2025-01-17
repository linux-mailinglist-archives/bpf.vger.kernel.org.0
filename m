Return-Path: <bpf+bounces-49187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E549A14F98
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CBE7A4209
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1361FF7A9;
	Fri, 17 Jan 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejQjzloM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549E1FF1AD
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117912; cv=none; b=hoK2yZoaLz+Di2Dx1im4JAFKl95gMuj1J0xpWFT2NredZNq6Xnq0Fh+1FcFpv3AZ42lWCFj2Zm9cJInZbcR3+lliQs/YwBt+o0+3S+/mc+tr6gSPJ1/0Hgn5+ly2UBTTaSKy5Jmyq2KYrPNcWXSRyS0UHy+YJolGrP7fGA26RJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117912; c=relaxed/simple;
	bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tt3YpGHfSbkC0DLd2iw/zq7KCXeHdIdMj2fhLkcsAqBp0M16gk5r4qmsEasvcdKDcklxb+bOD80jxlf7dvQHgrdnccwJ660tIGm7+SVOt2sr4uB78xr1/oMum7EoznQp/h4tD8Cal3xJPZcufCVSB1DkBCumtqaT2M4HjBPYpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejQjzloM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
	b=ejQjzloMQGj6awgv3ZQaAfIroOCzbNk/zVbn5/fKmysqfEMwtMhPqotpHmcPeO1YzfDj5S
	rCgEURTa0uAKRewVYiSXsK9tzkDXuB9F6itHVqV1ZUPAKtZ/aFQ1Jo4LmTvnP2s4efv8fH
	iSE6QxJliWYi9Jbc0kWFjG1HI2L0HXM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-1DGVzRqhOsyQcHtoAvRywg-1; Fri, 17 Jan 2025 07:45:08 -0500
X-MC-Unique: 1DGVzRqhOsyQcHtoAvRywg-1
X-Mimecast-MFC-AGG-ID: 1DGVzRqhOsyQcHtoAvRywg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa68b4b957fso263254366b.3
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117907; x=1737722707;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
        b=Qj9wvfOmDJDNnVtg8e3RtwVKvbcgW9ouH9cexR6MFBgfG89DbKdwXVOuKwtDjKgD4x
         yOWvmVmAbgzUNoHpYIVXIVaXklNNeMMVlcts78NYDnBgcE2k0/7uY1v/h+/OK363I2DO
         By25QlUctT+1f/6sv7kjliy2BRDiaLjp3NVXZMI/11ctoawXZlz8poERqaSAUNdt4m5B
         J7oyQggy2UQe19/ASGKe+YsLVePVdeDphQpxTPWoyrQWA2IkJVFA4ywOyziNAImrTM6h
         AufnhfrmmUXwt5oo58iFRR3/Y+J6qRMTPg3CPuzAD8AN3oTR3Y0uePK+Wo24rhrp8BIH
         4DHA==
X-Forwarded-Encrypted: i=1; AJvYcCXfE3IO7ocfzL3gof+DjsB2Kr4YYz+7hRYLZ0kFenZYXCbMmIHNyEQZWNr2gtonaxMXcdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ArmzPus/L++Z3E4GkS37BlL1rCWXdfeoI1I1Ny1jGHM6RK50
	BOqC6SfVzO69/r0DkWy9wO1E1Z5T+IpekMDBgoRaqfBAxDH/uvTsXZsB7Pf7QgiwbTZre7cNNhx
	CkM78XVThclJRedUzE9LruDOCnIXCPV2CEn/aKaVeNpeKy7iPHw==
X-Gm-Gg: ASbGnct2f/E59oVtEcotV5QUkWqJMm471maP8pXML3oWsgaqpOaznvqI4xAUXcDnOpc
	aeju2pt42ROnINtnlFJ+5bnAlFCOZL7eQWbiftH79SB/lKSpwpwdjRLjW80xGp4QsDvOLcUEbZN
	hD14/XxL1DGoYMIG10JI0PXq/jpzcbHzCKvnEj3Nk8jR11g6dq1bnRyM2M2vjyWvm/BTETnUcfj
	5iGG7qnsYP8vhVA9B1Qf07kjT+kQLHf0etD1921cQdk63JH3lnfjaCXZhq5kENcsqoVtC/qiR59
	u5LGSw==
X-Received: by 2002:a17:907:6d0e:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-ab38b112b07mr226449966b.23.1737117907395;
        Fri, 17 Jan 2025 04:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfFt2OocIDCeVCuphJzNl9Mw6EvXmqC8VOMNFVCg1AliOY0zzpd05VMHD+2EiGsW65Bih1uQ==
X-Received: by 2002:a17:907:6d0e:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-ab38b112b07mr226447466b.23.1737117906979;
        Fri, 17 Jan 2025 04:45:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f223f3sm164037166b.116.2025.01.17.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:45:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6986217E786D; Fri, 17 Jan 2025 13:45:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] bpf: cpumap: switch to GRO from
 netif_receive_skb_list()
In-Reply-To: <20250115151901.2063909-4-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-4-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:45:05 +0100
Message-ID: <87cyglobhq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> cpumap has its own BH context based on kthread. It has a sane batch
> size of 8 frames per one cycle.
> GRO can be used here on its own. Adjust cpumap calls to the upper stack
> to use GRO API instead of netif_receive_skb_list() which processes skbs
> by batches, but doesn't involve GRO layer at all.
> In plenty of tests, GRO performs better than listed receiving even
> given that it has to calculate full frame checksums on the CPU.
> As GRO passes the skbs to the upper stack in the batches of
> @gro_normal_batch, i.e. 8 by default, and skb->dev points to the
> device where the frame comes from, it is enough to disable GRO
> netdev feature on it to completely restore the original behaviour:
> untouched frames will be being bulked and passed to the upper stack
> by 8, as it was with netif_receive_skb_list().
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


