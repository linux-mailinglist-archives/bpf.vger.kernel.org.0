Return-Path: <bpf+bounces-7494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F66E7782A0
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A3A280D46
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7623BDC;
	Thu, 10 Aug 2023 21:19:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851920F92;
	Thu, 10 Aug 2023 21:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F65C433C7;
	Thu, 10 Aug 2023 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691702368;
	bh=og9HCM8mQmPzM+NOFpjCrf20xt3BkhG9VCjZDie6ReI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sANQrPKYfhMakHRRRYi3FjGp4URh17sx8nDfqANEDoR166atV+MKeV9AV3xeAT3jU
	 SgNt4to2XzrjvQQSySDF09EiGMFqe7q02BY8qx+LnKSky6KLonWg3w8hXSvyqP3roW
	 ScO7aSQAae0qP8etczmk3j/eS9cZtiutWCZb8YIlggpOmp6mrAdJ6S00LJgvsZlAEw
	 S3gvuaarLONwhVDdqFwAkPVnEQ0UoBvCaN2ChYZ6QyYozAzgBspxcGNEg588FdFseT
	 gaXZo4DwFb3/Vkv1qHRzvkgk4PFRFmgI41/w2x7TE3+KyuMPV8wc3XeqnTfjPX2Ae1
	 W6aakwu1M0Wpw==
Date: Thu, 10 Aug 2023 14:19:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-08-09
Message-ID: <20230810141926.49f4c281@kernel.org>
In-Reply-To: <20230810055123.109578-1-martin.lau@linux.dev>
References: <20230810055123.109578-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 22:51:23 -0700 Martin KaFai Lau wrote:
>       bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.

This one looks like solid bpf material TBH, any reason it's here?

