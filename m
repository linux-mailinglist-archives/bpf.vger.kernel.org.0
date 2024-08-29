Return-Path: <bpf+bounces-38388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F896424D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07703285A7F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E23190661;
	Thu, 29 Aug 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELix3QJS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99973190499
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928787; cv=none; b=jrONscinoDup11QOyokrMKf2KKShL3I36hvbcRMDVizdqhEFAmeRlY5ZbnS8AqrKv/P9x2mb0c2EU8Cwjd1k0BgWvy0MWjEpEGs6fNA2qN1lOYyjKpSRM8FL0nffcTuP/Arw3HO2S+DZ/00QL4eef9p4+TaeihQ9qXOfGQkY22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928787; c=relaxed/simple;
	bh=vYsSRcffFINc/Z5uf1RRpgskM6ELOon13wb4ULaXsb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biuptbKAdq/8lLGGTY/unEdInFL9uY/QVmcyS18URIno693Pj7AX7aKT7ithn72krcvjf2C4LwvuaTEnJryUAN70x6Wgn3/Xy+eqBPnjW31baQdpg7SdML30vYZ7TxPQzGK7jjKEu3JmexLxWNX2SJTjiNX3s3Sm8vhOenrY+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELix3QJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/8wOthdbHWlH+BLKtl0TRATt6SB1NZ6dUt6Jn4HyYQ=;
	b=ELix3QJSpG5MNZSAFXL1aS1+W1AspIfcO+E3rG6qakOm5r0wzv0Kj0CuTBfyXxeeB1zUhR
	EoBpLoInVGN5o9z5Mp1c3AjAqDJGBCYKFz3ku6uHqDahJYUviE9fqMQ/T9yA2Hbt9lcvHM
	6yT9pcC3dbZ6PySL9ckE2WjWNJJ5kuc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-NitpgqKOMjmSCFEZUa2Dbg-1; Thu, 29 Aug 2024 06:53:03 -0400
X-MC-Unique: NitpgqKOMjmSCFEZUa2Dbg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-372fe1ba9a6so408142f8f.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928782; x=1725533582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/8wOthdbHWlH+BLKtl0TRATt6SB1NZ6dUt6Jn4HyYQ=;
        b=ne7hYxMqtQA/6/SM6CZ06azvlMx7bAivNPParxR/ADBNsuqPSutXtPZfI5iO+z0C0c
         c8fmKG1iderCts33yvEnHY42vBHgbTPtPUAXSWMhz+ufSy5MQwS/8aSUSu0Zf7RnJA+8
         oGJyI2/MPmQht3DsKFyybn4goOh15hMJ5c7WlMMuZrkNtcHk+FMf+nykFp/Yfap+9Cm3
         lUaYz63mNhZCWXyWViTSudXOIH8HuaYOSk00iDJt7YSz24Nd5sIMIybhxVt+p7ygcV1N
         qLNI1zAHu63uxVrLXN4lgy4oivpaYrhs1XpGxHJYp4K2hlGw4+U5xDQqQTSOV9hWF14g
         /33g==
X-Forwarded-Encrypted: i=1; AJvYcCX3bN+UE4U1l4kFZ+hQwgPZuc1chUA3Wa27Fl7XZ7n9PybtrAoH5SsAgmww9x/NJbmzId4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDa7wp1aACyT5uLtAcS+JukX/HXaol6i7GJFOi1QET4qMcikBJ
	OmaC0iT8X9OWJWg3Q4s69s9cSuCy683u5+70dFxKtxDuamwnqV0zYmiPw8R7Sx/JuxjB2TR6o5/
	pTq8N8OQRr3TYSTlRzhiFQfQxGbHLirsslVoay/rWaq+iFI1Q6g==
X-Received: by 2002:adf:a416:0:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3749b5477cbmr1721326f8f.15.1724928782056;
        Thu, 29 Aug 2024 03:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCvmcLU9oPm9tTU/f+g5J+P2MF1yPV0hunP9kHsqhBqcIuXvYhwnSfDFdmDI67biubGwmkXQ==
X-Received: by 2002:adf:a416:0:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3749b5477cbmr1721280f8f.15.1724928781168;
        Thu, 29 Aug 2024 03:53:01 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273e3sm13202495e9.30.2024.08.29.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:53:00 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:52:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/12] xfrm: Unmask upper DSCP bits in
 xfrm_get_tos()
Message-ID: <ZtBTCjRP9M5qo7iz@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-8-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:54AM +0300, Ido Schimmel wrote:
> The function returns a value that is used to initialize 'flowi4_tos'
> before being passed to the FIB lookup API in the following call chain:
> 
> xfrm_bundle_create()
> 	tos = xfrm_get_tos(fl, family)
> 	xfrm_dst_lookup(..., tos, ...)
> 		__xfrm_dst_lookup(..., tos, ...)
> 			xfrm4_dst_lookup(..., tos, ...)
> 				__xfrm4_dst_lookup(..., tos, ...)
> 					fl4->flowi4_tos = tos
> 					__ip_route_output_key(net, fl4)
> 
> Unmask the upper DSCP bits so that in the future the output route lookup
> could be performed according to the full DSCP value.
> 
> Remove IPTOS_RT_MASK since it is no longer used.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


