Return-Path: <bpf+bounces-65519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F3B24BEC
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AD7B7B8D
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E302EAB8C;
	Wed, 13 Aug 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh8YPewe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5055A79B;
	Wed, 13 Aug 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095479; cv=none; b=W+n5I8Y+Bi/33tozas26uQ9BhxNy7O+oEr4Rg9kJe7AxVQFrwmow+Eze5OEArZTOzr4bPdlCZNKl95Cji0NGnmnN67xUchwyqN/wb7v58TXLQ9AhfhFRtPWUqcEy72MZ0DAtDhShJ1tw+yYx6Z+xPIVzShsB6lsgetVYpqC7DkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095479; c=relaxed/simple;
	bh=lCnHQFYDwV26ux3XAOHXzq0Y05YyeD3LTvZGTN484T8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+BQPZKV0ZentoXZK1/0QMNaZ5Lxls3kckzhot9s4zYGZFrQeDsv/9Ibu6l5HrQh8OdK+p5oI6P6y/U0V1kGgO2HNn979wuOK5TcYmm+wP8thvM4KOdwHkd65kUMdHppjiPcS3CZplOsXJUI3uy0YCvJYCQton2Fk/h7kaHeIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh8YPewe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28FEC4CEEB;
	Wed, 13 Aug 2025 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095478;
	bh=lCnHQFYDwV26ux3XAOHXzq0Y05YyeD3LTvZGTN484T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qh8YPeweVmCaLwlaoK61rvcUIEcpwetldWQ0ZXblbPFcXt6FtWFoda2FTBQvpa5hO
	 XPPjsBS09YVDDi9JJTMaAJmcWL2LtR9rh5gNa1ZOpPjALfywdxaF8rNhFpUdcAofe/
	 2GJQKuR/q4OlR06uojNuL56k39M5gkAE7HEWi6PInnVQ0pfa7eUD9SVRu0MkSdhCPa
	 or96RLbIoie7tvyIbY3O+IQ9l0L21Rppk4TPikEq9MsXjcOr6ya6ddgQ7QkY2kOYpm
	 kjPaXFwnMZGxKGbqRi9mQeHuFgrvkR+sRe4pLslCqIiTrSmbbVV40IJ0k2oGZhTwvE
	 0DuYC5XUzhZXA==
Date: Wed, 13 Aug 2025 07:31:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch, ast@kernel.org,
 bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 horms@kernel.org, john.fastabend@gmail.com, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next V3 8/9] eth: fbnic: Collect packet statistics
 for XDP
Message-ID: <20250813073117.1bca3a97@kernel.org>
In-Reply-To: <20250812222252.261779-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
	<20250812222252.261779-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 15:22:52 -0700 Mohsin Bashir wrote:
> +				} else if (PTR_ERR(skb) == -FBNIC_XDP_LEN_ERR) {
> +					length_errors++;

cocci is complaining about this:

...fbnic_txrx.c:1264:14-21: ERROR: PTR_ERR applied after initialization to constant on line 1250

I think applying PTR_ERR/ERR_PTR to the constant may clean this up.
-- 
pw-bot: cr

