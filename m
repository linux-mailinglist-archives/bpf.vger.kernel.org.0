Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5485622B56B
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 20:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGWSJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 14:09:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgGWSJ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 14:09:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NHubhj014302
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U3SkbezjWke+EWLpOiDoEv2H4KvIsgFd/ZYOLoDIRrc=;
 b=d5i73jiiGRWwPiClrFQ3HjIHjKtCQ9BugxQjDw33lj8mp7AtoT0aQi0NQGbY0PN/KHPI
 EjOUMQM1yLEr0VzY0+ifc0P1/510xJCC7jEwTg+QIQM3KK0auoIBzIhNdfz+2qX8SPkp
 9xHvIQS0cSw6gdOF8NuWbzYiFudEae9F0TY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32etmwdds5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:09:55 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:09:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 11C4F62E5050; Thu, 23 Jul 2020 11:06:58 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 2/5] bpf: fail PERF_EVENT_IOC_SET_BPF when bpf_get_[stack|stackid] cannot work
Date:   Thu, 23 Jul 2020 11:06:45 -0700
Message-ID: <20200723180648.1429892-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723180648.1429892-1-songliubraving@fb.com>
References: <20200723180648.1429892-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_get_[stack|stackid] on perf_events with precise_ip uses callchain
attached to perf_sample_data. If this callchain is not presented, do not
allow attaching BPF program that calls bpf_get_[stack|stackid] to this
event.

In the error case, -EPROTO is returned so that libbpf can identify this
error and print proper hint message.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/filter.h |  3 ++-
 kernel/bpf/verifier.c  |  3 +++
 kernel/events/core.c   | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1c6b6d982bf49..135692027dd8b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -532,7 +532,8 @@ struct bpf_prog {
 				is_func:1,	/* program is a bpf function */
 				kprobe_override:1, /* Do we override a kprobe? */
 				has_callchain_buf:1, /* callchain buffer allocated? */
-				enforce_expected_attach_type:1; /* Enforce expected_attach_type chec=
king at attach time */
+				enforce_expected_attach_type:1, /* Enforce expected_attach_type chec=
king at attach time */
+				call_get_stack:1; /* Do we call bpf_get_stack() or bpf_get_stackid()=
 */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a6703bc3f36f..41c9517a505ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4887,6 +4887,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, int func_id, int insn
 		env->prog->has_callchain_buf =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_stackid || func_id =3D=3D BPF_FUNC_get_=
stack)
+		env->prog->call_get_stack =3D true;
+
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f562..ddcfd2fb5cc5a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9544,6 +9544,24 @@ static int perf_event_set_bpf_handler(struct perf_=
event *event, u32 prog_fd)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
=20
+	if (event->attr.precise_ip &&
+	    prog->call_get_stack &&
+	    (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY) ||
+	     event->attr.exclude_callchain_kernel ||
+	     event->attr.exclude_callchain_user)) {
+		/*
+		 * On perf_event with precise_ip, calling bpf_get_stack()
+		 * may trigger unwinder warnings and occasional crashes.
+		 * bpf_get_[stack|stackid] works around this issue by using
+		 * callchain attached to perf_sample_data. If the
+		 * perf_event does not full (kernel and user) callchain
+		 * attached to perf_sample_data, do not allow attaching BPF
+		 * program that calls bpf_get_[stack|stackid].
+		 */
+		bpf_prog_put(prog);
+		return -EPROTO;
+	}
+
 	event->prog =3D prog;
 	event->orig_overflow_handler =3D READ_ONCE(event->overflow_handler);
 	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
--=20
2.24.1

