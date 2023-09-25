Return-Path: <bpf+bounces-10768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F17AE045
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 60ADA2816C7
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A223758;
	Mon, 25 Sep 2023 20:24:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AB22F12;
	Mon, 25 Sep 2023 20:24:52 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2EC0;
	Mon, 25 Sep 2023 13:24:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3d6d88231so51761905ad.0;
        Mon, 25 Sep 2023 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695673491; x=1696278291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdjM08gmoXvyztouDjrJfcBPW9vYMWj7EpOPKNnHpmc=;
        b=YsBJ821ecTLx16nOpfytKsgoQba/WakqkTum/+ZedOp/VJB2fpYzSOHnkQJteCk8v0
         13Ylp2KzXyJ9hr3i+oWisiSqTRYzKrEEfvcv7z58hWOi575nXdwlufDpN+wDi1HxC90y
         RbAqJOAHeEZAcCPS60ZgIE7ZBcOdwORaQMDJZ/HmzRmwhMqvutFhaeBLT2an5lRXyOTc
         Z9+9ih421JmXHtlGcXQxziypSDYnacaWnVceqOGlnnTfZyR9Q1J5qrWvBmnxpX+deT/l
         phoRTCy31ugERKdX1JMDSwe5UheYtQFGRYHEtPJpJ3aGHz0N7cIwLguPX/5DK5ZmBvoR
         +jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695673491; x=1696278291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdjM08gmoXvyztouDjrJfcBPW9vYMWj7EpOPKNnHpmc=;
        b=HieCqwq+fmVpOcvQTicUMaQR3T7RLngdJa712Qt7OD4TaerZA4PAP0AJJHRw1mDXzm
         Zhd3fwzlBjYJ8065mvxoforYxLxxGLX7ONo/rE8vGAKfoiRqeCKENdpjWoWkuiP56EW/
         qJsW4wo41NrZ0TTju1gTwQL166o4xgLpfsMmtBPixBnmrq1hHrwgnnrJ9Sjx8W3F+rcl
         J5G4J+qEda5A4aOsdALGEjfCln6ZZa/d/Zp2Uj6RneqPkYyZUyAfL7HOY0c904RmmUrm
         UlTQQz7ObQoEfpfpCodCgOpLTXqTNQeO0EJosFI+qyp39FFQgwgTE3U7ntTHVO+aTdHy
         q1Rw==
X-Gm-Message-State: AOJu0YwL4x43JZU6yPVZJvojXrIc4iunHE0ZeN7RA4bHDl2zU2Tbepch
	VpjhYccbe+kfKQ0frlm/wtw=
X-Google-Smtp-Source: AGHT+IHcFl9Yod5+JknRWxOw5Ym67/1MHOYZPNJU/LdDNIu+n934rYU1nwDhTVQgSa5nSrjlMfTaYg==
X-Received: by 2002:a17:902:d4cb:b0:1b9:e9b2:124b with SMTP id o11-20020a170902d4cb00b001b9e9b2124bmr6572116plg.64.1695673490665;
        Mon, 25 Sep 2023 13:24:50 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001c61df93afdsm2254040plb.59.2023.09.25.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 13:24:50 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v2 0/3] bpf, sockmap complete fixes for avail bytes
Date: Mon, 25 Sep 2023 13:24:45 -0700
Message-Id: <20230925202448.100920-1-john.fastabend@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

John Fastabend (3):
  bpf: tcp_read_skb needs to pop skb regardless of seq
  bpf: sockmap, do not inc copied_seq when PEEK flag set
  bpf: sockmap, add tests for MSG_F_PEEK

 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_bpf.c                            |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 +++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.33.0


