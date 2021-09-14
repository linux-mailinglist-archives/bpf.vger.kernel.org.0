Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987FE40BB61
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhINWYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:24:30 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:37478 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhINWY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 18:24:29 -0400
Received: by mail-ej1-f48.google.com with SMTP id h9so1739068ejs.4;
        Tue, 14 Sep 2021 15:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLwX7Ft6iVObQeGOv+OOScxnxcJMRCVD4XgxogKw1ZA=;
        b=JkVMBX+keARH+SdhYxbxhkiUxiLPxOjfmjznQtnkPrPvwr1EVjIBDLeyAoCAfwGPji
         1zisozh2JdKnekGoL5OTc0m5OORuUB8R/QV3e7m2mQrP1IU4EG5pagnhV7wGgWy6rki4
         KPB4eqVN1Vgkj+Aju2+qhTi9wxtjlLpMNVTl4bTsu8nM1Cdp/xMxdYQbPi7JpE5H1wSl
         Jpc72MH4/LWf0mOivNwdt8ghxXGxmkxi7CslhaP1pmnoS/gCnKFOrDKujuWc6M5niWdG
         DA3X7JDz2DM55/k1PPgGgXmy0ft/ijb208yhEWon+2yhNcTKe8NBnPsZnJz7RA0EfwSn
         5UKg==
X-Gm-Message-State: AOAM530r6A7z4YQWVzmfXZDxfvy5SdktlUcD0CEyC3FOtdlkoa8MAUUd
        9HhsD5ximWMn6DnCosWlLHaq6eAv1bOv4A==
X-Google-Smtp-Source: ABdhPJw8MgqbISJRtcFOMV+5Ur7oPKTF/sqpV/byQveIK4AB6QMoOI2uZkFhqfxobxWrNYtGLlkW0A==
X-Received: by 2002:a17:906:681:: with SMTP id u1mr21164779ejb.499.1631658190223;
        Tue, 14 Sep 2021 15:23:10 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id w13sm6592017ede.24.2021.09.14.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:23:09 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf: update bpf_get_smp_processor_id() documentation
Date:   Wed, 15 Sep 2021 00:23:06 +0200
Message-Id: <20210914222306.52522-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Since commit 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"), BPF
programs can sleep if the BPF_F_SLEEPABLE flag is set.
Update the documentation accordingly.

Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/uapi/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d21326558d42..5e3b2fb62d84 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1629,9 +1629,9 @@ union bpf_attr {
  * u32 bpf_get_smp_processor_id(void)
  * 	Description
  * 		Get the SMP (symmetric multiprocessing) processor id. Note that
- * 		all programs run with preemption disabled, which means that the
- * 		SMP processor id is stable during all the execution of the
- * 		program.
+ * 		programs run with preemption disabled unless BPF_F_SLEEPABLE is
+ * 		set, which means that the SMP processor id is stable during all
+ * 		the execution of the program.
  * 	Return
  * 		The SMP id of the processor running the program.
  *
-- 
2.31.1

