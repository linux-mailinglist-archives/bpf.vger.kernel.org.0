Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4DE44238E
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 23:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhKAWtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 18:49:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60642 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhKAWtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 18:49:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GoUGU015841
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 15:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jEL9FPuzOA6BkBpc3aPNfm5lLcrZd5euAGA5QhONQjY=;
 b=YuwACxfcUy6392khDYVt9OrjRuz/bsbYqdRj9Sc3cHpsDILlBX7HNjKwGFIb7jvreKOZ
 7xbHW4faWRbU/pJTNqnB3kHBzVuoWUCqb/ys5omOePUVP1YtD7tlgS6EWS0maHPvFFn8
 EPunShgDbIsJA1fcZli9bg75RKJiRZFLFNk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2da3d5ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 15:46:28 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:46:26 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id BDE628EEEB06; Mon,  1 Nov 2021 15:44:03 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 4/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Mon, 1 Nov 2021 15:43:57 -0700
Message-ID: <20211101224357.2651181-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211101224357.2651181-1-davemarchevsky@fb.com>
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: zls4ya9RL4Z1BnTOFUs-KjNh3zFw7FTw
X-Proofpoint-GUID: zls4ya9RL4Z1BnTOFUs-KjNh3zFw7FTw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=583
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111010119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the road to libbpf 1.0, and discussed in libbpf issue tracker
[0], bpf_program__get_prog_info_linear and its associated structs and
helper functions should be deprecated. The functionality is too specific
to the needs of 'perf', and there's little/no out-of-tree usage to
preclude introduction of a more general helper in the future.

  [0] Closes: https://github.com/libbpf/libbpf/issues/313

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9de0f299706b..797f5f8a0e20 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -918,12 +918,15 @@ struct bpf_prog_info_linear {
 	__u8			data[];
 };
=20
+LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
 LIBBPF_API struct bpf_prog_info_linear *
 bpf_program__get_prog_info_linear(int fd, __u64 arrays);
=20
+LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
 LIBBPF_API void
 bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
=20
+LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
 LIBBPF_API void
 bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
=20
--=20
2.30.2

