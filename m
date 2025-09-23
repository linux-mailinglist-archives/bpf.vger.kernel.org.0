Return-Path: <bpf+bounces-69476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A0AB976DC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44D83B484A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FC308F23;
	Tue, 23 Sep 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcNpm8dZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFC1AA1D2
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657641; cv=none; b=KFvL+EtrUin7DLlrBwthrq+ohS/inYrMMOpqFyehPlW4qFh/gNmD7zEP1s4kY5AYuRFZVY5zksSvPisk4GiNVR4KkN4PhuKjC8cJuwPPxCjqRW3B0ipKQnGigrbz7l5k1L6DqKkbj9tDwhUae0oLF6Wj8B1RyaQ9QCMzDQ3ju+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657641; c=relaxed/simple;
	bh=DUqNL0BxXw9yb60YTESlG8jt6nJyQ3pOZOLBywKCkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8b8Oru+FYMWcquF4LKCeTm21ok2dUbr5yCOwyCWY+DNZhLlShdwX9x+RXCy78bK333otUCsA3eK9Fi3fHWLZtDL1J1nkilaWTIDiG+9pmwYynn+w4WqnWQpCBD3PTDhiR+Mze/YNOmMyDhCuIUx+8mJX5jRuEzD+XRR+r1cnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcNpm8dZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2b8b6a1429so44645266b.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657639; x=1759262439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=lcNpm8dZWF5OfS0HG6HWS+OcptiMhZrL5K7rWXoxiO0aYfHbsyU/vb4j/BZKPfbGDB
         nf+iZ+DO8U9onqu2AJ3rvCsoSBDcPlM3+HW9dv5hy8TknhnbSVWSheHg6jE41UDG6bOC
         sY06ZNBeBKk2KTzH2SMfYAOahulTaDuUeYyNDviGKQBPh4AuzsHncPwaFaW/bq+1Lyz0
         i9BTGA1m65P/qxGjyAwLOKNac3Bm5vv0Z4E2GXTMSSiEF463dSLINFpOY641UUcP9XUH
         Gb9FXnd5IkJbLzTzuzxYkFOtw6DcsKVAQay1fPoKtGIK6ARKIAwoqHLa8HymNyBlp++2
         WbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657639; x=1759262439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=Y7d/QN30EhAz3c6sgL6DSg0B31LQKXy8yT3+xXG/AmJzzkrqBdLTEeyulLjArNWZSw
         RCxY4IBepl4G3AjXdOZCByre2RAq4fZEszhQzKETVw/wR3YhGUIZt72cbL1g5SfVn9uL
         48/JWSFN+zJDMcpThn7YCmrhyBxf1rxqAVOurtepPYfG2GvN6r2OjrTYJREcz37Lco3P
         JMubM1YFLNZDc5Ss7tXUiSc0p3WeOk9Fr9YNKlKmTtBGQ6eI2EZCz4/hvbpjRAxqoyZq
         p+WNqs2BM+2U5bAOfHapgJc00Fx83sZCpVQv4pozZIZGEcsptTIzYuV6XHgtao+uzXQ6
         G2hw==
X-Forwarded-Encrypted: i=1; AJvYcCVsMCZj/e1GjM4difjLWYp6yGThxCSalFY9DvkmCQzMjlqTR5gdcKE4lfwRe4QU6TPDfe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya99M2cFuwzS72aedtw1/6I4NrwOtK24qsMllbDqIT7S3hJKNA
	ffdKJBDrkivBLCkN0OluLQN5ol6Cg0qnFhSm+mP8Qa2ukH1HvyuC30wI
X-Gm-Gg: ASbGnctTjLDk+fFrkJhqXYm26NTFERlSQD2qpICJQEnCbFXDu7j6ZYalNjvvCeiRrR7
	loazkprLw7P9Om6PdP+oPXYxZdYf8IMxWVOtzIJsbitPh6zuQJhYKQ72RaqoO2n19sXsJv1wWLm
	YqTGsnATlI8IOI/mKjXrMBtR/EqxF4YMv0F7SVe09MuCeyeQ1bwnin8hp65INnvdFLtcuodM5OD
	EIuGRNtlyxANs7lJonAVPyUC0BGtAUaVH9z8EOfEHTdtVV3mMDa9IFkJwaHyBe9IOHBKcjhA6X6
	Fy7iWggx5j1aZZRAhvabGTHWx8IcA0ADiu6FElc8f+SVJm5wl0EStzyZATdFrzm02O4y76ehdnb
	SRWdJvc/W9lAsVjSJzrVbIDM0
X-Google-Smtp-Source: AGHT+IHN5XcNp/1KJalZXV/5R5ZCq+blsOxXx3/x4YcOoDnXFZxHCB5DKHENkTDjUloqq8JYpW2v8w==
X-Received: by 2002:a17:907:7b8c:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-b302689ce0emr142054966b.2.1758657638404;
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
Date: Tue, 23 Sep 2025 22:00:11 +0100
Message-ID: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Mehdi Ben Hadj Khelifa (4):
  netlink: specs: Add XDP RX queue index to XDP metadata
  net: xdp: Add xmo_rx_queue_index callback
  uapi: netdev: Add XDP RX queue index metadata flags
  net: veth: Implement RX queue index XDP hint

 Documentation/netlink/specs/netdev.yaml |  5 +++++
 drivers/net/veth.c                      | 12 ++++++++++++
 include/net/xdp.h                       |  5 +++++
 include/uapi/linux/netdev.h             |  3 +++
 net/core/xdp.c                          | 15 +++++++++++++++
 tools/include/uapi/linux/netdev.h       |  3 +++
 6 files changed, 43 insertions(+)
 ---
 base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
 this is the commit of tag: v6.17-rc7 on the mainline.
 This patch series is intended to make a base for setting
 queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
 the right index. Although that part I still didn't figure
 out yet,I m searching for my guidance to do that as well
 as for the correctness of the patches in this series.
 
 Best Regards,
 Mehdi Ben Hadj Khelifa
-- 
2.51.0


