Return-Path: <bpf+bounces-53295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C288AA4F93B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 09:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15E9165D05
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A61FDA63;
	Wed,  5 Mar 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmO3Q8vO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0541F5850
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164893; cv=none; b=PfBneDgrU9ioGjSUx12Lro9rnd55DrrJ9h0bQlRxap3MSsNsNFS6xHj6Vwj+JfVpJsa2vV+3VRyaGzgBFfASbqVjv2qObKD3lPnol4goaKEhjnHOEagzO5OYzRUHnRMeCDL/vUNacymr55T/DUbiL6DT5icHw0vmX51Vg5e7qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164893; c=relaxed/simple;
	bh=lFX8YiDKKigB+P/DtWHh+WXI5zUO6hvlw/dHF/zKh1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgQDL3BTo+8NtrKI8CFU261mDbpJKmkZECmfTS/c7/F7FuVWbVNFBYdRv26jg2SvAPPb3d16iHFY8+eLg+dWGsgpfFa1qBs0iVF6ImsWmRI2jx1eBj+6DxJhb9bK//xwEOKpZz25A6y/HAaVp84ULv7n4B+b8FrCqarAztSBp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmO3Q8vO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2237cf6a45dso66300405ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 00:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741164891; x=1741769691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLhKFSnuTwI1/bERxwY0NNbfGff9M3abeUujP6PZPfs=;
        b=FmO3Q8vO5qdRZCJ0bU/ffOZOkOxop+ZXZgx29MeRU6o+dbj9ySVbX5BCrbpLsKC+zz
         R9v5abWOKP+xZUpzaunkMEBTObgMhNPKZQbkkLNPTO2b4eebnFLYr5I2XbcN7WMRjsjJ
         nclLq3fAq+cyfvLVEahCRUDpVJ2KFhAxxEWeOj8214zIa8ZqmMrFmI8q2cZC2nSSC2Is
         9OCzULBTICl0luqoPN2T60V965gZ4OA3wqoVxf7BW8STHPhvEnaBFDG6UlVAHtVExRV4
         BxZqj1tExwxAggEUMwlkUEQyIoLq+uBJr2Sxjf/p84hEfBEn70Je9MdAQaYwQkZZ1GSl
         JuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164891; x=1741769691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLhKFSnuTwI1/bERxwY0NNbfGff9M3abeUujP6PZPfs=;
        b=b1VY1OO4AqfcvQJ0VL/eYbXYx0YXnQCoXeN139oHJC75g/Mq5QvwlmBJKfY4NdJ/nY
         L9iyXhxXe5iveCeFcIMRzsOMqPn+5bQSTcO6jyjA/HjO5lH34FjMkHxzx1fYwletW+QU
         5evFaaudLd+R4n39U72Tvps/5gqW499FVKDtlumWdQOoMdYsX/LToORyLyTlBlfjLTWC
         GBr5LFVKGSHYy9BGdrSddVWsBzi8GPhsBu5yT9sXSS6Gr1VlmWsL8OozkW86F2odK7Mr
         VD8HptAIZ/xIQ79Im+B3GmnEEexKJkntC3kmpXJb4xo9SiFpG9Z9Hq/gR+zt1p9ttiuf
         t1Ng==
X-Gm-Message-State: AOJu0Yzmz48x6nabALZXZyX4lvHIS1v+3t/A3LhBWt12lsKhfqHPWUod
	1Q8IFpx9j7hp4soh8Mvh0zqC6kZyd4pqZ5rsOTQ0ESQoe3G5BjbGuL4ELw==
X-Gm-Gg: ASbGncu4u2Gskm3pi7Vk0SBjUJiA1m65OehXMbOVB5XfEQkNY0fAUxmRLyNW0MlbGiN
	obgUjcjumVDH6/nPqKWxz1lDb3N0yUxh+GsQUoJYt/F3EdrYFw8YoGudOM33ZCVEydTpeUcPzPT
	0widR/HA3fXRGAULayiMzyhsvvTFY+EJvt5LJGKnAscPOaGk4yUoy5FyMZaULMYin5wH1huAA/x
	nU9GavYa8SJvCIxkWCZqDvu/JwGPXQKfVN4AmUR3Y///Aqqqf6U3LpH538QBaSoGu6tbV3ZQB4Z
	zQJwfYLWF8hBDs2QzAVZaDgK/Nh8bBEir1E+9zTX
X-Google-Smtp-Source: AGHT+IHizDkgvQCrnndo0r91AOtVIFbq3yb6I00LGbEjlM/nJbjPILhlMYaYacAZw8uvVkad1bEedA==
X-Received: by 2002:a05:6a20:244f:b0:1f3:484e:c551 with SMTP id adf61e73a8af0-1f3494e354fmr4165193637.18.1741164891438;
        Wed, 05 Mar 2025 00:54:51 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af234b133d3sm5112888a12.41.2025.03.05.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:54:51 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] bpf: correct use/def for may_goto instruction
Date: Wed,  5 Mar 2025 00:54:36 -0800
Message-ID: <20250305085436.2731464-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

may_goto instruction does not use any registers,
but in compute_insn_live_regs() it was treated as a regular
conditional jump of kind BPF_K with r0 as source register.
Thus unnecessarily marking r0 as used.

Fixes: 7dad03653567 ("bpf: simple DFA-based live registers analysis")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                                      | 1 +
 tools/testing/selftests/bpf/progs/compute_live_registers.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4edb2db0f889..3303a3605ee8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23567,6 +23567,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	case BPF_JMP32:
 		switch (code) {
 		case BPF_JA:
+		case BPF_JCOND:
 			def = 0;
 			use = 0;
 			break;
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 14df92949e81..f3d79aecbf93 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -294,9 +294,9 @@ __naked void gotol(void)
 
 SEC("socket")
 __log_level(2)
-__msg("0: 0......... (b7) r1 = 1")
-__msg("1: 01........ (e5) may_goto pc+1")
-__msg("2: 0......... (05) goto pc-3")
+__msg("0: .......... (b7) r1 = 1")
+__msg("1: .1........ (e5) may_goto pc+1")
+__msg("2: .......... (05) goto pc-3")
 __msg("3: .1........ (bf) r0 = r1")
 __msg("4: 0......... (95) exit")
 __naked void may_goto(void)
-- 
2.48.1


