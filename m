Return-Path: <bpf+bounces-52375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C9A4266A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9BB1610E6
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94EF23BD0D;
	Mon, 24 Feb 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nU+4RSO5"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C522190662
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411286; cv=none; b=Qj4TdKyuRGtzPA5B6lMl3qhyxbY82j859DoRTTHTeJn2t5/jIIPfQ/wd+HfuA90BSyVCTUDxgdYZGxiG+VHpfYQN/RJPXG8otfiXaowk3/Fh6LrIn8mEi2isQgBjfrUhnCGEc/AUE/azdMSWZdS+4fr8rNNko9SNM+SQqb5C/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411286; c=relaxed/simple;
	bh=qGkc45mOXq1TIz83GA1UeUUVLMNryi2K0z1Nd4iB6Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwOfJ7u+KFbA/mFtcse0woZeGpi5crgMFSpliMBAIaMRMrGSqiwD+/iBEhD7p2dcFPFVv3rf1oivYSzHZwzpNZXGhEfJF1sOO20Liw9MCRpZigTKY5x+apbe48wBoEblFt7XJBX0pMp+I3QX+cNkRYHboWKc+3LFF6FO5yi2P4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nU+4RSO5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740411282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEv1l4Uzx5k5yoQu1Eck5lcVa2oMNUR+C+TPeKmZiDw=;
	b=nU+4RSO5yaiNlmrKlEyA8fOisomkwQRixjSXebb5tRjEnKPUDKyp2sJUAEE+dkSC7968DM
	vZVVz7/NGbTXHTmBY2bcO/n2TRM4BCR3b/BUTVWqeCe0BZAb1sANIqPO9PZcMh0QHGmfEm
	MeRfByZwPcgOmICVbUYb5Zp5Pkd6Gsc=
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
Subject: [PATCH bpf-next v4 1/4] bpf, verifier: Add missing newline of bpf_log in bpf_check_attach_target
Date: Mon, 24 Feb 2025 23:33:49 +0800
Message-ID: <20250224153352.64689-2-leon.hwang@linux.dev>
In-Reply-To: <20250224153352.64689-1-leon.hwang@linux.dev>
References: <20250224153352.64689-1-leon.hwang@linux.dev>
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
index 5c9b7464ec2c9..6801662f1dd28 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22701,7 +22701,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
-			bpf_log(log, "Target program bound device mismatch");
+			bpf_log(log, "Target program bound device mismatch\n");
 			return -EINVAL;
 		}
 
-- 
2.47.1


