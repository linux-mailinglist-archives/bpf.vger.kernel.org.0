Return-Path: <bpf+bounces-63571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC320B085EF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EBF7A7E93
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B323535E;
	Thu, 17 Jul 2025 07:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120C21A434;
	Thu, 17 Jul 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735677; cv=none; b=uhSsxE+bweuDikb9c2usMtBf00murJcWUDrVx+DXdVIELTy1tK0SB+SfyZQpDY6/+XJ/ygokRzIx3uRVuaFoFydYdb4Hzo0bg9VaB4yuiX9gpuqM0/V9C0FQ9cEb5si6NEgPbtE5a942WXweqYazdBTsig53Fe7CRdVVcKDDT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735677; c=relaxed/simple;
	bh=/W68wn6cUzyXMEqBcZXzREZJA8MzCiky7GeibbhGu0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aHWawcDjOd0cualW6unn49fC57ckVNcVMJF1NugUmyX7bG781cxdG1Nzxf6iDR/bhTNE248jgWKNi470drJNoUJ8ljHriORNZd1nCaaVyo/7GVIVgGVWLwNWXVtPHNNfKWfS2vcJyBz6CgsuM9n9eZFZsP/vKQSmcv//CP1JXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-15-68789fb30571
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v11 05/12] mt76: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:45 +0900
Message-Id: <20250717070052.6358-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfWxLexjH/c57a+XoZM4dIuotJOqd54/lkptczj9DMokgYSd2oo1ulo6u
	I7KhXlZ3xYZsa8Ve7ZUtLVrTznQLixlbzRSzzZYxdLg6y6quabfc/z55vt98v8+TPAwu7ySj
	GXXSQVGbJGgUlJSQDkUULrVd1auWfx1aBZaaagra/YUkVI3qoazXQYKngoO7baMYWCpvIxgO
	vKbBmtmFg7/pIQXFhSM4BGqzCLA8NRDwveYHDgMP+mhodv9HQJU1FnquvSPAedqOQ+P3BdB3
	rpmCLEMQh7zukxSMvQqS4Ap8puG4oxwD16dbNLTdNpFw8UcpDvaM3lBXfycJz+osFDw70Y6g
	u3qMhHfuUKGvvIsGU1U+Ave9CgqOG1aB79YwDV8vNeHQY9oAv3J18KAgCkZafAhelz7HYMzp
	oOFJ9w0SmmrsGHS8DeAw8s8VCoxD5xA8z6vD4PGVWhJKWjqw0B5x0Dn2E4McTwEF/YYeBJ7G
	PgLMx0wIauq9JPzrDJ0cHLVQG/7iG31fcN7xpgTxNyteYvzg+V8Y761/hPF38t/QfIH1EG8r
	X8IXOz9gvNHrwXlrZSbFW79l03xXp5Pim3ODBG8rSecHbXlo6+yd0pgEUaPWidplf8ZLVZZc
	N5GcQ+sHzIsz0FnKiCQMx67mXPYBzIiYcXZenh8eU+wizusN4GGezq7g/H0PCSOSMjjbGsG5
	bLlYWIhkd3At70+SYSbYBVxr2VkynCML5Zwyp0/Ez+GqahvGcyTsGi54MXu8Vh6ydBRl0BOe
	MglXeAGb4D+4++Ve4jySFaBJlUiuTtIlCmrNaqUqLUmtV+49kGhFoW+7dvTnLgf61hbnRiyD
	FBGy+NpUlZwUdClpiW7EMbhiuizHo1PJZQlC2mFRe2CP9pBGTHGjmQyhmCFbOZKaIGf3CQfF
	/aKYLGr/VzFGEp2BEjB2ZreraOr1E5Mure3fT2VG/W1Y11bEuetjjiTPXTj51DbJrLfZ8dPk
	+UUCvqmZ8B8xz1KuiR2mqzc97d04e4svINpc9sHRLYJ+0fpWQemsizRXbJ7i16zMbq/uUu3O
	WqvUpMXLPvbP22yKiT7TGluaHpcqefGpUXtme0NkVIOCSFEJK5bg2hThN4MBEoxpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PnW5+O+HnYbQba5qnkH2GNcbmN83D+INspsNv7lZd3OWU
	odKJriSVXHVxPejRXO6iw4ldjSOkKzmc4hoxeSzNOeTO5r/35/P+7PV+//FhcEkTOYVRKJME
	lVIWL6VEhGj9soy5lvPJ8gVuz1QwmC5S0DlUTkLDj2SoeWUlwVnHwY3HPzAw1F9FMOx9QYM5
	y43DUNtdCirLR3DwNp4kwNChJeC76ScOb+54aHDYfxPQYF4HfdVvCbAdb8ah9fss8JxyUHBS
	68OhuPcYBaPPfSTc9H6i4ai1FoPWsnv+8cMVGh5fzSWh8OcFHJrTXvkD+3tI6LpuoKAroxNB
	78VREt7a/amDtW4achtKENhv1VFwVLsIBq8M0/DlTBsOfbkr4I9eA3eME2GkfRDBiwtPMBi1
	WWl41HuJhDZTMwbdr704jOSUUaD7eArBk+LrGDwoayShqr0b8/fYDD2jvzAocBop6Nf2IXC2
	eggoTc9FYGpxkfDVpiVWrOJbBz/jvPVlFeKb6p5h/Lu8PxjvarmP8ddKXtK80byft9SG85W2
	9xivczlx3lyfRfHmb/k07+6xUbxD7yN4S1Uq/85SjDZO3yZavluIV2gE1fyoWJHcoLcTewvo
	5Dels9NQNqVDDMOxizlb0UwdCmIoNoxzubx4QIewEdyQ5y6hQyIGZx8GczcteixgjGdjuPaB
	Y2RAE+ws7mFNNhngiP2czNLUwJpjZ3ANjbf/cYLYSM5XmE8FtMR/0l2RRuchkRGNqUchCqUm
	QaaIj5ynjpOnKBXJ83YlJpiR/5eqD/86bUXDXWvsiGWQNFgc23hALiFlGnVKgh1xDC4NERc4
	NXKJeLcs5aCgStyh2h8vqO1oKkNIJ4nXbhFiJeweWZIQJwh7BdV/F2OCpqQh5faOYLuRLEqa
	rE+1bGs6cTvryEDeIl0mN6FmSY547aaoYEiYkb608mlHtOby2LCvtVG+sIqVuHiJlJykXn3O
	vPNDxMR0h5D5qD9yoSPVtDLUHZM4XPGbu9Sx4PX9rSdGohND8+f42seV30uyZmw4lEHtOxsu
	Fas7p0WvGshZNl0kJdRyWUQ4rlLL/gK76wuPRwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mt76 access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14927a92f9d1..7e9ddf91b822 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1798,7 +1798,8 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
 	struct page *page = virt_to_head_page(buf);
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(pp_page_to_nmdesc(page)->pp, page,
+				allow_direct);
 }
 
 static inline void *
-- 
2.17.1


