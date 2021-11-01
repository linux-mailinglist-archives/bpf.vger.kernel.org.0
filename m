Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1434423D9
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 00:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhKAXUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 19:20:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60902 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhKAXUB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 19:20:01 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GoYE8005067;
        Mon, 1 Nov 2021 16:17:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ko2P8ysZufrqrB4nOMC1EiwfF8xbiaFG3ZZh6B+z6H8=;
 b=i0x8oXa6pq4IkGY6Qr+/ngIVTb52KO/O453R8OxcGrGr/WxZtcJpa6D9AQaU9u17hLAG
 6qk3oyYFT1rYzEUH0cXTup4cwQq9n2si1C0Z9aaRtQ80vHkvBAyok1XcswxyrlnLnGic
 JAq9GG5cnpT9c8zylrSQEyU7uW4/LsVw/ZE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2gryv377-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Nov 2021 16:17:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 16:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSJBpdqmDAOy0DI9PiRnyTQfxsaoZs6HOhMe5mRd98dypabFHgD+CvIpce1SuGZMQ8GaBmNo1sEuUJeayvJm3BWg4/oU8RReF4J1/89Xn80G/HrH1fbYvs3KOppHgnm5oCaxN7Yx3NLnpN1D89ksQ4YhEdKbc1SocuGtfOW0xXK4Wz3C/S4DkeGn14BCDzTbYGBh0KRWUrNmmW7lc7d5yA2Rq3QO1dF7f69ucN0OSLDlw/cBNA67xHc9HXwPRUVvduieVrNSfaTQhtExBvO/TLkR64dzliwATBIG2i571SfMHwayXSGaJ2PItE8YOEcrNFUMYWRZ7g7954SSl/78sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko2P8ysZufrqrB4nOMC1EiwfF8xbiaFG3ZZh6B+z6H8=;
 b=XEsmug4dWn1FKLHOMH4w27RV1NjbdHY9FYZ/Kynbq31Jf/xoC05qQCJiOtfmfQyy5pSoozJR49+zqvDYIS+SbDgQuCDx4AvfeiKMrDdn4dekTcm2dqkzS3D2qfngWXK5LKUTulRc3gZ88oiCl+9Kk/DCdoT4zboOmrQOezV5eU/pM5hwp3cEusm2bT+3sr18vd/TXQklgCjtdZJ13xVrUQ5hPKwVWq5x23dND3c724hPQNkFQskDZt6m1s2lxnH2f+faQxOMQf3n+yvWRFiTJA5AEoPPoeYBAeDkGzrIpNClZG5/dUm31IsrsJgYD9jxWzvCqD8GgbUyEWfI28Yq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2128.namprd15.prod.outlook.com (2603:10b6:805:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 23:17:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 23:17:06 +0000
Message-ID: <4efb8939-33ef-6a0d-f5cc-61e9f9436962@fb.com>
Date:   Mon, 1 Nov 2021 16:17:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next] selftests/bpf: fix also no-alu32 strobemeta
 selftest
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211101230118.1273019-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211101230118.1273019-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR1601CA0022.namprd16.prod.outlook.com
 (2603:10b6:300:da::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:38d3) by MWHPR1601CA0022.namprd16.prod.outlook.com (2603:10b6:300:da::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 23:17:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5839e39-6436-48b1-52e1-08d99d8db8d0
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2128:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21286C7D89F06E40EEEE1A9ED38A9@SN6PR1501MB2128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe19VB7v/KPR0/rGYe1VK1E3L78ijGSNJ5XOVJAMWsoX25dzgqc4KLt9bQFhqYAYNwnw8X0oY3U0bpeBrOuNxNrFkNJa73YASq77qcqBPz/sCYCsHIXFfVBagXf/OgW5fizrbxzHoUKry46w6pmbDs+dmMHZ5HVPHTG3BbmxageV58d0xi4opWJ2Aue+WZBd3L2lchLzqsLdRUtI0OBFR+vmx2vgcohSvEpVKWanAPKJCcAZHh48Nmbzd0CbXcwxqI5b02SzjgEdlxgokRfqMYrm3Strjzl2yV/pyqjLYYzP8eFAO5aBPcXL/KI3YDz/GhJKMGA16nteduSx57COB0ib3UEF239cBppzjZZKak4ah34yB22GhSY0wyJcRABn1a8LeKIXy+3f5lESwhxomGHcRyVrJwf6jAdJbuoVrvgoJxnKx07l1W5jZR7tuc0NGotd4HFr62AaPPNTJx8hfksIH63CW0C55jvochzhXY1kxKcamAs0dz9kLyIUxUVsDfaxk+ti6NRzBXPWRcxZA3PY7s1C5AvKXwHG0pquF6Py4r4/ucuYwNvxtIiAkyRjVh7hO23TdOceMyfGZOv3sZAVYZZj5khQLy4d98emqY4AC2fYm9JOGMJo+RHu+LRgsW6BOr1l4vgZZIzyA2WCJo8F0Xd1hcKKQyvMMl64eEQa7qwlEqM0gWshN8ZQpZEqHS9NEATWSbUoRlMBCzc9F7b5KzCFR1ULDBdct7odOSrPi1yYxceEno5BVpjMe4Sp5hOylzjrNLZUUCrML85RWojq49TPfJaKjKJ81PQ5I5tec0Pn5e7g+/H8z+ESvNv38sTqzqAQTZDmFCrDJWKWzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(186003)(66946007)(38100700002)(6486002)(4326008)(2616005)(5660300002)(53546011)(36756003)(316002)(2906002)(52116002)(31696002)(86362001)(966005)(508600001)(83380400001)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTlBeGtNc0JiQlZYWSsrWldoZzl6SHczMm5GTHVialBZYlU3WHNHbGRYLzlT?=
 =?utf-8?B?S0Rtb2ZoRFdvU0w5K1VBRE9RTmI2cld0REJXcjJGU2Y0aFpPVjk5MEZrWnQy?=
 =?utf-8?B?bHU4ODl4STFMd1huS3JTYmlKVzhrakcwSWhNMGV4dmFIRVBOWXVVdXczcWJm?=
 =?utf-8?B?cDhaejgvR3JmOWg3U3NSakVPS2NESjQwbUZVSFMySXNnSTB5eGlRbGJ0eUVw?=
 =?utf-8?B?ZDZ6NWxIakd1cFdQSjdOZXpVa2lxY1dLTWpLK04zdEFMNzRjMUZoMTlZYUUx?=
 =?utf-8?B?cllFSnJ5R3Azc09WRzBiUDlPdnZhaTBndGw1OEVTUEM1TjNmcEpiRWJQK2Jh?=
 =?utf-8?B?VFp2NUFITnAvOVI1S0ZCR2NJQnNnV2dza3RwckFUSmVYWFdqMGx3SDkzSEV0?=
 =?utf-8?B?WktwWHgwSDkrUStSbFB0WGJFelBHMjlUbmpFRUxZQy9VeHVlT1FMc25JR1lj?=
 =?utf-8?B?T0I2VTk4ZGE2K2tUL0lnUWRuYkhTUTZwb3dyWmVhSFpTM0hGM1M2UHBIS2gv?=
 =?utf-8?B?Vmg5ZnlxOEswQmxRckMyS2FGTE5JN1NkTzV0V215NEQxdnFnY1BoeFVRdS9U?=
 =?utf-8?B?a2ZhVjlCc09KNytwTm9EUVQ2VkpNRk0zTTVSU0JFd3gvOWdFZW55NWErQ2di?=
 =?utf-8?B?VmR6TFJXc1NpYUhHMVNMK3BTTkN4UW01WWRRVG1JVWVEWE9sWU42Y0swOTha?=
 =?utf-8?B?R1E0R2JpdFp6MmhSTTdXUXZqaFVGQzhnMkpRMWMrZHU2OTh0TXBPR0VaNlRI?=
 =?utf-8?B?M3ZmKzhUMnFDOHNjTmtrMWpOYk5DTll1V0lmY2FUZi9oU3hZR1huZkErR2t1?=
 =?utf-8?B?b0RxMlRHckNSRVZRTmxHR2E3TDhKRjFYWUp1U0Y5SWVJS3REVDByTk95YWlo?=
 =?utf-8?B?ckdrdVp1VXdxaHFoU0xTdDBvRWNhU1JKTk54cVkyRWxiR3FyQXIzdmIrYXZm?=
 =?utf-8?B?QnlMOXRRa21lbzFhQXZNRm5GRjNJbGVIeW11WDByOFoydFJmeWxoZ0NKZXZm?=
 =?utf-8?B?UVNLWjVQb1R1QTFKTWExNjBhM2U2V0tqMnhYcG0zeVRYdzhSOGwrTWxUUk9j?=
 =?utf-8?B?OWRnNzZXRUhDaEhNMmJvZjJQK1dreHlWOG84T1V1U0pGeHZOcFJwWWFjMXFy?=
 =?utf-8?B?UVREUm5NNDVoZGFIY1ZpVGVCOWxQbFRjcGxSblJXbEl3YklSTkc1bWJhU293?=
 =?utf-8?B?eTJZYlZ5Q2wyRzBZcm92MktVNjFnOGhGTmNGUE5sZnBYa0FVcmZzRW9STU0x?=
 =?utf-8?B?bFhCU0hjQTBQQ2pyZ0ZZUzlheFlWN0xzVk1rdEFLWUEwbjdCNFJ3TFRmVVlX?=
 =?utf-8?B?eGRWOGx4eHI5V1FMKzBmOTZLMlJWNDRqS0NMdGQ4N083MXVlOUtYbWxTbWgw?=
 =?utf-8?B?ckFvTjgyMFpxcVA2aTh0ei81SEFhb2Noc1pDYzFqTldYdmhlSVowMGFBQmVt?=
 =?utf-8?B?a0JMcUMzd1JZZFRwWklzM3lFYThVTWwwMTZaa3czSThlT294cUVjTE9KMGFB?=
 =?utf-8?B?dmlMeGRXYTdkQjFPRk83ZzJkUzlYS3c3U1A2ak8vVWdhc3lidjlKT3VyYk5o?=
 =?utf-8?B?dk8vcHcyNXFhWVppOTQ3Z0ZHbVZQdEdhYmEyZlhYRkhHYnhyL3RxSE5QOTd5?=
 =?utf-8?B?RDVkektTUTZXeUdSeFJDc1M3bG82a0FLS1p5cktUN2hkc1hrU215MFhGYlJ3?=
 =?utf-8?B?VG4xKzBFQXFOT1BEcE12aGtzYmpPdlpKQTEvRXZ2NU1Ca0FScnlMTGFMQzQy?=
 =?utf-8?B?UXN2SnRISGZIeSs1STFUREZXMTZvcWNRRHBnNUZaU09CZ0dEd2pXWGxvRUVs?=
 =?utf-8?B?ZCszZGhoSmg4L3A5UXNldWFRdVFHbWx4WmFldHlpZkx1SmhnbFpUYjRMY1Js?=
 =?utf-8?B?TWNUdmNDYVkxYmR0dUpwNUo2TUg3QnUxbGRtZ1lRRFpPVW1TWjNmZUZpd1Bp?=
 =?utf-8?B?QlZvV1ZnUzBDTTduSHhzbU9KRnRyOUxPTTFvQUt3ZXNtZkMxTnM1OFlOUkdi?=
 =?utf-8?B?YStVYVVVRGd0R1hXUCs1bGxlckdtSDZGVkhxYTlkWkQ2UTQyY3J5dUtIMHU3?=
 =?utf-8?B?NW5qS3dFSS94Z3FCK29wMUhncGRzblJCaG9tMlJXOG1HODBaZXc2TzdZeTc1?=
 =?utf-8?B?RytEN3d5MlVpVXY3U085MWZSR25lRVBBWkRUVkEyUXhTUFRZSjhrTjFnQzhm?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5839e39-6436-48b1-52e1-08d99d8db8d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 23:17:06.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B01Iy8cM4d1WGob+aLQwfInpieYwuK9wg0631foogG3Ap0VSidOi3C406gWUrn69
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2128
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: y96cXxhvVwrzo-v3V620QnUXJ_muXYtz
X-Proofpoint-ORIG-GUID: y96cXxhvVwrzo-v3V620QnUXJ_muXYtz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_08,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=895 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/21 4:01 PM, Andrii Nakryiko wrote:
> Previous fix aded bpf_clamp_umax() helper use to re-validate boundaries.
> While that works correctly, it introduces more branches, which blows up
> past 1 million instructions in no-alu32 variant of strobemeta selftests.
> 
> Switching len variable from u32 to u64 also fixes the issue and reduces
> the number of validated instructions, so use that instead. Fix this
> patch and bpf_clamp_umax() removed, both alu32 and no-alu32 selftests
> pass.
> 
> Fixes: 0133c20480b1 ("selftests/bpf: Fix strobemeta selftest regression")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This indeed is a better approach for workaround. It disabled offending
llvm optimization since "truncation" operation (64->32bit) is gone. BTW,
llvm patch https://reviews.llvm.org/D112938 is also landed in the
hope to fix the same issue to please the verifier.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/progs/strobemeta.h | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
> index 3687ea755ab5..60c93aee2f4a 100644
> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> @@ -10,14 +10,6 @@
>   #include <linux/types.h>
>   #include <bpf/bpf_helpers.h>
>   
> -#define bpf_clamp_umax(VAR, UMAX)					\
> -	asm volatile (							\
> -		"if %0 <= %[max] goto +1\n"				\
> -		"%0 = %[max]\n"						\
> -		: "+r"(VAR)						\
> -		: [max]"i"(UMAX)					\
> -	)
> -
>   typedef uint32_t pid_t;
>   struct task_struct {};
>   
> @@ -366,7 +358,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
>   					     void *payload)
>   {
>   	void *location;
> -	uint32_t len;
> +	uint64_t len;
>   
>   	data->str_lens[idx] = 0;
>   	location = calc_location(&cfg->str_locs[idx], tls_base);
> @@ -398,7 +390,7 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
>   	struct strobe_map_descr* descr = &data->map_descrs[idx];
>   	struct strobe_map_raw map;
>   	void *location;
> -	uint32_t len;
> +	uint64_t len;
>   	int i;
>   
>   	descr->tag_len = 0; /* presume no tag is set */
> @@ -421,7 +413,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
>   
>   	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, map.tag);
>   	if (len <= STROBE_MAX_STR_LEN) {
> -		bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
>   		descr->tag_len = len;
>   		payload += len;
>   	}
> @@ -439,7 +430,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
>   		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
>   					      map.entries[i].key);
>   		if (len <= STROBE_MAX_STR_LEN) {
> -			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
>   			descr->key_lens[i] = len;
>   			payload += len;
>   		}
> @@ -447,7 +437,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
>   		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
>   					      map.entries[i].val);
>   		if (len <= STROBE_MAX_STR_LEN) {
> -			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
>   			descr->val_lens[i] = len;
>   			payload += len;
>   		}
> 
