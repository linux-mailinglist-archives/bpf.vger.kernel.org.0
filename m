Return-Path: <bpf+bounces-72982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28776C1F04E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 09:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA44E99B3
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21C733892C;
	Thu, 30 Oct 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xrl/WCti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kHsHJoCe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xrl/WCti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kHsHJoCe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A01273D66
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813486; cv=none; b=cc4ubf7iRnLkinx3QDwHAlvXX4tQArwQfAkXKsAB5AE0UcWmrD5xsJVunBe0liEcJBEf/heZ8afd0E3BcC7M1SpAR2ClUwvgho5ZJlQo+TVxeUSCFt66jhhvHsmK3ZQqZlYnCznDEyCiyRmaMlOyAQCJtdfaGCHPZFp0zEies7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813486; c=relaxed/simple;
	bh=b3BmUeai7NSgi6gaI6pNqpck6u1VsQisyA6qdrDFrnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITXNNiUvy3nJFZ1NbKItCovtLZHr6Q1wXwl/vtUs3d6/grp7TWKe11zySO5bjrC2CU+4t4SqoH5o+iNa4UgbfCUJaxM4vIz0I+nzl3vcGHkBtCpzRqKOF1fnQPgu6/LWOiSmbaJ3Q6oYM/txNlNGgjwyuSvBm315J8XyWhN8yoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xrl/WCti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kHsHJoCe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xrl/WCti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kHsHJoCe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17A2D33899;
	Thu, 30 Oct 2025 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761813483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53nKA2HJa5rNDn7FCq67g4jdt3pT7RYKdpGCn1BnEw=;
	b=Xrl/WCtiuFyQsKvvtSFuZ1sHgy/OhTQKzMOLqURyMWe2sF0jObb6so1q/dX3mirtyAO/0W
	u96L7Sp/eRKGHBSO9LQGR/0w+3KISlS0qVtaG8a+uOMPmTQdFRXWHVHKBJ9NhLXJJdZPkD
	8LKnmcWpIy9yJuuvVi4dsr4euRG8UDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761813483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53nKA2HJa5rNDn7FCq67g4jdt3pT7RYKdpGCn1BnEw=;
	b=kHsHJoCeuwCeSPM9KpxCdPdCi7doswPiL5uCzfIOD7l4+StxKzOkNcqB2MHg57M6/6dcn7
	woZaGZVlcYHnTiAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761813483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53nKA2HJa5rNDn7FCq67g4jdt3pT7RYKdpGCn1BnEw=;
	b=Xrl/WCtiuFyQsKvvtSFuZ1sHgy/OhTQKzMOLqURyMWe2sF0jObb6so1q/dX3mirtyAO/0W
	u96L7Sp/eRKGHBSO9LQGR/0w+3KISlS0qVtaG8a+uOMPmTQdFRXWHVHKBJ9NhLXJJdZPkD
	8LKnmcWpIy9yJuuvVi4dsr4euRG8UDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761813483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53nKA2HJa5rNDn7FCq67g4jdt3pT7RYKdpGCn1BnEw=;
	b=kHsHJoCeuwCeSPM9KpxCdPdCi7doswPiL5uCzfIOD7l4+StxKzOkNcqB2MHg57M6/6dcn7
	woZaGZVlcYHnTiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA1513393;
	Thu, 30 Oct 2025 08:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0AXmI+ojA2knPwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 30 Oct 2025 08:38:02 +0000
Message-ID: <b7974772-2e34-44df-924f-702e96ac20d3@suse.de>
Date: Thu, 30 Oct 2025 09:38:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 bpf v2] xsk: avoid data corruption on cq descriptor
 number
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, kerneljasonxing@gmail.com,
 fw@strlen.de
References: <20251028183032.5350-1-fmancera@suse.de>
 <20251028183032.5350-2-fmancera@suse.de> <20251028160107.5c161a4f@kernel.org>
 <b21cf80c-5d69-4914-aa45-00f9527f3436@suse.de>
 <20251029162245.5ea2ee3e@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251029162245.5ea2ee3e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,gmail.com,strlen.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 



On 10/30/25 12:22 AM, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:51:58 +0100 Fernando Fernandez Mancera wrote:
>> On 10/29/25 12:01 AM, Jakub Kicinski wrote:
>>> On Tue, 28 Oct 2025 19:30:32 +0100 Fernando Fernandez Mancera wrote:
>>>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
>>>> production"), the descriptor number is stored in skb control block and
>>>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
>>>> pool's completion queue.
>>>
>>> Looking at the past discussion it sounds like you want to optimize
>>> the single descriptor case? Can you not use a magic pointer for that?
>>>
>>> 	#define XSK_DESTRUCT_SINGLE_BUF	(void *)1
>>> 	destructor_arg = XSK_DESTRUCT_SINGLE_BUF
>>>
>>> Let's target this fix at net, please, I think the complexity here is
>>> all in skbs paths.
>>
>> I might be missing something here but if the destructor_arg pointer is
>> used to do this, where should we store the umem address associated with
>> it? In the proposed approach the skb extension should not be increased
>> for non-fragmented traffic as there is only a single descriptor and
>> therefore we can store the umem address in destructor_arg directly.
> 
> I see. Pointers are always aligned to 8B, you can stash the "pointer
> type" there. If the bottom bit is 1 it's a umem and the skb was
> single-chunk. If it's non-0 then it's a full kmalloc'ed struct.
> 

That is a good point. Pointer tagging might be a good solution here. 
Thanks, let me try that.

>> The size of the skb extension will only increase for fragmented traffic
>> (multiple descriptors).. but sure, if there is a fallback to the
>> slowpath, it will burden a bit the performance. Although, for that to
>> happen the must have tried to use AF_XDP family initially.. AFAICS, the
>> size of skb extension is only increased when skb_ext_add() is called.
> 
> To be clear by adding an skb extension you are de-facto allocating
> a bit in the skb struct. Just one of the bits of the active_extensions
> field instead of a separate bitfield. If you can depend on the socket
> association instead this is quite wasteful.
> 


