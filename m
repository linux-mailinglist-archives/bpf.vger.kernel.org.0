Return-Path: <bpf+bounces-20564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B516840497
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4D1C22593
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B315FDB4;
	Mon, 29 Jan 2024 12:06:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E05FB84;
	Mon, 29 Jan 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530007; cv=none; b=iRUJaQogulVEPkleX608q2ogFTBgdwSlqg1PkMFgB5n1Z7SFb3qHJiSduRpM0FkcXY/lpmgVLCjKdkiGyK3tWCJe04ueDPdUrzNnTID0SJtqLPWUF77t/1Ti/yFTAuFgWuXPuDXeg3L+I3T7GBUM2SrZgOuYoYSbJ9hMRgLAWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530007; c=relaxed/simple;
	bh=t6LkJ01vvW/rXZtVIG+IWUs51vMwwbSUr66QJREtVlo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MDJ392A1VuXuk5XE/IBD3bW40QSzqWgu5u0X5efemetTIEpo4ilGx2AvpYrCigcJ1458cx7d2YCA6TrrOtaU66fIRfFgeJxmuj41kNd5on+iIb8+CGOG/4B/IZ9Mch2woEdxSdZqZNiW2cPCaQFiQeYtJPfO+ObqfINkU+zynR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TNn702Bk4zXh0X;
	Mon, 29 Jan 2024 20:05:16 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 381FA1404F8;
	Mon, 29 Jan 2024 20:06:36 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 20:06:35 +0800
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available just
 for global pools
To: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>
CC: <lorenzo.bianconi@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<toke@redhat.com>, <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<sdf@google.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
Date: Mon, 29 Jan 2024 20:06:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> Move page_pool stats allocation in page_pool_create routine and get rid
> of it for percpu page_pools.

Is there any reason why we do not need those kind stats for per cpu
page_pool?

