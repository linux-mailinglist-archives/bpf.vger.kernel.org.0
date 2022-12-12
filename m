Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2564A966
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 22:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiLLVSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 12 Dec 2022 16:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiLLVRt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 16:17:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFC167C6
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:15:28 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCHZ661017692
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:15:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4h3cnfw-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 13:15:28 -0800
Received: from twshared19054.43.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 13:15:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EE06423545216; Mon, 12 Dec 2022 13:15:18 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        =?UTF-8?q?Per=20Sundstr=C3=B6m=20XP?= 
        <per.xp.sundstrom@ericsson.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: add few corner cases to test padding handling of btf_dump
Date:   Mon, 12 Dec 2022 13:15:05 -0800
Message-ID: <20221212211505.558851-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212211505.558851-1-andrii@kernel.org>
References: <20221212211505.558851-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yKXHLKWcTmB8-Qq324U-bPxUwZKEFDg6
X-Proofpoint-ORIG-GUID: yKXHLKWcTmB8-Qq324U-bPxUwZKEFDg6
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few hand-crafted cases and few randomized cases found using script
from [0] that tests btf_dump's padding logic.

  [0] https://lore.kernel.org/bpf/85f83c333f5355c8ac026f835b18d15060725fcb.camel@ericsson.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/btf_dump_test_case_packing.c    |  61 +++++++++-
 .../bpf/progs/btf_dump_test_case_padding.c    | 104 ++++++++++++++++++
 2 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
index e304b6204bd9..5c6c62f7ed32 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
@@ -58,7 +58,64 @@ union jump_code_union {
 	} __attribute__((packed));
 };
 
-/*------ END-EXPECTED-OUTPUT ------ */
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *struct nested_packed_but_aligned_struct {
+ *	int x1;
+ *	int x2;
+ *};
+ *
+ *struct outer_implicitly_packed_struct {
+ *	char y1;
+ *	struct nested_packed_but_aligned_struct y2;
+ *} __attribute__((packed));
+ *
+ */
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+struct nested_packed_but_aligned_struct {
+	int x1;
+	int x2;
+} __attribute__((packed));
+
+struct outer_implicitly_packed_struct {
+	char y1;
+	struct nested_packed_but_aligned_struct y2;
+};
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *struct usb_ss_ep_comp_descriptor {
+ *	char: 8;
+ *	char bDescriptorType;
+ *	char bMaxBurst;
+ *	short wBytesPerInterval;
+ *};
+ *
+ *struct usb_host_endpoint {
+ *	long: 64;
+ *	char: 8;
+ *	struct usb_ss_ep_comp_descriptor ss_ep_comp;
+ *	long: 0;
+ *} __attribute__((packed));
+ *
+ */
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+struct usb_ss_ep_comp_descriptor {
+	char: 8;
+	char bDescriptorType;
+	char bMaxBurst;
+	int: 0;
+	short wBytesPerInterval;
+} __attribute__((packed));
+
+struct usb_host_endpoint {
+	long: 64;
+	char: 8;
+	struct usb_ss_ep_comp_descriptor ss_ep_comp;
+	long: 0;
+};
+
 
 int f(struct {
 	struct packed_trailing_space _1;
@@ -69,6 +126,8 @@ int f(struct {
 	union union_is_never_packed _6;
 	union union_does_not_need_packing _7;
 	union jump_code_union _8;
+	struct outer_implicitly_packed_struct _9;
+	struct usb_host_endpoint _10;
 } *_)
 {
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index 6f963d34c45b..79276fbe454a 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -128,6 +128,98 @@ struct padding_weird_2 {
 	char: 8;
 };
 
+/* ----- START-EXPECTED-OUTPUT ----- */
+struct exact_1byte {
+	char x;
+};
+
+struct padded_1byte {
+	char: 8;
+};
+
+struct exact_2bytes {
+	short x;
+};
+
+struct padded_2bytes {
+	short: 16;
+};
+
+struct exact_4bytes {
+	int x;
+};
+
+struct padded_4bytes {
+	int: 32;
+};
+
+struct exact_8bytes {
+	long x;
+};
+
+struct padded_8bytes {
+	long: 64;
+};
+
+struct ff_periodic_effect {
+	int: 32;
+	short magnitude;
+	long: 0;
+	short phase;
+	long: 0;
+	int: 32;
+	int custom_len;
+	short *custom_data;
+};
+
+struct ib_wc {
+	long: 64;
+	long: 64;
+	int: 32;
+	int byte_len;
+	void *qp;
+	union {} ex;
+	long: 64;
+	int slid;
+	int wc_flags;
+	long: 64;
+	char smac[6];
+	long: 0;
+	char network_hdr_type;
+};
+
+struct acpi_object_method {
+	long: 64;
+	char: 8;
+	char type;
+	short reference_count;
+	char flags;
+	short: 0;
+	char: 8;
+	char sync_level;
+	long: 64;
+	void *node;
+	void *aml_start;
+	union {} dispatch;
+	long: 64;
+	int aml_length;
+};
+
+struct nested_unpacked {
+	int x;
+};
+
+struct nested_packed {
+	struct nested_unpacked a;
+	char c;
+} __attribute__((packed));
+
+struct outer_mixed_but_unpacked {
+	struct nested_packed b1;
+	short a1;
+	struct nested_packed b2;
+};
+
 /* ------ END-EXPECTED-OUTPUT ------ */
 
 int f(struct {
@@ -139,6 +231,18 @@ int f(struct {
 	struct padding_wo_named_members _6;
 	struct padding_weird_1 _7;
 	struct padding_weird_2 _8;
+	struct exact_1byte _100;
+	struct padded_1byte _101;
+	struct exact_2bytes _102;
+	struct padded_2bytes _103;
+	struct exact_4bytes _104;
+	struct padded_4bytes _105;
+	struct exact_8bytes _106;
+	struct padded_8bytes _107;
+	struct ff_periodic_effect _200;
+	struct ib_wc _201;
+	struct acpi_object_method _202;
+	struct outer_mixed_but_unpacked _203;
 } *_)
 {
 	return 0;
-- 
2.30.2

