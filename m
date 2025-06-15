Return-Path: <bpf+bounces-60686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE74ADA242
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058433B03F0
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A233260562;
	Sun, 15 Jun 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT3biLzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA17262B;
	Sun, 15 Jun 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000467; cv=none; b=Llfpxi/JreApK6ILyK2/N761SXju2bd1nmKOJcw+UnYk/yBiEQIXZb7Np1RPweolrGau/6wZo0WcV/DqU2TG5YkslrjvNs6OgAECWReJ4lQ5/wy54g1L7WdxKdju/ClYADVMG5Z6RJKOzNKa6MRx9RT487D3UVEljxi+P7U2dy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000467; c=relaxed/simple;
	bh=JXYf5ZbXaxd+pTT//xI/FT14s6VC8aqe+LnXcuWiUc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSwlayA00mc3Kose2LTIaeEsoRBrYYuPd33H8r6CAU7C5TOhasv11dnQyDg+6AsKtkTyGX6zHaIO4LV6K53dx8WEnxp1zd4vWv+ZcOzuuTEM8EkGqJ1Txks35dYa6DT/EM0yawQRCUEzHMWKWmCFk8evKriw5+1ScKzhpQQKB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT3biLzZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748a42f718aso726370b3a.2;
        Sun, 15 Jun 2025 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000464; x=1750605264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeCjzQfkB1+ovbUpzeze8a4duFJQQau/6t5f8myV+mM=;
        b=WT3biLzZBHjsz4XtrpLVfdBX1Mobe27zr7KLcY/ICguNfgYfle8+xebywq0gX6C+IW
         XR6zwW7HjaktOjcGHpYEF1gUKc2E6mMM6Rh9Ta+Cs65/6IjcHMpBoX6oisZP8Cw5UXcS
         JEL4czQsN8VwEpMa4oXnxP4fIQNB1wPQ32gdneZQjHMOhyzrx5xj6xlEjS+NnIGqUIu/
         Jj3dLYUpjIFe29c+GOKM7IX7i50HfljQNzxgfUKpcTBl7JRPuRXM1f2GUqinnzG3+tcb
         57+P6Ox5SQCxiQ98uv5coVND5Vx5NJYuPQ/OTmwYW3AkyumVChm3QE4o26PU5sln4p8Q
         bxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000464; x=1750605264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeCjzQfkB1+ovbUpzeze8a4duFJQQau/6t5f8myV+mM=;
        b=RnoyVk2cwxh4RffTNT7AUe899vkzR4+c9CmJDGQWBs6eqQTYcw/YtsMC0K5tKWTbUz
         vIzbak1CthZuAN7OxIGfv/1DryAm3vTHJo2IDkrzoW6cpVW2/3kHjoTxLW4llH7sw5VZ
         5+fZM6aWI5IPkl/x5/GFXm2Kl1eImrbKfHX8A1d4l4iFb7J7xg4bweVskzL4UwP56eaU
         TnujexDFavi1PjOzXRX2WXwa9e2XNm9xG/ccn/ge5IIbFg78Zq4EpmfYhubu30REF/z2
         YiWDVe4/E5C+Cp66bnl6hdqlgrc8M5OyS5KmGus3eUDroYyrN+1DQ2hmbL6KsXKWvg6T
         RrLA==
X-Forwarded-Encrypted: i=1; AJvYcCUCm2nLgEY1Af4tAs1JyRwFZMzX1OoAnyacF4RgOOAN7mDZVDaV2FjY6WJ/KqWd8vPE7nA=@vger.kernel.org, AJvYcCWpni1/lA+s5HQ6SCDo33Poyc96Wm/6YOL+pHrFTxeyPnhjw2KcnbHDdoV/aNj7W9KlGq2UEYEyRivMEPWE@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRW8NgYa3d1FGWOeD1xt9qN+cnlFFxIOghNaWVYcX2z5IM91n
	FO9XqfKDNgK+vydokPVU56r/JEUczJse9gxtTli2Lcbkz6KlpuliHCJ28Q3e/g==
X-Gm-Gg: ASbGncvNt+ZZlPRRna1GxSjs7/XyjZ0gPoMeSKcwdKEAZJSufewsjxNWUeQj9QPrU8+
	pz72qIyrew1Vg1tKvJumSMDsCVx6i5M7Uh7B0ufO7R6dxMQYXfa3SY0FfHb9bnWu9ZEXlz25md7
	WoFdftwlbuBUEXbApNG6Yhq9T+/mOhnI/CLOX8t/hz8CJq+DQpG+2eqZv5rxnuU/JGXoaRJWsJr
	M17Hc0gKJeGfhcnD1QEvRY6whvsgbqjNDYo0CIR1BDYG/lkh4Xn4rBRuZK+0Krkf5JVP1StF2Th
	bInpeHYngRUjj8Deqi362StvzroM07mwOexBVsL6iBxttQbqcGSUCYJcqIdqPxYz/OuPNbxlhNu
	Saw==
X-Google-Smtp-Source: AGHT+IE+Dh7qkuSto2XPVBxAku93xQd1vexdTf/BYTpDRoQLi3HYEYrUq311ENiBH5Hu3V/gp727VQ==
X-Received: by 2002:a05:6a00:99c:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-7489d02e3bfmr8658913b3a.18.1750000463919;
        Sun, 15 Jun 2025 08:14:23 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:23 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sun, 15 Jun 2025 22:13:31 +0700
Message-ID: <20250615151333.10644-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains 2 patches for the zerocopy XDP receive path in virtio
net
- Patch 1: there is a difference between first buffer and the following
buffers in this receive path. While the first buffer contains virtio
header, the following ones do not. So the length of the remaining region
for frame data is also different in 2 cases. The current maximum frame's
length check is only correct for the following buffers not the first one.
- Patch 2: no functional change. The tricky xdp->data adjustment due to
the above difference is moved to buf_to_xdp() so that this helper contains
all logic to build xdp_buff and the tricky adjustment does not scatter
over different functions.

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 46 ++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

-- 
2.43.0


