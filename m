Return-Path: <bpf+bounces-52046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305AA3D106
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 06:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D733B1E5E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B101E2858;
	Thu, 20 Feb 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="auP5xDaD"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446C19AD8D;
	Thu, 20 Feb 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030669; cv=none; b=QVNa2HDj+2/b8DkuF3LpixccuAay6ooKgky5JXpY2YCVIGyOpODtvCkoGXNrhCXSRR+/noOEHoNI6NjrOV8yRESNIo7+xHQJ4u8eDUF5wkSGiz1CSBhXmu6Pm3BN9kOEBwjAFXixLgQ2DBqtQh0Mx2yY2LQ920xFgvaOdAMGX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030669; c=relaxed/simple;
	bh=Q1/h5UcSOF0+IitiK3DRpDk+zkM8EvN7YEECp6mauzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DefR2AALc8IbuAJYc4QPOrVvBoge9nnz7jahrqmWSLG8tfG2oKJiN2INig2QDddOHPJwJnF6kmtPBxSrQ4/53bu91SMr1BIfNBJl3M4goxQ8+ak32XH565dWMVYqNMqs0iKwBX5r/0FjkycGy42nJg882xa29ujZNSRUSK46ZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=auP5xDaD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Yz2S20gypz9spg;
	Thu, 20 Feb 2025 06:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740030658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+dgz00ZipOtNvzq7Cv9VSPB1Ky0qLAJZNTot4wkdp+k=;
	b=auP5xDaDcuJWKBqZLVGALXckR2T+En0lMNVxY3sBTx32a+lnXxVlimuuPvHpnJ9V2DMZ8V
	IcW7YKEOU/eUPOEZy0P7pKGZwwXgSvuPuPckEOVGT+bdRrygYQnYTwmK+a1CC9GEKnNy1r
	qXv/vLuIY6Qr7AMrMRLOaa3hzOvrncTjtuetEXcvIhfWwVWzPn9F9MbNfgjNdS5m8k1C16
	9qlC5ijAKm8nLMlE0yDQ2tYciTGnnxDHtCIfQlaEUmH3u1TcwgSc1H0vGZz5mtDMJ/I4Bs
	c0bf0f+yzdmONKVgP3QNKRZTJtYnuz8ZbI9my3XaVV4MkIjO7sY3me+8glfSDA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 20 Feb 2025 00:50:53 -0500
Subject: [PATCH] btf: move kern_type_id to goto cand_cache_unlock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-bpf-uninit-v1-1-af07a5a57e5b@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIALzCtmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3aSCNN3SvMy8zBJdY2Mj40QTEyOzlERLJaCGgqLUtMwKsGHRsbW
 1ADZnIgtcAAAA
X-Change-ID: 20250220-bpf-uninit-3323a4426da9
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=Q1/h5UcSOF0+IitiK3DRpDk+zkM8EvN7YEECp6mauzs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBHODd0SGR6eGVxLzRqTFpjVWVNRDJ3L1lEUnRqV1RkCjM0NHFmaDhIeWZybmJ2TzJO
 Tzd1S0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VUaXJ6QXl
 kUHllY3VBZ2c5VTM0UVdpZlo5dnpoZC91UFp0L3F6OTkzYi81R0hqWkZrbTZjYnczem5MMEZEbQ
 pxNmp1blBEdWlCb3gyeWRoUGk5RTB3OTh2bHV6WGpsWHEwbUpHUUEyTGswOAo9L3ZhMQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4Yz2S20gypz9spg

In most code paths variable move_kern_type_id remains uninitialized upon
return. By moving it to the goto, it is initialized in these code paths.
As well as others. Caught by Coverity.

Closes: https://scan5.scan.coverity.com/#/project-view/63874/10063?selectedIssue=1595567
Fixes: e2b3c4ff5d183d ("bpf: add __arg_trusted global func arg tag")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9de6acddd479b4f5e32a5e6ba43cf369de4cee29..8c82ced7da299ad1ad769024fe097898c269013b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7496,9 +7496,9 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 		err = -EOPNOTSUPP;
 		goto cand_cache_unlock;
 	}
-	kern_type_id = cc->cands[0].id;
 
 cand_cache_unlock:
+	kern_type_id = cc->cands[0].id;
 	mutex_unlock(&cand_cache_mutex);
 	if (err)
 		return err;

---
base-commit: 87a132e73910e8689902aed7f2fc229d6908383b
change-id: 20250220-bpf-uninit-3323a4426da9

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


