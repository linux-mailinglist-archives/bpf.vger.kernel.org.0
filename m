Return-Path: <bpf+bounces-61485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C4AE75E7
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08277A50F2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE081E25EB;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584A1C84AB;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826046; cv=none; b=S0B/qTF18i+O5s8sXtNl8TN0o0s55NG4d4hRdoUxCUGJdvkD2et/cO/iCUAObVT/wEwC4Av1W14mTUjZ+aSOEUviug7bDGkGYWeLkl6JU6Hpdtf8xFv6TnaAeKlmhAjTNLuZWjwwhAAcRommSrGsFMJ/9/PMfqw7QEw8xuzvl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826046; c=relaxed/simple;
	bh=FCU2au8iHfUYB8PBqpHcG2nvW+BbkUt3p1rBU4AB4NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV1obVSKta4nld71L8lUsHqzreXMZJzzm9C/FYotB72D0VwOl6X5jRiBWIy2+T6K54NylVKPzldhA2SsWncsue3t4ixDqXJccLEQKN9nlLCst+l4OCEFHSclyMYaIf/zlYsZ9OSpVnuHb5a+JaMFiFEfY8606P8dohNcyrnuSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-12-685b7c397362
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
Subject: [PATCH net-next v7 5/7] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Wed, 25 Jun 2025 13:33:48 +0900
Message-Id: <20250625043350.7939-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGefe+O+c4XB3X7ZhBsa4EpUbhP5DoQ9FbEARBH7of26kt3ZRp
	pqEx07RWWnRZNlfN7GKbsVqWM0rK1BKjwlitm9q8RBeT1MxLUDtJ1LeH5/88v+fLn8OaYuVk
	zmBKk8wmMUnLqIiqO/z8vMVZG/QxpW4eHJ4KBtyDGXC5zacEh+sWgv6hNyz01T1koKx0AIPj
	aR6B755hDJ0NQRbc3tXQeqmLwJ2CKgzBI48YKMwbwXB36CsL+3zlCnh2q0gJJ4YvYqiytLHw
	/LaDgZaKX0roqi0k0Gi/QqC1aCk0OCfCQNMXBHWeKgUMHD7DwPFmJwPtea0Imh8ECZTkFCHw
	1ASUMDIYYpTUt7BLZ9AHX3owrbzySkGr7e9Y6vTuojfK51JroBlTr+sgQ729x1j69sUdhj4q
	HiG02tenoIW5Xxn6rfM1oT01foZ6Kv2EPnbWsWsi1qvidVKSIV0yRy/ZqtJfL7uvTCkLy7DV
	nyIW1MVaURgn8AuFzzebkBVxf/SToiWyzfCzhUBgCMt6PB8r9AUfEitScZi/ygh1FW9YOT+O
	FwVLZ5qcIfxMob36JSNrtYz51IFG8VMF97V7fzhh/CLBEcwlstaEMvtf5ODRfITQeLqDyEgc
	2vWc1cg2DlVzb5ZgeVbgKzkh392pGGVGCvfLA+Qo4u3/1e3/6vb/6k6EXUhjMKUbRUPSwvn6
	TJMhY/62ZKMXhf7lUvbPDT7U+2xtLeI5pA1Xx+xfr9coxfTUTGMtEjisHa+2xYUstU7M3COZ
	k7eYdyVJqbUoiiPaSeoFA7t1Gn6HmCYlSlKKZP57VXBhky1IF+dPUBiRd5PpUH7PBVvLyWjG
	2Z1tVfMTEmzh2/eumCnmR3yc0njg4NQ5T1fZPhojv72bHtP/4Ydy8XJTumuwIGFn/1l/rGCp
	cfkc/visyJXnW+vPZRvoshFdxaHyuMH33sRA9wJ9StRwotu+cV1XsWv52JQxlZGzcmI3T/M/
	l7QkVS/GzsXmVPE3+fNa8isDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe/Y8u7tbrW5L6mIfpJEJYrYi6URhRh98CIqiIjAob3Vpo6mx
	mWhkzNSkkcuXKJszrJGpM1bLcrMMU9MkqJioKzNtvvRC2YsmvkFtRuS3P//zO7/z5bBYNUVC
	WV1yqmhIFvRqRkEUOzdlr954+oBWc6NQAjZnDQOOiXS41e+Wgq36AYKxyR4ZjLa0MWC/Po7B
	9jKHwC/nFIahVr8MHK4d0FcxTOBRXh0G/8VnDOTnTGNomByRwVl3pQSay9ql8OqBRQqXpm5i
	qDP1y6Cj3sbAu5rfUhhuyifQbq0i0GeJg9bypTD+/AuCFmedBMYvlDFQ7C1nYCCnD4G32U+g
	NMuCwPnYJ4XpiYCj9Ok7WVw4bf7yDdPaqtcS6rH2ymi56yS9VxlJzT4vpq7q8wx1/SyS0bdd
	jxj6rGSaUI97VELzs0cY+mPoDaHfHncy1P7xu4Q6azvJLlWCYvNRUa9LEw1rYhMV2rv2J9IT
	dnn65adXiAkNy8yIZXluPf/CEmtGcpbhInifbxIHcwi3lh/1txEzUrCYu83wLTU9s/wSTuBN
	Q6lBhnDh/ICnmwlmZVDzeRAFM8+F8Y47jbMeORfD2/zZJJhVASa3Kwv/5Rfz7VcHSVCJA3ed
	11TBGgdWs++X4gKktM6hrP8p6xyqHOFqFKJLTksSdPqYaONxbUayLj36SEqSCwU+oiJzptCN
	xjrimxDHIvUCpSY3QauSCmnGjKQmxLNYHaK8vCFQKY8KGadEQ8ohw0m9aGxCy1miXqbcvl9M
	VHHHhFTxuCieEA3/phJWHmpCOvsH+7q71ZoiR++uc3ktnocL23aXOQe/JnKFCZn9lRqyT/O+
	J2I+igqvbxyg3ZaGmPmrYEtUxUyD/Ozh9Z744ghkI8LBsM7UMykl11f0zft9acz9qihl3p76
	jtNLntywj4SuRLfDCrPy3p9Bpq29hkWRBTN7mZjMja1eu2XbJzUxaoW1kdhgFP4AWDEA9A0D
	AAA=
X-CFilter-Loop: Reflected

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index e9eee8f680d5..535cf17b9134 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -213,10 +213,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(const struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page * :	(__force const netmem_ref)(p),	\
+	struct page * :		(__force netmem_ref)(p)))
 
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
-- 
2.17.1


