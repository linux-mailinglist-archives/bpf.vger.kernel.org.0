Return-Path: <bpf+bounces-17095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3B809A3C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3511F21352
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F99442A;
	Fri,  8 Dec 2023 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASsiB6by"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E72C10E3
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:25:29 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-423db8ab6e0so10114451cf.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702005927; x=1702610727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qp7ogyAEQbF9G9PRS5E2EWntXUxjuYhPuiZsQjXu3I=;
        b=ASsiB6byyaovIZkjIEo3LNKUQdVrVNbzbsIgoAG5inZMBwzDdCOabWEgMzKkx2K6T+
         lzgWjqXPkZTV2G0QxMT1qUTX5JJQRYF35oclixxDelTebP5Rtmtw882At2HbgImEivf8
         p4yHD1tG+HseWWOylXIENIQfpUlguCIn8sch0PYyN/r5UQpqaEHh+FqU52ljh8v4aTkz
         Y26x9VSF4TvMgu2PTH3mzc7tJ9ZkdIiqx/BvaLOYgatR3i5S1BMulsxPmkDMWAnWrVB5
         NjPF28QUvNuzi+eY9/QaDx9KcdBszOkPAO11ySf/rf3PG5Sqt6SIl/2rfhjvlNnvJRks
         syeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005927; x=1702610727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qp7ogyAEQbF9G9PRS5E2EWntXUxjuYhPuiZsQjXu3I=;
        b=a6xuexLLWcrOmNaFv3YS7pZfQLZn7jSitxdTUOQh8C+ZW7/4NDzy+V0sRlDSScf8oy
         UYnHZTM7u9czMFJOXtJSMlGZjh+CR1n38BUpKtpfE4VUMcC+OsebzDFIxmOD5ZI/miaD
         GRFhlj6QAuSR2TPzwJGAG+mPltjcvMqX+kW/gCm4isacSM6PgZSTPY6oLqw26oPnMKo6
         OLp++eXf6SO286WjWKONIt6qd2WwRS+loPuUyteZhYuluJk566dZ9G87DqbR56ooZfMk
         5vmgKlsWjeg68tbtL78GNQXhj+13MKG/OeXrB7AekDaKamStcL8PJGZoOStSWnuFHy+s
         e4kg==
X-Gm-Message-State: AOJu0YyFNWnihbKbHQV8sTiikQ/kkhbfCRbQeLS+7r62M5wPbUUiLNe1
	RHSBJcm1RE3baagv/Vvxt7f0f8sfLzLE8Q==
X-Google-Smtp-Source: AGHT+IFtiTwJm9ztvOc4LWAC/zf6cYqqw1fA0rLI2IsIfdRcwpS0Yy8AtBaW1znVaNwmsKj2wgvP+w==
X-Received: by 2002:ac8:5b8f:0:b0:425:9f11:720c with SMTP id a15-20020ac85b8f000000b004259f11720cmr364526qta.24.1702005927400;
        Thu, 07 Dec 2023 19:25:27 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id l2-20020ac848c2000000b00424030566b5sm448266qtr.17.2023.12.07.19.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 19:25:26 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v5 0/3] bpf: fix accesses to uninit stack slots
Date: Thu,  7 Dec 2023 22:25:16 -0500
Message-Id: <20231208032519.260451-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two related issues issues around verifying stack accesses:
1. accesses to uninitialized stack memory was allowed inconsistently
2. the maximum stack depth needed for a program was not always
maintained correctly

The two issues are fixed together in one commit because the code for one
affects the other.

V4 to V5:
- target bpf-next (Alexei)

V3 to V4:
- minor fixup to comment in patch 1 (Eduard)
- C89-style in patch 3 (Andrii)

V2 to V3:
- address review comments from Andrii and Eduard
- drop new verifier tests in favor of editing existing tests to check
  for stack depth
- append a patch with a bit of cleanup coming out of the previous review


Andrei Matei (3):
  bpf: add some comments to stack representation
  bpf: fix accesses to uninit stack slots
  bpf: minor cleanup around stack bounds

 include/linux/bpf_verifier.h                  | 14 ++++
 kernel/bpf/verifier.c                         | 76 +++++++++----------
 tools/testing/selftests/bpf/progs/iters.c     |  2 +-
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../bpf/progs/verifier_basic_stack.c          |  8 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |  5 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  5 +-
 .../selftests/bpf/progs/verifier_var_off.c    | 62 ++++++++++++---
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 10 files changed, 115 insertions(+), 74 deletions(-)

-- 
2.40.1


