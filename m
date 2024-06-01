Return-Path: <bpf+bounces-31097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BCE8D71E5
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 22:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94967B21754
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47E154C00;
	Sat,  1 Jun 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGfbzgwA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3gzI0uYT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGfbzgwA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3gzI0uYT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AB27447;
	Sat,  1 Jun 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717274945; cv=none; b=Sl0Fp0OPIFWjRND0561fXYhUsh+v1UBAVLrSiXoYQ0p+nqhbmkkIkHps5QP0MGx55ZT7629RubIqmMQlXRBWQXCSutadrdUpxsme+cIKRjkBpBLOVkffI4KFCeG37dQ5PppF6ayV1McHgE65D5Pjdr77QdtiSYrjZV8CBqfLcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717274945; c=relaxed/simple;
	bh=TJUhnakkezy3jijdOVSBPJtYX1JNamsqZONzk+asy4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgMDJ2SmiTI5NKAJKwuCvrsxD4E5Rs8Cr//2mzqiBitMdAOq/ETL+iCx1WuYQ64eKEoECbGdd8+jsXtTVnpjjrW7TxkreVy+TDUw9NiOoHvmNiLm788dTngs/yTghgfeuHMEY99/KTAoYUJ/YfgEx+r0J2IrDUthpurDSM1/+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGfbzgwA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3gzI0uYT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGfbzgwA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3gzI0uYT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B1DD1FEE9;
	Sat,  1 Jun 2024 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717274934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dCDTiX0KomT1r1tAFoAwvnZAd6hkmojiupNma6nyo+c=;
	b=kGfbzgwAJio3GgGdExfGZnRxU6Evf3D8g4jlsxLTOBJXhDuIYX4H2vldEtDEmX1Xz/T5Oh
	nxRAu+nm8tOGfvJesYNIasVsC863iSEH3aHX1pf/pCh3lcZMvyN8yO+jjJ5DKN3fgIPFl0
	LF56y34NWUZgyKEE/d3Pvp5c4P9VR94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717274934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dCDTiX0KomT1r1tAFoAwvnZAd6hkmojiupNma6nyo+c=;
	b=3gzI0uYTZxFIrmGm+TBHChXdVgUUhGyJIf5BdU6BfdM58vhL5E/AXW6pJogURno0S0TAvo
	N/qXJGRQU79etnBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717274934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dCDTiX0KomT1r1tAFoAwvnZAd6hkmojiupNma6nyo+c=;
	b=kGfbzgwAJio3GgGdExfGZnRxU6Evf3D8g4jlsxLTOBJXhDuIYX4H2vldEtDEmX1Xz/T5Oh
	nxRAu+nm8tOGfvJesYNIasVsC863iSEH3aHX1pf/pCh3lcZMvyN8yO+jjJ5DKN3fgIPFl0
	LF56y34NWUZgyKEE/d3Pvp5c4P9VR94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717274934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dCDTiX0KomT1r1tAFoAwvnZAd6hkmojiupNma6nyo+c=;
	b=3gzI0uYTZxFIrmGm+TBHChXdVgUUhGyJIf5BdU6BfdM58vhL5E/AXW6pJogURno0S0TAvo
	N/qXJGRQU79etnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9C6137C3;
	Sat,  1 Jun 2024 20:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gqgkGjaJW2azTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 01 Jun 2024 20:48:54 +0000
Message-ID: <87a4928a-ea15-453c-b252-2da0b301cb7e@suse.cz>
Date: Sat, 1 Jun 2024 22:48:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] static key support for error injection functions
To: Mark Rutland <mark.rutland@arm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <ZlntQn-a7Ycko_j5@J2N7QTR9R3>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZlntQn-a7Ycko_j5@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,linux.dev,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]

On 5/31/24 5:31 PM, Mark Rutland wrote:
> Hi,
> 
> On Fri, May 31, 2024 at 11:33:31AM +0200, Vlastimil Babka wrote:
>> Incomplete, help needed from ftrace/kprobe and bpf folks.
> 
>> - the generic error injection using kretprobes with
>>   override_function_with_return is handled in patch 2. The
>>   ALLOW_ERROR_INJECTION() annotation is extended so that static key
>>   address can be passed, and the framework controls it when error
>>   injection is enabled or disabled in debugfs for the function.
>> 
>> There are two more users I know of but am not familiar enough to fix up
>> myself. I hope people that are more familiar can help me here.
>> 
>> - ftrace seems to be using override_function_with_return from
>>   #define ftrace_override_function_with_return but I found no place
>>   where the latter is used. I assume it might be hidden behind more
>>   macro magic? But the point is if ftrace can be instructed to act like
>>   an error injection, it would also have to use some form of metadata
>>   (from patch 2 presumably?) to get to the static key and control it.
> 
> I don't think you've missed anything; nothing currently uses
> ftrace_override_function_with_return(). I added that in commit:

Ah, great, thanks for confirming that.

>   94d095ffa0e16bb7 ("ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses")
> 
> ... so that it was possible to do anything that was possible with
> FTRACE_WITH_REGS and/or kprobes, under the expectation that we might
> want to move fault injection and BPF probes over to fprobes in future,
> as ftrace/fprobes is generally faster than kprobes (e.g. for
> architectures that can't do KPROBES_ON_FTRACE or OPTPROBES).
> 
> That's just the mechanism for the handler to use; I'd expect whatever
> registered the handler to be responsible for flipping the static key,
> and I don't think anything needs to change within ftrace itself.
> 
>>   If ftrace can only observe the function being called, maybe it
>>   wouldn't be wrong to just observe nothing if the static key isn't
>>   enabled because nobody is doing the fault injection?
> 
> Yep, that sounds right to me.

Good.

> Mark.


