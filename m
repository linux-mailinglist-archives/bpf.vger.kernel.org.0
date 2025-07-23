Return-Path: <bpf+bounces-64170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9AB0F52E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA757AF4E9
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E492EF676;
	Wed, 23 Jul 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIXRz6GV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227A2F234A;
	Wed, 23 Jul 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280625; cv=none; b=QTJ1hQGl2zrdWIoQldW/0eV8vMAFo9qIK2yLtntoBxSEIW3mR/f1zDvPEwQK8SXMp5E0Rj2m8F8IPDsAL2HSde2y3TGJsh/mxlJBQRqL9RRLIcTyoTLTp/Asri4pzlFXmc6BVmhbTVfMyi1/NvG5XoGROJwhHQGg6+V70/v0YmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280625; c=relaxed/simple;
	bh=jQuBTcFEbFY3C5WrbpT8N6fRotkgoLuGGHsQ/P9OI7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAXQX1oErn0H0b1an7YJUtowwJFszAQ+X7TbN+A7O8VrMIkb8IWnMCHNehZKz99NTUAWx2UpS2Jlzn/UsmMCjsREGIVZ0QUryO3qmVOYWzYUk0jNl6NxId78KzrpMNhfGpxXwsQxG0piot/Y/gMI3rbcVoDVcGQHF89G1bnEFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIXRz6GV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2349f096605so77471865ad.3;
        Wed, 23 Jul 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280622; x=1753885422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOntRSgVHCcFNpsuQ/f1gCdqRlv/yon0haOEPks1Dwc=;
        b=SIXRz6GVidApQPrQBT4EuPRp31nuHuc1tSF+L2W/vABR9h6+Yv2qwODMtyd9bBTunN
         QRqgnSe6LwQJrg/933q/H3WearkmRX3WjUu74cWVET6OQ+jUBC4OpFIrzwZp9g1LTYmf
         uWnIhEXtAXKZy3akz+pLFs7vLpJkL8K6DQEuz30Zatj2d1HgMyh/MHGybr8pKLL/OC9B
         zxRdhA729va2AlJv7fKozhgGwsqAMVNFYfu2Ldxdjq/m4dApd3MlCYLKZ2l3e9zT/Kgn
         ymAA0d5QbLVLcbwVtzO2NOMEqNfpwOtIOCwVl4R8zA6uYysC+0up7am6ebv9GHH4L/wq
         /W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280622; x=1753885422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOntRSgVHCcFNpsuQ/f1gCdqRlv/yon0haOEPks1Dwc=;
        b=I8MO4mXM+jaHCSzVVaCPlmNMgYZUIpdhaRls8BxUjWKbnDxfEdSvp26bFI/PwxbDA0
         Yz/6ssrA+L/5H330mE5fa/yzos4bHc2SqCeksGsa4C8nlW9DLrKj1Fzjzy9/Fop/d3ZJ
         8nm4j19QJitrPwBwNXgyc5fCbP29+WNc7SJAHQCu3HL7qv9DiSDi//gfWbJrs/C9mVCZ
         0vRqSINZR9Xb0z2hXwhF5IPdliKhtHaesq0BvZKf/l43aLyFdqQpP4HMSRz6HgvB9Y7H
         MCBD7Gf1TsaF4Eh+8g6Z+MvwFcQImozBVNeOfP9hSgG9ftdJlu9fmqgJTcT0DGAniwAJ
         V97A==
X-Forwarded-Encrypted: i=1; AJvYcCXVKfbv4OQ5esW1hHpkRWmFkLWztlWoU6igLwowwLUOCPdOlmnUcuJfCNkyKRboB/WHevU=@vger.kernel.org, AJvYcCXxD2jLfWODDTmSJ8Qb5o1US051Lqgf2c4CGMb7RogWpl5AyNFnWzLGl6kvisgPKP7zHtYRDlU0@vger.kernel.org
X-Gm-Message-State: AOJu0YyIB5QykxVl1km+S5LxVeT36+w4R1SdL9yL1EF37hPq8TCx3dCW
	nCykJFG6+POFcbIKyHxbYusmyxojKr1xF5OTc+fBwM0y4zst7BRkYzT+
X-Gm-Gg: ASbGnctEhncFB2J1QG3GIWDqWZvNUdP1yAk9GEC6qe37S0Xp29qeKaPxwSHNvWjYp1N
	2JXdjSTCFnKi1d9DqYFAcpo/ICgbFnvfXfK2juFqnx2EB4J+n3cDS7dvLu9lxpL9bReulKeC3Xf
	NUq70f5vLU19NX8iEQ6KlkGpueLAC+YMb0ad5Xt9m69SGWcCFpGqimFEtTtChy6+unF/J7W0VdK
	II4tm5REbKdvdH3NjbSrXWq9+6/BammPwujS6w6KxzopYpvK+d3wFJhGfg47ShV4xL46jf9ucJc
	7BCCir0Qcl+SnCFdP/U/tUOFZW/zVuAj/adW+LkL04uzDcfyRqEY2fMJjG72rHGVCJf1LgAP7xr
	Re68JlbOGgiugDLzy5j/KT8NfvAbVp1opDAS21Ns85777kBi8ei7vdtQQxq4=
X-Google-Smtp-Source: AGHT+IEMb3cIE20x0EQZMiLUrQDv3ie1esxuOFn0TXUcPb/jILtixQh8nGa/Jmj0cICBmpX2znYZ0A==
X-Received: by 2002:a17:902:f707:b0:235:c781:c305 with SMTP id d9443c01a7336-23f981932f0mr50241695ad.24.1753280622164;
        Wed, 23 Jul 2025 07:23:42 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4a9esm97929595ad.93.2025.07.23.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:23:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v3 1/2] stmmac: xsk: fix negative overflow of budget in zerocopy mode
Date: Wed, 23 Jul 2025 22:23:26 +0800
Message-Id: <20250723142327.85187-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250723142327.85187-1-kerneljasonxing@gmail.com>
References: <20250723142327.85187-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

A negative overflow can happen when the budget number of descs are
consumed. as long as the budget is decreased to zero, it will again go
into while (budget-- > 0) statement and get decreased by one, so the
overflow issue can happen. It will lead to returning true whereas the
expected value should be false.

In this case where all the budget is used up, it means zc function
should return false to let the poll run again because normally we
might have more data to process. Without this patch, zc function would
return true instead.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v3
Link: https://lore.kernel.org/all/CAL+tcoAnB+8ZLPyWQ3XsvWTa=JO1yCKWvrKVp+2WCP=kGpfSPg@mail.gmail.com/
1. collect reviewed-by tag
2. replace 'underflow' with 'negative overflow' in a technical way.

v2
Link: https://lore.kernel.org/all/20250721083343.16482-1-kerneljasonxing@gmail.com/
1. target net tree instead of net-next
2. revise commit message
3. use for loop to replace while loop
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f350a6662880..f1abf4242cd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
-	while (budget-- > 0) {
+	for (; budget > 0; budget--) {
 		struct stmmac_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
-- 
2.41.3


