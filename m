Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395D31269E
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBGSQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 13:16:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229753AbhBGSQC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Feb 2021 13:16:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 117IEo7X012501;
        Sun, 7 Feb 2021 10:15:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wkVCiVJxiMQU8hP8Dpc/6qI1c3Xrf1uBa/0v9JTdhYA=;
 b=CAygbWTbYc0fdCXSWapAc/nCmvuMQckazMjML6P4TGI73aTj/1B2fKvD8xw0ZuMt02++
 2XnxGB6aWSn1Bhov5JOAVH++jQV2dmRhgltFHlAn96pjMzfWMwWR222zXxMyE9oNvBFD
 fBqXTU5E5Vlo1t9kEJcwDyIH6i32pZc4Q5U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36hqnt48tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Feb 2021 10:15:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 7 Feb 2021 10:15:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axumnId2dj31l6q+i7s/6u+mge3eRkFApCN1Wnd7VPjf2h38ns0R+oxq5MNiG8SuGeZnj/OTA/eGxzfNZJV3uL+0X1+ZM0CqLaTmE6/aaHf3t154X19JbkZJIL/hS6TJaz0afE9Gq7yV7Oez8hcEQUIsaImVf0RKzGMCxaKtQ7P0yRC4q4iYScgvUlKgv17yaDBveAYOhqxzwwzP3Lwh+N+TM+rtxMnXXVyT3+DkVaak/WpTo4HGFryN0GAClrTA7QWIjHaKdmYBAlshnT3FEswn8PjeBgT7Y9X5wT8LEQyPamlV55ZG8CoGPTJDAOGP4SJRlfPPPULsZcFBS0kJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVCiVJxiMQU8hP8Dpc/6qI1c3Xrf1uBa/0v9JTdhYA=;
 b=PEDMdZA5aMDuH0bnclhi969IAmPqvvAXi58xkYATs1sVa0Mp7uOkX1KAqK6d1fPiZh2oX4p5ic4QNoHDda68ZDbVydX0OlzdSGCpjgpO67+/+HuxhJML7SbMSZg/yYLqsljd3I93vVVC1C+VuKQS2XE2LG3C8lHSrvbElVnHSwswiF1rVlf6JUw4434wWSlvIhX5+jXim0mB8vhJVvf7EwgGgA2FOkhyd5P88gsFybiA3wICpTQv5CGYPMqwVPpnFfT3qsf/pih3lSe5DzKr/Fb7ixWQTZc0cpK2Pp9nJ3eK5oeRwkAONwAyDWvSUkb2CUCRIjmgVaVX2bc+NGiMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVCiVJxiMQU8hP8Dpc/6qI1c3Xrf1uBa/0v9JTdhYA=;
 b=b4s1cH3pXwMz0DmmkwAMbE8mslfctnXVlNi3yHkbb0qXix1RKEi4W735sR/Ksdpq/qyvIst8ZpDyhuOZIpkCpdSa0sSS5RgsEJPdMbzHCpY9L5SIHAL0mP8JMyQ09FIXxrrJqaXDcJy0BsXSgX8mjSN3zNozcDGQ3IiPydKvQ3o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3618.namprd15.prod.outlook.com (2603:10b6:a03:1b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 18:15:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 18:15:01 +0000
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base
 type
To:     Mark Wielaard <mark@klomp.org>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <andriin@fb.com>, <ndesaulniers@google.com>,
        <sedat.dilek@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
References: <20210207071726.3969978-1-yhs@fb.com>
 <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce5d17a6-e5ab-d7ff-5c4b-5208721b56c1@fb.com>
Date:   Sun, 7 Feb 2021 10:14:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6cc5]
X-ClientProxiedBy: MWHPR22CA0027.namprd22.prod.outlook.com
 (2603:10b6:300:69::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:6cc5) by MWHPR22CA0027.namprd22.prod.outlook.com (2603:10b6:300:69::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Sun, 7 Feb 2021 18:15:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7ba677-d66b-4e02-dd08-08d8cb9448f9
X-MS-TrafficTypeDiagnostic: BY5PR15MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3618BFDCDA2679FB36C0CC11D3B09@BY5PR15MB3618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JrLiry68iq1Dq8rYKPdbY5FfTTwuwO6uneDmMpAHtCWh7cC49f6nOB3RFdk2k4kcFUS4ilKQEVQ46yET3xqhYER0jP/q2a9JdopEeQV/EKyS0370c0Ef9A9/jwqxkWkRaaglVri94Y8TbGccEa+WJ1K4grfAOhOODC9mXhDEZRk80mLQHg0DShbqEEhxRACxyW/NsmtN6fbsgREs0xoSYGyL6wuynXwyEe2oDRfg2YDPHMZSA3X3PV9oXb1ZXXG+xks2yMt8oLr4LIrHbJ3f+YvYenWt9MR4gRJiLcBOCs1+tYZLeaxiROmN4n0yN6IlCV+VM6FANpLZ4zPcsVpPUJblGao7zuowDTAX7x0aEMsAkIcqKwB1Z6nxMkndrbU9uZsEy4pl/8sb4b5KN30CWjRy55uI2WM/oAhWMlMibn+5EufMOThyU4GXk/TWBwxHWAwFUKgbqNXxeGZsUoD1cAeCuEjyZ23PpwavDbbd5IvTesZFlIJxKppsq2Z5Ha23ZYvOF3xWIxjuka7jvd/kOXByNaJ77GKX/tFlMsjBdyzWb9cANXprzoaHmvo65Iy07lEYnIT6aC17u91hcLUUC1SU2sN1l3uSSDHyGnphCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(66946007)(66556008)(53546011)(66476007)(316002)(4326008)(52116002)(86362001)(8936002)(83380400001)(186003)(5660300002)(36756003)(2616005)(478600001)(6486002)(31686004)(2906002)(16526019)(31696002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGZQbEVqSU5LRDV3UXNOd3lxaVhSa0gyRG5sNFlqK2NkRVRFZzhxSlhsK2hC?=
 =?utf-8?B?UGVSV1ZCUTczMktCUTdxdThMbGFQbEsvUGlsd282NDJYaFhmcUIydGY3Q0wz?=
 =?utf-8?B?Z2x4Rkl6UWRTcTYzZFk0T3JBWWhOWVl3YU56TUpCNExyZ2dGY0Jza1k5RUpI?=
 =?utf-8?B?WC9YV2loTVIrZzNaR1lVVW0xYi9NVzl5TG8yMHFhaHZ4Vk4xZTRVeTMwNHJ6?=
 =?utf-8?B?Sk9JS1daY08xTzgyYUViZUZFYVZSL0g2S2g3TGwvR3RtMzFva3BSRlZBVjQw?=
 =?utf-8?B?OGxBVTJHbkhTQjRNRVNua2Z2blROVC9pdDN5Rjd3alAwYUVNd20vdzZLM3U5?=
 =?utf-8?B?YXVKeEE4ZDI0MTEzbzRJMDhseFBaZGJRV0pnS3dVcmdkNE1mSFVCdGozY2NJ?=
 =?utf-8?B?WHNZVkZhUTFhVDdGc1JFK0Vpb2RXVkp0SndXcHdmVGtnVVp5eEkxY2tCWEhk?=
 =?utf-8?B?TU80VnpEK245V3YrVDZlbWJLeTdpcE1OcjFDRGc0ZllRZFVjbzRDZ1JGTWFo?=
 =?utf-8?B?c2Z0SWlLR0R3ZDBkbVJyWFF6NDczVXkrZzBTTi81UVdHT3kvbEd6dER4Ynkw?=
 =?utf-8?B?WE9iaUQyZUdzQ2toeFVyR3lOTUMzcDNKSDZjbk9sbUF3M1U4ZjJHMVJlS1Iv?=
 =?utf-8?B?cmduZDloWCtWL0VQTlZXV2pCMjN2ckovWDh6TEpKdEpuYWR6WEpNdlFoMEo4?=
 =?utf-8?B?MXFHWGlGdFpNYkJ2ZzFGWUZ6Z3FuS0FqL3paOEVNWTB4THozdnpscDBsTVYz?=
 =?utf-8?B?ZCtraXUveFBrMTQ5L1lHYnlzZFpUc1hHOFpwdWwxNnRkL2JWYW8vYklHbG5j?=
 =?utf-8?B?Z2M4RUdSeU5JWEJsM1p0bHV3WCtNWW5DTjNuVWdhOFUrcFpDV0UxOGxYbHRl?=
 =?utf-8?B?SHlYMTZDY2lvTm5tMGd3K1EzVTUvSUZubUhEU0J6OC9ZaHVlMURnOUtMeXZW?=
 =?utf-8?B?cFJGZjdpV3YzL1I4VGF6SUlkRG84cUZSNXRwbGtEbU8rdHZHVS90bUswM3hr?=
 =?utf-8?B?bzdBMDZsWElwc1ptWWpBbnZKd3E0a2F4VU9jVFhCMEI3cmdCdzVxYmI0TzNZ?=
 =?utf-8?B?YmZCL1h5dGdJUFQvTmFBcHJkMGFLUFpLeTNLSkF5WTBkZFR6MEpkODlyc3pP?=
 =?utf-8?B?UC9Ud0JPYjQ5YWNva2R1M2RGSnBLbTU0RldiYlV2SURaQUpmNzhwTWMzWm44?=
 =?utf-8?B?VitqNFkxSks4azVtcW0wSlZUclV0VXErdUdGMU1QY0JPUzZoSHpWaHk3T2hm?=
 =?utf-8?B?d25EYkVnenNHdFVLQjVsdzVIQmhMSEhmZWttb1ZrZUlyNUllRVA2ckxvYm5z?=
 =?utf-8?B?YTNiQWpPUk9zcUp4M0N2UXVwKzh4TytQYmVyeTZxUEllM2x5bW14Q0ozTmVL?=
 =?utf-8?B?VGtwc2EvQlMrYUtWemlsZTcrT2Irb3BJYStPcVRnQlJUR0ZBTEVsdFh2M01D?=
 =?utf-8?B?azgwWWYvQnEvODRFY010azE4dnlyS1RkZ1k2QUY5bEduamFZRW5UQTl3Wm5Y?=
 =?utf-8?B?cldQd1MwY0pxdHExSlBMVHFqZ0lFOU1EbHQxWmJwRjg0bURvVTdVbURoZUlW?=
 =?utf-8?B?TEdWUUJnY2duMGpvSndGVjk0c3pkdkk5VU8zbjBvN1RjdDAwZVBycm00M2Jt?=
 =?utf-8?B?UHU0MlpvRk5sUWIxYUIwZ3pjQjF6b2NCaS9qZVNOYmpPVkt5QkYrRCtiRWhG?=
 =?utf-8?B?QkFMMkR2TnRNYW1KdFdrNitrMnRkRXRBMDlORHRndkJzVEhSRlgxN254bVFm?=
 =?utf-8?B?cnBXSTBLaXd4dkR5SDNNRC9GT3NMUEZKdERLdE5vV0J6UGVwazFFN2NkWElX?=
 =?utf-8?Q?fgJOMGhjSnMfU2Cy4k9tMW7yz54R0r2uqwq08=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7ba677-d66b-4e02-dd08-08d8cb9448f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 18:15:01.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjQT47Al36zsEOqkE4TNPHYL/SH/R/bdWhzCjM0GNkaaselLNV3H7OLW9klBDPSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_08:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102070132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/7/21 6:18 AM, Mark Wielaard wrote:
> Hi,
> 
> On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
>> clang with dwarf5 may generate non-regular int base type,
>> i.e., not a signed/unsigned char/short/int/longlong/__int128.
>> Such base types are often used to describe
>> how an actual parameter or variable is generated. For example,
>>
>> 0x000015cf:   DW_TAG_base_type
>>                  DW_AT_name      ("DW_ATE_unsigned_1")
>>                  DW_AT_encoding  (DW_ATE_unsigned)
>>                  DW_AT_byte_size (0x00)
>>
>> 0x00010ed9:         DW_TAG_formal_parameter
>>                        DW_AT_location    (DW_OP_lit0,
>>                                           DW_OP_not,
>>                                           DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
>>                                           DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
>>                                           DW_OP_stack_value)
>>                        DW_AT_abstract_origin     (0x00013984 "branch")
>>
>> What it does is with a literal "0", did a "not" operation, and the converted to
>> one-bit unsigned int and then 8-bit unsigned int.
> 
> Thanks for tracking this down. Do you have any idea why the clang
> compiler emits this? You might be right that it is intended to do what

No, I don't know.

> you describe it does (but then it would simply encode an unsigned
> constant 1 char in a very inefficient way). But as implemented it
> doesn't seem to make any sense. What would DW_OP_convert of an zero
> sized base type even mean (if it is intended as a 1 bit sized typed,
> then why is there no DW_AT_bit_size)?

We need to report back to llvm community about this instance.
DW_AT_byte_size = 0 only for DW_ATE_unsigned_1 does not sound right.
DW_AT_bit_size might be needed as you suggested.

> 
> So I do think your patch makes sense. clang clearly is emitting
> something bogus. And so some fixup is needed. But maybe we should at
> least give a warning about it, otherwise it might never get fixed.

In pahole, to deal with dwarf weirdness, we have several other places
for workaround without warning. I think it is okay not to have
warning here as users cannot do anything about it. Also we have
this special int type with name __SANITIZED_FAKE_INT__ which will
signal the issue still exists if looking at BTF or generated vmlinux.h.

> 
> BTW. If these bogus base types are only emitted as part of a location
> expression and not as part of an actual function or variable type
> description, then why are we even trying to encode it as a BTF type? It

Let us still encode it as a BTF type as an evidence that we do
changed some types. After deduplication, we will only have ONE 
__SANITIZED_FAKE_INT__ type. I think leave this one type in BTF is okay.

> might be cheaper to just skip/drop it. But maybe the code setup makes
> it hard to know whether or not such a (bogus) type is actually
> referenced from a function or variable description?

I guess it is possible that we do a preprocessing to check whether
any types BTF intends to emit (var/func definition, etc.) referencing
such types or not. This will involves overhead for every CU most of 
which does not have this issue. And this should not really happen given 
a sane dwarf.

With __SANITIZED_FAKE_INT__ as the type name, if something e.g., a 
variable definition use this type, you will have
    __SANITIZED_FAKE_INT__ a;
in skeleton, or have
    struct {
       __SANITIZED_FAKE_INT__ member;
       ...
    };
in vmlinux.h,
we should be able to catch such an error easily.

> 
> Cheers,
> 
> Mark
> 
