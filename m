Return-Path: <bpf+bounces-37726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AA95A076
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8238C1C22794
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC71B2527;
	Wed, 21 Aug 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDuaVkYW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60A1531ED
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252015; cv=none; b=LYfq2z+9anFt4sW8GJae1p1OKU7rCWVDX6hJGRSia/pKr8Jm9goQFmftkXR5gmz/sg6d+YqX4y9HCGSzUEyr86EzL9LIwKJpI9gmxxEj/g7AIw6oQv30ve8EUBS7o7yPPkAwfDfgqNVC8Bk0WYqZ8gcB0TLRzMh0KVmgaQm2oBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252015; c=relaxed/simple;
	bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kij5SZ5JO31EzcLVu2Thz1G5Vr5nwvyMTPUux8Ypv12LCnF+dmHJQHQ9mLKYSoewamAZONIqgTBZfxaho+BznCnfNlYCXwnzrHUbbrYN0zaCiR10OB7I8ufIyZNnRbCvEIlgEeGJXfYeIM5VkYwMyECndXTRzkqZAYrRk++jG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDuaVkYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
	b=ZDuaVkYW9ebhghUiNuCuqZJyS7A/mV8zB9NP+pdRhtVsAIgknpS/GM4+lJGLvbs4eM8WG7
	O0sRYLyfkWrb2nwblkzNWWgL7J0DMKYHxU0TiAvqsrCgfuV0GgXQmdmm7iB1yjb+T08aPx
	Prhdapyxb+Omb2JXMAEKOvfoLiehW/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-1jDy9ywQP6mx2AfPynSbTg-1; Wed, 21 Aug 2024 10:53:30 -0400
X-MC-Unique: 1jDy9ywQP6mx2AfPynSbTg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718eb22836so3798207f8f.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 07:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252009; x=1724856809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRowLw6jeaZM96Gx0RTdiyjBbs/u63cqCTb4+mz3jVY=;
        b=jiw/Chg+uLaw2XgS+r2VR+LTzwJfiMmYxLSvRSjsQYoGmfNQ9F8IH4Yxg7+kJlcjMc
         jIFzYfLmxg5xs7PtvBajaTXRKty3GLxl0gvu6/OKSB2s7rMQ/pXlXqmy+3G9ZEb4MIAq
         wk80v6c6Kh4rHyhVmK8PT0vLSUuN4cTbtR9mIamifS5RcBR3ZDIvr+F/6dcApdSpX2MW
         DgkBPgMVvnrCV2OdW9OTfFGr0bq4RFOAHtkozevvyyVtKpZwRkiaCGfAjB0LuEQg8prQ
         j3mhFvZo4a5dB1Pk4Qtp7PaiKvJpZWIiaRBm1CFWQvpXB8PTNfyj09b9jdphDb4XcN0k
         uQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWHh6vLsYwFhg7Zz9qdTjtLYU9H0k/FGVFEsmn9/cYgralo2k6hAdnAxqcqcnWmRWRMUgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxyDDnEv29dnva9AwA/VQj3KVxPQCgHQyZrVKsxB5IUPJC/TL
	2JVWiiwxDrYEWBCil+vaCosn9I20sLix27trAvgMgTHAADZD38CkxOkNCtHx6Liyp/KqJysRIwZ
	sFzKEr8GvECjqT5sXO/KQ3/nksidUW81KIO4uiypcoDsESHa0xg==
X-Received: by 2002:adf:f892:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-372fd70ce60mr1529938f8f.46.1724252009420;
        Wed, 21 Aug 2024 07:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZDr7ggR+/eNYCST3LZgSsI550O5ufyI8DRdkzvxCJn3F00o3+I4ON3GXaiIZw6yjPzdqQRg==
X-Received: by 2002:adf:f892:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-372fd70ce60mr1529902f8f.46.1724252008552;
        Wed, 21 Aug 2024 07:53:28 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed91071sm29081695e9.1.2024.08.21.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:53:28 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:53:26 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 05/12] netfilter: nft_fib: Unmask upper DSCP bits
Message-ID: <ZsX/ZlsFqN3YnQ3h@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-6-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:44PM +0300, Ido Schimmel wrote:
> In a similar fashion to the iptables rpfilter match, unmask the upper
> DSCP bits of the DS field of the currently tested packet so that in the
> future the FIB lookup could be performed according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


