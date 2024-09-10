Return-Path: <bpf+bounces-39419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94847972D71
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BB3285284
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66775188CA8;
	Tue, 10 Sep 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpITt1oN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C461862B8;
	Tue, 10 Sep 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960251; cv=none; b=m3hQSLLid++3aIAAv3qLseKFpxfBIPZ0OjjQTvo/av+/fEktJMKt6ZFOd1gOpR8sh9Kb811P7zPNbD2XlDjB5xrfZFXg3BEWTfqaRdw9vQQ2BN8N2tahI6LMOLuFWkrUnnZ53J5Hq13jhN7uNihAU+IE6VXf7ScN2uVsTYLTwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960251; c=relaxed/simple;
	bh=q7XPAagp/JPud80GLii65MDVEGWN1lLrpC+Q7P3qjVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OV5bF8foLy6hk6zI61MbZ/qiAF+OGUwAE7u1A4teIcQwrpIG4fAXXVMB9NrvO1nmhQR29TTTKvtsqwQ/hDqbJLgkd4KVmOTBkbIKU4q1zrSUfoBm1OWDbt6LxLBqcWlqgHuHJX7SUpUoH175MlYY9XAiQSqv0ontxfFbr1Z10lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpITt1oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB274C4CEC3;
	Tue, 10 Sep 2024 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960250;
	bh=q7XPAagp/JPud80GLii65MDVEGWN1lLrpC+Q7P3qjVs=;
	h=From:Subject:Date:To:Cc:From;
	b=QpITt1oNHtiXMDeSbQRnCYfoQqmfuRJtkF33sF7v7DOkgFMq+w1iP2RPuvuGUOGJQ
	 8kAGNqdsY7kN25ZVWKngBbNYe/4UxRxXY+iYgPkmJamb9gY6T0jwTydxQBm4JZntIK
	 HSRcQXDuMAx6lhrGFOfI97LE3FTiG3ntORa2sHTgjY0HIWNC5eLTaX0FAZ8Qpb0RhZ
	 GtnvePk+eeWvheF+tOjCJMz5Uyi56inxzOEvAdCbJQIfGxXlZ7cHwmqG+YunzrdOAP
	 W83dGoSFTOWSDXsHcN5eAVFe2QnyXJ77CvometssMm5jSsIjil1jkRVGw61BohZkvW
	 utLm1MolMkKfw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v4 0/6] net: ethernet: ti: am65-cpsw: Add multi
 queue RX support
Date: Tue, 10 Sep 2024 12:23:57 +0300
Message-Id: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0Q4GYC/33NQQ6CMBQE0KuYrv3mU6BFV97DuKDtrzZqIS0ih
 nB3GzZqJC4nk3kzskjBUWS71cgC9S66xqdQrFdMn2t/InAmZcaRFyhQQH0TJeg2PuB2v3YOwgB
 WCW0rQ3VJiqVhG8i6YUYPzFMHnoaOHVNzdrFrwnN+67O5/wf3GSCgxEKhVsIavb9Q8HTdNOE0e
 z3/MHi1aPBk6Hy71UpKo0rxY+RvQ2K+aOTJsFmmTSXQGsm/jGmaXuRyA21HAQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Joe Damato <jdamato@fastly.com>, srk@ti.com, vigneshr@ti.com, 
 danishanwar@ti.com, pekka Varis <p-varis@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=q7XPAagp/JPud80GLii65MDVEGWN1lLrpC+Q7P3qjVs=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA0Za3QLGXOejHQi/umCfw73L4Wynx2DjZ6G
 y/Na0KTS5WJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNAAKCRDSWmvTvnYw
 k6cmEACuwPO5dORXhbjaS68uUP5gAOB+Gt2TVWd2b2cOxRdGjY205hKsYyjHFWsjjUeiF0CJOCo
 SpLOv6W0r+P6U8vJKc5YQUxjKE6l0niqm+UWbRwFE4XxgIPY4nmXSRaL/Lqq/7/SIzCteQjtjXu
 bv6lwNHdDH6yEf/nKSci5i0gxqJgD1imD0oX2Au2Lbpv+ngoNg3JnoYS6TszSIg4+JZFLys0S58
 +/Qw1gOjPAPbhrazj+Goh0WGSRZYp5QCrFT0wM7j4J03Kp4+ERLsgKcRcKruf0tYJhw6zX8p/mO
 Mseb/JDopoXPpPmtlwk9X1m92YFjOgZ0kQuKzJPor2wNIJ9pzoXoEY2mJtHNLWiZWRwodgP1be5
 NFnkkrVRo2Nz2u2bHRrO+qsRU3Q3xqGasK5gR9r7AjqI0V28wd0rZCg3cytcJRjXuW6EkuTtkUX
 CsS9dMFUx8oRIMWIUqxwOKNOqxLg2X51fY+cOHmdnxzWp1fQ3E2ZepplH2JHJTdHBtxN3ToVv4x
 oKZ0IgDLOI8nzt5FvDi6hx0zNWs43WpoTN1ehVo6BqGeUdvaxfuTyVn/56Qifus0HX7U09JK6jw
 YJqxi6hLubKEqt9cxCXRsMFMrbcFxdheNK06sr5F5Tj6DLNTmB5mDdIkQORqet/mP06vFmlXs0m
 szC98p1a50y9AyA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

am65-cpsw can support up to 8 queues at Rx. So far we have
been using only one queue (i.e. default flow) for all RX traffic.

This series adds multi-queue support. The driver starts with
1 RX queue by default. User can increase the RX queues via ethtool,
e.g. 'ethtool -L ethx rx <N>'

The series also adds regmap and regfield support to some of the
ALE registers. It adds Policer/Classifier registers and fields.

Converting the existing ALE control APIs to regfields can be a separate
exercise.

Some helper functions are added to read/write to the Policer/Classifier
registers and a default Classifier setup function is added that
routes packets based on their PCP/DSCP priority to different RX queues.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v4:
- Use single macro AM65_CPSW_MAX_QUEUES for both TX and RX queues
  to simplify code
- reuse am65_cpsw_get/set_per_queue_coalesce for am65_cpsw_get/set_coalesce.
- return -EINVAL if unsupported tx/rx_coalesce_usecs in
  am65_cpsw_set_coalesce.
- reverse Xmas tree declaration order fixes in cpsw_ale
- Link to v3: https://lore.kernel.org/r/20240703-am65-cpsw-multi-rx-v3-0-f11cd860fd72@kernel.org

Changes in v3:
- code style fixes
- squashed patches 5 and 6
- added comment about priority to thread mapping table.
- Added Reviewed-by Simon Horman.
- Link to v2: https://lore.kernel.org/r/20240628-am65-cpsw-multi-rx-v2-0-c399cb77db56@kernel.org

Changes in v2:
- rebase to net/next
- fixed RX stall issue during iperf
- Link to v1: https://lore.kernel.org/r/20240606-am65-cpsw-multi-rx-v1-0-0704b0cb6fdc@kernel.org

---
Roger Quadros (6):
      net: ethernet: ti: am65-cpsw: Introduce multi queue Rx
      net: ethernet: ti: cpsw_ale: use regfields for ALE registers
      net: ethernet: ti: cpsw_ale: use regfields for number of Entries and Policers
      net: ethernet: ti: cpsw_ale: add Policer and Thread control register fields
      net: ethernet: ti: cpsw_ale: add policer/classifier helpers and setup defaults
      net: ethernet: ti: am65-cpsw: setup priority to flow mapping

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  75 +++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 388 ++++++++++++++++------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  39 +--
 drivers/net/ethernet/ti/cpsw_ale.c          | 287 ++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.h          |  62 ++++-
 5 files changed, 594 insertions(+), 257 deletions(-)
---
base-commit: bfba7bc8b7c2c100b76edb3a646fdce256392129
change-id: 20240606-am65-cpsw-multi-rx-fb6cf8dea5eb

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


