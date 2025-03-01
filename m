Return-Path: <bpf+bounces-52941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1097A4A6CE
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA153A6DA5
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748D23F37C;
	Sat,  1 Mar 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJlSxP6/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D85258
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787335; cv=none; b=PBM3Pgh6RcX44GPJXmGHo2x6ZsnAgKfKP47jDo9CzlnrRHhklE0jRwtBZVxLvhDBh6udH8mqopFGYgmdW1p00sZZphOrxMqpCqNzmNF8HTk0V27jOmYc45HUBptRHUB5NoK4iJo7R+JO1aTPUuibdrnnNuCFWrLfnk+EyrlPqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787335; c=relaxed/simple;
	bh=lCFQkqrYefhTPhx1UAHsgIfxzuNUkSOz/WuUgzvXezk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJNtHqQnR3bLbyJA5uBY68f779NzDY2vqRRU1bcQC7vk5F4Jnc7IQxdeUkJ5607AIEcCjy8Oz9CT+3A3fcqyVm9eFoHQPcfITOfeR2pClK9IWNzX9lAtGbTA8wWixqkx9rVtYCWgtL9jwJ8aUwFcTlV0C1MmhkZJ6K/G4oJaopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJlSxP6/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223594b3c6dso46060455ad.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787333; x=1741392133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxigAmzfeD86qWidDllumvtbtcwPaTCfsIchHNKV/Uo=;
        b=KJlSxP6/DjnZID/mC8OIV3NuOIoEZcWZMutmZMDedCQKtR9oyJ+F37/5jTMT1ZiAgm
         gbXSez3rEYYHhrncOt0Kb9t6Dfb3wf3El665W+pd1rk9o896vYdLtRcxcc3UlA8ygW/Z
         tCRuCi+rZsKfZazOftHFb7XPBXyqZAtygvioCaZe1G1KuyJWwXP9397PX+pvMCB4glkv
         kjXf46HfTUniv+gzrrQIUciRd487uziRtPdcnF1dF/Cv8r++E9OuZQhd0SVFv759GsZ+
         kUILRP/KRwjOM6N3PbDdrBD7QyKaIghTyabrkxytmBkRLS1QhpbMU7maHLISjxpM6x/T
         8Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787333; x=1741392133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxigAmzfeD86qWidDllumvtbtcwPaTCfsIchHNKV/Uo=;
        b=gyjQIduQzahyLWuG6cSMjhLbUjxez8RFoXQAccvuC+UYQ1SKk6RAqZqIRv+FjW6FB+
         sgFx0UpopeFf/I5mEri7k+Zv2tjATXAs/7GDU8TqQXMLAXO0J4vpF8qj9KnMX/tRklmV
         Y2Xd9PGjG0zD1IBFydGNT3lpcAblhnm4dyBxgaPFHU9c9Gzvu2nbtjgP7qZ1QF06rwCB
         clzd8Vs0XZqBzeXQGvv0CnFyHM3Zu3iZaCZY/w60NNvjPkSC7H0TgJfGAtv+7/KmC+Oa
         /4KQEMhqMP/OP6yyEdHpQEYqm5+PXehAsuTmdZX/9mwXuaBmEnQvipwMrb9X3ZOLnATO
         +VwA==
X-Gm-Message-State: AOJu0YzW1h/KWm2/RQqlu9TNmKEOj5nVVywKgoZY7/pEXw/weCaUM1iz
	kWP47SIVoSWqjwQ18YzB0rwKcrhqw3bFsifmPGKL9GkX09tAI4sGVMhHnA==
X-Gm-Gg: ASbGncsW4RNAk+CURMH4ZFPbInYuKy2Y+ESCT7sVFuKzOyGCfY6ZVHh4cXBxTwU9SiZ
	YhTq05PudR9vmrq3/ti3/gnOEdkWRkVo6mUMFwIVra9Aw42njcBpPo1+o2SWxtsW6q4eMBvXjNo
	dEywDcdoImflc5n/qZ9uOhxICPR4zZXQLLRwrgA3B0/48bx3kZ6pPNfpTIVNljJhqux1DkiJjbj
	BWid59u7TT0hxOa4kB1C0j/ydtQBFR2pyPpAN4bY6ucUy9cvoUTk+yVN91/ZP8mURR45BUo8ANi
	Ys9iUA97Q79cMABxQO64i95pUIpoGZjhlPy/HD3h
X-Google-Smtp-Source: AGHT+IH1F2mxvH4cw8GOAZEIL89fL0vdxhSVQnthouUdNZIOq42gbsQs6SCGz6o9eeY0QLGU1YPMnw==
X-Received: by 2002:a05:6a21:516:b0:1f1:281:848e with SMTP id adf61e73a8af0-1f2f4e45152mr11262724637.32.1740787332665;
        Fri, 28 Feb 2025 16:02:12 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedf5a8sm3993425a12.70.2025.02.28.16.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:02:12 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] veristat: @files-list.txt notation for object files list
Date: Fri, 28 Feb 2025 16:01:44 -0800
Message-ID: <20250301000147.1583999-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few small veristat improvements:
- It is possible to hit command line parameters number limit,
  e.g. when running veristat for all object files generated for
  test_progs. This patch-set adds an option to read objects files list
  from a file.
- Correct usage of strerror() function.
- Avoid printing log lines to CSV output.

Changelog:
- v1 -> v2:
  - replace strerror(errno) with strerror(-err) in patch #2 (Andrii)

v1: https://lore.kernel.org/bpf/3ee39a16-bc54-4820-984a-0add2b5b5f86@gmail.com/T/

Eduard Zingerman (3):
  veristat: @files-list.txt notation for object files list
  veristat: strerror expects positive number (errno)
  veristat: report program type guess results to sdterr

 tools/testing/selftests/bpf/veristat.c | 70 +++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 13 deletions(-)

-- 
2.48.1


