Return-Path: <bpf+bounces-29893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761F8C7F69
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691ED1C2129C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA701A2C32;
	Fri, 17 May 2024 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SABINdmF"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581720E3
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908158; cv=none; b=DQjQJsoMFa8lpDMbk0b6IoJ2IwedhsPvtsndWP91siUwIyNOAlBmRs707i9C8t7xafG1OG8R43Kn9NJMgIPGTN4i8UcIClDqk+/bg1Htw86RUgjUe6SNvPcjE0Cwd17rHST5OSlxAbJ5/pMR8+vpzvC9+2O+FXssfV7bSr9CahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908158; c=relaxed/simple;
	bh=gEekdrYNh6S7gPAJ8d18ymC/w9fxQD+kLuXR+qBj/Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvt8vxWROfgQOXDZ2WBCx4wyIDWnaNPuhv0tN5OvXPAfG5kijWJGjQirFKmJeXKzZi6OZpmKlWQ61n+dGm8qixGLKUgBxgixiB+Gc9UMEBYLDZPkn/cxQCnr4j4ZdfT5eMtN27jx3cG4mUDrfE6BQSDJEv2NSaLmL2CDyfirIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SABINdmF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715908154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UbqBv1ohkIhFSpUWIlV5walljGuHrBVktUvk08YhKw=;
	b=SABINdmF66wLG4Pk8A9IJ0tSWo9F/MwFc5SSs5Iw5j/Bzb9aoqiEkGm79BXz7+oxANFDLC
	esLQJVDZN1MIxoegJsQ5IXqzzLSgqvlFYNqj/os3x08067L6oLBV8i1s+XIOI2gw1U7rkC
	Z9aQzUfa7PedbidsfuEBcZTlSakxzPE=
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <e8e0e6c2-52b8-4602-b146-7ab588c56f1a@linux.dev>
Date: Thu, 16 May 2024 18:07:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Amery Hung <ameryhung@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com,
 yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com>
 <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
 <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
 <CAMB2axMG2Pr11-O8ZRh3=T-4VqUmfoKQ7=ukQxK3rHONaTXypQ@mail.gmail.com>
 <184079b1-1ad0-414d-b8ff-179b5525c439@linux.dev>
 <CAMB2axOyfLoyicoNwJ=hdoNzZYQk67XVxQ4qrjZe4zLMZrz1xQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axOyfLoyicoNwJ=hdoNzZYQk67XVxQ4qrjZe4zLMZrz1xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/16/24 5:54 PM, Amery Hung wrote:
>> The part that no skb acquire kfunc should be available to the qdisc struct_ops
>> prog is understood. I think it just needs to clarify the commit message and
>> remove the "It must be released and cannot be acquired more than once" part.
>>
> Got it. I will improve the clarity of the commit message.
> 
> In addition, I will also remove "struct_ops_ref_acquire_dup_ref.c" as
> whether duplicate references can be acquired through kfunc is out of
> scope (should be taken care of by struct_ops implementer). Actually,
> this testcase should load the and it does load...
> 
> As for the name, do you have any thoughts?

Naming is hard... :(

May be just keep it short, just "__ref"?

