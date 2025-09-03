Return-Path: <bpf+bounces-67288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76113B4205D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C11BA81C6
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF822FFDC9;
	Wed,  3 Sep 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amW8gefT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C42741DA;
	Wed,  3 Sep 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904603; cv=none; b=KNCUfzY4NKplbzsx7azBqPopwG9ArUsGY6upamYlXOskZg3uO772kothNtchCU+rwYeujJE+ANz8gpLzsO+ULFJvZC/t4hmoUQoozZPx7bzfxLpxdh3xURWnnLx9VKzwsN32RNH9A13i9N2CzY3syC/cxCiBPbdpHFEY46Ul6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904603; c=relaxed/simple;
	bh=gQ03fBGAFuwsI9xFioKKjesvx+Gsro54JwhK1qlkHiE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWhYhMExQsAhq3ZHkEsnNpklG58+CgAcaN432vYGTCuHEYI2zEmMOFHKG85JPU5p7ncWEuGf1wFo+AV1iyECNTdGu8KgM/fAIJ+WmeMui7YNCKcAZjeYeaphAWYqwmrkF6bRX7sVwhBBXUU+WV456dQqOluCL32dLuYxwSx3NfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amW8gefT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cbfa1d820so13004138a12.3;
        Wed, 03 Sep 2025 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756904600; x=1757509400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKsJK/zcx9q1MHyU7zTce4tdn70RAQrFC+vaQsPz40g=;
        b=amW8gefT/WvSJ25yeFpHhMZj0Chpl17SWAaQQKO0zQl+Ndpm+FkuPlrnM38GTJoGRU
         g6T0zNl52/+1iBvHKpjlBitT0zXEtBKISbvVyMAVG6Xg2bTvm7Kjtl7H9/ULWMSf/A2/
         4Oq8pBN2+dDgmAae2hrP6EbocAsKvTiXTaYuE5fD0eeRvtvUnLvyKH8enAfQDuoJ9uWs
         dnFueu7Z+9mN5Y211iXAgp9TbO8oyN0F/qkOZdGi94U9hrqBazV2HIrT/qBnmt8T5DYU
         FUuJWaOz+SrkvwX8ogabtyCMDodBwadSKyLNcNeJTkSp6KftuXvLgCq9qPQWOScxVWcH
         ZFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904600; x=1757509400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKsJK/zcx9q1MHyU7zTce4tdn70RAQrFC+vaQsPz40g=;
        b=V5SmrgoUQfbfzKMl+diql0BO7NHLov1pe7T4drhD/+5NYfT/Dvlmu+uRrGWfVi/mnc
         FDIXooqJuJKG4gSjQfx62G6Nl5M9npIf9igZRD6Y0DOqWVmLFRTM9w/pPenBzpIAqXeF
         CrPqZZ8SkaAL/qcl4CQo5lt6S9vRuT7BDZDa2GkdxS2LiatddMABMI4NF9LGDwQE3Pud
         cKNiYfhLXAo8LLc+GHyIG6bH8frU8VRP1S7xVnZs57IcELPpPnFJuI+nRmJNQBGBNFdu
         EL7pBYGMovviODEym31wd93oH/41e4WPLyhzLuKDg23tWTzJ0ye9ekF0jpROSt2Xqaj1
         IBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Kl/SVdBlvDfLlYz53mGdWnOqQ24olbFOE56K4KsuAcrCnbZFgVnhN1zn6yWC7c4dtG+jOENItGW7LSFB@vger.kernel.org, AJvYcCW05G33/HBLk9lhtOOaNdyy/LLxi/K58CmDgmyelLdqpscqmR+XRycNkxs95k5ADKBp7yu2IBYB+Hp2AF5W8mEuXxij@vger.kernel.org, AJvYcCX6i0PKSn96E3+8YuH1YevUghX99B6dPkTIhr4iQnFNfAPaXlw4eZCxbJBIdqdiqjPLIZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmDg5TGeSRq5dJdhCkgZDc/+ctLDneMdXCIxsoQGEUhYhX3t7
	soH/Ey83ZV6W7ugT+jVx/yuUm1McnW6fspyD1k9feE9BoAMboWUQDa1j
X-Gm-Gg: ASbGncsq8LTPEcjJueAqNcal5Z7Pb4vQxyMKB7LIElMhwTbQ2S3q4LH9oARJJ7qjbIC
	L6P6w3Ue/+yqQ7IrGmVB3ZQUvEQeIQiOSxFJvqLpBFt2ULruw1iWMxw805nSSi3/Xa/K7zgTDKT
	AvFw8udZrxtADdtZVn5hCBSq8Ix9fAtRLWOvyrpORgNmTdXwYE+9hq9Hl9QcncAb8PRNiG1x87F
	4i9ChTC6xdSft8uYLLdZ/pqhCARq0YdjojwbevuTOtmxVruIHhyzF7NOyXAcJXFaYdKgFHy7pVj
	3YAFyN2iTi7oc5RNMis4FETmo46usYIQEW+fnTD2ZMKLJpbd104t7yzthIhcyP6zZuZfe/xWwfe
	CIH8ybGFcf7xBjMXeuzaGnjvnhIJ66EJAsbyA6wExqDp81sjV6QM=
X-Google-Smtp-Source: AGHT+IE5KLfq9A0AT22C59UYKF7lWBlAFa6e+YI5NMwM3b+a+9UnQafjvEz12kimp8MX81Ax28IwbA==
X-Received: by 2002:a17:907:1c12:b0:b04:31c6:a41f with SMTP id a640c23a62f3a-b0431c6a7bamr887728266b.41.1756904599432;
        Wed, 03 Sep 2025 06:03:19 -0700 (PDT)
Received: from krava (ip-86-49-253-11.bb.vodafone.cz. [86.49.253.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0474be5e99sm29395366b.94.2025.09.03.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:03:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 15:03:16 +0200
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
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
Message-ID: <aLg8lLgHdBhNeaOf@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
 <20250903115912.GD18799@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903115912.GD18799@redhat.com>

On Wed, Sep 03, 2025 at 01:59:13PM +0200, Oleg Nesterov wrote:
> Slightly off-topic, but
> 
> On 09/02, Jiri Olsa wrote:
> >
> > @@ -11144,7 +11147,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
> >  {
> >  	int err;
> >  	unsigned long ref_ctr_offset;
> > -	bool is_retprobe;
> > +	bool is_retprobe, is_unique;
> >  
> >  	if (event->attr.type != perf_uprobe.type)
> >  		return -ENOENT;
> > @@ -11159,8 +11162,9 @@ static int perf_uprobe_event_init(struct perf_event *event)
> >  		return -EOPNOTSUPP;
> >  
> >  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> > +	is_unique = event->attr.config & PERF_PROBE_CONFIG_IS_UNIQUE;
> >  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
> > -	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> > +	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe, is_unique);
> 
> I am wondering why (with or without this change) perf_uprobe_init() needs
> the additional arguments besides "event". It can look at event->attr.config
> itself?
> 
> Same for perf_kprobe_init()...

I think that's because we define enum perf_probe_config together
with PMU_FORMAT_ATTRs and code for attr->config parsing, which
makes sense to me

otherwise I think we could pass perf_event_attr all the way to
create_local_trace_[ku]probe 

jirka

