Return-Path: <bpf+bounces-59306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23114AC8161
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05359E512D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1222F39C;
	Thu, 29 May 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S85SxyHK"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983422DA10
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538056; cv=none; b=M8bvzMUnqYUrwiDQ1imWKsLOEyd3Tz466Dw/VW66cszTWEASr5IiR2GL3eeRkdAHnKytVt/QX3QB54P6YMLWFZk8fQOnJqDHQ3fhIba4X49HMiOqsl3JFvl7Y9UkCE0pGTGkRqJ8Da3pPZBFdd+M83S/vF90CYbog3a+TSk7gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538056; c=relaxed/simple;
	bh=uPum7yv/dAZtpDFCqHdVSBCWZGxdW+YMTMLQT39qaE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XG8WAPT4Rxudzyyg2vhm4fymiW1NasrYi4Kf9ahVIa97RcpPvw/tO6LZRVx9YqSWkGTadloTvFkiqHOT4rJ9uFFq+/Rj4bPJ9FxInff5GPUqTaCI9qfa/Lgm3tEeVWADZoTuyPgvfeW5+sVdSm+1eRZ67uRFGgIlEOFPBvaFw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S85SxyHK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748538052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2Db6aTs76/+FLLSB4vYJtBNL4/EggBTobsksTp3ywQ=;
	b=S85SxyHKQ8gBkcwFuzwNP9qt3xWEVGNReKP5S7NC0ua6BVQAs9DgbVQavl6/zBGnTY29WR
	tQ8aDJyMBSNn3jt5fYeWAWx4EelopbU61jDKGFrF4mI45uQzvHEzSg+0ROmSOV3HQcEycr
	R5a14Tdd3OfqvXVPygJmzQaSkuuQOKU=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next  2/3] selftests/bpf: Add cookies check for raw_tp fill_link_info test
Date: Fri, 30 May 2025 00:57:58 +0800
Message-Id: <20250529165759.2536245-2-chen.dylane@linux.dev>
In-Reply-To: <20250529165759.2536245-1-chen.dylane@linux.dev>
References: <20250529165759.2536245-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add tests for getting cookie with fill_link_info for raw_tp.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 6befa87043..0774ae6c1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -635,10 +635,29 @@ static void tp_btf_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
 
+static int verify_raw_tp_link_info(int fd, u64 cookie)
+{
+	struct bpf_link_info info;
+	int err;
+	u32 len = sizeof(info);
+
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "get_link_info"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_RAW_TRACEPOINT, "link_type"))
+		return -1;
+
+	ASSERT_EQ(info.raw_tracepoint.cookie, cookie, "raw_tp_cookie");
+
+	return 0;
+}
+
 static void raw_tp_subtest(struct test_bpf_cookie *skel)
 {
 	__u64 cookie;
-	int prog_fd, link_fd = -1;
+	int err, prog_fd, link_fd = -1;
 	struct bpf_link *link = NULL;
 	LIBBPF_OPTS(bpf_raw_tp_opts, raw_tp_opts);
 	LIBBPF_OPTS(bpf_raw_tracepoint_opts, opts);
@@ -656,6 +675,11 @@ static void raw_tp_subtest(struct test_bpf_cookie *skel)
 		goto cleanup;
 
 	usleep(1); /* trigger */
+
+	err = verify_raw_tp_link_info(link_fd, cookie);
+	if (!ASSERT_OK(err, "verify_raw_tp_link_info"))
+		goto cleanup;
+
 	close(link_fd); /* detach */
 	link_fd = -1;
 
-- 
2.43.0


