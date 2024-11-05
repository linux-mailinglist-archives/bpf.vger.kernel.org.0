Return-Path: <bpf+bounces-44054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DB9BD265
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E361C22477
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A891D9593;
	Tue,  5 Nov 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/99tZJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C93154BEE;
	Tue,  5 Nov 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824420; cv=none; b=SDryPdDd5JzaVoIjFm//XS6SCzjYKDh9iI6mh4n3fL0TAD8JY+F5QV3CHJqnhNisCb22HX15KA4s13PM1R0XgpDsnsRmnZOFwtU+eXXL0RPuk3Qlg8MiGuqtf0kWVUdAZw80mUyfeMZwnI72XN0/b2pBZZCOB7vZ7kPC5bA/W94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824420; c=relaxed/simple;
	bh=e8ydJsSQVkCMor4CLHMMlutxKMHjkhjv/e7qeQTxy5A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7WLIbNKOWyzbDGVy9GE2B7F5Vd5sbHN60NmXfUcSMHu6pZex6tcW32Fmfnd5+5dWJBhcx/OUz19svPGh8THc/c+PoRzU6pusUFqEdpAgiDUgo1MP0scy0k5kZgo1JuHERvue6Zo0y8F3qsjjq5KCTbHEHKBtxlDbEvRUo6vbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/99tZJZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso907988066b.0;
        Tue, 05 Nov 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730824417; x=1731429217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+7jwShemxXrn0wBgFQNrN/vkLYBEWF7jfE9Vx4ANCo=;
        b=X/99tZJZfiRB7YWVaxSFSBCIm3WUx6QvIyTnX4iHvPlNzGInIQyDf3Jcrs/lhw4ckB
         k6ZJcYu8vDKhCSzloUHVAMzy4VgIPaanHPTf4yrvWfoJmJg480zYYgSE1U28n3Dk9pzE
         /2aYGCvP7H3imFUKVuCb3Jvv0aCgEk60dSzeF51HkJyVHpSD1oJ/haGz49WmmICgZqGy
         +moPrFxe94LUOo9c5Ty6qwX1szPrMy1Bu23ds8/1uOxuzXKs2N1eYeEdCp8mro2ild2S
         JAVli5EultyiTf5bIcbEFUiTcQfGwEWRez1gKzuJc8ZrkPoa1W9lTsH7RBoaTdJDfNOj
         kJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824417; x=1731429217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+7jwShemxXrn0wBgFQNrN/vkLYBEWF7jfE9Vx4ANCo=;
        b=vx/jN/zpiq5pPhd5NLRmiIBW4glzaSXJW9Z20ZxxJ7b6liJfyapofYY8iS2t2Gnyw/
         q5zAA/9MlymCVc9qnOQHbQXoDqvdajS0hEKiy2/IGz3YMVolVJQu5shef1bOqmPuLLcl
         fB/O4oir0umOZiPeQ8/kZA8rbm9bBD2Fca85TDOHXRLR4h7idftDEk7uMVSwUh269KhZ
         HqG8lQd5YtHrccUXlPXH8/0mBiVchcWdDeaJdWyQjoO5jI3qbNwTKqHKyjlC6l/T70fQ
         am9UdgzLgP8FqokFHAPjAkeR8J4Nr7SlgJLJ8xwh9eHVGDnSOh+wYXT9MJ/H4t0pvwsv
         GnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/GLnfR8O1CnzPeJSUX/M/1RicGsDjWT9TfYXnmWCKUad1sIaKnlITdTDy34dx2SeuuN0=@vger.kernel.org, AJvYcCUgAtHAHIzZePu0c2ecC5hFvTdbmm9PJfRPrLIu1MwGQQ8X2Q8y1PCeCZE74WwxmQdoj+l/G8lbQ9k4ZOL+SWZg0KE0@vger.kernel.org, AJvYcCVjoExvVaO2rIUmHgYVpiPV3LezKHS1qL5MZRO42yLLXnbppJL9o1dM5qgTQ06i0IRZ08rr8o7UBMK46/Dc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Y02hTeXkwMICR+jiLo0ts27KIjE+4LJQKruk+GzV3i8ycgdo
	B2umsOSZ5CKJpxu+UoJTE7cr0NEExlhAVeL3W9W1UPwwN3tdr0imRmbQtA==
X-Google-Smtp-Source: AGHT+IGEerYT0hrVkPztESQDry8qyqE7d8A+Tx+rk/wMrgU+w7KuLoOMwujLEnSLX9uC2sC/o9IlsQ==
X-Received: by 2002:a17:906:da89:b0:a99:43b2:417e with SMTP id a640c23a62f3a-a9de61a2e85mr3533011166b.62.1730824416441;
        Tue, 05 Nov 2024 08:33:36 -0800 (PST)
Received: from krava (85-193-35-83.rib.o2.cz. [85.193.35.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d667fsm158531566b.61.2024.11.05.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:33:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Nov 2024 17:33:34 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <ZypI3n-2wbS3_w5p@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105142327.GF10375@noisy.programming.kicks-ass.net>

On Tue, Nov 05, 2024 at 03:23:27PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 02:33:59PM +0100, Jiri Olsa wrote:
> > Adding interface to add special mapping for user space page that will be
> > used as place holder for uprobe trampoline in following changes.
> > 
> > The get_tramp_area(vaddr) function either finds 'callable' page or create
> > new one.  The 'callable' means it's reachable by call instruction (from
> > vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
> > function.
> > 
> > The put_tramp_area function either drops refcount or destroys the special
> > mapping and all the maps are clean up when the process goes down.
> 
> In another thread somewhere, Andrii mentioned that Meta has executables
> with more than 4G of .text. This isn't going to work for them, is it?
> 

not if you can't reach the trampoline from the probed address

jirka

