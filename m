Return-Path: <bpf+bounces-41550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E84998178
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4851F20F44
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846431C0DE1;
	Thu, 10 Oct 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gklgb7b3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684A1BDABE;
	Thu, 10 Oct 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550836; cv=none; b=Fvp4KckjD+qyWidsVp5VzgxsPCMGAWJ6XnoBWEIAhpedLfJ8MZX2805f0UTibZaA2vuo9aYhqUzc+rTAfSa8ajgy+sKtgFgO2pEvZCNqDc7Ava1JaPpFU5O1lRsykV3Z7nyBCi9/soPyvQGp50SMCePQ3dPhy396Fim328WPoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550836; c=relaxed/simple;
	bh=Fia6irOv3VDqu6NKzoWzAVMngAe0tifmHNg6sodLiE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZSv08CuMgSjYb6xsm441lBpsXxNZwhcqdusuRP2bLgj9mZu/KWfFSDfg4rrWLA/lNdM2HY41gpOyRTFM2r7g4Cd+9TN56R6kFucCfRfN+9p82o73RSPl0u76S0z7HHpbFZ09gpKa+4Nqtc0LHxEVdyx9pV7iwhc4XpH/p/n1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gklgb7b3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9950d27234so98445766b.1;
        Thu, 10 Oct 2024 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550833; x=1729155633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LR1M84LN52X4U6RwSoUyMMdQCDpU64S8085SG37H4l0=;
        b=gklgb7b3bIW9ZcLdzlxtFhKfkoff361CW8EqZifsla6BwyuwMgUUqrJY5JmP/bmdts
         9Bs0OZLe3NVF1bkU6HDDeq4mFt2pnTOSijDFKtLrIOy51HogKzHNM8u7r58h9JvdqPsp
         IdxfuqFPzmxUiRrXNlkFiyTdPbgFPXfj40PtYMlh6jX/nevOU8C/w1otkcRRx26Cb3B8
         tvtQ3I+ul2v7UQlkleFK3qu0jXgVXR1FVPpUK8uj16xz5u8+LzCMgJ3RU9D/dZvmOqE8
         mVigClfpZSjbf5QdoGFfVkX6SklUt6KQ63jLqEI8N233CO7cA8y97yZ4oBisjrt/mXB9
         o9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550833; x=1729155633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR1M84LN52X4U6RwSoUyMMdQCDpU64S8085SG37H4l0=;
        b=TALk1RHEJX/Mf1oSUMHKfEt8hmgkYuqaA6fmRbImkekzFVYjOek1qbotdS5LHhYoUg
         l5811RDrKSYP6+a9AAUi9wq2oGu0Q0y+iVEykMx4/9dGwDNzIkzPaAqUy1B8favZmGIB
         QcNmg3Kv1rFC6SWeh1pe6DNjqUMD5qiYbjfwqU9SdLrCPZdU8nFxqRfT9LPloh0sCO39
         DwtycCQjxDDqPYE70jMAl3Eciduz2sENOS/+F83xpsKh7xllB+m3rLvm5F+w8hwHYGNg
         Ugm6iA2Xq+97QCb6wVgrB6JpBRBBRytRm1XsDzj5aYEgsJIiHmJ3dvCHUsWKK7dsZlsO
         l7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBCGoNCNH4MMzNA1i2qXRb2Ib4F18R+fDbqMITKTwXj6YUw+WxF6C0zHBJNp4qZq2VAbynrlcuVhsPhXPT@vger.kernel.org, AJvYcCXX5aEzE8eip2gE/ffaMfU3Z5/Sn+W1Qfpch7SG6JQ8/wCxoma8xOtNyuzYZ7LvwQ/PhFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7CG6Om0F2E4K501ONagNxgiGYcuj0UoTfVYnuT47eTP6HEce
	VwHgxV64xJsadA+3TYHyzmGtd5AMk3xGI1B6rRpvH2l8OCfGcHQbXTmRgnQ1
X-Google-Smtp-Source: AGHT+IF62mHBJEn1yNrnGwuST05IG0cpzQ2jrDUA/Rm0x0nY9OWDv9BbdP/KHA+6UgUPaFphRnkm2g==
X-Received: by 2002:a17:907:7da0:b0:a86:a481:248c with SMTP id a640c23a62f3a-a998d197379mr413059766b.19.1728550832509;
        Thu, 10 Oct 2024 02:00:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f266e8sm58844466b.63.2024.10.10.02.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:00:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 10 Oct 2024 11:00:30 +0200
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZweXrhopOmEb9rMx@krava>
References: <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
 <ZsRtOzhicxAhkmoN@krava>
 <20240820110507.2ba3d541@gandalf.local.home>
 <Zv11JnaQIlV8BCnB@krava>
 <Zwbqhkd2Hneftw5F@krava>
 <20241010003331.gsanhvqyl5g2kgiq@treble.attlocal.net>
 <20241009205647.1be1d489@gandalf.local.home>
 <20241009205750.43be92ad@gandalf.local.home>
 <20241010031727.zizrnubjrb25w4ex@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010031727.zizrnubjrb25w4ex@treble.attlocal.net>

On Wed, Oct 09, 2024 at 08:17:27PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 09, 2024 at 08:57:50PM -0400, Steven Rostedt wrote:
> > On Wed, 9 Oct 2024 20:56:47 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I was thinking if something like objtool (could be something else that can
> > > read the executable code) and know of where functions are. It could just
> > > see if anything tests rdi, rsi, rdx, rcx, r8 or r9 (or their 32 bit
> > > alternatives) for NULL before using or setting it.
> > > 
> > > If it does, then we know that one of the arguments could possibly be NULL.
> > 
> > Oh, and it only needs to look at functions that are named:
> > 
> >   trace_event_raw_event_*()
> 
> Unfortunately it's not that simple, the args could be moved around to
> other registers.  And objtool doesn't have an emulator.
> 
> Also it's not clear how that would deal with >6 args, or IS_ERR() as
> Jirka pointed out upthread.

another complication might be that the code in tracepoint's fast assign
can potentially call global function (?), that could do the argument NULL
check and we won't have its code at objtool invocation time

jirka

