Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F064A3C634F
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhGLTNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:13:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5780 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233504AbhGLTNN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Jul 2021 15:13:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CJ8KKa020841;
        Mon, 12 Jul 2021 12:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ytQuVGfRYWG4Js86GR2aGAbTh1y1HNoe1M1jfJe/uks=;
 b=ee+6KvM73XhbMf1kSV2GDLzXo9occ9Nx3+QMT0AwyR1qOL1ksXd+PKw9i27HBZk43ScE
 388WjJsAL6K4QSW6LfGiZ/XY0zyXDHRtUHkJQvs2Q/8Z3JSgeOmUdhCaml4z4z5EtPP0
 q0X6yi/1bqY7Cem5Tn72Gf2h0j34ddtGpjc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39q92y434y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 12:10:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwpyT9qy7Hr65FyrpuSDmPznD953F00h8ysIFo4GAbAUBZurYINIy8uMuLg8jKNA0X0aoaLE6TKAEmcthEOuXaXnhP5ecfDGzHu1JLpLC2twLmNqJhYzcZLRNlLKU8ned0hIDEr+V8HFUu/8S06QcvkKcP6nakn2H0XYHspJuxhwkJd7c01IG7f/YSEZIjVEL7oM8aai/asG2YyYyncqzWOX29KtrG+3nC98mONdVCJ+1Uia5xpkshqmN/5+z+YlGF3m4jbSNoRKPDAxjHtOXaMZCMT6WxP75oWkikpIlB4XoRIlBC8EopLudzUiXP6LiSinWLvzdYIl1aPuPgJc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQuVGfRYWG4Js86GR2aGAbTh1y1HNoe1M1jfJe/uks=;
 b=PyNlmIj3z3X/ER44wIxl4pPTTd137/yVdyCWgkMb+f/R9dCBntavUHbC6SkjTsCwwvGL8Sfp4G2wL08nbSHyR1fZjKnEP1zbW1FW7TgIlmbDx30bsy8SL1zkzaoFJvda6VFQvUmGNHibKK3JQgSERO4757y+VytcRLRrsSvMaWKqrNE5vfNXV/vocrFYfVsAtCI/D7jjkj8LgQ5WyGQPMQTTPLBRtLm4NEyie7MJq58ozTFjnHmhvaWhdPLV6G8SWCEWVeu9R14Xq7WeHG9YejqGklC+HY1prNTSkTzjv37bcquY+1FmbbwZ4gBfa4Fw8bZlBsOnqQSifnx5+CGFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2125.namprd15.prod.outlook.com (2603:10b6:805:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 19:10:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4308.027; Mon, 12 Jul 2021
 19:10:05 +0000
Subject: Re: [PATCH bpf-next v2] libbpf: fix compilation errors on ubuntu
 16.04
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20210712165832.1833460-1-yhs@fb.com>
 <60ec7bc1a4537_29dcc208e7@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <36c0e749-07da-b689-398d-1d6882b71de6@fb.com>
Date:   Mon, 12 Jul 2021 12:10:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <60ec7bc1a4537_29dcc208e7@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1156] (2620:10d:c090:400::5:9a8b) by SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Mon, 12 Jul 2021 19:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8232b1-c0a7-4d02-bac2-08d94568a80b
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2125B4EBA524F7342AE23048D3159@SN6PR1501MB2125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX8MnY/Pc32y2VLuFXDj2HxIVjpkAogB5G+8YhP80rlGerMQ63MojbP0Xm9dtFJGyG+i2iMqVvD6uY7x30ULd0mkb4qAiDLEiIVavEKC5ac/iWADdM2+E4hRHhFUD6osD3nPicVtonatbxdV1M41G5BTUC1jUUstwhUelxBxM8cMRbtvc674edSj/mi9IrsG2ZT2FeUJ0IqO24CF3YlsBjCSuyvO3RThnc9nL/x6bbn+h1DuvCEciiKumwDhtblCb8m9knJwPJ5vdpLagnL0k4rgNg5Uc0P2z2wBs3rOU9PtF+IBVLWj+wr9lIoHJuIJumwb025FVk16rr78UjIUaX4SU6FXTv1wE7srWR0gS/IdP++aA+EVa2hpd0fOvtt4/G6O8KvUKD6PqLmfwvXLTCEaITqlasyG647LkCM51NQvPDotb4bfsfCd3C51KoC0PS0fo74pVKWP3d6sU5cTo1cVSyETE/zBA9eOVSN5WZ/fbKZtI2a8XUAoyhQe7X6s6H54Pdh5q3LzyMqmQfxavz9SePmoMxckuPWgt5P6BOKVN9UdSZgAeJdUoPfIpIHsc+4/04dITE9H4+nzoC7kv4hVpNq81N593KLmTa2aovXiEu32Obk91uITtSVsfQe5aDEL0Mlu+qpUf7x80GrbWtp6rUZwFeMYqc4n5ftXt/q9Eqo5CIGrfNIg+U9SLvJEECtBXnSTelw4rAJy323OXDRsh4dpLPbhAhgKMqqbjAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(83380400001)(31686004)(2906002)(66946007)(66556008)(36756003)(186003)(478600001)(66476007)(31696002)(54906003)(5660300002)(4326008)(52116002)(8676002)(316002)(53546011)(6486002)(8936002)(38100700002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZGVmp5aVZoRkxVOG1XMXJyeHcxdzFZcEExVkFEZm5oaGRJWlFuRk0wdGN2?=
 =?utf-8?B?dVZaWjdCZGhVUHVSVUZpUjQrY1NxZ1luNUdIc3RGQXRwcDlUWXpOWGdzckZn?=
 =?utf-8?B?elFRTDJQQ0toRG80MTdtV2lxYmZuMU11VGdDODZHVXJzN2xZeFVpbDhMSHl5?=
 =?utf-8?B?a3RTOGgvYkd4Y2N0VmdmR0tZTnVWSnBZN3lYRFJSaEVXdnN6YTdvdHlTTkw5?=
 =?utf-8?B?WW0zc0VjbWVzV05USUtzeFg0RmxGYXNILzNNZys1V3NraVNhTGpNWVBnRXFM?=
 =?utf-8?B?VnVqSzBKaDMzR3Y1dGM4M0dERm90cXEwQmd6WDF0T0ZoZktnTzdlZER4N2pQ?=
 =?utf-8?B?NHEyTEhkbGpXM3JhR3RJenh1TzRvd0Fmcy9JMVkrT2plSFp5c2RMQ1RITVMv?=
 =?utf-8?B?SFV1Zys2RHJnejV2eURkVUZFZmpiVXhZMnNucHd5UE1yb0U0RG1RRmI1T0FV?=
 =?utf-8?B?SDBqdHNvanNoRCt6aUVId21CVUE0NkcxRFg3Qlk0VHIvcEtpZmpFd3pEc1Yv?=
 =?utf-8?B?QTlnL1NORHI0OTgwMGxJV2RNRkpOcEh2c3FQaGNZRUJORGo3NUJkeHlhNzBo?=
 =?utf-8?B?dFFzNVdvNGoxRkN4a0JSYWlvdS9vczBNMmF4SDlEMmJ4NlBYZk5MMEVMQUQ3?=
 =?utf-8?B?UXJOQnkxTzQ4ZkRiVHV4bXBlUTVBeGQ4b3NRb3dCdmNscEYzZFgxeFhleG82?=
 =?utf-8?B?TTJPcm1uR0x1RkdSYVl3aGErTC80TkVwSXpZUm5Pc3V5MjVkdkJ4YmhqUXB1?=
 =?utf-8?B?M2dtMEM4YlRXL1g3Q3hwaHR1Wk5GZTRmSTVNaE9KN0dDQVIxM2NNc0RKcnBr?=
 =?utf-8?B?L09hMks0WlhMdk9xOXlWemtwbTNBSThyOVRlZms3NlpyZGRyLy90UVZHZ3Mx?=
 =?utf-8?B?ckh4dllKVTBxNlYrcm5RRWxqSi9oSHBjaFM3emhkaGRNWHVWYU1JRzZLWERL?=
 =?utf-8?B?NWRXV2FjQWdVR1JKMVJxY3BObUhNWWkyQWlzVGVHOUJacTQ3b01xOWpuQ1F6?=
 =?utf-8?B?Qm1YZHdzSFUvUTYzZTdGdVY2S0lFSEZQcXZ4S0FUVnFLSHE0a0NkTTNrWFU2?=
 =?utf-8?B?NXVubitoL2EyTlQyRENYUjlPOWN3LzlpQ3d1T1RHWUZOaXZXNjdXL3FIOHI3?=
 =?utf-8?B?bjdpbHZGTk1NaUdrd0ROTGlXUDdnNzZaRkpCUmhTWjl5WnhBRHkzQmtaQ2Q5?=
 =?utf-8?B?QWkxTUNwaGlUY0tuM2xPR2lMYWhsZU5qQnhqaHZYVXA0N3dGYURIVjdpeGxx?=
 =?utf-8?B?MUxYWnBDK3hDdzNrK3hDNk9ObXg5c01oclNaZG0zdHU1RExkYWN0U3hKK2Rk?=
 =?utf-8?B?cjNVRjRub3Zxb3RXdGdrVmQzL3IwZ1BweGZWSEp4MGdqanpzTWExZGFqVnFh?=
 =?utf-8?B?aTNxQXJjVUhqejJDdDNYTHJkY1NOMjNabUpoM2M5RDZXQUVMTG1CL1BOSWF1?=
 =?utf-8?B?dGN3d2N3bmQxNVlzRFhyMG9vaitEV2hwYkhFb2hrNmNyeE81cksrd2I5U3hM?=
 =?utf-8?B?bFVQdkxUMFNnSUwyK3B1dmJ0ODdISjVIY3VRV2F5VnJaeFVMZTlDbldUVngx?=
 =?utf-8?B?UUlaUjRSZXE2R1d3QmpVRmdBSVMyeDVXdDgzTkZjS3JKczBrUG80TUY0Tkw3?=
 =?utf-8?B?anFJT2VzYkdpNVVuK1RZajZhaGZ4UkxmUW10MElhQXBjVFNJNkNNK0VBVWJx?=
 =?utf-8?B?cEZqVkpaak5ybTVlc0d4QmhWM0NHZ1N5L2hVZlNHNG5NSTZoV2VXUUZyS1or?=
 =?utf-8?B?b0ZZbUw5K3owMC9reDV3c0l6V1MwUEZ5VHhhVk9WZzBOL0l1RnQ1bnpVd3dB?=
 =?utf-8?B?cXEvRnZONjNzbFpJcEo4UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8232b1-c0a7-4d02-bac2-08d94568a80b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 19:10:04.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OUXuHAlZ120KWsHEZNe3flCdlKMsvaXm9TmSQNtyZN1i6qBQABny0qf3I5M1Msw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2125
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -bCcmbFUtn1stP0p278UtI3na09YD3uV
X-Proofpoint-ORIG-GUID: -bCcmbFUtn1stP0p278UtI3na09YD3uV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_11:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/12/21 10:28 AM, John Fastabend wrote:
> Yonghong Song wrote:
>> libbpf is used as a submodule in bcc.
>> When importing latest libbpf repo in bcc, I observed the
>> following compilation errors when compiling on ubuntu 16.04.
>>    .../netlink.c:416:23: error: ‘TC_H_CLSACT’ undeclared (first use in this function)
>>       *parent = TC_H_MAKE(TC_H_CLSACT,
>>                           ^
>>    .../netlink.c:418:9: error: ‘TC_H_MIN_INGRESS’ undeclared (first use in this function)
>>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>>             ^
>>    .../netlink.c:418:28: error: ‘TC_H_MIN_EGRESS’ undeclared (first use in this function)
>>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>>                                ^
>>    .../netlink.c: In function ‘__get_tc_info’:
>>    .../netlink.c:522:11: error: ‘TCA_BPF_ID’ undeclared (first use in this function)
>>      if (!tbb[TCA_BPF_ID])
>>               ^
>>
>> In ubuntu 16.04, TCA_BPF_* enumerator looks like below
>>    enum {
>> 	TCA_BPF_UNSPEC,
>> 	TCA_BPF_ACT,
>> 	...
>> 	TCA_BPF_NAME,
>> 	TCA_BPF_FLAGS,
>> 	__TCA_BPF_MAX,
>>    };
>>    #define TCA_BPF_MAX	(__TCA_BPF_MAX - 1)
>> while in latest bpf-next, the enumerator looks like
>>    enum {
>> 	TCA_BPF_UNSPEC,
>> 	...
>> 	TCA_BPF_FLAGS,
>> 	TCA_BPF_FLAGS_GEN,
>> 	TCA_BPF_TAG,
>> 	TCA_BPF_ID,
>> 	__TCA_BPF_MAX,
>>    };
>>
>> In this patch, TCA_BPF_ID is defined as a macro with proper value and this
>> works regardless of whether TCA_BPF_ID is defined in uapi header or not.
>>
>> I also added a comparison "TCA_BPF_MAX < TCA_BPF_ID" in function __get_tc_info()
>> such that if the compare result if true, returns -EOPNOTSUPP. This is used to
>> prevent otherwise array overflows:
>>    .../netlink.c:538:10: warning: array subscript is above array bounds [-Warray-bounds]
>>      if (!tbb[TCA_BPF_ID])
>>              ^
>>
>> Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/netlink.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> Changelog:
>>    v1 -> v2:
>>      - gcc 8.3 doesn't like macro condition
>>          (__TCA_BPF_MAX - 1) <= 10
>>        where __TCA_BPF_MAX is an enumerator value.
>>        So define TCA_BPF_ID macro without macro condition.
>>
>> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
>> index 39f25e09b51e..e00660e0b87a 100644
>> --- a/tools/lib/bpf/netlink.c
>> +++ b/tools/lib/bpf/netlink.c
>> @@ -22,6 +22,24 @@
>>   #define SOL_NETLINK 270
>>   #endif
>>   
>> +#ifndef TC_H_CLSACT
>> +#define TC_H_CLSACT TC_H_INGRESS
>> +#endif
>> +
>> +#ifndef TC_H_MIN_INGRESS
>> +#define TC_H_MIN_INGRESS 0xFFF2U
>> +#endif
>> +
>> +#ifndef TC_H_MIN_EGRESS
>> +#define TC_H_MIN_EGRESS 0xFFF3U
>> +#endif
>> +
>> +/* TCA_BPF_ID is an enumerate value in uapi/linux/pkt_cls.h.
>> + * Declare it as a macro here so old system can still work
>> + * without TCA_BPF_ID defined in pkt_cls.h.
>> + */
>> +#define TCA_BPF_ID 11
>> +
>>   typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nlattr **tb);
>>   
>>   typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlmsg_t,
>> @@ -504,6 +522,8 @@ static int __get_tc_info(void *cookie, struct tcmsg *tc, struct nlattr **tb,
>>   		return -EINVAL;
>>   	if (!tb[TCA_OPTIONS])
>>   		return NL_CONT;
>> +	if (TCA_BPF_MAX < TCA_BPF_ID)
>> +		return -EOPNOTSUPP;
> 
> I'm a bit confused here. Generally what I want to have happen is compilation
> to work always and then runtime to detect the errors. So when I compile my
> libs on machine A and run it on machine B it does what I expect. This seems
> like a bit of an ugly workaround to me. I would expect the user should
> update the uapi?

The reason is due to the declaration
           struct nlattr *tbb[TCA_BPF_MAX + 1];
so I have to have the above to check to ensure we
don't have out-of-bound access.

Alternative, I can redefine macro TCA_BPF_MAX to be the value
based on the *current* repo, we should be fine, I think.

> 
> Or should we (maybe just libbpf git repo?) include the defines needed? The
> change here seems likely to cause issues where someone compiles on old
> kernel then tries to run it later on newer kernel and is confused when they
> get EOPNOTSUPP.

That is true. Compiling in old system and then using in new system
might have issues.

> 
> Did I miss something? What if we just include the enum directly and
> wrap in ifndef? This is how I've dealt with these dependencies on
> other libs/apps.

As I am mentioned in the commit message, we cannot use a simple
ifndef to control including the enum since header file in the old
system contains *some* enumerators. Testing whether a particular
enumerator should be included requires some arithmetic (minus) in the 
macro condition and some compiler (e.g., gcc 8.3) does not like it.

But I think by defining TCA_BPF_MAX explicitly should solve
the problem. Will send a new patch soon.

> 
>>   
>>   	libbpf_nla_parse_nested(tbb, TCA_BPF_MAX, tb[TCA_OPTIONS], NULL);
>>   	if (!tbb[TCA_BPF_ID])
>> -- 
>> 2.30.2
