Return-Path: <bpf+bounces-20410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB383DFD9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E76B23DA8
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3CC1F947;
	Fri, 26 Jan 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="REcnVT6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C4208A2
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289553; cv=none; b=NpEhcGspnanwOEg71voLeCutVHFG8QIRFi0LzAOtGfH53/TOW52GZPx9lue0sWXldLbwsA8RKWCN9v0HBAkjrCP2OJh2r/jTvYHNytAJ7kgEmoYlQH5WL+n+B+wVb5u09LAkjdAVpZQtYv/vJSAuKtEPvOZGM+wlmKfwKx4/2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289553; c=relaxed/simple;
	bh=rI16l3L+mC53aKws7WCdPZzsB5pQh79OOl4glb9aVs4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pR01O3D/iiOQqhGynRdsBYmvUmAGAjt423yQUbfQK4hp+FOLXsw9bPXaggpWrG0QdzJUGa6M1Cf1kuLviV5rMiHnxPhLBGjgeUv9GKjQOGbWJpoz/toAzqv7dkATFpKp+DAVop5zWN/Eob+auB8vI67RnWQACO5Mv/uzJ7ygxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=REcnVT6I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33934567777so800555f8f.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1706289550; x=1706894350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foqDYpWr8vP+i6w/apFSLMAWs+tKaymiRbZsAWN+EC0=;
        b=REcnVT6IaOovteS6PS7I+qDLgf+hkH82utSq9GnhimO/S3qhv4SnBfoqIQ0R7rjD6O
         Bxtk/pf2qu7KjhGzwMJZrT8WMPGyW7fTKnlZBajHZM9S8pFPtXsAfBE7znm1hhAM1v7s
         5l1lVQN1jAYpDv9PPzqwIuUrW1bB3YF/RN8YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289550; x=1706894350;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foqDYpWr8vP+i6w/apFSLMAWs+tKaymiRbZsAWN+EC0=;
        b=Oa9FfxmWzk1HXVHTTmme/yezEaa68h2UKPePnJye+PFXy22aBMzG83i/lNxDLXHR0K
         dmbyOU7XT5bq/3gDVS7+ib7786EA9zr1/bOV89Z/B6Y+kUEeiZEO0ExLm+eEcAp4g1x1
         Td590/nFZ0NKDZD0z63LGSLwLLTYCo3RmVrk+skhrW4eHROI0RdT7h4/exf6ijwmWLpy
         Sp2fMbNDHp2TJRfO/fKDg7IVIpLrhCoBl3v79QqXr2zf4QJYucgeqP3CCrCDpGbeWyNO
         bg1SiRb2cqHDISdazfkehRkEpMmLIIo/MX2ojShOQXrJRrsQNoAZUG7DvDRyWMzMrrk+
         f+oA==
X-Gm-Message-State: AOJu0YwJ2cbR2myZ8Etmz/BCsxT7sIT4dJrvRG06MnYqo1QS0iMmSMtQ
	7B1TqNZ3EZC5hFW5z5ulE95UimEjmpQYlBLsxiaxynCnWxFYRBnxSPevClRWIxBLCwAVlKqLDZC
	Wm9BiW7060DcOmVvmFu4UrYlW9ZWcRSQNo4S4EmVaudn5IVDt/ws=
X-Google-Smtp-Source: AGHT+IFS7CFu+20E4InyPzDH/toBCMU1CxdK4waXitHr8uKKw+dx2pCrtwy2UcKLiwDY4WgSkQgHPnmRCNYDyK4M66Q=
X-Received: by 2002:a5d:5405:0:b0:33a:d1b5:8164 with SMTP id
 g5-20020a5d5405000000b0033ad1b58164mr1119367wrv.70.1706289549535; Fri, 26 Jan
 2024 09:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a5d:6c6e:0:b0:332:ed88:ec2b with HTTP; Fri, 26 Jan 2024
 09:19:09 -0800 (PST)
From: Bryce Kahle <bryce.kahle@datadoghq.com>
Date: Fri, 26 Jan 2024 09:19:09 -0800
Message-ID: <CALvGib94ovYOdwx4+qCc14WverUU1=X-LrRK9sNgajG1+0MYpg@mail.gmail.com>
Subject: [PATCH bpf-next v2] bpftool: add support for split BTF to gen min_core_btf
To: bpf@vger.kernel.org
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"

Enables a user to generate minimized kernel module BTF.

If an eBPF program probes a function within a kernel module or uses
types that come from a kernel module, split BTF is required. The split
module BTF contains only the BTF types that are unique to the module.
It will reference the base/vmlinux BTF types and always starts its type
IDs at X+1 where X is the largest type ID in the base BTF.

Minimization allows a user to ship only the types necessary to do
relocations for the program(s) in the provided eBPF object file(s). A
minimized module BTF will still not contain vmlinux BTF types, so you
should always minimize the vmlinux file first, and then minimize the
kernel module file.

Example:

bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o

Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst  | 18 +++++++++++++++++-
 tools/bpf/bpftool/gen.c                        | 17 ++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 5006e724d..9c357d339 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -16,7 +16,7 @@ SYNOPSIS

 	**bpftool** [*OPTIONS*] **gen** *COMMAND*

-	*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
+	*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } | {
**-L** | **--use-loader** } }

 	*COMMAND* := { **object** | **skeleton** | **help** }

@@ -202,6 +202,14 @@ OPTIONS
 =======
 	.. include:: common_options.rst

+	-B, --base-btf *FILE*
+		  Pass a base BTF object. Base BTF objects are typically used
+		  with BTF objects for kernel modules. To avoid duplicating
+		  all kernel symbols required by modules, BTF objects for
+		  modules are "split", they are built incrementally on top of
+		  the kernel (vmlinux) BTF object. So the base BTF reference
+		  should usually point to the kernel BTF.
+
 	-L, --use-loader
 		  For skeletons, generate a "light" skeleton (also known as "loader"
 		  skeleton). A light skeleton contains a loader eBPF program. It does
@@ -444,3 +452,11 @@ ones given to min_core_btf.
   obj = bpf_object__open_file("one.bpf.o", &opts);

   ...
+
+Kernel module BTF may also be minimized by using the -B option:
+
+**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf
5.4.0-module-smaller.btf one.bpf.o**
+
+A minimized module BTF will still not contain vmlinux BTF types, so you
+should always minimize the vmlinux file first, and then minimize the
+kernel module file.
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b80..634c809a5 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
+		"                    {-B|--base-btf} |\n"
 		"                    {-L|--use-loader} }\n"
 		"",
 		bin_name, "gen");
@@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
 	if (!info)
 		return NULL;

-	info->src_btf = btf__parse(targ_btf_path, NULL);
+	info->src_btf = btf__parse_split(targ_btf_path, base_btf);
 	if (!info->src_btf) {
 		err = -errno;
 		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
 		goto err_out;
 	}

-	info->marked_btf = btf__parse(targ_btf_path, NULL);
+	info->marked_btf = btf__parse_split(targ_btf_path, base_btf);
 	if (!info->marked_btf) {
 		err = -errno;
 		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
@@ -2141,10 +2142,16 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
 {
 	struct btf *btf_new = NULL;
 	unsigned int *ids = NULL;
+	const struct btf *base;
 	unsigned int i, n = btf__type_cnt(info->marked_btf);
+	int start_id = 1;
 	int err = 0;

-	btf_new = btf__new_empty();
+	base = btf__base_btf(info->src_btf);
+	if (base)
+		start_id = btf__type_cnt(base);
+
+	btf_new = btf__new_empty_split((struct btf *)base);
 	if (!btf_new) {
 		err = -errno;
 		goto err_out;
@@ -2157,7 +2164,7 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
 	}

 	/* first pass: add all marked types to btf_new and add their new ids
to the ids map */
-	for (i = 1; i < n; i++) {
+	for (i = start_id; i < n; i++) {
 		const struct btf_type *cloned_type, *type;
 		const char *name;
 		int new_id;
@@ -2213,7 +2220,7 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
 	}

 	/* second pass: fix up type ids */
-	for (i = 1; i < btf__type_cnt(btf_new); i++) {
+	for (i = start_id; i < btf__type_cnt(btf_new); i++) {
 		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);

 		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
-- 
2.39.2

