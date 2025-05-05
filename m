Return-Path: <bpf+bounces-57397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17389AAA4EC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817221B60A12
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C006305F37;
	Mon,  5 May 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjVdFHkB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36428A1E8;
	Mon,  5 May 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484081; cv=none; b=vFr+hg4MaZSfmOJrIy2lGdkjMiOuQIzEtQ01pdIfvkg2lQTORV4Iiitloswwdsg4VqaHyzcLEjHBh8ow/e//7N1mWYiWevr677kdUBPUB0zuoqgILZGepeL2MIsU3II8lM3GLPhdCsPVbsMYUbYlgGfMkQ49ZvQSEbOlC78Sxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484081; c=relaxed/simple;
	bh=wttWyXaQxRhpbHgkxP0KWBPlqCAEhUh8aI7oF4j4C88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJjLYAkxcFo48PEP4g8KerZsVftyBoUfbTbgUjEPBZcOTSpglJJB1GcfUrSK6Am9ON1gq0cLig8G7iO4m32MW2UOva2OeYztHhffcKgDKn7B5eZ8IzTWHTQms/C01+rG/JWT6pkydW9pGdGi0DeDtwY19NxOGfoJbBXHj/Msktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjVdFHkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C08FC4CEED;
	Mon,  5 May 2025 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484080;
	bh=wttWyXaQxRhpbHgkxP0KWBPlqCAEhUh8aI7oF4j4C88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjVdFHkB+xHwQgBkY+1CSP+lW0Bncd4Oub8L8hOA+d0UdxcSPeN52Ba8cuKICkx6T
	 Tkyb+MvNH5hknhX4d2Y+DQTTeHB/LOIC6b0TwSIlrAzQjz2wqU3I5oubA0fijMiseS
	 d5tw2WZQGzYxJDdGuUQdKft4WoUxG2Ict87a8mXFKaJwtkEkCwAoRrUXc16IWR1g9Q
	 IraGF5ayMYZzLXkkk9rkST0baOepoJNOZ1nncawcZnukokbJJ5ZlT3SU1KybLVAlXK
	 1GUvM3IuVQ/ozyAZxv1vRU5feb7BkyiLh5cl9nSCtmMqrh6jIw+gJ7wft2jlysKEg9
	 GK6dO6EMkEpuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 339/642] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 18:09:15 -0400
Message-Id: <20250505221419.2672473-339-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Nandakumar Edamana <nandakumar@nandakumar.co.in>

[ Upstream commit 236d3910117e9f97ebf75e511d8bcc950f1a4e5f ]

In `set_kcfg_value_str`, an untrusted string is accessed with the assumption
that it will be at least two characters long due to the presence of checks for
opening and closing quotes. But the check for the closing quote
(value[len - 1] != '"') misses the fact that it could be checking the opening
quote itself in case of an invalid input that consists of just the opening
quote.

This commit adds an explicit check to make sure the string is at least two
characters long.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250221210110.3182084-1-nandakumar@nandakumar.co.in
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b436ec872b0f..1791a12b1aac5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2106,7 +2106,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


