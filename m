Return-Path: <bpf+bounces-44384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D49C258F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378DCB22851
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA791C1F10;
	Fri,  8 Nov 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ED0EU0Mm"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175361A9B54
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094163; cv=none; b=T4+Qpa4Gqc3t/zA3qqrnrhrY4gVsrRWtFVyhGNDZeSMEekHz8QrXN46/BM9vAlc740Ns4rio0kke0vhm0vNTSQ+/mGBwR2YJc+C9RapvEoQnhhMIvBiHjVzdoPLGwU0a2PxpOaO+9xpBf09MBBAup+3JZnAMY7oFKFH5eoqcnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094163; c=relaxed/simple;
	bh=EtRuuaWJP2fFK7jgl2zOWZpe/+b0yhTJHKDU8kdNXNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsF4p5U0u1lgXXiNYOSDXIk4qVR3fCUIfkvedA4P5Abn9L5QMuRekQNrvAvfUdK9NujibyYtqodBuxeIzI014fPz4aAzJg1rwrqbdw4Qy8H21ZL2wE9YO5/oW9gIGw7NU1XTDuX/5HidXqPVwR16zS82n5qvDvHaQWO/rYpazGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ED0EU0Mm; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea4d87c5-ce13-43e3-8cec-b068055b0f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731094157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtRuuaWJP2fFK7jgl2zOWZpe/+b0yhTJHKDU8kdNXNU=;
	b=ED0EU0Mm2Ud6CX5BBMKugOxqt1lA76Z8CaFmKdfEm6nhmtixIbGkeZJpxZa12eyATXiUt3
	QLBMK7w/sRGpyDQ/R9dWH6kngRe144grQPdaLVsywNYDUdFm/372OGc85Fd3gM8X1hyu8h
	5bOO3joXWZaHISHUuLSOWDOwTkCP2cE=
Date: Fri, 8 Nov 2024 11:29:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Fix mismatched RCU unlock flavour in
 bpf_out_neigh_v6
Content-Language: en-GB
To: Jiawei Ye <jiawei.ye@foxmail.com>, martin.lau@linux.dev,
 daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 12:18 AM, Jiawei Ye wrote:
> In the bpf_out_neigh_v6 function, rcu_read_lock() is used to begin an RCU
> read-side critical section. However, when unlocking, one branch
> incorrectly uses a different RCU unlock flavour rcu_read_unlock_bh()
> instead of rcu_read_unlock(). This mismatch in RCU locking flavours can
> lead to unexpected behavior and potential concurrency issues.
>
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
>
> This patch corrects the mismatched unlock flavour by replacing the
> incorrect rcu_read_unlock_bh() with the appropriate rcu_read_unlock(),
> ensuring that the RCU critical section is properly exited. This change
> prevents potential synchronization issues and aligns with proper RCU
> usage patterns.
>
> Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


