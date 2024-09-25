Return-Path: <bpf+bounces-40305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C8985E47
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE4288DC4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B520E085;
	Wed, 25 Sep 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg0q1z13"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499320EDF7;
	Wed, 25 Sep 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266156; cv=none; b=TPxO104EGMIyavMGrORp+aBBtdFi/36NnpDQvhXjh5kIsV4ehVJjsEPasKbofOOYhSwH/xpA5ADnj3diQ4TOxv2oy+kzXBgvhsteXBwsH4DJf7plT5khz02+SsEU5qISl2RZktJNznen94qKCDn38+u2BvKqaoW67R8mS5nDHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266156; c=relaxed/simple;
	bh=PXYsEtrSdXpaRURxZQhAtlJjznCOG6BAByR7SGjYabo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+rgr0zY71YoTNdmCTwH7ic58dfuYpaKLMjpzuTpEB+5Amn4KclEXpcW4fckoj+DHSMtvHvoa/8ehc0blRvUt7xSZZ/60KFVoQzxe5TyCAgdsdxcNHvQQIQwbz0u1UouOUss/8bxdPK/jysRyMXZ+XF1FcGhgtSdhEkdnP6CfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg0q1z13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20CFC4CECD;
	Wed, 25 Sep 2024 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266155;
	bh=PXYsEtrSdXpaRURxZQhAtlJjznCOG6BAByR7SGjYabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dg0q1z13BsBhX5Obgy9PC/uQi6Zexc1/h6bBvkskuHJlEpm2DuJqWOLZ4jbcNeJrR
	 ndXL2wae9iy84UjpFKRzYamidu15TNNdSMs2tYILCYcCjnUF5IpilFU9sxeKABkP8K
	 QFPetSmWtWreZGq6PLEzw7OerHFTHNNMQgZmSVzAQ8KRUvGZUWDmUxo+GjZ9ozBiYw
	 0QwNGm0wP5ePftXnjPx+RpCuQo1vjBYkHWLmMYDo0FO3f24rUHaXjvc8mdrdbJz+ZY
	 xplyWAQ8hLz189xgoUEJj6kZbqDIN49HwTy/W+kIslGkSM5GRbMCr5Q2dhNwKTPuGX
	 z+KHmcHQqRc4A==
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
Subject: [PATCH AUTOSEL 6.10 196/197] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Wed, 25 Sep 2024 07:53:35 -0400
Message-ID: <20240925115823.1303019-196-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index ad2ea6cf2db11..0f2106218e1f0 100644
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


