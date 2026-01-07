Return-Path: <bpf+bounces-78068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E362DCFC95B
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 09:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10C863002853
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7427FB3E;
	Wed,  7 Jan 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZaa/Afk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7D2264AA
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774186; cv=none; b=Bl+wTXKeNjzg8SJoNweB8dTLOcwYUSFDCEO02Fofji1bcebY2ytGFMpW87r8NXbNBfqQJoyUlRlr7k7+9XIxv6wCr/RbR3/wqqMYISdHsj4mSxQYpiSLgj3Fh63EpiefOAhW4eqcy9QZ2MLoSxCMy3tJSW8fyiJODRzbXdBKXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774186; c=relaxed/simple;
	bh=6Y8LJF/IT28MILsR6fkqJKlCJIu/OktP8AH8ej/hsy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kddzdl3D32IV/C0vaJuLS90zxm6VNSsTFbmeQ7czlGyyVt6e6I7fEvgTPttWfQ63H6NMprU4afVCNKH1fODfO4+Z1HRUpqtjUCNz/629k4C6dwxaf4KWHlt9DecCCj/p68KNrN48h6QGPrDiLrsfu8C8KSvX/IPzQE7l4ljIacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZaa/Afk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fed090e5fso913758f8f.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767774183; x=1768378983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=df7REDb65mq75PTRlD31qjVxgAgGX1+69KUNZyHym1g=;
        b=IZaa/AfkwErFItrcuMmDMhHZ2sLBXvBtMbH9kbrADL5zbgaf0wfy6Jjw46dQ+w+siL
         B7G+A7B+skytcVLOP8ijb9Q4gWH53XtDi0j4OPezrMH878ulAxBMjoam8fH5BPEktHD+
         sZLKV/H+Gg8y/EHzx7DoqXHD2dmwAbyn3ZSL2qyYWOZWG49kOo+0QrkiM4LRHN7D/GSp
         yEIklJWIqCA+vqpZXWO8gZKRR7TgO9cMyZHQJCOX0Ct/p+ZnyqIRiWX0YpUv+HmCJl1H
         hAZ7FfnaujtjYvNy/z2piLqKjLKYqqPNIZaZuBcjV171hNWew242Lvw57oXTDXFnuyUW
         40Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774183; x=1768378983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df7REDb65mq75PTRlD31qjVxgAgGX1+69KUNZyHym1g=;
        b=tk3wdoWXdVIe7zRwypkAqQUvWW9m3H2t/3t9Dzkk6BPJK8+QCHrG/TBDRvbtZEra62
         OJprKDONIPYejN+vyQE9DGUhTqsgFaWOWAnz9o64JK8XP2kO46qhFrq8a93w3njDhLSj
         6zkbQT6n9t5MFvHe+u1Ux2ey4JzgvS7dM/oYEkCz6WtRgTOvKh+gcIhyiKt/6a9sRIXg
         +x/cQd2mgIXYzF8Qmy5ljYw55/OnpgzuGMtkCyk381XpGYpZQt610dm25HWbRAuzz4M4
         Ktd1kl3Z58zk4G+OCb8M2KzmIXTMu4SJuSYZ54p9EAKfnliwfTZYk3RtPBn9xcHDnyp9
         Ie9A==
X-Forwarded-Encrypted: i=1; AJvYcCUXiRXoP0onHD2cyf1b4biao46+SzbVzUrqh2h9E9Ejc7VRk7+lNMiOSwKj/zRi1/IwKYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlE5K4iCyPRdUg3YMunF98UbVLbYlo0MGR2uFwMLMAH4u3NIp
	QY4m/zko2sjK1b5qVGsqywFrVggVWccpMpJ7ZaErm7MpvLdgTYKQdhKS
X-Gm-Gg: AY/fxX6Eiiqebf2ihoPytWYztf+mPw6GUk3i5ApBlGmF7UevbFF3kA/QwSA9OsaMiae
	d2IN1bxUmmvKN1NSs6zxcnWNfLugEgkG+ZqrxcXIXP2EoYLCBoo0vU/iej6Ur1qBPC1AB6P6VTJ
	SoBsHj1Cfavm3Cr+Yv+pw1l5OOlOJTLOPpT86iO6aTd4mE2ppn+OJhh65AQZf6bjU7pDQdWHlq1
	oR+PaWYGfXFmoW/gwUvEgJD0DKU61Twkcq++RovJzfDSCKOVoj9nwgh/OnOEMRNeIbE+Qu2nYaa
	dznj7fXEsVt8de1kCxd5ccQ4zzk99rnU1c1iUhDoewQy39mVO/krHc/hwdAm4E2D6lQ4G8je9SO
	IuKASdOh2PhzHMjV+YKgr5veJ5lhdbpYk8C9+1iZRGYvawiyxjcT06yBCQrOLwpcHAZO93miWPt
	w=
X-Google-Smtp-Source: AGHT+IEsMNPHr9nzJaTOIYJD2qWD9ZSw80mTVgJ/kjHVyTIrFlwwtX/5Na2psG+/SMS1rx4kKZSw8Q==
X-Received: by 2002:a05:6000:290b:b0:432:8651:4071 with SMTP id ffacd0b85a97d-432c3632942mr1904226f8f.18.1767774183031;
        Wed, 07 Jan 2026 00:23:03 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm8920997f8f.43.2026.01.07.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:23:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Jan 2026 09:23:01 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV4X5Yx07LomQji4@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
 <aVfbqYsWdGXu4lh8@willie-the-truck>
 <20260104223415.0a31f423c861c0b651de966b@kernel.org>
 <20260105162220.6ba5129a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105162220.6ba5129a@gandalf.local.home>

On Mon, Jan 05, 2026 at 04:22:20PM -0500, Steven Rostedt wrote:
> On Sun, 4 Jan 2026 22:34:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > This looks a bit grotty to me and presumably other architectures would
> > > need similar treatement. Wouldn't it be cleaner to reuse the existing
> > > API instead? For example, by calling ftrace_regs_set_instruction_pointer()
> > > and ftrace_regs_set_return_value() to update the relevant registers from
> > > the core code?  
> > 
> > I agreed with using the generic APIs. Also, ftrace_partial_regs_fix() is
> > not self-explained. Maybe ftrace_regs_set_by_regs()?
> 
> Or perhaps: ftrace_partial_regs_update() where you call it if you need to
> update the regs.
> 
> /*
>  * ftrace_partial_regs_update - update the original ftrace_regs from regs
>  * @fregs: The ftrace_regs to update from @regs
>  * @regs: The partial regs from ftrace_partial_regs() that was updated
>  *
>  * Some architectures have the partial regs living in the ftrace_regs
>  * structure, whereas other architectures need to make a different copy
>  * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
>  * if the code using @regs updates a field (like the instruction pointer or
>  * stack pointer) it may need to propagate that change to the original @fregs
>  * it retrieved the partial @regs from. Use this function to guarantee that
>  * update happens.
>  */
> static __always_inline void
> ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) {
> 	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> 
> 	if (afregs->pc != regs->pc) {
> 		afregs->pc = regs->pc;
> 		afregs->regs[0] = regs->regs[0];
> 	}
> }
> 
> -- Steve

lgtm, the full change is below, I'll send new version of the patchset

thanks,
jirka


---
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1621c84f44b3..177c7bbf3b84 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+/*
+ * ftrace_partial_regs_update - update the original ftrace_regs from regs
+ * @fregs: The ftrace_regs to update from @regs
+ * @regs: The partial regs from ftrace_partial_regs() that was updated
+ *
+ * Some architectures have the partial regs living in the ftrace_regs
+ * structure, whereas other architectures need to make a different copy
+ * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
+ * if the code using @regs updates a field (like the instruction pointer or
+ * stack pointer) it may need to propagate that change to the original @fregs
+ * it retrieved the partial @regs from. Use this function to guarantee that
+ * update happens.
+ */
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
+
+	if (afregs->pc != regs->pc) {
+		afregs->pc = regs->pc;
+		afregs->regs[0] = regs->regs[0];
+	}
+}
+
 #define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
 		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
 		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 770f0dc993cc..ae22559b4099 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -213,6 +213,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..3a17f79b20c2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
-- 
2.52.0


