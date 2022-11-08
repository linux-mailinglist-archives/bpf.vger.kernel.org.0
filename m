Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25A620472
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKHAJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiKHAJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:09:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E61EEC4
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:08:56 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKpKu010043;
        Mon, 7 Nov 2022 16:08:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=K/mxUHVVuhu5QnJ1D05xxi1M+K1lcscqMye2B8DHq7Y=;
 b=dvt2FdG0ostMU/x/MAWYSX0PTiiAk1I7+nyxsy68/Ad+j569LU7lvbwFC4livDR+XfPE
 +pG+YLAQ9pqttpzmwFq2/iFRSRmA5urEOgXcz8rzTurUztI9oRt0E3UZCUhqhzJtq73L
 UEF0NamXzCTcP1oQoLjQnfMmCokiZ92rQcKmSznauXe/0j5peLT/36CjXBE9Jj0mO5w0
 e6pIquqb8g/B7TRKiLL/IOd8zjgNpDH24/67D+LAorbYV83yxduJEFOBwqsGX8pOWH50
 XBpevgW2LSnovyae9XDT6xfFO+e+i96YSQ0CFxkFKatZnbnzad8CdQQZTSVoLB04nsdU jA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knq54ur89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 16:08:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO8FOqtYx2ZGT21bsEcXJCBE5HpKMjQQDSIV7itoTzjAXGTWhZD35IIJFtlPV6hbewaedrF61CuRlEX1zRPaGYHYtF9NYPw3QRNhK5jsGM9FBdZAIKdPpNnO5hE2ogix474lg+zkd06mTAwWq3Aspdd9CBmIIyT4//QAktTnw0pfI+bLE70AGZwkW9OlvXgd/w76eOwO/YPMYbUTrAkSySALIMAsM/Aa3b0abyTD6f8ufBX1BBpfO9a4DTvBy5T0uDrTqblMWXFrK9Ll3cpsP7NgjzYxaS+2+6yELluK5nScAKcH7socqcx/7ot1aJRVgpcecqsZUs+vqQGB1Jdf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/mxUHVVuhu5QnJ1D05xxi1M+K1lcscqMye2B8DHq7Y=;
 b=F/aIRsjPcO8VAO4ZvwZknr4VBjFQxjhCH3egBjOuAZq6D2bAzQ+yx2lcdqm0qIY+9nUyq/HBLp5pAxAH2JqAxZTfy28pS5tAEBmfj1jJJtOcUMYw7XVDhoXNyL2DG9eaBJblmBB8EIKctpOdW1Y38MHqVEh5HCfgTRGW6kXIRENnRLLqzqOcBvTj40L04Lr3R3Q86jEqXoE8S4M641ZwXo5bw8dx6cVp8lSAQKbbC0mHBJtgxwaJ5yUs6pFik66vVW8mFQdSbPpMbUnApINjBLrwSodDoLwjjQfflAVQcpwmONunV27tJbR6VxbXphNyVMSZ2v2sZm78+JpVcfKlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2772.namprd15.prod.outlook.com (2603:10b6:408:d0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 00:08:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:08:19 +0000
Message-ID: <ef14ccf1-fc17-57df-fba7-162845be4722@meta.com>
Date:   Mon, 7 Nov 2022 16:08:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next] bpf: Pass map file to .map_update_batch directly
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
References: <20221107075537.1445644-1-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107075537.1445644-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB2772:EE_
X-MS-Office365-Filtering-Correlation-Id: e3686a25-d0dc-4bad-6856-08dac11d57ac
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0ox7hQu33NyQiaDoRLvnzVrGdxJnK1Z3QZwvMeLvMjg1l2ZC68nKc5aJ3wLZfBiyXtkDsUTv8j7K6mewZK8PrghVyg/5hH4wb20NUPiAXPPBECh8LaMd2KwJxBFDVXHmVPwAIYKVsp8DvLxylvAo1ml7QoCjEg4IKm2fJwpEgT8XNW8UkTNSHFSZd0YAIj9qXeVz9uwYZl7Xxom8ClIo+wzpb7rNVYyJWMeDB4/TKWIR40zyApY8AZJF8k7TFpY0TTdURRqPw12bXZHjkmO9LY4jhf3jddEgiR1FhdWNjx2zkGUWsjMJyPKfY4A2AsP7nJiAE6ds5C90U4iIyIziB+Ekoun/BoX9s5OL86iR+1zpfRiOerG9dA3KBB7cRmroREUHE/ClaQTdI1ZtibsI/ie1Wau2icW/23oUE7pljnGjzdj+Ey9n22DUnpzR99wkckQM+yr5jeZJBCI+PLIYqhk/KNy75KqI54JANUdchX+Yvxs7awawUu/e7HnDVMaXtFABOQdI1VulE0AAFDXCrhnz0rnFbfzxV0r/saOSBP/1BGvZusyQneY5ySZ8oO3MCm8qFMcluxbiFAa5MFAzHFxeCH7Q+gx0RYgcEOsgbZYfCzCE7kitc/DNbAkD1K7ZQZ3xUeD/lMYf6XzHLwPK95UCXF70HVebWhmWxN2PdwTFoKgBjbQRpDe/G1XxgSYDXOTDAWHsOthT9whLW0Mf/lXXjoFnE66LFOYXQ8tAvzspEXoY4+p+hnCbpZKlkrO1+N7PD/F68VkR43I8pBQgt3tU3gcmLmnGuyw+ZprQdK/i8wIVpzr59srfxORstNk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(36756003)(31686004)(31696002)(86362001)(66556008)(2906002)(5660300002)(7416002)(6512007)(83380400001)(186003)(38100700002)(2616005)(6506007)(53546011)(8676002)(4326008)(110136005)(41300700001)(66946007)(316002)(66476007)(8936002)(6486002)(54906003)(478600001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNGcG9IMUl2ZjZRK3BDUVVnWVVuMk04aGUxWVlhd0Vldm02VjF5QmwxdUFk?=
 =?utf-8?B?VURwY1dvNHhqNENaSVEyVkVUMGpKcXVBVnk1VGpHQ1lOUFpvQmFoeUtzODVL?=
 =?utf-8?B?QkZiSElua3Q5RGZHdkRWcDNEbklWYSswOHBkRXMvT1hpeEx4VlRCTEVLcnZB?=
 =?utf-8?B?VmJ2WVovbi9ZY3VLQVQ5U0o5ajRhSXdkY2FmVTExSmowbmV6Y3BGbnNHeTB3?=
 =?utf-8?B?cGtBRHU0cVFMdkZMdThzdEEzNzNOZ1Rwb1BRVGNRZWZQWVJFcDczd04yVFZ2?=
 =?utf-8?B?MmFhZEw0bDQwWnd2WUpWL0M4UzhpWnRvRnpzR3BhVlZRRVZESU5xSWRtRjNq?=
 =?utf-8?B?ckNZMDZwdDZIMnJGVzFxMjE3TmRGbDV0YVFDYzFwb1NkR1ZLckFTbW9jc0VP?=
 =?utf-8?B?bEEwVE1KMlJDdjA0c3RzT1JPUHZONmJMQjJ6L2ZNTnM2VjFlamYwdFJ2Mis5?=
 =?utf-8?B?RndQS0g3aWg5NHl1ODZVUXVTcjljNThrcVFhYVJ5V0hRcXYvZmlLVGtqbXhM?=
 =?utf-8?B?YVpyaEhwUHc2RkZaWFNieVo4cmMzZGZVdnZiZHJIUTJOYkdoQ1pUSHJGbjJU?=
 =?utf-8?B?NWp5dWtkTXFwZUkvdUtqSXNCTkRHaHNMZ0JrQTZFZ1ZhTFFINTk1TnRTZXRw?=
 =?utf-8?B?dmQ4aEFYV2FSNmNMYmMzcUZGZnE3T0E0RHk2d0tpUFJoQjZ1Ny9LSEdWakZK?=
 =?utf-8?B?RXdMWlh2U2kyajBIelFQZktqdC9kZWpDQXlOK0NlbFVidU5LbnpkK1RqeVR6?=
 =?utf-8?B?SmxOM05WbzJ6N2hZaXlRZExEZ0pmZWs5UzkyTVV3N2p6VExBb0FtYllZRzVB?=
 =?utf-8?B?NlhLa3dVKzIxVjkrNU44RTA4WjBXUFMyV09nbDBhMXBLMW1xMUNtRmhMN25J?=
 =?utf-8?B?N0NDUVVDVlNSRENoT081cWZHMEZ4eERNWDVjTDczK2xKbjVCWjcvSm5KcUtD?=
 =?utf-8?B?TEk4VGNnUzFvbGNreFZVOGx5bmpkYjFwUTVKa2RDUXA0UTRudUo3VUI2dmM0?=
 =?utf-8?B?TzJhd3duaG8yVkZCMW9JWEU2alptL3dJeVFkakdUUG5ldVM5a202d2UvZytU?=
 =?utf-8?B?eGRUcnpGU2NtZHZ0ampUU28wZVRiNDhjQTZxcis2aHJlYVVDUW4xZW5taHlR?=
 =?utf-8?B?K2VHK3FQOTFkNWtYM05rSi9XVWovUmtrUnVKd01SVTlIZ0U2aUtVL1VYb3hw?=
 =?utf-8?B?SHR4NTBwZXYwMUZTeStVTVZPUzM4NU55enNtR1J0RWs5eDNpaEFkdlVsVUds?=
 =?utf-8?B?bHBUakdnWU4wS3NEZFhMRFAybFlNbURwajBlOGxqRytIZExteGlIY1pFcnFM?=
 =?utf-8?B?MGlPays1TmE0bGMrWlpLTUtXVUY1cHozdjBZUG5EQmRhZldXanVMaHZIa3M3?=
 =?utf-8?B?ZmtEcHFZUENBTTZCdUlSem9jR1hGMGN5SVR1YWZ0MmtoSlpIbHJWSjdwSVZ0?=
 =?utf-8?B?bmhqc3djUjVscWZnUnR0NGhhQStndXdpVGVLNjhSTDJFR09FSEh3M3BPQ2lu?=
 =?utf-8?B?OXlrNXUrUVJUWnVvWmpES1lMTXlVbmdMcTZlU3UxRGt5SGYwZHNzK0dtWUcy?=
 =?utf-8?B?eXpGOW5LcStkNHZHdVNEVVBOcFlaQ0tET0lBTitaUjk5Tk1vMmZTS3Jmd3Ay?=
 =?utf-8?B?ZThHN0RzckJsb2xrM09iUHVJdWd1S0lUY1VHVVkybzhqbUJyRTJ3SU9lTFVI?=
 =?utf-8?B?Y2p6eDZUUmFyOUNxWnRNa00rQm1ZYlRsTS9KZkpNVHd3SFQra3hpRkZXWTM2?=
 =?utf-8?B?bmozVm5vYnFNRGo3ZE5pR3J3TXF5U1JZWVBzNWRDNjNmTGJwb09hNENkaVg0?=
 =?utf-8?B?ejIxU1RTSjhLQnhEMmE3bXQyNzR5ZVFmTnBaK2ovTm5jMDk5K3NiVjJEMUdD?=
 =?utf-8?B?R0x3Z3UrSmJCcWtWWjM1TlJhMnlvUWIvVXhyT3M3VlU1SENVK3NER3ZGemFz?=
 =?utf-8?B?R21sTHM4dkR3amhOV3BzMVZRbk5vRi94Q0NSVzAwcXFZMUZXcUE2Z1VqcUoy?=
 =?utf-8?B?dWM5eWZtcTJMekhvQlBmbUlkTUY5WGNGend5eHBSMUtVY3lPdEkxa0JQQy9o?=
 =?utf-8?B?cjdJVm5jU3c1Q2hWREtpUGx0dnJibUFIY2NwSzVqSVluclFXazJiL2NqY09U?=
 =?utf-8?B?ckErU3lKZFFoenNWSGJLaDRDMkNscCtreXhUcElNaDRaWXE5SmN6Mk1VTXJy?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3686a25-d0dc-4bad-6856-08dac11d57ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:08:19.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV9VQEtlReqLV3T5BAWGMEE0cdPdM265rmbFbXZaYgUTAACdHy2K1sE/x1tZYvn5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2772
X-Proofpoint-ORIG-GUID: hUxo5FZsFnai2SpySMzkaJ3B2i7O8U26
X-Proofpoint-GUID: hUxo5FZsFnai2SpySMzkaJ3B2i7O8U26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/6/22 11:55 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Currently generic_map_update_batch() will get map file from
> attr->batch.map_fd and pass it to bpf_map_update_value(). The problem is
> map_fd may have been closed or reopened as a different file type and
> generic_map_update_batch() doesn't check the validity of map_fd.
> 
> It doesn't incur any problem as for now, because only
> BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map file and it doesn't
> support batch update operation. But it is better to fix the potential
> use of an invalid map file.

I think we don't have problem here. The reason is in bpf_map_do_batch()
we have
	f = fdget(ufd);
	...
	BPF_DO_BATCH(map->ops->map_update_batch);
	fdput(f)

So the original ufd is still valid during map->ops->map_update_batch
which eventually may call generic_map_update_batch() which tries to
do fdget(ufd) again.

Did I miss anything here?

> 
> Checking the validity of map file returned from fdget() in
> generic_map_update_batch() can not fix the problem, because the returned
> map file may be different with map file got in bpf_map_do_batch() due to
> the reopening of fd, so just passing the map file directly to
> .map_update_batch() in bpf_map_do_batch().
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   include/linux/bpf.h  |  5 +++--
>   kernel/bpf/syscall.c | 31 ++++++++++++++++++-------------
>   2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 798aec816970..20cfe88ee6df 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -85,7 +85,8 @@ struct bpf_map_ops {
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> -	int (*map_update_batch)(struct bpf_map *map, const union bpf_attr *attr,
> +	int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
> +				const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
>   	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> @@ -1776,7 +1777,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
>   int  generic_map_lookup_batch(struct bpf_map *map,
>   			      const union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
> -int  generic_map_update_batch(struct bpf_map *map,
> +int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   			      const union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
>   int  generic_map_delete_batch(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85532d301124..cb8a87277bf8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -175,8 +175,8 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
>   		synchronize_rcu();
>   }
>   
> -static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
> -				void *value, __u64 flags)
> +static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
> +				void *key, void *value, __u64 flags)
>   {
>   	int err;
>   
> @@ -190,7 +190,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
>   		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
>   		return sock_map_update_elem_sys(map, key, value, flags);
>   	} else if (IS_FD_PROG_ARRAY(map)) {
> -		return bpf_fd_array_map_update_elem(map, f.file, key, value,
> +		return bpf_fd_array_map_update_elem(map, map_file, key, value,
>   						    flags);
>   	}
>   
> @@ -205,12 +205,12 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
>   						       flags);
>   	} else if (IS_FD_ARRAY(map)) {
>   		rcu_read_lock();
> -		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
> +		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>   						   flags);
>   		rcu_read_unlock();
>   	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>   		rcu_read_lock();
> -		err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
> +		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>   						  flags);
>   		rcu_read_unlock();
>   	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
> @@ -1390,7 +1390,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>   		goto free_key;
>   	}
>   
> -	err = bpf_map_update_value(map, f, key, value, attr->flags);
> +	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
>   
>   	kvfree(value);
>   free_key:
> @@ -1576,16 +1576,14 @@ int generic_map_delete_batch(struct bpf_map *map,
>   	return err;
>   }
>   
> -int generic_map_update_batch(struct bpf_map *map,
> +int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   			     const union bpf_attr *attr,
>   			     union bpf_attr __user *uattr)
>   {
>   	void __user *values = u64_to_user_ptr(attr->batch.values);
>   	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>   	u32 value_size, cp, max_count;
> -	int ufd = attr->batch.map_fd;
>   	void *key, *value;
> -	struct fd f;
>   	int err = 0;
>   
>   	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> @@ -1612,7 +1610,6 @@ int generic_map_update_batch(struct bpf_map *map,
>   		return -ENOMEM;
>   	}
>   
> -	f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
>   	for (cp = 0; cp < max_count; cp++) {
>   		err = -EFAULT;
>   		if (copy_from_user(key, keys + cp * map->key_size,
> @@ -1620,7 +1617,7 @@ int generic_map_update_batch(struct bpf_map *map,
>   		    copy_from_user(value, values + cp * value_size, value_size))
>   			break;
>   
> -		err = bpf_map_update_value(map, f, key, value,
> +		err = bpf_map_update_value(map, map_file, key, value,
>   					   attr->batch.elem_flags);
>   
>   		if (err)
> @@ -1633,7 +1630,6 @@ int generic_map_update_batch(struct bpf_map *map,
>   
>   	kvfree(value);
>   	kvfree(key);
> -	fdput(f);
>   	return err;
>   }
>   
> @@ -4435,6 +4431,15 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>   		err = fn(map, attr, uattr);	\
>   	} while (0)
>   
> +#define BPF_DO_BATCH_WITH_FILE(fn)			\
> +	do {						\
> +		if (!fn) {				\
> +			err = -ENOTSUPP;		\
> +			goto err_put;			\
> +		}					\
> +		err = fn(map, f.file, attr, uattr);	\
> +	} while (0)
> +
>   static int bpf_map_do_batch(const union bpf_attr *attr,
>   			    union bpf_attr __user *uattr,
>   			    int cmd)
> @@ -4470,7 +4475,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
>   	else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
>   		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
>   	else if (cmd == BPF_MAP_UPDATE_BATCH)
> -		BPF_DO_BATCH(map->ops->map_update_batch);
> +		BPF_DO_BATCH_WITH_FILE(map->ops->map_update_batch);
>   	else
>   		BPF_DO_BATCH(map->ops->map_delete_batch);
>   err_put:
