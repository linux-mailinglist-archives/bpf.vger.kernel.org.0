Return-Path: <bpf+bounces-62696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85857AFD020
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D905316AFFB
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B32E4251;
	Tue,  8 Jul 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEcLIgV3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5D1E412A;
	Tue,  8 Jul 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990867; cv=none; b=GZMap+iL/DoMQpTrn9QfNMl9DXwjsPIF4/9w35gAjQzBPbHXGzMXXvIssPOvBPBLhDLDJkFmz9igGOnNxcVzFiiN+pZvqZ/GiAJC57lCWAZPJqVn3iU8I1NZU715ypXzSEmCqmFstxZ6a0QOkMnA1J81z7fcEYRIQhQ6K8ReCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990867; c=relaxed/simple;
	bh=98fKvdP0i02lST6UkvFvXQHNgQ9XkTBzo+wtuhhTI8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbiaLsiA6ed6BGWv8J5TYO9jtEfsbo9sU5BjR9Ztmtk4F/kd5BcatpJnl/gsa7lyrqMemCI0+C/kRw/29yQXRXygxAuGyyE33ecgimdE6Q/BC5DHlvV9EBgSwDGaFEtfABMBw2MI7H2J7E1R5PGORHh2UDJJVin39jeSF2mwDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEcLIgV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8DEC4CEED;
	Tue,  8 Jul 2025 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990866;
	bh=98fKvdP0i02lST6UkvFvXQHNgQ9XkTBzo+wtuhhTI8k=;
	h=From:To:Cc:Subject:Date:From;
	b=fEcLIgV33jRV7doaIC0ukPrope5DureXTU5LscX8oc1XD4bp0iJ++oSt981aQp94h
	 2E7Rf5eloQg3yDqmEYaoSmspEBAZSBj+6SJSdYe6LG4fhVJEkqpho81GgIkltm0UDX
	 wc1dxTFssa38RwwwT8l+Ci1oS3JbiZSvwcQrKe6zJW9QaRAK8e+K1liv7G3OyPBxmY
	 CHpY6jOKDBAUPZ18mQq5SaheCKRdNupH+pazVyFhJRTl8HCMsJ38FdkQjQ/4kvTm8g
	 2j2JqVgUQ7pe9ulFtBTMgQxaipy/c+Iz+JmnhfFERJn7O+hPhzYNlSZvCy47w/VeV4
	 IE56eEvQtO+3A==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix dump_stack() type cast
Date: Tue,  8 Jul 2025 18:07:29 +0200
Message-Id: <20250708160737.1834080-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Passing a pointer as a 'u64' variable requires a double cast when
converting it back to a pointer:

kernel/bpf/stream.c: In function 'dump_stack_cb':
kernel/bpf/stream.c:505:64: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
      |                                                                ^

Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 8c842f845245..24433cdf6ede 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -498,11 +498,11 @@ static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
 		if (ret < 0)
 			goto end;
 		ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
-						    (void *)ip, line, file, num);
+					    (void *)(uintptr_t)ip, line, file, num);
 		return !ctxp->err;
 	}
 end:
-	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
+	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)(uintptr_t)ip);
 	return !ctxp->err;
 }
 
-- 
2.39.5


