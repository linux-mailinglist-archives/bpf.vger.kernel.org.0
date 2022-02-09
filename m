Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B24AF735
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 17:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiBIQuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 11:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiBIQuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 11:50:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A37C05CB82
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 08:50:07 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219DANkW012854;
        Wed, 9 Feb 2022 08:49:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6IDOMgwV8GScA2hawcBIc64Ogfz8DXho+F+c5rmpAbk=;
 b=ij30E+i6Szd1YT9T6qw8vO1SxGJG7LQxYl/egKrWZ9IsrYLLSZZgkFf7f7Bkc9FBFUDU
 Puh4ra+6Lq2pmrKZgdYoHgiPiDmdVYGUzpJlZo509KL3SZiZu8UrT464UW5ambuuw9LY
 xVrylagjHdD/p1vHXxWC9uHp4m6UCcHO0VI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4e8nskux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Feb 2022 08:49:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 08:49:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoU5WktQEim04l3kfZlpyNI+aUyXvPyaW12xuNXLk6kKd1SAFWwIxZqnWZvgZXv0wZZl1X2ILAn6D5CLfTztak+PUlj1FG9ZrfTVSR/BBO+GjJA8X6ogSuTUokkdBI6oyBsNGJB0gwINoPxudHWEsuSI3k3JX9QM7rgvQ2AAa6/ooLimoCI1zFcF+tzyJuaCUYa7Pe0f6tiyeTOTxFpytqlw69xd3vrQa9SvFvbCvi0u69a1MhwUEXz72J0Q/8Fq8GLGB9Cm7ebkWx22LrIvKlbxJXYL0VZQC6B/9nvgd+W6n5s/M4cXY27wSrC1wCdFLd00OX8k+K2kW9AGo/2dDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IDOMgwV8GScA2hawcBIc64Ogfz8DXho+F+c5rmpAbk=;
 b=Fol0GLh61rXo0+9lJx6z42+aOOKGWi6GltLNZScAn5U36Df38KvzvONe6UsMmo0wfSWa0HlP4NcXk2SWoRnQJvILSSSl7HpUM+Andnze7dZ2N967BSBIRfBO5VrgDbGLvkSimbw7RnclSL7Bup0zS0UfqSlBaoxxGvQjimjAl+rs8jj9fgxTbWWNwZ2V8pooxu00iVRAKZ6cPeJRJo7zj6vVeIItxPmYXiXMhjGOYWeyFnMEHqTvM5ptoZV5xZMUldzgF7mJycSYBXdH6DeYckpz/0gCgWbrdStabavBRyZNOudWfRfaWesnpqlAY4efrK515vThyUiAFzLmITuKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4874.namprd15.prod.outlook.com (2603:10b6:303:e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Wed, 9 Feb
 2022 16:49:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 16:49:35 +0000
Message-ID: <2e1afed6-680e-e311-d94a-b8fb28d93bbf@fb.com>
Date:   Wed, 9 Feb 2022 08:49:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Prepare light skeleton for the
 kernel.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-3-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209054315.73833-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1401CA0006.namprd14.prod.outlook.com
 (2603:10b6:301:4b::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e331fa-e229-4657-143e-08d9ebec274b
X-MS-TrafficTypeDiagnostic: CO1PR15MB4874:EE_
X-Microsoft-Antispam-PRVS: <CO1PR15MB4874D9F29519FC5DA65654A0D32E9@CO1PR15MB4874.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a1zOVvSrOgcQFvHhQVTaXcgYSghtxyuUIBmG7919XehOwMkw+f0cw+tC/LB/A7ld5FSvWFHbhEHcnQhPslh3hA+/cZLHiXaELS+t7fNdyg2V4nB3DXaM/jq8sGGltnMvozpzG4fhJ7b0OBrdHrG4v1lKLDbK5kQNtPRCC8eZMq/SiwRIhTxZwx0WlHCbeAUvX1qPf5oCiMBNwrO36iQ9Rm0+U8j4shcp6Uqcxnk3Ds4PTJwjqpZBEl07myTGMokEgNCoS2oQOkTyBffw+JDIGooB11RyvD1qSZbr2qwLCi/zL+kJAOyXOsTpDAIdl6hIkn6OQw+zuuDjRMv3MpynYTLS1xHPsdAwbjmlNgR1Pl5mgDi2seXK811+Uczu803VVh1X8BDsCh5MF9CBP4S4Bgc4jII76+QlawEa8Ka5Rgx/mthMssVa+nVnPDk0PotCBx6LusF9boE8I0UA1GuMeRm3/6o2tyvjVlZdYun/DJg2lKpJjlcFnGBWbI1KYUQjPdQTZAyNR+9Q5WRT+BbO5dqMDqFu6PfUgcBxXR+54HyNjNJb1E3BmikQa7km0euOUSCGN9ot+5i1gnEvMY/IU9kWKBBEo83D9UlNv7uF82qq/Tb6sENi45Di+Wfm91DetTgRzUVwlGR8ucgC+C86dTJkfySjAa684HYE5TyGHdMdtCzhdqMAeymwqjmpMe7jjXCm7HiUmzbqCpO6D78q4Ji6hQ2cgx9irR+uk/X9URH7FIpfCne4PDBNKw3Y/Hh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(2616005)(6486002)(53546011)(52116002)(6512007)(31696002)(6506007)(86362001)(6666004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(4326008)(8676002)(316002)(36756003)(2906002)(31686004)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dycXAwclk1Mm1HKzlaRmk3ZkladXMvUFlzYjJkTGxSbjdBNmhHbXFaS3d4?=
 =?utf-8?B?dzJnMTlzdTdwd0M3MU1EUmNTMHoyRVduamlOaDM1QUxEczZ5ODVSVnQ5ZUlQ?=
 =?utf-8?B?L0lGdUwvVU1ESXNLbHRFemx6Qkxrb1ZmNXB6dkx4RktqbkZwVU1VelQwcnl0?=
 =?utf-8?B?YXNWcmlwNlpzNXg4ZWlvVUJUYUdzQ2xrbERoWTNjZ0R3aFIwNXVtWG44YWsz?=
 =?utf-8?B?eVVwSHRTRmhwL0lRVm1Wb29oMnUvV2puNm9uNk5oVi8zWVJOVVNIOVRtamFq?=
 =?utf-8?B?RXZGcXYrMHlOUzFHNFh0dERmNEVZOGErQ3J6aUpvRXMwcStJcEJwTkhRdFd3?=
 =?utf-8?B?bU5xb1dla3RDT3ZCWEZCZDIycldpTi9ZR0NHL1VnMy9SMVVlM1hocGJSZlpZ?=
 =?utf-8?B?cW1aNnBjc0xQV3BvSnVQZ1N0WnFNRVNxaUN1MUx0WXpEUnRlN21jR3hUWFg0?=
 =?utf-8?B?dExZb2kxWitPNTkzQ0xaSHVQMHFkTU1zMHJsd3JSMEppVUYzNHQ1bDFuRENr?=
 =?utf-8?B?VzFMZHQyOEFRTkQxYzdERFZSYXhoUUdCVk1yZTJhNVFiU1FGdGRCYnl5QWo4?=
 =?utf-8?B?d2V4dHUvYi95YzhHY2FQV3A1bGJFSU9QdTNKdGJVdkYzN3pESzNJWVpwQlpX?=
 =?utf-8?B?ZEpMUUlTdzhNWXYwV0pEMVNGejNsUXlNNHVWTHhQOEhoVkw5YlUrSnd1SllC?=
 =?utf-8?B?QXN1bFVTdVVZVExmdjl4OHBSRnpCdWZDb0JFRFlGcWp2TVVQbUdTUWw2RUMv?=
 =?utf-8?B?ZE03WmQ2ZWNpd3dtSVhZV3BPdXdzZG5ON0FwTzVIaTZySHg3VFlzQ2Z6eGtF?=
 =?utf-8?B?cHB3RUdSTVdKaTBXWnJTY1NBblc5R0NkYmF1ejNtMURWR0N5S2NiQVpuQWRF?=
 =?utf-8?B?SkV2NnV1TEUwUEszYzlnMVUwS3JEWk50Smx6SHVVaW9mU0tWUUFXaWJza1dD?=
 =?utf-8?B?ODdpNk9LTkQ0MWNyWGxlNUJvZmJLb1Y1OXc5ZFlJaldqS0NXMlZSUHhhTVZB?=
 =?utf-8?B?U1h0OUFHbmNxdEQ4a3dGN3o0WElaOVdoR0t3VTlmbTd2MTY1c0gyU1VFbVFH?=
 =?utf-8?B?bytUS21EdTdWQm1aZHVqVnptSEE2b3MydXFYS1YzclNvTXp1VU41VnBZRk5o?=
 =?utf-8?B?dGFpK1BNNlpUMVB1aXNSRXhhVUc2SXJPZnBzOW9WUUIxL1JoU0Z4Tllmckw1?=
 =?utf-8?B?dEFhVmJoQUp0ZFRyYllaeFVYbDJ4SUp4QVlTWGlLcjJDSnlGOEQrZXBocGha?=
 =?utf-8?B?d29MRk4vb1RjVjRUVWVZbFFiTGVCWjNSanhML3FOTkRUQVpQbXZFUFBVMlRW?=
 =?utf-8?B?amQyNXhYVnYwUGVudEY1clpyQ2liUGlNVHNHaFYxN0NrKzBEdTFocTA2NThv?=
 =?utf-8?B?Y1hqTTJIT1IyMmNPbmw0c0ZYZTZSVGlndklaQkZ6eCsvMThHeVFLamQ2UjZU?=
 =?utf-8?B?K2VwK2tiVTl1RnA0NGNrRDhkWTlSSURCaE42K2E5UDhUVHZ0YTBOOGFPYzZl?=
 =?utf-8?B?WDB5bTBrK0pjOElSK3hnVE9FbWthQUhNZ2k1UFo5MFVYNDhXRkhzM3BCY0pz?=
 =?utf-8?B?ZFJxTTZVTm5PSEVueU5jaThPSTVLRWJWWGhIL0c2bmNMOTJWTER5UVNzMDhj?=
 =?utf-8?B?VjkzLzhHK0NSUVRiUUs0T2pYNTgwTkdNU1I0bDNuejFDVFhWRzRQQ3dKeDNm?=
 =?utf-8?B?aTZqM0FFcDFaVlA0M1B1bXdaL080dFhUTU9FSkhQTkI5Z2FibjE1N1h0R0tN?=
 =?utf-8?B?dDB4R09IREJ1UWFPdnFsODB2ZjZVYUNGQ2R3RjQ3aytRL2VOZHlVYTlxK0V1?=
 =?utf-8?B?T0VMaTJnOU00cmhwcTRoZ2J5ZzVKSUJ3alRoM3I3ZExsQU51aTBjWld5bk9x?=
 =?utf-8?B?bGZFdE1uOGlIcU96ZjhjZjUyRVcyZVgyZ1owOEZVTUJHdkcrRWNOSmVYME5W?=
 =?utf-8?B?d3BQa0RBVGlEK2dnWDFaNDEzRFRKNVkzSzZhRTFqblVOUDVIM0JsMU84WGk1?=
 =?utf-8?B?QndaOVZSUzV4aTZtd0V3SFVPcUJZNTlMMUFPdTZ6Q01TZUl4ZDZaa3ZXcFFY?=
 =?utf-8?B?TkUwTkdVM0pnVWE5VnBCQzM2S0N6Yk51RzJtdzd0SWJWVk5FTGUvVlk3OE9p?=
 =?utf-8?B?eXdjZFE4MW9PRnZiMkJDZHhETVdxcldzN21CQUdOK0RraHkzYzFZVkdOZHJQ?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e331fa-e229-4657-143e-08d9ebec274b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 16:49:35.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziCY3QPr3aZw4KfZr9hgIObLoRS9RvajujuGe1RTeIoQE8onoQLZ4Fpd8Z1oxJYx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4874
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: w4SC3_5ZbEpwqhbXucXoqiNdhwB3gegl
X-Proofpoint-ORIG-GUID: w4SC3_5ZbEpwqhbXucXoqiNdhwB3gegl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_09,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090092
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 9:43 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Prepare light skeleton to be used in the kernel module and in the user space.
> The look and feel of lskel.h is mostly the same with the difference that for
> user space the skel->rodata is the same pointer before and after skel_load
> operation, while in the kernel the skel->rodata after skel_open and the
> skel->rodata after skel_load are different pointers.
> Typical usage of skeleton remains the same for kernel and user space:
> skel = my_bpf__open();
> skel->rodata->my_global_var = init_val;
> err = my_bpf__load(skel);
> err = my_bpf__attach(skel);
> // access skel->rodata->my_global_var;
> // access skel->bss->another_var;
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   tools/lib/bpf/gen_loader.c    |  15 ++-
>   tools/lib/bpf/skel_internal.h | 195 ++++++++++++++++++++++++++++++----
>   2 files changed, 189 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 8ecef1088ba2..927745b08014 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1043,18 +1043,27 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
>   	value = add_data(gen, pvalue, value_size);
>   	key = add_data(gen, &zero, sizeof(zero));
>   
> -	/* if (map_desc[map_idx].initial_value)
> -	 *    copy_from_user(value, initial_value, value_size);
> +	/* if (map_desc[map_idx].initial_value) {
> +	 *    if (ctx->flags & BPF_SKEL_KERNEL)
> +	 *        bpf_probe_read_kernel(value, value_size, initial_value);
> +	 *    else
> +	 *        bpf_copy_from_user(value, value_size, initial_value);
> +	 * }
>   	 */
>   	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
>   			      sizeof(struct bpf_loader_ctx) +
>   			      sizeof(struct bpf_map_desc) * map_idx +
>   			      offsetof(struct bpf_map_desc, initial_value)));
> -	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 4));
> +	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
>   	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
>   					 0, 0, 0, value));
>   	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
> +	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
> +			      offsetof(struct bpf_loader_ctx, flags)));
> +	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
>   	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
> +	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
> +	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));

I double checked and this part looks good to me.

>   
>   	map_update_attr = add_data(gen, &attr, attr_size);
>   	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index dcd3336512d4..a431144c922c 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -3,9 +3,19 @@
>   #ifndef __SKEL_INTERNAL_H
>   #define __SKEL_INTERNAL_H
>   
> +#ifdef __KERNEL__
> +#include <linux/fdtable.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/slab.h>
> +#include <linux/bpf.h>
> +#else
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   #include <sys/mman.h>
> +#include <stdlib.h>
> +#include "bpf.h"
> +#endif
>   
[...]
> +
> +#ifdef __KERNEL__
> +static inline int close(int fd)
> +{
> +	return close_fd(fd);
>   }
>   
> +static inline void *skel_alloc(size_t size)
> +{
> +	struct bpf_loader_ctx *ctx = kzalloc(size, GFP_KERNEL);
> +
> +	if (!ctx)
> +		return NULL;
> +	ctx->flags |= BPF_SKEL_KERNEL;
> +	return ctx;
> +}
> +
> +static inline void skel_free(const void *p)
> +{
> +	kfree(p);
> +}
> +
> +/* skel->bss/rodata maps are populated in three steps.
> + *
> + * For kernel use:
> + * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
> + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
> + * The loader program will perform probe_read_kernel() from maps.rodata.initial_value.
> + * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
> + * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
> + * is not nessary.
> + *
> + * For user space:
> + * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
> + * skel_prep_init_value() copies rodata pointer into map.rodata.initial_value.
> + * The loader program will perform copy_from_user() from maps.rodata.initial_value.
> + * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
> + * skel->rodata address.
> + *
> + * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
> + * both kernel and user space. The generated loader program does
> + * either bpf_probe_read_kernel() or bpf_copy_from_user() from initial_value
> + * depending on bpf_loader_ctx->flags.
> + */
> +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +{
> +	if (addr != ~0ULL)
> +		kvfree(p);
> +	/* When addr == ~0ULL the 'p' points to
> +	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
> +	 */
> +}
> +
> +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +{
> +	void *addr;
> +
> +	addr = kvmalloc(val_sz, GFP_KERNEL);
> +	if (!addr)
> +		return NULL;
> +	memcpy(addr, val, val_sz);
> +	return addr;
> +}
> +
> +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
> +{
> +	return (__u64) (long) *addr;
> +}
> +
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
> +{
> +	struct bpf_map *map;
> +	void *addr = NULL;
> +
> +	kvfree((void *) (long) *init_val);
> +	*init_val = ~0ULL;
> +
> +	/* At this point bpf_load_and_run() finished without error and
> +	 * 'fd' is a valid bpf map FD. All sanity checks below should succeed.
> +	 */
> +	map = bpf_map_get(fd);
> +	if (IS_ERR(map))
> +		return NULL;
> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
> +		goto out;
> +	addr = ((struct bpf_array *)map)->value;
> +	/* the addr stays valid, since FD is not closed */
> +out:
> +	bpf_map_put(map);
> +	return addr;
> +}
> +
> +#else
> +
> +static inline void *skel_alloc(size_t size)
> +{
> +	return calloc(1, size);
> +}
> +
> +static inline void skel_free(void *p)
> +{
> +	free(p);
> +}
> +
> +static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
> +{
> +	munmap(p, sz);
> +}
> +
> +static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
> +{
> +	void *addr;
> +
> +	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> +		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	if (addr == (void *) -1)
> +		return NULL;
> +	memcpy(addr, val, val_sz);
> +	return addr;
> +}
> +
> +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
> +{
> +	return (__u64) (long) *addr;
> +}

The above is user space lskel definition for skel_prep_init_value.
Below the kernel space lskel definition:

+static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, 
size_t val_sz)
+{
+	return (__u64) (long) *addr;
+}

First they are identical and second this function is simple enough can 
we do actual inlining during lskel code generation?

> +
> +static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
> +{
> +	void *addr;
> +
> +	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
> +	if (addr == (void *) -1)
> +		return NULL;
> +	return addr;
> +}
> +#endif
> +
>   static inline int skel_closenz(int fd)
>   {
>   	if (fd > 0)
> @@ -136,22 +287,28 @@ static inline int skel_link_create(int prog_fd, int target_fd,
>   	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
>   }
>   
> +#ifdef __KERNEL__
> +#define set_err
> +#else
> +#define set_err err = -errno
> +#endif
> +
>   static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>   {
>   	int map_fd = -1, prog_fd = -1, key = 0, err;
>   	union bpf_attr attr;
>   
> -	map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
> +	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
>   	if (map_fd < 0) {
>   		opts->errstr = "failed to create loader map";
> -		err = -errno;
> +		set_err;
>   		goto out;
>   	}
>   
>   	err = skel_map_update_elem(map_fd, &key, opts->data, 0);
>   	if (err < 0) {
>   		opts->errstr = "failed to update loader map";
> -		err = -errno;
> +		set_err;
>   		goto out;
>   	}
>   
> @@ -166,10 +323,10 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>   	attr.log_size = opts->ctx->log_size;
>   	attr.log_buf = opts->ctx->log_buf;
>   	attr.prog_flags = BPF_F_SLEEPABLE;
> -	prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
> +	err = prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
>   	if (prog_fd < 0) {
>   		opts->errstr = "failed to load loader prog";
> -		err = -errno;
> +		set_err;
>   		goto out;
>   	}
>   
> @@ -181,10 +338,12 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>   	if (err < 0 || (int)attr.test.retval < 0) {
>   		opts->errstr = "failed to execute loader prog";
>   		if (err < 0) {
> -			err = -errno;
> +			set_err;
>   		} else {
>   			err = (int)attr.test.retval;
> +#ifndef __KERNEL__
>   			errno = -err;
> +#endif
>   		}
>   		goto out;
>   	}
