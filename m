Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC80356F5C
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhDGOyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 10:54:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48682 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhDGOyt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 10:54:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137Er2sL026976;
        Wed, 7 Apr 2021 07:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Yb9FO5/CgNo9H3FVqgaZ4NASU+H86GLmes5VcdzKTUg=;
 b=ZXKR0jbByzLFU/stQn13p5ZlUZgDToCirJoGPjmgwhTCycgkiC7awRG3YaQuq2nvvwIx
 wwUH355gOp+CegAYT4yStuzDb6eUxyivesj47w1Up1QLZk2xUmM5CJbGTcPuiqNqvYYs
 Ci455L64fh/3WcsPj4ETsGc8GjwAagmtBS4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37sew1r0ak-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 07:54:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 07:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOy9uCcZaXwzT+SnFGGIkzom8J/DM1sH34sYwTejSst08l4gTteJIJVenuu32P/bm6M+cBZ1kciGGa+HBcy9Zr56xDOLwFnhpWVsbqFNsjIvZyIjzgbOLRQQH30YYOyD3MBLBIPvQGS74D5HtPRJAQNES5l9zTal21lWF5UHYw4hR49krBMVlnx0dli4wVPUemV8UH6tkmg45vXdAJb94WxXCtgg5GJ/pbgb1dPNGUFh8+oSRbT1RtIG1BGkHToHEfEWM5n9J8t7Un9widBI0+sYgqnl7ee2gIBwg2nflSn4w8yEPdRGkV6xLWUbzqDFkPWALmzHEJYZvDh5z6cVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb9FO5/CgNo9H3FVqgaZ4NASU+H86GLmes5VcdzKTUg=;
 b=HRGH4hWCvGuM31trfq+LQU7MgjNIeAdxkLnlhBehH+u9r77OhUXt+cnPdJl8/ijedAMoD2LrYecsq+BFEBBemAKyVN4Ikr3WwoKjELglLQkdPrAKcr6jySbgEZMDmA7fhVTmIjSCiNmF1Q6hu/zLl3+6I/bbPxo9CVsWI8QRC5o7BX+wCB++4W2zvmqGqLx4y/CfpCNCI5FLH2o98no4Iv7chzJ3GiqOf3f1aIpAKlXnX2ZwutAxpZQvNqi2Dbv2ORAIDY8HchRe1XSanhF1613ToE62g33WQKln2jCLAsBlSChP2z6H6z3fzhxzBcJbzT7q6S0XE2b8RtTxWBSQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4659.namprd15.prod.outlook.com (2603:10b6:806:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 14:54:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 14:54:29 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     Arnaldo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     David Blaikie <dblaikie@gmail.com>, <dwarves@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com>
Date:   Wed, 7 Apr 2021 07:54:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:3758]
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10dc] (2620:10d:c090:400::5:3758) by MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 14:54:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753875ad-c3db-46f9-6d77-08d8f9d50b9f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46598D0C2A35CBC4997988CBD3759@SA1PR15MB4659.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUGo7TooArPj9Dmnt8i807v24c+e+ca7CqfSD9ijknpzxq1xBPyEMCwRm8bOFGw26N40v0wrAN0l/P6DdlLF/SE82smmRhs+6BWn86PhEpGB/If97hDqqq0+gtn2pDsTCUYz9PBYfm2w3JRa4n6VHer9ymBv38sTD40IEklreJTB7v7yUDcf2M7CBR34iymsoqVHzstnjZaIc65UlirqP+gckRgvH0MmCvfq2v6QcndAkUmN8CmMdOI17UpSSXC1vX5ExW3EhyI7qhqHt8H55FEiVqKM2L5MXulEH4Tvl8uzbg13NCZex4Co0Evvw1Krts1xFzzp+vKDpd0v89eKxxe5ab0qBvbAqKxlMvD8Sny9g2FEbluSCVSpteIkK+LeKOKD/9LzeczBBtRUpn1PbPV786NTM7j38QX1k1D/Zs9PRaJfS7BF19gqM9P/IosZUSUmAd54sfvW+ZIMHLgcXkdx8T3LlzjxCCDvlT02uD2oAMtfuelR3Tty6h1HRP05kVYkZT7n+vtXm2Ek8wPaW1UYOFFbmvq2WM9B4eBhYuiYcaG6IvFKW6B/vpUC03V7qdYdtOHoclqY8+VQmv89iqeMOZO+3NR1VOG9k+94nOJEtw4Mx+JD9qvjS9vMouhr+w8J4fFCXDypWn9YfpQXGHeqWg9++f/PZFAnAvBLfWGsL1JdcZDswTN1jgt9PWlFYvpiT7YBS5M6w3fDjPDvTwdgWfXPuJnu6TvQkFt8CjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(54906003)(86362001)(8936002)(66476007)(2906002)(478600001)(31686004)(31696002)(52116002)(5660300002)(316002)(38100700001)(110136005)(186003)(66946007)(66556008)(16526019)(2616005)(4326008)(36756003)(8676002)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHdQbUl1NWo0QzNUVHZKNVBVaUh2QjRsbWZ3UDJsejk3WjBQVEdFM3c4T1Qw?=
 =?utf-8?B?alhSckc1VkJvdHZtQ3lXUFM2YW5pSnVOUVVyWHpod0U0THN2ZWN6cStSZDFI?=
 =?utf-8?B?dlFYWjIyRUJ1TVdHVFZReGQ4dkRvMTBoRER0aUVzR3NFV2Rla3dmbGUzajgy?=
 =?utf-8?B?YWFKUkF2cnh1UFZsaldoWExFTnBBQUg3MUltc21kdEkvUTRJb1lReTEvVm05?=
 =?utf-8?B?ckQ0NmxQdkhrbW1BM1FRQWJwaW03MFZyVlkwZnhmZTZES3d1V2lkM2tJRSth?=
 =?utf-8?B?QzNleUhKR1pKWHkyZzk0dW92Zit3SG5FSEZwc242b09Wd0xGbHhOcVNnbmp2?=
 =?utf-8?B?S2lQbDdReFpMd1F0dFo0eUxNbkx6alJEdURxek1Wcithd0JiQnJrQTcvK0pN?=
 =?utf-8?B?RXBFaWd6Z1U2Z2w2OE5UWDRCYU5UM3M4bzhQM2FLM0xLRFNBZ0xJOUJBMVRn?=
 =?utf-8?B?SjVLWWpCUHBGMW5HMlZGZjVGbUhIenpDSCs5OS9EWEhWajJQNE9UbFo4Y1VL?=
 =?utf-8?B?Qy95ZzA0Y2oyUWxTRlJBTHB2NnNLUkpHQnNpUG50TEwxRUFEeWZ3enBTS2lw?=
 =?utf-8?B?NGpzaTRRV2VFb3dZeXZPL29la21NNitnYVg4cGVnN0pEajdZOER2MXlwenF4?=
 =?utf-8?B?VDZWaFBKMUtmcFpVQi9QdndUeFE4Q09XK0Z0VUxIQjFIVEl5YzY1QWl5c0JB?=
 =?utf-8?B?eko1S1Z1VktXL1VObERzSllNL3A2VGNnQmdMb0xBdjFyd1VUUXY3MTJkdW9m?=
 =?utf-8?B?UFhhT21CV0dIS3Fnd2JtalRiQXdNZU8xSUZnSjdFZW1IUkxmWE4rcTVBM3Ni?=
 =?utf-8?B?ZzgzNXJ6YVo5VmJvSzMyR3pYWlM0dnpzbDlwbUpNYTA2RlQwemc1QWhENGtJ?=
 =?utf-8?B?TnRFMm40ekpLdWZhNlNQWVlPQ29rY2NWdVpYUjlIUXV6bGFrUTNaOXAxa2Fw?=
 =?utf-8?B?ckdyKzhEWjU5Y25PT0ZvZ0U4a0l3OGhJQ2JLYUxHamlXd09SVnpmM0paQnNM?=
 =?utf-8?B?STlRRGRTVVg5NUFucEo1dlJNSytFMyt4aks3NmxkZytzdmduTm55a0NLLy9B?=
 =?utf-8?B?bEpCNjRUcjdhS3pOYTNKcmYyNW83RHQ5SzF1dHp2cWcyclI1Szk0bFhnendB?=
 =?utf-8?B?bGZBRng4TDhCUGhicUtHcERKcWlGTFF0NnhSNlNjSFZQZFdNUk9xVTlIeTVo?=
 =?utf-8?B?QzU0ajAzcGxKRisySG9qM1pSQkhvQkVBdkZDdWI5bXpRZWlya1dSWWFKOThE?=
 =?utf-8?B?QU1iYnFtQ3orbG5hME12QjU1WmpEVXZQU2NiTXhXZmMveGdiQkZPZzhBQlUr?=
 =?utf-8?B?ZVVZUGllcHZwL2tlQkxxVERWemlCRUp2M1pCMmZPTEd3M1ErSHUvSzFnNE5x?=
 =?utf-8?B?WUEycUNtUk9vMG9xUTk1bE5KTHdQdzluQ21MTmNDS1V1MDNsdHk5Wi9tUWNu?=
 =?utf-8?B?dlNuQjZlMldmcGR1NEtqTUJ5Qk1NRHJxSlNYWHAvdm9tQTBRN2ZkcS81K2FQ?=
 =?utf-8?B?Vm56ODhFa2Z4SHQrV00rNEQ4bW1qRnR1Y0pOVXlNeHVKaklmSnNmaGpYN3p4?=
 =?utf-8?B?TFRaQTRyaGpFZms3UmpTemRHVCtORnN1RER1dEF5ZEplSDQ3RklYWklGdEtD?=
 =?utf-8?B?ZTRzSWN1aTNtVHV5UEhoSElLd2V1aTNSbjB4dGxkMENNNUpEWlBsMTRSTkox?=
 =?utf-8?B?KzhmVmh4N3NsdVU5N0d5Z1BTVnFidSt2SWVURVR5bXZNSGZSQjlCYjFHeENx?=
 =?utf-8?B?cHU5TnlFN2wyVjlyY1JRSmRUQ0pDR1B6WkhaUjhKMlIvN2JjUWdad01RTHBp?=
 =?utf-8?Q?4CRgFWucEiyoFcN/MK8LKs+cIUNZoQYZjJqBc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 753875ad-c3db-46f9-6d77-08d8f9d50b9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 14:54:29.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr1wimQm2GKHEGwB+ny/qbqLafJ+DN4NkoHYuzgYG3AM9Mcpd3xOpFKs4J87V0/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4659
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GfZeIWTsPJ08mkTjFnk2BJjbSu45yRXl
X-Proofpoint-ORIG-GUID: GfZeIWTsPJ08mkTjFnk2BJjbSu45yRXl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 11:08 AM, Arnaldo wrote:
> 
> 
> On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
>> On 4/2/21 10:23 AM, Yonghong Song wrote:
> :> Thanks. I checked out the branch and did some testing with latest
>> clang
>>> trunk (just pulled in).
>>>
>>> With kernel LTO note support, I tested gcc non-lto, and llvm-lto
>> mode,
>>> it works fine.
>>>
>>> Without kernel LTO note support, I tested
>>>     gcc non-lto  <=== ok
>>>     llvm non-lto  <=== not ok
>>>     llvm lto     <=== ok
>>>
>>> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
>> issue.
>>> Some previous version of clang does not have this issue.
>>> I double checked the dwarfdump and it is indeed has the same reason
>>> for lto vmlinux. I checked abbrev section and there is no cross-cu
>>> references.
>>>
>>> That means we need to adapt this patch
>>>     dwarf_loader: Handle subprogram ret type with abstract_origin
>> properly
>>> for non merging case as well.
>>> The previous patch fixed lto subprogram abstract_origin issue,
>>> I will submit a followup patch for this.
>>
>> Actually, the change is pretty simple,
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 5dea837..82d7131 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die
>> *die, struct cu *cu)
>>          int ret = die__process(die, cu);
>>          if (ret != 0)
>>                  return ret;
>> -       return cu__recode_dwarf_types(cu);
>> +       ret = cu__recode_dwarf_types(cu);
>> +       if (ret != 0)
>> +               return ret;
>> +
>> +       return cu__resolve_func_ret_types(cu);
>>   }
>>
>> Arnaldo, do you just want to fold into previous patches, or
>> you want me to submit a new one?
> 
> I can take care of that.

Arnaldo, just in case that you missed it, please remember
to fold the above changes to the patch:
    [PATCH dwarves] dwarf_loader: handle subprogram ret type with 
abstract_origin properly
Thanks!

> 
> And I think it's time for to look at Jiri's test suite... :-)
> 
> It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.
> 
> Cheers,
> 
> - Arnaldo
> 
