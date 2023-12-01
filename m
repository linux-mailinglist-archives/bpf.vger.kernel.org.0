Return-Path: <bpf+bounces-16408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A5801226
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BCABB20EF4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F924EB3D;
	Fri,  1 Dec 2023 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMKgz+xK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F48D3;
	Fri,  1 Dec 2023 10:01:50 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so1957202b3a.1;
        Fri, 01 Dec 2023 10:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701453709; x=1702058509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e/9XyiGOZGy6621tU8NAwVZMxG8QNzIsXRcMqHYPoU=;
        b=RMKgz+xKg2xTDDPLwv/DoIDLShVXrC5wxbxbVq3AvOxN+YvGR9Q6zsxOq1866w8tQ/
         sGdz5cz1UyoA9Xbv62JlYIWsMWQD/oG3v8IjHK5L4jRRRIN1HiRHa1nkalNWlSGpxDNs
         utyqodkCIcR8B9BOyDdDRcab3J7Dq53nV3A2b5WalR1rAzVjPaiuPIQnPCHf2auXALmg
         IydCD45UrdLOP9qet3mGelL7iGtWQ2Q6ml129j53ROxC1M37ZFHU3s4nLeNzt0qBRFRx
         aZNvsoNzzYBEfFe1QZRppAlal3NQlEiadc8UgcGVmYcOq5Qv+WxoA0uOSYzZvikourzg
         KDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453709; x=1702058509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e/9XyiGOZGy6621tU8NAwVZMxG8QNzIsXRcMqHYPoU=;
        b=J/Glv+f4/I1sh83nk8do2Zkfjn751c62Xy45MGduAmhm1UkOYLvbAlwKx4YNDAXkUh
         e53QAXg5GZshk2hRyEgDV/D2fmHGfLeHusTwq/BTugdoIgY0SPE+HgOeenrefK6gJBCn
         x++RBu9vIycB9KntaN2pM8KbjdysUhANEclCEZhXVoj6/NDZ/gVdXSb64V46HSRqqIAz
         ffeZtzQ0ZxsY1ilvns/bX8622itc4XUsiYbNECkob7MDqWxZVLvd+K/8tylTcxrCpPNC
         J9uLbxZf0C+TXLwc4FKdlXwv11vGNkb4DzwrvJTq0iwJj4j0vuOhJVhD51UtUqt5s4R9
         EfKA==
X-Gm-Message-State: AOJu0YyOMOKgYqNvHCRZOX4UaM5/EWrFdLb1gPXa9ba/IB4VgYFMWkOA
	yLAHybrXYZf5CMQn9iYNXXbT8w4UCZxpMA==
X-Google-Smtp-Source: AGHT+IGJ3+YVV0vkIpxptrewazVTekZY5aWDl7rl0/32jRLGmmBTSnMvpxg/8dlG0B4cEcoqsUt9nw==
X-Received: by 2002:a05:6a20:1586:b0:17a:e981:7fe4 with SMTP id h6-20020a056a20158600b0017ae9817fe4mr42302182pzj.16.1701453709325;
        Fri, 01 Dec 2023 10:01:49 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:7a9a:8993:d50f:aaa4])
        by smtp.gmail.com with ESMTPSA id l11-20020a635b4b000000b005b6c1972c99sm3362493pgm.7.2023.12.01.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:01:43 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 0/2]  bpf fix for unconnect af_unix socket
Date: Fri,  1 Dec 2023 10:01:37 -0800
Message-Id: <20231201180139.328529-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric reported a syzbot splat from a null ptr deref from recent fix to
resolve a use-after-free with af-unix stream sockets and BPF sockmap
usage.

The issue is I missed is we allow unconnected af_unix STREAM sockets to
be added to the sockmap. Fix this by blocking unconnected sockets.

v2: change sk_is_unix to sk_is_stream_unix (Eric) and remove duplicate
    ASSERTS in selftests the xsocket helper already marks FAIL (Jakub)

John Fastabend (2):
  bpf: syzkaller found null ptr deref in unix_bpf proto add
  bpf: sockmap, test for unconnected af_unix sock

 include/net/sock.h                            |  5 +++
 net/core/sock_map.c                           |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

-- 
2.33.0


