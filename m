Return-Path: <bpf+bounces-14769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829F7E7BBB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA228157A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39E14F79;
	Fri, 10 Nov 2023 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSLimL0H"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978A14AB0
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:16:06 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7F2DE7E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:16:04 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZH6L016135;
	Fri, 10 Nov 2023 11:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=PHknHcswUDZRjwBzqCsIHBmjL19QHIDdeSDK1HSZToM=;
 b=QSLimL0HN0TGLtR3vXLeQeWml86eVSkf8PY8KTfc7siq15I/8YOweTAfHtEr0RJdCn74
 br6In3xN807oSKuntbemkv2oLfbC6fJBcKwUwbVB/ipAdHhTvjtPaGpnBsyPgC0Ms8nW
 pUhe6/dBJo0Qmz0OYfAVXvdk7Me747AuNcJEg6Wq+Z1cjF4RqnpZKq4ESZdNQ+stF6gE
 8cyNQQfyJmwxWBNdyswP6qfdNcFEumxHqf3X1DcRceDW+bz5NAmXAj6IEj7o8aF0Dj36
 ipTqjXyOagM2oqwkpMfnmJb4FhmqIMX/BcKErK4Nr/cWLlgTUEsdJp61bT+yylskupwj jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26x05g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:15:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAB0ntm004021;
	Fri, 10 Nov 2023 11:15:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w20se8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:15:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AABFh3L015225;
	Fri, 10 Nov 2023 11:15:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3u7w20sdw0-1;
	Fri, 10 Nov 2023 11:15:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH] pahole: add support for kind layout, CRC encoding BTF features
Date: Fri, 10 Nov 2023 11:15:33 +0000
Message-Id: <20231110111533.64608-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100092
X-Proofpoint-GUID: hDngwYePpzVKo1yZXixOMt7_F923BAfe
X-Proofpoint-ORIG-GUID: hDngwYePpzVKo1yZXixOMt7_F923BAfe

add "kind_layout" and "crc" features for adding BTF kind layout
section and adding CRCs to BTF headers respectively; this support
depends on the libbpf support added in [1].

Bump version to 1.26 to allow kernel to recognize support for
"--btf_fetaures"; vesion-based feature tests > 1.26 will be no
longer needed now that --btf_features can silently ignore
unknown features.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
---
 CMakeLists.txt     | 4 ++--
 btf_encoder.c      | 7 ++++++-
 dwarves.h          | 2 ++
 man-pages/pahole.1 | 4 ++++
 pahole.c           | 2 ++
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 98642e1..a250182 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -54,9 +54,9 @@ if (NOT DEFINED BUILD_SHARED_LIBS)
 endif (NOT DEFINED BUILD_SHARED_LIBS)
 
 # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
-# add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.25")
+# add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.26")
 add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
-add_definitions(-D_GNU_SOURCE -DDWARVES_MINOR_VERSION=25)
+add_definitions(-D_GNU_SOURCE -DDWARVES_MINOR_VERSION=26)
 find_package(DWARF REQUIRED)
 find_package(ZLIB REQUIRED)
 find_package(argp REQUIRED)
diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..0167cc5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1630,12 +1630,17 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
 	if (encoder) {
+		LIBBPF_OPTS(btf_new_opts, new_opts);
+
+		new_opts.base_btf = base_btf;
+		new_opts.add_crc = conf_load->btf_gen_crc;
+		new_opts.add_kind_layout = conf_load->btf_gen_kind_layout;
 		encoder->raw_output = detached_filename != NULL;
 		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
 		if (encoder->filename == NULL)
 			goto out_delete;
 
-		encoder->btf = btf__new_empty_split(base_btf);
+		encoder->btf = btf__new_empty_opts(&new_opts);
 		if (encoder->btf == NULL)
 			goto out_delete;
 
diff --git a/dwarves.h b/dwarves.h
index 857b37c..b1bea14 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -86,6 +86,8 @@ struct conf_load {
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
 	bool			btf_gen_floats;
+	bool			btf_gen_crc;
+	bool			btf_gen_kind_layout;
 	bool			btf_encode_force;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index ea9045c..1d0a627 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -293,6 +293,10 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
 	                   in some CUs and not others, or when the same
 	                   function name has inconsistent BTF descriptions
 	                   in different CUs.
+	crc                Generate CRC in BTF header.
+	kind_layout        Add BTF kind layout section, which describes the
+                           layout of the known BTF kinds at time of
+                           encoding.  This helps parsers read BTF.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index 768a2fe..32bfe88 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1278,6 +1278,8 @@ struct btf_feature {
 	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
 	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_FEATURE(crc, btf_gen_crc, false),
+	BTF_FEATURE(kind_layout, btf_gen_kind_layout, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.31.1


