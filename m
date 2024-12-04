Return-Path: <bpf+bounces-46105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCC9E44DD
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBABE282BF3
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CDE206F37;
	Wed,  4 Dec 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mny+SgVH"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721671F03C9;
	Wed,  4 Dec 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341081; cv=none; b=CBcApkhhkPFlJZYF7AtNYpY7fRhog16qQLudALWPw7l0dpOJ8ckWAjMaaD11oaD45BgrNCPkTlLHf39V6NWFj9panMJ/J3RHydhonUWKlc0VehbHva+yHIWCnGCUy64nnzNB+U/V1S/9Gzg1BTsWy3oSR3ltxB8yQxE5At0DZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341081; c=relaxed/simple;
	bh=f8xLN3ZcudczNgNboJNAgfLSKfWN18Qam/y5laaAdVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Scz0j6DnwaDLBAgWDXB/bWzInnqTuRyYMxR+uPr4e79aEKclabd6MUAdJI22qm+mRUHu0OvsHu69ki2sqC9j/lvEk1bcW9bMJxXAe+Pa7Zo+DHssYna4tAtKfd8zMwY3acOwNxPnVMjXRHGxcT/fswtn3Jys4hFaoHfAjgHezV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mny+SgVH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733341068;
	bh=f8xLN3ZcudczNgNboJNAgfLSKfWN18Qam/y5laaAdVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mny+SgVHsEk6gvlupIf+uMy+bUeC2vs8+pfGnPcvTKgaMvh8UYBlFP8WtUGxkNoks
	 xus6vLFzU7vQudCuEOzYxgMxJh71/n3cAFZywhKAzhA1VIr4Pwh4rvqGv1coEKwGpA
	 2CYGZG+DZNb4G8DihPlgKn63HPn4rxVQJdfTa9ts=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Dec 2024 20:37:44 +0100
Subject: [PATCH bpf-next v3 1/2] tools/resolve_btfids: Add --fatal_warnings
 option
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-resolve_btfids-v3-1-e6a279a74cfd@weissschuh.net>
References: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
In-Reply-To: <20241204-resolve_btfids-v3-0-e6a279a74cfd@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733341067; l=2329;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=f8xLN3ZcudczNgNboJNAgfLSKfWN18Qam/y5laaAdVY=;
 b=+05UzyPxH/V9pGb78h49Ua93Fh8kEAapaePFhC9Be2JJO1yD+3OQdlVpucuHXAzsqpr0ZlcLe
 VuLO4P+FtEKDLtG3OjY9hmtaPHFmMLP2a7iteHmaSC38p7io3eVNwbz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently warnings emitted by resolve_btfids are buried in the build log
and are slipping into mainline frequently.
Add an option to elevate warnings to hard errors so the CI bots can
catch any new warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..d47191c6e55e10215269774f4bdfc6e5b4bf72f8 100644
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
@@ -782,6 +786,7 @@ int main(int argc, const char **argv)
 		.funcs    = RB_ROOT,
 		.sets     = RB_ROOT,
 	};
+	bool fatal_warnings = false;
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
@@ -789,6 +794,8 @@ int main(int argc, const char **argv)
 			   "BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
+		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
+			    "turn warnings into errors"),
 		OPT_END()
 	};
 	int err = -1;
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
2.47.1


