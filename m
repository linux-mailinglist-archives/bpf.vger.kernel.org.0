Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D49198599
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgC3UlI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 16:41:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35841 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgC3UlE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 16:41:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so323339wme.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diBJ0x79+6O/wxFqEKBl8ch1Vskurhroixe+etKg5ds=;
        b=iZf7im/xB2B8gsISeTSt6aduVdGAss3K01k9DkivavNEydV0FoEpJ1r82SpBLvmavJ
         +Vz3Lgj5/BAtjn8epPfJydi5sCistPfYs7bAlrv0Dn1PhziubG5wDMVxLdF1iJ7fzFc6
         F6DKQuKnAC74stkr/1GzCKXNfgFPebUCEvuYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diBJ0x79+6O/wxFqEKBl8ch1Vskurhroixe+etKg5ds=;
        b=pU3wDaFBw0kjO/Ddglixksm/YKp7E9yPvfLjPyPDgCloVMnkcbf+/V9Zgk1SgJO5Ya
         LjonA6AMSbdB0plR3LorB32agaBOtXI18Unb5stS9hRvEDx1IlHspSafHNVrtGvLA5pw
         OckmD+AX36HHFExtp3cCAPA2VubHvq6HaR6BcYYqYb9LWiz1rkEzzuvhTZ9poQBQ/fKF
         fbQP86VS8//ILi+lpYwq3ll3FNfBNCfKvWaOoGjY9+SPA4orFGCGHNXazUrJBoZj2iCZ
         kMv3n5Q7RBiI3WPM2KrMFpAmrL3VJH+U4QVRnFBk4JkXTZuJLAqR2K0E8/hSYcGOf5ID
         gt7w==
X-Gm-Message-State: ANhLgQ3HVxupPg160nbJk3EVv/0hJbnPYRqAJ/Z1u/QbcuOItLs6sFn5
        Ie151VFR0dH5Hb9IIuVg9rIqGA==
X-Google-Smtp-Source: ADFU+vs0+WO+HMZReh+CV4b+EKUCIVkXRdBnzid39Ti1/WKMh5uSQ/VzWIEU+mU3N4lZ4g7u9xHuxA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr1087478wma.36.1585600862543;
        Mon, 30 Mar 2020 13:41:02 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w81sm890156wmg.19.2020.03.30.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:41:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: lsm: Make BPF_LSM depend on BPF_EVENTS
Date:   Mon, 30 Mar 2020 22:40:59 +0200
Message-Id: <20200330204059.13024-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

LSM and tracing programs share their helpers with bpf_tracing_func_proto
which is only defined (in bpf_trace.c) when BPF_EVENTS is enabled.

Instead of adding __weak symbol, make BPF_LSM depend on
BPF_EVENTS so that both tracing and LSM programs can actually share
helpers.

Signed-off-by: KP Singh <kpsingh@google.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: fc611f47f218 ("bpf: Introduce BPF_PROG_TYPE_LSM")
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index deae572d1927..7b7ea70e64ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1619,6 +1619,7 @@ config KALLSYMS_BASE_RELATIVE
 
 config BPF_LSM
 	bool "LSM Instrumentation with BPF"
+	depends on BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on SECURITY
 	depends on BPF_JIT
-- 
2.20.1

