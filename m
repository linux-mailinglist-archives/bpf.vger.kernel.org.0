Return-Path: <bpf+bounces-18008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41516814D3D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738641C2354A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD73DBA4;
	Fri, 15 Dec 2023 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxAMUj4y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA53D970;
	Fri, 15 Dec 2023 16:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2482C433C7;
	Fri, 15 Dec 2023 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702658281;
	bh=APiByjmtJ8apvzbXoGAkh9ds+m4DBaXPqAVdhBcorxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxAMUj4yX2JhLdGb75spHZnQj/rwHj5xbveko3scEnKm9o6vWjC5ncjJIECilipFG
	 H36VMAm84MuCK4o25cNTHQjKdUf1SUBsAtG4Lr02Qhfn5RFM2pI0Uan9eLsm/yWeDu
	 N9KAiYnsOx4g9I+BkqGHijfZwCz+52j4Dn9VQHct8FzbkJkH8G23D2NIJtWfB+bjne
	 4Vi9rnV6q3vkEWn/wFz6tTD8CQ1xnJtAlQzLPLJqsygZv/BMGx4AljTdwMfwv+sbO7
	 UTuJSsO93HCZEjMrJ+wmHFLJeJIuqtlA03nb/bql0gCmiTY2Vrw9r8ipToVGBJ7J/H
	 gJpI7MuWZEL0g==
Date: Fri, 15 Dec 2023 08:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: do not map packet buffers twice
Message-ID: <20231215083759.0702559d@kernel.org>
In-Reply-To: <20231214213138.98095-1-michael.chan@broadcom.com>
References: <20231214213138.98095-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 13:31:38 -0800 Michael Chan wrote:
> From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> 
> Remove double-mapping of DMA buffers as it can prevent page pool entries
> from being freed.  Mapping is managed by page pool infrastructure and
> was previously managed by the driver in __bnxt_alloc_rx_page before
> allowing the page pool infrastructure to manage it.

This patch is all good, but I'm confused by the handling of head.
Do you recycle it immediately and hope that the Tx happens before
the Rx gets around to using the recycled page again? Am I misreading?

