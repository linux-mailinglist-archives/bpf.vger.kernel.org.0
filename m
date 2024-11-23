Return-Path: <bpf+bounces-45500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DB9D6951
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CD4B22303
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06AB27466;
	Sat, 23 Nov 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Oq9aIHEk"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231EC195;
	Sat, 23 Nov 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368827; cv=none; b=b7FaYjDBvAHBX6jY8a5P05a+FajfN1rMXXVHfM/aisa0o9BAnKwVUzWlxRakd92O54v6gz2xiAJeyjXTKuoe+mP05GMZE4owtkM6KMtQ447A5uz0ibxw9wSqJFIK3/N44jbU3SG3wHcV0KwWUprFStbclBjYlbovvLnDobdEE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368827; c=relaxed/simple;
	bh=b2w80aj/337drIii2E6x6QjQqcUkYdT/ByK0kIRLqXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqHa2xGdTEYDJQ5cVyp7ZqwwEzI4a4MaD1dphY6BVn5Lck2cQit3Du++fdqFsyeior+gtVh9XT6x9q5gux29rQocY+4p6h238j70w/wzbRSz80xu2PYpy4UD8l4gcLOXVEE/yTx0uefsh0YxI4InndbLSrNpX3MMB5psyvFCmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Oq9aIHEk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732368822;
	bh=b2w80aj/337drIii2E6x6QjQqcUkYdT/ByK0kIRLqXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oq9aIHEktYwMJqjdQSAInSwjkc/qEgdDS+PFYTXNpNUL1Oei0x6N/kMmO7kvL9JBP
	 gUBhFVsGHoVjjR3N98darrrj3nTZnktHQ96DOucH6lz5FJ34kztgVq+DFHlnCjH1I4
	 FyAT74Yf9GQD4np3nBgXVC3hC7zfQk0EKuzPHy04=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 23 Nov 2024 14:33:38 +0100
Subject: [PATCH 2/3] tools/resolve_btfids: Add --fatal-warnings option
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241123-resolve_btfids-v1-2-927700b641d1@weissschuh.net>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
In-Reply-To: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732368820; l=2182;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b2w80aj/337drIii2E6x6QjQqcUkYdT/ByK0kIRLqXE=;
 b=G0B/rmQnA2tpKvxmlrof8LTfU+EcPwyPnajMu4SUpWefSNYVbb8eTcZKdcbmR/BmI9L2Kr1kJ
 +YCDtia4zbAD0mG7LFGVg+I8LiVPCZMoLMjMl0Hs0GzHAIl6PjfLCuD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently warnings emitted by resolve_btfids are buried in the build log
and are slipping into mainline frequently.
Add an option to elevate warnings to hard errors so the CI bots can
catch any new warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..a6ffd6b5fc3ebe9e0983556bfb178642a1c6639d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -141,6 +141,7 @@ struct object {
 };
 
 static int verbose;
+static int warnings;
 
 static int eprintf(int level, int var, const char *fmt, ...)
 {
@@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj)
 			if (id->id) {
 				pr_info("WARN: multiple IDs found for '%s': %d, %d - using %d\n",
 					str, id->id, type_id, id->id);
+				warnings++;
 			} else {
 				id->id = type_id;
 				(*nr)--;
@@ -625,8 +627,10 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	/* For set, set8, id->id may be 0 */
-	if (!id->id && !id->is_set && !id->is_set8)
+	if (!id->id && !id->is_set && !id->is_set8) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
+		warnings++;
+	}
 
 	for (i = 0; i < id->addr_cnt; i++) {
 		unsigned long addr = id->addr[i];
@@ -782,9 +786,12 @@ int main(int argc, const char **argv)
 		.funcs    = RB_ROOT,
 		.sets     = RB_ROOT,
 	};
+	int fatal_warnings;
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
+		OPT_INCR(0, "fatal-warnings", &fatal_warnings,
+			 "turn warnings into errors"),
 		OPT_STRING(0, "btf", &obj.btf, "BTF data",
 			   "BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
@@ -823,7 +830,8 @@ int main(int argc, const char **argv)
 	if (symbols_patch(&obj))
 		goto out;
 
-	err = 0;
+	if (!(fatal_warnings && warnings))
+		err = 0;
 out:
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);

-- 
2.47.0


