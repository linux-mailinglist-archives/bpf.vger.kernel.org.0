Return-Path: <bpf+bounces-29811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70118C6F46
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 01:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBFE1F232D4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98952F8C;
	Wed, 15 May 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwhDOZRj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80382502A1
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715816385; cv=none; b=kepalaaMfvdCI+k+svk8MzEJ1bTjKxpEWISZQmJXZixhBuzfkZPUhPIGD1BD0tHiFpNVMKZQ6BNdgqfdquac+7sN0LSayJxh73ijqq3kZ/HAQoe5sFFLK/LlIvt9iSp+UiHB1MNGnBL2wqKyjR0mssUIoPnLuKwE7UuWhOjJEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715816385; c=relaxed/simple;
	bh=c5oTgP9QkkqMhl0mhuFCPOTyp5qmTdwIBTcPx9gqqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHKGT00/3DMGQ0WnL4jPxOtWM0Pk+ZxRaQ19uajlH2f8vRpQNvV+goeYXyQ9/7cLPY3t0j9ivPNd1+R105p5mMPUBkeb7FqAzA4tggqsdU8trU36OAp7lE+WEJHsTwAUyyMqqMJs1/T4IS4/CcWXGFs2rAMrQGBoLKT5t9144v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwhDOZRj; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so246327666b.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715816381; x=1716421181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuFNtRiPUxiY2ssVsIPz8qk6a5jINgTHJnFo8uiNf6E=;
        b=hwhDOZRjnBef6cisxK+8vNfVInPTrs+3fKIBMi0OjbZmTvK6o9pl8dov01XpRnEEHh
         KfREXoxw0Py9GAFLFL+bTb9EXc5wCIVwQAOwnt5XX/N68ioMeTdV1ySVsIXLj9t2ajRC
         gccJZ6ZWWDqpfplugT5UVWbK7syayipandwYuynBz5LfM8FeceYvDMSuRyJki0FHHy8z
         /LdQixOsdzTQ0YS10k0FdXTMk3Ga9Bdyzm0NtifulLVFVCfaOfwXjuVSVCZ8xgqz2ET9
         4Tnx6UbvRKy46hsuMPN/82vFGJtpyNJa9AcnBF5BzOAgFNDfnBfD+3Znfxmzu6e9onuE
         EycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715816381; x=1716421181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuFNtRiPUxiY2ssVsIPz8qk6a5jINgTHJnFo8uiNf6E=;
        b=f6amOtjIx6zQ02SKvFqBAe4Ic7IUIMWSiDtYeyjqzoox92NK7UmPO6QL4f5vaNyld0
         QH/8ClI9tS6bbMclDOQTxyKXoWgYbJMCqRgVmyt/7JUcvjXynt6WvM1gL0a197arK2wz
         Evxq+2atLWdO46CUmKc4vuqOLLt0T5kjxeDd366pZqfU7/hCqulozTns7sgFzLLxYDz1
         HuGYWsal5BpPgmSDX4RAQhVSXi/NpM+aE8BEDQbdI7woRBjpxDodUk0aMfml8Mseo6Mo
         UdUtkUn9uwhWsUe9aFFWA0GdU23CiVW9uWtnWgZNHoLp6zco8qu70eMp2MXerLiVcXs1
         HV1A==
X-Gm-Message-State: AOJu0Yxdh7FfquW2LRtliUp7PWqrLV20ZHJSq5k7cl49PePGyVtYlpX0
	ZkXAswZDJezpdcgTiGt+RjWng4MmTd4nl53L9SM7xLJznKbgyeiuDIWgl9pT
X-Google-Smtp-Source: AGHT+IEU7ZqNfE7Y8V9LyIud1++9gvQjHgulMM7+L1Hafa7k6IV8YGZh4M8FiVTP7YQQWUDch8PaPg==
X-Received: by 2002:a17:906:7807:b0:a58:7298:fdfe with SMTP id a640c23a62f3a-a5a2d672028mr1165759066b.53.1715816381356;
        Wed, 15 May 2024 16:39:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c80ffsm914408066b.115.2024.05.15.16.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:39:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH bpf-next v1 2/2] bpf, x86: Skip bounds checking for PROBE_MEM with SMAP
Date: Wed, 15 May 2024 23:39:32 +0000
Message-ID: <20240515233932.3733815-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515233932.3733815-1-memxor@gmail.com>
References: <20240515233932.3733815-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=memxor@gmail.com; h=from:subject; bh=c5oTgP9QkkqMhl0mhuFCPOTyp5qmTdwIBTcPx9gqqZM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmRUUlHVXLEcjnMz1ZjXdYJR6KEUpM7hl4PD0Iv CImrToA1vSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZkVFJQAKCRBM4MiGSL8R yvT4D/oDA65a3kATSPCKOqlcWENl1KjrvVOZaJpHlN3n8hWF1Da+p7fpnz/j9v0sQEMgcZWUtu2 bVKKsA4CZRddxOn6wnNHxTsE5ilhBUtYjb9CgnacnndDL9EaQtqxOGEnxUAVo036zQAncpO3RkH lUlmZPL6WcEPQhjmbuNCof2g/YYLELjaOhSoh78NGcxW/nvDtdofJ/kJ9CF4yDEZlsz1h01UJpi 7ayH9wHivPIRCiZH1MbYdrZK1fGMwddbWXfTt8VJzqsfVja9gpzPK2s1Jg6LDtIi+wIS9/7fhlG ig2lwyaQpxvnnHqEiIpWnrQ5QSbzyk9cqM1hu5MXh7J1R7FZysDRoE+ZgkIZQMr+MS+l5RymCU3 bWD3jEj73iy4W5ZBNHcotRtPev41uD2QlfF/jxYi5z1SVkd42eL5h/owANQrRMhgy5euAkmQIui jAba3Qtf9JiJQXk6Z197S7kmsxoP5sKUyOflPPl8rZSkjQGJ97GQeYLBHAQqPB+wFlfk8wmrx1X ZVl4zo9xx/RjK03Lw1NI8vwCMUWS2YTkHr3l08RZjxNmGjjy/YwE+gr6WIsaVmQ6HeaPeHk9FDu wL2CmOcdjzWPddcQzLhY5Ycg2eBk63L6sZZkHYMLIK6pY3coSoQOzgwbxZu2QnoXS2VYzMp4xro ZEtEUmwfbN3l28Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The previous patch changed the do_user_addr_fault page fault handler to
invoke BPF's fixup routines (by searching exception tables and calling
ex_handler_bpf). This would only occur when SMAP is enabled, such that
any user address access from BPF programs running in kernel mode would
reach this path and invoke the fixup routines.

Relying on this behavior, disable any bounds checking instrumentation in
the BPF JIT for x86 when X86_FEATURE_SMAP is available. All BPF
programs execute with SMAP enabled, therefore when this feature is
available, we can assume that SMAP will be enabled during program
execution at runtime.

This optimizes PROBE_MEM loads down to a normal unchecked load
instruction. Any page faults for user or kernel addresses will be
handled using the fixup routines, and the generation exception table
entries for such load instructions.

All in all, this ensures that PROBE_MEM loads will now incur no runtime
overhead, and become practically free.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a22922..f8a39189cddc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1864,8 +1864,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off = insn->off;
 
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX) && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
 				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
 				 *   and
@@ -1912,6 +1912,9 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+				start_of_ldx = prog;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
@@ -1924,9 +1927,13 @@ st:			if (is_imm8(insn->off))
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				s64 delta;
 
+				if (cpu_feature_enabled(X86_FEATURE_SMAP))
+					goto extable_fixup;
+
 				/* populate jmp_offset for JMP above */
 				start_of_ldx[-1] = prog - start_of_ldx;
 
+			extable_fixup:
 				if (!bpf_prog->aux->extable)
 					break;
 
-- 
2.43.0


