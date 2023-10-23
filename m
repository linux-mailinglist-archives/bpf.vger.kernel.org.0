Return-Path: <bpf+bounces-12974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2B7D2A0E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858882814CA
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038363A8;
	Mon, 23 Oct 2023 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwiU3jSZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC73C36;
	Mon, 23 Oct 2023 06:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6004FC433C7;
	Mon, 23 Oct 2023 06:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698041663;
	bh=m8msnJbk9PZvnd9pC1CQz/Ha4xtjengljXw9BtSYNFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwiU3jSZwg+a9q+6n4PosfDCSeOYSkyExj3WQuXGAonMiu4DxjK87FYv5Pxae256h
	 fRDsNCUNtM9VPUSRDgOkaZffQyVzOSoNTpY360vGamAMPMoQBktVdQReiAhhZY/+u7
	 /IJ/nRH6GrW2kmeCiee2pys+oS4eP/wbA1lR/cIX2FvBU8bpG7L7YUw4LY/+NTnvcu
	 EuSizgEZMXddMlJBlSvVrtx4ZB7xHRH1je3eVPBNIFc1Aj6NfSk4Ew/94BNu+nv0sw
	 lRYoXvaLZWkBh636KOnaYMxcMOs1Mf6ldyj7iPEu4kzb2fIbvH2NiwJt/9mq1eZOt7
	 L0uUGYULJNsfA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
Date: Sun, 22 Oct 2023 23:13:47 -0700
Message-Id: <20231023061354.941552-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023061354.941552-1-song@kernel.org>
References: <20231023061354.941552-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper will be used to check whether a kfunc arg points to const
string. Add a type check (PTR_TO_MAP_VALUE) in case the helper is
misused in the future.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb58987e4844..0abfb3b2c05c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8243,6 +8243,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
 	return state->stack[spi].spilled_ptr.dynptr.type;
 }
 
+static int check_reg_const_str(struct bpf_verifier_env *env,
+			       struct bpf_reg_state *reg, u32 regno)
+{
+	struct bpf_map *map = reg->map_ptr;
+	int err;
+	int map_off;
+	u64 map_addr;
+	char *str_ptr;
+
+	if (WARN_ON_ONCE(reg->type != PTR_TO_MAP_VALUE))
+		return -EINVAL;
+
+	if (!bpf_map_is_rdonly(map)) {
+		verbose(env, "R%d does not point to a readonly map'\n", regno);
+		return -EACCES;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "R%d is not a constant address'\n", regno);
+			return -EACCES;
+	}
+
+	if (!map->ops->map_direct_value_addr) {
+		verbose(env, "no direct value access support for this map type\n");
+		return -EACCES;
+	}
+
+	err = check_map_access(env, regno, reg->off,
+			       map->value_size - reg->off, false,
+			       ACCESS_HELPER);
+	if (err)
+		return err;
+
+	map_off = reg->off + reg->var_off.value;
+	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
+	if (err) {
+		verbose(env, "direct value access on string failed\n");
+		return err;
+	}
+
+	str_ptr = (char *)(long)(map_addr);
+	if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
+		verbose(env, "string is not zero-terminated\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -8487,44 +8535,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 	case ARG_PTR_TO_CONST_STR:
 	{
-		struct bpf_map *map = reg->map_ptr;
-		int map_off;
-		u64 map_addr;
-		char *str_ptr;
-
-		if (!bpf_map_is_rdonly(map)) {
-			verbose(env, "R%d does not point to a readonly map'\n", regno);
-			return -EACCES;
-		}
-
-		if (!tnum_is_const(reg->var_off)) {
-			verbose(env, "R%d is not a constant address'\n", regno);
-			return -EACCES;
-		}
-
-		if (!map->ops->map_direct_value_addr) {
-			verbose(env, "no direct value access support for this map type\n");
-			return -EACCES;
-		}
-
-		err = check_map_access(env, regno, reg->off,
-				       map->value_size - reg->off, false,
-				       ACCESS_HELPER);
+		err = check_reg_const_str(env, reg, regno);
 		if (err)
 			return err;
-
-		map_off = reg->off + reg->var_off.value;
-		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
-		if (err) {
-			verbose(env, "direct value access on string failed\n");
-			return err;
-		}
-
-		str_ptr = (char *)(long)(map_addr);
-		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
-			verbose(env, "string is not zero-terminated\n");
-			return -EINVAL;
-		}
 		break;
 	}
 	case ARG_PTR_TO_KPTR:
-- 
2.34.1


