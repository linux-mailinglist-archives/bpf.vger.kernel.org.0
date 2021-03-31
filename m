Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B234F580
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 02:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCaAah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 20:30:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhCaAaL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 20:30:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V0PBWg005535;
        Tue, 30 Mar 2021 17:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6vWrta/mOaE99QvFBvR3Y/Tdhwu7uL1QVK4Hi8ctAfM=;
 b=o8QIWP9+HqJiHs4DL+Xik0YyLNIJHEWBPKPvlsJ1+98soHJIKSuD0KmRLSMk9OKfAM23
 PIO55tIB220OK4DaQ1YMZmGcIYDqNVXhwYbqiLAE3D2MYPced6y0wTGF6kEDYSOEmWlF
 2EhFVviGoqPrEyR1FlfbR251ckqDroGPlGw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37maa2s9ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 17:30:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 17:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXQZ8mgaUZjbYhZPtDlkMSLlUFKFbLazJDMvlXSptZtT0/Qhvxxz77kPHXNmdSZxjefGj3jkUVcL9znwTBLbOe4c3xyLJL1lRlBBah9+cF87TgcGY3q5wJOo2BCqQshvz/GfDjkmeHdWS4rdlX4ZhKPzHbKzFQFYm6tmC/Xi7//FrBIwqYAk2A5gwhbjp9cTSQrFpPvf9EX3KehLMFHvcvZ9+0HdqYvne9gg5YnkQCV4eQ9VYYNFwUgDlx7pKM1PMqGxF+EsVoyoU0Hia5tzBP/gwcNfF8yPnWODaZDxZzEigQVOwldii/FS7+Gf+xOUSDjZhgeQGdlBuyYRhlpBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vWrta/mOaE99QvFBvR3Y/Tdhwu7uL1QVK4Hi8ctAfM=;
 b=hqhIftOS4QI1vJ2ISzioyogDGRPU6bF9F+CQlJdbdjB1h2P7teqPWTC4b1Yi6eAsKYBCzDAsCNHKOBsl2T8+ZSLLxIcFmJ3wlb/F4xedNYQgDnDA3pwFcv+bxbjWCJAKoMI5OeMWqvnyaio5Q/Q0VWqQYLcPy4hEiNB6UttzUBR9VlaKA6Rv8x6MaL3EFQHtBRBQgTSNRDDeoeE4AMkux5lM1Pwl/fgOzaobfd9s4FjU6RRNja4ioA9EDsq46H/0CINzbiVt8ipMtCroeu6Bm1aczQ4Vufm5Viiagxm2DB3IrcCDagu8bccbBalVtrAkImaf5Y0+pBalXPo6mQjr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3790.namprd15.prod.outlook.com (2603:10b6:806:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 00:30:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:30:03 +0000
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org> <YGM/Uh61RVExWnTU@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ec083351-5fa3-fb6f-20cc-1b3d2b355012@fb.com>
Date:   Tue, 30 Mar 2021 17:29:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YGM/Uh61RVExWnTU@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:52b2]
X-ClientProxiedBy: MWHPR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:300:ad::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:52b2) by MWHPR15CA0041.namprd15.prod.outlook.com (2603:10b6:300:ad::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 00:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0186b7-319d-46c0-d07f-08d8f3dc2018
X-MS-TrafficTypeDiagnostic: SA0PR15MB3790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB37906A6D4F6FDC4FD14B647ED37C9@SA0PR15MB3790.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbceJpdMdX8ZdGX9ecuuvEFdvfO1PrUP3565LDyyDkkEN7SVRQ122p5jPJLoN/GJRVsy9vO++Q+Om8C2XKQ2+0YzJr9AcvlfP96pbeQJFub5ZX6rs1NYwzsXULBY4+/bOjvA+vRi/9d5rYjk5wZ/caDHluaYBT2W2ESYGf3uzPW757UIlL2jwVuJ6mASPetUvtIS61dIwdTP85JCr3mQ6a0bagNOFsvpZ/b6bxwxEGXQ+CqN0p8aOhm4vLrb7oUBv8GCb7ja/D0A91EEUMIx38qsCEDkt4OZSZT3l9ucVk0105q9uL4D5J1YoW15IV/1l5/Nnj8OWHRjC5oOV7dbQQBxakdoak7q3DVlfqtAOkRFyGJ+gZf63qVSy6t3bXjcHOP4pKBTTIyluRpwuA82V+ViCw/GqQ1UkEGkO3lpA5IGTb3qfW+HDvROWcLbTFOCCkDe8jzbQ9LLvoX3Inq15JjAdDr3PQua4zxyk64gjxUYvEAFnid48RgTzLhqVzmAfCNWiCHQDcncQiZOpKVF68QGrk8DXCKihqTydGCIyhWuUotUevcWtzFEkHtWfUa2x9yfnEDQFvkTgdx88CD2PLfkS1KzCnCxgN1vd+qvuuGwiQnrmtdC8mwecdU+dRREwkh5r6B1nSUr0dXrPIjBA6xqifC3g/hyctXJPu1xXV7Ez2ztkuQvDWZI9OCd/mA3SpIs+ql4PBxNiVGnJ6bocHo9AjpKd0D9JRQyzd38Wbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39860400002)(136003)(346002)(8676002)(54906003)(5660300002)(16526019)(52116002)(8936002)(83380400001)(66556008)(66476007)(66946007)(478600001)(110136005)(31686004)(2616005)(31696002)(316002)(86362001)(53546011)(2906002)(6486002)(4326008)(38100700001)(186003)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q211elV1VFMzL2dkdjBEQjVEQ1ZWeTJCK29QWCtGN2hURE5yNFlNZ2lqc1JB?=
 =?utf-8?B?RWhFc1l2dmVnNGRYL2FtaXhBMStXQk9LK05VeGJrc3ZRVm5rWmM4b2lZUzhn?=
 =?utf-8?B?bFdlUzZMMi81UDRNMDYvaDMrQlNWYUFKMFNkSVo1UlFzZlp5d2ZFMHlFRzJv?=
 =?utf-8?B?R3lMdkg1dGJkSnBQdk5aZGkvalI5OGZQaDI4a3lsSG8vbUI1QjRWNDBDNDBN?=
 =?utf-8?B?bER3eVF5RDRzS0xVbmxXL1cxZHdwSVpxWEVVV2tLZVlTV2ZsOTN0TFgxcTlN?=
 =?utf-8?B?ZWRGOThJQW45Nm5NZkd4ZWJPTENJdHBGaW80S2ozVWVMRFlBUHdYQ2twTmk4?=
 =?utf-8?B?TkIxWUNieFd5UjRCZ055TVNqTVBhN0UvZDNkdXRETUovVXFKZFZYNGczdnYr?=
 =?utf-8?B?c0diM3NrRjUveTluR3Z2MTE5RTJIbkppSWVyTmZyRUtrU1VOV2Z4NktNc1Zj?=
 =?utf-8?B?eHpOY0w1bUJuaE02NlkzTzE4UGdQRDRzazZMMVB5TkVCVThpREIwazFmWFgv?=
 =?utf-8?B?YXlOd1REYjdKN2ZpbmMyYzNsYm10QVRUQmFCN0h5ek52NkJuaHc5eXh5Kys4?=
 =?utf-8?B?OXEvMXYzd2lpVCtKK0ViNU1KOUYrdzh4RG55T2ZTZGc1NUFnUE9abXpWZDB6?=
 =?utf-8?B?Kzg2bzlhUVowRkFWODYxbTlkeUZqSEtaWVpaZ3FiNC80dmZTREorT0d2Mldo?=
 =?utf-8?B?YkdTUmUyNXdpYTVxRUM2enVGUnpIejdSbmNKa2d0QTlzRGdsR3dZN0ExNzBq?=
 =?utf-8?B?MTFDUW4xVFc5QlBUdHd6WW5WVjJUSm5ZYXMxL1h1MDZ0VlYweFN2ZWl5SFFY?=
 =?utf-8?B?M2lqTkFvQ09LMldRODZibEhBSFF5TnNIb1ZRUENnNVBuWDNBZDhkOTFVMEFh?=
 =?utf-8?B?d3Bpc3ovMFZ1Qk8vMU1yM1hPOXJUQ1lxVk5icG8xMndQaWVJNVVzZHlnNFBG?=
 =?utf-8?B?aWsrVFV1TC9sTURZSFNESnh3Wi83OCtVZUVaTDN4dko3dHBZR29vTi9SbVp4?=
 =?utf-8?B?MmEvR1BNQ0cvR2ZZdDQyQWRHb0JNcXR3K0pGUmRZdVJmN1BNVHRZWXIwYU4y?=
 =?utf-8?B?aE52M0NaditEWUFiTVo0YmtkcXNyZ3dMZWpkdDBoQ25lbXpYeThSSU5CRHAz?=
 =?utf-8?B?UVZOaGdhTXVVWFdWTUNtQ1I4K0F2T1ZoWnZvVWdpU1RzMzRvcldRYnJpNmo2?=
 =?utf-8?B?T1lWUHJpUDBWWjd3YlRHeldtWW5ZRFg1YlgwRHFHZ0tTRVk3YnNoU2ZPbzhN?=
 =?utf-8?B?RjRleEZtdUo1eXVIZXh0NUl6LzlCVTUwSnE3NW5RWklHWWRMYzhINjRvM21M?=
 =?utf-8?B?MThDRzM4dmJJbHZ4TEtIdDNlc3daLzZwdWJzQitNTDJxVXRpaU16ak1SSWhH?=
 =?utf-8?B?T3E2WkNTNGsySXFwUHdZSWloRkVUaEdOMFVRU01UVEV1RjdKdGlPVS84RjlQ?=
 =?utf-8?B?QmRlMWF4QXlsZEpsY0FkdE5DUlNod2Zob1lReVJUSGE1dzl0Q3FGV3U5c2oy?=
 =?utf-8?B?SzZIZVhhUGRjS3lrZ3o2OWpqaW1xNFhjUFJGdFppWjd3cGtvV3E2emFEWVBS?=
 =?utf-8?B?ejFsZDRFdjNHUmdCbm1LcjBDUm9Iem9SN2R1VWwwWnIyV0FIeW51WXp3d0g3?=
 =?utf-8?B?dGo2TDVualBQQ0hWUGFoR2RmNTN5bnJuLzRCUFhsN3ZmV1c4T2lFcngxeU5U?=
 =?utf-8?B?MTR0ejBRZW42UTlsY3poVE8yNU5kRWV5MGVHbHVwclRaZ0x1SzBrblRBS3Rj?=
 =?utf-8?B?TzdGd1Y1RDE4T0FBMHhGVzlXYjBmdVZpTkFoVjNCbVpiQlVRY0FqcGxQVzZT?=
 =?utf-8?Q?GepKDTgT8Qf/3x5MqxOqcs1MXhLUm0aVOIcus=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0186b7-319d-46c0-d07f-08d8f3dc2018
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 00:30:03.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9xZYZ6O4YVKnuiNvYf/lSL+fc9N6Z0kaBryF0jv1k8EwqNjRabOyTMuFvmVFUyd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3790
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: TEq2zrYpjVqPssjJlYd5fUybF4XzHK_T
X-Proofpoint-GUID: TEq2zrYpjVqPssjJlYd5fUybF4XzHK_T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_13:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 8:10 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 29, 2021 at 02:40:05PM -0300, Arnaldo Carvalho de Melo escreveu:
>> [acme@five pahole]$ ulimit -c 10000000
>> [acme@five pahole]$
>> [acme@five pahole]$ file tcp_bbr.o
>> tcp_bbr.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), with debug_info, not stripped
>> [acme@five pahole]$ readelf -wi tcp_bbr.o | grep DW_AT_producer
>>      <d>   DW_AT_producer    : (indirect string, offset: 0x4a97): GNU C89 10.2.1 20200723 (Red Hat 10.2.1-1) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -p -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fstack-check=no -fconserve-stack -fcf-protection=none
>> [acme@five pahole]$ fullcircle tcp_bbr.o
>> /home/acme/bin/fullcircle: line 38: 3969006 Segmentation fault      (core dumped) ${pfunct_bin} --compile $file > $c_output
>> /tmp/fullcircle.4XujnI.c:1435:2: error: unterminated comment
>>   1435 |  /* si
>>        |  ^
>> /tmp/fullcircle.4XujnI.c:1433:2: error: expected specifier-qualifier-list at end of input
>>   1433 |  u32 *                      saved_syn;            /*  2184     8 */
>>        |  ^~~
>> codiff: couldn't load debugging info from /tmp/fullcircle.ZOVXGv.o
>> /home/acme/bin/fullcircle: line 40: 3969019 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
>> [acme@five pahole]$
>>
>> Both seem unrelated to what you've done here, I'm investigating it now.
> 
> The fullcircle one, that crashes at the 'codiff' utility is related to
> the patch that makes dwarf_cu to allocate space for the hash tables, as
> you introduced a destructor for the dwarf_cu hashtables and the dwarf_cu
> that was assigned to cu->priv was a local variable, which wasn't much of
> a problem because we were not freeing it, as it went away at each loop
> iteration, the following patch to that first patch in the series seems
> to cure it, I'm folding it into your patch + a commiter note.

Thanks for the fix!

> 
> - Arnaldo
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a1e860da079e04c..3e7875d4ab577f1b 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -150,6 +150,18 @@ static int dwarf_cu__init(struct dwarf_cu *dcu)
>   	return 0;
>   }
>   
[...]
