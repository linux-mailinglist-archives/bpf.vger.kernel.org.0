Return-Path: <bpf+bounces-39849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45B9788BD
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6922281EBF
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40801146D76;
	Fri, 13 Sep 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qo7Ib/dI"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A41465A4
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255087; cv=none; b=Y9FEJW6eVE3+LjT4cYhCipEVq4vqtuJX/a0RKXlaFcbw4hkCF9ANfnblNeSePsALzxo4c9EyZR6TQNt1/da2ay8Nk/7yiv9LV/5VZRjzA/KuvjkXFVDzSIOLku7t4jg0r2s7DJ58Jmu8lE+Q5pmlSXeRdwNqM4CRiW+dArwLIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255087; c=relaxed/simple;
	bh=uw1TCc9Wm0RzNXrS2iQAAx/0UJAF//eyQVp2zLUsScM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFmsviXB+jktXeYEpLksBQiodkWvdf5IvZiPv1v6vH8ETSE0ZxD72vvmZl9WDQNMQ5BjEfPUpDlY+dtD8FYmooGGR6NQPK+XSWZWghV8Ks3vq7j48LDNyP7xdrnJJbJ3hgKYslm3jjXp1FWwVt6xxUXsih67NIbXipBez/6MmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qo7Ib/dI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1J96B2bL4ZrHkDcUuVj7CKRbCCVCChEvbgLM+gsIRnw=; b=qo7Ib/dI5e0EsT9vu5KyqTeDGM
	LdS60Z349Iyp/1SWCNaG58vbPElupUpv0m5SpRfNEPFq7JoEY5Bu4GEun2PrhYWSOPNhDXvCcLBtn
	qEdXI8RR2DqSFdA0vBdwIFR0flMJIO6whpLo5nB34+HZldoPfVdat5cN6IBZUGPOcfUy2a5PciZIJ
	Fy+pdKHybDSCCH6RSTCNEprj7YsaMdqfHf/RZWOthhR1T9gm88r73x2dHwYUT3A5ZB9UgZJgcFCGf
	BDfegwBCsXqkC8paWHA5sC6SONp0Z7wM0BCvlTU9b1278keZxGdvR+qZCeT4CaAx7SaryS6+x7nTP
	z4vlFN6w==;
Received: from 43.249.197.178.dynamic.cust.swisscom.net ([178.197.249.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spBnp-000Ksd-3z; Fri, 13 Sep 2024 21:17:56 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 2/9] bpf: Remove truncation test in bpf_strtol and bpf_strtoul helpers
Date: Fri, 13 Sep 2024 21:17:47 +0200
Message-Id: <20240913191754.13290-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240913191754.13290-1-daniel@iogearbox.net>
References: <20240913191754.13290-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

Both bpf_strtol() and bpf_strtoul() helpers passed a temporary "long long"
respectively "unsigned long long" to __bpf_strtoll() / __bpf_strtoull().

Later, the result was checked for truncation via _res != ({unsigned,} long)_res
as the destination buffer for the BPF helpers was of type {unsigned,} long
which is 32bit on 32bit architectures.

Given the latter was a bug in the helper signatures where the destination buffer
got adjusted to {s,u}64, the truncation check can now be removed.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 v3 -> v4:
 - added patch 

 kernel/bpf/helpers.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0cf42be52890..5404bb964d83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -526,8 +526,6 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
-	if (_res != (long)_res)
-		return -ERANGE;
 	*res = _res;
 	return err;
 }
@@ -554,8 +552,6 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
 		return err;
 	if (is_negative)
 		return -EINVAL;
-	if (_res != (unsigned long)_res)
-		return -ERANGE;
 	*res = _res;
 	return err;
 }
-- 
2.43.0


