Return-Path: <bpf+bounces-22309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812C85B81B
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4191F21BBF
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605F66B5E;
	Tue, 20 Feb 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A55KuLs0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C666B57
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422332; cv=none; b=FKGrjg5KbTpqre8qVmcORYk/Jo82tBzaxJwyC3cSbqjI5eMkmzl/kl8wxYb+bkdoLVuZijuEtZn75xMd+nZEOvs/mbsC7ElBzTCOxxrkibsG3nrGdcbb/8vMwyMrVFlcn7JsjASneGuL6js81uunCoi6eP7wSSTRoUfb0thPhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422332; c=relaxed/simple;
	bh=QKwnHET2XvLCNJyfebAoXI5gbwEFghhJoMtYv4oB/WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfQ9oC1FpePOk6k0C6zFuvovKC0QLopHjc793YmPUuaAPc1fCXFemIDrMHLSY9is9UJnPKOU7AuLxSBB2tT6aKyaCBOvzjEZ6/pw0h9S7OuAfd1NbBAhmELbp6rd2h925E2T5mhf4SEqBamkSNE+Ss0du8YlM7JSYw2kbSk+clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A55KuLs0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708422329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j3Ojsih1RLImOVYR5g52ucbPZV6KdFM+cuQq3txIXOc=;
	b=A55KuLs0K4kwpHEJLnoWIAyoV1rVLdz9bAFF8xA9qaVdAtYqBFLW//Y6DPpLf7QcklDQ+n
	ntir55c+ZGgcDrczZQxIQgtP0Np+9xXwf01yB8EwYNPffcih2MI9JgWlPdUOFrT7zhrPVW
	M4tQexmawogn0up86SgEocJvC9PN7CM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GRRSvT66Mdulu8UXsMskQw-1; Tue, 20 Feb 2024 04:45:28 -0500
X-MC-Unique: GRRSvT66Mdulu8UXsMskQw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411e53af2adso8361145e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422327; x=1709027127;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3Ojsih1RLImOVYR5g52ucbPZV6KdFM+cuQq3txIXOc=;
        b=cQeFwJdh/saxUtLmxYGWqC3TZG1XNhWO5DOI3KXY9CkUlabvWGCD31fN+uke7gsuJg
         I4tn1HHEjLL6vCw7vm901r/VEOhAiCgv5Dt/n8zTxQeSbAVyqIiS+NLEZnAkK3Byrh+b
         AWHbnAshbVX9U8UIVAV7vQLCeJv2sIFBSGo4usIgtdGUZVzonrx+Ymg8DWz11JoglxsN
         DZz6xXbxooI3RfDSu82iDKdqtOgbIt9zPHkVY/XmZXvXComNyOzJUawDvjxn9M5TJ83y
         gbPqv7WjBrxHJ4rfppVNBXhyQsxxP9IaELATOiO/ndwet18cNKfSiDSO8V68J8a9p5es
         8ffA==
X-Forwarded-Encrypted: i=1; AJvYcCWXzSMguy5kRnIkCud6wdJok1uYRQzZX99TaACIUee1QgyPAcH9eA2xiTUMIFOZKgohEdKwlvJgAYu4hdMekG3d8zld
X-Gm-Message-State: AOJu0Yzi0jk2xySVipcu9QcWx3UN1nzyuyfybV93rXMBz9TOt2j3kPUs
	55M39oH9Qa5MjVPQeut+FdzMIJol6A2KBn/qrtkKzScNk8AT+UReiQ26Mn82lXkGu+P2VAB41HK
	2Q8kWVdhlCRLWxqEX3cET6rtDKV8XVMTc5Jc3TuLl4TaQ8vFKoQ==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr5207894wms.4.1708422327041;
        Tue, 20 Feb 2024 01:45:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj3mEL6bTmQ1WutrhtIhtMBlT0HZjt/+BC/6e5t493Xf6zKpg2X8ZRrI6OXo4HHDWeTg/C4Q==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr5207873wms.4.1708422326694;
        Tue, 20 Feb 2024 01:45:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00412696bd7d9sm4161823wmo.41.2024.02.20.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:45:26 -0800 (PST)
Message-ID: <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
Subject: Re: [PATCH net-next 2/3] bpf: test_run: Use system page pool for
 XDP live frame mode
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
	 <edumazet@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 20 Feb 2024 10:45:24 +0100
In-Reply-To: <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
References: <20240215132634.474055-1-toke@redhat.com>
	 <20240215132634.474055-3-toke@redhat.com>
	 <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 10:06 +0100, Daniel Borkmann wrote:
> On 2/15/24 2:26 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
> > each time it is called and uses that to allocate the frames used for th=
e
> > XDP run. This works well if the syscall is used with a high repetitions
> > number, as it allows for efficient page recycling. However, if used wit=
h
> > a small number of repetitions, the overhead of creating and tearing dow=
n
> > the page pool is significant, and can even lead to system stalls if the
> > syscall is called in a tight loop.
> >=20
> > Now that we have a persistent system page pool instance, it becomes
> > pretty straight forward to change the test_run code to use it. The only
> > wrinkle is that we can no longer rely on a custom page init callback
> > from page_pool itself; instead, we change the test_run code to write a
> > random cookie value to the beginning of the page as an indicator that
> > the page has been initialised and can be re-used without copying the
> > initial data again.
> >=20
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>=20
> [...]
> > -
> >   	/* We create a 'fake' RXQ referencing the original dev, but with an
> >   	 * xdp_mem_info pointing to our page_pool
> >   	 */
> >   	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
> > -	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL;
> > -	xdp->rxq.mem.id =3D pp->xdp_mem_id;
> > +	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL; /* mem id is set per-frame =
below */
> >   	xdp->dev =3D orig_ctx->rxq->dev;
> >   	xdp->orig_ctx =3D orig_ctx;
> >  =20
> > +	/* We need a random cookie for each run as pages can stick around
> > +	 * between runs in the system page pool
> > +	 */
> > +	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
> > +
>=20
> So the assumption is that there is only a tiny chance of collisions with
> users outside of xdp test_run. If they do collide however, you'd leak dat=
a.

Good point. @Toke: what is the worst-case thing that could happen in
case a page is recycled from another pool's user?

could we possibly end-up matching the cookie for a page containing
'random' orig_ctx/ctx, so that bpf program later tries to access
equally random ptrs?

Thanks!

Paolo


