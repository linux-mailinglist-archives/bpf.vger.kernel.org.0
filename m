Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCE4448E2
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhKCTZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 15:25:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229697AbhKCTZL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 15:25:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A3H5j0C008860;
        Wed, 3 Nov 2021 12:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KszmytF9015a6+bOpb/oWonMA43CFsKQ6m1EDU1PQiI=;
 b=ig5/KuDEhQxY5TU/qNQdMZrf3MA6WLqVPWvd6SRR12E+6rseWWp0CS18cGGT4Id1+gHj
 aBWa+QExehH2D5h4TIRmCKb0SfdnOuHlKYkTGjrcBQCECMJO9nZf70QQvbuSM/oh6b55
 kx06dNANjLIIwLv3+s+ZmzfEgm0oDw+PvJM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c3dceykn5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Nov 2021 12:22:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 12:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQD9DRE7eO29pieituA4BgaspnS66dn3PcXZknpIK/wh/7mS1pbeo8XMxxcrbXmh9Vl8KRQNL5gq57iulZjyc2xf2VlOw6LcOAfFPJMHppxO6e61EBEa/YD0OEjy3EKwvGlDy7TnAJWAnOme5gDlLTptCHoqenTgGx2IwfKH4qAd/5MP8iVbdAhaI0pxH0IuKl7fBfl7Ey66teyGEPBwlXNPdNA/vLA99aEmpDEuDX+peZuwhkb5/TVoeAleiBIyWyBZsQT5RWOJONyYIixK2xHIsyHEJkmd4+tySRp7bIwhHl2xgu//3TXSLIihyYH5pinVq1hLAFAfneMSDn1/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KszmytF9015a6+bOpb/oWonMA43CFsKQ6m1EDU1PQiI=;
 b=jDANcALwF1w1g4UL3W22700fOhCahFL5ayBfZOEhFqE3RCMnvS6/NUHjopLR+hsDdrmd3PnUXUj/07SQmlCwGMB1DR8B70q3gq/A6BwdpgiPBoqEk4qBo6CmRKsaVJiPZMCR14VwmTP0gfHIyI/pzbsoslAjgYgzu9WbX3BwPsltdUkiQWDQv2/oVj7W15AdaHDIL9SNB5Orv8WwxE8hhQzSPaIXxksMHKudNFxDmIPrfWL0T+BwD0Mh0EaEiKsQIwprQIgjC6oeU54r4EbvCdUlajwiNGFj2ZhzJDTEvid6ej6UWXZ6p1KbACXRfu3cSi8xg06t+BeYVfJOrC82+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4094.namprd15.prod.outlook.com (2603:10b6:805:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Wed, 3 Nov
 2021 19:22:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 19:22:21 +0000
Message-ID: <5ef48d28-c8f1-83de-a918-d7b670f6f4de@fb.com>
Date:   Wed, 3 Nov 2021 12:22:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: Question about pointer to forward type
Content-Language: en-US
To:     Hou Tao <houtao1@huawei.com>, Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <c19f223e-2ef5-9f9a-f741-2fcc7d89fef6@huawei.com>
 <050ba6c6-c7b2-528c-b616-030b7b14d67e@fb.com>
 <bb306bdd-4770-6d47-c490-a206d191b1e8@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <bb306bdd-4770-6d47-c490-a206d191b1e8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:bc20) by MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 3 Nov 2021 19:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6901fcbd-63e3-4130-507c-08d99eff41fe
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4094:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4094D40001FFA0E94E09BD56D38C9@SN6PR1501MB4094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eof105pefGJlsgvDJYDtIzdAPnfy8fgGNNOVAyLcXFsrDtuKdqsSzWY0yz34UHqk+xKiWY7MjBURbJnFSzWoYYhanAEYn8ztqvrMbUfPEDqK5q06nJhPLpqv2oZDgxhhIXM5TaGbS5oMpH6RawC9Hsm4oZMDWtMHM0b0XxL4U4s0YuRWwbWNSp+C4s9DgY+ICrwUNZH57J8U3ft23PqBuxMg9nL5u85iZ1NVVoyFYd0Enke2BZY6ocZCURVLyN4YK48tMippqhYsw3Wf33wujbZ31OdG0vj+cZ0RXdZ7Aw4R+AJ2VN/oFe/VwvP9hsqLIn6xus4cJriAbAWRtAwxRhacwk54VXqS9X4uu6/cab3U5wqJgL01pjxsTnp1hgSVz3T6IxNCmLciWGhg0z0RvhtMoLEtR9/5xYSYyGgDt7taFU91DBZiaCr2wtNlB501YSpRKF/XZXvF1tgv80Vh5z0b+aZHJrlz4IxUjgGbvRvbL4f4I1E4B68NPKV4qHLNGr0bP3B5AihlDRUZPUbP9m+aGxdwgH87Fx1D4GNlKzP8+yt9d6IltTYnglOQqe8BQ+jS3tOm5YFRYFvWcYI6YyF0cYHwzPffJ2jR9hy/QQzzNNhsaXNhooisrUCRD7minaDJKDcCpbrNPagy3pNLs0WdknBB2i5pyyUyi1DYyFiwt6DV7Le5dEHQ11aWYvxqgnTYj1OcPZgSfpQUkgSgA/0naYZrT721IDjk+gp5yEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(86362001)(52116002)(4326008)(66946007)(8936002)(31696002)(66556008)(66476007)(38100700002)(186003)(53546011)(6636002)(508600001)(6486002)(2616005)(2906002)(316002)(31686004)(110136005)(54906003)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDJRV1dWTCsxSExSYnJKbE51OWF1b1lWU2ZUODhYYmtiWUl6SGE4bVRGcVpD?=
 =?utf-8?B?OG1aOGsyR2pqdDZ3RmpZM3cyNis5MUlTa3B2THU5MDhyVHdDL1NsenZxUzJs?=
 =?utf-8?B?d2dXYzl4eldqWmlSeTdHUlVxaG9BTXhaQ3hNVlFLRWRCcTFrdXdzdHoyVkVs?=
 =?utf-8?B?TjMwUkY1a3ROQnRhQytrRDNwZlBTZXBYd0pHajRXV0pSeHFRUkdncUVZUnh0?=
 =?utf-8?B?K1RiZk5tRzNUL0JtMjh5YWxBZWRoT1paODI2MWpMb1hOT2xFb0MwcCs3QXF0?=
 =?utf-8?B?a0VJSGNzSDdTT3pITk9LeHkzN3dmWVdTVThQNm5TZ0hwbVYzTU00ajNMM3Vr?=
 =?utf-8?B?a2tmY2dEK1V1U2huRlhpeTgyNnh3NGE5OGRwYVUxSmZoUVI0V25heWVHMnhx?=
 =?utf-8?B?M2FTVnBoeDgyTCs3QVZjVXZ1c0kxV3Q1YmpRdkp2QnRWNWZWMXdVQlBhblJY?=
 =?utf-8?B?YVA2Z0JjWG9PM1JwV3R3ZjBIcENqMTdTVndZeTlzRE5ldWR4MUw3ZGJ4SGkr?=
 =?utf-8?B?Snd3UG5OTTdKYUhURkVOb1Z3SEFCb20wU0txcWplOURnRzArc1JpZm9KekJy?=
 =?utf-8?B?b3NUeGNPdFRWZGJ4RUZvZ1dmT1JQY0Z5Kzdxblo3OUlRWXVWSi96bWswVWN6?=
 =?utf-8?B?RGRkTEx1Y05RVE5vREh5MjMxOGZ5OGhPNytSSTU2RGRpamdyMWs5c3VpOWJO?=
 =?utf-8?B?WmtiUU91M3NuUFNSN0NJYURITlE0clFmMnRSdTBIdW43U1ViOHg3Z2FSTjZI?=
 =?utf-8?B?ZmdzQVVMYnQxVXdBTEVsbHBVZzJiTW9ON05RU3g2NittVnhMdTFiNDRZTTh6?=
 =?utf-8?B?dXJqU0ZVd2hjcVkzbGJPRDc5QTVCbXl0ekg2SmpVeXNKKzVSVWt1TFp6NXJq?=
 =?utf-8?B?eVVDL2tqRHZsWElTeW0rUGs1eHBKaFUyNHlqa2RFRjhreFJOVUFPdTBEMExw?=
 =?utf-8?B?RXJpOUdRTU41M3JCMDJMQnRzaFQ4dnNaVTlMV1dqSFNnN05BbVlZaTA5WXZX?=
 =?utf-8?B?VVZYTE1UTk9wUHFNdG92MlVvUG90TmFZVk5tbVd6VE5rQ3p3T0hpTmxpTnpW?=
 =?utf-8?B?aWFNanVJdHhVTjFkZlNoQURXZjUyMk5pSHRXb0F3eVdWdHhSNzhrblF4RGlu?=
 =?utf-8?B?Ym1QQ1J0U0VPRjBtUDVHVS9aV2YzdkpzQUZvK3o5WG5zOGJ5ZnM3KzBrWkx3?=
 =?utf-8?B?TE52SEUyMVZUSldvUnNNRVVpbVRiaVpnd3FXNmdjcjhkblpZSXNlcUNYdVBs?=
 =?utf-8?B?OENmZGw1b0RIN0dLMlMxczIrL1BtWmJZY0sxRFg0ck53N0lFUExqd0R6YStT?=
 =?utf-8?B?bnBybUR3ZWRmanpZNW5laWI2SFYzZG5TYmhaQlhUdzZOMGMrRmFnaVg0ZGFj?=
 =?utf-8?B?ZVI4T2ZSWG9KbXdzRy9yT2lTNFg0Z3FNMWlveWxOYmRDZnlkMndQdUtTU1NG?=
 =?utf-8?B?cEhRcjFERmxCNktPUlVRdjViekZkek9ZUnRxNGhqYmVpQzdRMjNJa1JEVHh1?=
 =?utf-8?B?RTRWT1NOV3VJT3dKWUR4TkhRdXJIbmlsR3VNc0wva0svRGlzY2kzbGkwTnZL?=
 =?utf-8?B?Qnl0K0wvWmRsc0lHM2psaVFudi94dFBoMlZ2bG5qQTZoOEJBWGtzbHAva2xY?=
 =?utf-8?B?M1FoMjR0QWlQSXFYdG9MUVBqSVRKNjdQdjhqOWx5eGV6K3BjVEVIaGszeVdF?=
 =?utf-8?B?OG5FbVE2cURIR1dONTdwU291djU3VDFLbXRzT0J5cTlKallTbkNmUXh1ME43?=
 =?utf-8?B?SncxSEFwNWN4c1o3WWtqSzFMRGV2WDZEdVRxcHFyTXBNV1VIK3BDVHcwckE1?=
 =?utf-8?B?d2MzSFBPNTRGUUUwc2RUb2IwRUVPbEl5VzhSNDJMWHNQeTRvSXFacnpsUTZQ?=
 =?utf-8?B?d3ExcjlsY1VvS2pvS3I4RzJTZ3V5Z1lMcVF5YzF1YVA1VEtVVG9qdjVxblQv?=
 =?utf-8?B?TE9sanIxbTRBcE51ajd2YzhDK0ZsRzJOSnpPZkJma25KUDJlRUpSeTMyR3dS?=
 =?utf-8?B?NzVLeHdKYVZiYTFRbVRTS21vWFgveVJjdXdsMkt2SG9ENkQ3cUZwYWN4bXA3?=
 =?utf-8?B?M2xoTmRqOGJydERib0ZaQkpiWGZ5S0d0ZVZRWHpmY1llR01ySEdhazF4bGR3?=
 =?utf-8?B?Q2dFTU9GOFNJU2tmaGZZU3NEQmY3SzllZXRpRThwQjJWZlVvNWVtbEI3Wm1D?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6901fcbd-63e3-4130-507c-08d99eff41fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 19:22:21.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UIaJ2ONtKnB7107Ho+LMOEgXNWlOsyvp0MgwySyjjz42Rm85EjO5NsBQkfl+Rl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pKmjn1FJXPtaA7odo5Yr2CPvz-5XpQFh
X-Proofpoint-ORIG-GUID: pKmjn1FJXPtaA7odo5Yr2CPvz-5XpQFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/21 4:00 AM, Hou Tao wrote:
> Hi,
> 
> On 11/3/2021 11:58 AM, Yonghong Song wrote:
>>
>>
>> On 10/15/21 7:22 AM, Hou Tao wrote:
>>> Hi,
>>>
>>> When adding test case for BPF STRUCT OPS, I got the following error
>>> during test:
>>>
>>> libbpf: load bpf program failed: Permission denied
>>> libbpf: -- BEGIN DUMP LOG ---
>>> libbpf:
>>> R1 type=ctx expected=fp
>>> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
>>> 0: (b4) w0 = -218893067
>>> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
>>> 1: (79) r1 = *(u64 *)(r1 +0)
>>> func 'test_1' arg0 type FWD is not a struct
>>> invalid bpf_context access off=0 size=8
>>>
>>> The error is reported from btf_ctx_access(). And the cause is
>>> the definition of struct bpf_dummy_ops_state is separated from
>>> the definition of test_1 function:
>>>
>>> test_1 is defined in include/linux/bpf.h
>>>
>>> struct bpf_dummy_ops_state;
>>> struct bpf_dummy_ops {
>>>           int (*test_1)(struct bpf_dummy_ops_state *cb);
>>> }
>>>
>>> bpf_dummy_ops_state is defined in net/bpf/bpf_dummy_struct_ops.c
>>>
>>> struct bpf_dummy_ops_state {
>>> };
>>>
>>> So arg0 has BTF_KIND_FWD type, and the check in btf_ctx_access() fails.
>>> The problem can be fixed by moving the definition of bpf_dummy_ops_state
>>> into include/linux/bpf.h or using a void * instead of
>>> struct bpf_dummy_ops_state *. But forward declaration is possible under
>>> STRUCT_OPS scenario, so my question is whether or not it is a known issue
>>> and is there somebody working on this ?
>>
>> I suspect this is what happened.
>> The 'struct bpf_dummy_ops_state' is defined in net/bpf/bpf_dummy_struct_ops.c,
>> but this structure is not used in that file
>> so there is no definition in the bpf_dummy_struct_ops.o dwarf.
>>
>> Since in the final combined dwarf, there is no "struct bpf_dummy_ops_state"
>> definition, dedup won't be able to replace
>> forward declaration with actual definition. And this caused
>> your above issue.
>>
>> It would be good if you can verifier whether this is the case or
>> not. If bpf_dummy_ops_state definition is in the dwarf, then we
>> likely have a dedup problem.
> struct bpf_dummy_ops_state is used in net/bpf/bpf_dummy_struct_ops.c, but
> the problem still exists.
> 
> And it can be reproduced by moving the definition of bpf_dummy_ops_state
> from include/linux/bpf.h to bpf_dummy_struct_ops.c as shown below and
> running "./test_progs -t dummy_st_ops":
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2be6dfd68df9..1d1e6dff5ce8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1024,9 +1024,7 @@ static inline void bpf_module_put(const void *data, struct
> module *owner)
> 
>   #ifdef CONFIG_NET
>   /* Define it here to avoid the use of forward declaration */
> -struct bpf_dummy_ops_state {
> -       int val;
> -};
> +struct bpf_dummy_ops_state;
> 
>   struct bpf_dummy_ops {
>          int (*test_1)(struct bpf_dummy_ops_state *cb);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index fbc896323bec..2beb755b5806 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -9,6 +9,10 @@
> 
>   extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> 
> +struct bpf_dummy_ops_state {
> +       int val;
> +};
> +
>   /* A common type for test_N with return value in bpf_dummy_ops */
>   typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
> 
> 
> The following is the output of vmliux btf dump. We can see that it does
> have the definition of bpf_dummy_ops_state.
> 
> # bpftool btf dump id 1 | grep "test_1\|bpf_dummy_ops_state" -A 6 -B 1
> [29190] STRUCT 'bpf_dummy_ops' size=16 vlen=2
>          'test_1' type_id=29194 bits_offset=0
>          'test_2' type_id=29196 bits_offset=64
> [29191] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
>          '(anon)' type_id=29192
> [29192] PTR '(anon)' type_id=29193
> [29193] FWD 'bpf_dummy_ops_state' fwd_kind=struct
> [29194] PTR '(anon)' type_id=29191
> 
> --
> [106565] STRUCT 'bpf_dummy_ops_state' size=4 vlen=1
>          'val' type_id=21 bits_offset=0
> [106566] TYPEDEF 'dummy_ops_test_ret_fn' type_id=106567
> [106567] PTR '(anon)' type_id=106568
> 
> And the definition of bpf_dummy_ops_state comes from
> bpf_dummy_struct_ops.o:
> 
> # pahole -JV build/net/bpf/bpf_dummy_struct_ops.o | grep bpf_dummy_ops_state
> [1910] STRUCT bpf_dummy_ops_state size=4

Thanks for the detailed information. It appears that current dedup 
didn't handle such a pattern.

Andrii provided the following excellent explanation.

=====
it does when you have two copies of the same struct and one of its field 
points to FWD in one copy and concrete STRUCT/UNION in another one
we don't resolve FWDs by name
there needs to be more type information available
so if you have

struct A;
struct B {
	struct A *a;
};

in one file


and

struct A { int xyz; }
struct B { struct A * a; }

in another

then BTF dedup will actually resolve struct A FWD in first file to point 
to real struct A from second file but if it's just first file in 
isolation, struct A will stay FWD, even if second file has a complete 
struct A { int xyz; } definition (but no struct B)

=====

So FWD resolution to actual structure is done due deduplication and
libbpf does not proactively resolve FWD based on matching names.

If there is nothing to dedup, which typically means you can put
the actual definition before the "forward"-decl usage and in this
case we should be fine. This is also exactly what you did in the
final code.

> 
>>
>>>
>>> Regards,
>>> Tao
>>>
>> .
> 
