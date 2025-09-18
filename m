Return-Path: <bpf+bounces-68775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A6B84838
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1921C83698
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC72C3254;
	Thu, 18 Sep 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/lAz8a6"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA82C15B1;
	Thu, 18 Sep 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197372; cv=none; b=SSy4Tp+k3ZAfR6IcezNRtdiR7MeYYcM7HCrn8CVGE6clL32hzab0n91vPJNO/sd/MPOUTi9N44E+Ezx9JBn3ERD09Bxkg9IzU0h5F0NZ5VrRVX79cqufU1InIxHn8TfzXQKvb6wjiWZzSzqZkWScUrfr7aixEKT4mOiwOwma9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197372; c=relaxed/simple;
	bh=Pm+a6Q7xpNIHOKWIzc/xndugAQgcN6yfZuDpYSlvBCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oI+wbLV6OHC7qToV8XV12CjdXOJD9JmTCAWTWBofRhqK0AfvQws8NQ8yAp9Q26CrE83flHSmptFYJ945lQqo5zAb/BDgKjz/n8NPNODK43O3kMiJcU1dSbyYdBW7H8wwYJJmayMasveUcpk0gVdiNHhmPhEKT0Fnx8RzQoIsk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/lAz8a6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758197366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C8KiQcQZe7L3hdXFWlg9zHWgPeNnbXvSaHLe2wFAz6g=;
	b=W/lAz8a683L/StYl/EkGk74TfqBJ10hbPAr2+QEtyV6UJ1gYv/5lIMd/LFp4s2uY91/6mM
	BXHB6aiMWZ2o39KPG/y7WNTdSvtX0DGTACFtHeqZQftwLmPDh3tLZs73R8zmI29eXwuXgY
	TWLvt5mvKmChIm8g5FCF9w08QLRSAJ0=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	chen.dylane@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Thu, 18 Sep 2025 20:09:07 +0800
Message-ID: <20250918120908.1255263-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

$ ./bpftool token help

Usage: bpftool token { show | list }
       bpftool token help
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }

Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 1 +
 1 file changed, 1 insertion(+)

Change list:
 v1 -> v2:
  - strdup(mntent->mnt_opts) once per cmd/map/prog and
    remove another strdrup/free in print_items_per_line
    in patch2.(Alexei)
  v1: https://lore.kernel.org/bpf/20250916054111.1151487-1-chen.dylane@linux.dev
 v2 -> v3:
  - Replace PRINT_DELEGATE_OPT* macros with functions.(Quentin)
  v2: https://lore.kernel.org/bpf/20250917034732.1185429-2-chen.dylane@linux.dev

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 6312e662a12..82b829e44c8 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -206,6 +206,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list }\n"
 		"       %1$s %2$s help\n"
+		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.48.1


