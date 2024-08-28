Return-Path: <bpf+bounces-38308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A632963093
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7168BB249EE
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF91AB522;
	Wed, 28 Aug 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WlREnyGa"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE11AB503
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871588; cv=none; b=owMYdr+f+N6mhcUqBss6LAOUC8L9ABoJx0Qw6/cV/oX1z/NZJqGMUXc7sNNxxWmTy2asgxFpjVz3xh6h95zO8KIiHuwLi9lCCVNLW4KbzUgVQx4GbbmtY4U5bVt2TMLEb4gX215sjWoBuPID61foSHTLymVxEw2CzrxfZTYF08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871588; c=relaxed/simple;
	bh=2bES864NO1Dk0ae92GXkIm3uTTTcvmmiy4DjawLx+n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiiMUAv9PEKHOZKhdNj1TdbjTS5N5RwsayXAr2zVoErfhyP9Fc5Yj69h3vLugLEXuOm8b9ogw0w0kUd+/dwvMUOTCFiiDEebfgx5bmFhL5wdTq9mx363DRYZbYbZbSZHscjH6xP+U/b1SII0Ux9j3aUtb1V21+y6hBsUIC90mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WlREnyGa; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a76c7e0c-d8f7-44bf-94b5-63610abbd506@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724871583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d832903oHpgQqOKttJnC2sKKD1MJzsqysSdhnzV5kOI=;
	b=WlREnyGagnPHHMgxWuHoq0pLzok4k2R7ZPamr5BnPa2+ZnYvZW9YwK/ZjbG6A/1Owykxi0
	ttcHXCj18XyyNORwiChQhjKsPFenDVYsYLbMQ3IgcYxMJSIxuctrmU734Pwagf6DX/NBil
	qgbCI86s0KClOCR6ZGK9N7/yOK+TpoU=
Date: Wed, 28 Aug 2024 11:59:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st
 insn of the prologue
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827195208.1435815-1-martin.lau@linux.dev>
 <CAADnVQJbGCB5Hjb8NPU7P0ZOwR_EWcREuxsBOvyo7cRggdioDA@mail.gmail.com>
 <669bc1c6-2c8c-483f-8d38-0a705463a25d@linux.dev>
 <CAADnVQ+0qWRDvRouyZoikYAf=EQepPyuOWrk4oH+h8s1wJW-YA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+0qWRDvRouyZoikYAf=EQepPyuOWrk4oH+h8s1wJW-YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 11:43 AM, Alexei Starovoitov wrote:
> On Wed, Aug 28, 2024 at 10:44 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> -       for (i = 0; i < insn_cnt; i++, insn++) {
>>>> +       for (i = skip_cnt; i < insn_cnt; i++, insn++) {
>>>
>>> Do we really need to add this argument?
>>>
>>>> -               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
>>>> +               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1, 0));
>>>
>>> We can always do for (i = delta; ...
>>>
>>> The above case of skip_cnt == 0 is lucky to work this way.
>>> It would be less surprising to skip all insns in the patch.
>>> Maybe I'm missing something.
>>
>> For subprog_start case, tgt_idx (where the patch started) may not be 0. How
>> about this:
>>
>>          for (i = 0; i < insn_cnt; i++, insn++) {
>>                  if (tgt_idx <= i && i < tgt_idx + delta)
>>                          continue;
> 
> Yeah. Right. Same idea, but certainly your way is more correct
> instead of my buggy proposal.
> 
> In that sense the "for (i = skip_cnt" approach
> is also a bit buggy, if tgt_idx != 0.

Yep. Adding skip_cnt like this patch 2 is not right. I didn't think hard enough 
what to do with the existing adjust_jmp_off().

I will remove skip_cnt in the next respin.

Thanks for the review!

