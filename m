Return-Path: <bpf+bounces-31511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFAA8FF2CA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A0F285801
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E08198A1D;
	Thu,  6 Jun 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3gnpkh8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC51E87F;
	Thu,  6 Jun 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692393; cv=none; b=epTzFHaEIDe2Sdd2VTHDJKpf5xXaQpZzzAUTbljlElVHNLDw6X87Evpx5ci2XfDL4lnVH1RktC45Y3BWo6Ng5KvjZPyqObBH1N09Y/RcMICfGxu6+CejwwIMeeIEyQCi81/udEFBaqEHaIqVTuXvg+khJ+lEcCWxlVzQ6w1saig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692393; c=relaxed/simple;
	bh=YbCpow6g62s4Y/IsFXF+iWJNO0YFFPiz7b2876a3LhA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPqMRxC45nP3zvjetClq6VRwfdtbKrFt3DOYIgmOz5+XWzIpy7H6z9EEWpuXj0uamYsGgb8b1QyeGC88qzOFI7oSEXhb0lcycMRzqJx4QWnDQSQU1ZC5MmO6FlmJxeWfUDvfXwNovl4KPrl+Sv3Du4jRY305eCH4utEFMytDx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3gnpkh8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so7169515e9.1;
        Thu, 06 Jun 2024 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692390; x=1718297190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+sr+zYDiUtTeri95usC9+OHaSQ8DEfZldxCyLfldlE=;
        b=l3gnpkh8pivsu9hxmWWMOQpcNfgvO/ojU6CgyVg+XTyUEqQWV5qxPtYps7ZPC84BAU
         Z0SvImA/jJioIjjuPmSFTY40uy7RsvqRLambEGUdtwpHFg6/IY3T70CgXS032EeGrSgs
         bxti6LDq2RWOcF0obFK9i/L1Qo/fycf41CNwjse86B4/giv7sJccCTTFLZjYKDdo5Lj7
         Ic3+5mtOePqtamUuczFkFKHKKLPerQu6mpruX1yhYBI47vqU7YKzC+pW0+PlOJ1v1sPG
         JVjcuYzrOUWCg9O1X5ZlNdZ/qfDlCVPpNn98rlsWWivCoWJZeKf+vJhigLKhFuykiNR+
         Y2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692390; x=1718297190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+sr+zYDiUtTeri95usC9+OHaSQ8DEfZldxCyLfldlE=;
        b=K6o/ClsOHWjV2smCaA8Mxc3yll5CJrkqOvyIEm+I3kbzOU3DV/6VKbCh4MXtshTjCN
         b2SazABnf4XbMl8FZMZS3mxVpYrywRUSmipT/28m4p2vrhHH41cryjepvQHOafosKJcY
         SwChUGQX2X+046ZoEH5UjKokr09oI7B5HtaZrIg1M91z2OLm7gK9qkpj4/cCbC2WLGlr
         o6z9JA8XrknA6+VMjysukAOWigcWRRN6dNqLOaq9CfYGu2ECP68rHTdakVK5ET4WZZiq
         y9zIxuNI2A7xnIQkuEBDMGkIyzNzt6hoYduNDrego8rBNofzws3xcDKaYZxk/Btdzecs
         h01g==
X-Forwarded-Encrypted: i=1; AJvYcCXDAkdSBAGimfP2oKL5DuLCyICrc7vLQW5KjIYvw8teW6aua2Q0uHM2GrTpfWrLbvMz+xFVCGU97xeJVJhOvX2RVbL6g1rJZLvi1PX2k9jVtcrKpxuoOEhEEAua5dAGWn0KU0OlX2P2hKvg1lG0PbdA1UtbTAld9D1s26AxGgQbjGO/NLoF
X-Gm-Message-State: AOJu0Yw9ltCh65hT7HCruJpM9faw7UkKbv/IQ+7IXWB13/9qGO5QhD1R
	TBeyp6LkwieAkUavNVWzQ8RDlEywpJz6qApQ/fYwZ0J0ROSTNJFw
X-Google-Smtp-Source: AGHT+IH26w+K+rCueYkQ75KLKyYrpzWeYSPuvSZSCvTtwn2ih1yFE/aHnp8z6WQnOYEM6J5EWvVolg==
X-Received: by 2002:a05:600c:3b84:b0:421:28e6:9934 with SMTP id 5b1f17b1804b1-4215ad1f8a4mr31762835e9.15.1717692390122;
        Thu, 06 Jun 2024 09:46:30 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d49esm59509825e9.27.2024.06.06.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:46:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Jun 2024 18:46:27 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <ZmHn43Af4Kwlxoyc@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <ZmDPQH2uiPYTA_df@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDPQH2uiPYTA_df@krava>

On Wed, Jun 05, 2024 at 10:50:11PM +0200, Jiri Olsa wrote:
> On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
> > On 06/05, Andrii Nakryiko wrote:
> > >
> > > so any such
> > > limitations will cause problems, issue reports, investigation, etc.
> > 
> > Agreed...
> > 
> > > As one possible solution, what if we do
> > >
> > > struct return_instance {
> > >     ...
> > >     u64 session_cookies[];
> > > };
> > >
> > > and allocate sizeof(struct return_instance) + 8 *
> > > <num-of-session-consumers> and then at runtime pass
> > > &session_cookies[i] as data pointer to session-aware callbacks?
> > 
> > I too thought about this, but I guess it is not that simple.
> > 
> > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > What if uprobe_unregister(C1) comes before the probed function
> > returns?
> > 
> > We need something like map_cookie_to_consumer().
> 
> I guess we could have hash table in return_instance that gets 'consumer -> cookie' ?

ok, hash table is probably too big for this.. I guess some solution that
would iterate consumers and cookies made sure it matches would be fine

jirka

> 
> return instance is freed after the consumers' return handlers are executed,
> so there's no leak if some consumer gets unregistered before that
> 
> > 
> > > > +       /* The handler_session callback return value controls execution of
> > > > +        * the return uprobe and ret_handler_session callback.
> > > > +        *  0 on success
> > > > +        *  1 on failure, DO NOT install/execute the return uprobe
> > > > +        *    console warning for anything else
> > > > +        */
> > > > +       int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
> > > > +                              unsigned long *data);
> > > > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
> > > > +                                  struct pt_regs *regs, unsigned long *data);
> > > > +
> > >
> > > We should try to avoid an alternative set of callbacks, IMO. Let's
> > > extend existing ones with `unsigned long *data`,
> > 
> > Oh yes, agreed.
> > 
> > And the comment about the return value looks confusing too. I mean, the
> > logic doesn't differ from the ret-code from ->handler().
> > 
> > "DO NOT install/execute the return uprobe" is not true if another
> > non-session-consumer returns 0.
> 
> well they are meant to be exclusive, so there'd be no other non-session-consumer
> 
> jirka

