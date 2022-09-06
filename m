Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6535AF086
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiIFQgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiIFQgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 12:36:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AEBE14
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 09:12:25 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F3Tou028425;
        Tue, 6 Sep 2022 09:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/OjV2Q2/up+hLeL+HM0buukSC/qOXkVQ3mjcr7yLigI=;
 b=S1m5Z2z/INhPfAc+0Z8h0kv9GRS64rUVKpDMOUlhznfodNSn13dSG8Rw3cPDl0aCFJsz
 akgmgZL6y5pf8BrR2v0d8Rbc+WSde7UISI0+NA4xyqomWwfpF9sT1giHJMMnGO9UpM6K
 dTQkGpLLhpvVC566vKIzEK99CoPFDFzSLCQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jdnynne01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 09:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvWcCZLK1X8Qyx6qB/RjvqZoB2ZAp7DA1xd5kTOM+GVextdrcQAy4FStvG20nzC8yCwkmP7sNKguWlKiePFrNMmuxXW0CyeJPcfdv0CL6v1w7CJpVpXLYLsGV5JjV5UrY+RptiBMjjcvm9AYgcvqq6JCB0ZpWO5wYDUQKdTa4VIRWXmhqE3kOGdlcOZGGpkwiJaOVb76/LXdIH1V0YCKuhwdp/LfifHjfjtyT1iU6xy8bKQrSB7nBqhxgZqV5ZPJ/vDS/OU6R9Xm+OSuz46qhTP4vQ3RPmGbtEbAXmEPnby9QNWi6EtdM+4nz4L9sWeHJwvKKW3J11gcp8C0/zxVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OjV2Q2/up+hLeL+HM0buukSC/qOXkVQ3mjcr7yLigI=;
 b=Cu2y5/a8mtEQwPJSDYLeKkc+kQ09+sKAzXKsO9R823/z8oKGwv5/1Y03w7g3Vs0uIhSDXRjLCv6qvIzZE0QIcEfyAUervhM/NyArPJ7AAD9ppDTfM3QyNnliwN4j7mx3IpV5oglEyrQWHsvulg1QUjZVE0uCOt6qN2higoxGZ87NENIxyWLWXMRd2Bc2y4cPIhg20y0pi3fB3my/AI763wszd1LP3pFHoyaINOsYRBqeQY3mSSBXQT3qRwrWxpjL8OdJ0uDEmx41H44DzFabqBqzTDyS/Oqi6JNLv5WlIq3MGzV4f2j9cWlYQxTpUnUxA/nSaggnl1a5QUtybDQiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5308.namprd15.prod.outlook.com (2603:10b6:510:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 16:12:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5588.016; Tue, 6 Sep 2022
 16:12:07 +0000
Message-ID: <90ee59ae-6257-5e0e-067c-d37210a1df7f@fb.com>
Date:   Tue, 6 Sep 2022 09:12:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Update descriptions for helpers
 bpf_get_func_arg[_cnt]()
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220831152641.2077476-1-yhs@fb.com>
 <20220831152657.2078805-1-yhs@fb.com> <YxG3OVk72IaSEJd6@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YxG3OVk72IaSEJd6@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7402a23c-4939-4f98-955f-08da90228baf
X-MS-TrafficTypeDiagnostic: PH7PR15MB5308:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ze+C6YcX57zQuQL7B94Ga9SoFWfSZ99C349ivruwoPPIxi/wX1vFNnaPlQSyAsu23q+dqh320de9oRpoCgJhX5jrWbQwCj87V1ZVkd38ecfp1KJaYqaGqgQ6t5fwxjlIFKE5SXmLpa0+WJ0DH4TwcgzjXLEomL3CEGE9XXO4j5dwpAgB9RGfzaLymu8rxxXqI9sWNtLCkmBqMwvHZAxTgcETbrcjaoXJ8mX31BoBCIswbi5DTP2Pmr62SEwJZy5k347hh9zCQb1OXb8J2S5JpKRIAVKBDCdUhFrWiN7VH8DJTmD1pGylFLMmk1kmQDxEAnMxpFHPkQyXhhLOS/hVuPb17hhTytPm3hPLoqP7bp2Z0ZIUbPWy0OUfG61ioAtVtCxOXxMj1tcfIjOKgM+UlP5TB2XBy9kuoONu1isBOMSA2A1pQqO48ilfusH8nYj4IRmZzqvQZgGHbZlS10FDSnv+bDgSsGqR3jqsdFPwMjPbY7HZrDjdR5fScCqELmii7jgrqXBOAGafZUjKUdXTf1nprKddjlkapGQQy//aevzXylUDsdM5QsStMLBTFk4O3nScuQ6Fyog4PsU5n5RzEYzRS+Qv/8DuGHKgFHkjmJ6XMtfZjdn6Nx9yxMKEOmOnAPfKRDkFZHN7Z+FmGucRREwd0Mcv/C+QFJawsmQRedRngWZZi+V8q0ikKYn6r15ikCouPuszDp/sQFwLagYvimVlcSumzNeRB8NPK+U9zSut5ZJRJjik0xBojEibrNR5piyAJQZbaYh9RqI6sOK8nmQP8f763lt2S7bEPUn0MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(6486002)(4326008)(66946007)(31696002)(8676002)(66556008)(66476007)(86362001)(478600001)(316002)(54906003)(38100700002)(6916009)(41300700001)(83380400001)(6506007)(2906002)(53546011)(8936002)(5660300002)(2616005)(15650500001)(6666004)(6512007)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5GZFp4bDVFa3A2V2hCWTR4dVhuOUsza0UzWTBLMEpuNHk5NFJwYWQxc2NU?=
 =?utf-8?B?YW1GS1VieTZSTzh6RUxnY0ViaEVtTndxQ1pRLzdmc0o0cDVBWDNjeWQwRlY1?=
 =?utf-8?B?NkdSRVNyMURhY1Exd2lwTVJma0VIRlNGaER6Uzd3UGlCeHJlQ1JUcmxEdlds?=
 =?utf-8?B?c1Nyb2tsN0c3QVcxcUt0c2VrRnVwRjVEdGpXTFhlQnZrMCszVm5NM3FVblJM?=
 =?utf-8?B?VzdBZ2NWN0dMZ1JxUG0rTENPTzZNQkpGTXA2ZzRlcVdQWHJlQTNHdjZCOTF0?=
 =?utf-8?B?S25HamcyOFJTUURpclFOZ1pvRnlpd1F3czRtbjVPUXluSnFCa2lkN1hjcVJr?=
 =?utf-8?B?dlFHSndjUkZFS1YrWk5CdXhUVFZyZ1JXejV1VUU2NUVMOG4wQVBJWlRvYXJQ?=
 =?utf-8?B?dEwyQWVWN1N6S3Ztck5OaUxHUHo4bk5nall1dGVVM05jdzNkaHkrM29IQlRD?=
 =?utf-8?B?a053N01ia2JsdUtTS24wVmhtb2RrQVVmOWk0Ujh4QXdkUVFXSmRrYWVxQnh6?=
 =?utf-8?B?T2UvZDBvdGNrb21tTjhnMFFmcmZaTkJwMXY3emMxZUhPZDhsekJNK2wvZFZ2?=
 =?utf-8?B?TWN2UDlIaXRKZUp4cXhPZjBtZ1dyRWJraTJaNXdHL3YrTitmOFN6dmtmK29u?=
 =?utf-8?B?MmZzREpYeUlLVStBRlA4WXhvQmRIV1c3UDJ5UjNwTGNzUTQycnVVOUFMZ1pn?=
 =?utf-8?B?T2RIVlJYSnJlbnlwSW1uU0crNXVsLzF4TitiTXJKN3BRcTZ3YnA0ckx4c1Vk?=
 =?utf-8?B?YlkvTllyVlc4bmc1TEhRVEViVW14RmZVZ3NXRTE3Qk5ieTQ3YzUzUHVXM2dE?=
 =?utf-8?B?eXBzVEN1SFZ5c09HT2UxeUZpWkNOVDBGbzdOTU0wbUY5WGtpVUxPMkN6cmU1?=
 =?utf-8?B?dFZJVW9ScC8yd1FtNWdsVHdsWTdrRmdlQWRvUzFYZ3J6c0ZSY2xVTHlkVW9U?=
 =?utf-8?B?Zy82TlF5MzhVYVB0dWtWQ1J5dTU2azQwYlUzNlBRNXpFMHJYbXE2ZTc1Qytp?=
 =?utf-8?B?VEFMMTdKWTJzQnRhaDhMd3RXQzBXTFNPMzNFNDZyOGZ0VmdieTVWTzR5SWVv?=
 =?utf-8?B?YUcrZllZUDdTamZWUHlhRWFTbWFuUW9GQkQvSkRBeEZkNFNZQzVpckFsQURo?=
 =?utf-8?B?WVRBL2tyYW5EcjR5M0piVFQ4YzhBekVNUFdQaFpQcEdaQTB2QXpZNUdheFpQ?=
 =?utf-8?B?dlJQSUswZDlPOWg3a2FBbGF4NkQ4Z0g5VXVuSDkzTXVvbGhDbnBTQ3NoV25Y?=
 =?utf-8?B?N1hkTUJob1FoT3IyVXkvYXZSRDNZb3k1L2E5aU5kcW1ZazFvNzdvc1grQVlF?=
 =?utf-8?B?RUpqemZNMlJVc3EwcWZKOVgwMCtxQjFkVzNjbEh2b2ZHVmZKS3FxL3dpRkZ1?=
 =?utf-8?B?a0htK01XNUlVeGxnc0VzMmFNVTFxL1B3N1dITHJEYllhcld3b2tmWkN2Y2NL?=
 =?utf-8?B?VTdBNGFDN3RMSllZdFRIek5NWGtOeElDdEJrOUwvbmJMMzNVL0pEbE9PNHZk?=
 =?utf-8?B?YUNWU0lCSFRQYy9BTWxGbCtic0kxK0dRMG4zQUFLV2ZvT2I4aTMvTmJmSEpU?=
 =?utf-8?B?bWZJRStuRk8xcVltQ21YWVBGNmU1S1F0bkpQQ0l0eVFIenBFNWZLRUdwcy9w?=
 =?utf-8?B?V1ZxT2dmOXZYakhXcUJJVElLaUFrTm5YN3lvYzZQbTVxUEpnaE1yTFFsenVH?=
 =?utf-8?B?U3huQUF2d25wK1ZSL0JxdGFiWUllYTJqME5xeGRGZlJlQUx1Si9JcjFWMXdB?=
 =?utf-8?B?Q2FHd3B1aEVYMEJReUpQZm9TdE1ETEE3NW1CMTV4SUFvMHUvMHh0Si9lMmVH?=
 =?utf-8?B?VmtTenR2QmJrcjgzSk9paTcrZ1Mrb0IrOXBFTTB6N0NHNkhpeVpDZFM0dkZI?=
 =?utf-8?B?ZUVDcUVqdk81c0U1eTY5U3Jtb1VmdExKd0ZKdlplN0NMZkFvalZ6ck1xbXhT?=
 =?utf-8?B?L0NBSDA0T0pQRzlYRjJub0I3T2lmV3ZoT2RQRXNvd21JY3RqeXVjMnJBblY3?=
 =?utf-8?B?UktBcm95VU92NEZueDdPY29DY1pXbFdzc2xPdUJnckpMUjRTTFdXZThPSjRE?=
 =?utf-8?B?Q1lyQnYweCs3TWtXQndDbmNHa2YxV2RXOGRaNTlPV2pFOXRRV2RkazFSQTA1?=
 =?utf-8?Q?nyG8tC9wQ69xHID0a5z8aGbl+?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7402a23c-4939-4f98-955f-08da90228baf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:12:07.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TC6lpTuWo65nlEcoss9wBsuxLAl1DJ/7ehA3f9FNsbF0E/ncQ54FDDVp/9XG4u3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5308
X-Proofpoint-ORIG-GUID: zlAvfHBxApEjx_bd0HjCm70kxv628zvv
X-Proofpoint-GUID: zlAvfHBxApEjx_bd0HjCm70kxv628zvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/2/22 12:56 AM, Jiri Olsa wrote:
> On Wed, Aug 31, 2022 at 08:26:57AM -0700, Yonghong Song wrote:
>> Now instead of the number of arguments, the number of registers
>> holding argument values are stored in trampoline. Update
>> the description of bpf_get_func_arg[_cnt]() helpers. Previous
>> programs without struct arguments should continue to work
>> as usual.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/uapi/linux/bpf.h       | 9 +++++----
>>   tools/include/uapi/linux/bpf.h | 9 +++++----
>>   2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 962960a98835..f9f43343ef93 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5079,12 +5079,12 @@ union bpf_attr {
>>    *
>>    * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
>>    *	Description
>> - *		Get **n**-th argument (zero based) of the traced function (for tracing programs)
>> + *		Get **n**-th argument register (zero based) of the traced function (for tracing programs)
> 
> I'm bit worried about the confusion between args/regs we create with
> this, but I don't any have better idea how to solve this
> 
> keeping extra stack values for nr_args and nr_regs and have new helpers
> to get reg values.. but then bpf_get_func_arg still does not return the
> full argument value.. also given that the struct args should be rare,
> I guess it's fine ;-)

You are right. Since an argument may takes two u64 space, the helper
bpf_get_func_arg() might not return the *whole* argument any more.
But it still returns a func arg, maybe just a partial func arg.
So the 'n' here has a semantic change, instead of 'n'th argument,
it becomes 'n'th argument register. To create new helpers probably
not needed, so that is why I made the description change to the
existing helper which maintains backward compatability too.

> 
> jirka
> 
>>    *		returned in **value**.
>>    *
>>    *	Return
>>    *		0 on success.
>> - *		**-EINVAL** if n >= arguments count of traced function.
>> + *		**-EINVAL** if n >= argument register count of traced function.
>>    *
>>    * long bpf_get_func_ret(void *ctx, u64 *value)
>>    *	Description
>> @@ -5097,10 +5097,11 @@ union bpf_attr {
>>    *
>>    * long bpf_get_func_arg_cnt(void *ctx)
>>    *	Description
>> - *		Get number of arguments of the traced function (for tracing programs).
>> + *		Get number of registers of the traced function (for tracing programs) where
>> + *		function arguments are stored in these registers.
>>    *
>>    *	Return
>> - *		The number of arguments of the traced function.
>> + *		The number of argument registers of the traced function.
>>    *
>>    * int bpf_get_retval(void)
>>    *	Description
[...]
