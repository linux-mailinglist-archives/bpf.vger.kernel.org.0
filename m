Return-Path: <bpf+bounces-79059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBFD2513A
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECABE3052A9C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2A350A03;
	Thu, 15 Jan 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyQ8gMyl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CF30DEDC
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488600; cv=none; b=S3A1e4FlQczsygi2qIV8JO1Su68UTmC0I89kDm7v1KHT+2qft9w/0CMp3uyq5T3P8S5P8ypAG9Mu8Armkpyb5uXaH/KfNcHyfy9ne0qWpTMVkaUqFQ25UpTwsZ7PMic6Zb3Lc/rc6xzbp79ZcI88ZK0Rfly8TEyH3NAXla409Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488600; c=relaxed/simple;
	bh=RW55d/JaaWFpEiXYObuDlyFwRLauudhCxr+54ALHDYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JuwEunogbX1GHP+fLt8BC3p1IIQC4gW441wkKsd1anYABX/wvLlFnt6AUJRO0fF0tqs7WiZ+rxctd9PgGLsid+ODWG1e8ZtrSqqrAu1LbcJp//ResVLp3ollxOM69vKkXScms/RUmQJqb7cId/xk/soQI6QNZ0EQK7MhSqFtZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyQ8gMyl; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12448c4d404so166270c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768488597; x=1769093397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayyj+smXP+IDsPB6AjrrQ2LVZ2utyXTn+MR3JfEzhYE=;
        b=JyQ8gMylPaAYIOY4/qT6p4nWDBkdeOy2VIHh+5qj0ayVQKj4Z/xqnNJmIcYq6okHj4
         g4Ahl+4lG4Kp0xp9IePw5ifDP+pAeGLQqFPCW+xxz1f2mXa15LdYjqFztyf63pDMLgHd
         6WCZZNQxStKIjpViTD9dMTCAWUGAis3+SbDYFCsn9fMLS5KkYINpVgduS03vaHWZmeBi
         sXjfCunst5yJG43XGdVbsR5FoWXcm76IAdKkJ0mWBQ7xB6zbBDpfwIL/HpKsTCDJP1qE
         JxCl+BFhJsMRIaznGMeNy+nH4VovNRPltks69Nk7eqgBr+4A02FBWzB0V/XnXh8/BsEV
         px7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488597; x=1769093397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayyj+smXP+IDsPB6AjrrQ2LVZ2utyXTn+MR3JfEzhYE=;
        b=diqh8PfFcthL7qfpGTNcOI5+OxGekvlkklWi3uXmEesELQnKh0vE3t/JwSFFhgI0H2
         QVFlzKSk24dYY2o4aaezK3QGMvkj39GlIVyFig/i/tpVMXrZqLi/eYDM1yQmGschDKrB
         VaJTCoJZYtv5H0iKmFnkOTBvp0rX1EkqsF9D7tWqRDWlTZivf+79BScSpJ8r5gFC9Cjj
         m3YqlDzUP8TSILsacCy1pShXx5cDNF0egvjq8pxt/EPd2wh7X2mn30dfQz8Oa98+BC0E
         a/wyG66MLdfcIWRMquvrIt2/sSO1pO42PqD89m31HwuOpYLweuqazcqpeSguFW4aHSTY
         0/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW/EZAOJ4paLY1X4CdtiakCMmM8za0OclAoyCfze/L74Q/B+xCgrhkCF0kplE84Ee4mLHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZ/WemdlJdKzO8ztixse+soUSHEEVF2PUUlRDfJhmZBUL7PEH
	kvWX9xsgyDzkz7Hc0PSGmHMU2maACTvU7iNqDayp16OqPtDP4XICca0S
X-Gm-Gg: AY/fxX5L1VjJocToKkHo21o7yBZN15606pF/+BN9CElhooxS4TETHyVRhFMyV6I3i6a
	XDfKqj+sgU3DYGh1HbyDLAVcQtYn8c5H01sHbnTIQi9gH6w6H6wVPzdFPtKwB9ZCWiYrMA+Iv6U
	RMgNDMKmE0lCZw3RS6MPZl9gclKaz7NJhPiq4B3/traCelDs3vWh8tHHg7nNjf3di7T826fndRI
	Bx7b2kCRZxs9nuA1zvp+V/57wnFnYqzJ/Z1xv/XrLFjLwF+FXZvaJz+mfpUq88fQ9Vl8vgdixqS
	LTj+hw07RlwS1knUbJQCJ1mlJV9gXGMVr4fQuG0Y7wtbLdFCAnNGNUigaybGCcopttZSr23JzFC
	9QN+iEFrBGFX20qZeffR4rL5MwyUcVhlMu8oSpMJ6GYlV4ai74WaQAuL5L0Oj+JJMk3KgV+9gQ8
	Q6XPdcOCy8HXERv4oIGnUW3oc=
X-Received: by 2002:a05:7022:e889:b0:119:e55a:9bf6 with SMTP id a92af1059eb24-12336a4514bmr5934658c88.18.1768488596841;
        Thu, 15 Jan 2026 06:49:56 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24985d1sm33835539c88.16.2026.01.15.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:49:56 -0800 (PST)
From: wujing <realwujing@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] bpf/verifier: optimize ID mapping reset in states_equal
Date: Thu, 15 Jan 2026 22:49:46 +0800
Message-Id: <20260115144946.439069-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier uses an ID mapping table (struct bpf_idmap) during state
equivalence checks. Currently, reset_idmap_scratch performs a full memset
on the entire map in every call.

The table size is exactly 4800 bytes (approx. 4.7KB), calculated as:
- MAX_BPF_REG = 11
- MAX_BPF_STACK = 512
- BPF_REG_SIZE = 8
- MAX_CALL_FRAMES = 8
- BPF_ID_MAP_SIZE = (11 + 512 / 8) * 8 = 600 entries
- Each entry (struct bpf_id_pair) is 8 bytes (two u32 fields)
- Total size = 600 * 8 = 4800 bytes

For complex programs with many pruning points, this constant large memset
introduces significant CPU overhead and cache pressure, especially when
only a few IDs are actually used.

This patch optimizes the reset logic by:
1. Adding 'map_cnt' to bpf_idmap to track used slots.
2. Updating 'map_cnt' in check_ids to record the high-water mark.
3. Making reset_idmap_scratch perform a partial memset based on 'map_cnt'.

This improves pruning performance and reduces redundant memory writes.

Signed-off-by: wujing <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..562f7e63be29 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,6 +692,7 @@ struct bpf_id_pair {
 
 struct bpf_idmap {
 	u32 tmp_id_gen;
+	u32 map_cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 37ce3990c9ad..6220dde41107 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18954,6 +18954,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 			/* Reached an empty slot; haven't seen this id before */
 			map[i].old = old_id;
 			map[i].cur = cur_id;
+			idmap->map_cnt = i + 1;
 			return true;
 		}
 		if (map[i].old == old_id)
@@ -19471,8 +19472,13 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
-	env->idmap_scratch.tmp_id_gen = env->id_gen;
-	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+
+	idmap->tmp_id_gen = env->id_gen;
+	if (idmap->map_cnt) {
+		memset(idmap->map, 0, idmap->map_cnt * sizeof(struct bpf_id_pair));
+		idmap->map_cnt = 0;
+	}
 }
 
 static bool states_equal(struct bpf_verifier_env *env,
-- 
2.39.5


