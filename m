Return-Path: <bpf+bounces-17493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDC80E651
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D44B20D6B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3A1A58A;
	Tue, 12 Dec 2023 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2k+Rq8e"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FE194
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 00:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702370196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3REzlhxyjwr+W04GrphHu6w+MUbdp4P7YLZ0oCePgOg=;
	b=M2k+Rq8e5sqdlBJIaBC3QFGN30+CaFldBh3WdgHZ948/nKWwR8WTB0yU75cMgnVTxq3H0D
	SR7Tb7DBksIv+/k6FxHpyJnPc/TXx0fY/oxyJ0dqVH5fENbXE2ZY3NrU6NzpLoy4wJFppi
	9eum98jwWDe411hIceuAnvFeHEHDh3E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-2QPTrDHbPauoCnsYLPj5Wg-1; Tue, 12 Dec 2023 03:36:34 -0500
X-MC-Unique: 2QPTrDHbPauoCnsYLPj5Wg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d27c45705so114906966b.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 00:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370193; x=1702974993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3REzlhxyjwr+W04GrphHu6w+MUbdp4P7YLZ0oCePgOg=;
        b=Sh+atnsJ8zEaBjCLwRDz9dHmyeCq7SRsoY8nO1rkxgSDz1NMwoA+H6Hmsl+QD6oLas
         RY8a7KdeYQehiXiI4IF0/lrsUJmPOhkb24RfwGAQgrzj9kyt2avf7uXWE9FWugq5BlNV
         uIgnZ3foVdDTQ0a38ZJrG3oC4IpqK4neaiFXih3kABOnyFOs9z1PXMVOKJoGLpzSXSn9
         2vmhND/0ZsACaGjENVuC3SOtKgBwFawmGJ15LlUL8+SF2c5Y1+T8O/s4MX2Y1m/fZQEr
         z2ZyFmy3cUUi4mFe4N1gmwQyrsQsna6FcuiCwhM1Kr6WV9nBFtqb0oJrK4RdG49Ibmrh
         BKJg==
X-Gm-Message-State: AOJu0YxF+fU2vVFbzqx+Bqji5R5B2YzWwbaG+4apgZlDFaRJkLozvMqk
	nw9dXpXi3mrRbL3NSde4HKETU41gnCiVy6zm/CHbkjrUG2s3vOF/dMWWO4s/xJkF14FDXwvDoeP
	l8OAONyH3tnov
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr5927140ejn.7.1702370193650;
        Tue, 12 Dec 2023 00:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE56gsZlumMYJ8ZvJvJsPBUsttFzbD+4XIetl4XyQ6yIHMOZjuwdspXl6TBvDz7dMtZ3/Ei1w==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr5927130ejn.7.1702370193346;
        Tue, 12 Dec 2023 00:36:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm5838645ejd.28.2023.12.12.00.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:36:32 -0800 (PST)
Message-ID: <cb11852022d84740b417a93b9acada852d496d3e.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, toke@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com
Date: Tue, 12 Dec 2023 09:36:31 +0100
In-Reply-To: <20231211090053.21cb357d@kernel.org>
References: <cover.1701437961.git.lorenzo@kernel.org>
	 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	 <20231201194829.428a96da@kernel.org> <ZW3zvEbI6o4ydM_N@lore-desk>
	 <20231204120153.0d51729a@kernel.org> <ZW-tX9EAnbw9a2lF@lore-desk>
	 <20231205155849.49af176c@kernel.org>
	 <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
	 <20231206080333.0aa23754@kernel.org> <ZXS-naeBjoVrGTY9@lore-desk>
	 <20231211090053.21cb357d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-11 at 09:00 -0800, Jakub Kicinski wrote:
> On Sat, 9 Dec 2023 20:23:09 +0100 Lorenzo Bianconi wrote:
> > Are we going to use these page_pools just for virtual devices (e.g. vet=
h) or
> > even for hw NICs? If we do not bound the page_pool to a netdevice I thi=
nk we
> > can't rely on it to DMA map/unmap the buffer, right?
>=20
> Right, I don't think it's particularly useful for HW NICs.
> Maybe for allocating skb heads? We could possibly kill
> struct page_frag_1k and use PP page / frag instead.
> But not sure how Eric would react :)

Side note here: we have a dedicated kmem_cache for typical skb head
allocation since commit bf9f1baa279f0758dc2297080360c5a616843927 -
where Eric mentioned we could possibly remove the page_frag_1k after
that (on my todo list since forever, sorry).=20

Cheers,

Paolo
>=20


