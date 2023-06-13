Return-Path: <bpf+bounces-2558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5972EF87
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A468F281013
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D701A3446C;
	Tue, 13 Jun 2023 22:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E613ADF
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 22:35:53 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16F81BE
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:52 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35DJZRjj032387
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:51 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3r6q9e5521-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:51 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:35:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A4F4C32D46378; Tue, 13 Jun 2023 15:35:34 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/4] Clean up BPF permissions checks
Date: Tue, 13 Jun 2023 15:35:29 -0700
Message-ID: <20230613223533.3689589-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TfD8NsXUS5XSir3OBQUdHpMe5_y8Rgum
X-Proofpoint-ORIG-GUID: TfD8NsXUS5XSir3OBQUdHpMe5_y8Rgum
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set contains a few refactorings to BPF map and BPF program creat=
ion
permissions checks, which were originally part of BPF token patch set ([0]),
but are logically completely independent and useful in their own right.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D755113&=
state=3D*

Andrii Nakryiko (4):
  bpf: move unprivileged checks into map_create() and bpf_prog_load()
  bpf: inline map creation logic in map_create() function
  bpf: centralize permissions checks for all BPF map types
  bpf: keep BPF_PROG_LOAD permission checks clear of validations

 kernel/bpf/bloom_filter.c                     |   3 -
 kernel/bpf/bpf_local_storage.c                |   3 -
 kernel/bpf/bpf_struct_ops.c                   |   3 -
 kernel/bpf/cpumap.c                           |   4 -
 kernel/bpf/devmap.c                           |   3 -
 kernel/bpf/hashtab.c                          |   6 -
 kernel/bpf/lpm_trie.c                         |   3 -
 kernel/bpf/queue_stack_maps.c                 |   4 -
 kernel/bpf/reuseport_array.c                  |   3 -
 kernel/bpf/stackmap.c                         |   3 -
 kernel/bpf/syscall.c                          | 155 +++++++++++-------
 net/core/sock_map.c                           |   4 -
 net/xdp/xskmap.c                              |   4 -
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
 14 files changed, 102 insertions(+), 102 deletions(-)

--=20
2.34.1


