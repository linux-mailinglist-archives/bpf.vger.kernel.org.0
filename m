Return-Path: <bpf+bounces-62503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368DAFB590
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA57189FCA6
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B22BE059;
	Mon,  7 Jul 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="F6zJHbYC"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F271E4AB;
	Mon,  7 Jul 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897220; cv=pass; b=dqiZNXl/c3uKwxzHOKSAhp5KE7TnPdhzhZFjvY56Zw6fcRjL5ohe3EB3x/95KQ8y+V2MYbJOlFJHRHhO/z1LZ7Zv488E6HIxf8cRu0wYMt3WuO8GXNju2s4K6Y4NU2do0DezZl6VBQ7YMzrp+Uu2bQeTpWatGdoM0PQJ2dMV7BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897220; c=relaxed/simple;
	bh=nVL8RzbfQUbV3cWEN5HyzMj2JgPrLDM8C/LUWwir5pc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QtxbJ0kxjGdEypMvPITufngXDeif1RTlOO7X87uPZPm35tD3GvhC7iwdexZoJHp7S2GFsRgnQSIgLQ65MGQ61Hhf/iM9Ip0JrBw2+nILmCW5FTeZ/TWWi4vWVMg5PMobPIUpUTtJrMJFFBURLUdm5X7cAcau7c+6coVPZDAcFmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=F6zJHbYC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751897194; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LLNCR/NHkkh4BtqPJ/pCtseK5Ws83oNmpJh/GforqVFlguYwvIBNA98X+3RH/2aLRQvuOVpumum5U1cNiKzSGdz8m/zIMaeaMFiSjHOM4M3FxDPdfFTLbskUt6ruJo2Gmmbpj3nA8IvBseDeD8iCi+qj55JDKRJCTIkfmcexHsk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751897194; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p6r215HORtQkgpJubgFcQt2s0rODNo5ViU4EIRgi/3s=; 
	b=hy8A1BZXYujB1ebEPIQDioLRmyBnLGIrBarFzbw3hOijaYeqvdA0E71iI9KGWkusngIY0f6E3aJyhD74/anu5qqiMeqjwvUBL/FoJ/0+bK/U6SvlarU1v8OjLN9L8CHJU01Zb9KFNH6LsMBBjaHRURCdV5PKGsNSyV2+tJ12qlw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751897194;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p6r215HORtQkgpJubgFcQt2s0rODNo5ViU4EIRgi/3s=;
	b=F6zJHbYCHlzWqNy+5ogEzSuVhclGr3HMknP58crLG6vbFkXT75CKz23/eSB4LNtZ
	3cRN08qWfSR3+GKwhk8319Ht3f+/l+ylPJcnkVrEzn4cYUcoNaMPFdxyvLlcs8GJ9jO
	OiAtk66JaIHW8pvXJEcS70nHSfXrsZkhrmFPqugg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1751897191262513.0769904210841; Mon, 7 Jul 2025 07:06:31 -0700 (PDT)
Date: Mon, 07 Jul 2025 11:06:31 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bot" <bot@kernelci.org>,
	"kernelci" <kernelci@lists.linux.dev>,
	"Stephen Rothwell" <sfr@canb.auug.org.au>,
	"Linux Next Mailing List" <linux-next@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"bpf" <bpf@vger.kernel.org>
Message-ID: <197e535b307.1104f59621371677.7964423033912786920@collabora.com>
In-Reply-To: <d5136da0-51f9-4359-a283-9075b4992bfb@infradead.org>
References: <20250704205116.551577e4@canb.auug.org.au>
 <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
 <f06082bf-27b5-488d-b484-fecc100014a1@infradead.org>
 <CAP01T77AWoBqDgOPpmmcL5tQFqNa8W3rxBDB+Er0J5rxogCrVA@mail.gmail.com> <d5136da0-51f9-4359-a283-9075b4992bfb@infradead.org>
Subject: Re: linux-next: Tree for Jul 4 (kernel/bpf/stream.c)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Sat, 05 Jul 2025 01:52:58 -0300 Randy Dunlap <rdunlap@infradead.org> wrote ---

 > 
 > 
 > On 7/4/25 9:44 PM, Kumar Kartikeya Dwivedi wrote: 
 > > On Sat, 5 Jul 2025 at 01:38, Randy Dunlap <rdunlap@infradead.org> wrote: 
 > >> 
 > >> 
 > >> 
 > >> On 7/4/25 4:35 PM, Randy Dunlap wrote: 
 > >>> 
 > >>> 
 > >>> On 7/4/25 3:51 AM, Stephen Rothwell wrote: 
 > >>>> Hi all, 
 > >>>> 
 > >>>> Changes since 20250703: 
 > >>>> 
 > >>> 
 > >>> on i386: 
 > >>> 
 > >>> kernel/bpf/stream.c: In function 'dump_stack_cb': 
 > >>> kernel/bpf/stream.c:501:53: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast] 
 > >>>   501 |                                                     (void *)ip, line, file, num); 
 > >>>       |                                                     ^ 
 > >>> ../kernel/bpf/stream.c:505:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast] 
 > >>>   505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip); 
 > >>>       | 
 > >>> 
 > >>> 
 > >> 
 > >> Also reported (earlier) here: 
 > >> 
 > >> https://lore.kernel.org/linux-next/CACo-S-16Ry4Gn33k4zygRKwjE116h1t--DSqJpQfodeVb0ssGA@mail.gmail.com/T/#u 
 > >> 
 > > 
 > > Thanks, I will share a fix soon. Could the bot also Cc the author of 
 > > the commit using git blame? 
 >  
 > I added the email address for the bot. We'll see if it can read email. 

The bot doesn't know how to read email yet. :)

The challenge with Cc the author today is that we don't build every commit or bisect,
so we are not able to indentify the culprit commit. It is definitely on our roadmap to
do that, but we don't know when such a feature would be available.

Best,

- Gus



