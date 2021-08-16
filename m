Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83263EE041
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhHPXSC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:18:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43542 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232633AbhHPXSC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 19:18:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GNFE3h004413
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=F3apYiBck49hau8baDM4t6KBZICfVqSl2eQUWssm9Uo=;
 b=cJhoBOsnZmMQJIXBU3LqpKqkS2sHZsJADp5f7yDNvPvuOkViscTvoJqXjARtEfOwo8PR
 TDaKklrysdMOt18bisK95FCtna7nK102tTyHJCwLPQfPP2BuqycYIEUuFKf44QLOVmW1
 xOus4sMaXwvmmnnxog+kKYCtZNHXTAWcnK8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afj4d5ra1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:17:29 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 16:17:19 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 4AAB96DC616E; Mon, 16 Aug 2021 16:17:16 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <prankur.07@gmail.com>
Subject: [PATCH bpf-next 0/2] Add support for bpf_setsockopt and bpf_getsockopt from BPF setsockopt
Date:   Mon, 16 Aug 2021 16:17:14 -0700
Message-ID: <20210816231716.3824813-1-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: r4kTly9IAnOXlckWGzLrZlzWKKhlmNWb
X-Proofpoint-ORIG-GUID: r4kTly9IAnOXlckWGzLrZlzWKKhlmNWb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_09:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=958 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108160144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch contains support to set and get socket options from setsockopt
bpf program.
This enables us to set multiple socket option when the user changes a
particular socket option.
Example use case, when the user sets the IPV6_TCLASS socket option we
would also like to change the tcp-cc for that socket. We don't have any
use case for calling bpf_setsockopt from supposedly read-only
sys_getsockopt, so it is made available to BPF_CGROUP_SETSOCKOPT only.

Prankur gupta (2):
  bpf: Add support for {set|get} socket options from setsockopt BPF
  selftests/bpf: Add test for {set|get} socket option from setsockopt
    BPF program

 kernel/bpf/cgroup.c                           |  8 +++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 +++++
 .../bpf/prog_tests/sockopt_qos_to_cc.c        | 70 +++++++++++++++++++
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   | 39 +++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockopt_qos_to=
_cc.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c

--=20
2.30.2

