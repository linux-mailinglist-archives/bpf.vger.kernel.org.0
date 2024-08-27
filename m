Return-Path: <bpf+bounces-38176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A6961177
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF38B27C54
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D81C9ECD;
	Tue, 27 Aug 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLKG2Nf7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F01C86F6
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771969; cv=none; b=lbgoj6XUohfjPaob5MXMAaybE3U7dKsY2FQvHu6WJ/0Ttd9vVWqb6IEO/PHDfGEY2tuVPe8TMxscqCuUzmGj+gjBurLTL5sbBU+0JVZhS4fJJPHzSwNRUAy0NnM5XuBR4MR7nwEkt5s1Dgoe/jU2DGnTmYE/BVFnjieu4Hys6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771969; c=relaxed/simple;
	bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrRqvjM3oO1KG8NVV4IBKLgrwvIHcDIcgf0Dg5+FwUQuu6157e3pashn4BR7Wx1+Vy6ar000JnNq+IcEb9CZCpunLDYjZpTkWT6Wd7CpoCq0ksIpIOtaqolPYm1O4IchLRo5ktUnRh7akTOia+zggJO3chxEhPv41aRgvYHxJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLKG2Nf7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
	b=NLKG2Nf7I1oY1D5Lf5OgqR7eHpjWHuj84kdWBhLwQQA55sliz5+EEZtGEhoeeVyLWgXNI3
	9i7/nqtztFXU/7knGzHzCJQQRpbWg+qqVQLcPzDqV66JTttXkzMBCGg/EPZz8nZy1j05cc
	k+vOKatstZo/g6zB5Nj9JAPSHkfXYyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-K7hAXjARMuqnW2PnwfEr-Q-1; Tue, 27 Aug 2024 11:19:25 -0400
X-MC-Unique: K7hAXjARMuqnW2PnwfEr-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-429e937ed39so52870905e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771965; x=1725376765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsXTgyfX4lK8uIlF+JZT8a96CuV8addTsgcuxyLMIXg=;
        b=hFKwQClyb4XpmerAwbWY/8b3JdUxrhKSaWzVfUcoLAnLmOyYj9BR+9wxC39UmE7o4y
         0WAoiAU3p26jViOzF3P3FDBLjK30WUbYpkN8z9NRSLlVg60T1PwLmWk9mn79Wf9TbjKf
         r3dnKf2vSx6Cg8LgWD30fKiLObT5Q5LQqA97WsduuaddBUKJ+VeW3zDqrtx3D7Md+h+y
         UZgReGhoOh84QO0hWTuccEOosS/Ps+2ZFfd6/a571LMNqDfT0Y/g+GkZ+b2tk+87TKTf
         CO3R7lY/TElq7HT7Pr8MAqOSslIx0mdSEU8OJeC/WYcuu/tnuNgCmBIhsRmQxsIIRY+y
         TwaA==
X-Forwarded-Encrypted: i=1; AJvYcCWcqZ17Kv3nZ0UOfRQQSq3ECLNmhl360+T0A2aNt2+hI1nEU8X5EkXI7IpFMnRIU3tgyv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdhsacVnkZ81IsjFGOy2vWTn0fXB5ogtWJw+Yvl2RGOzr/MJW
	OJ0hQ8w8YnE0SoQXwc+kCx6W7AEDkrXPQpzfRgwxchG6f5Tmk/mkqHmV9RslF4FNVly14lpPWot
	D9c9rCyA5wFooI/WkRlhnU4J+273mIwuQ231AHlzXj+Gj7ASCJw==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr20766365e9.35.1724771964535;
        Tue, 27 Aug 2024 08:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVs7Eq/Lgx0Ec3DmzVYMcg2muWndP6suW1Qn92j1nPKb5gJ8Gdf9ACQzJ78fT4mjD/JVG01w==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr20765965e9.35.1724771963838;
        Tue, 27 Aug 2024 08:19:23 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffefcasm229538755e9.45.2024.08.27.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:19:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:19:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] ipvlan: Unmask upper DSCP bits in
 ipvlan_process_v4_outbound()
Message-ID: <Zs3ueeXcqw47HXa4@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-11-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:11PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


