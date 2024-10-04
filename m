Return-Path: <bpf+bounces-40993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E07990CDF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324152817BC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E21DDA03;
	Fri,  4 Oct 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoDweggm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC822216B0;
	Fri,  4 Oct 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066309; cv=none; b=MSoJRiQwevXBFWvaJrQk1x4yeM1rJARiV4V+t4hpyzevxjCup2RS8/Y7y6Fhmt0HiKD5aUsxNLde7Ntt+nZD1kbbkrUyEyY/2wGjpOYYBTTEAxoi8NxOVKBFFF5kcPG68LZs7oTfr59OS8DDuloAMqe7lnAlfkFTd8M4DsqnqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066309; c=relaxed/simple;
	bh=ztK4R81dI3iHycNWz9ngo8HvygWRn6KVN7cbIuZ/M7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHJ/KrbiRt8G+VfN0pJJmQP5YGFgHpmtmnn3b9pXj5gDaS5hMs8QR7uI/c1kuIg4OwD4a2FIvYkROKmwBjL3LrT4m0QqV56ydT+mJR/VvqVRLnDkC39gAhaPquyzWi8KG3g6f9P9CZ6az3n0F5aPsBeZpWk7G2Kp0peHSMhOagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoDweggm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE95C4CECC;
	Fri,  4 Oct 2024 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066309;
	bh=ztK4R81dI3iHycNWz9ngo8HvygWRn6KVN7cbIuZ/M7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UoDweggmicR572rG3HxccCsU/UP9D/V0YPfSKgskDBN/XF9+I+SwbO2/6uim/e+TW
	 De9OUerEh05begyLuvPaa8oOcb0Gy4X01PE5HTNIoHePR0LeR/iVvgOirWoUpumCIX
	 usyKTuvGNBjgtHXxQtpF9LszvGv0XYHoiAl0+F9C6VSunmr4NFkrZt+8DPmYKZvqH0
	 EPHYM07vIp54jRbESLXkf33Fjua6x7qF/4h9Mg/zv1d87ahdOrAyE6FFDjteHe8VUV
	 +bqdy6RDGDqBTvJjxJrlTLE7dyxBkgHgGA3LAT66GWVTTOIl1V9zgS15VgVzoPnG+I
	 vC/3wrG0WH37A==
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
Subject: [PATCH AUTOSEL 6.6 03/58] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Fri,  4 Oct 2024 14:23:36 -0400
Message-ID: <20241004182503.3672477-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 66a8ce8ae0127..bd4e66d514f14 100644
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


