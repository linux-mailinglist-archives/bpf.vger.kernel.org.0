Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AF40B3CC
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhINPzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 11:55:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65458 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhINPzN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 11:55:13 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E9Ojf8011688;
        Tue, 14 Sep 2021 08:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eeB72aotTfu5dMwIyBMzAVDT2d91r/HQ/6M4o/aJD4g=;
 b=JWLCt3sAV2P+FlqSmL0qAYlfi1De/BKSKPJkf9UT5BW9Bu7PYgjEMKoMCtstlMz2oD8/
 yqJiKuor2rOqUIb8DMHKWJ/Tbyx5NGR++4G3CgGpBLcRJHhQBnnfAhdrmud7NBivQfdo
 Edkyu+NrmOJLC/f/J5e/+IdOw63RIa0GL7c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2s3325ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 08:53:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 08:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJEAuVNLP/gMYm/Oa/XuRPM33pNGShEFbtPhhpjW6N0ulE2bkzJCxKk76bVuDRIKs6R3dPas4V5xp9ZDjIIZ8PXeM7WANMMlesnkt7aghclH0jp8Umu1KbY9rKdXSFAInaKQxPzNwIIgJjbdxKsvQr+2Up2VaHi+BBm0CUpNg5KUUpsY64ZzULUTPAkZ4FjkiMWWWFVtYX8aUMgmHh/cKJcuxCJ2BRQvpig03GXbauPE0YC56tfmMDmJBzT2QMc/sy4GoQTyuEnkp1XpH2HFejx7IQN2J3DjEMK+BPBHJ6ToQeC8j27iiKZn84ZY9YO5gZkrhXt+3X50y9A/Tj4BaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eeB72aotTfu5dMwIyBMzAVDT2d91r/HQ/6M4o/aJD4g=;
 b=Lz+mQG0ZZZEJe3VbR7/NvKA0v1hABFdd0tpSGlxttXXdB+MeJwl4GEuRvSFiSc//Fre3OYVEKoYpO1fwq+4fhneQ31sm3tTPsbEQGezdt6TLx2JWjJjjeLEnnsjtAf31ZAT19z+yIcwm1ZIrummWvkYdjaL8GIRRvjNjrtQXmt/aS451fKzcx2D+7pQEtiMC2mENThZbXjqUQxyAZrzReteCOLUK/Op9zS+Hc74SyhGqtlPU7+pNrxWQL+/nsfJsYluRWTZlSnqukVxx3WkKr6x5YJkzvvzRHBtlJgpwpzCQRAVlrfYeUNIJXwMUT5kZG1l9OZrtZRh2ddo9r9vswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 15:53:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 15:53:40 +0000
Subject: Re: [PATCH bpf-next v2 01/11] btf: change BTF_KIND_* macros to enums
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155127.3723489-1-yhs@fb.com>
 <CAEf4BzbZuKF6eN0BSsr_3c-g7ZbVzP6P__3Y9f35ef-zjWS20A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <624f17e3-2194-6f05-54fe-141d796fddde@fb.com>
Date:   Tue, 14 Sep 2021 08:53:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzbZuKF6eN0BSsr_3c-g7ZbVzP6P__3Y9f35ef-zjWS20A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Tue, 14 Sep 2021 15:53:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b53b9d4-6e8d-4491-941c-08d97797d27f
X-MS-TrafficTypeDiagnostic: SA0PR15MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB396799EF1C7D90AA9AC029BDD3DA9@SA0PR15MB3967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDyxIOi95gLSkPJEZ7l7hrwnqfBIJqftZKT+J2VB9ULZQjJ7QjTp3FrD1Z/i1H3l6hmZ4czEPOEind8nnTK/vcK+uuU9NRucxfWT/joJIK3OX34EqKA8CEV881Y93dXvm2w/mCqGsAa/fW58L88eDKNWfSHUTIRD4JyakCBiOf1uB+2Nf/6uhcX2tS7Ko4NnzW1Nd8PGkbZeuv6VKDE8a7p3zXR1Zf/5ZaWLm7vZHPcfpqpGQiyrettspDd/KXBIZfcIGzVPR5lZjz+iJ5svzryvTnhGExIjmYtBtGWXmTlEkD0quBvElrQ25mNDQ7ozaqCpTTQEdBcm6ZEQSyVmmfV2w+u0YsBuHbYi+5H3H220H37tqdlw2AdCdZLbNHMM1nNVl9fxqUkLWX6COEcsbUjNMLgluYoOLNp7pLxS78ffGKTVwBIQ6O27QhTjSycu7DsRTdffJ8H4tCT4/FtZAdvSRLUkLP5vPd4zeFbW0Lg5qvV1MZfRe7uE3o92YEXI4v3d59tMztzOmazdJRfUFEdWiPmQaBXLgLF2qM3w81qVZfO6R12HllB0lAxWAJfX/3Co1490/O33G3tZs65fW5ZBvnCP7noaojjdW/x8s5+JwimJ4f+0NIK6LYiI355FQhNl0FFnSXEYpwggBfFlo5DPLeBwMpqzpKonUTWORfl7sg3Ng7HDsRxtbT+FEVQ9pFjlHrYa/nGwz30Gzi59pNB4olb8krABFPd8YIiwUz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(8676002)(2616005)(83380400001)(53546011)(4326008)(54906003)(52116002)(66476007)(66556008)(6486002)(66946007)(5660300002)(86362001)(6916009)(31696002)(8936002)(478600001)(36756003)(316002)(2906002)(31686004)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhuam1ybDBUN2pMWkNhVFpFUGFhQ05mRkg2ajZVWkFqem9pdy9kYTNxa1dE?=
 =?utf-8?B?anJ0YnNiQ1N5NEVFYWhvbmVBazdwTnlMU3hmd2FOZ1k0V3pqMTNRTk05MWtz?=
 =?utf-8?B?RVZud0xvWktTTXFFUWRDa2dwSVh6KzJ5dHBUK1lWaFBLMXYwakRTRUpwdmYw?=
 =?utf-8?B?WnZERTl4U0FTRTBmMGFLVW81QnRSdWZrUVBPaVZkSzhJWGY1bUQwU3d1enZt?=
 =?utf-8?B?U09sZzdaTGY2VUJ3MFB3SDR1c1A4d2VVeTFqOFhnTnl0QjN5dk1DcUYrVzlK?=
 =?utf-8?B?RFZIWjlJN2V0YlNRUFJOMXBLN3dwL2pVNjlVa1FLNVVpRVAwOS9qUWtocHJS?=
 =?utf-8?B?Q2ZQU1dQeDhMWHBBYWhnMjlmcEJnblJXOVlmN0ZBSkt6R0RnUTFOQUZNalJr?=
 =?utf-8?B?dUVPbzNEdGZyZEZ6VEthbWREd0dNMkZYWHVlcnEwQ3ovQm5uN0RCNHFmOVl6?=
 =?utf-8?B?WVFRRk9GQXNiUDNyWll0Nk5kWWV6M1BvMVpoMFpkTDI4MzlmWWNIWDZtck1a?=
 =?utf-8?B?T1g1ZEFCbzU0ZVZyc2NRY3l4ZVZjMWJpcGxJWmdDWkpmYzcyVGNyMUQ1a21u?=
 =?utf-8?B?OWxxSjVRNVByM21wR2lxTTQvUVQ0SHhCUDlFQ213RHhCL2dRdTFrb1RnckVw?=
 =?utf-8?B?WUExTlovYk1zaFNmU2FGdUNITjRpR1RMNGRLSnplVHBxL0dvSFdiSW1WTHUx?=
 =?utf-8?B?NnozKzEzQk52T3FUdTY5ck12eTlSWWZSQXJZRGZhT3hhdGc1Vy8yenExajFz?=
 =?utf-8?B?RHZsV25YNCtOWEljWk80WUorSjh4WGdwZnBxTVJySk5TdWk5VWJ5WllTWWR0?=
 =?utf-8?B?NFk2aXNHWHJ3MEVueDVMZkVlODJNdlN1WjJLY1M0R3VlUHFQWi9oZFRHYjFp?=
 =?utf-8?B?STFKUjh5SkdZQXhrSmUvVUVRNGZMRUZSNjI0cDBlTFFEbUpXcnJKUk1LRms2?=
 =?utf-8?B?U3FiZXh4Qjh6U3BzSDgxL2lsd1RQRFBCcGM5NzZYM3NDWW9IOURQU25zK25B?=
 =?utf-8?B?MUY2ZDgyWE41M2dlN2NZT084SENXSzFBZ25QeTkvYkIrM3pxd2ltTXk3OWRi?=
 =?utf-8?B?RUJkZVJ6SGo3ZndadnZaaVBaYnBtVVdiYmVnbnFhNHdzT09Ec0xnUHc5Wjcr?=
 =?utf-8?B?bG9JekNIa3Q0b1ltUGk4QU1uVUQyUkZ5WEdLYzFtTUY1UzU0cEVtVWowakpE?=
 =?utf-8?B?cUZRc2hSQmo2ek96cHFGbjJzNUhQei9pNTgrb2FOcTJEcDI5NUZ0Uk42U3FS?=
 =?utf-8?B?eHR5RUVML1B6TjNaRUFYSE1VaE0xMitDelU2b1I3VFQ4Y1diWkVwN0ZnSVFw?=
 =?utf-8?B?cUhZM0dhdmI4aUdTbWxBRWUvVGxqVE9JaHhrdXhJYWdTRzZWUThad0Z0Y0Ry?=
 =?utf-8?B?WkltbDJ0SllCN0VsUVFidkttck9YWkY0NmlZOFhEWElmOSswSUliamxidTM4?=
 =?utf-8?B?eHZnMFNJZS9uSmg1UVZadTViYWZZSHM0SGhDdEl5Si8xcld6c2c0N1JNRU9J?=
 =?utf-8?B?SWplRkx1dktUbGltaW1XNWd4bXhTK0Zvcjk0VFIxWXJHM1VvMTZkd2tPeklu?=
 =?utf-8?B?R2Z0QWtUbks3QkEwSDFXeE5pbFdmT01FOGZlODBnbEZ2MWVUYmV0WkhTTnhI?=
 =?utf-8?B?OXByOVZGSlkyK1lhUmxNQlNoZmU0elVPbFZsL05QSVA5UzM4d0gwdC9JSC9K?=
 =?utf-8?B?cUR4WjJRTUtGTTVva1JlTDBUUHJmZFFLUjJTRGNBUlNZTnF6Tkg5L05iRVVV?=
 =?utf-8?B?SzQwSGp2ZG9PV1BZVXVEV0orR0o5aW9nSEdMQmwrMWdnUlpJNmUzaXBsTWxr?=
 =?utf-8?B?SUZHV0JzTGl1aXNiOEp5Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53b9d4-6e8d-4491-941c-08d97797d27f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:53:40.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhXDwJKE4rUBhAHy6h7/YKDmoLSlSmiBHNDawrzjzAvI3HaUEr0l0oIxN0XnIQbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GWVicOWvc5RyE755cxsutDoATj56s_KA
X-Proofpoint-ORIG-GUID: GWVicOWvc5RyE755cxsutDoATj56s_KA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_06,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 9:59 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Change BTF_KIND_* macros to enums so they are encoded in dwarf and
>> appear in vmlinux.h. This will make it easier for bpf programs
>> to use these constants without macro definitions.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/uapi/linux/btf.h       | 36 ++++++++++++++++++----------------
>>   tools/include/uapi/linux/btf.h | 36 ++++++++++++++++++----------------
>>   2 files changed, 38 insertions(+), 34 deletions(-)
>>
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index d27b1708efe9..c32cd6697d63 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -56,23 +56,25 @@ struct btf_type {
>>   #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
>>   #define BTF_INFO_KFLAG(info)   ((info) >> 31)
>>
>> -#define BTF_KIND_UNKN          0       /* Unknown      */
>> -#define BTF_KIND_INT           1       /* Integer      */
>> -#define BTF_KIND_PTR           2       /* Pointer      */
>> -#define BTF_KIND_ARRAY         3       /* Array        */
>> -#define BTF_KIND_STRUCT                4       /* Struct       */
>> -#define BTF_KIND_UNION         5       /* Union        */
>> -#define BTF_KIND_ENUM          6       /* Enumeration  */
>> -#define BTF_KIND_FWD           7       /* Forward      */
>> -#define BTF_KIND_TYPEDEF       8       /* Typedef      */
>> -#define BTF_KIND_VOLATILE      9       /* Volatile     */
>> -#define BTF_KIND_CONST         10      /* Const        */
>> -#define BTF_KIND_RESTRICT      11      /* Restrict     */
>> -#define BTF_KIND_FUNC          12      /* Function     */
>> -#define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
>> -#define BTF_KIND_VAR           14      /* Variable     */
>> -#define BTF_KIND_DATASEC       15      /* Section      */
>> -#define BTF_KIND_FLOAT         16      /* Floating point       */
>> +enum {
>> +       BTF_KIND_UNKN = 0,      /* Unknown      */
>> +       BTF_KIND_INT,           /* Integer      */
>> +       BTF_KIND_PTR,           /* Pointer      */
>> +       BTF_KIND_ARRAY,         /* Array        */
>> +       BTF_KIND_STRUCT,        /* Struct       */
>> +       BTF_KIND_UNION,         /* Union        */
>> +       BTF_KIND_ENUM,          /* Enumeration  */
>> +       BTF_KIND_FWD,           /* Forward      */
>> +       BTF_KIND_TYPEDEF,       /* Typedef      */
>> +       BTF_KIND_VOLATILE,      /* Volatile     */
>> +       BTF_KIND_CONST,         /* Const        */
>> +       BTF_KIND_RESTRICT,      /* Restrict     */
>> +       BTF_KIND_FUNC,          /* Function     */
>> +       BTF_KIND_FUNC_PROTO,    /* Function Proto       */
>> +       BTF_KIND_VAR,           /* Variable     */
>> +       BTF_KIND_DATASEC,       /* Section      */
>> +       BTF_KIND_FLOAT,         /* Floating point       */
> 
> Can you please leave explicit integer values specified? It's extremely
> helpful and much easier in practice, compared to having to count the
> number of rows from BTF_KIND_UNKN. Had to do it multiple times with
> other BPF constants and was happy I didn't have to do that for
> BTF_KIND enums.

Sure. Will do.

> 
>> +};
>>   #define BTF_KIND_MAX           BTF_KIND_FLOAT
>>   #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> 
> these two can be just an enum values as well, and actually will be
> "auto-updated", if done this way (I think, haven't really tested)
> 
> BTF_KIND_FLOAT = 16,
> NR_BTF_KINDS,
> BTF_KIND_MAX = NR_BTF_KINDS - 1,

This should work. Previously, I tried to give a name to
the enum. If that is case, e.g., put NR_BTF_KINDS and
BTF_KIND_MAX inside the enum will not be a good idea
since then you have some case not a real type or
you have duplicated case number (e.g, BTF_KIND_FLOAT 16
and default (which covers BTF_KIND_MAX) also contains 16)
and compiler may warn.

But eventually I did not put an enum name here since
a common name like btf_kind may have been used by
application.

So will make the change as we don't name the enum.

> 
> ... won't it?
> 
> [...]
> 
