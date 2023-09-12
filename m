Return-Path: <bpf+bounces-9704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042C79C65E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF62A281555
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C3171A6;
	Tue, 12 Sep 2023 05:59:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262A28E6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 05:59:49 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2CE6F
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 22:59:48 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C1QIvc000879
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 22:59:48 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t28mypft5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 22:59:48 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 11 Sep 2023 22:59:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3CC6D37E94062; Mon, 11 Sep 2023 22:59:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf] selftests/bpf: ensure all CI arches set CONFIG_BPF_KPROBE_OVERRIDE=y
Date: Mon, 11 Sep 2023 22:59:28 -0700
Message-ID: <20230912055928.1704269-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: C054GDU81TlBtP1tTwZBW49Vz1MF9mON
X-Proofpoint-GUID: C054GDU81TlBtP1tTwZBW49Vz1MF9mON
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02

Turns out CONFIG_BPF_KPROBE_OVERRIDE=3Dy is only enabled in x86-64 CI, but
is not set on aarch64, causing CI failures ([0]).

Move CONFIG_BPF_KPROBE_OVERRIDE=3Dy to arch-agnostic CI config.

  [0] https://github.com/kernel-patches/bpf/actions/runs/6122324047/job/166=
18390535

Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/config        | 1 +
 tools/testing/selftests/bpf/config.x86_64 | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 1c7584e8dd9e..e41eb33b2704 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -4,6 +4,7 @@ CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
 CONFIG_BPF=3Dy
 CONFIG_BPF_EVENTS=3Dy
 CONFIG_BPF_JIT=3Dy
+CONFIG_BPF_KPROBE_OVERRIDE=3Dy
 CONFIG_BPF_LIRC_MODE2=3Dy
 CONFIG_BPF_LSM=3Dy
 CONFIG_BPF_STREAM_PARSER=3Dy
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/self=
tests/bpf/config.x86_64
index b650b2e617b8..2e70a6048278 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -20,7 +20,6 @@ CONFIG_BLK_DEV_THROTTLING=3Dy
 CONFIG_BONDING=3Dy
 CONFIG_BOOTTIME_TRACING=3Dy
 CONFIG_BPF_JIT_ALWAYS_ON=3Dy
-CONFIG_BPF_KPROBE_OVERRIDE=3Dy
 CONFIG_BPF_PRELOAD=3Dy
 CONFIG_BPF_PRELOAD_UMD=3Dy
 CONFIG_BPFILTER=3Dy
--=20
2.34.1


