Return-Path: <bpf+bounces-58402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1CAB9EE2
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281C69E4DA5
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC7192B84;
	Fri, 16 May 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RRbFF/2X"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A613C914
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406889; cv=none; b=YcOLhOkxMXieixgRzUsVDs54Tkfxrwdd5uy69rHRFF9lSYjurDrce4Wb0NXFfDnoNkstSioSX4yLWhn+T6XwewJ2WBMW7Doq5v5jF/g+hX377h/tcpDzUXxxp+xWvijjxzctU2sLNiNvseQRj6xm0Yw/V1JADIvd/bZZdIpcabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406889; c=relaxed/simple;
	bh=21gawLCo3zIyc5D8SEqgPmGnZlkNfnfz8XtmPkFv7SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwkZHsqoJ1VgizY7QQXD60n4DSZWE3xDpJ54eg0XPr489BXjK/oRjb+utqg0kUlQy19SIUByfIuweH7E7wmI+iU9ZnonuqoOfK6mllOEkLa8cOAcIiXJ/qZiEwlueWjKr4UiOqlWkscwHPZn+2V/POTFLXF6JoV3FajlzCsN/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RRbFF/2X; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747406880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FyEVCctXmby7k7iloVDBeY4I+UGbC6F6wxFOef79nHU=;
	b=RRbFF/2XgrVewPDOh5ZMFplmM5NHskrLMRpjk7DylTXOjZGb9oC8AjhGwvrKlefGs7U8iJ
	TOJ6JyTvuFXabgoi5sQHDrJtOiehJv2Rm7W4WT0Iw/ygrffRI7K+P37jfwWUnLvQHet1Uo
	OeQv+EhM9b4P5IX+WoQao6V0maid3Fo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Tao Chen <chen.dylane@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4] bpftool: Add support for custom BTF path in prog load/loadall
Date: Fri, 16 May 2025 22:47:02 +0800
Message-ID: <20250516144708.298652-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch exposes the btf_custom_path feature to bpftool, allowing users
to specify a custom BTF file when loading BPF programs using prog load or
prog loadall commands.

The argument 'btf_custom_path' in libbpf is used for those kernels that
don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
relocations.

Suggested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
V3 -> V4: Improved documentation and added the Reviewed-by tag.
V2 -> V3: Optimized document grammar and some prompts
https://lore.kernel.org/bpf/20250515065018.240188-1-jiayuan.chen@linux.dev/
V1 -> V2: Added bash completion and documentation
https://lore.kernel.org/bpf/20250513035853.75820-1-jiayuan.chen@linux.dev/
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 10 ++++++++--
 tools/bpf/bpftool/bash-completion/bpftool        |  4 ++--
 tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..da3152c16228 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -31,7 +31,7 @@ PROG COMMANDS
 | **bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
 | **bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
 | **bpftool** **prog pin** *PROG* *FILE*
-| **bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
+| **bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**] [**kernel_btf** *BTF_FILE*]
 | **bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog tracelog**
@@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
     Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach]
+bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_FILE*]
     Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool prog
     load** pins only the first program from the *OBJ* as *PATH*. **bpftool prog
     loadall** pins all programs from the *OBJ* under *PATH* directory. **type**
@@ -153,6 +153,12 @@ bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | na
     program does not support autoattach, bpftool falls back to regular pinning
     for that program instead.
 
+    The **kernel_btf** option allows specifying an external BTF file to replace
+    the system's own vmlinux BTF file for CO-RE relocations. Note that any
+    other feature relying on BTF (such as fentry/fexit programs, struct_ops)
+    requires the BTF file for the actual kernel running on the host, often
+    exposed at /sys/kernel/btf/vmlinux.
+
     Note: *PATH* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1ce409a6cbd9..27512feb5c70 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -505,13 +505,13 @@ _bpftool()
                             _bpftool_get_map_names
                             return 0
                             ;;
-                        pinned|pinmaps)
+                        pinned|pinmaps|kernel_btf)
                             _filedir
                             return 0
                             ;;
                         *)
                             COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
-                            _bpftool_once_attr 'type pinmaps autoattach'
+                            _bpftool_once_attr 'type pinmaps autoattach kernel_btf'
                             _bpftool_one_of_list 'offload_dev xdpmeta_dev'
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..96eea8a67225 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		} else if (is_prefix(*argv, "autoattach")) {
 			auto_attach = true;
 			NEXT_ARG();
+		} else if (is_prefix(*argv, "kernel_btf")) {
+			NEXT_ARG();
+
+			if (!REQ_ARGS(1))
+				goto err_free_reuse_maps;
+
+			open_opts.btf_custom_path = GET_ARG();
 		} else {
-			p_err("expected no more arguments, 'type', 'map' or 'dev', got: '%s'?",
+			p_err("expected no more arguments, "
+			      "'type', 'map', 'offload_dev', 'xdpmeta_dev', 'pinmaps', "
+			      "'autoattach', or 'kernel_btf', got: '%s'?",
 			      *argv);
 			goto err_free_reuse_maps;
 		}
@@ -2474,6 +2483,7 @@ static int do_help(int argc, char **argv)
 		"                         [map { idx IDX | name NAME } MAP]\\\n"
 		"                         [pinmaps MAP_DIR]\n"
 		"                         [autoattach]\n"
+		"                         [kernel_btf BTF_FILE]\n"
 		"       %1$s %2$s attach PROG ATTACH_TYPE [MAP]\n"
 		"       %1$s %2$s detach PROG ATTACH_TYPE [MAP]\n"
 		"       %1$s %2$s run PROG \\\n"
-- 
2.47.1


