Return-Path: <bpf+bounces-42395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25839A3A60
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E14F1C226D3
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A420100F;
	Fri, 18 Oct 2024 09:45:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E8188A18;
	Fri, 18 Oct 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244715; cv=none; b=SPzsGWdhk/bjphLRiM0gElw+xeoh0W1VxHu7R1hKjicQSeOlrastAgzcw1y7GxISFEEZUK1vto3g578GTmov1RSp5CHsJNAB3KWGOiwLznSm8rypLxu/cGmERU+RRON1EwEIezQgeMHSKrQYTGqFZZ7IsTF0gZXqPdfTxYIagiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244715; c=relaxed/simple;
	bh=gkICjyOuQKQiNEoapX83bbermxloo2+MxYVnv9T9pfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkypgJOoz815p8DQEM6JFhWqv9HAXwgdd0+eCZFY6fW2KemloA1oPebJWkm3zJ8vEP5jr2QgyLkWD3QKuYJfdcVzXv1GKdK/Ia1DVrj+if2G1qKeKZR3FgfR0GcQLhbzMZqVEfMN9z3jHYKLtifs5f3/zmNb9wCHghVXTkuMwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1jXV-0006Gf-Qp; Fri, 18 Oct 2024 11:44:57 +0200
Date: Fri, 18 Oct 2024 11:44:57 +0200
From: Florian Westphal <fw@strlen.de>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH nf-next] netfilter: bpf: Pass string literal as format
 argument of request_module()
Message-ID: <20241018094457.GA24035@breakpoint.cc>
References: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Simon Horman <horms@kernel.org> wrote:
> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of request_module() is potentially insecure.

Reviewed-by: Florian Westphal <fw@strlen.de>

