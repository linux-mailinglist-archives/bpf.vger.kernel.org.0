Return-Path: <bpf+bounces-57453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CBAAB526
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C829173922
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E33464A6;
	Tue,  6 May 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FagQhk8S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EE284685;
	Mon,  5 May 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486989; cv=none; b=rTsN0VXvtd/cpMIlYfwD2JnOx//FpYBYGnSCh/uuB0Foa0tKHRKvJ0WRve5EK7W70uXnHOP50SRrZHhwCNAR/o8a1OdYWzrQcfRqkIkrnxIgZ3UkIgTDGwe7rb6DTU1e6ZBKp3UTCU8KQRSQA4HekuglHYW0ZXghhU+aNwamPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486989; c=relaxed/simple;
	bh=VShZx/OtOKuuvh06Jv/lzdqlqBzM61dEtJe8X10rhZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqedrXHrvdGJIWv4/Q5M7k5a09KyYpaeeg7K1H7SQu6bUF7FmKdx61/GoqeoVuM4nATiro1nNvD6qURUhMBf7Gjz4F9ZxII+1PTjQ7lm7WEWuUGx2ExF5MyYn7mnF8CurtAzzZP0YLFbhC/VmHzErxnvQNoGQUhLQ55BCv9SLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FagQhk8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62496C4CEF1;
	Mon,  5 May 2025 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486988;
	bh=VShZx/OtOKuuvh06Jv/lzdqlqBzM61dEtJe8X10rhZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FagQhk8SrXYkKyVJErsZdGeN7L+Q7RQ8UlbyL/BIWPoyZjD1PtqThfteBstsr5W2a
	 pqwbIOUzk4mpu+GLI9W3T4NGQBp2MqvQ+kMXArsbpf9OpkQl3N42S6xJxuN+xWRyAB
	 7tb5zzmcW8eLpPgJc9K1Su5A0fnbD4NvZxFWP4TeImP1wV0w1eY4Sf67NuQF+zGH/Q
	 8zTie9bVTjOwkHzYhMCSzxAAKY1MUjpTZlTDvM8x9Fxkl3GhjcykyXA/oWBE38HFwj
	 kgj2teTFMcPRFfmW4G3vJrpSPglKnJMDtAlQKL60b+I5CR3BQBGU6nGP6OMQ8o7e0G
	 RiD6Xxq0WO83A==
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
Subject: [PATCH AUTOSEL 5.15 093/153] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 19:12:20 -0400
Message-Id: <20250505231320.2695319-93-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 294fdba9c76f7..40e0d84e3d8ed 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1567,7 +1567,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


