Return-Path: <bpf+bounces-44618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA059C570F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B340BB37644
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538C1B86F7;
	Tue, 12 Nov 2024 11:36:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BA23098C;
	Tue, 12 Nov 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411418; cv=none; b=bEQunAc/Nm/ycuPfHWKmf72SZkLkHsOJEUBJdCfUAPhQ07c/CciwVTMkWn180JJ4mKgiep4AwarNlYBRB2cMUewBpCzoAg3OAUaAVJT4RvK0k/Mtv80DGsqw5oRAl76saPFdusbYfQgCmGO+6yJyNJeZiQZ9uU+/i2VJDnzWP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411418; c=relaxed/simple;
	bh=Rie9EXgiEfgE8cUOZHfpTlQo1q64m9Pjp3ivppCnqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfplOIYRg0w5qwkUgmVMo+qCjFvwXjrngUD72RgDB3ZfL8OfbEU5UPEnMd78qWDjlgjGgomhxI8HwUqZiojVn/VPYqUKDvXWgjP1c1+JcB/4ZlHJI+ciMfnsRo0CUmQzBHiknKi4u7rbEpdGsf13w95BX8yQbVpDfYAtJaveU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=51386 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1tApCN-007di6-JZ; Tue, 12 Nov 2024 12:36:45 +0100
Date: Tue, 12 Nov 2024 12:36:42 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@kernel.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH nf-next] netfilter: bpf: Pass string literal as format
 argument of request_module()
Message-ID: <ZzM9yvTopClYt4W-@calendula>
References: <20241111-nf-bpf-fmt-v1-1-5f061b6fe35b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111-nf-bpf-fmt-v1-1-5f061b6fe35b@kernel.org>
X-Spam-Score: -1.9 (-)

On Mon, Nov 11, 2024 at 02:47:51PM +0000, Simon Horman wrote:
> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of request_module() is potentially insecure.

Applied to nf-next

