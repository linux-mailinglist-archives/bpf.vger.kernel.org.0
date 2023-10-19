Return-Path: <bpf+bounces-12629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C57CECB2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD51C20ADD
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30C37F;
	Thu, 19 Oct 2023 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtTjOL6T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2717E;
	Thu, 19 Oct 2023 00:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1753FC433C8;
	Thu, 19 Oct 2023 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697674806;
	bh=dxFpRFGQyZYIt12hrHgMufWeqE05AdXR2afP4eEpMLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EtTjOL6T7kpVGiMQBlY9JUSeIpRaurrIM4JwgzxgVfML6zjp89ZXotZhHt0JTWOk7
	 uDzhIRAcEWdRCHC/LLDwrIbj0fQKwQz1Vze+94phMo0XZbKViWkJie8TY89DF7gl4i
	 aPjAd7qDPTPyI0RCzmsoPFesF9ZAZDFnC/NrQw7TAwp5E+KCe3IK3dB7Pwqij6bLlC
	 BkF0xxU5lXKleXt6sJyC7zT71JpESUlIjVSiTGb2Jvejo35jb/ykViTcbOs9Gh3e/3
	 fnMDSMq5MgN/NFn4khDuhTqF4m38BINMJ6M7769H9qzcYxGKMudRLN8GPgylceOstA
	 CdAZAkyJpbyaw==
Date: Wed, 18 Oct 2023 17:20:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com, martin.lau@linux.dev,
 krisman@suse.de, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH v7 03/11] net/socket: Break down __sys_setsockopt
Message-ID: <20231018172005.6c43c7ca@kernel.org>
In-Reply-To: <20231016134750.1381153-4-leitao@debian.org>
References: <20231016134750.1381153-1-leitao@debian.org>
	<20231016134750.1381153-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 06:47:41 -0700 Breno Leitao wrote:
> Split __sys_setsockopt() into two functions by removing the core
> logic into a sub-function (do_sock_setsockopt()). This will avoid
> code duplication when doing the same operation in other callers, for
> instance.
> 
> do_sock_setsockopt() will be called by io_uring setsockopt() command
> operation in the following patch.

Acked-by: Jakub Kicinski <kuba@kernel.org>

