Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A158CAD3
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiHHOzq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbiHHOzj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:55:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E962BE4
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:55:38 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ClBsr014677;
        Mon, 8 Aug 2022 07:55:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bwdhg/DUDaS86dD7jGCPrATrLkB4CXgM3XdQjE8Fhz0=;
 b=MrZ3kJmgffpUCWE4KvH2STb4jAwWmb8E11YiJIjdI51SpQp4Qlc8ek9iI5Rz2X0eVZzL
 ubSnllQxsQN90czAlefx1GhvZMdNb8iGkcwzL/Ae27lYoZFt13HzfIG99wTK/k/ylGwF
 8Hs/MwqTaB0TW8YAU0c8VkogezeRkTabxow= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsnty23vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 07:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOhuVaax2qI5eqJFJ0J/deMGLnBeBQz9+1wTz4Rx/A/gAHx9f7Qk4pE2k77s964ZLsEv9x7N/xrpWfhgoRQ8lype9IX4b2r0vrYGig/+LIiZqBa+BU37gx8HL38En6viB9evp4rsGI1ei+yG13wIE+KWGX8HBJ6XDAjPJbo564++BfqsaLvrxuakcGlucVGNmVFqBupn3N/ul5w8SQyjzqZ4fZ4wVldI53nHSByGOKfYr56s5xpGX9mm3VN0HDOrsBNAiS3a/uOCStJz9NUL/fzquH+4iz3DeWbQ7sPgC9uKOMe2WK8nD35onoNNwutVkR2Naa7frE32gfHVtY/fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwdhg/DUDaS86dD7jGCPrATrLkB4CXgM3XdQjE8Fhz0=;
 b=AcvKpCpSffNF402/qnNuJdQcqUgUhSWHNSs9kt1so+ynI1HFurN8dq2GboetvWK/cHM5tMg+uSrgGaCajYGp2EKkT6cJVu0L2yX0CNve7lxkXXmsGSieeMqT/y5G+motyLNfiEf9+N3mASF8cmMqPOltVQgkFNZ1N0pp+WOsLCkvrLB8TWm69bQy8ry0+z8LElmS/CmiuS8tXUUtFRc8N/Lih0SXLbkWrbSIfMliZaGG/4lLd+w1sA3snYTJSca7hfiIOzm1ei82UjYrLZ4jKAzY2jt7aC48T+WyQDBgCIGEk4pio/enAg4gadYQB6WJR10vWv3EOHxh5CKgpbIFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2333.namprd15.prod.outlook.com (2603:10b6:805:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 14:55:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 14:55:02 +0000
Message-ID: <79fe59bb-da81-140a-8ffe-d6c9874ca33e@fb.com>
Date:   Mon, 8 Aug 2022 07:54:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 3/9] bpf: Acquire map uref in .init_seq_private for
 sock local storage map iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-4-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21742114-3935-474d-551f-08da794df912
X-MS-TrafficTypeDiagnostic: SN6PR15MB2333:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6gEBjgznAV4GUhT2iOxQfs//B/Eh9ZIzaQD0y+l6Tvt/S916+oUsLhOAvE6GuxWXcUktSIMN1y80i/Srs7+W1QA54hRNUMf2uYc+it89HhbcDlzBnNdIaLe1Hvom+h8eM95120qmVPnjVwUhXZi4h/Vi2PZdMzvXmxtgVvxzaCCXH1nagU7/CuTKSXfCIwDbmVpIUwBpNQdUU6qzqSGlE7H9vlDn1EGqUa0sUVuPWWZeayquVYH9hQQrlZ2eT1QV0Eyl5qEcu0xxLw3Bit9vkayEDSKgeQP8h7CertWTEXQ5CtqhANZimOtt0PnApIXR0X1XPZC1gSe5Ri81skVi6lljAQqKgvJxrZy1JN32A0q5+cOHCLqR48CtryOR4APcAiwCjvKSkhbGL37Ed9UtRcUOeMEfMKZz77FP43mubu/pX1QISJubp5nAsQyVOwoOqW7sY+gSMjBCCXUI1Y8dEDsfQ+uFp80p2BBXKLQY8tyUPjhV5Q7lXKLRB6IBxY9577Svb10m1Z7AKEcL30OdDKzFn6qptFJcO4bW9VXz82P7RrfkgIAymk4PBt6vLd1iQmBocaJm9JY8aGy8Xo+zeZZyCphnxLn1NZP1d1tStdR7LogYAvudp4nq5b/06Ha1F+LJUk2L5FvSvuwf9dfUxPmH6izlh4sb+38au0VfrAddoN9Haj8JAUkejBjqE+LUJAP/jDzLGsvo91Mv+HBnvQuQIbIf95eqjhIZDOisaU3pQEyWtFVoCPxlriAV1AiqH60MiCE9ONsdh8gkaM8VIfbdiF1zqGULs2wFFlGCPFinSsq++qcwVZQ73C8keeOE2DAArnJ0PjJRyGKXkEPd7pOZ44W5I11Le+i4M6Upxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(316002)(41300700001)(36756003)(54906003)(31686004)(53546011)(6506007)(83380400001)(38100700002)(2906002)(6512007)(5660300002)(86362001)(2616005)(66476007)(4326008)(8676002)(66946007)(31696002)(8936002)(66556008)(7416002)(6666004)(6486002)(186003)(478600001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azUrZExuNGNZUXNWU3VYUlh4NUZ4cUFSbTU0K0FvVjJ3eTVWbS8vL2YrUDBK?=
 =?utf-8?B?cVJXa1RmVUx3SHdBQ0NPK3Z1cE5LTENOQkx3MlNRZ0UvYXFGbUZJSjVUdWVN?=
 =?utf-8?B?amlJMitxdWpEOGlRZHdkckcydGNPQmpuMHNyNS9aaVVaZEtHcGhVbWdxTHcw?=
 =?utf-8?B?Z3RHSThCYTV1cStxOUMvMjFhY0NNaVhxT0l0WVpVZTV0azlONzBCM3NrcXV2?=
 =?utf-8?B?YkM3ZzVOY01JVnFYa2QveGZQOFVoN1J6Mzdja2R6bHZZbkluVXkwSTg5aDgx?=
 =?utf-8?B?amdxYUV1SjMrWHJBU0xBTW9oRFJDbmwzWWtLT1g2QlQ5OVpPZHdYUTVjSjR6?=
 =?utf-8?B?OG1BN2xXUmhQZU56NTF3c0hBa1BuWW1NY1JMREJ5VFBRZFZvSGZqNEFjSit1?=
 =?utf-8?B?L0ZDSkp6QW04WUVOUkhOUGhJeUdQRzJaMStUcDZ0dmc1WGhHN1QrM2NzM24r?=
 =?utf-8?B?Mzh5Snh5VUNrMDBEdTdGV0VwRWVNZ2NjakoxNkhOdmdNeEtRMHNXZ3lDa0Nh?=
 =?utf-8?B?ODg2NkhKOGhXallKVm5Fbm5kR3JyKzJWWFdjNXFKS2c5TXpjd2xRa2NmS2Jw?=
 =?utf-8?B?M3l3bUpDL3Z3YXMwQnc1L3pBbUVxOWVsTnJKNHRaaFdhRXN4cHRoV2xHZnox?=
 =?utf-8?B?Z0w3QmxYZTByWU5wTy9jTHp2eVpLcC8xbjBZZ09Vc3ZvQnlFTTI1NjV5bDlP?=
 =?utf-8?B?V0p1MzlkcndTSTkydlpqNXJhRE5zZGxManBhUExNV2hUQ24rMFdJa2FnRjI0?=
 =?utf-8?B?Q29LV0ptWElTaTN1TzVXUUlEM2tYZHZMZENuaDdUV2hNNm9SdXU5NDkzalpr?=
 =?utf-8?B?RGtSL0U1RGVTV2M3djkxMnBsb2VzUHpyM0lIVkplS3VYbExKVmxST3MzZDFo?=
 =?utf-8?B?ams3ZVVRSWZ2QTZoMkdtVE8yWEZ6RTNCdUZGU05xUDJIaC9JWDVYTGVIVnBw?=
 =?utf-8?B?OTRyeDlGZllEUWtWRnBQVkFBeXA4b01hTEFvRzhUSENPV2NWWXFmdXE3MW81?=
 =?utf-8?B?K2lqck1VSUErT2lDbXhGaUVnZDl6MHp0SFRTQnkweENPSWVTTWNWQ2FXQkxt?=
 =?utf-8?B?clJuSGxPN00vQWdlbzFSZFhtUWR3L1RQSitrYkx4Vmo3MWM5U1QrdjVETXNn?=
 =?utf-8?B?UzgyTmk5em5OL3F4NW56eDBOM09KKzkxUjhKMUM0K1NESGN0N0duZU1VYWNz?=
 =?utf-8?B?dzNNdjQ1MTVGZ0pyc0FHamhsRStmS2tEb1YycUJTbXJVaVFkTFZUWHNiVjBE?=
 =?utf-8?B?a0RIVUk0bERkNWQ4bVB6VFhLMG53VVF2Nm9IM0xkTVQ5NElzMDIxVXdrNHNX?=
 =?utf-8?B?T21ia0RFT1RaVFluWEtYWXRYczhPb3J2TnFrT05iV2FxZk9wNFU5ZGNzZDNO?=
 =?utf-8?B?Zk9qMHVJb0VRSXE5M0IxQllEdFI1Q1gzQmJSY2t4TWtKOEU5MEo4N3dxT3hq?=
 =?utf-8?B?SVRtK3hULzBVRTN0dDFOaWttNDNFd2g0WXlvTkJRVnN0c2x3UWprMG5DN0lx?=
 =?utf-8?B?SUNJb1JDeTRlVmxEN2JubFlSMW1uNGFseFhhdVk2dGJCVnFkT0pMbk5tOXFH?=
 =?utf-8?B?VndCWVV6YUdRdjBub1UzaE9JVHN5ZHYwaUFtZjQ1ZlBBSWZjdDRNTThMejhl?=
 =?utf-8?B?dGt6ZmdBWWNJNGVtK3hYNzR0d0NvYlBxdXc2ZnpxWEpzMi9zTlUrck5BZkpj?=
 =?utf-8?B?UmhDVUdBTzRwME4xLzAzU0RzWEhPZkIyUnZxSnYzSjAwWVpQeFdnZ2dkQVN5?=
 =?utf-8?B?OVlQUjBXWkhkcUpEVU9NcE0yTjBqUUNqRTY0SmZPUkFOOHpIMENtQVh2TnpO?=
 =?utf-8?B?aUhoYTRnM1o5YXBNcVQyd2QyWnlkMVlrT2Z3TjQzd1FpcWZUTnIvMk8wUjdq?=
 =?utf-8?B?TzRROFU1V2hYNlFLVXBCeXdSQ0J3L3ZZNC80eGlDbUtGVm9zUUYwV0IrUGNI?=
 =?utf-8?B?UlRnY1lncSsxc2JHYUY2dkMxMnlxaVBPSllrajlSMHU5bTBXZDdoOVdxOVYy?=
 =?utf-8?B?TzJVQWd5MkYzZjZhUThLeW9vUlZHQWdFQXYxb3dVZjIzZUhJN251U29mSjhQ?=
 =?utf-8?B?aVRXelNGaGY2NHF2Snd4WXZxbStuK2I4VC9qb0lXT3E3WWdBKzNtUnJkdFFZ?=
 =?utf-8?B?WTJzR1pKblNwMEFPUnl5djJmbkZ5d2IwdVlhMFlvbGJ2MFZvQU9wZGduaXFw?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21742114-3935-474d-551f-08da794df912
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:55:02.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdz+E8FNCNDxfPWmRJ+E1xEKLrCTigvOgt5btFydPFUXqBgGaP9WIL8+tvtPrd2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2333
X-Proofpoint-GUID: _KnjIrYXuPmknOPLkxVMMolnm7GrbkXw
X-Proofpoint-ORIG-GUID: _KnjIrYXuPmknOPLkxVMMolnm7GrbkXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
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



On 8/6/22 12:40 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> During bpf(BPF_LINK_CREATE) for BPF_TRACE_ITER, bpf_iter_attach_map()
> has already acquired a map uref, but the uref may be released
> by bpf_link_release() during th reading of map iterator.
> 
> So acquiring an extra map uref in bpf_iter_init_sk_storage_map() and
> releasing it in bpf_iter_fini_sk_storage_map().
> 
> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

See my previous reply for some wording issue.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   net/core/bpf_sk_storage.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index a25ec93729b9..83b89ba824d7 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -875,10 +875,18 @@ static int bpf_iter_init_sk_storage_map(void *priv_data,
>   {
>   	struct bpf_iter_seq_sk_storage_map_info *seq_info = priv_data;
>   
> +	bpf_map_inc_with_uref(aux->map);
>   	seq_info->map = aux->map;
>   	return 0;
>   }
>   
> +static void bpf_iter_fini_sk_storage_map(void *priv_data)
> +{
> +	struct bpf_iter_seq_sk_storage_map_info *seq_info = priv_data;
> +
> +	bpf_map_put_with_uref(seq_info->map);
> +}
> +
>   static int bpf_iter_attach_map(struct bpf_prog *prog,
>   			       union bpf_iter_link_info *linfo,
>   			       struct bpf_iter_aux_info *aux)
> @@ -924,7 +932,7 @@ static const struct seq_operations bpf_sk_storage_map_seq_ops = {
>   static const struct bpf_iter_seq_info iter_seq_info = {
>   	.seq_ops		= &bpf_sk_storage_map_seq_ops,
>   	.init_seq_private	= bpf_iter_init_sk_storage_map,
> -	.fini_seq_private	= NULL,
> +	.fini_seq_private	= bpf_iter_fini_sk_storage_map,
>   	.seq_priv_size		= sizeof(struct bpf_iter_seq_sk_storage_map_info),
>   };
>   
