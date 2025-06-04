Return-Path: <bpf+bounces-59621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B664FACD5FD
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0917BBFB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251E2566F5;
	Wed,  4 Jun 2025 02:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8738230BC3;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005593; cv=none; b=op7tFQcWY0tglsMCbbI2dIgcv4eMHIouBAx/v3ld95AaqDbpjsdn+f+McJprzaDC0Df5cbEplgJCbdnuJ7sVrlXYG11rqmIkJj99TyVpovSnqLhaicd2fvE8lefaLpBaL5EXogPJ7yXqBIpvkRrL4533Lp8dR5/L7/psM8oHKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005593; c=relaxed/simple;
	bh=P6msonjomsElzNdLnL63wZFg+RS5SltS7JWVXNyGfXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u0Jq+A91PfYyx9bof6U7Iq3a9rmUiWp2n0rrIv2f8/q7BRv28Hmb2jr3+RZUeXQByTtSdVXR5ADpbbk+HNUPlxQlVWeNPS/5fBsjJfKHWs1uDRqgkaJHy9LAWmTnLYDbjjtDajDHHr+S4guWGpWLCD0VRyLn9bNuTMbQ2Xlfkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-32-683fb50a63b4
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
	vishal.moola@gmail.com
Subject: [RFC v4 12/18] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Wed,  4 Jun 2025 11:52:40 +0900
Message-Id: <20250604025246.61616-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fO3nMcLg5T6pSRtYioyG5aD1QmXV/6EEGBXT7UyFNbuVmz
	mUaZmZZtbYoFdlkwu5jOaLIuHkuktqXdoFhZy2aOhdJ1pdZSF5lO/Pbn9/z+/y8PSyk89ERW
	ozsg6HWqTCWW0bLvsZfnyO4sV88rKY4Hq+MGhtq+XLgeEKVgtd9F8Kv/PQO9nhYMVyrDFFhf
	FNHw2zFAQWdzkIGOqi4aGk/WUxAsfYzBXBShoFCslsDLuxYpnB24RkF9QYCBV/esGD7cGJRC
	l8tMw5MLNTR0WNKg2TYOws++IfA46iUQPn0JwxmvDcPHog4EXneQhovHLAgcTT4pRPqsOG0q
	uV3zTkIaLrQzxOY0kFvVs4jR56WI034KE2dPOUP8bxoxeXwuQpMGsVdCzMdDmHR3ttHkR1Mr
	Jo7brTR5bvMwpNc5eQO3VbY0Q8jU5Aj6uak7ZGp7z9x9N9ncY6VtVAH6i40ohuW5ZH7Qfl4y
	mks+/IlyzM3gfb5+ajjHc/P53mALbUQyluJCUr7TGokW4rjNfNAUiUo0N513/f4T5XJuEV/4
	1i0dGU3ka+seRJ2YIe4PVUQdBZfCm8XX1PAoz31n+EfNLnqkMIF/WO2jy5DchsbYkUKjy9Gq
	NJnJSeo8nSY3aWeW1omGflt15O82EfW83OhCHIuUsXLRn6pWSFU52XlaF+JZShkvT5w5hOQZ
	qrxDgj5ru96QKWS7UAJLK8fLF4QPZii43aoDwl5B2CfoR68SNmZiATJ42/y79q+xfDEd7ntq
	/BrEsbrVn48Gupfk/8zHDX6zY+w6ldupM+VfVZzbELOy3TpJ2yXkelvS11euyjIyqRUprvRp
	KSfKyexPsx0JC01i5bK6+8WXd2JDWejhQZki7e302LgtgX973OLiVxuPmvxkbXxTX5NU/3rT
	lJIV834p6Wy1av4sSp+t+g+7gAJz1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/Z/bjsvB0UYe7IM0LElQE1R+kOigiwcRySASS3PpoQ112qai
	keVlYGlqVwqdMJG8THFi5maKxBQvGFiaucxbM8Uu3u9OKl307eV5H94vL4271BButEKZxquU
	siQJJSSEEafzvYWvQ+SnOmYo0BoaKKjfzoSaaRMJWn0rgvWdLwJY6+6loKpyEwftoIaADcMu
	DrM9VgFMVc8R0FFgxMFa2kdBscaGQ56pFoOuin4S3reWkPB09yUOxpxpAQy/0VIw2fCHhDlz
	MQH9ZXUETJVIoUd3BDYHfiHoNhgx2HxQQcGTIR0FM5opBENdVgLKc0sQGDotJNi2tZRUwrXU
	fca4trIJAadrTude1XpxhZYhnGvW36e45tXHAm78UwfF9b2wEVybaQ3jivMXKW5ldozgljpH
	KK5qfhnjDC0jBPdO1y244BwtDErgkxQZvMo3OE4o16/6pjbSmbmlY3gO2qMKkSPNMv7svckt
	e6YYT9Zi2cEPspjxY9esvUQhEtI4s0iys1obdlAcZqJYa5HNLhHMcda8sWXnIiaQzRvtIv+N
	urP1TW/tjuM+H198bndcmAC22PQRf4iEOuSgR2KFMiNZpkgK8FEnyrOUikyf+JTkZrR/X3X2
	3iMTWh8ONSOGRhInkWk8WO5CyjLUWclmxNK4RCxyP7mPRAmyrFu8KuWaKj2JV5vRUZqQuIrC
	LvNxLswNWRqfyPOpvOp/i9GObjloUHoiJkH8rL3o7EogHbtsXvG07gQtYB76KLX62NeLVMz4
	oVjSqTLXM09UZIwJK/9x5WfIt0hbuneB+Ex1RM3o92xN+9TIh4nzW9cFA03p4fGhvx1TTOt3
	yq8GzEfL7nbcjjwX5nNJ7OUfJ12SLDi76v1XxR5EuEbuerOx1KFtQEKo5TI/L1yllv0F8m41
	vLoCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 2687c8051ca5..65bb87835664 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -195,10 +195,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
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


