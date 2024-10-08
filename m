Return-Path: <bpf+bounces-41170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DE993C55
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA0F2850F5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B5182C5;
	Tue,  8 Oct 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrcBEivz"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809C8488
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351637; cv=none; b=kTf/V/Y85PLE3N7LfL5ccsicnRSZ8BQWJOkHxXOv8pYCxQTXRowBdnkUwiy9Ert0kjdGa/Hq7b5lprqF1hqxWLWggPfNCNbgOzp686x5dZKubby/zi9BJ1ErV3okBIVvAktjVNsFJtIP4l/aKzhUFvqISlvwtYDXrqgTMDa+fKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351637; c=relaxed/simple;
	bh=B2GRuWWO+zkJJO3Yxi5A+sBodIFq92iiXD5DjhoPg0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPhI9/0DVPNqRNp4tZdvY0+7hZyqhCt5maYOwii/+kfoWoNnvtNn94beYQfeI2Pio8Ys2UYMBcEcGWmabEp+Xt36sd9AGSsg67FCS+gHweOs16wGVbOUy4ifLxAJGFhdU/fF9k8tQ4YoCg1BONEXduE5vLzGVZyoQ/lzWMHvWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrcBEivz; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72385fe9-e34d-4642-a62c-61083395c722@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728351633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2GRuWWO+zkJJO3Yxi5A+sBodIFq92iiXD5DjhoPg0Y=;
	b=vrcBEivz48gYUo8grTfiwdmnEIj4OAJH25XMI34C1Gq//D6JeUSyNKG2+tZCuZBUeILEcN
	yICNHYS7FZ7ITDq7IWb1dqVqV68FnGVhQCePuIWm66Gu62OZTZuhz3tbWrzvgYOqeeRqvq
	PUiZ9OhCiIhUze1rcGPmNnDsizW4GeU=
Date: Mon, 7 Oct 2024 18:40:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Extend netkit tests to
 validate skb meta data
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, kuba@kernel.org, jrife@google.com,
 tangchen.1@bytedance.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-5-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241004101335.117711-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/4/24 3:13 AM, Daniel Borkmann wrote:
> +void serial_test_tc_netkit_scrub_type(int scrub)

nit. This can be static. Others lgtm. I can adjust before landing.

