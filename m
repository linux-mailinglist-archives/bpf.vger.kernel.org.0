Return-Path: <bpf+bounces-36755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F326094C8A0
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 04:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7083FB221AD
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A617BA9;
	Fri,  9 Aug 2024 02:48:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D92900;
	Fri,  9 Aug 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171702; cv=none; b=GgYWrhb0Dn3ZMRMtqrACv5xpV1f0y+ZWAtwBQSp3rjtpuFGjvTXIQXjGg5LptWmCpqdzGGv5W1+SJTE+7sxX3Hi6oYSTEINmpj4Hw/U0DVGsma2b1oPTwaJzbIne//iCETLpfK/ACTMZHYSMrDaord4/cpd3flbPSRXXyvZrsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171702; c=relaxed/simple;
	bh=7kL3bXMy4lP6ke6ji+vjX0pR4cLJ5IGIznm33pg4pqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n96mSflZ3Bxti0P6eNl8oPT+/D7bo1cJ24+3Kq5fpaCBKPuWbNhPqSuKoYnNZuLDpqqwIM5UORfMdlVyZT4NCmFPyv+gJAoiLHdbpD9xBvUeZ3Cti7q3fUN2pA/Xwml0G56g3v25sWyM6XBQJzfaLsT4sK58WyAq98FWJuMyRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wg7bp4flszpT38;
	Fri,  9 Aug 2024 10:47:02 +0800 (CST)
Received: from dggpeml100010.china.huawei.com (unknown [7.185.36.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CC8F1800A4;
	Fri,  9 Aug 2024 10:48:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml100010.china.huawei.com
 (7.185.36.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 10:48:14 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <alan.maguire@oracle.com>
CC: <andrii@kernel.org>, <arnaldo.melo@gmail.com>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <dwarves@vger.kernel.org>,
	<kernel-team@fb.com>, <liuxin350@huawei.com>, <ndesaulniers@google.com>,
	<yonghong.song@linux.dev>, <yanan@huawei.com>, <wuchangye@huawei.com>,
	<xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>, <tianmuyang@huawei.com>
Subject: Is there any current plan for ipvlan to support AF_XDP?
Date: Fri, 9 Aug 2024 10:46:26 +0800
Message-ID: <20240809024627.2193378-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100010.china.huawei.com (7.185.36.14)

Hi, all:
we want to use the AF_XDP capability in ipvlan driver. However, the current
mainline does not support use AF_XDP in ipvlan. Has the community discussed
the use of AF_XDP in ipvlan? 

I can't seem to find any discussion on the mailing list.

Thanks!

