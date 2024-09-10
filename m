Return-Path: <bpf+bounces-39473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98E973B62
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6252628312D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3A19EEA6;
	Tue, 10 Sep 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MT8weMhT"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4E19E80F
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981527; cv=none; b=JPd9F/uWwA3Ro5Pw2eEkpBlBa0zXaVJSFRrtF4K9wOUie0uNBSlbOybxYPsFcD1vwgaaFTTVOA93IQ8reCZtkbsAhiey+oaCb0egF339ZjYEmti1LxSjaQS6Jiejdd1kncMPqndhU6um/sl0oJGCoOgjBVUrE3MVFFujqQ0E9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981527; c=relaxed/simple;
	bh=1ZHmz5tAPwT7ChCsujP+PfDX84n2wxfAT+nKWuLNoNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd8DVw35iolM+HmN4E0xG8bdKCQEJnYTFPh5seOjDnn+uQ5lvqwy+2W1Bbg6DtCb+e8kQAaOk6nSUNxrgoXTfnt9BkcIDOSKpNRdFd0G6uP6W4quRKCC4Acl3ujsuCoWCHeOoiKomjLEM3E17XO+I8t52o98LREo1XFYAyEwlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MT8weMhT; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff27a7ba-e3b3-4cd9-85a8-55c10756df5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725981522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eghQv2fgMn8zup51cmGB1QrSDKSaS9pXVEAuhgUpeWw=;
	b=MT8weMhTYqIZj0sq7lPXPNX0kqqPyCa7eID84eHRQVTkRX7K049qrcuCvz7v2LP2XmiNwa
	88mPY6a9ZQg9NZgccpm/4vFsa5WBZePWvgWRzbDQuLLDdmIdPJBjyrJpLR9Ra1t9GttDtj
	IUcGnfhM5/nPyVcecDPUlc/17jMLoes=
Date: Tue, 10 Sep 2024 08:18:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>,
 'Zac Ecob' <zacecob@protonmail.com>, 'Daniel Borkmann' <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
 <18d101db038f$f3c2d400$db487c00$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <18d101db038f$f3c2d400$db487c00$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/10/24 7:44 AM, Dave Thaler wrote:
> Yonghong Song wrote:
> [...]
>> In verifier, we have
>>     /* [R,W]x div 0 -> 0 */
>>     /* [R,W]x mod 0 -> [R,W]x */
>>
>> What the value for
>>     Rx_a sdiv Rx_b -> ?
>> where Rx_a = INT64_MIN and Rx_b = -1?
>>
>> Should we just do
>>     INT64_MIN sdiv -1 -> -1
>> or some other values?
> What happens for BPF_NEG INT64_MIN?

Right. This is equivalent to INT64_MIN/-1. Indeed, we need check and protect for this case as well.


