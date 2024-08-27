Return-Path: <bpf+bounces-38175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D3896114D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA683B27A9B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E11C8228;
	Tue, 27 Aug 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JajA3ibH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883B1C7B7B
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771860; cv=none; b=Koc45Os+RLnrPQfFxbeEnaANwVTQQ7n4p5E7sFzqlEjC1QNMHNf2XmU5ydF3mi+GlBEqMhU0rg+ETzR16ycuHt8zrM/pWZqSB8eUxQnv9IvaRb4pD8tAa60bvNRSEifcZ0bDCs1VZYYlapC4l6NprakNeeImfn6BjA0yM5mJeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771860; c=relaxed/simple;
	bh=Uis5UcWx7ESlkENuZddUEHlXPVlgyb9s9E+Dsu2AWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPACJ9v0mfuSp49jHu0nWHeJZ6zfyH2s92fI2UybCE4VmusT0sP7rVNJ6hE75pHGX+adYYu0oja4xZwkldpd5iIEnovts3QGxIF0aON2UyOQMJjx/q6e/sly3DlSd8UPaIIOUyuWzDZP767JISB81kzTmBlJD1yugUhFlW6ZvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JajA3ibH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r02ycll/0+vd2yPmctrGqk6tQvR75YJwftDX2X34Trk=;
	b=JajA3ibHFdrOAlMyaTn0wGl7b8NTWRkx6buxbeP/WRNPYBLwxO3C4y7XCrHEQ8o8O9NJMB
	CUcCVx3jo0UNEFQc5/uJUjccHjUHA7ZB/Xm3IRydE5L5BLckNqglAlAR1u7htBf1w1w2Jf
	54qA7dgMOKo6b52s84U6ENkbB1a4t/8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-FE-OXZLUPsOiYusE28GsUA-1; Tue, 27 Aug 2024 11:17:36 -0400
X-MC-Unique: FE-OXZLUPsOiYusE28GsUA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718d9d9267so3303117f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 08:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771855; x=1725376655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r02ycll/0+vd2yPmctrGqk6tQvR75YJwftDX2X34Trk=;
        b=vQoGJlllRYerur/S+FvN2sfHR6lNdGGGCVSEE4TgEk487WEYjea8GMEUbBwTJSRhhd
         pVieGtzW31EKwlXTpAUuDX0vwY/m7Okb0pzLo+NSfaV047M7u6/Xcld8jdYpHv/twOur
         Mj7vQjIsYv/3yE2l9F/B4VZwJARQ0lXIGoZX/bwaoDR1PmnkoRlpxGZlvplG2gcUkorn
         MckVdek1bIKfcwuCWwNedD0V+uYc6UXsqJz0T+lpE0ArSqxknniPoQgykeTjQ2nQVYNY
         pNRK+I044he0oE2mjoRA+cprbNn2DOnIg/hXv+Hk6UMybxC3GQPdogIiovoE0O4zgmlJ
         bbww==
X-Forwarded-Encrypted: i=1; AJvYcCXPWX6E0lMcniKlvVdy7RS5ka6RRF+XrVdYPCgaDocKom8OBIfvpp+ltaGkONvzBILTSTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwad7xAS54m87W8iBLJUWE8RDohFW7VKBeiwBEN5alkkCFYS35
	WBfUW7BZLdQIhmxhnnvsKEb7V4tNUZOdHdnIcVbNoMjsCbdb14w7+OjMy/TP3MVgeerLz5sk9Id
	1i+K7o+NSLpIMcIl48VQxuHaccZPAdJG9h7Gp5pTCUzbKUmrGNA==
X-Received: by 2002:adf:f24d:0:b0:371:941f:48f2 with SMTP id ffacd0b85a97d-37311865284mr8397732f8f.32.1724771855071;
        Tue, 27 Aug 2024 08:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELEUy4Prnr9PE8d6tJK0MjviDOOjG/ZZtWnIZk+XgFtC6kYa611ltjAGDxlvpBWZTu5GJaKg==
X-Received: by 2002:adf:f24d:0:b0:371:941f:48f2 with SMTP id ffacd0b85a97d-37311865284mr8397686f8f.32.1724771854246;
        Tue, 27 Aug 2024 08:17:34 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c536sm13546752f8f.36.2024.08.27.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:17:33 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:17:31 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] ipv6: sit: Unmask upper DSCP bits in
 ipip6_tunnel_xmit()
Message-ID: <Zs3uC1rpGScO4Cvn@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-10-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:10PM +0300, Ido Schimmel wrote:
> The function calls flowi4_init_output() to initialize an IPv4 flow key
> with which it then performs a FIB lookup using ip_route_output_flow().
> 
> The 'tos' variable with which the TOS value in the IPv4 flow key
> (flowi4_tos) is initialized contains the full DS field. Unmask the upper
> DSCP bits so that in the future the FIB lookup could be performed
> according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


