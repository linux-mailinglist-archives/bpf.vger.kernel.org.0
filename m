Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05519607DD9
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJURrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJURrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 13:47:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF725DAF2
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 10:47:05 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LFhJ1w011290;
        Fri, 21 Oct 2022 10:46:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NVuKkOJQZvfSwOoB1CRtZ1eEsNKn1zyINYN4cR5kkqU=;
 b=kqfWmKCJw/3EPFlkywh7oGQQclmedFhTKF9ydvTGXwTt1du3mt9PU6YbKtfFl67rYI07
 X4575SI/oubg7z3SbwBnBRz2DUX8MMbhSUt1wTMjTiJjD1M2U06sJR2oqwls3fqfu7cZ
 ybQA8iKvS5CRY+Rp1T3+GlDlRa/Coc+ujaNkbONrrdxmgPXIYwXGLwbg2T4QmgL/11Jc
 WkmKiwfpBvvhZqg2Jv5FKOmrBSF24TNqz9Lx+ST6xD48lztbx+B/0VNZcMJKBysqssnk
 e6fJcrUmZxaim2dnTa9sJmz/4rx5t70ahQpOiKkUVNckLqqqzcO2QTTnvnV7MMf3sbD1 jQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kbjx0xk95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8gHtgqNCkmB+2GqIQvxpmp+FLLc/oVncPpUOwLp4KNa4uDerK6MnERu+U52mlq6GyapaP4GOEmxqzZCqpcZZDb9XVGW5o/s2CFvaEtnXtFfZkFJgSPwsKHNqEekgMRW9P+/rCrNA04s3yL0Ypta8EG+zGgNl9nxgw8xinNIvcOX5R5px9nk8Qp6VQ7ARJ7p4oRtcXS4S1Pra7sqwNmSajYyh6osSwj/jaT/uU3kfduqrNrR7Ifw+wU7NEOPVfVGSyyH4iPXAaamAayfnPaDEzo4xMa+Baya4z6Z6x1dlsqPBwnubJSh8tgOuUBS4lZg8jUzUkcS2MzPwWBtnTYC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVuKkOJQZvfSwOoB1CRtZ1eEsNKn1zyINYN4cR5kkqU=;
 b=jzXKiIBC5kIyTJaCimhYfhb0o2EN+nZLA0gEja5v3b0aHj7/56SIFpFLUC1Jq9aZvT42BMRwGC+Y/rOxrV56PxsvLanrk0wXkgPsoikddg6T1GOygmOtlK6gmDvU41xtxUnOIT+7Np9Mu2gujcswxlqi0ZbK2huJiUnOuJkzdOEWxNmoxO+gALl9lHgEzXyE4GEeng2sRD/P5/0qUFvjWvCNyXPBzp3gzsHhBr93aqMroekq8LSsrNXOvAS7I0pJ4xt5VAgFCAcDCJggmodmwIk6AomnLF4U2DSve3FTweMNWtj7RGLKeVGQ2BjweIlB6KVA4PCbZ2YY8v3psmWqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2080.namprd15.prod.outlook.com (2603:10b6:805:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 17:46:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 17:46:47 +0000
Message-ID: <97e1a0ca-2da4-b3d6-fb40-bf80cd817bdb@meta.com>
Date:   Fri, 21 Oct 2022 10:46:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 6/6] docs/bpf: Add documentation for map type
 BPF_MAP_TYPE_CGRP_STROAGE
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221327.3557258-1-yhs@fb.com>
 <Y1JGVW9joJd9wipN@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1JGVW9joJd9wipN@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:610:76::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR1501MB2080:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4555be-082f-46e7-3272-08dab38c39a6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvP0brrIfgBZUjNmxIdgFErtI31rtvqeSZTOGFbjUQH5Wo2sNfaiObetytarWyBTBgeIqz+IkHxX0NOMEMMKFnZFYQatx+53ePVtc7Di44etT8EosGr81z7orXMvuPr2cbvl6QfuV2qXLEEnf1ivdWjIQ5O0H4cuWcqLsel0GIf6+u69I/0dHEmOG2tFxXEhxx220V42Vwd7PdKiVQkkI3bEal+IGSbuB9FjeWeawUBQ6y4oIyiVi589Gcf6s6xSjvLiKCC13TFmCSSb/AJwNZWifHVg6RcL3ViKPcKH1vqz9qIUiN7KX7/r2+8k+L73KLGoh4Jf7k94Fw/3jm6yGW7/9RLKWcZFVzfgf+VzxmlRFHxMfks1kBQCUUk5OaHK/87PeQ4hIp4iuAcpLtqxam3JWnoYDMAbIy7pBqtZQZhjGPyM7RuCYZfOr9bjXWapm4rXy/OXv/AWlpJGBw/DU53p5pfohAOokHrNWw7pgmlYZNmS80AdG2AYM/lYRUt333DzmPj6mZLZTRHsBzl+fITmVACgOmiQZkw9KE+6z2nGWf/cSVQqwemreDU/8qY2zMqB+dRH+ER4A9fvSY3aUDfjXthSOgiFeXYcazEi1KMg2KnXoyq136MBZLpaK37cEougX+86uqTuy1Npf+ZwazXWNYe3T4RTeInnfH53OMJQ/ze+ZjUbp2Ern/aJBnSzE+vEL22Rx8SEkT2N9C2f2LJRheCU1ThQZRnWvG4CX8hPJZoT8tr0f//uHcQwqSzG3lFJjpjZ+PfLm7GRMe9GBjSKfcPW4h6p9HgleBV2k1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(66899015)(186003)(2906002)(6486002)(2616005)(478600001)(66476007)(86362001)(110136005)(36756003)(66556008)(66946007)(8676002)(54906003)(6666004)(8936002)(6512007)(38100700002)(5660300002)(53546011)(31686004)(4326008)(83380400001)(316002)(31696002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pXb2ttNjliMUNUR1EzOTFTc2NqL0NVblRaMm51S1Z1WmRqNGdTUzJIT3FZ?=
 =?utf-8?B?bmtRMGw3MVBXNk54ZUZzaEt1YXdSbGsxNEVMODNWQ3pIU2VaeVc4OFk1Z1ZI?=
 =?utf-8?B?TVZ6V0hhVkp1bUFuN0hoKzVybC8vZHFJU0ZXZmk3aWJKSW1wb2dLZ2FFRWty?=
 =?utf-8?B?NlBWOVJJd2txV1lDRXAxWk5GKzBudTRoSmhHNlJWbG9lK0ZROXRTckpFbzgz?=
 =?utf-8?B?U0hKN0txWTdRQ216cFNZZU9aYVlzWUliaHZuZGY2d2htakg0U2srSDdyc1Ri?=
 =?utf-8?B?Rmc4SXVTQ0dvWUovWGJoTlh4c2FuYXU4eDdIWTRuWEJmampFRmpPMG8vak1t?=
 =?utf-8?B?QndsaWsraWprTkVwY3RlVllTZENFYi9PTVNKRW1oTzVUdHRKTW1jWklmSFQx?=
 =?utf-8?B?TWRpZmlRL1BITXM3ZS9zZjkyZXJFMnBEUFFRdytxYVFYQnk4TkFiSmQ2OFY5?=
 =?utf-8?B?WEgwSnJCWE00Q1p3LzlZd1RocVhCb1lJc2s2SXZITVM2ZkhHdjhkT090OTAx?=
 =?utf-8?B?dHVKYmw2UGRpUllZYlJxN3QvOUJtSEV1L2Q1MkRsKzBSYVQ4bmR6V2tnZWxa?=
 =?utf-8?B?RnF2Y2d2NWlhNFdNMEFxa1NmSTJLT0hvTWMraTlpQXVQNTRVczlBOG16aTV3?=
 =?utf-8?B?ZElOZ0xDa1hxcnB6Vi9yR3dXOTJVZVF1bjgva1BwSFE2Q1FPVjBpRVJCMzBK?=
 =?utf-8?B?UDlONGdKNnhNZURDeXU0ekVEOUVyVUY1SXhWOE81bzgyQ3ZXaWdVT08rL3pR?=
 =?utf-8?B?Tkh5NFpOS3BJR1M4OU1zemN6NVBpcGdnSFJpUWt4eG5PR3Rja0F3SUt0SHRl?=
 =?utf-8?B?VUhjaFZ1alB0VTNuNkpINlVoZ3cyeUMwR2Zyb3U0U25jMExCak9RMlZVUGt1?=
 =?utf-8?B?U0d0MGJuSG9PZVNQR0F0NEZIeDlwa2xnZmh1bUVLaW90TkQvVEs4aG9tY1BQ?=
 =?utf-8?B?c1JnaWFJT25RdTB2VlJWZ0FzRFczMlM3RFE2VXVIY3luNUZzZEo3NWFyNjZK?=
 =?utf-8?B?NUVnUnZaVVMwbDVoT041eVE2NE9NYjJDQUhjRjVCQXYyZ3BjaFMxZFAxd3BU?=
 =?utf-8?B?eTB3Q3N2bTJwOFg5b0RkS1l4S3A5UXhNdm1DVVJOajc4RWRzQWkybE5DeHpZ?=
 =?utf-8?B?ZHRIY0svZDFYdFpIcGZSbFYrSEthcFE0R3NXckRna3lxMUNRNUxDbXRISk5Y?=
 =?utf-8?B?OFYyVkhvY2hta3RmR0VPVTFhb1VXRnNFVmMzL2hVZlZncGZJa2h2ZURRSlBE?=
 =?utf-8?B?bFgwVHRNUUxyZ3hiWnVaSTFTd050K1huV2Zsd1JsNERKSCt3NFEwWUJJVHlt?=
 =?utf-8?B?cFhPT1pKdVRCZUR2ejBQMllMd0lkOEE1ODlhQy9SWm0wSHROeGhjQytTN1o5?=
 =?utf-8?B?b2NtWE93QjcvT3JqOEZmM2czR0NlSXB5djZGME5yTVZMbUltYTNzSHVFb3dq?=
 =?utf-8?B?Slk5L2g2S2dsbng4NXFTcFJkWlZNMytyN1p4VEZJVkpxclhnZnlNNlFld21B?=
 =?utf-8?B?bTBndUdHTjUrUE8vZ2puUkI5M3k2SnZUcks4Ykx4Wm1OSERaMWcxNElzd3ZW?=
 =?utf-8?B?U0J0Qm5xMURoUlZzL01nUWxCRk01c0JNSm9aakw4SVE1OWp0Rk9henVmTTQ2?=
 =?utf-8?B?b3c1SExBNnkzMnhHWUNVeWpIN2V5Rk56V3NqWThTOFVqMDZVNkZGQXdvb0Ey?=
 =?utf-8?B?dHZxN002UmFWaFhEOVoxcWVPbTY4NWUvdzZuRElYYjdyUndOL2tLK09lL2Rj?=
 =?utf-8?B?SFRKTFNKUHU4TDgwNzQ0UlhralJBYUJqTEdKQldBb1JFeXFPOHk1bm9mcDhw?=
 =?utf-8?B?YTJrRTJBRThLOU81NEliOHA1OXl6R3JVejhFWExsakxvN3lyWFBWd0FqdE9T?=
 =?utf-8?B?ZlYwSi9rUDlsSm1nVnZIMFVIeGUwSVJqbW9pSng4UjBaOEkycEpGNXJVajkv?=
 =?utf-8?B?YWpIODNERDVZQzFXcnhKUGRtK2VUZVFkUUxjbUhQNVE2WU04UjlTY2RhOUtG?=
 =?utf-8?B?MTMwUkhZWXJDcXpEWTNVbUk4Mm9zNHVQTzk5anJTajZwV3l1MHpGd2Q0dWhJ?=
 =?utf-8?B?djNPdzcvWTI5TjdrLzNsOFRVOUx0YjNITTJiQzErdEg0YWxjcTE4M2JvMFdh?=
 =?utf-8?B?djAwVU8zSE5uYk1kZGwwT2Z0M3J0dlZkOGJGWmRnY3ZaSit0YzBINU5NS0tY?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4555be-082f-46e7-3272-08dab38c39a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:46:47.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX5A/yDU+bup9goqt/P/TLrXGkSumL5j+AhnXP/Wdntr5Qhgu//9CXvH8X1wnxxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2080
X-Proofpoint-ORIG-GUID: YX6uS3zWhqiHysHanyS5UXFBQQZC5hNb
X-Proofpoint-GUID: YX6uS3zWhqiHysHanyS5UXFBQQZC5hNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/21/22 12:12 AM, David Vernet wrote:
> On Thu, Oct 20, 2022 at 03:13:27PM -0700, Yonghong Song wrote:
>> Add some descriptions and examples for BPF_MAP_TYPE_CGRP_STROAGE.
>> Also illustate the major difference between BPF_MAP_TYPE_CGRP_STROAGE
>> and BPF_MAP_TYPE_CGROUP_STORAGE and recommend to use
>> BPF_MAP_TYPE_CGRP_STROAGE instead of BPF_MAP_TYPE_CGROUP_STORAGE
>> in the end.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   Documentation/bpf/map_cgrp_storage.rst | 104 +++++++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>   create mode 100644 Documentation/bpf/map_cgrp_storage.rst
>>
>> diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
>> new file mode 100644
>> index 000000000000..15691aab7fc7
>> --- /dev/null
>> +++ b/Documentation/bpf/map_cgrp_storage.rst
>> @@ -0,0 +1,104 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Meta Platforms, Inc. and affiliates.
>> +
>> +===========================
>> +BPF_MAP_TYPE_CGRP_STORAGE
>> +===========================
>> +
>> +The ``BPF_MAP_TYPE_CGRP_STORAGE`` map type represents a local fix-sized
>> +storage for cgroups. It is only available with ``CONFIG_CGROUP_BPF``.
>> +The programs are made available by the same Kconfig. The
>> +data for a particular cgroup can be retrieved by looking up the map
>> +with that cgroup.
>> +
>> +This document describes the usage and semantics of the
>> +``BPF_MAP_TYPE_CGRP_STORAGE`` map type.
>> +
>> +Usage
>> +=====
>> +
>> +The map key must be ``sizeof(int)`` representing a cgroup fd.
>> +To access the storage in a program, use ``bpf_cgrp_storage_get``::
>> +
>> +    void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
>> +
>> +``flags`` could be 0 or ``BPF_LOCAL_STORAGE_GET_F_CREATE`` which indicates that
>> +a new local storage will be created if one does not exist.
>> +
>> +The local storage can be removed with ``bpf_cgrp_storage_delete``::
>> +
>> +    long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgruop *cgroup)
> 
> s/cgruop/cgroup

ack.

> 
>> +
>> +The map is available to all program types.
>> +
>> +Examples
>> +========
>> +
>> +An bpf-program example with BPF_MAP_TYPE_CGRP_STORAGE::
> 
> s/An bpf-program/A bpf program

ack.

> 
>> +
>> +    #include <vmlinux.h>
>> +    #include <bpf/bpf_helpers.h>
>> +    #include <bpf/bpf_tracing.h>
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>> +            __uint(map_flags, BPF_F_NO_PREALLOC);
>> +            __type(key, int);
>> +            __type(value, long);
>> +    } cgrp_storage SEC(".maps");
>> +
>> +    SEC("tp_btf/sys_enter")
>> +    int BPF_PROG(on_enter, struct pt_regs *regs, long id)
>> +    {
>> +            struct task_struct *task = bpf_get_current_task_btf();
>> +            long *ptr;
>> +
>> +            ptr = bpf_cgrp_storage_get(&cgrp_storage, task->cgroups->dfl_cgrp, 0,
>> +                                       BPF_LOCAL_STORAGE_GET_F_CREATE);
>> +            if (ptr)
>> +                __sync_fetch_and_add(ptr, 1);
>> +
>> +            return 0;
>> +    }
>> +
>> +Userspace accessing map declared above::
>> +
>> +    #include <linux/bpf.h>
>> +    #include <linux/libbpf.h>
>> +
>> +    __u32 map_lookup(struct bpf_map *map, int cgrp_fd)
>> +    {
>> +            __u32 *value;
>> +            value = bpf_map_lookup_elem(bpf_map__fd(map), &cgrp_fd);
>> +            if (value)
>> +                return *value;
>> +            return 0;
>> +    }
>> +
>> +Difference Between BPF_MAP_TYPE_CGRP_STORAGE and BPF_MAP_TYPE_CGROUP_STORAGE
>> +============================================================================
>> +
>> +The main difference between ``BPF_MAP_TYPE_CGRP_STORAGE`` and ``BPF_MAP_TYPE_CGROUP_STORAGE``
>> +is that ``BPF_MAP_TYPE_CGRP_STORAGE`` can be used by all program types while
>> +``BPF_MAP_TYPE_CGROUP_STORAGE`` is available only to cgroup program types.
> 
> Suggestion: I'd consider going into just a bit more detail about what's
> meant by "cgroup program types" here. Maybe just 1-2 sentences
> describing the types of programs where the deprecated cgroup storage map
> type is available, and why. A program that's using the
> BPF_MAP_TYPE_CGRP_STORAGE map is conceptually also a "cgroup program
> type" in that it's querying, analyzing, etc cgroups, so being explicit
> may help get ahead of any confusion.

Right, 'cgroup program types' is not precise either. It should 'only
available to programs attached to cgroups'. I will add a few examples 
like BPF_CGROUP_INET_INGRESS and BPF_CGROUP_SOCK_OPS, etc.

> 
> Also, given that BPF_MAP_TYPE_CGROUP_STORAGE is deprecated, and is
> extremely close in name to BPF_MAP_TYPE_CGRP_STORAGE, perhaps we should
> start this section out by explaining that BPF_MAP_TYPE_CGROUP_STORAGE is
> a deprecated map type that's now aliased to
> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED, and then reference it as
> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED for the rest of the page. I think
> it's important to highlight that the map type is deprecated, and give
> some historical context here so that users understand why they should
> use BPF_MAP_TYPE_CGRP_STORAGE, and why we have two such confusingly-
> similarly named maps. What do you think?

Make sense. Putting deprecation in the beginning of this section
can make readers more aware of the difference from the beginning.

> 
>> +There are some other differences as well.
>> +
>> +(1). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports local storage for more than one
>> +     cgroups while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only support one, the one attached
> 
> s/cgroups/cgroup

ack.

> 
>> +     by the bpf program.
>> +
>> +(2). ``BPF_MAP_TYPE_CGROUP_STORAGE`` allocates local storage at attach time so
>> +     ``bpf_get_local_storage()`` always returns non-null local storage.
> 
> Suggestion: s/non-null/non-NULL. In general, I'd suggest changing null
> to NULL throughout the page, but I don't feel strongly about it.

ack.

> 
>> +     ``BPF_MAP_TYPE_CGRP_STORAGE`` allocates local storage at runtime so
>> +     it is possible that ``bpf_cgrp_storage_get()`` may return null local storage.
>> +     To avoid such null local storage issue, user space can do
>> +     ``bpf_map_update_elem()`` to pre-allocate local storage.
> 
> Should we specify that user space can preallocate by doing
> bpf_map_update_elem() _before_ the program is attached? Also, another
> small nit, but I think pre-allocate and de-allocate should just be
> preallocate and deallocate respectively.

Yes, bpf_map_update_elem() should be done before attachment. I will add 
this.

> 
>> +(3). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports de-allocating local storage by bpf program
> 
> s/by bpf program/by a bpf program

ack.

> 
>> +     while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only de-allocates storage during
>> +     prog detach time.
>> +
>> +So overall, ``BPF_MAP_TYPE_CGRP_STORAGE`` supports all ``BPF_MAP_TYPE_CGROUP_STORAGE``
>> +functionality and beyond. It is recommended to use ``BPF_MAP_TYPE_CGRP_STORAGE``
>> +instead of ``BPF_MAP_TYPE_CGROUP_STORAGE``.
> 
> As mentioned above, I think we need to go beyond stating that using
> BPF_MAP_TYPE_CGRP_STORAGE is recommended, and also explicitly and loudly
> call out that BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED is deprecated and
> will not be supported indefinitely.

agree.

> 
> Overall though, this looks great. Thank you for writing it up.
> 
> Thanks,
> David
