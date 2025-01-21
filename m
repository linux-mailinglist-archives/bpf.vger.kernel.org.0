Return-Path: <bpf+bounces-49344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F2A17928
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B613161BE6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01091AFB36;
	Tue, 21 Jan 2025 08:15:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B0145A18;
	Tue, 21 Jan 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447336; cv=none; b=MgMDdDYM2Nlq4TAvBrqdTvmFAaxMBoHlWpqPPst13CRF3IJpUcdxtXp8t10lDEd90bw2Z/akqewWDIIW0Vpte+iqa1FOnQWrFWGrOtfay6H8mY3wLo1rPnPJcMvsZh3Yd7Nfkr8WdQHqDdnMeaFKrUeRcFjfN0tcNa+ZSgyGFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447336; c=relaxed/simple;
	bh=34+r50FKW+Y7y5ihMs4QnMEMyOdOvcu0KYugQViE/VU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlmXzA9cLB2Kp/Uv6OEq4k1H9OUktWhFVKwLT1Tk561bbhN9v3mU2fDPydPk+ckv8Vso9ZAKxYGL3z4G6VZkHDAlzx6/AN5WdPzkoPkTX2fUQTsSxx5AJirXSKa1xE99vGFW8ZaFxm9euZ5DU/U+dUQX2mO8B+DfqxgRZvIF96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ycg3X1793z1JHl8;
	Tue, 21 Jan 2025 16:14:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 63AA81A016C;
	Tue, 21 Jan 2025 16:15:31 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:15:31 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 16:15:29 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [RESEND] ipv4-bpf-Introduced-to-support-the-ULP-to-modify-soc.patch
Date: Tue, 21 Jan 2025 16:13:26 +0800
Message-ID: <20250121081326.3160003-1-zhangmingyi5@huawei.com>
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
 kwepemn200003.china.huawei.com (7.202.194.126)

Hi all,

I accidentally sent a wrong patch. Please ignore the previous patch.

I will resend the correct patch shortly.

Thanks,
ZhangMingyi

