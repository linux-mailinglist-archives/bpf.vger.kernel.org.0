Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626DD22A226
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgGVWNp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 18:13:45 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3176 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733145AbgGVWLh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 18:11:37 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MM6f3D019802;
        Wed, 22 Jul 2020 15:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0818;
 bh=GmEgsOs6h9b3iKtTR1f7ZzvpfMSp6NwSWPeac8kAzwo=;
 b=c6Y2N2ZLJaqT0j2CraOBXVCGB54OVxNENrQe1pxef7nuy7vMViODmBvNTRXbaMp3sZp3
 3AEuvZx++ODlRoSWQLe+q0KSXs3XgtfUUFaMhwYvNr9mgkMJ/e+mSbjR5jpBr0jkZ7Nf
 UnMNG1OuYMSgPqL+ZMe0JLbzKueUZKHtjYHA4fmIuTnx4I57Z5lFqr3H2D2cGJZfIIJr
 z/asPlY/0afpipBkcpWjhdNTWx/x6Z/2GFThL7r/UGqmLfll2ltBC1jdeCMUSN/o2Gfy
 9JuHCjVu2MP53bTYHB+AdMxSTHgxHDYwE4+dyIx8NnjNIm2UejAEi9mhsEAEIpdCU0Mu 5Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 32c0kkt0jr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 15:11:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 15:11:20 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 15:11:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:11:19 -0700
Received: from NN-LT0049.marvell.com (NN-LT0049.marvell.com [10.193.54.6])
        by maili.marvell.com (Postfix) with ESMTP id A61E43F7040;
        Wed, 22 Jul 2020 15:11:12 -0700 (PDT)
From:   Alexander Lobakin <alobakin@marvell.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Lobakin <alobakin@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        <GR-everest-linux-l2@marvell.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 02/15] qed: reformat Makefile
Date:   Thu, 23 Jul 2020 01:10:32 +0300
Message-ID: <20200722221045.5436-3-alobakin@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722221045.5436-1-alobakin@marvell.com>
References: <20200722221045.5436-1-alobakin@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_16:2020-07-22,2020-07-22 signatures=0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

List one entry per line and sort them alphabetically to simplify the
addition of the new ones.

Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/Makefile | 36 +++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/Makefile b/drivers/net/ethernet/qlogic/qed/Makefile
index 4176bbf2a22b..3c75e4fa9b02 100644
--- a/drivers/net/ethernet/qlogic/qed/Makefile
+++ b/drivers/net/ethernet/qlogic/qed/Makefile
@@ -3,12 +3,34 @@
 
 obj-$(CONFIG_QED) := qed.o
 
-qed-y := qed_cxt.o qed_dev.o qed_hw.o qed_init_fw_funcs.o qed_init_ops.o \
-	 qed_int.o qed_main.o qed_mcp.o qed_sp_commands.o qed_spq.o qed_l2.o \
-	 qed_selftest.o qed_dcbx.o qed_debug.o qed_ptp.o qed_mng_tlv.o
-qed-$(CONFIG_QED_SRIOV) += qed_sriov.o qed_vf.o
-qed-$(CONFIG_QED_LL2) += qed_ll2.o
-qed-$(CONFIG_QED_RDMA) += qed_roce.o qed_rdma.o qed_iwarp.o
-qed-$(CONFIG_QED_ISCSI) += qed_iscsi.o
+qed-y :=			\
+	qed_cxt.o		\
+	qed_dcbx.o		\
+	qed_debug.o		\
+	qed_dev.o		\
+	qed_hw.o		\
+	qed_init_fw_funcs.o	\
+	qed_init_ops.o		\
+	qed_int.o		\
+	qed_l2.o		\
+	qed_main.o		\
+	qed_mcp.o		\
+	qed_mng_tlv.o		\
+	qed_ptp.o		\
+	qed_selftest.o		\
+	qed_sp_commands.o	\
+	qed_spq.o
+
 qed-$(CONFIG_QED_FCOE) += qed_fcoe.o
+qed-$(CONFIG_QED_ISCSI) += qed_iscsi.o
+qed-$(CONFIG_QED_LL2) += qed_ll2.o
 qed-$(CONFIG_QED_OOO) += qed_ooo.o
+
+qed-$(CONFIG_QED_RDMA) +=	\
+	qed_iwarp.o		\
+	qed_rdma.o		\
+	qed_roce.o
+
+qed-$(CONFIG_QED_SRIOV) +=	\
+	qed_sriov.o		\
+	qed_vf.o
-- 
2.25.1

