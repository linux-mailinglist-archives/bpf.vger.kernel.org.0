Return-Path: <bpf+bounces-32424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCE90DBC4
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DA01F2236F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056416A94D;
	Tue, 18 Jun 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZMG3UD4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC7166317
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735915; cv=none; b=rgtmvh7X2RkqWHgv5Ar4AyK+gzUJYGuVQMFCDBOyM3k1jWyAfdvtvxUB/WSV/uvRhIG3LUsvqxTp+DxZpEgA+lw0iA7ATv9vzzsXzn/A9ZrOsqQfrhJtXOMf4VEVAvfQTSnDtdnda1hERFy/reON+W9IUZSXghnT+d/AqcS68gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735915; c=relaxed/simple;
	bh=S6vnrcZ2tqT4/W7MrM3Lek8ab7syCK04wGcx9YVZDIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixDjYBptAAujHiX/R+pHr0MWZ/A+GA+rB5OkUoVyDfn2Qsgodkn5Ee5s0qz+d6LHQquSKkF4qaRJQuYbAFWVeFwZ/Dp42KC/2NllZwJeZKCYqab/G2ppiA2mMBevlKaSuGvff5E7PbXF2qLdJX3H0x0KFPUj7r95k/eefy4SELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZMG3UD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F28C3277B;
	Tue, 18 Jun 2024 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718735914;
	bh=S6vnrcZ2tqT4/W7MrM3Lek8ab7syCK04wGcx9YVZDIo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZZMG3UD4KqbPownTOsv5IyJhl39L8HpAx+vJxdmnY9COf+DjswNsdbEeHz+DH2VX1
	 5LiElN2m75DtOHZhCtrmlQt/DZVZHlxMSuzLw7T7vmcaWDpCpZEoh4DlBxlSX4PEZj
	 NgRpGQ6HgBp4prPN8Uy9HZphnLc+HynbRjA9IRQ/Z13k3u7kHa2QciiuBfsw0uzcPg
	 7vHVlP7pb85M64VsEjrp5JuDBhCtGIi48Cg76xeF0bUvIAL40BI/C+x5CaMV+qozm1
	 AVzuS8IOZuLYokGARKrdgBzfSyaheJvSJ9HGtys/fcvRj+UeM32L3CvIwEX3Nx6d93
	 xWK8wRcVzRRNg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpftool: allow compile-time checks of BPF map auto-attach support in skeleton
Date: Tue, 18 Jun 2024 11:38:32 -0700
Message-ID: <20240618183832.2535876-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New versions of bpftool now emit additional link placeholders for BPF
maps (struct_ops maps are the only maps right now that support
attachment), and set up BPF skeleton in such a way that libbpf will
auto-attach BPF maps automatically, assumming libbpf is recent enough
(v1.5+). Old libbpf will do nothing with those links and won't attempt
to auto-attach maps. This allows user code to handle both pre-v1.5 and
v1.5+ versions of libbpf at runtime, if necessary.

But if users don't have (or don't want to) control bpftool version that
generates skeleton, then they can't just assume that skeleton will have
link placeholders. To make this detection possible and easy, let's add
the following to generated skeleton header file:

  #define BPF_SKEL_SUPPORTS_MAP_AUTO_ATTACH 1

This can be used during compilation time to guard code that accesses
skel->links.<map> slots.

Note, if auto-attachment is undesirable, libbpf allows to disable this
through bpf_map__set_autoattach(map, false). This is necessary only on
libbpf v1.5+, older libbpf doesn't support map auto-attach anyways.

Libbpf version can be detected at compilation time using
LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros, or at runtime with
libbpf_major_version() and libbpf_minor_version() APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4a4eedfcd479..51eaed76db97 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1272,6 +1272,8 @@ static int do_skeleton(int argc, char **argv)
 		#include <stdlib.h>					    \n\
 		#include <bpf/libbpf.h>					    \n\
 									    \n\
+		#define BPF_SKEL_SUPPORTS_MAP_AUTO_ATTACH 1		    \n\
+									    \n\
 		struct %1$s {						    \n\
 			struct bpf_object_skeleton *skeleton;		    \n\
 			struct bpf_object *obj;				    \n\
-- 
2.43.0


