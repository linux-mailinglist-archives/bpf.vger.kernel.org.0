Return-Path: <bpf+bounces-17087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C87809932
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C94F1F212E0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09371FB2;
	Fri,  8 Dec 2023 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwFn20Pt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0941709
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:32:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f31239797so67610985a.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002722; x=1702607522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FzA+sLY2Jo6QSs2eZF8UKKWxZiOiYwZ3vDN+FYbFWY=;
        b=NwFn20PtQI+cBa2LIIXQ4rWHNm6x4eUDt//3LqdnsyGLn2D08LcOKoQMJhc1x87Whx
         VA9z2cdZy0/o6XscC7Hitn0G5nBj1fYrgRjyyKHeuGy9dDPv2MdBT0jEmMNvuGpAagBA
         b4h0naQptTU75h+FXGoygmmRPa+w5QbxEgOdRIrFloBwOcCS5kafRzI3lKM0GwP1Fj+P
         E5FXkbsfF9AkqUqzRTT6cGaqQiqX3RGroI0OBT2FtH8y2uELAK1KvATAhj8HuLNjGnYv
         b1ux+QLEHAVdrMozfr1bSY0Q2hdxN0MTFRHOT6uncDlQGj/d9aiayWBi/uQhCwEO++bC
         4srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002722; x=1702607522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FzA+sLY2Jo6QSs2eZF8UKKWxZiOiYwZ3vDN+FYbFWY=;
        b=emg+bKICf5j8hk/nb3loJQORJjPnELQGoLV0vsfjWbtG3xIgkBnuZX1LwvWZdqdYBl
         bTwBqrX9lbZboPYmHFajOFirzEwBZn0rtpSGJIYen1bNbTWG7JCc3l52Ffr3jxDOf/iH
         uvWVHKDcoOuwLc3jIvqtdg8RAw2PgpG67TIFs5Je5dzAsy51WHULWIhshYnktcxvMHGw
         E3wiPvJhJyDfY5Z11mGjXwGeQV9ICCqfpr11qKWEB5qZV4B81wR0CF9VhbzQ+whLpI/2
         PVW6y/CK/PNRv/jNzKYc4dStdtA9E69calKuqK6USZkXJwYCjObGLqkBWu35+y5OBRnY
         rHaA==
X-Gm-Message-State: AOJu0Yxmw23KiC8JcmbnPLr3h8lxTtRpPZjEsN5w9N5ZwJu/QMv1x+R2
	gaJD5C2kemdNYjt4og9IQ+cjWWiNyklmVQ==
X-Google-Smtp-Source: AGHT+IHSJbBoTYMaZvJjdMMalbeAmdCgQGazmK6sCTuMWkv+Cw9DKDG4gLK1VoKWu/XWEvloA0RHyw==
X-Received: by 2002:a05:6214:c25:b0:67a:a721:9ebf with SMTP id a5-20020a0562140c2500b0067aa7219ebfmr3924935qvd.112.1702002721783;
        Thu, 07 Dec 2023 18:32:01 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id g5-20020ad45105000000b0067ac80bb33fsm408063qvp.125.2023.12.07.18.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:32:01 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v4 0/3] bpf: fix accesses to uninit stack slots
Date: Thu,  7 Dec 2023 21:31:47 -0500
Message-Id: <20231208023150.254207-1-andreimatei1@gmail.com>
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


