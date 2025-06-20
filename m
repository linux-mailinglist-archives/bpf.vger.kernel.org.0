Return-Path: <bpf+bounces-61152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE49AE123C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D715A3894
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEE223DC6;
	Fri, 20 Jun 2025 04:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6401201000;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392761; cv=none; b=WHF3w3wSsb78ykYsEekyNwHQUnIvxU73Me7w/5bf4KxC1ypyWCH4M8V2dX5iGRnIwUbDmRk97/Iuc4u6gWx0NJ3GilvMaR6VpN0/594F2NhcFGj9mRlxOhix/gXW309h3cqXgi5Tz5uqSifuixsy/Uj9QVPVDdTojQy1thNRlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392761; c=relaxed/simple;
	bh=P4c8k6L0wN8/ITkE+SaV2BDQ+0+ARLhDo47u7OpCUAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sptRhYw1qNM8J4YXJSuAp6eai5+iWIna6ymzIm1f0uj2MCcbv600BP/zm0wTGpX6Cs65R3peeXbV+ybEKsoRdg/fBRBuKpx/McNhaCwkWFAotkzAuum4aUT/dliGrVkBz+pWNVFVszdZwKgRtdVPX3JkT3fK71eKL6+puRNT5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a2-6854dfb37571
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v6 8/9] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Fri, 20 Jun 2025 13:12:23 +0900
Message-Id: <20250620041224.46646-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Y878Xl4HUNe7pANcrAyDQsThBh9OXNLkSLPhRdVr601Zw2
	a2l0sbmoJC2yQOeKmaROrcW6uKV2mcushMwuruvEcvWhC2nZ1KA2Q+rbj3PO7///cnisLGMm
	8nrjLslk1BrUrJzIP8dWzL4SXKNLfvhTBXZXPQt14Vyo7vYwYK+9juD74CsO+v33WKisGMBg
	f2Ql8MM1hKG3tYeDOvcKCFaFCDQdacDQc6KNhSLrMIbmwS8cWDw1Mui4XszA6aELGBryuzl4
	csPOwtv63wyEfEUE7tucBILFadDqiIeBh58Q+F0NMhg4fpaFkk4HC++sQQSdLT0Eyg8VI3Dd
	DDAwHI5klN99y6VNF1s+fcXiVecLmei1veFEh3u3eKUmUSwMdGLRXXuMFd19pzjx9fMmVmwr
	HSai19MvE4sKvrDit96XRPx68xkruq4+I2K7w8+tilsnX5ghGfRmyTRn0Wa5rvp4iMm+G5N7
	qf0Jzkf5fCGK4amQSn+4jrCjXPnxHY4yK8ykgcDgCKuEFNrfc48UIjmPhYss9de/4qKLccJa
	esvSKosyEWbQ3sY+phDxvEKYR5tbjH8zp9C6y7dHcmKE+fSbpXGkSxk5CZ+3MlFWCHH0ftl7
	ElVxpNd1Thkd44hacK0cR2up0MRTS1WY/M2cQO/UBMhJJNj+023/dNt/ugPhWqTUG82ZWr0h
	NUmXZ9TnJm3NynSjyMNU7f+13oP6OjQ+JPBIHavwfNfolIzWnJOX6UOUx2qVorJtpU6pyNDm
	7ZVMWZtMuw1Sjg9N4ol6vGLuwJ4MpbBNu0vaIUnZkml0K+NjJuajZR+2Wd2zEkIXD5njVaXZ
	q7oW/6RHx7Q50y+NZw7bq3UTHg87CioSg0ONmy1TOpfYun1pB1Te5ynujWematRSct7OroXv
	NzzVhB4c7T67Pf33Nc2iai2ZN3Zp/FRPyeRpweKM1XVZCwr8Cc3ksWr5mPQab6wh6aAzfUsy
	3WetGBunJjk6bUoiNuVo/wCWeEfqLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefeec3Y2WpyW1cGCYBGBpKlZPJSFEdGhyKIyoz7ksFNbu1ib
	DjWCeaFoqN2EbC6ZreumTVa6WXbBqWlFhVKYlo7ZTLpYTRtOo9qMqG8/nuf3/z9fHhpLp4hY
	WqnN5XVauVpGiQlx+uqS+FuDOxWJjR8osDjrKHBM5MM1n4cEi70JwXi4XwhjbY8osNWGMFie
	lxLw3TmJIdDhF4LDtQUGrw4T0HLCjcF/qpOC8tIpDPfCo0Io9lwXgPdiFwkvmipIqJy8gsFt
	9Amh546FgoG6XyQMt5YT0GW+QcBgRRp0WOdC6MknBG1OtwBCZRcpONdtpWCodBBBt9dPQHVR
	BQLn/V4SpiYiHdXtA8K0xZz30xfM3b7xWsA1m98KOasrj7t1PY4z9XZjzmU/SXGu4Fkh9+ZV
	C8V1Vk0RXLNnTMCVl4xS3LdAH8F9uf+S4mwjXwWc8/ZLYpt0jzh1P69WGnjdsrVZYsW1smHy
	cLso/+bTHmxERtqERDTLpLC2kSEcZYpZwvb2hqc5hklix/yPCBMS05ipp9i2un5hdDGb2cU+
	KO4QRJlgFrOBu0HShGhawqxg73m1fzoXso6Gh9M9ImYl+634LhVlaUSZuFRKRlnCzGK7Lrwj
	olEcueuskUbHOBItaazGp5HE/J9l/meZ/7OsCNtRjFJr0MiV6hUJepWiQKvMT8jO0bhQ5CWu
	HvtxxoPGeza2IoZGshkSz/gOhZSUG/QFmlbE0lgWI7F1piukkv3ygkJel7NPl6fm9a1oPk3I
	5kk2ZfJZUuagPJdX8fxhXvd3K6BFsUZ0eURqe5wTn3Fo0esNp/vrtb4UsWpelZ95WFizMrZ+
	KGM7HV6q7UmOT69VrdmnaciVi86sf98Q9GWIUpP65uxNMR073hBa53AvOLp5d+bMzM/2j+z5
	vJ++K0xLpScZJyY+syc/1TOaO4bRA8baYMKR5fXZgap0e9NWv2+Vvehku4zQK+RJcVinl/8G
	s8MlJA4DAAA=
X-CFilter-Loop: Reflected

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and APIs instead.

As part of the work, introduce a netmem API to convert a virtual address
to a head netmem allowing the code to use it rather than the existing
API, virt_to_head_page() for struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index d0a84557983d..d49ed49d250b 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -276,6 +276,13 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline netmem_ref virt_to_head_netmem(const void *x)
+{
+	netmem_ref netmem = virt_to_netmem(x);
+
+	return netmem_compound_head(netmem);
+}
+
 /**
  * __netmem_address - unsafely get pointer to the memory backing @netmem
  * @netmem: netmem reference to get the pointer for
-- 
2.17.1


