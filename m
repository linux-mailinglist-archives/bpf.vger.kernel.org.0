Return-Path: <bpf+bounces-9297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE9793104
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 23:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B8D2812A0
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E163101C1;
	Tue,  5 Sep 2023 21:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC3DF6E
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 21:38:31 +0000 (UTC)
Received: from out-223.mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023FC185
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 14:38:30 -0700 (PDT)
Message-ID: <6ad30137-c7d7-884b-c19e-e16288984d57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693949909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfptWl/s1atqi3XO0dXXzLTryT1h+Nv8xL9FirXe9es=;
	b=o27bh+yVKqUGlGitwiabSsIdDElCy+P60ie8Z/gXDqEzpsU070xnMihCiNm1R3tho9StF8
	B4ItLM04MyIqHYCzPyGV2vwVSGkB+oAqBSzr0teCdJuVygd4oMOCIvYIhBL6xsaulHqxeS
	OPdb1OGFdALWDFFlgrDFiXOHO5QTsfA=
Date: Tue, 5 Sep 2023 14:38:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-5-daan.j.demeyer@gmail.com>
 <52177bd8-65a5-ef4d-b00d-47509855c3e4@linux.dev>
In-Reply-To: <52177bd8-65a5-ef4d-b00d-47509855c3e4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/5/23 12:02 PM, Martin KaFai Lau wrote:
>> @@ -1766,14 +1787,37 @@ static int unix_getname(struct socket *sock, struct 
>> sockaddr *uaddr, int peer)
>>       if (!addr) {
>>           sunaddr->sun_family = AF_UNIX;
>>           sunaddr->sun_path[0] = 0;
>> -        err = offsetof(struct sockaddr_un, sun_path);
>> +        addr_len = offsetof(struct sockaddr_un, sun_path);
>>       } else {
>> -        err = addr->len;
>> +        addr_len = addr->len;
>>           memcpy(sunaddr, addr->name, addr->len);
>>       }
>> +
>> +    if (peer && cgroup_bpf_enabled(CGROUP_UNIX_GETPEERNAME)) {
>> +        err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
>> +                         CGROUP_UNIX_GETPEERNAME);
>> +        if (err)
> 
> UNIX_GETPEERNAME can only have return value 1 (OK), so no need to do err check 
> here.
> 
>> +            goto out;
>> +
>> +        err = unix_validate_addr(sunaddr, addr_len);
> 
> Since the kfunc is specific to the unix address, how about doing the 
> unix_validate_addr check in the kfunc itself?

When reading patch 3 again, the kfunc has already checked the addrlen with the 
UNIX_PATH_MAX. It should be as good as unix_validate_addr() check considering 
the kfunc can only change the sunaddr->sun_path?



