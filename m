Return-Path: <bpf+bounces-53788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E778A5BB3C
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF575171888
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47702288CB;
	Tue, 11 Mar 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs/aN5X6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD61DED63;
	Tue, 11 Mar 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683393; cv=none; b=OO2oRK4RkyyoK/oKm8/fGnLR8+hHFZf6ZzhB1cjLKn6O0ThrQxA2rwLnYIbWt0HfOy6plupW25V4rq763pE/uF938h/ELJaQyyb9NCt1StG7xKzVbrIVGbF/UCwDTuNIDpsd5ow9eJS60rJxJbQLCLWZnd6/z+cmjwDn1zMK0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683393; c=relaxed/simple;
	bh=KHJ61QWzKw7QJXechSjHFjdLPVCALVWUIQuh5jW09Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g44zzZIeAbpCOO8zjBzjJoNaQrXj3M/eBrACTsXqNvY6WnsppKu6kEMRmXWWGM9LhNJFH3P0A1Im+suwI3oKutC32Mg+oTbQ77JsMUASST+jyI+QWKxJLmhbbRxJwrqqY1f+jFYsHW5Uv8rX/PWUGzoXyXY8n8g9kP8ne1yADbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs/aN5X6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso7319276a12.1;
        Tue, 11 Mar 2025 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683390; x=1742288190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bixHXxIG1NNufeoV7lBfe8WWM+Lb7vo/7BEU455qMWo=;
        b=Xs/aN5X6SBO2Nvo6jm4Byr5Au3eRSXnSdcGbmal/gWvjMZNqFaaETaulMmBg3rzT6i
         0mDldpQQm3zCrW02D/Q3Qphixv124TQLkPegMJB9UtVNI+Hwelfongs10Oh7jMJ3iQIJ
         7h1IxX9cnr3pkrsxP/rWrzSfjWD2sKbkgFybIODU01uqwgDcX3cmVaC7wV/18NXq0qu4
         9H37m6vsJS5ueP6CbomyENajlpO7ZzrE3w4S1dofvsv4GbsWt1go0EEshYNKCf+kMVT0
         gVgNGNwVUFyt5SoPWFh9hw8VfFSZo1BnrpeHMHFHCCnYIjWYBImjJ3M3o+dxJ7X97xYr
         47tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683390; x=1742288190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bixHXxIG1NNufeoV7lBfe8WWM+Lb7vo/7BEU455qMWo=;
        b=uBAQ20Ss8Ti2LvLxCfilHWvMT4E94w0q+OBXfDycdl/UtWvYVig1FFlIk7oXihaaIT
         XoUnECjtxzwJAT/c4z7nTcHQ0sWpCRm6Wy+1xolNcfjntvo1K+DvZ0gJDhbX9OkJLwf5
         OekD4UtCkl1pY9SH2AFhPinkaykvolPIQDt2di7UCTVjF4TXqPmWOhFmoQWO7FNFkBSk
         G6oN9gpjnsKAAsC8d3OgwEPKT6UUggHmAoca6zPatsB03YxQ7/gYsiIOOPXUCEw6oU7/
         KIXPjCippw5FSZ+0PJ4zx0Xokh/4CPl9UHiH1P5+7XE4x9yloQHNrfQHBHl7m/XVTTDN
         rPdg==
X-Forwarded-Encrypted: i=1; AJvYcCW8B0qtzIPGWJUfaZCBR0FsSVdJSbvjI7/LDj3nzpPGtFkH2Jr8hzOLd1LesVivLLP9LhBevZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKshN1ez2+HCSPWvX4oCNp287CM8KsH4bhYgrRuMfw4xIaJrY7
	tB6DP8KluN4bVs4uHiwCUP468tPk/J5qkL12cMy4QPdzKcHtgjkY
X-Gm-Gg: ASbGncsQsv6xp6nv0VTdM3k1B9tnt6wcLU0cYFQoPCQN0sUdnCgfFnR3pMNBbNdZIsv
	gZVMU+41wsYRxPZC9YdREpaCIa7eSiOQrJUDsfPCiU9DbX7lrtG6d8Nw8GJh/umMbaZMbJV0Hox
	7KTBcazhtL57wtXI4d+Q2qsWzHMKW8CRCzC9WE4PGyjJnnaOHgNcf5YA4kx/YL2GkfCb/uGb7p7
	G8v0hobvKl/2Areh0tpB9VDlzdMMVdAV072nh35fp7vJ6zHyqtS6wwqw5J0tgOXMIe/N2kulQLP
	r77tI5YHfVVryczzlbUDoKQ9tsieI5YXfVL+ygTKIh3TVD5UqM2e/6K2SLJ1tTTjS9XgDw4VMKA
	FuV5dHA==
X-Google-Smtp-Source: AGHT+IEL2OeAb7DVAh3NStAHVBy6aewMB47TDlExcq8zZu2Ybvy73qpbhyInDvvqsQnC1fAWZ3wuMQ==
X-Received: by 2002:a05:6402:1ed6:b0:5e5:bfab:51e with SMTP id 4fb4d7f45d1cf-5e75d7a4980mr3373330a12.0.1741683389592;
        Tue, 11 Mar 2025 01:56:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX {bpf_}set/getsockopt supports
Date: Tue, 11 Mar 2025 09:54:31 +0100
Message-Id: <20250311085437.14703-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_sol_tcp_getsockopt() helper.

Add bpf_getsockopt for RTO MIN and DELACK MAX.

Add setsockopt/getsockopt for RTO MIN and DELACK MAX.

Add corresponding selftests for bpf.

v2
Link: https://lore.kernel.org/all/20250309123004.85612-1-kerneljasonxing@gmail.com/
1. add bpf getsockopt common helper
2. target bpf-next net branch

Jason Xing (6):
  bpf: introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
  tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
  tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
  tcp: support TCP_RTO_MIN_US for set/getsockopt use
  tcp: support TCP_DELACK_MAX_US for set/getsockopt use
  selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and
    TCP_BPF_RTO_MIN

 Documentation/networking/ip-sysctl.rst        |  4 +-
 include/net/tcp.h                             |  2 +-
 include/uapi/linux/tcp.h                      |  2 +
 net/core/filter.c                             | 45 ++++++++++++++-----
 net/ipv4/tcp.c                                | 32 ++++++++++++-
 net/ipv4/tcp_output.c                         |  2 +-
 .../selftests/bpf/progs/setget_sockopt.c      |  2 +
 7 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.43.5


