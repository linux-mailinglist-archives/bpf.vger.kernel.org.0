Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D65A03F5
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiHXW3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiHXW26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:28:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391ED7EFE2
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:57 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHCoQ027529
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=lOxrDB+XmbWbiJ63pzwxdwPHjVgaTwJHMCeamts7Cxk=;
 b=OuNfkKFK/Y2wRXLibCeoYAs9unFAGBm+8gpHget5fPvaOKRGousgEL8Z5yyvdVgPh/7S
 9INUqbzhFM8JAw1Azj/7/J/lFoDuq/k0p77N03Zu6b3vEFNdNky4bV1NieDaMKs1DJp2
 +5lE0x+WuAmGxVavE6akD9VTMaSTGZ9I0k4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5aay71t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:56 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:28:55 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 92821871C86A; Wed, 24 Aug 2022 15:26:01 -0700 (PDT)
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
Subject: [PATCH bpf-next 00/17] bpf: net: Remove duplicated code from bpf_getsockopt()
Date:   Wed, 24 Aug 2022 15:26:01 -0700
Message-ID: <20220824222601.1916776-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4LgQPSqtZmQQxRNxppti-LEJAm6z8MHJ
X-Proofpoint-GUID: 4LgQPSqtZmQQxRNxppti-LEJAm6z8MHJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_13,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The earlier commits [0] removed duplicated code from bpf_setsockopt().
This series is to remove duplicated code from bpf_getsockopt().

Unlike the setsockopt() which had already changed to take
the sockptr_t argument, the same has not been done to
getsockopt().  This is the extra step being done in this
series.

[0]: https://lore.kernel.org/all/20220817061704.4174272-1-kafai@fb.com/

Martin KaFai Lau (17):
  net: Change sock_getsockopt() to take the sk ptr instead of the sock
    ptr
  bpf: net: Change sk_getsockopt() to take the sockptr_t argument
  bpf: net: Avoid sk_getsockopt() taking sk lock when called from bpf
  bpf: net: Change do_tcp_getsockopt() to take the sockptr_t argument
  bpf: net: Avoid do_tcp_getsockopt() taking sk lock when called from
    bpf
  bpf: net: Change do_ip_getsockopt() to take the sockptr_t argument
  bpf: net: Avoid do_ip_getsockopt() taking sk lock when called from bpf
  net: Remove unused flags argument from do_ipv6_getsockopt
  net: Add a len argument to compat_ipv6_get_msfilter()
  bpf: net: Change do_ipv6_getsockopt() to take the sockptr_t argument
  bpf: net: Avoid do_ipv6_getsockopt() taking sk lock when called from
    bpf
  bpf: Embed kernel CONFIG check into the if statement in bpf_getsockopt
  bpf: Change bpf_getsockopt(SOL_SOCKET) to reuse sk_getsockopt()
  bpf: Change bpf_getsockopt(SOL_TCP) to reuse do_tcp_getsockopt()
  bpf: Change bpf_getsockopt(SOL_IP) to reuse do_ip_getsockopt()
  bpf: Change bpf_getsockopt(SOL_IPV6) to reuse do_ipv6_getsockopt()
  selftest/bpf: Add test for bpf_getsockopt()

 include/linux/filter.h                        |   3 +-
 include/linux/igmp.h                          |   4 +-
 include/linux/mroute.h                        |   6 +-
 include/linux/mroute6.h                       |   4 +-
 include/linux/sockptr.h                       |   5 +
 include/net/ip.h                              |   2 +
 include/net/ipv6.h                            |   4 +-
 include/net/ipv6_stubs.h                      |   2 +
 include/net/sock.h                            |   2 +
 include/net/tcp.h                             |   2 +
 net/core/filter.c                             | 216 ++++++++----------
 net/core/sock.c                               |  51 +++--
 net/ipv4/igmp.c                               |  22 +-
 net/ipv4/ip_sockglue.c                        |  98 ++++----
 net/ipv4/ipmr.c                               |   9 +-
 net/ipv4/tcp.c                                |  92 ++++----
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/ip6mr.c                              |  10 +-
 net/ipv6/ipv6_sockglue.c                      |  95 ++++----
 net/ipv6/mcast.c                              |   8 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/setget_sockopt.c      | 148 ++++--------
 22 files changed, 375 insertions(+), 410 deletions(-)

--=20
2.30.2

