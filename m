Return-Path: <bpf+bounces-40309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E73985FF0
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1311F21DBA
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2A22D730;
	Wed, 25 Sep 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwhi87nC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BA1BA27F;
	Wed, 25 Sep 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266689; cv=none; b=NxVZuvIJtROO+W/rq3zay1Xi2kiccZHpEVlbTNmpYT0Ax+svrsHOXGcO/q+2Zp1gVmwq3xM7VVi0STscIoWG98U9Z7gl6TEhDMaF9T2sgAjM6nj5sVTMLNb+WlYI/vlmOyAC73Khpenk9V+Z9vQ5fHveU4STtfTzxRH+hIpifRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266689; c=relaxed/simple;
	bh=IVhzTf/i6sKHDHhMn++HReGMeGNvP7ugazgPhMwmERw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc2sSed8D6wjnQKgyQ5TCiRDvlXZc/jS7UIWdRIik0/bUPizyEJThh2RMoMcgXdqmrkRnisoix+VMQqP30pjBQ4Ekfbor0O7il67OulsD6F/PfMDZKR1ex3YJr8I7XXONYMF9YYIBzmxuHS8FirJXkig7y0QufLHVH9oDY6TuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwhi87nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDCC4CED0;
	Wed, 25 Sep 2024 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266688;
	bh=IVhzTf/i6sKHDHhMn++HReGMeGNvP7ugazgPhMwmERw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwhi87nC3HYzJRlFNj3yvOKDznUPMRTRM+Y/xgVLMO0x847Cn4+bhnjgy4b3AcLvq
	 YJ38leBggwx24eYEYbTTUn6O4M31lGphuNdjwBnxZAC/pSpjXt/u8J1355+tG74sia
	 e58CuPel3sCBktS8NMY3vhUhVSU3Sh9NsvQg0N39dUFKM8iNeQZC+9XPXzFe+D1Woq
	 Y/zx9vs28MgERwcsQxG76IyLXG700nB+gQM0J6yEhRs1d/1ELI73Cx0ewMNv2ObaYM
	 tLNDKFSFHSpp4w1NfGiUOnsa3OAmppoo3wfdhUrGHKgi+UhOGinewebv2/Rjgp6q/C
	 NM+Qw4xq1DtBQ==
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
Subject: [PATCH AUTOSEL 6.6 139/139] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Wed, 25 Sep 2024 08:09:19 -0400
Message-ID: <20240925121137.1307574-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index fd54ff436493f..28e9417a5c2e3 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -819,6 +819,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_info)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
-- 
2.43.0


