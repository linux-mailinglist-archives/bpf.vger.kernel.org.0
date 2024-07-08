Return-Path: <bpf+bounces-34050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A83929E2F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06B3B21C43
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B638FB0;
	Mon,  8 Jul 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="OUZwZNkU"
X-Original-To: bpf@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1F481B4;
	Mon,  8 Jul 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426844; cv=none; b=Y9SUXV7ySxZkun+F1CdT289mxvW5ANUi3AwTUOay8QIehpX4rpOFPD9YaH0pDtWc33ptpLkQYGYK2ww2R6mltwmagw+AmjuNLgYdYbiSWxsTDm1oCBOctQ2tNuakBCmg+Z8sA+pioftHkChFlw4Y4CawsnM4ue8vT1PXatpOx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426844; c=relaxed/simple;
	bh=jsjA2w2tuCyc0S3i6dcfthTOHKejeUdEeiJCj0gu6xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFCPjjArhmIr8VjJUCDaE4wbrdSzWTulCs6GabRObQwFsFICs93AQcdzNmvJcvhNHwj2VFp02QbgtcQ9MBELLntrIahQs81r8eWoeMc3sbj33UFsYX5XO29AAgf16Q1/1sBomv5vyMVHc8JPRqGOY8CPQrV1jBLUIimCLqnGQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OUZwZNkU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=DQyi8H+P/p/fhoombAxqVcGrAB/hkjbMv7lfmWP5EsA=;
	t=1720426842; x=1720858842; b=OUZwZNkU3Y79COL5B+fVktYNG4efb3rgU/jYTcSiDpYgRpI
	dDHyzFYdqH0ILFIYfwLKpG+E6d7pQTfzSYoxPQAwvoHlmRrMI5eORwzXKUwgjlius6kRrzVfNQTVl
	RUfsAp+S39MKEJt0eLv6e6RcwzvqtypZuB8yk2+8d1vD8I0ZMUHcDd+bgfa1+2cJZBw4izi+tb7Nu
	ys3NokyjtU8QZm+rVJ2KmIf64aQ2i22OXc02y9Y9mk2Ri2sQ4fKLKfp5b1GFl3s+KxQh7jfaaId2c
	jYONOT2xoD9z87cwEhT9Gi043UtA0vgd9XqPuE+Ess63HB466opDf36Wkpx2LzFg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sQjbv-0000dn-3S; Mon, 08 Jul 2024 10:20:35 +0200
Message-ID: <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info>
Date: Mon, 8 Jul 2024 10:20:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Christian Kujau <lists@nerdbynature.de>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240612-master-v1-1-a95f24339dab@gmail.com>
 <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720426842;145f35d6;
X-HE-SMSGID: 1sQjbv-0000dn-3S

[CCing the regressions list and people mentioned below]

On 12.06.24 16:53, Alexei Starovoitov wrote:
> On Wed, Jun 12, 2024 at 2:51 AM Mohammad Shehar Yaar Tausif
> <sheharyaar48@gmail.com> wrote:
>>
>> The original function call passed size of smap->bucket before the number of
>> buckets which raises the error 'calloc-transposed-args' on compilation.
>>
>> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>> ---
>> - already merged in linux-next
>> - [1] suggested sending as a fix for 6.10 cycle
> 
> No. It's not a fix.

If you have a minute, could you please explain why that is? From what I
can see a quite a few people run into build problems with 6.10-rc
recently that are fixed by the patch:

* Péter Ujfalusi
https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/

* Christian Kujau
https://lore.kernel.org/bpf/48360912-b239-51f2-8f25-07a46516dc76@nerdbynature.de/
https://lore.kernel.org/lkml/d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdbynature.de/

* Lorenzo Stoakes
https://fosstodon.org/@ljs@social.kernel.org/112734050799590482

At the same time I see that the culprit mentioned above is from 6.4-rc1,
so I guess it there must be some other reason why a few people seem to
tun into this now. Did some other change expose this problem? Or are
updated compilers causing this?

Ciao, Thorsten

>> [1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
>> ---
>>  kernel/bpf/bpf_local_storage.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index 976cb258a0ed..c938dea5ddbf 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>>         nbuckets = max_t(u32, 2, nbuckets);
>>         smap->bucket_log = ilog2(nbuckets);
>>
>> -       smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
>> -                                        nbuckets, GFP_USER | __GFP_NOWARN);
>> +       smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
>> +                                        sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
>>         if (!smap->buckets) {
>>                 err = -ENOMEM;
>>                 goto free_smap;
>>
>> ---
>> base-commit: 2ef5971ff345d3c000873725db555085e0131961
>> change-id: 20240612-master-fe9e63ab5c95
>>
>> Best regards,
>> --
>> Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>>

