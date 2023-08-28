Return-Path: <bpf+bounces-8867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15E78B975
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32F2280F04
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8B14A89;
	Mon, 28 Aug 2023 20:22:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920B134D4
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 20:22:02 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8FA8
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 13:22:01 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SFeV9F007127;
	Mon, 28 Aug 2023 20:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=30OBwUqlQzHwI04ilvYqDtWEtA2emzyi1FvRoJt5sLs=; b=UJLK17kLDMGH
	GyWVLmfRLSZG7JVRJMUZi8R9Ve9KUakMXQZaZR+YMCyMQiwAKVW+SQIu6BEheN+X
	a9MJf2pCxkaXp49U0dqjUzeOu4Xbj9vdZVOUSnUAjH+8Hdqdsctpxe2UwOzkca70
	Gc/t0ypTm9wYxme0raXxxCoV9i2rv6EiRIaiNLsxIEqH1VsCQU5wyrh8YRVgby8a
	46HB8HMPLLav4QuIdhu3CVHFAa52rEJibA9KLzFTIG99erNfOYdJtgzmfLfZ8Z76
	zayMcYW6CRk3UKj+Yv9+mVjI1lccC0QLCh/cJYhNYNvcsukMN3gkPBpmS9Y8GSQ9
	YnUooRLehg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3sqvmwkm32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 20:21:40 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 28 Aug
 2023 20:21:38 +0000
Message-ID: <c109eeeb-9db7-3a7a-f815-412f412968a3@crowdstrike.com>
Date: Mon, 28 Aug 2023 13:21:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf] libbpf: soften BTF map error
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
 <5806e499-069f-18f4-2af0-5d9bd8bfa05e@iogearbox.net>
 <2e6c5f26-7ef9-f97f-44dc-03967b3326ea@crowdstrike.com>
In-Reply-To: <2e6c5f26-7ef9-f97f-44dc-03967b3326ea@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04wpexch04.crowdstrike.sys (10.100.11.94) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: _RFEfQS_SvkzvYQRXUZs9gupz3mHBsqY
X-Proofpoint-ORIG-GUID: _RFEfQS_SvkzvYQRXUZs9gupz3mHBsqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308280176
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 10:07, Martin Kelly wrote:
> On 8/17/23 07:17, Daniel Borkmann wrote:
>> On 8/16/23 7:30 PM, Martin Kelly wrote:
>>> For map-in-map types, the first time the map is loaded, we get a scary
>>> error looking like this:
>>>
>>> libbpf: bpf_create_map_xattr(map_name):ERROR: 
>>> strerror_r(-524)=22(-524). Retrying without BTF.
>>>
>>> On the second try without BTF, everything works fine. However, as this
>>> is logged at error level, it looks needlessly scary to users. Soften
>>> this to be at debug level; if the second attempt still fails, we'll
>>> still get an error as expected.
>>>
>>> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
>>
>> nit: $subj should be for bpf-next instead of bpf
>
> I had purposefully sent to "bpf" instead of "bpf-next" as it felt like 
> a fix, but I'm fine with "bpf-next" instead if that's better.
>
>>
>>> ---
>>>   tools/lib/bpf/libbpf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index b14a4376a86e..0ca0c8d01707 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -5123,7 +5123,7 @@ static int bpf_object__create_map(struct 
>>> bpf_object *obj, struct bpf_map *map, b
>>>             err = -errno;
>>>           cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
>>> -        pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying 
>>> without BTF.\n",
>>> +        pr_debug("bpf_create_map_xattr(%s):%s(%d). Retrying without 
>>> BTF.\n",
>>>               map->name, cp, err);
>>
>> There are also several other places with pr_warns about BTF when 
>> loading an obj. Did
>> you audit them as well under !BTF kernel? nit: Why changing the fmt 
>> string itself,
>> looked ok as-is, no?
>
> This message is actually printed even for a BTF-supported kernel. 
> Basically, the first call to bpf_create_map_xattr using BTF *always* 
> fails for map-in-map types, printing this message, and then the second 
> always succeeds. So this isn't really about BTF support but simply 
> about an over-zealous message.
>
> I changed the format string because calling this an "Error" feels (to 
> me) unnecessarily alarming, given that this is totally normal 
> behavior. I'm OK keeping the "Error in" part if you think that's 
> better. The most important thing to me was that, when the program 
> loads successfully, we shouldn't be logging to stderr and scaring the 
> user.
>
> Let me know if you'd like me to keep the "Error in" part for a v2 patch.
>
>>
>> There is also libbpf_needs_btf(obj), perhaps this could be left as 
>> pr_warn similar
>> as in bpf_object__init_btf() - or would this still trigger in your case?
>
> I think this one should stay as a warning, as it looks like the code 
> path is a fatal error, and if you try to load a BTF-requiring program 
> but don't have BTF, that seems like an error to me. This patch was 
> more about an error being logged 100% of the time in a totally normal, 
> non-fatal, BTF-supported case due to the quirks of map-in-map types 
> and BTF.
>
>>
>>>           create_attr.btf_fd = 0;
>>>           create_attr.btf_key_type_id = 0;
>>>
>>
>> Thanks,
>> Daniel

(ping) any thoughts on the above? I'm happy to send a v2 patch but want 
to make sure we're on the same page with what should be in it.


