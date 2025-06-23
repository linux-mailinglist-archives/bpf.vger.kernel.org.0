Return-Path: <bpf+bounces-61270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C809AE3961
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68002161FAF
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417F22FE0A;
	Mon, 23 Jun 2025 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO3ztqGF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD182EB1D;
	Mon, 23 Jun 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669498; cv=none; b=cOsiCf4mO54E80UG04Py8fQuFbarIZ+lFPkByB+j1fjS0pXpcUHh90dLuX8paIrcRzFWeRGuaPRB/NVPCfc8pkNfzatf6HjuPJpHO7GC7UiB2BOQRKtqnx3gWG/PI5ilCLxiNQ14dzi+wU3RQ46iS1nGpOYxv3KsyqMUewZIgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669498; c=relaxed/simple;
	bh=cHusQ2VZmE4UIlYbu5OpWoF9Rc99dg6ImE33GJlTdOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOAqysnh4zY0gt8N+LXR1q49T/Jqj4SDggXTo/IWqxTmK7oEjMstpJ7QvqHyKyoyJku+vl4/tkN7hRu+O0tbyTlF2ivHlxpGoh9IhiJ1RDllZFa9yVfGnN/GYWaM3DjsCJJLzsL72wnPrbxRrHW7NiXKPbBB2UyGFGUMYgq6Fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO3ztqGF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45310223677so29349755e9.0;
        Mon, 23 Jun 2025 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669495; x=1751274295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mp4zG9WmNam+JoCdJwjtNBfJYYLGYfORbnaYyB6I4o=;
        b=iO3ztqGF0GMQtC7DZZCFdXODBPVtlYoSLCTpw5cBf7Ua4TJ4npnZjE29TiJOnt8oZo
         8Of6jHPn6qeJfp2zaUYA8spIYORkM/OZzy4hpr4tMjuILZebNDYbFmW7BkLe9Ql0L4r7
         W7IWJzDki8YmI8CUcHgV3Nvwrf8ZJ9k/kzyckOUgPsqQbPCHy3wQWhzPdrfC+KIQV+3g
         vloL1IUaRs7mcGbLdgwlt/Atxu9BVihhm55iXigy+miFqabxJN6+Pj5f8CnxJqXkIa23
         0IKu6P7jhQ7AS47nsAOv7hRxlqPSxzGf2BCVriz/H38xdYBknkNrr/FrOGkvO9r3DIRN
         dPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669495; x=1751274295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mp4zG9WmNam+JoCdJwjtNBfJYYLGYfORbnaYyB6I4o=;
        b=UB5+xvq5R2hjpRiz5EPLGSzhLYqdYptHVGcU6UHMNZOVFksk99obZXdKjJTaAeWcfd
         3zExCHa9LBPduLTmNTJj5sBoagsMI0KXWGDhBJGwIPQz9Lfn1coid4UDNCB2/Ms/vkPj
         WVz4O/B2OustGiIiki/501eXgeQHvobBDHM2nhAYwrm23LIJg60LK4+fkaZxK+Nd/cmx
         Oda1KwEcmjn55a6ogx9fSnxSyOJsFg8aWZsSG9ZvstxPLEq7DGnHuOTyGoFlSdkMdmQq
         OcrEGuDUqgKyH6PHPxI+4m/B1GeshiS9ZFcX1hFpN5Pdx2U+L8r+/3ZsQNCYloGNuNkJ
         ZCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVbYed5qr1ApBsOTjAYeGz+KDlvqUpnNU8heZSZi+YIVwRtCIqWFlae9EqsiduksnyVO6NUbQ@vger.kernel.org, AJvYcCX3B5250QcfFY42Hej5zG/jv3xK9tDZJEdjn4N6mm6pYjkIq1oqpzZqHeQKx5c8j1lFaoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxfe6HHX8cLtp/cegN9L5HRy/YAL2GzGu41UWlzBmtCNRZbxe
	eigSrvdx/M2p/SaMos1ucJb2HSobBLDEuZ43XqTaZTNrOgIkWdWGIr4f
X-Gm-Gg: ASbGncsoXjz0g6pyNipdMf8zSB6DI06fkavoPdIdawrTARGwPinJWpWnWNTFH9BFmLa
	0Oai+CsnmQuOa44a2IshLNwXhMdmTajNtjx6PMJSTHHgJfC8zBdobzq8cYzqNRhEtHJ1oUW8Bjm
	G1UuATBVMMmGTRlw4fDWFYgwxoGde4k+FH50jP6t2QV+X8n12eCWMGSw6D06Y+w0rQ7s7GdujH4
	UAUxl17cPc+0eiwKdU/icNZc2nAmDiPDWUaddic1B3huUsFfJsIcMy3SxZboq7vhR9/2vgA8qtW
	z3bFmnoIq4vDJ0oaWnNo0I0P7nK5Lcjla3OPcnWTA53UcIuybkm/hYau/iofhb8sbKe80zx4Wm7
	YtdMXcMmc13Q4BOPrErPImE3hmOglqaTtN2aHVteBTCMIDEpIcaAteIcRJfNZ
X-Google-Smtp-Source: AGHT+IH+ExDbubGYUndUo11AsgsJZlD9if2irv5BgJtju2mboZPLIsB6AipN78PB9b6AXcv8r0pc1A==
X-Received: by 2002:a05:600c:35c1:b0:441:ac58:eb31 with SMTP id 5b1f17b1804b1-453659dcd4cmr95201975e9.20.1750669495009;
        Mon, 23 Jun 2025 02:04:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e005b5e8ea9b277abf2.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:5b5e:8ea9:b277:abf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364703701sm104047835e9.27.2025.06.23.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:04:53 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:04:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 5.10,5.15 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <aFkYtN3WK19iK0-d@mail.gmail.com>
References: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
 <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>
 <2025062357-grove-crisply-a3b2@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062357-grove-crisply-a3b2@gregkh>

On Mon, Jun 23, 2025 at 10:46:47AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 17, 2025 at 05:49:21PM +0200, Paul Chaignon wrote:
> > [ Upstream commit ead7f9b8de65632ef8060b84b0c55049a33cfea1 ]
> > [ Note: Fixed conflict due to unrelated comment change. ]
> 
> This does not apply to the 5.15.y tree at all, due to:
> 
> > -		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
> > +		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
> 
> This chunk.
> 
> Can you fix that up and resend just this one?

It requires the 1/2 patch to apply correctly. I've tested them on the
tip of 5.15.y (1c700860e8bc). Or is there some reason not to backport
the 1/2 patch?

Paul

> 
> thanks,
> 
> greg k-h

