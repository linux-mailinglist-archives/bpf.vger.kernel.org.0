Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DD49479C
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiATGv4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 01:51:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14282 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237867AbiATGvz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:51:55 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K1FdR5006843;
        Wed, 19 Jan 2022 22:51:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=iGY0fX0SgPoz8bQEV3bCwkTd3cQ6PzO/tsHFlXnMZ4Y=;
 b=d0m12rr7W+r3zuoIF76CI/QcSkfgRqlXIIyUf1I4aerEGWt8s5XpZXl3+GvLcwfQzurK
 E8cneuOLRiTtL/qfA5pzcNGqSjbLcf0n1W9zGXiy9a4w+lxb9pFF9lDV0UDBfrMTuTiS
 hcjbfMi4cwcc8AtcG00ehW9JacN4I7kG5BE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpwwt9aqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 22:51:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:51:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdAX8BenuI1d8sORA7ZERUU4PzteMzUSjF6jVoBpeh6iSuTAfZR6TFRU1Ln9hIBmgTg7owJa2d11USEERKsSC5WfEWqu3NvT1nq3FjVvXrr80VnfaI690VELR1EpTlYOK7sAH8dkB4uL0b+nTAKSUiHkKwmAC9ckfdCs+C/QBTwiu/d8NmM6oJ42Dd1nbcwPA+eVwGN9WyjaPrmjQNdlgpOZOm7q0CN//weZxvLfes47CpzSLkh9U+1nedyrBCyv8vgQO3HKoTm3aLLu5lggJE8MslcyHEb+IlkqqRAZEjTMVwapyE1xDub/AnOC6IVynSa7x4FpCwUBQzdOXRxq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGY0fX0SgPoz8bQEV3bCwkTd3cQ6PzO/tsHFlXnMZ4Y=;
 b=oI0oGen5g+P+RgWeooL8g2EDpEpdaIWjEaWuIYBZK1bo+kUk2GIvWJhtFDOLRnNUGshLm0AzntxP2cntDPIVHK+BuiiYDVVxDrqvZSujt1QJRd752S53s7+QBkbYArm2muvrvbPSlzAecd4/kwoPp8tAMobcWpjzPJCOPjKyRZclZLWulUbkkTurp29DTyl5e/wiahLyIGU/7R3gOfkfaLw+GoFiRmzicrivAFAp6EXBPCq7TKAD3EalklLNTZPccUPt8JN1wPNMAp96ZsfrbqpN6qUo9bNqmlvd7CRpnWVhD1TY7l6h6vDtOL5ANjlwJ+BnHNPfnzuLym0e6OIxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3977.namprd15.prod.outlook.com (2603:10b6:303:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 06:51:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 06:51:33 +0000
Message-ID: <5f276f7a-68ad-f88d-65fa-f3a316956529@fb.com>
Date:   Wed, 19 Jan 2022 22:51:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20220112201449.1620763-1-yhs@fb.com>
 <20220112201500.1623985-1-yhs@fb.com>
 <CAADnVQKY-uvYic=4iXmHMdyiYOSzT1Nx=Zv_70pL+8ypNWQjYQ@mail.gmail.com>
 <4fe03fc1-fc1a-9853-bc10-dacb8cc60fe1@fb.com>
 <20220120042730.eow5d3dv3mtkwbci@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220120042730.eow5d3dv3mtkwbci@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:300:6c::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b53fe6-28c7-4c8f-da71-08d9dbe14bd8
X-MS-TrafficTypeDiagnostic: MW3PR15MB3977:EE_
X-Microsoft-Antispam-PRVS: <MW3PR15MB39775BFD177BF8DBE674D78BD35A9@MW3PR15MB3977.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUZgih9QGKn0+8XWetVJeXd5sqekn4rx9CdgCYkDVWHTBXWHhP1/HaQeG/NAGAsw/EYyHJ25MF/FdLaMLf6R3bEBzDbDHq9dsf6J4WngJeIYFC5i5HzNcl8nEv3iyDF6fWffniwMebkvv02o7mSYV1IxcOP921WpmrK4aaglKskg62iidACl7ty1eSDvEBbZ/PCokHc203o6BO5SV0buOKKjQfRMsemPIO5A3ratKB0TwXqQ6FB2H35szXox8SoPyeIu0/foyLxSdHnRvB8xwkdCMQdvpxIfSdniRYQU9eImZ+0Sh/OOiDUExIYK6x0lgOxW9GHihh0aY2p16KpZRbu2IkmgRrCPJqGWzpW+8sL7GYN326qU4XrHt3J95aUmjGCSjxbekNr+82mOQrvSM3CeLzgVsajdVX38karEJ+RxheSZRYfjqR8fLu4v61aZRf3asfqUd0NdQ4R/qrgRy36AmGGspDO8H+rgLX66n2DgR1L2IPrnTc0AbjxXp6kUaapD0Ol6qcgdnVmXsSVlXRhyoRj1t0U35aw+d7VovDuquM5152KVT+EfugMIOIRi8yLARnH9WDhM92k82JU2PfzaA4ST0N4++bO0zf2Rv8RAVsdZNGUVE7nozQgvetFawFuVp9U2ZZAiWMXpZlUM/arMx22ZHEpdlqZNzqkmV3qKIv0j3GcwW4qUd1sD+ptvzKW1EqKJncfMQupgkmXn3BZN6KDTUQTFYHaXs6PKwvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(38100700002)(5660300002)(6506007)(31696002)(36756003)(52116002)(53546011)(83380400001)(54906003)(66946007)(316002)(6512007)(86362001)(66556008)(2906002)(8676002)(6486002)(6916009)(66476007)(186003)(508600001)(8936002)(2616005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekYyY0N2S3V3WDRLOUQ4a3FWT0piY01mTGk5YXYzSEZNVXBQbUZuK1VFOHIz?=
 =?utf-8?B?ZHVjVDlTcFk0azFCMjFRRUlDK0JrUzdTWG4zMkRjbXNlS2hvVWk1czhtZXVC?=
 =?utf-8?B?d21oUWpzN25UU3l0ZVBuK21Ca0xWOUdPNEcwejNISXdQRXJOMlQ3YWZHTDNk?=
 =?utf-8?B?NVlYaWx0U04yWWFiOU5sazRNeVlUQlF2NlNTTjdKcE5EOVF0TXVsT3E2SmIw?=
 =?utf-8?B?WFc4eHpjMXlQSHluU3ErT3R1Vzc0RFVYenRoQUlvRm50cUMzc0xYc3d5dm5H?=
 =?utf-8?B?Q05VS3BDQnY2NmwzQUZ5Q3d6Uk9FSTl2ajAvRnVNaVA0ZU9KTy9xaGt4bjF4?=
 =?utf-8?B?bkNMSXVkSDNDKzhCR0V1c05OZTB3ZlcrWDI4ZlllK01mYTE5R2NJYVBTU0lt?=
 =?utf-8?B?R2ZZSllMenhoTU5mTXFmdWtlekpUVnZpTmpiNVR4bFJHOVdBcllKQklxZlJO?=
 =?utf-8?B?QzBraThGRGhRRnBXbHFna1owSWpwUFJmY2RLSmNSZGlqYWNUMHlWbzM1WGk0?=
 =?utf-8?B?dFVqVzJZV0l3UUxlZHZ1TnA2TUZ3bXF2VkFuZU8xRHV0Wk00UVBFU2tnalVM?=
 =?utf-8?B?MTZMZndjNmk1L3lseUs4eW11Zjk3dmpEdm1DSzY0Y1IyT1dSOG9Va05XMCtB?=
 =?utf-8?B?ZlZLanJhRkRtTlJRWnVjQU9YUUJkZ2xOWktuOU4va2hQN0xraSt0VitYM003?=
 =?utf-8?B?ZGRPTkphWnRxWk15aVFtZnh4SjA0VmExbURRb0l4WWp3RWptaGNkMVZuVHZq?=
 =?utf-8?B?M0I4cFdzVEd1eWZPTDg2ZTJHcytabmhhWThxbWxKNWJsTE5nKzN5WkdFV0Ix?=
 =?utf-8?B?VTVDYmF0M3hvdjhQaGtxV2xwbUt2UVM2WUdkQ0RuUDFwM0V5bExlQXUyQ1Fx?=
 =?utf-8?B?NlRhcmsvbVF3dk5xclZ1MHU3R1ZZNy93OWp3UXFFV0g2TUNwOTVsSVl1cWll?=
 =?utf-8?B?SERreDZyU1hDT2lxUzEyMXA3aTVrZ0JSTXlYYzVydUY3dlJpNFN3RC96UkRn?=
 =?utf-8?B?ZG8vbVZ6ZGlvN3RUNzVZMFJTcGVaUmJIOXkxNXhsL0MzM2tsOFVjQlJISzdH?=
 =?utf-8?B?YzJ1ZG9MQk9UTk9xQ2tjTkpPcGxmZC9BTTRESjZZZGNXRE1hLzMwT0dyQkIx?=
 =?utf-8?B?SW5xeWxVMVVBZGRFRGRCQTRQbnl4bUlqcDZPMlhvY04xQ0VoY0duUDE3WE12?=
 =?utf-8?B?cVVHZUVPTWk2K2wzWDN3QXhKR29kcHF6S3lkNkhnVlR5RXdmUzBCbTF4NTRP?=
 =?utf-8?B?M1A4V0pPdmxuNmVGWFI0bzhvd00xRE52U2g3ejIrNW82eHZTbU5RL2dzbk83?=
 =?utf-8?B?S3Q1Q3pnem9sMkorV3hJeUpNUDh2L2VtV2M1SHlhcSsza2tKSURUUmEvbUl6?=
 =?utf-8?B?YVBUZmN2MHg3MEFhcjFZeVdxT2tSanZGUEg2TnpoV3J5LzZBM1FXa2dZazVs?=
 =?utf-8?B?UHZFRGQ0VFJRMkdCTFFUaS9aRGJ4YjFyTkZKZkt3MzEwWjc3TjZQdVRnNGpi?=
 =?utf-8?B?dThhK3hOVTZHUnIyUzZvRWhYUVY4ZVV0MmN0cy9xRmpCNm0rYVVqaldZVzRD?=
 =?utf-8?B?MGpPOUMvWDFZa0VEVCtDWVpDZDYrWVZhWUFyWURUWmNxZ01uWWRlVHZFZTBv?=
 =?utf-8?B?RG5GOWsrVi85VktWK1l1cGtINk5Va0d6YkNiTDdqMDZyZ1lSL1hTdFIrcWph?=
 =?utf-8?B?aWRVaHBlSFQ3WjI4aHJRbkhqYVRmQWlOMnVQMkhlcEdSMG14d0dUSG01YWdU?=
 =?utf-8?B?TGlob1l5MU42TUlPUzBENmlZeFpNYms0dC94aGFpT09lWTlOck9vZDk1Q3pC?=
 =?utf-8?B?eld1MmJKSzQ2emRucFJJZXZXOERzY0RWbk83RmVBVUNCb2xlVFVzdEs5K2wx?=
 =?utf-8?B?ZHFtMUN2L2tQMzJFYVZLc3ArR01odHRBSDg4N0h0U05RTjU3bDRZM040ZlF0?=
 =?utf-8?B?aTdtekt1d3BqaWhxWUtNTUhTMTRkV3YzM1RsbG9ON013dGxJdFljLzJ3cXU2?=
 =?utf-8?B?aDZXVU1xb2tPd3BJRTZpVmp3MDRDRW4vUmRFUThnclkycmdaREd4ZEs4K0dV?=
 =?utf-8?B?bEN1WFZyTlRNODdERVR3akhaS3dXUGhnRk4zZ1YwZkc4SnFpVTZhQmVyb3p0?=
 =?utf-8?Q?V08cEK/U6gQ6HcDNfmruXOWma?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b53fe6-28c7-4c8f-da71-08d9dbe14bd8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 06:51:33.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/ydpDmfa0HQBRqDWjH30/U5RdtA8RHAc0UkW2/H7+LNlWPcqs0GZS/SWnWqefMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3977
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 19gSBqIk7gJtT11VhVieOHAjyHsljQ-K
X-Proofpoint-ORIG-GUID: 19gSBqIk7gJtT11VhVieOHAjyHsljQ-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/19/22 8:27 PM, Alexei Starovoitov wrote:
> On Wed, Jan 19, 2022 at 08:10:27PM -0800, Yonghong Song wrote:
>>
>>
>> On 1/19/22 9:47 AM, Alexei Starovoitov wrote:
>>> On Wed, Jan 12, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
>>>> +
>>>> +                       /* check __user tag */
>>>> +                       t = btf_type_by_id(btf, mtype->type);
>>>> +                       if (btf_type_is_type_tag(t)) {
>>>> +                               tag_value = __btf_name_by_offset(btf, t->name_off);
>>>> +                               if (strcmp(tag_value, "user") == 0)
>>>> +                                       tmp_flag = MEM_USER;
>>>> +                       }
>>>> +
>>>>                           stype = btf_type_skip_modifiers(btf, mtype->type, &id);
>>>
>>> Does LLVM guarantee that btf_tag will be the first in the modifiers?
>>> Looking at the selftest:
>>> +struct bpf_testmod_btf_type_tag_2 {
>>> +       struct bpf_testmod_btf_type_tag_1 __user *p;
>>> +};
>>>
>>> What if there are 'const' or 'volatile' modifiers on that pointer too?
>>> And in different order with btf_tag?
>>> BTF gets normalized or not?
>>> I wonder whether we should introduce something like
>>> btf_type_collect_modifiers() instead of btf_type_skip_modifiers() ?
>>
>> Yes, LLVM guarantees that btf_tag will be the first in the modifiers.
>> The type chain format looks like below:
>>    ptr -> [btf_type_tag ->]* (zero or more btf_type_tag's)
>>        -> [other modifiers: const and/or volatile and/or restrict]
>>        -> base_type
>>
>> I only handled zero/one btf_type_tag case as we don't have use case
>> in kernel with two btf_type_tags for one pointer yet.
> 
> Makes sense. Would be good to document this LLVM behavior somewhere.
> When GCC adds support for btf_tag it would need to do the same.
> Or is it more of a pahole guarantee when it converts LLVM dwarf tags to BTF?

Yes, this property is guaranteed by both llvm (for bpf target) and
pahole (for non bpf target). I will document this behavior in
btf.rst.


> 
> Separately... looking at:
> FLAG_DONTCARE           = 0
> It's not quite right.
> bpf_types already have an enum value at zero:
> enum bpf_reg_type {
>          NOT_INIT = 0,            /* nothing was written into register */
> and other bpf_*_types too.
> So empty flag should really mean zeros in bits after BPF_BASE_TYPE_BITS.
> But there is no good way to express it as enum.
> So maybe use 0 directly when you init:
> enum bpf_type_flag tmp_flag = 0;
> ?

I thought about this before and that is why I added FLAG_DONTCARE
to match value to the type. But I agree that is not elegent, I will
use 0 as you suggested.

> 
> Another bit.. this patch will conflict with
> commit a672b2e36a64 ("bpf: Fix ringbuf memory type confusion when passing to helpers")
> so please resubmit when that patch appears in bpf-next.

Thanks for heads-up. Will fix the above two issues and
resubmit once commit a672b2e36a64 arrives in bpf-next.

> Thanks!
