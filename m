Return-Path: <bpf+bounces-6297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657A7679F0
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8855E1C2170C
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85364F;
	Sat, 29 Jul 2023 00:42:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C47C;
	Sat, 29 Jul 2023 00:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD8C433C9;
	Sat, 29 Jul 2023 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690591334;
	bh=d7Z6pnlFPGFfDhjwhra0Ri99vsNTVZ53Y3LVs7Z3vx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mkl6qwm8py6K4mpgVWJwPRaXk50gl5hVq8We7KrZhpGWcclTrTfJL34hUpUK0hmVU
	 uiyCA2EdhEAGUhf0VajdHublDI6aw7Ld/asV/LuDbs+EAW3rDy7lRXyhfQV1bKZg+p
	 DQqbwjMYsmM7Y4rN6NHWjLMteqoYr3zJUF+85xCDkBxrvhCdudS1iHxtmSZYVLRhoj
	 b53O1qYVaNaHdGmUzt6qTWoXRWLLOy9V3KdCEn7bW3ICVYdQFfjYHHeQlcW75u4qxx
	 FJ6Cs/a3ZI/mdj/ky1uf5IoXCvuFJRhqM5k6IJ1x+TfchtMoHwkGv/enickgJObnpq
	 Za6LTsqYPxwpQ==
Date: Fri, 28 Jul 2023 17:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, bpf@vger.kernel.org,
 somnath.kotur@broadcom.com, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
Message-ID: <20230728174212.64000bdc@kernel.org>
In-Reply-To: <20230728231829.235716-4-michael.chan@broadcom.com>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
	<20230728231829.235716-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 16:18:29 -0700 Michael Chan wrote:
> +	pp.dma_dir = bp->rx_dir;
> +	pp.max_len = BNXT_RX_PAGE_SIZE;

I _think_ you need PAGE_SIZE here.

This should be smaller than PAGE_SIZE only if you're wasting the rest
of the buffer, e.g. MTU is 3k so you know last 1k will never get used.
PAGE_SIZE is always a multiple of BNXT_RX_PAGE so you waste nothing.

Adding Jesper to CC to keep me honest.

> +	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;

