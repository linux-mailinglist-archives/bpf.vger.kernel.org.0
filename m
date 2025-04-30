Return-Path: <bpf+bounces-57013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FBAA3FD2
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B56E3B6281
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563A2DC78B;
	Wed, 30 Apr 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBPIpnAu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D732DC786
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974227; cv=none; b=FJeiHb9sk/klcGw6Jy2HJkrGgy9kvMZdcjPASL9GBxbClvcZzfAPo+ITvgnhIvppNloiCa5RvdNTU4lHpFfG4e6FrWKBKbMMl/Sei1MQwNnqk73ouJgz75c16zKupSI4lMi9sPM1l945HuRD5C5qIglbYxjbfekbTjrIzlq1aXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974227; c=relaxed/simple;
	bh=Hczz8tFQqeMvwP46tuVNFw7wmHyU/EZIa/u6vgz0sJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHp6FCiJf0ysUozQj1K4l4MF2P69yf1jgaoGZ+sTB5i7O08oMXJB/UM3usU3L0e9LQbOHlDrtTrY1NcAMK65Cm8CXFHIoINSf6S5J2jhBnGrQ8+Ex1nenzEUXtNkw/w5+N5nNFco7RjLKaoYKySzfuRwi4P3d+g8eQW/i3weUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBPIpnAu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd36189bso9302684b3a.2
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974226; x=1746579026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8KfWtJknVUvMYzwAQZK7J5V2/CfVSOWymHPTFROZA=;
        b=MBPIpnAuMOJAwrQZeoByfw7Xiz7Ny40o6MqrFeArWsLprj/iuAa05u0yDGSmaoLqEa
         oTKI7PS1hFOHAuE2bDRaYmQfqONWfKHqKX+FhTiNEm42XfRmZR3ktHrgMHJp6RlwS1L2
         zjFZuZtvV1X5y3uCBuyaar6H9v9M7Pvbaa6kh4K95VZYCRWBi54RqAph+ASTCcYbdPPn
         XOLNx9LxoCnwcyFnY2mFMdOjAFceVDrncb3mnd2hY5qeuIT554WYDb4ZcUeNHI/rUJ2h
         MlpOB1FNCiQpSNe91UuSbEbHOxLpLwmogWV3zSgEs4WzDjY99n6fKJbImtikgUSy82EF
         W8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974226; x=1746579026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8KfWtJknVUvMYzwAQZK7J5V2/CfVSOWymHPTFROZA=;
        b=JDaXuqMDl39x+dgxCRAHcNbE+gAMk+JaFUMtNjc7S07p12abMuuxFxeHRUv7Hh4Wi/
         XFXFkrL8MRXm9coDQD+k+ZdtOvpLacrwT6j9JM2QmAfsG+qEzzYi8Zw8pkefB7IA52sS
         NbjO9i8Svs4Iqc0gjyhOw3XnBSrxvY9wB/i0F+w0jUG9vhrIhSU23h2uLF8hhob99hUc
         06Zr5w/1s2yiDfsq+5vLOlhosNgrgjeghs5ppB9vO0mYgwnrIAbNtIwTErRSmYrp3xvV
         A/BJgcgAaN8OB6O8m1RidjOoaeArqSqQkdzKV5YQz7+dkfzAxx/YRQfYiX1r+xWWNdhZ
         SZHA==
X-Gm-Message-State: AOJu0YwE152CZQXylBcaD3GW/wmwkLh11voD5SCX6y5+y+Y4rsHwkHJn
	L7LZj1MhIiVCNCYkyghjO0q3aULbHFP8iIPAnq7EHIpwCGas95eo/Tfd4ijeeUoZxGRFgQXh4vl
	UENpNSk6twCL6vTt2vfFnQ0S/XM9KwrLi6orgKx9GB6NQ7kZTa0TsAnoL1ONYp2EjT5OOEqJD0q
	LvLV1tdi5UnyTFP888u6LD0RF2R7MTfjEjKNm1K30=
X-Google-Smtp-Source: AGHT+IGXjMAQ6Z4HpUzZGw+SfPLRp4intDdhQh/m2Ddl0uunRXtaCeDsdf0ekIVVtBs7GrtIhrk10UjAwgEmPg==
X-Received: from pfua19.prod.google.com ([2002:a05:6a00:11d3:b0:730:8e17:ed13])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:928e:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-7403a831702mr887054b3a.21.1745974225616;
 Tue, 29 Apr 2025 17:50:25 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:50:00 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <2c1ec0e60974f8438730dc5126f9ed986b32a3f6.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 1/8] bpf/verifier: Handle BPF_LOAD_ACQ instructions
 in insn_def_regno()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting BPF load-acquire and store-release
instructions for architectures where bpf_jit_needs_zext() returns true
(e.g. riscv64), make insn_def_regno() handle load-acquires properly.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..6435ea23fee4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3649,13 +3649,16 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	case BPF_ST:
 		return -1;
 	case BPF_STX:
-		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
-		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
-		    (insn->imm & BPF_FETCH)) {
+		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
+		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
 			if (insn->imm == BPF_CMPXCHG)
 				return BPF_REG_0;
-			else
+			else if (insn->imm == BPF_LOAD_ACQ)
+				return insn->dst_reg;
+			else if (insn->imm & BPF_FETCH)
 				return insn->src_reg;
+			else
+				return -1;
 		} else {
 			return -1;
 		}
-- 
2.49.0.901.g37484f566f-goog


