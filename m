Return-Path: <bpf+bounces-19392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5882B8EA
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E315CB23A79
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155AEBD;
	Fri, 12 Jan 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW+sek4Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E5A3F;
	Fri, 12 Jan 2024 01:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B64C433C7;
	Fri, 12 Jan 2024 01:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021514;
	bh=CIAO/YraxlCzA9oiPS4MJulort5pdMfKnWHFRHA3/OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EW+sek4Yw3o/vknqQovQadAy5eixzlmSa/L5PmwOaKPidcWvPdfgTG44rLw63LcyB
	 rXWZqPYNB6k4SgqjzVtJRU3p6fQBSnqiLXjKSHhJ6cf0wgwsjqR5YNvh7AbRK93XO1
	 ZOkeMN1BNfcz1IUiAhJqmALKcAzcVYgM8XdP9rkRPkWGw0tSCCNkVB4Db585J7Vdkz
	 q/wJyQHU0zjmZcWssUxVYN/+afLHfBR2V+DRN02AlVJ1JF1ij617g5LnpiURXRdpCP
	 y4iMAfoZARowef1VEPMWhYDuAt8zZ7S7ROxETYO9qHkpXfXAamGanrOEdpHDevMGlR
	 8hsXH9CaS7ZFg==
Date: Thu, 11 Jan 2024 17:05:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, eadavis@qq.com, bpf@vger.kernel.org,
 borisp@nvidia.com
Subject: Re: [PATCH net 1/2] net: tls, fix WARNIING in __sk_msg_free
Message-ID: <20240111170513.7f8cd768@kernel.org>
In-Reply-To: <20240110220124.452746-2-john.fastabend@gmail.com>
References: <20240110220124.452746-1-john.fastabend@gmail.com>
	<20240110220124.452746-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 14:01:23 -0800 John Fastabend wrote:
> A splice with MSG_SPLICE_PAGES will cause tls code to use the
> tls_sw_sendmsg_splice path in the TLS sendmsg code to move the user
> provided pages from the msg into the msg_pl. This will loop over the
> msg until msg_pl is full, checked by sk_msg_full(msg_pl). The user
> can also set the MORE flag to hint stack to delay sending until receiving
> more pages and ideally a full buffer.
> 
> If the user adds more pages to the msg than can fit in the msg_pl
> scatterlist (MAX_MSG_FRAGS) we should ignore the MORE flag and send
> the buffer anyways.
> 
> What actually happens though is we abort the msg to msg_pl scatterlist
> setup and then because we forget to set 'full record' indicating we
> can no longer consume data without a send we fallthrough to the 'continue'
> path which will check if msg_data_left(msg) has more bytes to send and
> then attempts to fit them in the already full msg_pl. Then next
> iteration of sender doing send will encounter a full msg_pl and throw
> the warning in the syzbot report.
> 
> To fix simply check if we have a full_record in splice code path and
> if not send the msg regardless of MORE flag.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

