Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A73AAB97
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQGFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 02:05:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhFQGFL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 02:05:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H5t0Yv015007;
        Wed, 16 Jun 2021 23:03:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qgGcj2EBijR9ete8KIjVdcbqehPheS6JZ3/azrNxgjA=;
 b=dg5PWb7BHVM612gjob1mmuogNQg+ig//nV+RfVQvVNwZD/67AbScd+cLSvbwLAXuPmIb
 /UNWHxz+xjsyqqDz7M+A0VpXTU518TPa37ywYD3CT18FF/gsnCd+h2Olj23eKwrvevne
 YXIQCkXrhPcBsaaHIsAoDkxwHDkG3GNQC9k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 396t1bdw7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 23:03:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 23:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SenOtpx6p+sfv3mu9Y+5O97F2odNHBPOAt6O2X0UYXP4cb85Oe1wqaMQfRIuwlU3ytjgWvFdPF7Z9zYyj9LCg8BdQ6Zuv+OV0VcY9P3gw6ddepryk+GyyU4XY4AE8/yY8kShNP8AfQ78Q1Z1yQmgcG33xpzGUcG6DFsBUr0Ow0p0eW6IaArd9FFXGA7WoqiglQJSFubZ5y7mNttyNYbo7DxJ1o/PHg0xQsNx2tuzvbtkJd+Ie0kT+KWm1SUhfWLC7oER3R+xkGHMY/YE/jn+LPwRUmzag4cnLSst7/0yIejjv6X9Bts1kEf7byI9YX5Kfm82WwzxF4xTkBKnmA25wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgGcj2EBijR9ete8KIjVdcbqehPheS6JZ3/azrNxgjA=;
 b=k2V3Qu0FVmPRvLl1uELUaxF8emHA8+jTKq+b579DS9z3vqxr6Qdg6ua5SpSPBxpAxt2aBtHV+CAfT+CXgN0cyDwPyLeL13R5wt9+bY41FpLJ+eMzPSVjSH9gAeg4BuinYKHI9Pwe5X7SYWct/1EsswY0e/uFF014i2ORO70AbcysbJkppxEiW8e2Wl6nGMzQg6MiTQqDOlxaiUrHWLh9S+uWdvSFP3Bb+X6BL5msae5axXI0Bqk9YC2dD71E1SSzdEZAI4GhgbOqxN8vI86lQyDpoOtajZen0oRY/+AfVLVoWB3i6ukXPnRksQPvTy9vKQcTJRuWATLo2cKvGac5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 06:03:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 06:03:00 +0000
Subject: Re: R1 invalid mem access 'inv'
To:     Vincent Li <vincent.mc.li@gmail.com>, <bpf@vger.kernel.org>
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
Date:   Wed, 16 Jun 2021 23:02:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:6d3c]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:6d3c) by SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 06:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f28a528b-d186-4c32-eb10-08d931558fab
X-MS-TrafficTypeDiagnostic: SA1PR15MB4660:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4660C75FE1018B3EF02B26D8D30E9@SA1PR15MB4660.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHFzghPms1eS/EievOzGgCvwRke/SCZqi4SJJc0p3VHXL0g0mYc0dZieE4pffOAA03EujwDNTJ7mpxJHvXQ1mWtLqgfmoEkODM49P+HBnQHwmNnWrD985Ru2Mw0fzBJDsEOfk12uEnS5UDHr5fEPf8tpvKmcrAVjSH4UzZetEPjiXjA/MsZXbX49zbOV99MhUZrrp1pa6jfcJq/RNMdpM7dRf/Mbzt1vmi/YvfGnyuhLqEGDvcOkUhWRNUWgKMCr7meo8LcjCqROMikX2MsVvsh8oDGYrcdJQ8Xak+lvPBw5dQ3cFVMO8wzUlij+/MtRgKCzz6XG2f64bCUBzVL9UaZuDa+EAPd+jh+LYUypisKgk0OeRIdrFJ9b5nCsEE7XwTBGtASw/mhRIe8yncZYYam67ZHVOiwrbvWnZfmJ8JyXudJsPaLNtvhVE4dHcGdrugDAC8dRs+C4TRfagwT25Qgf3TY0FZIZNYCRqViRJM0kHsmPuVvzkyVIPAQ1oqN1cPDl1xc3GxRTXgIwL1m1cN5Mg6gbCTS+XJodtW1q+eSC2JKT/sThRFynpJF5DWc3FJ4nt9AsHLsDwumUI3Y1I1hmyYhf6OswUDEy6/RFIg642yIqUf87c11J2tKXEzuyu8jH8h7YKoK7tNH93G5u75qbblzAfoGzahaOcSXxgESGZ83HD14+XWKTpeOpZyGi4eiMuhfjkP2qkA/r/pxyB/c2PXawQKm6ykXBRG/mBPIASw9EAzOgnqQ70NHWtiunTWTao/FNx9fffQsbnZuv5ZD3jZ1wKqpGg/TsUQNe4VMu2duefK6xn9iEtzcefWda33lWkaWbDUgUxI0Gn1ElOhhSIpihVJag7oMK7Iq04O9tb07vk1O7d8vdFEZPTcQV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(2616005)(52116002)(66946007)(53546011)(5660300002)(478600001)(83380400001)(966005)(36756003)(86362001)(16526019)(8676002)(31696002)(2906002)(6666004)(6486002)(8936002)(31686004)(38100700002)(66476007)(66556008)(316002)(186003)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFM1bXBCaCtqdDlyREdzRFdmTlRCQVZiL1VHekRBN3lvazF4MmxEblQ3QUkz?=
 =?utf-8?B?NjUxNm5ScmlyZSsyRlN0NzZpRzdUbHdDaUFmOEYwdzFoWEVPS2JqZ1ErWk5k?=
 =?utf-8?B?TkFJVnNFcVRMNGVaMjJ5a0lZY1Era2pIV0pGSGRNTUYxVnZ4VTZNYTRSbkF1?=
 =?utf-8?B?SVhOUllwVllFSDlWVmdobHI5RlFkQW5kWThCV0tYdTZHTCt4azdNYUNsMVdO?=
 =?utf-8?B?STl0cnN0QjJZOUQrYVZiT0drL2pMK0V4TmNUd2JVUEw1OGtPVUpzZnBNT2VR?=
 =?utf-8?B?ckxTN1R2Nmhkc3lTZ2dHNjVhaVMwaHdWeWRLbmJBa095cXhXNXpuT1FhQThF?=
 =?utf-8?B?RWsvTHVEbS9iWWI3VEZTVzM4TDhiV1dBOXc3bm42eWhXQ3I1eFkxN0ZCS1li?=
 =?utf-8?B?aXpoQm01ZG45NFh1NXEzMklzSmN0TWdoalR4ZGppNHI4NWxidUc5OVJkZC9l?=
 =?utf-8?B?OFBTMHA4dVpibDBYL1JVcW1MYjRIT2RjaVluN3NjKzFXM3IyV2IzS3dCMFF2?=
 =?utf-8?B?Zk93SmxUNFNWVHhHbThBVjNIdm5ldjJDOHZwOUpOc09pRDdDNWl3ZmhnR1lr?=
 =?utf-8?B?d01SRDdSYUE4Q3F4N0cwZnk2bnErVmY1Z0hRdGR1Y3UrYnc0RTRrbjN0Z081?=
 =?utf-8?B?QzliZnhpZXJFWC9Xd1ZjS3dRaEx2TW93aC8rc3pzUERCNnRFUExPNXJCeVlq?=
 =?utf-8?B?d1RqaW9ZSEI5aXBCK0pGbmFVRHozeUlta1cxcHdER0NJc0dGL0c2RWczNDFG?=
 =?utf-8?B?UW42Qkc5RUtKOEtPUnBaN3MvZFdPSnNMSklBdUs1NlhUck1YY1pGa1BLdG5m?=
 =?utf-8?B?QXlFWXdiOE4zc3BROEozM3VDTG0wbGw1bGZYSUIvcDZNelpLZk1pYUJLc2J1?=
 =?utf-8?B?YS84UVVIenlWbWc3MWRJanp2am9ZTy9yWkZvTTQ1R3l1YWZxUVF0MGFON1ZS?=
 =?utf-8?B?TlFJSnhWQ2tocENhbEJ2bVZGcmZsR0FPUnBiZDVaTVJUN0s2V01aNG1LZWZO?=
 =?utf-8?B?TENuTzNqWnRFYUtsMytXYVdqRy9TT0JGWDhuSU5mN09SQUZCZjI4Znc3YnhK?=
 =?utf-8?B?QjdDOTFBeFFLbVBCcWgyVWxBZTdaL2lSOUxSckVGZGZnZ0F1OTZCekZpQ3Nj?=
 =?utf-8?B?LytxaEpaSXpXZTVRWnEyM25zaVhBbFB4MHIrZTB0emRxS2hDWEdMZTgyVU1l?=
 =?utf-8?B?U1JuVmV6R29Zd05iL2Y5TFN6R2ZhSENGcmdwZXdOS0F1dnZOd1MyWkliRFdL?=
 =?utf-8?B?NkcxSnczbXM4ZHIwYTg5bmhOZ1JwbG9jZmppNnRwZENBdWQ0QjBjRUJiaHBa?=
 =?utf-8?B?VHVjMDZ6VFcvckdFdW1xaTRzWTZ4c0pKV3o0a2hqaVlHSHpsOWVXVVIwUlds?=
 =?utf-8?B?YWJOa3ppOVZaNGNCenlhQzkwK1dWR1NrTXRuQXdHemxqSVlvYnorTllkVnpx?=
 =?utf-8?B?dnBFaVpYU3dFYzUrWHNVSVNCUVRNbCtmbGhha3YyTTFQUWZPNUprZkJUTXlx?=
 =?utf-8?B?dFp2VXlPMHlJVHJOSTA2UVF5em1vMm5pN2swRGJaeS9KbTJtUDc2VGphWSt1?=
 =?utf-8?B?WjN6MHVtSERieWVnMXJtUXZmN1pTS2t4Rkl3ZFIrazdjaUdCVnZ3UDhvQ2Vp?=
 =?utf-8?B?Zi9FRkxmbVhKTWJaS3hWUm9LWXlTZnlKVkpGM0MzTjdHakU3VmdNSnlHazMv?=
 =?utf-8?B?dW8xQWpxMnJNL2FuQkZxT2hOVnQwcnFjTkNYK092MzlGemdqZlg0WEMvM3Y1?=
 =?utf-8?B?VDF6Mnp1eWo4ZitUbGdsZ3VpYmlWMlhML3VicWdSQjBEbWsvNjJOK0p1eU5t?=
 =?utf-8?B?dlNmOFlaY1F3MjVtOUN6UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f28a528b-d186-4c32-eb10-08d931558fab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 06:03:00.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9AXEGsXWxihrwhm1RbxNp2/bYzjtl+v1rjEoMLzwD4LJgrBt/XDXCYssyWv9VuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: x59oVjp4YcSt_NEmSNCF7k6n1_594dS5
X-Proofpoint-GUID: x59oVjp4YcSt_NEmSNCF7k6n1_594dS5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 5:05 PM, Vincent Li wrote:
> Hi BPF Experts,
> 
> I had a problem that verifier report "R1 invalid mem access 'inv'" when
> I attempted to rewrite packet destination ethernet MAC address in Cilium
> tunnel mode, I opened an issue
> with detail here https://github.com/cilium/cilium/issues/16571:
> 
> I have couple of questions in general to try to understand the compiler,
> BPF byte code, and the verifier.
> 
> 1 Why the BPF byte code changes so much with my simple C code change
> 
> a: BPF byte code  before C code change:
> 
> 0000000000006068 <LBB12_410>:
>      3085:       bf a2 00 00 00 00 00 00 r2 = r10
> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>      3086:       07 02 00 00 78 ff ff ff r2 += -136
>      3087:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>      3089:       85 00 00 00 01 00 00 00 call 1
> ;       if (!tunnel)
>      3090:       15 00 06 01 00 00 00 00 if r0 == 0 goto +262 <LBB12_441>
> ;       key.tunnel_id = seclabel;
>      3091:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>      3093:       67 02 00 00 20 00 00 00 r2 <<= 32
>      3094:       77 02 00 00 20 00 00 00 r2 >>= 32
>      3095:       b7 01 00 00 06 00 00 00 r1 = 6
>      3096:       15 02 02 00 01 00 00 00 if r2 == 1 goto +2 <LBB12_413>
>      3097:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> 
> 00000000000060d8 <LBB12_413>:
> ;       return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
> seclabel, monitor);
> 
> 
> b: BPF byte code  after C code change:
> 
> the C code diff change:
> 
> diff --git a/bpf/lib/encap.h b/bpf/lib/encap.h
> index dfd87bd82..19199429d 100644
> --- a/bpf/lib/encap.h
> +++ b/bpf/lib/encap.h
> @@ -187,6 +187,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
> tunnel_endpoint,
>                         struct endpoint_key *key, __u32 seclabel, __u32
> monitor)
>   {
>          struct endpoint_key *tunnel;
> +#define VTEP_MAC  { .addr = { 0xce, 0x72, 0xa7, 0x03, 0x88, 0x58 } }
> +       union macaddr vtep_mac = VTEP_MAC;
>   
>          if (tunnel_endpoint) {
>   #ifdef ENABLE_IPSEC
> @@ -221,6 +223,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
> tunnel_endpoint,
>                                                  seclabel);
>          }
>   #endif
> +       if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
> +               return DROP_WRITE_ERROR;
>          return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
> seclabel, monitor);
>   }
> 
> the result BPF byte code
> 
> 0000000000004468 <LBB3_274>:
>      2189:       bf a2 00 00 00 00 00 00 r2 = r10
> ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
>      2190:       07 02 00 00 50 ff ff ff r2 += -176
>      2191:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>      2193:       85 00 00 00 01 00 00 00 call 1
>      2194:       bf 07 00 00 00 00 00 00 r7 = r0
>      2195:       79 a6 48 ff 00 00 00 00 r6 = *(u64 *)(r10 - 184)
> ;       if (!tunnel)
>      2196:       55 07 94 00 00 00 00 00 if r7 != 0 goto +148 <LBB3_289>
> 
> 00000000000044a8 <LBB3_275>:
> ;       __u8 new_ttl, ttl = ip4->ttl;
>      2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
>      2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
> ;       if (ttl <= 1)
>      2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
>      2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
> 
> 
> You can see that:
> 
> before change:  <LBB12_410>
> after change    <LBB3_274>
> 
> is different that <LBB12_410> has instructions 3091, 3092... but
> <LBB3_274> end with instruction 2196
> 
> before change: <LBB12_413> follows <LBB12_410>
> after change: <LBB3_275> follows <LBB3_274>
> 
> <LBB12_413> and <LBB3_275> is very much different
> 
> and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
> 'inv'"
> 
> Why <LBB3_275> follows <LBB3_274> ? from C code, <LBB3_275> is not close
> to <LBB3_274>.

The cilium code has a lot of functions inlined and after inlining, clang 
may do reordering based on its internal heuristics. It is totally 
possible slight code change may cause generated codes quite different.

Regarding to
 > and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
 > 'inv'"


 > 00000000000044a8 <LBB3_275>:
 > ;       __u8 new_ttl, ttl = ip4->ttl;
 >      2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
 >      2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
 > ;       if (ttl <= 1)
 >      2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
 >      2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>

Looks like "ip4" is spilled on the stack. and maybe the stack 
save/restore for "ip4" does not preserve its original type.
This mostly happens to old kernels, I think.

If you have verifier log, it may help identify issues easily.

> 
> 
> 2, Can I assume the verifier is to simulate the order of BPF byte
> code execution in run time, like if without any jump or goto in
> <LBB3_274>, <LBB3_275> will be executed after <LBB3_274>?

The verifier will try to verify both paths, jumping to LBB3_289
or fall back to LBB3_275.

> 
> 
> 
> Enterprise Network Engineer
> F5 Networks Inc
> https://www.youtube.com/c/VincentLi
> 
