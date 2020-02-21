Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E74166BF7
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 01:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBUAn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 19:43:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729419AbgBUAn6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Feb 2020 19:43:58 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L0hXOX007585
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 16:43:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kjDbiIqCnoVyTemxISZnVpkeVp6Rk3Hp49wUOig0jZs=;
 b=nKtEY1NNMc35xN2F7BAT5o24yWpON+bUdhiPnna3GbB8iUvgkbe6eUBEFcruQsnyh9q/
 r4g4zzr2bYKPU+CADNexYyU3sxiWT3OkhOTlu7Fc6+pGaaNjrLPtltmHUgIr7/zkPCXp
 3AVxTcohpnWQ/lLsY1NMaoPIZcdRP7kMeaA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y9q5dv6d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 16:43:57 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 20 Feb 2020 16:43:55 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 35D2137047DF; Thu, 20 Feb 2020 16:43:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] docs/bpf: update bpf development Q/A file
Date:   Thu, 20 Feb 2020 16:43:54 -0800
Message-ID: <20200221004354.930952-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 suspectscore=1 impostorscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf now has its own mailing list bpf@vger.kernel.org.
Update the bpf_devel_QA.rst file to reflect this.

Also llvm has switch to github with llvm and clang
in the same repo https://github.com/llvm/llvm-project.git.
Update the QA file with newer build instructions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index c9856b927055..38c15c6fcb14 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -20,11 +20,11 @@ Reporting bugs
 Q: How do I report bugs for BPF kernel code?
 --------------------------------------------
 A: Since all BPF kernel development as well as bpftool and iproute2 BPF
-loader development happens through the netdev kernel mailing list,
+loader development happens through the bpf kernel mailing list,
 please report any found issues around BPF to the following mailing
 list:
 
- netdev@vger.kernel.org
+ bpf@vger.kernel.org
 
 This may also include issues related to XDP, BPF tracing, etc.
 
@@ -46,17 +46,12 @@ Submitting patches
 
 Q: To which mailing list do I need to submit my BPF patches?
 ------------------------------------------------------------
-A: Please submit your BPF patches to the netdev kernel mailing list:
+A: Please submit your BPF patches to the bpf kernel mailing list:
 
- netdev@vger.kernel.org
-
-Historically, BPF came out of networking and has always been maintained
-by the kernel networking community. Although these days BPF touches
-many other subsystems as well, the patches are still routed mainly
-through the networking community.
+ bpf@vger.kernel.org
 
 In case your patch has changes in various different subsystems (e.g.
-tracing, security, etc), make sure to Cc the related kernel mailing
+networking, tracing, security, etc), make sure to Cc the related kernel mailing
 lists and maintainers from there as well, so they are able to review
 the changes and provide their Acked-by's to the patches.
 
@@ -168,7 +163,7 @@ a BPF point of view.
 Be aware that this is not a final verdict that the patch will
 automatically get accepted into net or net-next trees eventually:
 
-On the netdev kernel mailing list reviews can come in at any point
+On the bpf kernel mailing list reviews can come in at any point
 in time. If discussions around a patch conclude that they cannot
 get included as-is, we will either apply a follow-up fix or drop
 them from the trees entirely. Therefore, we also reserve to rebase
@@ -494,15 +489,15 @@ A: You need cmake and gcc-c++ as build requisites for LLVM. Once you have
 that set up, proceed with building the latest LLVM and clang version
 from the git repositories::
 
-     $ git clone http://llvm.org/git/llvm.git
-     $ cd llvm/tools
-     $ git clone --depth 1 http://llvm.org/git/clang.git
-     $ cd ..; mkdir build; cd build
-     $ cmake .. -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
+     $ git clone https://github.com/llvm/llvm-project.git
+     $ mkdir -p llvm-project/llvm/build/install
+     $ cd llvm-project/llvm/build
+     $ cmake .. -G "Ninja" -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
+                -DLLVM_ENABLE_PROJECTS="clang"    \
                 -DBUILD_SHARED_LIBS=OFF           \
                 -DCMAKE_BUILD_TYPE=Release        \
                 -DLLVM_BUILD_RUNTIME=OFF
-     $ make -j $(getconf _NPROCESSORS_ONLN)
+     $ ninja
 
 The built binaries can then be found in the build/bin/ directory, where
 you can point the PATH variable to.
-- 
2.17.1

