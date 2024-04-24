Return-Path: <bpf+bounces-27704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D68B0F16
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC61295815
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244C161B6B;
	Wed, 24 Apr 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jl+mtTZ0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740116193E
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973784; cv=none; b=AIxcr8utvlD1ee12XoLuj8iUduKZrgUN1py5VQTlpQg2GErDNMtlI18qGH69MSVTqzXz5Ybo3q+rDa4TJfTuzzHcpvxeEIYY8C557I+qtcLeFmhVyBX74y8ysUp8PKkii37bRUCZkKEphet3u6QrGLWUpYNm6C24vkWI+t54nOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973784; c=relaxed/simple;
	bh=+HZXhraZgxOkG2ZhCmB2sEfbIoA6LJa7cp7h9ZQwenc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PB+GSrAZYc4u/kQpaXhq53dzm1sGcs9is5bKjHdYBeNdnM7yndgfBfmQGyEz4478VfycFOq/LDjBYersogWZKfO3mXbq3vmWs3kdnYz7bGxGgZ3BzETXVnbExzLQ7t5DV8uE3U2gCEAjcfpVJ/dyKvNdsnGapFgmPb3rpBOoYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jl+mtTZ0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFQBKE023161;
	Wed, 24 Apr 2024 15:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=fWkruEM9KuqgXoWx/b4UIshz413t7thTfPdnBi4uYuY=;
 b=Jl+mtTZ0T9aKaYHmALpy2FxSDuqeoohY8qVxFYxggjgdlzslUpnvAp4XR+BeVJ1GbPK2
 YqsHAPPK7T9H3uFzhz5WzwOFihW+FO/sB1sHucfuLJG4jMXuNuzlr5BQdxelDLci/mJ0
 CFC3/tuvDv2d1GUjPbdh4s+0vrr7bhbJkVOUQ9NHepmYwhGlH8fUqJqQDPAO8ZmNkjUB
 uxQZPuSH+U4CLQ0q80JGa5/A3uWxGrXPOBvYHFErWEupfCgzb7rLaA/G5ffYFDqbUFuK
 wuRWshxILgnbcF4ZkubjTQWjB7wMamqLiiikcHA0xN8CD3djHzdnf4Na44NvBudNgu3C +Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aurgvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:49:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFbl0H025235;
	Wed, 24 Apr 2024 15:49:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fb0n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:49:16 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoo008769;
	Wed, 24 Apr 2024 15:49:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-14;
	Wed, 24 Apr 2024 15:49:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 13/13] bpftool: support displaying relocated-with-base split BTF
Date: Wed, 24 Apr 2024 16:48:06 +0100
Message-Id: <20240424154806.3417662-14-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-ORIG-GUID: 0xtKpJNIRuM-eqgfaWGbEN01gmd4XL9W
X-Proofpoint-GUID: 0xtKpJNIRuM-eqgfaWGbEN01gmd4XL9W

If the -R <base_btf> option is used, we can display BTF that has been
generated with distilled base BTF in its relocated form.  For example
for bpf_testmod.ko (which is built as an out-of-tree module, so has
a distilled .BTF.base section:

bpftool btf dump file bpf_testmod.ko

Alternatively, we can display content relocated with
(a possibly changed) base BTF via

bpftool btf dump -R /sys/kernel/btf/vmlinux bpf_testmod.ko

The latter mirrors how the kernel will handle such split
BTF; it relocates its representation with the running
kernel, and if successful, renumbers BTF ids to reference
the current vmlinux BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 15 ++++++++++++++-
 tools/bpf/bpftool/bash-completion/bpftool       |  7 ++++---
 tools/bpf/bpftool/btf.c                         | 11 ++++++++++-
 tools/bpf/bpftool/main.c                        | 14 +++++++++++++-
 tools/bpf/bpftool/main.h                        |  2 ++
 5 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index eaba24320fb2..fd6bb1280e7b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **btf** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } { **-R** | **relocate-base-btf** } }
 
 *COMMANDS* := { **dump** | **help** }
 
@@ -85,6 +85,19 @@ OPTIONS
     BTF object is passed through other handles, this option becomes
     necessary.
 
+-R, --relocate-base-btf *FILE*
+    When split BTF is generated with distilled base BTF for relocation,
+    the latter is stored in a .BTF.base section and allows us to later
+    relocate split BTF and a potentially-changed base BTF by using
+    information in the .BTF.base section about the base types referenced
+    from split BTF.  Relocation is carried out against the split BTF
+    supplied via this parameter and the split BTF will then refer to
+    the base types supplied in *FILE*.
+
+    If this option is not used, split BTF is shown relative to the
+    .BTF.base, which contains just enough information to support later
+    relocation.
+
 EXAMPLES
 ========
 **# bpftool btf dump id 1226**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 04afe2ac2228..878cf3d49a76 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -262,7 +262,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf'
+            --use-loader --base-btf --relocate-base-btf'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
@@ -283,7 +283,7 @@ _bpftool()
             _sysfs_get_netdevs
             return 0
             ;;
-        file|pinned|-B|--base-btf)
+        file|pinned|-B|-R|--base-btf|--relocate-base-btf)
             _filedir
             return 0
             ;;
@@ -297,7 +297,8 @@ _bpftool()
     local i pprev
     for (( i=1; i < ${#words[@]}; )); do
         if [[ ${words[i]::1} == - ]] &&
-            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
+            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]] &&
+            [[ ${words[i]} != "-R" ]] && [[ ${words[i]} != "--relocate-base-btf" ]]; then
             words=( "${words[@]:0:i}" "${words[@]:i+1}" )
             [[ $i -le $cword ]] && cword=$(( cword - 1 ))
         else
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 2e8bd2c9f0a3..7df8a686fef7 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -639,6 +639,14 @@ static int do_dump(int argc, char **argv)
 			base_btf = btf__parse_opts(*argv, &optp);
 			if (base_btf)
 				btf = btf__parse_split(*argv, base_btf);
+			if (btf && relocate_base_btf) {
+				err = btf__relocate(btf, relocate_base_btf);
+				if (err) {
+					p_err("could not relocate BTF from '%s' with base BTF '%s': %s\n",
+					      *argv, relocate_base_btf_path, strerror(-err));
+					goto done;
+				}
+			}
 		}
 		if (!btf) {
 			err = -errno;
@@ -1076,7 +1084,8 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-B|--base-btf} }\n"
+		"                    {-B|--base-btf} |\n"
+		"                    {-R|--relocate-base-btf} }\n"
 		"",
 		bin_name, "btf");
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..69d4906bec5c 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -32,6 +32,8 @@ bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
+struct btf *relocate_base_btf;
+const char *relocate_base_btf_path;
 struct hashmap *refs_table;
 
 static void __noreturn clean_and_exit(int i)
@@ -448,6 +450,7 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "base-btf",	required_argument, NULL, 'B' },
+		{ "relocate-base-btf", required_argument, NULL, 'R' },
 		{ 0 }
 	};
 	bool version_requested = false;
@@ -473,7 +476,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:lR:",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -519,6 +522,15 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
 			break;
+		case 'R':
+			relocate_base_btf_path = optarg;
+			relocate_base_btf = btf__parse(optarg, NULL);
+			if (!relocate_base_btf) {
+				p_err("failed to parse base BTF for relocation at '%s': %d\n",
+				      optarg, -errno);
+				return -1;
+			}
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9eb764fe4cc8..bbf8194a2d76 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -83,6 +83,8 @@ extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
+extern struct btf *relocate_base_btf;
+extern const char *relocate_base_btf_path;
 extern struct hashmap *refs_table;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
-- 
2.31.1


