Return-Path: <bpf+bounces-10838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA27AE44C
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id C64351F2533A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66AC1865;
	Tue, 26 Sep 2023 03:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD97F;
	Tue, 26 Sep 2023 03:53:06 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD9DD;
	Mon, 25 Sep 2023 20:53:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso7017894b3a.0;
        Mon, 25 Sep 2023 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695700384; x=1696305184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vf5HlYBmIHHLzInv2RjwQu3wo0UX1jMb7vNQvp7VZvU=;
        b=E7NwQbszr7Crwv2eZY6t5jirRh/Pd7jZq+pAD8nw8ACC/fsdrqqh+j9nYvsQzjBYeG
         lSdXTN0kGbmMSQki4BJ0E5rrF5t6nwjZVuKXQEm9JKrOsJh8K20kMkZq9i3ph+e9dOXH
         Tt6xdIXrV6AanQQBH/ojpAA484LEVNtC8+VCWyIxFosC3UI8kHnGeRqjvkAEGQtcM5vQ
         EQ58k9gUdY/XhfcP+nu5fd4B+5zXi50jQn4wEOEHsu7O7AA+92X0GmHJCzGoyvVyMRo5
         6fTZ9nsNYW24Zp1ev91bAOVezxIIFH1J+CzpHSZoSyARQahgLdqHmaSLtDuL+/DsXDJz
         u3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700384; x=1696305184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf5HlYBmIHHLzInv2RjwQu3wo0UX1jMb7vNQvp7VZvU=;
        b=mQCZn5fAZkmDv410t7AFKlrbdEgJK7scEO+LUnzp0ej7u0ZE7RZf9Lag9g7apfI06p
         ZejuGVoo+k4MQWVnhrNAYC/5FDnicQMN3HalSs8sBbqXF+i2RAfn7CWW9IyjJSxZgTYY
         3Wmz7nCbrZV0sZxmkg35bT+R3jSCyioqs6Zc9qjpw+51w0c2B9P+M0kytzLeAvCqOquT
         1HfVk+p6VY4jqOTWqzvGjnjDSb14PFpCdX+wLeayihGsAnhRf1fLs/eoRLep4GervXbP
         i3hsbzHN/Y75RfyJeL9dEVQG5xaUdai3SVWiz5WhoUrVb6xFfa8rsfrco/MoeHULc6DS
         Qtwg==
X-Gm-Message-State: AOJu0YztXwxFfLEo6RHHYarzbftBGBxPOV7R6Lw41ZdywDOzFsg2NWR/
	hfPc60SYLHzEUmzbda99/4s=
X-Google-Smtp-Source: AGHT+IHyqDAycYqEbMO84iKN0GSN/HLxoO1Lc7/Gc7zp3FJFMFdF5qMz/yh+Wwd4FTMq76p1TZyeWA==
X-Received: by 2002:a05:6a20:1614:b0:15e:1486:1e08 with SMTP id l20-20020a056a20161400b0015e14861e08mr10747453pzj.19.1695700384210;
        Mon, 25 Sep 2023 20:53:04 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:650a:2e28:f286:c10b])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001c3e732b8dbsm9755723plg.168.2023.09.25.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:53:03 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v3 0/3] bpf, sockmap complete fixes for avail bytes
Date: Mon, 25 Sep 2023 20:52:57 -0700
Message-Id: <20230926035300.135096-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq") we
started fixing the available bytes accounting by moving copied_seq to
where the user actually reads the bytes.

However we missed handling MSG_PEEK correctly and we need to ensure
that we don't kfree_skb() a skb off the receive_queue when the
copied_seq number is not incremented by user reads for some time.

v2: drop seq var in tcp_read_skb its no longer necessary per Jakub's
    suggestion
v3: drop tcp_sock as well its also not used anymore. sorry for the extra
    noise there.

John Fastabend (3):
  bpf: tcp_read_skb needs to pop skb regardless of seq
  bpf: sockmap, do not inc copied_seq when PEEK flag set
  bpf: sockmap, add tests for MSG_F_PEEK

 net/ipv4/tcp.c                                | 10 +---
 net/ipv4/tcp_bpf.c                            |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 +++++++++++++++++++
 3 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.33.0


