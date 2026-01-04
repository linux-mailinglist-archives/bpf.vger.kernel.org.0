Return-Path: <bpf+bounces-77756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953DCF0938
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 04:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E77230124F2
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D62BEFED;
	Sun,  4 Jan 2026 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyyvFlxg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D611EA7DF
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497004; cv=none; b=TnzKIf3vlDke+4qhJs2zITZlImHXo80pXPgc3N2s1ZGJESrvq3dfZJRlypYkFF6I21qfZ64jpnWSAaCi+x0HKq/cAdiD3S4m+zo+LF63Y+dgGM5LU0tYUn28wIP7W2kZXrz1uWuUOtT73R60dn8GCaqIF/hCmuuBPN4Xx3rRChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497004; c=relaxed/simple;
	bh=H7Lp4hlHYKaLNrD6hSx22K2kF/5UZefq0VDM2fZgvew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQMHJ5ZLxaoQHwcIs4g9PIMZVazsYTV07yLkk4T/MRJ9PcERTYfW6BJbIk/ESzSOZgl9jAsOF+KCpVHU4bzhgho4dLnMTT0Wd42zhGPASLhpr5LHd0hA0DOnOZTH/foA8U9qXczLjc/XMWCLuC8rkZKqG90wRqvOWFWoKOjh/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyyvFlxg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0fe77d141so148937415ad.1
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 19:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767497002; x=1768101802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I84VtQc9KkyspRiC2X9X4Oiyff91gGOYfJWSeOoC4yY=;
        b=DyyvFlxghUhBICA5ogPG+ypmRMUp0WAOCnjPFM6Y2gTJZa2PZqONkZv2+/OwVp8qBG
         TIUZyQa5iHkGfv8BirxzuT7cXMmsYFw9KoeRxEiQr5Fx/bdyrQiUV2GE0z/LNkUcSeIA
         O7+V7hPn77p5zNXbZfeTQ7Fm8QZ0EmkuKFBkLjaplnwegVRIulqHRDeZU59wp07YhCdV
         y7oHn+0NjVzuDuFxJi/mI9GQ/RlSDF8VNXSFR1OZFRxgceddopnIjM8K8xhhDXNbcfOx
         rk5stXrQUjpxXyZEq/bb/FC/2ffrjd5iV0LnnpaTBetIB9omVakDTeRDo9IdwOADhoJV
         s0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767497002; x=1768101802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I84VtQc9KkyspRiC2X9X4Oiyff91gGOYfJWSeOoC4yY=;
        b=Xab+ik1hDNI9nYtk2KTcQTclulLn20RVZjHLNK1kijiY2EofPzIPqGkb4qwk4OayIE
         V1LyrbcbSywH5VwLQAp8WDUluedLDFgTWJut8jnvIJHslkSCZIT/K/6eiA6orKCfBj24
         edrWcauiqGLlWsIjtawCUPXt4/8f0owJ4Bpwvj9dt4HHbci5mPMWEmRlCaqZb1AOvjfj
         x8yklIlkmQmX+jTaTaLHXQLYmjXnvYNeQWFBLeQXGmChdIycwuXquYxBN3KJpvocilZI
         niAcM/RBgzKEGytxOIVmbLfRZF8qpEV0uI0sPRKjoXaSt7L384UaRhXHVOMUq3KtFROr
         mK8w==
X-Gm-Message-State: AOJu0YxYu6DoM9lqVETgJ26xtdo4LQZAIbKqSg/f0YFUExhDTY0sHatx
	nAVCSPsxdOwBPFEr/A6tl92MYA0xHEy6umAT0iO2gQJ79grfMOAzNzr9
X-Gm-Gg: AY/fxX6fJq8P6QsECHPuoRlVucKR6rqs8UZ/1tgfhpPnQmDdxeXC1OIFb9lfpKwQPoj
	i7NJzfOf2lwMhB9Mlr9bCprxFV9fSVMuO2wLZ0vt6vG4raXdj0GXuaXKDDMxJIi+VItdspafUH2
	n97N8apY0yCrTsYTSVZVtcrdrlq1yZMypNcXG70b4O1zLxaQHhpZuWQKTi3Xo4dK3eXXlvdMy/f
	VYnrTrPwjswd8sZXBV36vfhkR84DPkCGIyi9YSzGwnmq6tdU6NbahTdHaLVkmBtjsuGAJWiLuE2
	Z1hSBUXjVvDl9LrYrUo85+16Gw8I7hrgqXdtOT/Wtx62DW8i1sTbcguLySerhcPV67Aq/lGomNE
	lgAIq8lnu7686SKqNaU5GRwe2z8CaI4Wzf3PZWbpDfAZ8d4uYOMaKZUu6sVeO5RlS+esTHkzu/y
	5EJ+sC6zOyVNZag4rR5UJ7wy0xRwFJEGssRn2nR6kBmpVd5TXG+FkjAZMYqXB5cHmzEOwI
X-Google-Smtp-Source: AGHT+IH+1cbf7PbR9rmOhkZLX547un8Ww+01xAk9sjVgjF9ZNkVhQe+dnO9QBNOQLu57YQwxrNcFEA==
X-Received: by 2002:a17:902:c403:b0:297:f527:a38f with SMTP id d9443c01a7336-2a2f2231764mr467489455ad.18.1767497001872;
        Sat, 03 Jan 2026 19:23:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6d557sm405852335ad.84.2026.01.03.19.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 19:23:21 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Sun,  4 Jan 2026 11:23:11 +0800
Message-Id: <20260104032313.76121-1-kerneljasonxing@gmail.com>
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
 net/xdp/xsk.c          | 222 +++++++++++++++++++++--------------------
 2 files changed, 122 insertions(+), 108 deletions(-)

-- 
2.41.3


