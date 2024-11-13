Return-Path: <bpf+bounces-44726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0809C6D96
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9CB25951
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5C20125C;
	Wed, 13 Nov 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGkfWs8n"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DA201011
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496431; cv=none; b=bBIeIZvaXSidyTDyM/Ne8ZaWnEt1ED3Zrhn7a0Xfxt1VtNrl2gRrYGXPZa9P+EwaBK3pPvDM1ehS9ZsgcdgFNJHJ2AqiRBaLYJHWrqCsjpgpqom2Wv98qqb0uf9qRJqXCUtwLh8ml1KCHvZ4HKxpJwmYECV+qO8Wan6TqkffzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496431; c=relaxed/simple;
	bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrVF4QewTX0szu5g6h+RXtpIGbUiu0cDmVVcVJYCGS/OyQW7cb8J7rS25VciooBCZ4ZLIT8SNGupnLMBACGvff5r/G/2jUO5OvvBz27CFrhfHVecuy2+8naWYkobCvrgLEUfcY5dAz0Gnu/Sy9q09zlU8/QJh8KWFg90V5G/F6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGkfWs8n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731496428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
	b=OGkfWs8nDk3f93k/Pz63mt8iGsQPkSpSxmlh+nINKN2uu647zTSG7Zg8Bld8TQ+g9h6Jav
	rf+PhyGbxHg5ZVt/bafkdxiOBJNYPCE0gurN81loHSZL6FHDBVClpP/AIaq//GI/eeG+E/
	TNhQWrAdHGvJRlvM+TEg2sPTa2VRR44=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-9m5lqwM3NTSHfpakcMoQOQ-1; Wed, 13 Nov 2024 06:13:47 -0500
X-MC-Unique: 9m5lqwM3NTSHfpakcMoQOQ-1
X-Mimecast-MFC-AGG-ID: 9m5lqwM3NTSHfpakcMoQOQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so584022466b.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 03:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496426; x=1732101226;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
        b=kNTFQu7TG5h7S77nltmgBc/DUbygxbHBR2GjAxoHtAGyA4TOTR75ISCtW4LBuVaLje
         ovAuFoH49o58y0yASdB/ZgnFszrckHbKJqm67H2W3RekW17dru/gkmbHMIcwaPT0lvwQ
         qDqrpll58gle017FvbATREZrWgfYNerYnP3tTxHrkJyfj1x1GX0081TaV859aokmiPO2
         Q5KRTqrUtgWO4gA9ZUxiZwHcczGSb6Yp6A+jq7lG9SHLCPq2VMrn68XJzJJUn0OBjgx5
         7AnpBFs/8/KbYhjh9yHQiYHaqKpk2g0m/56c8bZRABXh2IQ17ZtjFNgAD5jVEuWCYsW7
         QP5g==
X-Forwarded-Encrypted: i=1; AJvYcCXqMbsBcbgzel0PagO7sBIR8WxuWOAlY0I/+uwXYQ8aIWlFrAllcfTcU8vJRts/EF47xVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWyrbNRKGBM/5QpWmG7WkHymdIPm5gOLtZ6cBQABuzQJBUW76
	7mtNNh1hnqYy3dQ2lQzAZVJYYaZpt2+TMLv96E8Cw8A/lrXuG8RGaJDtBfMnCFpJvPlEUWc+l6K
	fJRLNV0Y3qMEY3H65+pDmGjZ9krtGEuB88RJ8O3SQd9ZGva0v9w==
X-Received: by 2002:a17:907:3d8f:b0:a9a:c769:5a5 with SMTP id a640c23a62f3a-aa1c57ef3a8mr647385266b.50.1731496426131;
        Wed, 13 Nov 2024 03:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqADmkP2C4rClEcqwx1wtnRk3ZcRtmjUzRFnnm4W6YT+sh8g87gsJHxjBz3mkMGvBqlF78hQ==
X-Received: by 2002:a17:907:3d8f:b0:a9a:c769:5a5 with SMTP id a640c23a62f3a-aa1c57ef3a8mr647382366b.50.1731496425619;
        Wed, 13 Nov 2024 03:13:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176e1sm854010866b.31.2024.11.13.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:13:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D08E164CF1F; Wed, 13 Nov 2024 12:13:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/19] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241107161026.2903044-13-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241107161026.2903044-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Nov 2024 12:13:44 +0100
Message-ID: <87wmh7wfmf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
> using napi_build_skb() and make use of the available xdp_rxq pointer to
> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
> be recycled, as every PP user's been switched to recycle skbs.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


