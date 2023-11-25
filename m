Return-Path: <bpf+bounces-15849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3557F8E3F
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746691C20C6D
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACF2FE1E;
	Sat, 25 Nov 2023 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SZc5paeA"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3500D3
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 11:55:35 -0800 (PST)
Message-ID: <f1fde0d0-dba6-481d-8b2d-d0c3d63620cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700942133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8F9MPFwmOCLPLh8hmhGAN37mH4T2KQmfMjmUggVj90=;
	b=SZc5paeACdtCsfOQZrfxxewPoTqdyO35fFPpTs4U8NXsZ0oEHm3hbd+Gqodgncau5QMv21
	PLLS7U2rXzQW4DviSbyXl7NVEVX2U45mCVoXXRgK9//yueu208RZHrrjexexSdBFj7Nzob
	MyWqyRPftxWdxFpro2o+OxOPkbUZeY8=
Date: Sat, 25 Nov 2023 11:55:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Content-Language: en-GB
To: Dmitry Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, dan.carpenter@linaro.org
References: <20231122191816.5572-1-9erthalion6@gmail.com>
 <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
 <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231124211631.ktwsigoafnnbhpyt@erthalion.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/24/23 4:16 PM, Dmitry Dolgov wrote:
>> On Thu, Nov 23, 2023 at 11:24:34PM -0800, Song Liu wrote:
>>> Following the corresponding discussion [1], the reason for that is to
>>> avoid tracing progs call cycles without introducing more complex
>>> solutions. Relax "no same type" requirement to "no progs that are
>>> already an attach target themselves" for the tracing type. In this way
>>> only a standalone tracing program (without any other progs attached to
>>> it) could be attached to another one, and no cycle could be formed. To
>> If prog B attached to prog A, and prog C attached to prog B, then we
>> detach B. At this point, can we re-attach B to A?
> Nope, with the proposed changes it still wouldn't be possible to
> reattach B to A (if we're talking about tracing progs of course),
> because this time B is an attachment target on its own.

IIUC, the 'prog B attached to prog A, and prog C attached to prog B'
not really possible.
    After prog B attached to prog A, we have
      prog B follower_cnt = 1
      prog A attach_depth = 1
    Then prog C wants to attach to prog B,
      since we have prog B follower_cnt = 1, then attaching will fail.

If we do have A <- B <- C chain by
    first prog C attached to prog B, and then prog B attached to A
    now we have
     prog B/C follower_cnt = 1
     prog A/B attach_depth = 1
after detaching B from A, we have
     prog B follower_cnt = 0
     prog A attach_depth = 0

In this particular case, prog B attaching to prog A should succeed
since prog B follower_cnt = 0.

Did I miss anything?

In the commit message, 'falcosecurity libs project' is mentioned as a use
case for chained fentry/fexit bpf programs. I think you should expand the
use case in more details. It is possible with use case description, people
might find better/alternative solutions for your use case.

Also, if you can have a test case to exercise your commit logic,
it will be even better.

>
>>> +       if (tgt_prog) {
>>> +               /* Bookkeeping for managing the prog attachment chain. */
>>> +               tgt_prog->aux->follower_cnt++;
>>> +               prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
>>> +       }
>>> +
>> attach_depth is calculated at attach time, so...
>>
>>>                  struct bpf_prog_aux *aux = tgt_prog->aux;
>>>
>>> +               if (aux->attach_depth >= 32) {
>>> +                       bpf_log(log, "Target program attach depth is %d. Too large\n",
>>> +                                       aux->attach_depth);
>>> +                       return -EINVAL;
>>> +               }
>>> +
>> (continue from above) attach_depth is always 0 at program load time, no?
> Right, it's going to be always 0 for the just loaded program -- but here
> in verifier we check attach_depth of the target program, which is
> calculated at some point before. Or were you asking about something else?

