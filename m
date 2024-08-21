Return-Path: <bpf+bounces-37734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BA95A2CC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C66282831
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C77152E1C;
	Wed, 21 Aug 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3uo23Xc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3A14F9DB
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257714; cv=none; b=EmmUUM96DVSMaVy0vjmhZIWKuQVnsXSavwEpB9woI6Or4fkRjdVkhbgTwsc9Mn4Wn/Q+6d/gDxPvRwinPLZi6xJqb4wcYHKlgKEK2al2TBSCVkCk6JyqdcYmkXCHVjV9VqK8gW8ejB04UujyxoBQvVW40ccUpW/XWoe8+s9sXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257714; c=relaxed/simple;
	bh=INy/bAAJCjlbio1Ldw+aWgMzJBL0pym6HlFrkQVJuMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCZD0I/CF7WlHqhjW4WJ0Jbij2+khtKNFwQ8a1F9okmqIJuaOGqXM6IgdY2jj+13YG0jRAI4tqhkLkvT/E3XTthMOMyw+vmWMegB0LqREIXJIsbF4SMzxAhmbL57nSOvVheC291JOvLmMb4XBhHtvaJrGjWwY3d8dFGoHrnQTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3uo23Xc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724257711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INy/bAAJCjlbio1Ldw+aWgMzJBL0pym6HlFrkQVJuMc=;
	b=A3uo23XcGHfbnwJkIqbNH6Xb+FhoQhSygAGi5bEXg3QRK9yF5lE1FM08mQZjcL5z5Npmg4
	UKXITPhqcc2Ru7jedjsUnwHtcpe4+kZNwIRSwnmAxst9nps1ySqOSfA/SYiWiyCBUl6Qxj
	g3AFsAY4PN5+om9h1uf2PPtuKRFUzhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-533dM_vsMWqpab76Sfy72w-1; Wed, 21 Aug 2024 12:28:30 -0400
X-MC-Unique: 533dM_vsMWqpab76Sfy72w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso56697585e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257709; x=1724862509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INy/bAAJCjlbio1Ldw+aWgMzJBL0pym6HlFrkQVJuMc=;
        b=Nfds/EZrSSu2XdR/Req1uP2aMULjv1VZ8v2h0IvBLBw0OVpJCJ2aElXz/w4u6pHbOU
         DMkoFktPggvChRZUIxqmxZrcP0ciVcJpO5Umc1aI41eYsf39c4Jkss8j1oxtdKpeBeQ2
         zs/zFZQQ0GvPmQ6K+9kEE1d/Q1/bCFfgJwNcdXH4ksm3T8lE5zEflBqRh7O/9HXFJb1m
         hhCLlY2gWPVz6gshWyU5xypop046AY+u65fNCYtZ9JrP+r1GZe9x9kD7+iyORgIe1tUl
         czzigoxZ3AGz78rC5dEWSor4qClKwwhvvMn4gCUNbtHh5lWW4NL9uWa7ZE6ap1cTtahL
         V95A==
X-Forwarded-Encrypted: i=1; AJvYcCVEu7wkXhhMXW6L6fCCHYd7SA/ljLTGtaW0y38gMgYs9tatXm9yfE8UNQ0Tqz1Me245xCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftERdr2t54zm/BPxTT3cWmyXuAQa7lPRiiYPI5dwmoEAtXXtq
	msQSK4QquN/HgY4JTLP/u888DWrflhIqdCDFCT9KHN9njHybzndeAfKoYHItx8th+ZQoD2V7Qjw
	J8j1YW1OwbYRQZIrMtI4mzV4/uNEzH0w93EFqGhfbEiDY6ypvxw==
X-Received: by 2002:a05:600c:46cb:b0:429:991:dd71 with SMTP id 5b1f17b1804b1-42abd22fecamr19431565e9.11.1724257708910;
        Wed, 21 Aug 2024 09:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5+n0Fv8HveCdgINXMy+eE22ChN3nWbNrpHxcY7XJtnEmbN/V8Dc0vDGGi9pP2zhZWlB17DQ==
X-Received: by 2002:a05:600c:46cb:b0:429:991:dd71 with SMTP id 5b1f17b1804b1-42abd22fecamr19431195e9.11.1724257708039;
        Wed, 21 Aug 2024 09:28:28 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8bd36sm30069825e9.18.2024.08.21.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:28:27 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:28:25 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 08/12] ipv4: Unmask upper DSCP bits in input
 route lookup
Message-ID: <ZsYVqfPuyDiCyrO6@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-9-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:47PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits in input route lookup so that in the future
> the lookup could be performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


