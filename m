Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8190031EEE4
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhBRStB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 13:49:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234535AbhBRRlA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 12:41:00 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11IHapuD010333;
        Thu, 18 Feb 2021 09:39:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vRhQHxDotIGSYCuRhuuZkB1Hxs8KA1Pp1zuhVmhIoLQ=;
 b=bHMPIpfbnZdD+zkLApfC9QJR43JfY5XpLgAcZxtXKS8jWoseJVlOmKWHkaHPvqrucIED
 xg5FlSG3/gHygvZSL3U/k/eP21n7/QLy49oekjBBF4PghGqgup+KklPFA0KJ+kFVR6H6
 zRgXlN34Pysc25KzKG+T8zHsOZM/iooIttc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36svm782wr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 09:39:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 09:39:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU4FV8ld3QeIAWW8Nd4woNEnhdBUqUguW6GolPqkhqp6WxJNnvA4BTBjUZN+tWal+C1ud7n/fz3WWp/hrSlMQFPC9mayGWeRaQFoZKNyjtRk5MsW4tO1lrYUAYJZGvFz1QgEPqiS3qZJ7XkbZmz6l9MEFGt3ZSqtAsYoEZiIYWl60nrC1Qm6Nr/LPv9zjFsS+ZHhg45M7SwoYS+5Nz9H7YUp7Tpyd+xwAE/ZwdL3cqu7dzakYaVX3d2+Av1g73uYk3TH6ZEmC9DC26oApfUflG8+d3+SwQHWzwevZEs0CVotWep01oeds+HpRTphs68+RKxv1bt/Cr7HIpVZvg6XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRhQHxDotIGSYCuRhuuZkB1Hxs8KA1Pp1zuhVmhIoLQ=;
 b=Bwv7nFKZWohZCN33YaV0Y3+l0NtEgpFy8cnAu0ufQgZYmU7cuEMpvScsPKDK0FkIEfzqu7t3NkB0pgOiUUP5gTv5r35WZ8f96LO235JBtPLhbhbCZUTy1hnqb+7MdhMT3VP8EqEUc8wPgMx9H6R4/8D8HhH2gt8T+TodCCTvIqHTWer2ctbnO6rzLSXqd4vsppxdg0DLfx07vvKSMaiOOICV7BQZr7Z+QfoErdV8x2KJJhGE5T3mzUz8YxfPaq8nBxzwuvgSzxkrT4grvr/i9G/GWbp4u04wch83t5h+3Kpc7SiiJ+tFhBzFcUfd2hOXE78/I7dFywz6YeG8QgfuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3569.namprd15.prod.outlook.com (2603:10b6:a03:1ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.30; Thu, 18 Feb
 2021 17:39:50 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 17:39:50 +0000
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
 <ace21632-0292-bcde-d87b-fc3b00fc612c@fb.com>
 <8c88e095fdd48e9d71693021b3048119f45895e6.camel@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9f03bbc4-8664-e093-d6dc-b9737309a313@fb.com>
Date:   Thu, 18 Feb 2021 09:39:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <8c88e095fdd48e9d71693021b3048119f45895e6.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:5a6d]
X-ClientProxiedBy: MW4PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:303:114::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1506] (2620:10d:c090:400::5:5a6d) by MW4PR03CA0389.namprd03.prod.outlook.com (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Thu, 18 Feb 2021 17:39:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00779e6-258e-46e8-99fc-08d8d434318b
X-MS-TrafficTypeDiagnostic: BY5PR15MB3569:
X-Microsoft-Antispam-PRVS: <BY5PR15MB356970797115190D77621BF4D3859@BY5PR15MB3569.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mr0XwjvtNYiSg/GUpo8IlBH0x1VZKNSIHBCKu9VjISALmPHkgn/Ra180NyPLNPBKVESkNsqvm5aRRdvrLIINhyerRnU/B7/55+lc20UoW1hQunoS3YNsZSq0M3Eh2NHc2YYKcZcYX4n22ayiEvlx2unGxY5TKyjCHTNIGBu1fHhJJzoMmkXL5OY57JpBx6vClS/OwDI4qBkDXVbYFyuKilga0zev/YNHxeKm1eVV5rDeK6VtbefNe56xVQhAxfMp0hjK32qNADAX0NZMfHkMPfBHWjUXw0kGfRjZmG4CJgTKKhZRJP+r9ESeMK9tTU3QIL5sKLcMjlTvrq/VBrmYDqmbYk/Qgl8o/Q5fDznV7ky2pYtvp/d1nD5K98/uppUigXPsmTdmsSsRwx3eqbcFdnQUPVrYu+pxkLo4UyMaRhH/QTIaC6HGCCGjFOV5ldIzH0lMytprqsgFhx6g36w/7gBB9B7dj2NzZdlSoeGmKWeo+dnLnDUKt9TTdpuKHm1AdaNOzmlZDq1BwYjyfh7VxYUbCGJE/osd+zHd//2g3TDTMCa+Kjp6FlAxxGkJidkZ7pfKgfbeFsEDtbXI3LPUhkTOGKbF78TN94w4WhaCGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(66556008)(66476007)(4326008)(6486002)(53546011)(66946007)(186003)(16526019)(6666004)(5660300002)(8676002)(478600001)(2906002)(8936002)(36756003)(86362001)(54906003)(31696002)(110136005)(2616005)(316002)(52116002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WllVNmtONEZDYzIydXRmSkI4RGh5YnBwV2tJRnV2NnRHdlZvd3VjL3o5Z29a?=
 =?utf-8?B?Z2EzcEcrbjJtS0s4Uy9YZ2ZLSmlLaG1XbVJDYVozWkUzZ09MWXhEbmlWbDh2?=
 =?utf-8?B?bUlERVg5cDRjTk5wYkU2ZVNUMzFCaERIT2NGb3k1RFN3UFhVcXZIVzB5TGow?=
 =?utf-8?B?R0RzUTlad21LTTBqcGIxMXdWazdoMHR6d3pGYy9CWHR6R2luY1QxazhvUTgx?=
 =?utf-8?B?cjZ3ejJpWXpCMDY5U3NvMlNqZ1ZNYUI5aVA4UWNhNVYwb2d0WVJSUXA4Tkt4?=
 =?utf-8?B?N055em9wSHlGcW9kb0NPMlJLOHZBSURzdml6MEYvUGpmTExYMjZyUWVrMmJu?=
 =?utf-8?B?YVZieG9HRllwUERYYTUySG4xc2NlRnkrTXBab0wwd0k1WEYzekNKM0h1aUpz?=
 =?utf-8?B?WGx0d0ZTdHZEUTNKSjBndVVHbVpUVE1ST1JQV1lPbkZMMnorc0RiWlNFUkhM?=
 =?utf-8?B?a3VVaXk1Vy9nOGQrZnVLSzFvNlUzT0Y4VW93bDI4MkVaUnU1N01mQ1JjZDRE?=
 =?utf-8?B?U1JIUnk0L3pSbmlyV2NEZHZGdFZNUDdaTUhLUW5zbWhpVExHTWVmUlNpY0hv?=
 =?utf-8?B?S3hNNjFaVUhkRnlmVHJiQkt6NDZYV1lDbHFqNVFRQk5aNDF1YzNreHp3SUNu?=
 =?utf-8?B?cXpXOFBtaGU3a3lUR2tZaTFsWTNkZ1Ntb0tkVHhjN3BTaC9EdU50M0dGUjlW?=
 =?utf-8?B?eDZuekRVQWpab1BKTEdqNis4UzN4c01UaUZsVko4NVViVWxUbGZuaUtmODcy?=
 =?utf-8?B?WWtQNnBjVWpjRHg4MlF1a0hKVEpwVEtiWkllNkVIQjA3aXU4dTNETmkzcS9M?=
 =?utf-8?B?b0UyWUZzVXNnQzRMdmNTYlFhcFVXdXg2bjlmaEVwRjQ3ZXo1V2VURU5MZTYw?=
 =?utf-8?B?eHZ1QWNtVjAxaTgyb1Z0VTU5ZmxmMk4xYXRla0VUQ0dOcUtTWXNtS1lDbGxp?=
 =?utf-8?B?UTRQWXZpWlZtaUova1NsOGF4T0tnY0pYd0d1ZnZYYklBSloraHZ4RFdaYk1x?=
 =?utf-8?B?WDg1U21FUmdPRi91ckxYdzB3Wm8yVEVrL1hYNktHY3VnT0lpM04zZnpZMTJI?=
 =?utf-8?B?enFucXRkRUhERERrWnA3SGU0dXFoNkNuZnpSR2NOQ1VibWE2REwwckQ2YlM0?=
 =?utf-8?B?bUhoNHBDdURORTZKY254NFI4bCswdSs4ZVFjWDN2TXRhNHFBalBHTmlaeHhM?=
 =?utf-8?B?aFBXMTViQlNmUkU0OXF1d1ZKd2NwNkxuVTRxc2hEa2poZWkyaUVUa2tXQ0h6?=
 =?utf-8?B?Q0ZMUTZndHJZRHBaTk1ka2NEY3pTY0VnYnRZeXdqWmdndXlueXIxeUtPdTV5?=
 =?utf-8?B?L1MyRXdEekxqOXdNS3RhUVgyY2psOUl6c1lBZ0R2MmJFSWRZbUFoN1RESkJP?=
 =?utf-8?B?TkM3d09YY2o3QjJvMlR6T2dCV2FPL1VQTTRXNVU3NE1CMWd0NVQwbUJINE92?=
 =?utf-8?B?aXByQTJFQTVUZlA3NzlWK25UZSthWklpdGRkRkZEL05NajBaUUo5M1d1SEFL?=
 =?utf-8?B?bkVuOGdwOWRNZTFtdXNuQko0SnlKd2pURlVaTElkdGlrdnlCY1l2T0JCV3VP?=
 =?utf-8?B?azh4SkMvbWJYZ2RHM3ZQZDE3TWVQZ3JqNXZHcklibjYvQTJOZVlUQWdEcDE3?=
 =?utf-8?B?YmxqdVA5UFZsMEpDNkZ4V2lEVHc3eGlXOEQwaTZtQTE5cFlGUjdHeUh5dnNO?=
 =?utf-8?B?M0FQZ3BaZU5SY3FqUWdNN3pUeWs1UlVlMUdoUzNJWHMrc21mNnoyeGdhRnVE?=
 =?utf-8?B?QnBMT09nRmgwcWNlVXRXRllpd3dkci9JWFBqU2NNR2hSVlJvZjBDS0lMUDZJ?=
 =?utf-8?B?VzdWckpvZHZWckc3cTJ3dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f00779e6-258e-46e8-99fc-08d8d434318b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:39:50.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4SalAuCd265Ey/kIz771uoI1+xI88jkyVO/KnbjXfHJ7eVNsdB7LonIVUD0Jn6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3569
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/18/21 5:41 AM, Ilya Leoshkevich wrote:
> On Wed, 2021-02-17 at 22:58 -0800, Yonghong Song wrote:
>> On 2/15/21 5:12 PM, Ilya Leoshkevich wrote:
>>> The logic follows that of BTF_KIND_INT most of the time.
>>> Sanitization
>>> replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
>>> kernels.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tools/lib/bpf/btf.c             | 44
>>> +++++++++++++++++++++++++++++++++
>>>    tools/lib/bpf/btf.h             |  8 ++++++
>>>    tools/lib/bpf/btf_dump.c        |  4 +++
>>>    tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++-
>>>    tools/lib/bpf/libbpf.map        |  5 ++++
>>>    tools/lib/bpf/libbpf_internal.h |  2 ++
>>>    6 files changed, 91 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index d9c10830d749..07a30e98c3de 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
> 
> [...]
> 
>>> @@ -2373,6 +2377,42 @@ int btf__add_datasec(struct btf *btf, const
>>> char *name, __u32 byte_sz)
>>>          return btf_commit_type(btf, sz);
>>>    }
>>>    
>>> +/*
>>> + * Append new BTF_KIND_FLOAT type with:
>>> + *   - *name* - non-empty, non-NULL type name;
>>> + *   - *sz* - size of the type, in bytes;
>>> + * Returns:
>>> + *   - >0, type ID of newly added BTF type;
>>> + *   - <0, on error.
>>> + */
>>> +int btf__add_float(struct btf *btf, const char *name, size_t
>>> byte_sz)
>>> +{
>>> +       struct btf_type *t;
>>> +       int sz, name_off;
>>> +
>>> +       /* non-empty name */
>>> +       if (!name || !name[0])
>>> +               return -EINVAL;
>>
>> Do we want to ensure byte_sz to be 2/4/8/16?
>> Currently, the int type supports 1/2/4/8/16.
>>
>> In LLVM, the following are supported float types:
>>
>>     case BuiltinType::Half:
>>     case BuiltinType::Float:
>>     case BuiltinType::LongDouble:
>>     case BuiltinType::Float16:
>>     case BuiltinType::BFloat16:
>>     case BuiltinType::Float128:
>>     case BuiltinType::Double:
> 
> There can be 80-bit floats on x86:
> 
> #include <stdio.h>
> int main() { printf("%zu\n", sizeof(long double)); }
> 
> prints 12 when compiled with -m32 (not 10 due to alignment I assume).

Wow, I do not know we have long double float size = 12 for m32.
In this case, maybe we can enforce float size of 2 and multiple of 4?
I still like some enforcement, arbitrary float size seems wrong to me.

> 
> I guess this now completely kills the idea with sanitizing FLOATs to
> equally-sized INTs...

My previous email suggests to use "const int" for sanitization.
In kernel, we did not enforce the "int" type size as long as it
is equal to or greater than the one represented by bits.

         if (BITS_ROUNDUP_BYTES(nr_bits) > t->size) {
                 btf_verifier_log_type(env, t, "nr_bits exceeds type_size");
                 return -EINVAL;
         }

But in libbpf, we do want to the int size to be power-of-2.

         /* byte_sz must be power of 2 */
         if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
                 return -EINVAL;

When people dump in-kernel sanitized btf and they may see
an int with size 12, which will be weird.

So maybe "const char_array" is the best choice here.

> 
> [...]
> 
