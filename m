Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83456587409
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHAWlj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiHAWli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:41:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999933A01
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:41:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBS72026841;
        Mon, 1 Aug 2022 15:41:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fp5VNbMWLKHlqk5oP8UOC/U8t9N/nC5Ttt7sQnqZLio=;
 b=qAc6D4mx82PY0EbxhPXctdfIRTw3oO47LtURRaA4uqFoIpHPhrzJ4t2m7gJfuBhiiHJ4
 7HLLhSkjhcTWLO8OpnHak5bq38Wjxp9SzxU5pttDqq38xWdZbH38ANLTiOm5nRfSaDzz
 mrPJyZyAEDaBdfzE14T+lykCwPT85GiB/cI= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn2cxq398-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLYCEY9Hh+9shW2mdV4eZ2uA1o+yEir2uBxwb0WJprDBkjx2opDVAx6xfRItJz2sTwvJTC0/2QPbLXdCju/wELjHuA4kNLxB33yKAkgNyeq4wYF/Ac2cA5O3ntpbceGUy6bYWECluPtm5Tjyf1l/wEjspQX9BkZ9UZzqdLJNuoDHtS+upsWtjWoVTSNbgWI64Ce2KjEg6gaMXNK4VrGYwWsBCdIWNX0paEDyBdupmcWPcGmBagnp8dUVnGZLT0RLI0lut0e6FCpaQFAF903YaZH64dkTY0h5dOx8gQWSObc6ao+5G8aoMhu8tHOujWDHfdxlQBqLGArR3Zn440W1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp5VNbMWLKHlqk5oP8UOC/U8t9N/nC5Ttt7sQnqZLio=;
 b=PAxj/sJxLWjyK6Y4+JfFjzoKISoRFFn1NndWZdzN1w6N4cz/GDUjgynkpXwOB+DhnpuGuT0RNiRtBI2BJAMRx//e1m7Y6kRMbs3xpPdo3+6lwdpTle/KZEixu9JFkU1POeMjPGhuRoDbobY/BM0pBRZADjoBvuJBpScjW29gyLz8ADUt0popYh0ATMvjMhcs4SXgSVVwW4ERw529otF/9hW0rnU/0UPXwd0GItnpbLVq58ExHEgAM9hxGMFgbmN5Z7r/stbypOKFk5UXIMT1ILGwj3Q5njjZioiYSKOUpe1nW0EdPHIcYNy+2h//4zg20SIcoWPMAOqrJt9slnAPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SN6PR1501MB2141.namprd15.prod.outlook.com (2603:10b6:805:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 22:41:20 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:41:20 +0000
Message-ID: <e08116f0-8dbe-0d9f-ca2b-3f4c27d289b6@fb.com>
Date:   Mon, 1 Aug 2022 15:41:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 08/11] bpf: Add OBJ_NON_OWNING_REF type flag
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-9-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-9-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac40793-b9be-44d3-3c8d-08da740ef401
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2141:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqWEOeK/1foBDCnPftEf6MqG/5OYza4r3uDnfuY2FDxqCR9bPfKvyPKPjF8/ry9T49m0mdxl5xbZQH0exySE8EwqVWBBtnjZhQ0tPsmKNBSEaVsJMI11ToexC59Yvp412Uy3ojYICVyLpbq3VVVTwv9yYa3GDEFqMMVuBgksKPDW2mWM7iX+0qWxyc+GeN1CIGl32tsEPy6uDNQb51wtHT5usv2VeNIuGZobNdFhuWtu9oxXGUj11/YABGCnhforg76MIoCPXCTT6aYNjv6AEMl4QPP0bmBY69rrBQr/d0AdLI48ZL9BY6W7IPgyrn0DMem3rUZzC5TpziruGeRvKj9x3He3xS/UbR37qUfjYBI4Dk6B6cEfp0POq9/Y9SRQdl+U592oEVF2N9GZwXxtTYBwDRkSrSNwqDWL0QZrc8d4d/Mi9JGctNddpbKJO58VpY7dM103JleHSadETSSOUgAdfO9aMFURMmLI61BP2IqarKjOc/z77WiAoXYf2nxVYKTR99TGOupHarwX9qrSkG2VNSTIE3KnuxsJuVCVfiUmyoIh4P4m8Bp6OQU/p3CwW9XmH8GcGzGagz8qsyP+f4ppg97qXYd2D/gM1Nqvkz/eK6ApxYq0k/+lC5EiCFj/GlFDKWxhSk8jC4gDaw4OodkLJtko0TWOA7D4WxJ1TJ+chiHlSTxTIykln9+VzJfrq2VKLkKbrB6liBSMLXfCxU01b7w4vfm5VGGqmIk6149Lbiam0u6UHuliJ4xgBlWi20prhA6AkkbdiSRzsetZEcI5Dg6dlsrhIw+fygVgFg5zzMAh4IvsFfwnL0GvCxJgmfGOCWG57vxNA/7quVO2RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(66476007)(66946007)(36756003)(66556008)(5660300002)(478600001)(54906003)(8676002)(4326008)(8936002)(316002)(6486002)(86362001)(52116002)(31696002)(31686004)(53546011)(6506007)(41300700001)(6512007)(186003)(2616005)(83380400001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBEck9yaFlremVlN1BTQmhQbEd4ZlkxRUtLZFNZOG9aWXhHWWxmcXBGTTdp?=
 =?utf-8?B?WStQdTNEblhtbEJObVBuYjBIeTRmeUE4L2FLUXRxZ1Z6NVlGNEpoa1JwMjFQ?=
 =?utf-8?B?ZFptVGFQN3NkNFVyWGRCTVFSTkt0Zm5FMkFmNUZDb1VkZ2E3bVlKK1VacEVL?=
 =?utf-8?B?bEtMUmloa05tMWhnS1M4T2ZCaWRvSzVGczNaRG1DN2NvU1AxTXFGYTJVaFli?=
 =?utf-8?B?Rm5GSlhJUDRwRVdIT0VQa2xXWU44NnFJL0tIR1c3U0tSTDc3azAvNVhCaHE3?=
 =?utf-8?B?M0w5L0VBdEhDYkp6bjZ4UHRhNllHNUxkY1Axa3FCRi93UUE1TmhwOVlqNkw2?=
 =?utf-8?B?TjFUb29jcWdYbzEydU9LVENWckJhVXdta0pOdmxzWmEwNmpJMzFxajdla2dX?=
 =?utf-8?B?aDJNSStZamExQU9pM3pIN3BWSTNaRm1hUHVJLzNuMC9YSjJMdlh1bWczRWZi?=
 =?utf-8?B?ZUFodlR0N1JiRHVlS1RONjdFMzV3bVdyM2lZMm41NGFiaHY5dkdCTkErYXp1?=
 =?utf-8?B?MFgxQ1NpT3hKREdnT1Qvc1BrR0hTMllVWDdzb1lIYjlDQXRkZitlWjhVaHNL?=
 =?utf-8?B?cFd1OTUvZjV6eWxHbEZOMWxlclhaNTg0QTV6NFFreWpzMkVTeE9ZbzBhV2ZF?=
 =?utf-8?B?UUlhYjhCdGd0MEpEekxQb0VXNjZqaXdrQ0lMTTlRR1ltVUNHYm1UeE5TaVpl?=
 =?utf-8?B?M04wREp3K0lveEdRKzg4T0hndEU5M1RZQUFNd1FEUWFMZHlSSTRhR21GU3ZV?=
 =?utf-8?B?N0lYYWtNenN3cUtQUVRVMjd6Mm8ydXRvWktPZVh0Y0lFejBISXRsSWNBaWdm?=
 =?utf-8?B?NlA5eFRBMzdsNk9FZGd4R20rKzl4YlNOYjhmQmNGZjEzZjdOTXBGeHlHU2l2?=
 =?utf-8?B?bXM5SkxHaDdUemRoMjhpUnNKa0Z6Z1pydWlIWXlVRmQ5cEJQQzUzTHY0OW9H?=
 =?utf-8?B?RFJDcVUvejd5MHBmKzBMK01nTEhKbjM3L0lUZGJaT1RCYkVNYmF4SnExejRR?=
 =?utf-8?B?bDIxd0VGQ2o0ZE0rRFlwVW0xSkJ2Sm5sV2Fmc1pybXJjeTU2MFFRMnByV282?=
 =?utf-8?B?MnI0WFBnZ1I4MzlzTGlzUnhRUUhsSGFRMG5TZXN4a0trQy9UUDVpVHZlSjVS?=
 =?utf-8?B?bDBJL2gzdFFKVFVFVWdDTFNrRFVkOS80bXhMN0ZkblpnU2ZjL1dmdEdUMXBp?=
 =?utf-8?B?cm0wR2c5RlF5SHIwV2xVbGhTeHVlY1Z3ajN3VEZpZ05IUEV4VUxKdC9KWm9x?=
 =?utf-8?B?OXlDM0g3WjcxTGt0TndGUHBLcGswcnBDZmdDK0RqLzV6dXF5TEJIRGNEbURE?=
 =?utf-8?B?cFRvdE9GK2FKa3pPZVdqcFZjRmExeURldmhoSkdlMmhOMDFUSTBFSWdaUzA4?=
 =?utf-8?B?dnRyZlB1c2FCUjFKOU5lQkVXWWd4aWIzRHMyVFAvZ2pIblpiWXpYMnBkUGJv?=
 =?utf-8?B?aVZ5eDZrdm4zTTBUR3VNaWJUUzZsSE1OaFY1ZVN6UldOOVBuRGIyS0ZqMHNt?=
 =?utf-8?B?dFdLQ2h2SmZJS0tYY3cyRFh4dUVTUmJwdUxRL2pYMlFqMkFHMWl4WVMyUVJJ?=
 =?utf-8?B?Y05jTkg0YzNYTHNtRkxZMzJMbDVld0ZLMjVCMElKLzc0RUszNkw2T0RYZ0R2?=
 =?utf-8?B?djdQbjlmdE12L0IxZytweGJCMjVyK0ZrY0xiUU42bzJpWlpqRFAzWlU1b2Y1?=
 =?utf-8?B?Mm1BZVdSa2NXSnBLMmM2NnZpTzRqOTYwcklCYjJXM3ZpQ0R5RVdOajMvdXJS?=
 =?utf-8?B?U3FCQ1IvbjBFQmMrTEVCdEpld2hPd2VDdUo4TUpPdDhiK1IzT0laVUdHcHNj?=
 =?utf-8?B?bnArcXluR0dOR1JXa2pJV1VYSmRKaUJjYWxUU0diR1RBdHZzZldUQjhRcWlL?=
 =?utf-8?B?Z2hCOUZrMzU1T0N0Y3NDNXB2aEdpSGN6c0l6MUQxWTdEeVROSnhtMndZaUpF?=
 =?utf-8?B?VjFYSGQ5UHYzSDBBdXUrWjRNMGRJQUFsb1hEeHBwL1NjbzlIZXRPM3daWTIx?=
 =?utf-8?B?anNjYmd1NGNEdmwrMWlDa0NacWhwL2FGYStxLzlNNHRjQThKelRQRDJZblAv?=
 =?utf-8?B?WnBJM2tvOXc2Y3Y4c2lEU2VFQW0zazFUUzNhaUlzb0hXMjkyd285RWhjUWdD?=
 =?utf-8?B?OXlhcUxoYUdSbzM4YjFtd3FlVng0NlphUVZpUkVMemV1RC9QT0tZeWJoZjIw?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac40793-b9be-44d3-3c8d-08da740ef401
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:41:20.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YPDZFtQCdomd5I7fZ5w1Sv2dj3FM7/Y4x4VGT/MSYWztBbm7XGWc0sVib4Zy/qz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2141
X-Proofpoint-ORIG-GUID: PCKjtttNa0wTAFdlB9g27rxJjR_Gha_R
X-Proofpoint-GUID: PCKjtttNa0wTAFdlB9g27rxJjR_Gha_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> Consider a pointer to a type that would normally need acquire / release
> semantics to be safely held. There may be scenarios where such a pointer
> can be safely held without the need to acquire a reference.
> 
> For example, although a PTR_TO_BTF_ID for a rbtree_map node is released
> via bpf_rbtree_add helper, the helper doesn't change the address of the
> node and must be called with the rbtree_map's spinlock held. Since the
> only way to remove a node from the rbtree - bpf_rbtree_remove helper -
> requires the same lock, the newly-added node cannot be removed by a
> concurrently-running program until the lock is released. Therefore it is
> safe to hold a reference to this node until bpf_rbtree_unlock is called.
> 
> This patch introduces a new type flag and associated verifier logic to
> handle such "non-owning" references.
> 
> Currently the only usecase I have is the rbtree example above, so the
> verifier logic is straightforward:
>    * Tag return types of bpf_rbtree_{add,find} with OBJ_NON_OWNING_REF
>      * These both require the rbtree lock to be held to return anything
>      non-NULL
>      * Since ret type for both is PTR_TO_BTF_ID_OR_NULL, if lock is not
>      held and NULL is returned, existing mark_ptr_or_null_reg logic
>      will clear reg type.
>      * So if mark_ptr_or_null_reg logic turns the returned reg into a
>      PTR_TO_BTF_ID | OBJ_NON_OWNING_REF, verifier knows lock is held.
> 
>    * When the lock is released the verifier invalidates any regs holding
>    non owning refs similarly to existing release_reference logic - but no
>    need to clear ref_obj_id as an 'owning' reference was never acquired.
> 
> [ TODO: Currently the invalidation logic in
> clear_rbtree_node_non_owning_refs is not parametrized by map so
> unlocking any rbtree lock will invalidate all non-owning refs ]

probably should be parametrized by 'lock' instead of by 'map'.

> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/linux/bpf.h   |  1 +
>   kernel/bpf/rbtree.c   |  4 +--
>   kernel/bpf/verifier.c | 63 +++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb8c550db0e2..c9c4b4fb019c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -412,6 +412,7 @@ enum bpf_type_flag {
>   	/* Size is known at compile time. */
>   	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>   
> +	OBJ_NON_OWNING_REF	= BIT(11 + BPF_BASE_TYPE_BITS),
>   	__BPF_TYPE_FLAG_MAX,
>   	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>   };
> diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
> index 5b1ab73e164f..34864fc83209 100644
> --- a/kernel/bpf/rbtree.c
> +++ b/kernel/bpf/rbtree.c
> @@ -111,7 +111,7 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, void *, value, void *, cb)
>   const struct bpf_func_proto bpf_rbtree_add_proto = {
>   	.func = bpf_rbtree_add,
>   	.gpl_only = true,
> -	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
>   	.arg1_type = ARG_CONST_MAP_PTR,
>   	.arg2_type = ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
>   	.arg2_btf_id = &bpf_rbtree_btf_ids[0],
> @@ -133,7 +133,7 @@ BPF_CALL_3(bpf_rbtree_find, struct bpf_map *, map, void *, key, void *, cb)
>   const struct bpf_func_proto bpf_rbtree_find_proto = {
>   	.func = bpf_rbtree_find,
>   	.gpl_only = true,
> -	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
>   	.ret_btf_id = &bpf_rbtree_btf_ids[0],
>   	.arg1_type = ARG_CONST_MAP_PTR,
>   	.arg2_type = ARG_ANYTHING,

To prevent race the bpf_rbtree_find/add feels not enough.
bpf_rbtree_alloc_node probably needs it too?
Otherwise after bpf_rbtree_unlock the stashed pointer from alloc
will still be accessible?
May be it's actually ok to access by the prog?
Due to the way preallocated maps work the elements can be use-after-free
within the same map. It's similar to SLAB_TYPESAFE_BY_RCU.
The elements won't be released into global kernel memory while progs are 
looking at them.
It seems to me it's ok to do away without OBJ_NON_OWNING_REF concept.
The prog might have pointers to rbtree elements and they will be
accessible by the prog even after bpf_rbtree_unlock().
This access will be racy, but it's safe.
So just drop this patch?
