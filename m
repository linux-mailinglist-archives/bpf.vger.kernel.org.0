Return-Path: <bpf+bounces-39669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A02975D31
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 00:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469BE1F23A83
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E61BB6B1;
	Wed, 11 Sep 2024 22:27:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753C1B5808;
	Wed, 11 Sep 2024 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093620; cv=none; b=EROSEKgtZNcEV1Oe/gRlF7iHPIOT8OQy9fie9VYoFi9sJ3DJTLqI3nN9PWnbC6ah699N2VU0ew8N2ogYm9byROCT0C3qpS2kaWM7F/CkLZEzU7krxwg5yZ0Os5nN+wYT2+6ZO3HQzJUyT0Y83YZ9yMdvKN53Z2Aat4oFD8l9/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093620; c=relaxed/simple;
	bh=r3DmMXq1AXFTDQFzwTFrrrEnMbuDF0efQQJ18TXLopA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+bMIg5MnbTkYRE9P3ZE8niyQyJUO6lPbGttPeYhPVtEw4TL8YUG+s8X23LjXKNyX7/GdorI+1Ds4jNjtTuUi/RlOpM6aVKjIAH/S3yR+3qjGvsH7F87J/sgsBQ60pEl9qmRXibI861MW+FD0CXOCyUnLQZ4rCi04Ceyz/7FYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=58890 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1soVnZ-007XrK-B9; Thu, 12 Sep 2024 00:26:55 +0200
Date: Thu, 12 Sep 2024 00:26:52 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: netfilter: move nf flowtable bpf initialization
 in nf_flow_table_module_init()
Message-ID: <ZuIZLHc3kvZ-lzY0@calendula>
References: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
X-Spam-Score: -1.8 (-)

On Wed, Sep 11, 2024 at 05:37:30PM +0200, Lorenzo Bianconi wrote:
> Move nf flowtable bpf initialization in nf_flow_table module load
> routine since nf_flow_table_bpf is part of nf_flow_table module and not
> nf_flow_table_inet one. This patch allows to avoid the following kernel
> warning running the reproducer below:

Targeting a net tree, here is my tag:

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

