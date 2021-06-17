Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4083AB9C7
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFQQe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 12:34:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41028 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhFQQe6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 12:34:58 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HGS73n032307;
        Thu, 17 Jun 2021 09:32:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xW3emhXeTEKWCaSFfooyaZOZT6ghiSVA23IPT0Y5wJ0=;
 b=Ju1C/Qrn4igFGJKd4gOklmp48vBExPWq1zGV7CpC9DcE3oNm+x2c+bUD3jd3oN24zBxH
 IwhW0pyPJK3PQQKaMq20OVbPDCsLSfOL7VaDgRZHevciPw1fVJX90wvYG4hqeMpyVazk
 6qhlxef1Q5VchOT7WYEl6p8H8fAf5JF2gkM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 397mfpyv4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 09:32:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyJB2jDyeyLjdiIkn54YwP7zZLv9NHKbj8fm1UxCl6DqaEoODH+uQFpCEm74FXTv3WcYwxW4740NJ4nt4RxEvXh/6ZgSpKheGTJMjONe75cecJ4TlBHmTYWzqp6m8uug+IjyxlGqYs1mM7ByD4H3nMgik5btyrXWSy/aa7u/E0maBC3tzPchVle/NUZMP2f2/Z4xQbz7xE19L7VFwcZearG0I8zuypIi20itMjzrHqhBOakEz2Tmj1tCiXLDjVW0CnWxM8sbw50oUjN3IRkhZ4A+dzNQYy1xQW21w9rOf6A7ohppx8qMpDDOOB14t4Ut/qFspsdHEtphaV5Ww6s9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW3emhXeTEKWCaSFfooyaZOZT6ghiSVA23IPT0Y5wJ0=;
 b=YW2SNdui5ZATQqD5pDUnhTe3tegaoEaJt2DB7foq6FOnLA9hC4ye6XpScUbPVU5dyQIdkAHmE6VXzuWr4EM7O56zxlQL74vbPWzJOBczj4AATIxY58mHRNjlBo9Yct113dQIqYl8H5mQYt3rzCrRPQzsMSEofFsKdj5WObq+4v/EV1VmaFlxmjfZSaYVdPGgoQmC+694nY1fGDREpdYvHyEOjx8hxzg+zrPvP5Kz23hfFo/DdxPAlEbuB6nT/cmgL9YiI0mA7K/2cEPDQgmBmXM2iqd3Vwls4vxLhjwVUkhj1kKwiL/vL1nQcWMFp6HK/VnQ8AtZHVuh1fKa+0IXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1228.namprd15.prod.outlook.com (2603:10b6:3:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:32:48 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::b0e1:ea29:ca0a:be9f]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::b0e1:ea29:ca0a:be9f%7]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 16:32:48 +0000
Subject: Re: R1 invalid mem access 'inv'
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
 <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com>
Date:   Thu, 17 Jun 2021 09:32:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:3b8a]
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:3b8a) by BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:32:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1c02c1-c44f-466e-1b4e-08d931ad8b20
X-MS-TrafficTypeDiagnostic: DM5PR15MB1228:
X-Microsoft-Antispam-PRVS: <DM5PR15MB12288A657EDF2988EB670F81D30E9@DM5PR15MB1228.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1HyvXgDY7NAT9Wj/j+aZeTp9LZQjcFasYgvYki2rRjR3VBxHADBCmKmQXBwB6qx1Jo9t9vncUyTme1gBNRZayIDvWzpSzSitsUD81jUXDMbRVXLkzrpHbXlJwL6OJ20ukqJYo7qSj+Aq7BwQKJRMEWShOd+of1ze3eIXfaSbuC9Ut4N3VyQpzS6oPqtIaY6La3TfIstLP599IZ7cKBLevYKtR6LOfN2W1/aFrKZIiJNZJt0rk5th90IZuAvkFHVRvDST8R0RX3o4rOCtvZE1PKoqBF4yGpJ8KwKnlFheLTnt0Ew8zj0AFERbL2FodXoeIdkwSIYwlLeU2vaBFjXjysQXJDwXIy7VRJvkMkaa0uECVi8KaFwaUkUdcY+67r0dCKd2yImOEUmnV24GJkfogvDwX1jBpG1LHMczDrsZI9K6A1+S44yy/gDLLYgKdi9ODYdVLJ7Cz94YseS+taRs3Q3UEAHvaIGOnxkAdvhZz78hy73sOCCdhPU70wNraZKe3TpJ/SqneFC2VlybIZ/Q6MmHys5t0ZKmEk0Nh7RNLfSWHG4Xr10XXEO9YoyZ25SPahehG5T1iTapfuNv9vAkT4FtFjHkZ7HWZjFzx3fsgSVpXM/BuEdjV+hmdMF+lP5t+ZYd13JfBAqDvypuX0mBJ7sHd0pni1T9CB50FqRxeILJwdAw+59E6RDgsr/MiOmcz4+ae7c1HR8IXN5QOFe2phWVIGk3ZYYPkEseQRnHPWhasAKUgfRjfiw3lMKLwUncmboQfKe8HwqOH6mfFpYQd5Y1LYzMZPv39SVQdn3hlvEHfnKYxx7/okrFJpiz0nburkwO2QwUlYdtz7VpzeW5plSrky83gXFCuLD+3CtOlUVrII1S9giCdpRf7IlvOlz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(38100700002)(8936002)(6916009)(5660300002)(52116002)(31686004)(186003)(6486002)(2616005)(53546011)(36756003)(16526019)(6666004)(8676002)(4326008)(966005)(30864003)(86362001)(66946007)(31696002)(66556008)(66476007)(83380400001)(2906002)(316002)(478600001)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRrUmJYRlZJYW8xVWNFTS9UZnN4RktrVzU3cCtWRFEvdEoxSnNWUjhXbTFi?=
 =?utf-8?B?SHFsbkFEL1ByMHZMVldVc1k1Z3Fjbjg5bGFCYkk2a1YvSWZURUpxZXl1QzZ5?=
 =?utf-8?B?aURwaVl2SGpqMGFwRmJqZVRoMkVtV0kvdC9pOC9DMUtIVjgxZWZpaUlQSjhH?=
 =?utf-8?B?SGozdTd4K0pnODJkTHBEVDlIQWdrU3R6V2VVZEdCV3l4YktoYWRFdFYzc1hh?=
 =?utf-8?B?WXpITHAwUG9FOS9xWlFGYUZ3RzFHcWJDZ2Qwa2RyczdxSFRmNDRZZ0tpOEVQ?=
 =?utf-8?B?Y0xaL3AxY1pvTjFkMVpHckMyMWV6a05pdWVhQmhMRWpBUllhTUhKZFJQQWFi?=
 =?utf-8?B?NmxPdmFZeXV3VmNyWmZPcGhqbUVUUEtwbEEyKzBZcjJRV2wvRiszSnIzWGdr?=
 =?utf-8?B?czFlaHcvbDFiNHdYeU5IUm93b0pEU1E5WlNpQW5kWFpjQTRRS09lUWlpNnRV?=
 =?utf-8?B?TXNvVFFydUdmZWNYS29SUTZQZXRaS3AyYTNGN1VwWlJDZytiZVlqYUdhTHdt?=
 =?utf-8?B?OGV0Z0dBZ1RTa0dDcTZOaDYrYytkS2FMZ29SNDZ5T3kvS3B5N3E2WHljV1JX?=
 =?utf-8?B?MG5Ma1NsamR6V3lnSTdvekQxY0JncmZnNjRRMlNJdWs4SkFBVG1FcHZaSktp?=
 =?utf-8?B?ZjhGcVByOS9FUmN5elR6dThVK2ptOVpEUlhseDgxYko1YzRRNWxWT2NlZHdP?=
 =?utf-8?B?Rm5saUYvSENvdk5SRHJPdlp4Qk5Scm9WS0l0ZlFydkR5MkdlM0JQckZya0dE?=
 =?utf-8?B?V2FXTGplRkNPdFQ1QVBYWG1FQkhHbGRILzZ1VjgxZVBNQy9XdDlSdzdVUktZ?=
 =?utf-8?B?VkVuekg5Q0dvcnZaZ1BQQnhybnAyZVJyeW9nOVJHNjYwbVpuZFh6WllUSXZG?=
 =?utf-8?B?YlZHaE00TUNaa1Yrb29Bc0ZFcTJ3Z0Z2Si9taFU3T01MSkpPYlFVQnNNUkhq?=
 =?utf-8?B?YmZYOE1oeW9tYmM4VC96R3hsUUNaVU53TGwyNW82TEFiZ0EySGQrQkxGdjdL?=
 =?utf-8?B?T0daVUNWdWlnOHdjUGJDQW15VVpYUzFoRTVkODBxSEJoU3JKM3lmLzU2TlI3?=
 =?utf-8?B?cVBnOVhvamo0UEdQQ29PNGxzR3daN2kwdlF5SzRvTEg4YjU5NkRPMkgzOTZS?=
 =?utf-8?B?SFNtZXFIWnFncElDVjFacHNlU0NPMkdWNnFYbkVLK1h6K0lUMVloRHYwR0hS?=
 =?utf-8?B?eUFEUFRjNXd1ZHNKNStDeExtSjNSME54Z3pCRkY0R2Zmcm5qRnJmODlwTFlG?=
 =?utf-8?B?TEhNV2VRS1ZWd1pMMGNsREJqVGRsMkdrSmtaaFd1UlZVQlQ5SkJFZjRqL2t4?=
 =?utf-8?B?dlM5MytjRG5jR2QwenBuUDZuWGtKSUxnUTRBdzkybktJMCtka2JMS2hIOHRD?=
 =?utf-8?B?NDFwVjFkUTJKZFNDbmxqamV0OU94bmc3TURya2piaHk1YmZWOTBLQ1Y0Q0JB?=
 =?utf-8?B?REZEWmFpREpYUTRvcncyc3Z1ZkN4eG1tMWgzd2VMU2Z6SFlDVDZQeGxZV1Ir?=
 =?utf-8?B?MVcvc2t6N1owRFNsV3lYa3JFN3RydlhaY1dYVTI1bmhWWVdhc1EyMzRPNEtl?=
 =?utf-8?B?WjJWSHRraDNCTmtGUG1wZzdBRStuczltbGt5ZE04d0FiOEc1QkV3MjZXK3dO?=
 =?utf-8?B?bGtDL3p3Z0xBL28zNXFrYXAyaTV5M1htNFJQS3c3T1YvaENvcGs2dG1NOVVN?=
 =?utf-8?B?SkJhbk9nSGMycFdicEI4alNCQUNNK0F1ZTU1SXo1eTZYa0w1clhDNE92M0cv?=
 =?utf-8?B?RUhiZUhCeEFqTndyNGJLTVc5U3BjRmtvWHgybkhSVTc5OUdFUDNOOTlyQ3h0?=
 =?utf-8?Q?8RxD1u/VO6UYTnYs7/TRD9rFnSHpZz7of4rIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1c02c1-c44f-466e-1b4e-08d931ad8b20
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:32:48.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHrsxeg3hicwNCxCeWfK2jEsEAF+n0/wSTnqtvuIvz6CznPS3eq1U82tu7Bczpig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1228
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Zlr19O7W7PVAQO5Iz9aZunsaN5rSsUAq
X-Proofpoint-GUID: Zlr19O7W7PVAQO5Iz9aZunsaN5rSsUAq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_14:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 7:19 AM, Vincent Li wrote:
> 
> Hi Song,
> 
> Thank you for your response!
> 
> 
> On Wed, 16 Jun 2021, Yonghong Song wrote:
> 
>>
>>
>> On 6/16/21 5:05 PM, Vincent Li wrote:
>>> Hi BPF Experts,
>>>
>>> I had a problem that verifier report "R1 invalid mem access 'inv'" when
>>> I attempted to rewrite packet destination ethernet MAC address in Cilium
>>> tunnel mode, I opened an issue
>>> with detail here https://github.com/cilium/cilium/issues/16571:
>>>
>>> I have couple of questions in general to try to understand the compiler,
>>> BPF byte code, and the verifier.
>>>
>>> 1 Why the BPF byte code changes so much with my simple C code change
>>>
>>> a: BPF byte code  before C code change:
>>>
>>> 0000000000006068 <LBB12_410>:
>>>       3085:       bf a2 00 00 00 00 00 00 r2 = r10
>>> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>>>       3086:       07 02 00 00 78 ff ff ff r2 += -136
>>>       3087:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>       3089:       85 00 00 00 01 00 00 00 call 1
>>> ;       if (!tunnel)
>>>       3090:       15 00 06 01 00 00 00 00 if r0 == 0 goto +262 <LBB12_441>
>>> ;       key.tunnel_id = seclabel;
>>>       3091:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>>>       3093:       67 02 00 00 20 00 00 00 r2 <<= 32
>>>       3094:       77 02 00 00 20 00 00 00 r2 >>= 32
>>>       3095:       b7 01 00 00 06 00 00 00 r1 = 6
>>>       3096:       15 02 02 00 01 00 00 00 if r2 == 1 goto +2 <LBB12_413>
>>>       3097:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>
>>> 00000000000060d8 <LBB12_413>:
>>> ;       return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
>>> seclabel, monitor);
>>>
>>>
>>> b: BPF byte code  after C code change:
>>>
>>> the C code diff change:
>>>
>>> diff --git a/bpf/lib/encap.h b/bpf/lib/encap.h
>>> index dfd87bd82..19199429d 100644
>>> --- a/bpf/lib/encap.h
>>> +++ b/bpf/lib/encap.h
>>> @@ -187,6 +187,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
>>> tunnel_endpoint,
>>>                          struct endpoint_key *key, __u32 seclabel, __u32
>>> monitor)
>>>    {
>>>           struct endpoint_key *tunnel;
>>> +#define VTEP_MAC  { .addr = { 0xce, 0x72, 0xa7, 0x03, 0x88, 0x58 } }
>>> +       union macaddr vtep_mac = VTEP_MAC;
>>>             if (tunnel_endpoint) {
>>>    #ifdef ENABLE_IPSEC
>>> @@ -221,6 +223,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
>>> tunnel_endpoint,
>>>                                                   seclabel);
>>>           }
>>>    #endif
>>> +       if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
>>> +               return DROP_WRITE_ERROR;
>>>           return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
>>> seclabel, monitor);
>>>    }
>>>
>>> the result BPF byte code
>>>
>>> 0000000000004468 <LBB3_274>:
>>>       2189:       bf a2 00 00 00 00 00 00 r2 = r10
>>> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>>>       2190:       07 02 00 00 50 ff ff ff r2 += -176
>>>       2191:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>>>       2193:       85 00 00 00 01 00 00 00 call 1
>>>       2194:       bf 07 00 00 00 00 00 00 r7 = r0
>>>       2195:       79 a6 48 ff 00 00 00 00 r6 = *(u64 *)(r10 - 184)
>>> ;       if (!tunnel)
>>>       2196:       55 07 94 00 00 00 00 00 if r7 != 0 goto +148 <LBB3_289>
>>>
>>> 00000000000044a8 <LBB3_275>:
>>> ;       __u8 new_ttl, ttl = ip4->ttl;
>>>       2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
>>>       2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
>>> ;       if (ttl <= 1)
>>>       2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
>>>       2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
>>>
>>>
>>> You can see that:
>>>
>>> before change:  <LBB12_410>
>>> after change    <LBB3_274>
>>>
>>> is different that <LBB12_410> has instructions 3091, 3092... but
>>> <LBB3_274> end with instruction 2196
>>>
>>> before change: <LBB12_413> follows <LBB12_410>
>>> after change: <LBB3_275> follows <LBB3_274>
>>>
>>> <LBB12_413> and <LBB3_275> is very much different
>>>
>>> and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
>>> 'inv'"
>>>
>>> Why <LBB3_275> follows <LBB3_274> ? from C code, <LBB3_275> is not close
>>> to <LBB3_274>.
>>
>> The cilium code has a lot of functions inlined and after inlining, clang may
>> do reordering based on its internal heuristics. It is totally possible slight
>> code change may cause generated codes quite different.
>>
>> Regarding to
>>> and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
>>> 'inv'"
>>
>>
>>> 00000000000044a8 <LBB3_275>:
>>> ;       __u8 new_ttl, ttl = ip4->ttl;
>>>       2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
>>>       2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
>>> ;       if (ttl <= 1)
>>>       2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
>>>       2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
>>
>> Looks like "ip4" is spilled on the stack. and maybe the stack save/restore for
>> "ip4" does not preserve its original type.
>> This mostly happens to old kernels, I think.
>>
> 
> the kernel 4.18 on Centos8, I also custom build most recent mainline git
> kernel 5.13 on Centos8, I recall I got same invaid memory access
> 
>> If you have verifier log, it may help identify issues easily.
> 
> Here is the complete verifer log, I skipped the BTF part
> 
> level=warning msg="Prog section '2/7' rejected: Permission denied (13)!"
> subsys=datapath-loader
> level=warning msg=" - Type:         3" subsys=datapath-loader
> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> level=warning msg=" - Instructions: 2488 (0 over limit)"
> subsys=datapath-loader
> level=warning msg=" - License:      GPL" subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Verifier analysis:" subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Skipped 158566 bytes, use 'verb' option for the full
> verbose log." subsys=datapath-loader
> level=warning msg="[...]" subsys=datapath-loader
> level=warning msg="-136=????00mm fp-144=00000000 fp-152=0000mmmm
> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
> fp-240=inv128" subsys=datapath-loader
> level=warning msg="2437: (0f) r1 += r8" subsys=datapath-loader
> level=warning msg="2438: (7b) *(u64 *)(r0 +8) = r1" subsys=datapath-loader
> level=warning msg=" R0_w=map_value(id=0,off=0,ks=8,vs=16,imm=0)
> R1_w=inv(id=0) R6=ctx(id=0,off=0,imm=0)
> R7=inv(id=0,umax_value=128,var_off=(0x0; 0xff))
> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=invP0 R10=fp0
> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm fp-88=mmmmmmmm fp-96=00000000 fp-104=00000000
> fp-112=??mmmmmm fp-120=mmmmmmmm fp-128=??mmmmmm fp-136=????00mm
> fp-144=00000000 fp-152=0000mmmm fp-160=????mmmm fp-168=mmmmmmmm
> fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm fp-200=inv fp-208=mmmmmmmm
> fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm fp-240=inv128"
> subsys=datapath-loader
> level=warning msg="2439: (05) goto pc+41" subsys=datapath-loader
> level=warning msg="2481: (18) r2 = 0x5c7" subsys=datapath-loader
> level=warning msg="2483: (67) r2 <<= 32" subsys=datapath-loader
> level=warning msg="2484: (77) r2 >>= 32" subsys=datapath-loader
> level=warning msg="2485: (b7) r1 = 6" subsys=datapath-loader
> level=warning msg="2486: (15) if r2 == 0x1 goto pc-341"
> subsys=datapath-loader
> level=warning msg="last_idx 2486 first_idx 2481" subsys=datapath-loader
> level=warning msg="regs=4 stack=0 before 2485: (b7) r1 = 6"
> subsys=datapath-loader
> level=warning msg="regs=4 stack=0 before 2484: (77) r2 >>= 32"
> subsys=datapath-loader
> level=warning msg="regs=4 stack=0 before 2483: (67) r2 <<= 32"
> subsys=datapath-loader
> level=warning msg="regs=4 stack=0 before 2481: (18) r2 = 0x5c7"
> subsys=datapath-loader
> level=warning msg="2487: (05) goto pc-344" subsys=datapath-loader
> level=warning msg="2144: (18) r1 = 0x5c7" subsys=datapath-loader
> level=warning msg="2146: (61) r2 = *(u32 *)(r6 +68)"
> subsys=datapath-loader
> level=warning msg="2147: (b7) r3 = 39" subsys=datapath-loader
> level=warning msg="2148: (63) *(u32 *)(r10 -76) = r3"
> subsys=datapath-loader
> level=warning msg="2149: (b7) r3 = 1" subsys=datapath-loader
> level=warning msg="2150: (6b) *(u16 *)(r10 -90) = r3"
> subsys=datapath-loader
> level=warning msg="2151: (63) *(u32 *)(r10 -96) = r8"
> subsys=datapath-loader
> level=warning msg="2152: (63) *(u32 *)(r10 -100) = r2"
> subsys=datapath-loader
> level=warning msg="2153: (18) r2 = 0x1d3" subsys=datapath-loader
> level=warning msg="2155: (6b) *(u16 *)(r10 -102) = r2"
> subsys=datapath-loader
> level=warning msg="2156: (b7) r2 = 1028" subsys=datapath-loader
> level=warning msg="2157: (6b) *(u16 *)(r10 -104) = r2"
> subsys=datapath-loader
> level=warning msg="2158: (b7) r2 = 0" subsys=datapath-loader
> level=warning msg="2159: (63) *(u32 *)(r10 -80) = r2"
> subsys=datapath-loader
> level=warning msg="last_idx 2159 first_idx 2481" subsys=datapath-loader
> level=warning msg="regs=4 stack=0 before 2158: (b7) r2 = 0"
> subsys=datapath-loader
> level=warning msg="2160: (63) *(u32 *)(r10 -84) = r2"
> subsys=datapath-loader
> level=warning msg="2161: (7b) *(u64 *)(r10 -72) = r2"
> subsys=datapath-loader
> level=warning msg="2162: (7b) *(u64 *)(r10 -64) = r2"
> subsys=datapath-loader
> level=warning msg="2163: (63) *(u32 *)(r10 -88) = r1"
> subsys=datapath-loader
> level=warning msg="2164: (6b) *(u16 *)(r10 -92) = r7"
> subsys=datapath-loader
> level=warning msg="2165: (67) r7 <<= 32" subsys=datapath-loader
> level=warning msg="2166: (18) r1 = 0xffffffff" subsys=datapath-loader
> level=warning msg="2168: (4f) r7 |= r1" subsys=datapath-loader
> level=warning msg="2169: (bf) r4 = r10" subsys=datapath-loader
> level=warning msg="2170: (07) r4 += -104" subsys=datapath-loader
> level=warning msg="2171: (bf) r1 = r6" subsys=datapath-loader
> level=warning msg="2172: (18) r2 = 0xffffa0c68cae1600"
> subsys=datapath-loader
> level=warning msg="2174: (bf) r3 = r7" subsys=datapath-loader
> level=warning msg="2175: (b7) r5 = 48" subsys=datapath-loader
> level=warning msg="2176: (85) call bpf_perf_event_output#25"
> subsys=datapath-loader
> level=warning msg="last_idx 2176 first_idx 2481" subsys=datapath-loader
> level=warning msg="regs=20 stack=0 before 2175: (b7) r5 = 48"
> subsys=datapath-loader
> level=warning msg="2177: (b7) r1 = 39" subsys=datapath-loader
> level=warning msg="2178: (b7) r2 = 0" subsys=datapath-loader
> level=warning msg="2179: (85) call bpf_redirect#23" subsys=datapath-loader
> level=warning msg="2180: (bf) r9 = r0" subsys=datapath-loader
> level=warning msg="2181: (bf) r1 = r9" subsys=datapath-loader
> level=warning msg="2182: (67) r1 <<= 32" subsys=datapath-loader
> level=warning msg="2183: (77) r1 >>= 32" subsys=datapath-loader
> level=warning msg="2184: (15) if r1 == 0x0 goto pc+57"
> subsys=datapath-loader
> level=warning msg=" R0_w=inv(id=0)
> R1_w=inv(id=0,umax_value=2147483647,var_off=(0x0; 0x7fffffff))
> R6=ctx(id=0,off=0,imm=0)
> R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff;
> 0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0)
> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9_w=inv(id=0) R10=fp0
> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm
> fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm
> fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm
> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
> fp-240=inv128" subsys=datapath-loader
> level=warning msg="2185: (18) r2 = 0xffffff60" subsys=datapath-loader
> level=warning msg="2187: (1d) if r1 == r2 goto pc+9"
> subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="from 2187 to 2197: R0=inv(id=0) R1=inv4294967136
> R2=inv4294967136 R6=ctx(id=0,off=0,imm=0)
> R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff;
> 0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0)
> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=inv(id=0) R10=fp0
> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm
> fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm
> fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm
> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm

This is the problem. Here, we have "fp-200=inv" and
later on we have
    r1 = *(u64 *)(r10 -200)  // r1 is a unknown scalar

We cannot do the following operation
    r3 = *(u8 *)(r1 +22)
since r1 is a unknown scalar and the verifier rightfully rejected
the program.

You need to examine complete log to find out why fp-200 stores
an "inv" (a unknown scalar).

> fp-240=inv128" subsys=datapath-loader
> level=warning msg="2197: (79) r1 = *(u64 *)(r10 -200)"
> subsys=datapath-loader
> level=warning msg="2198: (71) r3 = *(u8 *)(r1 +22)" subsys=datapath-loader
> level=warning msg="R1 invalid mem access 'inv'" subsys=datapath-loader
> level=warning msg="processed 1802 insns (limit 1000000)
> max_states_per_insn 4 total_states 103 peak_states 103 mark_read 49"
> subsys=datapath-loader
> level=warning subsys=datapath-loader
> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> level=warning msg="Unable to load program" subsys=datapath-loader
>   
> 
> 
> 
>>>
>>>
>>> 2, Can I assume the verifier is to simulate the order of BPF byte
>>> code execution in run time, like if without any jump or goto in
>>> <LBB3_274>, <LBB3_275> will be executed after <LBB3_274>?
>>
>> The verifier will try to verify both paths, jumping to LBB3_289
>> or fall back to LBB3_275.
>>
>>>
>>>
>>>
>>> Enterprise Network Engineer
>>> F5 Networks Inc
>>> https://www.youtube.com/c/VincentLi
>>>
>>
