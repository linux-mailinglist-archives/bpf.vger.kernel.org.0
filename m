Return-Path: <bpf+bounces-76111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E079CA807F
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E19143045241
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4D333434;
	Fri,  5 Dec 2025 14:55:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9863321BB;
	Fri,  5 Dec 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946521; cv=none; b=B7AR2Ki2Z9zOYouq/05Oj8qYAcEn43UAfkYF010rqKiXbP/dLbWiLN11AL5udv2NNBZSMBaPCPHcWE2mbdlixwxoZry+gUvy+3oaFR6MX0ma8q3Fuu1nO+2qr66mQczn5EWDy/KTD05JTjJs5fUf1mSB5SINh8pvPvvcrSxJSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946521; c=relaxed/simple;
	bh=3SVo4KltT5zARibswhVjRpCnw5g+Ckij9RsDBfvJtjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPwS4Yi3//TIRKbS9tJXUTXEDTenAq4ZA7EK/MLwiPMBscgIEWdjtHmA13ocmwe5zneKP+VcfRj5138KBTHewyjn789gApnSbm1o1mg9OpNkXIcj8LsLZt10oVU4RFdPfsFTfYRIGM7wAgd2U8cjYsZoNQ4GY7ftXGk+YsAguwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E8C01758;
	Fri,  5 Dec 2025 06:55:08 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B4013F59E;
	Fri,  5 Dec 2025 06:55:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] bpftool: Fix build with OpenSSL versions older than 3.0
Date: Fri,  5 Dec 2025 14:55:06 +0000
Message-Id: <20251205145506.1270248-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ERR_get_error_all() exists only in OpenSSL 3.0 and later. Older versions
lack this API, causing build failure:

  sign.c: In function 'display_openssl_errors':
  sign.c:40:21: warning: implicit declaration of function 'ERR_get_error_all'; did you mean 'ERR_get_error_line'? [-Wimplicit-function-declaration]
     40 |         while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
        |                     ^~~~~~~~~~~~~~~~~
        |                     ERR_get_error_line
  LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
  /usr/lib/gcc/x86_64-alpine-linux-musl/11.2.1/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/sign.o: in function `display_openssl_errors.constprop.0':
  sign.c:(.text+0x59): undefined reference to `ERR_get_error_all'
  collect2: error: ld returned 1 exit status

Use the deprecated ERR_get_error_line_data() for OpenSSL < 3.0, and keep
using ERR_get_error_all() when available.

Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/sign.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b34f74d210e9..c98edd6d1dde 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -37,7 +37,11 @@ static void display_openssl_errors(int l)
 	int flags;
 	int line;
 
+#if OPENSSL_VERSION_MAJOR >= 3
 	while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
+#else
+	while ((e = ERR_get_error_line_data(&file, &line, &data, &flags))) {
+#endif
 		ERR_error_string_n(e, buf, sizeof(buf));
 		if (data && (flags & ERR_TXT_STRING)) {
 			p_err("OpenSSL %s: %s:%d: %s", buf, file, line, data);
-- 
2.34.1


