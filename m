Return-Path: <bpf+bounces-56563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC9A99CF6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6055A442D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6EBA3D;
	Thu, 24 Apr 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Irk3iess"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A618E25
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454495; cv=none; b=QIkYYRYIU2XyyCMToIqAFekiUjtlAZgPqI2LuO/m/yjPreghWzewElntU07SvRKjJ5NejUo1SNV4/i0idgqp4Cl8js/ofAGZh03bq5ytsfxn5X61Fi/4USU4cPvgipQKwWZd6GTdT0Xbc9oA+FOM2ul0XuWU4GdP8aaEgPAHUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454495; c=relaxed/simple;
	bh=h8wAY7qtIy5UrHIDhwmDC5fKfwUd64U5Lep9H+J6vLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIDwFVJi3mu4+/7/wZA2GOiJQ98+/9PY/wvsvUhC28ZrX8a99n1K0XTL8j+4fXbx5lcCoSIXAdaDVyPR33VeOe8S7Ph9rOcioh0HyziEe9X8y9/jhHSWyTuHFPI/Mata4OZvczQkWq5gYBeW39lKUeGz+A/VjvTk7+ixbqbCvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Irk3iess; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso508595a91.1
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454493; x=1746059293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIHmcKmXhg69DmaElnA5LLW3gaVd1eMpD/hTU28A/HE=;
        b=Irk3iess1ZWp76vpIqY5KPFENe546uefn8gu0FUv4zFwws9WeEWpYwLJhVFzmtGIJ/
         9NymRvz3kZ2/UGxkxTyOq7NsHOel9Bexar/PuFA6mjIMCKul9TJzb8r7CaSm5jS0HWOl
         sa8u4cOsXO8vdoSuPh/cq2Izhdy+ZBT2rXb+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454493; x=1746059293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIHmcKmXhg69DmaElnA5LLW3gaVd1eMpD/hTU28A/HE=;
        b=MXOWuZ0/abEK3uGYwGjJDheaDiQnsbx7f96tXgSqdweLvBuyA/ktccjsRYixD5KrfQ
         FXkMAmPF3MK5MH8tY963LriozreYmoCo2IV+YFMK8YdFo7onFfqaEPbTM3w8Ui2QC2Mh
         AUWzeKBtfr6xwWYn/t4x/TPvsbdIFLo0GFT5vdNGgV/GWtTht/j1HvpWG2g4GI1BxD6w
         9prjvRiaCjwKH2VrXsSwHYdotHbxEJisEfS5BpaTiwLq0FxUypLunfOQCKZfIkX27wYN
         Yd4DWggx+KtQPtlIj1WWXoe/xkwSNyJm+Umu2FG0Zws97C+spB9FJk9b+bfpBZKg8ho9
         uTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd11COYtf5UuKOvMoJbw73vt8bW8i0CQLFVkVXXK7zlVuDaUbdrXcOGyMGZqdQ1vc5AM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfCt4QPl8sV3h/QC4NTU1t0du3rsiXXkeC68kvIGfBlh2rq2x
	PpK0vz9zYRFA6QNpuxWIWFyXLoMwg1VtCuEi5VzhvP6EZeFXaQ1c9CsbeysIwOo=
X-Gm-Gg: ASbGncvudUxr9PZ9KbwsxPHMARYOrttuYwNb8hu/ZsxVi0kVF+5XJejO9Mpl+x0LkWZ
	g5R+W5fzbHkr+KULWkFuD1JUWPgJr9VZUAuYbgO1Pz1Gi+vdqMgyOpre+YDG6S6hleebqDfM7YC
	2MNmRENo5VBYbuSjXREkaSWYQ7mJ9hqOXGuEAl1F2WQFpyKE4PROBbjst2NpuhcYXDXExbd69hK
	bmWGbOxTt/AnQEGxDXkRH03eDJtm+9qHiPDazyQpLcElkO5Fv52pj5ImmSyTp78l6vJV+Ej3VP0
	/f0LtAW+tgkAXVvtSewu/dOoLnh0hei/dK35Lvd/u5uqfJkj
X-Google-Smtp-Source: AGHT+IETblWxuoSuSV8+WUwaLohHsvmGk7SHFO08yaKEGr+w9ecMqwtPnCysdbaJTuia4bAV484exQ==
X-Received: by 2002:a17:90b:584c:b0:2ff:53ad:a0ec with SMTP id 98e67ed59e1d1-309ed2821damr1082565a91.21.1745454492678;
        Wed, 23 Apr 2025 17:28:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:12 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
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
Subject: [PATCH net-next v4 0/3] Fix netdevim to correctly mark NAPI IDs
Date: Thu, 24 Apr 2025 00:27:30 +0000
Message-ID: <20250424002746.16891-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2 & 3 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 3)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v4:
  - Updated the macro guard in patch 2
  - Removed the remote deploy from patch 3

v3: https://lore.kernel.org/netdev/20250418013719.12094-1-jdamato@fastly.com/
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
 .../testing/selftests/drivers/net/napi_id.py  | 23 +++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 7 files changed, 172 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: cd7276ecac9c64c80433fbcff2e35aceaea6f477
-- 
2.43.0


