Return-Path: <bpf+bounces-41169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E81993C4D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC241C222EC
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AB17578;
	Tue,  8 Oct 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfFRDcja"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F971388
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351389; cv=none; b=diaRLJxRUsmEtqgDD1CXaQ/PaH/+0WDcH8HyXzA4G2IVhkdoiEtyc40ldRs3WJsr9VGbUvl7Q1BjxIl4gJ0FUPSvLxz5GhBgnlsEMTvr2bbLPQPCdxerKBhyD8FRzuXLkzGVYLV4wT5BX+wqN7eS86F3r/RDKGiP9Pkdd0lbxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351389; c=relaxed/simple;
	bh=oJydzKPElYQB1w5RWKEMB3N08RMJuEPSvO04+qCcbBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBCDK1Bud/yngCkgLVOWkvR4uB3jAsxywewpLHCuhx1v257uYL6cPj7DH1SOi5bLu1kwkEZj+AkIO7hXmzfYgskNb5B2efhoWudn3y1pTQsdgo94UvDp97bT8cGcQAePjTb20eokXmfo8C2Y/kJH2R/U4PrQ+KQD01cy1dHGSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfFRDcja; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75bb08f0-45ab-4fa9-b343-82772e9af0f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728351384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btVF5zTAEiCokPrMKsEhRjMAfdYG4djhBtNnW2z85B8=;
	b=xfFRDcjauj9RDKc7xqFc9x/n/xeLQvV7i8wUuL53G9mrfsJPPOrz8p2VIguAlllHiWhzvV
	kEPiZWS57S48mNn+RpFdq0uJaCCdsimJNIfoCd7W357mWEg3AKLiGrI/1KUK12BP9dQY2A
	C+0ni7Krb5m+kwy+8N17fIU0lRFlTBo=
Date: Mon, 7 Oct 2024 18:36:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] tools: Sync if_link.h uapi tooling header
To: Stephen Hemminger <stephen@networkplumber.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, kuba@kernel.org, jrife@google.com,
 tangchen.1@bytedance.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-4-daniel@iogearbox.net>
 <20241005090254.061c1317@hermes.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241005090254.061c1317@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/5/24 9:02 AM, Stephen Hemminger wrote:
> On Fri,  4 Oct 2024 12:13:34 +0200
> Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
>> Sync if_link uapi header to the latest version as we need the refresher
>> in tooling for netkit device. Given it's been a while since the last sync
>> and the diff is fairly big, it has been done as its own commit.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> It would be good to have a script to do this automatically, similar
> to the 'make headers_install'. I use one for iproute and do it every kernel rc.

would be nice not having to sync the if_link.h uapi header. I think it
would be even better if it can directly use the headers installed by
'make headers_install'. There was an earlier attempt to use $(KHDR_INCLUDES),
may be some of the ideas can be reused. I think there is another parallel
effort to do this also: https://lore.kernel.org/bpf/CAEf4BzaWneXBv401rOdW8ijBTqRn_Ut4FFvhbsPShh5_pjV33A@mail.gmail.com/

This uapi header improvement will probably need a separate effort/followup.

