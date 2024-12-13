Return-Path: <bpf+bounces-46846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38FC9F0CFF
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36AD283318
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03431E0B7F;
	Fri, 13 Dec 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZrHexda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96341E0B67;
	Fri, 13 Dec 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095280; cv=none; b=o6DlCr7pcJdAntAwIWYiq3aAdMwzyXr2FYe7LYolhVGEjG1nQDwedk7nUw9jLBXWBWs6iwg8D1cZU3gzAmBBmhBiGjx0lhs/rkTTmyM6oGUBT/atRIiTDlY8PeGswNYnrx1uQxF3SzbJKxdDQEwAl/9ITbjgva/Lc+VzJ74t8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095280; c=relaxed/simple;
	bh=T2qbFS/VfyLNKut3R+kmJ10y9llOEamkGLxbu+C5gbU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB6A4MgltCV51fyLj1XImVfPawyXiqsKhYImEiWkP3z+ZmET74U3qJq661dNJA0H44jKm7gFcxZt6wSs/ftzE24ztAQV1EEJ4vWi3Gj7K0loe2YvbyovnnlbEYmErrmlF8iCITvwPzjpA4TMQGYrXdR8j4opwfPMYzN45XofcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZrHexda; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1317192f8f.1;
        Fri, 13 Dec 2024 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734095277; x=1734700077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pny43IjbXA+/wIRDe08ndy2RzpYe+YfTzRllKJrGWM=;
        b=IZrHexdalB1Z7rIs5RcE9QxoZ7i5Bjq/5MVTANfYViIDkLe7cm9gr+CZQFzthp1PRw
         i9bK7GsQXv9qoiMD7Wz5vRY+b12Oq73wA0fi7rBETFae3oiI9L5ObGTQUcVznezuv7rE
         68axRFwnxJS1sIHJ3yFhz9Rq3DIhrqxlGBKAAUD5G2EN7TVKUZUnLUeKzxXRGFjopIfS
         l6QhpBq4YIE25NSG0VIbD+uIIcLx6a9lrl3poPeg+8I1ERlcRYFelxnKhr2wr+8By9Gz
         9U3et2MzMCePIfKSHpc8y851Oh1H94tSwQ13JUDkbeIPTjicF6wJFzYXF8cnx0kPjsfS
         b/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095277; x=1734700077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pny43IjbXA+/wIRDe08ndy2RzpYe+YfTzRllKJrGWM=;
        b=vyW4rTPQgSTAWp0oNcXDnwE+tua5LluA32fzN1ZEjsW0VVgHx2VGzesEYEDXoh6vrT
         8Mqz8icSXM4aIuFAJYjJ758bE6F6bQVGp/b1efTr+MGlzcSFOzUqsCQDj6oL+T807woe
         zIqV1XAJVKmuTmFLBEq/ck9wtW2VA0iiVHX/Mym3cerW/pISn+Q07oyV1X4Ktg6o3K0M
         M07Pgd9YakLCg3kYy0q4XQxoQVv2Rk0UMaXir43SELnhXKQD11Gv26zrmsw+EfsgmSrp
         w+Fqyq8GnH/mdJtO8rskQLKQn5Ozff0t54JOAmAxsTShOAD4IfXzNl+v+QxruOZPzk2H
         /rog==
X-Forwarded-Encrypted: i=1; AJvYcCUKrIAeYVGhGxY+qHIwGxM1Rcm5YCtI5N3R0VUAMpdqejCdD3pK3/oGXjJQ2M0v4FJMbNZv8hJ5OSoGO3gjw97om4At@vger.kernel.org, AJvYcCUh3dEW4PkNsAFIOYArUtIyzqLep6izyMwla6xp5nMIbR49gBWjaonPI+sB7BSvD7ustrg=@vger.kernel.org, AJvYcCXJwK28N/UjG2LoEEVdZuQ+3EZmlviOu2Zdwv6iOoXqhWFH5YpTIVN1IhZPK6z7KnXu+MrMzw8fo5ArkA5H@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMBYwPN0cRiTJg3uWHiK7Afufk35mv0Z/1eN//0iEheiK2kyN
	gsxoUckwpm05W/zHdjP2IjTOKGRE0dflmWTVUFiIlBaFfjt8/FU2
X-Gm-Gg: ASbGncvW1q1m94Q5S6gfQtwcjmk9demYfD/9/YRQa8fjYOPWB7ht1Hrk1DsppJ46VKQ
	NQHbfk3PRuajCillSX5jfO9AbW6nE7MRlNcsPQxUr0BmNWBNLpaIkoYKhSDz/IS7nWAkE8APb+/
	LkI7VAl4HR5lI+sDFJCMcKA3qrh6Y656UqRUV3DTM7fsrEa5MTkUrgnTevANYSuHR+GN1eub4Yb
	07R3Svn60bS4jT1XO0HkCUxwXLNRvhsjy5nv6Z8ILDCBw4m4GfcfqhHXpDrBjkmkZD22Ky+ACRc
	pzHkOm7dKkxPhWarhOIXl9ltoMqHJw==
X-Google-Smtp-Source: AGHT+IHQU/LJQSTsO+zwOz3R3N381tEUMmonmZYiRo4Pz1pz8GCx7ErWSq2cPo56jMEV3z8Z+bk6kg==
X-Received: by 2002:a5d:584a:0:b0:386:42a6:21f2 with SMTP id ffacd0b85a97d-38880af1406mr2089867f8f.10.1734095276768;
        Fri, 13 Dec 2024 05:07:56 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e61dsm7033788f8f.21.2024.12.13.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 14:07:54 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <Z1wxqhwHbDbA2UHc@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241213105105.GB35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213105105.GB35539@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> > 
> > The generic approach (optimize all uprobes) is hard due to emulating
> > possible multiple original instructions and its related issues. The
> > usdt case, which stores 5-byte nop seems much easier, so starting
> > with that.
> > 
> > The basic idea is to replace breakpoint exception with syscall which
> > is faster on x86_64. For more details please see changelog of patch 8.
> 
> So ideally we'd put a check in the syscall, which verifies it comes from
> one of our trampolines and reject any and all other usage.
> 
> The reason to do this is that we can then delete all this code the
> moment it becomes irrelevant without having to worry userspace might be
> 'creative' somewhere.

yes, we do that already in SYSCALL_DEFINE0(uprobe):

        /* Allow execution only from uprobe trampolines. */
        vma = vma_lookup(current->mm, regs->ip);
        if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
                force_sig(SIGILL);
                return -1;
        }

jirka

