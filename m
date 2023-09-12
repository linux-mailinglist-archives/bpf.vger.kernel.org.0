Return-Path: <bpf+bounces-9765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F779D4B5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C063281D57
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDC18C13;
	Tue, 12 Sep 2023 15:21:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7618B1B;
	Tue, 12 Sep 2023 15:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE607C433C7;
	Tue, 12 Sep 2023 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694532089;
	bh=MODnFuqOmN7qBnUWBEYPJdtRHcnRb8MFbXBkDapR5wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=it/ChpLvf1ohjiGo2F7VpKjXT3UYU9WN3lYgHuq5FpwOGf2n6MA+hRw9fze1fKlRF
	 8dNK7kIMYv8bvNqR49lmcelCNqOtVU8mkPjo1hCpNWNuIZuhx9b97kKv+U6mx8jtwS
	 sseYhfQThkWqH3Yz2Dfh9KXFM/J+lcImVEN0OYdqN8jpJorRKeCAr+akDcA3q2Ew3i
	 BMawoE9mxxHCP6v33AsWog4uQWzQ4LGIlQU3su3KxqrASwI83VHOzJBgZvVI8WW9Ij
	 l5Iz7INZnMw7fwVmWezxQ6gsiuMVwwgU82VxTK5ng4ABNuIZyNIVX7Rg8uuZFonJl0
	 cZBCm8Kw/Aulg==
Date: Tue, 12 Sep 2023 17:21:25 +0200
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH net-next v1 1/2] net: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <20230912152125.GJ401982@kernel.org>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>

On Mon, Sep 11, 2023 at 06:45:33PM +0300, Andy Shevchenko wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


