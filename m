Return-Path: <bpf+bounces-28296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD418B8156
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FC1F2561E
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAD19DF71;
	Tue, 30 Apr 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoPKi2Hb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB2180A82
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508399; cv=none; b=r8Jp/aSlQfUzJkeQXN6w4x1JYiyx9XdLuvJku7IGf4/eAnHvMQ8tzuq2Bgd+DYpDfTmzeUWKgYScY6Iyt5eGB77qgnnzpQo4eQHlFpcpu9Hu2XxV47QHiOXmGet1nPHsGvE9X1QgKKznkaiDp6uwA6mIkYKyBymq1yhoqsuPMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508399; c=relaxed/simple;
	bh=LNtRaM0LR19fjBbQFodcTxLgFQXmA+atmoZxZCBUwmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixhDj/0B6e/ValHPSTn8dDvYPzMbNcLebj0Nkprr2lUrTxvTCkyRH02NwYuTReYddl/tocB77opqcCU7bZ8SA22yH0i22+hg3W+aZ6vRDuFF0+3/MY8czUfJEoYv7eeNiczaTeY9Bo+cD7EjgUft96JymNBLb5FEsmk3LQB29XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoPKi2Hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D36C2BBFC;
	Tue, 30 Apr 2024 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714508399;
	bh=LNtRaM0LR19fjBbQFodcTxLgFQXmA+atmoZxZCBUwmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoPKi2HbBv1BTjVlV5CDV4oTir4OS7kKRJNGggpcPbNKXZQRwFYokrq6we8fpzV77
	 6irvu7RnyU5CTBmXQnxYqrBOOZqm5NLOgKg06xX968gFpVSOwdO6TxrBNe2cYKe5KP
	 u5s31Fvf5AQPiy4WJJ8ASR832QX3HftrK8I7a55e4j4PjUJd4kA2Mg8p3zk8+JpV9r
	 yBPhD3a8iFiU1Vft6mZ3g4wM3AkFADoxrRpDdT+TOUTjsPfE5AB8hltKUJamwOG/18
	 LFYlnpDTI2mXEOSEnr2NF+JTqvfVyvPSwraAfC2GMS2ZH5cH+DJoftSEx2OS9/cMi0
	 WVgBsVlFQ7wJQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] libbpf: fix ring_buffer__consume_n() return result logic
Date: Tue, 30 Apr 2024 13:19:52 -0700
Message-ID: <20240430201952.888293-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430201952.888293-1-andrii@kernel.org>
References: <20240430201952.888293-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INT_MAX check to ring_buffer__consume_n(). We do the similar check
to handle int return result of all these ring buffer APIs in other APIs
and ring_buffer__consume_n() is missing one. This patch fixes this
omission.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 37c5a2d86a78..bfd8dac4c0cc 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -301,7 +301,7 @@ int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 		if (n == 0)
 			break;
 	}
-	return res;
+	return res > INT_MAX ? INT_MAX : res;
 }
 
 /* Consume available ring buffer(s) data without event polling.
-- 
2.43.0


