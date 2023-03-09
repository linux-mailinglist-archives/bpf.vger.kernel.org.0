Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659A6B1ADF
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 06:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCIFk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Mar 2023 00:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIFk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 00:40:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8BA82367
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 21:40:25 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3291KvUB010680
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 21:40:25 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6ffuhh01-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 21:40:24 -0800
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 21:40:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 80D6029AA204C; Wed,  8 Mar 2023 21:40:18 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 1/4] selftests/bpf: prevent unused variable warning in bpf_for()
Date:   Wed, 8 Mar 2023 21:40:12 -0800
Message-ID: <20230309054015.4068562-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309054015.4068562-1-andrii@kernel.org>
References: <20230309054015.4068562-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: halxKY6qNMVFj1pVDCNvnnpO_Y0AQLyz
X-Proofpoint-ORIG-GUID: halxKY6qNMVFj1pVDCNvnnpO_Y0AQLyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add __attribute__((unused)) to inner __p variable inside bpf_for(),
bpf_for_each(), and bpf_repeat() macros to avoid compiler warnings about
unused variable.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 43b154a639e7..c95eb603403c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -115,7 +115,8 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
 	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
 						    cleanup(bpf_iter_##type##_destroy))),	\
 	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
-			       *___p = (bpf_iter_##type##_new(&___it, ##args),			\
+			       *___p __attribute__((unused)) = (				\
+					bpf_iter_##type##_new(&___it, ##args),			\
 	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
 	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
 					(void)bpf_iter_##type##_destroy, (void *)0);		\
@@ -143,7 +144,8 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
 	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
 						 cleanup(bpf_iter_num_destroy))),		\
 	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
-			    *___p = (bpf_iter_num_new(&___it, (start), (end)),			\
+			    *___p __attribute__((unused)) = (					\
+				bpf_iter_num_new(&___it, (start), (end)),			\
 	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
 	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
 				(void)bpf_iter_num_destroy, (void *)0);				\
@@ -167,7 +169,8 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
 	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
 						 cleanup(bpf_iter_num_destroy))),		\
 	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
-			    *___p = (bpf_iter_num_new(&___it, 0, (N)),				\
+			    *___p __attribute__((unused)) = (					\
+				bpf_iter_num_new(&___it, 0, (N)),				\
 	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
 	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
 				(void)bpf_iter_num_destroy, (void *)0);				\
-- 
2.34.1

