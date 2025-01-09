Return-Path: <bpf+bounces-48385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61491A0750F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA863A7AD6
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D5216E05;
	Thu,  9 Jan 2025 11:48:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C2215789;
	Thu,  9 Jan 2025 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423329; cv=none; b=sc4gTaVe4Lg8uBYPijU9Aw3hVZM1jJvuO/A7kQjE35cgEc7FwFu6xD3/nYRzBYUZT8RpJQI4kJdRbdHaal8r56eXO61XAEUvKYwWWQTqRbaSj+VeyReeRfcuDLjGJfdFc/4OyYgJJN7mX4MyHYadnu64N6W4Sbn34i8/XB1ZkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423329; c=relaxed/simple;
	bh=YCEJn8ABQi2ZGK3gViqw+VgqmIlvYqn1J34SpfSMKj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7UGRjjBdr6WvmV5WcNhPB4IbDLQ+DUquIEmqRmFlYQ0hVISdQIv8+HkhVDXy7boh1PPu5k6HqZtuwm0MJWoA89zLH0DoesZnBes4z0mj03dcncs2EhuoIzDkPwXP+LCSbl7ItOMv40bY/Dgz+wmLADm/NEh26mi9O+e/bT2MNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YTNJj4RTQz2DkMC;
	Thu,  9 Jan 2025 19:45:41 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 6066F1A0188;
	Thu,  9 Jan 2025 19:48:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Jan
 2025 19:48:43 +0800
From: Muyang Tian <tianmuyang@huawei.com>
To: <yuanchu@google.com>
CC: <Michael@michaellarabel.com>, <akpm@linux-foundation.org>,
	<bpf@vger.kernel.org>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liuxin350@huawei.com>, <liwei883@huawei.com>,
	<tianmuyang@huawei.com>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<yanan@huawei.com>, <yuzhao@google.com>, <zhangmingyi5@huawei.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: per-process heatmaps
Date: Thu, 9 Jan 2025 19:48:47 +0800
Message-ID: <20250109114847.539237-1-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJj2-QEtASHEfiYuoKrfx7n1UjDS1e+aF0LdYB5vhBUUS3cq8g@mail.gmail.com>
References: <CAJj2-QEtASHEfiYuoKrfx7n1UjDS1e+aF0LdYB5vhBUUS3cq8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500014.china.huawei.com (7.185.36.43)

Hi Yuanchu,

I'm working on observability and the programmable page generation policy of MGLRU based on eBPF, using a similar approach to yours. 
I'd like to know if there is any related work, such as the application of eBPF in MGLRU? 
Also, this RFC provides a user space interface to call run_aging(), which is called periodically in the demo. 
Do you plan to optimize this, perhaps by calling run_aging() based on page access observation results?

Thanks!


