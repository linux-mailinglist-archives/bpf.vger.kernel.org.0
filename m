Return-Path: <bpf+bounces-65068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64561B1B7C9
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45013B9525
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB20289814;
	Tue,  5 Aug 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgI9ANK2"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D9278E77
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408950; cv=none; b=nXrXHNt3NuDyuIckI6/X+VPWcIIHakTnpXOrCmbgElN+Tv8j1WhYzUaGymebI9LZcybOnF/YxBAuJRMFYLACNQqR/uotzYHzxSp2K6OW4m/KXuSFh6GIhWaVog8ffYSxtI5i7xw/0rs7iavV5hQl6V+Eg8J7bzvehWEgtDAWke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408950; c=relaxed/simple;
	bh=X2dfIZZ5Mq2RqlPfGxGJ4bSfulRv0axO5u2AT+yBECE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuXaGTjbCRmcwOddqjfH4TmqMwDTKzq0RAQKpCFbqV36c6V4cHtW6cDFHo53iXI7XIiUdD7hOhcLvQ+qyo5vI/yY9TDhQvnJJgk/14ksz/otd6ooydynR+AOb1XKcdZuseB33Qs65LZ+7WpR/ILb+2EjjtvWBLbHleWgdXgre/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgI9ANK2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4348a5c5-8689-49a8-b59f-bf4ab2bbc74b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2dfIZZ5Mq2RqlPfGxGJ4bSfulRv0axO5u2AT+yBECE=;
	b=AgI9ANK2dvdpxoFYlMskbC/MdROFC6Z8+fUVSU/pLKWFrXrBrM0kSG+OU3rc7IKb1YTI+4
	kZ9tuoe5njMBhmW4xumfuFoTCtt3ry2E4nektzKuP6rPaagoLAjQ2DwNMJq2WPWRhFTUaZ
	TnjE6NP0M8gqHz/7ysKBAepmQ6Rr5B4=
Date: Tue, 5 Aug 2025 08:48:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250805122312.1890951-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250805122312.1890951-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/5/25 5:23 AM, Tao Chen wrote:
> bpf program should run under migration disabled, kprobe_multi_link_prog_run
> called the way from graph tracer, which disables preemption in
> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
> need to use migrate_disable. As a result, some overhead maybe will be
> reduced.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


