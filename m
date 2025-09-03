Return-Path: <bpf+bounces-67283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556EB41E57
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D51217D022
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D627FD49;
	Wed,  3 Sep 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbY3pNqb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CC2FAC19
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901165; cv=none; b=cwjunrOgz82A0LtV0LWTrQvRk4Npi1HiAYR9Bzao+HbMCqLRfL3QfgKcDeMIlBq8UB/ByY/UOX77gbPFOXqygLfI6t4MoN1EqoHJHGTTXO3ZYxuTMjzn1k1gvPPlqByVmv/DEa3oZS0ySbcmOL9s2kJ/XxhkTDcpiN3by/0NttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901165; c=relaxed/simple;
	bh=PpVmgWHtlHzTEWSzjqMsLMqVS2NTZDJvoWyT+mQ6KRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9cAD0OVKqHbNKlxxxT/jpnDRr3UHVtWI64oqG8IIYHT0DT2hJPc78AYb/8SHOKrzedbvuhxSrJ+G67lzMBTJkYNj7UR/JYrC0CKcORDuSBWg58WcZ922BGlTqKqwEVNRhyw5DWCC0llb4y9q0ElQC6Chrg6zRItIeX19WLqJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbY3pNqb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so880949b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901164; x=1757505964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i79mMmWi1o5Jhs2l3W0//QPGmkXUcAOe3z/upCCt3A8=;
        b=AbY3pNqb2ifhyWJ6Nh1tj9Vtk8J4I8XiTcWLYxaN01S4C23aAvRA1YUaSWlEw3xDpO
         Sa/sAhBmKkXUx40VOhYw4+tW2Ki1JqAfeG9VApDgykbDRbZF3moMUGQsayTAiWPcxRqg
         2EPZ5BchL/djqw+9od4r9DNcVsXYrSfoubfnCi1WK+c+CDv5LGQ+utYjg1N9Fzg+FznV
         zPqOzxL6XpQoGgNG9veROi5Ki2as0/EaQIXfJywc4iAwAPNi1cmq7YuWB4xa8xKmV/hI
         Z0YDTAOBX+SZkZwoZ0NJo8AXWPRaKcjcqJALL+dsQ2fuH40c+9F9RGw6yNTnkwmfMHlm
         BbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901164; x=1757505964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i79mMmWi1o5Jhs2l3W0//QPGmkXUcAOe3z/upCCt3A8=;
        b=I7fll11RVopqEpcrrpSW3+O6ntYBiGywfrVU3A7lPFwKVWDF61i1xu91T5WDscijHc
         uq83Mstpchi2Eq6nz11H1s5dblwVAB2fXcaNhr9lO6cCmobkJ4+fXTfXd/1EK6IG+Bo0
         J1ZfYaS1KhVdKoDYJqAsl4lrvU9GyIqiSXLmJ3V6Ils62Nd4ZSUCkk+UYOtK7I35++3V
         39OPW43L6rLcjHyQ1Je7tiOphwZRVgWZ7G6qYa40N8w8WpnfE3N4WStA1y9/Fo4JQU6q
         CoZOoad43iAWdyiG7hPQ2wF6NiemWLJLoXMZJAq+KNtBYJoPMOwmBPh7uX4yjcAXUkkh
         Agaw==
X-Forwarded-Encrypted: i=1; AJvYcCXODhRr+0UaYbiAhSdzcck6aMqZtdvpkVibWfqySdvbGmBKfDah4Ywc0OU17Cu4TLlOERo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Bk1CRBPfjx76PcRQVfN+925ftodh9TfWSLffBFBfGeP5ycZu
	G1KmxKb7q8Ktrl9qN4qm+3v+T2aoa3V9SRjF558NjRMTlRlQjBaTN1sbrQsEftYr0y4=
X-Gm-Gg: ASbGncvDWqzWPRjzrmhGh5tIzHKDjUU0f/6gNKTwlJJcc4cubQ18JkcncNw2e1T/e4m
	ZhRHLWCDoN2stfhMOx4A1g9i6zu0b7vlYIRGOGb1YYPsM8olk6KIuyzaTFMZ9wm/zcLn5h+ItvG
	q57lYEgu9pPYEtDtZ2Pimin3QZzhM+3WYLB2FGfpeW1TPhAejH4tQfslwgn5Ra7autQPM56xFgj
	RhrXVun2pd9hvwI7LaqP6Pzbg5lbz5hWyU8G19U73VfyF6teCBaU+iCP3fzznhn7b6WGe+rqRkJ
	x2lSyYsRtzjJ86Ms/0pf30JD3BCij2v6xyeWXHd2xLyRe3OwXe+zCcSguGbE34uHD3TlOYDqiR7
	8xgizEFisnmUKi1ARqk8Qc0H7u1U1eolk8mme8xdm
X-Google-Smtp-Source: AGHT+IHGbnOJk18bUwBHacTOhmiIU31YcL3OajmhbJ5I+4pPssQpYpN/NF2+xMZn6DOP0Zn2or3RfA==
X-Received: by 2002:a05:6a00:2b86:b0:76b:f7da:2704 with SMTP id d2e1a72fcca58-7723c503bc8mr11722818b3a.11.1756901163417;
        Wed, 03 Sep 2025 05:06:03 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:03 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 5/8] LoongArch: BPF: Don't assume trampoline size is page aligned
Date: Wed,  3 Sep 2025 07:01:10 +0000
Message-ID: <20250903070113.42215-6-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, arch_alloc_bpf_trampoline() use bpf_prog_pack_alloc()
which will pack multiple trampolines into a huge page. So no need
to assume the trampoline size is page aligned.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 35b13d91a979..43628b5e1553 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1747,8 +1747,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 	ret = __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, func_addr, flags);
 
-	/* Page align */
-	return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE_SIZE);
+	return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
 }
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
-- 
2.43.5


