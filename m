Return-Path: <bpf+bounces-36893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC794EE85
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E7B22317
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4117C7B9;
	Mon, 12 Aug 2024 13:43:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E3170A0D;
	Mon, 12 Aug 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470215; cv=none; b=Xg/s+dFT9z0N7WXS6Q94610clc1a5QCHow6doOSEu8ihH8bLwlz11fWBoA92CmayFEJUhi+Ue/YzoZ4Y88IGVVyjxPF1pfVMiYjb2pIolgY9Ct4cIQU9vLhfAEad52Zxo1L9nFqrg7EcZuSazdquo9pUNsUYgLQ2IovF7yZfbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470215; c=relaxed/simple;
	bh=hHdJ32wcgjqyWDiC/xKhBmeRH9HEEHOXkYfi5JdtBSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aURFtNiaZaUha36tbBKhGIyh+AHtZD4CliUX1R5Gx7++Zyw/NZaCE1oai7fUytuWDRuK2VbW8li3eWCfltCV/gbzsrpJ0EGOarB0qZmMIlIU7eZuHRneE0ZaBilqXWa8zKeNE2xo9oC5rVLm4DCxbrgb3M7LtU5RbSepY/CVCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjFwZ4PlLz20lVl;
	Mon, 12 Aug 2024 21:38:54 +0800 (CST)
Received: from dggpeml100010.china.huawei.com (unknown [7.185.36.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 81C3114035E;
	Mon, 12 Aug 2024 21:43:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml100010.china.huawei.com
 (7.185.36.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 21:43:25 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <alan.maguire@oracle.com>
CC: <andrii@kernel.org>, <arnaldo.melo@gmail.com>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <dwarves@vger.kernel.org>,
	<kernel-team@fb.com>, <liuxin350@huawei.com>, <ndesaulniers@google.com>,
	<yonghong.song@linux.dev>, <yanan@huawei.com>, <wuchangye@huawei.com>,
	<xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>, <tianmuyang@huawei.com>
Subject: Re: Is there any current plan for ipvlan to support AF_XDP?
Date: Mon, 12 Aug 2024 21:41:39 +0800
Message-ID: <20240812134139.2203440-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ZrYp7CHx44-6hPN7@mini-arch>
References: <ZrYp7CHx44-6hPN7@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100010.china.huawei.com (7.185.36.14)

On Fri, 9 Aug 2024 07:38:36, Stanislav Fomichev wrote:
> On 08/09, Xin Liu wrote:
> > Hi, all:
> > we want to use the AF_XDP capability in ipvlan driver. However, the current
> > mainline does not support use AF_XDP in ipvlan. Has the community discussed
> > the use of AF_XDP in ipvlan? 
> > 
> > I can't seem to find any discussion on the mailing list.
> > 
> > Thanks!
> 
> I don't think it has been discussed. Probably because there is no
> straightforward way to make zerocopy work. Copy mode should probably
> work already?

Thank you very much. We are considering adding some driver code to support the
use of AF_XDP on ipvlan in the near future.

