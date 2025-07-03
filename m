Return-Path: <bpf+bounces-62214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D7AF679E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236C41C285D9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E11AA1DA;
	Thu,  3 Jul 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VrFHqAjT"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F86DDD3
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508097; cv=none; b=sGk/yCxWvHVO7kYotsn/KzHthpL1YSqCNr4xoKcMVjwGc5wsy9xwoSmpHTu3m3hFmkG3lZj/isJKRpYMSQ99hKdjJuz81OIwX3TagcCrvK9d5TnmP5afx6R7R1VItPbmIxqEO0/QHNgr1oaUq0TqIuAHi1NIwnYtlAIfuIaudbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508097; c=relaxed/simple;
	bh=IDJd6QPeQjkCmQDHXBNSnunRvfbTz46HF78NqyA8FFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4EXc7/PWQo99UzSDhsImlyr9qTTiMD3QgZOkLGpbfgztHVqZLyQU+VNpmefzcwFOqptmk83wS53WgBnp7gaR7Vbp040Egs0e0QftvyrhFiZlxf6M6KFuQKYfsRO8NUKE8tSThaAFHlRF3K3DPs6KW3O/1MJv3/joZpGufFLtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VrFHqAjT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7a1884c-5566-4356-b91c-b7c461077331@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751508091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOLFR9D5Bp2I1mES17+hlUV0HCzLqVpO5vlcU2px9Vo=;
	b=VrFHqAjTFX9bWCXVDE9apAaKCK1GttQPgC/4pxWGynvjJtnXOJuxSyLABvMK+ZBxAj9+YQ
	AviiqYwSMP1qvGxNFV4++T6rj83GG7MaFCeXKHLIr0C/VqDfjqY+aURB3SKEmxGpMS8NMD
	Swqo7HO85rXVOjQx8WWE075RtMpo7QM=
Date: Wed, 2 Jul 2025 19:01:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Avoid putting struct
 bpf_scc_callchain variables on the stack
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
 <20250702171149.2370937-1-yonghong.song@linux.dev>
 <cd208a86a068c70994461066b6d863307a5e0645.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cd208a86a068c70994461066b6d863307a5e0645.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/2/25 12:03 PM, Eduard Zingerman wrote:
> On Wed, 2025-07-02 at 10:11 -0700, Yonghong Song wrote:
>> Add a 'struct bpf_scc_callchain callchain' field in bpf_verifier_env.
>> This way, the previous bpf_scc_callchain local variables can be
>> replaced by taking address of env->callchain. This can reduce stack
>> usage and fix the following error:
>>      kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>>          [-Werror,-Wframe-larger-than]
>>
>> Reported-by: Arnd Bergmann <arnd@kernel.org>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Oh, well.
> I liked stack allocation for callchain object, because it emphasized
> its ephemeral by-value status.
>
> The changes lgtm, all places with callchain stack allocation replaced.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>>   include/linux/bpf_verifier.h |  1 +
>>   kernel/bpf/verifier.c        | 36 ++++++++++++++++++------------------
>>   2 files changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 7e459e839f8b..e2c175d608bb 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -841,6 +841,7 @@ struct bpf_verifier_env {
>>   	char tmp_str_buf[TMP_STR_BUF_LEN];
>>   	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>   	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>> +	struct bpf_scc_callchain callchain;
> Nit: maybe a comment here about this being a scratch buffer?

Maybe I can just change the variable name from 'callchain'
to 'callchain_buf' so it will be clear it is a scratch buffer?

>
>>   	/* array of pointers to bpf_scc_info indexed by SCC id */
>>   	struct bpf_scc_info **scc_info;
>>   	u32 scc_cnt;
> [...]


