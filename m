Return-Path: <bpf+bounces-67254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FEB41583
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 08:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585B63A792A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997722D97B7;
	Wed,  3 Sep 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mii0Lrdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED52D8DD3;
	Wed,  3 Sep 2025 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882133; cv=none; b=LlWUy3eAgXkR8bL5UIjPrqVqTD4fS0UOurgG+keMNeHZ5ZvUPvItI59b+wdjSYdiVILDJutFmJ1frCg8gA0LmWCXcBv699CJRjkJgUsjoEjHbACpfGHHUx4EVFjajSlNUprOcc7CFX4BM91WRLTeYx5X/TMhQEZ2GQDQXqRqTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882133; c=relaxed/simple;
	bh=qjmB1RAA7F0wVqM7zHKXMSrfTZRfahNUiS26O3cUvT8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crmQeBb42bQyHs7v2kVAB1lsd8YgB2Dcl+p8YB7ESTfswmBLikqG3a5/tclRFNKYuUIjqfVkIdMq8798IehMObYElOF9l3UmX1aU0sxeyLeIoJvGwjpzl9VE4HVD9gbOlUU8E+Mdw1ChTrpaZx4I0Kc32woNiX07jnndPSY2GOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mii0Lrdn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0428b537e5so495770366b.3;
        Tue, 02 Sep 2025 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756882130; x=1757486930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtIpceXnZjTA0NBZG6Ie6QAq4Kp296Wp3sK1PNsV79w=;
        b=Mii0LrdnafKb/oR90tMideGmfM7fo7biNUIqMT+T7BNzQ0+PD81W3AAUFk4gHhztui
         5y26v6URdaBWwti0PboYWuqz+5Y/FyYyPRHDI0+/BvP7nq/pJe2HX1/15plMLFFhvBdL
         XMg7eFvWeZpgmadqJLKKfhYGp6Xku4p2Lr3SQuS6WJXWGfRT0Nl1deit3NO3NhiRKDY+
         jbVf2PbomBcylAsR3Tc4c5X8QiKRCSrtNylk18cfP7mVZfNWOSIAG63hGLyYcMjUiyL2
         a3P53sWpL0s64TXi7yHCw639h47micFGz3v4zz8OinlwX+FGm639h2GZ06mXWV9WG3tq
         xVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882130; x=1757486930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtIpceXnZjTA0NBZG6Ie6QAq4Kp296Wp3sK1PNsV79w=;
        b=mEuVooSaZkBYRGGCd4vQMRkuu/GyQZKmwkP5hlFHLg5ouNNqYAj0e5Svm7AM0Wsjav
         WtFCalZ/BXkAtGToMuQ/fwPKffYOajuqi75BCVUscmDVFpGPKfy8VhvhzrU2775SAwL6
         QFfxGv4uskgmrQ1ga+ycR3iy1DqG5hihiaHlRMNQhX0uD1VdasVTTubeP7sUovIeHitq
         cJVA0RDGUr7oQsB/bMeSbH+/BhvdZh09P/iCUNz8BvaiDBz+16iZzbEpHlPfzxOFeWkM
         v7+Z52NRQ9dUr6kSbHXnxBEUOuX2P7sLB/hVwL68CGggnxn7eB2IUxElYQz/bhCb2quC
         lpMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJU88Bw8DQVKEopUqx1orb0XoH1cnf6ObpPh7zq1vh5/dBOm5yNoVHq7oYjQPT1zyB99Q=@vger.kernel.org, AJvYcCVnEsatd++BSV7mowcOLHib28vWTul6h9cYwjWin0JgfFcpk9y3DBrWXbo65VQEiX8pRJMu+/MR7WLiqmvbnhV1fngL@vger.kernel.org, AJvYcCWyk1gfd8UwFPcWhn3WkcmA8RARSOD1MKgsJ2DnodU1iN6UWG46YC1d+JCsV4IVQNi+RogzD+xokqQjbsOn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4jzOUEu3s1gaUU38rVnErXQOlXqFqrfylKeu8mNyuO7giDeG
	OH+FiCNMWl1s8uJHq8QFAC9KuVPPk+gmwPL8u+AgmKrFyfk/mzmxRlCX
X-Gm-Gg: ASbGncvpayB7uO1IwT6dYpyN4YQ3L6Q7FsublQ4KPN9INkPBBbJiHBiZVWwS+Q/qAYe
	2aCqBmNUtpjTGDAw73OX/Zs2S6ZWcc1+HtlcXsfDHjGpFwXK5T7LLzx8Fwvzt1Cn4fhoKzn5CZC
	7ic+Jk7ZYhvCgjsFFz+UtATqtTNEwgN811aa0hb1reaQhzZda7gV75CWu4+fM7G0Ot2ZVnwj9DR
	RSndhCrS9aJdGau1wr8J6RAszHXXUaiX5Rj3+AFR8md0yg+A4pJtbkW+bt8vnszs69sSY9mtrTj
	Hgt/wZEoGzWcFA8kP8SFHCZLLDpVGgfp0A8zRkNE+G2l8/QAFnvkxm4F/xvJA/CeLP2lyW/I4Q2
	+j3iSOLR9AuWlvmZ8s+8xMw==
X-Google-Smtp-Source: AGHT+IGVu836mQO+y8+vS80i0WjWO4Im+/HFsaRS2Q1h4C91RiD8hiCYlHBjxai2RlpQHTzTdhDbBQ==
X-Received: by 2002:a17:907:94d2:b0:ae0:d1f3:f7f4 with SMTP id a640c23a62f3a-b01d8a2fd89mr1355062166b.13.1756882129612;
        Tue, 02 Sep 2025 23:48:49 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04252103f2sm730511366b.50.2025.09.02.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:48:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 08:48:44 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aLfkzE_eMYE40QjD@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191515.GM3289052@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 09:15:15PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 20, 2025 at 01:21:20PM +0200, Jiri Olsa wrote:
> 
> > +static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
> > +{
> > +	struct __packed __arch_relative_insn {
> > +		u8 op;
> > +		s32 raddr;
> > +	} *call = (struct __arch_relative_insn *) insn;
> 
> Not something you need to clean up now I suppose, but we could do with
> unifying this thing. we have a bunch of instances around.

found two below, maybe we could use 'union text_poke_insn' instead like below?

jirka


---
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6079d15dab8c..7fd03897d776 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -109,14 +109,10 @@ const int kretprobe_blacklist_size = ARRAY_SIZE(kretprobe_blacklist);
 static nokprobe_inline void
 __synthesize_relative_insn(void *dest, void *from, void *to, u8 op)
 {
-	struct __arch_relative_insn {
-		u8 op;
-		s32 raddr;
-	} __packed *insn;
-
-	insn = (struct __arch_relative_insn *)dest;
-	insn->raddr = (s32)((long)(to) - ((long)(from) + 5));
-	insn->op = op;
+	union text_poke_insn *insn = dest;
+
+	insn->disp = (s32)((long)(to) - ((long)(from) + 5));
+	insn->opcode = op;
 }
 
 /* Insert a jump instruction at address 'from', which jumps to address 'to'.*/
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..bac14f3165c3 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1046,14 +1046,11 @@ static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst,
 
 static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
 {
-	struct __packed __arch_relative_insn {
-		u8 op;
-		s32 raddr;
-	} *call = (struct __arch_relative_insn *) insn;
+	union text_poke_insn *call = (union text_poke_insn *) insn;
 
 	if (!is_call_insn(insn))
 		return false;
-	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+	return __in_uprobe_trampoline(vaddr + 5 + call->disp);
 }
 
 static int is_optimized(struct mm_struct *mm, unsigned long vaddr)

