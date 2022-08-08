Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543358CC5C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiHHQr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbiHHQrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 12:47:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0B175B2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 09:47:34 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278ClNDl018579
        for <bpf@vger.kernel.org>; Mon, 8 Aug 2022 09:47:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=4RsmRSrA1DDHqlT9s2TuPUDx3xaXQnmmrxJvk5I9CRc=;
 b=h3OsnUFlRp6AWoscnxkWPkgpP3pSgaOqw2QLO2Tj9Z2CYq1WzogN15wghfUl3gR4sioy
 mdnnIhq+zJ/LYN+KvchPOZP1Vda/Tvh2E6q2uyP97J9zRywRIyW1iSOcUmRxOnY6O9Mu
 lrFsTkL6dwPzLtd3j7GDZ5XVEGIbeejQEe8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hskywkacp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 09:47:33 -0700
Received: from twshared16418.24.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 09:47:31 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A8C62B905A0F; Mon,  8 Aug 2022 09:47:24 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, <kernel-team@fb.com>,
        <slinger@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Improve docstring for BPF_F_USER_BUILD_ID flag
Date:   Mon, 8 Aug 2022 09:47:23 -0700
Message-ID: <20220808164723.3107500-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aKWHe3-9d6VEKE55sQzScKXFHwhu6rY-
X-Proofpoint-ORIG-GUID: aKWHe3-9d6VEKE55sQzScKXFHwhu6rY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Most tools which use bpf_get_stack or bpf_get_stackid symbolicate the
stack - meaning the stack of addresses in the target process' address
space is transformed into meaningful symbol names. The
BPF_F_USER_BUILD_ID flag eases this process by finding the build_id of
the file-backed vma which the address falls in and translating the
address to an offset within the backing file.

To be more specific, the offset is a "file offset" from the beginning of
the backing file. The symbols in ET_DYN ELF objects have a st_value
which is also described as an "offset" - but an offset in the process
address space, relative to the base address of the object.

It's necessary to translate between the "file offset" and "virtual
address offset" during symbolication before they can be directly
compared. Failure to do so can lead to confusing bugs, so this patch
clarifies language in the documentation in an attempt to keep this from
happening.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/uapi/linux/bpf.h       | 14 ++++++++++++--
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7bf9ba1329be..534e33fb1029 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3008,8 +3008,18 @@ union bpf_attr {
  * 		**BPF_F_USER_STACK**
  * 			Collect a user space stack instead of a kernel stack.
  * 		**BPF_F_USER_BUILD_ID**
- * 			Collect buildid+offset instead of ips for user stack,
- * 			only valid if **BPF_F_USER_STACK** is also specified.
+ * 			Collect (build_id, file_offset) instead of ips for user
+ * 			stack, only valid if **BPF_F_USER_STACK** is also
+ * 			specified.
+ *
+ * 			*file_offset* is an offset relative to the beginning
+ * 			of the executable or shared object file backing the vma
+ * 			which the *ip* falls in. It is *not* an offset relative
+ * 			to that object's base address. Accordingly, it must be
+ * 			adjusted by adding (sh_addr - sh_offset), where
+ * 			sh_{addr,offset} correspond to the executable section
+ * 			containing *file_offset* in the object, for comparisons
+ * 			to symbols' st_value to be valid.
  *
  * 		**bpf_get_stack**\ () can collect up to
  * 		**PERF_MAX_STACK_DEPTH** both kernel and user frames, subject
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 59a217ca2dfd..f58d58e1d547 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3008,8 +3008,18 @@ union bpf_attr {
  * 		**BPF_F_USER_STACK**
  * 			Collect a user space stack instead of a kernel stack.
  * 		**BPF_F_USER_BUILD_ID**
- * 			Collect buildid+offset instead of ips for user stack,
- * 			only valid if **BPF_F_USER_STACK** is also specified.
+ * 			Collect (build_id, file_offset) instead of ips for user
+ * 			stack, only valid if **BPF_F_USER_STACK** is also
+ * 			specified.
+ *
+ * 			*file_offset* is an offset relative to the beginning
+ * 			of the executable or shared object file backing the vma
+ * 			which the *ip* falls in. It is *not* an offset relative
+ * 			to that object's base address. Accordingly, it must be
+ * 			adjusted by adding (sh_addr - sh_offset), where
+ * 			sh_{addr,offset} correspond to the executable section
+ * 			containing *file_offset* in the object, for comparisons
+ * 			to symbols' st_value to be valid.
  *
  * 		**bpf_get_stack**\ () can collect up to
  * 		**PERF_MAX_STACK_DEPTH** both kernel and user frames, subject
--=20
2.30.2

