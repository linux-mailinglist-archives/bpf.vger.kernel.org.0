Return-Path: <bpf+bounces-75714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A7C922C6
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD8CC4E491A
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFA241C8C;
	Fri, 28 Nov 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L95J4cpz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD561E3762
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337577; cv=none; b=tcxEvyYirShp1MlGNTmm++3yThNzdJLDk9F7mwnym2wfZ7zuqt1Mq3CIwMSAkXd8DGPyg/h07L/nkxB2tzsV8L/h9sxT5kCJLV/RIpIL0r3hkBQthNX+1fdsk11kMxXTBZC6zvPhHmYphcGBUXJ2z+vuFmL/BgWVdhApVlp/gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337577; c=relaxed/simple;
	bh=zlvW/jN0idui1pFEaPCILXLEB6Pz7MYxpVsI6cS6zyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1MGIwsKI8n45SxBCPa/vk4zvcjkh0qeH5rjnQ7oykQbWzJCpDyYYOoopJGTmXivvbUIi3BWT6Uw0/OSaUzUsSJdNgj9bSdo7hWHgy7txPQmtyakyfkDPG7mfYxFvOAhbtAM4vr+zX5O331/jQULpM8rNwXJTudb09Obn4xorFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L95J4cpz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so1727779a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337574; x=1764942374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=L95J4cpzZs+eEo/mp9daf5xxXMfuUc7mFs2tOrr+DwQKtu81IYh35HxPqfsOEpUBP8
         E1sqxNQrzsLcJJSd4apddnx23PmN/W1NhosSkELooZCmDUgNAKYf05at7trEgj+Rbfwv
         V3HATyuwb/y1P23SrPXMnW89YtSufh3+Jga2yP0gPGDiH4XDWzDr6z9eET9Ko8TcFPWK
         /hVMoTJ15oz0zZXTxdtRlOCOif2Ox3GXJ5xdDSNMng9M1sAtrePHaV2vwxn5zNrC/KfB
         s4dTbg28T78n9XxK7f0yI/k1WjgYlNfJmv9yqte+468qTh0L+SzjaWIDoE9EfGJZrQTf
         HWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337574; x=1764942374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=GBVrW7dKgxF5vZDqM8cTOyEeHmuQW0ePPxg4hmggUNWjOG99BR85Mk9K9Kp0RtDhMf
         KgQd7Xd97BT7GJ9vRQnPrlCuGIm0po2sjIu7vrfBIORZt+dx01gFsi9oKWSmLHq8IP5V
         45ZJ0rRbk2UoCLfFsiTmcgHdh5l4NMDb1shCwhjEobPbGQRuV3rK3avtvtbpreMvlTqB
         Zjhtr/e7DCIv+7ObhDwPHgqB3rwZEIMX1BYig2EmhS2RNPiRVm0oE8+AkSCfOG66ydSE
         JJjijugJQ680xs553V0XtrwijBD8s9Q5tYVx8M5MjntoLDDfsm+VeQJuSoohMEhcLRcB
         89Fg==
X-Gm-Message-State: AOJu0YwMlX8uF/MxzXNL6NkQJkKeW3xtsVVzupJ5z3pxTdVd9NJDTIYe
	iHwlUED6PfUeQle8vjRSqmgk1jI9HhzmJ+JnMGqdOu23Oj85FDsdTTTA
X-Gm-Gg: ASbGncuwJukgV/2K3IRRJ88oXuILC8IUZLOZ0l8H/ua4PEMYmV0mOoAjrakPlxxqsee
	uwB4XjjjwEM124XeqfW850wsRsZfqPPwQYPqRfFlSUp9UL4tWBg4pRXCBDupW1WUus6NB9Vaxb5
	Q08gYJUdwPcyOOYEcFNGaJYSOAeoTog6vp3a7Zgx8EjgwbQJByEdwUd9PBfvMcDU17oV1YLKu3N
	gKCEms7g+pCbtKyOviqVTXOWHYeFFA5dY4mLMuwVW2//RRsE7QoAwxhTmiKaPfJiizHIVCaaenk
	swb4dkQFmXQce4/Gd/dgsTivw4Gk8BW9jOKIx+Iz6EWLHUK0GLegws7rCsSpKXe5Aq/r5HmUph0
	VhXEjVbOptUi81mgyX0KlFoOCE/IhdJu4WAvVjf3Z73zZ+f7eFromyTR1shJM5UHv3nFXsXTfKk
	HN+Vk8XijRbjlsbIm4Edw2ZFRkvd5+w+PsGmDGw7LnIGm3kEAW
X-Google-Smtp-Source: AGHT+IGjh2qVKM3LjOZ/aC5vAnRiCgrHQG0X7v0g3hocbg6GKpT+EUtZNTece8yiB/ANMOyGcYW5XQ==
X-Received: by 2002:a17:90b:3502:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-34733e55015mr31024244a91.7.1764337574026;
        Fri, 28 Nov 2025 05:46:14 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/3] xsk: add atomic cached_prod for copy mode
Date: Fri, 28 Nov 2025 21:45:59 +0800
Message-Id: <20251128134601.54678-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128134601.54678-1-kerneljasonxing@gmail.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a union member for completion queue only in copy mode for now. The
purpose is to replace the cq_cached_prod_lock with atomic operation
to improve performance. Note that completion queue in zerocopy mode
doesn't need to be converted because the whole process is lockless.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..44cc01555c0b 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -40,7 +40,11 @@ struct xdp_umem_ring {
 struct xsk_queue {
 	u32 ring_mask;
 	u32 nentries;
-	u32 cached_prod;
+	union {
+		u32 cached_prod;
+		/* Used for cq in copy mode only */
+		atomic_t cached_prod_atomic;
+	};
 	u32 cached_cons;
 	struct xdp_ring *ring;
 	u64 invalid_descs;
-- 
2.41.3


