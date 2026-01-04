Return-Path: <bpf+bounces-77752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC45CF078F
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 02:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE4B3014BDF
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847D143C61;
	Sun,  4 Jan 2026 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwMAuOum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BDE555
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489695; cv=none; b=UcjuFy7wKmgVL+TrANzt6DBJ45tRjIbzzeu81Rt4jMJMZRP8UNNAXVDLsLH5YnL7T/ZyQCksdfw04QWEbWgV5P0kgLlydBtXsWChiJFn3vQL7/5jF/nEFLxzmV0Is1dK+MMUdCJZyQ/1b9Sz76x9h3DbaaDgKgWQx6UNHD5Yw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489695; c=relaxed/simple;
	bh=VcSvpLpbh0fEnPUOq/GhltLFqOdrvS6cj4/rV17TS0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8DtP6QNFMzZWcQceqNvRDYP2HKMX4UPZ1BDWxplvoiriEFOuc9gD77z6sjt4m4w5SGjRjCupm9jUKAR33wK6N2/Pnfw6NLwL/U+8wLmAtrdO9pb+TPzzSt30rPRnj2LGVYEvsA9eyTcAyPaonSdH2fGNa0Gk533hy3Neqlemvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwMAuOum; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a12ed4d205so113980675ad.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767489694; x=1768094494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdvP8ECgpBcOdlKiEy0yoAm3c9IvL3YKmio/VImfYxs=;
        b=fwMAuOum8vN8tlJlrqRCuhx0Y3bwubDE40gVMc4w/oRkwNMiY/FFxLcqs5uw2Zs5X8
         4sUo+psoRJXP+iENQobe5Bs3Mp3ziu4MacXRZ9vLVrZ2S+8YoCKmGyscvPARQGkeaL9L
         8RtOIppNTAhAO4NPdDlIqZk/NpbzbF7HhdOJBB4cnARWc7dzy3jqSk9RwY63diNCBHfg
         umLJAgzilB1YGSW+dtP62+HtT2+YziDy+WbLWt6X48wolZhvs8lZKABNCY6Q2NAbC7hl
         qQCamFgfPHzQ+ABPzJzUZE6jwCp5xTCr9r06oWk+1Ao2GQQNDswQtf1nDfdqxTlWWOgw
         uD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489694; x=1768094494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdvP8ECgpBcOdlKiEy0yoAm3c9IvL3YKmio/VImfYxs=;
        b=QDstGke3bVFKE41242GDFLYNi9vq8gUBS/YXmnO4flVriZfw/kfS+aXIKZaUPSjMcl
         cGj1RNCJVIfPPftfzCUSjUuFkJxBx4YKmPlpk7mVxyDJBUB7pLVy8HmOUACx7k3LkwRD
         hUMR8fGcgGctT3L9Aw9TMQWsHY2tz8PQB/OYdTsdhfG3P2cd7ystBYWpwCwxEzXbW5zD
         x5AizHCZ4CBXcRMsrVImFbOv6Zje4JCw40KFshL+szXNUU9C6m9UMcSimB05Wdr/Jx8B
         ILCjfjUucOMi1fWxQ4Tbpw+sk2KkeqxEtRUCgo+gycRmWHQpNW1sp4SjX9jqoyHZBVus
         wzXg==
X-Gm-Message-State: AOJu0Yy0DM+Fx+t+pQl/alo42Ou6McmGCQepo1FMtFM8SPx4g1CfgZTx
	E0AGm/csxqMc3SmaFQZONWChUPS/NrdFOkwM8Dbf0FT1xJPnzKgzjmW8
X-Gm-Gg: AY/fxX6PJ0nzAVLRwZrSb2rWf7uZ5KElvSb53uZTnW+U4UzkCdl1Xq0q1z52Vn15+92
	aUGYu2Yx8J0bUZiqMlZlYxZe1o83u9rio+YCC5mLGJgnduhb5A9o1oVoQS9/8syF1Sbnfu9UWWw
	domKyaspayAfLavhuPf6kd2GuIu0cZ/RLQ4OOV4Ggky5REr9cxt1i71C2u0suNjhMDUpgFLTQDd
	7jMvY0dRON2rq325HgJNuce9Jn7Py5Vhcse7w7e37f982/z/c7VDHXRyC9/afBETFdm5fJ3yAt+
	oBkhkB41KmbfI90jr91vg4NwwKLI15kkJ26XDHGUxUHgOEJNELB0nPsvzmUGopIwNrxn4h0G9qm
	XRybXwZayICOHjnnh9T7BP0XLns0qHAE2y1nvdwdZ3L9AJDTIm42HJ5ZF3oTdo+xEKBOHebkbz0
	+e043c+MFwZgDoXlC8RsZdB49EZmUn6tSXAAvVxpU+KMhdEOL0RcTKeWYIbQ==
X-Google-Smtp-Source: AGHT+IEa+CYDyN8yb6jg12hX7SncnSJaXO6QEUHvsIW8UiXvYemlAddXr8JbMLB9PBsjFHNggSAGbw==
X-Received: by 2002:a17:903:90b:b0:294:f1fa:9097 with SMTP id d9443c01a7336-2a2f2735321mr373864505ad.34.1767489693694;
        Sat, 03 Jan 2026 17:21:33 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm44484500b3a.51.2026.01.03.17.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 17:21:33 -0800 (PST)
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
Subject: [PATCH net-next v6 0/2] xsk: move cq_cached_prod_lock
Date: Sun,  4 Jan 2026 09:21:23 +0800
Message-Id: <20260104012125.44003-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Move cq_cached_prod_lock to avoid touching new cacheline.

---
V6
Link: https://lore.kernel.org/all/20251216025047.67553-1-kerneljasonxing@gmail.com/
1. only rebase

RFC V5
Link: https://lore.kernel.org/all/20251209031628.28429-1-kerneljasonxing@gmail.com/
1. From what I lately know from the repro at the above link, application
can use the shared umem mode directly but the kernel will eventually
return error that is reflected in the xp_assign_dev_shared(). Advancing
the check can avoid the crash in patch [1/2] and be good to avoid
unnecessary memory allocation.

RFC V4
Link: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/
1. use moving lock method instead (Paolo, Magnus)
2. Add credit to Paolo, thanks!

v3
Link: https://lore.kernel.org/all/20251125085431.4039-1-kerneljasonxing@gmail.com/
1. fix one race issue that cannot be resolved by simple seperated atomic
operations. So this revision only updates patch [2/3] and tries to use
try_cmpxchg method to avoid that problem. (paolo)
2. update commit log accordingly.

V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review



Jason Xing (2):
  xsk: advance cq/fq check when shared umem is used
  xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending
    path

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 15 +++++++++++----
 net/xdp/xsk_buff_pool.c     |  6 +-----
 net/xdp/xsk_queue.h         |  5 +++++
 4 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.41.3


