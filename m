Return-Path: <bpf+bounces-79544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA71D3BD86
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC62302EB3E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269F2367D9;
	Tue, 20 Jan 2026 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGdfmv00"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D122097
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876382; cv=none; b=GiBIu6lnGDWc8u/5PwKySkC9Jz6lwl4/PKhacHXLb83c4LlLsXbJgTEorkEpMIXDqk08q8kzV1R/cv6Gkd9erQcbGn9/M0gV6n8HiOcLU6sYlVsx4+SzK3OifschtsOGGTdJgTxq1KaQX0aUG2OAwTh+6p4x2NLOmLURpTNGNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876382; c=relaxed/simple;
	bh=0pO5NHg2tWVLPnYLjzKpH7rb3sfTc7EZr3CvxnF3R/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnfbYo/lYVyEz/CwfIJVj83oP30bxwMrMF9UakrKUaE3ndc9ytw+yyWK8XGy/bnG/UITMmE/DDrlUEn38n4/Hy8xxjxJstzO4Z00F7M3dUoHepKJHLN+17tSE2UrUEQWhdghA7OCii6C76yhIwuLZptLbug8NlKsOmRtJzBZNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGdfmv00; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso4711451eec.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 18:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768876380; x=1769481180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYn6FnuXxBibHJ3eOFTCVQgiio18LIIZJQ0lPuD1ZUE=;
        b=OGdfmv00rZ2DXWfDleionFDR/cMMMfRVRnZtWlr5QFhfJwNcbXCZEuX+ItFQ8s5TMc
         HbP6rlgr96+L+VKo3q9T3eGPnVvGToClRztTmCXoZEtNE93cUAwX3HVZP/2HcSvw+gsf
         5R6njM5h7wjpSyzBF41EX6uwQVgMcAh4pmMhc5N+t9xovjj+ro0V8eC/L+ErHmOToyC7
         ewvx6cuonqsR553rjMf+hy4VCplrj09C6N4tQQ47IALBk72dm9wFavWYkzchYVRO+mRN
         ttKx5ETqfaGX+T/5XtMuBaZ5BQ21X38pK3N5Vgm74pAVviGXq+c0xSBoNe2OD1tctqk7
         VlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768876380; x=1769481180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYn6FnuXxBibHJ3eOFTCVQgiio18LIIZJQ0lPuD1ZUE=;
        b=NiLxZMykhfnidieuO7/tSfHV/M2Ay4MjgYBJwGCWMfLCEePaEnMTOGA1DpDsAmGpH5
         hwauc4yJ5fxgHohU3KRnDDa/tAblb6girofHNv557K31NiMQcKhOf5WUDZ5fPVWGg9Ky
         iK+YBfhoo3NgxarU7rxkAX5fae8hGUwqA5tTbFdqKsDS6kj61REfsy85sfFW2WP4hkgk
         mfMgQ4PfCykZIaZqJ1tqwld/HvSGVpQ6+xGNZzhbGEPQ0cDDlABE/9P3d16l9HgtDD9B
         qr/RuyIDTM6Yi5m1NmcRPfAH/luQpldkrzVn26z421iIP+mNSeZ0xRQaCTohTh72dbtb
         thfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtx4aB4riP3MhgRZ1SHRG+3QGPOWfgxUSrADoq/JzuByx39IZ7SgWp14rVPwK95Cm8ars=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CKjfG8aFkiWlyjgi1F4h1I4WLKr7JRdbJo5QdAiBhxMjSPvu
	dmj2O1yfktKiTkGIg4kEPJNpl0Yc5qOArNLDgr2PymrzLvP2VUPe0o0L
X-Gm-Gg: AZuq6aKuSkrnovOESFwGY31WY8HJ3IvOcHul3NEtMDjVlPTLyqT0R0b+KyYhTEebmXk
	xSNJn5CekTmZnSeeJhqsMh+vs2vMvH8mivm8vqvDzOoSMAVOPdNCl0V/w2bomn6KEyFkT23sCx7
	/ZwDVaqYraEcRCfUgxKlH3r3ojTuHjQK7SaW/J6uHuM9i5TRxasw2C6Q58vHnPI2QkUVc0sWQ+B
	Nvk5RoCDEbbaexaSbVsSwhgcaR7mQCg1gE19JovZwkkaThTtH/l/h6MrvkNVHg5DG1tKL8yjqyB
	cjoA5KjOD5mQvswudjf0ef+HDdAJzT68JcXIk4K86vsqxEdUidKkZOT+9z5ZawnIys2E7ckU95E
	q/coRfCIBwl2eXcC0SZckvw5q1ZhsAijwT4er/5/FoD6D7gmlYUhQq9S8pYiaZbw/q3vOkSwyiG
	BuPkF/L1FOBq3bFyXzNgykYG0=
X-Received: by 2002:a05:693c:3002:b0:2ae:4fcc:7e98 with SMTP id 5a478bee46e88-2b6fd61757amr282174eec.17.1768876379756;
        Mon, 19 Jan 2026 18:32:59 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c56a23ecsm13103430eec.11.2026.01.19.18.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 18:32:59 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: alexei.starovoitov@gmail.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	realwujing@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v4] bpf/verifier: optimize ID mapping reset in states_equal
Date: Tue, 20 Jan 2026 10:32:34 +0800
Message-Id: <20260120023234.77673-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAADnVQKkDCNB5xk-gnUWXJ44LqG0gRaHfE5WjbAwZL-vnV+6oA@mail.gmail.com>
References: <CAADnVQKkDCNB5xk-gnUWXJ44LqG0gRaHfE5WjbAwZL-vnV+6oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, reset_idmap_scratch() performs a 4.7KB memset() in every
states_equal() call. Optimize this by using a counter to track used
ID mappings, replacing the O(N) memset() with an O(1) reset and
bounding the search loop in check_ids().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..8355b585cd18 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,6 +692,7 @@ struct bpf_id_pair {
 
 struct bpf_idmap {
 	u32 tmp_id_gen;
+	u32 cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..6ec6d70e5ce7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18948,18 +18948,21 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	if (old_id == 0) /* cur_id == 0 as well */
 		return true;
 
-	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
-		if (!map[i].old) {
-			/* Reached an empty slot; haven't seen this id before */
-			map[i].old = old_id;
-			map[i].cur = cur_id;
-			return true;
-		}
+	for (i = 0; i < idmap->cnt; i++) {
 		if (map[i].old == old_id)
 			return map[i].cur == cur_id;
 		if (map[i].cur == cur_id)
 			return false;
 	}
+
+	/* Reached the end of known mappings; haven't seen this id before */
+	if (idmap->cnt < BPF_ID_MAP_SIZE) {
+		map[idmap->cnt].old = old_id;
+		map[idmap->cnt].cur = cur_id;
+		idmap->cnt++;
+		return true;
+	}
+
 	/* We ran out of idmap slots, which should be impossible */
 	WARN_ON_ONCE(1);
 	return false;
@@ -19470,8 +19473,10 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
-	env->idmap_scratch.tmp_id_gen = env->id_gen;
-	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+
+	idmap->tmp_id_gen = env->id_gen;
+	idmap->cnt = 0;
 }
 
 static bool states_equal(struct bpf_verifier_env *env,
-- 
2.39.5


