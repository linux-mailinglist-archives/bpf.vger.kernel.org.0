Return-Path: <bpf+bounces-51250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F0A32758
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B3F7A05D8
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158F21420D;
	Wed, 12 Feb 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ObAogfSp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA120F07A
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367725; cv=none; b=S47F7g0M0iNqVboMcCCxSXc0Ae9CvGc6Clz6Qe0hMjIFexB8pVakSsq+lGU1gW1441X7w2PZ0ZAzuQnk7bfVLMIhHyhGnFk5C/EshZcuuqpb8b5sYg4dBhUcco8PvwMS02pyB7fdjlf5yrkYSDI8VLyS9t/Iscj/zEO0IXO+wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367725; c=relaxed/simple;
	bh=HzA97DPnn+U2gZkXV8YQI5t4LN4Nd9v0u24mxG8tzFo=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=a/XbYyQtQqK7WGTdzxVXlYMFTZ4IL2W6sLCE8U4Y++hkGXPudOPstkePYQ9ZhOLQAPUsj/UlufQ4IdlJU3pEQ/A7Wip2Sl2V7a6O30fJ8cBn4fQR3thzjwaL5EgRWolIvzTdaohoJvvSuAvL2Nf+ikXFDFepI5SI3DlGlouvXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ObAogfSp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso1187520a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367721; x=1739972521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vx4K/GwJmSxxuxEf9CYEVojUHCwqS7V2m4wDGfnHgXs=;
        b=ObAogfSp60miJjwQ2qilScjFLmjvSMi58i905OlYlQxPJxDUpLIIIiPpeQPDsnr8Oo
         fn2QLXm+eRI9aodVrw7FVGGz/I/KiARDksK0Q0jUNXZx6RtuHB7uhzv4T/d94hzOBaii
         gF2xLtnYxowDS5lGEP4f4rjWtq8Qg+1oEskR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367721; x=1739972521;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vx4K/GwJmSxxuxEf9CYEVojUHCwqS7V2m4wDGfnHgXs=;
        b=dt5oqubQC48peYiKHb9aD3IvXaeDjdbtoP77RmTelu+jyhSTRza8FKY1n7RAYjNq0Y
         1LHxrmulZRIuRz9UUUGzDE/SoeDmfKTSQLmNkONErgSS3S8DjnHzL/9SWLxukzX/8hIO
         XAhqbnuQR8e05n3ZvfGfvyZmtRUMz+01LSawYu3KecFzC1rBeq75CAoEse30Vt/uG7s0
         s/5dmZB5JgATO6oZyD4IFjc/DeOTNV1IIfjbEYoPTLBNp8psjhwAxKxuGIeZJVYL9wGn
         rT+Le2gK1zcs/E46zcmi9/WeDAtXjR84GFd4vJwx5cLN8UkRlcdTxgPDgjF57pYoxVn3
         xjeg==
X-Forwarded-Encrypted: i=1; AJvYcCWMafl3eGEXg72N6OCrWIGdEAxJqHvMJWF+IVFQc9RWA2s/97fDywK7PzUWsyZwPetgkEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5JHi0PJUKR6yJNapU+iDT3deYGVIy+wRAVfwSt4Azcu4x8l5
	3/hN9rmHLOsEBPk8ipVJzzRRtZJ+3oQ7FIK7YUvLuWLVUPjKA82L+Mr+PQEPmkdMTeAn1CvimA0
	2hBttxDumEDIh8fTzwbIFzvEndqcVAUGvwVtFgA==
X-Gm-Gg: ASbGncvh8X0BdSOKkd36W15j4S+RCygjq+xm+G7Ft6ErHJWCsaGU9pukJbLf3NztSnE
	ZKsm5sWg5QQa0qzuPd8xUy9K8k9vRTLKsRofcvWfIF/umsvMXXrdFGclzyr0zhW0cMGwKBA0Srf
	lNw9MTpWIwhr17E/3x31JAc8/A
X-Google-Smtp-Source: AGHT+IExY+577RFSkgohoQb2qPrtldLo7ZoR+uTGSWF+pFLzLK8mEvgKjNwZyU3Yafymz93SmD9UC67l3DwKniJi9kE=
X-Received: by 2002:a05:6402:4606:b0:5dc:da2f:9cd1 with SMTP id
 4fb4d7f45d1cf-5deadd7ff22mr2750686a12.14.1739367721337; Wed, 12 Feb 2025
 05:42:01 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 08:41:59 -0500
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 08:41:59 -0500
X-Gm-Features: AWEUYZlwmvHKRwI2fJFJaa53LoTAcn2hU8f5TdJuaF-vAvBD-4SwZmnDN9AK2pE
Message-ID: <CALALjgw_h9ToEaiQdKebyp0KLgJvaHJuxyLh3ZXAYgz6v5SL-w@mail.gmail.com>
Subject: [PATCH net-next v7 0/3] netdev-genl: Add an xsk attribute to queues
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, Alexei Starovoitov <ast@kernel.org>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Daniel Jurgens <danielj@nvidia.com>, "David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Greetings:

Welcome to v7. Added CONFIG_XDP_SOCKETS to the selftests/driver/net
kernel config in patch 3. Updated the xdp_helper.c to return -1 on
AF_XDP non-existence, and updated queues.py to skip the test if AF_XDP
does not exist (but fail in other failure cases). Tested on kernels with
and without CONFIG_XDP_SOCKETS enabled.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v7:
  - Added CONFIG_XDP_SOCKETS to selftests/driver/net/config as suggested
    by Stanislav.
  - Updated xdp_helper.c to return -1 for AF_XDP non-existence, but 1
    for other failures.
  - Updated queues.py to mark test as skipped if AF_XDP does not exist.

v6: https://lore.kernel.org/bpf/20250210193903.16235-1-jdamato@fastly.com/
  - Added ifdefs for CONFIG_XDP_SOCKETS in patch 2 as Stanislav
    suggested.

v5: https://lore.kernel.org/bpf/20250208041248.111118-1-jdamato@fastly.com/
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/



Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 +++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 10 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
-- 
2.43.0

