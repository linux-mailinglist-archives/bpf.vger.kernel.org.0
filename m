Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA258CAD4
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiHHO4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiHHO4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:56:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2DDEB2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:56:31 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278Cl6So014462;
        Mon, 8 Aug 2022 07:55:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zOeaEvcXW5VP1T6iB+b5F07mMIejJmAOSE8P/9jcmZo=;
 b=itklXPPECAAYft6Kj+ekwkothxgAc4TNmdnyuv3o6/cVb6WMrxbI0vgWRTBylhuh4+j2
 TQmKqI92NDLbD4qou6NSJ1q32JB4b3V/5/vmmbbRfgh4bLRSABSOcQwif2FD/sWeVrKJ
 V5jysuBB8Doigw0cy9ZZ2phUVidpP29cgck= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsnty240h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 07:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iga4dsl3NbgoFYx5FpGqCCRgixZXa30Mjc/noE+ifjr7A3ab5BKKLgT2Cs8T4oTY+x4j2QMBMPpzSd8xTlSQfG1GlpPjdhJko45NzyNr78PauEWYLtrJgZZYTAWm66chrF0OHXptSaKXoBp9nFMsk3mwKfpSn34oEQkxjv/76AJWPz9PUEKrdRNhuOxHmPFM3ymo7Q5Esikt1J9mwLBRb5u9oKJpFZ1IVmgtkfHolL8rB58e6UV+orhgyiiNQbCLSOm2QVuwTPBdckIRvqwyxl92/AqtbDkXAQ1RDCA6Xv1sh8Dbjr7SJVjctbjp7Wc3uh3R7ispcOUt5ofDnDDEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOeaEvcXW5VP1T6iB+b5F07mMIejJmAOSE8P/9jcmZo=;
 b=OEUefOZaBg09emiQu1j5HW/IZqJEnN3wuboe28zTDYWlBLkP4G1LrEUy+rRljhf8dKBADt2ZA1WJxV0mn0sWV6qeqrJ4T9gsuM4GGGPe8bLptoBPe1j/DZf/LIOgQuC+tme9DSB9ulDtSK/06SupCZPnyxYt9mRCRHprJGEziieQVt+QPERFXo0VQKMQ7EY0ZrseFL5MWmq4V93koDOlMGrXJXs7y32oOECqwwO4j5t5HxSCIPn+vyup/mm4quSWtwF5/AgTGwegaNK2gtKXrIwp3dpOFWmtcvAaBrAVpkAqEJTKafJZEBT9hq2xGvlqUQXpQ37wIunI5AAU32ExJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4055.namprd15.prod.outlook.com (2603:10b6:5:2be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 14:55:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 14:55:39 +0000
Message-ID: <59e05fab-1c08-d232-9123-c549ab2eb4dd@fb.com>
Date:   Mon, 8 Aug 2022 07:55:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 4/9] bpf: Acquire map uref in .init_seq_private for
 sock{map,hash} iterator
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
 <20220806074019.2756957-5-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b544e40-804c-4cdf-e1d1-08da794e0ee8
X-MS-TrafficTypeDiagnostic: DM6PR15MB4055:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqbv62kxF5cs6Oh0EC5Y2Zg/NUyr9Tljyba6Uor8Yy8wzfH9Eu4TCnHewe2t+s34+z7q+rQDpnsvTC3cma5UF95bbqpAj0HmUoKIdNxkCCQ2uHL9Vfkt+9u9ZfuI1gbF9v7CsoYREWeINXQM4W4g0hSNnti4/B5K4+91Qqufe14Jihdi0u8WXD0KGjBvhgkgNUj8HNsyqShEGmXk6+WUAkOjgiLxPGRTbZHbiv1WGTJYnMyvHontMR6pmmL2ie5076it+LESbFJQcJ5MGVReUSyUB8u4Qfz73ZYNYn+MvU2aS/KgBFLfAaU7VWoUeEudPERm4FcjHLb/gfn3dgs4fO2CZ0bb1ySkPzueYDAXVjTohjn72ZNOdX+nqrQUmbaOkqB82qs8liJWnKsijOIdEVeqBltXWMWfCPQcH1ESPWo/i4/lHWhQzfSBbgdhkXFmQA6bomfVgYgUE9yNHXphm8turhm1xXNpJe6V0rtENS/GN1vsMkytAFm+WUGL/jC5s1a+voW4FFKAJnkyafBK9tvfbuw5tJUo+u1hlddTrULPiYGNrExsDWdGauV2rYNa5C1c8YdihEfCcrFGm6HdSNGFXWCSJZk5U8MrwIpRdxM4HZEhbP76eVNuXFFqyBaqA4V3sLnV5loc1Djy1a8NvCP/xduICeXZ5AEYxpjO11IWvo0gfmqeb9tvA/RwMW43CrgE9zZhcTvqlnva7L7vaGf8JM3nilgrhhweynv+zlwWM/BPYWTpGDImICZqorhW9Ac82tGh7ADFqd1lHjf2REbASJxnOCNquYqW3Al347e80998aBK+mMvgqT7hOXZnAH/x2tow25ZK5kI3PperQSLszAh7g5NOFeE8KnncIKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(41300700001)(6512007)(31696002)(86362001)(6666004)(53546011)(6506007)(38100700002)(83380400001)(2616005)(186003)(66476007)(4326008)(8676002)(66556008)(36756003)(7416002)(5660300002)(2906002)(31686004)(66946007)(8936002)(6486002)(478600001)(54906003)(316002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktHdVRzc3dBOGd4VC9aazJQNDlDWTVveTJDOEtiNkVpYWVpYnRGK0tYa040?=
 =?utf-8?B?UXpjY0pFcGdObHNuT2dOVnBLWFpZcXlHSDQvRk1xT3ZmdERYWjlxRzRqNnc0?=
 =?utf-8?B?R2V5dWZIUzZRRmtSMVRBT3NCQzd6U0hZWXQvRk5ZVEMzUFNnbFBuV0dzWURX?=
 =?utf-8?B?aFR1MjlaUzFJV1BDaUFPSWthL0J6QkR1dXdFU2ZRNWJFYlFndm9vbG5KZzdz?=
 =?utf-8?B?TlRubStZVjM4bXNwYmN0SHFGR0FZSzJ5anNRcVNkYkhYblJxVGdmWlN0QnFI?=
 =?utf-8?B?VHBQZ2xwcGQraHVlVytNWDNSeUtCYUdvZHZkVW9Hejgwei83TGhseklldkl6?=
 =?utf-8?B?dGE4U294Wmo1ME9HR3hNR2diK3VHV0p1b3lrdGwySW1OOFRyejNGQlpUNHVo?=
 =?utf-8?B?YWx6QytqL2xHVnhURStLd2tPWmJzOFB5T21Ham1Ic3ArV1JvRWp1REljTkgy?=
 =?utf-8?B?bE9DdE1lS0w5VDNlSy83R3hDTm9uYlhFV3FaM3Z1bThmTmRUc2JLaVVQWFJV?=
 =?utf-8?B?Z3hQVUlxVENwRWpHTUdFK3F5Y3VLVGZ1djc2WGlBS21yQU9ZSnFIZGpSMDJj?=
 =?utf-8?B?SXl0Y3NoNm5SN1BHckdLemdkR0xSaUZMMnM2MU82VVVneWUyRG56ZCtYb2I5?=
 =?utf-8?B?cWtwZXhtZEdNbVdhcEtNeEdYWGphbVZWck5xclB3TUdlNWl4QWNCaEpvTVh3?=
 =?utf-8?B?bUdIc2tGanVDeGdmVHIrMmZXR3lGTTc4b3BsUUpPVnhMcXE4cmxEWFdmanBq?=
 =?utf-8?B?YlhTK29wdjFzeG9IMHJjamVXWTc4QmNsTXNZWjNCT1IrbFM1R0tVMEFqVVRB?=
 =?utf-8?B?WC90RE1uOWliSm5rUVluSU8yeGtJTGtrMVlKRnhPR0d4RUtiY0VRZUJSUlhj?=
 =?utf-8?B?emtHQlVIbUxocjFhR3pGK2VYMzdvU3JGOUQ0K2c5MEozQmMyMkdoaUhPWHpB?=
 =?utf-8?B?b1dCcGMvcFhqU2xCSEdEWUk0dGR0NXcvUTQzTkRTeVRkSjBpYjJPZy95RS9L?=
 =?utf-8?B?R0QxWmZXYjltaTVwMnZITnlSbkovQmxtbTFtUnZyRmczdDJGN0gyVkZKV2dN?=
 =?utf-8?B?MktSUTZlWGxRM1M2T29TeEw4VXdBNkdXUis1RTNqU2pOWk42QjV5MkpGS05t?=
 =?utf-8?B?MzlXTStnWUJyczU4NndwNGtQZXFVRFNPa0FEQU45eDFIY01IYVlYQUx2dzZ1?=
 =?utf-8?B?bGNTNDZDeDhZY0VzZmtINEpCOTdpU1c5YitKdnAvUUR0QnJrYkhqMk9jMXM3?=
 =?utf-8?B?c1p2eEpqNWVLeWhreUt5d2Y2T2FZYjVIb0FlT2tkWHZ3RXFsdUttNzZTRkwz?=
 =?utf-8?B?NlR6KzJabGV5QkNpc3JzYk1KUmUzeFpnUU11b2lMMDdtOG0rWGxrckFnK3Q5?=
 =?utf-8?B?LzFwc1lqdE1MNzJIeHUyNm00ZXcxWitRNjdEZzF1YStsTUhJRCs5ZU1iWWli?=
 =?utf-8?B?REtPWDNPRVJtUjc0Z0ErZGxobE95UkZZS2J0Vi9NUGNudDNPQWtqZnVta0JH?=
 =?utf-8?B?VVNuUVJyTkljZWlIa0ZNMnhvS0lMSkQ2azZSU2o1WmhoVFFIUFhDTE9SUXNu?=
 =?utf-8?B?TmlkRWROMUlUU01lMC8xNjcvc2h5L3pqSW5HTHQzcENTeDlNcmxqcTQyUXJl?=
 =?utf-8?B?QkNsQmNzcE9neGNLMStJeXZtQjVmbmRxZ3MrNFlUR1ZhVDJUOVBvYjV3VFdp?=
 =?utf-8?B?RzVvcExWUWwvVXpnZG5oMUFHcTJ2bFFWWXRKcGF6Y2lhRkZRV1dsYnZkV0Jz?=
 =?utf-8?B?Q21vbGpOVDVQUkljVXEzOVlreHk0b3RXU0hNRjlCdDkwUk14M3ptOEEyNFRY?=
 =?utf-8?B?bUVqUHRlaVB3YUwxUDJzNiszN1Q0cjhFUjRYUmxrNnpHa2x6RnkzYzR0ODdk?=
 =?utf-8?B?cFFsQXJKVlVodnVCclUrV0diR1FJL1pydGszWGxrQ3REQUxLQ2tuTDN6NFZJ?=
 =?utf-8?B?a1lIaE1xMDJmbEFTSVRMRlFMTEc1SXFLQU1IaGI0OTBDUHJpVzBiQ3J0ZkU3?=
 =?utf-8?B?NUd2NFB6NHV3Q3h3dEpZczVRaS8wbytkK2R1enZwRllZVENTTEgrRVNCdVRV?=
 =?utf-8?B?RTlRM2ZGL1ZzQUViaTBJb1licXU3U294VUNXQkMvRjJkdHZ1dFZwZE9DekMv?=
 =?utf-8?Q?HDq9LugG6mzgZTnDpgPwZZCA8?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b544e40-804c-4cdf-e1d1-08da794e0ee8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:55:39.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JGGx1ON9cMMrcho4oniCnVe3XjNcHUHmiuReUKLhoILkRMJX6puBW+nFuzD3hn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4055
X-Proofpoint-GUID: V2Y83jX-fVJ_gwiv2VMpyMr443zfi-PP
X-Proofpoint-ORIG-GUID: V2Y83jX-fVJ_gwiv2VMpyMr443zfi-PP
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
> During bpf(BPF_LINK_CREATE), sock_map_iter_attach_target() has already
> acquired a map uref, but the uref may be released by bpf_link_release()
> during th reading of map iterator.
> 
> Fixing it by acquiring an extra map uref in .init_seq_private and
> releasing it in .fini_seq_private.
> 
> Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

See my previous reply for some wording issue.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   net/core/sock_map.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 028813dfecb0..9a9fb9487d63 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -783,13 +783,22 @@ static int sock_map_init_seq_private(void *priv_data,
>   {
>   	struct sock_map_seq_info *info = priv_data;
>   
> +	bpf_map_inc_with_uref(aux->map);
>   	info->map = aux->map;
>   	return 0;
>   }
>   
> +static void sock_map_fini_seq_private(void *priv_data)
> +{
> +	struct sock_map_seq_info *info = priv_data;
> +
> +	bpf_map_put_with_uref(info->map);
> +}
> +
>   static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
>   	.seq_ops		= &sock_map_seq_ops,
>   	.init_seq_private	= sock_map_init_seq_private,
> +	.fini_seq_private	= sock_map_fini_seq_private,
>   	.seq_priv_size		= sizeof(struct sock_map_seq_info),
>   };
>   
> @@ -1369,18 +1378,27 @@ static const struct seq_operations sock_hash_seq_ops = {
>   };
>   
>   static int sock_hash_init_seq_private(void *priv_data,
> -				     struct bpf_iter_aux_info *aux)
> +				      struct bpf_iter_aux_info *aux)
>   {
>   	struct sock_hash_seq_info *info = priv_data;
>   
> +	bpf_map_inc_with_uref(aux->map);
>   	info->map = aux->map;
>   	info->htab = container_of(aux->map, struct bpf_shtab, map);
>   	return 0;
>   }
>   
> +static void sock_hash_fini_seq_private(void *priv_data)
> +{
> +	struct sock_hash_seq_info *info = priv_data;
> +
> +	bpf_map_put_with_uref(info->map);
> +}
> +
>   static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
>   	.seq_ops		= &sock_hash_seq_ops,
>   	.init_seq_private	= sock_hash_init_seq_private,
> +	.fini_seq_private	= sock_hash_fini_seq_private,
>   	.seq_priv_size		= sizeof(struct sock_hash_seq_info),
>   };
>   
