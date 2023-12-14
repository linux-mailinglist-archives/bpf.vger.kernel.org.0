Return-Path: <bpf+bounces-17790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD418127F0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CBBB21006
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF7D263;
	Thu, 14 Dec 2023 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsdu44nm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28DB7;
	Wed, 13 Dec 2023 22:28:38 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6da16eab6fcso3145755a34.3;
        Wed, 13 Dec 2023 22:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702535318; x=1703140118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DACrLAWMgkdWOj6IS64GGQr5aAGYXSH/tnwt+3cBGmE=;
        b=Zsdu44nmfZvBRgJsZBZQgtI3hXMPq6tS2T5oBJ+rUho4v4tJ9vGD8RZ6psoU8rKxgt
         rTbu7P21lpsfNf1O/LL8IP+jLUXEE+4eZP7CeNqNwjGRtQXb6qI+vkv7XxQ9Wns5XSf7
         vI9o1Qtaxl01S1+mnqOXb64UwqjGecxPXE0ae5WFh74aRYwaJJGxGjjMVmFNNGDoQUZw
         qkRaJDw/Q67bpILd5wr1X8l5uxDiOMgO0ihd8bPlNMgOSFbIPTi+4CFNOKIhYHPD8sGf
         ZbNpnracPCpwV8Ie7CI3EXp+WCpxJIiRcHleD37SOJ2Hjxj6JWyds5/tTx95txJWKQxg
         DmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535318; x=1703140118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DACrLAWMgkdWOj6IS64GGQr5aAGYXSH/tnwt+3cBGmE=;
        b=KNs+WGYIu8bYNCsWmZdFQeE694o7NU7YK5Mi7+totwx5FUWiMuYZZrBYG6xZxdUHGV
         ooAqILpNNr13Ym1Jm+Db+sI8Esy9zTgk+upa/S6Rlt51XVBADBgLAl4PGiNZUkNz93Ei
         IGf3RB2/G7vj+s0/tEMSITYc2op/h8qYwz9RIhYCyJrUTzPLVi3hGyMbaVZuRmYUt+Zy
         ILU/iC4Uz+uDGos4ykdY40rjbHtZgsV1doZZE5434VWCD/BaOpZi/6sJ0GKmw5+pRvnf
         GzLspSM9Cc3vwnuIhOu6xmpvfSuRZ8AJkQfRfetW5eqakEzTnms4ch+fQgm2QqI7I58b
         MCqw==
X-Gm-Message-State: AOJu0YyO9Yffd3R3Bz0pRPWgG/3U+it6IL8oEZebIx/6PAr8P4C2NYnN
	mKJoE7xJjDblbGqgRrebphI=
X-Google-Smtp-Source: AGHT+IGc+XSLEwAysJ/H6XUnxDX2fwwVEBl4Vm5agEu1aA3vS9QI53pf03vr2XUVPiVCYs0opkMChw==
X-Received: by 2002:a05:6808:1307:b0:3b9:ee89:541b with SMTP id y7-20020a056808130700b003b9ee89541bmr11183525oiv.28.1702535317951;
        Wed, 13 Dec 2023 22:28:37 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e107000000b005af08f65227sm10744770pgh.80.2023.12.13.22.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:28:37 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: support to track BPF_JNE
Date: Thu, 14 Dec 2023 14:24:32 +0800
Message-Id: <20231214062434.3565630-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the reg bounds is not handled for BPF_JNE case, which can cause
the failure of following case:

  /* The type of "a" is u16 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

In the 1st patch, we reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg For BPF_JNE.

In the 2nd patch, we just activate the test case for this logic in
range_cond(), which is committed by Andrii in the
commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").

Changes since v2:
- fix a typo in the subject of the 1st patch
- add some comments to the 1st patch, as Eduard advised
- add some cases to the "crafted_cases"

Changes since v1:
- simplify the code in the 1st patch
- introduce the 2nd patch for the testing

Menglong Dong (2):
  bpf: make the verifier tracks the "not equal" for regs
  selftests/bpf: activate the OP_NE login in range_cond()

 kernel/bpf/verifier.c                         | 38 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 25 +++++++++---
 2 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.39.2


