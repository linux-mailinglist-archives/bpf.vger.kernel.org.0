Return-Path: <bpf+bounces-56086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF775A9112A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 03:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF51445205
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBAF1AAA0F;
	Thu, 17 Apr 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Niit9KmY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391A10E0
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853587; cv=none; b=I8goks4b/cmYhcmRwaagEFOrlq19GFRgM9HfNuKfu2qUt/TEt1ZyO6EjUKfhD9go4M6TWFTvsIxEiCsjNXIbszdZmvweXQiM4qV6Bdb7pzpzzWJ8FYoTrsmFaXGRYeILI1zNABlnH++Dj4X2X2JQmEgaLgdHoWJSvBPnxpnYK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853587; c=relaxed/simple;
	bh=2xULYgcWmIJIehHFYM/bibVezPdaJmAJv90YTx9g74U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQ5ZWVoodrbhzosjscbJgq00b+HNv21ZN5lIvLB294mjjlwlhrfeI7R080fhxws52kEriYiNvhWN7H0X/1LMAvB8OCl4mJLWQSGuIYnAszdfDQQ7WIxH/4vm+u55O54JVl0+00xyqyThfIotH1RT3mVULZcW5Mz1v1diPuK9pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Niit9KmY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso3275165ad.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853585; x=1745458385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=Niit9KmY+zeqZb+KOolZ0UPw8k+9oFE9HAUxH+EOggwLn0LbFnpTqB7MfJyHqc3jYz
         dskzprgL1yZRgw4itsd7cz188OasiYGAbtVbw2KnKTKziHlS2ZQy0dfkoMvQpkqANJss
         BP1B3dONTAbPh1auPbTt4EqMAVe9IuB6h1UEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853585; x=1745458385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=nf1viz8cApOY5Ad7PrEe64JX4o/7BIutC6WdXMQo95CCupejSlvVASQlR/7ETUeDbm
         qFxlQZT84Q1bjnpo05WQ/pRRh7SSun6gxgSDq3ky/yyQ1rhlcsSRO70o/6lxoM/OC74q
         W+tU/TW3cqXKOUFfN8g7gfczMAVW1hxtEa5N3y/yfFkoXYE9A+YtXKPo5WB9OLWoM0J2
         Jy9LZLH5PjcPRTCad7F8z1JPwc39hN9hdn1jM0DejvzMC+QM6mdCkhSahVyeCmNAwjeD
         zWaayXjdUW+X8ZnkOF1zXd/gkdyLTWcpUNhyDc5KqMg/MT+ulfoXdwSA16L4+oLHU4pM
         IXNg==
X-Forwarded-Encrypted: i=1; AJvYcCWzkGiXeCnfQRA9Rw1ePS3t/Vfuj3flTsW1ZgFQ6BGydoGxzGutkfELqNROARIP6fg/o5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VID8f9HtgNzjhbxdrr2XfExnvSod5Dtb8yE2VRFOuVvwnV9o
	yuSUbD1P8JEHspQgm/GyziSG82dAR4DkAGFxhBdyx00miLqQNK4kyAHatJJA96A=
X-Gm-Gg: ASbGncvMm5KZFElFAjoq29OoZYvselAgG63O9ZvgEwk//1HFqtGSSkLiQ8x7Wzl3ou/
	4PLWHjVCChH0jKLojJIlo53OKnNtLJB2QcumOB4USdjPF6Eapf3ob+ZJcAIaPhi0yKeSugBGiWJ
	4eONsC6PIDRZPsq0XTpJ0bvkH+eY+rwri+p5v6Nd6CMSLPf0NHngoZGOxyiRj1iC7lUZIanoKVh
	Vx3kzdP2A8QIwiyJaTkeGImrwA2JuGsZs8cTfP0xC/LNQYxetmRp2CO2Oz8JKmldxvGqLK5D8th
	tY/aAMEsAyPsyXIGdONZkvMKJx7mOKqMWhXv3E0zgKdxx9ewStnJi/0L77c=
X-Google-Smtp-Source: AGHT+IEfKQ+r/gnTBZHe1EymGe3tKAmJ5TO38k1pfoylMUgPGDSds01vW9UdN7R4QlZfSpduWCIKYg==
X-Received: by 2002:a17:902:ea07:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22c358dae13mr58260805ad.21.1744853585258;
        Wed, 16 Apr 2025 18:33:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: [PATCH net-next v2 0/4] Fix netdevim to correctly mark NAPI IDs
Date: Thu, 17 Apr 2025 01:32:38 +0000
Message-ID: <20250417013301.39228-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2-4 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v2:
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (4):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: net: Allow custom net ns paths
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 tools/testing/selftests/net/lib/py/netns.py   |  4 +-
 8 files changed, 175 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.43.0


