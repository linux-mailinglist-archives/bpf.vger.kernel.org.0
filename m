Return-Path: <bpf+bounces-61150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBFAE1234
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AFD188A3F5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04C21FF24;
	Fri, 20 Jun 2025 04:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5921E5B7E;
	Fri, 20 Jun 2025 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392760; cv=none; b=phH8at+2qiiPs20rCphAMVG2M+MTHQhOGtVZ7okN7DR3i5kekzgj77ko8DIlIjhhh/McYTXWhBDTw/zU53wOIPuBtfXIOzLnM7Y44mmDBxBFOeASxL8Nrx+DhI/9RVllZ4cYAWjR/X0YRs7XzAtrRyYPQLQBFa5dPEYfdgZpJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392760; c=relaxed/simple;
	bh=Vc9KZAZEagVw40jqBa3hCAzI3J3o9xAy+bTxXwdJbnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ln8pEtquv2WqaKCrWABLq9soWC81wJHq7xsefUTe7Vjqnj49FBtGo8yRGsZSg/0GhDlvfG/EaP9gouBVpkWDh/acezdxCq4ZAxMy7ih5ccrvWyOcPB8wRi8Le++X3tPMSIEb2MkzBz9pOsrqOuMVRHjCrPeOxBUzkGIPglAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-81-6854dfb20d59
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
Subject: [PATCH net-next v6 5/9] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Fri, 20 Jun 2025 13:12:20 +0900
Message-Id: <20250620041224.46646-6-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe/e+O+e4HByX1NsFonUjwUth9URRGQQHoggKpCRq6Mmt5rRN
	TYvAat0ktdQop9XMNG+xmqazG7aWlxK0hbVuKpbSxRRdDXVFbUbktx/P8/z+/y8PhxUF0lmc
	Rpcs6nUqrZKREdm3wOLQmu7t6ojCAQJFlmoGqkbT4EaPTQpFlXUIvo+9ZcHtaGagpNiDoajd
	SOCHZRxDX1MvC1XWzdBd1k/g/ql6DL05LQxkGb0YHowNsnDMVi6BjrpsKeSPl2Koz+hh4cXd
	Iga6qn9Lod+eRaDVVEGgO3s9NJmng+fZAAKHpV4CnrOXGchzmhn4YOxG4HzcS6DwaDYCy0OX
	FLyjvozCJ13s+gXC44EhLNRWvJYIDab3rGC2pgg15SFCpsuJBWvlGUawjuSywruX9xmh5ZKX
	CA02t0TIOj7ICMN9b4gw9LCTESy1nURoMzvYrUE7ZWviRK0mVdSHr90jU9e9MkuSSgLSnnr6
	cQbqZzNRAEf5SHqiuBT/41+tnyeY4RdTl2tsgoP5pdTd20wykYzD/E2GOqrfTsjTeBXNf2qU
	+JnwC2mN04MyEcfJ+eW00pr4N3MurbrVOJETwK+gw8fuMX5W+E5GrxmlfpbzQbS14CPxq9jX
	a7mi8I+xTz1+pxD7aylfy1HvmQL0N3MmfVTuIucQb5qkm/7rpkm6GeFKpNDoUhNUGm1kmDpd
	p0kLi01MsCLfw5Qd+RljQyMd2+yI55AyUG77vk2tkKpSDekJdkQ5rAyWl7RsUSvkcar0Q6I+
	cbc+RSsa7Gg2R5Qz5Ms8B+MUfLwqWdwvikmi/t9WwgXMykD5U3ZFZTjZq3PCP0ZvCUu7/Zls
	PBB5au/zvkVVBoUyyN1xPvzm3iXKtXkR8RcGyOn9Fy07opd3rFjchtbF9rzZRwenrvsUXD9t
	fkjwV05uN6F5Jx0FoUm516mucWXqhvzVXwwjOXVDOe4YXbt3vPGw98OGfRHaVa0zN6mjSp4k
	zA1TEoNatTQE6w2qP8oEOWIsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97ds7ZaHVaow4GCqMIpCwp44Ei/OaxSISKIII61aENdcam
	pl3Ay0iz1Ew/6Jw2W5pOYzFN57rJtNwaZijVuqmYSoFpNpu3bpsR+e3H8/z+/+fLw2DFIhnG
	aLRpok4rJKsoGSlL2JW3xT50UL2t9/F2MNmaKWiay4Tbww4JmKxtCGbm39Hg7+6hwFIbwGDq
	M5Dw3baAYezpCA1N9v0wVD9OwoP8dgwjJW4KigyLGB7OT9KQ62ggoKvaI4EXbcUSKF+ow9Ce
	PUzDgNNEwWDzbwmMu4pI8BgbSRgqjoWn5rUQ8E4g6La1ExC4Wk1BWb+Zgo+GIQT9XSMkVOUU
	I7A98klgcS7YUfVkkI7dyHdNTGG+tfENwXcYP9C82Z7OtzRE8oW+fszbrZcp3v7tOs2/f/WA
	4t0ViyTf4fATfFHeJMVPj70l+alHLyne8ukrwdtaX5KJiiOy3afEZE2GqNu657hM3fbaTJyx
	SDOfBcZxNhqnC5GU4dgd3E/PZxxiit3E+XzzS6xkozn/SA9ZiGQMZu9QXHfzu6XAGlbgyp8Z
	iBCT7EaupT+AChHDyNkYzmpP/dsZwTXd7VzqkbI7uenc+1SIFUFl7qZBEmI5u5rzVI6SoSgO
	3rXVKEJjHIzm3avC15DcuMwy/reMyywzwlak1GgzUgRNckyUPkmdpdVkRp1MTbGj4EvUX/xR
	6kAzA3EuxDJItULumDmgVkiEDH1WigtxDFYp5RZ3glohPyVknRN1qcd06cmi3oXWM6RqnXzv
	YfG4gj0tpIlJonhG1P3bEow0LBs9X0ekbPbObtoVXVqS62TxlfoEK4qP8vf+kn1sbJJ7Knrs
	7pZViUImNbpW+rA13JJfe7mT7vNWFsT7rngbciI7hlcOKhsG6/w19cpDxJejUze6so8WnHDW
	ZMCWTmfSeZO7rKd4dsGbFhGjvUDeuulq9BD75sPPXnLG1ZVuYFSkXi1ER2KdXvgDgdot6Q4D
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
index e0aa67aca9bb..e27ed0b9c82e 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -191,10 +191,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
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


