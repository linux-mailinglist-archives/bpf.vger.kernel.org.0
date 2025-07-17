Return-Path: <bpf+bounces-63564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB7B085E0
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3368B16EC05
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529E21C9F2;
	Thu, 17 Jul 2025 07:01:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4E217723;
	Thu, 17 Jul 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735672; cv=none; b=ZrNwLOb+SJ+QGhOhexxDKo5jZ6ycpFnYe/6CzW84V5JUFQoDBzmhv0z08Zuw43Ez5nnjWrUbGDFhj4wKQ0sfxyM0A0u3LaP8pKN6t0cOul00pWWM8+pQjI10IptdCZutHYC02prd1GAExs+dC3fcgnkk3i6yvl31bZ9Xz6nEVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735672; c=relaxed/simple;
	bh=KQ1Soy0mWqukdCEA5OCmYYHkHskKEoGTFa1vQZDsDDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eFcNUkBc/uySNiLRO28QUsdF9QPd1+u8m33JYGkVFjZsgTT0+5C2Lps+eDQtwwD87fOkViTatYleFeUtY8v77pTrZ7IvaxnfyMPJlrZ9n/dUPWXrGVtASREV5DFg/1LbzescLCmqioky0iZRcw9h8rUSUBW4G4pLn1+m0uMBTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-02-68789fb30538
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
Subject: [PATCH net-next v11 04/12] netdevsim: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:44 +0900
Message-Id: <20250717070052.6358-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b/3dtS9q2R7p/GyGuImERUxOTHTEL/4+sFLhA9T8dKMN7ax
	oGu1gsmUcdHQaCFeQaqrXJRSAqQVKFrYVphURVcrNkWQIgyC4eKlgi11dq2Xb788T87znJMc
	Bpf2kHMZZeYhQZ0pV8koMSGeiClfZv09S7HixL/xYKivpeCh/yoJ5kAWXB+wkeA2cXDLFcDA
	UNOE4E2wlwZLYR8O/o5OCiquTuMQbDhNgOGffAKm6mdwGL49SIPT8R8BZssm8F0bIcB+shmH
	9qk4GCxyUnA6P4RDaX8BBeEnIRJag5M05NqqMWgda6TB1aQn4dxMFQ7NOQORriEPCY9uGih4
	lPcQQX9tmIQRR6RwvLqPBr35EgLHHyYKcvNXwXjjGxpenu/AwadPhvclWrht/Bqm740j6K16
	jEHYbqPhQX8dCR31zRh0PwviMH3qMgW6iSIEj0tvYtB1uYGEynvdWGSPFPCE32Fw1m2kYCjf
	h8DdPkhA2W96BPVtXhJe2SMnhwIGKnk93z7+AudtTysRf8PUg/Gjxe8x3tt2F+NbLj2leaPl
	MG+tXspX2J9jvM7rxnlLTSHFW16fofk+j53inSUhgrdWHudHraVo6/wd4h/TBZVSK6iXr9sr
	VgTMHnSwQpT1xBbEcpCL1iERw7FJXPNLE/WZu4svkFGm2CWc1xvEoxzLruT8g52EDokZnL0f
	w7VaS7CoMYfdzQ07LkaYYQg2juupSo7KkkiOvvftp8yFnLnhzw85InY1Fzp35oMujXaV59DR
	TI4tE3GmwgL848C33F/VXqIYSYxoVg2SKjO1GXKlKilBkZ2pzEr4+UCGBUUe7tqv73ba0GtX
	igOxDJLFSPY2HFFISblWk53hQByDy2IlZ91ahVSSLs8+KqgP7FEfVgkaB5rHELJvJInTR9Kl
	7D75IWG/IBwU1J9djBHNzUHrx06Uxfx07Jb/QtuWuh27Er5vzzvasmFjadeK735p2R5vTTXG
	09d1xXVfEanBO4kaV6/3ZOWaVbGiodG12IKhxanb0sA9e9GMx/PMUZF7ZbgrLe2VLP7LkYJu
	55qk8K6B8i+eJxYNbxr1dQYmyn6Yf8Osmj3jm3Tuu+L/e52hbWPKZhmhUchXLsXVGvn/Rquh
	wmwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+923o8FtWV0yCgYVBFlRwZeKEIS6BEVQ0AvKS97acE7ZdOlC
	MltEK5e9tbQsH+kWObbUZbPHNsxeptPWzFdqhdHs5TLXrLUV/Xe+58D5fP84DC5rIGczSnWW
	qFELKjklISSbVh9ZbL+ao1haeH0GlNbdpKBj7BoJlokcuPHGQYK3loO77RMYlJobEARDPTTY
	jvfiMOZ5REHFtXEcQtZCAkpfGAj4XvcTh3ctQzS0un4RYLFthIHq9wQ4jzXi4P4+H4ZOtVJQ
	aAjjUNJ/lILI6zAJzaFPNBQ4ajBwlz2Onh/raWhvMJFw7mcVDo35b6LAYR8JnU2lFHQe6UDQ
	fzNCwntXlBqo6aXBZLmEwHW/loICw3II1Adp+HLeg8OAKQl+F+ugpXwmjD8NIOipeolBxOmg
	oa3/FgmeukYMugZDOIyfLKPAOHoKwcuSJgyelVlJqHzahUX/2AK+yCQGZ73lFAwbBhB43UME
	XD5sQlB3z0/CV6eBSErm3YHPOO/oq0T87dpujB8p+o3x/ntPMP7OpT6aL7dl8/aaRXyF8wPG
	G/1enLeZj1O87dsZmu/1OSm+tThM8PbKQ/yIvQRtnrtTsiZVVCl1ombJ2hSJYsLiQ5kVcTmv
	HSEsH7XTRhTHcOwKrqvoAhnTFLuQ8/tDeEzHs8u4saFHhBFJGJx9PpVrthdjsWA6u5t757oY
	1QxDsPO57qqkmC2N9ph6flD/OudxFuuDvz1x7EoufO7MX18WY13Pp4uQpBxNMaN4pVqXLihV
	KxO1aYpctTIncW9Gug1F11SdN3nagYKd612IZZB8qjTFekAhIwWdNjfdhTgGl8dLz3p1Cpk0
	VcjVi5qMPZpslah1oQSGkM+SbtgmpsjY/UKWmCaKmaLmf4oxcbPz0WLN6pGDHbuUOzzjQt+0
	25OrytQFtWj47onWtyN6q3OB/NgW8/bmVH1AjirS1p5w96YkSwan+Ab1Cb42jLlifKgtbsmy
	GvsieXcCz03TwsGPsCZv3ZM5TRlbPdlp5urk7lFJwqv06rA+ddbog32W/dt/tFVuVrmCHQff
	ZgqOL3JCqxCWLcI1WuEPXGe7KUkDAAA=
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


