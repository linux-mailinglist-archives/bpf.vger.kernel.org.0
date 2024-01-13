Return-Path: <bpf+bounces-19503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372582C92A
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 03:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF54281869
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE6748A;
	Sat, 13 Jan 2024 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db6SZzaV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E006139;
	Sat, 13 Jan 2024 02:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5786FC433C7;
	Sat, 13 Jan 2024 02:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705113933;
	bh=WPXNIjwPEyUAkDq9R3BucYPvYuAfL7jmt++pnxeAdj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Db6SZzaVP/go0D8hwVgyW9vUMX6p/j8RS7XGrtL/MCBs1tFF7vJfmwPZ8/zUY9HG7
	 Gu1gVgGacmVzkcgrnKKX5BE/WGyudQPAjfrh6bQHPMkfBEHZC1zis8ua4S6Ipc0P/b
	 gVpMg8QP6KYgb15XmBeHElqPTRnQa76ldjykKHEzKdM+b523BmmBg5HIVZSumqJ1VT
	 5GIyRUMfS32GkugH7vdcQM91pRFqV+7HmyuZwuHSLO2UDlnRO6sowYW5eGswE6qaG5
	 pAkBjpsG2nTg0NZ3VkB1qIU6v/rkl2Yw7NkXmBUA9GUSu7gbmkyUlmj2BOfF8L3HgF
	 YTb+YtGr1u0Bw==
Date: Fri, 12 Jan 2024 18:45:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, eadavis@qq.com, bpf@vger.kernel.org,
 borisp@nvidia.com
Subject: Re: [PATCH net v2 2/2] net: tls, add test to capture error on large
 splice
Message-ID: <20240112184532.7eb22ca2@kernel.org>
In-Reply-To: <20240113003258.67899-3-john.fastabend@gmail.com>
References: <20240113003258.67899-1-john.fastabend@gmail.com>
	<20240113003258.67899-3-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 16:32:58 -0800 John Fastabend wrote:
> syzbot found an error with how splice() is handled with a msg greater
> than 32. This was fixed in previous patch, but lets add a test for
> it to ensure it continues to work.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

tnx!

