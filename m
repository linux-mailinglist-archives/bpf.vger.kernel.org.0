Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B3500807
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiDNINz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiDNINz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 04:13:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58746658
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 01:11:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n17so141921ljc.11
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJlEdUxItHncTxzEbs260EsD9mgpD7B42dxtRERT3hI=;
        b=g2ecaIQtYOiNnjMNswlHllmS0uoXO2Sy2SUzKggM7WWJk7typh8/wiGdgRhz9GWYZF
         sPv+QL0vXeRKRXbuzKad5I6Hg207cw+Tk/3f1bY7xPniPOLKORK+4o7AB5OWdjH2hFKk
         0wo25TKiTNY2ub+YehDIBl7e0+JXZXlq84cMGPQ64bhC2iPe1LO9GUaNyqJWuviRRy8q
         GwhyE4yUKbVj3iHyb+3i5tjrBHvo9o6Jaoim3ffCkTKZoHEUC/W0TeYD0UMCJxhiqg3M
         CICJYD4GPfUay4uVQ9lsINj8U+fnXSyWaYXR5wzFTxTUdPoqqaTSn+wv6JGOUDv2Q/OS
         MX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJlEdUxItHncTxzEbs260EsD9mgpD7B42dxtRERT3hI=;
        b=m/z47M6BMztwhlmpV4zvmHBBq9DwKg13ADHp5lBL0LBpchhHuaplQTDp1Ecsr3sJzL
         EHP9hoOVP+k3wFo/yovOTSjLVcPtaZlKMuKpN40lwxJLSHloQLYhd5xyWjSr9RFWSRAt
         2VC5/6W2ivme3tv1blemEN3Nv3P82QRYWmuEkoeS1ESEgUfYbWT44ChWEsX0uvTG6m6R
         BH6/+k6xN2Go/yEHZo+wQFkxEtBEb5ttLCTuLU1ksEu568R/HwO83lQmvstG6nfHWAcN
         0HxL3GWvwuJgGt9qImy32ZSpkDHV+KmYh1vq680ILlADwg5vzQLvEI9EUcedA5p0RUT9
         wZPg==
X-Gm-Message-State: AOAM532gt/ywWGT72rY4Cn5yocnAAozqGIM7ZZbmyv+Tv1pxPgassULp
        x3wNS1GjQ2RA0JjDAE4X6AAG6+icWEz11Nfu
X-Google-Smtp-Source: ABdhPJzsU7axWC0m6sowjy98vES1tSAV+SfnhptRq8hqppKJMRd6gSbD2Cv78WKscYwUEq8CnFNdEg==
X-Received: by 2002:a2e:9b0d:0:b0:24b:64ff:b6f9 with SMTP id u13-20020a2e9b0d000000b0024b64ffb6f9mr960182lji.140.1649923888845;
        Thu, 14 Apr 2022 01:11:28 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id c25-20020a2e6819000000b00247de61d3fdsm116858lja.113.2022.04.14.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:11:28 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Sergey Matyukevich <sergey.matyukevich@synopsys.com>
Subject: [PATCH] ARC: bpf: define uapi for BPF_PROG_TYPE_PERF_EVENT program type
Date:   Thu, 14 Apr 2022 11:11:26 +0300
Message-Id: <20220414081126.3176820-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich@synopsys.com>

Define appropriate uapi for the BPF_PROG_TYPE_PERF_EVENT program type
by exporting the user_regs_struct structure instead of the pt_regs
structure that is in-kernel only.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich@synopsys.com>
---

Originally I sent this patch via linux-snps-arc mailing list: see [1].
However this patch accompanies ARC support for libbpf bpf_tracing.h
accepted to bpf kernel tree: see [2].

So it looks like it makes sense to post this patch here as well.
I will also update linux-snps-arc patch series accordingly.

Regards,
Sergey

[1] https://lore.kernel.org/linux-snps-arc/20220408155804.587197-1-geomatsi@gmail.com/
[2] https://lore.kernel.org/bpf/20220408224442.599566-1-geomatsi@gmail.com/ 


 arch/arc/include/asm/perf_event.h          | 4 ++++
 arch/arc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/arc/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 4c919c0f4b30..d5719a260864 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -63,4 +63,8 @@ struct arc_reg_cc_build {
 
 #define PERF_COUNT_ARC_HW_MAX	(PERF_COUNT_HW_MAX + 8)
 
+#ifdef CONFIG_PERF_EVENTS
+#define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
+#endif
+
 #endif /* __ASM_PERF_EVENT_H */
diff --git a/arch/arc/include/uapi/asm/bpf_perf_event.h b/arch/arc/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..6cb1c2823288
--- /dev/null
+++ b/arch/arc/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_regs_struct bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
-- 
2.35.1

