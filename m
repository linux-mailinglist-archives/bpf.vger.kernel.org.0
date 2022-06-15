Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755F954D4EF
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 01:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiFOXDQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 19:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFOXDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 19:03:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D283222A3
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:15 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25FLpjlI003573
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=se6NoeIsESINTodtQFPkqZO3i09QPUHgq0junBWYOIs=;
 b=HWUByzlOGamMahxOvJBDQ/XtXxbXAdCrnph7YEi4z3P/ccg/BUCqBdmxq0FcD4GW4bZp
 1fNzVBf+sU0RLZ2wq2EjPu12HC6cDafnhw/whf8OwRdBzxnY4i8/5ImVlB/xjvEikWKE
 MKCkXziGP5tBFMt4Paf3HYecuUBZy6zomGo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gpr0ee0xr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:14 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 15 Jun 2022 16:03:12 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 13C36BA4C514; Wed, 15 Jun 2022 16:03:06 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/2] btf: support BTF_KIND_ENUM64
Date:   Wed, 15 Jun 2022 16:03:06 -0700
Message-ID: <20220615230306.851750-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f3SQVCZVBzWuV-JRLePZQbYsQsm0IIQG
X-Proofpoint-GUID: f3SQVCZVBzWuV-JRLePZQbYsQsm0IIQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_16,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for enum64. For 64-bit enumerator value,
previously, the value is truncated into 32bit, e.g.,
for the following enum in linux uapi bpf.h,
  enum {
        BPF_F_INDEX_MASK                =3D 0xffffffffULL,
        BPF_F_CURRENT_CPU               =3D BPF_F_INDEX_MASK,
  /* BPF_FUNC_perf_event_output for sk_buff input context. */
        BPF_F_CTXLEN_MASK               =3D (0xfffffULL << 32),
  };

BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
after pahole dwarf-to-btf conversion.
With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
with BTF_KIND_ENUM64.

This patch is on top of tmp.master since tmp.master has not
been sync'ed with master branch yet.

Changelogs:
  v1 -> v2:
    - Add flag --skip_encoding_btf_enum64 to disable newly-added function=
ality.

Yonghong Song (2):
  libbpf: Sync with latest libbpf repo
  btf: Support BTF_KIND_ENUM64

 btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
 btf_encoder.h     |  2 +-
 dwarf_loader.c    | 12 +++++++++
 dwarves.h         |  4 ++-
 dwarves_fprintf.c |  6 ++++-
 lib/bpf           |  2 +-
 pahole.c          | 10 +++++++-
 7 files changed, 80 insertions(+), 21 deletions(-)

--=20
2.30.2

