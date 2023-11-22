Return-Path: <bpf+bounces-15699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE867F507E
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9429E281559
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248715E0C0;
	Wed, 22 Nov 2023 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdBVWCyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57111F;
	Wed, 22 Nov 2023 11:24:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso160041b3a.2;
        Wed, 22 Nov 2023 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700681095; x=1701285895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+40406Q9ZR6OTPkYcSVNkHdzAKppHACKlwdUqFbtww=;
        b=IdBVWCyBhQxF8TX8z4A7o6sLD6ZJ9VItQwg8CfbhZnn19mK/IWcNa7GYjC6mmB9uxW
         Fbyw1+pEGbl4cMwyU/mGMJ9puA8JakPPkxPuPSfswr1H7k4MuTmZn1n+8Zz38viMt1y7
         ThmjO3AJW2vZ/WUFqzsXpl/kQ6x91vGavk9yzl4nqD8xBHn4Elvk19ESqUeOU4AuRQcO
         2zkfQv/SPAp3qovIG73HOeaF5NSPVsxk9vaqjZankeOzF0sD3QifOJ9/EPF53FMNeeXM
         V9DeABg2VPGBTIvQMaz5kQixeAfH/FEpYyRAY8fpC9CPCRIDCVgEU0it1+XqWne5t23B
         x9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681095; x=1701285895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+40406Q9ZR6OTPkYcSVNkHdzAKppHACKlwdUqFbtww=;
        b=CrlaTFbfR2hvas1w8WvjyFaC9twwXiUyVA573wB8hWV4Sl70WM7uIl52e6IxhbIscJ
         yJWwoqTeBxnhHQM2prD8nBPnSGrw3XpIKqx8VSjz8FzHf3MSnsw20RAMDpbEVMsPBzLt
         Fts65IbK09hUdIprL6k5YKs+BlAN2Uqq4O48x6CVSG6o8X0mOOC1Cuo85Y4QmMWPumBQ
         n5OO7A4xLOnMAMhjBOyBWrGIqMYSYyB8ndLz+jjwacCWzGna/5/dEwciCv4Wj3qGBaY3
         9QyzLDrfMIY9M1Be2irZXyK9ir1lDMQcWGS2s17jhvR+zuJg+y95l8oEgFrDAsbiWmIf
         xntA==
X-Gm-Message-State: AOJu0Yyjw9HKiP7QOrZFBIuUKJkRIYVH0QlIdlXfYUkMpNoVFTTlr+Zy
	Mxhv4QXDzsZ7BZ7Sqzs/m4s=
X-Google-Smtp-Source: AGHT+IGUGq0Ylp/eEZCtHJ+r3KS+CFOnV4XR8mgu1CLzDmb+aigzsEsNXRPQGNa/etn/+9BeN82TLQ==
X-Received: by 2002:aa7:930f:0:b0:6cb:8a1e:207b with SMTP id cz15-20020aa7930f000000b006cb8a1e207bmr3367733pfb.19.1700681094898;
        Wed, 22 Nov 2023 11:24:54 -0800 (PST)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id r7-20020a056a00216700b006c052bb7da5sm89240pff.7.2023.11.22.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:24:54 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 0/2]  sockmap fix for KASAN_VMALLOC and af_unix
Date: Wed, 22 Nov 2023 11:24:50 -0800
Message-Id: <20231122192452.335312-1-john.fastabend@gmail.com>
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

v2: drop changes to dgram side its fine per Jakub's point it graps a
    reference on the peer socket from each sendmsg.

John Fastabend (2):
  bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
  bpf: sockmap, add af_unix test with both sockets in map

 include/linux/skmsg.h                         |  1 +
 include/net/af_unix.h                         |  1 +
 net/core/skmsg.c                              |  2 +
 net/unix/af_unix.c                            |  2 -
 net/unix/unix_bpf.c                           |  5 +++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
 7 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.33.0


