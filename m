Return-Path: <bpf+bounces-54826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754ADA735B9
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67DB17BE80
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B264190692;
	Thu, 27 Mar 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uFCS2CPz"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D8126BFA
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089640; cv=none; b=sOEacoSnUvLCo8UsjWdkohdftqAooFPpDh3FpF/mKyF9jzWg8oOfTMTklyaWtyePRuEM5if+iyGvy0wU6hiVfGzMdNuIK4E0YJbX3UML5ML4DvBFYooxz5nFcWhiQ8ntt1FEZky8Pj4EisACl+MG1ne8cSV0l8Se+YfpE2oKHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089640; c=relaxed/simple;
	bh=v1ZgflRpCBnl75VPslZ9XVEGVZXE4FbRiSpUnbfMRrY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WJiaeTJx6PMR62RWZ9yap6gPnRZuRADYVQ391Ato7HpRzxbeFRErT1rsmWVzDwKoWYQuxRKbwf45ykdHbzgnhbhgoX7rzbAAYSGLwes0ykqshrFPZBXQjgAoLF+EKnao1Sb4nYo2FgjjOjSe9ylXKCHJM2F1G5HoSEs8OKe3DS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uFCS2CPz; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743089636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1ZgflRpCBnl75VPslZ9XVEGVZXE4FbRiSpUnbfMRrY=;
	b=uFCS2CPzsAJaLcC41ZdJKupfLPH7Ugn6xRODrKHcEPS48wbLLc5RalnKknRGi4Y9tnFIxZ
	DdonS/ZV4HI1c1CHJ8ZKQcWJ9syA8pb6WW3gQqAM2frAgCKZuEMEjPiHbl9w5feBt979+l
	7ig+vmqD4pP5fO9MT/4CoR8Ly26mA3s=
Date: Thu, 27 Mar 2025 15:33:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <53ae1b2352f808bb57ffb461d506da4e75195154@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <97ab5e09-6240-4fd9-9411-19b689a21e37@oracle.com>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
 <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
 <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
 <e9c86b63-7715-4232-869e-8835eead9a8e@oracle.com>
 <70bf9434663f748563e5e464ac76bab669d0acf9@linux.dev>
 <97ab5e09-6240-4fd9-9411-19b689a21e37@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 3/27/25 1:22 AM, Alan Maguire wrote:
> On 26/03/2025 17:41, Ihor Solodrai wrote:
>> On 3/25/25 2:59 AM, Alan Maguire wrote:
>>>
>>> [...]
>>>
>>> Great; so let's do this to land the series. Could you either
>>>
>>> - check I merged your patches correctly in the above branch, and if t=
hey
>>> look good I'll merge them into next and I'll officially send the feat=
ure
>>> check patch; or if you'd prefer
>>> - send a v5 (perhaps including my feature check patch?)
>>>
>>> ...whichever approach is easiest for you.
>>
>> Hi Alan.
>>
>> I reviewed the diff between your branch:
>> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3Dne=
xt.attributes-v4
>>
>> and v1.29 + my patchset:
>> https://github.com/theihor/dwarves/tree/v4.kf-arena
>>
>> Not a lot of difference besides your patch.
>> Didn't spot any problems.
>>
>> I also ran a couple of tests on your branch:
>> * generate BTF with and without --btf_feature=3Dattributes
>> * run ./tests/tests on 6.14-rc3 vmlinux (just a build I had at hand)
>>
>> I think you can apply patches from next.attributes-v4 as is.
>>
>> Thank you.
>>
>
> will do; can I add your Acked-by to the feature check patch? Thanks!

I left an Acked-by here:
https://lore.kernel.org/dwarves/68a594e38c00ff3dd30d0a13fb1e1de71f19954c@=
linux.dev/

>
> Alan

