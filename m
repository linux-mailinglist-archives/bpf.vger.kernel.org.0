Return-Path: <bpf+bounces-26837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C3F8A56F1
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2292E1C21CAC
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2C7F7C1;
	Mon, 15 Apr 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xbYIFhJr"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399180BE5
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196872; cv=none; b=tZ+Z/qfQprqN23Z/BvRwHOH+ro/EeNETQv2gng8qIW51I1/XD1MLfxfTKBe94/+p69wCvK1BITPfx9ahnIJQP93OgZN8Qg22HYTmKRiGTyVLAPJHEHpJcUSCM67E9meLqK5737/O/BEdIxrCuucWiDS4gGcJzPKH/fRGu1WxhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196872; c=relaxed/simple;
	bh=0H4XtbyvwMPP+/fb03bacnc6BJ24wueFJapzd/ho/B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=At1idDcdAE/2nAT/5mvRk8ErAYJhZT7qyRWv0/HtXdP597qti4Jz1WKjR3pKKKRffNurE0LAGuqs/stftMaLSk5lpBvaRjbJkyxuu+GSdSJib9CTsJi00t86LNEPPAzxEdbrFOFVBGSW2WoCC5Z0TOPUKlBuPw1d8jdkuJbeuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xbYIFhJr; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f62fa70-ac50-41ff-a685-db6c8aefb017@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713196867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGUqjF7AdPOvaG+TZ/9SggjWcPR8+n5QB8MSMuMTtF0=;
	b=xbYIFhJr6+SYd1vKcAzMtvcJUwaraJGTi0VeT4nijf3BQejTZGpBLGrbbh1hSe6SKodTv6
	yEHoyTTGLIY4rNYDKriRjQx0L07HUUCa/nnXjC2JyCmv7wFgSqXh5bbbJ50YJ0MPt5O5+y
	r3HwN+mEPIq/zpoqvkpzwPeOyxuR1Hg=
Date: Mon, 15 Apr 2024 09:01:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: No direct copy from ctx to map possible, why?
Content-Language: en-GB
To: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>, bpf@vger.kernel.org
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/14/24 2:34 PM, Fabian Pfitzner wrote:
> Hello,
>
> is there a specific reason why it is not allowed to copy data from ctx 
> directly into a map via the bpf_map_update_elem helper?
> I develop a XDP program where I need to store incoming packets 
> (including the whole payload) into a map in order to buffer them.
> I thought I could simply put them into a map via the mentioned helper 
> function, but the verifier complains about expecting another type as 
> "ctx" (R3 type=ctx expected=fp, pkt, pkt_meta, .....).

Looks like you intend to copy packet data. So from the above, 'expected=fp,pkt,pkt_meta...', you can just put the first argument
with xdp->data, right?
Verifer rejects to 'ctx' since 'ctx' contents are subject to verifier rewrite. So actual 'ctx' contents/layouts may not match uapi definition.

>
> I was able to circumvent this error by first putting the packet onto 
> the stack (via xdp->data) and then write it into the map.
> The only limitation with this is that I cannot store packets larger 
> than 512 bytes due to the maximum stack size.
>
> I was also able to circumvent this by slicing chunks, that are smaller 
> than 512 bytes, out of the packet so that I can use the stack as a 
> clipboard before putting them into the map. This is a really ugly 
> solution, but I have not found a better one yet.
>
> So my question is: Why does this limitation exist? I am not sure if 
> its only related to XDP programs as this restriction is defined inside 
> of the bpf_map_update_elem_proto struct (arg3_type restricts this), so 
> I think it is a general limitation that affects all program types.
>
> Best regards,
> Fabian Pfitzner
>
>
>
>

