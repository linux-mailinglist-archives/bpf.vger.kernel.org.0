Return-Path: <bpf+bounces-40195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94597EA69
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5751F22061
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711D197A88;
	Mon, 23 Sep 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYg04hIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C824EADA;
	Mon, 23 Sep 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089361; cv=none; b=GiBR3UF/+P5bgyRB4FJuHJyFAcH+99rjWHFwTpYGHGfbKoZZnhwfjI/QQu3/zCCgVvnUnUrsPS59zP186uDprSLcUf4MQ9gLuhlMPOmU4ffdJB12SFcKeEHPTv2igQFDtNnrQ8g49GPmY1cH/EByvcaUnZcojxqVfiMYX3WlfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089361; c=relaxed/simple;
	bh=LlvucM0P1hXSJnxs8UuQo5QRum/PKVcAx7WDA82wobk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1UxjgycLlQY+LRPEfLiaVK1V+jjhn728GbNHgCH51josNRovTlLCDFjYsCNzbfZsGAAfWyE4Bu8cvH756U0b97pqGlWPsFF4fcgBlFkvUPYi4bf6HIuCPIkoIzrTC3zUd9ScwwP++ROy2w50bHEBtahjq/Yu2gHSLNpTIfk26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYg04hIQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bd0da617so2978462f8f.3;
        Mon, 23 Sep 2024 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089358; x=1727694158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yidkyLnY/xuXlstPu2cMA6yS+9pleuUa9Q9pOuYZ4M=;
        b=BYg04hIQs21f+OKRzlZOVrZdVaTc7G3p0x9n9U5k4UmBy8HbUuPvHCDE0XUuU4j/LL
         7aJx7PsSFeMw/MOA/pgm2uaO8z2QxJ1pSBDPJg5NtwzmhhmHxcPpvmHw9bRuSdA6Z9Mi
         jEV81WU6pMZdC+y6aOroZyHQCvUr9hXcpA+LPYt2Qrkdq6rWo/5gCxZe1KsFxetAbbBV
         /XQybb8Ia5T1s3AhhSjobTsEgi7x5FefL6N2LEXfnsgYFvOuvI83dhQpOCGivUfzqQWm
         +8Y+tR2l+YCbQVoggWnDfE/Ho3i15fVGNFbBF/K0t1wOqaZ6+O0cgsEGgWQBabc36Dhf
         bTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089358; x=1727694158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yidkyLnY/xuXlstPu2cMA6yS+9pleuUa9Q9pOuYZ4M=;
        b=PUZr3AVtMgDM9EWUgGTD/Rwf/ZGNNEt38qRiZYzcecLg1yD+xWjRdy0Oj3CJM4foef
         BGFWcsLq5yglLeiDwEOIQMbX/r4SaSoyedzAfAZQZtNwFpBBDgrqU9gK2F+CJ9eSqdbS
         s39PB5x45Ilocx0l1Z+QEdlo0grk4iWN4mVjpnDJR6nh5+cLEGxvE2cvdFxRZZIwlWte
         quN2EKs6W8t718SCmvdhX4+ydkRGqw4vOEX/bsKyFT875dPUvzn/25RwiSYDVfZ8ly3j
         DsNkO+TRE5PbVtppCTWbrTwwobcn43H6zUVYkXMv3T3ZyFj6r0BJKyZINUKb0F1Fest8
         wKiA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvUpw3rjTJpW7uYXoYbrLd9T4eOUH7Ypdp4IzV3XWftj43IM7Fviq/Z31HJbwPNnbjksZc/cCL57hnoLcgh1LhsTQ@vger.kernel.org, AJvYcCX66qoeyTnpMNUCmB+l44EHEBb9kMnMHKmgc0koTulOtXnJdh3cORwF2Ssrh8OZApyi+bXSWYfg8ajMNadq@vger.kernel.org, AJvYcCXBZGj+riApIIgMsceW+kXpQB/MgVLEgMXNhiT7u1tmCBRIXquX/RQL/GMq7DapryV5Uxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9inX3mc+xBUy3cC8PoamsfYiJjVg39vG86Cz4JX6tAfJQGJK
	SJLkVB4pLXXEsNrQpwNN198OyeQ3d5/cCnJH188MQEQeUrnwCGpT
X-Google-Smtp-Source: AGHT+IHaEAZrODitl8iCpdeEw/+Vxhs0sLBKOLbimZWJkK85P1HSSkvbyYQR5dqF0IlKeHJAqUEZ1g==
X-Received: by 2002:adf:f882:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-37a4227273dmr6127402f8f.16.1727089357801;
        Mon, 23 Sep 2024 04:02:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm24050519f8f.30.2024.09.23.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:02:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 13:02:35 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZvFKy9WLiz18GjEZ@krava>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
 <Zul7UCsftY_ZX6wT@krava>
 <20240922152722.GA12833@redhat.com>
 <ZvEhL114tyhLmfB1@krava>
 <20240923100552.GA20793@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923100552.GA20793@redhat.com>

On Mon, Sep 23, 2024 at 12:05:53PM +0200, Oleg Nesterov wrote:
> On 09/23, Jiri Olsa wrote:
> >
> > change below should do what you proposed originally
> 
> LGTM, just one nit below.
> 
> But I guess you need to do this on top of bpf/bpf.git, Andrii has already
> applied your series.

that seems confusing but looks like just that one fix with the
commit link in [1] was applied

[1] https://lore.kernel.org/bpf/172708047825.3261420.5126267811201364070.git-patchwork-notify@kernel.org/T/#mb065649b5ab8f7ea5b03c215bdc6555a0b76c0d7

> 
> And to remind, 02/14 must be fixed in any case unless I am totally confused,
> handler_chain() can leak return_instance.

yep it was missing kfree, but it's not needed in this new version

> 
> > also on top of that.. I discussed with Andrii the possibility of dropping
> > the UPROBE_HANDLER_IWANTMYCOOKIE completely and setup cookie for any consumer
> > that has both 'handler' and 'ret_handler' defined, wdyt?
> 
> Up to you. As I said from the very beginning I won't insist on _IWANTMYCOOKIE.

ok

> 
> >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > +		ric = return_consumer_find(ri, &ric_idx, uc->id);
> >  		if (uc->ret_handler)
> > -			uc->ret_handler(uc, ri->func, regs);
> > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> >  	}
> >  	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> 
> return_consumer_find() makes no sense if !uc->ret_handler, can you move
> 
> 		ric = return_consumer_find(ri, &ric_idx, uc->id);
> 
> into the "if (uc->ret_handler)" block?

ok, will move that

thanks,
jirka

