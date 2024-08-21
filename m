Return-Path: <bpf+bounces-37767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D295A64E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0751285CB8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90307174EE4;
	Wed, 21 Aug 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8r9CJvk"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4F170826
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274210; cv=none; b=Vmnafti+/HTIR0WcCJ5ph9ra2dIlGWepNJtpd7q3lo1Es9gz2xsav3p8RounQTAhDGr3dv9A3CyVwVrfjzilBzA9OASCrBn8uezvXQERmFMZgW4/QKVgBXf2WClTGFfmF4x4KVvuIZNhnjxo/jAuet/pHKtod9h1VxdE3rDbImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274210; c=relaxed/simple;
	bh=cDiCTjyGyZe6FUSam0Z4JCrWJlpk3SZafhYt0vOYGWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNsDiu5pMF+PKe8iwey/cFCHeJKFHWs9YNNYN8SJGP5t+F1EUPFIHPAPo1ymXy/RSXapbJLdIsrezefIEudGojmv2Y3nJsc9bll4mMWI+862OC4r+HcnhmvBB8iUngaQH8szq8AXZlVGQhxmZqP8DznraLwOPVT4Zy44yOJkREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8r9CJvk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724274204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE5cPhg4MLsyr29aiCjr4pC6mToQl9x3/vD2EHyeviM=;
	b=o8r9CJvkVR0wt00ZhDkU/BBJJRa9InBPX1/l4AHbdachzNoGXhrD28SzAjoOX3wLsyyaub
	Y0JSnUH2RYXcn7FsC8/BTtc5B3aDkvCTq3psY3JlNlztgjAsgqqJ7hFWw3lYXmX/QKVxEn
	UutD4qJnaXdWkQf02/p/Y6QrNFQ9mw4=
Date: Wed, 21 Aug 2024 14:03:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
Content-Language: en-GB
To: Hao Ge <hao.ge@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240820023447.29002-1-hao.ge@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240820023447.29002-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 7:34 PM, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> Smatch reported the following warning:
>      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
>      warn: variable dereferenced before check 'buf' (see line 454)
>
> It seems correct,so let's modify it based on it's suggestion.
>
> Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> check in get_xlated_program()") fixed an issue in the test_verifier.c
> once,but it was reverted this time.
>
> Let's solve this issue with the minimal changes possible.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
> Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next] ...'
so CI can properly test it.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


