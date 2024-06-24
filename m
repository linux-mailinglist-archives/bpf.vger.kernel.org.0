Return-Path: <bpf+bounces-32912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C29E914E99
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC381C20B99
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4E1420B0;
	Mon, 24 Jun 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMlwThy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164313E3ED;
	Mon, 24 Jun 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235732; cv=none; b=fKOXdjMr8qfLgNObhLgN5ZqhFAlDCiB2q7dZuV1U46F82Qh/29nDoOvaxAJ7blFGXR1Db6xGpgO+cLyEjRYJ8+E7RnkjV1FTI9Ucq/I96xXFYaHkUElA/xEQmqFzRiDsttnZoxN9krtoQC/eeKa0IjdTFDm80Bvm2HbUTbeEzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235732; c=relaxed/simple;
	bh=cDqcb6SJV4vRBb4QkNmQT3Wl/AbFEpR2X5N+u6WtmW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oomZk6CRsk8ytWhalvCbqvQ0tKx2qDH51svMaTIduVNACagcZP0osPVzF8ugp7ml4D4DzlcJ1JF8G/PTYzgdWzALhsYOFehDWW3THayKAZ1lxPK/Zjh75HXkWEkpDQZjnNqnAyiVHrnRYYLauPnHln9+klMmQVdMIrzmS4hVkuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMlwThy/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so4209021fa.1;
        Mon, 24 Jun 2024 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235729; x=1719840529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtEe7sDqfN9JW3LcLHq6hNyDw8ZBCvPF/f0tUgUw0Ek=;
        b=ZMlwThy/3xzxtPwT3+luMCEFBU8NHV4ABEkK6TrI+XMuIjE0ITbgF8tppy75mwmS64
         LmBcZuGQ6NBi7SYO5Jqm88u/55nvxpsiCVcw8IHYbBnJQ1EOyMmI/Vdcd0GAJoBlna96
         rUbA3aglp4yEvhviO6Hy9nAo21pel+JTZIGUEm5Vb/9/MzvMCVU0u8YUtcXfaa8Idc0V
         qCcNEZTJESr1ZemwILHDkRTAh7Y532LYGxKnfOqxwM+QcauvYRnXEXdAfEl4hMky85ES
         IPrqVwBqeSi8DyVf6vPXg84IoiNL5eBmCibYG0uFr9LzX1nUjfxbEhz2UFoZd2meWH/E
         5w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235729; x=1719840529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtEe7sDqfN9JW3LcLHq6hNyDw8ZBCvPF/f0tUgUw0Ek=;
        b=fi8u9dR5qtzgPKO080S2J3CVBkOHsqFteIzW0tGrWEUPPVMmBVd0rk2q40buCQVAa6
         QHf632rNkmlI7QBp7U9M/x4RnJsKVKTJfOgs3vDZ5atkTdVMZsC5+TGwAIYb5HkOj13o
         c334GeOEVkDggeJsiui857TjjK7mkahtzL5VR9Ge+UN3HG/diV8gldrVCbeVI0aQ4wZr
         EVOAuEwiDn4DbwN9Y6P5vuBlgJBxRcbeCuTgU7Kj+ejtwVH0zG3AYUfcFayRFeUyAYo/
         sPEth9usubTcMZ7L2C1VZ97ha4gt0V1glwqsBlOUvs7mIFr72fnLJaNuLXejw5MuVM6S
         NBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVZWzYmDIrQJJaOE6hNaLIT0678H0vm6QZkUOqEOme/8fdr+wz0h6CE961S9x87lHw6fMH0RQGGUTA1B+dMCU4V1rN3onas7gMjaEZihpi8jRpTbJLL4QCXtx/z88qObmR5JUWMsyVJnntnfdUQa3zcyL/3JMawWYY7
X-Gm-Message-State: AOJu0YxOtaoTJ9a/QRNuvLJOMdD4ou2PNbbQUHYCfkW8qI0wXFzSy1Gm
	0CP4Uo+mAMLmAGuAclQZsVqgH5t4L6ncfPX/WnvGWCMmeM0iNq9w
X-Google-Smtp-Source: AGHT+IFPP14441T+3czwKEItmbrOsbND2YdLL8uZN7bzYoWhRPQpBDSL2HCd8X2teLzstMx3I7E0FQ==
X-Received: by 2002:a05:651c:1988:b0:2ec:637a:c212 with SMTP id 38308e7fff4ca-2ec637ac2b5mr15471271fa.39.1719235729169;
        Mon, 24 Jun 2024 06:28:49 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d602519sm9997201fa.6.2024.06.24.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:48 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 17/17] net: stmmac: pcs: Drop the _SHIFT macros
Date: Mon, 24 Jun 2024 16:26:34 +0300
Message-ID: <20240624132802.14238-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCS_ANE_PSE_SHIFT and PCS_ANE_RFE_SHIFT are unused anyway. Moreover
PCS_ANE_PSE and PCS_ANE_RFE are the respective field masks. So the
FIELD_GET()/FIELD_SET() macro-functions can be used to get/set the fields
content. Drop the _SHIFT macros for good then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index a17e5b37c411..0f15c9898788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -43,9 +43,7 @@
 #define PCS_ANE_FD		BIT(5)		/* AN Full-duplex flag */
 #define PCS_ANE_HD		BIT(6)		/* AN Half-duplex flag */
 #define PCS_ANE_PSE		GENMASK(8, 7)	/* AN Pause Encoding */
-#define PCS_ANE_PSE_SHIFT	7
 #define PCS_ANE_RFE		GENMASK(13, 12)	/* AN Remote Fault Encoding */
-#define PCS_ANE_RFE_SHIFT	12
 #define PCS_ANE_ACK		BIT(14)		/* AN Base-page acknowledge */
 
 /* SGMII/RGMII/SMII link status register */
-- 
2.43.0


