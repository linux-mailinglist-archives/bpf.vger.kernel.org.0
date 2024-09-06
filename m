Return-Path: <bpf+bounces-39114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69396F28D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62891F2515C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842091CB325;
	Fri,  6 Sep 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COUiHW8E"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0D1CB123
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621311; cv=none; b=OmHmrVuI2Wr1Q9OMKnW8Am2vzBTKKXSHhcFecBQiWYB6BRIJwvbMln1GTBq4jEIVUXJ15x1WlnlrjLY4pKDz/YKJNWKObiumV/Zy3B8coNmoEWwjiSgBNP67YPXm4IcHk7p+AobLYiXoQes4bi4pt7cftSq1Rs7f4S8FiMKQKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621311; c=relaxed/simple;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guO/xohvvpx6+h2L+M+aX5Zaq1DFmO0pdGbgVml0jn8yeBnPzfTDXL+o5Y6ZHs12hELbxy10MRWPOf4L1OVbQgXPsK+4D2puUQwzM3NYhfhV+rhuyisUvaV3RwEcmz6RpBrv1vYazvfLLBX31u+/dGvgqOFnkR6HpJAwkjjdBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COUiHW8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	b=COUiHW8EvBM6PoV4HjoARUgXVCG8XhghMBYGkt0r0nkt/WuKC5Q3CTlQyr+RCtHgcbjBgY
	ZtfR4o1fq1mzsM8cOEusxr2Hnb07KxNSGoM/kMZ5zzcNRa8JSwMVvYdMWJKfNyAC/fDtDm
	i0MaVoPHx7tkih33Xod+z8+RYIglaDc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-852rw79TNzyWp6VQpgLFWw-1; Fri, 06 Sep 2024 07:15:06 -0400
X-MC-Unique: 852rw79TNzyWp6VQpgLFWw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb9fa67d7so19345235e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621305; x=1726226105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
        b=Fu5WtyqoyXIn52owGGcDt+dkbdY7mRw2QZA0OPJ4EmSvrqvA7hY/nPnCa4iwMB5yY3
         uPRe5/1ZBrUopQXdy4zWohW9Z8FVkkMmdUjOPwx/dENJbxyhZXz0zAfmS9S+Mds716pk
         gFV8Isb6HOZ+aJgsGYSqIBBLzy/9StbHwE+FVTmOZzIHQAao5to9FaCmQoTTOWQqF1Rk
         BKbzrRq0K/wCVeElosVCvBe0n+cGnL59OeTV0Yg8AbvHck71JrLCfZSrDrMi3aEUadsV
         LgWSV3r9INEEr7CnJRivEU3wJcUcDKfpnGkCPvvbaVEQgFkEdLMAEMuit9dLrzw0YnQ3
         PX5A==
X-Forwarded-Encrypted: i=1; AJvYcCXYBSPgUv851lImaDnJ7nEE/GDpAH/TiHAbXuBauYifcFoF6YRyalMvFjksCHOvM1xLEDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0hnd5EYT4cWJnJZImi9JHNZMX4PRVGDVvtVbdLF2r5F8W1se
	CmlomXvuTgtdLff/iPdvQ8b8xA9Atmews833FK63TLZjJ4crTMA5mtdZQR7Y3ffbhH9LcWvBadB
	Z9AHwCXPl0MlX8iY2YBqtm7RgfQZsY9ZNRwiAFYLNldOG9N3CDw==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16076005e9.18.1725621304841;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7vCxT8H4VqHEs2N44xCaNM+DluDvFbOAReI6BECcPwvJ8SnS7DtqOd/aYseydN9zLNtq3KA==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075695e9.18.1725621304232;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm660405e9.0.2024.09.06.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:15:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:15:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] netfilter: br_netfilter: Unmask upper
 DSCP bits in br_nf_pre_routing_finish()
Message-ID: <ZtrkNbZcjQrUmdcC@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-2-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:29PM +0300, Ido Schimmel wrote:
> Unmask upper DSCP bits when calling ip_route_output() so that in the
> future it could perform the FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


