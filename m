Return-Path: <bpf+bounces-74772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB3C65B53
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A93B349062
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91F30AD00;
	Mon, 17 Nov 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A2JRaXw/"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC4313525
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403963; cv=none; b=gsmiUc3bMXXBRPySf9AYx6Slp5AxL3gxIp9lC0xuENWGQQPwfj5/8RJubFJTKyXx3FFBNQpUdVdCI5awo5YaJbJMqkPPu02q+kxWv+HFKWd9MsgRa1vDR4b7VPub/Klj0wmFz6g8y4YIgDySQxCCzpP7H29R6er9k+0jm0mYRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403963; c=relaxed/simple;
	bh=No7YV6cP0aBYVvXRMfvUR+uUidTv6DvtAuqzct9dyr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIeIhvUXhBzg6kQ+UPT/Orive6bGRmOaqFRJssRpwofS2FiMmHs4yC67enoLujUc9V/DKH/lGs++4IV5Y+u34huEtey9jbeYdPpvaK2L+Zm+I7szsdVmVQed+w+NmKFVbo9GHNPwCA9RoF5hhjf3I7VHJg4t+3ESKpVKdubkDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A2JRaXw/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70c07fd8-ac13-48ec-8867-e8b0de017b17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763403949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=No7YV6cP0aBYVvXRMfvUR+uUidTv6DvtAuqzct9dyr8=;
	b=A2JRaXw/HDvgSSJQA+2qXt6rzHl7Z5Z3ha7CotM/a9YKOdK88ne8sqWM9Rn3ihULNxFvMI
	a0LVn6i2OYiHDZOzlZ6EztzCh91VHs5scbPJCWznFgK80CF0/r/mKepilxLuKrCW+RIXR9
	gw6Q4LGpuhyIgvdjNnM8KVHZLN7h/U4=
Date: Mon, 17 Nov 2025 10:25:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Always charge/uncharge memory when
 allocating/unlinking storage elements
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, memxor@gmail.com,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251114201329.3275875-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/14/25 12:13 PM, Amery Hung wrote:
> Since commit a96a44aba556 ("bpf: bpf_sk_storage: Fix invalid wait
> context lockdep report"), {charge,uncharge}_mem are always true when
> allocating a bpf_local_storage_elem or unlinking a bpf_local_storage_elem
> from local storage, so drop these arguments. No functional change.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


