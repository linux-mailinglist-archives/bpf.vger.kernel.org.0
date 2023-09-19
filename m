Return-Path: <bpf+bounces-10354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD947A59AF
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 08:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1D281F6F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131335890;
	Tue, 19 Sep 2023 06:04:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC43180
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 06:04:00 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A0710F
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:59 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKG6Lx030303
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t60jdvcbb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:03:59 -0700
Received: from twshared19625.39.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 18 Sep 2023 23:03:58 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 5405524985074; Mon, 18 Sep 2023 23:03:42 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        Song Liu
	<song@kernel.org>
Subject: [PATCH bpf 0/2] s390/bpf: Fix arch_prepare_bpf_trampoline
Date: Mon, 18 Sep 2023 23:02:56 -0700
Message-ID: <20230919060258.3237176-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4uj3xz2iNnfJY4ywh9GVB2jPUVpfaUli
X-Proofpoint-GUID: 4uj3xz2iNnfJY4ywh9GVB2jPUVpfaUli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While working on trampoline, I found s390's arch_prepare_bpf_trampoline
returns 0 on success, which breaks struct_ops. However, the CI doesn't
catch this issue. Turns out test_progs:bpf_tcp_ca doesn't really test
members of a struct_ops are actually called via the trampolines.

1/2 fixes arch_prepare_bpf_trampoline for s390.
2/2 adds a check to test_progs:bpf_tcp_ca to verify bpf_cubic_acked() is
indeed called by the trampoline. Without 1/2, this check would fail on
s390.

Song Liu (2):
  s390/bpf: Let arch_prepare_bpf_trampoline return program size
  selftests/bpf: Check bpf_cubic_acked() is called via struct_ops

 arch/s390/net/bpf_jit_comp.c                        | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 2 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c       | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

--
2.34.1

