Return-Path: <bpf+bounces-37745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976B95A32B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6ACB23228
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18B1AF4F9;
	Wed, 21 Aug 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF54EQzJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C814E2EF
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259020; cv=none; b=u+AaE1uFWh0/h/C7ia+udjgsx6DqdJmcm2caarqWQP2E2htSLH3F3C2IL/g1Knb5Qqzl1ABpKvDmZb2Hl0o658lJKxj7KnX4+lLsm8DWUCqDrGbdhGOI1S3jCYz++6trDoDB6H6Bz4gylCUf8ZNr9Md2vPN3X1eUlg8K93DVN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259020; c=relaxed/simple;
	bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlRc98ZCTrmVgy9EoQJagJeMtXkfob/OiY0s5Zkji53I0kuZRR7wU7hvqVHDQtDArU4gltv0bW6i5ZtadPS4kjnC9CAxmH70q582vh8CxdOiW9+1KYDEJctfeRPRcG9WyYIEUVUs/WnMCngrR7WCfNuPAoaq2WOjpdpsRBDLRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HF54EQzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724259017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
	b=HF54EQzJVSPEaG1SxJglRqmeMx2Cz6Pt7yPPg6dNcIdz43fi4igIDZhmd/zevOuwyk0A8m
	Gyh/NsUVLkhUqLbqf6tI47P69KfRG4RixItSZxKgvrjpsUIpf4w4O6e3sP/pgu5EbwJaDI
	6lja4AIjiuZ1Ioh3eYcZXsSK+aikAsc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ypSTl6zBOLKV93hiAThKsQ-1; Wed, 21 Aug 2024 12:50:15 -0400
X-MC-Unique: ypSTl6zBOLKV93hiAThKsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816aacabcso58126545e9.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259014; x=1724863814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
        b=MjC9LIjk0hPn4wJakCgkBEijCc87D5mv7JBPY+kQkNYHqOmRo92XCkmagc0O+V8SOc
         Hl0JI/cZDK1g1B3ISf6CgrpaedTDuUR77LWDtsU4mbTY+KaR5EwvQBcD5lEHhHaIXI1M
         1j5cCjWf/1A813SS7LgNk+ph+uQGkw9aDVchYBAp6Kw8O7BS0x30DyK7P9BhVZ5ZNrPw
         gDCMHnwikfEwzxx7J7CK14a/TXFEeoh8MAnrZggZNJTLoNI9pYiO1CBfcSUiLwZEamYN
         bP8g3vTgD/nfQGfNe7Zvz7u3xm7SjZ6jQx+sOYOR3Jfc5lsYoMdBrcCxaGMg33NvT30I
         wtsg==
X-Forwarded-Encrypted: i=1; AJvYcCVOdUT59FjXH6aR6JJfChmVTkMa5ew9kLXU0eLPHf1ryCStC94a1QmxtT3EyiNzpH5bUF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIzWOioi6BO6gZfORO9oEF8PzVP74yu/Cf3RqmmzAPEbwPCbz
	DlwpE7dD6oQR7fB3PCZlZFwkDtbV6BBor2g2NXn2LxB/CMGE5VMuHA9MdTVgY5gpm3H3509jWK3
	tud/7vcCtjCb8hB58m0ONybAxx/whT1Mc+enxcN4/mN+m1p1uww==
X-Received: by 2002:a05:600c:1c90:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42abf05ae37mr18604895e9.17.1724259014591;
        Wed, 21 Aug 2024 09:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdYw76zuZe0YDI3B1kYguVY6tpjojxF2XLFri0Dx6C52Xr5OcnHJXIat12lugoEB31B+ySw==
X-Received: by 2002:a05:600c:1c90:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42abf05ae37mr18604395e9.17.1724259013301;
        Wed, 21 Aug 2024 09:50:13 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86f23sm30360345e9.20.2024.08.21.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:50:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:50:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 12/12] ipv4: Unmask upper DSCP bits when using
 hints
Message-ID: <ZsYawgBS7HuvFmMR@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-13-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:51PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when performing source validation and routing
> a packet using the same route from a previously processed packet (hint).
> In the future, this will allow us to perform the FIB lookup that is
> performed as part of source validation according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


