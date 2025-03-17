Return-Path: <bpf+bounces-54189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38AA64E77
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB83ABAD6
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C323814F;
	Mon, 17 Mar 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLXQItIa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718F1DE2C8
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213873; cv=none; b=Lma/jvTebU0jL63tlKUYyEjuq2LR3f/3FTtqDPQjkzlXbPWGvJRqoUtZ73ZRqAv+iIFW8grKkwnbIxXXD22/kTcBmTxlzin/+0P5HJBdrhn8L8RVjg0juUUueaxwa2NxZ2Xe9c5oJogBAO6fo/pVcQad8QwGwkiwNLbkNK3I7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213873; c=relaxed/simple;
	bh=afDg2opWdrTQCiK2KeCZZ+s90s0C+eoYyXXGjxmtufY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPeyihl4m5sq7VATuP4XsYRztSJg5W0BHRZBzdlPmd0sfxKs14RwCQG7MfuEu1fTjIvZ4pTQCzsCm3vRj+ryjAeig+KJ8oeV+1IgbepYpyH7TknwSzha8lZsX93MemxJ79yRu32he2ijzVbsB2EGiNT2XIRPTwQCIyG+jPVG2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLXQItIa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2260c91576aso15096015ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213871; x=1742818671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vv8d/vSBqh+nPW/VLdJCn39Dg/ykqe411tIE0sZWPFE=;
        b=eLXQItIan7WtpQ+jvO5G0Uy8Cx4IsCXXi5mMA8ipFW2Nylui5JgpJRBXQy0LdQ8jqc
         2vZlIzvV25bZGC8UO5zwHhfPYsS2sIuj6odRgxpzjUseUEr/5gtBVmWQqcYpaFg1PXvq
         V3wRQHVgcgJpu4+q1KKat/ylqn1OeN/w3nk41cF2/k1PZaUKwYRzkcuf3J6Msv5go0da
         PNq6AR0JGyhoj65JMv6oUDetGij1QFFAEp2FHaxIIWR2nULtf6V9HX1ixWEX9xWDZpcr
         wIbrHPIxmjoJRr/9ezDoB8bW72U6n7wrR0GHjWqGwFA288zAn3nx3ZOzCtGh6ZjKdQb1
         ZsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213871; x=1742818671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vv8d/vSBqh+nPW/VLdJCn39Dg/ykqe411tIE0sZWPFE=;
        b=N0naBpbhVHX0g5Q2BOoWfNgSc0HXbWBW5bYFFwzVlGPm8C9hadgU3Madn9xvr1ZELU
         UbhHzbWYAm1TR79WZkC7ZkCh2DC8HKM4MnQFLORmA+bHCq1BCH3sFaatb5Vxp0U2NhSW
         OVeNkopN1Pq5OqU1OEkF0XmKIz9esDd5Th2/Z3Cv8wANQv+ZBNqeKmrR4fUH9PUcFiz0
         vnz+hIi/5zgdKaqtsjleiRgeFQhDvtrFNooBJeqI3Y5S6rKgNhppKEcK2krFIQjfiiaD
         VPRe0Epxrjh5To/Yd3hyD8SPAQ8hd4P8q/yNY212AyzvoFa+XeAYYjRo94HT2OkAXPRD
         5vxQ==
X-Gm-Message-State: AOJu0YzI45HlDiiBX+pERPhEhUiRt0bZVmo3RUxv0msZypBbZS7EMD4I
	sTv30ZA6Mq5pTndof578VLysQUX49EkVeeu0pe3jG5SaqaxMhbl9
X-Gm-Gg: ASbGncszq3rwgiyeYRxkdwl0yxg8MoY0lr5V8GKGB4x5aDDSUe7h5ZWDdSOXpTfP+fT
	Wm0h7EH+BqTA7fFvMElfm+RkXtSQBYDqEwxodV2k3sGbgtqPkjWk2w/E0uZ7Z5D/j4p+Ji1TPsl
	/z0XVr74Y7SAX42WGMEJsORkScy0x+y7rYuzsZO9viG8dmdUzGsifRvG/ycwVF5M3Jqkq8zTBPf
	YKUfqWp0AmoKRH1VrXM/q7t8TtRxa7M8oi1rE6POfAFD5i8Kc4vu2qncLbO7DyM0CsalDkY4gbF
	NREsG5rkxeyZTpPAJyOn2Qb1GdqHG0YdZ97JfNZuWgXjVdGNN0lcVJwtn5F36JiwfnYY
X-Google-Smtp-Source: AGHT+IFbwLGfwDt0xqSmW//aolKfaXguI1Bh9SjUMj9Jh6GBxsxadLjs6CKDkC1DEhAUuzeqyfxZwg==
X-Received: by 2002:a17:902:c946:b0:224:26f2:97da with SMTP id d9443c01a7336-225e0a8fba4mr120371085ad.29.1742213871262;
        Mon, 17 Mar 2025 05:17:51 -0700 (PDT)
Received: from localhost.localdomain ([61.173.25.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7c1sm73445555ad.187.2025.03.17.05.17.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 05:17:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
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
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Mon, 17 Mar 2025 20:17:33 +0800
Message-Id: <20250317121735.86515-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching fexit probes to functions marked with __noreturn may lead to
unpredictable behavior. To avoid this, we will reject attaching probes to
such functions. Currently, there is no ideal solution, so we will hardcode
a check for all __noreturn functions.

Once a more robust solution is implemented, this workaround can be removed.

v3>v4:
- Reject also fmod_ret (Alexei)
- Fix build warnings and remove unnecessary functions (Alexei)

v1->v2: https://lore.kernel.org/bpf/20250223062735.3341-1-laoar.shao@gmail.com/
- keep tools/objtool/noreturns.h as is (Josh)
- Add noreturns.h to objtool/sync-check.sh (Josh)
- Add verbose for the reject and simplify the test case (Song)

v1: https://lore.kernel.org/bpf/20250211023359.1570-1-laoar.shao@gmail.com/

Yafang Shao (2):
  bpf: Reject attaching fexit/fmod_ret to __noreturn functions
  selftests/bpf: Add selftest for attaching fexit to __noreturn
    functions

 kernel/bpf/verifier.c                         | 48 +++++++++++++++++++
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ++++
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 ++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.5


