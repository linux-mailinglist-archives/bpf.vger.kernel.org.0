Return-Path: <bpf+bounces-67427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8995B4391F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8816EFFF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7B2EFDB4;
	Thu,  4 Sep 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCE6VIp+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A472629;
	Thu,  4 Sep 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982796; cv=none; b=NHS8eaiWynCARtEcGCbGZIHrzjnjhqYEzS/LxoBEZIUnIliSrBfWKLYlxEbyp6uGYAZClOoZj6b3SPkDPbosquNkz8wN/oqAIxlvsg9Idi2+4nRLsbIUiXfUaODHSNLGQeBP+zRiR41bQmFhNcERCjiMvQt7xPkOanWGZmMztFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982796; c=relaxed/simple;
	bh=t7jhEFWu/vL/nffTlTXgSrADqDago8gdgl9cPR+Pi2o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl25waemFlhMPQgqupXsTK9VvZmfgibbh/OzKZfSkkGqj4ZJ/br5Kdlh/GkMWKZF4sqinjZRlsenORCmntcv8Xuwg6Tqn0TrfjUj01BkLwgUm7vnv0T2bmBUldgrkQ2KTxpUS3P4aunZ3ujHzAR2O//km1BINndDUUFxpYMeljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCE6VIp+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso1293837a12.2;
        Thu, 04 Sep 2025 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756982793; x=1757587593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/6MCHmVs/INco1rBZwPhEs0od+L81/1d00TkL5c64U=;
        b=DCE6VIp+KFjtVo2zuxUq1CFdhffi+0fvDvJZQ9+Q1brEeLGbQ53BIfcxRn4+aWCAhU
         Pa58YEMF15RVfOIyaOhj1IxEQ3CB6wcGAl+Rq9puOY4eeGcPUM2h7cKNKxkN1g6REsSz
         l2NCBU+BAgdkkR6/3UHGytxzd5zag6Nm64UUcDCliPCTHI/mFjjLwL45rmLWA0whDrbI
         +hsnWDMLz1uvO+gaj+DPmm2VJM/qS5Jqi9XXLt+wY1WAk4XudcrKPr+z8/BUXB1CHRRn
         ClBhquHrijfbFIODWmUin8Uh574WVobyTxu18tclAWURfvXBa0o55uEuKZBjcINh2BRq
         Q9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982793; x=1757587593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/6MCHmVs/INco1rBZwPhEs0od+L81/1d00TkL5c64U=;
        b=fspTrS3GjtQfV2K0tSsEk9xvXRZhtM1rE2hpc4Exb4mex7vIXkWgtZdJvQGMZac59F
         Mq7L5cuU3GzUXnfWs9bTpTgcZQQmWvpww8FCpfr4KJZe/JZsOF6elcbxw/4vLdaHZgkK
         D6ypuZkZRo4KGr1be8mH3ENk5kdYFukgWKtyq8yjPSBMN6r5yf2nP7xnsAgfOzj28mrU
         jQGqQveN22qjWdiPTWAKWHj3KcjyleMUDkl1Zx4oXyiHSkQYIfIPilAe+6r9g33c/UXZ
         d580TAMa6e11IPHO2B8jjrmG/zYtPVsSXeNWU8i9EL31+9AZL+LDbs8E8BaeAXFVSUsi
         ePAg==
X-Forwarded-Encrypted: i=1; AJvYcCUI5y9fkJBVEHB8Ha4XxLDnSKaUt+AGyVEI6pLoIwnRW1O0PW5Qsi9aGxzpqj0fRCjQGyM=@vger.kernel.org, AJvYcCXq7TXE4lenJU1mevyUDdAHXGZrEPLuNxLWw+vOs2epnjojOXje+oHf/sAXcjPSG862GKiIWZ0dS1Gqc37lIibV1Gc3@vger.kernel.org, AJvYcCXs6iR2xSxIc8CnneIsAOCjgIjs80ctryotlOScvdlRLw3yTPggdBMFXUdBrawe39fRJc/9iLzCJ6ALJwT8@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQFiS3JukDKxYJkojSWXInmI4MaSSJLDCt7ho9lFcpDQRfmGT
	AlM+lBF4VwiVRf63ybzWfVsgJAn2dwqv6wN/X0svZ+I8vYuXUa29iZwy
X-Gm-Gg: ASbGncubnUA3uVALkGGNq6UMGegmnRv5+3Q8XWHcHTZ2+schrsYuRZYj/xBOveO/2pA
	TjIbsPsQDJ112uOtz8urTTZAenxKTGyNngqHpd/zfr/AiQYC89EZBfzXn07re1XrjJw5G6fqPfo
	9hpHXnFi7pTTlfJ5T/N5rWT6D+6+PecLlFUbXUJdybxzOb++tGWybxmnWkmZTrSM7NKfWY8rzEc
	HYuGxRcQ/DastVS5AQ3OOksPplTYrMsWH2t5CenNSJYjXk9ZbldliUMG7TmxwxO/sD1P5n2GhFA
	s9aaShm989jRiXM4LRErC6i5898SCyA9GrTQYnBma7+SUL4O0yqcf5TNzwvA79M3qFCVUNHPyU6
	OewIeg9E=
X-Google-Smtp-Source: AGHT+IF2BbXiznN72q968yvBy6zKn2zLuchEHAzxeMcnRqvSKT6buqhPOlQiBdzDdyf17ZN1MJI/1Q==
X-Received: by 2002:a17:907:6d18:b0:afe:ba8e:7378 with SMTP id a640c23a62f3a-b01d979d03dmr2024143466b.48.1756982793072;
        Thu, 04 Sep 2025 03:46:33 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b017e4b9ed7sm1308898266b.90.2025.09.04.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:46:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Sep 2025 12:46:31 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <aLluB1Qe6Y9B8G_e@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904084949.GB27255@redhat.com>

On Thu, Sep 04, 2025 at 10:49:50AM +0200, Oleg Nesterov wrote:
> On 09/03, Jiri Olsa wrote:
> >
> > On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> > > On 09/02, Jiri Olsa wrote:
> > > >
> > > > If user decided to take execution elsewhere, it makes little sense
> > > > to execute the original instruction, so let's skip it.
> > >
> > > Exactly.
> > >
> > > So why do we need all these "is_unique" complications? Only a single
> > > is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp()
> > > can just do
> > >
> > > 	handler_chain(uprobe, regs);
> > > 	if (instruction_pointer(regs) != bp_vaddr)
> > > 		goto out;
> >
> > hum, that's what I did in rfc [1] but I thought you did not like that [2]
> >
> > [1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@kernel.org/
> > [2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com/
> >
> > I guess I misunderstood your reply [2], I'd be happy to drop the
> > unique/exclusive flag
> 
> Well, but that rfc didn't introduce the exclusive consumers, and I think
> we agree that even with these changes the non-exclusive consumers must
> never change regs->ip?

ok, got excited too soon.. so you meant getting rid of is_unique
check only for this patch and have just change below..  but keep
the unique/exclusive flag from patch#1

IIUC Andrii would remove the unique flag completely?

jirka


--
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b9b088f7333a..1baf5d2792ff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2791,6 +2791,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	if (instruction_pointer(regs) != bp_vaddr)
+		goto out;
+
 	/* Try to optimize after first hit. */
 	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
 

