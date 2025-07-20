Return-Path: <bpf+bounces-63828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0EB0B483
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A031189B3E7
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF41EB5DB;
	Sun, 20 Jul 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmVHfFvu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E61E5B99;
	Sun, 20 Jul 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002704; cv=none; b=lkxtVTYzgeUcZmf9tJObuLUapaV05tNEOBXNtw8KsW6a6aeQgjC/4ug+7NQq3SOvSAsZmV+dUCfWsPt7r++6y11P1fr+jpH4idkmzF4oB30am/VrVOyb2rKKDs1dKh7vqijLjxcR6/LEG7G/D6yI16r5nkOhZHLqPs95uOmk8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002704; c=relaxed/simple;
	bh=EqaANTD7eCCyPBKHvF5QgrVPhgYT5UJUbFV+2xM0/5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohgHzkab6hh6qmO3mnSwed+loRBDOz+uvZuCtcS1SiGS4PHEsZ6t1u5bVcytA3VPXqX6mSI8jbaNVxHqPd9+Onpqf4RYAwxh4hXsUInKUNN6AFU1US+2Idr/6HzZf/7Y8tUVS+tPhb3/RZrrDhq/r2BGaJarMb2OJBr54g9zCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmVHfFvu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e92cso2312228b3a.1;
        Sun, 20 Jul 2025 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002702; x=1753607502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqFKurrhgXKGO68xSd3MOtKTSUiUpTZQiZZDyPjY9jc=;
        b=JmVHfFvun0Zl/ajlzJB0zc3ldbn6ar5GJ0yomWLN02J54v6CwzYEcMNx2EfILDoF0X
         ar+uGpYN4Qowwq7AHagCrJfxUEW3DkLf1sooeJem8VmxJkyyka8SXt4lqJb40qkplqd5
         0AjcAjfKjFakXo5gYCf9KeqyKIDEwQRuTK4VL7TkUjeWBrS28Hf2GcV7rhXOCxc8AOTm
         9MQKlptAkO34ayFJT2CAxiGUlhxYxU7eMnDXmp5NIwBKp3Xpat1bibzRZEjkmPF+jl6d
         8EFGbTDt5s/51UxLyQHpEyd2JRMkVSqcCWthEuTprK2aT1M8k7vBrcDTumvspZM5O2iY
         u8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002702; x=1753607502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqFKurrhgXKGO68xSd3MOtKTSUiUpTZQiZZDyPjY9jc=;
        b=l2cDETh4Gl5Sw+iEA1yCUrjfGe/9YMOqOmNzSWLU1kPpQ/DnoMtCdeM2YKXS0C+SsL
         UQo5NA+vPEzCjzoQlybgY76o02YpnxB8ux9ity+ieizLSG00pyQ/3ntY651wfT65YQVU
         Uy2g5caceQhiUbSdyPLJapR9EcJijdD+Ddr2rApL+rnoZ0OTOK1SBh07Jmo7FgdIOui4
         5j+M2mKc/nQ9eQ2LdlmVI6NGDP86he5FiqerGYxtOdjQvySG3aXDzyDURfoj+PdzIoxt
         OZ8LSc4zZl5IxDCC27Ft35EE0ugnYA95jYP5kbWMfCrKhVD1j5K0SX4l0T1GiguVzCSf
         njNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNRnU32/pZcht9yE2BBWu8EqK0Kxx6MDUMUqIU36PF1rP8kY8CV2C89Tbh1XyOLC2rrohLz1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXb5jAsq7jr3rFRpBrupbjoB5avpL6fexCtMW2RfZr1ijROr/7
	WmEO9dVLhGuAAYxDEFjlnWDPNxA2ygiePsJl2U0upvtj5wRTsKuq47DR
X-Gm-Gg: ASbGncsAOToOzOeuQeocWRxz2kQodB7yCsgKVWrcy5Jc78CBevMtiK9Mui5PjejkGHZ
	4z0rEt4MWRR7SRCqbcI7T5zZ4fq5wWwInrTY5+lba4BU8Elroj8Tui97v9ggLkOQt5MjwBzF5tT
	ycU9YBApJWg4qOar/j0TatmIFV2XlqrCsJwvz9DuSlgqMgEdUdWGlyiiyiZM0lNhf+0yQKO9PN0
	tZG/hyrNHOSMpssr3PSU+is4NBmKE4QK8mUjobxp/pZkXZTUcPurIV6T6rFdmk8CRlPfD9Ga3Ab
	NqXvUbA8CE64eRfxrEtLgsoOMB8OCDJjHMPLmdY49SvS0HSZaZkX8U+vl1W/sg8z8jBgjWz3g9N
	3iub6DCR8cskcf+RilsCEmlOiwWi2TDZnOeFzoqkBR8/UoQSumZamRlx/Jh67rYV/0Bd0IQ==
X-Google-Smtp-Source: AGHT+IEJ5FcxXi7E152V9I7QXWTjGS6Pd9anA1JjNHWubokETEfoWd1owh9KeIXXmgfMtvGvcqAZ0A==
X-Received: by 2002:a05:6a00:887:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-756ea7bf745mr21985436b3a.16.1753002702304;
        Sun, 20 Jul 2025 02:11:42 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:41 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget in ixgbe_xmit_zc
Date: Sun, 20 Jul 2025 17:11:20 +0800
Message-Id: <20250720091123.474-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250720091123.474-1-kerneljasonxing@gmail.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Resolve the budget underflow which leads to returning true in ixgbe_xmit_zc
even when the budget of descs are thoroughly consumed.

Before this patch, when the budget is decreased to zero and finishes
sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
and enter into the while() statement to see if it should keep processing
packets, but in the meantime it unexpectedly decreases the value again to
'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
true, showing 'we complete cleaning the budget'. That also means
'clean_complete = true' in ixgbe_poll.

The true theory behind this is if that budget number of descs are consumed,
it implies that we might have more descs to be done. So we should return
false in ixgbe_xmit_zc to tell napi poll to find another chance to start
polling to handle the rest of descs. On the contrary, returning true here
means job done and we know we finish all the possible descs this time and
we don't intend to start a new napi poll.

It is apparently against our expectations. Please also see how
ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
to make sure the budget can be decreased to zero at most and the underflow
never happens.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 0ade15058d98..a463c5ac9c7c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
-- 
2.41.3


