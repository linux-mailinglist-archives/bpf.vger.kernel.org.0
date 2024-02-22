Return-Path: <bpf+bounces-22502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F485FCD9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D251F276A9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7E156973;
	Thu, 22 Feb 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViZhPw75"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEC15696B
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616513; cv=none; b=utl/WAmpZ5h+aD4S8iinwRUVJWYi7TR8Y78Ur7COCgIfqnK9D1j9fBjBYeYhV+SVMTkbwmXg157VRoioOGZJZeeYJ2gTxIiQugWN0wvChv9b0T5WTyE2DYE09R0j1QrrRHv6lq0ou77g/q8hG6JyN1PFU3kUQxoBeXJ8ITr/Lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616513; c=relaxed/simple;
	bh=+f/bDCH0LCqA5vvFPrBDyHGhwuHd0BZCV4+lfRe2skU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xms77VsmXDZG3epFJTnoV7QnFhvXG3IWX4tZXOkOKY+XBpgIxuWvAhBvGQoQ0SSwBDYhLSq8IU/OOX2LJG61NMojueNKyymlJ4mBuBaU4IhWPB7kKh+4usn0xxHQMz4CUWCDU81EVYa8O9oaS6u9343thd1we7dOgzfrOe3EBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViZhPw75; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so249119566b.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708616510; x=1709221310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOCu5I6W3BKQG7htbjgKNaZv0Zb74b0z2xgBrWp3mN0=;
        b=ViZhPw75MRm9koY1t3ITQlRX19mF+4IXxDotP3Q3CDAXgMiJFvOKfG0VxdfixmFoUw
         vVCJa0y3kR05JfMqmAHf9gnH+PsONwKNN5OjGRwm4q2VnOtY5hz783/i7UvbPrAerANV
         0W9JGjXsQJGod52uBjDoqsW1dSUNMZ1AMjS6IJWs+mJvm+iflh86TuOWKFEA81P9QCbr
         VADwFmVuPurVyVHqqBjwXS6YjoO2QTlHFF23/BAY5/4Od96On5z9/AZw0xFFPkrwBY21
         I9eEdr0raFg480TUtpMYK1B5dD+NrsYpchSybXR4/laVirsh+b33VuOT+0q0r0GA7qTd
         CtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616510; x=1709221310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOCu5I6W3BKQG7htbjgKNaZv0Zb74b0z2xgBrWp3mN0=;
        b=ZQVl201f7gOdjEAODxQo6qDyxEFhPtbxiEHhXOi7PrGFD1wjZ3R1SSJLa0X701iznG
         PJmfJVglHjU5YmgJl1wibfJyUo3YlQlXQ3Mht1YN8tLpHTOxYc5dlAQ+NkG6kIoZeyfr
         sbxsBukaX10bAN/hC+ELIqffSCJkAj28X48YbQjULouae8xKqb46ybM8znzSfqIhmcNc
         GK7vzApuwGTXgGiZV7d1IcowAjU4pf2mcr9eIK/vu31BNVbRJHrBgX5VOBi+8puJo1Fh
         A9gycRoz7D8m/ZCiRges+qJ/YTqkhRYQC5bG5SFkhMD5V3jmRTVF5vbYLOnZLwUIDF3T
         EBsQ==
X-Gm-Message-State: AOJu0YwRZu9hQmJaEB0bsQHwAnoULyKP+H920/4nUrW5ri7MLxLeCXe1
	fuVCEy9zlsl3nCsAV009LoFd4j2G4HMhAjHb1Y8VerBQqkxTwUqM5nDuCsT9
X-Google-Smtp-Source: AGHT+IFZ2KTgETlb+SbCgABM3dKHQLhnSnJpZF6H2XBu+qoBZa3Mc0hpljrG+QUWVlzt1K2/JvAyaw==
X-Received: by 2002:a17:906:a881:b0:a3d:6a42:a5a8 with SMTP id ha1-20020a170906a88100b00a3d6a42a5a8mr15215342ejb.73.1708616509728;
        Thu, 22 Feb 2024 07:41:49 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a3e1939b23bsm5725090ejc.127.2024.02.22.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:41:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 0/2] check bpf_func_state->callback_depth when pruning states
Date: Thu, 22 Feb 2024 17:41:19 +0200
Message-ID: <20240222154121.6991-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set fixes bug in states pruning logic hit in mailing list
discussion [0]. The details of the fix are in patch #1.

The main idea for the fix belongs to Yonghong Song,
mine contribution is merely in review and test cases.

There are some changes in verification performance:

File                       Program        Insns    (DIFF)  States  (DIFF)
-------------------------  -------------  ---------------  --------------
pyperf600_bpf_loop.bpf.o   on_event          +15 (+0.42%)     +0 (+0.00%)
strobemeta_bpf_loop.bpf.o  on_event        +857 (+37.95%)   +60 (+38.96%)
xdp_synproxy_kern.bpf.o    syncookie_tc   +2892 (+30.39%)  +109 (+36.33%)
xdp_synproxy_kern.bpf.o    syncookie_xdp  +2892 (+30.01%)  +109 (+36.09%)

(when tested on a subset of selftests identified by
 selftests/bpf/veristat.cfg and Cilium bpf object files from [4])

Changelog:
v2 [2] -> v3:
- fixes for verifier.c commit message as suggested by Yonghong;
- patch-set re-rerouted to 'bpf' tree as suggested in [2];
- patch for test_tcp_custom_syncookie is sent separately to 'bpf-next' [3].
- veristat results updated using 'bpf' tree as baseline and clang 16.

v1 [1] -> v2:
- patch #2 commit message updated to better reflect verifier behavior
  with regards to checkpoints tree (suggested by Yonghong);
- veristat results added (suggested by Andrii).

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/
[1] https://lore.kernel.org/bpf/20240212143832.28838-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20240216150334.31937-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20240222150300.14909-1-eddyz87@gmail.com/
[4] https://github.com/anakryiko/cilium

Eduard Zingerman (2):
  bpf: check bpf_func_state->callback_depth when pruning states
  selftests/bpf: test case for callback_depth states pruning logic

 kernel/bpf/verifier.c                         |  3 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 70 +++++++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.43.0


