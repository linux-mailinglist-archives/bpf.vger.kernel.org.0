Return-Path: <bpf+bounces-60602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42537AD873E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79BD189C81D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0071279DB7;
	Fri, 13 Jun 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="JwjMVIzQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A099272802;
	Fri, 13 Jun 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805685; cv=none; b=aHaSAgu9+10phNMF1vbi4mluDPNs4dhCmac7eaoEo1ZtkFd9ggF/kg7bDN1fkclfZAA/WIwpYLUTef7oerRFwhuFAF7cFdNEAeXJDWWh8+fiNeENbiP2KdWr/it+6ixWOPUGEyh4iEh0+3UaDn6IfoSCpK4y3R5SzFUzUtmioT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805685; c=relaxed/simple;
	bh=d0nRz28PJt8t39/tBp8+FlGLIeidQBBqOTOjhcljsws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4Zfd9t2jacTC7/mNilmWD0xJ1zj9YcZnQbrnOWcBCid1NL9iGyqPvYjQX5QuH0qrEZfsMpWFj/AJ8JuGhC2HUVt6VGnCvqNBGafRBerIdpPnRsbHbBKhEcmDSefO4I1w4Dpn3kitcv8FsGEOV12kJyxyD+QJCn9BBJ+wPgwKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=JwjMVIzQ; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749805681; bh=yxcJ+W/1B/900NFk5AUkIrOU/OV84UCckpMYMsrXow8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=JwjMVIzQNaZj9+FbbXJzpxwSmpYa1MnqnkUMAV10FT0jGUjglDE+yZ/4/oNbufgUP
	 Lk+gUxfx0+Sa3V7D2Pfx5gXu9neAkvVaOSXvgNESxyoJm0b971Ssx3tCRwIdReRmML
	 CSwmStzLnMOXNlPnntGdGGNfvCgJAzgCemEpTW95vRhZwQG/oaVLgdBGf4szE7CenX
	 WloIm0L6ddnu+EWhrVQIL1++QQknQRDkNo1SmabAVc7H1FBLp2gZQ5sOTX//UJ07Si
	 HNLXanOoTEzqrtF6q6mAns+ppBYviP6WKxj0P1w9HJyUKpTxuRAzp4EbsAmXAvsBa6
	 7K9cWEBtwrejQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bJYTF0q5PzPjxn;
	Fri, 13 Jun 2025 11:08:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 37.201.192.232
Received: from localhost (ip-037-201-192-232.um10.pools.vodafone-ip.de [37.201.192.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+EprZ6QqAkNepeh2qpKNYCZhmROqRlwo4=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bJYTB2KNXzPkPv;
	Fri, 13 Jun 2025 11:07:58 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Remove redundant
 free_verifier_state()/pop_stack()
In-Reply-To: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
	(Eduard Zingerman's message of "Wed, 11 Jun 2025 15:36:55 -0700")
References: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
	<20250611211431.275731-1-luis.gerhorst@fau.de>
	<19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Fri, 13 Jun 2025 11:07:57 +0200
Message-ID: <878qlw3t76.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2025-06-11 at 23:14 +0200, Luis Gerhorst wrote:
> 
>>  kernel/bpf/verifier.c | 26 +++++++++++---------------
>>  1 file changed, 11 insertions(+), 15 deletions(-)
>> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d3bff0385a55..fa147c207c4b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2066,10 +2066,10 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
>>  	}
>>  	return &elem->st;
>>  err:
>> -	free_verifier_state(env->cur_state, true);
>> -	env->cur_state = NULL;
>> -	/* pop all elements and return */
>> -	while (!pop_stack(env, NULL, NULL, false));
>> +	/* free_verifier_state() and pop_stack() loop will be done in
>> +	 * do_check_common(). Caller must return an error for which
>> +	 * error_recoverable_with_nospec(err) is false.
>> +	 */
>
> Nit: I think these comments are unnecessary as same logic applies to many places.

In that case I turned `goto err` into `return NULL` directly.

>>  	return NULL;
>>  }
>>  
>> @@ -2838,10 +2838,10 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
>>  	elem->st.frame[0] = frame;
>>  	return &elem->st;
>>  err:
>> -	free_verifier_state(env->cur_state, true);
>> -	env->cur_state = NULL;
>> -	/* pop all elements and return */
>> -	while (!pop_stack(env, NULL, NULL, false));
>> +	/* free_verifier_state() and pop_stack() loop will be done in
>> +	 * do_check_common(). Caller must return an error for which
>> +	 * error_recoverable_with_nospec(err) is false.
>> +	 */
>>  	return NULL;
>>  }
>>  
>> @@ -22904,13 +22904,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>>  
>>  	ret = do_check(env);
>>  out:
>> -	/* check for NULL is necessary, since cur_state can be freed inside
>> -	 * do_check() under memory pressure.
>> -	 */
>> -	if (env->cur_state) {
>> -		free_verifier_state(env->cur_state, true);
>> -		env->cur_state = NULL;
>> -	}
>> +	WARN_ON_ONCE(!env->cur_state);
>> +	free_verifier_state(env->cur_state, true);
>> +	env->cur_state = NULL;
>>  	while (!pop_stack(env, NULL, NULL, false));
>
> Nit: while at it, I'd push both free_verifier_state() and pop_stack()
>      into free_states() a few lines below.

Both is in v2, thanks! (Also reran the syzbot reproducer with it.)

