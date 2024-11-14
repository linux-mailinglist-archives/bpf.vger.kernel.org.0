Return-Path: <bpf+bounces-44823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82E9C80BC
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 03:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494581F257CC
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 02:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BEE1F26D8;
	Thu, 14 Nov 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MKmarq11"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DA1F1304;
	Thu, 14 Nov 2024 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551067; cv=none; b=cwYER2I1mxLku8rASnjedYv/3uqcqGwv15PRJxACC6AWLxZQ84m9UkRX/szxQEh0cSqC5i7R1SzCP47uJbZbqwNPXRK6Oes1zLnX/WSUYNTcM+Jw3H8e6NkG2kf9rH8rgHBabdjlLyhCSYAUm167rLcdLSVi/H3jQ6+UCNIAIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551067; c=relaxed/simple;
	bh=vPAQWXFeY2D/RA9r8Ote1ZVTFoVIaLvPq8cRBlLUTVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE5/NhquapeIJUAWNY3aaUiGNZgyQf3sx2MKwLPpA9TEvWc38dcF4xa8TqYPuB/Wjjz6tUK7LzTHwZO3kag1y9zmLLwFsAuVXt0ZCx77bIJb6xV9iHXwKmJ6jXwsUJ5WpJVrQjM+X0Q41KlhZB+nthueMr5DEhGSZSycNSnrP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MKmarq11; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=iNEB7UQtDSiGmwS6kWfSsdV9K1C3QAjqEtHiepsfLxI=; b=MKmarq11KDhjAkES
	/8D2QHe3Eb2iLm8u3a1cJlnfoZ2QYKa6hx9oAHAPHpN+yUekivAonzVr9MRsOKltkogIRaivukn7J
	t8vbveMJ3QFz1pvva+DTN8lQQeDVoTZGUh/EseN+BT8uqAECcQBHgWls4C19yDbrEZAPJEY+lURI1
	rPEdHO2Cs/5f7aMqQUH3XUpw/HH9GTIT4NYMy+4xWnecVYMn/mlMgANOmrZtS/XlXv/9Gk2ip2Xo6
	FF+cKBPAIozDPXSSzTpnY2S8Wv8P7NMwHu1rNkmDVE44Ysc353wZl06/W18fUXzHXuI6Z1Rrl3XMU
	K6+jYHGdXHVjZKGo2g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tBPWg-00HPvO-0C;
	Thu, 14 Nov 2024 02:24:06 +0000
From: linux@treblig.org
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	roberto.sassu@huaweicloud.com,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] bpf: Don't select USERMODE_DRIVER
Date: Thu, 14 Nov 2024 02:23:59 +0000
Message-ID: <20241114022400.301175-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114022400.301175-1-linux@treblig.org>
References: <20241114022400.301175-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

USERMODE_DRIVER isn't neede dby BPF_PRELOAD anymore since
commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")

Remove the depend Kconfig.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 kernel/bpf/preload/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index c9d45c9d6918..f9b11d01c3b5 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -10,7 +10,6 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
-	select USERMODE_DRIVER
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are
-- 
2.47.0


