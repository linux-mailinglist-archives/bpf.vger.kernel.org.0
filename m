Return-Path: <bpf+bounces-7765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E377BFFD
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B749281208
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC3CA48;
	Mon, 14 Aug 2023 18:49:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83485C140
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 18:49:19 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768612E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 11:49:18 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37EHD5p8004467;
	Mon, 14 Aug 2023 18:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=JJNIDGgTos3wELEWNmjfQwz1EBupJcdB2aMdIQJx35I=; b=TsKPIjjIbUP+
	XX4AL0b5cIuGDWyN52tx5QCpWbrhOXHlQXP8Y+EmKAHZTwkcJ0kNy6t7fnzH/j92
	KEqicqxnhVR9qYO4dJIgPts98MlwCtOpxG+Q0zbHmv4vGD/IIL4Uwd3fnbA+lVpA
	qsFK5ayS59Qp+0RzRmvnwjRF5QT1HuHm768gMPGm5asyw3E3mVA96RMtGXdtwm3i
	b8CTflD3GZ4y532rKQa8kHaKEDmBosLEBy0+MEK4m6vBCVDkSPyW6hX3gQrRVv7K
	pQcNfFx2g0rzRxftCqsIgMoyCQsn9xAEdtJyVUz2tzWUoArYllWfVC1fN9sSSFtI
	DDC+7DZjkQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3sepj93asm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 18:49:03 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 14 Aug
 2023 18:48:57 +0000
Message-ID: <66c7f651-1482-e1db-2231-b35410bd1900@crowdstrike.com>
Date: Mon, 14 Aug 2023 11:48:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [External] Re: [PATCH bpf-next] libbpf: set close-on-exec flag on
 gzopen
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Marco Vedovati <marco.vedovati@crowdstrike.com>
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
 <674989d5-abc1-60fb-64ea-da25d24f935e@crowdstrike.com>
 <ZNpeU4faW3wSgDVf@google.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <ZNpeU4faW3wSgDVf@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH11.crowdstrike.sys (10.100.11.115) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: sbjuRLZN7pNAiRMGOPR-lXbRHDXcZ0VF
X-Proofpoint-ORIG-GUID: sbjuRLZN7pNAiRMGOPR-lXbRHDXcZ0VF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308140175
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 8/14/23 10:03, Stanislav Fomichev wrote:
> On 08/10, Martin Kelly wrote:
>> On 8/10/23 14:43, Martin Kelly wrote:
>>> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
>>>
>>> Enable the close-on-exec flag when using gzopen
>>>
>>> This is especially important for multithreaded programs making use of
>>> libbpf, where a fork + exec could race with libbpf library calls,
>>> potentially resulting in a file descriptor leaked to the new process.
>>>
>>> Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 17883f5a44b9..b14a4376a86e 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -1978,9 +1978,9 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
>>>    		return -ENAMETOOLONG;
>>>    	/* gzopen also accepts uncompressed files. */
>>> -	file = gzopen(buf, "r");
>>> +	file = gzopen(buf, "re");
>>>    	if (!file)
>>> -		file = gzopen("/proc/config.gz", "r");
>>> +		file = gzopen("/proc/config.gz", "re");
>>>    	if (!file) {
>>>    		pr_warn("failed to open system Kconfig\n");
>> Sorry for double-sending the patch; the first was missing the bpf-next
>> prefix and I wasn't sure if that would be an issue. Feel free to ignore this
>> patch, as the other already got a reply.
>
> Next time pls at least reply to the first 'wrong' one :-)

Yeah, I replied to this one as you had already replied to the first, and 
I didn't want to add confusion and split the conversation into two 
pieces. I saw a 40 minute or so delay before the initial patch was 
posted to vger, and I had thought "maybe it's because I was missing the 
bpf-next prefix" and then resent... only to have the initial message 
appear a few minutes later :). So, my bad, I jumped the gun.

Next time I'll make sure to add the right prefix initially and to take 
into account mailing list delay.


