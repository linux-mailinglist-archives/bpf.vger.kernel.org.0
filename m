Return-Path: <bpf+bounces-47676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21569FD6D3
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E423163C86
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8051F892C;
	Fri, 27 Dec 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FvRlaoBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD211F8692
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323001; cv=none; b=Noei9upyEk+vd6lxVwXmQdlg6KBJNiCBlwyYewqkjDlDP6UeaJfH2gvaHdL2RCTdCj3+1kDYRe/qG+oZiXk63aVSXTkHMl/0dpf4utfIYjuoEg5arhJ0S+615tnlei+j6keocQFPkjVg+gdbT/pBRiRxJllcjYDRiZJbRReh1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323001; c=relaxed/simple;
	bh=lIgCGRIjaCWKrn+E11kdlmQyFebXDmv69x2tOk205hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxA4oO9J+a4+ctSw8qkQIVHkesL6L0xM6fwfenLgyD3Nq3SOdo99Ky3ZeSfMllg1mckoAeUhoeQAZkpuo6o3xwfCtyQZTeYa7BW/JcRV+pcm7K9c6c1AsFvnnzTfAptb5R8jAEKZal5hZqNtS7RKudH7uONZtKee6MLnOzKSkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FvRlaoBY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso1261111266b.2
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735322998; x=1735927798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yX3BV4MQOHPYJPObPt8JUHeYgGfsYXEGdeuM95hlgDk=;
        b=FvRlaoBYHpGIMtjx/Ax11oZir09L47Uw7fdI/RwdX1NCjFJ/m4ASkS/skmP5OkkKQP
         q3xLavUXppaNxzIrjDMkGjR8L1LX4lIkdYd3WHdswXJf/XhQyXxJ0q7qc9btvrVUTk0C
         eGABU3PDiEp6DaeD5U+BwbrPFw/3MrcjKeImE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735322998; x=1735927798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yX3BV4MQOHPYJPObPt8JUHeYgGfsYXEGdeuM95hlgDk=;
        b=fVHUTSs3RvQKTJiA20pN7pjS3TMZcf7nGWkWPRkodPbaYv1+rihq2Lld8xh1+Plugc
         XQenDk9sOfYessHMjlj7dIHK4auozBOA3l2l7qMzwKfSJmrh97Rk1Ig5UO4ziHT4TNdl
         6GnVel3FMDqxzZElayURVrURyl1wXr95eqgrmiDQOqGj9XovT1PcVfddiD1o9imnfByq
         caNp52tYgSf9CI4pHRzfN1e9i+xwpAuqRXop2l4fhgJi7JvSPZUATTgeYlfPSvGiuXCz
         jQUECnlXhGwQYRcK7b+uwKdZAiLrt2hfFsWTW4aTxoXY1YQJKWY7KGUJDh9pUdz/JIeJ
         iN5w==
X-Forwarded-Encrypted: i=1; AJvYcCVWjrWRVVO8ipkwqG/RA4XBhhnNXOlcPCVKRaoXXDz/m45qtCQsZALSu948C5RmRR+hdQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM95CNYNq4BSp4gaPsnMOGNpvLHuO+bQkakT9zTfLqjwmZyV2C
	pO/IRK48gvvO3LZ6S/ApDAij028Ca+uZpNzhfldXiKDnD0z5l3WCmPid4uFPDo3UbuO9JBmd2NN
	R6m+uiA==
X-Gm-Gg: ASbGncsAGv+kDdRzjwAQ2j4Fpslwzsfh+Dfn7K+6M9JSEwiVIdi00usRwGin6oqioLB
	LKdy0vs8SZx0Qv5zeuj7dbsaBFHEyqc+LpkxDUxJtyYCrdAPPSU3qwoLuok/am8OLhn41E4uXdu
	WJCUb4AJt5YXm627pwyuwNS4KMLH0Aw/cXRCVj4Pzqy6SKSNkxep7BolbOdcXgAZBDuszKrvkvS
	RhXCQOuKUBgP+shBNhkqNnsmcEPnafDxhuNU8SX58dWeRfRZ9tJf+NXVkIR3NE8Vo4G10kSw5us
	F7bjVdOcWGDXjckrZ0i7m/Gbs55KKss=
X-Google-Smtp-Source: AGHT+IE7cNKIVm53eY8HQXY5zmfLFWXwIh1/2ERmYD5WEv+3j7nUK+GZR7QDv3dOUpDNOtkWM/3wBw==
X-Received: by 2002:a17:907:7f22:b0:aa6:7c36:3423 with SMTP id a640c23a62f3a-aac2d4472f0mr2383099566b.1.1735322998005;
        Fri, 27 Dec 2024 10:09:58 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4184sm1137548866b.119.2024.12.27.10.09.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 10:09:57 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa69077b93fso1076819866b.0
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 10:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPoWtty4mnovptGKvgVgYhUPt5tNNNaNdPN9OmrTemHBGFGGdG0HwHEgFY3CTCbczujcE=@vger.kernel.org
X-Received: by 2002:a17:907:9812:b0:aa6:738c:2ddc with SMTP id
 a640c23a62f3a-aac2d4472bamr2701724166b.4.1735322996702; Fri, 27 Dec 2024
 10:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
 <20241226224521.2d159a02@batman.local.home>
In-Reply-To: <20241226224521.2d159a02@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Dec 2024 10:09:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
Message-ID: <CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 19:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >
> > Btw, does this actually happen when the compiler does the mcount thing for us?
>
> Yes.

Ok, that's actually good.

I'm not really worried about the "unused symbols aren't in kallsyms"
issue, even if it confuses the mcount logic. THAT confusion is easy to
deal with by either adding symbol size information (which I think
would be a good thing in general, although perhaps not worth it).

Even without the symbol size, the mcount issue can be dealt with by
just knowing that the mcount location has to be at the very beginning
of the function and just taking the offset - that we already do have -
into account.

I was more worried that there might also be some much deeper confusion
with the linker actually garbage collecting the unused weak function
code away, and now an unused symbol that kallsyms doesn't know about
wouldn't just have an unexpected mcount pointer to it, but the mcount
pointer would actually be stale and point to some unrelated code.

So as long as *that* isn't what is happening, this all seems fairly benign.

               Linus

