Return-Path: <bpf+bounces-76669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B8CC0A39
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4CF3030395
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A22EA173;
	Tue, 16 Dec 2025 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBJPe1VH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1122156B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853456; cv=none; b=EyhprCf59JDuW2Hw2Zzgeeqn/Y7wDF3ISC7YFUjlcrJvX+vmlTxLJHEHvkx9k28P/p+/39UA37SFhMsL0gispwZVuyVhBgfuP2NzEkS5Uss1ETx6AjN9XQhhrjS9mEwm6UsFFndv8fF4ULIfu+mlISsi2JkG34NPHUxRNMdY59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853456; c=relaxed/simple;
	bh=dalPQlnuHSGBmNY79FwxXca8hEj5CG46UpgEtlKl6lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UnPGPVsUvgyNtGGp9xQLmisQuMrMohhArLZCr1MpFz35zxziTev3DmfhjhWkDSy+g69S22ics/7mRjz/824etGSzDK4BXJWePDDWJBXkdZjX25zWgolh2UNlnMGMl2BYJ5VovBonUhhIY8ZMGvo+FNZV87bJ58JAJ3Mt3TRhfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBJPe1VH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d5c365ceso25706215ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853455; x=1766458255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cFcDQBskX+EieZGTeMb7UvLaBhVBbrfDThfVI9zuA8=;
        b=YBJPe1VHDoTvoawjPgUOYNZzg7tY79EhoECnBBSwKa7Y1umbOShS/JS+QoP+YKhKSp
         CBxUnry/uvpI4fAqQ0YbQXtFfaeiFcqIbVdibswdT3ix3SpORLsqye5rL6swGyS8eu9h
         /b15Pj6Byx9Y/hFjnAhpCe2F5d9/p+BT6cZYdMLyOWy1dlssFZaf8Z/VHCD9k7h9O0te
         KsF9XqPzzPod9W7mleJzVdWdSpeQUxm+vgQl2qJ019QBFJQo6poB2QAohVu27Y2m+t3G
         fRneQa7bqrFzGX8pKEu/PIU5SEs4FBPBKmO+LKp5492PpXU1xoskjFsnhMOLnTujMcZP
         q61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853455; x=1766458255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cFcDQBskX+EieZGTeMb7UvLaBhVBbrfDThfVI9zuA8=;
        b=B2oX6XLsBqCjNEkjx1HQy76e14D8Jqi13+8x6vD9a1h17bfE91xkDpZXIRpxCUcyGc
         n7aRi9mWNP2++Cimgw8aJD0ekX1rZnyIz6UVLAYBl89Wv+5LY/Dt/wXbo1bctE24o2WL
         LQYtZNolaf3g8kGepoeahpDQLRxZMILEimTl2xUzeliD0/gue8mskg/wo/aQVIb9Abfb
         GmT25CUeRtIFXWtyfQCjWc/1q/plpo/Ji5WETkByIQMbbHfEGX1MbqtZCKjiQ1VGp+8Y
         7hA56y4xY9O1lmECvjEcO00qdsREfxzThimJPMNVCAisCimpQtXq3i6ffJk0tSmFurca
         RXGQ==
X-Gm-Message-State: AOJu0YzFSNW3pVDCfQogS+I+35yFGLIQ6rBebl2Pj1nZT1XPmz0sZHQ3
	seryUajgKGxNPqk0WUAVQtaSYnFzkApHbA3NinFHK+mEdh5Iv7gRLVex
X-Gm-Gg: AY/fxX6DCwtM/XojnG6kclcZaRKUWUisLnR+otc2KD/TT5UUS+mAsoRNvNC9E+stXov
	Y+FdHfpJErQavMivD5RiLOaU8/X+LCaEU6eI43Ki0Ds/8shmTMGgaF0OzOShd1bJQ/0ONOaTP0D
	HMndm8ZBrAxhubpaAk1pKvPqpT+eStLTRHsb6VMRjsph4h0UlaUkIOSOz3E02HQ4ZE3mmxN0yJt
	bIpkXPuGxfUrdC521Fr/ZlxEr0dXHGnPpTB82T9jfTizXUWE5axP0j9sdMzvVFb2FU4d7iMmP2l
	4xBMIpn19HIGdVWlpY0sLzuTuAoAYKzIcCYYhkTu09BKYeS/TXhfsrq1OmudmRoHZX+BMSc7vDY
	WNORZ8bW/jK80iVJTIb022K6sOaAB6SvkoWBN4iJFNK7XLq6ijqacpfPBOwdnLvmpt3sfQA+pS0
	B9t60sA0UABnUPKPyqqgSIZBz/Y5UhIulPhjdFg4eUpeahI3A5UZEPwHz4tw==
X-Google-Smtp-Source: AGHT+IEOLKeERSn3llecFxiRgEcnZONahbOSstlIrJcsk+a+bEC3cScVzokuEQWQlseaT0hhUIJxdA==
X-Received: by 2002:a17:903:3510:b0:2a0:909a:1535 with SMTP id d9443c01a7336-2a0909a184emr81374965ad.11.1765853454588;
        Mon, 15 Dec 2025 18:50:54 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a13cd7f1ecsm2618865ad.74.2025.12.15.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:50:54 -0800 (PST)
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
Subject: [PATCH RFC net-next v5 0/2] xsk: move cq_cached_prod_lock
Date: Tue, 16 Dec 2025 10:50:45 +0800
Message-Id: <20251216025047.67553-1-kerneljasonxing@gmail.com>
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
Q: since net-next will be open next year, I wonder if I should post this
patch targetting bpf-next?

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


