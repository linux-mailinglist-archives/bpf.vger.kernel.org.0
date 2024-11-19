Return-Path: <bpf+bounces-45189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518579D295B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0842D283D27
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9F1D0B9B;
	Tue, 19 Nov 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StNHHwob"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB61CFEB8;
	Tue, 19 Nov 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029256; cv=none; b=sT55zNb23II//KWJUH7DL3MOgyQ66OmvXN7sa6scM0a+7SLQhLcTEfgZlW3LWISR4wad7i2ySmsVTLKZ7G2/mMA2XT5QWY38KFeq1IF1YfYHNv843dCmwkLIn2J/36bKh68KNIVpiRIzu9mKHKy3cYmqwP252N1rXSIJ4ChLm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029256; c=relaxed/simple;
	bh=wsIsc65wsl1a3A8TlAEYhRoPXjHLrOqSQcfQqgioS6I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9qY76VCxNfoIfiqCmmpJp33U18X60rGSZykdQgEdm0wXfxsCBfJmnD/HBOIMMUXUWvvo3BciAANAJKJwbV+cvMq7xkrZOB1tvOSudYsgwdcBhoF9G/Pbi5RVsDJKNitgloOayCiLbKfSBxke2ZPF0bbdRdMXG9x2Ly5/hMSY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StNHHwob; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382411ea5eeso1637661f8f.0;
        Tue, 19 Nov 2024 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029252; x=1732634052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q+CAblMGwqdRkJ74YKnBF6CZP3Rv4TdMRaOiPdoI1R0=;
        b=StNHHwobxumCf4f7km22iGnuOXPLBv6mLYjVWNz8hADg6fSqGE6TT54OU2FlFJmeYh
         aBUZqtOyAjRFO58tfU29MZZN+HKo7+QN70JHInIkL1v377EtqxSRkHslhmGvOw+jdeQv
         Tj6eZbVeCZad1FjEx8ivuc1v93vufr9KRhOM0rkf1YmGn4PzyipCh1Rtest1fvOCTM/E
         x0v/AkVKMbgJsTJInXcZeAyPxAr3XiiuA6MnXYAnGkkN9vK8UdjwHbMQWFs/olfZ5DxI
         NHnbYI5fqNaLntSeJoirZkRVa5IcePqiO+MESyXERan/syGDO07tTn65FknTWSi1Q91M
         M3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029252; x=1732634052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+CAblMGwqdRkJ74YKnBF6CZP3Rv4TdMRaOiPdoI1R0=;
        b=GBWzPJaRdnt0KIv8lENeQT8R7des+vc3hbMdOkoP8ikQngOndaoNZdnKbN6WWpyx36
         UzGG5sDELXQgxulwxz7wNi7FwoRLVSvBZwUYeeOp39EROumw1bRSQVnLcblvZruJLhDz
         i4s1hGCusll0TNgInrOQJMGOLMTI6CmGq2dWkqhOtjf+I3ggvjovM9ERGx6pxhzTOpGj
         AMPtf5nhQgz/lDj3HlaHLJwzOum+wpMZtk+bLOCuBzLYg+ZLLfO6cD4zbeyAI7odSaW3
         SaLDo9MhzoPj8ZLc7JtCyx3Cheqn+5XrE1gZHPsgEGkm1UZ37Sd5KF7RwRETbrfkayL4
         +pUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPEuEZxE7VwKor6u0eAHmWSMTz6y4lJ8+dM1cZ/HaiaJ0M3Yyzhb7564s3YdAV0ATd04R7FyAAE0zj14EX0M820r6j@vger.kernel.org, AJvYcCW/c5K2Hzm9kfLtwGQk67iR6MmjlUpvCGadW7M48Q3atwODK/tFTMODOZNthlMR+FFj91A=@vger.kernel.org, AJvYcCWhIFo6MZMxU+Sx4P4+/rDiOOEIgOdZKwH1S5SJ1GEZCAZa8pM1/mpvwMjyO5joK7eSBu+6xQn1IJwSAs7R@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfqsgEIC6fdh4QiRptl1RFp9aAiaQ67JEWhTUi19FcrYI1ibD
	ataDEdmHCIVmq5H1xlAfWKbXiwTpjeG9Itg5Qp2bD3RxT0aRPLNe
X-Google-Smtp-Source: AGHT+IGN9CrVaw83GmI4uu44gxeD6Jr0F2TRG+eGuFN6z0OiwShzW2xa+Z3B0OxykD0FrwIYu0+r4Q==
X-Received: by 2002:adf:e185:0:b0:382:3754:38e7 with SMTP id ffacd0b85a97d-3824cd3196bmr3154851f8f.23.1732029251795;
        Tue, 19 Nov 2024 07:14:11 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161d8sm16412168f8f.78.2024.11.19.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:14:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Nov 2024 16:14:09 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <ZzyrQWLrPYzUqLGq@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com>
 <ZzkSOhQIMg_lzwiT@krava>
 <CAEf4BzYBRtK-U_SLY-qYDGf2pc4YzBOeKgyjFbzv-EHXrdNANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYBRtK-U_SLY-qYDGf2pc4YzBOeKgyjFbzv-EHXrdNANg@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:05:41PM -0800, Andrii Nakryiko wrote:
> On Sat, Nov 16, 2024 at 1:44 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Nov 14, 2024 at 03:44:14PM -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 5, 2024 at 5:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding interface to add special mapping for user space page that will be
> > > > used as place holder for uprobe trampoline in following changes.
> > > >
> > > > The get_tramp_area(vaddr) function either finds 'callable' page or create
> > > > new one.  The 'callable' means it's reachable by call instruction (from
> > > > vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
> > > > function.
> > > >
> > > > The put_tramp_area function either drops refcount or destroys the special
> > > > mapping and all the maps are clean up when the process goes down.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  include/linux/uprobes.h |  12 ++++
> > > >  kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++++++++
> > > >  kernel/fork.c           |   2 +
> > > >  3 files changed, 155 insertions(+)
> > > >
> > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > index be306028ed59..222d8e82cee2 100644
> > > > --- a/include/linux/uprobes.h
> > > > +++ b/include/linux/uprobes.h
> > > > @@ -172,6 +172,15 @@ struct xol_area;
> > > >
> > > >  struct uprobes_state {
> > > >         struct xol_area         *xol_area;
> > > > +       struct hlist_head       tramp_head;
> > > > +       struct mutex            tramp_mutex;
> > > > +};
> > > > +
> > > > +struct tramp_area {
> > > > +       unsigned long           vaddr;
> > > > +       struct page             *page;
> > > > +       struct hlist_node       node;
> > > > +       refcount_t              ref;
> > >
> > > nit: any reason we are unnecessarily trying to save 4 bytes on
> > > refcount (and we don't actually, due to padding)
> >
> > hum, I'm not sure what you mean.. what's the alternative?
> 
> atomic64_t ?

hum, just because we have extra 4 bytes padding? we use refcount_t
on other places so seems like better fit to me

jirka

