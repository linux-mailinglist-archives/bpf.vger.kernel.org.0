Return-Path: <bpf+bounces-29445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EAF8C2177
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 11:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5327E1C20C92
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3A165FA9;
	Fri, 10 May 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="htYbeuAc"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B316D4D2
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335109; cv=none; b=WFxltGVBU1+xkxgDtO+txxyrRLpBa1joNhFEvZkuSdJDyB6nS0MgLKKTskdbaP5vPf+83PJruAn+EXYK20lLZ1li3TwTv99jGL4cFumZUUZp/hLr9ipDbt1hxA5dXzQO+ExA//Lr7Hk83C4m/zGDFW3oZ+cC4CxXxMzA/g7NJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335109; c=relaxed/simple;
	bh=z9zdge8Uw/xViOY7Q1RU4YYXc81cHoFE1Mhbnb/H+ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eliv/vyX832C7kE0gQu8i6ZqlUKeddYGSZ4QxxOGfAPiUROvA+RDCwxsSriKtRWYsi1C3ap3IbyC9hJCHRK7XLLd2WHNQBDwYZ+psWdbyCAY6vUtSOzvO8qT5PjWHFmMqM52T7i6TLiYLQL1T7OQnVgtni0cu1sbGLFrTfVRIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htYbeuAc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715335106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z20fNZGFCqGAeDIBxhPRlb7sk072IN18zBHdKwtlyTE=;
	b=htYbeuAcAhLYNZklnby0O8snwbvSM2rqf1jrXvpgaHB0B7rL1lgx3uw05t7RXWYKXc7NX3
	2/e8C/A6UqN+4iHfcgVshknDf93Z5ZB6T0zQ8Uokd4RvTf/UC8hsL0YKNZuOmNDaqT5GBg
	WgEAowPbAmYACMAdheVLgSjQoSU+TIU=
From: kunwu.chan@linux.dev
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf/sockopt: Add a null pointer check for the run_test
Date: Fri, 10 May 2024 17:58:01 +0800
Message-Id: <20240510095803.472840-3-kunwu.chan@linux.dev>
In-Reply-To: <20240510095803.472840-1-kunwu.chan@linux.dev>
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

There is a 'malloc' call, which can be unsuccessful.
Add the malloc failure checking to avoid possible null
dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 5a4491d4edfe..bde63e1f74dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1100,6 +1100,12 @@ static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring)
 		}
 
 		optval = malloc(test->get_optlen);
+		if (!optval) {
+			log_err("Failed to allocate memory");
+			ret = -1;
+			goto close_sock_fd;
+		}
+
 		memset(optval, 0, test->get_optlen);
 		socklen_t optlen = test->get_optlen;
 		socklen_t expected_get_optlen = test->get_optlen_ret ?:
-- 
2.40.1


