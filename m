Return-Path: <bpf+bounces-20598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0E840882
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C0D28C330
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24683154C0E;
	Mon, 29 Jan 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmzDCe6X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922B152DF7;
	Mon, 29 Jan 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538809; cv=none; b=RaSrRAi/QXNi6Qp/Nb1mm80BCL7ivVmsqGeMM705DPxQfgSKB3mkzWsTIKU6FuSfLDf6KC1H8b7nRMiJo5EobH0DPqtrduy1lRilf9Q2PsTxga0/h0SwVssx+ftLf/27xiCiWt0tSSQsW96vns9dMsPgARbhwZRGMx5zWabzO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538809; c=relaxed/simple;
	bh=kW2g6Dz+tIXorByc+AhAFneeAB1zVin/42tC9xQolBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GaUAPU6LJAWJgam5srVg6bWA1/N3CL/8k3CCNBf+ian8+g7DmjcCVzbKijpoNCYnJmFSYCl/cCY5rxWFFAqZoep7qfj/Z63UpDkflhbtOpaZkJKdKu7duvvhsRaCNOR2aT9vPZvhPSZ2HLBw65/VEtngdKoYYhIQALAEveYUp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmzDCe6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7D8C433F1;
	Mon, 29 Jan 2024 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706538809;
	bh=kW2g6Dz+tIXorByc+AhAFneeAB1zVin/42tC9xQolBE=;
	h=Date:From:To:Cc:Subject:From;
	b=HmzDCe6Xp0KRQAGqE588CvOyhRKpzHVKRJ1HVUq0QRfuY/0qFQXnGgajuZk9PlOHW
	 Vg5JelFMXzyuIlmsN8ZQ309c8+gK5ZRy0ki7/s42WZ3MpLFSN/ZLgmBWxlJQD+pz1g
	 w+aZuaPHi5sffhrtrOE2L+WCEUMNribFKUpj2i7YNrAbV0O7DcTjQlWyh2fvFb+aZ+
	 II8U4B6nIxJWPaXGVa3pecfqacDZVXEeb32QhDTGRvKCajntdBmn3GcMWMaDLLrmb9
	 +nX/A23tNbQ8ZNAmltyv3cZm62miWs2w3e6Mb3PRkeabQtRqbnPcO3jjMBH7oj4Loj
	 RU+glkRzLnWGg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8542440441; Mon, 29 Jan 2024 11:33:26 -0300 (-03)
Date: Mon, 29 Jan 2024 11:33:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] bpftool: Be more portable by using POSIX's basename()
Message-ID: <Zbe3NuOgaupvUcpF@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

musl libc had the basename() prototype in string.h, but this is a
glibc-ism, now they removed the _GNU_SOURCE bits in their devel distro,
Alpine Linux edge:

  https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

So lets use the POSIX version, the whole rationale is spelled out at:

  https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZZhsPs00TI75RdAr@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/bpf/bpftool/gen.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b8000d75d2..a5cc5938c3d7951e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -7,6 +7,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <libgen.h>
 #include <linux/err.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -56,9 +57,10 @@ static bool str_has_suffix(const char *str, const char *suffix)
 
 static void get_obj_name(char *name, const char *file)
 {
-	/* Using basename() GNU version which doesn't modify arg. */
-	strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
-	name[MAX_OBJ_NAME_LEN - 1] = '\0';
+	char file_copy[PATH_MAX];
+	/* Using basename() POSIX version to be more portable. */
+	strncpy(file_copy, file, PATH_MAX - 1)[PATH_MAX - 1] = '\0';
+	strncpy(name, basename(file_copy), MAX_OBJ_NAME_LEN - 1)[MAX_OBJ_NAME_LEN - 1] = '\0';
 	if (str_has_suffix(name, ".o"))
 		name[strlen(name) - 2] = '\0';
 	sanitize_identifier(name);
-- 
2.43.0


