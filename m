Return-Path: <bpf+bounces-39448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA069739C2
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285AFB25EB6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE637193439;
	Tue, 10 Sep 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="slFZN+sw"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625066A01E
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978106; cv=none; b=dM52chrBh6bjlgp73HF43MmsToQoS9CZ3V+zJsVE9DhpQlqRCJ8RgusZWVa7aVSeG37OQd2B02eiTmEkITwlUNOwF+dc7XI2nqdQrlc9+fkCZp4rJzdNDG4uR6VJuZuj2Z1EyzE+C1tV6Zxs9P44jNxyWAvSkhXvIwCOWVR7avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978106; c=relaxed/simple;
	bh=xt9bGYxYOzkg3QK4gA2XoWV8RLCIyaEC8Ar/gJdnIt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWomyl6rfNXX30Faukf52AJ1UogmdBRY4MZDGsfJ7RU0ipB/nF9Djjpgiapir86A2Jp6J+QT+H28oQJI7qjZdyXnTBccfObnUdN2EumQFDvdiviLMANqVcefvLTJHvUaqVa7KIuew2d3R9pmCPfW4HGecdRyqZOcKkAkyFbrd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=slFZN+sw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDZzm5ZKsqARN4uq5Xw8R5WS6JhOvL5BjqUfmKPvsQg=;
	b=slFZN+sw14ENfiwW59LtNQBZJTQo6H2GDSObRbp+EXPsfvDvru9Y2M7k7ZuaLKT8QvJPNc
	hTiDQ7LoWP+0Wihk25PcyODDhANDjavhbw01I4SVST9G1IYT4BiHqC5YCd60tP/OwDu1Mw
	6aOdNa1hnbUGLQhKZDltOZLpvgYnXN0=
Date: Tue, 10 Sep 2024 07:21:35 -0700
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

In verifier, we have
   /* [R,W]x div 0 -> 0 */
   /* [R,W]x mod 0 -> [R,W]x */

What the value for
   Rx_a sdiv Rx_b -> ?
where Rx_a = INT64_MIN and Rx_b = -1?

Should we just do
   INT64_MIN sdiv -1 -> -1
or some other values?


