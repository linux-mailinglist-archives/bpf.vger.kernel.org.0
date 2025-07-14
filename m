Return-Path: <bpf+bounces-63171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65BB03E1E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17FF7AEC5F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCDD252903;
	Mon, 14 Jul 2025 12:01:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6F23A9BB;
	Mon, 14 Jul 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494463; cv=none; b=cVtYCejqOZVV5kGHBO0pywXJrvy4EM1n5tXoy9l8Z+ClO9SCwVzaqVOtJPaW3H/a3DTRHn/KqMXKNdoFkGBLytTTC2wEEVlH+K5l6hrrG7xGbKWxihujEG6b4U4+Foa0RfVUKKHV9lZtu8hqtv/eyhUJzs6vbHxYR5wK3WBSeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494463; c=relaxed/simple;
	bh=KQ1Soy0mWqukdCEA5OCmYYHkHskKEoGTFa1vQZDsDDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gboIOKS9bpzsSH3eSiMCzsH59Jo9x8e8CfnztTaTeIUzUoI8Zf8fSFzd632qwGgjgRCwq9hP/uzCjeuZz4uoF3W1fRW6UeqFlk+ut6juMe+E+vKyGHHCNY9n50Jyb/C7y2DHK3AEzmk3YLnQRtexY7ablD5m0xogpkB+k+YQ9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-33-6874f179578c
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
Subject: [PATCH net-next v10 04/12] netdevsim: access ->pp through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:39 +0900
Message-Id: <20250714120047.35901-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGfb/3u7Wh27cq7ptmWdKFmZjM+9zJNNMYk72JIXEzxmRLcM34
	XKu0mlIZmMyhQpiNVNwt4MosUllLdWVFobKC2iKyeVmpQqpAi/WGgnMK7WgBa4vZf7+c55zn
	OSc5PFbeZObxWr1RMujVBSpWTssfZx1/d89To2aJLYDB4jrJQs9YHQPOiWL4dcjDQNAhwh+B
	CQosjS0IxhP9HLgPDmAY67zEQn1dHEOiqZIGy99lNMRcSQz3uqIcdPumaXC6cyHScJ8Gb0Ur
	Bn8sB6KHu1moLJvEUBMuZyF1a5KB9sQ/HOz32CloHznDQaDFzMAPyRMYWkuH0ll3+hi43mZh
	4fqBHgThkykG7vvSgaP2AQ7MzqMIfOccLOwvWw6jZ8Y5+PfHTgwR81p4Xl0EXda5EL88iqD/
	RC8FKa+Hg2vh3xjodLVScON2AkP8UC0LpseHEfTWtFFwpbaJAdvlG1R6j03Ql5qi4PuglYU7
	ZREEQX+Uhp/3mRG4OkIMPPWmT56csLBr1xH/6BNMPIM2RE47blJkuOo5RUIdf1Hk7NFBjljd
	u0mzfSGp9z6kiCkUxMTdeJAl7mffcWSgz8uS7upJmjTbviHDzTVo45ufylfnSwXaIsmw+MPP
	5ZoJZx/aVS8rvuVJUKUowJmQjBeFFeKhri7WhPgZDqR0mTIrLBBDoQTO8BxhqTgWvUSbkJzH
	wtUssb25msoIs4U8MRZpmPGhhRwx0lrKZlghvCe2PLyAX/q/JTqbzs+wTFgpHqu9jTKsTPd0
	mGw4YyoKLpmYvHuaejnwhnjBHqKrkMKKZjUipVZfpFNrC1Ys0pTotcWLvtipc6P0wzV8PfWZ
	Bz0LbPIhgUeqLAU8MmqUjLqosETnQyKPVXMUjwYNGqUiX12yRzLs3GrYXSAV+tB8nla9rlgW
	/ypfKXypNko7JGmXZPhfpXjZvFJU8Umj/ZWLp9bnnx3fhsI5V49MNWQHyoltrv/YtP7jWcmO
	I7qRSFtudPOS+WtW7dhStW3dB4I1Bsll8bevnHt135/bleP//RKqMubFtjzRtA/Wjry2d+9P
	F8Pm84uH12SH+YqNH007okF/eXbltytl7x9/Z0FuP+7ZsOH3Xkdd3gN1z5CKLtSoly7EhkL1
	C6aXEi5sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG9z/3djQ5qYgnmjltQsxcVPBC3qhTs5n5zzIWDMnc9sHRyIk9
	kyJpKwGNyqTE0AgyvIGWrA6o0BpLyoQqFWxhgKIbFGyqAoV6iWLd5riEitq1JH77PXmeJ8/7
	4eVIZQu9mJNyDaIuV52jYuSU/JtNxasKXxk0KR2eT8HsuMzAwORFGuyzBXBpzEWDr1GAtv5Z
	Asy2FgRTkYcsOEuHSZjs6mGg9uIMCZGmMgrMfxkpmHa8JuFJd4iFXu9bCuzOdAhan1LgPt5K
	Qud0MoRO9jJQZpwjoXq0hIHogzkabkT+ZuGYq4GAzppbMfniKgv9LeU0nH5dT0Jr0Vhs8JGf
	hsHrZgYGiwcQjF6O0vDUG1sNNwyzUG4/j8Db0cjAMeM6CF+dYuHfM10kBMu3wbuqfOi2JMFM
	XxjBw/p7BETdLhb+HL1CQ5ejlYCh8QgJMydqGDC9PIngXvV1Au7UNNFQ1zdExO7IBH/0DQGn
	fBYGHhmDCHydIQou/FyOwNEeoOGV20ht+wJ3hv8hsWukDuHfG+8T+FnFOwIH2m8T+Nr5ERZb
	nAdwc8NKXOt+TmBTwEdip62Uwc7/Klk87HczuLdqjsLNdUfxs+ZqlLH0B/nmbDFHyhd1a7Zk
	yTWzdj/Kq5UVPHBFiCLUz5oQxwn8eqE/qjUhGcfwK4RAIELGOZFPFSZDPZQJyTmSv5sg3Giu
	IuLGAn63MB20snGm+GQh2FrExFnBbxBannvmywL/sWBvujnPMj5N+LVmHMVZGcu0m+rICiS3
	oA9sKFHKzdeqpZwNq/X7NIW5UsHqPfu1ThT7JuvhN7+40NTgDi/iOaRKUMCEQaOk1fn6Qq0X
	CRypSlRMjOg0SkW2uvCgqNv/o+5Ajqj3oiUcpVqk+GqXmKXk96oN4j5RzBN1712Cky0uQp4v
	1+X9NB7a9CFKTlQ0diy/dcJtrTyruSJl3/86rdSaHCzrlp01HFpUf2TAUpnhkTKWbT+88e3M
	3bL033aW+K31bTa773uUpM386ALz2VhF1toJT7EBZ4493pKx6o/j8tNC3m3ctmNrSVraKenb
	c6mB7oVJfekppZKZ+sT2+XdDoKL0GnXqSlKnV/8PXxIIqkkDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make netdevsim access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/netdevsim/netdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2d..d6b3a7755f14 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -842,7 +842,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
+					ns->page, false);
 		ns->page = NULL;
 	}
 
@@ -1069,7 +1070,8 @@ void nsim_destroy(struct netdevsim *ns)
 
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
+					ns->page, false);
 		ns->page = NULL;
 	}
 
-- 
2.17.1


