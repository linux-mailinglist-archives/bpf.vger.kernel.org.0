Return-Path: <bpf+bounces-59809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BC9ACF9E5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E9E3B03C9
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E827F198;
	Thu,  5 Jun 2025 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLxBwJ3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7A1F9F51
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749164786; cv=none; b=Z5iFdJ5In3moDSY57ynVg2/JjX3Nt7xw+sPXYz4aKa3eK0z0yH9O2xC8bgXYBFqD8rcTmQM+ysxgVZMM5Cd2EUZSjoVu9RRw2Xn3KqPTO56LsnUR3GuTzMs8Zxhp4lhqOOWNIWTrLvwK7PN4kAbNp0La7qknsK1wZu4nOupe2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749164786; c=relaxed/simple;
	bh=5FzbUAI46IPDJzKTvvYI1g5uG7rIhjhLi0hX2jVv1Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah0+ikKFiO75PEr38mtnOQy7ORPd/BJJ2mcRP3n8D+itZW1oxxc6mwPP0C3npZMsqM0M3tiLJcsdfTB0dwQYyZ7+N9AnTEuDCbw4a2Gc27ys9/e3332G+oarez2rwlF0eaPNDGjWlPbakktRJGzD4VrwPOUSjoAXgZFv80r/eME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLxBwJ3+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b440afa7so16027055ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749164783; x=1749769583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5y5u+ADiGvBRxFnepznnRXHrJAIZnHU02KDSA7eOuw=;
        b=KLxBwJ3+sZg+cqt7d/R3VXLaPTGJs3xEheZwO88Q5XaXivAoy35ghFmiMxEUylrmDt
         BbzIg0loYeWb4n2es3p7oiClF9tyzhXeTKZydrtAk2vqgrkDp02zXmymeeVwSu22v7hv
         P6v0AUAHXm3FxBPUrEvTZi/Jx2dTw2LBaAddGkdtwxPtekA8moqYzd6GZNPueeCBWUEc
         99neIsXc8pvtj8eEEi37VIgFseox28yZ0X1rDYj6QDjW5TanT4mJk6JNphV0UCrDxhP2
         AsUAl8JFacvEUwghiGn6EIi/mgjZ54W1ANdtAwDSfwAIXiRCFNOwVjflyJThVFCkc0Sx
         yabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749164783; x=1749769583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5y5u+ADiGvBRxFnepznnRXHrJAIZnHU02KDSA7eOuw=;
        b=nspV7P1N/x5y66G2Esl29ypkuA2EpbL7iJN7M5OOHfIkBN2kd2qiyR6kGTsCeqyC84
         0WrLIY7zxQmMloEOuVLQnuiHUXYopBb3wY3BZ7mAlpxmjChYL4PapPXduCPwMnr7UaSt
         Ii/bZ/eMTMbHyXN1ezfycZY/Ukjg2mR8gUojtgTsfDVf2HJTMl7XHvOGcxhPC/vWIbAu
         RuxAeEPxydkdFz26qKVzaSL2+k92nY99SKIElWWMFYzv4aOWWnuKBjf3lmugQdq9TFOq
         SoKz2Ib/tqy40VnW+uEtKddIRd3cLBj0/mFVObDB8Ej9Iut4MlCqTlTWnG5UgZ8eHL1b
         LotA==
X-Gm-Message-State: AOJu0Yxtc/OJzukzQHlmGagCo0J4+0WnLyqD8Ns2cUBIBxxiySHJLvwL
	XBV/PxSwjiwjv4NN5R2pOZ2UL46GfYpNkz1bJ8RvbQw4QSUxI8SbokCCLi7/x87klCM=
X-Gm-Gg: ASbGncuBP9Hsa3xiifF5ja8nDwi1V3nbp8oIHMMRpp5z6PML/1ioORkQ07pU5/c+NRc
	VIsvprWb1Ask2O7H4PbzBfDqUh4Pw8cdS3rlNjZZ2c9ezgThRTdc4HmlpgLbPllqLWjgSqZpbKl
	VxzZBEMZpv4gmwGImN9vljIK6m/G/jT/TFmZYgpAJWMacNcigr1N/YjrehcnQkzSxvkmdXKtlnR
	bpPbCKhhe4ivkQppG020ebIfwaCMgo+7/3JwuK5JSR/VJhQOz0qPBu5cORB8RAm0FtZrMG3X2UA
	YRm9Z7GDblwoVwv3BBp+CYDN2wEJEACaddZcM4bzHLf1PGdlWhsJyEsIhg==
X-Google-Smtp-Source: AGHT+IHT1sdQ8Oe+8qM7kQ1Jdecb4mCCQD2J+6zesfI8yp9M9oxT2GkHeI2T3MzRlBrxjb2oErjMCA==
X-Received: by 2002:a17:902:da88:b0:234:ba37:87b6 with SMTP id d9443c01a7336-23601cfdc9cmr16300875ad.17.1749164783553;
        Thu, 05 Jun 2025 16:06:23 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092635sm1305655ad.81.2025.06.05.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:06:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/2] veristat: memory accounting for bpf programs
Date: Thu,  5 Jun 2025 16:06:07 -0700
Message-ID: <20250605230609.1444980-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on the verifier, it is sometimes interesting to know how a
particular change affects memory consumption. This patch-set modifies
veristat to provide such information. As a collateral, kernel needs an
update to make allocations reachable from BPF program load accountable
in memcg statistics.

Here is a sample output:

    File       Program               Peak states  Peak memory (KiB)
    ---------  --------------------  -----------  -----------------
    bpf.bpf.o  lavd_select_cpu              1311              26256
    bpf.bpf.o  lavd_enqueue                 1140              22720
    bpf.bpf.o  layered_enqueue               777              11504
    ...

Technically, this is implemented by creating and entering a new cgroup
before verifying each program. The difference in memory.peak values
before and after bpf_object__load() is reported as the metric.

This incurs some overhead in veristat runtime. For example:
- increase from 82s to 102s on test_progs BPF binaries;
- increase from 42s to 47s on sched_ext BPF binaries.

Measurements are not completely stable and might change from run to
run by +-256Kb or something close. For sched_ext binaries I observe a
rate of 3 changes per run from a total of 188 programs. Mostly affects
very small programs.

I tried a different scheme, where new cgroup was allocated only once,
and then a combination of "echo 32G > memory.reclaim" and
"echo reset > memory.peak" (via fd) was executed before each program
load. For reasons unclear this approach did not produce stable
measurements.

Eduard Zingerman (2):
  bpf: include verifier memory allocations in memcg statistics
  veristat: memory accounting for bpf programs

 kernel/bpf/btf.c                       |  15 +-
 kernel/bpf/verifier.c                  |  49 ++---
 tools/testing/selftests/bpf/veristat.c | 249 ++++++++++++++++++++++++-
 3 files changed, 275 insertions(+), 38 deletions(-)

-- 
2.48.1


