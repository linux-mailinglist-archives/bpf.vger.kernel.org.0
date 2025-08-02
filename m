Return-Path: <bpf+bounces-64942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8222B189BA
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 02:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BDC563B89
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137F2CA9;
	Sat,  2 Aug 2025 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlFscboR"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110E2E371E
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092886; cv=none; b=ofF3qttIwuapjX1WP7UQVWNA1398IxVO9wVUmXih/i4CF6iYvjUDJ9AqsOzxo8Vzwl9Y6QVWIfQcaKze36gI+NRUGA8J9azbd0LCXaxtemTlf7U8fnKNdjqmJuYOl593SS4+xcybALNYGuJSEXKKdx3/3SQ3a8gnLBrjWrLrM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092886; c=relaxed/simple;
	bh=rjzkCq6DmLcQXmc1JxR9f7/G0bzlzmscB1DovrQ81+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0dtUfN6H94p/z2pN9dGUyWb39shv/x5+XRQ5eDiJmLh+QtM8PuBhyPWeO0GxVVvgkrI9spv9ZN53umNY7IUjfi/oZ4yotGLdcNZUtR1DTbmiSLJAR1qUaRltP7CvIqWtjPHFIHRBtyYN3qBiOTaNqSwMYG0TYF9l8JSxfluZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlFscboR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7804bd72-90f5-4bab-a0b9-a0aa282f2610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754092860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWvfk6Pyus5TO52Q9RiPG2DHPnI2HVx/dJWgpFUYw5A=;
	b=NlFscboR4O9KcwQNIsd9/O0GN93A3sJDfI+uvW1K7HLaiLee+cHFoy3o0TYIcxU37F5o/e
	ZGIi+PZRHs0juHL1LhkKN0/ZCof7IoRpyd7MkefaR9kk/kUMIk78dGe4388r/3NkxGyasI
	3g1IA1YIVyETH8dhOrjLoZo2pjZ16Wo=
Date: Fri, 1 Aug 2025 17:00:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 netfilter-devel <netfilter-devel@vger.kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Petar Penkov <ppenkov@google.com>,
 Florian Westphal <fw@strlen.de>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
 <91bb735f-088e-4346-9b2c-874caf0bc1ce@linux.dev>
 <CAADnVQL-YTbqG1xrdbFBEqsoJWcCKGFnx0sCNSkKJKb9shnXEA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL-YTbqG1xrdbFBEqsoJWcCKGFnx0sCNSkKJKb9shnXEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 2:47 PM, Alexei Starovoitov wrote:
> On Fri, Aug 1, 2025 at 9:31 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 8/1/25 2:49 AM, Paul Chaignon wrote:
>>> We've already had two "error during ctx access conversion" warnings
>>> triggered by syzkaller. Let's improve the error message by dumping the
>>> cnt variable so that we can more easily differentiate between the
>>> different error cases.
>>>
>>> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
>>> ---
>>>    kernel/bpf/verifier.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 399f03e62508..0806295945e4 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>>                                         &target_size);
>>>                if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
>>>                    (ctx_field_size && !target_size)) {
>>> -                     verifier_bug(env, "error during ctx access conversion");
>>> +                     verifier_bug(env, "error during ctx access conversion (%d)", cnt);
>> For the above, users still will not know what '(%d)' mean. So if we want to
> Right, but such verifier_bug reports are mainly for developers,
> and we will know what it's about especially after redundant (1) is fixed.
>
>> provide better verification measure, we should do
>>          if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
>>                  verifier_bug(env, "error during ctx access conversion (insn cnt %d)", cnt);
>>                  return -EFAULT;
>>          } else if (ctx_field_size && !target_size) {
>>                  verifier_bug(env, "error during ctx access conversion (ctx_field_size %d, target_size 0)", ctx_field_size);
>>                  return -EFAULT;
>>          }
> It's nicer, but overkill. As Paul explained if cnt > 0 && < INSN_BUF_SIZE
> it must be ctx_field_size/tager_size issue that
> needs debugging anyway with a proper reproducer.
> So making this particular debug output prettier won't help
> analysis much.

Sure. I am ok with this. Thanks!

[...]

