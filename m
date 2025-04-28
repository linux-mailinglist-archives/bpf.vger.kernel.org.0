Return-Path: <bpf+bounces-56844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D62A9F2B3
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8560A16BFF0
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE226158D;
	Mon, 28 Apr 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIrEO5hK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB752686B7;
	Mon, 28 Apr 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848138; cv=none; b=J7L6WRvq+jiQIQd5kP00IXET9faYP6wd7Sut5lg4uDtXStXOOLSufp8bzaWdzG+fHw8gz2vqjcNA9B/qYpzVU7YpF0hQzKP4XD3TLkHHd+us8JSkqn8NCkXcs2EVhI7ZNuRl4ER/usqyZc5dPxjEdHGKt4A/fBVo0F4/STOWGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848138; c=relaxed/simple;
	bh=HLTxekg6SxOcOsK/qGp+Wm+ZPRgavbtD8xBy8iyQaAI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVhFR0BFT/4MwPSpzmPDac47E1rNa/2EaiLe2jrbFxPz870iCrFTerFFF7OEgR1MVjHmrJ+9KHYf/JnCI37cElXGpR0aJAXVpLFPd53tBe1iROS4UTdXoXtMd+YiV/lyBYNwhBPxM8Kgj+W09DT+Pybo+v02hD8xP1dzrFlMiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIrEO5hK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so687292466b.0;
        Mon, 28 Apr 2025 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745848135; x=1746452935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot7zGl3RuBf7IRpQhd5mY289ZLMwSwI/eG9Lq7KXLoQ=;
        b=JIrEO5hKmCz1QHHKHCgvq4bPnUKhIrSHnOEsDX2U3pSF7dnS3C79+EIDjK83DRE84y
         2ET1FHZUPr48vEroHSvLxL9lUuTE/33gPT16VR7pX9mjl0C5FhsWFi4Fy2Lfj9Nr6yGS
         u2TMVZ1u9en7c1xTgJbZPp5CO3K8D5uOzdrvFfmfuv0Dn9xS0O+011oiY/d/lX6eJXPZ
         8hpPhouCu4/2400NEq6WqZjqD4vbk9bfgY0x7+5Ln3LRaoPLBBQX08hDUFTi1fGSOEHa
         8iYwyaKbE/8o8uA8TkLHE1/YGoXzpIYXCRtRBIXaonnASlTwMQv45PcVkhFuQDSte38A
         Rozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848135; x=1746452935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot7zGl3RuBf7IRpQhd5mY289ZLMwSwI/eG9Lq7KXLoQ=;
        b=Ojw+lrtXyY6UNezJT6qHyXnjeeoHJrSAkNYZ1xTv76e9aKl9JsVaBMNuRsez8Fp6tA
         T5DuktZR0EoVxzzHytzDe+tmXiUOhgRAFlKuV/o0uiYd+aY1bg41B2KTXZyycD5kREgW
         k0l+qsBMluve3A/z7XKEGAvqoMLWf6Up4wlyWMzW1Cn2IZmq25gpVNvEKkgCE8dvvfDH
         0ADSRQ039vAqf4zmof9PGc0QCEN6cnXi/XAEnvh4IVtZxcpna6RefrjlfLb6t2YBRIqJ
         o7ww7wXzzMD83CmumeMyJZlvJT/aueut8fY1qQtj/A1D7PGmi9fnemiNJqecHBiV8Dcu
         XcQA==
X-Forwarded-Encrypted: i=1; AJvYcCU3FjYy1uuwTBv60oBYb9g3SLiDxWAHD9f71qtIUtFlOYImYUhRSCjk1LiJsmEItl11Y09OnBV1XyFQQjv2@vger.kernel.org, AJvYcCXf1N92agAbv1WzS+8/Es84j2wtfvzm/6fEGliPekHWZOGZbWRIjJFM9rHQw1dVDqTCXtw=@vger.kernel.org, AJvYcCXgWG5xVocZYCK7L5AKbLDWwA3g+J+X8WCiwH9eWRfTV1zB8W+sTBK82zr5TLuFMYX1lNiaVRkfO0hSVEiLRXANlxq9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iC72xROQsgA24SMjLRnoGJxR8mZdFnfGVjtcIJfqtJF3fGwM
	PiZDDg7CdtFCxOOWDPDRozTLqj38VBn+Wp8+aBFu1sfQJtdMGa9+
X-Gm-Gg: ASbGncsqiClTTmhsWkyZbSBP8/1sBchrT+cro4L3CaWeMvc/ZD/0gwQ5btmZhl6lyki
	4uLWHrrEHdqoGaDqg1LoJ3wn2AW9lHWvR+1oeYgnoh/A3lqYznVwNiN2XSd0bBHV7N9UvQOIn4l
	pIAs3DujP4kFUzmSTg6M2HphskJhwBq56bK33Lx19z/mFWVRIqPvh7oqulPMszEH8I/Gc/ZVofd
	CC6ayol1u5RfzIQTHf60oH2iz5EhRG0L2ihQ+vUPOEU6CJOITE8BL2reo27qzizXJn4MSeqSADP
	gjqqXGlAfxPs2dJCmZ4O3vcNnB8=
X-Google-Smtp-Source: AGHT+IF2RIymO56/j4PaaIVUU5hWd33q98hmsID+T/QUTfZAQNdifbnv4XI4o7FGCL6y7RRKdXRf/A==
X-Received: by 2002:a17:907:2cc2:b0:acb:5583:6fdd with SMTP id a640c23a62f3a-ace71048406mr802061866b.11.1745848134448;
        Mon, 28 Apr 2025 06:48:54 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec3933a0dsm6497166b.21.2025.04.28.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:48:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 15:48:51 +0200
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
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aA-HQ3YfLz28MnhZ@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-9-jolsa@kernel.org>
 <20250427145606.GC9350@redhat.com>
 <20250427173456.GB27775@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427173456.GB27775@redhat.com>

On Sun, Apr 27, 2025 at 07:34:56PM +0200, Oleg Nesterov wrote:
> On 04/27, Oleg Nesterov wrote:
> >
> > On 04/21, Jiri Olsa wrote:
> > >
> > > +static unsigned long find_nearest_page(unsigned long vaddr)
> > > +{
> > > +	struct vm_area_struct *vma, *prev = NULL;
> > > +	unsigned long prev_vm_end = PAGE_SIZE;
> > > +	VMA_ITERATOR(vmi, current->mm, 0);
> > > +
> > > +	vma = vma_next(&vmi);
> > > +	while (vma) {
> > > +		if (prev)
> > > +			prev_vm_end = prev->vm_end;
> > > +		if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
> > > +			if (is_reachable_by_call(prev_vm_end, vaddr))
> > > +				return prev_vm_end;
> > > +			if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
> > > +				return vma->vm_start - PAGE_SIZE;
> > > +		}
> > > +		prev = vma;
> > > +		vma = vma_next(&vmi);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> >
> > This can be simplified afaics... We don't really need prev, and we can
> > use for_each_vma(),
> >
> > 	static unsigned long find_nearest_page(unsigned long vaddr)
> > 	{
> > 		struct vm_area_struct *vma;
> > 		unsigned long prev_vm_end = PAGE_SIZE;
> > 		VMA_ITERATOR(vmi, current->mm, 0);
> >
> > 		for_each_vma(vmi, vma) {
> > 			if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
> > 				if (is_reachable_by_call(prev_vm_end, vaddr))
> > 					return prev_vm_end;
> > 				if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
> > 					return vma->vm_start - PAGE_SIZE;
> > 			}
> > 			prev_vm_end = vma->vm_end;
> > 		}
> >
> > 		return 0;
> > 	}
> 
> Either way it doesn't look nice. If nothing else, we should respect
> vm_start/end_gap(vma).
> 
> Can't we do something like
> 
> 	struct vm_unmapped_area_info info = {};
> 
> 	info.length = PAGE_SIZE;
> 	info.low_limit  = vaddr - INT_MIN + 5;
> 	info.high_limit = vaddr + INT_MAX;
> 	
> 	info.flags = VM_UNMAPPED_AREA_TOPDOWN; // makes sense?

so this would return highest available space right? current code goes from
bottom now, not sure what's preffered

> 
> 	return vm_unmapped_area(&info);
> 
> instead ?

yes, I did not realize we could use this, looks better, will try that

thanks,
jirka

