Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744EC58CACC
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiHHOyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHHOyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:54:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11062D3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:54:17 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ClCRA030779;
        Mon, 8 Aug 2022 07:53:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JHYTkIBrl4b9uSWa0xeJ4JiT8+AvnNHzbivJezv6LWs=;
 b=InoHQfb8Zqpl7BP37ddxp6g/qIMmBRldbTG0SDScXsinCV4Ce3j0+cYGXqMqh3sgH6IG
 PeO1+mBIRHzjsyCncfcuynweEIDRJZx9mOT7C5stsdaXuDv93ToiS6/uQt27fzOEk2v7
 lf4Dc30XSpav9jxvnP0UH70ii7nucjIm2Tc= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsp4v238y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 07:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMqZEgVuIU4wswqmdcnNTOUq+XVYws8vVeJlWW5taXKxHpup206F9A2GYeEf8EPT7gfVmcGRF4yXkFpFdCCAX4koaPX84bb/gMZ2dVLTEyHyUpTrBvb+rGuWCnv2chq6he74Sk2/PjfRMZ9IfHlshcyZBDQtVMjdt+h8QAXSlgmncgw+8qm2lg1lxP4Mu8F7YyqQBEHVJMojs5pir7Oyg7jZqmcsOJZ13cqrIbs+Ge6rtf5E+HPF8qwC2x10XOVT/qrddsxFZUNo4mAApbLud/IWZjqlny5odtCVBjcTZQ6/HZM3/T0PM5TJ6wvXOnAPTXfaAnqtSdE+5K0k0tJGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHYTkIBrl4b9uSWa0xeJ4JiT8+AvnNHzbivJezv6LWs=;
 b=oC5AC09TgAXhYjwDvDKrCUZcObI9/Tq3DDuHmwPvoWNNbUxz3CHXmyUnBoTvVN81P0mxlFaUwJJyANoRBi4E796s8xVx83tRwMztLVYsBamwQj0+G241NB4U/HTtVJ9iJBWgOwYf4HFXAe8gph9xlCOLIRKD+htFMCAHRWG+3AxlYvtt5aChg/ziYKxMe6fzoC6DG7BcYUT/SSTJHC7+U81R/NiafNpdqfEMdsvdtyZKBksErTjJq44XbYOpQ9KGUFC82l9mGd++Oq9t4d6pWnIGilhXcRTL6tomD2gA0H8anH34/1We09MO5/UheQVjjZSXxK30It59KpJiM4wxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4861.namprd15.prod.outlook.com (2603:10b6:510:a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 14:53:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 14:53:39 +0000
Message-ID: <7e82bc88-d42c-98de-79a7-eda5d48c2b3c@fb.com>
Date:   Mon, 8 Aug 2022 07:53:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 1/9] bpf: Acquire map uref in .init_seq_private for
 array map iterator
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
 <20220806074019.2756957-2-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acaca192-ebf6-4164-abd6-08da794dc7a8
X-MS-TrafficTypeDiagnostic: PH0PR15MB4861:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGz6rhaYg3+BRHL/GCUIDCghjHbIkT3Ny1m9Qy08NdTQmA2E/gVfXRIt3gCUVNcONYqgVlfa772ldlifl6ZIdJHchNsvTiYhhmZiCZ4cAWpy4fP0XmXfdR49cb3+WkO2a3lzZ2OJ00OR3snxuhYIMyvFErbv9uKp1ksCA8ah9TZ2twTgeta7i1etvssUbx0HRc9t1tzAFGxCRf+GNmglvPeTvnDlZDokcMpPuVMD/6SpihD1orVyaayBB9HU5UD+WD86K46t9H6GqZahhZ+Wo8JJMHJB/nm7zAeutrmhGQ2SrMcO5LeQE+WDciXny3nqq78QfxIp1w8HvPow5buB1PNXYpkyAXIpONy4kMdmkRnljVCWZnjJPRfe3BRA3RUkuuT4A7kbpWkryNzZkMfzcuNlg+531c5JBjm2GCYF2eoO/x+iGkXmcZvunETPzoI5RmF0DD0AWdWEHThIwXOT38vKMnMxUjQ5/5WN7eHSQIMbV1qs6lNamIHkMcVM1bgwb1k5gWf6niw1UM2JD0d0WtQZ3lVrxijJsNNWFI5D5loEsv7o9ZP43pDHy/sdumO8pp+7JYrdSff6iImguds2xftWiRD3r1wcjYIeRnTUPHl0iOJCwW5E/tmOzhksRn4gdO7WBNz9jw9AIrqMLxrXXkzTA6jifVxqvysSB5eDImyxcv/Nkiwp8aGkKM73zLXPbgEOBnIvVEP77P/RohBJCYijneeCZ/tQWx/qY/4Crz+MrCuPhPVsg1e3WGQxYDiz8kUPGtHnz2Z8dHl8RT3O+aGtBS5IJ4IEZrDU/vOSwIaJ05sIc2H6lL5oXu2olzImf99x5akuD5j8MMWM75GSm9TcTM1ULuZmxMJj020HQg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(8936002)(8676002)(66556008)(66476007)(36756003)(4326008)(478600001)(6486002)(54906003)(316002)(7416002)(5660300002)(31696002)(186003)(31686004)(66946007)(86362001)(6506007)(53546011)(6512007)(6666004)(2906002)(38100700002)(2616005)(41300700001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hLUVoxdThodzd1d0gvNVh1TFZtTlhleWhCaVkydXJOV1Rhc2VOd3kyZUw1?=
 =?utf-8?B?MjE1TEpuaFRkM1dhdmFaaFZyK1NGUThIcUpaZDV3QXY4N0FQOHBaaGpKdDRH?=
 =?utf-8?B?QkpmQXBMdDRReGlLRmp5WHI3QUZmajFMNEhSOVVFdHZsMllWREFEYk1JdHJ1?=
 =?utf-8?B?ZTE5M1J5KzhvRTkvU1RuZVJVUlUxRkpMa2s3UUF0SnZ1SDNTRVNVcXg0WnNQ?=
 =?utf-8?B?K1RBdDFUdjN1NTJQVHZTejRkYmxVYmFicG1sakFlVlRkSUZCek90UWs3ZmRB?=
 =?utf-8?B?dDNKQnZ2aEk3S0FlVTFqazVmVHp6N3haSVE5Mlk0TGpUL2F3d2I0T2VrcUJG?=
 =?utf-8?B?U0J2SXdKQm5TZCs5S2lrTGxaTjNjMW12cGxRS1ZzelpUa2MxV2tUQVJsKzRq?=
 =?utf-8?B?K0FZYWVwZUZDbkE1S2FwbWNTQTFsU1lnWnRMTVQveEp0dXRPdjk1YVhmclU0?=
 =?utf-8?B?dUpFeEFiQktVWEJuNytOUmxKaXg0bmI1aU9QSmY1OEVyeVVIdjhHK0JWMk9Q?=
 =?utf-8?B?YUt0RE5HK0thS0RWV3MxSnptbjhBTTB2YUExSlMxTVNWS1ByVVNmSFdZL05T?=
 =?utf-8?B?SVlHZTNjZ3NYOGlXeXVXcmNXU0REUjNkU2tmSlFUSC9PVllibGFQc3BuL2Zi?=
 =?utf-8?B?SHNPVEhZVGtQUUNRWm9hU0pyU2VwZjJ1N0R0Yml1NFNpQmNJVHQ5NHQ2NG1V?=
 =?utf-8?B?bSs5eXFQanEyR1FTWUszSm1JY0JOL0tZUWxXNFJSZEQ1YVg0RXRzbmxNemdE?=
 =?utf-8?B?d2RGK1ZPNi90WGZCOFUrT1prQ3JhQjlSS2l5TE4wWktzZmtDd2grRklabHhF?=
 =?utf-8?B?NHpBaGl1UDBVZksydlVKUkN1RXc2V0ZCQWRUNk5xTFBEZGlaL3djTkFJQVIx?=
 =?utf-8?B?Q3R2U1lZNVBhNlNZaEFhRVlBcEJ3MUZjb2ROMjhYb1hNelJVOHViT0lxRXZ4?=
 =?utf-8?B?dWl6Rm42bi9DRDRNbkZaY285WmRBa2pzZC9pak1PVU5nbnJQUmtkSXhwbWQ0?=
 =?utf-8?B?M0syL0lVRCtmRmlhMGZ1RW1Da1hFTUVheXg4aW9FTmp4c2pMbDErYmlBc1FI?=
 =?utf-8?B?ekU5WlVBTGdoUGIrdDQxUXZqV1loMk9uQUtNc3MxQmNVQlp6UkxMaE55ekx2?=
 =?utf-8?B?REh5ekd1NXVrbnFPdkltSVVvNUJyTk5ja25pV2cvbUh0bzJmNVRRWEdXWFNW?=
 =?utf-8?B?aGhhTGZGZ1ZCTUNNb3JFRDF5Tnd4dS9MV0hEZFhJUUpHMjFjNyt3cUhFWm1J?=
 =?utf-8?B?Y1RLWTBkZUYxazNlcWFBVmIyU0lSNkoyQ0Vra0N6YVVVUUgzcU0xM3FNWWVq?=
 =?utf-8?B?dkxJb0NLd3RZWFhkajg2dGFUSFE2SzlTR1RURllkWjJSUnlKdHZ0cFNEQUo4?=
 =?utf-8?B?VWsvSG5RdkxJcVYwYlU2MzhVZ2wzSm5TSUQ3U0pkTVEyMWJHWUM0RzE0NEMz?=
 =?utf-8?B?SWE0MEd1RDhkSlNmR01sZkhTVDR0YVBrVkpjNHJMZS9Pdkorekc0bWFHNlI1?=
 =?utf-8?B?VWs0N0tWZGs0ekNVTCtnTVo4Rll1a0JCWWs2ZFhmUXBUSFFqWndWRGtsa0th?=
 =?utf-8?B?c2cwYUZlZ3hYWDNyTFlrb1RpaHpUSDJPNkxGbjZjZE4vZTlDVUZwYkVNbDJh?=
 =?utf-8?B?aTdpS1J1OE9nQ1pvcks3eXQ4cVBkYjJCNXc0TEJrOW5QdThkdUw2ZStNUjBV?=
 =?utf-8?B?bU1jNExPdktIb0xlaFBHRTZaaTI1Q0dvMFpxWWFiV3djc3ZKcVBJcm9xcmJI?=
 =?utf-8?B?bGRaU1Q5RkxScHdnazFTRjQ3STFwM3NTdExmMVBWYUMrc3o4VG9IUklIRnNJ?=
 =?utf-8?B?WHl2UGZ5RFd2OC9pNTh1V083K2xIZmxET3NyTEVvcnpCRXJoRmlmMHV5SEpJ?=
 =?utf-8?B?RzhDYVJrK1VsS2lhSzMzMFFSdzc3ck8xQ25KbE0vWlJlUVF6bmdxd1FjV2NL?=
 =?utf-8?B?eFBPMVA2eWVwVUwvMXdINTRpbnhMUTE4dG80d3hueVdzMXZlcisveWtUbWpQ?=
 =?utf-8?B?MG95a2VXS294WXJ4Um1HelVZM29nMmc3TzBjbjRocXFNM3B3M29kNnR2UnRR?=
 =?utf-8?B?eU1TK01ZUjNURXNBakZYM3dNSC9kTlM2Q2FUR3oyZE1GOVFaTm45SGdPMldu?=
 =?utf-8?Q?KTiXP7wnrwYQ+XyO+u8l72x8l?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaca192-ebf6-4164-abd6-08da794dc7a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:53:39.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmPyXLjaIsN1flUBKJBBF17RztwskkDdA6DlpQjAljJUI4mpMQ1D6EwfjiPNZJ6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4861
X-Proofpoint-GUID: 0rOB6VjGBkfypDh-3v8M8IgLro29OmzE
X-Proofpoint-ORIG-GUID: 0rOB6VjGBkfypDh-3v8M8IgLro29OmzE
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
> has already acquired a map uref, but the uref may be released by
> bpf_link_release() during th reading of map iterator.

some wording issue:
bpf_iter_attach_map() acquires a map uref, and the uref may be released
before or in the middle of iterating map elements. For example, the uref
could be released in bpf_iter_detach_map() as part of
bpf_link_release(), or could be released in bpf_map_put_with_uref()
as part of bpf_map_release().

> 
> Alternative fix is acquiring an extra bpf_link reference just like
> a pinned map iterator does, but it introduces unnecessary dependency
> on bpf_link instead of bpf_map.
> 
> So choose another fix: acquiring an extra map uref in .init_seq_private
> for array map iterator.
> 
> Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/arraymap.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index d3e734bf8056..bf6898bb7cb8 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -649,6 +649,12 @@ static int bpf_iter_init_array_map(void *priv_data,
>   		seq_info->percpu_value_buf = value_buf;
>   	}
>   
> +	/*
> +	 * During bpf(BPF_LINK_CREATE), bpf_iter_attach_map() has already
> +	 * acquired a map uref, but the uref may be released by
> +	 * bpf_link_release(), so acquire an extra map uref for iterator.
> +	 */
> +	bpf_map_inc_with_uref(map);
>   	seq_info->map = map;
>   	return 0;
>   }
> @@ -657,6 +663,7 @@ static void bpf_iter_fini_array_map(void *priv_data)
>   {
>   	struct bpf_iter_seq_array_map_info *seq_info = priv_data;
>   
> +	bpf_map_put_with_uref(seq_info->map);
>   	kfree(seq_info->percpu_value_buf);
>   }
>   
