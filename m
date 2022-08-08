Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D111E58CB07
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiHHPHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiHHPHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:07:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61865BF60
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 08:07:46 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ClIMe026903;
        Mon, 8 Aug 2022 08:07:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dCiQaMePfJDS2zPN39cj7ksCCUjjupq3PYMg1BSsYyE=;
 b=ajPMZbGCu9+2EzzCJ+iz9QYGFZYfB+bCypTlWAsH/qkjHWE9gau5ux1/YKcTBPlsQRcY
 3iuoVSZOTbT2H/YCm/Ve9t8aa4n54gMt+Fp7WxEszBagHNqGR6Se8nT3JCClzaH2Nyn7
 gab1vPrJXnmoPEQNtFNzmtQHWpTFCwvo8dg= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsndtj9m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD7BaFCllgiuMfPCzPDVGyXHDKnl21kNdKhnj6/dUmuzQ/rMDWzI4YaMLFvfoRYPH1AxlAsbqu103rODZJ3gALH9baGdsovgriK5wXADcwOhzkDm6qKKIj4+iLI+XVFXRfZUjtBEshp3FfjF0xNzxo/wIeG5itUVeLl0VfMDyjZvfngu24PnOtOgKX8WmP9bgy11SkK2QP0LTyVK3XCn3g/eX2/BLB9vXeYd9vM6HyYE/MrQ3k+SqNr4QqQ2pPs2T+ciXfd8EEIVl3tWg8MnuSvsqwyxkv7WP2OaBRxxotam2VbKQCHX2DMj1QjNveMdL8E9g8KUPKyQDKbgBI1C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCiQaMePfJDS2zPN39cj7ksCCUjjupq3PYMg1BSsYyE=;
 b=dCZdduzAQwHnyBUM/kDpBtE9StrCnI1OdtRp/oPUgRZSvcD49HJrE4r6lJr5aaY5c4CekL0Q8D4CzsFg8VN2lvv0ufpalmiaNsa4C8WC4fEHUVzKbVI4GaXnZQ/QG3HWYdAQhBhQTNrp3RXn2zC2HBDK2HwxbIMQ3pxaId/Uxg2/5FuQvWIgUGgnE3ZdAnZKJOIjXwLtMurtjftZ38ddWM/q8snbtLffp7ERhtklmL3Dgxi2+rXX1U97912ZymllMy64wSU9Ss5GIjCctYD5ugnsF8gvVAIMP93YRI2lefcwtRjlXHLL4IvO7gS3UJLvTbmt0zfH6yR985LtZxZtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2994.namprd15.prod.outlook.com (2603:10b6:408:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 15:07:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:07:16 +0000
Message-ID: <1e863483-5437-7ec8-d644-03f81aa8b3ef@fb.com>
Date:   Mon, 8 Aug 2022 08:07:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 6/9] bpf: Only allow sleepable program for
 resched-able iterator
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
 <20220806074019.2756957-7-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-7-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b53202-7984-4e84-93ed-08da794fae5d
X-MS-TrafficTypeDiagnostic: BN8PR15MB2994:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37A5L4OzF8lnNcPcXF8ICVJTVICFrtFlvJa0LmBsS9dRV/WSwxIgu0eLS0nbTsRlM3hETujBgYVmfDhBfnTXkhByRW+FNuCcE95HPTvsGjOv1ol29Akn/jfoFhftPTELHCIaT/0EYUrSBCUjVSxH2i6HviPL5itzKU0lmNbY2Ppf3WwcrO9R+aEHE4hQLcvQQzSDUv+16xru0twZ7KSrzTnrhXfucZCFA4AFK4nGA/unXohXIMe/d8cdII4XT5k18NvLuK+qzOslggPXz4j2BYPL9DJDOUlEemhvTwmlWruLtgk8X8vnW8Ju10OIeS+1IBS2GRifCSfEaCrU5ia4H3E/iciyGGKw0P8MJrtcL5SdSrXvTBEUJgUyNekB9Q6cyVkI6zYqPf2wSJkkrNbXmHQm7OseStesUBYLuA0dRgQRtb3hJ5FXZjsc2XKHLZ+Q4wLF5dJrFcWROnGvXlcrxo/joYsY/HtMUVhnCqbvguQ92sGuRZznAhrytF0rzLhkZnCcPx00znUzArsAMxPpTvi4ABPIFMBl20cpCt7zkmSbOmUc+MZJuXTVh4xYXPX8hAGb+9I62/H2dv/1NuS0csWL0+DC90E/KExkClv5ocALv/CG9cbj/Wr/Kap1a7RY/8edrgR41dNFocefCCZL/nvy6hjoVeXwXkXGRQuMjt7ac3tai0aXNkDvR1R+2Xmi1zRWzDYJ8hxNPl2KxMlqpnB+T1ExO7M004tB6fOjj+TIX2HwX1xDPibpNoFylz2f9be/lWuNxw0AeWDnHRX1wSPLrwCO7vKZD0hwZCIH8TSVhfjnaFCJRX+NddBYBaGdkT4h3nZ4u83RLQ55k9Pswg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(2906002)(54906003)(316002)(31696002)(83380400001)(66946007)(8676002)(4326008)(66556008)(66476007)(8936002)(7416002)(38100700002)(5660300002)(53546011)(36756003)(6666004)(6512007)(6506007)(31686004)(6486002)(478600001)(86362001)(41300700001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JlVGFlUEp1RGphaGxCUGs5Z1JQT1M2YS9LTm9CbHNBZWRYZGVBd2pUN0ZN?=
 =?utf-8?B?eHNmQ0xwSWptd1p0ZVpiVTAvc3hUMWFJcGpGNGxVK3dCV3ZFV2dNakVYejV4?=
 =?utf-8?B?UmJScVNlZkRIb081OGIzT2tKRFYvTmV1cGxwQ2oxOUVZUTZPZFgvc3U4bnds?=
 =?utf-8?B?MEJXT1E1ZlZSZ0lSWGhqVG92eEZzK1ZMUmU1TzFZZTNtVWRMMHlyYTZadlVO?=
 =?utf-8?B?QXZyMDk3dlJRSVFsellZaTYyS3NxRXhTbXlselRHUlh3L2tRVk5zVEdDTFZJ?=
 =?utf-8?B?MEU4QmpoVElscWRqWndCSE12TzhOVUFRd0ZsbDBHN0JnVjdBaWJTNEZxRUt5?=
 =?utf-8?B?N0tHWjEvU2RqY1FETGh1bk1EdkpyekhRS1lWSytKSnU2bWMyUitRU09GbWl0?=
 =?utf-8?B?aXBWTEIwY2wyZDlrWHk2UzByenEwNmdjc2d4Tnd3V041YnBFei95VENaRVFM?=
 =?utf-8?B?bm1heTVaU2RWa0hoUDBDUWxac2lOTjZmVjVZRUM5N0laL2VxR25BRk8yendU?=
 =?utf-8?B?ZXFuV3QzUmdMVm0yNGxObnNobGQwWUJjVVNDVThRMTRvSXlyV3pVbkFSOHdr?=
 =?utf-8?B?RkNzWG9iRFJxaWRYR3VqVkxZaE85MVdjQUlpREVIeUdIc3NrQ2ZHbU9hZ0d5?=
 =?utf-8?B?REhsRzZad1FNL09rNWR2akh4VVZ4WmdSNU1SNmdRTUpQZno4NkdheUFQTlRV?=
 =?utf-8?B?ODZidWJWd0c5QTRsNGdiNVhTNWVNd2NTdjNvYy90dzA1TE1VVDQyMnJDOWpU?=
 =?utf-8?B?NHN3anJDbGNWUnRQc1I3a3pqOGFzMDRHN2I2NTFIRXl5NFJQaFV6K3JlbTE5?=
 =?utf-8?B?TE5jOFVaU1dDMUJiYU10UDZqZ3hvSkRvR09ldThLNXdYRFBvM2RFcXE4RFI0?=
 =?utf-8?B?dzRwZHRPUm5tZHZJNGptL3VqN0pIOVlJSDNLUkJkOVkwakpCNDFEZzhWR0xH?=
 =?utf-8?B?bENZZG1Hd0JFMHV5V0RyakFWbWFML2dFMURRZzcrRmNnUUppRTZuVzF1MDh6?=
 =?utf-8?B?T2RLT05QenN0ZWpKOUdMUFc0STFHRG9LdkNrWThPaXBJTzBaSnNRcFVxMmJq?=
 =?utf-8?B?NE5KSmFsVy9nN2tEa1FFNHE3dE41dmd0dGQ5cnhTN2NHNk9BdnNueXk1TEFE?=
 =?utf-8?B?M3lvR0dMOWhHS01KQWxhUFo2RG1SNGdpS3lKTzFHYWV5cG5uNXY4czVFVHhC?=
 =?utf-8?B?dU5KeEx1aWxvLzhINlcyR1lRQkVyU3NGMGpXaUtaeWluMkZXT2VsZytrU0Vk?=
 =?utf-8?B?ZG03UWVWSjNFN29GM3YzOXExVmYrSGhXV3M5RlFqSXl4eVRzUEMyQjI2RVd4?=
 =?utf-8?B?MFQxTm5sNUJpaE9KSGRxOVprb3QzbDkvV0RsdlY4aEUrOCtPRU96ZFFqNEt3?=
 =?utf-8?B?SFBCSHhLNE1DRTN3Wm1OaXN5TFBTdXJOaW41eWpOSFdkampVcWoyRVpldThQ?=
 =?utf-8?B?NDZwTzRsZGcvSlFTQ3Zmd05UMU82VVJBQnhEZHE0V1JRUVV2bC9DOFRzZkJK?=
 =?utf-8?B?Yzk3aVpmM05DcGpDUFQzRjhxUWJpWXdxdkpNalVacGV1VTZyTVpjSmhuNTNC?=
 =?utf-8?B?by81dmRrYVVCZ1dLaGh3UElKNFlORk1rVmxuYy96YlVnU2QxdHFBUGZhOW9y?=
 =?utf-8?B?NDNnWEQzWXdOMEVyVzBmWFZmSWNRK01PeVAzSWNJOGJteFB6czV1SXBnRTFa?=
 =?utf-8?B?cDJwSGxkLzM0VnRCUFdYa00vM09nREVSMlBULzJKVjRMR0VLcEcvOWovTTJF?=
 =?utf-8?B?WUp3UlkwM3dQUjJEV1ZLQktwZkdvUUZNNnJ0T25EdnBaRDhMY3lBQlRiTGJh?=
 =?utf-8?B?OGVQRkQxeTczejRFOFo1VGJnTUE3L0R3UHhoRERzaTRvMnQ5THhkUStRQVhk?=
 =?utf-8?B?TzVHMkdoaGFCOHl1aU5DMWdzeUZ2YS9Cc0ZYc3VZZy85OEd5c2NVNElsMERL?=
 =?utf-8?B?NXZqVEVnb2MwaTJHSGNkVktSOU5uVjMzQndpTGY1ZHZQdkJpWEx0Zmw5emR0?=
 =?utf-8?B?dXFmMGtncGgzcDA2UGt5bE1OTzJLNHNHdUFWMUxFd052a2k5YUhMQnRiMVBR?=
 =?utf-8?B?eHMrQU01RzlZYURtMGc3aElWU1FjcU5mcms3aUhsMnBKdE5ZMTRWa21HdGZk?=
 =?utf-8?Q?wqWGSdsiH+zzN9HyKw+13RzKi?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b53202-7984-4e84-93ed-08da794fae5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:07:16.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y791Wnn9Ts75U/mAumgv4Af2N92IWfr+zGYXZQw7LKZdJxwktndVs6LvelXbnvO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2994
X-Proofpoint-GUID: 0F_RTY2VHCbmJYeuS5oUd_NYvrZcN1zA
X-Proofpoint-ORIG-GUID: 0F_RTY2VHCbmJYeuS5oUd_NYvrZcN1zA
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
> When a sleepable program is attached to a hash map iterator, might_fault()
> will report "BUG: sleeping function called from invalid context..." if
> CONFIG_DEBUG_ATOMIC_SLEEP is enabled. The reason is that rcu_read_lock()
> is held in bpf_hash_map_seq_next() and won't be released until all elements
> are traversed or bpf_hash_map_seq_stop() is called.
> 
> Fixing it by reusing BPF_ITER_RESCHED to indicate that only non-sleepable
> program is allowed for iterator without BPF_ITER_RESCHED. Another fine-grained
> flag can be added later if needed.

I think this is okay. BPF_ITER_RESCHED will enable cond_resched() which
won't work in a rcu_read_lock()/rcu_read_unlock() context. We can
revisit bpf_iter_link_attach() later if later there are other
conditions which may cause rcu_read_lock() issues.

> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/bpf_iter.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 7e8fd49406f6..f4db589d1dc5 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -68,13 +68,18 @@ static void bpf_iter_done_stop(struct seq_file *seq)
>   	iter_priv->done_stop = true;
>   }
>   
> +static inline bool bpf_iter_target_support_resched(const struct bpf_iter_target_info *tinfo)
> +{
> +	return tinfo->reg_info->feature & BPF_ITER_RESCHED;
> +}
> +
>   static bool bpf_iter_support_resched(struct seq_file *seq)
>   {
>   	struct bpf_iter_priv_data *iter_priv;
>   
>   	iter_priv = container_of(seq->private, struct bpf_iter_priv_data,
>   				 target_private);
> -	return iter_priv->tinfo->reg_info->feature & BPF_ITER_RESCHED;
> +	return bpf_iter_target_support_resched(iter_priv->tinfo);
>   }
>   
>   /* maximum visited objects before bailing out */
> @@ -538,6 +543,10 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
>   	if (!tinfo)
>   		return -ENOENT;
>   
> +	/* Only allow sleepable program for resched-able iterator */
> +	if (prog->aux->sleepable && !bpf_iter_target_support_resched(tinfo))
> +		return -EINVAL;
> +
>   	link = kzalloc(sizeof(*link), GFP_USER | __GFP_NOWARN);
>   	if (!link)
>   		return -ENOMEM;
