Return-Path: <bpf+bounces-344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4DB6FF5C7
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6837281466
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E34642;
	Thu, 11 May 2023 15:21:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE2629
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:21:56 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A0138;
	Thu, 11 May 2023 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683818512; x=1715354512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XR/zMIbG4Jcm24Yt1GRfoMUGo5dYfwoSu6slMdxjNv0=;
  b=jlXojrXqon1WWvbp+EcLZkFcoys1+84ZnRSwfMh/R3uCSRNCo2u/Kths
   6FQzaD7kromafBDXORasEL+sclbnkMRuBJJYPzrgKn4RGmrdK0BJHIeF5
   z+BmkW3oHyaztnJ+6g8eN6XhvJuZwvE01tcjqESo5cuKWo6rmKljKPZpp
   WKcmA7k0tpbWPwwgXhbulutpfH77AFa7ZB+ZZyVdxiIixMIW+n4aLJswT
   OdWVfYk6++m7+sOUxzILk7KpuIHkdHgyTNV33woEOvCJKqrMYJycSFxUA
   8c7aE7RoWoVwo9j6n9ot6CGrPeZpyRWyyNbuPJwf5sFof755W8gplIkQi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352760702"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="352760702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 08:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="702782185"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="702782185"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2023 08:20:06 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6D7EE36C0E;
	Thu, 11 May 2023 16:20:05 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: specify XDP Hints ifname when loading program
Date: Thu, 11 May 2023 17:13:46 +0200
Message-Id: <20230511151345.7529-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ability to specify a network interface used to resolve
XDP Hints kfuncs when loading program through bpftool.

Usage:
bpftool prog load <bpf_obj_path> <pin_path> dev xdpmeta <ifname>

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/bpf/bpftool/prog.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 91b6075b2db3..a9cb96d99277 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	struct bpf_program *prog = NULL, *pos;
 	unsigned int old_map_fds = 0;
 	const char *pinmaps = NULL;
+	__u32 offload_ifindex = 0;
 	bool auto_attach = false;
+	__u32 meta_ifindex = 0;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	const char *pinfile;
 	unsigned int i, j;
-	__u32 ifindex = 0;
 	const char *file;
 	int idx, err;
 
@@ -1614,17 +1615,25 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			map_replace[old_map_fds].fd = fd;
 			old_map_fds++;
 		} else if (is_prefix(*argv, "dev")) {
+			__u32 *cur_ifindex;
+
 			NEXT_ARG();
 
-			if (ifindex) {
-				p_err("offload device already specified");
+			if (offload_ifindex || meta_ifindex) {
+				p_err("device already specified");
 				goto err_free_reuse_maps;
 			}
+			if (is_prefix(*argv, "xdpmeta")) {
+				cur_ifindex = &meta_ifindex;
+				NEXT_ARG();
+			} else {
+				cur_ifindex = &offload_ifindex;
+			}
 			if (!REQ_ARGS(1))
 				goto err_free_reuse_maps;
 
-			ifindex = if_nametoindex(*argv);
-			if (!ifindex) {
+			*cur_ifindex = if_nametoindex(*argv);
+			if (!(*cur_ifindex)) {
 				p_err("unrecognized netdevice '%s': %s",
 				      *argv, strerror(errno));
 				goto err_free_reuse_maps;
@@ -1671,7 +1680,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 				goto err_close_obj;
 		}
 
-		bpf_program__set_ifindex(pos, ifindex);
+		if (prog_type == BPF_PROG_TYPE_XDP && meta_ifindex) {
+			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__set_ifindex(pos, meta_ifindex);
+		} else {
+			bpf_program__set_ifindex(pos, offload_ifindex);
+		}
 		if (bpf_program__type(pos) != prog_type)
 			bpf_program__set_type(pos, prog_type);
 		bpf_program__set_expected_attach_type(pos, expected_attach_type);
@@ -1709,7 +1723,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	idx = 0;
 	bpf_object__for_each_map(map, obj) {
 		if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
-			bpf_map__set_ifindex(map, ifindex);
+			bpf_map__set_ifindex(map, offload_ifindex);
 
 		if (j < old_map_fds && idx == map_replace[j].idx) {
 			err = bpf_map__reuse_fd(map, map_replace[j++].fd);
-- 
2.35.3


