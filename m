Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29835503378
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiDPEdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 00:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiDPEdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 00:33:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359D111DE6
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23G2NKk7029767
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YJLHnvitaMlu6HhIN4yl5Zp2LrRP6cc3IrLgGUeAXII=;
 b=o34n1PtxfF0uwQurmlVS7V97FTWhwGAETGtL73y8hwhZL/48M+72LyfgEgDrygonFF3A
 +OuQ1MLIDhDSUhAlThjmYABGAgIaeh9gkw+DS3XLLEukjJjuME+AYgihl2p13AmF3cfb
 aJi4y8cgaqsRIg1l8TBULeMbMJ5I3lTG6Zc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fewgpq0m6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 21:30:36 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 21:30:35 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 6508D252D7DA; Fri, 15 Apr 2022 21:30:27 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v6 4/6] bpf: Create fentry/fexit/fmod_ret links through BPF_LINK_CREATE
Date:   Fri, 15 Apr 2022 21:29:38 -0700
Message-ID: <20220416042940.656344-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042940.656344-1-kuifeng@fb.com>
References: <20220416042940.656344-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YLScwboisxLEebAL-HDSapTYKN-gLLZ5
X-Proofpoint-GUID: YLScwboisxLEebAL-HDSapTYKN-gLLZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-16_01,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make fentry/fexit/fmod_ret as valid attach-types for BPF_LINK_CREATE.
Pass a cookie along with BPF_LINK_CREATE requests.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 include/uapi/linux/bpf.h       | 7 +++++++
 kernel/bpf/syscall.c           | 9 +++++++++
 tools/include/uapi/linux/bpf.h | 7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a4f557338af7..780be5a8ae39 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1490,6 +1490,13 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		cookie;
+			} tracing;
 		};
 	} link_create;
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 966f2d40ae55..ca14b0a2e222 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3189,6 +3189,10 @@ attach_type_to_prog_type(enum bpf_attach_type atta=
ch_type)
 		return BPF_PROG_TYPE_SK_LOOKUP;
 	case BPF_XDP:
 		return BPF_PROG_TYPE_XDP;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+		return BPF_PROG_TYPE_TRACING;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -4254,6 +4258,11 @@ static int tracing_bpf_link_attach(const union bpf=
_attr *attr, bpfptr_t uattr,
 					       attr->link_create.target_fd,
 					       attr->link_create.target_btf_id,
 					       0);
+	else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING)
+		return bpf_tracing_prog_attach(prog,
+					       0,
+					       0,
+					       attr->link_create.tracing.cookie);
=20
 	return -EINVAL;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a4f557338af7..780be5a8ae39 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1490,6 +1490,13 @@ union bpf_attr {
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
 			} kprobe_multi;
+			struct {
+				/* black box user-provided value passed through
+				 * to BPF program at the execution time and
+				 * accessible through bpf_get_attach_cookie() BPF helper
+				 */
+				__u64		cookie;
+			} tracing;
 		};
 	} link_create;
=20
--=20
2.30.2

