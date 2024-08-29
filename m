Return-Path: <bpf+bounces-38393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD49643D1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67101C24986
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93419882E;
	Thu, 29 Aug 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9gDTucm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21E19597F;
	Thu, 29 Aug 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933020; cv=none; b=GZsWloHDE2dVI7ckHX4l0nZvpSwnS4zdgMrWDLFgkN3gE0Wjt3rfe+FPz9Bn0DXYBJsI9FwbqrpnSGQqrVWjD7ebKLHFqtc6Hhr9MK8MhDyp7s8O3tL71sAnah30qB02lXHVK+eUcqrK1qILiCrDD3WZz7DzI18WDPo0DtZ1OXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933020; c=relaxed/simple;
	bh=/dyoBxa9xJHe968sZ6tJXhoil32Hg5rPtRChLxVz/ds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZUJsM8SN2XCBg2RGZx+04gUQxV1vsU4jHDtcjl6NnFQM2OktSplccauC2C0NAHfN+QQblOgMOiZP+9KEYFJTqgo6njI1d2dQbpfP0eP3PUodxNJGxsFQzuNE43YDaXPlaE3nxEJgkvPSLDVarDutRGy4UOAIX9i4c8OLg+dPzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9gDTucm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B64C4CEC3;
	Thu, 29 Aug 2024 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933020;
	bh=/dyoBxa9xJHe968sZ6tJXhoil32Hg5rPtRChLxVz/ds=;
	h=From:Subject:Date:To:Cc:From;
	b=n9gDTucmv9+3j71iCjG18iod/fHfjSmm+FwP50Vj0sA2oNiIZBVfBZS/OvUbNlwbb
	 U9wqrUOWj7lz/mDoN6Q7IczpBolRAE7YLh1TKrKhFKFz2cXfLcUZBBH7NkQsROuBCy
	 HcNcrRUwz+QKgwEz82gUeozT4dBNdBrOKGlcCsb5zyDy4UilEwtXEOoTgsdqsVwcSJ
	 VLGYttbOY51fgJ4Oy7Ptc5d4NN5vHA6d2bUXi+A/7TknPujPYmfihI31qAb8vH99lN
	 KPiBYt+Qz/WvBJMNoSxGgw8NmCmMdhWJuyzrVjtsAMe34xmXOKsAk082JnpfAqBTnN
	 XfOw6PEpisuEA==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: Fix XDP
 implementation
Date: Thu, 29 Aug 2024 15:03:18 +0300
Message-Id: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZj0GYC/x3MTQ5AMBBA4avIrE1Caf1cRSxoB7NQTSs0EXfXW
 H6L9x4I5JkC9NkDni4OfNiEMs9Ab5NdCdkkgyhEXbSiw2lXErULN0bj0Mi2UbOQVSU1pMZ5Wjj
 +vwEsnTC+7wdTm9zqZAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=/dyoBxa9xJHe968sZ6tJXhoil32Hg5rPtRChLxVz/ds=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm0GOUMUbRIWAW8V+AZ92F9m0ddcj6xfm/3ILEq
 6fmuNqR1SGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZtBjlAAKCRDSWmvTvnYw
 k4qmEADZiuLMD1lv1jMoUNHWCpx/SuLclcc5gM1R9lMXutp2hZZRWpKmkH7MjBO3iceiLg2wdnl
 DC0LkhgPMCgYKC6mUD+ZVCDbaAlUL4EkCraAUdl6RV3VY0zxK5PcD4rD2UPRU7tY192YLxUYAlu
 +BKrc6ltkZvIabKgZyamMDPMvZuKArEWE6234dOiQJ0BbpH11nn3eKpH9zCCJxrsa0dOvCV9naA
 pCiIec5OFrHKM3KlZ9/79LGCvMqqfcEV5GIIBD2us/UWzvMxfWxvKNuQ0+roghy0L+ItBuVjRUx
 7DyKMmwKutCNCTIOT8rdkopONK3VRaHUzsuTN8BWtr6/poSU6lZuf2902M33dqF2NJLi6Orgsj5
 iAGrFk0uUTVfIsEDwgIgAcMachDiBfssq3O18h3uNNOaxMPWT9t2P+j7N2YHZJKWq+TV98qeAsB
 5n3wyX6pppXlj4P97004Nv+EjlRyQfnQSqqzhx67sdTn9AbO61dKf4cIReX26bXnaofSXdTaGDA
 xrcVSs7hAUUwRZ34XXQ58Ptg/kkh83tB65zAkoPjCr3Y9AhfYE/fdLimHRPzdHSFAAIB94sbXI+
 DtTu3CddHJWG5N1IMfxQooO+ElUk6TNEppp3kWs3sXR9uKRD9IObhW5l2owRrMcpXgNUIcrkh36
 lWrLd+qJGbPPozg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The XDP implementation on am65-cpsw driver is broken in many ways
and this series fixes it.

Below are the current issues that are being fixed:

1)  The following XDP_DROP test from [1] stalls the interface after
    250 packets.
    ~# xdb-bench drop -m native eth0
    This is because new RX requests are never queued. Fix that.

2)  The below XDP_TX test from [1] fails with a warning
    [  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
    ~# xdb-bench tx -m native eth0
    Fix that by using PAGE_SIZE during xdp_init_buf().

3)  In XDP_REDIRECT case only 1 packet was processed in rx_poll.
    Fix it to process up to budget packets.
    ~# ./xdp-bench redirect -m native eth0 eth0

4)  If number of TX queues are set to 1 we get a NULL pointer
    dereference during XDP_TX.
    ~# ethtool -L eth0 tx 1
    ~# ./xdp-trafficgen udp -A <ipv6-src> -a <ipv6-dst> eth0 -t 2
    Transmitting on eth0 (ifindex 2)
    [  241.135257] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030

5)  Net statistics is broken for XDP_TX and XDP_REDIRECT

[1] xdp-tools suite https://github.com/xdp-project/xdp-tools

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
      net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
      net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and XDP_REDIRECT

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 82 +++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 33 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240829-am65-cpsw-xdp-d5876b25335c

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


