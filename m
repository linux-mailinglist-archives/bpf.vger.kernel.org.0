Return-Path: <bpf+bounces-15859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91717F909D
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 02:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B531B20FE9
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3DED2;
	Sun, 26 Nov 2023 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CN3jD6kd"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F632A9
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:05:24 -0800 (PST)
Message-ID: <31aed971-6b0e-4cce-a2e1-d9fa2c27c9c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700960722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bk+IbpVVNDdbQs6Py7OjtL49ceILXMR0//OC812J3AU=;
	b=CN3jD6kdjqdeA7oX/rPlHUESqWhGIUpEZBdM5r8HKTMnf8N4+Cr034eSWtLxpM4M76NcZd
	8/iJVeQget+8kZnYND6AKAi9uVc5qJFX2dR/Z/S91gxM56pVIXUDdCN+PHparxn9ftRJlc
	JX5I88TcNZo2tTXZ6ctf+OqbBQ9kgyY=
Date: Sat, 25 Nov 2023 17:05:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Content-Language: en-GB
To: Song Liu <song@kernel.org>
Cc: Dmitry Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, dan.carpenter@linaro.org
References: <20231122191816.5572-1-9erthalion6@gmail.com>
 <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
 <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
 <f1fde0d0-dba6-481d-8b2d-d0c3d63620cc@linux.dev>
 <CAPhsuW7K37n+5XWc2eKVhVA-V+Pd=NmLBN7hnowOpC0hNaCzgg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAPhsuW7K37n+5XWc2eKVhVA-V+Pd=NmLBN7hnowOpC0hNaCzgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/25/23 3:40 PM, Song Liu wrote:
> On Sat, Nov 25, 2023 at 11:55 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/24/23 4:16 PM, Dmitry Dolgov wrote:
>>>> On Thu, Nov 23, 2023 at 11:24:34PM -0800, Song Liu wrote:
>>>>> Following the corresponding discussion [1], the reason for that is to
>>>>> avoid tracing progs call cycles without introducing more complex
>>>>> solutions. Relax "no same type" requirement to "no progs that are
>>>>> already an attach target themselves" for the tracing type. In this way
>>>>> only a standalone tracing program (without any other progs attached to
>>>>> it) could be attached to another one, and no cycle could be formed. To
>>>> If prog B attached to prog A, and prog C attached to prog B, then we
>>>> detach B. At this point, can we re-attach B to A?
>>> Nope, with the proposed changes it still wouldn't be possible to
>>> reattach B to A (if we're talking about tracing progs of course),
>>> because this time B is an attachment target on its own.
>> IIUC, the 'prog B attached to prog A, and prog C attached to prog B'
>> not really possible.
>>      After prog B attached to prog A, we have
>>        prog B follower_cnt = 1
>>        prog A attach_depth = 1
> I think prog A has follower_cnt=1, while prog B has follow_cnt=0, no?

I checked bpf_tracing_prog_attach() again. Yes, I made a dumb mistake
and indeed
    After prog B attached to prog A, we should have
       prog A follower_cnt = 1 and prog B attach_depth = 1

>
> Thanks,
> Song
>
>>      Then prog C wants to attach to prog B,
>>        since we have prog B follower_cnt = 1, then attaching will fail.
>>
>> If we do have A <- B <- C chain by
>>      first prog C attached to prog B, and then prog B attached to A
>>      now we have
>>       prog B/C follower_cnt = 1
>>       prog A/B attach_depth = 1
>> after detaching B from A, we have
>>       prog B follower_cnt = 0
>>       prog A attach_depth = 0
>>
>> In this particular case, prog B attaching to prog A should succeed
>> since prog B follower_cnt = 0.
>>
>> Did I miss anything?
>>
>> In the commit message, 'falcosecurity libs project' is mentioned as a use
>> case for chained fentry/fexit bpf programs. I think you should expand the
>> use case in more details. It is possible with use case description, people
>> might find better/alternative solutions for your use case.
>>
>> Also, if you can have a test case to exercise your commit logic,
>> it will be even better.

[...]


