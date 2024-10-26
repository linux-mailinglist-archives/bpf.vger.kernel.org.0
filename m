Return-Path: <bpf+bounces-43234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0679B1909
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D720B282A1D
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848422612;
	Sat, 26 Oct 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="f1KuznAZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5320326;
	Sat, 26 Oct 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955962; cv=none; b=StJNuNpkmrk6zLFgr4GJwgnI2b4g3STKyMqoxlJywgvxtJb3XPH8UhaxCGpqenh7nTI8FVCu7k4unSGmzRPZB+iPolZQgiunEu/DTtMyBAqnMWdTYc9KBNxy3+PUcFxoL/QZ5Tae6W1UPcaqCMYPzgezRbhJW+sg2N8w0nwCowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955962; c=relaxed/simple;
	bh=RzzZTH5YgogTIQk8E3+Ny2PunCEi4PzHedHeeWu6nGQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FFrfgmorvvV8O3uB0/d+AOlHCPzw33UGUFI3CD1KW2fUW51X9zrnUMSg/frFfQSckrlgA+UljMw0VwvWPYo3RHIFfh/9mW55P0a+UDpqnj36D5q2iNRZFIBGHo46Edd7U392mrgOtfcqYafQHdMK7d1/u+4j+21GswdHglxFIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=f1KuznAZ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729955958;
	bh=RzzZTH5YgogTIQk8E3+Ny2PunCEi4PzHedHeeWu6nGQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=f1KuznAZVKWhOSz1t+vd26Eo7lJ+E4+cDjIccOd2hOnUxAzoSAP21mYDZRcW+uE4+
	 WchvXThptekaUmM+02h3gKUdSSKAffdhCualmhqwzGBTfx6XYBKhhf+CruJKYqa7LC
	 SRpFRW7ymYJUtnuwB1xnR/hWohVQ8LxrF820/tJSWNdziNkan5pAyHbS0r+FVhPG18
	 nx5I4pbtVQllIvL2UmyRiRdUYu+d3TxIxv7irDCYifzyp1R2NQTgi8Z2mlIS091ysB
	 63euw+Uiw+4e7SvAQfYcCKDsIVDJGi+osOFGmhO5bYyZ/XI6TNQTyH+6oUgXxUOd7Y
	 CTO+xCAT/D3Kg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XbNbp5TnQzNCL;
	Sat, 26 Oct 2024 11:19:18 -0400 (EDT)
Message-ID: <da4beb18-7bed-41bd-aeba-94497eff0b58@efficios.com>
Date: Sat, 26 Oct 2024 11:17:38 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jordan Rife <jrife@google.com>, acme@kernel.org,
 alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
 ast@kernel.org, bpf@vger.kernel.org, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
 mingo@redhat.com, mjeanson@efficios.com, namhyung@kernel.org,
 paulmck@kernel.org, peterz@infradead.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
References: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
 <20241025190854.3030636-1-jrife@google.com>
 <f31710d3-e4d8-43ad-9ccb-6d13201756a3@efficios.com>
 <20241026031314.0f53e7fa@rorschach.local.home>
 <b961bc6b-331c-4315-b424-60d514cc112e@efficios.com>
Content-Language: en-US
In-Reply-To: <b961bc6b-331c-4315-b424-60d514cc112e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-26 10:25, Mathieu Desnoyers wrote:
> On 2024-10-26 03:13, Steven Rostedt wrote:
>> On Fri, 25 Oct 2024 15:38:48 -0400
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>>> I'm curious if it might be better to add some field to struct
>>>> tracepoint like "sleepable" rather than adding a special case here
>>>> based on the name? Of course, if it's only ever going to be these
>>>> two cases then maybe adding a new field doesn't make sense.
>>>
>>> I know Steven is reluctant to bloat the tracepoint struct because there
>>> are lots of tracepoint instances (thousands). So for now I thought that
>>> just comparing the name would be a good start.
>>
>> You are correct. I really trying to keep the footprint of
>> tracepoints/events down.
>>
>>>
>>> We can eventually go a different route as well: introduce a section just
>>> to put the syscall tracepoints, and compare the struct tracepoint
>>> pointers to the section begin/end range. But it's rather complex
>>> for what should remain a simple fix.
>>
>> A separate section could work.
> 
> I have another approach to suggest: it shrinks the
> size of struct tracepoint from 80 bytes down to 72 bytes
> on x86-64, we don't have to do any section/linker
> script trickery, and it's extensible for future flags:
> 
> struct static_key {
>          int enabled;
>          void *p;
> };
> 
> struct static_key_false {
>          struct static_key key;
> };
> 
> struct static_call_key {
>          void *func;
>          void *p;
> };
> 
> struct tracepoint {
>          const char *name;               /* Tracepoint name */
>          struct static_key_false key;
>          struct static_call_key *static_call_key;
>          void *static_call_tramp;
>          void *iterator;
>          void *probestub;
>          void *funcs;
>          /* Flags. */
>          unsigned int regfunc:1,
>                       syscall:1;
> };
> 
> struct tracepoint_regfunc {
>          struct tracepoint tp;
>          int (*regfunc)(void);
>          void (*unregfunc)(void);
> };
> 
> Basically, a tracepoint with regfunc would define a
> struct tracepoint_regfunc rather than a struct tracepoint.
> So we remove both regfunc and unregfunc NULL pointers in
> the common case, which gives us plenty of room for flags.
> 
> When we want to access the regfunc/unregfunc from
> a struct tracepoint, we check the regfunc flag, and
> if set, we can use container_of() to get the struct
> tracepoint_regfunc.

Actually I can achieve the same space saving with fewer
changes like this:

struct tracepoint_ext {
     void *regfunc;
     void *unregfunc;
     /* Flags. */
     unsigned int syscall:1;
}

struct tracepoint {
         const char *name;               /* Tracepoint name */
         struct static_key_false key;
         struct static_call_key *static_call_key;
         void *static_call_tramp;
         void *iterator;
         void *probestub;
         void *funcs;
         struct tracepoint_ext *ext;
};

Thanks,

Mathieu

> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


