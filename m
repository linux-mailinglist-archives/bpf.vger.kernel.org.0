Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8353AC050
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 02:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhFRAx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 20:53:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhFRAxz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 20:53:55 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I0o7dA014801;
        Thu, 17 Jun 2021 17:51:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8TrpE9HoqjdVNUBi9zdcqFz0/8U+p+lIZuAsXY+6IWo=;
 b=WSUObQZL07f3hrxCFVbdzygLmZIDpjia0fD/mwG2+0TLKRObMJ6I8TSQvMo0pyld/t3k
 cf2Ctsx2I+LMOWsSj8KCTX1cTJDMXJ8hiXvR76JoQK/IF9L/YROW3GVbhuVFKRVzZ6He
 GKwuvfHjMErYt/zEznuv9f739EqD5h5TsAA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 398epngs1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 17:51:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqwLdT70YagKfyJWK2CFPYhrvgpYR0o41EG+/sIc1rz0Ljw8Yc/kBccQ3ZrKmtJVpl7yozNVLwVV9PUbMcxZkF6SsHEq6f2BfhdwT6c+B78MlDsAb7APt8PD2mGAmapLisUTAGzYuwleCGqmLwoV4fwm1r4XnKJoFd2SLkfcA/wS0/h8WnzaRpIhnorU9NBn/cnm58ObxNSHskOwbCOzMS0yfMhWMEApnm7TNKBEsJUosgA06J9hOkoFAPewaF7DaV+0SW4alcXNWsJJp91L2FaYf0HTN+hVgEAjjr3prJzVymo0IOR+m3BNGrg0ubppnMBs3p1w4cedjNJ7SbfYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TrpE9HoqjdVNUBi9zdcqFz0/8U+p+lIZuAsXY+6IWo=;
 b=NcVSY/Wm0BqaLfiy+upMQ95zy0G9eqnajCNwCXhLShXyjXyoWSTnt6qHnDkm25tJKvqHrhtJpTKVIflqcDAJ9VXYJAq1qHRhf0R1h8J/AVCtvwOJHGfmcm0xAkAl6P8RhNT6nA7S9oYfS21eRxi2H4Pnb6p7DFr5Rz9tk6LtkYQqqaQ1675VW84EFD8ij1NOKmvG//hwJmWBWcPURMTwLlaIdO5bXLlAUukPGgGaTsSy/2RGcWiH2fixGcWZHpUAE8/Eb9W4c4l266khSl4Dnjg6Z+eRSniTs7mUckd7Ttfi2BtFtpNsyZD/r6Hp1SncGG1aFd1nLyvJQTP4wSni3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4920.namprd15.prod.outlook.com (2603:10b6:806:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 00:51:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 00:51:44 +0000
Subject: Re: R1 invalid mem access 'inv'
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
 <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
 <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com>
 <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce2ea7e8-0443-3e78-6cf8-d3105f729646@fb.com>
Date:   Thu, 17 Jun 2021 17:51:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c984]
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1349] (2620:10d:c090:400::5:c984) by SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Fri, 18 Jun 2021 00:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e3163e-d0ad-4cee-0c23-08d931f33e28
X-MS-TrafficTypeDiagnostic: SA1PR15MB4920:
X-Microsoft-Antispam-PRVS: <SA1PR15MB492099824C35B59DC37409B9D30D9@SA1PR15MB4920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QQT2muZYzQOEZRSaIc3aIYybAR92T+DLRe2WWhDWUTOMGHUVypV2Uqxgl0DTHgwnWkQxPv+ZhTkO10790NWpdMTAiU6TQ483WTN+ywzkKWGpWpynGvC9JQeibxaI+xfw7CLdrYeR0uDAiIZDJPcSMzs0x68+pqMp93kCS6/eBXTltO4g81obf8ykGxPR4xL0cEYssk6l+WaqeMEY1N19wRw5kQWjVGSZcLvfuVOLmitz+ngk9TA3QrabRBFVMjH2IKKoV9zu9hnan2Mx/T1g5N3UM8v4VOTV+953I/3ttVQtIlFAPp9Hur5YFTxANt7xdlBLpztILZLurFBtecc8iuZ9SSqTTVrqfqb5xVST2f7kESmfta24yU6A4sLWuehX6WLZl1g4MKUXKtTIn3QzvzxehwxVqTv+aS43Iimho4pC0boh3HpvGx3vxURejpJlIHoaZFCCvhoDqZAc4Y5xAFKOFH55HIunNnKRPagyxx1yYP/OASMq3vGBGoTaitgdmtv3kuY4Tkl7fHVMZRPZ2jdtKMDDDwGosz3G1/L03c+Y5hH6P6ocZirNd+8rgzyhjs/kFz/CuQCeaCCDM+DnQgRqsaFPKOp0TQcm7IKgA/+vggLBHTCjiDcO/ZgLA5kSE8bbMJEcd1dULIwxJVMUNE3S2G85oQoZnIVdZlMOhUPDYDgqu/Xy5YUG75O0+BlJ9tdKcpZc+i0lrSnHcOwJnm2ohdYZD8ScVTOS2ZNRiG/7kpMl1fqMbyf6fO68BnxUEtBenec2SvynLwdOXI4/N0PVQRqwwuhbw+Hcp4vtmnbh/JIpp/44SNmQHdHzMWSmqaaJ+cIhZD+YzKTPcCXv2/lso4h/QcLc6tZ6oJdfq7SCU4MDkXleBQnqNCMT1k7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(4326008)(53546011)(83380400001)(16526019)(8936002)(66476007)(8676002)(31696002)(478600001)(36756003)(38100700002)(52116002)(5660300002)(86362001)(6916009)(2906002)(66946007)(2616005)(316002)(31686004)(66556008)(966005)(30864003)(6486002)(186003)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJvbkg3U0pnam5tK1VXTzFBZDJIRzg3VzJpdDVRZHVSUHhhcW5McUVUYVZh?=
 =?utf-8?B?MjkxY2xJYUU3UEx0c1c3Z2tTd08wVDcxNnQ1U1Bja3l6djBCTGh4UG1QeVYw?=
 =?utf-8?B?ZnRKN0lscWZWQjlrelI5dnA3WHVpYnFkWDEzNmM0ampib2l1eFVDSG1oc1dD?=
 =?utf-8?B?REZRbXdsOGtFbWdIN0prdnQ5U1pWUEN0QWR0ZUxxWjJ4UFRyV2VDRHVlbHAy?=
 =?utf-8?B?bEx3Y3MwWnJPQ3Z6MS9FS1FKV3AydUE3OTllTCt2ZDdWMlppdy8wOHJSeGhV?=
 =?utf-8?B?T2Rnc3RzekVEZEVnNmZlRTA4RHVra3FHYnNqV2ZpM2lmK3FmUHloT1JSZE9P?=
 =?utf-8?B?VVptM0c5K2VuSU1MK3VZb1NKU0crSWwrY3A3K2o4OFFRSUFMc0NDcDE3OFdp?=
 =?utf-8?B?WmQycDBqRU9KdTRXVDliYjFsb2VTMGxqQVNSMVNqMWdJZTNQMjhoMGtzNkx3?=
 =?utf-8?B?dVNONFZWeVRLZmVjY08vVzA4TzdSemMvSU9CT1ozSUJiNFBORjFwOFd2ZmtI?=
 =?utf-8?B?eGJvSDZvMG9TNUc5SjBPeVptcE8yaXhvUmxndFlwbXltNlBQVFQrYkxncDF0?=
 =?utf-8?B?enhXeFNqbDZMV3BuSi9ZTXBwUUhCSEhpTllPZFhjSDQ0V0hpalM0UU4xQjMv?=
 =?utf-8?B?OW1ubzBmOSs0YmZlbGtUb2Zoa21ObHBkazRVMWlxUlpmVUdiZUIwckZocGxU?=
 =?utf-8?B?R3F0WlB0Z2VQeCt0VnNRWDBYVThKZU9xeHF1T0VlMmRKb0lMc280Rk9Vcmwz?=
 =?utf-8?B?QTZCQWtyemtDamtZRXNFNUFFc29kNTlqdUs2V0EzaG9mRURMcGdRQjJLZDha?=
 =?utf-8?B?ZmE1YUZ6VnNFYjBwM09oeTl3T2FWWEFsWjVpeVdXZ0JUSU05bFlocEY4T3h4?=
 =?utf-8?B?UTk2eVNTSmdUbDdINWlDMlg2QmMybDlKWWU1Vnl4eEhHNGpERHdYV0JORTNG?=
 =?utf-8?B?SGVtZjYra0NPVEdNTjR3bnJMN0xQczZmdG1RQURNTGlST2hNcElScmVFQmRq?=
 =?utf-8?B?ZXdiMkYwRHNlVXNFSWpIeEIxcExLRHdNYzdWQmtpcm5Bd29LTDJWckR0bW0w?=
 =?utf-8?B?cWpPQi91S09idDd4OUgwK3N0c2NoOXlQVGduOW5sQWpKQmUraGpTN21qcThs?=
 =?utf-8?B?ZkdSNEcwVmRPL1ByMTRaSHpJYTVSQjJmSEJ6dWFhQW5tLzdock9HWXNuVzQ0?=
 =?utf-8?B?U3VBOWg4T0xFQTBrZWExY1dQZkVaRUlXTUsvbTQ1QXoyWlVoRlhER1VBOEVT?=
 =?utf-8?B?UW5TWEpGRW11RXZ2d3RsdjRiY1dTVmtmd3hMeTVpYUJnR1lyZW1OYXN5dXpD?=
 =?utf-8?B?Y2pjRktXS3BZdjErRkNOaEl1eFdMVnNCcDkxMFhOVTdqYVhJaDJTZGNFTjJZ?=
 =?utf-8?B?YnBJcDRMZUwrT0t1aFN4M1YxRzlWTklsVTl2SDVFT0t5L1J3M2hMMnRKZjlL?=
 =?utf-8?B?TGwyeEE4amI2U0hDTTZ4bFpOMWVhTFRRWmo1ME1qYk5PRW9PQ3JSc2VsRUFU?=
 =?utf-8?B?dVhIV0VhbWlrQzVoNGh1RlJGb2xJbGZaQjJNSDVkZzBMTThNMHMzUmlXWTNz?=
 =?utf-8?B?eFNPS3RBQ0Y3UGlxVFBpN3dyV05WZlZ0VDlYUkhDeVVEbWJGR3djMTRlbHB2?=
 =?utf-8?B?dzBZK1JUUWdUbW5RbjdzU0hjYk9Feng4RGl1dk5POFg4Rjh0dndWTENZdmNK?=
 =?utf-8?B?RHZiY2VqYzk2V3liMFhOZUdITjI2SEUzNStpSzVscVNWbUF1ZUZrKzJSYTN6?=
 =?utf-8?B?ckVIYXlpUjBuMmJCdzMwMnF6SkVTTDArbE1SUlIzc21VcFU0TkhlZG1STEpB?=
 =?utf-8?B?cXNYL2ZHM2NTbjh3L2xhUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e3163e-d0ad-4cee-0c23-08d931f33e28
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 00:51:44.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9jCfZ3Zdl7VHHBHnlEtbux3HIM+IgYEkpEdMp7YrVuustA9ATlFSulWkl/6o94K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4920
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Fd8HWeVg-0gvrSMKYYJrvtqodzTAWRW9
X-Proofpoint-ORIG-GUID: Fd8HWeVg-0gvrSMKYYJrvtqodzTAWRW9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_16:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 3:19 PM, Vincent Li wrote:
> 
> 
> On Thu, 17 Jun 2021, Yonghong Song wrote:
> 
>>
>>
>> On 6/17/21 7:19 AM, Vincent Li wrote:
>>>
>>> Hi Song,
>>>
>>> Thank you for your response!
>>>
>>>
>>> On Wed, 16 Jun 2021, Yonghong Song wrote:
>>>
>>>>
>>>>
>>>> On 6/16/21 5:05 PM, Vincent Li wrote:
>>>>> Hi BPF Experts,
>>>>>
>>>>> I had a problem that verifier report "R1 invalid mem access 'inv'" when
>>>>> I attempted to rewrite packet destination ethernet MAC address in Cilium
>>>>> tunnel mode, I opened an issue
>>>>> with detail here https://github.com/cilium/cilium/issues/16571:
>>>>>
>>>>> I have couple of questions in general to try to understand the compiler,
>>>>> BPF byte code, and the verifier.
>>>>>
>>>>> 1 Why the BPF byte code changes so much with my simple C code change
>>>>>
>>>>> a: BPF byte code  before C code change:
>>>>>
>>>>> 0000000000006068 <LBB12_410>:
>>>>>        3085:       bf a2 00 00 00 00 00 00 r2 = r10
>>>>> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>>>>>        3086:       07 02 00 00 78 ff ff ff r2 += -136
>>>>>        3087:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0
>>>>> ll
>>>>>        3089:       85 00 00 00 01 00 00 00 call 1
>>>>> ;       if (!tunnel)
>>>>>        3090:       15 00 06 01 00 00 00 00 if r0 == 0 goto +262
>>>>> <LBB12_441>
>>>>> ;       key.tunnel_id = seclabel;
>>>>>        3091:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0
>>>>> ll
>>>>>        3093:       67 02 00 00 20 00 00 00 r2 <<= 32
>>>>>        3094:       77 02 00 00 20 00 00 00 r2 >>= 32
>>>>>        3095:       b7 01 00 00 06 00 00 00 r1 = 6
>>>>>        3096:       15 02 02 00 01 00 00 00 if r2 == 1 goto +2 <LBB12_413>
>>>>>        3097:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0
>>>>> ll
>>>>>
>>>>> 00000000000060d8 <LBB12_413>:
>>>>> ;       return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
>>>>> seclabel, monitor);
>>>>>
>>>>>
>>>>> b: BPF byte code  after C code change:
>>>>>
>>>>> the C code diff change:
>>>>>
>>>>> diff --git a/bpf/lib/encap.h b/bpf/lib/encap.h
>>>>> index dfd87bd82..19199429d 100644
>>>>> --- a/bpf/lib/encap.h
>>>>> +++ b/bpf/lib/encap.h
>>>>> @@ -187,6 +187,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
>>>>> tunnel_endpoint,
>>>>>                           struct endpoint_key *key, __u32 seclabel, __u32
>>>>> monitor)
>>>>>     {
>>>>>            struct endpoint_key *tunnel;
>>>>> +#define VTEP_MAC  { .addr = { 0xce, 0x72, 0xa7, 0x03, 0x88, 0x58 } }
>>>>> +       union macaddr vtep_mac = VTEP_MAC;
>>>>>              if (tunnel_endpoint) {
>>>>>     #ifdef ENABLE_IPSEC
>>>>> @@ -221,6 +223,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
>>>>> tunnel_endpoint,
>>>>>                                                    seclabel);
>>>>>            }
>>>>>     #endif
>>>>> +       if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
>>>>> +               return DROP_WRITE_ERROR;
>>>>>            return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
>>>>> seclabel, monitor);
>>>>>     }
>>>>>
>>>>> the result BPF byte code
>>>>>
>>>>> 0000000000004468 <LBB3_274>:
>>>>>        2189:       bf a2 00 00 00 00 00 00 r2 = r10
>>>>> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>>>>>        2190:       07 02 00 00 50 ff ff ff r2 += -176
>>>>>        2191:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0
>>>>> ll
>>>>>        2193:       85 00 00 00 01 00 00 00 call 1
>>>>>        2194:       bf 07 00 00 00 00 00 00 r7 = r0
>>>>>        2195:       79 a6 48 ff 00 00 00 00 r6 = *(u64 *)(r10 - 184)
>>>>> ;       if (!tunnel)
>>>>>        2196:       55 07 94 00 00 00 00 00 if r7 != 0 goto +148
>>>>> <LBB3_289>
>>>>>
>>>>> 00000000000044a8 <LBB3_275>:
>>>>> ;       __u8 new_ttl, ttl = ip4->ttl;
>>>>>        2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
>>>>>        2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
>>>>> ;       if (ttl <= 1)
>>>>>        2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
>>>>>        2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
>>>>>
>>>>>
>>>>> You can see that:
>>>>>
>>>>> before change:  <LBB12_410>
>>>>> after change    <LBB3_274>
>>>>>
>>>>> is different that <LBB12_410> has instructions 3091, 3092... but
>>>>> <LBB3_274> end with instruction 2196
>>>>>
>>>>> before change: <LBB12_413> follows <LBB12_410>
>>>>> after change: <LBB3_275> follows <LBB3_274>
>>>>>
>>>>> <LBB12_413> and <LBB3_275> is very much different
>>>>>
>>>>> and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
>>>>> 'inv'"
>>>>>
>>>>> Why <LBB3_275> follows <LBB3_274> ? from C code, <LBB3_275> is not close
>>>>> to <LBB3_274>.
>>>>
>>>> The cilium code has a lot of functions inlined and after inlining, clang
>>>> may
>>>> do reordering based on its internal heuristics. It is totally possible
>>>> slight
>>>> code change may cause generated codes quite different.
>>>>
>>>> Regarding to
>>>>> and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
>>>>> 'inv'"
>>>>
>>>>
>>>>> 00000000000044a8 <LBB3_275>:
>>>>> ;       __u8 new_ttl, ttl = ip4->ttl;
>>>>>        2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
>>>>>        2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
>>>>> ;       if (ttl <= 1)
>>>>>        2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
>>>>>        2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
>>>>
>>>> Looks like "ip4" is spilled on the stack. and maybe the stack save/restore
>>>> for
>>>> "ip4" does not preserve its original type.
>>>> This mostly happens to old kernels, I think.
>>>>
>>>
>>> the kernel 4.18 on Centos8, I also custom build most recent mainline git
>>> kernel 5.13 on Centos8, I recall I got same invaid memory access
>>>
>>>> If you have verifier log, it may help identify issues easily.
>>>
>>> Here is the complete verifer log, I skipped the BTF part
>>>
>>> level=warning msg="Prog section '2/7' rejected: Permission denied (13)!"
>>> subsys=datapath-loader
>>> level=warning msg=" - Type:         3" subsys=datapath-loader
>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
>>> level=warning msg=" - Instructions: 2488 (0 over limit)"
>>> subsys=datapath-loader
>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
>>> level=warning subsys=datapath-loader
>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
>>> level=warning subsys=datapath-loader
>>> level=warning msg="Skipped 158566 bytes, use 'verb' option for the full
>>> verbose log." subsys=datapath-loader
>>> level=warning msg="[...]" subsys=datapath-loader
>>> level=warning msg="-136=????00mm fp-144=00000000 fp-152=0000mmmm
>>> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
>>> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
>>> fp-240=inv128" subsys=datapath-loader
>>> level=warning msg="2437: (0f) r1 += r8" subsys=datapath-loader
>>> level=warning msg="2438: (7b) *(u64 *)(r0 +8) = r1" subsys=datapath-loader
>>> level=warning msg=" R0_w=map_value(id=0,off=0,ks=8,vs=16,imm=0)
>>> R1_w=inv(id=0) R6=ctx(id=0,off=0,imm=0)
>>> R7=inv(id=0,umax_value=128,var_off=(0x0; 0xff))
>>> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=invP0 R10=fp0
>>> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
>>> fp-48=mmmmmmmm fp-88=mmmmmmmm fp-96=00000000 fp-104=00000000
>>> fp-112=??mmmmmm fp-120=mmmmmmmm fp-128=??mmmmmm fp-136=????00mm
>>> fp-144=00000000 fp-152=0000mmmm fp-160=????mmmm fp-168=mmmmmmmm
>>> fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm fp-200=inv fp-208=mmmmmmmm
>>> fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm fp-240=inv128"
>>> subsys=datapath-loader
>>> level=warning msg="2439: (05) goto pc+41" subsys=datapath-loader
>>> level=warning msg="2481: (18) r2 = 0x5c7" subsys=datapath-loader
>>> level=warning msg="2483: (67) r2 <<= 32" subsys=datapath-loader
>>> level=warning msg="2484: (77) r2 >>= 32" subsys=datapath-loader
>>> level=warning msg="2485: (b7) r1 = 6" subsys=datapath-loader
>>> level=warning msg="2486: (15) if r2 == 0x1 goto pc-341"
>>> subsys=datapath-loader
>>> level=warning msg="last_idx 2486 first_idx 2481" subsys=datapath-loader
>>> level=warning msg="regs=4 stack=0 before 2485: (b7) r1 = 6"
>>> subsys=datapath-loader
>>> level=warning msg="regs=4 stack=0 before 2484: (77) r2 >>= 32"
>>> subsys=datapath-loader
>>> level=warning msg="regs=4 stack=0 before 2483: (67) r2 <<= 32"
>>> subsys=datapath-loader
>>> level=warning msg="regs=4 stack=0 before 2481: (18) r2 = 0x5c7"
>>> subsys=datapath-loader
>>> level=warning msg="2487: (05) goto pc-344" subsys=datapath-loader
>>> level=warning msg="2144: (18) r1 = 0x5c7" subsys=datapath-loader
>>> level=warning msg="2146: (61) r2 = *(u32 *)(r6 +68)"
>>> subsys=datapath-loader
>>> level=warning msg="2147: (b7) r3 = 39" subsys=datapath-loader
>>> level=warning msg="2148: (63) *(u32 *)(r10 -76) = r3"
>>> subsys=datapath-loader
>>> level=warning msg="2149: (b7) r3 = 1" subsys=datapath-loader
>>> level=warning msg="2150: (6b) *(u16 *)(r10 -90) = r3"
>>> subsys=datapath-loader
>>> level=warning msg="2151: (63) *(u32 *)(r10 -96) = r8"
>>> subsys=datapath-loader
>>> level=warning msg="2152: (63) *(u32 *)(r10 -100) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2153: (18) r2 = 0x1d3" subsys=datapath-loader
>>> level=warning msg="2155: (6b) *(u16 *)(r10 -102) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2156: (b7) r2 = 1028" subsys=datapath-loader
>>> level=warning msg="2157: (6b) *(u16 *)(r10 -104) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2158: (b7) r2 = 0" subsys=datapath-loader
>>> level=warning msg="2159: (63) *(u32 *)(r10 -80) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="last_idx 2159 first_idx 2481" subsys=datapath-loader
>>> level=warning msg="regs=4 stack=0 before 2158: (b7) r2 = 0"
>>> subsys=datapath-loader
>>> level=warning msg="2160: (63) *(u32 *)(r10 -84) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2161: (7b) *(u64 *)(r10 -72) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2162: (7b) *(u64 *)(r10 -64) = r2"
>>> subsys=datapath-loader
>>> level=warning msg="2163: (63) *(u32 *)(r10 -88) = r1"
>>> subsys=datapath-loader
>>> level=warning msg="2164: (6b) *(u16 *)(r10 -92) = r7"
>>> subsys=datapath-loader
>>> level=warning msg="2165: (67) r7 <<= 32" subsys=datapath-loader
>>> level=warning msg="2166: (18) r1 = 0xffffffff" subsys=datapath-loader
>>> level=warning msg="2168: (4f) r7 |= r1" subsys=datapath-loader
>>> level=warning msg="2169: (bf) r4 = r10" subsys=datapath-loader
>>> level=warning msg="2170: (07) r4 += -104" subsys=datapath-loader
>>> level=warning msg="2171: (bf) r1 = r6" subsys=datapath-loader
>>> level=warning msg="2172: (18) r2 = 0xffffa0c68cae1600"
>>> subsys=datapath-loader
>>> level=warning msg="2174: (bf) r3 = r7" subsys=datapath-loader
>>> level=warning msg="2175: (b7) r5 = 48" subsys=datapath-loader
>>> level=warning msg="2176: (85) call bpf_perf_event_output#25"
>>> subsys=datapath-loader
>>> level=warning msg="last_idx 2176 first_idx 2481" subsys=datapath-loader
>>> level=warning msg="regs=20 stack=0 before 2175: (b7) r5 = 48"
>>> subsys=datapath-loader
>>> level=warning msg="2177: (b7) r1 = 39" subsys=datapath-loader
>>> level=warning msg="2178: (b7) r2 = 0" subsys=datapath-loader
>>> level=warning msg="2179: (85) call bpf_redirect#23" subsys=datapath-loader
>>> level=warning msg="2180: (bf) r9 = r0" subsys=datapath-loader
>>> level=warning msg="2181: (bf) r1 = r9" subsys=datapath-loader
>>> level=warning msg="2182: (67) r1 <<= 32" subsys=datapath-loader
>>> level=warning msg="2183: (77) r1 >>= 32" subsys=datapath-loader
>>> level=warning msg="2184: (15) if r1 == 0x0 goto pc+57"
>>> subsys=datapath-loader
>>> level=warning msg=" R0_w=inv(id=0)
>>> R1_w=inv(id=0,umax_value=2147483647,var_off=(0x0; 0x7fffffff))
>>> R6=ctx(id=0,off=0,imm=0)
>>> R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff;
>>> 0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0)
>>> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9_w=inv(id=0) R10=fp0
>>> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
>>> fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm
>>> fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm
>>> fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm
>>> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
>>> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
>>> fp-240=inv128" subsys=datapath-loader
>>> level=warning msg="2185: (18) r2 = 0xffffff60" subsys=datapath-loader
>>> level=warning msg="2187: (1d) if r1 == r2 goto pc+9"
>>> subsys=datapath-loader
>>> level=warning subsys=datapath-loader
>>> level=warning msg="from 2187 to 2197: R0=inv(id=0) R1=inv4294967136
>>> R2=inv4294967136 R6=ctx(id=0,off=0,imm=0)
>>> R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff;
>>> 0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0)
>>> R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=inv(id=0) R10=fp0
>>> fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
>>> fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm
>>> fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm
>>> fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm
>>> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
>>> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
>>
>> This is the problem. Here, we have "fp-200=inv" and
>> later on we have
>>     r1 = *(u64 *)(r10 -200)  // r1 is a unknown scalar
>>
>> We cannot do the following operation
>>     r3 = *(u8 *)(r1 +22)
>> since r1 is a unknown scalar and the verifier rightfully rejected
>> the program.
>>
>> You need to examine complete log to find out why fp-200 stores
>> an "inv" (a unknown scalar).
> 
> I guess you mean the complete log starting from the prog section 2/7 from
> verifier, if so, it seems fp-200 started with "inv"
> 
> level=warning msg="Prog section '2/7' rejected: Permission denied (13)!"
> subsys=datapath-loader
> 
> level=warning msg="-136=????00mm fp-144=00000000 fp-152=0000mmmm
> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm
> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
> fp-240=inv128" subsys=datapath-loader
> 
> and I don't see fp-200 ever changed to something else after, maybe I am
> reading it wrong

The log is truncated.

 >>> level=warning msg="[...]" subsys=datapath-loader
 >>> level=warning msg="-136=????00mm fp-144=00000000 fp-152=0000mmmm
 >>> fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx 
fp-192=mmmmmmmm
 >>> fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm
 >>> fp-240=inv128" subsys=datapath-loader
 >>> level=warning msg="2437: (0f) r1 += r8" subsys=datapath-loader
 >>> level=warning msg="2438: (7b) *(u64 *)(r0 +8) = r1" 
subsys=datapath-loader

The log starts with insn 2437.
The complete log should start with insn 0.

> 
>>
>>> fp-240=inv128" subsys=datapath-loader
>>> level=warning msg="2197: (79) r1 = *(u64 *)(r10 -200)"
>>> subsys=datapath-loader
>>> level=warning msg="2198: (71) r3 = *(u8 *)(r1 +22)" subsys=datapath-loader
>>> level=warning msg="R1 invalid mem access 'inv'" subsys=datapath-loader
>>> level=warning msg="processed 1802 insns (limit 1000000)
>>> max_states_per_insn 4 total_states 103 peak_states 103 mark_read 49"
>>> subsys=datapath-loader
>>> level=warning subsys=datapath-loader
>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
>>> level=warning msg="Unable to load program" subsys=datapath-loader
>>>    
>>>
>>>
>>>>>
>>>>>
>>>>> 2, Can I assume the verifier is to simulate the order of BPF byte
>>>>> code execution in run time, like if without any jump or goto in
>>>>> <LBB3_274>, <LBB3_275> will be executed after <LBB3_274>?
>>>>
>>>> The verifier will try to verify both paths, jumping to LBB3_289
>>>> or fall back to LBB3_275.
>>>>
>>>>>
>>>>>
>>>>>
>>>>> Enterprise Network Engineer
>>>>> F5 Networks Inc
>>>>> https://www.youtube.com/c/VincentLi
>>>>>
>>>>
>>
