Return-Path: <bpf+bounces-67337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3799CB42A26
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EA5484BA4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6E3629A9;
	Wed,  3 Sep 2025 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOTQ40Qc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3229D0E;
	Wed,  3 Sep 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929040; cv=none; b=kVFwaL6/60VicEGMNEQgH/pQ8oiSKmj2hPMou70fLSIhkbJmAfr8LVTmAaLTeBfK6sf0KmBak3QFy2mDPRp2VGYo4LmWfPublvR1ah5hYtm1r79nnfEjx5Jj1dZP4KXIUyTzr14KdEJx08xPlaAF+5P+V4Tpqa28k6dn9ZhjEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929040; c=relaxed/simple;
	bh=O31dmHfc7geJEvris/Ly7Pd4Q81L3VNPulUMDdTSH1Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGbrUZlzcE99k6WdNpGWxP8jfL2zPOhdVS6oHCSEXLKG8LHXPJTSqA+L61Il5I5yEckTPIBZhqybF/yl2e8HVWSinKkCITqhTe+/cIxHUYJiqFppWfFGzQfgdYApqIh+m2+zs8JTAyi0+eyAosWKtH7vg4ysM6XxtA0jXqrKiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOTQ40Qc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ace3baso48784366b.3;
        Wed, 03 Sep 2025 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756929037; x=1757533837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaHs0FewPkWbV/t+y5r/zPWx8uRFCtdWPBg+J8FlR2Q=;
        b=JOTQ40Qci24pfTJaKOYk9HSt7tbEHcyj9yKWfIPi8jjdIOZlKaB3lwPZoP9zprd+zs
         8G8c2p/12l2RX1pt00oIMovUqQfvlH0A07kYGTDVtcgAfJD+3r1Ml+smBpeeF+VK21jK
         qHSoHJFSfbo9wAlYQTC9tf4GEts/wDAB0Ya0DjFhVtL86YCqNdc7QRe7higxgCjN5Xue
         ZcAWj+m/288HqCncvx72mGoooyK12gVxzmmyY2vJ+TZvFFwLRqltoEXymNmH0ZUSEVXn
         6jBC2FuJT0g1ctNlFNF4fGmoy5Gz9/Ah6dZa/nvPRcJu3uBqD1Y1Oky3bvCZtqH9VeNj
         6VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929037; x=1757533837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaHs0FewPkWbV/t+y5r/zPWx8uRFCtdWPBg+J8FlR2Q=;
        b=a3vYMhsdohjIG6GlDgJLMT5dmBfaP22f44wNMwfNJNfwZ05QBCwDQfQ5JJVflHoYn+
         TpluBiExf4p+hvuirSk6F/kdXfwN/MRkNOPZjwmNp5PRMyUZIOej2m8DgZsjtGDu7xBH
         ARdzyEb6iUa7jnKDxV7VhQix8h4owl065hFM8GCrPahwMJC2CuTOvS8jcjtOEaP3DoLV
         adLLxQSv8bGfvLeooF4wvUiMcWbrqIj+l+UEYffIMVFxpFl35HjZNXWTZ/XR1S0/w750
         1VVDDXNb4L+Ar/ZNHa9kNIxsyzU9Mo7CFDzhYJzpnhSvqP91KHiXexME4GhEiTsR8xtV
         WX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD/XWkOXIel/1ZYIJZBaJ8sx1gestzsHqpPa898rHk4hirxdwJ6pzzWzTfmnJPUTY95Ro=@vger.kernel.org, AJvYcCVXfcoxg8pA/PYocr6iRTxdv1r2ecVtPncvhGpRgZrmpC2HZq+4Uf1FJimwU5Mzj2BkR9l+WSUwEC2Pc4xs@vger.kernel.org, AJvYcCVz9OWEK4MgjJdIHm8mEAHKu53zF+2p9b0Pi71wcmaKsCCbVvjrkTq5WUPIF+0LG8N4mAPNarCQXOuFjhwKtTzH6Gof@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg51mcNnZ7WxFL7jmkS91EtgywD0gqO131DYgJ76surwfexjBm
	zjLc/qf8YI6cz+gtg5bU9BRBGUWmWzi5VDH7PizZPoycQ9QkWgKDr5/x
X-Gm-Gg: ASbGncv45fpPW0ennfzfW/BVapShxqRCgJAZoMvr5/4ejGGQo3bUtjchwapYcvU+Ouy
	jMpxPQpQyzhWyKn2++u4G+uqIavNIxdwLXpoDXEdpbwm/S9nOLsqs/QDHRfV4pPr+jcUkAG2Owa
	QCYDTv1pRVvClMYepA+UjopaD6on9XuMDrG/si/JbxSBNX0tEXd2SPySss2TrKm9CvCHo+q5RkW
	OluX/BsPClLib9j+Mik4z5BAZypWCNd8L9LXyLysARjKdJOLgWIwcGZOHs1c/eZTL343Fa8BYNN
	6bBsrkVGKEvZpd9uY57C98s2I+IAfEg+pwomnHnDgyY7iqaW09MRJuQdxbEnjqxa0LLw03/lfR5
	1rv9iwT90aS8Um18K6ks+Zg==
X-Google-Smtp-Source: AGHT+IEpTXDdePmttzZ1ZD9TKhMMmlY+ohWG5ikWx1wikh4ei37m8jY7o2zvUugdxjRsAewRga9gMQ==
X-Received: by 2002:a17:907:94ce:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-b01f20bc52cmr1867397666b.57.1756929036735;
        Wed, 03 Sep 2025 12:50:36 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77d0sm12729765a12.11.2025.09.03.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:50:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 21:50:34 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <aLicCjuqchpm1h5I@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903112648.GC18799@redhat.com>

On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> On 09/02, Jiri Olsa wrote:
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
> 
> Exactly.
> 
> So why do we need all these "is_unique" complications? Only a single
> is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
> can just do
> 
> 	handler_chain(uprobe, regs);
> 	if (instruction_pointer(regs) != bp_vaddr)
> 		goto out;

hum, that's what I did in rfc [1] but I thought you did not like that [2]

[1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com/

I guess I misunderstood your reply [2], I'd be happy to drop the
unique/exclusive flag

jirka

> 
> 
> > Allowing this
> > behaviour only for uprobe with unique consumer attached.
> 
> But if a non-exclusive consumer changes regs->ip, we have a problem
> anyway, right?
> 
> We can probably add something like
> 
> 		rc = uc->handler(uc, regs, &cookie);
> 	+	WARN_ON(!uc->is_unique && instruction_pointer(regs) != bp_vaddr);
> 
> into handler_chain(), although I don't think this is needed.
> 
> Oleg.
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index b9b088f7333a..da8291941c6b 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2568,7 +2568,7 @@ static bool ignore_ret_handler(int rc)
> >  	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
> >  }
> >  
> > -static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > +static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool *is_unique)
> >  {
> >  	struct uprobe_consumer *uc;
> >  	bool has_consumers = false, remove = true;
> > @@ -2582,6 +2582,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  		__u64 cookie = 0;
> >  		int rc = 0;
> >  
> > +		if (is_unique)
> > +			*is_unique |= uc->is_unique;
> > +
> >  		if (uc->handler) {
> >  			rc = uc->handler(uc, regs, &cookie);
> >  			WARN(rc < 0 || rc > 2,
> > @@ -2735,6 +2738,7 @@ static void handle_swbp(struct pt_regs *regs)
> >  {
> >  	struct uprobe *uprobe;
> >  	unsigned long bp_vaddr;
> > +	bool is_unique = false;
> >  	int is_swbp;
> >  
> >  	bp_vaddr = uprobe_get_swbp_addr(regs);
> > @@ -2789,7 +2793,10 @@ static void handle_swbp(struct pt_regs *regs)
> >  	if (arch_uprobe_ignore(&uprobe->arch, regs))
> >  		goto out;
> >  
> > -	handler_chain(uprobe, regs);
> > +	handler_chain(uprobe, regs, &is_unique);
> > +
> > +	if (is_unique && instruction_pointer(regs) != bp_vaddr)
> > +		goto out;
> >  
> >  	/* Try to optimize after first hit. */
> >  	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> > @@ -2819,7 +2826,7 @@ void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
> >  		return;
> >  	if (arch_uprobe_ignore(&uprobe->arch, regs))
> >  		return;
> > -	handler_chain(uprobe, regs);
> > +	handler_chain(uprobe, regs, NULL);
> >  }
> >  
> >  /*
> > -- 
> > 2.51.0
> > 
> 

