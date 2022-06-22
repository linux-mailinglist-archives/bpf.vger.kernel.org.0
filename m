Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE055540B
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358717AbiFVTMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiFVTMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 15:12:50 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280718389
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 12:12:48 -0700 (PDT)
Received: from SPMA-04.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 1C882974E18_2B369AFB;
        Wed, 22 Jun 2022 19:12:47 +0000 (GMT)
Received: from mail.tu-berlin.de (bulkmail.tu-berlin.de [141.23.12.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-04.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id C0EDB977D13_2B369AEF;
        Wed, 22 Jun 2022 19:12:46 +0000 (GMT)
Received: from jt.fritz.box (77.191.241.175) by ex-04.svc.tu-berlin.de
 (10.150.18.8) with Microsoft SMTP Server id 15.2.986.22; Wed, 22 Jun 2022
 21:12:46 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: [PATCH bpf-next v4 0/5] Align BPF TCP CCs implementing cong_control() with non-BPF CCs
Date:   Wed, 22 Jun 2022 21:12:22 +0200
Message-ID: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=dkim-tub; bh=i9w4K5wg2MfAV7GShGVmtqtp2CZvpkNUjXKCVzsPrQE=; b=I8XaRrPkrjwfOpuqheX0kjQ1rcZDxMIqKXQUpTKXtXessSlGAUaEJEzYGoDbW67T6aHPeZ8bDsNQ45G/usJvCd+V+s5rPHs+tPQ5BAZQWBJEN/YD6Et5zP3Ay21yaZjQ1DEFgD9+TbgQhz6tZ2R8Y3HBrQECKA4rdDciTZeAPGM=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series corrects some inconveniences for a BPF TCP CC that
implements and uses tcp_congestion_ops.cong_control(). Until now, such a
CC did not have all necessary write access to struct sock and
unnecessarily needed to implement cong_avoid().

v4:
 - Remove braces around single statements after if
 - Don’t check pointer passed to bpf_link__destroy()
v3:
 - Add a selftest writing sk_pacing_*
 - Add a selftest with incomplete tcp_congestion_ops
 - Add a selftest with unsupported get_info()
 - Remove an unused variable
 - Reword a comment about reg() in bpf_struct_ops_map_update_elem()
v2:
 - Drop redundant check for required functions and just rely on
   tcp_register_congestion_control() (Martin KaFai Lau)

Jörn-Thorben Hinz (5):
  bpf: Allow a TCP CC to write sk_pacing_rate and sk_pacing_status
  bpf: Require only one of cong_avoid() and cong_control() from a TCP CC
  selftests/bpf: Test a BPF CC writing sk_pacing_*
  selftests/bpf: Test an incomplete BPF CC
  selftests/bpf: Test a BPF CC implementing the unsupported get_info()

 kernel/bpf/bpf_struct_ops.c                   |  7 +--
 net/ipv4/bpf_tcp_ca.c                         | 39 ++----------
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 61 +++++++++++++++++++
 .../bpf/progs/tcp_ca_incompl_cong_ops.c       | 35 +++++++++++
 .../bpf/progs/tcp_ca_unsupp_cong_op.c         | 21 +++++++
 .../bpf/progs/tcp_ca_write_sk_pacing.c        | 60 ++++++++++++++++++
 6 files changed, 186 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_incompl_cong_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_unsupp_cong_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c

-- 
2.30.2

