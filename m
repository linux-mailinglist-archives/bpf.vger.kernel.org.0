Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE7CC7FE
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2019 07:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJEFDW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 5 Oct 2019 01:03:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfJEFDW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Oct 2019 01:03:22 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9550mj3016304
        for <bpf@vger.kernel.org>; Fri, 4 Oct 2019 22:03:21 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vdmh9g4rj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 22:03:21 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 4 Oct 2019 22:03:19 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id DF7DD76091D; Fri,  4 Oct 2019 22:03:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 01/10] bpf: add typecast to raw_tracepoints to help BTF generation
Date:   Fri, 4 Oct 2019 22:03:05 -0700
Message-ID: <20191005050314.1114330-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191005050314.1114330-1-ast@kernel.org>
References: <20191005050314.1114330-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-05_02:2019-10-03,2019-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 adultscore=0 impostorscore=0 clxscore=1034 priorityscore=1501
 mlxlogscore=819 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910050044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When pahole converts dwarf to btf it emits only used types.
Wrap existing __bpf_trace_##template() function into
btf_trace_##template typedef and use it in type cast to
make gcc emits this type into dwarf. Then pahole will convert it to btf.
The "btf_trace_" prefix will be used to identify BTF enabled raw tracepoints.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/trace/bpf_probe.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index d6e556c0a085..ff1a879773df 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -74,11 +74,12 @@ static inline void bpf_test_probe_##call(void)				\
 {									\
 	check_trace_callback_type_##call(__bpf_trace_##template);	\
 }									\
+typedef void (*btf_trace_##template)(void *__data, proto);		\
 static struct bpf_raw_event_map	__used					\
 	__attribute__((section("__bpf_raw_tp_map")))			\
 __bpf_trace_tp_map_##call = {						\
 	.tp		= &__tracepoint_##call,				\
-	.bpf_func	= (void *)__bpf_trace_##template,		\
+	.bpf_func	= (void *)(btf_trace_##template)__bpf_trace_##template,	\
 	.num_args	= COUNT_ARGS(args),				\
 	.writable_size	= size,						\
 };
-- 
2.20.0

