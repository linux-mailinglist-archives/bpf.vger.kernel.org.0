Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890C115CCD7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBMVBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 16:01:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbgBMVB3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Feb 2020 16:01:29 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DL12st026625
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 13:01:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s5AINjqbi4/0oeVLttio2uLVEGZPsLRmz6siQCTuMVM=;
 b=JI0/4LdgSgjGVTI2aJZb2j+fQEQ0XwVW5EPVl46WNZDUdCi3M27PwfrO6ADV7qINwug+
 amXvwmx7IZKj/2bqnezENk9LbRs26jVDUjcm2u7zDSqU8Fy8TwwW5ra3RzdC6uDvaGzZ
 +y0b00lXy3FZWdgDnhhk/krIKWrFY5y1m7s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y44cxuvmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 13:01:29 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 13 Feb 2020 13:01:28 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C4A9A62E1882; Thu, 13 Feb 2020 13:01:21 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC bpf-next 1/4] bpf: allow bpf_perf_event_read_value in all BPF programs
Date:   Thu, 13 Feb 2020 13:01:12 -0800
Message-ID: <20200213210115.1455809-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213210115.1455809-1-songliubraving@fb.com>
References: <20200213210115.1455809-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_08:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=932 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_perf_event_read_value() is NMI safe. Enable it for all BPF programs.
This can be used in fentry/fexit to profile BPF program and individual
kernel function with hardware counters.

Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/trace/bpf_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 19e793aa441a..4ddd5ac46094 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -843,6 +843,8 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_send_signal_proto;
 	case BPF_FUNC_send_signal_thread:
 		return &bpf_send_signal_thread_proto;
+	case BPF_FUNC_perf_event_read_value:
+		return &bpf_perf_event_read_value_proto;
 	default:
 		return NULL;
 	}
@@ -858,8 +860,6 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stackid_proto;
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto;
-	case BPF_FUNC_perf_event_read_value:
-		return &bpf_perf_event_read_value_proto;
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 	case BPF_FUNC_override_return:
 		return &bpf_override_return_proto;
-- 
2.17.1

