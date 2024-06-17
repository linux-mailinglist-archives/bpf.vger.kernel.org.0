Return-Path: <bpf+bounces-32265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DE90A260
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 04:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C72282C00
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 02:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183B176AAA;
	Mon, 17 Jun 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLErqF/0"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38229D19
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590485; cv=none; b=cxA8zfHV+zacyVzkzk06QyUlGfqn/KVEwxalFQwCW7bMV7vh+YBS6EkPXx9sZkLscbkY3ab3lISsqIfq47iXURN17DEPIfIGO2LeI8hxBnR6vy19MjqHoms8bmuWOPGXOjqGTgJbyzoR/qCq7MpdeDF4TDpNbNks2becuCOFnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590485; c=relaxed/simple;
	bh=J5mRnvJiNtBlliSkOWrPR8JFC+hIqU/sZM18fpHQ9iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CXA6nL9evJwsUdzYaQMyz1BWU50DdopdWj2KfE/ORafOjOD3Ndj1zeEg6nhRSrh3xPvQCYEsvDMhLKcRKsQrz6ScebPaZ5oFlGy9Yi0lcbEY91z9vGMexdXYo4AwqEy0pX9FnXydOscnuGt9D7KRx6W0a9+Rxc8tWWItwuk1PTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLErqF/0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alice@ayaya.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718590480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+U7MMs/Grp4fxnA09iO+Fj8dmaszRqGKTqsSM9PL5Y=;
	b=lLErqF/02G6P8FMJ7y7Mo87A+ngP6KTjR4hJjTxQvQkBc1p/MmN9FyGU1j4P5cUsh4tXXG
	YFzjv9BUYbiQiQpmtdlzMiQGSxv7ajavcQipc8198Z2+n/UkYVCsgc9W2U81Xcm9ui1trS
	AUS14aq7I2YzX+G9Pojft1l2o7wcXnA=
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <363d0b06-1249-4e8d-8ed0-8debac0eacaa@linux.dev>
Date: Sun, 16 Jun 2024 19:14:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: fix signed multiplication overflow in
 hash_combine
Content-Language: en-GB
To: psykose <alice@ayaya.dev>, bpf@vger.kernel.org
References: <D21SEVE6F615.2LMUOCTGW8AI7@ayaya.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <D21SEVE6F615.2LMUOCTGW8AI7@ayaya.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/16/24 3:11 PM, psykose wrote:
> when using -fsanitize=undefined (which flags signed overflow which is
> UB), a crash can be reproduced when building the linux kernel with BTF
> info.
>
> cast to unsigned first to make the overflow not invoke UB semantics- the
> result is the same.
>
> Signed-off-by: psykose <alice@ayaya.dev>

This seems against upstream libbpf repo. Could you do a proper patch
against bpf-next tree. Please have details how to reproduce the failure.

Please use proper name in your Signed-off-by.

> ---
>   src/btf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/btf.c b/src/btf.c
> index 2d0840e..60cd412 100644
> --- a/src/btf.c
> +++ b/src/btf.c
> @@ -3317,7 +3317,7 @@ struct btf_dedup {
>   
>   static long hash_combine(long h, long value)
>   {
> -	return h * 31 + value;
> +	return (long)((unsigned long)h * 31 + (unsigned long)value);
>   }
>   
>   #define for_each_dedup_cand(d, node, hash) \
>
> base-commit: 42065ea6627ff6e1ab4c65e51042a70fbf30ff7c

