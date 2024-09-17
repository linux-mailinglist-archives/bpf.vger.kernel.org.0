Return-Path: <bpf+bounces-40043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF097B05F
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 14:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D6F28328D
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF0161311;
	Tue, 17 Sep 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6zsrvkL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5413E47B;
	Tue, 17 Sep 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577494; cv=none; b=bQ1ZHitSRIkmKvSpeV1dabfva2GoJPqs0WDLWiNrgFpNWuevOCBTG0p/wj15fUxzm2rFz4Ov7M1od1NZli3EffJXzJUQUx9C/QOFPVCJsEFPhQx6xGpxR+ASEzr5c/cZGPTt27c2QfiyY8Eu2haEpht+31r03L34HW7RtoxjY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577494; c=relaxed/simple;
	bh=zS/D1wq4UCMEE+38ZtAXafYF7IIcKz0YGu54fl21LG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyf5NwfL0hkKvVEnmGz8bypU5npSxP0OJ3wP5f8+XPAk7VoSmWxZtLdPl9MznUg5iIyQnczRow1OOwTsBdsQi43QxYAmxNraydswcwS2x/GEtH4hG4mj4ST5tx2K66D39266LOTLJD2aTgT6URNeCsdS6h8GRswdmv1NIitpQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6zsrvkL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so35992085e9.3;
        Tue, 17 Sep 2024 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726577491; x=1727182291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqXzNlf+uoSPRUa4ng6hfr1FL9Ao0p8UeM2cOowwwRE=;
        b=j6zsrvkLM0daBVGcEnyY/kCwkXTUf5Eq2MM+6wFqL6bbWsuswzR20b/SKS1Sn2l8Pv
         /CtngwhXTdBp8vdUxOclvIOoVZdMnQaeQsuqbxbzjaw15pv58sut8ca54OfvHHVH2QgE
         Jvi27N4V7cSMQGcnj4NY8KhLI2klkB1Ulw3b6PaefQxukRRde4VnPLSuC+K+cPLFAcoa
         Kl/ehteNQS9m+9GDCR3mC0aZXYLbd+wuP3TQU4b7JlptWzLKkr/qk7FKfI8rBVWos4FF
         Lrh2yBYP6xAzQL0S/wLkMvfo8OgOY9zbdwwmCxE2hWG4pG46+6U2s2lTm4frwyJG/2Pe
         VTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726577491; x=1727182291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqXzNlf+uoSPRUa4ng6hfr1FL9Ao0p8UeM2cOowwwRE=;
        b=dQ6asotpiGAehFpsiO6kmQXYHNdrWKwIsyCqz5TfQbJ92HMM5gbogrzsJDlTgCGtT2
         OSdPi5zIPjmlR8aIqjGU9cqaBtTRhLe0RHE+GIwSrnK8JGfbB6vcFUgnzIC4lojSYCGR
         rChhIwIxcCSyslUiWYwzPbtF1kpMNvd67OpuEvMCBt3qPKVibid3+yDpaymZlAWc16/2
         YTzXlw1VhZ79LH/8QsyJB3fWvwGnyauZb9sCQSe1Lk5IJqvdo7q6P7rDKnMsWztSf+73
         LKmQUn+3ZG7n6p/udG4MqKpBGomyJCX8CMolOMhJ7Xy8Iq946at+Rii1Y2YEYp/DKMQt
         OctA==
X-Forwarded-Encrypted: i=1; AJvYcCUVhsHyOyKceEG+odgSMtoCOh47ENr34l+h5ox+ToOYeEJaQa4yZTndazXPA80v3wFlfyM=@vger.kernel.org, AJvYcCWrFm8A6vb4U2x2OIBzuzMUpoX0BuBE9gg9MB0oPJefDdMbkvufm8nVNk9ol06n9+qhKMGM2OsAaE+78RdW@vger.kernel.org, AJvYcCXUKKhi3IluwF+aVADFyjk2IY2deyRVl6d20rdMyNF1Z7EtjVYI+yzZZ+ROWk8BGVR49EcuUclnJeaTHmDXqJcGJCdy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+U7x9TV25TgsoJxfyV+5PbCWEGDQJpQ/vJpHuQIDTfNpZV1Cf
	CZysO8+Fnp+/rAddu8/XI321A0pWOj1NZhvXCWrWMDq+ZWZeUI6T
X-Google-Smtp-Source: AGHT+IH+AsafrfuPxIbs88nEZp4gLlTEC3JF63M85W7cpkE9lUoC2mUjKaxYikYSPLXvYLTpdrM+tA==
X-Received: by 2002:a05:600c:468a:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-42d964e0f42mr106350065e9.29.1726577490501;
        Tue, 17 Sep 2024 05:51:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24215besm102322355e9.30.2024.09.17.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:51:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Sep 2024 14:51:28 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <Zul7UCsftY_ZX6wT@krava>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917120250.GA7752@redhat.com>

On Tue, Sep 17, 2024 at 02:03:17PM +0200, Oleg Nesterov wrote:
> I don't see anything wrong after a quick glance, but I don't
> really understand the UPROBE_HANDLER_IGNORE logic, see below.
> 
> On 09/17, Jiri Olsa wrote:
> >
> > + * UPROBE_HANDLER_IWANTMYCOOKIE
> > + * - Store cookie and pass it to ret_handler (if defined).
> 
> Cough ;) yes it was me who used this name in the previous discussion, but maybe
> 
> 	UPROBE_HANDLER_COOKIE
> 
> will look a bit better? Feel free to ignore.

ok, no fun it is..

> 
> >  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> ...
> > +		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE)
> > +			continue;
> > +
> > +		/*
> > +		 * If alloc_return_instance and push_consumer fail, the return probe
> > +		 * won't be prepared, but we'll finish to execute all entry handlers.
> > +		 *
> > +		 * We need to store handler's return value in case the return uprobe
> > +		 * gets installed and contains consumers that need to be ignored.
> > +		 */
> > +		if (!ri)
> > +			ri = alloc_return_instance();
> > +
> > +		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE || rc == UPROBE_HANDLER_IGNORE)
> > +			ri = push_consumer(ri, push_idx++, uc->id, cookie, rc);
> 
> So this code allocates ri (which implies prepare_uretprobe!) and calls push_consumer()
> even if rc == UPROBE_HANDLER_IGNORE.
> 
> Why? The comment in uprobes.h says:
> 
> 	UPROBE_HANDLER_IGNORE
> 	- Ignore ret_handler callback for this consumer
> 
> but the ret_handler callback won't be ignored?
> 
> To me this code should do:
> 
> 		if (!uc->ret_handler || UPROBE_HANDLER_REMOVE || UPROBE_HANDLER_IGNORE)
> 			continue;
> 
> 		if (!ri)
> 			ri = alloc_return_instance();
> 
> 		if (rc == UPROBE_HANDLER_IWANTMYCOOKIE)
> 			ri = push_consumer(...);
> 
> And,
> 
> >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> ...
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		ric = return_consumer_find(ri, &ric_idx, uc->id);
> > +		if (ric && ric->rc == UPROBE_HANDLER_IGNORE)
> > +			continue;
> >  		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs);
> > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> >  	}
> 
> the UPROBE_HANDLER_IGNORE check above and the new ric->rc member should die,
> 
> 		if (!uc->ret_handler)
> 			continue;
> 
> 		ric = return_consumer_find(...);
> 		uc->ret_handler(..., ric ? &ric->cookie : NULL);
> 
> as we have already discussed, the session ret_handler(data) can simply do
> 
> 		// my ->handler() wasn't called or it didn't return
> 		// UPROBE_HANDLER_IWANTMYCOOKIE
> 		if (!data)
> 			return;
> 
> at the start.
> 
> Could you explain why this can't work?

I'll try ;-) it's for the case when consumer does not use UPROBE_HANDLER_IWANTMYCOOKIE

let's have 2 consumers on single uprobe, consumer-A returning UPROBE_HANDLER_IGNORE
and the consumer-B returning zero, so we want the return uprobe installed, but we
want just consumer-B to be executed

  - so uprobe gets installed and handle_uretprobe_chain goes over all consumers
    calling ret_handler callback

  - but we don't know consumer-A needs to be ignored, and it does not
    expect cookie so we have no way to find out it needs to be ignored

the change solves this by storing also return value for consumer

if all consumers ignore the ret_handler callback return uprobe is not installed

jirka

