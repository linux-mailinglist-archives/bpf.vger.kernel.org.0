Return-Path: <bpf+bounces-74296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F3C52B4F
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755B342425E
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F55A26B2D3;
	Wed, 12 Nov 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5w+yE4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589226ED41
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956780; cv=none; b=KeqyKpAWS/lAPAYUjJv8sKr1Mot0w6BN1FXsehXIvD3HMb/73DsgkzMm1vtyO6Jhzx0Fv4oyILSEuBQElcmOUkS6ut2K5EPuq6myhA4SgHLNn4yNawg5DGSue9YvZWTTlwO9BEznMLd9FddlSnWtijm1WH/pIHaDNao70KnIIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956780; c=relaxed/simple;
	bh=pVP2OILUU+1rzWIBbsAl/6YtKwi9rPRCel6NowAfs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuPG5hYh5W3lBAPyD9ZjClv7m7RRybukunWkFl/I5YPmrGcck2aDef2z+C85W/1QFn2KKHQGa2STL80ZteyUxqs6BxqJaaprG2A+kGQwpY9NXqGSuqGEdmG/8Ws9m4jrTnv13Dpov4vxqRHx/GVHuFjlrkFiko7sizF/uHtfXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5w+yE4d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so528329f8f.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956777; x=1763561577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=T5w+yE4dv6WzPr49oYvFbx6sySmsxGSB3B0Qbk4nQ2iXQcTVwvIyzXUoisE+/TLziq
         TJVaIpGg2MbmfBQe30SmDez0fy42VSR8vs0HewNTfCLOh5eigM301YfCkS2UeG204nu2
         06weNRsHhJ7lOHlcdEWPg/rF7BbGfX7y8t3UxipFzhB4UsvlYcQwLfP8ZRpyNaJ1GLVZ
         I7NgmN0W9ZyzMfChyFfVqFdgvcdHYNj0KBhKw1xXfFAOMDeOqGmBQQW/6PQChHxtgVEp
         wC51XPZ7P9xdRJ321g9P8g/VhRB6EcfCs+OuWSO+HZU8newRbhtALUAxQuCVR+DAYWK6
         T4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956777; x=1763561577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=ZDh0Dym2FwzNv+Qu3yzFlhvLAg7gYz/2s9Z/g0+JGp4i1NqhrjV6M9oCSkm+MZAkOV
         Lm6U/rYnkxneitkv1fjjlACF+QZGkFbC0O+PBPu/+0dUUbaB/rZ8mzCoBysHLsVBf5P9
         v7NqjLJvBlsAwe/EPNk9MMa4hL1ROhJRsZe1bZfvq+mLsc6joOIuZKes961tC3IPF8wl
         THp9G1uLsBZgvk8XORCDYq7CI+dhkC8rdbn7I6aoDgXgeNxdyFoVjHdUsn81ohnBGFR9
         +BjEUHzRlMgVmUnokh2APFXtaNTv0MjFhtITBh3VCqACnudnIhAmuQtj+nD5Cp8BA2es
         Fkow==
X-Forwarded-Encrypted: i=1; AJvYcCU4+CSyW3q9EMlTPTQ+H8p0v4w6dai4/hvd2zIpvzwni1/KDDh5GvtxpmGW0viWRKj/2x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94O7kUDKAYcuGYWk5NIThtlc5l287iDqVI+kMIL8Ny2Nf+/vE
	MocKdK1K0ZTPYrubCI31rxRmQTvtUioSahvBE4++KNX7zIFvGfH7CFcg
X-Gm-Gg: ASbGncvyZaXvW9CR7xewqU0nEDjbIit3EYdPEHcvSmGZzrDBtyK/DJpVlhAr1FGusZ5
	5gPDx4JgNrV+m5KtM+jvGXLnzK2IcdTMuT7LCXLM0UdxppLC5jdXtyTUjV5DE2G4ma6TD9ts5j0
	qZONqCWwQY60WaYb+3v7m+6gquBMeWrynDZy3r/YQkatWnfynBmZ0Rjdhkc/sRZLwTyokWAI377
	LyFY2Z4lwtY/+fseeMGu31ekCrdCkaQv27ivKnlOiG5T7H0Y9jUhJpnGlEbBTsImdaaj43l3Wlm
	P8xBvDLRCTiQrCzMJNOUHRCt7VZlc0WB7/QuBwD+RnZ2mTbYjHS+LMvcCdvPyD6DS0eRPZUyZxL
	0ZCwjngv+SjERKCJ3YUx99RTi0oY7RO4Yx5CVDoyyFOWTkWkySrWTAx+yweMPGZ/RHqnevW38gL
	tZMQ5/gqtUldCm
X-Google-Smtp-Source: AGHT+IGYNoOTXnre/4ceRR7yKQ/OoOBBVZ7Ao+Bo2jO9uF7B6Yz0Tq6gekxjquRjIP2nqgGKT+RdVQ==
X-Received: by 2002:a05:6000:4210:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42b4bdb03a9mr2990959f8f.30.1762956777196;
        Wed, 12 Nov 2025 06:12:57 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:56 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v2 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Wed, 12 Nov 2025 15:11:34 +0100
Message-ID: <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762956564.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several ./test_progs tests:
    1.  btf/dedup:recursive typedef ensures that deduplication no
	longer fails on recursive typedefs.
    2.  btf/dedup:typedef ensures that typedefs are deduplicated correctly
	just as they were before this patch.

Signed-off-by: Paul Houssel <paul.houssel@orange.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..a19db159475a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7495,6 +7495,67 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
 	},
 },
+{
+	.descr = "dedup: recursive typedef",
+	/*
+	 * This test simulates a recursive typedef, which in GO is defined as such:
+	 *
+	 *   type Foo func() Foo
+	 *
+	 * In BTF terms, this is represented as a TYPEDEF referencing
+	 * a FUNC_PROTO that returns the same TYPEDEF.
+	 */
+	.input = {
+		.raw_types = {
+			/*
+			 * [1] typedef Foo -> func() Foo
+			 * [2] func_proto() -> Foo
+			 */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+},
+{
+	.descr = "dedup: typedef",
+    /*
+     * // CU 1:
+     * typedef int foo;
+     *
+     * // CU 2:
+     * typedef int foo;
+     */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			/* CU 2 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [3] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 3),		/* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+},
 {
 	.descr = "dedup: typedef tags",
 	.input = {
-- 
2.51.0


