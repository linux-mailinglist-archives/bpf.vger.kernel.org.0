Return-Path: <bpf+bounces-63876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E6B0BAA7
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE89C189CC54
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500525A337;
	Mon, 21 Jul 2025 02:18:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A7226CF7;
	Mon, 21 Jul 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064338; cv=none; b=PjmEhH4SIlySUNiBQfJmW60Y82wg9+mtB7HETyy22hWTmtPx9p0NRQez2B6+aXnM5Do3Bi9CJZyK750Tx3cgVkL2fXgSTTnEKnvK3XvUgzQ4M6vKW9uZWufcXqZVCgzdg/VJfVdlxy7i4Hr7vC0vpTXJAyTyeEhdm4K3lorHrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064338; c=relaxed/simple;
	bh=TLxhqPJIfz3AvMf0ahyEZem0BqxOUvOB+Lo/b4vtNoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IRH4QebThzz6li2ya8EuZZz7A+7WkWqie7l+c88QjQxs5yE51rbqg1c/7q0wBsnj8iw+0qqWm1af08K44Dd/Ep/hVCcowj7b200MPY4GLpSw7sCPVVlPYmUmsMWpEeElx+8nUnUJRMxFLdHGpelJ3ITO1vUYm92EkYz4djMu2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d8-687da387e959
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
Subject: [PATCH net-next v12 10/12] mlx5: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:33 +0900
Message-Id: <20250721021835.63939-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b/3dm3ypjb6rotxaWIwOpmILkezqXFf/h9mosHE4CWukTdr
	Y6mklY5iiKhFBplgNjSgNVIBpdRY1k6pUrwUQvEOpWIZNy1iUKtDUNYCylqN3345J8/znJNz
	OFLRS6s4nWGfaDRo9GpGSklfyezLimsKtMtLXnwNNtcFBrom7DQ4Y3lw/rGXhqBDgObOGAG2
	hssI3sb7WHCX9JMw0RZgoMY+SUK88SgFtgdWCt65pkgYaY+w0OF/T4HTvRGGzj2jwFfcRELr
	u0UQKe9g4Kh1moSqwSIGZv+ZpqEl/pqFQ956AlpeXmKh83IZDRVTdSQ0FT5OZA330NB91cZA
	9+EuBIMXZml45k8ERuv7WShznkTgv+5g4JA1HaKX3rIwdryNhKGy9fCh0gzt1fNg8k4UQV/d
	QwJmfV4W7g9epKHN1URA6EmchMnfTzNQ+qocwcOqqwTcPd1IQ+2dEJGYIwN6ZmcI+DNYzcCw
	dQhBsDVCwamDZQhc18I0vPElVp6O2Zj1G3Br9F8SewdqEf7b0Uvg0WMfCBy+dpvAV04OsLja
	nYs99Utwje85gUvDQRK7G0oY7B7/g8X9PT4Gd1ROU9hTewCPeqrQpgXbpN9niXqdWTR+u/Zn
	qfbE7QCdE2LzvLHf2ELkYEqRhBP4lUJFYzH6zL1XXtJJZvgUIRyOk0lW8mnCRCRAlSIpR/L3
	ZEKLp5JINubymUJR+amPRhS/SHA8+Ssh5jg5/50w9WbHJ8+FgrPxxkcfSaIcSVw/yQp+lRB9
	4aWTngJ/RiKcbwgQnwRfCjfrw9QxJK9GcxqQQmcwZ2t0+pWpWotBl5e6e2+2GyUe7lzBzHYv
	Gu/M8COeQ2qZPIcq0CpojdlkyfYjgSPVSjkO5GsV8iyNJV807t1lzNWLJj/6iqPU8+UrJn/N
	UvC/aPaJe0QxRzR+7hKcRFWINMtHRzKPOyx1ZwU9pO2n86dkXYoS5/W0PemLU5Qp1nGLccua
	3KKZn8btoUesY7NUudX/NPYeHlTY96s6ohKlymT6Jnr4B9Y80Le6vc5wRPpF82b5j46xZbc8
	wxmuEcPOYHRC+mip/b9MFUfmXNzFhc6uay4ckKWmj/m6K1+rKZNWk7aENJo0/wMuA3g+bAMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0iTYRTu/e4uRx9L7MOiYBCBkSllnK50+dFLUET96EJkI7/acJpsJlpJ
	WrNUastuaCloam0aarN05bowRS3TbF5Y5XVWlK7MpsupuWbRv+ech+cC53CkrJoO4VRxCaIm
	TqGWMxJKsmv9+RUXilKU4aOZayGv4j4Db92FNJRNJMG9fgsNdpMAtW0TBOSVViMY835gwZzZ
	TYK7vpGBokIPCd7KyxTkvdFRMF4xScKnBicLTbbfFJSZd0Lf3c8UWC/WkFA3vhSchiYGLuum
	SMjtTWfA936Khqfe7yycsxgJqMt/6R+HH7HQVq2n4fpkCQk1qf3+wMEuGtqf5DHQfv4tgt77
	Pho+2/ypLmM3C/qyWwhsz00MnNOtAtejMRZ+3KgnoU+/GWZyEqGhIBg8zS4EH0o6CfBZLSy0
	9pbTUF9RQ0DHgJcEz6V8BrK+GRB05j4h4HV+JQ3FzR2Ev8de6PJNE3DNXsDAoK4Pgb3OScHt
	ND2CimcOGkatOmrzNlznGiGxpacY4YemdwT+cmWGwI5nrwj8+FYPiwvMJ3GVMRQXWb8SOMth
	J7G5NJPB5p9XWdzdZWVwU84UhauKz+IvVblo9+KDkg3RolqVKGpWbjoiUd581UjHd7BJlokM
	NhWZmCwUwAn8auHd42F6FjP8MsHh8JKzOIiPENzORioLSTiSbwkUnlblELPEfP6AkG64/VdM
	8UsF08ADv5jjpPwaYXL00D/PJUJZ5Yu/PgH+tdN/8Vks4yMF15CFvoIkBWhOKQpSxSXGKlTq
	yDBtjDI5TpUUdvRErBn5v+luynS2BY21b7chnkPyQGk8laKU0YpEbXKsDQkcKQ+S4sZTSpk0
	WpF8StSciNKcVItaG1rIUfIF0h37xCMy/rgiQYwRxXhR858luICQVHRM07JlZebpsOB1M4cC
	Mx7YFvl2K9La4n//Slq9vFzWbHRfH5GGhF9QN5UMdUgbiGqV3pkQut8QeaC5xtV/eO7GcM28
	7tKtnj2enSPTPY6Dy63txm2OzuyUdPudoX5DhjHmTJ/bY3GkBkfPjdIuXKHMnxqnF8+f56zN
	Lmz9aH7vk1NapSIilNRoFX8AjoMWi0kDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mlx5 access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5ce1b463b7a8..5d51600935a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -710,7 +710,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check page_pool_page_is_pp() as we
 				 * know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
+							 page);
 			} while (++n < num);
 
 			break;
-- 
2.17.1


