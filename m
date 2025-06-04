Return-Path: <bpf+bounces-59628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B468ACD615
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D4C7AB2ED
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013B25C6EB;
	Wed,  4 Jun 2025 02:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023ED231832;
	Wed,  4 Jun 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005595; cv=none; b=AMuQOYG144HzaGK/HPAlGvwSsVynMvBSr2rZV3iz5fCfESO3H4LQ/5TUBFajbz9eALWH4OU7PRnPHy0X8njvwz4b3DZxLD2VnmximmLpolqnjfIh4cLXrU1zYYfzsDX/hre+TDAtoyxvWWtvvTT0mGYlf9jaht2DrUwdRw+uUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005595; c=relaxed/simple;
	bh=Wc9SuBRytznhj9YZTfJ17EVkOqIfheeRssFhRw5N/9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qbtcFJmazE05ns9KeAimFkSziw/uE3aLwuQpH/E+GBMGhV0TjvprRGMlmGu/IjqEtoEMnvAGYpvbQP7I/PTvnY3dSydHQv1p8rShxZSI6FwAmTm26xzRyDhqSl/uDqaNevpK2ahH8RlEL7kLcwu1KzbYGaRqzKcImft/inFao3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3d-683fb50af615
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
Subject: [RFC v4 13/18] netmem: remove __netmem_get_pp()
Date: Wed,  4 Jun 2025 11:52:41 +0900
Message-Id: <20250604025246.61616-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnR2Hi9OSPBooDUQS1AyrVwgTgjgUURFF2occeWgrnbJ5
	2SzJciBJ07SBZYumQ9MprKbpDDHzLmmJt5aXFGsGkks3W9OlNhW//Xje5/l9eUlM2IkHkVJZ
	BiuXiVNEBB/nL/pVRPDfnpQcXtgIBJ2pnoA6txJezVq4oDM2IVhZneSBs6uXAEOFCwPdZzUO
	f0xrGNh65ngwUz2PQ2tBMwZzxX0EaNQeDB5Yajgw1FTEBe1aFQbNebM8GHmnI+Bb/SYX5js0
	OPSX1+IwUxQPPfr94Pr4C0GXqZkDrkcvCHgyrCfgu3oGwXDnHA7P7xchMLVZueBx64j4g0xj
	7VcO01I+zWP05kymoSacKbQOY4zZ+JBgzI5SHjM13kowfU89ONNicXIYTb6dYJZtEzjzu22M
	YEyNYzgzoO/iMU5z8AUqkX8imU2RZrHyqLgkvmTVvcJNf8lX1iydyUPdZCHyJWkqhta+r+Ps
	8rxah20xQYXRVuvqNvtT0bRzrhcvRHwSo+xc2qbzeAckuY8CWmtI3OrgVCg9MTS+7RFQx+im
	gXbujjOErnvdvu3x9eZT9rLtjpA6Smsso9iWk6YWefTPwSVsZxBIf6ix4o+RQI98jEgolWWl
	iqUpMZESlUyqjLyRlmpG3tdW5/67ZkGOoUsdiCKRyE9gmYqTCLniLIUqtQPRJCbyF4Qc8kaC
	ZLEqh5WnXZdnprCKDnSAxEUBgiOu7GQhdVOcwd5m2XRWvnvlkL5BeSj2vDnRwb+zsE7H+qRl
	B/ennl4vHsqM1PpEo5KGSsup6pE9pZWypbIQu+E4Cgv922JwUp8ilKMqR2vum5Kz59zts7cK
	Fq/6Bc1GCZ9VJndK701WfUkiNka6cxRSzt55xCYEEPkO4/SV/sK7k5lY/vjm8sU1pW0wLaHs
	8g9RsQhXSMTR4ZhcIf4PSbU779YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/e9cdjy4OHnrYB+EgYVClpHxi8IkiP4YmB+CwD7kSQ9t3t10
	zOhiKoTSlqZl6KTFyHsslpcZJqLLSwmuTWWZ6TAVyXtecFqUGn17eN+H98vLEL41ZBCjTM8W
	VelCqpxmSTb2bMExtuW84kTLoA8YzE00NG5podZtpcDQ0Ipg3fNVCmu2PhpMLzcJMAwVkrBh
	3iZgpndKCpM1syR0PGwjYOpxPw26wh0C8q11EuipHqDA3qqnoHz7FQFteW4pON8ZaJho+kPB
	bLeOhIHKehIm9dHQawyEzU8LCGzmNglsPqqmocxhpOF74SQCR88UCVUP9AjMnS4KdrYMdLQc
	N9d/keD2ym9SbLTk4Ld1YbjY5SCwpaGIxpafT6R4fLSDxv3Pd0jcbl2TYF3BEo1XZ8ZIvNw5
	QmPT3IoEm5tHSDxotEnjDsaz55LEVKVGVB2PSmAVnq11KvMFq61biclDH5hi5M3w3Cl+ttBA
	7DHNHeVdLs8++3MR/NpUH1mMWIbglih+xrAjKUYM48cBX26K33NILoQfs49K9ljGneZbB7uo
	f5vBfOObrv0d7918fKli3/HlInmddZgoQawReTUgf2W6Jk1QpkaGq1MUuelKbXhiRpoF7b5X
	c/dXqRWtOy91I45Bch+ZdTxK4UsJGnVuWjfiGULuLwsO3Y1kSULubVGVcUOVkyqqu9FhhpQf
	ksVcExN8uVtCtpgiipmi6n8rYbyD8lBCY2K7X0WvMP9Zt+FlzG4PdP6Y9zky2lOGVbUXObPJ
	rfVKRuoVMtStb71ckXh/2FF0IYogQn7Ln2rGt3NL7Tm268/sAb3Zi3YXFXDlnmc5Py6rsWto
	LWvi5lLJ4vuK5AP5xPKqfc4ndmSh6mNavHP6JH2mzCPoHa+Z6at35KRaIUSEESq18BdZmFwY
	uQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 65bb87835664..d4066fcb1fee 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -234,22 +234,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-/**
- * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
- * @netmem: netmem reference to get the pointer from
- *
- * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
- * e.g. when it's a header buffer, performs faster and generates smaller
- * object code (avoids clearing the LSB). When @netmem points to IOV,
- * provokes invalid memory access.
- *
- * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
- */
-static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
-{
-	return __netmem_to_page(netmem)->pp;
-}
-
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
-- 
2.17.1


