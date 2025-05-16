Return-Path: <bpf+bounces-58376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95EAB94A8
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571713BE5AE
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925D1D5ADC;
	Fri, 16 May 2025 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b3MNX5FS"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E63D69
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747365825; cv=none; b=liTK1wFL4T2OAXZpy23EzjAV9/+Chhz6oT/7tiFIRXBfrBbuHNq6Pb3mE3tu8i5ZA8pi12q/6nQYD1i0UNtFJOnVsK8wpp3L3ht01wC9KdRnFo/p4CvwQvOU+LxBWHYh/Vq8ZCely5lAKFvCprWcrt9nhICrCrO75LBF7X/G2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747365825; c=relaxed/simple;
	bh=AWkkCfi6oA0nYFHIzzJUA86K0s0118UVGL/IWo3IBko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+WInjlK+xsDx5+UbP6UYs//Cv/u/qhv6BarF3F+0aYBIvo8PQR40JOCdaRep974FH74tCafhtD8Xi/GtLn+38NDl9yWKOPafaXtFhQvTfq9TzK9JtM07PPD2X8m71QkBKPamLl5p77Hbe8jCKfxR9FEcXBs6cW5xlJj3TuATpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b3MNX5FS; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747365811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=THgsYtDm20+Ng95cWON+GsyudgBoMpP632XoGpT/cRk=;
	b=b3MNX5FSuRHSqbwaLZQekRg3fE+NTlXITswQDvhm7fbOiJGUh/g73UGeCslJoRTqVTdkM4
	M2/EOBoZ3Y172ZjSJqbKlR0l09k7/VPCTyZiY52F1yWG/q224d737WxcoxAScRd+Xa4gfc
	XTbGmGU6CAyso+ekhLVhcBrvypUpYl4=
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
	Mykyta Yatsenko <yatsenko@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Tao Chen <chen.dylane@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] bpftool: Add support for custom BTF path in prog load/loadall
Date: Fri, 16 May 2025 11:23:06 +0800
Message-ID: <20250516032312.275261-1-jiayuan.chen@linux.dev>
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
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
V2 -> V3: Optimized document grammar and some prompts
https://lore.kernel.org/bpf/20250515065018.240188-1-jiayuan.chen@linux.dev/
V1 -> V2: Added bash completion and documentation
https://lore.kernel.org/bpf/20250513035853.75820-1-jiayuan.chen@linux.dev/
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++++-
 tools/bpf/bpftool/bash-completion/bpftool        |  4 ++--
 tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..4dce43e8e8a3 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
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


