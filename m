Return-Path: <bpf+bounces-74357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D443C56430
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 359A8346F49
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A46330B21;
	Thu, 13 Nov 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6+m9Kgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C9DDD2
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022300; cv=none; b=ADrXEQp3+N0dxYn227tOahRk/sdh1VE5Q/74fAujy3LtQUlS5BafTHC9sRK5IEbPzrlCVoRWBwwpbZiG/vbUTcAo4zvTDvFU+bu3NMOBbG1kQvxd7qcRSdj94GN3TncdvOTxoJrjuBjtYCkdJth+wy4N6+HKYri11Xa2IaajDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022300; c=relaxed/simple;
	bh=pXLpg1P+NszGM8RZ98JaLiDfJk2ejEBhbCKCWa8Wy4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5vltt6ZnzIAmaHGPFLqDuGyC42S1ATfelTYYH0gNca+Pkr814+dh0Gsqlezr2q+Rkib0bfwB/b92R+iMa32i1ZAJwP9C9jvjnJPz4qA2R7Q+4DBrWQ3EK0PaVNgAqCiWSUs6FJSQ+BajBvElprfpKxxbaaB6oBlSaGQRx+ZbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6+m9Kgg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953ad5517dso6473975ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022299; x=1763627099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=Z6+m9Kgg4ATLxOnbYbxDYu3dpm05yxztNZa8oQ1pGTD3kk9DR5YRcxn4TcSSbC3Nuq
         2kI8VJTcTVuLj2N3P8x1sXf/zYvzJfCR1nCx2SIFBRTLNQBbu9NX/XaXUxR2xR/RG2eY
         WmfjJoEtBkzxY/G57J7RkhV4FaTfHYswK8/U8CFBvHeu0HWNjTTrvP95P4vZ4G5udc/6
         rTHN3A93A+CfRaX0UrD0MjqQ9intF/RYDGB2+khUaZ+9W95LU0kIzlTEi1VmnnstO+sF
         6k7WhvHAhs1JepKhG+Z4igiU9J8ZxfWXfpFH+hIBRMX3TO+t5d5ObsSOJZblvx6m+9nC
         8qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022299; x=1763627099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=k78mtnhs6xUci9C79CtkxtIS9hX6ERKBjYrE9BH8SmQfkh8Zy+KGsyT18Z2ToZgmke
         LhygqvOgV6fxYm8zxSKfDiuW0CmBnxHydtcS/esGjsXOftyHopEL2pvT8HvTZz1fMuHZ
         ToQX+Psa9u0xFY+oHWKcOBP0jRujFbytgu35PNZBmXfMTyUPyZXI2Jn3iJB1sS6bIRWB
         iYJg4A4Kgzmm5QhkirlSqijJtM7jvdLLAI02DDFmvLU8q2HbI1qjX/+dM9yxZLJKQE81
         8PJ6XUDu9FlX7qyB7zMFky7OV8oNkHMKdvtZ2GOYk6xN19ZyxTtCGLr5Vcr1WySJkveZ
         LR+w==
X-Forwarded-Encrypted: i=1; AJvYcCWmBXWoLp196bZarrwX2CEs9Wnt/uw8Io/ugRbxLJQovNd5L4uxI6WcFtz2LIXMYoe5elg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPkMWy7JfTBfnNMMh+DyZUhzbSBWZgfiN2UXoqDi4mCzNWHKXm
	mDp/WOUpD1K3pCCVvZ5jgMMCZzilMfyfb5WiYeXTo44/VPKDLRvynmwh
X-Gm-Gg: ASbGnctVSQcBRDpDKQZIifSUYctc3kLWyHjOAy5FazdJUgb6FF1Gc9Fi4LXGb+3yiWx
	BQ+kKdUO1dinZPHXPg2XyFuVKPnDw3aNlX4LxBnl9sxMuMkpKav0U3CN78U2jo2bRQxir2gQH5y
	pNX4ZubHmpiFQqZy9aaf/0cxvPGuGC5niqNvY7aPZ496c4KN+xO86lvBooM0+POCI+jGHRMhyJZ
	QApMe5miMcqM33n/cRBtryZLOzNJzilLaNUvGe/5MBSsl6V+ODJm24NHElfCZEDcI2ggL/rxN5f
	vHcaojhzLV22GpEncnvN+tcXsmtwNwerrT2y6tA4o6BSfvJhAO0IXj9ND+I7kzqCCMBitzYvqnr
	7LyoywYLrwA1+m7AJjZksf+LUFx6SflYpd36R3a/KDAdhwRjdR8HVxAyy+mbRePJ5aVri+PHu6y
	N0bROwqBSo67M77ZJ/gqQQ1GQad5f2wz7VLlO2Dxw=
X-Google-Smtp-Source: AGHT+IG6G8bRlTc+7WY76hJfvUTnoph43OEFDRSFR5ryUFHLWUxOfe6SWPhcIlsJWUCZ9XOhzdKiwg==
X-Received: by 2002:a17:903:110f:b0:298:34b:492c with SMTP id d9443c01a7336-2984ee1df94mr76201095ad.54.1763022298884;
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1055sm16332635ad.59.2025.11.13.00.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v3 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Thu, 13 Nov 2025 19:24:37 +1100
Message-Id: <20251113082438.54154-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As suggested by Maciej, submitting v3 which makes i40e_clean_rx_irq and
i40e_clean_rx_irq_zc use similar logic and a shared function
i40e_inc_ntp_ntc() to advance next_to_process and next_to_clean when
handling status descriptors. 

I've left the rest of the i40e_clean_rx_irq logic unchanged or this
patch would snowball. I think it'd be nice to change the function to
work with local variables and update the rx_ring only at the end like
_zc, but seems out of scope for this patch. 

Changes since v2:
 * use common utility function i40e_inc_ntp_ntc to advance indexes

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 33 ++++++++++++-------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 17 ++++++----
 3 files changed, 34 insertions(+), 18 deletions(-)


base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


