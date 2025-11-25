Return-Path: <bpf+bounces-75427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68BC84146
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 09:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DACA34296E
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39322FE05B;
	Tue, 25 Nov 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcUq0cLQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD72DAFBA
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060880; cv=none; b=nTqvnDcjdf8g4lZcmkhEuw/12iZQbDM2w7R4VRTDn7rmr6Sl458K0FXefB/jRVEbGrjINhjW9nZkW+6NAYLvg9XksEPtREMwOWcEj/AmeJZCdsjpqSNIXFgvBOo6WNSSvVfo2+Zx5enMZa+SDu5OUOoqdLHPW9Fl1YGuP4ondpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060880; c=relaxed/simple;
	bh=+rPzlTTGDHBiu7g6uncIg7hpYKpcHkzjqyHxm7RSCi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWQFS7ZYRMsMlMTMfdSEWrZDi5dkS5pNgzmAiW3tSVLFIkqd529npv6xaIwFMvtyDzz5dj0MzWtzEPr2m3HhRAfMmUthhH3L8ArL3thNtWSLfvQonQpBDqxDvsQ813GjeG6sE8imjkg/4jc7m5Ajr7W6cPlYQU6o5BUKSc/jgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcUq0cLQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2955623e6faso61531985ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060878; x=1764665678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2d7ZWjlz2JDe0uOm6xYACisrKq8Q1WaOIOi31l+DVw=;
        b=YcUq0cLQWYYDtcfpqBURMPnZLmlPohvJUbTFePqg/UkiIqbXfRnPEsl3cW9vyY17Pa
         LoKAA2f4Czpa56yi8dsQK6OtF4ZKLAYnKRXV+CraQPH81teZGzJRCIKInx1BIVC7j2VU
         6k7V76dga4kFFSmwcUqD44D1jqDM0tPIo7u39pce+hOV5cxbDZgOIN7UsCRTYWkUqUhT
         dvCgV2An+Rg3hQB9HZqAUhoj3JNGU/9cO4TcrZ4/oS1o3Y8Hvk1HeHgwmm45sJXwGy8t
         w3WtiQrH9q+F9PAf3Jgs84ANXFBh7AafZ0iICUq2xizlUv5CxfozgOaEDznRTZmjk5Vn
         VVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060878; x=1764665678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2d7ZWjlz2JDe0uOm6xYACisrKq8Q1WaOIOi31l+DVw=;
        b=jgrCBGiQ7NKMsDoQxhzIRyTRzPkoEOIohj2K4CRQ77FQzNeLBkOB/nifBifXL9mEXX
         solTJHI6WKEZVapAswyc6uqGXLm0Orwl0aU7r0FMluqDzdHTKikt3Pdnu2J9BUoxSCv6
         CTtYCJUaRWGuzWAvq4t3Grb+Mukb2/whzHHi/W4h8sNVJT/V2knqSIsSi4aDZcCWRxaU
         E2x7h75rzkH1YYjce5RYL7HKwaTQMF54C6ASbYrh3qW39gAIxOG7ASogyZmXC1o4mddz
         lQWLCmfh79NsU4jWWePSMvod+LxOzPYZp13FqKo012mhA2QJ5HdbG6ewh7AyT03nNoiW
         oKGQ==
X-Gm-Message-State: AOJu0Yzep27JM5z7pncOFW6kxBkqp5YRs+BAuCz+7wpp99xClJhz6VS6
	WVhhuwop2lkFpbHZu10YDeD5RRr9p+GiHexHO/ll0ZLiMjXGPCUkmPL6
X-Gm-Gg: ASbGnct8dTnnAX/lj+io4bFqeJIlt1ZEWX4tKt4Zw0W5OOBBYLxZBOsI/OTnyfIuxYk
	byd63dMaeZ3/z4y5wU/qVMWKkTx5VirdDFqSHdaKi17fKTcrU4NDAiI4Jzl5TnaNcaReWlno/iC
	mPCjXkiQVGDUAmT3zbwOLyOypd91qmpYpXZtaE+wIm+BT011t95DGGwgHDKg6uddhp/O8qhJiUT
	zJvxrzLCg6qHlWIcl0ou7FoKcJcWFeI4fn/dpKjr0CbcFdDKf4ll4d13VmQZs97dELdJs1uTvMC
	wE0PIueQjex2kHlAuddKRzzkKaHmbHVQ1EmrF5n4Hd4/NyAawY5oe5CQRnaX+UdIADhlxHYxirJ
	QajmdrZgKQ9nGRrz0lRN9I6o0L8HnI/cfoaTaSj+aA8Qh21VXj4Ja4l7yXtuvn0IHPeKJZDirb1
	NvwLHwmduKiIYbevvQ5j5W0otADn63zMcyiGz3G9qFJ45dZHg7aU+d4K3btw==
X-Google-Smtp-Source: AGHT+IFGkQ27GCUa9O+yUVXV2TXGWxmYrK7j83HZbm38J36zxWZGE8Y2JiZgqodn6lng86q8YrtWeQ==
X-Received: by 2002:a17:902:f70a:b0:295:a1a5:baee with SMTP id d9443c01a7336-29baae4ec26mr23315085ad.4.1764060878302;
        Tue, 25 Nov 2025 00:54:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe6dsm15192263a12.34.2025.11.25.00.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:54:37 -0800 (PST)
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
Subject: [PATCH net-next v2 0/3] xsk: introduce atomic for cq in generic path
Date: Tue, 25 Nov 2025 16:54:28 +0800
Message-Id: <20251125085431.4039-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the hot path (that is __xsk_generic_xmit()), playing with spin lock
is time consuming. So this series replaces spin lock with atomic
operations to get better performance.

---
V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review

Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: use atomic operations around cached_prod for copy mode
  xsk: remove spin lock protection of cached_prod

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 23 +++++------------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 27 +++++++++++++++++++++++----
 4 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.41.3


