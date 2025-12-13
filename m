Return-Path: <bpf+bounces-76557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E58CBA729
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283923058613
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EEB2BE033;
	Sat, 13 Dec 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="WMdf1yAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail98.out.titan.email (mail98.out.titan.email [54.147.227.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68EE28EA56
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.147.227.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765614034; cv=none; b=R+fC10l6LsT7npx533/WUddrqic0mc93iLUU2DvfgRxoXWUSSFsYOL9IIFv0ue7pB2YaEfHrR1fWsCCaZLtJ9qHBLkC/N69ZLHW1vJsNFfSJBblrRPmzEDZmaf0ursE2C9cMOXi5hFsFYil6hFwmCEWQHzLe++AzNGRIA0hZ5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765614034; c=relaxed/simple;
	bh=tMqJYHgMME4WvarDgCgm8Mdk0TRQIniiYmJc5WXYzzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orY0JMbMOI9D6b5W9dwtLdjI9uRJDuWg3d44fTay7J3BEXvaX5IPAl6lnF5KxwS5a73U+TIj6sapdprV2iqX/ZLI/8Y4PtRBQM7xGMaBIliLvfRQek+ABYZfGOAKx3fc9Sxo7l2aoG4zgBuT0DKuqMkwp/IO0MZNYfwLG6R4m5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=WMdf1yAZ; arc=none smtp.client-ip=54.147.227.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dSzlr6CHGz9rvR;
	Sat, 13 Dec 2025 08:20:24 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=39BXdQPgl272D26llb4eKizzyaDUSI/FuUYQ+gWa2+4=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=mime-version:subject:in-reply-to:date:to:cc:message-id:from:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765614024; v=1;
	b=WMdf1yAZR69Y5aO2Rt2xtl2/w40BKhNzlX8++AsNjvEENlzJ+AyXinnHN0qSkg8oXrQch3pc
	EwehiaAGjj7uH0+IwHvKFo+unRrME/qhaoSt2uy02j6KAeavY0L3byuEJWfcNtWisXu4LuPGPeY
	vrf+T39DUQQYz4YteFDoZc7A=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dSzln3Cv0z9rvW;
	Sat, 13 Dec 2025 08:20:21 +0000 (UTC)
Date: Sat, 13 Dec 2025 08:20:14 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
Subject: Re: [PATCH dwarves] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
Message-ID: <aT0hjyVstASDsl-E@pie>
References: <20251130032113.4938-2-ziyao@disroot.org>
 <a3f82302-09d2-45e1-a30a-38a32ddbf947@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f82302-09d2-45e1-a30a-38a32ddbf947@linux.dev>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765614024715901337.21635.7901820713464576493@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=693d21c8
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VSvT0IB8AAAA:20
	a=xTb4uN8yn8Aq-SSUa2sA:9 a=CjuIK1q_8ugA:10 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22 a=bA3UWDv6hWIuX7UZL3qL:22

Hi Yonghong,

Sorry for the late reply,

On Wed, Dec 03, 2025 at 04:46:20PM -0800, Yonghong Song wrote:
> 
> 
> On 11/29/25 7:21 PM, Yao Zi wrote:

...

> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 79be3f516a26..635015676389 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -708,6 +708,11 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
> >   		case DW_OP_addrx:
> >   			scope = VSCOPE_GLOBAL;
> >   			*addr = expr[0].number;
> > +
> > +			if (location->exprlen == 2 &&
> > +			    expr[1].atom == DW_OP_plus_uconst)
> > +				addr += expr[1].number;
> 
> This does not work. 'addr' is the parameter and the above new 'addr' value won't
> pass back to caller so the above is effectively a noop.

Oops, this is a silly problem.

> I think we need to add an additional parameter to pass the 'expr[1].number' back
> to the caller, e.g.,

However, I don't think it's necessary. See my explanation below,

> static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, uint32_t *offset, struct location *location) { ... }
> 
> and
> 
>    in the above
>        *offset = expr[1].number.
> 
> Now the caller has the following information:
>   . The deference of *addr stores the index to .debug_addr

No, dwarf__location() invokes attr_location(), which calls
dwarf_getlocation() and dwarf_formaddr(), the latter already performs a
lookup in .debug_addr[1], so what is stored in *addr is right the symbol
address.

Thus I think it's enough to keep the signature, but add the offset to
*addr.

>   . The offset to the address in .debug_addr
> and the final address will be debug_addr[*addr] + offset.
> 
> > +
> >   			break;
> >   		case DW_OP_reg1 ... DW_OP_reg31:
> >   		case DW_OP_breg0 ... DW_OP_breg31:
> 

Thanks for your review, I'll soon send a patch with the missing pointer
dereference to addr added.

Best regards,
Yao Zi

[1]: https://github.com/sourceware-org/elfutils/blob/67199e1c974db37f2bd200dcca7d7103f42ed06e/libdw/dwarf_formaddr.c#L37-L77

