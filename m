Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9C21C191
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 03:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgGKB3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 21:29:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42720 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbgGKB3P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 21:29:15 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B1SpQn018695
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sCfAZ8R5XYksxd3Rvwf64+RwJ+YDSaUF1RQ9sffmk+Q=;
 b=HU43yetMXZDvRF3zsuYSQxsoMkUj8o5Mp1sTPmPYUor9xsV07JSLu0vRN6aok0fYhRVB
 6hgegPFOxuyDYRsAzNQzqXC9u9VG8ZRtgdtKtYORJIICFh8YrypqbajzyTV8wEmCzM/G
 9qxv26iR08PlFC9KZfeaiR7aF3QNYvpVOTI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 325k2cn9te-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:14 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 18:29:12 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DC9EE62E50B7; Fri, 10 Jul 2020 18:26:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/5] bpf: block bpf_get_[stack|stackid] on perf_event with PEBS entries
Date:   Fri, 10 Jul 2020 18:26:35 -0700
Message-ID: <20200711012639.3429622-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200711012639.3429622-1-songliubraving@fb.com>
References: <20200711012639.3429622-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling get_perf_callchain() on perf_events from PEBS entries may cause
unwinder errors. To fix this issue, the callchain is fetched early. Such
perf_events are marked with __PERF_SAMPLE_CALLCHAIN_EARLY.

Similarly, calling bpf_get_[stack|stackid] on perf_events from PEBS may
also cause unwinder errors. To fix this, block bpf_get_[stack|stackid] on
these perf_events. Unfortunately, bpf verifier cannot tell whether the
program will be attached to perf_event with PEBS entries. Therefore,
block such programs during ioctl(PERF_EVENT_IOC_SET_BPF).

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/filter.h |  3 ++-
 kernel/bpf/verifier.c  |  3 +++
 kernel/events/core.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2593777236037..fb34dc40f039b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -534,7 +534,8 @@ struct bpf_prog {
 				is_func:1,	/* program is a bpf function */
 				kprobe_override:1, /* Do we override a kprobe? */
 				has_callchain_buf:1, /* callchain buffer allocated? */
-				enforce_expected_attach_type:1; /* Enforce expected_attach_type chec=
king at attach time */
+				enforce_expected_attach_type:1, /* Enforce expected_attach_type chec=
king at attach time */
+				call_get_perf_callchain:1; /* Do we call helpers that uses get_perf_=
callchain()? */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b608185e1ffd5..1e11b0f6fba31 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4884,6 +4884,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, int func_id, int insn
 		env->prog->has_callchain_buf =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_stackid || func_id =3D=3D BPF_FUNC_get_=
stack)
+		env->prog->call_get_perf_callchain =3D true;
+
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f562..f2f575a286bb4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9544,6 +9544,16 @@ static int perf_event_set_bpf_handler(struct perf_=
event *event, u32 prog_fd)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
=20
+	if ((event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY) &&
+	    prog->call_get_perf_callchain) {
+		/*
+		 * The perf_event get_perf_callchain() early, the attached
+		 * BPF program shouldn't call get_perf_callchain() again.
+		 */
+		bpf_prog_put(prog);
+		return -EINVAL;
+	}
+
 	event->prog =3D prog;
 	event->orig_overflow_handler =3D READ_ONCE(event->overflow_handler);
 	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
--=20
2.24.1

