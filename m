Return-Path: <bpf+bounces-59626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E80ACD60B
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC8B17C478
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB825A2C2;
	Wed,  4 Jun 2025 02:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606523536A;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005594; cv=none; b=Nz14i5vVEYa076WT5aR6C33Nnn+kNe0JIneQ2Csp1R38DCpYPX/Vi+1rodLX1+dw42UF73uW3ZIzRTnN1lO8oH2WyeK0Z+hlqB6ZwwgqWcchwXwCyWpHVupmos0UKpv9gF1lbNDAS3HX+d8aLgBxpkDpKV+FTbUQ/4KsgGoTlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005594; c=relaxed/simple;
	bh=3e2wWQjzL/nHoe82u8QRBrIltsUak/khJlSdHV3fHQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PW9iTb1o/AXGGDQYb59N9otjz8epwx+5T8rNabilVY82Mezqvuh5WWDEob46/TJ6MlI2PLOgtQTTCCTlpv1sfV4Fkq3i2n8y8BXXXbDfMPv2HNUI/OPQVvn+xPJKM6S357jUJ85D/QEFtc4SoXKK7+CBkbt+v0KMeXfsKkg6GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-5b-683fb50a8f99
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
Subject: [RFC v4 16/18] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Wed,  4 Jun 2025 11:52:44 +0900
Message-Id: <20250604025246.61616-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fenR1Hg8OSPCkkDSKSMg2z50OZdIG3MMiyCwnW0EMbTWfz
	XgZWVqRuiRqJzlhl6rw0mbbNEKk1b5V5y1g60yYagRo5HZVGqdG3H//n//99eRhK2o79GWVS
	Kq9JkqtktBiLZ9Y+2i5+tk8RopsJAb2pnoa6H5lQPW4Tgr7WgmD+54gIPI5OGh4/9FKg783F
	sGD6RcFkh1sEY1VTGFpvWylw3+2iQZu7SMF1W40A+iw6IZT8ekKBNWdcBIPP9TR8qv8jhCm7
	FkN3mRHDmC4SOgzrwftmGoHDZBWAt6CChuIBAw0TuWMIBl65MZRf0yEwtTmFsPhDT0duIs3G
	jwLSUjYqIgZzGmmqCSJ5zgGKmGvv0MQ8VyQirg+tNOkqXcSkxeYREO2NWZp8nxzG5FvbEE1M
	zUOYvDU4RMRj3niMPSvek8CrlOm8ZkfEebHi9pQHJz9iMg3VX6kcNE3nIR+GY8O4p0sG/J/z
	9BWCFabZLZzT+ZNaYV82lPO4O5c7YoZiZ4XcpH5xtbSOPco5G0ZXRZjdzPW4y0UrLGHDOe+X
	CeqfNJCra3yxyj7LuWv2/upWyu7itLb31IqUY2dEXFFOK/o32MC9rHHiQiQxoDW1SKpMSk+U
	K1VhwYqsJGVmcLw60YyWn1t1dSnWhub6TtgRyyDZWonNFaGQCuXpKVmJdsQxlMxXErh1OZIk
	yLMu8xr1OU2aik+xowAGy/wkO70ZCVL2gjyVv8jzybzm/1XA+PjnoHzHtgMn1cct/T1xluIJ
	dXy/ViBJC9cVNMlG9l+pO6huzDZmJMT1DeZ1n74XkxtjbFxKGx4uiQ6I9nH5GbOn5VWFl26q
	TpEWZ/tnKD2kDOUG9w+HTjYsxJ7pPXxrqrLJt9LyO3H83fzrB+6F/OaoI1FOa2xYbcVe627C
	YCNVL8MpCnloEKVJkf8FS5IIfNgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUgTcRzH/d/dbudocM1RhwbiIKRJppDxA8PshXYJRlAQJJFDDzedD20q
	GhSWgjXcephU6ISV5mOyWDanyao5dGaSzbRVPjGZPSCr3JwPE0qN3n34Pr35UrionYikFEWl
	nKpIppSQAkJwKrn6oOD5MXmC60cUGExPSOhaq4C2eSsPDJ0WBIH1L3zwO4ZJaH4YxMHwroaA
	FdMGDt4hDx/mWhcJGKjtxcFzy0mCtiaEw3VrOwaDTSM8GLfoeFC/8RiH3qp5Pkz0G0iYffKH
	B4t2LQEjDR0EzOlSYci4B4KjSwgcpl4MgnVNJOhdRhIWauYQuAY9BDRe0yEw2dw8CK0ZyFQJ
	29PxCWP7Gmb4rNFcxj5rl7IatwtnzZ03Sda8fJfPTk8NkKzzQYhg+6x+jNVW+0j2t/czwf60
	TZJs87dfGGvqmSTYt0YH//Tu84KjuZxSUc6pDqVkC+S1i36i5BFVYWz7jlehJVKDwimGPsxo
	DE3YNpN0LON2r+PbLKYTGb9nmNAgAYXTPh7jNYR2QhF0JuPuntkpE/R+ZszTyN9mIX2ECX5d
	wP+NRjNdT1/tcPiWPu27v9MV0UmM1voBv40ERhTWicSKovJCmUKZFK8ukFcWKSric4oLzWjr
	v9Yrm3esKDBxwo5oCkl2Ca3TKXIRT1auriy0I4bCJWJh9IEtSZgrq7zMqYovqsqUnNqOoihC
	sleYcY7LFtF5slKugONKONV/F6PCI6tQlmtGn5MWKLmUH+No6c6IT0+Ji/a/PHt188XyHOY8
	/r6iz5uwb3xM2GO9IJZYVupXRsKS12LWcg2rDWaftM6Ulp6fmKBvybJN6YMfT8a2e0dVm9Fk
	a04zo8vpX3mzcG+8K68uELyRpoh57ZyNq121SdctZzLjpI56fpg7ApMQarksUYqr1LK/M/SC
	xLsCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and APIs instead.

As part of the work, introduce a netmem API to convert a virtual address
to a head netmem allowing the code to use it rather than the existing
API, virt_to_head_page() for struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index d4066fcb1fee..d84ab624b489 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -265,6 +265,13 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
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


