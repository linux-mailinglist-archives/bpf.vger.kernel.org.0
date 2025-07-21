Return-Path: <bpf+bounces-63868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51CDB0BA82
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B3189A32D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3A2236FD;
	Mon, 21 Jul 2025 02:18:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB41FAC48;
	Mon, 21 Jul 2025 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064333; cv=none; b=sZfuf9Md0CXA/D8vEO3F/n3w4rMhBzecYiNabEbFRbM9RxPK6544wy60s0xymPn4jVE8MVGnFnmNgS/CpSEVXE+0aPK773kUTQulXeXlGU7xXGn8ZFUgdqw+PWIGrxKs4gFiiniV+eAcs/Fa3NEGNS8dHa/KtZSkG5A+ePwF6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064333; c=relaxed/simple;
	bh=VOGdoBvhjejH77efcQeoJr+PQGtGpIFL66Y/taM0X0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fi8x9am8igJxWQOmFCk6FbIc3n0T4AjEXKtPTK0tgGZEk9d9en8pet3GTwrpIILLnWcw1qp0smT0SOcydNmBkHj6bzJLM0oFlN1ZDwwbNlWFUbBCepp3wqTN0do2RfgbFgJ+9OELsBBw5MW3YrCbiPlUexVEqmgPMMhkUOrLykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6b-687da386ed5a
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
Subject: [PATCH net-next v12 04/12] netdevsim: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:27 +0900
Message-Id: <20250721021835.63939-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGeb97K41fCuinbllSY5aZiYK6nMTLjLrkXQwLinMX3LSBT9vY
	AimKoCF2yKYSBdxwgtQI4SJQhKYM6bQFKQQIeClVSRlIpSrx0u4CWigorED875dzznOec3IO
	R8r76aWcOumwqEtSahSMlJL6QktX/VKWqVpzLf8TMNTXMtA7VkqDcSIdrj620OCsFuCmY4IA
	Q811BK8DAyyYzwySMNbeyUBZqZ+EgOkcBYZ72RS8qZ8k4VmHh4Uu+zsKjOYYcFeOUGA91URC
	25sV4MnrYuBc9hQJRUM/MzDz1xQNtsDfLGRZqgiwvWpkwXE9l4aCyQoSmvSPg15P+mi4f8PA
	wP2TvQiGamdoGLEHDb1VgyzkGi8hsLdUM5CVvRa8ja9Z+PdCOwnu3C0wXZgGHSWLwN/jRTBQ
	8ZCAGauFhbtDdTS01zcR8GA4QIL/7GUGcnx5CB4W3SDg9mUTDeU9D4jgHHHQN/OWgN+cJQw8
	yXYjcLZ5KCj+KRdBfbOLhv+swZWnJgzMlq24zfsPiS2PyhH+o7qfwM/zpwnsau4m8J+XHrG4
	xHwEN1StxGXWFwTOcTlJbK45w2Dz6K8sHuyzMrircIrCDeUn8POGIhT74ffSjYmiRp0m6lZv
	3i9VNVWUopQySfr5i35ajxxsDpJwAr9OcE/2Ee95eNhFzTLDfyy4XAFylsP5KGHM0xmMSzmS
	vxMq2BoK5wRh/I9Cc0HrHFP8CuGdyzMnkPHrhW7DTWq+6UeC0XRrLi7hPxM8wfPPsjxY431p
	oedrrkqErvKYeV4itFa5qHwkK0EhNUiuTkrTKtWadZGqjCR1emRCstaMgg9Xmfk23oJGHXF2
	xHNIESpLoTJVclqZlpqhtSOBIxXhMtx5TCWXJSozjom65H26Ixox1Y6WcZRisSzafzRRzh9U
	HhYPiWKKqHufJTjJUj068HRHwudnA5UxYV+et61WhezmlJN64+m949vqdu+I+LalNtnp+6GQ
	nD5+NNq0YCs9MvDdqK+nNfabDxzEyXZtuKX4yvi+l5rtO/V77kkXZtji3avYL0Yiugv6r+Xv
	3R+2KWzDrhOfPsvbZryw2USLsXpbyNfLl5l+P937Vdb4niW+EK2CSlUpo1aSulTl//TCgJ5s
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUyTaRDHfd6zbWx8rURfNfFoom5IRI1HhmiMiR981Hhk1yMeWanyxjaU
	QlpowISIUi8UFNEsaFlbCy4Fs8WitkpBLcRWUYSCpCpXixCPenJoRcSC8dtv5j8z/0lmRKTM
	QU8TqTQpglajUMsZCSXZuDxr/lFLhnJhMH8iGG1XGWjqM9NQ/jUN/uty0uCz8lDV+JUAY9lN
	BP3hFyzYT7SR0FfnYcBiHiQhXJFDgfGJgYIB2zcSeu4HWfC6hykot2+Aziu9FLiOOUioHZgD
	wdNeBnIMQyQUdhxhYOT5EA3V4fcsHHaWElBb9CASvr3BQuPNXBrOfSshwZHZFTHsbqWh+baR
	geasJgQdV0do6HVHXEOlbSzkll9A4L5jZeCwYTGEbvSz8PF8HQmduavgR4Ee7psmw2B9CMGL
	kqcEjLicLDR0/E9Dnc1BQEsgTMLgqSIGst+dRvC08DYBj4oqaCiubyEie/wFrSPfCcj3mRjo
	NnQi8NUGKbh4KBeBrcZPwyeXgVq1GteGPpDY2V6M8HXrMwK/OvODwP6ahwS+daGdxSZ7Kq4s
	jcYW12sCZ/t9JLaXnWCw/fNZFre1uhjsLRiicGXxQfyqshBtnrFTsiJeUKv0gnbByjiJ0lFi
	RskWcVreP4N0Jmpks5FYxHNL+EDAT40yw83j/f4wOcpR3CK+L+iJ5CUikns8nq+uLCBGhUnc
	33zNuXtjTHFz+GF/cKxByi3lHxqrqF9DZ/LlFXfH8mJuGR+MnHyUZZGa0BsnfQZJTGhcGYpS
	afSJCpV6aYwuQZmuUaXF7EtKtKPIO13J+J7nRP3Na9yIEyH5eGkylaGU0Qq9Lj3RjXgRKY+S
	Ys8BpUwar0g/IGiT9mhT1YLOjaaLKPkU6brtQpyM269IERIEIVnQ/lYJkXhaJlJ8zo/xfbGt
	T+852rvDvjo1ljkuVpru3I3aHF2ys4l2V3VXtz+4nKa2dIn/ne15ND827uWfNvuWqZ7QXNq6
	ldYzge3eTSfXJqjNJ4OJE1p2xZsD28pm7dqW1/Q8JcGbpfFcHFjy+NLunt19DcnzUhzW2OEd
	2fUDf1xLashp9cTvfSendErFomhSq1P8BMLy5gNKAwAA
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
index 611e7f65291c..2b80591981dc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -898,7 +898,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
+					ns->page, false);
 		ns->page = NULL;
 	}
 
@@ -1126,7 +1127,8 @@ void nsim_destroy(struct netdevsim *ns)
 
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
+					ns->page, false);
 		ns->page = NULL;
 	}
 
-- 
2.17.1


