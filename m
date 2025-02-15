Return-Path: <bpf+bounces-51647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61270A36D8C
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3459518951CB
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C85192D97;
	Sat, 15 Feb 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYV7KNA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789294A08
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617470; cv=none; b=rOA19x3PcPor6ZYsUOq2gUiNr0V2Rg0cZSuJpntlX7u+rnbNT3n9QcYVWRD20NtBjcGII0W5WRVEe3v64Ew2ORGC58wWQ7fmFksw0YVJXd4WCDZxWex4/AozJF6Yx6rdJtPeA89budYJ0H/u7PfpnwjayTv8QavG1quLq89TtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617470; c=relaxed/simple;
	bh=thMzMyTnwXroCH1tmrm079p7/ffXcbA6RwycGCYJWak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmOgutttlGaRGMYsFm2Q1etegrxCu99RPSRxINLdECNCKJJ4Oi9yWo5f7pSSvtCdCwaVDmYkg+QIxSrIVmCBuhrt6aKv6VGRWKKS25sAiNENa+tNSZgNcbtSpRXYc4cqFIGvv8sEjBa/K6lJwI17NTPIzdSJVfry9qihQ0hTlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYV7KNA+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ecbdb4c2so45341995ad.3
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617468; x=1740222268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bC7SwpcxZjHtzTQDxUpnKWTfBo7RT+JjSXJm5LztO90=;
        b=PYV7KNA+zZa83BJhi/GwVC3Eh2LOX2mwzPSeR8Woo5E5ZG8AzHecz05HXuOXh07RYG
         a6XlWi+lbKIPJe1ECWk/lCWCY4HPh8rlz1ZpI1VOHL8eMxDLgg9ofYRSmVu+GlF2fnnS
         UHV0FdQC5De3z+hw3zRjar8HfRRHWj6UyGAkrxVhf6yzXLuOoTtvHt5/lcTJ0OlvbGbI
         iIWr/f+i8k8J9I5bYCfpUOXJs3mSVVK2mxei4x86fvhP/3qixqI0jCeRXFHG2Wfr9N07
         sL8xgChjZ4fZ2bnPQ17P24sitS3iaXg2p/TTQfaBrgUF43J+yUKo9y3wM/eKmZoszcaE
         0h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617468; x=1740222268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC7SwpcxZjHtzTQDxUpnKWTfBo7RT+JjSXJm5LztO90=;
        b=nEVI+XFNxADD8t73eLMD7KzLjQxUAyIa04d0lk/f86eFLjOKzR2T9aw5y7jqnkHPsR
         574jN/4gd+k0vMDAE3eZy3FVNTf4dRAZfzWfwPUwzWLDUunH4RPPuTKsr6MWrJ0yF6Gu
         mq3LB/QE/y8LNXKCQHQZOBn72fK40VevRyZJ/L+f83aklpm2HuwwVyWtosjJeVMqlu8v
         oG8gJPu1SKT3jVY6hKYIjYi7KYPFv//YY7pYkX9GNTUPxKfCfZKhV8omXLlS4q5hOCM5
         rRjzDbR9zDp6hWFOYr+Wr0ADdPsIRQ3zEBAMnnhilQsNbS9G7i1+bGMpWzuQEBVVbNhv
         gf3A==
X-Gm-Message-State: AOJu0YwPaJFN6ZE6GV9xizFuj3KHeL8si919JARMIaB8A7vQs+dqe6Y8
	0apMN512b8cnUiKMNzsgIW5uqpJN0f2DNAbzS5px67ndlAisJlaMTa5Lyw==
X-Gm-Gg: ASbGncu9dSDIfkLvZGTLw/oTWgaDuoJqTxrGlTBUjbtTWHlBYdbKEjVsoONJKst0LcZ
	mZBMKF1l40aXj3cjhnfsHQLX6O8gJ7UZPMIsoEtxwYiXEfbpbBSzYsWCWHnbhegeoIBHtabdpl5
	bZD4bQjQ90nBc1bFykkPbGUFwxuiF2LsmDZwwkUzSUE7CyLQMiPviAKpsDHV3ChqrCdk8iL+bCB
	mJicCn+MBeIb9uyLrCsZ3NIsysLb1OpYcxLmypLJNTVGS/Nq0xINnpyLbhLHfvwpSbmLjOtCYjw
	KhQYsb77W5I=
X-Google-Smtp-Source: AGHT+IF8iH47iMjXEvn8cPOcOHCOCQ7Hy7i9na2BCVRyBGuf9gdmT3+SgcEYX3dgP4IAzca5tFKRoQ==
X-Received: by 2002:a05:6a00:4fd6:b0:731:e974:f9c2 with SMTP id d2e1a72fcca58-7326144ab2fmr5412939b3a.0.1739617468352;
        Sat, 15 Feb 2025 03:04:28 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:27 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 00/10] bpf: copy_verifier_state() should copy 'loop_entry' field
Date: Sat, 15 Feb 2025 03:03:51 -0800
Message-ID: <20250215110411.3236773-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set fixes a bug in copy_verifier_state() where the
loop_entry field was not copied. This omission led to incorrect
loop_entry fields remaining in env->cur_state, causing incorrect
decisions about loop entry assignments in update_loop_entry().

An example of an unsafe program accepted by the verifier due to this
bug can be found in patch #2. This bug can also cause an infinite loop
in the verifier, see patch #5.

Structure of the patch set:
- Patch #1 fixes the bug but has a significant negative impact on
  verification performance for sched_ext programs.
- Patch #3 mitigates the verification performance impact of patch #1
  by avoiding clean_live_states() for states whose loop_entry is still
  being verified. This reduces the number of processed instructions
  for sched_ext programs by 28–92% in some cases.
- Patches #5-6 simplify {get,update}_loop_entry() logic (and are not
  strictly necessary).
- Patches #7–10 mitigate the memory overhead introduced by patch #1
  when a program with iterator-based loop hits the 1M instruction
  limit. This is achieved by freeing states in env->free_list when
  their branches and used_as_loop_entry counts reach zero.

Note: for env->peak_states computation in patch #10,
      I think this should also include env->stack_size.

Patches #1-4 were previously sent as a part of [1].

[1] https://lore.kernel.org/bpf/20250122120442.3536298-1-eddyz87@gmail.com/

Eduard Zingerman (10):
  bpf: copy_verifier_state() should copy 'loop_entry' field
  selftests/bpf: test correct loop_entry update in copy_verifier_state
  bpf: don't do clean_live_states when state->loop_entry->branches > 0
  selftests/bpf: check states pruning for deeply nested iterator
  bpf: detect infinite loop in get_loop_entry()
  bpf: make state->dfs_depth < state->loop_entry->dfs_depth an invariant
  bpf: do not update state->loop_entry in get_loop_entry()
  bpf: use list_head to track explored states and free list
  bpf: free verifier states when they are no longer referenced
  bpf: fix env->peak_states computation

 include/linux/bpf_verifier.h              |  25 ++-
 kernel/bpf/verifier.c                     | 229 +++++++++++++---------
 tools/testing/selftests/bpf/progs/iters.c | 139 +++++++++++++
 3 files changed, 296 insertions(+), 97 deletions(-)

-- 
2.48.1


