Return-Path: <bpf+bounces-46009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD239E25B8
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917B228884D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4ED1F76BA;
	Tue,  3 Dec 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rjof7PK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010E14A088;
	Tue,  3 Dec 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241840; cv=none; b=CYDpCWAe6h1/b+PdPpiGVQ1GP+BEaQl3LNqYtlM+zyr877ONZxnnzIpue0n011EsJDFmaiIXNvoMOOsQEMwGqN8Y7z7ZUQ5FToJs/5tMAW2LZ1IytJtiYEncEhRIrwmkhhJMzf0YwiR877qz7XdrwjEvJqSe9OXaEW0WN/7cThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241840; c=relaxed/simple;
	bh=SzIDSIb7RmP229wG289IoXZ2fkN9qxqdL3/iLNru0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkXiX6T6KXUg3RS5q3qcSmoh6NVsD3qDUywiHwHHC2u/lFtrtaaM9tNMKolJzlBZwtWYccRCF2STgozORWEAj8gZ2FKbOzU5xnjCL/7AS1OoCJv/iJXuoKKWgxX50XJF/BzU9zyVc51mT0Ar7fhdjowEJEh1l9iyQh8Ok61r370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rjof7PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F44FC4CED8;
	Tue,  3 Dec 2024 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241839;
	bh=SzIDSIb7RmP229wG289IoXZ2fkN9qxqdL3/iLNru0vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0rjof7PKvW2LnzRyESqsk09rQIe6owI4MbtslPXDu4MBEJF08fgjt6FY20Zd66Zgw
	 ircFDU1PYE4wzXgeKe2hgQZN1eYW1KBm/QXk4otIwMC0HKkE8zyABMhOfoOHZ4xTdq
	 q2T3AfTeg/jlrKiq2pw8KU1PThOL0UXkERjmDsWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Ge <gehao@kylinos.cn>,
	Namhyung Kim <namhyung@kernel.org>,
	hao.ge@linux.dev,
	bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 532/826] perf bpf-filter: Return -ENOMEM directly when pfi allocation fails
Date: Tue,  3 Dec 2024 15:44:19 +0100
Message-ID: <20241203144804.507539868@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit bd077a53ad87cb111632e564cdfe8dfbe96786de ]

Directly return -ENOMEM when pfi allocation fails,
instead of performing other operations on pfi.

Fixes: 0fe2b18ddc40 ("perf bpf-filter: Support multiple events properly")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: hao.ge@linux.dev
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20241113030537.26732-1-hao.ge@linux.dev
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index e87b6789eb9ef..a4fdf6911ec1c 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -375,7 +375,7 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	pfi = zalloc(sizeof(*pfi));
 	if (pfi == NULL) {
 		pr_err("Cannot save pinned filter index\n");
-		goto err;
+		return -ENOMEM;
 	}
 
 	pfi->evsel = evsel;
-- 
2.43.0




