Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B51394727
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE1SqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:46:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5596 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhE1SqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622227477; x=1653763477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUtYu3gMswSai/R0sCyOGc9Fo+GX41jucxP7pg0MEIA=;
  b=pHBqIbvpSYn3O6CG9trpILQA/C8mRKWv6YT9Dqm/lc3j1OqjzstOU9nU
   T7eZQqLs2AMIORE+Tt92av2l7jsL5XLIpRIz6IkDle40EPa/SJ1dqwX/K
   Grcd2C6XWpLVxuq0k6+zHtTQYwBe+EAdyp1fn60zEraPs4XX4tQw5Yqal
   JQe2sdEe+53hvtvZvBr/dakdHADbNzG93qeZ8mP0vn4sKkts/8ExY8PmP
   EonhnUXe3alavg+0DwbTfVd6SPGUf8D9AzrMA4KDIPyy9Xsyd+a3k60bB
   uCbjyrf8Ca4WdvhzlUb8btfRGgB8btbGZEdyE/WjzVUvwLPnzftfK97gx
   w==;
IronPort-SDR: WKgE2ojX8LXtll61a1sv3Nn/ML7KhhjmLPUzxgIVFkMpxI7SPF3uzSOmpSRQjLbCwpvEjKnNfJ
 716F1kiiYAG7PFkXcLDJ+XQADa4wXaq7xGrY1Sek8aXRQebnw8yx+DA6wjFb+xsIxASUaYSbJc
 w4VeOpiiOKPuwVVAIWZ2AHnj3l6PI0vtO6cGp1Ub+2R856PYoYsWM++XXJ01fCOekUoX15cXuv
 dlu6/Wc0u5M8UXJ5tfibtbUeca98SxKBCsXALsJmgpn8Xca0pTrtdeQAGH0KBxejc1vZUGfPez
 IYc=
X-IronPort-AV: E=Sophos;i="5.83,230,1616428800"; 
   d="scan'208";a="170380451"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2021 02:44:36 +0800
IronPort-SDR: MPgr0RGXyCPXE6NI189KdkF7Ea4Afay4sedH22QKMigfYwyt4KHMa2Jk89xoqByvEg7H7Y7AdT
 gU7nUyOJBvP89nH3Mmiu0mL700fvk4tFLqr8vJs8qmyKkMFcqNCDJplgRyrlnXTviG1octXkar
 i7vhUUh4jLzHQqdOsGBLE8WcrXQg5AGeFCqgw0jgsgUzPIAwFZHa6uyA7cRDCWf4zX8O9lnsEt
 OU/0QoYSIadn7mOyBlRAqFyuSAf25Gq8P4T/wDlG0XB1BDQNJS+iOw6ut9QRYp31+BFLmg+dxI
 3ZajnRFElWR8cPkkF2eCgb/0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 11:23:58 -0700
IronPort-SDR: 7WscSkZAXKGXqCRtdW1KZCfMKDYysvxYRSJ6fLgIWkvIf5J6dy0sUxukflCpgd5jwIe1F+waJ4
 ataa00iwNT7Xm11XRmbC+jDVT3ege9rIRTHyYiCjZIniVsHpvT9IMh8R5W6wilX8HjieZjtCgv
 Z00gkK7jAaLUI5DOdUrfi0ZkXIYrD+2GZdZbFfnHTRe8DCdehoh6j9acSnmDWbGpPNh8U3e3dI
 oIbYowqDWj+6mzJMppBnMQ7sip9oJjSDkZPcfhOq0+1oAN9ntbg3exzrBd33CdevTXJvlLQwgp
 /Cc=
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.wdc.com) ([10.225.163.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2021 11:44:31 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        bpf@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alan Kao <alankao@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC v2 2/7] RISC-V: Add CSR encodings for all HPMCOUNTERS
Date:   Fri, 28 May 2021 11:44:00 -0700
Message-Id: <20210528184405.1793783-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528184405.1793783-1-atish.patra@wdc.com>
References: <20210528184405.1793783-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/csr.h | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 87ac65696871..e4d369830af4 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -89,9 +89,67 @@
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
 #define CSR_INSTRET		0xc02
+#define CSR_HPMCOUNTER3		0xc03
+#define CSR_HPMCOUNTER4		0xc04
+#define CSR_HPMCOUNTER5		0xc05
+#define CSR_HPMCOUNTER6		0xc06
+#define CSR_HPMCOUNTER7		0xc07
+#define CSR_HPMCOUNTER8		0xc08
+#define CSR_HPMCOUNTER9		0xc09
+#define CSR_HPMCOUNTER10	0xc0a
+#define CSR_HPMCOUNTER11	0xc0b
+#define CSR_HPMCOUNTER12	0xc0c
+#define CSR_HPMCOUNTER13	0xc0d
+#define CSR_HPMCOUNTER14	0xc0e
+#define CSR_HPMCOUNTER15	0xc0f
+#define CSR_HPMCOUNTER16	0xc10
+#define CSR_HPMCOUNTER17	0xc11
+#define CSR_HPMCOUNTER18	0xc12
+#define CSR_HPMCOUNTER19	0xc13
+#define CSR_HPMCOUNTER20	0xc14
+#define CSR_HPMCOUNTER21	0xc15
+#define CSR_HPMCOUNTER22	0xc16
+#define CSR_HPMCOUNTER23	0xc17
+#define CSR_HPMCOUNTER24	0xc18
+#define CSR_HPMCOUNTER25	0xc19
+#define CSR_HPMCOUNTER26	0xc1a
+#define CSR_HPMCOUNTER27	0xc1b
+#define CSR_HPMCOUNTER28	0xc1c
+#define CSR_HPMCOUNTER29	0xc1d
+#define CSR_HPMCOUNTER30	0xc1e
+#define CSR_HPMCOUNTER31	0xc1f
 #define CSR_CYCLEH		0xc80
 #define CSR_TIMEH		0xc81
 #define CSR_INSTRETH		0xc82
+#define CSR_HPMCOUNTER3H	0xc83
+#define CSR_HPMCOUNTER4H	0xc84
+#define CSR_HPMCOUNTER5H	0xc85
+#define CSR_HPMCOUNTER6H	0xc86
+#define CSR_HPMCOUNTER7H	0xc87
+#define CSR_HPMCOUNTER8H	0xc88
+#define CSR_HPMCOUNTER9H	0xc89
+#define CSR_HPMCOUNTER10H	0xc8a
+#define CSR_HPMCOUNTER11H	0xc8b
+#define CSR_HPMCOUNTER12H	0xc8c
+#define CSR_HPMCOUNTER13H	0xc8d
+#define CSR_HPMCOUNTER14H	0xc8e
+#define CSR_HPMCOUNTER15H	0xc8f
+#define CSR_HPMCOUNTER16H	0xc90
+#define CSR_HPMCOUNTER17H	0xc91
+#define CSR_HPMCOUNTER18H	0xc92
+#define CSR_HPMCOUNTER19H	0xc93
+#define CSR_HPMCOUNTER20H	0xc94
+#define CSR_HPMCOUNTER21H	0xc95
+#define CSR_HPMCOUNTER22H	0xc96
+#define CSR_HPMCOUNTER23H	0xc97
+#define CSR_HPMCOUNTER24H	0xc98
+#define CSR_HPMCOUNTER25H	0xc99
+#define CSR_HPMCOUNTER26H	0xc9a
+#define CSR_HPMCOUNTER27H	0xc9b
+#define CSR_HPMCOUNTER28H	0xc9c
+#define CSR_HPMCOUNTER29H	0xc9d
+#define CSR_HPMCOUNTER30H	0xc9e
+#define CSR_HPMCOUNTER31H	0xc9f
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
-- 
2.25.1

