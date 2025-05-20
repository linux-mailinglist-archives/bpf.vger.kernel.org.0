Return-Path: <bpf+bounces-58561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A7ABDD77
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CA4E64C3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597EB264A84;
	Tue, 20 May 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhFyBJcu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB324A063;
	Tue, 20 May 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750610; cv=none; b=Z2sW2iZkvHFlgcMksHPJua9dCy39SJp6CGu2EW4e/7GDAx23Gk2Q9N8R2PL7QDYhuM/k9712re0r1O/Cp8Vr5NK/5quKPzYxUpwJ6GapmzmAWaRuA4yntjmHRgW0j1AK1GBsS7XPGyBgKgqBLJtixiIsSwD0HNQS899M18ZHf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750610; c=relaxed/simple;
	bh=9845lRrTwXYxLKnCGaZLjP7FJCySvM2kgiB80MXvo5o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmhDwP4Y2W1BQZCY1g810OHv7k19qupwrH9SchNi5D+T59B13BY8Ks4XqcgtnrXSakJtxv/B9vSGBgwdbheRPzs0RJvrUGMrt8GhpjQidNIfDOCLDdfo/z/VGRetiBVhAuvoClO2lUg0SVMBPkLcleXQJt2ka99rFXzrETJlM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhFyBJcu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso2216792f8f.0;
        Tue, 20 May 2025 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750607; x=1748355407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8zSJjCRi1M41Zo6T5qJaK423QY8z842edzrekqdkMM=;
        b=FhFyBJcuPmr3WOuli3LpromTOiQqLqctMvSb4drqbgm1LOqAF3KQLec4CFymYVWzfg
         x0PaXJ8HW2+HCFKzhq1GtW4nrq+d2q/pcsWdxkTuru8jZbkAYSEcdYzUVrLWWRCXN/tQ
         WhRcsZPVgU7RsYAs4BUps6xS2d+EWmEXnHrK/YkBMmFQUWQKstEG+07A+eZDKoURRAnx
         EDJkZN+2R9LxzfKatGZkTWRJ8KDFgkp63iMTa8gaCsCLzuPAqGB3qbc0EvGAII+p5LN5
         suGXhE2uZUYMqZjQ/FzCSr9XYPm0QgiZDFFj/W2fq5FOt33QMirI2aOQW2G2NGe8S07A
         9bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750607; x=1748355407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8zSJjCRi1M41Zo6T5qJaK423QY8z842edzrekqdkMM=;
        b=KUK/QRxbBxEXvyCh0SzsMwH21Mb+KgcovAzHafwSKu6BAfACJ+vI1l0slQ0rc78uky
         TbC2UwieO8zCravWUCHiq42cSp2fx5hZkmD8vQb36diE1q8bGtqznznIve0Us/ja2mOO
         yEE5Abt02OqfLvm2fpy9B/xwmxFp4lCD+/dRSECGWIBvNjYWkfzmhblViHXWeOjyPAJj
         8FYExSJ5x0cCkMZXNQ4MJW8bH3x4wi+KWEycYwYSUQkjHQZYKcX2VHDIl4GWDewbJ7tg
         5keG+DcjUyuDJEU15Ar+Vk+cPK1jkbkto7kCiWP0lBjMT+VWs96YHS44KH1lcGRshy/M
         kAng==
X-Forwarded-Encrypted: i=1; AJvYcCUxc6yltiMynOHjkGZpNss9lZMJlYjYNH1G3W3ch0pvWHcRLYUWk77MN1ddlywzl/KH8DZibr+Xc2nmavY5@vger.kernel.org, AJvYcCVWoZJvNDK2oSsgR3Jc+DAitCbjltFPzpwkHqpxRQPTSRBet4BEj3Z5ObYZG0SKDJvOovU=@vger.kernel.org, AJvYcCVxhhs5iUvTtvcqgCykUShuekRNAXi23rDA/FMMnmj8Vkrji2lAFIusRVAxQxOQm39+OjQemdyESgAUZd/Eb4FqpN+/@vger.kernel.org
X-Gm-Message-State: AOJu0YxBk4buxF/cCpxRU96fGffRxGJhvVG0ecXsrBSQvNlbIj06QpHt
	AxdWwkFs/4p7ro9kGTSP/F8QDEUvaY3PNJbc+Se7WOx+kalIerZuguQMqirazUcb
X-Gm-Gg: ASbGncvrnrH/BtGPXdrb09R4mS5gQBHauS0pPbcMqS5UEqD3dPGoTk1PNeUgZwSKGVB
	c3L3TJFnWnMf4F7t2vQlwRMOob1Y6dOrQitYFZCCE/hmETJjK1CovRHVhqtX+jRCB94P1d0pFJD
	iRDoH6dhT+eVzOvH+VOd64q0Ss6LTHudKm8pWe9cBJBvc1l6Pd4AQ686PegOmuuYMUJlpzRT3MI
	JJ7g9qDM5Ss8iYvzCxlZYiwxQUo7jt9H1TO9jxnudRtyk628ye8LvRA15lKG277h8CyHHeTC2fy
	Le4XsH7P086qJVDIAwYq6M/3qGp3aapwD++i
X-Google-Smtp-Source: AGHT+IHpAnvXNreEzLLqAUagJDkV0tQZs1tpXf9pWpAvAhFCTkj2uxZv2DHjMrxfmDDzvZhlsoXNzA==
X-Received: by 2002:a5d:5442:0:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a364fb30f1mr9468037f8f.12.1747750606990;
        Tue, 20 May 2025 07:16:46 -0700 (PDT)
Received: from krava ([83.148.32.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d258sm16430575f8f.20.2025.05.20.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:16:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 May 2025 16:16:43 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <aCyOy1OKDSrma3rJ@krava>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-2-jolsa@kernel.org>
 <20250520084845.6388479dd18658d2c2598953@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520084845.6388479dd18658d2c2598953@kernel.org>

On Tue, May 20, 2025 at 08:48:45AM +0900, Masami Hiramatsu wrote:
> On Thu, 15 May 2025 14:10:58 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Currently unapply_uprobe takes mmap_read_lock, but it might call
> > remove_breakpoint which eventually changes user pages.
> > 
> > Current code writes either breakpoint or original instruction, so
> > it can probably go away with that, but with the upcoming change that
> > writes multiple instructions on the probed address we need to ensure
> > that any update to mm's pages is exclusive.
> > 
> 
> So, this is a bugfix, right?

nope, the current code is fine (I think), but the new code needs to go
through 2 separate instructions changes and we determine the state of
optimization based on the instruction we find, so we need to be sure
there's only one thread inside remove_breakpoint call

jirka

> 
> Thanks,
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 84ee7b590861..257581432cd8 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -483,7 +483,7 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
> >   * @opcode_vaddr: the virtual address to store the opcode.
> >   * @opcode: opcode to be written at @opcode_vaddr.
> >   *
> > - * Called with mm->mmap_lock held for read or write.
> > + * Called with mm->mmap_lock held for write.
> >   * Return 0 (success) or a negative errno.
> >   */
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > @@ -1464,7 +1464,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
> >  	struct vm_area_struct *vma;
> >  	int err = 0;
> >  
> > -	mmap_read_lock(mm);
> > +	mmap_write_lock(mm);
> >  	for_each_vma(vmi, vma) {
> >  		unsigned long vaddr;
> >  		loff_t offset;
> > @@ -1481,7 +1481,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
> >  		vaddr = offset_to_vaddr(vma, uprobe->offset);
> >  		err |= remove_breakpoint(uprobe, vma, vaddr);
> >  	}
> > -	mmap_read_unlock(mm);
> > +	mmap_write_unlock(mm);
> >  
> >  	return err;
> >  }
> > -- 
> > 2.49.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

