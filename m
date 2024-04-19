Return-Path: <bpf+bounces-27259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37A8AB62E
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E62838A2
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFE2BB04;
	Fri, 19 Apr 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy8Y6RCZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E971BF3D;
	Fri, 19 Apr 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560278; cv=none; b=ETH1/cy0gUTDLmdYUoUbHtgDZhZsu0ingt9lDA7joC+mLa16s29/OZRni5XVx4IZQT/TSjn3eMMus1xWXIhYCIHYxsCc+MQwajInmKNr+TkMTFfFqVP4z6zp2qMv5/XJwY8jK/aVMysV/9GPwedNcMlmagbm6FJ0bL5BbvWYnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560278; c=relaxed/simple;
	bh=FHdWZDnD3iImj5qxrs4DAL/d0Ax6+0EL96pV+pyVI7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGvP2CJTxbd7t8GPFeiMIN8T3SG+v1W0yk3rx/0OjB3m+qKAcYyWzXKgGzvBEOiBsdEadPpGd+E+SUL/FFp6B07RprrycnYK50eGVVK/hUw7GYtVKCWaBTFk6tu6FGI7fB0OZJakyOXHuKykyrdom/P/IMV2sf50y82l7COTHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy8Y6RCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF79C3277B;
	Fri, 19 Apr 2024 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560278;
	bh=FHdWZDnD3iImj5qxrs4DAL/d0Ax6+0EL96pV+pyVI7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy8Y6RCZkjWex5iEEHGsDYNReZvh+e3ev3DFLHBKlpOV/EMFm5NRHIIg9qgHkYb+v
	 RWV5v3IS2o/OselygdVFWqXuV1PeY6wNwngKizZ7hiZ80IAkYIQA3F5BwCafKI1GO6
	 9w59XJHLOLzvqPJJvTwOSM1NVKOkLbdFn/3SGdB8jtnvqm/t9J5Kl99yCeiWUq6qYW
	 15u/xuyBmwX1uisasA3GOUIF8+uNIELZ2J9L5IEduAt52iQSL8cfdKEtW2E8Rqy40i
	 OendDgcL9bPLLdatjKK+2ejTtFbGMlbeQkT857hC8bd78c+0KyiEmYBTmCanMwnasP
	 D2ZW7VqaCV8AA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 1/2] pahole: Factor out routine to process "--btf_features=all"
Date: Fri, 19 Apr 2024 17:57:44 -0300
Message-ID: <20240419205747.1102933-2-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419205747.1102933-1-acme@kernel.org>
References: <20240419205747.1102933-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll use it to process "--btf_features=+reproducible_build" meaning
"all + reproducible_build".

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/pahole.c b/pahole.c
index 38cc6362015fd95b..af94d2a45ee96cbe 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1340,6 +1340,14 @@ static void show_supported_btf_features(FILE *output)
 	fprintf(output, "\n");
 }
 
+static void btf_features__enable_for_all(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		if (btf_features[i].enable_for_all)
+			enable_btf_feature(&btf_features[i]);
+	}
+}
+
 /* Translate --btf_features=feature1[,feature2] into conf_load values.
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
@@ -1352,12 +1360,7 @@ static void parse_btf_features(const char *features, bool strict)
 	init_btf_features();
 
 	if (strcmp(features, "all") == 0) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
-			if (btf_features[i].enable_for_all)
-				enable_btf_feature(&btf_features[i]);
-		}
+		btf_features__enable_for_all();
 		return;
 	}
 
@@ -1371,7 +1374,7 @@ static void parse_btf_features(const char *features, bool strict)
 			 * allowed.
 			 */
 			if (strcmp(feature_name, "all") == 0) {
-				parse_btf_features(feature_name, strict);
+				btf_features__enable_for_all();
 			} else if (strict) {
 				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
 					feature_name, features);
-- 
2.44.0


