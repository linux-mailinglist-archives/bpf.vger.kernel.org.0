Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C04EA44D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 20:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3Tff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 15:35:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJ3Tff (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Oct 2019 15:35:35 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UJXX2j017689
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 12:35:34 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vybre9ts9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 12:35:34 -0700
Received: from 2401:db00:2120:80d4:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 30 Oct 2019 12:35:33 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 6523A76071F; Wed, 30 Oct 2019 12:35:32 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: cleanup BTF-enabled raw_tp
Date:   Wed, 30 Oct 2019 12:35:30 -0700
Message-ID: <20191030193532.262014-1-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_08:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=561
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=1 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When BTF-enabled raw_tp were introduced the plan was to follow up
with BTF-enabled kprobe and kretprobe reusing PROG_RAW_TRACEPOINT
and PROG_KPROBE types. But k[ret]probe expect pt_regs while
BTF-enabled program ctx will be the same as raw_tp.
kretprobe is indistinguishable from kprobe while BTF-enabled
kretprobe will have access to retval while kprobe will not.
Hence PROG_KPROBE type is not reusable and reusing
PROG_RAW_TRACEPOINT no longer fits well.
Hence introduce 'umbrella' prog type BPF_PROG_TYPE_TRACING
that will cover different BTF-enabled tracing attach points.
The changes make libbpf side cleaner as well.
check_attach_btf_id() is cleaner too.

Alexei Starovoitov (2):
  bpf: replace prog_raw_tp+btf_id with prog_tracing
  libbpf: add support for prog_tracing

 include/linux/bpf.h            |  5 ++
 include/linux/bpf_types.h      |  1 +
 include/uapi/linux/bpf.h       |  2 +
 kernel/bpf/syscall.c           |  6 +--
 kernel/bpf/verifier.c          | 34 +++++++++----
 kernel/trace/bpf_trace.c       | 44 +++++++++++++----
 tools/include/uapi/linux/bpf.h |  2 +
 tools/lib/bpf/bpf.c            |  8 ++--
 tools/lib/bpf/bpf.h            |  5 +-
 tools/lib/bpf/libbpf.c         | 88 +++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf.h         |  4 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 12 files changed, 151 insertions(+), 49 deletions(-)

-- 
2.17.1

