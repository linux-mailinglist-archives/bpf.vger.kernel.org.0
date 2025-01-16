Return-Path: <bpf+bounces-49045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B62A13960
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 12:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48E0168A54
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A891DE3C5;
	Thu, 16 Jan 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOeQbs4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DC24A7C2;
	Thu, 16 Jan 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028117; cv=none; b=Ni1DiR1TCzLIiOGBQY0QNUgYf2wvkbtfyOBdlOlPgSeyIZwlWMqmS93ZLmpkYdFCZRN8WUaeyHxIme849urb6C6gBIRNRlDISqHbS0yR2E+0np0McMGhI6xI+DlpgJNkeomwypV1/Rik20AuIyd0sdJTE3S7prPu/H+c39zVLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028117; c=relaxed/simple;
	bh=HJzh5eLYCv8EJJgmVTMsiQgqHdac+IUf/vJRGhPT/Ow=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuM6iNrNzAO+CLHlQZ4zqrV+DKH/fjKP3nbJCTtCyKqWL91WFPIX0diq7sF9bU9ji6UZ0mIxpQD5Z/piTRj2l1xoPNZUzVnU+P4lSFKKjal2x2r9wG7bN87fVCdYnUp2AFAanNfh60RblNmDFt0IKuGDJhokon+g0sJQo3Vnu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOeQbs4h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso11894295e9.0;
        Thu, 16 Jan 2025 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737028114; x=1737632914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EPZnBUtvS/OYO7Vs8h8x8FOhvEvG+0Oo/UW/4x38QI=;
        b=eOeQbs4hiy3GrGXkcko1Mbor6cZOmgmxA5WEtKB7aFtJpXzj7OWxuduP/jxYYHfzRR
         VtzfHyw4NOR/kHkImZJO5H9D5FH01O8ttBXU5yAVmyG42277V9ydHKRgexB82D03K7nJ
         Hcn8EjCzHPr1vsNkN/HlYRy4G3XycozVzfki6IsN2VAfbsGkbLzsvQNVXxp0T0dN7Z9j
         rcDNTmgYdjpmMt87y0pc/CA/MBhze69SpVN4AFvCFP7RYbhe2qlVaYBnPe+75XAer0jP
         uXJ/ZJYyuGZH4JUTIiLiFG8B9X00eYEWR762f8D4aRy2p7WKIzSzYAH70MNJu++mGxpw
         511g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737028114; x=1737632914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EPZnBUtvS/OYO7Vs8h8x8FOhvEvG+0Oo/UW/4x38QI=;
        b=rc/69aRYqaF5WFIY0CTfv7n6pZvsUzvmrjGYv83hKZaEGEWAJmM4BFnWCR5Y//Y7Xm
         T1KKB+0/Ph/fK+z+kIK1qLhSz5U76YGDQc3AsppE9unOOabRPUDRC6VyC5TNCexbZ6VH
         LrIvCumNDO4MThRnpftDK5P+dODfld6BxCctQIzOJwDuXkMWPqJ2m2Aq+XWTg1T8B4pZ
         DJNgraRH3NmlEs0bjvVe8AIR/CUkTGhIYlQjd4PyKHUcp2Nt351AZEYvoF5PbeQS6+Sb
         TzR76XKAbqEjzP2qTU8Izx8DsL18rnaZr8/Ziqk37SOvDZ8UF+dODpBFdsOl03Kv+APw
         BscQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ499TpQuxVpIlk/H0nYjlUbt4s2EVHeotTazq1lkx+X1665aFeJ49x8zbHYpyjE0JE6ur6MswYXkgsPc/Xv2+3EzN@vger.kernel.org, AJvYcCXNIgkVzInAwN2v8ha6fgNQYZQZyAD0MCRaHe/ulK+l52aLyRl0K6aJl9kw20hoZ/Su5CbypxQxBjTpmvlG@vger.kernel.org, AJvYcCXix7BpiC0Y/4JmzPk+5sq5EmOydEssXjb3jkto7W2sy1696VLE6g1oWZlsyF2rSQMKD+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gyXcUpnYUSP6lIbBT42QIhD9N/u7wC3v9DVofI/7WMjlNZKs
	BMvfi3jifK2mhkj11PiE3kGyGSn2tD96S+ie3S6xY3Df5Cm8dxQwFw+TYg==
X-Gm-Gg: ASbGncv4P5puPc82U/+WHTGxnbMWWx8qXGjYfsL3MwwuqcSVRqU6lJFgUbdWN6eWepZ
	OG5UaRBmYqRL9vt6VYwXnQQlhf301JxENwIzni+K0easHrz03J7OiMYAi0WWLNW5fwRHqW98tC1
	4CtAdp7unyDRVdZLxQwXyj3OawJvYbzO+FsS8/81CXKF+nDGQ/GGSvVzj/2CVLzrzpDg+O+QUIX
	5LkJMONVgUnqHqOKn0fsE7lFz6/5kjYVCwkAZI3kkY=
X-Google-Smtp-Source: AGHT+IEkVAIA+sDM935/MFzAgL6IUhxWzJiTMKcSNJzf8RYXLXA5lacmebdk4RcP/RK9qsmIXTWdVA==
X-Received: by 2002:a5d:648c:0:b0:38a:906e:16c3 with SMTP id ffacd0b85a97d-38bec4fbceemr2364082f8f.13.1737028113971;
        Thu, 16 Jan 2025 03:48:33 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d154sm20691803f8f.10.2025.01.16.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:48:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 16 Jan 2025 12:48:32 +0100
To: David Laight <David.Laight@aculab.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC] x86/alternatives: Merge first and second step in
 text_poke_bp_batch
Message-ID: <Z4jyEBf5WIvygWYh@krava>
References: <20250114140237.3506624-1-jolsa@kernel.org>
 <c88cf8951a0d4f73901ba97a81ba3a12@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88cf8951a0d4f73901ba97a81ba3a12@AcuMS.aculab.com>

On Tue, Jan 14, 2025 at 02:38:42PM +0000, David Laight wrote:
> From: Jiri Olsa
> > Sent: 14 January 2025 14:03
> > 
> > hi,
> > while checking on similar code for uprobes I was wondering if we
> > can merge first 2 steps of instruction update in text_poke_bp_batch
> > function.
> > 
> > Basically the first step now would be to write int3 byte together
> > with the rest of the bytes of the new instruction instead of doing
> > that separately. And the second step would be to overwrite int3
> > byte with first byte of the new instruction.
> > 
> > Would that work or do I miss some x86 detail that could lead to crash?
> 
> I suspect it will 'crash and burn'.
> 
> Consider what happens if there is a cache-line boundary in the
> middle of an instruction.
> (Actually an instruction fetch boundary will do.)
> 
> cpu0: reads the old instructions from the old cache line.
> cpu0: pipeline busy (or similar) so doesn't read the next cache line.
> cpu1: writes the new instructions.
> cpu0: reads the second cache line.
> 
> cpu0 now has a mix of the old and new instruction bytes.
> 
> Writing the int3 is safe - provided they don't return until
> all the patching is over.
> 
> But between writing the int3 (over the first opcode byte) and
> updating anything else I suspect you need something that does
> a complete synchronise between the cpu that discards any bytes
> in the decode pipeline as well as flushing the I-cache (etc).
> I suspect that requires an acked IPI.
> 
> Very long cpu stalls are easy to generate.
> Any read from PCIe will be slow (I've at fpga target that takes ~1us).
> You'd need to be unlucky to be patching an instruction while one
> was pending, but a DMA access might just be enough to cause grief.

ok, thanks for all the details,

jirka

