Return-Path: <bpf+bounces-49896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA2A200A8
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B8A7A279B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750ED1DB363;
	Mon, 27 Jan 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpYCjJQj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946FB64A;
	Mon, 27 Jan 2025 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017398; cv=none; b=ouPc/l5xngEu5sEhEbgpMkD3PfC7pnW31DouqMRPbYPTVuAgi9f8T7By6ahZshNSOmBXMFL0VeWQOlc1gRWS/MOanioU5jGTto9Ze625vMC6ufFxlyFgBwT5J9O+JFejgEybWlSzxaygTVP1F5jMrIZk0WvkQVbkuBLs4KdruI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017398; c=relaxed/simple;
	bh=RBA8lE7qceJYQ75Ek4p3s4FiSr8R4e9t8pEPfHM6Yfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YITOWp0NBcsGA9O72SAZXBGTJ+Zqa8l+hC94/DwR7a/cpLfvMCkN7QfIh0bF6nKbotxElkAxoV7PM1ot9pIxGX9cW8AF6NXMQkuRst9FNytCj3BPyVeiccr08EQql4ytH2ZHrgWF3KtTTycTUsp8Cp2EzGYOVS2T2emxgjfDNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpYCjJQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC86C4CED2;
	Mon, 27 Jan 2025 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017397;
	bh=RBA8lE7qceJYQ75Ek4p3s4FiSr8R4e9t8pEPfHM6Yfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpYCjJQjbCYDYCwEhVfAxms1lR7bbgA8R/v1qe7yr4lMn6ngKKTZBn7otdBk6O01j
	 G9lhGZ1QpZS8LZY1n9yapP3J9LSfIoXIBqdM9YtHU4sh9Jjyi/VQU+cJr0NQnIWVuI
	 KGfFRsXtUNg+mqfBrKe+urzVM+IJJBnb69qqESUUub9DhYlWTrQh+6i8bGfdvAY1zg
	 B9nzXVCHY9sE6RcPjvLVOF/2Am8OU+Y5k/gUNLylG5k0dl8jJeawoN4JEzcll0ReNn
	 dstRNjAdwnkZH8wxbbrUMTDXB2M6f7Ud0/5/50Ut8JfsHkk5WIKGvkO+InBlrdNmGp
	 27VGVhBjLt0lg==
Date: Mon, 27 Jan 2025 14:36:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, ronak.doshi@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, u9012063@gmail.com, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, alexandr.lobakin@intel.com,
 alexanderduyck@fb.com, bpf@vger.kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Message-ID: <20250127143635.623dc3b0@kernel.org>
In-Reply-To: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
References: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 14:32:11 +0530 Sankararaman Jayaraman wrote:
> + * Copyright (C) 2008-2025, VMware, Inc. All Rights Reserved.

Please don't update copyright dates in a fix.
It increases the size of the patch and risk of a conflict.

> @@ -123,7 +123,9 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
>  	struct page *page;
>  	u32 buf_size;
>  	u32 dw2;
> +	unsigned long irq_flags;

please order variable declaration lines longest to shortest

> +	spin_lock_irqsave(&tq->tx_lock, irq_flags);

why _irqsave() ?
-- 
pw-bot: cr

