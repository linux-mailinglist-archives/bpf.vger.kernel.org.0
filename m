Return-Path: <bpf+bounces-27260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F768AB62F
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D18284913
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759C2E3F7;
	Fri, 19 Apr 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btgunqbc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B121BF3D;
	Fri, 19 Apr 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560281; cv=none; b=lqvex7onMaynZenCEDlPT2+tr+5ZWIc2vhUw/xTWQRfZ7O7eyJgS6DhkfGzpv/j4OfTld1jRTKjWEEopt0Ab7YuZEGvhGo59Egst89FkT0s4cCkX4WbUe16+O0uu6PHiujqYfCQQ6SUkzMyBPQy56xLir68LCoMEk1yJ68EaMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560281; c=relaxed/simple;
	bh=cNMp4+vDY+TbmeH/gCBZcn3PBx1SKm4AQpGhcuyxSoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqmSMnkHXknx78Y+CRWSrZOXc14I+v8o/00ZQ89iTUvfc3YWsoN2S/a5hRPIsFjA3ABckIra+wmvy/Q2c5LOfq6AqMubH9OA5PHaEcZ5/wGJsD26pPpiU/HgNnNtBjyj2B0siOBzPVADhwxZxmGPtuNbMhxUV5Av9EhbxkX7J1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btgunqbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BBFC116B1;
	Fri, 19 Apr 2024 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560281;
	bh=cNMp4+vDY+TbmeH/gCBZcn3PBx1SKm4AQpGhcuyxSoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btgunqbc8ivr86O71D4+K8p7zGvRZ0cisXZwKtkEmfujvgelu1ipPNGmTgVKVi6oK
	 Y57karwpWjLd1IvG5XyAIa+oQoOgMlLDgVPdAF3hPR60Loh1XjF6KjCR1LaOEVvaHC
	 hzvB/hmi6w2U7QCJuVR2mMqB9Leu83Z25DcfqxMxViG7t4zwFuOOnSSIa03GIWSt9E
	 GVo9h5/bADxfhA+BP6y10YLwCPPsa/GEbDSEgBiE1umkzeQafU9ivBg8RdPgBLaX00
	 9oKW7Chgo7Z93vLPBFA9gkCDXMbajGB4HbS5kO2B6u6xUw3pTITHBBs/pFr3vRGpXt
	 T9rsXgEwyGr6g==
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
Subject: [PATCH 2/2] pahole: Allow asking for extra features using the '+' prefix in --btf_features
Date: Fri, 19 Apr 2024 17:57:45 -0300
Message-ID: <20240419205747.1102933-3-acme@kernel.org>
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

Instead of the somewhat confusing:

  --btf_features=all,reproducible_build

That means "'all' the standard BTF features plus the 'reproducible_build'
extra BTF feature", use + directly, making it more compact:

  --btf_features=+reproducible_build

In the future we may want the '-' counterpart as a way to _remove_ some
of the standard set of BTF features.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 man-pages/pahole.1          | 6 ++++++
 pahole.c                    | 6 ++++++
 tests/reproducible_build.sh | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 64de3438b5f9a77a..2f4f42f8323efd6e 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -320,6 +320,12 @@ Supported non-standard features (not enabled for 'all')
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
 
+.fi
+
+If one wants to add an extra feature to the set of standard ones, the '+' prefix can be used, i.e.:
+\-\-btf_features=+reproducible_build will add all standard features plus the 'reproducible_build' extra
+feature.
+
 .TP
 .B \-\-btf_features_strict
 Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
diff --git a/pahole.c b/pahole.c
index af94d2a45ee96cbe..42c5b03ee1d1a8f8 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1364,6 +1364,12 @@ static void parse_btf_features(const char *features, bool strict)
 		return;
 	}
 
+	// Adding extra features to the set of standard features.
+	if (strstarts(features, "+")) {
+		btf_features__enable_for_all();
+		++features;
+	}
+
 	strncpy(f, features, BTF_MAX_FEATURE_STR)[BTF_MAX_FEATURE_STR] = '\0';
 	s = f;
 	while ((feature_name = strtok_r(s, ",", &saveptr)) != NULL) {
diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index e2f836081b125119..1222cb42c6639235 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -29,7 +29,7 @@ nr_proc=$(getconf _NPROCESSORS_ONLN)
 
 for threads in $(seq $nr_proc) ; do
 	test -n "$VERBOSE" && echo $threads threads encoding
-	pahole -j$threads --btf_features=all,reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole -j$threads --btf_features=+reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
 	pahole=$!
 	# HACK: Wait a bit for pahole to start its threads
 	sleep 0.3s
-- 
2.44.0


