Return-Path: <bpf+bounces-38688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8AF967C44
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BE21C21229
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD179B84;
	Sun,  1 Sep 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6J1BENu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB52C6AF
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224875; cv=none; b=s3LnOMAoC2d55fHrZ40IHr6JkCR6n2IlMNR1zO4gIVNikhivOO39WTSCv6z4+KE3ajMHqJLcrvfo75qZHtHDErY26QJm//i6ugwySf+tUEAuemKPgsDRVuunIMNwU6s5UiVciZ9FVJJzB+ubOT+uBOr154H14gDiNSg053tHBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224875; c=relaxed/simple;
	bh=NK20xvBCV0o+sh/OPnElLbYxb6WURUOW/x/m7BdvigA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITQMPaAYCoXXYXE83Mrn/QSAmAAdXYt+8OxsZrl7bVAEQOTNU0oBsLLIVt8pMW2Nz+CdIzJ0nGQGpEvWDIXYCxp3/sMjzgSUrco6i0KYYuowtHX57B2IMKLWjAn/7Ej4aZ1uTwNWKJKj4TZ5+xHQ3s/NJQU8IWM/ykaqFqW4XZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6J1BENu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D97EC4CEC3;
	Sun,  1 Sep 2024 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725224875;
	bh=NK20xvBCV0o+sh/OPnElLbYxb6WURUOW/x/m7BdvigA=;
	h=From:To:Cc:Subject:Date:From;
	b=Z6J1BENuFtwiuETn7ymZIldEefn8x8z7gtUyhEb0KRqhX/Znqre3vCMcmlOkzAogl
	 AYH2ohL4QaW5A4WJKvUqKkJY3jArQxn66CsFv4IenVrFz42CaaUXm0POvKO/r16FrS
	 0FAKPQHHZr0YvbzJooF7hDdFU+TlKolxlPBkF70XfKeIw7nyBo3qONyRswyyZ+WkvT
	 X+NbylG5s7H4W6yQbOsQP+wvZMM+TDzoCJLDvzUbYTIaCq76mfyUzOz3b3I3jc7mPc
	 rNst5soiCeqsSCGoJOE6r/BiY4SuYfeTFFSSOEpxUvjyG2JEcHSykwhoJHCm+o8bXp
	 4qymvaanbSMjA==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Add missing blank lines in bpftool-net doc example
Date: Sun,  1 Sep 2024 22:07:42 +0100
Message-ID: <20240901210742.25758-1-qmo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bpftool-net documentation, two blank lines are missing in a
recently added example, causing docutils to complain:

    $ cd tools/bpf/bpftool
    $ make doc
      DESCEND Documentation
      GEN     bpftool-btf.8
      GEN     bpftool-cgroup.8
      GEN     bpftool-feature.8
      GEN     bpftool-gen.8
      GEN     bpftool-iter.8
      GEN     bpftool-link.8
      GEN     bpftool-map.8
      GEN     bpftool-net.8
    <stdin>:189: (INFO/1) Possible incomplete section title.
    Treating the overline as ordinary text because it's so short.
    <stdin>:192: (INFO/1) Blank line missing before literal block (after the "::")? Interpreted as a definition list item.
    <stdin>:199: (INFO/1) Possible incomplete section title.
    Treating the overline as ordinary text because it's so short.
    <stdin>:201: (INFO/1) Blank line missing before literal block (after the "::")? Interpreted as a definition list item.
      GEN     bpftool-perf.8
      GEN     bpftool-prog.8
      GEN     bpftool.8
      GEN     bpftool-struct_ops.8

Add the missing blank lines.

Fixes: 0d7c06125cea ("bpftool: Add document for net attach/detach on tcx subcommand")
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-net.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 4a8cb5e0d94b..a9ed8992800f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -187,6 +187,7 @@ EXAMPLES
 |
 
 ::
+
       tc:
       lo(1) tcx/ingress tc_prog prog_id 29
 
@@ -197,4 +198,5 @@ EXAMPLES
 |
 
 ::
+
       tc:
-- 
2.43.0


