Return-Path: <bpf+bounces-20273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935C83B251
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F26F1F245B7
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96D132C27;
	Wed, 24 Jan 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDkKSdo5"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A756132C25
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124803; cv=none; b=q1o4T9H6aTiA76O1RQA3GeuHc5oF2LOxYErojIDhpmfzHK9VGFZ+q7dUDOTtySWqPVg9PC0DzNMQXGFP8aGm4iM9cGo+QH79M+XVDxD7i8DTMxS/UTWzVz/OS9h4fUgUoIZ16TDkN0L/bPUSbCbZqZF4w6XHHrpACYdPrK5cNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124803; c=relaxed/simple;
	bh=Mgu+ztchMazVbSFqcGdBjKj0oSl3oMxjyqaGYn2D9kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bl2IxYiV3O354LXdqVoujQc1YoXEy8Mj+2eDb7c/yJDemsErxGEvaeYVlID5WOt99bVxnYtzwsHmdoqWfUOillbPdOZ8oAdpAWjxcgjQYz0AEyU2uVJTTZqHoZY6lkR3eRDbv4bWpJpCeYHtMHtUIGCZiy9bPHbTwVm6X1kxmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDkKSdo5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706124798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWaAntcZrwvuFlRFCKqmmfca/9/tgp7D5aNFEZn3xzs=;
	b=rDkKSdo5IaNUa3Ypk12AjyEPSGnM9fFIqUgXkA+nkvGVqiMSBrWUQHfvKuakDaDoTAUEMV
	FsHYPlbWjhYGB6YYhF++qCsV/1f9+00xZG5sWrsz/x8i2fgXfZn+f0IKG9p4tgBJ9HVfKd
	Hz6syDmfcNpbUzPBAZIlmQ5PDjdF6Rw=
Date: Wed, 24 Jan 2024 11:33:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Jump instructions clarification
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/23/24 6:07 PM, dthaler1968@googlemail.com wrote:
> Hi Yonghong,
>
> The MOVSX clarification is now merged, but I just found another similar question for you
> regarding jump instructions.
>
> For BPF_CALL (same question for src=0, src=1, and src=2),
> are both BPF_JMP and BPF_JMP32 legal?  If so, is there a semantic difference?
> If not, then again I think the doc needs clarification.

BPF_CALL with BPF_JMP32 is illegal. This is true for src=0/1/2.

>
> BPF_JA's use of imm already has a note that it's BPF_JMP32 class only,
> but what about BPF_CALL's use of imm?

The imm field of BPF_CALL insn is used for call target.

>
> Similarly about comparisons like BPF_JEQ etc when BPF_K is set.
> E.g., is BPF_JEQ | BPF_K | BPF_JMP permitted?  The document currently
> has no restriction against it, but if it's permitted, the meaning is not explained.

Yes, it is permetted. It represents a 64bit reg compared to an imm.

>
> Dave
>
>

