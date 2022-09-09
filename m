Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916035B316A
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiIIIOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiIIIN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:13:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4017670
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 01:13:58 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Ml6u0004108;
        Fri, 9 Sep 2022 01:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IyICEuif6UHod25IOrYyAj0H3QlpnXnqGoROUrQ7mKc=;
 b=fVepsH3kUXm83DfOvMDCxjEKhG9RhmZ9O+m7evgFw7tp/XkuGnWp503naOA7inT+lpPb
 FHjUEV3YyMfsFkUMU8M6PXHxUfHu4Avg+gRMtOnj22NiDRYv2MrtVb60e9Kr6+MRJfoM
 UQt9tj3u9yKkb1BWdAtoaPs8Nsa2fVvEqo0= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfk74n69s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 01:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfgRfgEVRNaZieprrMzthzhYjBvIgyorKvA3mc05fInOUc8KYh598wlkU3S0k+5nOiZRknIDSuvo4lhC7hKtXlwlTAhaATBwpjWavsulPjK6kSEwydSmtELMLGpx4yOY0Zn3WWjBuVCG1kFbu2XRIdOJ9QiD+0W+M5iymmjVqZpByaAQGaD3ep9u3B+1pqaXq6GobUcHiS6pe7kYjDyb/Kp5oVOH5OGPlAfSKJ4HGNADqrvySoY1+oUUAgJsa02JzU3ZsRNezDOwMD1wKOtaaS9rIbhaHtmpN4t6luRljxPzppKeCd8RPXYtBhxLuYkUSMIecmisvc5rqCtkJ1qfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyICEuif6UHod25IOrYyAj0H3QlpnXnqGoROUrQ7mKc=;
 b=anH4r7ZtLLFhH8eFc+Tla5smvNyf+pxgsy0yQ1x/83fBsjvB5LYQ2DQacXfHeBBi5MV/mMdHGHv5Ry1ah1DIjOdaJEdvmNXXq59LazL7GZQoQUK6MW/xbbYPLEn4z7LnpGSdVDhZedaJu91NnrmkSrOGCy8XaBCNBHEF444H+GcqvnF4UTG1U3EQJIBDw5F90lzNQjSMNS5c+soD/u2oVLHqvC6H9FmNMj7I4RNdu3HdiuLpVNPn63bLHKew0hwACB/RXu9ziAPh9JhWJgyOuF36N4PME36N64E25esG4v4h6tMLDuuSAYTg938krINPXIPyaCzk5/zfNGqillOyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ0PR15MB4389.namprd15.prod.outlook.com (2603:10b6:a03:35a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 08:13:41 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 08:13:41 +0000
Message-ID: <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
Date:   Fri, 9 Sep 2022 04:13:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-22-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220904204145.3089-22-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a761d74d-7273-4d17-3e15-08da923b34bc
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4389:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itCscLFcnniEG/idQaSzuCeNAjvZ7GMcbbcYYIcClDpw6Hv8eIr5sEk26Q2D7+QwkhmZoqNPU7+UIsdBhv9PkQu4JZ8rAnCQ3UrQyj85bAo5umitB2pI5rNMYpzrIupRBkXZ4ZJAYr5qczFwwTR/oyBJRcfP8ze/kDXTY+R+YHmBfKItrNp48WwZV6R/2BAIeAiRltDp2z1PfLmOFYBoiSNjGdbCCtBx1BvwtfD5ZaUo5D+2pYP7dL2w1dorIaUmekozk89zs8k8ITpBI5MuqkxuV1TcKP1lx7mWiJZ734LxjS7cGGyPhfhhpS+j0TWv/0cqXVYBHhXckyAv45nM6TwIY3TJn1ZsAUhAvq1tl2KE1bBG9/93CVX2yuGpKeMpl743E0Dwt/c+SbLPGXKp75UL4n7jmiJ7YmtjctG7cdBh2PWFnA9PGyslOsIRyzg8S4v6dQezSZQujRETWo5JXJIIrlh1miQK0vozl2yontYUbj1FMlKMYQE89YblEQWMYvYK4WjtS7w14zsyclWd1+ZJny9EdOzXM+jG8vneh2BPV0iimuyjek3JELJTiXWm8DMYn+lXkv4c7OZ+Zbrv+Wxu2R++Knun3y8+O0Ns36b8bKW46H6OgXUJVCNTjnVbv9LaA50liGjlecW5qQz6WkWZ3DJi4Dm5r7tby5dDl8R2n5hYx4YscnRyRexEUxwCxCcgrnAdreTTsonoIg0tAMpPCnJ74RdxgQh+cCqbW4jEo9/IbzLI+sQRTyNKjLexJC6gfKIpb378vxj83CR6h2AR9/XFHVnU+OGEHjZt1BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(36756003)(53546011)(6512007)(31686004)(5660300002)(66556008)(66476007)(66946007)(8936002)(4326008)(2906002)(38100700002)(54906003)(6506007)(8676002)(31696002)(83380400001)(86362001)(6486002)(186003)(2616005)(316002)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWI2WWlibjE3djBDdHM3UzNCeVJHUndQazZmL295aVBkcUtZY3ZBd2FDN2JD?=
 =?utf-8?B?dEpTZXZTVE0zU1FuenBIUUpLODJjSHNETGJiMzl5ZFNGM2M2c1dQVkVuVVFH?=
 =?utf-8?B?RU1ZdkdweHlzOFlhK1BSRVRraWg1YkJXUkUzbGxnYWZJeHNaaXEzS2xKVE9J?=
 =?utf-8?B?TWQwUU1Ecyt0WEtZNWNVQmVoVEUyb2JTRlJIQmh5dUI3NElGRnREVnc3dlU2?=
 =?utf-8?B?VjNxeXloTlBabDNrcjB2NzRkVnorM1grUDhEMHRZOEU5Y2RHWlQ1ZmVjVkVw?=
 =?utf-8?B?ckZxcWhBR0VaN1g5TEN1RXIrdEc5Zmt2TkRjQTVOblUySU9IZXBFT1dpNHVJ?=
 =?utf-8?B?V2s2UGYvem0vN25aeHYrKytUaVpJR0g1TFB3YkxMREZsMmNSK3JOOEZzbjN2?=
 =?utf-8?B?UklVWVFTcW1FaTdwV2lNT0hUZi9HYWxNU2xxVm1lZSt1aU5mcUFuWXNxYUtT?=
 =?utf-8?B?N2ltTm5CRDRUNWVmYTNWemNRZTdrb3VFZnpDQUNyQzEvYlhPUFRHaHJDakpU?=
 =?utf-8?B?bTVOcjEyOTE3Tm83a210S3BVOVNGUm9odmJCV2FwaGJpN2JpYnVLUnJRUTlK?=
 =?utf-8?B?aHB4Szd0MnFkZmN0dFpsVEFVYmNUU1FOWmd5Y3krV1IyTTRWTzFhYXlWbER2?=
 =?utf-8?B?ajV2NWQ5N0E0NW43eEFadkx5OXk0MW1uNXBkR0ZSMXl6UEJ1bnQ4R0pwTUdn?=
 =?utf-8?B?dVI2OExpUVZ0TVd2aGJIQ0ROVWZES0JqdU9ZZ1h5cHp2dlh0VHY1clBkMnA1?=
 =?utf-8?B?VGRUV3lTSlNrV2ZxMTJUd1RLdXBlSUgzdWMxYnN5UmFzNzQ0aEx1S3RhSHVL?=
 =?utf-8?B?NXZYZVJ1am5LZExUbW1oaVBaNXQvcXRscG9ScDZMOVFhcVNrakN3dW5wL2Z3?=
 =?utf-8?B?RERad2d4V1lpQnh4QXRLdGxRMVkyV3NQNk5BRWxKaG5sc1R0cmwrOGZVUUVi?=
 =?utf-8?B?dGZuSm82TFhMb1FTcHZHUkhIWEF4Z041UERZSDNpN0RCZGlVK2NiZlJ5SzFa?=
 =?utf-8?B?T3N5N2VwSWtHbHNhWVdnMXphN2J5bXJibDdGbXg1WmhZa1ova2plTmFibWhL?=
 =?utf-8?B?ei9OdGJaNi8zU0JvRDJXMFBtRzRLRFhxTXI0Y2lZaldyaG5EQkF1alpoTEN6?=
 =?utf-8?B?MUE0bkpmaGxLbktNSXJrMXhtaDVrZ3QyYm0vaUZKemVBSnJqSHhoRFgwOWd5?=
 =?utf-8?B?L2NUVHlUTXl4WnM2SlFKMnltOWpna01YenhrbVpWOGZFd2hEeWZsZHEzaG50?=
 =?utf-8?B?cTFIaWNoVzRkdmxJYzUzQ3Q4T1RDdXhJNkg3MW94bGFBTEtXNTRQVnVmamFi?=
 =?utf-8?B?aTFJOVdvemxvd29YdFNzMS9Ha2ZicUErU0taWUhHOVZLQmJ2MnRYcGVUeVBW?=
 =?utf-8?B?bkcrWUVDc3NQVnl6cXR6dFN6bWMwcFpZajlnL05mREN3TmRUTUtaR00wamZB?=
 =?utf-8?B?THJTSFZXSnhxQS9DeW5OYmovTEZsT3lIL2FtVm5DdHFsNjFpQitCalpSdlFw?=
 =?utf-8?B?eHNWUlc5MFIxLzgvMDBtcTQ5bzIrUUtvNHkzeUwyakxyRFNsMkpoYXZHai91?=
 =?utf-8?B?YXI0cFoxUUlrREt3Y2F4Njh2YXpCdGhyU1J0dGt1QnBIdlV6Um5kTjZDeDd5?=
 =?utf-8?B?Wjd1a1FleklQNzV1MVpPQ0JwUTJtMU9BZW01TFdJRVg2bVcvVXkxWnRIWjZT?=
 =?utf-8?B?RWJYOVNyNEFRWlVzRlZLUHpqK2w2OWZhVmFJUkFKZjhBMlo0MUxVVlNNallR?=
 =?utf-8?B?QzU3dXhHY2hvRkc1YjROTDdCcGM2aWRiTmhDeTZJQW1qeStBNDhzMzZWRVN6?=
 =?utf-8?B?WUNEYlhIbU9LZUV0ZWVpSkJYVEVTenFObmg0elNSMVYyblZXWHpxMXNWM3Vj?=
 =?utf-8?B?WHJUeERjNlFZNmo4MlJpSG1LWkFtSVJqN0Z0a29SM1lTSG1Kb2V2Z3Z6dnM2?=
 =?utf-8?B?L3VpSjI2cFl0L1Z0cnAvZnM2elNEZTBEb1hmOG1wVWpNZk9mUG53bktaMU4w?=
 =?utf-8?B?VkFlT2U3VmxzQ0RaQzcxdmZFS1NqTmE5SjB1WDM3S2lkdGdzNnF0NXBPZExN?=
 =?utf-8?B?Q2c5ZGNtTFcveW9qcFFvMjd5STFhT3FEWUp6TVpYTy9NZGxpMXVLYURJQlJL?=
 =?utf-8?B?dnliYXZ1MmlzTGo2SmV2YmxaTmpiUVR3MW1tbEFNL2NVOURjbURQUDd4bW9r?=
 =?utf-8?Q?c9AlkA6YpQtocaHMwcdJA9w=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a761d74d-7273-4d17-3e15-08da923b34bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 08:13:41.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+4JUF3qMuuAJ/orzOSPpsUriQllOZFlmH4J3ZZUn+Y4iLhLLrL7yn1ZD3bO2NKp2/GphUWVPspXfa+/FwerYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4389
X-Proofpoint-ORIG-GUID: SsZ4YcZgPN6mS05ORjGp25_BCf--TWs7
X-Proofpoint-GUID: SsZ4YcZgPN6mS05ORjGp25_BCf--TWs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> Global variables reside in maps accessible using direct_value_addr
> callbacks, so giving each load instruction's rewrite a unique reg->id
> disallows us from holding locks which are global.
> 
> This is not great, so refactor the active_spin_lock into two separate
> fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> enough to allow it for global variables, map lookups, and local kptr
> registers at the same time.
> 
> Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> reg->map_ptr or reg->btf pointer of the register used for locking spin
> lock. But the active_spin_lock_id also needs to be compared to ensure
> whether bpf_spin_unlock is for the same register.
> 
> Next, pseudo load instructions are not given a unique reg->id, as they
> are doing lookup for the same map value (max_entries is never greater
> than 1).
> 

For libbpf-style "internal maps" - like .bss.private further in this series -
all the SEC(".bss.private") vars are globbed together into one map_value. e.g.

  struct bpf_spin_lock lock1 SEC(".bss.private");
  struct bpf_spin_lock lock2 SEC(".bss.private");
  ...
  spin_lock(&lock1);
  ...
  spin_lock(&lock2);

will result in same map but different offsets for the direct read (and different
aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).

> Essentially, we consider that the tuple of (active_spin_lock_ptr,
> active_spin_lock_id) will always be unique for any kind of argument to
> bpf_spin_{lock,unlock}.
> 
> Note that this can be extended in the future to also remember offset
> used for locking, so that we can introduce multiple bpf_spin_lock fields
> in the same allocation.
> 

In light of the above the "multiple spin locks in same map_value"
is probably needed for the common case, probably similar enough to
"same allocation" logic.

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2a9dcefca3b6..00c21ad6f61c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -348,7 +348,8 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	u32 active_spin_lock;
> +	void *active_spin_lock_ptr;
> +	u32 active_spin_lock_id;

It would be good to make this "(lock_ptr, lock_id) is identifier for lock"
concept more concrete by grouping these fields in a struct w/ type enum + union,
or something similar. Will make it more obvious that they should be used / set
together.

But if you'd prefer to keep it as two fields, active_spin_lock_ptr is a
confusing name. In the future with no context as to what that field is, I'd
assume that it holds a pointer to a spin_lock instead of a "spin lock identity
pointer".

>  	bool speculative;
>  
>  	/* first and last insn idx of this verifier state */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b1754fd69f7d..ed19e4036b0a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1202,7 +1202,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>  	}
>  	dst_state->speculative = src->speculative;
>  	dst_state->curframe = src->curframe;
> -	dst_state->active_spin_lock = src->active_spin_lock;
> +	dst_state->active_spin_lock_ptr = src->active_spin_lock_ptr;
> +	dst_state->active_spin_lock_id = src->active_spin_lock_id;
>  	dst_state->branches = src->branches;
>  	dst_state->parent = src->parent;
>  	dst_state->first_insn_idx = src->first_insn_idx;
> @@ -5504,22 +5505,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  		return -EINVAL;
>  	}
>  	if (is_lock) {
> -		if (cur->active_spin_lock) {
> +		if (cur->active_spin_lock_ptr) {
>  			verbose(env,
>  				"Locking two bpf_spin_locks are not allowed\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = reg->id;
> +		if (map)
> +			cur->active_spin_lock_ptr = map;
> +		else
> +			cur->active_spin_lock_ptr = btf;
> +		cur->active_spin_lock_id = reg->id;
>  	} else {
> -		if (!cur->active_spin_lock) {
> +		void *ptr;
> +
> +		if (map)
> +			ptr = map;
> +		else
> +			ptr = btf;
> +
> +		if (!cur->active_spin_lock_ptr) {
>  			verbose(env, "bpf_spin_unlock without taking a lock\n");
>  			return -EINVAL;
>  		}
> -		if (cur->active_spin_lock != reg->id) {
> +		if (cur->active_spin_lock_ptr != ptr ||
> +		    cur->active_spin_lock_id != reg->id) {
>  			verbose(env, "bpf_spin_unlock of different lock\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = 0;
> +		cur->active_spin_lock_ptr = NULL;
> +		cur->active_spin_lock_id = 0;
>  	}
>  	return 0;
>  }
> @@ -11207,8 +11221,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
>  		dst_reg->type = PTR_TO_MAP_VALUE;
>  		dst_reg->off = aux->map_off;

Here's where check_ld_imm uses aux->map_off.

> -		if (map_value_has_spin_lock(map))
> -			dst_reg->id = ++env->id_gen;
> +		WARN_ON_ONCE(map->max_entries != 1);
> +		/* We want reg->id to be same (0) as map_value is not distinct */
>  	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
>  		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
>  		dst_reg->type = CONST_PTR_TO_MAP;
> @@ -11286,7 +11300,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return err;
>  	}
>  
> -	if (env->cur_state->active_spin_lock) {
> +	if (env->cur_state->active_spin_lock_ptr) {
>  		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
>  		return -EINVAL;
>  	}
> @@ -12566,7 +12580,8 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	if (old->speculative && !cur->speculative)
>  		return false;
>  
> -	if (old->active_spin_lock != cur->active_spin_lock)
> +	if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
> +	    old->active_spin_lock_id != cur->active_spin_lock_id)
>  		return false;
>  
>  	/* for states to be equal callsites have to be the same
> @@ -13213,7 +13228,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock &&
> +				if (env->cur_state->active_spin_lock_ptr &&
>  				    (insn->src_reg == BPF_PSEUDO_CALL ||
>  				     insn->imm != BPF_FUNC_spin_unlock)) {
>  					verbose(env, "function calls are not allowed while holding a lock\n");
> @@ -13250,7 +13265,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock) {
> +				if (env->cur_state->active_spin_lock_ptr) {
>  					verbose(env, "bpf_spin_unlock is missing\n");
>  					return -EINVAL;
>  				}
