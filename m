Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B8628518
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiKNQXz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiKNQXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 11:23:47 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD125C0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:44 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AECvla1006156
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ieWcW5SN5GBQJxwXsUobI79ewEYoDO0daSLMmqn6BXk=;
 b=HCROxkVhEBZxmUI5Ze4sa+sXrtxdsWGZ74htx8vsG976Ao473pwK3IKfBw0FU30CIUaO
 aGmsmulyys+mwNMGcgm40RFWk+JGv0eGWu0/8xsq+TNRgN5vB8IF6NOcEPnfe8sr2eqB
 5nDQCe16u3fBqLHcS/VcnFYcJTNCovAGXfI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kup4t9rr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:43 -0800
Received: from twshared10308.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:23:42 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 453CE12265E1E; Mon, 14 Nov 2022 08:23:28 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH bpf-next 0/3] bpf: Implement bpf_get_kern_btf_id() kfunc
Date:   Mon, 14 Nov 2022 08:23:28 -0800
Message-ID: <20221114162328.622665-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MQAHpk8AaJOM3G2JoUWCxo8RTjcZ-bq4
X-Proofpoint-GUID: MQAHpk8AaJOM3G2JoUWCxo8RTjcZ-bq4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currenty, a non-tracing bpf program typically has a single 'context' argume=
nt
with predefined uapi struct type. Following these uapi struct, user is able
to access other fields defined in uapi header. Inside the kernel, the
user-seen 'context' argument is replaced with 'kernel context' (or 'kcontex=
t'
in short) which can access more information than what uapi header provides.
To access other info not in uapi header, people typically do two things:
  (1). extend uapi to access more fields rooted from 'context'.
  (2). use bpf_probe_read_kernl() helper to read particular field based on
    kcontext.
Using (1) needs uapi change and using (2) makes code more complex since
direct memory access is not allowed.

There are already a few instances trying to access more information from
kcontext:
  (1). trying to access some fields from perf_event kcontext.
  (2). trying to access some fields from xdp kcontext.

This patch set tried to allow direct memory access for kcontext fields
by introducing bpf_get_kern_btf_id() kfunc.

Martin mentioned a use case like type casting below:
  #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
basically a 'unsigned char *" casted to 'struct skb_shared_info *'. This pa=
tch
set tries to support such a use case as well with bpf_get_kern_btf_id().

For the patch series, Patch 1 is a preparation patch. Patch 2 did some
but incomplete implementation. Please see details in Patch 2 for what
is missing. The goal of this RFC patch is to seek comments about whether
such a kfunc is helpful and what scope (e.g., type casting like skb_shinfo(=
SKB)
can be implemented with this helper) it should cover. Patch 3 has two
simple tests.

  [1] https://lore.kernel.org/bpf/ad15b398-9069-4a0e-48cb-4bb651ec3088@meta=
.com/
  [2] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@g=
mail.com/

Yonghong Song (3):
  bpf: Add support for kfunc set with generic btf_ids
  bpf: Implement bpf_get_kern_btf_id() kfunc
  bpf: Add bpf_get_kern_btf_id() tests

 include/linux/bpf.h                           |  2 +
 kernel/bpf/btf.c                              | 75 ++++++++++++++++-
 kernel/bpf/helpers.c                          | 18 ++++-
 kernel/bpf/verifier.c                         |  8 +-
 .../bpf/prog_tests/get_kern_btf_id.c          | 81 +++++++++++++++++++
 .../selftests/bpf/progs/get_kern_btf_id.c     | 44 ++++++++++
 6 files changed, 225 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_kern_btf_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_kern_btf_id.c

--=20
2.30.2

