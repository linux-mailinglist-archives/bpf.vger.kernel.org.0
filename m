Return-Path: <bpf+bounces-74214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C88EC4D203
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 11:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07AA3B811A
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03634D4F5;
	Tue, 11 Nov 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnCBA1vZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZ6UEQ/n"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D634C81F
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857432; cv=none; b=nCJK7Zl9i8fL/bOwLnIn4QSrFW+z4dWVQaAnrua8CP4M6erGJgkTk7S1iDJ44o2VBRxdE4iXzQXhOLMMXp5Ucbwbn6Asq8MldaM5cPrZBY3GI4xSLBnuGAUys/QYu/CQcUcOdnWIEUyYJqygYMXfNIVsCAVBHARxa127BJF8wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857432; c=relaxed/simple;
	bh=IYd4RbaYiFXlX49+n60igcRzzIxKYBIgAXdbixl54lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfhPqqW7ZjQgOxrS4VYXQfywdHznso13eKb/6Yo9ib1um196xxt2dZsYy8oY5uBGUL+J1gDKSfRo+GKWIW7zTl2Epof73JJGl0vTE+qetzCNgwTfKTzrV+eLSoHAwAa5G8FWDqarm6X6evwuCGaGRBkywaSfFxGIEWOdfUtE9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nnCBA1vZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZ6UEQ/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762857428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cdbhjjUs2OWaCR+gciF/9acBbcmGeleDDJakfvORTs=;
	b=nnCBA1vZC5nWd6Q5gryJJqyRe7S+DmHo3OH4UMBr9f5OI7ZFJWD8wlANK83L0fXqKUNDPj
	1FsQDAIGqP7roOhKR/jvqu9HVjl4Uys8hXQTc6fon28dauQ4l42mTqq6OAxKmV5vptwSnn
	VYiaY3EwFVYfad4Yymzc6eASjhe+dytDAlvTo54l1YiD/1ns6QEGrgtjmepU3CW5zw12T/
	e9ts7mL97c1CLWJXnd+7DUzkcxdZPpV3ax9Ip2iBxPQZg1GrUVPaJ/z+T9+1dIRIpL05hz
	f0vh+dg/6pzHuroMw68UynsCWm0S/jtHSh2aCkzDHlXXAHA8PgKk8wOmcpXevg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762857428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cdbhjjUs2OWaCR+gciF/9acBbcmGeleDDJakfvORTs=;
	b=tZ6UEQ/nbThHxJx6eLCt5N/lXZ8TtYQLLBGvGiygxWhPwrv7WxbrUeHupq5ElHcA+bNOYa
	UnPcLhWH+LMiiGAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bot+bpf-ci@kernel.org, chandna.sahil@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Message-ID: <20251111103705.B_sEhO6r@linutronix.de>
References: <20251109173648.401996-1-chandna.sahil@gmail.com>
 <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
 <2ed9877e-77e4-4f18-84fd-dc8b1ffe810f@linux.dev>
 <20251110132546.eE4o18h6@linutronix.de>
 <03bc2787-b5e7-42e7-9812-8c50da912c0b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03bc2787-b5e7-42e7-9812-8c50da912c0b@linux.dev>

On 2025-11-10 09:44:55 [-0800], Yonghong Song wrote:
> 
> 
> On 11/10/25 5:25 AM, Sebastian Andrzej Siewior wrote:
> > On 2025-11-09 11:44:48 [-0800], Yonghong Song wrote:
> > 
> > Could we do this instead?
> > There is  __bpf_stream_push_str() => bpf_stream_page_reserve_elem() =>
> > bpf_stream_page_replace() => alloc_pages_nolock().
> 
> I would suggest to stick to preempt_disable/enable().
> In the bpf-next (newer change), for function
> bpf_stream_elem_alloc(), kmalloc_nolock() is used
> and no local_lock usage any more.

Okay. This is then basically a revert of the removal of
preempt_disable(). If it doesn't break anything, fine then. I don't have
a strong argument against other than it would impose limitations as
mentioned previously (but this is no longer the case).
Unless it breaks anything, fine by me :)

The correct tags would be:

 Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
 Closes: https://lore.kernel.org/all/68f6a4c8.050a0220.1be48.0011.GAE@google.com/
 Fixes: 4223bf833c849 ("bpf: Remove preempt_disable in bpf_try_get_buffers")

Sebastian

