Return-Path: <bpf+bounces-68753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4398B83CEF
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8453517907E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D72D94BB;
	Thu, 18 Sep 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFU7vQlq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A12836AF
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187964; cv=none; b=eEEivHriLgdUT2RuRn6CLAIbMg9Am/4BLUCSs6aOvOxGP4hwxylUmqQpdAUJMYi23leUxntOcYdcR9PeYdpiFhN7/S9RBeTZO0B8b1DV5Q1g3STlPcS6KeYPUp1W2LUiBxaR0SKDO08K9A4ImrpyD4bD2ODox/SgX1v4XFIVrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187964; c=relaxed/simple;
	bh=WqL9FAESHxYzDs+rQ/RRSleqMkZWB6P+MsPufIemKbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nmm/52kQ+6wvkwUYoHr0GApLmskhN2Iu/J7SdbHDz0A/AVwjToU377vjOc5qo/erV2uA11pdf9RnGFHpBZri4j2u7WCooDtD5Ljh2Bd37k22Sp2z06x+faPe2/5jWdlLSi72BjW43n5Gi4YTo4zB/f0q4SoOc2wAnz0uqpbRX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFU7vQlq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso604172f8f.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187961; x=1758792761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94XNoWpAKBQurQvAi2p8f9QJgIEAh6Ad0e4rqBA2y9M=;
        b=bFU7vQlq78mk7uWONuKEv8f25WXgiRYCX2TmmP+ULMr/lCjDi4dOPXKwAXuqjRMxtT
         PupnEnwaE4B5AXa4nEwWxeRFPIi590jvAUgstcWpk0ttWnKdQuJJ8cRsu5fRZsjjs7hB
         j0xfWNfE6Xf8ZDl2vaSdetfj18f4FbUz+8E//Hzpr/rOedHCk5KhQBFiUL+K81SNljZq
         bgRIgHvhdMgRsRRcdkKX0kL9dJU6YzMOL3XzmbQ890I/TYXvn7QyY3gdO36XZ1iQW7nC
         aqUagD1dTdFhKZ2Tc51MK1bu3g4r7PcKkNClQFtjN/Z1Zjn2qYYFduSWMjhG0UYySi3R
         C6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187961; x=1758792761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94XNoWpAKBQurQvAi2p8f9QJgIEAh6Ad0e4rqBA2y9M=;
        b=CSpHF6lv73pV/V/LVwYjE/vXH+8hZBjHp8bFmq4pkrp0/iRcjRrjaXmpGwRADdN8We
         nUYV5cMGSmkOWmZkdaTI+bObJDJC9kyr8FZlb0+AzPbS8HIpk2cwPkBmEAFVVNV9eurc
         zTmvkZT4kIJGc47+sMNmSfbjiugPc4mgKIrTLfKE+trrN7/7fh+rXmAz4lbWIPEcwD3k
         ImBhoE9JN1Rq8vOGMV6bX1vK6faozV/K3bnRJGO8NW5VZCW+iNXfg+mnZyyFIr2t0M72
         uDga08P/xllfc9S9ZczfSekjGIfvVBCwvIt9MFuaRQdu107iLyQ6j7YaTRlop1A9AVEq
         McOA==
X-Gm-Message-State: AOJu0Yyc0XZesLy+fsPfq8dr4oekNl7lTPGvWUIxPxAj1mL2rEG5R9s3
	DWRvm4ONjl4saOrbhT00sr1K14ftAYbxOlQjk2vJsBdxV2LjdIm3qiLUQ8kisQ==
X-Gm-Gg: ASbGnct9CyV1s3qOC08h0TD2QuwiSpi1M6AumcqgotUCAuPX5A8aO8ehZvoRERIXZFG
	JCmqzV4Ht6WpQGjTkEr5TjotOZW2lDsE4feAg11xJYkxTDU1u4FPNN/vKxqxlNzBc8vfZ/uATqT
	T2/yP/vGwPjCLbQIdRHoARAyhSubUpQ1NoNoAu/fGsLWzHjrMhshoDQQwRuo1d8qu8PnNbNdWf2
	Vl4yJ4F64zKAA0BL/uoxEREDD4ypdWg/+HqcAcscErKWbpVu1A+27HBqGYRiqvb9up060liR5hO
	4y7LL3bxnJIG5rpuz1yACKO//Wz4BBi8+ZBaxAf8knKBnGgqFrxxsEeRujqPjxMFO52sBo5yyx3
	h96bS9XvaDZcmyKTGcl8vzsOPS9E8BUVBHrcflqnuG5TXlQ/lUTiy3YMzHIaq
X-Google-Smtp-Source: AGHT+IFLsW9WHYC3EwrMhit8qILVt5/LJX2pHxnjfGATwHuPa0+mZRACUndQtjoFFxqaLt7C4nBcpw==
X-Received: by 2002:a05:6000:220c:b0:3ec:dd33:d0e with SMTP id ffacd0b85a97d-3ecdf9b491bmr3289780f8f.4.1758187960330;
        Thu, 18 Sep 2025 02:32:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:39 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 02/13] bpf: save the start of functions in bpf_prog_aux
Date: Thu, 18 Sep 2025 09:38:39 +0000
Message-Id: <20250918093850.455051-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subprog_start field in bpf_prog_aux. This field may
be used by JIT compilers wanting to know the real absolute xlated
offset of the function being jitted. The func_info[func_id] may have
served this purpose, but func_info may be NULL, so JIT compilers
can't rely on it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff5..1056fd0d54d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1601,6 +1601,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6e4abb06d5e4..b8c4b4dd2ddf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21611,6 +21611,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


