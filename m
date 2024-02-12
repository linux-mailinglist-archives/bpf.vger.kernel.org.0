Return-Path: <bpf+bounces-21791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BF8521BA
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0C1C224D2
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7104E1CF;
	Mon, 12 Feb 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WqynV2W8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WqynV2W8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buRQTJFF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1034D121
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778158; cv=none; b=oM5KOWmCnWOFlIbBQejEtl6GHCcx8nT/QJN+fp0kq7Mtanzr4P+nTBbZJSFR+R4W+WHfsq+fgfKQYc/lG2UDTQ3n8eAEUJ0KHvBM0UM1POp9FkraiTqG3eLziwFdWJriNayBH6ET1/6Z7kLyHDQ8l6yHLlwBdsEfR8frnBTVfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778158; c=relaxed/simple;
	bh=KB946rGxG9KIE0jVr02YPBYw3moko/1CPBW9/tC4uw4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=WBPhVJ7CxmhpQH5nRwxaZEWX6x2yla/scdz3iuniHTDLpUwQ9CJc/YPGbE+rA+5PBx2TaGCOG/24QHQCzmP8TqFxUzLm3EwXvZI0gb4Ai8SkOwxOa6pwpIZUPXXxq3f9APw2cMdCN7A2rE32zuQyhcOuYKVE3PR/TNVozS66hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WqynV2W8; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WqynV2W8; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buRQTJFF reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DE18AC15155A
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707778155; bh=KB946rGxG9KIE0jVr02YPBYw3moko/1CPBW9/tC4uw4=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WqynV2W83lmlt6OiP42uE1NGqotpujq8NLTgw9S3rCfY3ENBCxV4qmQfhi1DAyJ+O
	 bVqf9T8JSC2noie1IIHw+2U3m7mZ17l+i4xYhoYKxrQApnwWQYZfyDYGAi3GxZO6hW
	 wLeTJoA4wX6Q6S6ElV8saiCVbMLlXGTOQVuBklJQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Feb 12 14:49:15 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AC90AC14F697;
	Mon, 12 Feb 2024 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707778155; bh=KB946rGxG9KIE0jVr02YPBYw3moko/1CPBW9/tC4uw4=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WqynV2W83lmlt6OiP42uE1NGqotpujq8NLTgw9S3rCfY3ENBCxV4qmQfhi1DAyJ+O
	 bVqf9T8JSC2noie1IIHw+2U3m7mZ17l+i4xYhoYKxrQApnwWQYZfyDYGAi3GxZO6hW
	 wLeTJoA4wX6Q6S6ElV8saiCVbMLlXGTOQVuBklJQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B4CC8C14F5F5
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 14:49:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPZxWKmvwUKk for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 14:49:09 -0800 (PST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 60F05C14F697
 for <bpf@ietf.org>; Mon, 12 Feb 2024 14:49:08 -0800 (PST)
Message-ID: <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1707778146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxxpcU8xAC2U25ibMmPCd2/qGSoxCgvlX90Yj8CWOlE=;
 b=buRQTJFFMfo39aQ31z2BoUDeoIxU7GZffJqwH8PIyPQTSYFNebSTOL1v82F7t8T2os6Y/1
 u5wqi4q0trh2WZmO3n8o7k9XmTnfFA07rf7BoGf1i+/huhedoQZz4pBdfUhkZzEfo7BBpj
 0J7mzt1G36ChuoaiV7hg2pRqBjuxmZU=
Date: Mon, 12 Feb 2024 14:48:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: dthaler1968@googlemail.com, "'Jose E. Marchesi'"
 <jose.marchesi@oracle.com>,
 'Dave Thaler' <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
 <036301da5dfd$be7d1b30$3b775190$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <036301da5dfd$be7d1b30$3b775190$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Vx1H3ViPUWoGKNssCO22lOIjyXU>
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


On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
>> -----Original Message-----
>> From: Yonghong Song <yonghong.song@linux.dev>
>> Sent: Monday, February 12, 2024 1:49 PM
>> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
>> <dthaler1968=40googlemail.com@dmarc.ietf.org>
>> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
>> <dthaler1968@gmail.com>
>> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
>> conformance group
>>
>>
>> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
>>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
>> only, see `Program-local functions`_
>>> If the instruction requires a register operand, why not using one of
>>> the register fields?  Is there any reason for not doing that?
>> Talked to Alexei and we think using dst_reg for the register for callx insn is
>> better. I will craft a llvm patch for this today. Thanks!
> Why dst_reg instead of src_reg?
> BPF_X is supposed to mean use src_reg.

Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch
of flags (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this
property as well in case in the future we will introduce variants for
callx. The following is the llvm diff:

https://github.com/llvm/llvm-project/pull/81546

>
> But this thread is about reserving/documenting the existing practice,
> since anyone trying to use it would run into interop issues because
> of existing clang.   Should we document both and list one as deprecated?

I think just documenting the new encoding is good enough. But other
people can chime in just in case that I missed something.

>
> Dave
>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

