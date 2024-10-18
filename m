Return-Path: <bpf+bounces-42386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F89A396A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA86D1C243F9
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780A190063;
	Fri, 18 Oct 2024 09:07:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478E14389F;
	Fri, 18 Oct 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242448; cv=none; b=gu4LC+cXPELLdnPLUtoBaLRiJEIf/CPLkZdsbJYY1uHUw/1Z4JPuHH09EUKCX0W2H+ws333uJfHUz+eXnHX5HLC5b4Sqhdqgp9pvHxxkNs5lGTqDNj8molWe55KP2nOOzjb0FQXjeMh5D3VTAL/5l2xG8tS6OSdxo7YW8YuGbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242448; c=relaxed/simple;
	bh=FAYd/zy4QBjUCu/IX5gY7yxL5WuYCsLEvS6F703sMSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbRFoMIBdNAKzJvFGGDN5qCHk0gle4e8/LP3TNvRL/6RZHlW6hKwUgR1SJDqehe3juRAG8oqqDMei44AgUr/ewylBA82E3T84r4AUNRQSSEDIhR1ES8r7QHyMrpVfhmtfwrkvkNtEA0ZQq3zeoUxSuno/wDN24+4oCNyfpxPhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XVJh803T5z1T8sP;
	Fri, 18 Oct 2024 17:05:28 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 091ED18009B;
	Fri, 18 Oct 2024 17:07:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 17:07:21 +0800
From: Muyang Tian <tianmuyang@huawei.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
	<donald.hunter@gmail.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yanan@huawei.com>, <xiesongyang@huawei.com>, <wuchangye@huawei.com>,
	<liuxin350@huawei.com>, <zhangmingyi5@huawei.com>, <liwei883@huawei.com>,
	<tianmuyang@huawei.com>
Subject: Re: [PATCH 1/3] xdp: Add Rx checksum hint
Date: Fri, 18 Oct 2024 17:07:57 +0800
Message-ID: <20241018090757.411456-1-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ff067123-f516-4e86-bdeb-c7fcb5cef796@intel.com>
References: <ff067123-f516-4e86-bdeb-c7fcb5cef796@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500014.china.huawei.com (7.185.36.43)

On Thu, 17 Oct 2024 16:27:50 +0200, Alexander Lobakin wrote:
> From: Muyang Tian <tianmuyang@huawei.com>
> Date: Thu, 17 Oct 2024 21:54:28 +0800
> 
> > This is an implementation of functionality that allows drivers to 
> > expose checksum information to XDP.
> > This information includes:
> > - Checksum info, a union of
> >   - complete checksum, if checksum is complete
> >   - skb-style checksum start and offset, if checksum is partial
> > - Checksum status, an enum which is the same as skb checksums in
> >   skbuff.h, identical to sk_buff.ip_summed
> > 
> > Signed-off-by: Muyang Tian <tianmuyang@huawei.com>
> 
> Is it just me or this is clearly based on [0] sent a year ago?
> Credits then?

Hi Olek, I have made some discussions with the community days ago[0][1], thus the previous discussion[2] is to be revived with this patchset. I will update the patchset with correct reference.
Thanks!

[0] https://lore.kernel.org/all/ZuGrpG6N_OINizBm@mini-arch/ 
[1] https://lore.kernel.org/all/Zw1eZQJG3EMz5ADv@mini-arch/
[2] https://lore.kernel.org/bpf/20230811161509.19722-13-larysa.zaremba@intel.com/


