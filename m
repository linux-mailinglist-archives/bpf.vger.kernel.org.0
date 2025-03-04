Return-Path: <bpf+bounces-53226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0CA4EB2E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99AB160DD9
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C7292FA9;
	Tue,  4 Mar 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2lGtyf1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024A20A5D9;
	Tue,  4 Mar 2025 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111239; cv=none; b=gLR6UaPIfbuBdsXeNGdn9lQ+8sK0+ufF83i1XywQGNo6OWG3F72s3rws2XnoCkJlbnwH3wiVATxjjtTGKjHEhqL+hgtIxdc+6aukEggUmawXZnyQrQCRwLQemthcU387IaCnaYBCNDjzirlTtdJWYdXtjhQGuPnAIKPzIpEghRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111239; c=relaxed/simple;
	bh=b845LDQJJPYS8ZbSf7oU05RhkWH9rVjK5sTMZbicoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9OKLcK/plXPN7GiXsbq/0Lq3RFU0i825ZyDB/1BqGtICn8Fu+K8XPbeC3f1FA0N/M3ETu/6Iv6lp1uJ7lxQ5oDW1ahbskWX+Hkp6KegGstHzEItY/WvZnlTMaqLvMwrlXMEq8WX4ShOAmgIzF9owlOkiqvFuzNhgy1gNdrPUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2lGtyf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC43C4CEE5;
	Tue,  4 Mar 2025 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111238;
	bh=b845LDQJJPYS8ZbSf7oU05RhkWH9rVjK5sTMZbicoSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2lGtyf1LyBSLq6GoLUfYKXWzi7CHV6OeHJPcQS82tS+dMs4muuaShnH87R6cypP8
	 BGFY0kwwE2VH7UMCOQx1YI+WFJqDRSTJ0RDF/xNH99e8zLn7DSz5SCwSzLXlWUkteB
	 +nuHQhtljYmuwGVzV9nD9N9Q+qAwTTP+RwFNametph/6tvQ7Vud4YbiytnTwUAyDLP
	 g9mEXVfx4iSg6TYCeMa26TlsMlVKEKLrNzCZmiIQiccUyaMaesNAli/zrkyIV5tVWN
	 ZVI7+oaEki0fNkJ2+/tXMpySbfGd/IRfwruB6PNJmmoJ3+xgtcMzVOjssotp4QbRXU
	 4O485yKHJF83A==
Date: Tue, 4 Mar 2025 08:00:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 2/5] sched_ext: Declare
 context-sensitive kfunc groups that can be used by different SCX operations
Message-ID: <Z8c_xWrk-kanKgOQ@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8IxQy9bvanaiFq6@slm.duckdns.org>
 <AM6PR03MB50802468907B621471E451DF99C92@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50802468907B621471E451DF99C92@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Mon, Mar 03, 2025 at 09:12:52PM +0000, Juntong Deng wrote:
> > Can you merge this into the next patch? I don't think separating this out
> > helps with reviewing.
> > 
> 
> Yes, I can merge them in the next version.
> 
> I am not sure, but it seems to me that the two patches are doing
> different things?

I don't know. It can be argued either way but it's more that the table added
by the first patch is not used in the first patch and the second patch is
difficult to review without referring to the table added in the first patch.
It can be either way but I don't see benefits of them being separate
patches.

Thanks.

-- 
tejun

