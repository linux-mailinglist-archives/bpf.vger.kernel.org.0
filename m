Return-Path: <bpf+bounces-56834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D14A9EEA4
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68ED7A538F
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C4262FED;
	Mon, 28 Apr 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfbYl1u8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79538F9C;
	Mon, 28 Apr 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838678; cv=none; b=PUZzb+3/rPNTdCGK2udwR3AAh0a5uR48PSGEP1VwATEm7hS0NTIBuNhGE1sqQA7K1o3Pe3pluDd9pJz4PEtbQsVH1iucwZFQGxw3mlJZB9FLRwFOyHxNkMhRXEiRq33Bw7J17MH5RexdXxy150hoGhKMeuXKpC0ZZQbTFCHFVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838678; c=relaxed/simple;
	bh=ya758ZWdrlfF0MXIIyijqnANJPeLkKx1Qs1taaDd8Ps=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdw3eQVftpP5bJQ4le17riAtokX0p4oWKkat1xia+duyDYpbb7y9oSGA2fWIvCJfQK3xFLtQOeqs7fUfBN+uzDDERjJdgurz2U9J9cm/1voXysDH5lonyeHkssdE0FhnvSfFRKvWpxhxGA8XCLVSEJW53R+DXCWJAJcoMCuL+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfbYl1u8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb5ec407b1so764273966b.1;
        Mon, 28 Apr 2025 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745838675; x=1746443475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxwsILxiYRvwgdcm5gcrIrdErYNKCXrz6yyo8LoOi8Q=;
        b=gfbYl1u89spcw8t5aJvzLJQRn311MxdJXIzmtZ3LbCjuPiUQ8mwI0p2IjlYn2rmNhi
         /peJTFgg7u++gl6GRnLBG0AgMoYMfQwSPi7Y+0ejnkZdkZ4mhCGkH7YSerBG/pPhSI3t
         KVYsR+rqyR+m7T8+4SMXaf8FjeEfZETmPRkPg3j0o+6GA2AibtSsXj7B0WTzmGBlNvZu
         yQk0JCcB84cMT409O+AVoLUveUB1jc1BEzJvx6bG5cY2lkyRFNWDj2YfLy6QxmvyOZ0p
         Wqt8sUAWFUEgzwmFzSpKZDGDDqiCfMGP/0dT6e4MjlT0jlzNv4HbUA3YWU43qw05wGAG
         rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745838675; x=1746443475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxwsILxiYRvwgdcm5gcrIrdErYNKCXrz6yyo8LoOi8Q=;
        b=U0mZr6gk34kMd+uKQPKLMgBI6mKtjBEu4202/YWimf2dUs0uW1R1PKLcYZAh9tEwB3
         CKWYLFjgHMyjq1xuRSHDMA2WzEBNScPZ8GNBtWh9Xj9cRcJ8529lkdzGpWSol01FXCcC
         wiOBJggLbops3/Qr8nyjSu2Z9mlk054/f8TvPp4NTAP2d9NDXu3lLkdhQCF97+8N8LOq
         eTBhlnVzJM222grshUxLUoHumcAoNGulyAfaAL9EXJele0PV3fFzRN7eY2iHQ7NNasFZ
         /BHds6eWqziLdUIdT9HkECSnNT9H0xsoCykgGVMOx2y4fFnq+2UJBYL13o9jqWPaRESk
         LAXg==
X-Forwarded-Encrypted: i=1; AJvYcCV/KO7t89b5QxHgLOdZyI16ZIo+KvPVAt14vY2tte4zVWmCkdHeQAo6AtSY1bXJMxexxYDewuMqb5IlbXNj@vger.kernel.org, AJvYcCWT+pHjqzO7vtVECKJrvrn9oP6uvQAeUGxTC6VQ4B8rR6y22TqDKAwjqVJJxD5Xm4PSLP8=@vger.kernel.org, AJvYcCXfk4MoJrzEnMp3QdjdpVV5TUN++icIQON8HN885ZEexbWCY+FzFgn89S3NOFLxYEJ8vjQ1iKKCztEAIUCzQZBi6Oh5@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmwK8/caKNBxg0U/Zyz82nSkBXrPR/kDX3RKigrx9dMbvycpU
	v+g9B3pfNZ2o4GEHO43bVZ37JWAGbQRyBnSGI8dPPG+FYa5B1R8X
X-Gm-Gg: ASbGnct3R8P/r5sTCdoyxhA5b9BPesY4wluLNQTIFHhSdNlJFAWaW3WwpUSeIRIxSE/
	wkF4aCPZJ7H17fX7B/r0nHO/6HO/j1VGJs+d/1JGvo1Fqcm2imVhXRDjK5L69tV41XpVIN2VgAf
	mMFqEyn8CHOdf56CUY1G0F3d2mWqhYgX5vNJC5KFJQ0H99AGgakdIKc7ILconfDw0ML12tHKii6
	RXrduJKS1HP2yvU0XFFoedJXGWtwnmouNogGTcwuMZCSw3gsRFS8REKlrkHT3Yf/nYMMLVV14ua
	iQgOQkL6ueTKeXCvL+TgoEWOogA=
X-Google-Smtp-Source: AGHT+IFhEPkmm9QV39yT7PwGUYrcLhyifatGwU1Z8qAoge6/anjqIKn++nprL27Dbet9RM6guC4rwA==
X-Received: by 2002:a17:907:3e95:b0:ac3:ccf7:3a11 with SMTP id a640c23a62f3a-ace84a91569mr649620866b.44.1745838674606;
        Mon, 28 Apr 2025 04:11:14 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbc3sm609170966b.3.2025.04.28.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:11:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 13:11:12 +0200
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
Subject: Re: [PATCH perf/core 07/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <aA9iUIsdiWfrFcRR@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-8-jolsa@kernel.org>
 <20250427142400.GB9350@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427142400.GB9350@redhat.com>

On Sun, Apr 27, 2025 at 04:24:01PM +0200, Oleg Nesterov wrote:
> On 04/21, Jiri Olsa wrote:
> >
> > @@ -1483,7 +1483,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
> >  	struct vm_area_struct *vma;
> >  	int err = 0;
> >
> > -	mmap_read_lock(mm);
> > +	mmap_write_lock(mm);
> 
> So uprobe_write_opcode() is always called under down_write(), right?
> Then this
> 
> 	* Called with mm->mmap_lock held for read or write.
> 
> comment should be probably updated.

yes

> 
> And perhaps the comment above mmap_write_lock() in register_for_each_vma()
> should be updated too... or even removed.

hum, not sure now how it's related to this change, but will stare at it bit more

thanks,
jirka

