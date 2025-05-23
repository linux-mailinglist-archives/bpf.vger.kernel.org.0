Return-Path: <bpf+bounces-58856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD5AC296F
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863EF1C048A5
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380E216E23;
	Fri, 23 May 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T99jWIjm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D09297B68
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024261; cv=none; b=ufRVHS6m/hyGKZzs2qR9jFDnnM5YpkhjZcesySalhxsPojK8cnzIJk6P0w8woL++2gp7Wig9Qd9iZfwpwYUmt3QkDGOtkC+auyn87STJRdbsEwzjHVUmtYjxHQeSzny3ecNsPSu9O/Z1QbDrIBHGZ6ukEivm8HsyXTbAXw5cksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024261; c=relaxed/simple;
	bh=8k2Z/uvcFaXax6xHZWPtwaGEO8PQ8o3C/a/i260JB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ci8UjfiiMRAKJtrMURwf9+2iljE9l0ryCQgug6EDYcFZCGIsHQOj8SKxJuxYMZqjn/1ahMv/putMnJG1G7q1lNbl2+hrCO7o46t3C1zHDEB8uWUi0xuB7hV/5h55DigDqu30QmRII1IQTFgCpjXEbzCOiAqQ5BraYwQPe6AJQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T99jWIjm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso661065e9.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748024258; x=1748629058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjiRZffF2gMvypCwbzJWCHWvmta7rkGAAtc5QwDqKZs=;
        b=T99jWIjmKUeqjYBN5YzXhO0RraVQqHgxW0egdn2be2sipk5hhz1rvq+mY3n43EHEZR
         jG9LvncXxZjbyLh6DOMFqAjXTCWm4PepSbecUMUXcngyRaBbJqJ2wc2Cf934j7OD4790
         K4DHqi+yHM/S4AarwpCjavbHSa0b1gZlsc+HUFSGnkrk6M7d+hHlaafzEkql12WEFrqT
         EG2sn1hc7H9rafM2hSgD5HMpX6dheFMMO0SeCuZLkpSWIWP5nI3sIevdFqhCWMsG4HE4
         fsfBiWE7cwRxzvmX3WRHtWmgpcw8BMXv/tHcYgGnvBMHHEe+JCLx6EdcGSWxyqvypyWu
         72Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024258; x=1748629058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjiRZffF2gMvypCwbzJWCHWvmta7rkGAAtc5QwDqKZs=;
        b=oOHHpV6e6+LBX0Ix5UwD5LMZwtD29zU6npEmG4Hua7iwAR/Fq6j8rNBuRAKj7aN12I
         Jn8LMWkggdXQkDT2RqZindOzhfyuVCCybv4kAkkOCsYcquwS/otqDoTjqe92ivbeopBZ
         +IPNH6sXFhOYhqO5Ee8t55kyWX+6ZJSVtow0hCqbTgnDF0a5W8kRRZHL9e42PQMq2c45
         vvp6O7YfC8auEWqVa6XaUOUFThwbQdLMRPtGpVBKPdpXzYyvPTVwoS9vg/jIf9yLLiOT
         G7nrBN9iIjv1j5AZT/jE8DnsyUgC44e/Wmg2WSOT++g9xRs+buMEtzuttYslXU/NVRoy
         daIg==
X-Gm-Message-State: AOJu0Yw/6tXyuI+DtbqJst/DY84vFlFaQmnXnzfFF3jKMWUl2EbdCdIZ
	GHiJuC8xe0jGPQ2Y6PuD4dWbfK7MaFtU+eDv1y4qXfWkckJBavJWhpXhsH/Vag==
X-Gm-Gg: ASbGncvN/GvSffjpnTnWZalSmZDaF3aVyJ+HNvOd/fB2EOHmeF8sIxH3mCbg65zIjgQ
	vqKgckpDwpek3gckDZK2SxGw5K+QYQ7cEeVDca+rsF+moS2UBQCq3kJ2nXMlbUVC52W79wsDCX0
	Yy/Cp3d2bLhzDBo/MarIyCgeDxBpSz28Jhx+PwCQXOVhTejxCaQPgxfSrYHgi6e+4NcnjvpxX0H
	OzSDyrCKS6UM9ufmQ1Ia8qVjZUO/aB14AWbg2kp/XyLP1GIZNDaQmMD2iXKteOTqq9WOKS7sBBI
	37cppxDnGolRcmxjRnVKVNaixtD1uysx+qShh+5yqE/GIeABzTDeRC/W/cMAjt42ghj/RA==
X-Google-Smtp-Source: AGHT+IEunjsBVgKVMGOnbEMGL8uBI8gYePfQuO8c+Lj0GUsdPMlB5Y8mgZ7FC4OT5U/jLd3yFnoxpw==
X-Received: by 2002:a05:600c:5294:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-44c9493e67fmr287525e9.20.1748024257701;
        Fri, 23 May 2025 11:17:37 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm145858125e9.27.2025.05.23.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:17:37 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	dan.carpenter@linaro.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpf: fix error return value in bpf_copy_from_user_dynptr
Date: Fri, 23 May 2025 19:17:05 +0100
Message-ID: <20250523181705.261585-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

On error, copy_from_user returns number of bytes not copied to
destination, but current implementation of copy_user_data_sleepable does
not handle that correctly and returns it as error value, which may
confuse user, expecting meaningful negative error value.

Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aDCbQq99EfNDI8xr@stanley.mountain/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/trace/bpf_trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0eb721fcfb5..6876985ba527 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3553,8 +3553,12 @@ static __always_inline int copy_user_data_sleepable(void *dst, const void *unsaf
 {
 	int ret;
 
-	if (!tsk) /* Read from the current task */
-		return copy_from_user(dst, (const void __user *)unsafe_src, size);
+	if (!tsk) {/* Read from the current task */
+		ret = copy_from_user(dst, (const void __user *)unsafe_src, size);
+		if (ret)
+			return -EFAULT;
+		return 0;
+	}
 
 	ret = access_process_vm(tsk, (unsigned long)unsafe_src, dst, size, 0);
 	if (ret != size)
-- 
2.49.0


