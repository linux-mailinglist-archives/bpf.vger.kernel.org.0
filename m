Return-Path: <bpf+bounces-56213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235FA92F54
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 03:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E668E3D2F
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71A1DA31D;
	Fri, 18 Apr 2025 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KBwZwn04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFC184E
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940264; cv=none; b=Za+sBEPONwX7v6GvJEWqUvDZv/eFiH3mzMShgRHr77ArNJHV7yJOg6Tc26M5KaY3qWWusztwtNjCfREUSJ9O6v0CR+OTH/HMllh3XmSxL/zAMtw+nwXUdC2qtUtmQdUzB9h1mJ/6NpGdRS+HF7F44X+pLL9lm1ZauguqUOX/uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940264; c=relaxed/simple;
	bh=83ine0mrSdz+4LSvDN5s7gcTAppP0Ss3rM2gY/WezSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l73N0FqNYvA9/xWUEQEUDUodb/aT6NWR5mnO8N/v1wplZv5rpzT83coirFVgGpZW8L4qG2XA3sTplo3aPeluauZPohhUs9fDdPHRrEPIFl7OHE9UtsrpscFpSwBT/C7KftyIecmfQ9mgh1dQsVClF+HCAFnHKOiiuuQEz0OtSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KBwZwn04; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af579e46b5dso996029a12.3
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744940262; x=1745545062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=KBwZwn04q/Az4CTzRDbtKoSU00TO9Z/xrWcUsw7FM+2ozNDJiRe3Ps777sLenVxfv0
         Hs+fzwD/qoGgS/vO0s0GfFXJqE/JEl3pNsiPxu0NViu5v6gqgmhkb+VfggCFol6FVNDP
         np2CMOiGNp+thzOhK4wZrb/c+aflqjbvFCrWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940262; x=1745545062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7I8NgF9RlR8FwCsr9V1VCpYsrKioxWgjmoDan09dvi8=;
        b=U08M4k3gRsZZG7W15d5/uQzYws4hTZfjMSn6Sig9g/MzKXZb+RYFEqgBdcxKASs67D
         zhWru0jloq+BALWHfvLKrZvd5AFuiDKfmLqGhlzPs7bFxCOtBtczJskDSDvS3MEvNVtI
         wS8RdqkqaW0REM/QyusZBdSFgTGA/t8fPWEpvuay3YNlKJWUIMlwPIOhULtHuExNTRTQ
         MmqL6yH2KeK2W/Ju0BNwFo+U+W/hhTkrLBYzZ53IdnHYUPRVW7e6Qby0vqhvAmN42exk
         UlS3uSdMkOHQ9/GiBTehbHpm6mFhvM2CJ2qDQT6hF9eyo1KsKo1wOEAaDq1Q1bDiAotT
         4psw==
X-Forwarded-Encrypted: i=1; AJvYcCVxtkxfGAPIIoOOOVgvipJiUSLTXcCuGivbUi8XKhBlU2gayZw6vDbwHrWikqC+BiULyLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvL/4vsn3ji/oPNGe+GWEj3B/NWp2P9DKvOEXO9ifVZo4tKI5
	Kxu4leRFceuN8ILIO/+sj/cBtXrfGi/aJyOL6Y/sYwkPuZ0vGCR8m6FGCO5Jyj8=
X-Gm-Gg: ASbGncto86rkp1Q6tPBWkFe3VGEin2GsuhG7u/C4xnQjwkksj6MxF2xOmynqbO3W3In
	JyJeQjGdIK++H3b/HAfEbDCoQ80AYnf0wPZdaT+jsf5Q9AHlM2S0WnVrcLXiK2Pfp9RVm9Flnu1
	lUIYOulAQSiy2vvIP3nWLLd0WWPlUOWnevjBs+5mnCIpbaiMVpzn13QwWWAony/mx2heae42NwI
	5sQzUgrngSKefntYxbDGDqbHgL/aoFbwcLLL85ZsFpnioBm51NGScIyODi83+YOJPyCH0Z5e0cU
	tbNtwxqCkQcSDtzpoWKEBSDmZVNXFuYy6NnIv4icWXGFakyJ
X-Google-Smtp-Source: AGHT+IE6KmDOqTadvPBOoP6NCbep8sj/+WD00V+zMFXa6ok1PnWjm2kVgaHVjOv1izpghACtKB8Bjw==
X-Received: by 2002:a17:90b:568b:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-3087bbc4d52mr1273243a91.27.1744940261993;
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df21278sm131772a91.29.2025.04.17.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:37:41 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	shaw.leon@gmail.com,
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
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v3 0/3] Fix netdevim to correctly mark NAPI IDs
Date: Fri, 18 Apr 2025 01:37:02 +0000
Message-ID: <20250418013719.12094-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2 & 3 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v3:
  - Dropped patch 3 from v2 as it is no longer necessary.
  - Patch 3 from this series (which was patch 4 in the v2)
    - Sorted .gitignore alphabetically
    - added cfg.remote_deploy so the test supports real remote machines
    - Dropped the NetNSEnter as it is unnecessary
    - Fixed a string interpolation issue that Paolo hit with his Python
      version

v2: https://lore.kernel.org/netdev/20250417013301.39228-1-jdamato@fastly.com/
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (3):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 7 files changed, 173 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: 22ab6b9467c1822291a1175a0eb825b7ec057ef9
-- 
2.43.0


