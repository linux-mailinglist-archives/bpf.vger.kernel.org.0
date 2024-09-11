Return-Path: <bpf+bounces-39570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FB9748C9
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64031F26F1D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730141C72;
	Wed, 11 Sep 2024 03:43:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925CF4ED;
	Wed, 11 Sep 2024 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026204; cv=none; b=LNTkzMjvpCIHzp/VZ15yhKL/7h6EshZBQ1kkxTXvZn5y7LYCyMC4ODApL/WJrrlPM9DzVzsS4Uq4LNapVPW3PfJT+ui51s7hfraurDewJvPdQo71R7c1ZsBrhGLzrmAlt0UDnPl7EyFt1k21UhEqpUxXx+moMfVZt+mNcdWMrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026204; c=relaxed/simple;
	bh=Dhmw8cljojrSxEVT/dfTyxbQ1J59v28B3/R6QtUbBPQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jq346Q8XUDws3KoPkWpISq798QevL5JEo0eMN6s1pp3YalMIstLW1L7Q30EKxoj7uY5Nz4YjkJ6HJQdU+mBi3LIWmt3ANeWM0mm5TJOBLdAHhACZgYpBvrXVZ2Bb//yukNxq55bRdCDfQu1ULRBlKgEpq/la112nMOJf+gIgsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X3RHT43Mjz1xxBg;
	Wed, 11 Sep 2024 11:43:17 +0800 (CST)
Received: from dggpeml100003.china.huawei.com (unknown [7.185.36.120])
	by mail.maildlp.com (Postfix) with ESMTPS id D4B5F1401F0;
	Wed, 11 Sep 2024 11:43:18 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (7.185.36.43) by
 dggpeml100003.china.huawei.com (7.185.36.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:43:18 +0800
Received: from dggpemf500014.china.huawei.com ([7.185.36.43]) by
 dggpemf500014.china.huawei.com ([7.185.36.43]) with mapi id 15.02.1544.011;
 Wed, 11 Sep 2024 11:43:18 +0800
From: tianmuyang <tianmuyang@huawei.com>
To: "alan.maguire@oracle.com" <alan.maguire@oracle.com>
CC: "andrii@kernel.org" <andrii@kernel.org>, "arnaldo.melo@gmail.com"
	<arnaldo.melo@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, "ndesaulniers@google.com"
	<ndesaulniers@google.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "Yanan (Euler)" <yanan@huawei.com>, "Wuchangye
 (EulerOS)" <wuchangye@huawei.com>, Xiesongyang <xiesongyang@huawei.com>,
	"kongweibin (A)" <kongweibin2@huawei.com>, "zhangmingyi (C)"
	<zhangmingyi5@huawei.com>, "liwei (H)" <liwei883@huawei.com>
Subject: Adding new fields to xsk_tx_metadata
Thread-Topic: Adding new fields to xsk_tx_metadata
Thread-Index: AdsD8/EQxaT5qWe4SlST+ZFONp+nkw==
Date: Wed, 11 Sep 2024 03:43:18 +0000
Message-ID: <7835e88690ad424cbf644bf3cb0610b5@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgYWxsOg0KV2Ugd2FudCB0byBhZGQgc29tZSBmaWVsZHMgdG8geHNrX3R4X21ldGFkYXRhIHN1
Y2ggYXMgZ3NvX3R5cGUgJiBnc29fc2l6ZSwgaW4gb3JkZXIgdG8gdHJhbnNmZXIgY29udHJvbCBm
aWVsZHMgd2hlbiBoYW5kbGluZyBqdW1ibyBmcmFtZXMgcGFzc2luZyBiZXR3ZWVuIFZNcy4gTXkg
cXVlc3Rpb25zIGFyZToNCjEuIEhhcyB0aGUgY29tbXVuaXR5IGRpc2N1c3NlZCBhYm91dCBhZGRp
bmcgbmV3IGZpZWxkcyB0byB4c2tfdHhfbWV0YWRhdGGjvw0KMi4gSXMgaXQgYXBwcm9wcmlhdGUg
dG8gYWRkIHN1Y2ggZmllbGRzKGxpa2UgZ3NvX3R5cGUpIHRvIHhza190eF9tZXRhZGF0YaO/U2lu
Y2UgY3VycmVudCBmaWVsZHMgc2VlbSB0byBiZSBnZW5lcmFsbHkgaGFyZHdhcmUtcmVsYXRlZC4N
Cg0KVGhhbmtzo6ENCg==

