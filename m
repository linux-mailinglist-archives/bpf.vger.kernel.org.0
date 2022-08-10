Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68858F2C5
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiHJTKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiHJTKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 15:10:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313B30D
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:13 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27AGuScJ024191
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XmeOb1F/f3jhiHgcB1Yw5jElPLwz9VAOp3EWt1RMQRw=;
 b=IYbxWHYtVZQmJD1VNhPci5bCNDbtIoxxrd0mash+B4g6kICqtC5UDOEI7lf5Uc8JStkh
 luZRkvRXC4ix3Q0gM04k/walJ0aeBf0jFznrECiAuxKU94yn52ncSrtNvmT5rnDlEtdT
 3r6g+MCXaJ8VkNNCSj7uc1yxHdoDjqaIzPc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hvdb5u3wr-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:12 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 12:10:08 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 4CB4C7E74D91; Wed, 10 Aug 2022 12:07:24 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 00/15] bpf: net: Remove duplicated code from bpf_setsockopt()
Date:   Wed, 10 Aug 2022 12:07:24 -0700
Message-ID: <20220810190724.2692127-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: P0APEDIBAW5gkPoFPsS7X_w29043WKS3
X-Proofpoint-ORIG-GUID: P0APEDIBAW5gkPoFPsS7X_w29043WKS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The code in bpf_setsockopt() is mostly a copy-and-paste from
the sock_setsockopt(), do_tcp_setsockopt(), do_ipv6_setsockopt(),
and do_ip_setsockopt().  As the allowed optnames in bpf_setsockopt()
grows, so are the duplicated code.  The code between the copies
also slowly drifted.

This set is an effort to clean this up and reuse the existing
{sock,do_tcp,do_ipv6,do_ip}_setsockopt() as much as possible.

After the clean up, this set also adds a few allowed optnames
that we need to the bpf_setsockopt().

The initial attempt was to clean up both bpf_setsockopt() and
bpf_getsockopt() together.  However, the patch set was getting
too long.  It is beneficial to leave the bpf_getsockopt()
out for another patch set.  Thus, this set is focusing
on the bpf_setsockopt().

v3:
- s/in_bpf/has_current_bpf_ctx/ (Andrii)
- Add comments to has_current_bpf_ctx() and sockopt_lock_sock()
  (Stanislav)
- Use vmlinux.h in selftest and add defines to bpf_tracing_net.h
  (Stanislav)
- Use bpf_getsockopt(SO_MARK) in selftest (Stanislav)
- Use BPF_CORE_READ_BITFIELD in selftest (Yonghong)

v2:
- A major change is to use in_bpf() to test if a setsockopt()
  is called by a bpf prog and use in_bpf() to skip capable
  check.  Suggested by Stanislav.
- Instead of passing is_locked through sockptr_t or through an extra
  argument to sk_setsockopt, v2 uses in_bpf() to skip the lock_sock()
  also because bpf prog has the lock acquired.
- No change to the current sockptr_t in this revision
- s/codes/code/

Martin KaFai Lau (15):
  net: Add sk_setsockopt() to take the sk ptr instead of the sock ptr
  bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf
  bpf: net: Consider has_current_bpf_ctx() when testing capable() in
    sk_setsockopt()
  bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: net: Change do_ip_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: net: Change do_ipv6_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: Initialize the bpf_run_ctx in bpf_iter_run_prog()
  bpf: Embed kernel CONFIG check into the if statement in bpf_setsockopt
  bpf: Change bpf_setsockopt(SOL_SOCKET) to reuse sk_setsockopt()
  bpf: Refactor bpf specific tcp optnames to a new function
  bpf: Change bpf_setsockopt(SOL_TCP) to reuse do_tcp_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IPV6) to reuse do_ipv6_setsockopt()
  bpf: Add a few optnames to bpf_setsockopt
  selftests/bpf: bpf_setsockopt tests

 include/linux/bpf.h                           |  14 +
 include/net/ip.h                              |   2 +
 include/net/ipv6.h                            |   2 +
 include/net/ipv6_stubs.h                      |   2 +
 include/net/sock.h                            |   7 +
 include/net/tcp.h                             |   2 +
 kernel/bpf/bpf_iter.c                         |   5 +
 net/core/filter.c                             | 377 ++++++---------
 net/core/sock.c                               |  81 +++-
 net/ipv4/ip_sockglue.c                        |  16 +-
 net/ipv4/tcp.c                                |  22 +-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/ipv6_sockglue.c                      |  18 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 125 +++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  31 +-
 .../selftests/bpf/progs/setget_sockopt.c      | 451 ++++++++++++++++++
 16 files changed, 883 insertions(+), 273 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt.c

--=20
2.30.2

