Return-Path: <bpf+bounces-60235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D5AD43AC
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3457AB13B
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15226562D;
	Tue, 10 Jun 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ3MCAqm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E59261390;
	Tue, 10 Jun 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587088; cv=none; b=qcItDPq/PUChjdGwHFs4P1lcbnxfvOlm8sHMg2gvr7xLTqz4NcL8fvz7JSzDF6BviUbsp9HtLvXNkZd00wXEIiggLXhR+dwZdF4PCyOE3TpyH9ZHxVSyjdld00PBUWzEDiq0CiY8nlG5bVBC7Ir0B9UnN52baSs/Ar5rRfppYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587088; c=relaxed/simple;
	bh=sw3ZqSgKQCKhT56XlMQWwMH1gu9MA58LgMyebrIfZr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qnJ5Le6vVmip5PSLkj69F6v4Q+aK0inRY2dqmV8Fm8EJiJRK3w88KKKrL742PysmhQr2+U9soRpzfEdgi3qbVko9MlY2rmxwZ+p/WDtUJNKi2X7bTYdZFLfvG6M5EquCATbtJfsZd62ZgcdY1OLmhQYJgKAtfnF3cJdU9jKciRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ3MCAqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22ECC4CEED;
	Tue, 10 Jun 2025 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749587088;
	bh=sw3ZqSgKQCKhT56XlMQWwMH1gu9MA58LgMyebrIfZr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sQ3MCAqmWOjqbGB6Z58dW3G4WVfCNy+VwBfhjPAX6hlnYyJ2OGX6NKlkLJJ5jPGli
	 lEgpHJcbKmj6Ra+4GQvRw4zQqPpwx0uHPAO2RPz88GgqclHv0OrDh+pH5l3cteVogt
	 1rDxMcK2hn9tsgAQHI8CYB3L/VUNiXAdd3C8JtIDgd6om7Dul7bQit6vEzVVhsd8QD
	 +NpiffQep9vDP+KmNDCpk9FBxIPdE5g0WJRDrDUcD8nppEWDkpGasFPprTTsFtIzV2
	 jSG3OpTcCxA/j9WXIIrzW8Pf6lL7XEiV1IYl7tN9/RRQxvqgCQvXxQUMPqCMmQxHyl
	 LS3qNtt3w7M/A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 873691AF6B6D; Tue, 10 Jun 2025 22:24:34 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, aoluo@google.com, jolsa@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
In-Reply-To: <CALkFLLJpz2MxRZ8r+mGayU_BZE=2=ukXTzXcnmyhXeHB7Q6v3g@mail.gmail.com>
References: <20250609173851.778-1-ujwal.kundur@gmail.com>
 <05305f84-37ff-4345-803a-85c2025dd67b@intel.com>
 <CALkFLLJpz2MxRZ8r+mGayU_BZE=2=ukXTzXcnmyhXeHB7Q6v3g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 22:24:34 +0200
Message-ID: <87msafcpkt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ujwal Kundur <ujwal.kundur@gmail.com> writes:

>> This looks wrong...
>> I think this will always return index 0
>
>> So passing dev->_rx to that function will always return 0; which is what
>> the field is already initialised to...
>
> I didn't realize that would always return 0, sorry I should've tried
> to understand that statement better.
>
>> I'll just add that you may want to take a look at Lorenzo's series[0].
>> Rx queue index is sorta HW hint, so it shouldn't be a problem to add the
>> corresponding field to xdp_rx_meta.
>> Then, you can expand cpumap's code to try reading that HW meta if present.
>
> Thank you! I also tried to work backwards to figure out how the
> queue_index would be used if present in xdp_rxq_info but that wasn't
> immediately apparent to me.
> I'm keen on learning/contributing to the BPF part of the network stack
> and this seemed like a good first patch to take up -- I'll understand
> this better and try again.

Sounds good! Don't be discouraged by having to try again, that's
perfectly normal :)

-Toke

