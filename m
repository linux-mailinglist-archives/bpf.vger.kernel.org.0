Return-Path: <bpf+bounces-63442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A685B0774E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4941C2718E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324A1E572F;
	Wed, 16 Jul 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K9HZao44"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082791D7E26;
	Wed, 16 Jul 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673650; cv=none; b=F5XW/esc+jsl415CIgvQon2zzmU0c6gMj9RxYYccfjYOudiarcu29nzxvdp+gPb0f/I61sWfX7tcdEgt1M7Q40wElLtEx9AuyR+XEVYsbCm/CoR7A4pMDhy7v6G21M6S4SjIAwi90zh9Q1nQ2F8Av1vaVl7jeq3IYcB0NMuDFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673650; c=relaxed/simple;
	bh=wV6AB4b15vzlnHpyXKLaORlUnvgaI8PNAU6JPGUkVks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6y1kzL2/9fGkB6cHpk24xzJ+SG2J3c/U2cv4ftjUTxxqeH9qJY2baJ5kPu/AykXAHiroQ0CMxETwV5K3aNxvOdiv5MB+xN4uZHsnDUCvAi0JjyeW9A6FjMtWNy0NbbzbL319PjyUipNX5T+91i5dYcQEHn2Vo4OE9qGk6jaN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9HZao44; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752673646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTbtrHDHNEb8o4OaDgUEPfHagRJTln/rm7XQuawnK0c=;
	b=K9HZao44phT8iUlvn1iaW5RRiahSS0TG/0mmstBTvQI+Dxj0ubVuQ2HqTWn/RptnbeeAIW
	bLXAoOg7QF1Vjij3uaZyqCfPGs0GB6pWb9e7uhbzEHaeNzOZ7c+cOQtspiC/XrR8NZ2tdq
	r3EMuYleYFJ73OmcfjZWchA1lkmtSvo=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 2/2] bpf/selftests: Add selftests for token info
Date: Wed, 16 Jul 2025 21:46:54 +0800
Message-ID: <20250716134654.1162635-2-chen.dylane@linux.dev>
In-Reply-To: <20250716134654.1162635-1-chen.dylane@linux.dev>
References: <20250716134654.1162635-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A previous change added bpf_token_info to get token info with
bpf_get_obj_info_by_fd, this patch adds a new test for token info.

 #461/12  token/bpf_token_info:OK

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index cfc032b910c..b81dde28305 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1047,6 +1047,41 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 
 #define bit(n) (1ULL << (n))
 
+static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	int err, token_fd = -1;
+	struct bpf_token_info info;
+	u32 len = sizeof(struct bpf_token_info);
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	memset(&info, 0, len);
+	err = bpf_obj_get_info_by_fd(token_fd, &info, &len);
+	if (!ASSERT_ERR(err, "bpf_obj_get_token_info"))
+		goto cleanup;
+	if (!ASSERT_EQ(info.allowed_cmds, bit(BPF_MAP_CREATE), "token_info_cmds_map_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	if (!ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_XDP), "token_info_progs_xdp")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* The BPF_PROG_TYPE_EXT is not set in token */
+	if (ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_EXT), "token_info_progs_ext"))
+		err = -EINVAL;
+
+cleanup:
+	zclose(token_fd);
+	return err;
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
@@ -1150,4 +1185,13 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
 	}
+	if (test__start_subtest("bpf_token_info")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_MAP_CREATE),
+			.progs = bit(BPF_PROG_TYPE_XDP),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_bpf_token_info);
+	}
 }
-- 
2.48.1


