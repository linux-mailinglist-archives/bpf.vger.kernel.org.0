Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0E406E8A
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhIJP5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 11:57:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58024 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232438AbhIJP5O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 11:57:14 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AFnqvp008483;
        Fri, 10 Sep 2021 08:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BhobYlUsezABHo9UCKoYNXYDBFNREUPlEJy8goLl8Y0=;
 b=kikEcyCU9LM6fWeI9O5GCmlB2R4EjHYBtxhk2EAFcY+aOy2S6aB4EVS/FhlTemHYWk4l
 yYdZ8ab8XnQNTzF7eO/lMjDpSVb3GeHFRi+0PRYcDoRUKVCACRjX/se5xaPTnlE5aBqd
 73kNjxJ6sAdjHu6CoEQuZmlIjlT67tetnsQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgcq08s-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 08:55:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 08:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OITUl5ET06yvgLrSPdKASuXz6irezyXj2dOLoiJt04e8cCr9IHaDUvIl7b/vu9leR8QB7cDYAYLWoSGbXEg7tOtdYsssc68eD4/XggspDPrEwSzHrCQZMTBmNSmmgssXxla78N9fvwQ0RdBiEZyuVvzOzfSyWoYWiJqnov3kiSo3VW+a2eseR1pbYIsbGOP7Isc6iws59dyzcRuWPp3U/A2cYjvVmCc62PleIwSXzr7N3DsOzNtQe236UIIcifonQJgrdXCajg8hIVNtM0k/ZTlNgPTmvPccCPfjq8YQX7e2fvrI88h67EtzesW0x5+eFiPFZwJZ/Vv3IfpCtCU2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IAaCiFCZGiMbjmXbkFeRH3r42Z5ufNUadCrpgWsSUsg=;
 b=BBfRQ6f3sTTf7iMnl40jI0KqM9Wm4F7eUpXBmj5h6AhOsi8L/jtHPk7FGl/yG/7EeOjtzhzoSgITpoy8pJNrNDay8h6YpJvto1AG1SEjqDFaMywDZ6/Fax24pcTQzdZ7/MBoFJbankn9yrRKp69DUizBKaeB6AI9JoRbsck6dGCcdovHgKhqXIbbDftySCyKmzS2IpNfANF/ty5Un3yG5rnpM8e14T9FFfnmAjmtzPOOp8FC/9XgJuWMbEwK8DGWip4b8OSDJ1tGKc/e9c3i22UwR+cHUU3oMyjb0L2SlP9CxLj09KvDOoH9conz2sfIb568mHJedf4tTNELs+WRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1967.namprd15.prod.outlook.com (2603:10b6:805:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 15:55:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 15:55:46 +0000
Subject: Re: [PATCH bpf-next 1/9] bpf: support for new btf kind BTF_KIND_TAG
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
 <20210907230055.1957809-1-yhs@fb.com>
 <CAEf4BzYUhFZf_Kt+uQ1k4N1k_H3uJd2A9-FqSF9HbcfvLYUO4Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9f58f7d3-e517-81ad-2bc8-07efa8689f32@fb.com>
Date:   Fri, 10 Sep 2021 08:55:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAEf4BzYUhFZf_Kt+uQ1k4N1k_H3uJd2A9-FqSF9HbcfvLYUO4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 15:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3d96b8-dccb-4683-85b2-08d97473738c
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19679EF63E875FBBB97B4894D3D69@SN6PR1501MB1967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VaHA/vP+q6TIS3pl74OpmI9252fpWWXGdd+6s+HciMCPm6WUL+hVK82E/ZzC/K49AkbiNySMxZEXRQJbbAI4DZ1vTprCeal4ZtOGGFiXS6fSjUCwF+hHekk8cmLKA5UEBZsuAh+bE57jPp2PDpFnXuHbyKIoeJMCsvw3c0s+IytjLbKnPwpiSv4xpshlT6twupTTro7k7doIlEqSYN2OFWEbZX9itQTMKM91yRMgYFtKCH8tw7eawVAs+/vKJR9xBZW5MftJr1gfE9ME5sxclXjwoFqUrkgHwFFsYXGexXy6Z0J0yTTbuo/VwWDZPyyHeHio/PP9cnuJ3mEbPAOKcyGFd7AS0t01HICl9V4IVHAHBG+/nAEELrQD3Ic0A+Ixa5fRUMzieeUmDsZhnL+O+69MkcQXFl7zYlORbX4m3p+80tdKi5u1gt6TYgIifbRbR77/aD9cS1S3fBFdZbrmxJ1gMaMG99gQeogE7PWT4P1jUJRzbSrKXrTB+Khb0a1pu+VUrfLAgSogcfknsfW/YMHymozXy+i6LghtoGeQe87xJ/9hRBc9nBeiABPgXNbDYCAbhomdqz1bDQShmip0TnpcUj8SP8NQxA1UWYjuduf3NrKScBgi0jwQS1V6qFNmLukRPK8e6lyVaTDHRoV/9QNu1Eo7LwIr6IOfypSeuhjRKewecx4JiWsOrqQ6FPk4pbCZKE49FDJQowxCNUklcTPd6RjCOna8FDWNHBXGyFtoAe9Sg8ZnFt/mx9DQVSK73RN/03vUiLha66sYkvclEohYY49dWgVMb2u/k2QhwrpkN5gmq98qrluJg7jCrdUer53kDlXJqePNWXIhTNSoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(83380400001)(86362001)(66556008)(5660300002)(966005)(54906003)(36756003)(66476007)(478600001)(6486002)(2616005)(316002)(38100700002)(2906002)(6916009)(31686004)(8936002)(186003)(31696002)(8676002)(53546011)(52116002)(66946007)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlE0c1BHZWE4WlhDbG5aeW1wTStyeHliQ1lxYUNSODg0TUh6T0g0eUN5VHVB?=
 =?utf-8?B?L3hpSFRtN1pxc2M3djk1Mjh6ZU0rc0FIejdSV0FpOHVJclNhVUtoOElsZnBN?=
 =?utf-8?B?V0FiMVR2QWpuMlcyZVFBbGtnaVpqU2RQeVJwa2JZMjZsUi9TbklCNUE3anFm?=
 =?utf-8?B?WGE4OXFURmhDRktGcTFtSjZ6akcrYmV3QUFFeklibGtsUytRbm9FU2kxZnJX?=
 =?utf-8?B?cC81SUh5SCs1WkFlOU1IQ1l3d25PU25YZlFLT3RXV1VVZnJLZkhWZ1R4bExl?=
 =?utf-8?B?UXFuVEhOL0ZCMURpQ1pJWVZ1MFpFVnQrVmVFRmJrTUd1M2JVRjRlaEg5VlNL?=
 =?utf-8?B?SFlaWXk5VnJyM0pzUG9nM3FBMkx4ZEdKWkhHSTB2dm1NZnUzdkFEbWVnZEph?=
 =?utf-8?B?eW05V2J2Szl6NjZUdVNlRlhDMHlWMVcvRFBhQlhHb2V1VDROL3hUYWJmMjRH?=
 =?utf-8?B?OERMSnFCbS9McUdrdTFlQWpKTlN4cVFxL281UmN6cDdqNUM3Z2dQejdqRUZy?=
 =?utf-8?B?V1ZKUlVMVGVQbU9KaHlxWVBVM1FHV2hka3NHUXNNUmQ2YWNhZ3BPbzNrNG5K?=
 =?utf-8?B?TFZybDZGQlRIQTI4RmY4aXBRYlo4V3hjbUNKRUxYVUZHT3ZxOHByNGpJMm01?=
 =?utf-8?B?c2xMdXBTMVZTU0NSQ0o0TG9wRmdxcnA0eDNQUHFnbnc3SGpHYytubmVZN1gy?=
 =?utf-8?B?clFvSy90bGVJSVFSU2xxZFBUN2MxaDlWM1YxVVFWRWNObkFmUmNiWFgybThZ?=
 =?utf-8?B?YzFQUld3SVFlbGhXRXFqRTNlZ3JzalBNcEdTZmlVVExOUjNSOGN1bEJBNFli?=
 =?utf-8?B?dSt3U2ljbm5odzdTbUxPSEZWYVp2SzIzSzViVmpSWEJHVk8xSG56ckxWb2dQ?=
 =?utf-8?B?Tmpzc1B6RkF5V3FtcTVMRThEVkRPRndKQVd4QmlkWFRpOXVHV3B5bStlZVlG?=
 =?utf-8?B?bENXUThCRjNlN00xWkdYYm9QRHdSSVNoSVpSZzdwSkhSK0s2Y1NVajg2Ym05?=
 =?utf-8?B?ZVJ1ZmxKdjZuK0hEU2IxQ2F2dnF2RTlwNFlGdnZRNFlTY1BOdElGZU9URXB2?=
 =?utf-8?B?a3NIRlZyLy82eVFONklZeDVnaG10NW1LeGNvVUcxSW1sYXlKM3VhRElWYnNK?=
 =?utf-8?B?V2NpRWVmQTZ3OW5ydG42Ulg1cXpCTWtnUkZiTWY4ako2Vnp4K05mbGVISDJO?=
 =?utf-8?B?N1NWRjY2eVBlZy9qcVdWNVB1K0NHMEczNzdsNGdPSjVuV1lWV2hyd2twbzFh?=
 =?utf-8?B?dFdZSlNpSnB2OXRERllWQndWNktNV2xvZUVaUW5KK0Y3RGd3djJQREFIckpX?=
 =?utf-8?B?ZG1ITFpnUWt1QWZqdDJPN1k3ZkUyR0krZUdKZlJIOUY1bVFhYS9Fb3N5aEE5?=
 =?utf-8?B?emJyMGU2YlFEaDJ4c0lzMmZRZjBLdXBrSUJrZTJid1d6OUQ5SVplRzU5SVgz?=
 =?utf-8?B?aUZUcDVwK2NDNS9nNm54TXBUZjVJWmZHVmQ1ZmR5dWNqb2dwOGxCN3FDOTVY?=
 =?utf-8?B?eGtyZ0FNWklEV0V2VzhEeXdYTUlLT0VFd0Z6eExaQ2RrNU94YitTMVY4c1lt?=
 =?utf-8?B?cTV5YmdXaE02TTR1ekpRdFdWd3lTNWxsL291bWNFN0cyM1E3RG5zRVY3OHgr?=
 =?utf-8?B?RlZFY1p4VUtIcnhvdS9KQndkMXh4SE1kcDJsNXRENllrSVRvTVBwYXlRczZw?=
 =?utf-8?B?WmNrUFNJUlZUWHM5N0FmdTVOSkcrVlIyZThoU2FTR0VBR1dmQ2FVblU4MUxq?=
 =?utf-8?B?RWwyamNMNjJwT2F1REJHT0FqZWJITXV2SmxacXo0cTlHdC91dGU5YXVtVHk5?=
 =?utf-8?B?V1h1c29lcG85WWVDeHVaZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3d96b8-dccb-4683-85b2-08d97473738c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 15:55:46.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILY/h5dWcH1P+gBQt9oGrBYdhuI+b5uw4RywtyhJVWjkrjB3yKhRzX1TuftdYYmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1967
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JQAK_cEkZKSUAE-uW1VdSF_uZGcRvDSq
X-Proofpoint-ORIG-GUID: JQAK_cEkZKSUAE-uW1VdSF_uZGcRvDSq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_06:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 10:09 PM, Andrii Nakryiko wrote:
> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM14 added support for a new C attribute ([1])
>>    __attribute__((btf_tag("arbitrary_str")))
>> This attribute will be emitted to dwarf ([2]) and pahole
>> will convert it to BTF. Or for bpf target, this
>> attribute will be emitted to BTF directly ([3]).
>> The attribute is intended to provide additional
>> information for
>>    - struct/union type or struct/union member
>>    - static/global variables
>>    - static/global function or function parameter.
>>
>> For linux kernel, the btf_tag can be applied
>> in various places to specify user pointer,
>> function pre- or post- condition, function
>> allow/deny in certain context, etc. Such information
>> will be encoded in vmlinux BTF and can be used
>> by verifier.
>>
>> The btf_tag can also be applied to bpf programs
>> to help global verifiable functions, e.g.,
>> specifying preconditions, etc.
>>
>> This patch added basic parsing and checking support
>> in kernel for new BTF_KIND_TAG kind.
>>
>>   [1] https://reviews.llvm.org/D106614
>>   [2] https://reviews.llvm.org/D106621
>>   [3] https://reviews.llvm.org/D106622
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/uapi/linux/btf.h       |  15 ++++-
>>   kernel/bpf/btf.c               | 115 +++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/btf.h |  15 ++++-
>>   3 files changed, 139 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index d27b1708efe9..ca73c4449116 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -36,14 +36,14 @@ struct btf_type {
>>           * bits 24-27: kind (e.g. int, ptr, array...etc)
>>           * bits 28-30: unused
>>           * bit     31: kind_flag, currently used by
>> -        *             struct, union and fwd
>> +        *             struct, union, fwd and tag
>>           */
>>          __u32 info;
>>          /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
>>           * "size" tells the size of the type it is describing.
>>           *
>>           * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
>> -        * FUNC, FUNC_PROTO and VAR.
>> +        * FUNC, FUNC_PROTO, VAR and TAG.
>>           * "type" is a type_id referring to another type.
>>           */
>>          union {
>> @@ -73,7 +73,8 @@ struct btf_type {
>>   #define BTF_KIND_VAR           14      /* Variable     */
>>   #define BTF_KIND_DATASEC       15      /* Section      */
>>   #define BTF_KIND_FLOAT         16      /* Floating point       */
>> -#define BTF_KIND_MAX           BTF_KIND_FLOAT
>> +#define BTF_KIND_TAG           17      /* Tag */
>> +#define BTF_KIND_MAX           BTF_KIND_TAG
>>   #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> 
> offtop, but realized reading this: we should probably turn these into
> enums and capture them in vmlinux BTF and subsequently in vmlinux.h

Sure. Will look into this.

> 
>>
>>   /* For some specific BTF_KIND, "struct btf_type" is immediately
>> @@ -170,4 +171,12 @@ struct btf_var_secinfo {
>>          __u32   size;
>>   };
>>
>> +/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
>> + * additional information related to the tag such as which field of
>> + * a struct or union or which argument of a function.
>> + */
>> +struct btf_tag {
>> +       __u32   comp_id;
> 
> what does "comp" stand for, component? If yes, it's quite non-obvious,
> I wonder if just as generic "member" would be better (and no
> contractions)? Maybe also not id (because I immediately thought about
> BTF type IDs), but "index". So "member_idx"? "component_idx" would be
> quite obvious as well, just a bit longer.

I will use component_idx as member_idx doesn't align well with function
parameters.

> 
>> +};
>> +
>>   #endif /* _UAPI__LINUX_BTF_H__ */
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index dfe61df4f974..9545290f804b 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -281,6 +281,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>          [BTF_KIND_VAR]          = "VAR",
>>          [BTF_KIND_DATASEC]      = "DATASEC",
>>          [BTF_KIND_FLOAT]        = "FLOAT",
>> +       [BTF_KIND_TAG]          = "TAG",
>>   };
>>
> 
> [...]
> 
>> +       const struct btf_tag *tag;
>> +       u32 meta_needed = sizeof(*tag);
>> +
>> +       if (meta_left < meta_needed) {
>> +               btf_verifier_log_basic(env, t,
>> +                                      "meta_left:%u meta_needed:%u",
>> +                                      meta_left, meta_needed);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!t->name_off) {
>> +               btf_verifier_log_type(env, t, "Invalid name");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (btf_type_vlen(t)) {
>> +               btf_verifier_log_type(env, t, "vlen != 0");
>> +               return -EINVAL;
>> +       }
>> +
>> +       tag = btf_type_tag(t);
>> +       if (btf_type_kflag(t) && tag->comp_id) {
> 
> just realized that we could have reserved comp_id == (u32)-1 as the
> meaning "applies to entire struct/func/etc"? This might be a bit
> cleaner, because if you forget about kflag() semantics, you can treat
> comp_id == 0 as if it applied to first member, but if we put
> 0xffffffff, you'll get SIGSEGV with high probability (making the
> problem more obvious)?

Good idea. I will get rid of kflag requirement and only use
component_idx to indicate where the attribute is attached with
-1 indicate it is attached to the type itself. The llvm has
been changed with the new ELF format: https://reviews.llvm.org/D109560

> 
> 
>> +               btf_verifier_log_type(env, t, "kflag/comp_id mismatch");
>> +               return -EINVAL;
>> +       }
>> +
>> +       btf_verifier_log_type(env, t, NULL);
>> +
>> +       return meta_needed;
>> +}
>> +
>> +static int btf_tag_resolve(struct btf_verifier_env *env,
>> +                          const struct resolve_vertex *v)
>> +{
>> +       const struct btf_type *next_type;
>> +       const struct btf_type *t = v->t;
>> +       u32 next_type_id = t->type;
>> +       struct btf *btf = env->btf;
>> +       u32 vlen, comp_id;
>> +
>> +       next_type = btf_type_by_id(btf, next_type_id);
>> +       if (!next_type || !btf_type_is_tag_target(next_type)) {
>> +               btf_verifier_log_type(env, v->t, "Invalid type_id");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!env_type_is_resolve_sink(env, next_type) &&
>> +           !env_type_is_resolved(env, next_type_id))
>> +               return env_stack_push(env, next_type, next_type_id);
>> +
>> +       if (!btf_type_kflag(t)) {
>> +               if (btf_type_is_struct(next_type)) {
>> +                       vlen = btf_type_vlen(next_type);
>> +               } else if (btf_type_is_func(next_type)) {
>> +                       next_type = btf_type_by_id(btf, next_type->type);
>> +                       vlen = btf_type_vlen(next_type);
>> +               } else {
>> +                       btf_verifier_log_type(env, v->t, "Invalid next_type");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               comp_id = btf_type_tag(t)->comp_id;
>> +               if (comp_id >= vlen) {
>> +                       btf_verifier_log_type(env, v->t, "Invalid comp_id");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       env_stack_pop_resolved(env, next_type_id, 0);
>> +
>> +       return 0;
>> +}
>> +
>> +static void btf_tag_log(struct btf_verifier_env *env, const struct btf_type *t)
>> +{
>> +       btf_verifier_log(env, "type=%u", t->type);
> 
> comp_id and kflag should be logged as well, they are important part

Right, will log component_idx. kflag is not needed per above discussion.

> 
>> +}
>> +
>> +static const struct btf_kind_operations tag_ops = {
>> +       .check_meta = btf_tag_check_meta,
>> +       .resolve = btf_tag_resolve,
>> +       .check_member = btf_df_check_member,
>> +       .check_kflag_member = btf_df_check_kflag_member,
>> +       .log_details = btf_tag_log,
>> +       .show = btf_df_show,
>> +};
>> +
> 
> [...]
> 
