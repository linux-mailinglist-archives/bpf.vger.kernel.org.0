Return-Path: <bpf+bounces-19998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A23835C39
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5E284ADF
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1D18623;
	Mon, 22 Jan 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWZwPJzs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A020DDB;
	Mon, 22 Jan 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910614; cv=none; b=IlxHtkldjL2HGVCbn8AiIR+p4OnIIZMQeSLowro0Il48Zt1Bxjf/KUKJqOZZkYBEaSr+ziScUd7VxN4qxv9T0QNujZcZB8L55HuBtVHNCsiSdme7jlSZg8egd/0NTNwYASEpYCylUX5X1ex4x6fEAz7tYp7ZX24s0WZiX2tIdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910614; c=relaxed/simple;
	bh=EbfASx6rdYM/fLYLjwpVsRLzQ8vlWH2xIbbLy3j+3tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCZvwTYgK0C3RUgkw8lVe3Ida/kLxlE3dIOF/68lV9MthJih1RqpUYZ4BpoYElc56RF7YZwiAPVFEJVleA3BPQv+hDeIwCzCCvTcPPVsjCMrnNGLPEDGNymRnvLsYe8rWZ5yMcbCv3XENMN1HONMvClhQR6NWRo+qH+vuTINgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWZwPJzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D4C433F1;
	Mon, 22 Jan 2024 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705910613;
	bh=EbfASx6rdYM/fLYLjwpVsRLzQ8vlWH2xIbbLy3j+3tM=;
	h=From:To:Cc:Subject:Date:From;
	b=CWZwPJzsmVZOgK3YChPXH5NRZmsfEKYe7IwCl4TcaM2rMBfBh9lUOj9dC4x+uJj07
	 qVFReVHCQYJvrrhaQxmtqk32z+3Yi2djZyJgKIl6GTBpqdNmVaPQ5efLoGP7lQGsEJ
	 gwXomJoDvULTx67btE2gFB1fKNB5ygLwnIXUh48NYA78ZEFNczHxjciWkCPR4vpkkD
	 0XLuShj6rY2lzT+t74k5GGpFa0HJrdaC0Jpm9tCB5SRU0xJiwdLtF50ME4vWrK30k3
	 fMAk/bZBtBcGh0dkiRO6JumTf0829Ij5ERroQfhP+P0FefNuqWSs5SpUvrjvgpCIc9
	 MjDf//lwlZw5A==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH stable 5.15] bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
Date: Mon, 22 Jan 2024 09:03:29 +0100
Message-ID: <20240122080329.856574-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.

[ small context conflict because of not backported --lang_exclude=rust
option, which is not needed in 5.15 ]

v1.25 of pahole supports filtering out functions with multiple inconsistent
function prototypes or optimized-out parameters from the BTF representation.
These present problems because there is no additional info in BTF saying which
inconsistent prototype matches which function instance to help guide attachment,
and functions with optimized-out parameters can lead to incorrect assumptions
about register contents.

So for now, filter out such functions while adding BTF representations for
functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
This patch assumes that below linked changes land in pahole for v1.25.

Issues with pahole filtering being too aggressive in removing functions
appear to be resolved now, but CI and further testing will confirm.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230510130241.1696561-1-alan.maguire@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index d38fa6d84d62..5c724f697100 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -20,5 +20,8 @@ fi
 if [ "${pahole_ver}" -ge "124" ]; then
 	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
 fi
+if [ "${pahole_ver}" -ge "125" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+fi
 
 echo ${extra_paholeopt}
-- 
2.43.0


