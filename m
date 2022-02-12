Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86154B3359
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 06:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiBLF55 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 00:57:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLF55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 00:57:57 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725EE28E3E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:53 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21C4bwtn006889
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5sug56ev-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 21:57:52 -0800
Received: from twshared27297.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 21:57:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 39B7F10BF5C65; Fri, 11 Feb 2022 21:57:36 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/2] bpftool: add C++-specific open/load/etc skeleton wrappers
Date:   Fri, 11 Feb 2022 21:57:32 -0800
Message-ID: <20220212055733.539056-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212055733.539056-1-andrii@kernel.org>
References: <20220212055733.539056-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XwY5CulTwCI7op7SVOG-17feJQZgoGZo
X-Proofpoint-GUID: XwY5CulTwCI7op7SVOG-17feJQZgoGZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_01,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=986
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202120033
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add C++-specific static methods for code-generated BPF skeleton for each
skeleton operation: open, open_opts, open_and_load, load, attach,
detach, destroy, and elf_bytes. This is to facilitate easier C++
templating on top of pure C BPF skeleton.

In C, open/load/destroy/etc "methods" are of the form
<skeleton_name>__<method>() to avoid name collision with similar
"methods" of other skeletons withint the same application. This works
well, but is very inconvenient for C++ applications that would like to
write generic (templated) wrappers around BPF skeleton to fit in with
C++ code base and take advantage of destructors and other convenient C++
constructs.

This patch makes it easier to build such generic templated wrappers by
additionally defining C++ static methods for skeleton's struct with
fixed names. This allows to refer to, say, open method as `T::open()`
instead of having to somehow generate `T__open()` function call.

Next patch adds an example template to test_cpp selftest to demonstrate
how it's possible to have all the operations wrapped in a generic
Skeleton<my_skeleton> type without explicitly passing function references.

An example of generated declaration section without %1$s placeholders:

  #ifdef __cplusplus
      static struct test_attach_probe *open(const struct bpf_object_open_opts *opts = nullptr);
      static struct test_attach_probe *open_and_load();
      static int load(struct test_attach_probe *skel);
      static int attach(struct test_attach_probe *skel);
      static void detach(struct test_attach_probe *skel);
      static void destroy(struct test_attach_probe *skel);
      static const void *elf_bytes(size_t *sz);
  #endif /* __cplusplus */

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6f2e20be0c62..022f30490567 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -831,6 +831,16 @@ static int do_skeleton(int argc, char **argv)
 
 	codegen("\
 		\n\
+									    \n\
+		#ifdef __cplusplus					    \n\
+			static struct %1$s *open(const struct bpf_object_open_opts *opts = nullptr);\n\
+			static struct %1$s *open_and_load();		    \n\
+			static int load(struct %1$s *skel);		    \n\
+			static int attach(struct %1$s *skel);		    \n\
+			static void detach(struct %1$s *skel);		    \n\
+			static void destroy(struct %1$s *skel);		    \n\
+			static const void *elf_bytes(size_t *sz);	    \n\
+		#endif /* __cplusplus */				    \n\
 		};							    \n\
 									    \n\
 		static void						    \n\
@@ -1025,9 +1035,19 @@ static int do_skeleton(int argc, char **argv)
 		\";							    \n\
 		}							    \n\
 									    \n\
-		#endif /* %s */						    \n\
+		#ifdef __cplusplus					    \n\
+		struct %1$s *%1$s::open(const struct bpf_object_open_opts *opts) { return %1$s__open_opts(opts); }\n\
+		struct %1$s *%1$s::open_and_load() { return %1$s__open_and_load(); }	\n\
+		int %1$s::load(struct %1$s *skel) { return %1$s__load(skel); }		\n\
+		int %1$s::attach(struct %1$s *skel) { return %1$s__attach(skel); }	\n\
+		void %1$s::detach(struct %1$s *skel) { %1$s__detach(skel); }		\n\
+		void %1$s::destroy(struct %1$s *skel) { %1$s__destroy(skel); }		\n\
+		const void *%1$s::elf_bytes(size_t *sz) { return %1$s__elf_bytes(sz); } \n\
+		#endif /* __cplusplus */				    \n\
+									    \n\
+		#endif /* %2$s */					    \n\
 		",
-		header_guard);
+		obj_name, header_guard);
 	err = 0;
 out:
 	bpf_object__close(obj);
-- 
2.30.2

