Return-Path: <bpf+bounces-40987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2FB990BF4
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621961F213B3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8A1EF941;
	Fri,  4 Oct 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOIEdC4p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EE1EF92C;
	Fri,  4 Oct 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066131; cv=none; b=YT7NeosVDuMRY/tzq30fPnmp0C1/VmfUSYnc4qy9Gk9ewcYbZ+IpRbhQdYyY5XBzAtbwpJbZUZwFaauKjHFMnOI6Ops1kyU+HDiQDZr7HI26AjaVsAFYMaw1uQGCIKYk+5VQy9bav0+JVJbFcx4M8+nwixk8yjPOFQvnmij0VjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066131; c=relaxed/simple;
	bh=2my7iZVJrU4CA6w35Blro+3kSQHI5GlKSS8Rl/NZ5/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBNKlIfl2bmp/JF+kfS4Cmx/8BqVxnGDKEwgpWJSoD6rlJk5UUzf+z4+hYLD+v2uLQeqcXfnK5gBX0noTCx/qlJ6QKPhQBB9K6coAJ57NRkE8AQ/JaYAwQCHylD+XE3rDnyFl4UkA0bmhA+e3li0OB7UeCBN6paVg0/tkTtUXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOIEdC4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BF6C4CECC;
	Fri,  4 Oct 2024 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066130;
	bh=2my7iZVJrU4CA6w35Blro+3kSQHI5GlKSS8Rl/NZ5/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOIEdC4pMdQua7flGOIFJY/v1zfr4xegZ8l51h9+yvJ9zkpoqfHGRr8hzNms1NyvE
	 663HV8gbUrwCfZMCpJAuPTMWCZ0YFKtHCowmhC7PZAkRv7ZIoVVDk1fUN5X35H2nE8
	 kdnPtHw3Iezb3+XBKmDCWpZhlgk5uEylJDS1bthJjZRpvOJEUQ1seiSDBbS1pOiVcm
	 L2oSnsz/j6HFLrlJPOhbJiXdM+0aUjjLgXzzt6NEFYrWvvFib/wvb9dMHRwX2XEcfY
	 Oa4CJOHPJRJ2aezF6Nau559zuUOZlnmA8BZfMfh29Rji4kGdzk17vOi4MR53lnRVIs
	 XBzG/5fA6Kz4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/70] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Fri,  4 Oct 2024 14:20:03 -0400
Message-ID: <20241004182200.3670903-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit f04e2ad394e2755d0bb2d858ecb5598718bf00d5 ]

When netfilter has no entry to display, qsort is called with
qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
reports:

net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Although the C standard does not explicitly state whether calling qsort
with a NULL pointer when the size is 0 constitutes undefined behavior,
Section 7.1.4 of the C standard (Use of library functions) mentions:

"Each of the following statements applies unless explicitly stated
otherwise in the detailed descriptions that follow: If an argument to a
function has an invalid value (such as a value outside the domain of
the function, or a pointer outside the address space of the program, or
a null pointer, or a pointer to non-modifiable storage when the
corresponding parameter is not const-qualified) or a type (after
promotion) not expected by a function with variable number of
arguments, the behavior is undefined."

To avoid this, add an early return when nf_link_info is NULL to prevent
calling qsort with a NULL pointer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20240910150207.3179306-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d45..0ad684e810f34 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -824,6 +824,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_info)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
-- 
2.43.0


