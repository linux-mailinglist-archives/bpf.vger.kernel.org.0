Return-Path: <bpf+bounces-75524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC31C87B1E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444674E6253
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAB2F83AC;
	Wed, 26 Nov 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MCaqU0Cu"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3202F659C
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120574; cv=none; b=FAVgvibysIWXPNXj2n27ydiyjEleTGAmldjmRZKwd6DOu8I4hMkAltEgkWcmzqOEXGk7m48VeEsDUICGuBxhlSrvsNLjI92YNfoPt/tawlXGwdxfsGesXE3S7iquTOaH7KqtOYg8O6swFbv+f2rhtHQQSlZsd574NWokFzuD8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120574; c=relaxed/simple;
	bh=0vPBXFkWZ/MzGH4tjLWdF3Fl9qTxFcaK/Jzqj1oLtgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqFJlt3Agq4g8OtLaPJVVG8e09q0tbWYDGHRDvmKfl5U36xL3CHrhd7lEAw+PQutrLisxt+rg1fp0lNpzW2F3bHo92MZgAEsqIXf+lK3PAeR4tLN5+nbm9qx2mW5j4PwNVBLXs4OcqC0oJqnQgRBcq/ZBAtOsIVQ3InhpG18PnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MCaqU0Cu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764120570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xzNaBNG8jGgwOPkttRYQPmkjzfbEIAH53D/pi2LZps=;
	b=MCaqU0Cup+kk5iU+XTEsWgK2C5cR4gPaOFtdx7Tp6e4LOtTwFJH/CidUDGTYNCdhUukKqj
	TATIZPGq9cGcvF0aIY7FVyBVbv7obvfE5ITssPGkG6V4gEzrjQL+j3lNlnbA/FBEcggnUI
	T63SBlPCsmMUKB+NnyIg8gRmXyTy7ms=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH bpf-next v1 1/4] resolve_btfids: rename object btf field to btf_path
Date: Tue, 25 Nov 2025 17:26:53 -0800
Message-ID: <20251126012656.3546071-2-ihor.solodrai@linux.dev>
In-Reply-To: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename the member of `struct object` holding the path to BTF data if
provided via --btf arg. `btf_path` is less ambiguous.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d47191c6e55e..d2762487ce5f 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -113,7 +113,7 @@ struct btf_id {
 
 struct object {
 	const char *path;
-	const char *btf;
+	const char *btf_path;
 	const char *base_btf_path;
 
 	struct {
@@ -550,11 +550,11 @@ static int symbols_resolve(struct object *obj)
 		}
 	}
 
-	btf = btf__parse_split(obj->btf ?: obj->path, base_btf);
+	btf = btf__parse_split(obj->btf_path ?: obj->path, base_btf);
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
-			obj->btf ?: obj->path, strerror(-err));
+			obj->btf_path ?: obj->path, strerror(-err));
 		goto out;
 	}
 
@@ -790,7 +790,7 @@ int main(int argc, const char **argv)
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
-		OPT_STRING(0, "btf", &obj.btf, "BTF data",
+		OPT_STRING(0, "btf", &obj.btf_path, "BTF data",
 			   "BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
-- 
2.52.0


