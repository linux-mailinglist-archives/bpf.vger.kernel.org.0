Return-Path: <bpf+bounces-73665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE89C36960
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31241A27516
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D83203AA;
	Wed,  5 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI4K1ONh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B5314D29
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358355; cv=none; b=HzzQJRTnZLr8t2u6ddSe3M1DsGb2yz+Hw0CxiyqxV0lo+437XO8xu1O2EyXr1hppTun5VB5pRaRZSOB+SG20I/lH7W+edmrLpr91WBe5sgwYA0mp2X3DaXBK1Hl+f1jy2pUy24EcfAs1qU7KAvvq1Mi8Q6sLZyhDQstLvrq4Y7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358355; c=relaxed/simple;
	bh=8cAvxL7f8vxFNNXMRtQ+xRH2cP84bfSHHJ50QaLYT8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ULmKzf8DYZVELbfv+1jiyWOyfqCgeIAEglhYsCb3Tja5NkQjj8s/UlW6Ffrl3YLsgbcnrEcIuWkchIfa85MIEKjOp7p/XXwJjqXbJ2C30d+5mnAfRCBii4V0g1iJD70486fBFCLRBEwdz1xHJC4l6kdoelLVUWNFMBZEbPCylF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI4K1ONh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4283be7df63so3799785f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358350; x=1762963150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnZZmzXAYgb48h9KqOSoxBMd314ql7cvy8+1ipCqbBg=;
        b=CI4K1ONhMlYCkMPlJ4RklxhO7MjS2jwK7K4kmGzps1lsS4n/vTDphJ7K8+/mLcfsMV
         FgQ3RCGkaXGrpjZ7+L2Z0sjH1jbHoEIvQIFUcnDOWpLrB+f3/7LfaMJkWcNiY2ZlR3QZ
         5NWFNTaJyOEDP0TvTCwFnOqtKwgww1FKKEe+V0ZkLItZA772b23DpMFxHhe89e9nnpjV
         EhZmVVV5zo3MT1AMzK4IG+frFDI9R0+9LHwmkAoPw0UdbiqawhRCDEzoNTLyIvG0B4BW
         kSmqESuQjiJe53r3DHwCxWn1zUV/P6awP3TKmpq+zpJQWxTBfvy3+lHGQeCgGYhSxJph
         pmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358350; x=1762963150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnZZmzXAYgb48h9KqOSoxBMd314ql7cvy8+1ipCqbBg=;
        b=pmMMO53Y/EbJ8Y4t031Nuugv1LS5W/73B0AXuP4Ye5KVPLrBkVYEc0Ur5Iu/+kF9sK
         NIMV2d1tQehBWdp2Mj5ScAr+Lkt+neWd4IFFnF4sAIcWL00yoeycdqzMVPOnWZq5IGvi
         6SGc1zZisbux/E8+qlb+WkoKBNG4xGIZJIHRV6GJNurBz0Nu4SaBv0dEVWLKsdxlVitn
         liFDRHnjBbfQQbKvfvojFFifxWc1c0i/2eQ/hrD+kuvzaWPiFsHIzvv7CGjvhLc6qpBA
         743tVricfLaurWeIdEHqx8OQ3jqAcAbrEX8NQYS/FT3hbqwuJbG+mOd2LykfmFN2fP35
         Yp5Q==
X-Gm-Message-State: AOJu0YznqkShxJi3h0jiEmvNubSdefjQI2xVmPOhOr5BMc5cA/JVH5Y0
	6/z4pZqtV/I2TGPTuwc2JF6w4rYbLnQEZO8yNbjfMz/gX8B2YTszy8t4
X-Gm-Gg: ASbGncuLGwN7A/0Y1pMUM9O9i97C3kdgNFlmFkJSIVtLJqX2Aq+g7FxpdjSGGkeUfF9
	H+AxQUUihldQAw7jBBcph/WTHkVJlP7O/5tuIFqoaM5UwRd7GMKwm3ZFlqxgejBNO6pIBztgiL5
	BGwUlsgJZCvakPOSBdnrIZdWYI6CXb6rCB49OEABICPFX1J4r9zvZzoGAq2hfKawcthVUby8/oY
	tDsgK3KSs6lo3156V/jvQlJ4T1aw2J32gbHbQONTXWj6ceSaae5E1wWNOYbbtZrLTR+X6+rRNeP
	AoegrmxgKs9oq4QfpB8KnbIkgJY9FtYe7BgcYggGDRuQSR8PKdQRkH2ZJCKbz2hzqzbrcBWNM6E
	SHOK+TxUujzNrMMV78VlxNFzVe4DxWTYDF5Vjzv4Wr+JDlFcaUzKoUxVX71jx
X-Google-Smtp-Source: AGHT+IF9oxaM5p7P9QrsCR36zkZZg8mnmBDXWWoCUp6O3kLJ34BvPF38sNgdOQcdTTmh6kP9ixR8kw==
X-Received: by 2002:a05:6000:4112:b0:429:8c3b:c4e2 with SMTP id ffacd0b85a97d-429e32c6c6dmr1887231f8f.7.1762358349302;
        Wed, 05 Nov 2025 07:59:09 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbd1csm11342387f8f.38.2025.11.05.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC v2 0/5] bpf: avoid locks in bpf_timer and bpf_wq
Date: Wed, 05 Nov 2025 15:59:02 +0000
Message-Id: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEZ0C2kC/1WNywrCMBREf6XctZEkTX2tBMEPcCtFkvTWXjSNJ
 CUopf9uiCuXZ4Y5M0PEQBjhUM0QMFEkP2aQqwrsoMc7Muoyg+SyEVzu2EQOw230T28fTDXbvjH
 7TmuLkCevgD29i+4Kl/MJ2hwOFCcfPuUiiVL9bLX4tyXBODN8ozQqXpveHB1Oem29g3ZZli/5q
 u9ZrAAAAA==
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=1797;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8cAvxL7f8vxFNNXMRtQ+xRH2cP84bfSHHJ50QaLYT8M=;
 b=+t7GsTrAOHM/jO7NHKluwygARA5r9snpHhBt1VtvoGXz5cepX8Hh+5g5BTORk9bgYKazAuO/E
 Ceo8nw9xgkcDPxMXK9YV+7Jm1gEeQvkzK4faO84Ehe6H0cO24NZcmfu
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This series reworks implementation of BPF timer and workqueue APIs.
The goal is to make both timers and wq non-blocking, enabling their use
in NMI context.
Today this code relies on a bpf_spin_lock embedded in the map element to
serialize:
 * init of the async object,
 * setting/changing the callback and bpf_prog
 * starting/cancelling the timer/work
 * tearing down when the map element is deleted or the map’s user ref is
 dropped

The series apply design similar to existing bpf_task_work
approach [1]: RCU and refcount to maintain lifetime guarantees and state
machine to handle data races.

This RFC doesn’t yet fully add NMI support for timers
and workqueue helpers and kfuncs, but it takes the first step by
removing the spinlock from bpf_async_cb struct.

---
1: https://lore.kernel.org/bpf/175864081800.1466288.3242104888617580131.git-patchwork-notify@kernel.org/

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

---
Changes in v2:
- Move refcnt initialization and put (from cancel_and_free())
from patch 5 into the patch 4, so that patch 4 has more clear and full
implementation and use of refcnt
- Link to v1: https://lore.kernel.org/r/20251031-timer_nolock-v1-0-b064ae403bfb@meta.com

---
Mykyta Yatsenko (5):
      bpf: refactor bpf_async_cb callback update
      bpf: refactor bpf_async_cb prog swap
      bpf: factor out timer deletion helper
      bpf: add refcnt into struct bpf_async_cb
      bpf: remove lock from bpf_async_cb

 kernel/bpf/helpers.c | 309 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 189 insertions(+), 120 deletions(-)
---
base-commit: 23f852daa4bab4d579110e034e4d513f7d490846
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


