Return-Path: <bpf+bounces-60034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EBAD17F8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385BB188B80C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC27283FD1;
	Mon,  9 Jun 2025 04:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0F280328;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443564; cv=none; b=VQDk3oAMDmT65fdL4WIQYCtmStaxiI8URSCeMydcBNdQY2Xnu0toptJZOiE1y0DyHosOwv9lzLhtpRn3flwlX/hPiQBl8Z512VlPrcZ0Ekw+cXAC4OfClbUQ+oIjeiP5TYc7KT/KL9N0aO2/xiX7xqEF6k14+u3hXqUeEvDSjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443564; c=relaxed/simple;
	bh=omiNsBe9y3tWuFi1FDkvk0jhkOJoT8T2ScM38IyZW6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiElEDNA085uC4Gh8xy5GaXDYOe/+j5/gBG8MiR7Jq6qeF17T5nuOK/1Vt65Kay1cWwnLeRZco8tTXLvpj5UNSzfNpMfJKbwFr/LlFe1F1qeQEjsYEIa1Ht0FlPelaQYQJTc33ujH3esmzFcuHYEig+F5Gleh+7nhyQXqaHToUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-99-684663e4ac9d
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
Subject: [PATCH net-next 8/9] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Mon,  9 Jun 2025 13:32:24 +0900
Message-Id: <20250609043225.77229-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG+e9/793dcnabkrdXaSmVpmVYHCIiiPL2qcSQ0A+69NJWOm3z
	NShmrkJTy14o54qJWJtKi2VqYWLTMktomNlMS126KNLSlfhS2FZJfvtxnuc5z/lwaCwtJJfT
	SlUGr1bJU2SUmBCP+lSEDSftVWyuf+4PBkstBTVTOXB7sJEEQ3U9gu/TfUJwt7VTUFkxicHw
	UkfAD8sMhpGnTiEM3HIR0HSuAYPzwjMKinWzGE43mgRgry8h4cpMFYYG7aAQXj00UPC+do4E
	l62YgA69mYCBkl3w1LgUJl98QdBmaRDAZNENCi53GSn4oBtA0NXqJKA8rwSBpdlBwuyUgdq1
	hqsz9wq4B/p3Qs5ozeTumUK4QkcX5qzVBRRnnbgk5Pp7miju2fVZgnvQ6BZwxfljFDc+8pbg
	vja/pjhL3WuC6zS2CTm3dfUBJk68I5lPUWbx6k07E8WKslEXmf5ElFPQ3Y61SEsXIhHNMpFs
	XYMZzXNp3y/KyxSzjnU4prGX/ZkI1u1sJwqRmMbMGMmOGGYFXsGPiWFL7Xf+MMEEsx2VD0kv
	S5itrNauJf4uDWRr7rZ4FtG0iNnGDjoyvGOpx2LrNuG/9iVsR9kw4bVgT6/lptQ7xp5k/v1y
	7K1lGTPN1tQU/btzGfvY5CAuIka/IK7/H9cviBsRrkZSpSorVa5MiQxX5KqUOeFJaalW5PmQ
	Wyd/xjeiCXuMDTE0kvlIEq/tUUhJeZYmN9WGWBrL/CXMwG6FVJIszz3Bq9MS1JkpvMaGVtCE
	LECyZTI7WcockWfwx3g+nVfPqwJatFyLgqp889NXxX+KDcppKY8e98tr/ayN0eeyiRscJHU2
	5Kw00C8iKiw4YM7RHX54/9oS1aPpHlHB1crjbQlnQh+5XL6pup7K3lNzzkDJIvPQy6TO2xUT
	o9n3jIcCzkeV7tu4/4Zk5Zuw0P71yR+LWqNdkhlFsP3b0YO+iwM6moY0cbHbZYRGIY8IwWqN
	/Dd6femOHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/7nrPjaHFcUieLLoMQhC5CygNekCI9FV2goCvlcMe2vLap
	zS6wcpBZalpQrhULs0yllV3UMKlp6rRQvMTykmYqkdltJrqty1ZEffvxf37P//nysFg+QQJZ
	TUq6qE1RJikYKZFuDs9ePhIfo171oUACZmslAxXTerg5VEODufwhgsmZPgk4G5sZKLk2hcHc
	biTwzerCMNo0LIHBG2ME6k5VYxguaGEgz+jGcLKmjIKGK3YaOh7m03DBVYqh2jAkga5HZgZe
	V/6kYcyWR8BuukVgMD8amixzYartA4JGazUFU2evMHC+08LAW+Mggs6GYQKXT+QjsNY7aHBP
	m5lohXD/1itKqDUNSARLVYZwryxYyHV0YqGq/DQjVH0tkgj9L+sYoeWSmwi1NU5KyMv+yAhf
	RnuJ8Km+hxFK3n2mBOv9HiI8tzRKtvrvlkaoxCRNpqhdGRUnVRdPjNFpz/z0p7ubsQEZ2Fzk
	x/Lcar6w7zvjY4YL4h2OGezjAC6Edw43k1wkZTH3keZHzW7KN5jDbeMLO27/ZsIt4+0lj2gf
	y7hQ3tBhIH9KF/MVd554i1jWjwvjhxzpvljuVWzdZfiP7s/bi0eIT8Heu9arcl+MvZvZDy7j
	c0hm+s8y/bNM/1kWhMtRgCYlM1mpSQpdoUtUZ6Vo9CviU5OrkPcJbhz3FNagya5YG+JYpJgl
	i7u4Ti2nlZm6rGQb4lmsCJBxg2vVcplKmXVE1Kbu12YkiTobWsASxTzZhh1inJw7oEwXE0Ux
	TdT+nVKsX6ABFTkjgyKNDyom0/Onp9cv2lm+PTbb0xc7cGp2+8EYWXzE001hG5dwxT9aVQX7
	rhuonPCj/BYxt5dZ8/XNBc/SniJNzrH3rgXr6mJcqk0L95T2B7Z9y0k4GdWqPDR+hlqsVi8s
	0Sfqx5dI39/d5dnrbp4PnonDCTOq2snHL7rZKP9OBdGplSHBWKtT/gKDZs41AAMAAA==
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


