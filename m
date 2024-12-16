Return-Path: <bpf+bounces-47029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBB9F2B87
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FAB1887A29
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77DD1FF7C5;
	Mon, 16 Dec 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw6CVlr4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9931CEAD5;
	Mon, 16 Dec 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336543; cv=none; b=TfZIVugABoFTaQ+xssx57I+YHo2Sr/YYNgXN4GfS/hAtr1zaX6Dr/agjIm2zPLFrAx82GrDvKVL2lg4yQQAj+aMUh6UdQMpr0k5GGhVRl/WamFtDpODt7nS1KpgEOIjH6lwssG7r63F7+Ta3xqtgzJ4Ku5YRLJ1FY6Vc+AK21dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336543; c=relaxed/simple;
	bh=yfDdcBAeRRSm9eT0WfpTgZrtlz0BHwuzU6jR8JAIMZg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhDmn+Bdth6pecYW+CVA17vW9nMEKwtITCuMkzppNtcJ4IFi8zI/01sK6N8il52TpL6l4g+8z7hZm82YWfKPBfWhWQ7FZ4k2VDYOw6XkwKMmnDM/qWElyv+5evvp5qcVS0S983dEflk0bKKJl7JUnPGtRHnmqCz/XYPsYigasmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw6CVlr4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6a92f863cso762336766b.1;
        Mon, 16 Dec 2024 00:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734336540; x=1734941340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=la5JQYoouqTj/QhbRjkxnmYrbjj3uj5kdFNDL0rgwbE=;
        b=Qw6CVlr4wd4cDczb5PqLGQRUC4HDwioAIwl00tJgNrir1iRu0VEPhUkV1lfTLuUPlx
         yD/5CDg9NI1fOo15ArfWTEBxBjY4sllL5AfJ+xRlRkwE1fVs3DDori6dqZ9qUJmCuAO9
         EFVzWmIX7S+8JtX0dP41xzDe1UJ7amUe0vYh+RhN2Li8J70wp9wsfTQXEGyXLP/YAkk0
         fRRwwRImT8HtxT94vK34BHfQ6c0AIafpU5iJvdUBfy8qMg0AYz59QDKwcbvsAdLJyL0/
         4/S2rPAykDAp0x71RnMXSAdDvoIgDbx+uFn5Dos5xyd1YEUe8srXvzKkMHWAeyszqoHR
         p2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336540; x=1734941340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la5JQYoouqTj/QhbRjkxnmYrbjj3uj5kdFNDL0rgwbE=;
        b=lwsfOr2IyE8v2vgVIrLdAxz/1d1Nt28aXSNVJekqOjTfdqmghqiPunyid9VQ2NGpA3
         5LcuJ/cheJS8eByLJgsRP9e0DrByGQ4dG/UP2OEl6E2J1f0no1Wa3GR5dK2uPpOiKgbr
         slVrvfOPn7DfWkFa8gGRtnaUjKsVhwURoaqAWqSIrTebv7xaWtCndiS6wAUvuzjzg5Am
         imIrWjqwMZws92NEXngF08Le86vVn2sC00I5qqXc9+o7VpAzSehZyME/T9LP97poSk38
         YoaTamvwGNGZrlSDexdIzZ19JueGx/HYjFRkN2Re62/rfpBPCSlRsqYIAY8h3+fvaETp
         YhAA==
X-Forwarded-Encrypted: i=1; AJvYcCUhNoCkZLF5xqE8aeCjZthqMTB9mjEY/l+24veGeufml8D1DkRjBSdGC7ta6M6l/mNYNoq8zPi/ExqY44NeLTvfDdbJ@vger.kernel.org, AJvYcCUsmrWMPDj/QX5NSKNk5Sve4b8CGUKIIgkcwzsxg0vxADSWNe6QRn8OnRAYPVGkLoTAPiM=@vger.kernel.org, AJvYcCWFSmIXkbDo6hZiL+XeofeHUx3y1RBrv42OoL262/HNSLgx0MrzIGnJNoocLNNwOMUKr2GqvdVL3nKSDwRK@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKcOYh0g9K1ipemkqvfOzrwl8aYM/rI/emq1qUYcqnAOm06jY
	YdUjLtzMe8FIlA/3+QlgSzfbg7/7Eoi3J9I9mE61pscPOQQuAAbn
X-Gm-Gg: ASbGnctmgtrzVMDQNLgbLNQslnJu8+Zro45Ht5xG+x1jwCxdQL8ZaQZjBZAr1fRoHn5
	2HLBEFsAbCCSRNbvjz7HNT5MuIif8NfxBvPC9nYwD4T/7sp7nTIAaonQ41cTW3PfRug56lBfxpz
	MvsvGyTLV1eCAc4OJzn0nv7yEO4XraEemxtHWnLMdKlLUxEKlbJKrDGPBSR8EwMO1rL3KC/SOpo
	QQQQ8KYHzuaLquZrAcruy3WAtryDuTwX3DIkfI3I04cPMVyjAukiG15EIYNVQT/lRrOHUBUGT0p
	52vvsMEs0SItFGzc/1qi/ce1UDelnQ==
X-Google-Smtp-Source: AGHT+IHHB6p/R/tUA0e/WmZPxGfQa4xzKgIcuPRBffN6DrLrY+lZW8xSLwT97paxihDtkmS/EIEfBg==
X-Received: by 2002:a17:906:3092:b0:aa6:25c6:d94f with SMTP id a640c23a62f3a-aab779ab523mr1040071166b.31.1734336539698;
        Mon, 16 Dec 2024 00:08:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9600628asm303418566b.20.2024.12.16.00.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:08:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 09:08:55 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Laight <David.Laight@aculab.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <Z1_gFymfO3sAwhiY@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215141412.GA13580@redhat.com>

On Sun, Dec 15, 2024 at 03:14:13PM +0100, Oleg Nesterov wrote:
> On 12/15, David Laight wrote:
> >
> > From: Jiri Olsa
> > > The optimized uprobe path
> > >
> > >   - checks the original instruction is 5-byte nop (plus other checks)
> > >   - adds (or uses existing) user space trampoline and overwrites original
> > >     instruction (5-byte nop) with call to user space trampoline
> > >   - the user space trampoline executes uprobe syscall that calls related uprobe
> > >     consumers
> > >   - trampoline returns back to next instruction
> > ...
> >
> > How on earth can you safely overwrite a randomly aligned 5 byte instruction
> > that might be being prefetched and executed by another thread of the
> > same process.
> 
> uprobe_write_opcode() doesn't overwrite the instruction in place.
> 
> It creates the new page with the same content, overwrites the probed insn in
> that page, then calls __replace_page().

tbh I wasn't completely sure about that as well, I added selftest
in patch #11 trying to hit the issue you described and it seems to
work ok

jirka

