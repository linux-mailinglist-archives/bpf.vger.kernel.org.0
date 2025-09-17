Return-Path: <bpf+bounces-68617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F214AB7C7E3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7191B225D2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F426159E;
	Wed, 17 Sep 2025 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugsjveQb"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C783DDA9
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080907; cv=none; b=ECAVIZGRfslHE01tFZ5Qaus3aZMSNn1kpJzCiHc9oMUTSFENtwkbTAevRcn0eNwiEkXZIag0wBeIG4hEnoiHrAEQvO0vMOiAabitZtD6GQKlDZKuGiyyXWxsf2iTYt3F+IaVe8TCgSzve04e3+Drg1LiiEf6x6+iIvBdpe4eX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080907; c=relaxed/simple;
	bh=jq20iTS9jVDOxoWT+gH+uIIPrVQif5ioi/5KQckDVBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbkdDGrVWsW+xjnBb3/4AZoa4Wx0PLCqLA5clXKYHt3iCnDvE1m1s+UPwLGFBmzevKaOaGfXSYkSdi0rzvVaBM15USsnIjaud4cLK2kJIHhwA8WkmCFe/Z0TpnKWccaKb/nF1bwAQE98B9VlhN7rNLOl4tqybEPoh1R28tcqYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ugsjveQb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758080902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOqw7V8ruMiVBd+YRR7oKYroMTd+7ZOnIXwfeZfS4uA=;
	b=ugsjveQblY1hC+zm3yC2sABjTr1iU9lCuGcKyKNCT7LbL0tnUE5GG7jBk9Ou0lPRhRd/F4
	wQHJe7bqSvqHKy/THEL9CPpD2LpAF1gq5/MmxxZ4NiLPGa2BsGTBnk6jG7YKj4UfOKV12Q
	Od2FYhOS6LtqFEORoRg+v3RO5BgyMd4=
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
Subject: [PATCH bpf-next v2 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Wed, 17 Sep 2025 11:47:31 +0800
Message-ID: <20250917034732.1185429-1-chen.dylane@linux.dev>
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
Acked-by: Quentin Monnet <qmo@kernel.org>
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


