Return-Path: <bpf+bounces-16524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AB801FA5
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 00:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3939B20A73
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC22232F;
	Sat,  2 Dec 2023 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkYJ7rzg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE36F3
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 15:06:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-42548f6c552so5643421cf.2
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701558379; x=1702163179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbQu4BTu2yrvpXC5DVQ5k83V6in1nn0yBDhQk00h0t8=;
        b=XkYJ7rzgTbTs5x0SiPXQlbZbwmao+AGTUxJeVDgEJINGa1Enq9CfbR+ycO1wA0qF/i
         2Nmvl8PBtpOQ1eBK4r3BU7RkJjh2AY29uiWtUQPRI7bdikDQuFTRkf/KeDcK0dgNMELU
         IBZxpU5N+IOBNfWx1RT0r+XbP6GbYI9+UKDOBdP5JU2IcGbKaNnpuN0SQUtwY+HWisGE
         16ZKeYh/M+Nt0b439+XSXeYroha70FGFbGXr/oRuBNHCdbU0hXf94cfNQi7n6WzzAaDh
         8+EFxHcJ5UAtcWUFwlTIA0Rd6Y3Q79T2H9gih1RILqkYcAO1r09n3SQKf0ylHWo0VQ1C
         Qp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701558379; x=1702163179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbQu4BTu2yrvpXC5DVQ5k83V6in1nn0yBDhQk00h0t8=;
        b=EAFCLz41nKuVSj6nt29zMLgOcjolQ2gBYg68IGMcH1wVPtNHq925ixtBuD8WOVJD+T
         Hw/Cv+NcA3PJUDe/ZzWNxgfox0lxksWGoBoFctJgcMOBmBhBDaIM1uwbkpGhsESprBJM
         JwVriAtRUP+f+r5IL+4/4TRQMRZMVZCINxWBJ9yqp51NbpBoPD5A0mTs8KO54MJcnNmA
         ETsbrg0uO5Y/D1UDTR8eJo6hPZyx4gpdVeZdq6KI9KfWPv80cR2OnctbUkAX6uf2humM
         zExyfZepGLBb+kH/EuHtd/yDGKs6u9e+SYfAKKj0mZZoEzNU252cfWEoVjWJJ3SQA8CA
         m7qA==
X-Gm-Message-State: AOJu0YyhrLKSQgu7HFybDByRzUj2lXG+mAUX0wZ7cSb7ACj9JHppuBpR
	cv9l+dIEQyTt/3PDYBtMe0ipdAbMnaP5Pw==
X-Google-Smtp-Source: AGHT+IHWZLW56cEGjUPne0H8GcD2N8UR3gb0D6O2HZjJmqSkbSFSUCVR9EbK5aiRPH985UiHyhMjvA==
X-Received: by 2002:a05:622a:1aa1:b0:425:4043:1d80 with SMTP id s33-20020a05622a1aa100b0042540431d80mr2644050qtc.83.1701558379201;
        Sat, 02 Dec 2023 15:06:19 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:fcf6:1739:7af2:33dd])
        by smtp.gmail.com with ESMTPSA id c4-20020ac85184000000b004194c21ee85sm2815417qtn.79.2023.12.02.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 15:06:18 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 0/3] bpf: fix accesses to uninit stack slots
Date: Sat,  2 Dec 2023 18:05:55 -0500
Message-Id: <20231202230558.1648708-1-andreimatei1@gmail.com>
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
 kernel/bpf/verifier.c                         | 73 +++++++++----------
 tools/testing/selftests/bpf/progs/iters.c     |  2 +-
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../bpf/progs/verifier_basic_stack.c          |  8 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |  5 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  5 +-
 .../selftests/bpf/progs/verifier_var_off.c    | 62 +++++++++++++---
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 10 files changed, 113 insertions(+), 73 deletions(-)

-- 
2.40.1


