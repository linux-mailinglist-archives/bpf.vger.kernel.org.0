Return-Path: <bpf+bounces-54706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F48A70870
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CEF1890CE2
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6030263F2C;
	Tue, 25 Mar 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEg6jeoq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608919EED3;
	Tue, 25 Mar 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924893; cv=none; b=NutTC8aL8BpFjnWtlN7gm7T/k5x/qHy25XW+JVfFdczInFnwK6xF4+QIZueKS5l2UKrUAlc/yuk1+Uw2F7xjjOw6VNQCv2Ot2Gpz6Js/ILSzIxaSzuSXcxiQxVr9Kgo4rF576x9baPibpumwaRgHBIOSi9DgW26s7/laIhF6/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924893; c=relaxed/simple;
	bh=LDYDrMN1yw3dnPT5hqTvwo1DrKrUFNcyLxotDaZ19As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5tSDnBn3EWTJCpSVz+0qLhmNjggp2t4NfZYDdlmsEITQfcQ0/ataiz0PqQimk636yImB8G5aEEuxvOkrcLXa/gP2Mh8rlStasSeHYSAs09OMLzBbxRNdf76zjeBAO2zddfZS4WGjnRvaM/BW4+7QnSVEqwbm1FL0G22ryxNNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEg6jeoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD4C4CEE4;
	Tue, 25 Mar 2025 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742924892;
	bh=LDYDrMN1yw3dnPT5hqTvwo1DrKrUFNcyLxotDaZ19As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEg6jeoqkTApxk+g4qxnWkA2KZibY5XwiIYqCjJZeLAETwp8dhdDtijH7GCzFgJvH
	 St2ItRLskRowiJQlKKLQhyOj9uZ5iHyWFshM3dluJDgXBWsgi6RZHh+lUDIIH4++ZS
	 cceOkMcfkOPi7Quu1HTfAra7Kh1sNY90JJ0FTeClpMsnzEKZPlPBJkZ98SScn3qnj1
	 4IwL723MoY4UCa5sMvlGD/3OY9Ki6oxQglZdMAePjZnNokrLy/K1Q4jYV+rBTaTALn
	 nsGL756qYeF5D8+Gr51gjx7f/qfPLP5PIOdJZ2AHQP0IyaNdNERUDgAa7EwtINAvJ6
	 fdiDLSGOJF5Ow==
Date: Tue, 25 Mar 2025 10:48:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kory.maincent@bootlin.com>,
 <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
 <diogo.ivo@siemens.com>, <jacob.e.keller@intel.com>, <horms@kernel.org>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix possible NULL
 pointer dereference for perout request
Message-ID: <20250325104801.632ff98d@kernel.org>
In-Reply-To: <20250321081313.37112-4-m-malladi@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
	<20250321081313.37112-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 13:43:13 +0530 Meghana Malladi wrote:
> Whenever there is a perout request from the user application,
> kernel receives req structure containing the configuration info
> for that req.

This doesn't really explain the condition under which the bug triggers.
Presumably when user request comes in req is never NULL?

> Add NULL pointer handling for perout request if
> that req struct points to NULL.
> 
> Fixes: e5b456a14215 ("net: ti: icss-iep: Add pwidth configuration for perout signal")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> 
> Changes from v1(v2-v1):
> - Collected RB tag from Simon Horman <horms@kernel.org>
> 
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index b4a34c57b7b4..aeebdc4c121e 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -498,6 +498,10 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
>  {
>  	int ret = 0;
>  
> +	/* Return error if the req is NULL */

code is trivial here, explain the 'why' not the 'what'
Why is this called with NULL?

> +	if (!req)
> +		return -EINVAL;
-- 
pw-bot: cr

