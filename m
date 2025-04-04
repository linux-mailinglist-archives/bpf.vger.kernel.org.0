Return-Path: <bpf+bounces-55328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEDA7BEFB
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5807217B052
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6A1F37CE;
	Fri,  4 Apr 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWzKLc2c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzosCgw/"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A628E3F;
	Fri,  4 Apr 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776401; cv=none; b=JJSGTRYVlC+VaS4vnhHo9HszOkRb63Jdv07OKXAP1rVxOTzKqsGusFVBGlZ1zT884EHXvmVrgVeP7SBVlNY+xfvOdlRYLx+2RH8xr2L5Q27+I8gRTPO0WZJpHuVbfH4FUg42ICjf4PqWrqYkA8iIS6Xd3iuwNVwJWZEyjXXCB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776401; c=relaxed/simple;
	bh=/2aEIo4PTu9z/sYVwRw5ohvcBLPPiG/NlbsJlADStM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlVhHHj+2IbNCw5xGAfzHPTIW51LLwg3G9xROjxSimAIFJ5RvaBBI1wVIP4sylVWEiyraHSEFksYMuXJq1efUfxEhVPN+jbqGA2ZmLY8a347r3cAX0HsicsHNBIep6PspESfyV+YksFRc474c/c4PyEK3O8kTCEmiZzaNqg+N8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWzKLc2c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzosCgw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Apr 2025 16:19:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743776396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2aEIo4PTu9z/sYVwRw5ohvcBLPPiG/NlbsJlADStM0=;
	b=SWzKLc2ctXrmW44PKGL6CcCaS+hl9rjHHYYydFdyT39Eh9irFmzRJK2waz2vSNSgG+HBKR
	u1cgHkttkBo8vPLTnUGcPGUa8gx699yT86ULNPWa/OFd8oxkwPaYu67FTZsxXHB+oWkxe9
	/Ddd2bHUt92cbKfHUCdyR/pTfacvC6OhikGde9rejr6zwSreLshxw34yjDYQooGk5AZjPr
	6l78nJyPs4lwa+PytA181sl1+jKSPDDel3rx+8MZTG3/BIYANCqqK9wprK5WhOyFZcn8vG
	7bOuMjiRTxVtLrpABMCzw83xOBaiKG67ZhlLmTEqqnq1/2vHSflRS49kEpnA6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743776396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2aEIo4PTu9z/sYVwRw5ohvcBLPPiG/NlbsJlADStM0=;
	b=yzosCgw/DorY+XXIp2bDiFycqfnFwFwJ1P09MN3jCa/0Gci95AWugeaSE3uY+caX3djPfA
	Tc4MpQ+XqJfFW6CQ==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Iurman <justin.iurman@uliege.be>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
Message-ID: <20250404141955.7Rcvv7nB@linutronix.de>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch>
 <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>

Alexei, thank you for the Cc.

On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
> Stating the obvious...
> Sebastian did a lot of work removing preempt_disable from the networking
> stack.
> We're certainly not adding them back.
> This patch is no go.

While looking through the code, it looks as if lwtunnel_xmit() lacks a
local_bh_disable().

Sebastian

