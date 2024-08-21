Return-Path: <bpf+bounces-37725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88B95A069
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B85B285743
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239E1B252B;
	Wed, 21 Aug 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRMBPsZN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA991B2515
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251855; cv=none; b=qViCOD+xUuXc/5Pkfd2W/h9To/Cqv6DyLXgJP48T6SzQ5hEFDFuLpPLoHYagHKDp8XAUCPzKJtrecmumVg3nz1O60CwWO4Y4g8hGIzVc/CLxN0GjnBcmSkVPf5mZpCQVzmSsY7Gi2gFjysC/4v/8LURyxUYYyb3Pz/c5G23I5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251855; c=relaxed/simple;
	bh=Lz4JP4RGDLHi9RLgMyWvSGuFnZvOp5ENEyuoAWs/zpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTdM5UMy8mTwkDbENTSLMJgN61TDsRVhYzzH9PCXMuH+epj9lTU5E+va1b6cFRVrRZ49O7Pie5gmYx+UIbvwlhK0EjrYM6bhviXEj11eIT0UvrD6UbXN0OCkbj2uibb0kwK9v2hMfR3xdF2m8BQQwuWRRQUoCKE3J/+EK8n6G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRMBPsZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724251853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6RL4UN+IajAch5jP7ub0jIzRqoNQWJh8Odhf9HIiPk=;
	b=MRMBPsZNtGKPZnTHl2bKXejjTvP5e8znfqA+rmYSCg8q6q5S3d1SAF7WbiGcv6IVxcWUXj
	23xalvP+3CT6y9qeBhs4vWcNjwyAGc6fgFAEwaa3PAkjJiBhKemFmWWsDoi7pHUewmlyz2
	5Vu86LqELqSJC6VHMhRiP6tJjbqhLYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-_3uycJxfOyWsthX4XQ2SUA-1; Wed, 21 Aug 2024 10:50:51 -0400
X-MC-Unique: _3uycJxfOyWsthX4XQ2SUA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso58790035e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251850; x=1724856650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6RL4UN+IajAch5jP7ub0jIzRqoNQWJh8Odhf9HIiPk=;
        b=WlK9bsL7D8YOd4VUh7vT2PSGAA43e5I6T0oHBGHTy6P5CFCWP/OZ+wfF0NwrL8ClAK
         zkzr2ZfBaYCp1AlY9R5gDgFzzosDLHHYO4aJ6xgPGD4Ovvd48OweNsGqPUvn1iYcaz/b
         dl1JNaQ/AvvXhhl/wPYmyWGHZmnNZPMAAhF2QIpaqlI3js1W3/5Ge+Ku6XQEqZiKqFjq
         zAY7s+TeLRsCWT5At5a4MxTtGGfZ9M0uR8txc9OaAdcL9E/J6kJhJ2mj8MhDb33URD+M
         tgwAeIyNPVzoXzLFoZyjxQIwjn3zSqB8bdX4E7PIyhi6njcpCoqtTRlkuh0Frt55CXKA
         5EtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp3yBIsYILxgT5C21l0rdTkB1LoNc0ePh5cwG70FuNjyN8KNtGTCfCAZvhyNvwM3acojA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LKtpMNnGSVKb3mulJPrJg3hUuNjncjnkTT8jfABrcJ4O60ze
	uIIWgUzGAH5MZQnUFf0XsEdjyTsPwKM9fRAEIDi0+qOBrk3YXKgX+75Gviwjn5MolMXDtcMyRQ1
	/azAPnhNlYf91Z1UyrX6DpIux+SQRgbwoSW7cy5KrX1Mzc/jxPA==
X-Received: by 2002:a05:600c:a0e:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42abd244b8bmr17110485e9.27.1724251850374;
        Wed, 21 Aug 2024 07:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJZTO+za0Tzl6ZmOTOOjQhPQJN9bYwFdrr8NJSzjsMoBaqfx4mSpjWqlRxORsBcqVfFoCkA==
X-Received: by 2002:a05:600c:a0e:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42abd244b8bmr17110235e9.27.1724251849543;
        Wed, 21 Aug 2024 07:50:49 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8bd36sm27422815e9.18.2024.08.21.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:50:49 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:50:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 04/12] netfilter: rpfilter: Unmask upper DSCP
 bits
Message-ID: <ZsX+x32u37WIYqVA@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-5-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:43PM +0300, Ido Schimmel wrote:
> The rpfilter match performs a reverse path filter test on a packet by
> performing a FIB lookup with the source and destination addresses
> swapped.
> 
> Unmask the upper DSCP bits of the DS field of the tested packet so that
> in the future the FIB lookup could be performed according to the full
> DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


