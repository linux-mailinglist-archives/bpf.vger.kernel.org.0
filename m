Return-Path: <bpf+bounces-37741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F388195A31A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014F1C2219A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AD18C01C;
	Wed, 21 Aug 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OclwEOau"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713A166F2A
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258686; cv=none; b=jKvdiUcrat2DB5sfkcJimPawhesupDcAizCn9PTLg02/CkSgicnySztIRSlQjl0+/aKynBBJDHzXk0Io826tsRl010glYFpytJBjNpXtZwUkp/9h9xlKyRD753Pcu4jJsfxHziW4YpkFFE3BEVTUs2oGxZRs5l/AWQ6eVUHbKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258686; c=relaxed/simple;
	bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8hzkpSqHXgCp2OzJJM8RAMGxbDM2/JvRVNX2N2Om1jB3/BGjmf9/T/lxl1I3vOUcJTVYKc2ubXCCtuFl46tVM0ou2oQsD3E0JrCm5qhmnUWs0Y/msMw5yj+Kkj4ogti/tkpLWunIuajEpKY4X08aZyZ4kTdV1ESggLf6R2WiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OclwEOau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724258683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
	b=OclwEOau1uRiOsTLvW4VlhOnNxIr18qOHA/L2UNPekpCxX/1qEDHsw44g7VTt0B1D+ivZ4
	pLkGC7aUDf2f2LRgTPfKC3Sqo50bIRWioIDvfTGPmIDaI7SK5mEBFpP+lt1mxxh9VlXzlV
	CkypOIST6E7dQVu0NkG8uhUZRKWQanU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-ey2MRkoyMciFclTJJZIY4A-1; Wed, 21 Aug 2024 12:44:40 -0400
X-MC-Unique: ey2MRkoyMciFclTJJZIY4A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371b28fc739so553509f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258679; x=1724863479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
        b=CEmBk25Pac94VhPYhC03eKY0CWnkeNLBkfvEiTGHb8mRIAgNaWJaWSt4lm1AZqFN14
         D7lIgawpbKza0bv53/WtCO7UzLWRfqsJrXMDl1WIfUXBqdl4rKIGTOqe5BkMH1+I8+Zj
         xiC7cbvR+HQwbJOgTdHIA628Rpc1mMf4nLN9JsFrHuWdrtkmWdiGTakZ6IsGVlH54Ks8
         Yr8yCI1//WajQCahZ1BnT+bRzvo7QvVf4t20JOEAZLnrx9ZeO3bRzTb5GUQIsRYcFfit
         /ok6GUCDKOsIbq6vlE7/ae/ezQArIu4xmvJk1n1f37iCdjSVhLAt3VJrpcGKBWk/Q5Be
         IuXg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FnAgsjOL8yQomyR+jtCupydAzFzsqYFpp+CeQyBDDD89eFWV0lyL83SRxuxy+dspksI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVUR7UvAiC6TJUL6XZo4sIUBEOfgwWsA0PY2ahar0Sor+2PWh
	6By2rGBgyNnLZT/ORzr+6UNqaVjCoVVTGUWtB6VvY85FD+6OO1weB97risrhV5YIItxHU+Q+X/L
	bzefb/rG3/bTEysJgqX3gyBBrsbGZBPzFVl+v70o+Y+pZDQixbw==
X-Received: by 2002:adf:e450:0:b0:36b:aa27:3f79 with SMTP id ffacd0b85a97d-37305252bfdmr164229f8f.4.1724258679153;
        Wed, 21 Aug 2024 09:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+AvspN3ANp8D8OkOYAf7VfX7eBe+ARUXdDV1KzYegvFDJe3qrckw5DAhMczrijJ8Nj7klQA==
X-Received: by 2002:adf:e450:0:b0:36b:aa27:3f79 with SMTP id ffacd0b85a97d-37305252bfdmr164188f8f.4.1724258678209;
        Wed, 21 Aug 2024 09:44:38 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2d7sm16226321f8f.10.2024.08.21.09.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:44:37 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:44:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 10/12] ipv4: icmp: Pass full DS field to
 ip_route_input()
Message-ID: <ZsYZc+JGy8Pu6gLP@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-11-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:49PM +0300, Ido Schimmel wrote:
> Align the ICMP code to other callers of ip_route_input() and pass the
> full DS field. In the future this will allow us to perform a route
> lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


