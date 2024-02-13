Return-Path: <bpf+bounces-21819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893EB85270F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CFFB26370
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670BD2E6;
	Tue, 13 Feb 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="j5E+iGg4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ex+NCjVr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WlvVa2Ip"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C85BE5A
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787449; cv=none; b=O6wZs4Oxj5OIjDj14cdvzT3U6iooZzCs6Hz/XGKMRYEaa9Eb/UNHoLnBioGVjf8+xfht2FLL8PGH3GzljnDeJBMtUqNbYwJSlK9Hbf8yL8hjpb2rBvXLjAj+t8PpCZM994PRpHQx9K0Isp9Gc1AKO86isuLbKV93TQcIZwWZGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787449; c=relaxed/simple;
	bh=JRYsKmACQecY7a+0WrDQDddJK+Bm8FiJAo644CawpDY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=af1Q0swIMAQYIoDQbmWVGPlDIh/SmlG2x9n8Pm607exIpavpH8bUxbar3KMmUvwj0wjDR420RpEoBBURcGMedY70t8vpiudEBpxFKO72wfJ4N1nPAEZVuivF8rhNurE0dhsgUYwPiyXshmJQfgBrFsHUD1Jb5K4Lfa0JkaGxmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=j5E+iGg4; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ex+NCjVr; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WlvVa2Ip reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31F57C18DBB9
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707787446; bh=JRYsKmACQecY7a+0WrDQDddJK+Bm8FiJAo644CawpDY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=j5E+iGg42txPPGs0pMFwJpCfSD27UtuJq0pvP2FX5+CALarSZ5/Psf8Gru72a0QYR
	 rN/eZacVkx2PZXH5JHA1aAFFg+EfJuHYcmxlxYjMQJ7CL6+rCJpsGo3cyO+Npkr7Y2
	 1VhlLomPgrbJJkf44uamqK+gfXBFPAzEeafhml7U=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb 12 17:24:05 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A01E2C15199D;
	Mon, 12 Feb 2024 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707787445; bh=JRYsKmACQecY7a+0WrDQDddJK+Bm8FiJAo644CawpDY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ex+NCjVr5FYlgyUn+PueHfS8xVQi8TB+iWmCFRiQxBcebII/oHsiQn60cU99fZY+I
	 RbR3GVNi3qPBfGy/Dm81HhEBCO8EFfq7bWnei1ewB3/44DpO0NpAs4kQqS6lNrl8rc
	 yj/upGAZg1AmJeyWl0bHolxy5iDBhEFAFpO3CHhg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1073FC15199D
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 17:24:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xD2kbLUyyy0F for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 17:23:59 -0800 (PST)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [95.215.58.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DDC11C151522
 for <bpf@ietf.org>; Mon, 12 Feb 2024 17:23:58 -0800 (PST)
Message-ID: <d3b89acf-fb83-4bdf-84e1-6c4a77f3ad36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1707787436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=texyvZ/XwQWQWgeYnioyP/KDLsoY6O6tqmtEXOQYBhA=;
 b=WlvVa2Ipfmn6PvwSHK1ow3JeoLl5XOG7dboDAVvT0YfAbKt1O+kxkO4NLkNgejgNbu7l2R
 /hPnLmJtAIT3CUWu8EcMrP0Fra76P7MxR5fUFyYJwWSvp62ojnBLgRn/c/P/m9z3Y8/B5c
 5l+RTkk+uRH7/PokGWcjYwAWb3W/CgA=
Date: Mon, 12 Feb 2024 17:23:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: dthaler1968@googlemail.com, "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
 <036301da5dfd$be7d1b30$3b775190$@gmail.com>
 <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
 <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/0uYKMxxx86ImNhEYGi1yzAZBxvM>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


On 2/12/24 5:18 PM, dthaler1968@googlemail.com wrote:
>> -----Original Message-----
>> From: Yonghong Song <yonghong.song@linux.dev>
>> Sent: Monday, February 12, 2024 2:49 PM
>> To: dthaler1968@googlemail.com; 'Jose E. Marchesi'
>> <jose.marchesi@oracle.com>; 'Dave Thaler'
>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>> Cc: bpf@vger.kernel.org; bpf@ietf.org
>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
>> conformance group
>>
>>
>> On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
>>>> -----Original Message-----
>>>> From: Yonghong Song <yonghong.song@linux.dev>
>>>> Sent: Monday, February 12, 2024 1:49 PM
>>>> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
>>>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>>>> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
>>>> <dthaler1968@gmail.com>
>>>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx
>>>> instructions in new conformance group
>>>>
>>>>
>>>> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>>>>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
>>>> only, see `Program-local functions`_
>>>>> If the instruction requires a register operand, why not using one of
>>>>> the register fields?  Is there any reason for not doing that?
>>>> Talked to Alexei and we think using dst_reg for the register for
>>>> callx insn is better. I will craft a llvm patch for this today. Thanks!
>>> Why dst_reg instead of src_reg?
>>> BPF_X is supposed to mean use src_reg.
>> Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch of flags
>> (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this property as
>> well in case in the future we will introduce variants for callx.
> Ah yes, that makes sense.
>
>> The following is the llvm diff:
>>
>> https://github.com/llvm/llvm-project/pull/81546
> Which llvm release is it targeted for?
> 18.1.0-rc3? 18.1.1?  later?

llvm19

>
>>> But this thread is about reserving/documenting the existing practice,
>>> since anyone trying to use it would run into interop issues because
>>> of existing clang.   Should we document both and list one as deprecated?
>> I think just documenting the new encoding is good enough. But other
>> people can chime in just in case that I missed something.
> Ok.
>
> Dave
>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

