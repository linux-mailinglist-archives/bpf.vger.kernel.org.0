Return-Path: <bpf+bounces-34862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A5931D74
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EC1B219CF
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A61448D7;
	Mon, 15 Jul 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJzvQ6J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1491448E0
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084561; cv=none; b=D0CL3BnLevFQrrxPE7P2f3LgPPKDm1ctCPyydNYiHNwwvKbmXhNx98eHTP9KmVv4hQIAkuoibLVZgn7JSoC2GBIbMy/nBPnoAeKpSn/BxLuxrctR/w9a2XX8wEG8fFARuaM0A5XciDYE+xfaJJFwUfmxnJXdHH/doqwLcmR1YnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084561; c=relaxed/simple;
	bh=6rR8nvi0lIDNBcvG9RjGUZ9FH0QpcOFS3RD/q60L57k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz/vew6tIYha6RfDEiYrLknJiEizZZJzJT+UJIPQDruyj9smubPkDh3D/WZLpb0eIzFTnhDCPR8euZ64xDlo3V2pKZWAJiDNV+eQB02sD2plAPCbkbglPbz7XLtRWehx/zOQ/JMpUzTCb1OCxadUXz1ZeFA7KQ/JEDoWVa79QNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJzvQ6J; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b42250526so3686506b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084559; x=1721689359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSvSc3lEG3d5pVzLc2yz77lX3sNbF6SElydtummTNs0=;
        b=XQJzvQ6JZOzE7xY71fbWa1SOEQ91l595gWfah19G68HODYA6lUYT5DEqCJif7/7dlm
         zsqR8AMlAA1+10RL2Lz9LQ+9NtY1qZnP0k6FnMcTbnT2VimxOKGlCkiQ5uFX5VvwJfRD
         Nz6qsIv1ISl3uZcD146Nuzx8tTsUKsk7jDqOeNh+KplwkIbbqBX76srWPZlrprovt79Q
         DkJNFb11c/ZkHoeP54zj3aDHakrCa7bhZUPx5d6BKsgIbKbL5UjK2MAqCLQCdFcvtcjd
         7l1E6JAaN+hrAXgUv9m4Lawa9mp2YHwx1VTKJH/HgK85F2m2LiyPg0P8GRT0HGOLFDNS
         52rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084559; x=1721689359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSvSc3lEG3d5pVzLc2yz77lX3sNbF6SElydtummTNs0=;
        b=ToYHrH7joU1TivsLeKi43CFnkuEoUSixVzGYY2jWK6MeQsCdPfWUuRO9OT6DfULeKj
         0TXdcDvN2PWLgsxWqqGhNnhimxghXniyUc+qpiUsYE6oor50se6hWgIKAxTh7uQev82S
         EhNw70tNG0fPcXRialKbEnaFlT1zH+VpEiLZAsIDptcjQT3fyYQ5QPp8RBfEp18ojfR7
         HXkOKCB6cW/yk6Vh6tyHQGXSxw0ha5vQcnKmL3+cP8KfsgUrBjvkouOlxQn3QR1NdDSa
         oFN9lSCaTXEiA1xxioH+wbja1SXc6iPkH5C2LMpabIsJOAHICQZEbdAaJdXeOl5z3Ysq
         vo0g==
X-Gm-Message-State: AOJu0YzX4o5WPtHZZICHFxh9m54kogp94qcc5/fPcxz+pxiGy6ddR6XI
	t8pRxZskeGnY0yi4C2UpWh4YHkv/KSnOYHSR+SYVeVSIYaDCh1P+3dKO4w==
X-Google-Smtp-Source: AGHT+IEopLU7SYBCSGvl2t/gbTCw0+1tSTdnYUn6M3uHSrKcqPlxtZsr4yazjcbViJab+86pUAo/6g==
X-Received: by 2002:a05:6a00:2381:b0:705:b6d3:4f15 with SMTP id d2e1a72fcca58-70c2e9b5544mr606985b3a.25.1721084558680;
        Mon, 15 Jul 2024 16:02:38 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for ARG_ANYTHING helper params
Date: Mon, 15 Jul 2024 16:02:00 -0700
Message-ID: <20240715230201.3901423-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a number of BPF helper functions that use ARG_ANYTHING to
mark parameters that are used as memory addresses.
An address of BPF stack slot could be passed as such parameter
for two such helper functions:
- bpf_probe_read_kernel
- bpf_probe_read_kernel_str

This might lead to a surprising behavior in combination with nocsr
rewrites, e.g. consider the program below:

     1: r1 = 1;
        /* nocsr pattern with stack offset -16 */
     2: *(u64 *)(r10 - 16) = r1;
     3: call %[bpf_get_smp_processor_id];
     4: r1 = *(u64 *)(r10 - 16);
     5: r1 = r10;
     6: r1 += -8;
     7: r2 = 1;
     8: r3 = r10;
     9: r3 += -16;
        /* bpf_probe_read_kernel(dst: &fp[-8], size: 1, src: &fp[-16]) */
    10: call %[bpf_probe_read_kernel];
    11: exit;

Here nocsr rewrite logic would remove instructions (2) and (4).
However, (2) writes a value that is later read by a call at (10).

Function check_func_arg() is called from check_helper_call() and is
responsible for memory access checks, when helper argument type is
declared as ARG_PTR_TO_... .

However, for ARG_ANYTHING this function returns early and does not
call check_stack_{read,write}().

This patch opts to add a check_nocsr_stack_contract() to the
ARG_ANYTHING return path if passed parameter is a pointer to stack.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 438daf36a694..77affc563a64 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8684,11 +8684,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (arg_type == ARG_ANYTHING) {
+		/* return value depends on env->allow_ptr_leaks */
 		if (is_pointer_value(env, regno)) {
 			verbose(env, "R%d leaks addr into helper function\n",
 				regno);
 			return -EACCES;
 		}
+		if (reg->type == PTR_TO_STACK)
+			check_nocsr_stack_contract(env, cur_func(env), insn_idx,
+						   reg->smin_value + reg->off);
 		return 0;
 	}
 
-- 
2.45.2


