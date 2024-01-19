Return-Path: <bpf+bounces-19911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2749D83302B
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6D1C21B81
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7457898;
	Fri, 19 Jan 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="RnYtg79t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226857890
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699146; cv=none; b=AzgBVONQKLne1Phi1sQq0n+krM5zH7MDtbxX5hoZQXbyAtfa1+mVGjB1yufWNyQmhcQHfnGuGTrIJTbDslXXw3lk+OS7yGaO3uPcHFvb7/5PiblslJmXjh/4cbG2w/vJkwUGolKMXSSX1vtXqOqy+EK6KZaJ6FZuivfRltQNpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699146; c=relaxed/simple;
	bh=vxIfE/R/xuNaMWwqqmCkD4xxGFbq3z/ywdCOjkrmSdY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OUhw1DUr4PoSZbZNULT6XyhQpZYukTQ2d/aDk7A+dWp9UdM2jMo0afP2gAlz6mji0QZS3Wjh0RMyS5crU87ewS0ZZKHdiAiyrA9/gthVhtU0Nrge/IEG9Nfdx2VTaPJUZowmgES4+PZQnDXx8YecUtBluX3U++xG1uIuxGw+R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=RnYtg79t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e490c2115so14384395e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1705699142; x=1706303942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9ltOyncinwZe1bdubCh/Pd/cncjzRAA5LgF8rUbJjI=;
        b=RnYtg79tUfg4KRX0dRc/pMHXDYaz5Zo4hM5mEqH0Kuv4HQbXJSkDe2hqkVfsePNjxn
         hSiUfwsFzM5VOjIhmxYEEF1TPF6PAEbzs8+A62uGuOoXKE0U89FcV5cTHMzkvd5DGn6Z
         chLHSOOndPwKoYkgvJ6WpQnXsiIDK8txKN2CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699142; x=1706303942;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9ltOyncinwZe1bdubCh/Pd/cncjzRAA5LgF8rUbJjI=;
        b=JvQf+Dg8i2rrpwCmoRwLIHSUSewiuLAkafOh0nkCmmNN/sUVVMHheA6/62Rje8TW0t
         l8R4TF/Lo2uA7lAmrLTapyWSU/D6nigWHOMxlixgvK5933Mf91JH8QCR3aSBoAdd6gdQ
         KUn4H9+JgAIfCLzWWANw1agHBdRxSX+Ks9itXv+tC8/cxgLMNZ9muU5yUMfNzztkvhZL
         JJlB2t6gFYx/zP3nezA+A79rFVk7e/xVOxIuyPwjUW10icUVAtcHHBS6H7IRhJxYN7kH
         FXxNre7pTZ+iicnXiGKl7ZN0Xrv+SEuoccSgK3IR79Ve0qYe8w/B424f9nTA3jCy+aKD
         EvRQ==
X-Gm-Message-State: AOJu0YwVC41xCJCgrifOq+WU33GvTFjyUOIB8YJnY7af+kVpswswnUkw
	SHbDY94Ur6e+nEqoc5+xVYfM8atIJUBIlbZYrfQERo/0MRZSbOs5C5z7rgl2TXs9TMf7A3l4oWY
	Z1y6CIm/aKeRVFCO+8SMoc7GjH0Lj+ICmSt60VE6xMwVAxgvVW1aN7g==
X-Google-Smtp-Source: AGHT+IGIJnI+TYcIuFBQB/tj88H/gGo+mUkDomCqY03HwYMCxfwGbZzqbyutCVJa0eK79vPzhCMmnDBvCd9lxIMJQqQ=
X-Received: by 2002:a05:600c:1c29:b0:40e:6e98:3ad9 with SMTP id
 j41-20020a05600c1c2900b0040e6e983ad9mr1016205wms.4.1705699141965; Fri, 19 Jan
 2024 13:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bryce Kahle <bryce.kahle@datadoghq.com>
Date: Fri, 19 Jan 2024 13:18:51 -0800
Message-ID: <CALvGib8483xSN1VWqxc4XN98k6Di2cNtW76UH_2Vmyft5WQpkQ@mail.gmail.com>
Subject: [PATCH bpf-next] bpftool: add support for split BTF to gen min_core_btf
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
index 5006e724d1bc..9c357d339000 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -16,7 +16,7 @@ SYNOPSIS

  **bpftool** [*OPTIONS*] **gen** *COMMAND*

- *OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
+ *OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } | {
**-L** | **--use-loader** } }

  *COMMAND* := { **object** | **skeleton** | **help** }

@@ -202,6 +202,14 @@ OPTIONS
 =======
  .. include:: common_options.rst

+ -B, --base-btf *FILE*
+   Pass a base BTF object. Base BTF objects are typically used
+   with BTF objects for kernel modules. To avoid duplicating
+   all kernel symbols required by modules, BTF objects for
+   modules are "split", they are built incrementally on top of
+   the kernel (vmlinux) BTF object. So the base BTF reference
+   should usually point to the kernel BTF.
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
index ee3ce2b8000d..634c809a5173 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
  "       %1$s %2$s help\n"
  "\n"
  "       " HELP_SPEC_OPTIONS " |\n"
+ "                    {-B|--base-btf} |\n"
  "                    {-L|--use-loader} }\n"
  "",
  bin_name, "gen");
@@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
  if (!info)
  return NULL;

- info->src_btf = btf__parse(targ_btf_path, NULL);
+ info->src_btf = btf__parse_split(targ_btf_path, base_btf);
  if (!info->src_btf) {
  err = -errno;
  p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
  goto err_out;
  }

- info->marked_btf = btf__parse(targ_btf_path, NULL);
+ info->marked_btf = btf__parse_split(targ_btf_path, base_btf);
  if (!info->marked_btf) {
  err = -errno;
  p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
@@ -2141,10 +2142,16 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
 {
  struct btf *btf_new = NULL;
  unsigned int *ids = NULL;
+ const struct btf *base;
  unsigned int i, n = btf__type_cnt(info->marked_btf);
+ int start_id = 1;
  int err = 0;

- btf_new = btf__new_empty();
+ base = btf__base_btf(info->src_btf);
+ if (base)
+ start_id = btf__type_cnt(base);
+
+ btf_new = btf__new_empty_split((struct btf *)base);
  if (!btf_new) {
  err = -errno;
  goto err_out;
@@ -2157,7 +2164,7 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
  }

  /* first pass: add all marked types to btf_new and add their new ids
to the ids map */
- for (i = 1; i < n; i++) {
+ for (i = start_id; i < n; i++) {
  const struct btf_type *cloned_type, *type;
  const char *name;
  int new_id;
@@ -2213,7 +2220,7 @@ static struct btf *btfgen_get_btf(struct
btfgen_info *info)
  }

  /* second pass: fix up type ids */
- for (i = 1; i < btf__type_cnt(btf_new); i++) {
+ for (i = start_id; i < btf__type_cnt(btf_new); i++) {
  struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);

  err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
-- 
2.39.2

