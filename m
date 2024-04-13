Return-Path: <bpf+bounces-26695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BB8A3A0E
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 03:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9677D1C20C93
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 01:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287554C83;
	Sat, 13 Apr 2024 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH4dXiOr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5E4C65
	for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970911; cv=none; b=mRb4n6tOUe/zbSZsNUNw2R6o7G0U6KOkHrmK7sCeSkk1a10hnv+gWYW59mLayCwnZMolRc/sfZp8+tU9RmYmFtoX3tbFAlLcB/tRdFxTw8OuV8lXCZUwLwYJth1o2e2aQdCtY6z4hfLfLZFkQ2Cw/Or5coJRu7ExUNxYz+ADhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970911; c=relaxed/simple;
	bh=mCZhqiXNv+uUVUrEGhfvp3pVFzCPqJAtZuDUyUFgtPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YaDKsJE+XSNvOwaxilJKTwp4Ws1OYa3TvFb7OqWpG+h5gtbuLRgKQIwUM0fwr77DxyRIxMiABUGHXzaV9kMaRJOqpO/74UowF0GTLjyVxf0hgKhxjvV3FoxoWrWEbt1CBG5z1cJAQK6/pzw297kpm12SzWOZqk4e3e1bTpLc6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH4dXiOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073BC3277B;
	Sat, 13 Apr 2024 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712970911;
	bh=mCZhqiXNv+uUVUrEGhfvp3pVFzCPqJAtZuDUyUFgtPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH4dXiOrsJH2VVFDmn9f10JwNo7KpiEDJt1exjk0fxXeU10+iJiBubSEH5QWPDH0H
	 tPJRg+1oiDdnTZH4ymSesbobbSGLYN0h6H0vqDzprH+bbNpK2O9Gck9Vw/xOiiQT2c
	 SuQmX91t8CZRuSuz4QimKuEPVwBqifQVftt9WxMsxNBLTAwdwsaRVNeQ/b2wY7AmxA
	 7pslOizixuEXt90sr3T2tn+SmEjrhz/A7hoYdGTwperCsTkUm64EN0hkVSLpfEzq9O
	 ajRb6WCf5oz10RAZWCk+AkW39esClOsmXhAQoeTq0kyx2E2Bk7cZ1pxuykmMWB5h/l
	 EQtf1Uo3kOyRw==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 1/2] bpftool: Update documentation where progs/maps can be passed by name
Date: Sat, 13 Apr 2024 02:14:26 +0100
Message-Id: <20240413011427.14402-2-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240413011427.14402-1-qmo@kernel.org>
References: <20240413011427.14402-1-qmo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using references to BPF programs, bpftool supports passing programs
by name on the command line. The manual pages for "bpftool prog" and
"bpftool map" (for prog_array updates) mention it, but we have a few
additional subcommands that support referencing programs by name but do
not mention it in their documentation. Let's update the pages for
subcommands "btf", "cgroup", and "net".

Similarly, we can reference maps by name when passing them to "bpftool
prog load", so we update the page for "bpftool prog" as well.

Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index f66781f20af2..eaba24320fb2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -30,7 +30,7 @@ BTF COMMANDS
 | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
 | *FORMAT* := { **raw** | **c** }
 | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
-| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index b2610d169e60..e8185596a759 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -30,7 +30,7 @@ CGROUP COMMANDS
 | **bpftool** **cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
 | **bpftool** **cgroup help**
 |
-| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 | *ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
 |     **cgroup_inet_sock_create** | **cgroup_sock_ops** |
 |     **cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index f8e65869f8b4..348812881297 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -28,7 +28,7 @@ NET COMMANDS
 | **bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
 | **bpftool** **net help**
 |
-| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
+| *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 | *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
 
 DESCRIPTION
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 8e730cfb2589..d6304e01afe0 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -39,7 +39,7 @@ PROG COMMANDS
 | **bpftool** **prog profile** *PROG* [**duration** *DURATION*] *METRICs*
 | **bpftool** **prog help**
 |
-| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
+| *MAP* := { **id** *MAP_ID* | **pinned** *FILE* | **name** *MAP_NAME* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 | *TYPE* := {
 |     **socket** | **kprobe** | **kretprobe** | **classifier** | **action** |
-- 
2.34.1


