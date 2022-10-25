Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D560D1A0
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiJYQ2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiJYQ2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 12:28:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0764173FD3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 09:28:39 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PEv4i4023509;
        Tue, 25 Oct 2022 09:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=D/1O6GQ+3wYQ3Gr/Pnl6vdnm46EGxxpVg9pIZZj8SQY=;
 b=AuWKvlW1GV3PJJQ3Qq+d+Gu51Up+1AVy0Py1iDAfupjQl7AKAJFtVwS+uAdxrzyDlJqr
 +NeIa+sLeJtrbDnGcFS6PKmlJaH8eRoZg5xvdvK6hA8i17eHr8zDLCgOnSvgR2LPBk7Z
 IDnyqmepzNn8DTk5xlKFabXzqiRb7KBe0TXN9pFNzCDPOFVmWBl6Ac2H2L41C1Rc0sia
 LKc+20Ao/t0vgO3BZBrkPypuXG8Ve6v670NviCbzL63C49+lDVljyr9fcM9vYVKaEmZg
 HaU9Dii/XvzCFDtJRM2CaargQMifkeUMuVmtWGGrDIa0oAqMLOXT85vvuXfq7gvGYKwS YA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke64gqquh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 09:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV1+Xqiit9FpTZr0iaIB3SAYwfPbBHUrVqftY8Xv8cyaIgQo370+7RVQOhKhG4CpvAsRByTTBo/34h/NCOIbuEA0svIe3aVMw6kFJKFoIWKgfc3vZzQXnbjwCFSUVnMN4RKgm+1ePvB+FS5xgnjls0SqDmEmx73YGqubgOLsM1M1ZC5nghsUf40pPPpKuCHtBZ6cjs4rDVfsFK9BHV3rSk8JFlvoDylIwwVPIzXlfW7HnqXJhJIFJdmFPmEJ3IqJ6A3wjWM/yJFP9nwQC+KZDha5YM0tqWzz7VLvU3ltI5BVyfDD7mcwsw9TYGbFj2CjPbrIh6LgLp6bpfYNhhXoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/1O6GQ+3wYQ3Gr/Pnl6vdnm46EGxxpVg9pIZZj8SQY=;
 b=OzgfmNUGQTz1B+gOHRo9waMptXzUJV2wCCbUOA63m4Lo+pSEFSlc4qIyWbF9Tv+d1L1f31QNU836ICnvdZUzw9L0UvXLNKSwiol4ubpCnND59Ck8APk165d4g+TAYBhEyi00Vs8A1lljGE+rDq69uiv96gEDft4lLIMumdxFLTyZyVmZNUGto+SrBj+QMC+aAaMLRH+jgjd/917YWXFxkT/41KsXjqyp4xJbU68svBGPGUP+fxshb4/samCGREM78Qmlf4tO2b4hxNaSb5jZx8vdsJQc0JYNhlZhXOkexMoVHAsmTYO5aDO1Gq0JTx6/L3Jc3m9MB1G6kUaRc3K+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BY5PR15MB4787.namprd15.prod.outlook.com (2603:10b6:a03:1f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 25 Oct
 2022 16:28:00 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%8]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 16:28:00 +0000
Message-ID: <d147dca1-4b8b-338e-103c-9ecdb476f06d@meta.com>
Date:   Tue, 25 Oct 2022 12:27:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next v2 10/25] bpf: Introduce local kptrs
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-11-memxor@gmail.com>
 <582912fa-3d32-7c5a-cf24-fc79899a2e31@meta.com>
 <20221020004837.qclzg6pgrqamcn7e@apollo>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221020004837.qclzg6pgrqamcn7e@apollo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34)
 To DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BY5PR15MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: f82f821e-54a7-4587-6eb4-08dab6a5e1cb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CiV3prMH6NhuFdVxaADAGJ56HRbFxVQBlW8ugTsbFBFxV0edQs+BIErxRKbmeltsCHjtWzjCL7NPlD7FNUOY34ApGavbXAIkrIVy2c5jMJaRwBKudVuhrKXce0W2H7SRHZ5WmVe0VvwksZnTpCGO1H8Z04DIWnxT+i3Vt2bbXQFbsMfWRPdkKyopXxEo/c2K50D94BQBeAzsrbYHpb5hoO0xAvwHBytjqr5irIjNrPfNNhxdtoDSLU+9FvG4T1m2rqUe8LOAbk03xXG6EshM4UxC2XiwEg/v5d0q33r+YMzUbC13MyXt/hUczPiN60Xh7xpVDOyA62yFNC98ZOxJ1OqQ5q6mF1moWteh+aw0jNIIEoCuThGAakjimHD9sMF/1jGyjv3IWOwR8LQJYuHkSjlorGlM0boZA1CVibx337ZiXNm/TTHjTuBQteP3cZXyI70xZFE+EKYjLdKfufA+cPaYp7gP1D2lsdsmveWPegWPo/Vj8SwyI8T6FVL1Y51ksxTEQe4JRP7KFkJJGDqbgCcxS8by8bbL/BvlrY8GFYEPYvX/aajjrrYLsDUAJWsHa7jZ0Ny1dVHLSfykRDRVYBKilMtNVxAI/h0LMKuZ9dOdw9a0G0pM+kx3WkXAChXJU3AAoL59xpFVgLP8mrjFkEHLIpOA2ERlmXdG7NyZkswYE7OPZfh+wf5wYKdHemhp86EHLoRvjKDltKT0x3/8CFQqXrgejySzszDKg/G5TYWuAsIDHWPXyT0vQV5aNHjQtvi0ILpuG/qJqjF/sgROD9Gk7xp3ouJn1/kgzdcVtYxb0CYzDwU1lqq4aF5N2Kb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(478600001)(38100700002)(31686004)(6486002)(316002)(6916009)(8936002)(54906003)(107886003)(31696002)(6512007)(41300700001)(83380400001)(53546011)(86362001)(2616005)(2906002)(36756003)(66946007)(66476007)(66556008)(8676002)(6506007)(4326008)(5660300002)(186003)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklHWDgzQ05wWlBIcDdKTmxXRHd4cU1CUk45RjJrRzVUdGxNVmVMMXRpR2Ri?=
 =?utf-8?B?YUR6dzIyVThJT1Q5dm14VUpyMEU4bUorS3owUFhjcTZ2bklFY0ZIREpkLzZ0?=
 =?utf-8?B?NGxJUE0xbmphUGI2Q1Y4YmhzMXFGak1PWmpyU2VVWG03OVMxRHVBVU1JRDlh?=
 =?utf-8?B?SFE1UTRsVjlOeWxSN1p6RVMwSXRqUzRDTGduRVhCVG40a1J6Y3kvNExtR01W?=
 =?utf-8?B?VG1kbE91SmN2Ykw5eEpobThMS1daQ3JmU204QVQzSHhKQitYZ3UrMmVCb0lJ?=
 =?utf-8?B?dHQ2T2ZzQTFMVTBzdFYzMzloVitPd2d5Nm5waTJ6bDl2NGljeUhRS29Pa080?=
 =?utf-8?B?S2ZsRGl3L3Q4TlZVMmVvdnRRZVdlazRMRmx0NjhReEZTU2tPMkNibmlsbmNk?=
 =?utf-8?B?NUlSVHoyNThJdU5Odno3WEZzdnZNbmtqRXVKTzkyMFFlNE5hSmtuRHlaNUVD?=
 =?utf-8?B?cXpscVdzbmNCQ0ZxbmJrdjIvc0R2OGtDajgzOTJwZ2ZuajNSY2plWm1hVGtM?=
 =?utf-8?B?bnFYTFQxcnZ6ZldMUER6MXhITFhJMlNUSllJZ2FWei93SEgvc09TUVJZYjlI?=
 =?utf-8?B?bmFvSXdlenJNdU1kbnBYRThaRDhMSDZLeWxRT3N5UkpQaUJFZ0Z3V3lJalRl?=
 =?utf-8?B?Q3ZmMTg0S3NxaXRFVFNWMWRwOFI4WDNrQ3NmYU5zUDUrWTlnTllXZFJaeFNU?=
 =?utf-8?B?SURXMHpOZmFsbituaEt2R0g0bndCelRxSlh6M0Nsc0JwUmhSRnB2WjZNZWF3?=
 =?utf-8?B?QkFIeG51dnZtT2w5QUZXeXc2dXdIdFBpWFBXOXg2QkFyMzZDTXI0aWxlN2tj?=
 =?utf-8?B?alhZQzFNbXVZOU52a2tzZnU2U2t0QVdnS1BqeDFrTnJBVlFKdUY4TVoyMUk3?=
 =?utf-8?B?bWdCZ2tybnR0L2JEalE3V1VFeVpKNUk4SFBsdGg3L1NPZTliMGd4Q25aTXU3?=
 =?utf-8?B?bUZvUjFDK09maFZYQWRRd0FUNHE3ckhRT3lHZGp4R1EzT01ad25jcDJtTHVk?=
 =?utf-8?B?NjVoSmV1OFgxczhQalluT1lFc05GZlpWSnpieDNKVGd0UUI2MUdhdjFGd1BB?=
 =?utf-8?B?OS9KakFHMHB3N3ZpTStVb0JLaktJbUFVU0JMc0pxa1BrYU5sSWQveGJBVVVU?=
 =?utf-8?B?Vkc3dU1jSlA5TFRWVWNXRk5kRTYxWmFLbVljN2pRdHh6ai9ud0g2L3djcHNs?=
 =?utf-8?B?YzRaTkZoWVVkdnA2OUFZM25tVm5hclpLclQzMUVtdDh1SC9veitGZG5iYXlt?=
 =?utf-8?B?QlFFaUpTcGRZYTJKTEdWYXdZYTdJMnJuSllsNWs1OFZBNCs4NEJrbXVuUEZM?=
 =?utf-8?B?USs2RkRUTUlPMGVEdWtlNHJNaVJFV2JwbG5Bc09LN0lhN1plOUZadDdwMDQr?=
 =?utf-8?B?aHRFUGlrbUxJc1lva2RzMnVwUnk2MUNkdHVNK2Z5U21WOCtncFNPMnViZFlQ?=
 =?utf-8?B?MUFQR1QzOTVydnVVQXBpTEIrWDlIcllsc1o1ZjcvbURzeTY1aUJJQk96a3Iv?=
 =?utf-8?B?L3YxQ25iMTFkS1NTOFk5Mk5tb2VCai9kRzdjeVFad213SDhwL0IzNTBHcmY1?=
 =?utf-8?B?WUJVVUtVQnBoUGtuNDRocEkweHdNbUphY083dUNsWmJTMTFoWkxSR3MvSys5?=
 =?utf-8?B?QzB6UGhaSVlPbjMrVndRV2V5REFlcnBHbU44cUJwS2NhNGtvN0Vjaks0NGZQ?=
 =?utf-8?B?NHhkQW5zRDZSREJSWGQ5T1FuUG1FQU8yTzQ0RERRUElTTCtBYllqK0swMWxH?=
 =?utf-8?B?OHJXM2JqVjBLZG9oV0JnK25EaFowSERhQmhxRk1aaGxteVIxSEZXRG5obzhR?=
 =?utf-8?B?T0xzd1hQcThpVHlVcG1XN0NkVkI0cVZvNTQ1S3EwU0FDL3N3SmM4UjVwOXBu?=
 =?utf-8?B?Y1kzdlBnNUpPRFRHbFFMbERFNTgrT3RFWVRDMDNEVEdoY2NoZ0dPbGNrdlg3?=
 =?utf-8?B?eWtwUnQ2SDNuN0w1dlhwRS84UGdDdU84YkR5OGl4N3ZJd2x5SXFvYjFJZmM5?=
 =?utf-8?B?eTVpSDVWU0g2bFJFclFUbHJxNHFXd1N2MUphNzNGLzNUd04yci9WdGJwV1Fi?=
 =?utf-8?B?YUt5bWV3Z0srd0xNTHllNVh2TW5YQjNXWG1WdmtVajhKbmdDMGxmK281WGdk?=
 =?utf-8?B?NldRMHhYTm0rQXZUK1Y4NUhiYWRXaDNWeFVDL2Voam0xVmZXRHJQZnhZcHRV?=
 =?utf-8?Q?xKusfE+1VntZDLyQwXwtBRs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82f821e-54a7-4587-6eb4-08dab6a5e1cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:28:00.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrEoWI6Fn6+qBaILTHttwjglqY/J6LuTT4eIpPZa39et7Zj/wVOlaYiDzuZ/FawVB6LVZwDofye0x/RX5MvfLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4787
X-Proofpoint-GUID: lY4GoRrHaEFX-gZ_btNeOo6KyH_9q-BG
X-Proofpoint-ORIG-GUID: lY4GoRrHaEFX-gZ_btNeOo6KyH_9q-BG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_10,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19/22 8:48 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Oct 19, 2022 at 10:45:22PM IST, Dave Marchevsky wrote:
>> On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
>>> Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
>>> type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
>>> type tag in reg->type to avoid having to check btf_is_kernel when trying
>>> to match argument types in helpers.
>>>
>>> For now, these local kptrs will always be referenced in verifier
>>> context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
>>> to such objects, as long fields that are special are not touched
>>> (support for which will be added in subsequent patches).
>>>
>>> No PROBE_MEM handling is hence done since they can never be in an
>>> undefined state, and their lifetime will always be valid.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---

[...]

>>
>>
>> more re: passing entire reg state to btf_struct access:
>>
>> In the next patch in the series ("bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs")
>> you do btf_find_struct_meta(btf, reg->btf_id). I see why you couldn't use 't'
>> that's passed in here / elsewhere since you need the btf_id for meta lookup.
>> Perhaps 'btf_type *t' param can be changed to btf_id, eliminating the need
>> to pass 'reg'.
>>
>> Alternatively, since we're already passing reg->btf and result of
>> btf_type_by_id(reg->btf, reg->btf_id), seems like btf_struct_access
>> maybe is tied closely enough to reg state that passing reg state
>> directly and getting rid of extraneous args is cleaner.
>>
> 
> So Alexei actually suggested dropping both btf and type arguments and simply
> pass in the register and get it from there.
> 
> But one call site threw a wrench in the plan:
> 
> check_ptr_to_map_access -> btf_struct_access
> 
> Here, it passes it's own btf and type to simulate access to a map. Maybe I
> should be creating a dummy register on stack and make it work like that for this
> particular case? Otherwise all other callers pass in what they have from reg.

Ah, sorry for missing that. Personally I'm not a fan of dummy register on the
stack. Then if btf_struct_access starts using some reg state that wasn't
populated in the dummy reg it will be confusing.
