Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2E34F203
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhC3UQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 16:16:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhC3UPw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 16:15:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UKDZFN012648;
        Tue, 30 Mar 2021 13:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DKvzM+XoktyfaCSv0tXjcJzwa7HiTtNS4Fvw2Qn+c2c=;
 b=DZ90niOJwB0TzJeLpxUgD2pv8YRsdoDx934YtpzaSzSC9HfRIUrPWnqI+C+Q9Afba3xv
 A376ZBJ2Tp8PjHTL+M4MDVablfyIrzcqd7PzWXqigEE3OlZG+mEevBKSRjFV0abSDH33
 qBm9SJenKzaUtjJl2zBlhPsoSHUga4vs1jY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37mac1r5jt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 13:15:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 13:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME0SNRorZ827hYbH5C365Q4WquvP1JcWNjkfVPns421vmao8fsSNKfzKUaBCIG26vbO3fYJ1eLlyspIWiEYkGkyr4BibMiLXOgn8jI4/vqAR+Wnn5IVOjgEHKM9AlwiPIQNyB61ZyUqVUQWIejwJbEhy4zO8hLwiiUyPk47Ja/j3FXoTMSPlgZUWHLrsviR4KYhA0KQ12PFK2SjsO+paAP1IyXaGK+gxKAePMNOCTh3SsXUBXUpjo670G4T7w5hcJnauUQSb/dYauoKzRRcm12okD2Sv7yCyJ3CvxJWlBSt1NTkW8UZpWn9CSu3Whj3Aii62xV2DaD2H+jmzC1vL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKvzM+XoktyfaCSv0tXjcJzwa7HiTtNS4Fvw2Qn+c2c=;
 b=XmX7bX7V9vt5490xly0SU/92ICJzbpUo5rNztfyiYoRQuVR0ud6RbgBQS09MiWD60r7qoLeZsPMDt+gfhTP/3LtJmKXxCuKyVdkSSYeXzNcMkQC0fciVGL2loTabdoDDhT1Gbf0Ymez8stLs+AAwnJ/Rf6dkpWj4JpNI0+R59x2n7oQ4+9gDug4KzxDHjK51BKrPOiog3IydMlBi0eJRZy9gbyRwIG0rqu/VHqpz41WIeHcFdCo++Yc1KGmNXc3chQrg0P1U9kLH5gH/ikDpaaBAYymZan2+Mm5C6RO2ESCbZRzEAz0DyRTsc5bMsJ/q33eMKylPYEp/t8fvNG3Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2254.namprd15.prod.outlook.com (2603:10b6:805:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 20:15:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 20:15:44 +0000
Subject: Re: [PATCH dwarves v3 3/3] dwarf_loader: permit merging all dwarf
 cu's for clang lto built binary
To:     Bill Wendling <morbo@google.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
 <20210328201415.1428856-1-yhs@fb.com>
 <CAGG=3QUxQ+xfY9n8n+5QrTPAR4TDp=_TNfXtnKY32YZXH9WBaA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <26c68f0c-6be9-7af5-0182-44e5a59f243f@fb.com>
Date:   Tue, 30 Mar 2021 13:15:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAGG=3QUxQ+xfY9n8n+5QrTPAR4TDp=_TNfXtnKY32YZXH9WBaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ac88]
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:ac88) by MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 20:15:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3722b50e-9bc1-4a7d-3e61-08d8f3b89935
X-MS-TrafficTypeDiagnostic: SN6PR15MB2254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2254351A4F86C1537E99B3F4D37D9@SN6PR15MB2254.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB6j4Y+1YSPgCbxpn6JC0aCJmUL6b3Vg4xHqxmlpFxvh9r1b6lF7mqkx/IwNouVcT+RpsJ/tvjqgB2a/N2Ky8A/jldhYklk9HtQ6RkhMkm22r/qtmJeIjHUnTNGcvQLQWiNeatYoMFGzXs1e+iySF7sO10VBKUYD+qziGJNP5fp3R1hegM0Z5CP0vHW9Aq80I69SpaJRY6oIBrhWN5Y1fEJTtsZNRxh3wrG4CjcmiBm+ztGgCBtH9SnjSV3qiSOVaBS982B0AjHv1SsDMzWWCgSaIgNJxtftX8mMcZpFWwuA0uD7rEPYmt5yd+Ob+JrUvIEdJAuFREGxH0u/rij7ftHaJqe9+98G/MGuV4vgioyDwzu5OnDjvbIXOo0xHVUhTpsIhmsfebhbINPT8BklWv/yswa+8pDwMP2JRcz6yFslIT409FdPqUgpeEo6c/gREdlYEIx+t/reaDAImu7wgnoSTVdlngs2asmYJXqY73ccI9gT8+AgZIwjaUsxcu3s0gFl3f4gWm9nFCthUnuGbEmvBr6ShZ2UOMKVIA/eRYXdO9i6pEDvNP1sat4MvDhGuy7TmMHojYBLq34B0nTn6fSjkMT7L5A7yZTX949wYDVY0ZGB/RSAnuZZ++u8G64xQchE55lw84k2hBi0zS59bgcMhDiFxMIueMWnJq4V9hpCemjhu2H7sI0u5VjrtiA14Sg5MA12Z80wBIlmyQrAvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(83380400001)(478600001)(8936002)(66946007)(66476007)(66556008)(5660300002)(86362001)(38100700001)(31696002)(4326008)(8676002)(6916009)(2906002)(54906003)(36756003)(186003)(52116002)(16526019)(53546011)(31686004)(6486002)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QW83WEppbHNzV2pzU081VEZYWTJOMnNkMUdTai8xWkxveGNUa3BjRi9LUVpC?=
 =?utf-8?B?N2luMVBnRXowLzNjcVQ3ZGhkN3VZWTF5NlpSSGZxUjFuRkJ4WnZRVmJ5T2kv?=
 =?utf-8?B?TlB0Yy9QNXZvY1p3c1JYd2phR1JWeGxMRUx2dVV5Yk1hbmNodHFBdlZpQ0N5?=
 =?utf-8?B?RHpEVWhiYUdkWk5OQkx4ZjdoMVNZcnpFUmpQWUNLRUcwQ1RrWnJQWlNNTm9j?=
 =?utf-8?B?ZTBUbDlrZjE5NXp6RXZFVEdoemx1eS9teXVHNFN1VW5OWnROWE5RdEJCNll1?=
 =?utf-8?B?bXp6WDRGUEZneWZQVjc2VXdXOFVoc0I3eGw4NjFOTnBNcFo4V0RHajlXaUJQ?=
 =?utf-8?B?ZFNpZ2NUcVdXem9rNjhlOFF5MUVUTk1nckVySWlWRjMrdi81NUN5ek1PSXFm?=
 =?utf-8?B?NW5GRXc2ZTdHRjBPUkx0NFp2TEpyYmwvRjVhZFQrZkJJbEUxb2FnNnNZMjRL?=
 =?utf-8?B?OUVjRGxhSlEycjN5OHJzbFpoNW1wTkVVT0llSHJqTXcwM0o1blpOc0hZMGZn?=
 =?utf-8?B?Z3M5cnhtd1BKandzSTYwZGs2alNBWW5MN3NSdk0yVlZtYXJNUGNsVlVYa3A1?=
 =?utf-8?B?RWRUMG5pTXZncy9DMk5JbHNvck5FUmJlMHBteDZxYWYrZFpuSDZKeWNrY0hB?=
 =?utf-8?B?RVcvbDBHenRQKzV6ejY0UGFxV3Y2cTcyLytrTjM2VSthcElManNzUXMwOTNj?=
 =?utf-8?B?QWVyYmpMcEFjNUxsdms5ZzhNTTFRTnpwa3lERkd4dmVNd1RCVXpzTFBRS2gv?=
 =?utf-8?B?aFQxUHFTWWxQWFlHS3B0aDJMSStzQkdhajhPSUd5Y0t0WEtKUjBXUzRTV2V0?=
 =?utf-8?B?eDhyK2h5QjAyQUo5ODVaaG8vaHRJNWxMNXRFZ2puaGRJUEw1YWpMRDhnZTk4?=
 =?utf-8?B?dU55Nm96VjJzR2poQllNblFvYVMvUnpSUDBCbFB6UmRMdjJCOUdGRHdZQSsz?=
 =?utf-8?B?aExGQ3hVSjhYZzBRNmszUkZTRU42YWRRaFZZRmVVeURYZGw2b05JRHVHcGIx?=
 =?utf-8?B?OXhvVVdqZS9CUXBOejhvd2J5WlVPZHo1KzFNZ1RudkxPVUx0cExxNGJ4MGtB?=
 =?utf-8?B?OXJnR0c2U0NXam5aNDJyL2hWcTdYc01pTjBHNXoycGxML1FDeUpTYjlxLzhr?=
 =?utf-8?B?dCtWNUFtMm9acXNaQ21wK3RYMUJKeHdxNUtBWm5NeHRYZUJRdjBHZ1lSQVlG?=
 =?utf-8?B?RjIrM0N2RlVNd0RQUnZpeVhwVFh1MFBReE01eEIxUXg3TG9CdStmQ0JPMVQv?=
 =?utf-8?B?T3lwdFdaMVRodU5VZElOc2ZPVVlYaGNWaWNXeFp1TUpNd3oxMFk0eEVVZEoy?=
 =?utf-8?B?K3Fjd0ZKOHBMRXRGMnR1emswd0t4aW5WWU8wVWQ1YS9oUldudU5aNCtTUEpv?=
 =?utf-8?B?Q2ZSdDYwYUlDSFI0RzVsUEZhWkFlNFo5RXJJQ0FHZ1hkbjRaQU1CYW9nTitO?=
 =?utf-8?B?N0hHQ0ZnWHczME5mMTloN2RYanFoVHV4QVVkN1dJRU5nWHJCNEE2QndOcWU4?=
 =?utf-8?B?ektMbEkxeTVXcG0ybmFTemIxM1J3VUpocUJ1RHcxdUk3dExTRC9TSkc0VjJx?=
 =?utf-8?B?QjRBenRBRHdBS2c4SG9YMUd3Z29PVk1sWE5DKzVpRWNZTERCSEZHbUl3NjhN?=
 =?utf-8?B?ZTlFS1ZSODYrQWlmZkUyR3FEWkY4V28wNVpsRmJPeU80eU41aUhZYVBGbUtY?=
 =?utf-8?B?dForY3RZSTJTeUl4NlFTUy9lZ2VuRmdxYjdQQmE1L3c0UzBiUDlFcUZLemtT?=
 =?utf-8?B?RXdCUnBVWWtoWGwydjZiZHBvS1pOTTYvTGlJdVozQ2l1K1Jhck91QVVheitY?=
 =?utf-8?B?TGIrcFh3Y2h4UStoR2NMQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3722b50e-9bc1-4a7d-3e61-08d8f3b89935
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 20:15:44.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91QQvo5i0paimftdfOp5lP4EDBAxFTGiJeWFHGEf1z1NAzXnudR/pT1dFIPdyxf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2254
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EobdnQJ7sSzfC3p0PamFcM4trSpadZGD
X-Proofpoint-ORIG-GUID: EobdnQJ7sSzfC3p0PamFcM4trSpadZGD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_09:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 1:08 PM, Bill Wendling wrote:
> On Sun, Mar 28, 2021 at 1:14 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> For vmlinux built with clang thin-lto or lto, there exist
>> cross cu type references. For example, the below can happen:
>>    compile unit 1:
>>       tag 10:  type A
>>    compile unit 2:
>>       ...
>>         refer to type A (tag 10 in compile unit 1)
>> I only checked a few but have seen type A may be a simple type
>> like "unsigned char" or a complex type like an array of base types.
>>
>> To resolve this issue, the tag DW_AT_producer of the first
>> DW_TAG_compile_unit is checked. If the binary is built
>> with clang lto, all debuginfo dwarf cu's will be merged
>> into one pahole cu which will resolve the above
>> cross-cu tag reference issue. To test whether a binary
>> is built with clang lto or not, The "clang version"
>> and "-flto" will be checked against DW_AT_producer string
>> for the first 5 debuginfo cu's. The reason is that
>> a few linux files disabled lto for various reasons.
>>
>> Merging cu's will create a single cu with lots of types, tags
>> and functions. For example with clang thin-lto built vmlinux,
>> I saw 9M entries in types table, 5.2M in tags table. The
>> below are pahole wallclock time for different hashbits:
>> command line: time pahole -J vmlinux
>>        # of hashbits            wallclock time in seconds
>>            15                       460
>>            16                       255
>>            17                       131
>>            18                       97
>>            19                       75
>>            20                       69
>>            21                       64
>>            22                       62
>>            23                       58
>>            24                       64
>>
>> The problem is with hashtags__find(), esp. the loop
>>      uint32_t bucket = hashtags__fn(id);
>>      const struct hlist_head *head = hashtable + bucket;
>>      hlist_for_each_entry(tpos, pos, head, hash_node) {
>>              if (tpos->id == id)
>>                      return tpos;
>>      }
>>
>> Say we have 9M types and (1 << 15) buckets, that means each bucket
>> will have roughly 64 elements. So each lookup will traverse
>> the loop 32 iterations on average.
>>
>> If we have 1 << 21 buckets, then each buckets will have 4 elements,
>> and the average number of loop iterations for hashtags__find()
>> will be 2.
>>
>> Note that the number of hashbits 24 makes performance worse
>> than 23. The reason could be that 23 hashbits can cover 8M
>> buckets (close to 9M for the number of entries in types table).
>> Higher number of hash bits allocates more memory and becomes
>> less cache efficient compared to 23 hashbits.
>>
>> This patch picks # of hashbits 21 as the starting value
>> and will try to allocate memory based on that, if memory
>> allocation fails, we will go with less hashbits until
>> we reach hashbits 15 which is the default for
>> non merge-cu case.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index aa6372a..a51391e 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -51,6 +51,7 @@ struct strings *strings;
>>   #endif
>>
>>   static uint32_t hashtags__bits = 15;
>> +static uint32_t max_hashtags__bits = 21;
>>
>>   static uint32_t hashtags__fn(Dwarf_Off key)
>>   {
>> @@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>>          return 0;
>>   }
>>
>> +static bool cus__merging_cu(Dwarf *dw)
>> +{
>> +       uint8_t pointer_size, offset_size;
>> +       Dwarf_Off off = 0, noff;
>> +       size_t cuhl;
>> +       int cnt = 0;
>> +
>> +       /*
>> +        * Just checking the first cu is not enough.
>> +        * In linux, some C files may have LTO is disabled, e.g.,
>> +        *   e242db40be27  x86, vdso: disable LTO only for vDSO
>> +        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
>> +        * Fortunately, disabling LTO for a particular file in a LTO build
>> +        * is rather an exception. Iterating 5 cu's to check whether
>> +        * LTO is used or not should be enough.
>> +        */
>> +       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
>> +                           &offset_size) == 0) {
>> +               Dwarf_Die die_mem;
>> +               Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
>> +
>> +               if (cu_die == NULL)
>> +                       break;
>> +
>> +               if (++cnt > 5)
>> +                       break;
>> +
>> +               const char *producer = attr_string(cu_die, DW_AT_producer);
>> +               if (strstr(producer, "clang version") != NULL &&
>> +                   strstr(producer, "-flto") != NULL)
> 
> Instead of checking for flags, which can be a bit brittle, would it
> make more sense to scan the abbreviations to see if there are any
> "sec_offset" encodings used for type attributes to indicate that LTO
> was used?

Do you have additional info related to "sec_offset"? I scanned through 
my llvm-dwarfdump result and didn't find it.

> 
> Thank you for improving on my hacky patch! :-)
> 
> -bw
> 
>> +                       return true;
>> +
>> +               off = noff;
>> +       }
>> +
>> +       return false;
>> +}
>> +
[...]
