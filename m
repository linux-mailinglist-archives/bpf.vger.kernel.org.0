Return-Path: <bpf+bounces-39585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717D974B9F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 09:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B661C2463C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAB13F454;
	Wed, 11 Sep 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6+kTvrZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61A13D52B;
	Wed, 11 Sep 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040408; cv=none; b=e+trRcMlbnyuH8TJ1Lpx8Q4ky2c7BtM+fbay87hR1mSwDW4EFg4Ocsfe34xTx3tbY96yuq7QvwK3QITLmTKhEk+mLmC8jTMypMSsIJgJcokwUuxi61oGxls4IXo9WMRe4oPzoJIq2WVUQQsgddoTbN+8piH/oSlpqyz2KIyRQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040408; c=relaxed/simple;
	bh=z1b6pVa9eOEfyu40NGxDNSnXinjavrHxuv1qkW3GbrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am/tpuAGoDWhBmaghpBmWc0wHgg8e2PQaDDcT7im9kVeX+mahNGl5GkRMOokxknd1/6DAk1vdSmZjWw1Ds0V6oqtnzVxeeqH4ieW5amoD2g+ZvpUFenxuvmPkHMS8IUWRiyjfdJ4g6TQRXwQVov8yK+x1LR4Khh/blGaWMETLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6+kTvrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6CC4CEC5;
	Wed, 11 Sep 2024 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726040407;
	bh=z1b6pVa9eOEfyu40NGxDNSnXinjavrHxuv1qkW3GbrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6+kTvrZAyfVT0Fr/VAiUShNjAwuC9B2choCKXVSsuoob9cexbdlh1zGin9hSIGgi
	 RJITnbAq98KwaUHfqYkjvYJ/IvV7brxszWX5GqUvc/uelH8IE+R5n8TZR5AcYBz4Vs
	 QFi/0BuWRN3cIXEg25H72dAsPMV7gtH4FDrSmsDJQOBKuMOkAshrtje6TQYHfAxAgH
	 5phm+38PJSlayeVg0wE753BEf7Fu17FbuKl1V66jJFqd4WYGOlvybD+F0L9JoEFMo6
	 0LzQ9xXxME9frdBF7BKAE2oQSdNQ+V0Wo56IuP67NE+hSd/idmZM79HWQdk4nK6E5C
	 b7xoSQEci/xAg==
Date: Wed, 11 Sep 2024 08:40:01 +0100
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Joe Damato <jdamato@fastly.com>,
	srk@ti.com, vigneshr@ti.com, danishanwar@ti.com,
	pekka Varis <p-varis@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/6] net: ethernet: ti: cpsw_ale: add
 policer/classifier helpers and setup defaults
Message-ID: <20240911074001.GM572255@kernel.org>
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
 <20240910-am65-cpsw-multi-rx-v4-5-077fa6403043@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-5-077fa6403043@kernel.org>

On Tue, Sep 10, 2024 at 12:24:02PM +0300, Roger Quadros wrote:
> The Policer registers in the ALE register space are just shadow registers
> and use an index field in the policer table control register to read/write
> to the actual Polier registers.
> Add helper functions to Read and Write to Policer registers.
> 
> Also add a helper function to set the thread value to classifier/policer
> mapping. Any packet that first matches the classifier will be sent to the
> thread (flow) that is set in the classifier to thread mapping table.
> If not set then it goes to the default flow.
> 
> Default behaviour is to have 8 classifiers to map 8 DSCP/PCP
> priorities to N receive threads (flows). N depends on number of
> RX channels enabled for the port.
> As per the standard [1] User prioritie 1 (Background) and 2 (Spare) have
> lower priority than the user priority 0 (default). User priority 1 being
> of the lowest priority.
> 
> [1] IEEE802.1D-2004, IEEE Standard for Local and metropolitan area networks
> Table G-2 - Traffic type acronyms
> Table G-3 - Defining traffic types
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


