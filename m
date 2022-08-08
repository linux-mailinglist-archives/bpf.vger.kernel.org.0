Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415D58CAD1
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiHHOzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHHOza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:55:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC42BE4
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:55:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ClJNP026947;
        Mon, 8 Aug 2022 07:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=y2zaAnwGWgjSbOt8BYnfUsaHhf3X5lo55Koy3ZTy7Wo=;
 b=NSL9IH+5xeI1wJjKJYlUrMwu9eIr3emfJi9Ni7vV2GcTzwMc/Cd7CdyPyLQhwLUVNefk
 Do25yurR8MURJuckiXFntObElcHbTSk74g6j2B9mDvwJf0tpVLpdum0uX0KmIVyvd6Wf
 ijEvIkkZS0i+FYjqm6VYOC4sDjtEpSVgBNo= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsndtj6cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 07:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9/7o2B+yPa2aiUHh7vjH0+2obj11eBTZBrDxkoBQ40GkphH6O4JZJPYSSfDDLbyQh5rLYjXnBql4PGTgjWz4G93iJhhv27rPF9eoLiEwQ9a7C9tS+TdhaqOnhAjhm2f37WxkqezX1E4obQtqvZvJQFUPRqx8+7vBPBF5615ldEBzJzdHJQqhNzatx6114GRlLFc/WF5SvKmTsiXCVpnW4auO+Px06/nDi1Yp0NTYiq1RRTmL9F2oi0hB8wGnDu8g+4luLoa9ry4fpmIXEd1eUPr+kvdvaF8QK04sj8t+pT+LfP51ivTKxxhVoJI8te4SEZBcxWH0m1ItOAdTDyOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2zaAnwGWgjSbOt8BYnfUsaHhf3X5lo55Koy3ZTy7Wo=;
 b=QWg4RtvfDpu4zSTjPkj1W+jasjk9bxRAWCy1Bf9hUBIkLURXr0nN1jgTvWL3Sos8glmI98r8RyAZbXpn/9iehb5IukpYEXQKr+Tqs3CcgAVdb/4iSEYT28nQudNocM/L7XxMy9CWhIdm61Beg8U68g8s0JBoIK6btEiDVt45pMXtulfCeJXbFn1XkkViOMVYSx2LnhRzPFQO0A6Vd+ASJUGxIY9IfBlnCUXg3wKPHHokzLWuap24JCR1O8ZqnuLYMokva67b9eO1wUkUMR0p+HPjNh++3A1tAIrjLV5qVoop670lxg6yT117TFhTM6mmjarOoRDZZAc6w3sRW+gaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2988.namprd15.prod.outlook.com (2603:10b6:5:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 14:54:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 14:54:23 +0000
Message-ID: <7944d355-e30c-66f0-9bdf-165330e98f5a@fb.com>
Date:   Mon, 8 Aug 2022 07:54:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 2/9] bpf: Acquire map uref in .init_seq_private for
 hash map iterator
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
 <20220806074019.2756957-3-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8b61e5-8bd5-4dc3-06be-08da794de1cf
X-MS-TrafficTypeDiagnostic: DM6PR15MB2988:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwRTtRfes6hLkzsjqjBxUa+8AuflD1cf5CGKEv3QhrRPDCfX3JisYMtcNlDSGqxsHbcDaL/kU6M5LEfUE6oHn28N3xOj77jSpz9GkbhtwLdB406uSs8X6+S3q37rTOVmAADmUSWU3j8zjF0KG/cxxZg9YP1Wv86goSn+KzUl56GjYfPSMoI5uCEAjjW+cJzGPusKYhBHJKTNGbdZy7QJ341lg6NvHMol5L4bapgWOBX7AHARy+Db0Fs9vHt1qFkBabuTD78aoFVmlKolDq+6Mz+BQEFXhzqrKnUs9JmnD7/n6KrSmvDD76S3iwccCYpejw2DHHSgf3b5iEdTWFxEBeIr9dwCF/CaAfkPzH5a0HQb+Xi587APWneljhlzDdVw6SUrEh+Jmwmtftq9Ny7u+d3ugSJSBmEr8KxJjwQSIduPzLDyW+ldUQqOX1Qsoi37OJQOV30/pPDXu4+V/fBwETp9Fhm06I2JpjCnGmu1vZbf9n2005+VPmQv1IdHHB17CzLJJN7qhZz0cuw95rzT0qkSmhiHpJwX4i9sZLNTkZkIsx6LIX14FXN7PVCQF+SkUvzN3eewMpCUB63D+qe8YnkPUuB+6Z7H8I0WSqsUrhs4aFc5PxYvivyunsdfudgZ0uSORN2gqWlxkzpfP8iXHb/O5hfEyhkJ49PpelbKC/ipggzewTP1c4kceqD0a+HkoDKWaypn4GthFMh0hzDBJMPxIpPFNjwoC6j57GNP/sJYdrt0NGEujDlQjId0ObGYMplxySD5ONK0rNv/vk9U60I/4idRCHITBY8Pf70w6wrJ0qyOkU3R1Sm990aDsyx1CoKI6cVzEKzVzhXUjjSFmFSSjmDECbMMy3L6yxHoEC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(41300700001)(53546011)(6506007)(2906002)(6512007)(86362001)(31696002)(2616005)(38100700002)(66476007)(8936002)(5660300002)(66556008)(186003)(8676002)(6486002)(66946007)(4326008)(7416002)(54906003)(31686004)(36756003)(478600001)(316002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJCRE1WaS9WV2ZuZ20rQU92a0tFTWlZYzcrK3lPc1dBOE1meHNuU25LNnM3?=
 =?utf-8?B?MU0xUkZRaU9ZeEJ1ZXNrNi9yQVhrcGhzZlJRWklSaFAvdFY4aHdYV2VXNGdC?=
 =?utf-8?B?eHQxVk1kYlFhQ0Q5RDRCVTlhbUJHcTdDUnNheGdKVko4b3ZTRDRjb0c1ZXNq?=
 =?utf-8?B?eStaemNkcEM5WWFsMHIyVXlzNzA3eFBXcWJBSkF5TGFuNmQ0a3pibjN3WWI5?=
 =?utf-8?B?TTJGdDQzSFZSSXdTWFZVcHpDUTRjSFBLcE5HSXNnN2Y1TU5DRWVyUnlJNGtR?=
 =?utf-8?B?eWNFQWxDK3BqMmtLWjRKSzd5MUY5K2xmakxWN3dhcVU5WTZxQVYxczllWXhw?=
 =?utf-8?B?Q3k2SWtaZ2RMVmQzazdwNXE1OFlDSFNuOTVONndPWk1SVEpDdGVUQm1zeWVr?=
 =?utf-8?B?WEZ6Rm1YdmQ4Y2lSWk5jR0U0QW5oMjF2anlWd2YvRmpxRUNpV0lmMlNGSDJz?=
 =?utf-8?B?WTlNNXAwZFBWaUltWU1WT2tTVlFCV3ZLWXA3ejk2YzBza0dSYlo2ejEwU2xi?=
 =?utf-8?B?ckZkVWxjMHlnV2dwZXNZSXlGMUJWVStQWG1SWVdlN0ZHTnh6OHBZc0xwRGZW?=
 =?utf-8?B?SGdSVHVxb0lCSEJkZXR3OXMyYmdUUnFkNlo1K3hKd3lkY3JOZlI0VTNXQmw1?=
 =?utf-8?B?ZXJSRnphRGhOd0ZobXF3emw1bU4xYXdQaVNKaFo3Q3d1T0l4dm5ZcmNsVzVt?=
 =?utf-8?B?eE96ekFoMnRwa1grb3dyVjlUYjFxKzhnSHNSbU95NlNCdHNjWHViMjRqV0tL?=
 =?utf-8?B?djlHUVE2YU55aVFCdUdpMGF6VGlDS1hNUm5yb25CaTdBK2IreWFWYWNOUmpW?=
 =?utf-8?B?R2d5d0pDVnZOOXJ2N1hOTnU2NHFnallXa0ZMV3JmejVsTm1RZHNFbVdILzFI?=
 =?utf-8?B?QlBNRFVpUTZyMzNVRXhjUWkyT0x5bjZjS0F0ejBaTEZRcFcyekxHbS9sbnh2?=
 =?utf-8?B?dTdZTzFsREZUcDFQQVFNU1VXbGdCSDhNNFFQZUZqZlRPSWRjME1KUWtMdlpG?=
 =?utf-8?B?TllNT2R6MEV0Q1BpUmo5TnFPVzJ3Yk1Qa1A2MTJqS0dCNzlYK0FsWkFVY3NM?=
 =?utf-8?B?ellJdzM3VHdIV2l4dVNiYnhGc0RjenJvQkhBZlhIUTNmMmdzVHpYWGh4d1dC?=
 =?utf-8?B?M1QvNHFRZXFJZWJwSjJhRjdNZG9oUjhXSXNReGYvbG9lSDVJQk82WG9SUXBL?=
 =?utf-8?B?VmVkVEhtUzRnaXJwK0M4YWwrWGhSMlcwV3Q2YU9zbm5pSHBKV0FtZWdaT082?=
 =?utf-8?B?TTVrbzFyVk9FSVMwcmEzQTFaVXZudW9ka1MwcnNQeHM0M3pDQkovWVJaWmFK?=
 =?utf-8?B?dzdVYUNQZzQ3NDZnUjJHZTBUWU1LVVEyVU93SFIwUWw2N0ZENzlmbjNHS2k0?=
 =?utf-8?B?NDZTcXNpRG11Z3hNNy8rTWxvZVhnVlJCSVpINklJRFpiaWhCRDJ3R0QyeWRQ?=
 =?utf-8?B?aEFEcUJhcmNLQTFNenNDbjBJRjM1aDNtVUtudDFERjlMdEFSY3c4bUxxQU9U?=
 =?utf-8?B?UEE5U2JzRG9HdEVQSUlXa0VqYm5jcURnb0E0bWsyS1VlSWJCcE50eGRWdFkr?=
 =?utf-8?B?RkJVNDI1TnhhQ0h0NXRrRlZTWlZYelRoTm1VVzBrMVBOSHZSbnJmWjh4VGQ2?=
 =?utf-8?B?dk1DSUZ5MmdnQjlUaWJLMHkxNkN4NnhFV1RuWWZTd3ZMblZVY0xQR21UM2Fs?=
 =?utf-8?B?N0JnYS9jLzBBK1NLKy8wT1ZtcXJzRlpuQkRoSjdSbVF5c1RYbk52RloyUE0y?=
 =?utf-8?B?N1BJYWVBSUh0WDZxaFJZQ3pxUnpnZnFtWTVGR052MWlSSzZMODBLdVVBNUcz?=
 =?utf-8?B?aWd3cTJCYzIxeGgxa3ZuSlRXcExETllLbnM2V1c3VDF1UWVtdTkxSEttNm1I?=
 =?utf-8?B?TnZpRHVIVm9EVlk2SXc0MkFyMDBtZkMxTGRFTU5HNThpVTYrN2wxb2tubERQ?=
 =?utf-8?B?UXdwN3JRdlZoWkpkMGhHQlJYaWlrc2IrNFBzVXpLd28zb3ZKcVRremxLQVMw?=
 =?utf-8?B?b083VmVpQzJYLzQ3SlFmakd5ZWZIMmxEcWJzTnVEYWQ4aFFzaW85ZTRvVDFw?=
 =?utf-8?B?TXJmWU43ZDQ4Z1libEU3b3J1SkhVMUoyS0Z3SW91TkhsSnU1ek9NMTVIS1dC?=
 =?utf-8?B?VDk2OEV5Ym0vbVlqOVhXbkNuaStmQ2dVb0tFSUhFRFdNaXFmdjRpN1BZdEE5?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8b61e5-8bd5-4dc3-06be-08da794de1cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:54:23.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvIh/suGC4kzKI0Dnm5q9Ps5/xn0U36S65BF31FhsvaVD+6NH3Mq14FBkPAeT6pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2988
X-Proofpoint-GUID: H6bguF0DD7iHCC8dEvlvEt18QeBsER6F
X-Proofpoint-ORIG-GUID: H6bguF0DD7iHCC8dEvlvEt18QeBsER6F
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
> So acquiring an extra map uref in bpf_iter_init_hash_map() and
> releasing it in bpf_iter_fini_hash_map().
> 
> Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

See my previous reply for some wording issue.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/hashtab.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index da7578426a46..da8c0177f773 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2064,6 +2064,7 @@ static int bpf_iter_init_hash_map(void *priv_data,
>   		seq_info->percpu_value_buf = value_buf;
>   	}
>   
> +	bpf_map_inc_with_uref(map);
>   	seq_info->map = map;
>   	seq_info->htab = container_of(map, struct bpf_htab, map);
>   	return 0;
> @@ -2073,6 +2074,7 @@ static void bpf_iter_fini_hash_map(void *priv_data)
>   {
>   	struct bpf_iter_seq_hash_map_info *seq_info = priv_data;
>   
> +	bpf_map_put_with_uref(seq_info->map);
>   	kfree(seq_info->percpu_value_buf);
>   }
>   
