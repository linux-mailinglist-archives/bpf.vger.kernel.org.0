Return-Path: <bpf+bounces-47823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A6A0030D
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 04:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7161883F32
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903D158870;
	Fri,  3 Jan 2025 03:15:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422581527AC;
	Fri,  3 Jan 2025 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874132; cv=none; b=I7VPnawjLyP0hQbFKeGY0J4m9SoxhmgaShI9b1c7zyq9Uu79iC+5WMC+HLGqMGToSCcij1YvL5SRdQfMpTRi6qNbe2APDxv84P1Wgr+zW99n+gZupWzZMeY6cJe9s8+YdSq0tn2tsFlo04FCBDwAFGV+05u2WdO/92+DreC2cyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874132; c=relaxed/simple;
	bh=KHEj/W7gal/yFwrzZbGOxTbFwGyaELEmLbpwSLkGNV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdo//pwaaestBV+482ufZ5rp6q8eYZmkR3ASmm1g7dWANndSaS2GiS2GKCQtBw7cD2u1muvgzT99T5UcGuiAeHmdRkWTfOeqsrjnF66NZ3RTk65vDFruyv2pciHG6VU1FeDBkAxZrbEJ6uiMbXgTOerkt7ZbOyp/Caoar84k9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YPTCD4C1gz1kxZL;
	Fri,  3 Jan 2025 11:12:24 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 12C62180042;
	Fri,  3 Jan 2025 11:15:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Jan
 2025 11:15:18 +0800
From: Muyang Tian <tianmuyang@huawei.com>
To: <yuanchu@google.com>
CC: <Michael@MichaelLarabel.com>, <akpm@linux-foundation.org>,
	<bpf@vger.kernel.org>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <yuzhao@google.com>, <yanan@huawei.com>,
	<xiesongyang@huawei.com>, <wuchangye@huawei.com>, <liuxin350@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: per-process heatmaps
Date: Fri, 3 Jan 2025 11:15:26 +0800
Message-ID: <20250103031526.529434-1-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220911083418.2818369-1-yuanchu@google.com>
References: <20220911083418.2818369-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500014.china.huawei.com (7.185.36.43)

Hi all,
It has been a long time since this patchset[0] submitted, and I've been doing something similar recently.
I wonder why this patchset remains unmerged/uncommented? Is there any other similar work?

Thanks!

[0] https://lore.kernel.org/all/20220911083418.2818369-1-yuanchu@google.com/


