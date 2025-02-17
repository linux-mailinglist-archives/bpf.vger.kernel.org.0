Return-Path: <bpf+bounces-51720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E49A37C3D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60F93AFEF0
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF218FC65;
	Mon, 17 Feb 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU3cbEYq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE118DF86;
	Mon, 17 Feb 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777514; cv=none; b=shOMbo4k1Opl9GMCaul0fqlCDbk9Sx22wQn9OYM09OZHjCP9kQaOcAHC8jofpdPkD8E5302aSYhuwux6W+02A8m0PLoeMc6ksZhN+iVaKnWCH57QiyDvQtwKB0SQQ2E9nXYLr210r4qr/Rsx/Mv4sERKHqJxKToZub4KNl51yWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777514; c=relaxed/simple;
	bh=4Dwuc9WiZ1k2pmniN6lQGfsv8ylh1rFZMcHg0ghFFJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVu3JtakqDQYuPUKmObFM90kXwVtYCKrf31Ev/f/Soo3yGSZD9V7/Oohbwune6e9N45sm8IvO5rE1L1Vg3KyNlLh2gZM49tBQD/1BV0T39v5pgqXrMa703vWT80p09/fltgBwIgeOuYqWVutXgR1EVnG+nUQ18d4FFZZ/14w2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU3cbEYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939F9C4CED1;
	Mon, 17 Feb 2025 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777514;
	bh=4Dwuc9WiZ1k2pmniN6lQGfsv8ylh1rFZMcHg0ghFFJk=;
	h=From:Subject:Date:To:Cc:From;
	b=IU3cbEYqlIx2EX7yHm5TINEvSKuAKUMYLNOb4Llh/L/WPun6erjh1+TI96+SOq78B
	 gvRDIqkvqFBGnr2kpFGnigvc1GvtyNOYbM0tuckVIuZrDMMOtqwHPu45O879z6T6kP
	 k6+1xH867VFSOMhpBAzlh9+pjv4M2eJYY0nKGn6D45YlIURw5qk614/U1nQpq66bfZ
	 5qw5j6SJa/9EVHlSFKueKeJrz8/vfA388yqUElor2f+11XTAaoo3udYWJWUakmtXeC
	 nkxuAYsiW7xEf+XWd4hERkDTGS8UnRUPKJtxQjo3RsAa7LiloGdjJpzABFSiizdf2W
	 f7ZmvAElcMRiQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 0/5] net: ethernet: ti: am65-cpsw: drop multiple
 functions and code cleanup
Date: Mon, 17 Feb 2025 09:31:45 +0200
Message-Id: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHlsmcC/x2MQQ5AMBAAvyJ7tkmVKr4iDlKLPaimbRDi7xrHm
 WTmgUCeKUCXPeDp4MC7TVDkGZh1tAshT4lBCqmELCoct1qhceHE26Dz5FCUjdS10i3pElKX5Mz
 X/+zBUkRLV4ThfT+Bc8zhbQAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=4Dwuc9WiZ1k2pmniN6lQGfsv8ylh1rFZMcHg0ghFFJk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXltlGSEAdQBwDIAKP2KBCfDwIeHRbuXhayD
 JxO9//0DrqJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5QAKCRDSWmvTvnYw
 kwbYD/4+fZilffxaWgy4SA+Elw8wanK51v8dZcnotRawL9HNaxc4516zfKAVPFENe7PrW236TuV
 ptw6Na9c6ol9CyvJG7HNyBwbPlK3zly2CxUbpR34Cj7KBVZATyCqGDoujmeTiKWyyDzk2Zxuyly
 ewWHoCPmlL5bNtVwKm0QrD63Ca/BvLOOp6sLOP7Z4SxN4JhVvDVZrDq38xynBjqNrE8T/cGTtlE
 0TI0AAecWZE9xlPfa2tkQiXzdLWqYqkOKQTKqVWeOvjqcERkoH/4atS6ec/uDZd4nmoWaq1RhY0
 ehIL6x/W/E/FL4zL9TFhDxGP31XMrdUgCMQAmQhWTeKfAW4Uzs8/lruIx2J4TJR1Boj38IhPs9J
 FIXMi1Ff+H9rqky3eiC9isiHIkEicoCEJhx+cRQ5Eu4pQP2DdyopLpxpnrmFNKliFvnCsUCKYRs
 n29iM+PZSijMEIYTHokqrgj/XpnWBMWJpxDSBneel3fJ/eB5iVwG/XBpDcDKzDoudxYbnSH8LPe
 +5Af0Rbk3Ld8JnTNR13AnXRrDPNorm9f5XGEAfyq0H0yVPEOzazs7C+jmw3caq2cnctT2PUez9a
 8UoX53sWOrEDRjDHyTqyrlbdVh3iyee/xVmZTEMs6TRKwqLDBCIlKgWnIFH9Sa2yjFh5jbVzPJs
 DRqrYpfy6cNyghw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

We have 2 tx completion functions to handle single-port vs multi-port
variants. Merge them into one function to make maintenance easier.

We also have 2 functions to handle TX completion for SKB vs XDP.
Get rid of them too.

Also do some minor cleanups.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (5):
      net: ethernet: ti: am65-cpsw: remove am65_cpsw_nuss_tx_compl_packets_2g()
      net: ethernet: ti: am65_cpsw: remove cpu argument am65_cpsw_run_xdp
      net: ethernet: ti: am65-cpsw: use return instead of goto in am65_cpsw_run_xdp()
      net: ethernet: ti: am65_cpsw: move am65_cpsw_put_page() out of am65_cpsw_run_xdp()
      net: ethernet: ti am65_cpsw: Drop separate TX completion functions

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 211 +++++++++----------------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |   8 ++
 2 files changed, 71 insertions(+), 148 deletions(-)
---
base-commit: 489b31c6cf29fff5b1f5c48625770f45cea90ada
change-id: 20250214-am65-cpsw-zc-prep-038276579e73

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


