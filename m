Return-Path: <bpf+bounces-39339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1997220E
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DA1282BB1
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C673178CF6;
	Mon,  9 Sep 2024 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="WvISwyI/"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06032135B
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907713; cv=none; b=HircSAoigE4RnmQfpEtQJxA9FFj1CNf2FLqKa7RBmrgRtO6F+OfIl7X/uqCrFHa8oRJ+Vkv0fHmRqFmUfAd2BE47zJiugN+pnWpM/RHMQOiOxaqErvcUJ8LWH6r5Pv21+88EjI7+DWdnXo85XEhQZvkctxI3nnQAbvgb4dt5mK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907713; c=relaxed/simple;
	bh=YUJZgeUj6KYFZIIhJwlcu1XeGi0E2IdJz2Ze+7Yih/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnjoCyILtlkoUFFGH97OO7dHsOegMVEMUaTN/hjmRNnRkI/tsJbHjb27MBI31jpgHARkhFyMl3B1XMoT7G5nyiE4gqNHv4miwnvcaFYGLlOlq/N1wKo5cA7X0c22Cw0mx//aqtwhaFcoSzLg6pioeHGGvj1g0szq2Hdth2fB+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=WvISwyI/; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1725907704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PKmtkxoc5b8vnoy7LbP0ElooXwR7zC0BNINP6TdpxSQ=;
	b=WvISwyI/Di4GHENFrrPuFAShHwKXHCX0lJrJVi9fUy2qTKXEOHTee3HwV8jh0x6eaUeFbr
	GoXl9ZIc9/hSfeJSTqUCoID9rt8iQD/e4kuWZs33BC8vyAL69uoHdZeVbZE1alf8IasPek
	PdA9bHEhxkuy6qWD2elGFQl/75z9zsioIloiSKrREmV7v9tgu2RMI7SewXWEzcAKcZJk7d
	jaebIOQBmU1mqY87Lkgow1t/hTWELRBO9AU8eCXG8ucThrQ/35woQP2X8/zgxNLjJE2N+7
	1BpplNenXd40xyBlD8iyIdZdqd5BMlb1VTw/U00C8P3A5uBporod8FNreNQWMA==
From: Shahab Vahedi <list+bpf@vahedi.org>
To: bpf@vger.kernel.org
Cc: Shahab Vahedi <list+bpf@vahedi.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Francois Bedard <fbedard@synopsys.org>,
	linux-snps-arc@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] MAINTAINERS: BPF ARC JIT: update my e-mail address
Date: Mon,  9 Sep 2024 20:47:54 +0200
Message-ID: <20240909184754.27634-1-list+bpf@vahedi.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The previous e-mail address from Synopsys is not available anymore.

Signed-off-by: Shahab Vahedi <list+bpf@vahedi.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Francois Bedard <fbedard@synopsys.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..ebd4bca26e20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3931,7 +3931,7 @@ F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 F:	drivers/iio/imu/bmi323/
 
 BPF JIT for ARC
-M:	Shahab Vahedi <shahab@synopsys.com>
+M:	Shahab Vahedi <list+bpf@vahedi.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/arc/net/
-- 
2.46.0


