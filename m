Return-Path: <bpf+bounces-43282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548ED9B2DE7
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129F4281A1D
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D11F428B;
	Mon, 28 Oct 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhMra7RK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AD1F4264;
	Mon, 28 Oct 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112768; cv=none; b=CuE9zDdDvkkwGiDmUAQ36x5tTnRkKbN8ibhPEysOv2Z/TCXPDf78BXXU1A3vpOGHYy/lFWPdgeCX/4zG3bA+qpyoOsEbwBZbFPR543UqWmXGZA4JU+khco8L2eWvcJM674oVGLLyA9MGFRdiWLHb9xQQFh9qN+x9cpRsRP0HOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112768; c=relaxed/simple;
	bh=VSoNRi8c5SQ0AzyhFBTOZSFTBGsWwJ1j/Vssn5v0a2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkr3U++OkeV5+yAimWe8UD0AuqRtSdteQrEfWvYiNNEw3Y0WjMSBUXLZuynKgjYZzupX6dBGFYkaibJPOHryK24qTy2SJQO88n9Sn5U9pkVhKsCCMvHetYXHcHZ2NhgGZpwNwJAi3fKHONoy/AMHsbRz734EF0snGPh6G0uvERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhMra7RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B3C4CEE4;
	Mon, 28 Oct 2024 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112768;
	bh=VSoNRi8c5SQ0AzyhFBTOZSFTBGsWwJ1j/Vssn5v0a2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhMra7RKdG+pA9I4tLvTJQp7XquGJ4DT7HFMQyO+ey2DjOBeKqlHL9Dk2D9LVCQDa
	 oGCrvm6IhtF0d4khe7Tf0oolaXBsHHW08ObUKFFnWQS5eY+YV9ifvwejyqlwmT3la+
	 Mj8dJmwX8/hIImtcuPPuF3G901aTveYUZaktqBgnz/7HUN1bkrOdVYQmAPvi7BMi7u
	 BAFe2l68jGrOA+w+h8gOj1Jr2DO7popaJXv7zYnGzyDjq3D63k2/Wn8m37obgzM9oP
	 5lWC9cK6f+2F39ckfP7RKh9evAN4kTWqevu6VBKM1jMU0Cmdf4U6PfFQCOMeua+cGI
	 hnMmo9173BEkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/15] bpf: Check validity of link->type in bpf_link_show_fdinfo()
Date: Mon, 28 Oct 2024 06:52:11 -0400
Message-ID: <20241028105218.3559888-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 8421d4c8762bd022cb491f2f0f7019ef51b4f0a7 ]

If a newly-added link type doesn't invoke BPF_LINK_TYPE(), accessing
bpf_link_type_strs[link->type] may result in an out-of-bounds access.

To spot such missed invocations early in the future, checking the
validity of link->type in bpf_link_show_fdinfo() and emitting a warning
when such invocations are missed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241024013558.1135167-3-houtao@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b1933d074f051..74245c5251915 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2963,13 +2963,17 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
-	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id);
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	if (prog) {
 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 		seq_printf(m,
-- 
2.43.0


