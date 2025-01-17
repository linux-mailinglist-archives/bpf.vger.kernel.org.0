Return-Path: <bpf+bounces-49143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E6A14710
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD627A48E4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716325A651;
	Fri, 17 Jan 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRUUK4am"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF71096F
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074400; cv=none; b=T4uyUTO28aH1Nr6RX89yzN5BeyviIE4Fqi8e9h9iY2tOI8yYs2pkhFw9gzgEoZP0X83Hg70xn4SNT7Wbi7EoRwl+Q+CjIz5p0Poqv+BLD2kpFuNi/pk0maUYpKR5RZ+Gs66OPC/WGjS9DxXwsqPM8zYb8r6x3yyFxaT1QT54HCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074400; c=relaxed/simple;
	bh=GhhDAilcuy3C0rMr8h7/Fn0ivVTNi7BQhAp9Uq51pec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTeJ1Q2x3H+bH3Pys29ieFikRO0hMdvulAFDVyxCGmXJKmYUuiA/73tQHPW6BwhtfoFtMha/eH/UAnXJgb/Vkzhfth/+orEr9B5//yhJgp5g/77o3b9oJcf69Wh+QlcNd9hM6R6vCmNJB+JMACTKxFBUrOj3WmxWPZLX0HWYYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRUUK4am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D695C4CED6;
	Fri, 17 Jan 2025 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737074399;
	bh=GhhDAilcuy3C0rMr8h7/Fn0ivVTNi7BQhAp9Uq51pec=;
	h=From:To:Cc:Subject:Date:From;
	b=hRUUK4ameu4IrvAfEbhbzLFvrjFlkHq2Nd9gpU/CYEfIq0WfJD8iYIs5q6jqAaDc/
	 eSE7RmaNX/xsK/GTvx/bURvEa6nbdhkyhpLRe+xQClNJYTZwYikRu6DSj9qIXHeufW
	 8Kl9RVpkXJ1lsqcKOmMtrWvSsJDGmF+1sOQrxXSIbzWsFVSZ2NTMHOAFddcd4OyWOX
	 tmjeRC4M7UqOWbqOu9n2IAxauYkrsVjtjQ9TZQg+dRT9RmoPYs6PExvHy3UIO0Yqo7
	 3LCVbz/jt9Kb6iasVJzWe4Zm/ia6mlT8oG1Dt7K1M7bQqXahwxZcrQ2gOmJ1ZMvBjF
	 eJ5uEixWWdE3g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: work around kernel inconsistently stripping '.llvm.' suffix
Date: Thu, 16 Jan 2025 16:39:57 -0800
Message-ID: <20250117003957.179331-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of kernel were stripping out '.llvm.<hash>' suffix from
kerne symbols (produced by Clang LTO compilation) from function names
reported in available_filter_functions, while kallsyms reported full
original name. This confuses libbpf's multi-kprobe logic of finding all
matching kernel functions for specified user glob pattern by joining
available_filter_functions and kallsyms contents, because joining by
full symbol name won't work for symbols containing '.llvm.<hash>' suffix.

This was eventually fixed by [0] in the kernel, but we'd like to not
regress multi-kprobe experience and add a work around for this bug on
libbpf side, stripping kallsym's name if it matches user pattern and
contains '.llvm.' suffix.

  [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c262d0152f8..194809da5172 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11387,9 +11387,33 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct kprobe_multi_resolve *res = data->res;
 	int err;
 
-	if (!bsearch(&sym_name, data->syms, data->cnt, sizeof(*data->syms), avail_func_cmp))
+	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
+	if (!bsearch(&sym_name, data->syms, data->cnt, sizeof(*data->syms), avail_func_cmp)) {
+		/* Some versions of kernel strip out .llvm.<hash> suffix from
+		 * function names reported in available_filter_functions, but
+		 * don't do so for kallsyms. While this is clearly a kernel
+		 * bug (fixed by [0]) we try to accommodate that in libbpf to
+		 * make multi-kprobe usability a bit better: if no match is
+		 * found, we will strip .llvm. suffix and try one more time.
+		 *
+		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
+		 */
+		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
+
+		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+			return 0;
+
+		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
+		 * coercion differences and get proper `const char **` pointer
+		 * which avail_func_cmp() expects
+		 */
+		snprintf(sym_trim, sizeof(sym_trim), "%.*s", (int)(sym_sfx - sym_name), sym_name);
+		if (!bsearch(&psym_trim, data->syms, data->cnt, sizeof(*data->syms), avail_func_cmp))
+			return 0;
+	}
+
 	err = libbpf_ensure_mem((void **)&res->addrs, &res->cap, sizeof(*res->addrs), res->cnt + 1);
 	if (err)
 		return err;
-- 
2.43.5


