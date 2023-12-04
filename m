Return-Path: <bpf+bounces-16597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE9803A13
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215001F21298
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B942DF73;
	Mon,  4 Dec 2023 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2M92TMU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD7CA;
	Mon,  4 Dec 2023 08:20:48 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35d74cf427cso2507415ab.1;
        Mon, 04 Dec 2023 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706847; x=1702311647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es+hCWrFXDwniwMcfM2dvcckNIuZXiwDz+UAIj8VFJA=;
        b=O2M92TMUGKE1DanM/GbOZZ4lxIDTPN6TZQu6oU9/HeyvYo2SySowudkMdSWI7FQtnO
         9u+dlFALkgTCXYct0UxItfoETbE+1hzcjRf6wjzcj4tddpcESU3VfEmd2sWf1YnLtHyw
         gehBtvpQaZBgFtwrtY21YYvjj0CVU3AkpM4cG/yETUSuy+lZqGWCXTn0pwo8lNO0Uzyn
         KLrr4RkQnjwAo3XWvsA/nWuw59kimzYksjlGdeb7+GpK7yklXrn7b193n4PN8V/jjIng
         whNoNieAmyHKl5TDDfhhwtDjmT1q67hLDpBvsV61mG/3dzWFZT9GB3xBnL2X9ZN0pFZ8
         9Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706847; x=1702311647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es+hCWrFXDwniwMcfM2dvcckNIuZXiwDz+UAIj8VFJA=;
        b=Chl+BPwUcELv318Xd2yMsmG1DN2Esl3/qxPfwpif2qEqoJDT3nkNISUPpUp4F7tWRs
         PvwOho1T3hOfVa/wkHPOyARtuIrAZTyOxxz9ZETRhRXsOAJnSrAWXhpTyVNPpWIKeLka
         JiE8fPcOE35CKk+yHrMAUoKXPJpAXNPYx/884f+zCejubrZMGmUYhv9S/SadWqyjU3iC
         LMkYDmrPrawdChJPgJaNBhaHXX63Xd2dqshpBptoYtwbXnBbT0tzzVkSmcYott6qwppZ
         u9XXQJczJVD5L73vayCygZvZz70tAUBvIStulG7iJvRykCNkcClN0bMrJu5lqZ88znrp
         dI5Q==
X-Gm-Message-State: AOJu0YwGWrm1yRvHvZUAOailUJdikR8dIPJIamdbSO2+75NPmBACt5vI
	IoV1+OTuiv9dwuFQaoM5PZ34dt/zWDA=
X-Google-Smtp-Source: AGHT+IEhr/y73+C8HGzgQnVsW0Y2ggL68hFdiBnBrbUv0IqcwH3zLyhK0X0PJii3PpbhwIeqJ1NM7A==
X-Received: by 2002:a92:d082:0:b0:35d:59a2:6452 with SMTP id h2-20020a92d082000000b0035d59a26452mr4564300ilh.37.1701706847586;
        Mon, 04 Dec 2023 08:20:47 -0800 (PST)
Received: from localhost.localdomain ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id y24-20020a637d18000000b005742092c211sm2492261pgc.64.2023.12.04.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:20:47 -0800 (PST)
Date: Mon, 4 Dec 2023 08:20:37 -0800
From: JP Kobryn <inwardvessel@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>, ericvh@kernel.org,
	lucho@ionkov.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZW38VTs2L4vbcJLO@localhost.localdomain>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
 <1881630.VfuOzHrogK@silver>
 <20231202201409.10223677@rorschach.local.home>
 <ZWva7DYTPUG95xv8@codewreck.org>
 <20231202231524.4ce1d342@gandalf.local.home>
 <ZWwS3_DGmqc73dxm@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWwS3_DGmqc73dxm@codewreck.org>

On Sun, Dec 03, 2023 at 02:32:15PM +0900, Dominique Martinet wrote:
> Steven Rostedt wrote on Sat, Dec 02, 2023 at 11:15:24PM -0500:
> > > Also, for custom tracepoints e.g. bpftrace the program needs to know how
> > > many bytes can be read safely even if it's just for dumping -- unless
> > > dynamic_array is a "fat pointer" that conveys its own size?
> > > (Sorry didn't take the time to check)
> > 
> > Yes, there's also a __get_dynamic_array_len(line) that will return the
> > allocated length of the line. Is that what you need?
> 
> Yes, thanks! So the lower two bytes of the field are its position in
> the entry and the higher two bytes its size; ok.
> It doesn't look like bpftrace has any helper for it but that can
> probably be sorted out if someone wants to dump data there.
> 
> 
> Let's update the event to use a dynamic array and have printk fomrat to
> use %*ph with that length.
> 
> JP Kobryn, does that sound good to you? I'm not sure what you were
> trying to do in the first place.
> Do you want to send a v2 or shall I?

Sounds good. I'll send out a v2. Thanks Steve for recommending the
dynamic array macros.

JP
> 
> -- 
> Dominique Martinet | Asmadeus

