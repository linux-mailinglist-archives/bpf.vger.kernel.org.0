Return-Path: <bpf+bounces-47417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E049F93D8
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13216161B58
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516C215717;
	Fri, 20 Dec 2024 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="at3OXPcF"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B01C549D
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703264; cv=none; b=EYbuEwS2Y6QH/fxWmuMk4NIWKloIJ1OHZcn4F4J+YAHFz8f06HHyetu6KOkKB4TFKPrCz1SpNAZ3fOTKBTUcJ1oeer0KQ+3Ccqn1B8lqMv6lfLUnBiGz+SSvr3duhVsKsfFmgS54MSHLXJnDxkT73hhmt/uokvGNAwzKzBt2YWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703264; c=relaxed/simple;
	bh=Zg00mqSBrpcoJeWxXLRfUGS0yncUtP9wblHrYbLYOzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFHMRUI/mmrVPQUL3z9Rn5j4qBNByL5BgEXZ1eaLXj1vsEhcB/Q7rZ5bHZspifVJXiZSAHJyj8IJpsiuvuU/91fu108qSdL8CqxPIADsYjmY+p7Bcn1ACrjt1cuYcbTDo2DlfEeoUT5M2rkJLoIIXjC3ZeTzz7LcFuNlK3M0vdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=at3OXPcF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZX5TS88G/McISU6BMaGXrKm/ueN78G2h7umu6555hJE=; b=at3OXPcF2dMZHbiWaFqQWivNSd
	fT4cfPNhIT4e8eTRqOVBk5tNg9AZRXryaDxtpQtGHTI9g2WI4f/xBTgkJeUCoIpZcGdPdgKBuIqjg
	+QCV/zyURQ9I6trKFLVKxmLy840nwWnglzcJ47I1JMMs0P3TpCRzqYT9DG//xpSzKp7NARwXbHy6G
	ao6c42mgg2H/qj6RokxxPyoKt57xSOa4VSCdbDAM/dHMYB99BSOySWVIG3s1yYgTdsJI9FwANRM3z
	p+TFvZ+5O80VtBlMRc+8Y0YOYbjc975iyc03tmK6fTzHWxwHsp04d5OTvDVZS+R7aHftFgHTAl4Af
	Aig7vKBA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdYp-00000000ud1-1POY;
	Fri, 20 Dec 2024 14:01:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04C263003FF; Fri, 20 Dec 2024 15:00:59 +0100 (CET)
Date: Fri, 20 Dec 2024 15:00:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: Idea for "function meta"
Message-ID: <20241220140058.GE17537@noisy.programming.kicks-ass.net>
References: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>

On Fri, Dec 20, 2024 at 09:57:22PM +0800, Menglong Dong wrote:

> However, the other 5-bytes will be consumed if CFI_CLANG is
> enabled, and the space is not enough anymore in this case, and
> the insn will be like this:
> 
> __cfi_do_test:
> mov (5byte)
> nop nop (2 bytes)
> sarq (9 bytes)
> do_test:
> xxx
> 

FineIBT will fully consume those 16 bytes.

Also, text is ROX, you cannot easily write there. Furthermore, writing
non-instructions there will destroy disassemblers ability to make sense
of the memory.

So no, don't do this.

