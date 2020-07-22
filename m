Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5A22A23E
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgGVWL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 18:11:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27186 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgGVWLY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 18:11:24 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MM6v1c019879;
        Wed, 22 Jul 2020 15:11:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0818; bh=Il19awlAmG29fp9AVrUyzNFznr1q+S/tbnyiY1K3Rwk=;
 b=nwLk46lXISSnTe9yw+UAqUc7uD/CJThoXOo/FChbbniLP1icXDoqKgs6fZIKJDFdze+P
 j3CMQbdS49rJVh+9g5unHPQ8JwzNzX9/sCGs4SFx73jHQFQPuvSWDRLF1/Uh9xzf87z2
 vO7aJqIc1eauq9sCU7guCsRICMRwI91YjfScFiQiLyROjN9TU/4RWanxBDANjLQfcnl5
 pXFgZlUdhZ5qXTtfka1YyYebvVrS+31q6lipv0Y0Bb854eDFCj9Bfd3qNXmybzVCIVbt
 oUz7vACq81+r8Ih+TtlmQUIpYhFoR/JYqRBLY/jopgSZOKwKbQy5yPwUTs1FjQ8W56Tj tA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 32c0kkt0hw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 15:11:08 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 15:11:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:11:05 -0700
Received: from NN-LT0049.marvell.com (NN-LT0049.marvell.com [10.193.54.6])
        by maili.marvell.com (Postfix) with ESMTP id C997E3F703F;
        Wed, 22 Jul 2020 15:10:57 -0700 (PDT)
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
Subject: [PATCH v2 net-next 00/15] qed, qede: improve chain API and add XDP_REDIRECT support
Date:   Thu, 23 Jul 2020 01:10:30 +0300
Message-ID: <20200722221045.5436-1-alobakin@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_16:2020-07-22,2020-07-22 signatures=0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds missing XDP_REDIRECT case handling in QLogic Everest
Ethernet driver with all necessary prerequisites and ops.
QEDE Tx relies heavily on chain API, so make sure it is in its best
at first.

v2 (from [1]):
 - add missing includes to #003 to pass the build on Alpha;
 - no functional changes.

[1] https://lore.kernel.org/netdev/20200722155349.747-1-alobakin@marvell.com/

Alexander Lobakin (15):
  qed: reformat "qed_chain.h" a bit
  qed: reformat Makefile
  qed: move chain methods to a separate file
  qed: prevent possible double-frees of the chains
  qed: sanitize PBL chains allocation
  qed: move chain initialization inlines next to allocation functions
  qed: simplify initialization of the chains with an external PBL
  qed: simplify chain allocation with init params struct
  qed: add support for different page sizes for chains
  qed: optimize common chain accessors
  qed: introduce qed_chain_get_elem_used{,u32}()
  qede: reformat several structures in "qede.h"
  qede: reformat net_device_ops declarations
  qede: refactor XDP Tx processing
  qede: add .ndo_xdp_xmit() and XDP_REDIRECT support

 drivers/infiniband/hw/qedr/main.c             |  20 +-
 drivers/infiniband/hw/qedr/verbs.c            |  97 ++---
 drivers/net/ethernet/qlogic/qed/Makefile      |  37 +-
 drivers/net/ethernet/qlogic/qed/qed_chain.c   | 369 ++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_dev.c     | 273 -------------
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h |  32 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   |  39 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c     |  44 ++-
 .../net/ethernet/qlogic/qed/qed_sp_commands.c |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_spq.c     |  90 +++--
 drivers/net/ethernet/qlogic/qede/qede.h       | 175 +++++----
 drivers/net/ethernet/qlogic/qede/qede_fp.c    | 174 ++++++---
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 185 +++++----
 include/linux/qed/qed_chain.h                 | 328 ++++++----------
 include/linux/qed/qed_if.h                    |   9 +-
 15 files changed, 1018 insertions(+), 858 deletions(-)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_chain.c

--

Netdev folks, could you please take the entire series through your tree
after the necessary acks and reviews? Patches 8-9 also touch qedr driver
under rdma tree, but these changes can't be separated as it would break
incremental buildability and bisecting.

-- 
2.25.1

