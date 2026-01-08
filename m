Return-Path: <bpf+bounces-78213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61887D02167
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 11:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC7F30B06F3
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4E431B35;
	Thu,  8 Jan 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S31CHabP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8042C3F6
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864031; cv=none; b=frmIW/INKPUDPQHhLhf12EZwR41o9TRWlGPAJ/wPN70lzq0WkRZCFdcuK3gd35mgN0H/OHhZnU/uDk2I17Lp8n2SlqFY5JoOsEfiWdBnIjju90IuCPi4P5J1CugyR3/vAeFCei9ivs63iPzD2K0Ixg0WUhAwzAsJ7ZDh59nymiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864031; c=relaxed/simple;
	bh=FbosATJlJMrrAZDjJg3pfl9wL+jyPVTQR6KUMBPIvpk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boRfmgblKvVHj0KQLhD24sOelk13vcsK04UowwZrUtgHJ60ongSrG107oTweBrSZw90JJvj0xFFxK/mnZf5ExY8KvX22mJcEZT/LMqULoXhWQF82IZQnsRt1DKqf78Y/Tf+s8MgVlGa8P6WtZjEeMaRqr59nNKXidXGcb2dVsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S31CHabP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-431048c4068so997736f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864019; x=1768468819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibNZDSomea2Kq8JU1LII4jRZLAkzC6KvW4qElfknzVM=;
        b=S31CHabPHS7Y2m2keYKSv0z0Xp8gQjTNMEl9Rm85dEtWKWHQXgaSssoHKMSL/wzBmE
         H/FunC3+MGwPPMv4XfkPcJX9+Xxv+UMg0osNF5gxlKpBmWMErgDKI8Ol2wHcoDHgb9qZ
         QhstiggVQWhkAvZbtClCEWO15HdNncihsWjwZYC50ArOwB4vuXFHKWLRw6+SMJYdLv27
         I1Hr2uobcr0R3KHGW7SoiZfwEu3ym279PYal4FGZ1Aitn1p4ekg89VelFuXZ4SEzzySJ
         nrvBrzjDrqhLeMoigBslwON0hdTzPNIWF6bsJjLvoLv8+AAtd4XKxxdHE/EdqVgfdRX7
         kMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864019; x=1768468819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibNZDSomea2Kq8JU1LII4jRZLAkzC6KvW4qElfknzVM=;
        b=FK8g54FklXJSjFZUJrlHoipz5+Tv+zcVtITWudiE4g+efot6gIcTK0Rmrvb/JevipV
         RujxQo3UNMfQZ3aoqceby7x+o+C+fj2RLzTM9lb+ZIsB+sWx1psgzw4k3Q0x/4pgcHcG
         eFDxolQaKFOcnoN8yPm5uSvSZznLwSu+aMb6Q84TJjHOJCVUgakg3d3iWTcdIed2Zv6F
         eGW3wyIgQuJEkUT+Yw0KhElVf+D+5q9vJSwRkD8C54yXutEa8q24m8W7mP/rKnSIGjxQ
         Z0hkGDbhRVhBpQ8xiHUqO5rxvnmsn9pGDbiSmV8EEioM3RhFe1IDS+SefqleQpY9ZQeU
         Sg+A==
X-Forwarded-Encrypted: i=1; AJvYcCUc4gP7UCOp+Oowr0NQ1TTHnn+sZ9CF3AF47n6D+OM7f8wbV6lbZQvXgC5zL63T3+5wGF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIGUwCAGxJk7l7As7L6VZe4uh0mZ9UWBcN0cHJnIlZMRw2B3Z
	9dm/3noGHh89opGiqRuNYgRFR/6u9bVduCYXKflOfwtVhm/VABCIbvot
X-Gm-Gg: AY/fxX59oVyf2b2aTTYmX4IjqB+3WLJYsT/DsDL4mYvyZ0PIqryh2uUT0fdC+t1Jjd1
	mMB8YhCFXRrCgL2WVNfDEc7f8gMVLNpFkaLQgcXh41QhEshCIiKj/s9RWe8L1glBAvGJrMYMpca
	aIgQ8rtA1wQLvnAuDzNO3VzADSTSRDfwfiWXPc//1kHNuV5LfLxE7MgYIxvkE/mVpAYfn7Muuzf
	8+w3rvzO9+MCHQJ6nlT3Onko51cMAdY8oDlIN8PAaPWTEKJBYp5axXzAZjaSyqYeNElIIPAixh9
	67/3Evf9WebQz6VfLYaYNqpbw5DZ0EfkB2b9ZCc0uQxnqdK131aY7G51kIYKf4lkElvyLFMes1W
	LycsnuTkjAqcmtV6AgPe4iN+L+spmKl5/VQlertfWyhjt8yoEQylIZ8QXLo0gpYN7aqpuOaTvYT
	+HeF/745kVhQ==
X-Google-Smtp-Source: AGHT+IEeTGSbCnce2NYPoDErH8a4YSRN2uHCz3Hrwe8riLU2jJcFM/suSjmul2LgFsXBuT7yKXIMaQ==
X-Received: by 2002:a05:6000:430e:b0:432:b953:b02b with SMTP id ffacd0b85a97d-432bcfd3d7cmr12200245f8f.16.1767864018804;
        Thu, 08 Jan 2026 01:20:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm14982921f8f.10.2026.01.08.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:20:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Jan 2026 10:20:16 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV920FGl9-1A1jW7@krava>
References: <20260107093256.54616-1-jolsa@kernel.org>
 <aV5qpZwxgVRu2Q8w@willie-the-truck>
 <20260107110814.1dfc9ec0@gandalf.local.home>
 <aV6PZKx9g_hCz4ZW@willie-the-truck>
 <20260107121432.73fccf84@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107121432.73fccf84@gandalf.local.home>

On Wed, Jan 07, 2026 at 12:14:32PM -0500, Steven Rostedt wrote:
> On Wed, 7 Jan 2026 16:52:52 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> > index 15627ceea9bc..3ebd8cdac7c6 100644
> > --- a/include/linux/ftrace_regs.h
> > +++ b/include/linux/ftrace_regs.h
> > @@ -33,6 +33,15 @@ struct ftrace_regs;
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >         frame_pointer(&arch_ftrace_regs(fregs)->regs)
> >  
> > +#else
> > +
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> > +       ftrace_regs_set_return_value(fregs, regs_return_value(regs));
> > +}
> > +
> >  #endif /* HAVE_ARCH_FTRACE_REGS */
> >  
> >  /* This can be overridden by the architectures */
> 
> Hmm, maybe that would work. Of course you forgot to add the helper for the
> !HAVE_ARCH_FTRACE_REGS case ;-)

seems to work, will send new version with that

thanks,
jirka


---
diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bc..4b053eb4c9d5 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,18 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
 	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
+#else
+
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
+	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
+}
+
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
 /* This can be overridden by the architectures */
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

