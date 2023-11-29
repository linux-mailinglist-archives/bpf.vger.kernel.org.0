Return-Path: <bpf+bounces-16102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5257FCC51
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 02:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E32D283319
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E691FA1;
	Wed, 29 Nov 2023 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZRB8DAj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB357F5;
	Tue, 28 Nov 2023 17:26:00 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c2066accc5so4215763a12.3;
        Tue, 28 Nov 2023 17:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701221160; x=1701825960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOFTCg/xZX2VkbDOt6Fpz6uOzcvRQ3a4F6VRrWEkpU=;
        b=dZRB8DAjPP0rzl+m8tI+W+qfMXGeyI7c6RPwHMw/ahuKDnC29dkegJYZzv2eQeO3Ou
         cSc4smqg9xxWxWfSlbFitjUYbiFdaNBNxXtspEPODYUD/3vktS4svcaiGistlgdyrYA+
         laDdp6bYVVn5qHegZjU1q7ktNJzwUgUx0M61gLlH7ce2njZWBZbtSTmqmY3LCGYAYbtG
         HXEM+Cv6+o+Qi8SPoWrZLkMX8eo7mkkgrLOvpPXpYOBlXy+6/9sd1upRdKoB9MAAJ0BJ
         6gTZ3yp9f6CEVBkycvE55q87c0IU12slvkxzNvNJZEWOOn+Y+tMbtFb4BRrxFWLYaZmU
         /3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221160; x=1701825960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVOFTCg/xZX2VkbDOt6Fpz6uOzcvRQ3a4F6VRrWEkpU=;
        b=anSwhm8f1dxEPT90XRH7dIg0sFTSzBTmfULkjDlTrkzZCFxa5m/aR7BrhGJMpZheYA
         JBzte/NyV0l1FywNfT/vyMRGuJqUcHfG2czeoe7H6KoNHe8W/Vw5FegTsmJvnLJa16dt
         Wzs4sUsQnfRdAkBkHV7JyYWffc4Qr1vfTv3xhVbqu1L214u/DvcHn9SvFu3SngrF4+/B
         w0BWQ5Cqd3aWOt715KV255SL9t90pb8tkumRSanCmLhC820oCGmIFRtSKzuHFjI4f6it
         FfqzLvWUWV5VZ5z7nYasFcmC6LDGTNjvAitoxqNcfsN6d3gDA0hX+qIz9s5cLtykswlG
         M7og==
X-Gm-Message-State: AOJu0YwOyp2JphO4niGjQcwylBNQilVmq+txAVLx1rDHA3xYVz96uAd+
	pdQW0Z10S0g7xC8dNgum0sw=
X-Google-Smtp-Source: AGHT+IEQhA9RfxAKATEO7MpYaUFnB5Crfa8RCeYldiz63/kgE6FE1YSDWyD9IEqSlqAh0wDdjJ4qAw==
X-Received: by 2002:a17:90b:3ec3:b0:285:9424:4a4e with SMTP id rm3-20020a17090b3ec300b0028594244a4emr15445544pjb.38.1701221160080;
        Tue, 28 Nov 2023 17:26:00 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:9a79:36c7:502e:91e9])
        by smtp.gmail.com with ESMTPSA id gb23-20020a17090b061700b00285114454b4sm122757pjb.22.2023.11.28.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:25:59 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v4 0/2] sockmap fix for KASAN_VMALLOC and af_unix
Date: Tue, 28 Nov 2023 17:25:55 -0800
Message-Id: <20231129012557.95371-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The af_unix tests in sockmap_listen causes a splat from KASAN_VMALLOC.
Fix it here and include an extra test to catch case where both pairs
of the af_unix socket are included in a BPF sockmap.

Also it seems the test infra is not passing type through correctly when
testing unix_inet_redir_to_connected. Unfortunately, the simple fix
also caused some CI tests to fail so investigating that now.

v4: forgot to commit typo fix add that now (CI build failed)
v3: drop unnecessary assignment (Martin) and rebase on latest selftests.
v2: drop changes to dgram side its fine per Jakub's point it graps a
    reference on the peer socket from each sendmsg.

John Fastabend (2):
  bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
  bpf: sockmap, add af_unix test with both sockets in map

 include/linux/skmsg.h                         |  1 +
 include/net/af_unix.h                         |  1 +
 net/core/skmsg.c                              |  2 +
 net/unix/af_unix.c                            |  2 -
 net/unix/unix_bpf.c                           |  5 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 51 +++++++++++++++----
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 +++
 7 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.33.0


