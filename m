Return-Path: <bpf+bounces-56949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4EAA0DB1
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81196163F75
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397E2D29DC;
	Tue, 29 Apr 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmz51O31"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727802D1F66;
	Tue, 29 Apr 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934269; cv=none; b=JVxykTOlHN6ql+63AwVreSIForFUAw3rBpTfuQLClGyzU35hY6im+Q2wgr8z2jyV9mvrHE51jX2u/eV0JgAqQr2JPanCGZl2fmDZghPzp5mmaCzH2Fp9/tmaH1znCyi4IZcCZxU7gpg8y5Wv9nkqzlc+54bBbRbFZi7bVin5CZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934269; c=relaxed/simple;
	bh=sn4Zc2a08/jxnc89UrIbN0v4ePVwTaDL4DKWjOTGZug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBY26wwpilFhV0rrJCMUMlTFJTaGolguiLp5y7vOqEFUGAzyGGcV4dVAzIDb/erHq8EXFZ8bo/ejNtZoEGZMoiO1d/zmfEr5YrXggZJwaIXyfVSLvafBw3JFakjFJnzqEKIub8EavhDxVoYD8fXNc/K+VkHOO2uyatp8AhfCxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmz51O31; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acacb8743a7so1028039266b.1;
        Tue, 29 Apr 2025 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745934266; x=1746539066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py/+tRtKpxAVkjpFhtFIv9ZCspznEw0Yc/TuPK6v0P0=;
        b=Fmz51O31RdOQQ2cS3D2jxadzYnEkL+Dj7fq4ciVBMYhY68A8aw7FU9i5aDERixx7kS
         kdAE8acSUtqz01uiLa/LC3t6CwM45T5dRZixpTUJaWxasXIG3mVrpwdcmoVpjFcMAa7m
         3WzNL9kzTVtEeDAAcXHBJqn22qSgJEO5fwhHI5WCB9aYD1s4EW8hi79TU4UZ04oLkj60
         oGm8E0tZoXBdVFtBthGt4teKSehaMXEm29tDDl5Y4jSc5FfNLIE/GZhktFWBLGqbYM+M
         fn9Jc88y4XgKGllFxnydoagoIyMiNQ9aVi/hfJVvKMjHWvaPQCZyEXeVNpwdSC6/Xjfm
         HjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934266; x=1746539066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py/+tRtKpxAVkjpFhtFIv9ZCspznEw0Yc/TuPK6v0P0=;
        b=a8B/LaOiESIFIyaK1MJb6+sH+5RunpPvQYDkPogeOmaztZQj68pMAyzY9+ZF7Rxvd/
         7buOKXfLA8ndsg89UtcqzPXy6vEj3JEUS00WMwTjEr81U/Rqu9Wby41LVxbFQOOMtxR8
         NksK0q1Sw2asdmcOJ3b5mxxC99qA96mNHOEIadw/RgXmDQ/BiTKIt06gm/zkoBtAWwdm
         NVCxIiQR/ywTGnl/ooj2qF8aujbtlHVfFbpK9qF40IY+9AMp9yLLES3H4kZvfZgbeSCd
         nyZ91CQQf4/gwZUqmAthRjSVFfOwMjRxZva3Bg2uQ6c1Y+aHq78oiMh6eeNsqbltXmr4
         mCWw==
X-Forwarded-Encrypted: i=1; AJvYcCVsTGZKcYVfje6E8owy86svL5t9pnH2IpxOIvo5+J9BrPq9r32glzbxAIHoeN594R6HMh4=@vger.kernel.org, AJvYcCVt6AnCD06Ps6d86+2jshIicHgDJUwBNNnotOsFEDqKK7aLU/qji1U/w/eZO5NM6e4RvXWnj1c0mrD3B54F@vger.kernel.org, AJvYcCWVtJiAH1A/OtWnyN+MXYncLq9fTAcApMinxiAxAoMGUzNohVJ4iBjScreIK1w/zas8QsZYBXYDKPlImdkv9Nb3SvsM@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5VbTfsGNURjK6fsR/VLHcFHbbxQDxa16o9KvKy8Y7xDRb+A0
	RMLoviiqj+ea98wSNBma74ZHqFcHkDjGWIzfQw4RoxMIG7geyY9Kc5VnIr2i
X-Gm-Gg: ASbGncsvYkuG7hsVHomkX/bYyXDebBPDinAsak+PMmb2pDq0NDCC1UZAAaakDJdlG8v
	FzbrOs0TM1aynwn9x6kTzaqZB8ypPObxX2EKKTHJG4ZdJIfzyufopBq0RE6kZe7Js4hJCY8d6HV
	1gF5JLpbDrcQLjUtvvSwJeT38qT6YGoQluGxNkiDrNJsKnE2sz/lyBxcQSB4p7YG7lraXJMjpxo
	JUs+rqbKsOX5SWAf1QkZy2PV+ENmU3zgj3wXlItRVhyfccoawvJAIglbUewHOQJ6ewFpAL3yWAB
	vgSTR/QGTo1aADvJxybYRhP86+k=
X-Google-Smtp-Source: AGHT+IEzjLmNdgBn1573NpnF+vIUcUzCNRAWLZ34NioL/R0iZ1SWG/YJ7G9Zy3Ei0M24E48pW9t5iQ==
X-Received: by 2002:a17:907:94c5:b0:aca:c67d:eac0 with SMTP id a640c23a62f3a-acec66aaab9mr340369566b.0.1745934265396;
        Tue, 29 Apr 2025 06:44:25 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e5963fesm776592166b.81.2025.04.29.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:44:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 29 Apr 2025 15:44:21 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aBDXtYOZelStjAe_@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
 <aA9dzY-2V3dCpMDq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA9dzY-2V3dCpMDq@krava>

On Mon, Apr 28, 2025 at 12:51:57PM +0200, Jiri Olsa wrote:
> On Sun, Apr 27, 2025 at 04:13:35PM +0200, Oleg Nesterov wrote:
> > On 04/21, Jiri Olsa wrote:
> > >
> > > +static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> > > +{
> > > +	struct mm_struct *mm = vma->vm_mm;
> > > +	int err;
> > > +
> > > +	/* We are going to replace instruction, update ref_ctr. */
> > > +	if (uprobe->ref_ctr_offset) {
> > > +		err = update_ref_ctr(uprobe, mm, 1);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	err = set_swbp(&uprobe->arch, vma, vaddr);
> > > +
> > > +	/* Revert back reference counter if instruction update failed. */
> > > +	if (err && uprobe->ref_ctr_offset)
> > > +		update_ref_ctr(uprobe, mm, -1);
> > > +	return err;
> > >  }
> > ...
> > > +static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> > > +{
> > > +	int err = set_orig_insn(&uprobe->arch, vma, vaddr);
> > > +
> > > +	/* Revert back reference counter even if instruction update failed. */
> > > +	if (uprobe->ref_ctr_offset)
> > > +		update_ref_ctr(uprobe, vma->vm_mm, -1);
> > > +	return err;
> > >  }
> > 
> > This doesn't look right even in the simplest case...
> > 
> > To simplify, suppose that uprobe_register() needs to change a single mm/vma
> > and set_swbp() fails. In this case uprobe_register() calls uprobe_unregister()
> > which will find the same vma and call set_orig_refctr(). set_orig_insn() will
> > do nothing. But update_ref_ctr(uprobe, vma->vm_mm, -1) is wrong/unbalanced.
> > 
> > The current code updates ref_ctr after the verify_opcode() check, so it doesn't
> > have this problem.
> 
> ah right :-\
> 
> could set_swbp/set_orig_insn return > 0 in case the memory was actually updated?
> and we would update the refctr based on that, like:

ok, I think we need to keep the refcnt update inside write_insn and enable it
through argument, so I can use write_insn from swbp_optimize/swbp_unoptimize
and tell it not to do refcnt update

jirka

