Return-Path: <bpf+bounces-19194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AB827304
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3AB1F24941
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6E4C63C;
	Mon,  8 Jan 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QrqLdDWG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361851009;
	Mon,  8 Jan 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y4MEnlTx9Dk7KhHjiCM2gMag4basiFzoRieMIdpOKxE=; b=QrqLdDWG7Q7E0dzOlgVvxbxZb6
	EHH3y3oiJ9YGZbk017Ub+4VYY3qnPP92CQP92OOfFiT5svecZh4lU3KG57vxRr4xhC4ol3k5jihI8
	NDLcTvTY3UK11v402IoiDuZMAdFypmTnlDVQoNcQH0ybI12CI/IttdgEAFmaEXwdj30eQN28QGSNL
	+di5CFS58Ewu/T+/wU0tJHB1Ud6kXca5WO6LQq+W+zMxW8AU3VLqaPvCEmaO5ggUECMYaCSePzbbw
	VBOxApC6Ajku2JLLVhlVLA+aZaiMWCd1SB3G+K4fDPqixBOW5+4IRdVOSCs4FlWmhVXTY1WTg6gPW
	XjFsSz6g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rMrXD-000Bvb-4m; Mon, 08 Jan 2024 16:27:27 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rMrXC-0004Js-4Y; Mon, 08 Jan 2024 16:27:26 +0100
Subject: Re: [PATCH bpf-next v2] bpf: Return -ENOTSUPP if calls are not
 allowed in non-JITed programs
To: Jiri Olsa <olsajiri@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104130817.1221-1-yangtiezhu@loongson.cn>
 <ZZvI6g2gGRoebPiO@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <306f4ceb-0d25-d0a3-fc70-1141b6db06c8@iogearbox.net>
Date: Mon, 8 Jan 2024 16:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZvI6g2gGRoebPiO@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27148/Mon Jan  8 10:40:14 2024)

On 1/8/24 11:05 AM, Jiri Olsa wrote:
> On Thu, Jan 04, 2024 at 09:08:17PM +0800, Tiezhu Yang wrote:
>> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
>> exist 6 failed tests.
>>
>>    [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>>    [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>>    [root@linux bpf]# ./test_verifier | grep FAIL
>>    #106/p inline simple bpf_loop call FAIL
>>    #107/p don't inline bpf_loop call, flags non-zero FAIL
>>    #108/p don't inline bpf_loop call, callback non-constant FAIL
>>    #109/p bpf_loop_inline and a dead func FAIL
>>    #110/p bpf_loop_inline stack locations for loop vars FAIL
>>    #111/p inline bpf_loop call in a big program FAIL
>>    Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
>>
>> The test log shows that callbacks are not allowed in non-JITed programs,
>> interpreter doesn't support them yet, thus these tests should be skipped
>> if jit is disabled, just return -ENOTSUPP instead of -EINVAL for pseudo
>> calls in fixup_call_args().
>>
>> With this patch:
>>
>>    [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>>    [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>>    [root@linux bpf]# ./test_verifier | grep FAIL
>>    Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
>>
>> Additionally, as Eduard suggested, return -ENOTSUPP instead of -EINVAL
>> for the other three places where "non-JITed" is used in error messages
>> to keep consistent.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2:
>>    -- rebase on the latest bpf-next tree.
>>    -- return -ENOTSUPP instead of -EINVAL for the other three places
>>       where "non-JITed" is used in error messages to keep consistent.
>>    -- update the patch subject and commit message.
>>
>>   kernel/bpf/verifier.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d5f4ff1eb235..99558a5186b2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8908,7 +8908,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>>   			goto error;
>>   		if (env->subprog_cnt > 1 && !allow_tail_call_in_subprogs(env)) {
>>   			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
>> -			return -EINVAL;
>> +			return -ENOTSUPP;
> 
> FWIW I agree with John review earlier [1], also there's chance (however small)
> we could mess up with some app already checking on that

+1, the ship on this has sailed unfortunately. Tiezhu, it would be good if you could
update the selftest handling instead.

> jirka
> 
> [1] https://lore.kernel.org/bpf/6594a4c15a677_11e86208cd@john.notmuch/

