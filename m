Return-Path: <bpf+bounces-77904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C4CF6462
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D28030060E6
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E12550D5;
	Tue,  6 Jan 2026 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMGZkyea"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA51E3DCD
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663082; cv=none; b=sBk7KpI7r6XOUgDUUlWhZqMfCLKA+LPEGJ9t+YTw0yutzFl8Pvj9gqNmkhPmvmyDG5BFvbEXTm8l2dosBelXWW18V2a9BLtPc5N68bKkusHU9JEbhUJD2q8V4SHMgInL3SjtfeB6oGfmmxG/sgQgjFHW6tM6BNIUGmkwd2owi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663082; c=relaxed/simple;
	bh=XXlo8TVy0D+U60r4gF9lesILAKXn+1/8h93MrVZGXnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UchirzVLt791Yj9nojCRXHEmpTZplF7uWvvZRRPPwcmFhN9QEhz6eH8n0ILLXHVTa0Roaxf8St0MDQeJyG/fIFsTwcCEArukeNYoVp0jqfH3kUTa6e75ZYB7OvkzAAK2mrgGXCYD30NQ1hqZBknliNIXKjTFv4kMCCL3UM4q4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMGZkyea; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso514823a91.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 17:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767663080; x=1768267880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4YAEli/oXuIfYQ/ot1/+zoBf8JMyj/sAgBytJYu+9E=;
        b=CMGZkyeaUsHn372umWB6yy27yP7RoJipgdK7GBAoS0HGc76M+1KaFFSyyd4yaWEiV4
         EqO/3zuFRNiQz5zUZ6nIpT6sfVh6zlVXQ76uslX+qQQeT0KSnFhwXRGQINfw7kSdZlMY
         iDeDRt+rC/GHG9LdOtM1GVvNWyWqUFAGlfO1A2Gae6/d41rUgd3gDfORG1B2z4/5rn0i
         64sh+hOqJjdqeURSU9loUJlZVFRDuoo8e+rrbZ7hOVhBGSpg6zDvODyElPhGSEgRE4iU
         SZJEqZB8GAN6+VMiEwblx2rjFF6tStu6MZE/fK3+oO8KON6lmQY7BPnA3Qfb1KE7ifMF
         Jwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767663080; x=1768267880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4YAEli/oXuIfYQ/ot1/+zoBf8JMyj/sAgBytJYu+9E=;
        b=RsvrF1r2foWyNMlaO+17G2QMIdWK2wZhPXi5UwOZs976t3DjzPDjzNJfXVv+UjlsbA
         RBCUqH7ZhVz8OZdMYRs7WiI8oWcUZax+st+pMM0I1xoRWu7X7zC/TLvCesL5tAEu8gTa
         5jo4cjJeIdAJxvuW2NNmCrobwWZHL5o5yFXwrnFmNBJas43gfaaLdrwDFQcftp5zfbvL
         8inVCNJVVfeds/UMpb/I1d4ys9dWkgegXu+1YW8X71byHD0L5gTlWUC8Mj+Ull7wDEmk
         DKFOx62QjCDUx+MXvcV+iBHi7oiyD/rDQQheir736YaWoLCg0AgtkRHtcu/7wpO5zqFZ
         IaMQ==
X-Gm-Message-State: AOJu0YxigwJD4o5io0+bjrzwSOCLY3QvAZhXE6JARGBe0p9whfaeyC9X
	tRKD6GDCjBArc7ttVQHZ/PHFBubn291kGa2hJpW+EDx0s6dP462ZD/5K
X-Gm-Gg: AY/fxX49OA+nvvJoukkGFQC/Mjx9yGokfjmxyOB9+1sCsVdDnDB3ZhqTb5eZG1rJA9b
	ELP4P+NQaqBGZhSbWcpltdNJKz6GQ/9jgzBDE9MOlcdF/0LPMCqzlxlq99TC6jIXsuAcvWn4Uu4
	Vkg1qGPEhl8Y6RkY5CGPlm/+WxIb91W2FgQtiZLAEFXFq2CfvrX/YP0nUjLcmjQnLrUCMVhEqP9
	9WVpx1Peu3UElqZR1GDvqC0t8st3HdrlRtg1aBmMpDS+EBjCi8WXjAP4ZPXDaP09SpKfUT1YY44
	U8kheDj4Otlc/5CGG05VtF/MpFnzCMtcWsAVooQaOPd0wsTFxYDd7uAAcRe7f5ap/FA+HyffOHU
	EQFLxzDNJQ5sYwlWP1vqdkxrIDH5lk4rrSrQd2+x9EN/VTdzggNsD55UtvzdrdTHzMAb1bX52nb
	0d1AZmY5P/7y0/2TclD5ZXJLYuykV7VGUgkh0NFV+HwAQc1YWybcTsSf8a4WIWd3b9od+L
X-Google-Smtp-Source: AGHT+IFFA/XN6UYnjtPDWZslaUtRHocpcB7HSI1R42TMlNz90/QyWyaCta2RK9pzyj2DIYG/Su5bMQ==
X-Received: by 2002:a17:90a:c890:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-34f5f287947mr1004850a91.15.1767663080086;
        Mon, 05 Jan 2026 17:31:20 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa947ecsm544110a91.6.2026.01.05.17.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:31:19 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v4 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Tue,  6 Jan 2026 09:31:10 +0800
Message-Id: <20260106013112.56250-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact through adding a
pre-allocated memory for each xsk.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")
---
v4
link: https://lore.kernel.org/all/CAL+tcoB6eCogZXXxDQ58nxp-VxWFOPR2DP4pyLVxGtjXdWPQXA@mail.gmail.com/
1. use u64 addr in xsk_cq_write_addr()

v3
link: https://lore.kernel.org/all/20251216052623.2697-1-kerneljasonxing@gmail.com/
1. fix double free of lcq in xsk_clear_local_cq()
2. keep lcq->prod align with cq->cached_prod, which can be found in
xsk_cq_cancel_locked().
3. move xsk_clear_local_cq() from xsk_release() to xsk_destruct() to
avoid crash when using lcq in xsk_destruct_skb() after lcq is already freed.

v2
link: https://lore.kernel.org/all/20251209085950.96231-1-kerneljasonxing@gmail.com/
1. add if condition to test if cq is NULL
2. initialize the prod of local_cq

Jason Xing (2):
  xsk: introduce local_cq for each af_xdp socket
  xsk: introduce a dedicated local completion queue for each xsk

 include/net/xdp_sock.h |   8 ++
 net/xdp/xsk.c          | 223 +++++++++++++++++++++--------------------
 2 files changed, 123 insertions(+), 108 deletions(-)

-- 
2.41.3


