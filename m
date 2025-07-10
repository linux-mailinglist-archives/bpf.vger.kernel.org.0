Return-Path: <bpf+bounces-62894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339AAFFC3F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BCA1C28399
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B828EA4B;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC328C5CC;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136110; cv=none; b=HI9qwsqlAw+f3iCFhCakx4jHXQNh1xqEBQ5vQRJdaWYSTLzXciwEtCkxm42PGKBVQahktWntR2mk7YlAVheiRdq3lhs2H+fBX8yBhqcjak/M6NFw35+T9fWx6OArMCkmvtVVBn9VJ0LVtPA61T4UfZmwU1Wdc5GTf/nlZBihmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136110; c=relaxed/simple;
	bh=hK1RRFRcd7Rb1RLo7hJ76BRYK9t+zQYYkhWzco8sIbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRV3xbNp5+zp1vq6MgWnN3KUnA9nCZhUMGmn31D4si6dZ82rvJ3jCXaVuJtIQ+hxiH54HP4IsqiPurPQoIt6L0c6aYg0X5kFwW+Q/2mueX992zcwp8xNTdocZhnZdKe2ZLjoLegN1hB0S26839dkM2YyWykp2Q9K8ahaqXMISK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-02-686f79a11a2b
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
Subject: [PATCH net-next v9 5/8] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Thu, 10 Jul 2025 17:28:04 +0900
Message-Id: <20250710082807.27402-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGefe+O+c4XJyW6eleywgDzULtT0VEfXkpiiiK6EIOPbjRnDLL
	NItMhdhKu1hUm8W0MtuMxSqdtm66vJCUGNrMa5riBy/UangJalO6fHt4/s/veb78Oay4KZ3P
	aXTHRL1OpVUyMiIbCS6OLMlMUUePtBMospczYBvPgPu9TikUWSsQfJ/oYMHrrmfgTrEPQ9H7
	PAI/7JMYBur6WLA5dkBP6SAB17lKDH0XGxjIz5vC8HxilIUcZ5kEmisKpHB18h6GyuxeFj5U
	FzHQXf5LCoM1+QQaTQ8I9BRshjpLKPjeDiNw2ysl4Ltwi4HCFgsD/Xk9CFpq+wiYzxYgsL/w
	SGFq3N9hftPNbg6ntcNjmD550C6hVaYullocx+njslXU6GnB1GE1MNTx7QpLO9tcDG24MUVo
	ldMrofm5owz9OvCJ0LEXrQy1P2kltMniZnfNPiDbmChqNemifvWmeJna3lWKUs8FZZhKDZJs
	VMsaURAn8DFC5f2xv9rsG2ACmuFXCh7PBA7oEH6N4O2rJ0Yk4zD/kBHc5R3TwBx+n2D8XD4d
	IvwKYchlmNZyPlYwXzaTmdIlgu3RK7/PcUF8nODszwrYCn9kqtVIZuKzhcabX0gggv279tuK
	gI39ZO5TMw7MCryTE6qvt0tmKucJr8s85BLiTf/hpn+46T/cgrAVKTS69GSVRhsTpc7UaTKi
	ElKSHcj/MKWnfx50om/Ne2oQzyFlsLw5SadWSFXpaZnJNUjgsDJEPr5fq1bIE1WZJ0V9yhH9
	ca2YVoMWcEQZJl/rO5Go4JNUx8Sjopgq6v9cJVzQ/Gy04eKsZ8tfLtrgFZrcnVvqOwbeL006
	JTlvdb4Lb0/QZ+2JuBXcfyh0aHL9srOFFjm2uTp3vEyJPGxT7+Zyis10a/xSQypzdOJt3MfG
	a9vPG3Ntz64k9Cw81VQ4d2/kZVfDNpMB3Y3eGbUrbDFT7ShZl7PpjDXCG1v49GsbHxdxp26h
	kqSpVWtWYX2a6jfwrGmKLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e/8d87ZaHVcVof6EC0kKroYGe/o5pfqEF0/ZCaFjjq05Zy2
	OXVFoGmFI+2yPtQ2ayktm5PJyXKGWWxeqUgm3spbmrFA7KINbUVtRtS3h+f9Pc/75aEJeRgv
	pjW6bF6vU2kVpBRL920uXHPXlKleL/RsALvHTULVdB7cH/aKwe56jGBq5i0Fk02tJFTcDRFg
	f12E4ZvnOwFjLSMUVAl7Ycj5AUPDpToCRq60kVBSFCbg6cwEBee9lSLwl7WLoeNxqRhufL9H
	QF3+MAWdT+wkDLp/ieGDrwRDu/UBhqHSRGhxLITQi3EETZ46EYQul5FgCThIGC0aQhDwj2Cw
	FZQi8DT2iiE8HemwNQ9SiXGcf/wTwdU+6BNx9dYBinMIRu5h5SrO3BsgOMFVTHLC1+sU19/d
	QHJtN8OYq/dOiriSwgmS+zL2BnOfGrtIriL4WcR5arvwAXmKdMsJXqvJ4fXrtqVJ1Z4BJ8q6
	JMmzOotF+chPmZGEZpmNrC00RkY1yaxge3tniKiOZeLZyZFWbEZSmmCqSbbJ/XY2MJ9JYs3v
	3LMQZuLYYEPxrJYxCaztmg3/KV3KVtU8j/g0LWE2sd7Rs1FbHkHCXWb8B49h22+9x1GEiPz1
	3JZHbSKSLHxkI64imfU/yvqPsv5HORDhQrEaXU6GSqNNWGtIV5t0mry1xzMzBBSZhPPcj2te
	NNW5y4cYGinmyDpO6tRysSrHYMrwIZYmFLGy6WStWi47oTKd4fWZqXqjljf40BIaKxbJdh/m
	0+TMSVU2n87zWbz+71VESxbnI5eyYG/Rx1JzcvWrNst+e25DyeqpMcncZ8ccO4OerfMupDX5
	BUvB+tTtp5aX30nsNC4rm8gN3sqmYvfn4kPLYizBviNrzglnfx6Mq4zZvKOt2zekrCp/GVBe
	sJCjze6HmoI9xhr3lsa+lPKeixcdH/uPPlqgNDlqVjJJ7+r9X8dPK7BBrYpfRegNqt+p5yiz
	DgMAAA==
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
index 283b4a997fbc..b92c7f15166a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -372,6 +372,13 @@ static inline bool page_pool_page_is_pp(struct page *page)
 }
 #endif
 
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


