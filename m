Return-Path: <bpf+bounces-37721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562695A014
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882461C22889
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567D1B2EC4;
	Wed, 21 Aug 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlYTXjsQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166E1B2528
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251053; cv=none; b=X+vbEPLQoVQMy4icwykUrjp2cRHtmtx99rtolSVivoUHOGQTU+OG7EhRt1dBOmqdPIdk42Am1DEU4Cm9ceb4AjsOmwAHA4nA7DP68Rr+oA+gXakoGdFupXd3fQaiQdSt2NUexqbT3LUn4oxBoc0zi44k+ydZkf/ebE8yox86Pw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251053; c=relaxed/simple;
	bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kidBka+WZ1G+0U2GsZG/SEtWQKopDLV7PVzOYQ/DABOmrHo9Cr8fx6jUHBfoY/Z8rCnOp9TtQkJCsQXUcQJk0G8pNE+ugORf4I13+FXvqpgxQ3zKmTGUJzBsmwZjkrSVOvPakTWtYC78e6N+CC5Zoan3XFbfPSs2ruZvTRDk2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlYTXjsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724251049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
	b=AlYTXjsQKILqbqH7CT3uUOXh7dSbWHuxHjChugSeDV5SdsTJ5ztezEpI6lB+xOEhZAqI77
	+XfkiFIr9gHa5CCTdaZX4OH7cr9mOS2s+Da1mEB1Zg373alzEHjU5rJpynQyVl28q0P1yG
	OzTygxp1o1po+bFgJi8QVTF9aWIJZrE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-fW0yimM3Ov6T5BSFbSMqlw-1; Wed, 21 Aug 2024 10:37:28 -0400
X-MC-Unique: fW0yimM3Ov6T5BSFbSMqlw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42820af1106so53960595e9.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251046; x=1724855846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
        b=trxQBvlbpWIG1elR2FD+y+L3Jok0ROMnc0B9bZV50pIPtnQpTcAqrxunKlfHahRd4o
         tXjkSmguixx1Wxi+s5zQ5w2tzuFnuW8sLm5soZl254jh3ps7vhDU3ECgjV6SQx/mGsdO
         p6d4sVzPLjhop2Hkm04DfERhiALWWgVMWjGGs7AyKXoDB1hljtB7lIqj78AyEcCAUfxN
         T+DqhzhouxmSk38uqx6+CPzZWaH3ATCL3D5SReCx5QBvcE0lWIv/6JRYSa+aRV1fOtYE
         Of1drANZvo6jCVb0x6zh48mGhN8eCtvWseDkSJHbj0Nb7I9zcPNlleRLxiCWopVCWRS4
         2m0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXS9UAz3zca7p23AfeqWnlcS0wK0Oy2sjZtDtMMqHwZ6XZCkUyrE45BEDsGNQHjqF3JFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYAGMTNyXRDAkBDyCZJ/JH72340NAgpgBgOaZWxz+3AdViFh2z
	CtLjyE25bFOJiY0Je59h4o5ODUrd4JD1r9lvud0hCyZDhUh6UmIPa82xxqOMJPGtYU1n0cGqtmc
	pWaDpRK00DQ6Hgow5b7utdQKG8zGeQwbwwG5qwSElq4UvlU0N2g==
X-Received: by 2002:a05:600c:35c8:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42abd25e09emr19024915e9.26.1724251046086;
        Wed, 21 Aug 2024 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZ0w1vMUzhLTU1LCWBMDSAY92DCEqfTOCresT/HxF2xp/YTkeLxR6bm7/9BsLpuZ4cUXD/Q==
X-Received: by 2002:a05:600c:35c8:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42abd25e09emr19024515e9.26.1724251045282;
        Wed, 21 Aug 2024 07:37:25 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86d2csm28143355e9.16.2024.08.21.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:37:24 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:37:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in
 NETLINK_FIB_LOOKUP family
Message-ID: <ZsX7oh/Ft2gazpQf@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-3-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:41PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits of the user-provided DS field before invoking
> the IPv4 FIB lookup API so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


