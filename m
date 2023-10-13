Return-Path: <bpf+bounces-12177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5371D7C8EE0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855E31C20FEE
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BE26294;
	Fri, 13 Oct 2023 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDpQgZwy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499924200;
	Fri, 13 Oct 2023 21:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB0FC433C9;
	Fri, 13 Oct 2023 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697231843;
	bh=cb+6M+VjMEh/7lfug1HEZP7KTDY5oSMrWSCNgMT7D/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mDpQgZwyNYaQ4ZKd1T5zGA3vB2Fs/4XuqGBZv8ZlEX8KpG7daXTKjPTyXzhDKXm+1
	 uUfD8Y1uuax3AAASiNEkXGwrI/N1WEIblc6mK1/fTW6LPEFlpaY4c2AxWnBEHHdkrM
	 4fFIoH7gCYQx1kICsvt8grWzgEgsxAzVYW6FEML0EZX+oqENb76z1nJVKUTCRkvQty
	 fQEnyXJ6jrrjYk8EbrWVdYmoPCvtkEcME4FEITIi02BOLt11QnCFdVTGQ2SF2Fdb1p
	 NmtvYja1NPEDkeLGqS/WC0bR3y75H4pTwinHBWhL488aYnXrYKPMVleEs7QSgw/nzZ
	 K1z1Bk860845g==
Date: Fri, 13 Oct 2023 14:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jhs@mojatatu.com,
 victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz,
 xiyou.wangcong@gmail.com
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
Message-ID: <20231013141722.21165ef3@kernel.org>
In-Reply-To: <20231009092655.22025-1-daniel@iogearbox.net>
References: <20231009092655.22025-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 11:26:54 +0200 Daniel Borkmann wrote:
> Currently, the kfree_skb_reason() in sch_handle_{ingress,egress}() can only
> express a basic SKB_DROP_REASON_TC_INGRESS or SKB_DROP_REASON_TC_EGRESS reason.
> 
> Victor kicked-off an initial proposal to make this more flexible by disambiguating
> verdict from return code by moving the verdict into struct tcf_result and
> letting tcf_classify() return a negative error. If hit, then two new drop
> reasons were added in the proposal, that is SKB_DROP_REASON_TC_INGRESS_ERROR
> as well as SKB_DROP_REASON_TC_EGRESS_ERROR. Further analysis of the actual
> error codes would have required to attach to tcf_classify via kprobe/kretprobe
> to more deeply debug skb and the returned error.

I guess Jamal said "this week" so he has two more days? :) 
While we wait:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

