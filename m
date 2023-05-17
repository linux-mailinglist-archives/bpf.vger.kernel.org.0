Return-Path: <bpf+bounces-788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF936706D9F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC161C2095A
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C2111B7;
	Wed, 17 May 2023 16:05:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55111111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:05:47 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B732127;
	Wed, 17 May 2023 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684339544; x=1715875544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w2SQ7GPmBdR1JpLgaHE9X6uMQsSBgM8HEIAY0K1OpMI=;
  b=QadwsIIQ4tYZgWphyQPZf07AVADLJdiQkPa5ogFjvOM7vScU1m84XkNG
   yesyuYNUGjdC02bZ/pWN6Pdt4y2BYpqfdQri3OBVrFF4tU4ueKfHG2xvp
   rLXUZCD56Xk3CN3/EXqsgl2j0eAecUxFlMTLDpBprUSp5ee6YVL2SL984
   cn1LCgliI60i4rybMx06d4A/Wkk/Nm36hlX17tlO8/u1hRGwSOIx4K/Ep
   SRXV/uR8KJoMtofw2s5igj/J7Wd7MR5pC5UF0/l/8Io7M8fL0Safpjfdi
   fKjS3UFqQ/FyUjZivPG9FqnoKFayW+AhauDbYa2/oIY0PD/311/czIaBI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="438143376"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="438143376"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="695930069"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="695930069"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2023 09:05:38 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 904D72878B;
	Wed, 17 May 2023 17:05:36 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"Stanislav Fomichev" <sdf@google.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yhs@fb.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>,
	"Hao Luo" <haoluo@google.com>,
	"Jiri Olsa" <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [PATCH bpf-next v2] bpftool: specify XDP Hints ifname when loading program
Date: Wed, 17 May 2023 18:01:04 +0200
Message-Id: <20230517160103.1088185-1-larysa.zaremba@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ability to specify a network interface used to resolve
XDP Hints kfuncs when loading program through bpftool.

Usage:
  bpftool prog load [...] xdpmeta_dev <ifname>

Writing just 'dev <ifname>' instead of 'xdpmeta_dev' is a very probable
mistake that results in not very descriptive errors,
so 'bpftool prog load [...] dev <ifname>' syntax becomes deprecated,
followed by 'bpftool map create [...] dev <ifname>' for consistency.

Now, to offload program, execute:
  bpftool prog load [...] offload_dev <ifname>

To offload map:
  bpftool map create [...] offload_dev <ifname>

'dev <ifname>' still performs offloading in the commands above, but now
triggers a warning and is excluded from bash completion.

'xdpmeta_dev' and 'offload_dev' are mutually exclusive options, because
'xdpmeta_dev' basically makes a program device-bound without loading it
onto the said device. For now, offloaded programs cannot use XDP hints [0],
but if this changes, using 'offload_dev <ifname>' should cover this case.

[0] https://lore.kernel.org/bpf/a5a636cc-5b03-686f-4be0-000383b05cfc@linux.dev

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
Changes since v1:
 - changed syntax from 'dev xdpmeta <ifname>' to 'xdpmeta_dev <ifname>'
 - added 'offload_dev'
 - deprecated 'bpftool prog load [...] dev <ifname>' syntax
 - deprecated 'bpftool map create [...] dev <ifname>' syntax
 - updated usage message in prog.c
 - updated usage message in map.c
 - updated documentation
 - updated bash completion
 - mutual exclusivity of xdpmeta_dev and offload_dev [0] is now indicated
   by errors and syntax documentation
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |  8 +--
 .../bpftool/Documentation/bpftool-prog.rst    | 11 ++--
 tools/bpf/bpftool/bash-completion/bpftool     |  7 +--
 tools/bpf/bpftool/map.c                       |  7 ++-
 tools/bpf/bpftool/prog.c                      | 51 ++++++++++++++++---
 5 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 11250c4734fe..3b7ba037af95 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -28,7 +28,7 @@ MAP COMMANDS
 |	**bpftool** **map** { **show** | **list** }   [*MAP*]
 |	**bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
 |		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
-|		[**dev** *NAME*]
+|		[**offload_dev** *NAME*]
 |	**bpftool** **map dump**       *MAP*
 |	**bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
 |	**bpftool** **map lookup**     *MAP* [**key** *DATA*]
@@ -73,7 +73,7 @@ DESCRIPTION
 		  maps. On such kernels bpftool will automatically emit this
 		  information as well.
 
-	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**dev** *NAME*]
+	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**offload_dev** *NAME*]
 		  Create a new map with given parameters and pin it to *bpffs*
 		  as *FILE*.
 
@@ -86,8 +86,8 @@ DESCRIPTION
 		  kernel needs it to collect metadata related to the inner maps
 		  that the new map will work with.
 
-		  Keyword **dev** expects a network interface name, and is used
-		  to request hardware offload for the map.
+		  Keyword **offload_dev** expects a network interface name,
+		  and is used to request hardware offload for the map.
 
 	**bpftool map dump**    *MAP*
 		  Dump all entries in a given *MAP*.  In case of **name**,
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 9443c524bb76..dcae81bd27ed 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -31,7 +31,7 @@ PROG COMMANDS
 |	**bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
 |	**bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
 |	**bpftool** **prog pin** *PROG* *FILE*
-|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
 |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog tracelog**
@@ -129,7 +129,7 @@ DESCRIPTION
 		  contain a dot character ('.'), which is reserved for future
 		  extensions of *bpffs*.
 
-	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
 		  Load bpf program(s) from binary *OBJ* and pin as *PATH*.
 		  **bpftool prog load** pins only the first program from the
 		  *OBJ* as *PATH*. **bpftool prog loadall** pins all programs
@@ -143,8 +143,11 @@ DESCRIPTION
 		  to be replaced in the ELF file counting from 0, while *NAME*
 		  allows to replace a map by name.  *MAP* specifies the map to
 		  use, referring to it by **id** or through a **pinned** file.
-		  If **dev** *NAME* is specified program will be loaded onto
-		  given networking device (offload).
+		  If **offload_dev** *NAME* is specified program will be loaded
+		  onto given networking device (offload).
+		  If **xdpmeta_dev** *NAME* is specified program will become
+		  device-bound without offloading, this facilitates access
+		  to XDP metadata.
 		  Optional **pinmaps** argument can be provided to pin all
 		  maps under *MAP_DIR* directory.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index e7234d1a5306..085bf18f3659 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -278,7 +278,7 @@ _bpftool()
             _bpftool_get_prog_tags
             return 0
             ;;
-        dev)
+        dev|offload_dev|xdpmeta_dev)
             _sysfs_get_netdevs
             return 0
             ;;
@@ -508,7 +508,8 @@ _bpftool()
                             ;;
                         *)
                             COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
-                            _bpftool_once_attr 'type dev pinmaps autoattach'
+                            _bpftool_once_attr 'type pinmaps autoattach'
+                            _bpftool_one_of_list 'offload_dev xdpmeta_dev'
                             return 0
                             ;;
                     esac
@@ -733,7 +734,7 @@ _bpftool()
                             esac
                             ;;
                         *)
-                            _bpftool_once_attr 'type key value entries name flags dev'
+                            _bpftool_once_attr 'type key value entries name flags offload_dev'
                             if _bpftool_search_list 'array_of_maps' 'hash_of_maps'; then
                                 _bpftool_once_attr 'inner_map'
                             fi
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index ae9e822aa3fe..f98f7bbea2b1 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1287,6 +1287,11 @@ static int do_create(int argc, char **argv)
 					  "flags"))
 				goto exit;
 		} else if (is_prefix(*argv, "dev")) {
+			p_info("Warning: 'bpftool map create [...] dev <ifname>' syntax is deprecated.\n"
+			       "Going further, please use 'offload_dev <ifname>' to request hardware offload for the map.");
+			goto offload_dev;
+		} else if (is_prefix(*argv, "offload_dev")) {
+offload_dev:
 			NEXT_ARG();
 
 			if (attr.map_ifindex) {
@@ -1431,7 +1436,7 @@ static int do_help(int argc, char **argv)
 		"Usage: %1$s %2$s { show | list }   [MAP]\n"
 		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
 		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
-		"                                  [inner_map MAP] [dev NAME]\n"
+		"                                  [inner_map MAP] [offload_dev NAME]\n"
 		"       %1$s %2$s dump       MAP\n"
 		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
 		"       %1$s %2$s lookup     MAP [key DATA]\n"
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 91b6075b2db3..3b77986f0fb7 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	struct bpf_program *prog = NULL, *pos;
 	unsigned int old_map_fds = 0;
 	const char *pinmaps = NULL;
+	__u32 xdpmeta_ifindex = 0;
+	__u32 offload_ifindex = 0;
 	bool auto_attach = false;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	const char *pinfile;
 	unsigned int i, j;
-	__u32 ifindex = 0;
 	const char *file;
 	int idx, err;
 
@@ -1614,17 +1615,46 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			map_replace[old_map_fds].fd = fd;
 			old_map_fds++;
 		} else if (is_prefix(*argv, "dev")) {
+			p_info("Warning: 'bpftool prog load [...] dev <ifname>' syntax is deprecated.\n"
+			       "Going further, please use 'offload_dev <ifname>' to offload program to device.\n"
+			       "For applications using XDP hints only, use 'xdpmeta_dev <ifname>'.");
+			goto offload_dev;
+		} else if (is_prefix(*argv, "offload_dev")) {
+offload_dev:
 			NEXT_ARG();
 
-			if (ifindex) {
-				p_err("offload device already specified");
+			if (offload_ifindex) {
+				p_err("offload_dev already specified");
+				goto err_free_reuse_maps;
+			} else if (xdpmeta_ifindex) {
+				p_err("xdpmeta_dev and offload_dev are mutually exclusive");
+				goto err_free_reuse_maps;
+			}
+			if (!REQ_ARGS(1))
+				goto err_free_reuse_maps;
+
+			offload_ifindex = if_nametoindex(*argv);
+			if (!offload_ifindex) {
+				p_err("unrecognized netdevice '%s': %s",
+				      *argv, strerror(errno));
+				goto err_free_reuse_maps;
+			}
+			NEXT_ARG();
+		} else if (is_prefix(*argv, "xdpmeta_dev")) {
+			NEXT_ARG();
+
+			if (xdpmeta_ifindex) {
+				p_err("xdpmeta_dev already specified");
+				goto err_free_reuse_maps;
+			} else if (offload_ifindex) {
+				p_err("xdpmeta_dev and offload_dev are mutually exclusive");
 				goto err_free_reuse_maps;
 			}
 			if (!REQ_ARGS(1))
 				goto err_free_reuse_maps;
 
-			ifindex = if_nametoindex(*argv);
-			if (!ifindex) {
+			xdpmeta_ifindex = if_nametoindex(*argv);
+			if (!xdpmeta_ifindex) {
 				p_err("unrecognized netdevice '%s': %s",
 				      *argv, strerror(errno));
 				goto err_free_reuse_maps;
@@ -1671,7 +1701,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 				goto err_close_obj;
 		}
 
-		bpf_program__set_ifindex(pos, ifindex);
+		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
+			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
+		} else {
+			bpf_program__set_ifindex(pos, offload_ifindex);
+		}
 		if (bpf_program__type(pos) != prog_type)
 			bpf_program__set_type(pos, prog_type);
 		bpf_program__set_expected_attach_type(pos, expected_attach_type);
@@ -1709,7 +1744,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	idx = 0;
 	bpf_object__for_each_map(map, obj) {
 		if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
-			bpf_map__set_ifindex(map, ifindex);
+			bpf_map__set_ifindex(map, offload_ifindex);
 
 		if (j < old_map_fds && idx == map_replace[j].idx) {
 			err = bpf_map__reuse_fd(map, map_replace[j++].fd);
@@ -2416,7 +2451,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
 		"       %1$s %2$s pin   PROG FILE\n"
 		"       %1$s %2$s { load | loadall } OBJ  PATH \\\n"
-		"                         [type TYPE] [dev NAME] \\\n"
+		"                         [type TYPE] [{ offload_dev | xdpmeta_dev } NAME] \\\n"
 		"                         [map { idx IDX | name NAME } MAP]\\\n"
 		"                         [pinmaps MAP_DIR]\n"
 		"                         [autoattach]\n"
-- 
2.35.3


