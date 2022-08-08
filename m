Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF358C323
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiHHGJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 02:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHHGJp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 02:09:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A810DD
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 23:09:44 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 277NH9AG023860;
        Sun, 7 Aug 2022 23:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=La2oc3LbOpWkbQB9ARqxoPQ6vIx3+C4a6J8BaUmYw5o=;
 b=ggDuofYqmZzClM0U2NuwfYKv3xgrNEhKrBJ7W2WEYa72O2D5Hn9rxHefgJchNNXoGsm0
 GtnIqJm/w+QB5eaByBBtWCZWTixERUpzrWN00tiZAR0CSFA7B2IGLs78lfgWFxbcSDQH
 TkJn4povXbVj8KiAZ6ZQIteAFK4M9d/9IO4= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hskt8qx1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Aug 2022 23:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIJTeCrLLhPUbi6BFZ26zjiWVjJOCWBDzk3ISPZZW1aXpa8qAwt/yixd66DLOvOhyIs80KXr63q/TW2hJAPF1oexNegCVPkI4kQrSJHYZucJjkVACJpZ4ZFMohmKV/Y1THZWc6T/XujRRzcAm66oQ2AMcW5hkVIeGHZUmU6UMghJ9/s9/DO/5qeA71rzHpWrHHyFXK+LiuENC6+Qtr1pfO4YQHrlwhPWJmwlrAt1SMD6DRYxc9EK2bAtZOeDSjA9uQfc57cOQql0BIeIzg4P0SOjY7aBV9lGji2VtnTb9y5GLyOE5hKntz2yBmClazLLz3HkHK3meherPqOwrLo1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La2oc3LbOpWkbQB9ARqxoPQ6vIx3+C4a6J8BaUmYw5o=;
 b=fUCcPm/bEMhXT2C3pISCrKY8POs+sse8IUzk4GGtIn0i0QLcYGwzzLnKWFLDe+hmcAYZcabOvPBB6+K0BdV+nzx3JPOWIxqmtiN0tPATMRSO4ApvVj3bxuSoTiAUPxKM09oNYWkPd4zi2HI0l6IjugpjwUD63xr7BrRgOC66bKTh+ZfE5Lww/MbXCXzKD92SS0Vc+ZL2oJRj0MkROtu9+g2q13WKAAmvKOSeoJH69OJGdHX6Zbsw4jBNs+FWO/5teiASZ2icI4RX7/i5phUBGTVf/mbEaLubcRQPFhCC3/E1ng75dDepSChXQ2C9F6fcJxCc6yzEamicJMhgWCcVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2211.namprd15.prod.outlook.com (2603:10b6:406:8c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Mon, 8 Aug
 2022 06:09:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 06:09:28 +0000
Message-ID: <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com>
Date:   Sun, 7 Aug 2022 23:09:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in
 prealloc_lru_pop
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220806014603.1771-1-memxor@gmail.com>
 <20220806014603.1771-3-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806014603.1771-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc077fd-df69-4ead-e674-08da79048d6c
X-MS-TrafficTypeDiagnostic: BN7PR15MB2211:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mutSO0pUMZ+XuZMdlZjxiDS7FUxvLexpTbJBDuBxgPqnycyoNqhhrQr0HzMIoFlubMIY+2JtEVW1XPlv6N9GQ0yV8/KVYqJcjB7Iq2q3tRyPCkg+WLwTJJwXgcBGol4sRwpojUozoUb1QKHSjS7DE5mIDkOws39hjG5VjDk+EShB5mXtGkERUBrwIZZ+wtjBe9iBEfeYMVd8wLvSwlm80LvcKpNP4skGcBHRC9dMkKBlAPho2xJhgGQY9wbMlOCweLHFOcrFePJvgdQnf/lZdqPUSru+aeacUhLJdz9b7EIwO7zW6NrNiMi1qHbpY8HLSFWXGCYr4Q2YfTnUyIQTuk9uGy/lcEcLtdrscrKRzvmfMgwbe8cjzCIjXRpDzd9ZsuD5NyYD8TYcxJ/EIu/t9Cjynxm5AQ1042aos0zxYcppvD3eyNMQ8UcMmaBg5+/9YjjYSVMcqT8WUfAYsKVzl3Xqt2DavHzs//97wcNTVjHikJnA1HQ1ttBizQ1E80XsQtczxx2xHf6ri9YUt/7fPWUBsWe0D2ZmVHH4YOSU4/NtXD/0xv3YGqR7Mm17jkSN+lrY0PIDy/FesxEq4RKUZ2Nv8lBzp/37WzfPMEsfedhkZyM/BuNTWnL4NyNsWMsOi+cpBo6bsc9QA/ov/t1DLHuSJ/+02qVl8UhAWh8G/0GmgRkoo4djzf8nwjRGk+cFiUzLP7C/9pSjLoD1VRAs5Q3BuBICWM+1AUc7dpN+8r1U105C97HIXoYH1GrJXx1eYv/G+yGevDZSb0qyFDwqhO2sd9E75XCKX8dE7++92dEuX1LMzBa5J6ABKZwSm3UQbOeDBPPtVQ8snnygawZyng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(5660300002)(31686004)(8936002)(66476007)(66556008)(66946007)(6486002)(4326008)(8676002)(36756003)(38100700002)(2906002)(316002)(54906003)(186003)(2616005)(83380400001)(41300700001)(478600001)(53546011)(6512007)(6666004)(31696002)(6506007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGk0NGxoWnBWSU9kSjUrNytjd00wN0piM1hNNTYyZ3J1ZDRnRGFRY2I5M09S?=
 =?utf-8?B?SHgvRnRCU3Joa0NOemd3RTZudkpTeU55SlpFUkw4cm1tMXg1SWgxVHhnY0pR?=
 =?utf-8?B?dU4vRkYrVzlNcTNST0hseEdnRzNUTHB5NW1LTFNMQ1FIVEZKSzlBcm4wN3J4?=
 =?utf-8?B?Q1hBTU9SdFdhSGlsU216OXVESzRuUzBWdk1FMTdjRDIvdGthK1ZvSEpmQVkv?=
 =?utf-8?B?MDNsUUx5bjJhdjltNDZSLzIzdnd4dlJhb25CRjNZRU9oYk5nYmR0d2hCZlda?=
 =?utf-8?B?QWc5ZUxFZm5rMHNoWDBrU1RiMFIyZytNL1oza0REdFdCVVhOUG4zWGs2RERv?=
 =?utf-8?B?eGRZaXloTGpDMlJNUFZKTkpUZXFkVkcxcytua1hzVVE4UjJIUUVSNlBKaThx?=
 =?utf-8?B?T3Bva0hxSnRaSm84MUpqVXNBVURJNjdPajNuYXpRNEU0N0VBb2R4RTNPWFRH?=
 =?utf-8?B?TTZwaThWY01NdGlYd0JCQktuckRzc1M0LzFqWXRab1M3VVlnM2doa2RVeG9U?=
 =?utf-8?B?MlNJZmw0SDQxTTg2NWEyZ05Md0tKWm5DQ2tjKzYxZjB4Nll6L0RXMzh1Z0s4?=
 =?utf-8?B?THQwQVZvbDBsaklSNlIrZmtESStVbEhkbFIxcUN0TnVqQkkyN29SczZidElo?=
 =?utf-8?B?Q1VxL0R2NW53NlJHSEk4M252SUhqdHc3bTc4ZllRMHE3WHdxcmdkc3BuUzlG?=
 =?utf-8?B?NU0rZVZvWWhrTkNiMWt6K1dUVDhXdStES3ZCT240eVc3SjFpK0JYeHFEVytN?=
 =?utf-8?B?RjcrTnFVQVhRQzhuemJiRTdmSWNreE1qNU52V1dvaVVHTVgvYVFMUTZsaFZt?=
 =?utf-8?B?Z245SzZHT2ZFOUY2VkVhOXcycmhoOXNNRkY4WVA4WjBoM2ZHdTRnSDNqdXJF?=
 =?utf-8?B?QVNmeWUzSDNsY1ZxNXBERFdyMmtRT1c1cGdCZG9uM214SEEvNC9Jei81eVp3?=
 =?utf-8?B?SWtyR2dqemJRYmpHL1hKR1JLVklYdXdLUWpiaFZNMmRXUXVWbTZ5dll0Rkxs?=
 =?utf-8?B?VzJPQTFyOWsyekpaU1FudzVoaHFGWTNrWkZ0RmltU1JCQ0tDZEU2L3Y3RFdr?=
 =?utf-8?B?N0ZTck1tLzZzUkpweGE3UjJoR1hGOVlveTBhNG1jdVA3OFhQM0pnWFJqUDFm?=
 =?utf-8?B?S3lHNkxnU1BsUnlLc2xkUy9rWGlyTDYvODFwNG8vV24wb0paeEpMcTYreGIw?=
 =?utf-8?B?eVNaZy84QzUvRFBZVkR2U001eGRkLyttdUM4QU5hbXN3MmFIY0dONGp5aXVF?=
 =?utf-8?B?TlpmajZkZE0xNGdrak1hVGJNWGpnNS85aGhhS3ZySnZURUl4MldFeitXbENY?=
 =?utf-8?B?dDIzQjhuN1JQblpLQnBsS2hFQWRsdkdkekJjU1dINFloc3crSTF4NVNrbGc4?=
 =?utf-8?B?eEY2ODhKSnExSm1WeFRlQ0xSRHFRWDAyK2gzUDBJSElLcUJocXZ5TEVFamlj?=
 =?utf-8?B?TjZrQmhhYkE3MjR6NXF2OUFBVTlXejlJWkZOa1dYcDQ2SnJnMXdjOGVHL0Rx?=
 =?utf-8?B?amw0aXpYazEyNjFqZm0zMUtXeU81Sk1RL2U1aGxoRkhQSWNkMnoxRlNhcmVT?=
 =?utf-8?B?WVUwZXMvV0lGTWQyOTlQYjRFdFdmZy85N0d6T2dURnNKS2RoV29aRDhxSVJy?=
 =?utf-8?B?NWw4RW1RQUJvYStqek5mWUNQV1VSSFZSOTJvZ0xCUjJ2VlpEYWxaYy9TSGlL?=
 =?utf-8?B?Q002SzlMWVBkL0pXTXB1cWdQRURoazNtTVhGWnZGQzFGbEFibExhZ3RUa0g1?=
 =?utf-8?B?bERMQzdmK0FvcGU5MXRCZGdETE9lZjRBTDl6dHlIL0dSV1UwVFVER2duZjRq?=
 =?utf-8?B?cUg0djhRT3pja2xTNWErRUVGbVFXbHBHNjdQbjJyRkNwcmt0b05iaFg5ZTd2?=
 =?utf-8?B?VkJZa1R0TmxiUHFzL1Y4VUlDNElQM2Y0UzVxNHd6YnVLUG8ydVU4a25QRU9N?=
 =?utf-8?B?NUZpNm5rZGU3aXltSmtacUpZSDRZSFR3VFVNbHowWTlsdEZ0UEVqMThXTEpY?=
 =?utf-8?B?dHRxUmg0c3RzYVUzREhjQWVic29ieDZtREd6bkVhM1dFYnRseGtUV2RPNWdx?=
 =?utf-8?B?bEJmSThtQXlQbGVXaEdKS1hrVGxod1BZTWk3cVF3ZmRJYlZEQXQrTWVVenFM?=
 =?utf-8?Q?7GALiUTXToecjvTueQQX3U2kx?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc077fd-df69-4ead-e674-08da79048d6c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 06:09:28.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbpZcbJX6qvN34EQo1I6jx6EXHj6+UsWOwSXUIIn5LmOWMJprjRgnRRFN/UIXCgl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2211
X-Proofpoint-GUID: MDa9PNojpGCeOcL8YXylC0iCOKPIPPhU
X-Proofpoint-ORIG-GUID: MDa9PNojpGCeOcL8YXylC0iCOKPIPPhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_03,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
> The LRU map that is preallocated may have its elements reused while
> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> only check_and_free_fields is appropriate when the element is being
> deleted, as it ensures proper synchronization against concurrent access
> of the map value. After that, we cannot call check_and_init_map_value
> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> they can be concurrently accessed from a BPF program.

If I understand correctly, one lru_node gets freed and pushed to free 
list without doing check_and_free_fields().
If later the same node is used with bpf_map_update_elem() and 
prealloc_lru_pop() is called, then with this patch, 
check_and_init_map_value() is not called, so the new node may contain
leftover values for kptr/timer/spin_lock, could this cause a problem?

To address the above rewrite issue, maybe the solution should be
to push the deleted lru_nodes back to free list only after 
rcu_read_unlock() is done?

> 
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/hashtab.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index da7578426a46..4d793a92301b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -311,12 +311,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
>   	struct htab_elem *l;
>   
>   	if (node) {
> -		u32 key_size = htab->map.key_size;
> -
>   		l = container_of(node, struct htab_elem, lru_node);
> -		memcpy(l->key, key, key_size);
> -		check_and_init_map_value(&htab->map,
> -					 l->key + round_up(key_size, 8));
> +		memcpy(l->key, key, htab->map.key_size);
>   		return l;
>   	}
>   
