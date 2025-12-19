Return-Path: <bpf+bounces-77139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733BCCF20A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C84330138D5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10972E7BA3;
	Fri, 19 Dec 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+WcGS3v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE813D539
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136457; cv=none; b=Nr6JRHt8W6mj9UVbnMm7S70NLOIIsSDZLpljTURdml/B5cu5uSsQvnFsmEdMUq4lw+WKuMIGv5WTYBFDCMU8ccB5LEDMxcHJ+LMVbz1AvS6gt4+QpQiZw3CtS4l4QjkZmhsTU4nBiuJq1tEoPVfetBk4O0C3ssiNKW6oc+uH+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136457; c=relaxed/simple;
	bh=ncH0WX29PmKWXHkMb9W7MxVSClntPHuEcroF5q70h10=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrjcXC5c6WB1cXB1iaQmKiJn5Xea5NVA/WaauzGXgaQelUv20HMbeAaFx0toZ6PpOeQ43ewoagP+EB+FmYX2HviRwqFoUwK28XGWjywuWMH6qG1qCqKPsrqHodeUaxJYdebArTa1oPhRNyWfLlD+4KpTI8u3w0x3lzdLGFrcXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+WcGS3v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so878185f8f.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136454; x=1766741254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW6xT6zKa/DbjWLXugE2SCCRWvLGUmWxnxjoprlKdVA=;
        b=H+WcGS3v77jbJnwUDd+ufnwpnCE2+JOwndJc72wRCz1TiTv7SbKQ+L0AL+9b2MdR0b
         yLitPq/QpQ/mA0uuB3ZVM2uhcCuEM+kVTU+ztcyLKj8FXsl+ZNysvtG0tZbv4ewOzlBL
         5MO2hjatAJxRjfsSTTC488uTiSBYw/NnDCJ1YFnrnfG4pRuYi/BpDxW6ddZRwU7e+LsC
         p2laa4toWEalNK0JQAatQrDrwd6PTIjnb8Zf+kJgQiJlelYu4zFXZAts1mpT0KGTjFPU
         na8j7lbGWRBbkQcsWnHKpj7lx4xsfUfnzKPNxaBBekIoDZCesM4lfmXNul6KBlsBIsVM
         iI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136454; x=1766741254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW6xT6zKa/DbjWLXugE2SCCRWvLGUmWxnxjoprlKdVA=;
        b=mP/X2og0gwLrH8h6zohiHv15tCAk9nk5hALIZL0fFTU3M7dZ1bgbu6CsGi+B3Jx5/k
         VMu/61L21whsR0fdomXTOve/ehLo9QIhmUqrSDhihhvOhz9y0WuqdbRjF+jDcCLHvvfs
         0y0D/AH5wv5FSr+5aKTKHYaf7iKLLicilEjCbZEh9xS1zkAfJdlmM1g8wgjHsWkG/d9T
         ZQoSTjvvLYk+yz5g+jJdc7Ul5MTocmS9Srz1TrgjA2I/EB/yNwpbqCz3cSdpgBe8tHCx
         1YofkGAWT7jB2nMFjLjNqVW4tz/6gB/UfERWXMTF/T1gxIAUBuU9ok4lfocNCsoL2mBb
         g9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFX3rggP2cdOzyfNBFW8FLQivFKL7Pvz/CJ1Ci4yFJHk4BxfASOCv/YMGnDmtm6IvoHGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lSV3+1dVR0N34zg2kMFezg4O3QFQfTPsLehAJ/0HL3SbK2CL
	pa/6FeZaPDysBLQRXeerUKururHRehDfSzMLPUX58qoWQiW/+/7Ztbm9
X-Gm-Gg: AY/fxX5SPNng8C326ahFmPsMM0EWUuFSzjq3DfvlAr+q7hfjZi3glSAjcgnssNvaQ/+
	sNkjToEOtnOrj6Dc0wdq4yAsM5jjlwzv3l4r5hSL5K9xGbxAd2whSQglhAPw172rlER+Y88UhkI
	06N3mPHMrelA8RlwakvrgmLtumplusbDQx4CnGTpmzQpjyHY7bL1NgKZsHE72ArUTmx6zxkGSpB
	AEOE8WjdqKC22j8Sjg4661ZYji0UqH3VNn36w339r8UsJEdxlaWEwdYKWGwEh/iTTo7Wd/8IUhS
	pBlpHvQEF5qB3FLnNsyc/y2bX3U9iB1N8d3m6GLWPVsIQiqud2oJKJuK2vSGfZYYxqIjhZHNL+t
	YsDcv6obN2bOeXbi85Qf2PM540WrL52fhFcLlTtWBofE94ikwkuKay7zBfegm
X-Google-Smtp-Source: AGHT+IGZerDxPd0b4gdsyGcPyDLXRMjKat7AKujtmwuJrtu/onCDnzbnfiuN8UDjCgD2FYBSHSQDtg==
X-Received: by 2002:a05:6000:24c9:b0:430:fc0f:8fb3 with SMTP id ffacd0b85a97d-4324e506148mr2457124f8f.38.1766136453761;
        Fri, 19 Dec 2025 01:27:33 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08d9sm4154643f8f.30.2025.12.19.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:31 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 3/9] ftrace: Export some of hash related
 functions
Message-ID: <aUUag8LVUy2CTNpS@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-4-jolsa@kernel.org>
 <20251217200712.606a9a7a@robin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217200712.606a9a7a@robin>

On Wed, Dec 17, 2025 at 08:07:12PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:56 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > index 505b7d3f5641..c0a72fcae1f6 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -82,6 +82,7 @@ static inline void early_trace_init(void) { }
> >  
> >  struct module;
> >  struct ftrace_hash;
> > +struct ftrace_func_entry;
> >  
> >  #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
> >  	defined(CONFIG_DYNAMIC_FTRACE)
> > @@ -405,6 +406,14 @@ enum ftrace_ops_cmd {
> >  typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +
> > +#define FTRACE_HASH_DEFAULT_BITS 10
> > +
> > +struct ftrace_hash *alloc_ftrace_hash(int size_bits);
> > +void free_ftrace_hash(struct ftrace_hash *hash);
> > +struct ftrace_func_entry *add_hash_entry_direct(struct ftrace_hash *hash,
> 
> As this is no longer static and is exported to other users within the
> kernel, it should be renamed to: add_ftrace_hash_entry_direct()
> to keep the namespace unique.

ok, will change

jirka

> 
> -- Steve
> 
> > +						unsigned long ip, unsigned long direct);
> > +
> >  /* The hash used to know what functions callbacks trace */
> >  struct ftrace_ops_hash {
> >  	struct ftrace_hash __rcu	*notrace_hash;

