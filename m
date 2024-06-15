Return-Path: <bpf+bounces-32232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F035909968
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EE1C2107D
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD283502B2;
	Sat, 15 Jun 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qM/UA3cR"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386226ACD
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473784; cv=none; b=K841kIbEFYCxvtqHuXiBf3JbANGriENTaQXEVe62fT0gyTuAnFb+0GECIl4PBpwxsX8dgVtJr26tmj7POBHpSGKZ1XwtlUJ/nvbPDdF2mhXkaX7A2mKBjTtVDcZ47ednlNVlOBff+E0xiIgJ+6u4hHnLSASJ1xVbiGqHSBMI0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473784; c=relaxed/simple;
	bh=shQFVXgquplzSvph1NcgptaRdys0rYDQT6sCCNqT6LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7SW4+mE4erJtAeCwUvkHA9XwfX/vilUe0tK1aAu7b3W47ExG0RKqA4rX7lPPzoH5XvmRZPmEmCDRn4v+Sjq/THWwycB31l2v4A3q67WXyDHgeRwnHc3NwAnrqiTGYNrmMBB5g4KCAwtOty3FDppXfO3Wj3zpOrhVlRck3ZzGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qM/UA3cR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718473779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shQFVXgquplzSvph1NcgptaRdys0rYDQT6sCCNqT6LI=;
	b=qM/UA3cRI4LYGDuICsq2541PEbFrpZVEz8safvr4eehzE1P1DTq97BKCE4PE9pF67zd8JR
	/YzLr0yDoMKl0sAlxEWolH0Dp45TRJIPVRtbtBvc/2A3roQp7pOJbSUkhbggGbqyVasDPc
	vbcl3ywd7PwpWVA791spHaAxstj9cJY=
X-Envelope-To: zacecob@protonmail.com
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <f3dde80e-c3b9-4cca-9617-7133e1ca7e98@linux.dev>
Date: Sat, 15 Jun 2024 10:49:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: rcu_preempt detected stalls related to ebpf
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Zac Ecob <zacecob@protonmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com>
 <CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com>
 <-P_rTwSVX1lEiqRGA2drBZcQM24fbnVw4OBcVUrZ4bwPHBQ9QhFHJeWrHmImV3UxR6YqbRdkKXgVHHfNck-54u8Q0QSK6Qi4EWzxr9PVPSE=@protonmail.com>
 <CAADnVQJU30G1DezPLTzGyOSzG5TU3Tr-ZAoL+MYFEE+WKLD=2Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJU30G1DezPLTzGyOSzG5TU3Tr-ZAoL+MYFEE+WKLD=2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/15/24 9:59 AM, Alexei Starovoitov wrote:
> On Sat, Jun 15, 2024 at 12:09 AM Zac Ecob <zacecob@protonmail.com> wrote:
>>> I reduced the reproducer to the following:
>> Thank you for minimising the repro - I didn't think to do it myself. Apologies.
>>
>>> The verifier doesn't process the (s8) instruction correctly.
>> I took a further look out of curiosity and managed to properly crash the kernel. I think it might have security implications?
>> I haven't attached a repro for this because of such (though I could perhaps email it directly?).
>>
>> Not sure how best to precede?
> Pls focus your efforts on fixing the bug.

This is the fix: https://lore.kernel.org/bpf/20240615174621.3994321-1-yonghong.song@linux.dev/

Zac, could you test it in your environment?


