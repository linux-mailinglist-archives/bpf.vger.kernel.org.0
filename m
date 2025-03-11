Return-Path: <bpf+bounces-53810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC461A5C0D0
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BEA17783B
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB82571A9;
	Tue, 11 Mar 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg9XgULl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF5231CB0;
	Tue, 11 Mar 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695538; cv=none; b=qsEswEFtbcFXb9vmAH6+7Bw9LVqG2gw11kT5t1HEadVLrWahaFjFkd8Q2ihiK/h2Qqo1b00dWaAm3+FG8MCh1ox0Nql7nODVdVaeU541PYoQqgS3pLaARdbgtScLirkCZwWWg7AblhoeQPWKo8S245ez48xcwYU3cy1SRnVBSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695538; c=relaxed/simple;
	bh=cxGH/8yoDlpE4cyb58o3A+GZk4q5gxWQrv+6hcsMkZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Av9JpCVjdYsIqmdAkPjamvM4U8mxCann3gHTA9CWGZlSNM1nFlhmESM339verZRtxs1uLptvooxgP+upQdS23tCFS6nh5FZvBMFDykkZZDi404nVg+qnLomegCuXb/6jXakZeMsvT7l6k6BqtnLR+hv66ixDmoYTnHlVRrkxuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg9XgULl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B9C4CEE9;
	Tue, 11 Mar 2025 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695537;
	bh=cxGH/8yoDlpE4cyb58o3A+GZk4q5gxWQrv+6hcsMkZc=;
	h=From:Subject:Date:To:Cc:From;
	b=Qg9XgULlvTkmtg0c04NCeS/POwdITsEwNTU9JRDvynwh/TnYiS0cSjFsMIB15EhBm
	 R2wy51d1AFWimBfb/c+s3+6Pz7vGcOBuJtqhmkMDrTVB/3rLjOIYqdl2vab1jLUhzh
	 KpP0eBgLPkrob502RZxRbwxJ4ROcA+OuiW8LE1/6Kon/S4SU64Do0vTdkVew+wdViW
	 y5/RoaK1YPKyAjRH6HHnxr6K5mypKvgeikxkc7l4xEfP8QPXTYAu5ztwMQApm8YYQK
	 18ylxNuTJ5TaqVT6OvLrx9XC5w9g/DFbgzyJPTsTEEElk9hIWzWV0QI0q3Iu89Iuq4
	 BY6R1kU88xxkQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
Date: Tue, 11 Mar 2025 13:18:32 +0100
Message-Id: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgq0GcC/x2MSwqAIBQArxJvneAvsK4SLSRf9RaaaIQg3T1rN
 7OYqZAxEWaYugoJb8p0hiai72A9bNiRkWsOksuBK8GZvwNelhUXmf9AIXfW4Kb1aKBVMeFG5T/
 Oy/O8CTjfnmEAAAA=
X-Change-ID: 20250310-mvneta-xdp-meta-3e0da8ef4498
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce missing metadata support for some xdp drivers setting metadata
size building the skb from xdp_buff.
Please note most of the drivers are just compile tested.

---
Lorenzo Bianconi (7):
      net: mvneta: Add metadata support for xdp mode
      net: mvpp2: Add metadata support for xdp mode
      net: netsec: Add metadata support for xdp mode
      net: octeontx2: Add metadata support for xdp mode
      net: ethernet: mediatek: Add metadata support for xdp mode
      net: mana: Add metadata support for xdp mode
      net: ti: cpsw: Add metadata support for xdp mode

 drivers/net/ethernet/marvell/mvneta.c                  |  5 ++++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        |  8 ++++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 13 +++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c            |  7 +++++--
 drivers/net/ethernet/microsoft/mana/mana_bpf.c         |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c          |  4 ++++
 drivers/net/ethernet/socionext/netsec.c                |  7 +++++--
 drivers/net/ethernet/ti/cpsw.c                         |  6 +++++-
 drivers/net/ethernet/ti/cpsw_new.c                     |  6 +++++-
 9 files changed, 44 insertions(+), 14 deletions(-)
---
base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
change-id: 20250310-mvneta-xdp-meta-3e0da8ef4498

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


