Return-Path: <bpf+bounces-26674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD48A37BB
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A44C1C209C8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910141514DB;
	Fri, 12 Apr 2024 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUpy6H/t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861414A89;
	Fri, 12 Apr 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956574; cv=none; b=YOVSx1pMJ7hrk8nZCsl0jbCIkHQAaNP9b5MRsg4ADrsbMzAmfN02Z0KB5Ey8UmlqaF6CfluKjwbVA546CqOql/dUavBTjVN4MDRIFlJG5tHIdh0Z6mSAGd3qy0j7sQIkUyvAwiG3RVcU9DXX6nt7uZJmMLlzTwIZGsIBisLsqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956574; c=relaxed/simple;
	bh=ST7KWbTW5vEgaJZoKatfLIs/wAQGXKcwIytfLAFU1Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cui0W2WhWpBXCaLJI+mUstqdawZo7gXpHl1ktBkVEn/nPTrqDFHAiElax+e0zZ3eeV5q6QHVA2n71Pelrl4Dert1SWk4CjLyKuVXMTT6MBg92HdiL1Oy3zSYmEYKLY662RO1EkT3x9EmqBrInyQpxAcWEIDODj4cEwnDydZ8tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUpy6H/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B6C3277B;
	Fri, 12 Apr 2024 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956573;
	bh=ST7KWbTW5vEgaJZoKatfLIs/wAQGXKcwIytfLAFU1Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUpy6H/thDBTzqjY9qf4yHLqW2PX9Fo9aBvTXSajYuOJ7mrdU1NRyK4/Hy5yngXKr
	 W74J7xahieSnxBbtduFG3ZlfT2Odfljc+t4LT5XnO78gF50lrHgb0wRYjhrDXXhPEG
	 nTXJVY0eq9Fq3KL/8+QAq4kBLXEat+PAT3j61tzKRdLb0La8T+qFEn34OIpbESeimo
	 K44pW+IGyQzOsnK3u5+YAd0SODgVXO+Amed+5hER3QfKmQct77lzyw8HT/g4MBVy1O
	 //KjrF68+UFSye6VikYQACRpcrJkB6ihfWNwvkJ7TdpHBRrbJ/ytkb8M+GDe3x592S
	 2cgMJryTv4XWQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 01/12] core: Allow asking for a reproducible build
Date: Fri, 12 Apr 2024 18:15:53 -0300
Message-ID: <20240412211604.789632-2-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is initially about BTF encoding, we want to load DWARF and encode
BTF from it in a way that is reproducible, i.e. no matter how many
threads we use for the loading/encoding process, the output will be the
same, i.e. the BTF ids produced will be the same for all builds.

This first path just adds the conf_load field and allows it to be asked
for with the '--reproducible_build' option in pahole.

At some point we'll use with --btf_features=+reproducible_build or
'--btf_features=default --btf_features=reproducible_build' to keep the
default set of BTF features and be able to use this in the Linux kernel
build system without doing an extra pahole version check for the
availability of --reproducible_build with pahole versions that already
support --btf_features and thus would ignore "reproducible_build".

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.h | 1 +
 pahole.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/dwarves.h b/dwarves.h
index 2393a6c3dc836f39..4dfaa01a00f782d9 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -87,6 +87,7 @@ struct conf_load {
 	bool			skip_encoding_btf_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
+	bool			reproducible_build;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 0b9c2de74f146a4d..96e153432fa212a5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1235,6 +1235,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_supported_btf_features 342
 #define ARGP_btf_features_strict 343
 #define ARGP_contains_enumerator 344
+#define ARGP_reproducible_build 345
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1819,6 +1820,11 @@ static const struct argp_option pahole__options[] = {
 		.arg = "FEATURE_LIST_STRICT",
 		.doc = "Specify supported BTF features in FEATURE_LIST_STRICT or 'all' for all supported features.  Unlike --btf_features, unrecognized features will trigger an error."
 	},
+	{
+		.name = "reproducible_build",
+		.key = ARGP_reproducible_build,
+		.doc = "Generate reproducile BTF output"
+	},
 	{
 		.name = NULL,
 	}
@@ -1997,6 +2003,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_reproducible_build:
+		conf_load.reproducible_build = true;	break;
 	case ARGP_btf_features:
 		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
-- 
2.44.0


