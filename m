Return-Path: <bpf+bounces-69829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2EBA35E0
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F343E1C04BBE
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC62F5A06;
	Fri, 26 Sep 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQSi0bcu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B32F5485;
	Fri, 26 Sep 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882800; cv=none; b=lJYalRfcadFlvm8iRSrifnQB8FTkxYpVnWl1uEgwwqJN0jVSJ8zSuj3gCZV9Ui7haBnr95toywmkZqo/VbphfFmdWqeE/0vzXiRM+uDH9rcqcpN4765tvq1gpHWU4hwG/HTLxwOapDrRmAGjzzEIoEmWV/gzHYb4VDTE+dusmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882800; c=relaxed/simple;
	bh=cpWqUiz/PYRwWb19Ebd0lG6MyrzBJ6qf+7hqubH3DYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S40t3kbG+kzTi0+VXAjF45j4UZtZjKBgjLtFyE4AQx72KnA6lG0DfEBEvJ8Sc9RIj7po0KLwZ24ZomUa0xJLwQqpyyMWQrN3/8YWaRxKMggKMTfMYxedAftGjwTgeLlY2t3oEEetjBKjHQ40ujxdnvkF6vKpjNmOV7fdst9nlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQSi0bcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7591AC4CEF5;
	Fri, 26 Sep 2025 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882800;
	bh=cpWqUiz/PYRwWb19Ebd0lG6MyrzBJ6qf+7hqubH3DYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cQSi0bcu3EB6yspccig2jcTj/lrvv3ww1Tzk03BFuqlbc4gvA3gqok/lhPEQvm1Me
	 e9uLPpttQpjmqKCin6ZtpBvmaul535bJqJpLffm5mgoMejTrsVoP2A6JwnVPlU3iYd
	 ryO8ftBOzPqDj5RrVoqhTBtSuR5LjOlWCdULkIm65nDx9/KkVYXN+M98Ce+pGl/dAJ
	 4kHBaKM9r2gNCHIpwssJv9VE8ZWyGrnLYwkBiJKrAa2ym5c1qLipumF47HhXKZhYf6
	 Tc4fBEGEbZyu8cO4Gl4HKDK5ZYkQUjHCM95bIVeHCmjvHBAB4XSk6twGJtQX/VXbpf
	 qaIDPyYu82Fdw==
Message-ID: <a26cb4bf-71d6-4970-8ac2-fd3bc4f0ba33@kernel.org>
Date: Fri, 26 Sep 2025 11:33:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/2] bpf: Remove duplicate crypto/sha2.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-26 17:52 UTC+0800 ~ Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ./include/linux/bpf.h: crypto/sha2.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25501
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

