Return-Path: <bpf+bounces-61582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C0AE902C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9B54A58B4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55E221773F;
	Wed, 25 Jun 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="OjTiqBEU"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054F2147F5
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886655; cv=none; b=qVrG8JFt6B/tR28cug8jgekDMM8+s0Anala8q1ZsbIyhZyXktvhy/xB8Pf9s9M84oUlqsnRkChClvFL1O//9MmjJ/jLkBcxUd6gEc2BHg961FmsahLwnGUFyKFcf1JHDvhGz3Z7Fil6LyHhliMv8PkEoC3g2MDs4yVwadkS2g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886655; c=relaxed/simple;
	bh=DEiZtGmzCLBlTxDoxXEBl743d/THveWVubpq8eT0QpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFpzFQFSVGdZzErS+uZDGQJOxpHmGKYkpgR/E5oWVOhh1IpSmCrbIFjhhTAHQ6sL9DeZubTN3IiOFW+ShWJTFARBNDckhghw9a28/berbHmn0ApsBWsru/rcDT9r57/FiActWnhqV5KJ4x0TYQFVybYccIFC85mMvPhrvN44aE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=OjTiqBEU; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750886307; bh=hOKv6dtUjzlAb1C3ubbdEfI1d+M2aNgh/6m4tTOS8CU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=OjTiqBEUgFP6jDRWac6RddtWXfVPMv78S2Y44vivkYX+hjGhQ0PLo41Wgw4dLqRod
	 3Syf8XxOlP6cQsfGpgA+OUtpl1ATZILeR1I7hzcAHraHIeWB4inXpTXsD6ys/BU3ku
	 yPjnfQWufxVcskOW7dnb1M87Bqnwi0GbkSMsiqBKzzrwUZ85z6ybJauoqXfEvHFCZd
	 1JFNmOjICnF2GAXfNnG3QhKzhJc/eeb9FslfRu46TIN3nvYnCvb7nmZbD9YGGo2Dez
	 LfcCmujnGsVLtGg/M0LwpblZlMJ5z8QtAk+3u5iAHxikWlIGpTDNr6xyg5wn6P3RLT
	 hY1QpFh7OWpxg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bSF6W4D3gz2128;
	Wed, 25 Jun 2025 23:18:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3631:9e00:b010:1411:53ca:5fd9
Received: from localhost (unknown [IPv6:2001:9e8:3631:9e00:b010:1411:53ca:5fd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19SPchGhqf2cfI0vf21mB3oFUHVOSfSYMk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bSF6S4MQzz20XH;
	Wed, 25 Jun 2025 23:18:24 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>,  bpf@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative path
In-Reply-To: <402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
	(Eduard Zingerman's message of "Wed, 25 Jun 2025 13:19:01 -0700")
References: <aFw5ha9TAf84MUdR@mail.gmail.com>
	<402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 25 Jun 2025 23:18:23 +0200
Message-ID: <875xgj4j1c.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2025-06-25 at 20:01 +0200, Paul Chaignon wrote:
>> Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") added a
>> WARN_ON_ONCE to check that we're not skipping a nospec due to a jump.
>> It however failed to take into account LDIMM64 instructions as below:
>>
>>     15: (18) r1 = 0x2020200005642020
>>     17: (7b) *(u64 *)(r10 -264) = r1
>>
>> This bytecode snippet generates a warning because the move from the
>> LDIMM64 instruction to the next instruction is seen as a jump. This
>> patch fixes it.
>>
>> Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
>> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
>> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
>> ---
>>  kernel/bpf/verifier.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 279a64933262..66841ed6dfc0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19819,6 +19819,7 @@ static int do_check(struct bpf_verifier_env *env)
>>  	int insn_cnt = env->prog->len;
>>  	bool do_print_state = false;
>>  	int prev_insn_idx = -1;
>> +	int insn_sz;
>>
>>  	for (;;) {
>>  		struct bpf_insn *insn;
>> @@ -19942,7 +19943,8 @@ static int do_check(struct bpf_verifier_env *env)
>>  			 * to document this in case nospec_result is used
>>  			 * elsewhere in the future.
>>  			 */
>> -			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
>> +			insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>> +			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + insn_sz);
>
> Could you please elaborate a bit?
> The code looks as follows:
>
>                  prev_insn_idx = env->insn_idx;
>                  ...
>                  err = do_check_insn(env, do_print_state: &do_print_state);
>                  ...
>                  if (state->speculative && cur_aux(env)->nospec_result) {
>                          ...
>                          insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>                          WARN_ON_ONCE(env->insn_idx != prev_insn_idx + insn_sz);
>                          ...
>                  }
>
> The `cur_aux(env)->nospec_result` is set to true only for ST/STX
> instructions which are 8-bytes wide. `do_check_insn` moves
> env->isns_idx by 1 for these instructions.
>
> So, suppose there is a program:
>
>      15: (18) r1 = 0x2020200005642020
>      17: (7b) *(u64 *)(r10 -264) = r1
>
> Insn processing sequence would look like (starting from 15):
> - prev_insn_idx <- 15
> - do_check_insn()
>   - env->insn_idx <- 17
> - prev_insn_idx <- 17
> - do_check_insn():
>   - nospec_result <- true
>   - env->insn_idx <- 18
> - state->speculative && cur_aux(env)->nospec_result == true:
>   - WARN_ON_ONCE(18 != 17 + 1) // no warning
>
> What do I miss?
> Could you please add a test case?

Thanks for looking into it.

Yes, ldimm64 should not require a nospec_result as it can not be subject
to SSB. Should be as in
https://github.com/kernel-patches/bpf/pull/9193/files (ignore the arm
failures, these are because of the BUG in the test)

I will continue looking into it tomorrow if you don't want to.

