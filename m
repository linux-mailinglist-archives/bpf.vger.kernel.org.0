Return-Path: <bpf+bounces-20696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65118842186
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7128F8B8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD60657BC;
	Tue, 30 Jan 2024 10:38:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8160ED2;
	Tue, 30 Jan 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611095; cv=none; b=GklLSNDN4li+PL2eE3EN2skNvUCvTmtwJfzDSEPq4+8BKkmo+Fe9EUCYuQfL7PoyemyPQmn7QA+0O+7lGP8iCr7+F8hW8SO9rT5ykmdOeqz3bHwJQgoBhwx5bmpH0ZQ2yxvQS2ldZUV8npnx/GMB7h9kz5O+g3R+j71khOS7EoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611095; c=relaxed/simple;
	bh=OWfADM/4h1vMnw1LL7dvca8UKTseG6Hquky1rJKiekI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zuq+SSgsS4dhI5lXhUWtdtsMhoDOninXT/Nu8l08+Sbrr5tz7ZKkTG+sYhX+Psu+iZfo+VEMjTg5hE0ejJJcNvyuy2xv5umI35AQWz16VBCxS+I6AC09ucb1kHs85qvm2yHKj8T12peqpfi1GGSNZHuR9qd7V1qTslRfI7O1/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TPM6R5V0FzXgvy;
	Tue, 30 Jan 2024 18:36:47 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B569140136;
	Tue, 30 Jan 2024 18:38:09 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 18:38:08 +0800
Subject: Re: [PATCH net-next v3 0/5] remove page frag implementation in
 vhost_net
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
References: <20240123104250.9103-1-linyunsheng@huawei.com>
 <65eb8581-5cd8-8759-d598-c6711608b0c7@huawei.com>
 <20240129180846.28937389@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ee92b1d1-7520-b304-5aee-038b922720f2@huawei.com>
Date: Tue, 30 Jan 2024 18:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240129180846.28937389@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/30 10:08, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 20:40:37 +0800 Yunsheng Lin wrote:
>> Is this patchset supposed to go through vhost tree instead of net-next?
>> As the state is changed to 'Not applicable' in the netdevbpf patchwork,
>> according to maintainer-netdev.rst:
>>
>> Not applicable     patch is expected to be applied outside of the networking
>>                    subsystem
> 
> Sorry about the confusion, DaveM changed the way he uses the states
> since they were documented. There were concurrent changes to the gve
> driver, patches no longer apply. Could you rebase?

Sure.
Thanks for clarifying.

> .
> 

