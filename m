Return-Path: <bpf+bounces-63086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F7BB024AD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E7C5C1E12
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A61EBA1E;
	Fri, 11 Jul 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQFuFEk2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0525FDA7;
	Fri, 11 Jul 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262571; cv=none; b=ZuQi5IdfBuv+0oki0HBSOZl8pov5wlbJGAOv9Maat9Rc4gDfYlM9xIef6U5RAV3jY1nv+eZs8WnwYh+lreqof03cKElLuiDMPxRP1DJaUWzed5PksZz8FsB3SOn0hrPvGHrmWI0JWix/EusO9RqNbrMfiZym004qeHe7eS4uBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262571; c=relaxed/simple;
	bh=2JyjkZbaVpOcZNXUr6/+YHVMQgQYM+1Zvh45n+aaKwo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E10dW2tlAbTlZrTqKoNMpgKbglw8HWM0lYTWb4/By6PXsd+mnOLp8Yhyz9eRTA5l5Vb2bqdaQ5xmMBfd8IbM/ejT68QZPja07lDaZ8txFo5jp1yRN3h54aZbep26LqD2sxuszEvynaE32a0XznGrdDGe9QQH5dM8FDAdjrqGrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQFuFEk2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso3471281a12.0;
        Fri, 11 Jul 2025 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262568; x=1752867368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIfOn6Rb3tfseofOmKK1vxMi7RNeHNheLMa9bMxs2dU=;
        b=gQFuFEk2mQShfqaO0EsmvmDIZ96zNnjv/LqQPCW9uBn9JXa8LVuKNX5DANWDXy+jCS
         5xKv+7U0nwfSyVwHekw6/JjjHj6W8tZDgb1GIMom1dEqsbcn3mXE2Y9FcHXnea4h767D
         naB44CU3AOmz+948/1AuDRk0MsuHprvrTOvNkTmmTFL5qs0AEDufB3307wyrfUIsjPTZ
         83RPhvxIFeZq8vkBVEBd+b2gLcbrw8LJBcbZkXd29HT7L3Dq/BJCuxOkyeZOYQwZwmEt
         UfNI26YFSTfiyQmCb3W+Q106mxL4AhjmKVMZoiZG+brKn5jL49ozGlZf48R2xe6x05Cg
         f7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262568; x=1752867368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIfOn6Rb3tfseofOmKK1vxMi7RNeHNheLMa9bMxs2dU=;
        b=dRJusogo6NHR/ULLSej8Z3rNy1rrKhOp1jvqmbX0bYCrEDbRq391XOD18MMNK1gYkJ
         3Zd4tYot1HCB11YBvyN4lDrqu6l4jG4XfTAhTbxWBNCF8jhZnbSUN9uTYIk+9MgVu6WC
         CpxR/am45hUMcCUl4hfQUjHB6oHGNC0+2c1HrQzdxzApOIpVossfxkyEKKUAy98TZNiP
         z6LVZdkh1Vas1lEBN32AMBesr74TwBHwh7zYwdybTl/iiN2SJBHYvyKZIyEE7BTvX/yK
         SeXFaScBcg/YkXmI40/wadPN4Rko4j3hqikkkbhDqa4AXuhH9VIr8V24PPO60peN+27o
         LMrw==
X-Forwarded-Encrypted: i=1; AJvYcCW/lxBhJJxDM+vwU6/dpiBR1/zpx2TAbsUrki0lPyN4HUuNcAlrPEEvz0z5rI2jcGlSsls=@vger.kernel.org, AJvYcCWqVwHtNIO/SbAJj5xdzmaO4mzu/21LBVx9SnSlglvJu3krMEPH18ZWJhOKSzd/H3Sc9akAjDqFU5sQjp+Mng6kV9m9@vger.kernel.org, AJvYcCXuqe+d8dXPImlK3rvf39OXreWS1G0lw7Es1ecxvlfdIUS1uPNGdy4DsSAQeoYxZ3nVVaK7S5HXKqx06vU1@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVocii2TA8NdGJqcgtJ7CCkFWjL3xwFzbctUwER0NXbcm+BNa
	xqHlGlf3iW3F3Kn+8808DJfZsqoqcJEegP6escc/pIRRvxB02oWpUSx8
X-Gm-Gg: ASbGncv4go8QWHFCrBPCiBxPyKLt8+xnc5wodzy3CEqPlVf8V+j84tfVJCDIOlz2exa
	TYhCA++LKt43EREf60AawICO/vY9IGbbka9TbqzZJViqd2v0ys2JA5HpQdyIkh/Vc64lAmsrqN1
	es0581mZ6nuIPcItO6EC05GATJ0lDUUPxiRSmE43apIzj2/x8mznq8q2ejWc8hX5KuZ+7/pdN/a
	iWgMpOypCOvLArQYRSkS6Fz/r5kbsy3hNtx75MOswlUqrddIJdvu4Hb62nQ3myOEm3geKSRmiwE
	RJu8WUDqfs8DwQqebwJUhQhu441SOeH0/PrSgRMBp+kSM5yyqrLxgjn5iAu381JkkQFysKEa2px
	YJeyhsNeB4Q==
X-Google-Smtp-Source: AGHT+IFDvB4IMf95WTCzX7Zq4Ah+hUJyynqhCkjv6kas9TazcKdgKM0N+esvU7a8CHSkhakrT8CgRA==
X-Received: by 2002:a05:6402:42d4:b0:604:a869:67e9 with SMTP id 4fb4d7f45d1cf-611e8479c1amr3737986a12.22.1752262568011;
        Fri, 11 Jul 2025 12:36:08 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c973360bsm2615306a12.45.2025.07.11.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:36:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Jul 2025 21:36:06 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aHFnppb8xUGyezsK@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-9-jolsa@kernel.org>
 <20250711174631.GB11322@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711174631.GB11322@redhat.com>

On Fri, Jul 11, 2025 at 07:46:32PM +0200, Oleg Nesterov wrote:
> On 07/11, Jiri Olsa wrote:
> >
> > +static unsigned long find_nearest_trampoline(unsigned long vaddr)
> > +{
> > +	struct vm_unmapped_area_info info = {
> > +		.length     = PAGE_SIZE,
> > +		.align_mask = ~PAGE_MASK,
> > +	};
> > +	unsigned long low_limit, high_limit;
> > +	unsigned long low_tramp, high_tramp;
> > +	unsigned long call_end = vaddr + 5;
> > +
> > +	if (check_add_overflow(call_end, INT_MIN, &low_limit))
> > +		low_limit = PAGE_SIZE;
> > +
> > +	high_limit = call_end + INT_MAX;
> > +
> > +	/* Search up from the caller address. */
> > +	info.low_limit = call_end;
> > +	info.high_limit = min(high_limit, TASK_SIZE);
> > +	high_tramp = vm_unmapped_area(&info);
> > +
> > +	/* Search down from the caller address. */
> > +	info.low_limit = max(low_limit, PAGE_SIZE);
> > +	info.high_limit = call_end;
> > +	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > +	low_tramp = vm_unmapped_area(&info);
> > +
> > +	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
> > +		return -ENOMEM;
> > +	if (IS_ERR_VALUE(high_tramp))
> > +		return low_tramp;
> > +	if (IS_ERR_VALUE(low_tramp))
> > +		return high_tramp;
> > +
> > +	/* Return address that's closest to the caller address. */
> > +	if (call_end - low_tramp < high_tramp - call_end)
> > +		return low_tramp;
> > +	return high_tramp;
> > +}
> 
> IIUC, nothing else has changed since I've acked the previous version?
> Then my ack still stands,

correct, just the find_nearest_trampoline function

> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 

thanks,
jirka

