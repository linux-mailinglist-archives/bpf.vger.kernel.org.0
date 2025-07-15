Return-Path: <bpf+bounces-63337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00928B0631F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67FD189DFEC
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33522DFB5;
	Tue, 15 Jul 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaYHf0xI"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AC189F43
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593821; cv=none; b=fEeMP+ObC5/M1vry6dEmNslzuhE/HAaB6B7m2JzSviEapR5vC7q3Rf9vGsxlNsgQm1towAIvrVizwFAd5QPgHc4mSgL2F9cDAAkIap9dbcLt3EPifcDnBIvW9E/FZWfGYRQwiy3dR6isRYSxzFDVYiAL87EYshv+eK6UKHLQdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593821; c=relaxed/simple;
	bh=Bh0Y8SZoiEglHf0+3cV2Zu2LLLSNgefs0REhwYjPpfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRR0DvJNV+WrloS0ivnohFnG/MAGqhTh5geFLtFB9TJLFcm7+kwsVdDFcqAsgYzkS1/0h7SoFHvaeHWkDt262kTobYat50DXfIxdQpTT0LnY2OH5dDdfcgjwucUoebnuM3GyGzano1WCr7ipNZY3VWYWq9WcAhrpZpJs5Q8td5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaYHf0xI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0dea1f3-b396-4503-8aeb-baba7cd21981@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752593816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEhoBoqHfzUdGt1/xboG0chXhAgdsaLzQMQXZ1dytdg=;
	b=CaYHf0xIrT3MZtAkEqHXNJHw94z5TjHF0qbmvq+bikkuPEkp4KNkK0NAw16ty0L5pB073K
	ZMx+QQ3maRzuz8tt+xUvTg+NPtbk9RX1ORq8KhodMji46MGwI4iTegMlO3goVSdSaz7zcL
	LdIRSx+w8FkWL13tDFj//olL9qBQHrQ=
Date: Tue, 15 Jul 2025 08:36:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
 <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
 <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev>
 <680c6507-af5f-41be-8823-c8c9dfceaf5f@oracle.com>
 <DBCH1MVGI5EV.JODF0DE5B063@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DBCH1MVGI5EV.JODF0DE5B063@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 1:04 AM, Alexis Lothoré wrote:
> On Wed Jul 9, 2025 at 6:21 PM CEST, Alan Maguire wrote:
>> On 07/07/2025 20:36, Ihor Solodrai wrote:
>>> On 7/7/25 7:14 AM, Alexis LothorÃ© wrote:
>>>> On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothoré (eBPF Foundation)
>>>> wrote:
> 
> [...]
> 
>>> I think a proper fix for this is differentiating two variants of
>>> LSK__STOP_LOADING: stop because of an error, and stop because there is
>>> nothing else to do. That would require a bit of refactoring.
>>>
>>> Alan, Arnaldo, what do you think?
>>>
>>
>> Would it suffice to treat LSK__STOP_LOADING as an error in the BTF
>> encoding case, and not otherwise? That's a bit of hack; ideally I
>> suppose we'd introduce LSK__ABORT (like DWARF_CB_ABORT) and use it for
>> all the failure modes, reserving LSK__STOP_LOADING for cases where we
>> are done processing rather than we met an error.
> 
> Ihor, Alan, is anyone one of you planning to work on it ? If not, do you
> want me take a look and implement one of the solution suggested above ? I
> guess it's best to aim for Alan's second suggestion first (introducing a
> new LSK enum to represent a failure), otherwise the simpler solution
> distinguishing reasons for LSK__STOP_LOADING.

If you're willing to work on this, please go ahead.

It's not directly related to this series though, so maybe a separate
patch.

> 
> Alexis
> 


