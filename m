Return-Path: <bpf+bounces-58278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABBAB7E4C
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 08:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ACF1B65EB3
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C950296D35;
	Thu, 15 May 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hbejOnLx"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EF1C27
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291934; cv=none; b=tP+z0k7nbR2ssHUibfyb5gA5oarxf9vve+F19OeA6xnApr2jpn42p9PdunBV1zmEsjLiGSLgrw83Lq+bs/pBO0+d2mmdme5wgStO056tPPAYwk3dNQ7bd3GD2oFjXGphiCgWupfp/tosA31Wp9av7EET49+FeC4QrxG09B90flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291934; c=relaxed/simple;
	bh=v3rJUJA3VnQscDRiQtRpypekAON6aWpisMA013rym3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioe3twVM4KuBb9qVbuZrZc+V+mRXd+ZDdknauEKTU50cFTYa0/8vdltK5ueNv6AMFxGdr7QmZAIj30sClUii0aYn98KUuSRXyYr7WOBKyw8GemSW+si+RC12bsMZFtUiSw7oL6yLgxnMpBfgHIjSX+xaokOliTIFBUGPwO57l/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hbejOnLx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747291929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GCTwaTwDhG28ATyJHv4EIMQid3ICTTX78fEuCxTG/VI=;
	b=hbejOnLxKOWSzaXgeVPzO5L2LvuY8xqvuBUa6rQnI+e523VjqPbCsHcJBMVGEOHIwHKJPs
	yVTxbyrgfQJPTxqo3zquuVl9Lwu/ti7bD4aNSAMv3OyQfaV77vw0IJXpGF7iqzjQOjq2T/
	NJUnpkfIli8/u9m68oK83qoxZZExrLo=
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
	Mykyta Yatsenko <yatsenko@meta.com>,
	Tao Chen <chen.dylane@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpftool: Add support for custom BTF path in prog load/loadall
Date: Thu, 15 May 2025 14:50:11 +0800
Message-ID: <20250515065018.240188-1-jiayuan.chen@linux.dev>
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

The argument 'btf_custom_path' in libbpf is used for those kernes that
don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
relocations.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  7 ++++++-
 tools/bpf/bpftool/bash-completion/bpftool        |  2 +-
 tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..e60a829ab8d0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
     Note: *FILE* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
-bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach]
+bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps *MAP_DIR*] [autoattach] [kernel_btf *BTF_DIR*]
     Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool prog
     load** pins only the first program from the *OBJ* as *PATH*. **bpftool prog
     loadall** pins all programs from the *OBJ* under *PATH* directory. **type**
@@ -153,6 +153,11 @@ bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *IDX* | na
     program does not support autoattach, bpftool falls back to regular pinning
     for that program instead.
 
+    The **kernel_btf** option allows specifying an external BTF file to replace
+    the system's own vmlinux BTF file for CO-RE relocations. NOTE that any
+    other feature (e.g., fentry/fexit programs, struct_ops, etc) will require
+    actual kernel BTF like /sys/kernel/btf/vmlinux.
+
     Note: *PATH* must be located in *bpffs* mount. It must not contain a dot
     character ('.'), which is reserved for future extensions of *bpffs*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1ce409a6cbd9..609938c287b7 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -511,7 +511,7 @@ _bpftool()
                             ;;
                         *)
                             COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
-                            _bpftool_once_attr 'type pinmaps autoattach'
+                            _bpftool_once_attr 'type pinmaps autoattach kernel_btf'
                             _bpftool_one_of_list 'offload_dev xdpmeta_dev'
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..3b6a361dd0f8 100644
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
+			      "'type', 'map', 'dev', 'offload_dev', 'xdpmeta_dev', 'pinmaps', "
+			      "'autoattach', or 'kernel_btf', got: '%s'?",
 			      *argv);
 			goto err_free_reuse_maps;
 		}
@@ -2474,6 +2483,7 @@ static int do_help(int argc, char **argv)
 		"                         [map { idx IDX | name NAME } MAP]\\\n"
 		"                         [pinmaps MAP_DIR]\n"
 		"                         [autoattach]\n"
+		"                         [kernel_btf BTF_DIR]\n"
 		"       %1$s %2$s attach PROG ATTACH_TYPE [MAP]\n"
 		"       %1$s %2$s detach PROG ATTACH_TYPE [MAP]\n"
 		"       %1$s %2$s run PROG \\\n"
-- 
2.47.1


