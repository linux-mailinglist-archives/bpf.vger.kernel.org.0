Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2162352E33
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBRXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 13:23:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhDBRXs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 13:23:48 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132HKg40006274;
        Fri, 2 Apr 2021 10:23:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xKTn7bBQEISAzn5f7WdIJnuPUhRFJAGKEJuoYaZj6NQ=;
 b=OYKM48kFj/m6oWzx/TaZ5rvQttz3eOTcmxn5OKhz4wzw70LHqlQropFLO1DpjJc1gY8W
 lCOzNQSagN7xJm5GwKIY+rUR5/74D4zZ7kTUgezv7VmwODmSz1RvzFqd1NLmy7YkKvMh
 0bAsIxKaDEh+2mTpkIGw2h15lnbuaBLNEjo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37nspfuvhp-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 10:23:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 10:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2L9OMS4ajiRsnhVed5MPwqTusnmDMJj9xXn5iOnyc1mR/Gydaf0DTFdjg24bher0aPbP34iIrnmRJhjBbnXB9o+W/NUT8cHHHYQIImt/XzKWoZ2ifr7N3N/vmJHU9U4x/cZuS/u/0gGi3nQ5yhiX3zE+TfRMTWzSQoowmb4kI4KOGlkpwryrg2NmqU8A6UzXPTwSoqP/b96LKzv1+YgSZKEqoXuUps36MEmPCGPlpJYpDeP6/XQ5aSoq5Ca6GqAv46LGopshmrlmyAKToA6xnQylzqQ6CmZ7VIHfXjeP9dZmwpMcxL8prpRJsuMx0+iyEQVF1fGo1PGJlTXVooOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKTn7bBQEISAzn5f7WdIJnuPUhRFJAGKEJuoYaZj6NQ=;
 b=i1TvGoMWXC6pgK7ZtVYMlLYqXSu/Abi+e8LiRnV75Dtc7yvZpeovZJwFeeG/FD14nULLPpOw6PtNTI/qyf8UvEaTbWzrT5BtuqGkhyX5j9SfdG7UbflJtAAG+JaFLW5G/R58qUHpel8baI1EyfgkH+GoGZ3bIgpJBIAlVgVpmUKXg8j/b9pLkqfgtw8UAG163WdazIpdaiygD5b+Ul/OuDygUlAnD48h68C50aIfYbaxTc+8/lZXMWdzpVrGVcfcyLhbPXTrQCaJjFlSVkitQASuNpkTFHUOlJn6+M/ckPwVV0It1E0hIqep/NgY6hrsjl/Bb6DECvyC1VhUQS8VtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2415.namprd15.prod.outlook.com (2603:10b6:805:1c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 17:23:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.027; Fri, 2 Apr 2021
 17:23:39 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
Date:   Fri, 2 Apr 2021 10:23:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YGcw4iq9QNkFFfyt@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:810b]
X-ClientProxiedBy: MWHPR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:300:ad::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:810b) by MWHPR15CA0046.namprd15.prod.outlook.com (2603:10b6:300:ad::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 17:23:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f8d72e-0b43-433a-beef-08d8f5fc0e3e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB24151EB135E4D4C7F5A53A36D37A9@SN6PR15MB2415.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2I920vHX2OzcNqhKL9aOlztM88tOz7drIJ+nutS1iv1XrG8zPjzCBi4QiUTavMVJVZrvtBUXTruL5AJYW05UkvYEbBGEmvyobqPyKiD7jzzWMFnmVIs1D/oNQVdwwCFi6rHs1xmvpDXrvgSd+fzqmsNI9lp/k4T2LOTLWFrmS5Gg7Og1TMvEwWj5K+yJdEJc8PXEDVC46Ic5qtU89z8zSJWXKzD7nokNAvLu0s4/QfApXC4oupMeaC1wCBDAnd24osJ5plAQr+9Id1wvr92d2WYZn4OvEEmvRqmGOJ7mDO15QsnZ5tf+yTHuz0EE0EaRMMm6QTJBybdw62OWV2WRRx9yWgsARlDcJPKU2SWHZqD02syEDlHEnSybZyTgDskS1XWdSTdXQnPdF9uT77QWa9CTIIk9CCD6dh0lQ4iNOl45hzzT0oqRafpV6WNGQ4RHRhvtxrvDVIsckWaD2CwcWMk+snyhNDTP5yVms8N4f4cVre5QuWI/LUnCTODnyQUbr5SejUiZrOdsX3M3SJ77CwMAl3Mkaj5ZPWOcg+hXI9U/9Zwe7tAYQpbdlDJPnNWatv0OeTcRhqPNYfa7emWmrruzUMmf/6KYPUm1YkF5o7O2JkUvUlAG2midVoGiGZyPaYz/ishdrbQY1B/r5pbEQoKHn2mIMaTxhhS4VmMjE3dmVQFWOeZz5SFw8I95/0taE9PDzgfvUphITmwRVzJiQ0MTotAOKFgnvWdSMTYs6PFMI2WmAyqGaQXm8QUjKVYvb3z7AbTDfFTSkbmxukgvnhnZUC4sOOYK64i7GNx1Oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(2906002)(31696002)(8676002)(36756003)(66946007)(66476007)(66556008)(38100700001)(52116002)(2616005)(6916009)(86362001)(5660300002)(478600001)(8936002)(966005)(186003)(83380400001)(31686004)(54906003)(53546011)(6486002)(316002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RTJvN2R5elBBQ2x0YndTNmlyb05UU1UrNlJtRlA3R2lKNE05cHJnZWlFSUgx?=
 =?utf-8?B?RFRiTzdGQmkzWVBmRVlHdzJJcEJKMUU2Vm9LL3lzWXlDcHVmR09FenJkblRy?=
 =?utf-8?B?SEtaQ21ZTDBCUnhDTG9rQks5SDFRbjVhYnFULzZQazVRY3R3cXlsYjJqSmJN?=
 =?utf-8?B?eTdFUnhWRHVoZFl2MnEwUWtSN3dWNWM1QVJqZDRkTGtKRUVLWFFTM1RpRlY1?=
 =?utf-8?B?cWlFS1lKSkNvZDZLZnlpQ3pLaDBHUnhhdnFmZ3ZMcmdsbVpVUVovZHhTb01I?=
 =?utf-8?B?b1NEUE1mamY3dEN3K0ZuNkZlVGpZQ2YrUnhkRDRITnBpQ1RTdGZ4azdmYmp0?=
 =?utf-8?B?RndaRTExZ29hVjJydHJwRnJpbUZad2RpZzB2YmpNWHlvTVA3Z0taMjcxS2pw?=
 =?utf-8?B?bjBES1RLR1BjM0Y3YXhvV2krajhjOUZiUXE2M21tYlNXWWRHUjNzc0lKS3R0?=
 =?utf-8?B?VzRhQlJIYkR0UWsybUs5QXM4a2JsM2VJYjMzaXZGSzNyV0VsaE16ZUhMQ2t0?=
 =?utf-8?B?QzRBR0JZM3FaWjRqdnNSZWJONWxKSU1EOHFIeWQ0Vlh1d3pEZm11WWFZZnVo?=
 =?utf-8?B?UytQZldvZTNPM1pBbnlSc2d0a3diRXJqd2R2VXRVYktJOExENjZVdURYUmVB?=
 =?utf-8?B?dmRieFJDNDdiVDk2MHVNcnlOQmlrRjFncUFiZjJLdCs4YkpnUko4aWU5ZzBS?=
 =?utf-8?B?TmlkUVRLcFpUSys4NWxIaUV6MVhsaVVZU25idXBkWTljRGRzTnFMOXlPUFFK?=
 =?utf-8?B?NmhiNmZZQllHaFVsVjlHSHpuTEZVSWJQL1VYeFRnUTJjM2dOQVBHZVBHZFUr?=
 =?utf-8?B?MXlvOHFkM2gyTVFrbG9TNVE5VCtwQ3hweTBqTENyWDVHRCswZGZVVlJSM01D?=
 =?utf-8?B?QlVjVXg5Q2ZneDZOSFNFT05NOEVTcWlTaGdqcTV4YlQrN2k5MTVYSXNhMHFB?=
 =?utf-8?B?dG9YT051UUVUYWI1c1dCN3VDTFZzZU9NWTIvVXV2U3JSbkRFVEJoMUlJazIw?=
 =?utf-8?B?Nnl5WjI4Q21BU2ZOcTRCaFJyZXhOVktvTHM2aXA4WHJXYWNuWFc2M2tsb2Uw?=
 =?utf-8?B?NGVTY09pRThPNHNMQVBnV3cyYVUrZlZiQmNiL3NBRFdWSGJKeWNaUUI5c2xt?=
 =?utf-8?B?dS9TS2dYejNoUzVNdE5ZeUxocWNRUFZVSGxLem51a2tMNWlHUndVblZHZE5Z?=
 =?utf-8?B?eWxZQnpSQ0ZDbTYxd3JIY1kyZExyWW9xTGNCWmU4WUluN1RPSkg4RzAwa2Rp?=
 =?utf-8?B?b2c4RlNYR3UyVjN3U3pVcmFod0MyK0VNcnBBTjdHdkZpTUI2dG5IWEhWNlB4?=
 =?utf-8?B?dFFQZnNaRmhHL0I4cUozUkNoZFBlYVZGand5bHlTYVZOc2FlR203NjRnQlVR?=
 =?utf-8?B?eHZudld1RllXaFUxU2NxL2U3WkdRV1VEZ2Zzck03V0doQXJJb1RCR09EbklJ?=
 =?utf-8?B?Y2Nxc0dpZTA2TGh5dWRScy9vOXAxSk9NS0p1aVptMnArcEo2WVRRSE5BTHMx?=
 =?utf-8?B?alhsVHVoMmYrVHlMWjFDUFhPZGNVNXdIdk43Z3NjdllxVnQ0ckdNS05MeWpT?=
 =?utf-8?B?S0NHNEduNzZlSjJsY0JJUEZCVzl4aEh1VVk1Q3ZHRW42ck9aRTA0anJySGNH?=
 =?utf-8?B?Qld4TmN0RmV2cjlLeVEyNWhsZS96MzRZL1FRYVZnU3k2bGZkZFlYODBsdm5a?=
 =?utf-8?B?ZEF6K0U3SVRETkhET2M0YjhSZEZubXdkM0RaQTBObWtJTzY0dm1iajVidFZF?=
 =?utf-8?B?cGEvbkovVE5EVDBib2l2end2amFCaUNOVlpKajRMVFZRNk9URDc3MzBlY0d3?=
 =?utf-8?Q?xpalqROMsTF4b6UjGSNQa7+6PTLyauwC5ReDI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f8d72e-0b43-433a-beef-08d8f5fc0e3e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:23:39.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cuka2wZQGVsdIypZIz1OyPysKiXND2VXSvup2Rqs6RryJizU0KTMiKdjhykxdH7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2415
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2GPUqKAWb0qnC1RmiSc7zETd5LKoc0AK
X-Proofpoint-ORIG-GUID: 2GPUqKAWb0qnC1RmiSc7zETd5LKoc0AK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_12:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104020122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 7:57 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 02, 2021 at 11:04:18AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Apr 01, 2021 at 05:00:46PM -0700, David Blaikie escreveu:
>>> On Thu, Apr 1, 2021 at 4:41 PM Yonghong Song <yhs@fb.com> wrote:
>>>> On 4/1/21 3:27 PM, David Blaikie wrote:
>>>>> Though people may come up with novel uses of DWARF features. What would
>>>>> happen if this constraint were violated/what's your motivation for
>>>>> asking (I don't quite understand the connection between test_progs
>>>>> failure description, and this question)
> 
>>>> I have some codes to check the tag associated with abstract_origin
>>>> for a subprogram must be a subprogram. Through experiment, I didn't
>>>> see a violation, so I wonder that I can get confirmation from you
>>>> and then I may delete that code.
> 
>>>> The test_progs failure exposed the bug, that is all.
> 
>>>> pahole cannot handle all weird usages of dwarf, so I think pahole
>>>> is fine only to support well-formed dwarf.
> 
>>> Sounds good. Thanks for the context!
> 
>> David, since you took the time to go thru the changes and to agree that
>> Yonghong's fix is good, can I add a:
> 
>> Acked-by: David Blaikie <dblaikie@gmail.com>
> 
>> to this patch?
> 
>> Maybe even a:
> 
>> Reviewed-by: David Blaikie <dblaikie@gmail.com>
> 
> What I have is at tmp.master, please take a look and check that
> everything is ok, the only think I wished to fix but I think can be left
> for later is in the tmp.master branch at:
> 
>   git://git.kernel.org/pub/scm/devel/pahole/pahole.git tmp.master

Thanks. I checked out the branch and did some testing with latest clang 
trunk (just pulled in).

With kernel LTO note support, I tested gcc non-lto, and llvm-lto mode, 
it works fine.

Without kernel LTO note support, I tested
    gcc non-lto  <=== ok
    llvm non-lto  <=== not ok
    llvm lto     <=== ok

Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start" issue.
Some previous version of clang does not have this issue.
I double checked the dwarfdump and it is indeed has the same reason
for lto vmlinux. I checked abbrev section and there is no cross-cu
references.

That means we need to adapt this patch
    dwarf_loader: Handle subprogram ret type with abstract_origin properly
for non merging case as well.
The previous patch fixed lto subprogram abstract_origin issue,
I will submit a followup patch for this.

> 
> I did some testing for this ret type fix:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master
> 
> And for the LTO ELF notes:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=7a79d2d7a573a863aa36fd06f540fe9fa824db4e
> 
> The only remaining thing, which I think can be left for 1.22 is:
> 
> [acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO
> vmlinux.clang.thin.LTO           vmlinux.clang.thin.LTO+ELF_note
> [acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO+ELF_note
> --- /tmp/btfdiff.dwarf.CtLJpQ	2021-04-02 11:55:09.658433186 -0300
> +++ /tmp/btfdiff.btf.d3L3vy	2021-04-02 11:55:09.925439277 -0300
> @@ -67255,7 +67255,7 @@ struct cpu_rmap {
>   	struct {
>   		u16                index;                /*    16     2 */
>   		u16                dist;                 /*    18     2 */
> -	} near[0]; /*    16     0 */
> +	} near[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 5 */
>   	/* last cacheline: 16 bytes */
> @@ -101181,7 +101181,7 @@ struct linux_efi_memreserve {
>   	struct {
>   		phys_addr_t        base;                 /*    16     8 */
>   		phys_addr_t        size;                 /*    24     8 */
> -	} entry[0]; /*    16     0 */
> +	} entry[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 4 */
>   	/* last cacheline: 16 bytes */
> @@ -113516,7 +113516,7 @@ struct netlink_policy_dump_state {
>   	struct {
>   		const struct nla_policy  * policy;       /*    16     8 */
>   		unsigned int       maxtype;              /*    24     4 */
> -	} policies[0]; /*    16     0 */
> +	} policies[]; /*    16     0 */
> 
>   	/* size: 16, cachelines: 1, members: 4 */
>   	/* sum members: 12, holes: 1, sum holes: 4 */
> [acme@five pahole]$
> 
> - Arnaldo
> 
