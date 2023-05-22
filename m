Return-Path: <bpf+bounces-1042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8970CB43
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C511C20BE0
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37B174CE;
	Mon, 22 May 2023 20:35:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FC168CC
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD92C433D2;
	Mon, 22 May 2023 20:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787752;
	bh=0nQ8xIPSPhBIr1gc3+npYhNke4IXHy+5EM39FqGHhHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvIIl7JwcJq1f1lT50bQTaPuLv0NZy78hJqb4UTvWapPNbd41FW80wvaW4pH0aAOo
	 4TFqg8491i9Zl3rQRFtYXMLVrUEjAIN2Sus2yH0U8HOELjOAhTmZZlj6/RVSV3KFvt
	 Xe9iqVfgcL67vJ4LphGTNfl2Ao1Ub0EQ7bS13b2S6nILe6dKwQjN4s3A5ifjdgD6B8
	 HKSBErLqGZ2KGI5RO4zGnfoSCGGwg236gdTcm9UFy3mIkKjxjyKFjwyOA5VTnN1Ir6
	 STLK7od7jNeP4m7FYg/VWUGu+uTiQw4V/Ub1n/8uiGlC7+KimKstqJvqYoDpmxE5EM
	 cl8yPMWAoz3Ag==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 8/8] bpf: bpf_probe_read_kernel_str() has to return amount of data read on success
Date: Mon, 22 May 2023 22:33:52 +0200
Message-Id: <20230522203352.738576-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andriin@fb.com>

commit 02553b91da5deb63c8562b47529b09b734659af0 upstream.

During recent refactorings, bpf_probe_read_kernel_str() started returning 0 on
success, instead of amount of data successfully read. This majorly breaks
applications relying on bpf_probe_read_kernel_str() and bpf_probe_read_str()
and their results. Fix this by returning actual number of bytes read.

Fixes: 8d92db5c04d1 ("bpf: rework the compat kernel probe handling")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200616050432.1902042-1-andriin@fb.com
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a46256f99229..c4c825dcdef8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -198,7 +198,7 @@ bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr)
 	if (unlikely(ret < 0))
 		goto fail;
 
-	return 0;
+	return ret;
 fail:
 	memset(dst, 0, size);
 	return ret;
-- 
2.40.1


