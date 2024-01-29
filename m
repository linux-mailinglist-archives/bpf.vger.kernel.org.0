Return-Path: <bpf+bounces-20569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E2840527
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433F21F21FF3
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF116612EC;
	Mon, 29 Jan 2024 12:40:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48612C1;
	Mon, 29 Jan 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532043; cv=none; b=NUBoAlASSjyRLkIx71dqKYgir1wRjyyXbmmTweBmGA+wNWRF8GKqP4+ezYIEO812Eit0WZmKa9C+uAT0z8L7pX6kkjwXP7MenBqMDriXpsik27DzdhwZUVSrmMQjPMgQtBmyaOphmsUqSUaVO8jetQ6x+4tRWX57JxWSetiTsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532043; c=relaxed/simple;
	bh=duqFhnpW+O9Svg2DLWfYfuFaahA/CjfaxQC70aaDb/A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K1gzm9QE/OfQFcQ7gBrvQZdvfgSCulmHlss/Tt2JuNMIGuDiVaMEC7E6jZqX7Inc9JKtd/Tzd8+rmNHxEoGRGivM3d4qSkZV70ExyhDOWuwyRzsCPiPWUvHkPq9uP3gA9EmEobx+tOwabOyEiLQhs1UYhwZ29ZExHAdd3+AUbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TNntg2JzYzNln8;
	Mon, 29 Jan 2024 20:39:39 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A1B6B1404F7;
	Mon, 29 Jan 2024 20:40:37 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 20:40:37 +0800
Subject: Re: [PATCH net-next v3 0/5] remove page frag implementation in
 vhost_net
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
References: <20240123104250.9103-1-linyunsheng@huawei.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <65eb8581-5cd8-8759-d598-c6711608b0c7@huawei.com>
Date: Mon, 29 Jan 2024 20:40:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240123104250.9103-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

+cc Micheal and Jason

On 2024/1/23 18:42, Yunsheng Lin wrote:

Hi, Micheal and Jason

Is this patchset supposed to go through vhost tree instead of net-next?
As the state is changed to 'Not applicable' in the netdevbpf patchwork,
according to maintainer-netdev.rst:

Not applicable     patch is expected to be applied outside of the networking
                   subsystem

> 

