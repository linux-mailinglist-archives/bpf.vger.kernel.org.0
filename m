Return-Path: <bpf+bounces-39384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B579725D7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5AC285B3F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC018E36E;
	Mon,  9 Sep 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONappwZt"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110873440
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925651; cv=none; b=q/AFnP1BRAS/8DyJxsh5PtUzXX1ZTVnCT6GZ+ezwekTILJiLTgx//rH0Mq1WTwwDltbu+BzALSjq73xE9DuxKK80MY3E3G0b1V+Kfs+QykvCveSb05YmuWLaSqgY4GRcswiZd6SzUn9lWFy19Wny2vYuWaXf54ctef+pXZ9c+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925651; c=relaxed/simple;
	bh=oGccMYeHUpGbX7xj51BUdWfXZHDpHONKlSAQR3NRZlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzNRW0ODPSaqC7Z2ffNpXFJ+UOF4ebTXTY2f198AHO7QZ62TzkzLDrG3+BjNFcS4nPFBClbQpIs7ObWpGuOk5sw6fYAOehljRGwjNl3pel9HZxMdfgyETtS4XxXnS9tsQxdQKUDES06btDalZaSPo2KhQoYXcrojWdlSPqfea7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONappwZt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6ec9fa2-375d-4db7-ba76-7c78c2a58f1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGccMYeHUpGbX7xj51BUdWfXZHDpHONKlSAQR3NRZlk=;
	b=ONappwZtdvhZ6bvtMyleUHIRXIhRGz9MUq0Z9y525v/OQBjuwze8ffgsJ1N5hXCHuri6Oj
	A+7sM+MOG/eEYo6ahc8i2yqNrHslzug1JAo0IB1rAjC5VtP0LESU4Tkfo1RugFIs4jR9C8
	yGavAJYHcaiI8dG4wwsMzFagtcPi5t8=
Date: Mon, 9 Sep 2024 16:47:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
> On Mon, Sep 9, 2024 at 10:21 AM Zac Ecob <zacecob@protonmail.com> wrote:
>> Hello,
>>
>> I recently received a kernel 'oops' about a divide error.
>> After some research, it seems that the 'div64_s64' function used for the 'MOD'/'REM' instructions boils down to an 'idiv'.
>>
>> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because of two's complement, there is no corresponding positive value, causing the error (at least to my understanding).
>>
>>
>> Apologies if this is already known / not a relevant concern.
> Thanks for the report. This is a new issue.
>
> Yonghong,
>
> it's related to the new signed div insn.
> It sounds like we need to update chk_and_div[] part of
> the verifier to account for signed div differently.

Okay. Indeed, INT64_MIN/(-1) cannot be represented.
I will do something similar to chk_and_div[] to filter
out this corner case.


