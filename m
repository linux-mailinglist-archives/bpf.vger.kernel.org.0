Return-Path: <bpf+bounces-38311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C2963103
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0261C236C9
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9A1ABEA3;
	Wed, 28 Aug 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQBnyHnI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D31547DD;
	Wed, 28 Aug 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873714; cv=none; b=Q7BhGElivMRyhyyAoLh1dHphvD4qxNfCSv9TTC5Tn6/y2F8LF67OF1OhGfyFHS2pShwcjd3JGHXQu00kO7PIlTCrt/XeAiPWAOosWexU625fS+6h4PSl9IDE6R0yKM8CZVpsSITocN09owKExJ7bxYwLyANghdUOwTAA9tYvMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873714; c=relaxed/simple;
	bh=uBfE6XiMeQku167WVIBk+bZx7tNbdbYptjkWfk6Gx3o=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LXLyA36wzZejtctNEah74118bZSJbzR9kx0HqO3r8SB448NBBPOX2eebV6gJjhVQIkPQX/7145R0AEpYlx6Gb5/bIqhTw7qYmc1wRw/DjW1JmzV/9Gyc1JRaf2khOQAFe0A436p5gqzSuSEaKqo/9HVwpWf9aGCfSCCc85rv3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQBnyHnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC2C4CEC0;
	Wed, 28 Aug 2024 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724873714;
	bh=uBfE6XiMeQku167WVIBk+bZx7tNbdbYptjkWfk6Gx3o=;
	h=Date:From:Cc:Subject:From;
	b=QQBnyHnIcac9cpG33vLAXwYt0W2Y+YOfjiJ5DsO+aZ7VBML9HssCbF9FOjBejII7P
	 M9wNnJDPxVrBw5eEzqGicJw2gld0C5oiWDtMJRwX5OUKlLMioJnr607MqT8val2cHH
	 qZzhvc4coa2pLKHNVrMXRjTQdF1ktb4BugeZMR0K1fJnpg9cv6yx5t1UfRLFH+mcmm
	 3hmnsc33N1tPl1CX/d0mGGswEjb3ToRyMrObO/R2E9SH9zp7UMC+8wHUVKl7wZdzWE
	 eDkb1XKBEg3hAp1vgKn2CX1IjYaZ0KCUovO33V7CrELtMMLwwmSLNU+YKA2ynGzLTl
	 v3sElq7payPtg==
Date: Wed, 28 Aug 2024 16:35:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] pahole: Add option to obtain a vmlinux matching the
 running kernel
Message-ID: <Zs977_n0rkleEl94@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To use in regression tests scripts, but in general its a nice utility to
use in other kinds of scripts.

All this matches:

  $ pahole --running_kernel_vmlinux
  /lib/modules/6.11.0-rc5+/build/vmlinux
  $ file `pahole --running_kernel_vmlinux`
  /lib/modules/6.11.0-rc5+/build/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=4dd7f9c4507b82a5bf90671d524e5bb308104ffa, with debug_info, not stripped
  $ perf buildid-list -k
  4dd7f9c4507b82a5bf90671d524e5bb308104ffa
  $ perf buildid-list -i /lib/modules/6.11.0-rc5+/build/vmlinux
  4dd7f9c4507b82a5bf90671d524e5bb308104ffa
  $

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 2f623b4e42619114..0a9d8ac49fbf94d5 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -339,6 +339,10 @@ Identical to \-\-btf_features above, but pahole will exit if it encounters an un
 .B \-\-supported_btf_features
 Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
 
+.TP
+.B \-\-running_kernel_vmlinux,
+Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes).
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 226361dcf349c777..a33490d698ead7d5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -37,6 +37,7 @@ static bool ctf_encode;
 static bool sort_output;
 static bool need_resort;
 static bool first_obj_only;
+static bool show_running_kernel_vmlinux;
 static const char *base_btf_file;
 
 static const char *prettify_input_filename;
@@ -1237,6 +1238,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_btf_features_strict 343
 #define ARGP_contains_enumerator 344
 #define ARGP_reproducible_build 345
+#define ARGP_running_kernel_vmlinux 346
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1851,6 +1853,11 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_reproducible_build,
 		.doc = "Generate reproducile BTF output"
 	},
+	{
+		.name = "running_kernel_vmlinux",
+		.key = ARGP_running_kernel_vmlinux,
+		.doc = "Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes)"
+	},
 	{
 		.name = NULL,
 	}
@@ -2032,6 +2039,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_reproducible_build:
 		conf_load.reproducible_build = true;	break;
+	case ARGP_running_kernel_vmlinux:
+		show_running_kernel_vmlinux = true;	break;
 	case ARGP_btf_features:
 		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
@@ -3707,6 +3716,21 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (show_running_kernel_vmlinux) {
+		const char *vmlinux = vmlinux_path__find_running_kernel();
+
+		if (vmlinux) {
+			fprintf(stdout, "%s\n", vmlinux);
+			rc = EXIT_SUCCESS;
+		} else {
+			fputs("pahole: couldn't find a vmlinux that matches the running kernel\n"
+			      "HINT: Maybe you're inside a container or missing a debuginfo package?\n",
+			      stderr);
+		}
+
+		return rc;
+	}
+
 	if (languages.str && parse_languages())
 		return rc;
 
-- 
2.46.0


