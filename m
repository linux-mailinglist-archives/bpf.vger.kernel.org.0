Return-Path: <bpf+bounces-51751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD0A387FC
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFE41885D13
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295C224B09;
	Mon, 17 Feb 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cdGFz5QV"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2C224B03
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807048; cv=none; b=qqLEeJBWqp0bIDD19YPnIJ1u1siyRIQRrlrdkp5v+ijc4TYckkbCjUbkfrxExbQNeaHXNFhAgWbFhKB0x54ekrHDTkB4m9x1X5eytceXPAaCt3UCBkWC24NrIG5eTm44GwdmKRrYBp9sOcBdBciwk1N/MGdwa850XwKJm1PxT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807048; c=relaxed/simple;
	bh=GOXUlIjFbxZvqeMO3gns43WUTBoOo7+lx6yQR+6XXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmWtI8u/I8Cxx/RXN2aG2O1sAQbHr6twpc2IMQ64zlvl+tznGBsaTyVykwr8mFW+gZdCTs4VxIcrv+OUrLYNZMJRd8+bcTcnTx72ZfZv0UWmSt7vsYBdR5jL3xIwCACqseZDZa/G6vl0mmbpOjARuG+FFKZVt9BHHIBf+ky3VJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cdGFz5QV; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739807041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEp3Ep8bUDs//z0kGQY09N0WhdHQRhACrBy7anxWXco=;
	b=cdGFz5QVJId7AMccL95X5KbZKeKGAvTakKbtpIYz8arF5qFLD0rqe7nKwtw2gNGJtGOhW6
	KZV5kaO96+J4f8n/JYOUz5PTBpj4/BWBX8+j/1Cqx/g0ykfcJk/Y2KEzkGrKFaXSn49fGs
	sUhXnZH57A4d3eCOIQ98bmeKnB428bU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 1/4] bpf, verifier: Add missing newline of bpf_log in bpf_check_attach_target
Date: Mon, 17 Feb 2025 23:43:15 +0800
Message-ID: <20250217154318.76145-2-leon.hwang@linux.dev>
In-Reply-To: <20250217154318.76145-1-leon.hwang@linux.dev>
References: <20250217154318.76145-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the missing newline in
bpf_log(log, "Target program bound device mismatch").

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c286ec9e8413..2f9fc84f9b1a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22574,7 +22574,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
-			bpf_log(log, "Target program bound device mismatch");
+			bpf_log(log, "Target program bound device mismatch\n");
 			return -EINVAL;
 		}
 
-- 
2.47.1


