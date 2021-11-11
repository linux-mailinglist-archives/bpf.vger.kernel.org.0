Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0444DBFA
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 20:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhKKTQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 14:16:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKTQQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 14:16:16 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABJ7F2n024190;
        Thu, 11 Nov 2021 11:13:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OHDhds30HIx/QUXsZwapiERWRfPNVEdcjv9qjYIMW5o=;
 b=fHrZQ7uGFNqSSPQTNtm9zGUtLkVzZ/c5l5IGEIQ4MiHlurRMqqEnbC9+rDO1ZhaJmK7J
 YnyNZsQocBN85HP+udlM6dWci0xfX2KgNrqpU2wldipo3e4zTTw1MboVwWnOLpLcoxH0
 oRofvCBGMC+qV18muAAbm6MKBwFbyQl9ss0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c91q53qh6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 11:13:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 11:13:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twfx9jpp/hsym6ZQp3XCAWEo2ml3AlcYasvnJiOjTkQcKIPDXFrm6K5mjOuHnYNQtr3pOcoPn7/T+gx7qZvgPG0GEX6c12ttaiYlBYdH9+MBjl79vj7s6s1xqK+fIfa4l4LfAGG1ZNkQIylMeunMKjGHb0bJ/gdYhlzULDWWJ2urBCXkDCAKN0Tvn1KE5VVjmdB1TIppoLfE2Wc1EF9V/M8bAZHizsusVYuCcXY5dAIW9GSvVGM0yZmQG4nLfiwpPajr70+TAFQ1l1pPpXuBkPxkB3Dii1Mos8U3j0n24JrPug25yCBXnGBjonDfU1UTYvEKAzXqLoNdpxO4TY8IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHDhds30HIx/QUXsZwapiERWRfPNVEdcjv9qjYIMW5o=;
 b=YRSHxLzj4ZCz9c0v0hBAx6XqhH7QCAlXZT7zLaGLyFf5W4HuFaCk4GPxNHKgypY75LE7SOT4nKQLKfDfO0Hox3lS751kau+f5ie1UqAfJ3DqFjMbCy7YQDtigVhW8AYidGIgdI6Yk+RB+gCanBisYEhkbkprTMNedhsBxL6QgQcV9yWW1G/8kpbqmEUPEX0YjgjVxXUIcoNvPGTGLlKyGd92kO6KeFHPSA6Iisq13DwsdhpNiO3eMC7cGwI9Gyil8TWcHOeAISK6MB5pH9r0vjofJps9MW07BTuQQNYN+n/L5rhhnZB7DfhFWmLScF6IenKmneB+qovZxZN0EFW0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4869.namprd15.prod.outlook.com (2603:10b6:806:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 11 Nov
 2021 19:13:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 19:13:07 +0000
Message-ID: <918dc82d-4822-1a1d-7f61-4db5a0ef9112@fb.com>
Date:   Thu, 11 Nov 2021 11:13:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 02/10] libbpf: Support BTF_KIND_TYPE_TAG
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110051951.369416-1-yhs@fb.com>
 <CAEf4BzZHPM=i4DaOZE=Z945xB5a68FwbFGkTf0dW+OsmMYujcQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZHPM=i4DaOZE=Z945xB5a68FwbFGkTf0dW+OsmMYujcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0037.namprd22.prod.outlook.com
 (2603:10b6:300:69::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::18c7] (2620:10d:c090:400::5:918d) by MWHPR22CA0037.namprd22.prod.outlook.com (2603:10b6:300:69::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 19:13:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda0d786-24f4-4afb-a8dc-08d9a5474afb
X-MS-TrafficTypeDiagnostic: SA1PR15MB4869:
X-Microsoft-Antispam-PRVS: <SA1PR15MB48693D9AD423BE7A49699B12D3949@SA1PR15MB4869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kImwdTxTNb/JYaDAFT5oYC7KJe4ztP3xoHIQDfvzc5Nwc7rDc+Lhn88Lermf/K50oa7XTVAeQNVz9xO+eN7YkhaQEtNvnZERsFnzBezDYLkHrdHSrWgYP+bHcqtTejeitYdnf+t60aFhlu3XZ+GEsmFibXZb7s22DzyoR2szBhA4ZrIEmn6kf/Fp6p3FHMVrLgUnRjtx1+TKqJmUMfF/qAIPjGEfdBfxTVe0oABqVZru7SQExf4Ve76W/gOdlXkSdp5otXMbOCEm39V0YSUw7a+JsYmB1A1V5IEKkjImewKXsKLGY5wL0Og+nst71XAZUlndkDjrZ6X0NJhUAYL+ILFqRBqkW/XZaSwnSAUwbBWmj4FNxbrtb62Qscq38SM1XHScNKLtGDdLKKwQcqb80VYyHSn6V7ZhjTl4vYGDog5vxOW3BEXKp/GTgTM2QvY6XKEiSBt3t/chmWbOiiV7EdrqlEemY1+Ooq9LB7Rv8K/3KUc0ZjUxD/qJBQ93cm9Tu/SYcVbaJ0E/zJkRS8Nb9sFzlI8AFI7BM3CXx2duykliOPja1bSUYvOfng8hgqiQ9bnk/guaRlxA8gBaoAlRXiXZ4HoTfD/XeeV7sYE3kjQpi2/WQeFe7UDic6BQ/Z5aj9YUsD6pvuaTkPBmIp53dkcP1g1X+Ld9b1uyri9y1Ri1p6SeVxuo59f0Yl1sUtLAIDI+GJWVparnDLmTmphbaM80/rPwzxCM8zLTbvCw5dlbXiG0YsNYEwu+MDPkZgY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(86362001)(5660300002)(2906002)(6916009)(186003)(8936002)(66476007)(2616005)(38100700002)(8676002)(83380400001)(36756003)(31696002)(4326008)(6486002)(54906003)(316002)(53546011)(52116002)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNBRkJRelZxZHQ4eDVZbnBtN2xJRUJ5M1RaUnQ0Vm5WTWZyZ051NXM0TitY?=
 =?utf-8?B?bGJ3bDdRbUNyUUI3SnViemFNVVRFRG90NEl1RDFIZWZsK2dGMEF6dWM3cHR3?=
 =?utf-8?B?NDkxZG1IdXo1QmtBSXVNYjlsY3hzQmZsZUdtQW84MG9hSkRpeURvUi9ESlht?=
 =?utf-8?B?RTF1bFRRUElrUmJTV0ZiT1h2UWIyZDNGTE9tSisva3dRZUhQdm9XVDJHeGt2?=
 =?utf-8?B?TmlOdnlMWVV0bUxXZFV6dmJoaE5hMWR1MmRxVDQ5V3o3MXNDRllZVkdhK1hJ?=
 =?utf-8?B?aWl3ZmNxNG0xeDMvUHdOb2RDa3BDUWRwY3NEWjdnS0FMVmZSQm5HSW54YzBi?=
 =?utf-8?B?TkdpMVBGcFg0Z3praGZ4VE9MWmdGKzdkUWdIL0d0KzV4S0ZpcExZUHBJNUpH?=
 =?utf-8?B?c2VDQm5IT1FmM3hKY05ZMmt6RGFIaDd0cWsxclp1RSsxMHRuTEl6OWFVYThE?=
 =?utf-8?B?dGNDeUlCOGZmeG55TFBPeXlFWS9iQXNQQ09JTkx1Y0tCaUxXcGZ0azN6cWVz?=
 =?utf-8?B?N0ZIc3lpUzFlemptV2RpT21XN3kvVmhWV3ovalBINUppMEdNTTYxT2NMaDIw?=
 =?utf-8?B?TzdOc25ZaDd2U1grakxGdGhQYktqVE1oT2RodndUSzJJNXBGdkNQVjcxTWlO?=
 =?utf-8?B?YkhpYkl0UmhIWkUwZm1qM1pzbFhzQVlZeDg1RWJMTGpzZEhzdWErOTdienR1?=
 =?utf-8?B?em9WSnVEazVFVFVYb0ZRUHBSM0VMRzlweTlqcjBKT0N2bUMwQmpTUlZ1U0Y0?=
 =?utf-8?B?Q08wbFJXWnhXVGQyNlJpcGgyQllvemM1S29vRFpvRTFqbHZ4Y2dZc3ZOQkpG?=
 =?utf-8?B?cm9TQlBIMi9taDZxeEZjRTJUWWxvZzU0bVFGaTNYb3p1NHpaM3lGbEdMWFpJ?=
 =?utf-8?B?M1FiUWRmRFFjNmJ2bTZoam9XK0lTcmVJSWJmWk1XSnpoMmdWNXFGeWl1b01J?=
 =?utf-8?B?emVadkxLT3ZCWUQwWkxtNktKbHlDQ1l4TzVMRUZEWkFyNkxIcnZPWlpMMFFv?=
 =?utf-8?B?YTJjMmJMVUdTVDJRc2U0VXB0VDBZemp4M29acXM1eXVMTW9YVTdwa1VXaVJn?=
 =?utf-8?B?aFRaSzJETSs5OURGWi9Fc1pkSDc0Mm44dzdFbzZvdmJKT1hLaXBORHdJWXZs?=
 =?utf-8?B?b1NGd1Fic1Z6NEpyRXhtK0IxVUtncXdudi9ad09qUFllWlFqMEJGbUhBblBC?=
 =?utf-8?B?aTBFbGtMN2JHZlgvSThRcW5aaitJbXhmdTBaREJuOGRXc05rTFZyUUI1VHJZ?=
 =?utf-8?B?UGdoS1FoMXh6NzMyeGlCR1pWRWpWaFd3eTJLaG5FTCtvaVhQOExiZ3YzOHV5?=
 =?utf-8?B?MitsOElMTFRlYVNYMmdaL1R2RVpxazRVQm1Cb0d3NStESXk3TDV3VFJxR3k4?=
 =?utf-8?B?emFRSXhtODNkVjl4V3o2OExiOXZDYUhsT2tLRWtLdWFScXpWdkx5U0o2dzdi?=
 =?utf-8?B?b1U4Zm5DUG1hK1lOYkk4cnppOFpIZlprTkY4WG5JTnBZcFZDUkNvT2pnb1lu?=
 =?utf-8?B?Y1hxT28zTlJLMm02NXdJVEdIamZLSmdRODlZcDFHZWwyN1pHcWdXQ1p6VS9x?=
 =?utf-8?B?RnBSdUwxNllxL3FTV01mcWVwdFVuMW5xcWZvQnltMlhEZnFvNWFScFluMkM2?=
 =?utf-8?B?OVIycmtNWEFNWFdxNzdNb24wTStsWU96UmdIQ1U2TEJadnlLM1pJMFMxZ0Ns?=
 =?utf-8?B?aWhWMWJibFdhMGNiQlM2VjBpL3VNN3RqMk1YUnRyL1kycksvSWUzVnh1ejRm?=
 =?utf-8?B?dmF6Nlh0bXJLNVBYdXhGcE5LMEo2a0dySGJFUHlIMVIvR1RDc0RiaWxrKzJH?=
 =?utf-8?B?ZVlXR1ZRV2NKNkt5eDgxeHNYdFdRak1vM0d4UnFZREFYU3ZjbWw4R0FnZWhY?=
 =?utf-8?B?N0g3b0FHNnNMT3dma25udTBMRUZsTDB2YzRMM1BZUVptWXVteUN5TFZoVDBL?=
 =?utf-8?B?c1prbGZwQlVlS0tUVENad1lXN0VzSlVJdi9kM01SYVIyZ09MK1FmN0dRWVdV?=
 =?utf-8?B?ZHM4alRtOWNrUHhJeVYvaFhReWpYSThEWXI5QUt4OXphVHpYL2VzTVM2VGVP?=
 =?utf-8?B?NnZyOUszS3h0UFRkNk94SkpWaWRwaDloNU1ZenE3QXNxWVd3elg2R1QxMTdi?=
 =?utf-8?B?b29HOURvbFA3NXVYeGpBTTBqV1VBSlFrRVNCa2h6RU1IajYvdnVrS1lvK1lO?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0d786-24f4-4afb-a8dc-08d9a5474afb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 19:13:06.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzpmR8B7rCFn9JtFgBVLilJY3bIY3WaIKigUzxx/sSNbzOdTWLBSRPVMJzS9RHAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4869
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JpB7YLaMd-2_hcpVxbMi-Bq81HDb4By2
X-Proofpoint-ORIG-GUID: JpB7YLaMd-2_hcpVxbMi-Bq81HDb4By2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_07,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/21 10:41 AM, Andrii Nakryiko wrote:
> On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add libbpf support for BTF_KIND_TYPE_TAG.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Few nits below.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   tools/lib/bpf/btf.c             | 23 +++++++++++++++++++++++
>>   tools/lib/bpf/btf.h             |  9 ++++++++-
>>   tools/lib/bpf/btf_dump.c        |  9 +++++++++
>>   tools/lib/bpf/libbpf.c          | 31 ++++++++++++++++++++++++++++++-
>>   tools/lib/bpf/libbpf.map        |  1 +
>>   tools/lib/bpf/libbpf_internal.h |  2 ++
>>   6 files changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 7e4c5586bd87..4d9883bef330 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -299,6 +299,7 @@ static int btf_type_size(const struct btf_type *t)
>>          case BTF_KIND_TYPEDEF:
>>          case BTF_KIND_FUNC:
>>          case BTF_KIND_FLOAT:
>> +       case BTF_KIND_TYPE_TAG:
>>                  return base_size;
>>          case BTF_KIND_INT:
>>                  return base_size + sizeof(__u32);
>> @@ -349,6 +350,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>>          case BTF_KIND_TYPEDEF:
>>          case BTF_KIND_FUNC:
>>          case BTF_KIND_FLOAT:
>> +       case BTF_KIND_TYPE_TAG:
>>                  return 0;
>>          case BTF_KIND_INT:
>>                  *(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
>> @@ -649,6 +651,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>>          case BTF_KIND_VOLATILE:
>>          case BTF_KIND_CONST:
>>          case BTF_KIND_RESTRICT:
>> +       case BTF_KIND_TYPE_TAG:
>>                  return btf__align_of(btf, t->type);
>>          case BTF_KIND_ARRAY:
>>                  return btf__align_of(btf, btf_array(t)->type);
>> @@ -2235,6 +2238,22 @@ int btf__add_restrict(struct btf *btf, int ref_type_id)
>>          return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
>>   }
>>
>> +/*
>> + * Append new BTF_KIND_TYPE_TAGtype with:
> 
> missing space

Ack.

> 
>> + *   - *value*, non-empty/non-NULL name;
> 
> s/name/tag value/ ? It's not just a name, some tags can have
> "parameters", right?

copy-paste issue (I copied from btf__add_typedef).
Yes, tag value is the correct terminology.

> 
>> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
>> + * Returns:
>> + *   - >0, type ID of newly added BTF type;
>> + *   - <0, on error.
>> + */
>> +int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
>> +{
>> +       if (!value|| !value[0])
>> +               return libbpf_err(-EINVAL);
>> +
>> +       return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
>> +}
>> +
> 
> [...]
> 
