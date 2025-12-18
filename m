Return-Path: <bpf+bounces-76938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BDCCC9E3C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A46A7301DE2C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378E1EB1AA;
	Thu, 18 Dec 2025 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVseiO5R"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950319006B
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018058; cv=none; b=b4bhtw9xrG4JKKJ5ioMKvX5a+c/52IrMIKrnjc5gr31/bSwFnWo1ObzCMrGAKIlrvovCvDwJNBKwuvqJWb/RTn74FR/kUX1uu3xXvAPPAzfRCmwz/wkBq7Cx07FeuX73KKd7nivm7YoRzh4JDU40uCXqMoAKLEAYmB6WjJqJxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018058; c=relaxed/simple;
	bh=/9EOX2T4PsSLKlslCku6owIx615Wd85jFXGLADC8i+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVdlzeowGwCix+mK45IdI3urf/XOeRk/wEH04tDTXsqAiytPvMpv/K6KF74w1DLjrPsxh3ataUAsik5JAvIturV1eUCelBNEN0hPRKqYG09Cam9OBsWq9IUbOuh8ccklLThwePTlWHxawUBnzr/OL24saE+Cdf7sxlr1fm7Mlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVseiO5R; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMrhGEo8g6IdHWJcU5PThGSVr6JdXvAM3OyddrEgcdU=;
	b=WVseiO5RhleFmLXdssEXVGC7tCRvtdMsKmDf6c5NLNq7NzfwT5yg4g5pWQ1zvCHpxXJKnA
	UU1UcFscDA9I7amKDNmgi1RdGUdL/ImSB7TMqOFLJCr+yHl1i3m4Y0uzDGVB6i5BR2qNsh
	8w1rEzk+Iodv3D9ZCtL3BVHt5hsTlho=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Vernet <void@manifault.com>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v4 1/8] resolve_btfids: Rename object btf field to btf_path
Date: Wed, 17 Dec 2025 16:33:07 -0800
Message-ID: <20251218003314.260269-2-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-1-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d47191c6e55e..164f0c941f04 100644
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
 
@@ -790,8 +790,8 @@ int main(int argc, const char **argv)
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
-		OPT_STRING(0, "btf", &obj.btf, "BTF data",
-			   "BTF data"),
+		OPT_STRING(0, "btf", &obj.btf_path, "file",
+			   "path to a file with input BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
 		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
-- 
2.52.0


