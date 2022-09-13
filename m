Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E55B6BB9
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiIMKf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 06:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIMKfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 06:35:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45913F9E
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 03:35:54 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8eA2Y009124;
        Tue, 13 Sep 2022 03:35:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mQKnSUBiIIixCpJTcXJ7laJmtrHaOBHdurYEn2zA/34=;
 b=dFc8OhPyowtFJdb+CeJYbSH3zZ9Zi0C5QBmVyIWPqJpm/57BTiw2qBw7/Vp0ez8TFI0o
 XiHxYcNWpZ3dR7wcmgApMK+d3EZ9PzpPE+9FUnkpxEAt8w1lxfLjISIbLO8bNYXpKsXW
 IKt1F+LV/Wymc0n6o/NnOv/d7ISiz7xtFfg= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjphy8jfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 03:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw3E99Sp5uGxMOoF+FVVR2fgsKD+nMbX5YZCsztCShFcED7AZ1f+94/4lNaGKKaOpim3bA2odIfytOQBcVrEa8vDlEM6/UfefU2ucKCqJOnksR0PW9EPrGvC2fvrk5jLw8oHx7dW4XuQaJh0epAYg1a25SqqpWVoFRV4RezpmOqvS/9VzQqjYaNFcI1O6Uqe17IuhFjQtHv5eZCJIG8xPg8XP4nvyMR8Rht0pPx77xiYfucj6I4/j4a570u+FqP/ROlfe77xP8KvGtJ0sIkiIZFsH8kysxDEW4eqtSQcdXADRXTpITkgoUczTHudITDZrwzmH89kkNovwnCiPdVXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQKnSUBiIIixCpJTcXJ7laJmtrHaOBHdurYEn2zA/34=;
 b=ikxm4bDqgQfMG2ap5i/C6tRo/5E9u3PIQDv+RRCMbiDImRR/QwV4cuj2xdLdPcRP8rqtVQ+jrNNXjK4VX3memo7OLvefT6Dv//qwy+eGa+j3LOgq/K5t5lDPOdtgO65A95QkuF7+Fjk53bp7bP2/wSnK1KAuBUVwDHq4X9gw0Az/eg+UkCFPCWEY6GqigBJp6ZME8IisORvrj9JwCkLv+4f3oEI1Tpa37xoqr8lr+MZTahuRipvWGCBVMiX1VLQxQEdPjqPQrDKAC1fnU6W4Noh+brDUWyBnsG24MuRDlypun3mCWANwDSl8GW4pwyEX83VzuhxI8L02SbUmEspO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2785.namprd15.prod.outlook.com (2603:10b6:408:d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 10:35:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:35:38 +0000
Message-ID: <12cf87b1-9e92-f6fa-ca2d-2c1767c45d23@fb.com>
Date:   Tue, 13 Sep 2022 11:35:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next 2/2] bpf: Consider all mem_types compatible for
 map_{key,value} args
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>
References: <20220912101106.2765921-1-davemarchevsky@fb.com>
 <20220912101106.2765921-2-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220912101106.2765921-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB2785:EE_
X-MS-Office365-Filtering-Correlation-Id: b8970c5b-eb3f-46b2-7a56-08da9573b2ab
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJfzLQM1GGDGTjPFi5K2FTKFesECd91HO0Uuvnvi11WYdkdZGnm3+jhgGYt81YVWF9puUV1odro9085GA3lVRjbW1tfI5FCyb4KKUp8kFL2MwmskYcEEoi760h70OVt4ZF9PQNC9BBwU3AJ1Uzio0pmgDUl7FTNOIgyC5EelF3cyudjDQxrML2V0WV9p2qOMrxknFRNLvXHaQos1cIxK0YkOdafQM53QJeSiuenGzca04lrjpeuMbYvyhS5H7l5OJY/Fk4pzzqA21DWlZKUdSfC1NWgKPL2VPUw/z1Rg53n65OemK83AyoBUOZEX5c/wQfHjNbXnROWqyb4QeD4hH7yk1SFrXNoCEumJVMa1TDgGKcn9Hh/4r+24FHp2zLxpS1myl5cfzNRLNXpQERoG4kMnr5Zb7GVDinWmE7qcU3VSwPtv3wNCEGtmnSUL0nJTZCVJWXa8UdNqgpKXgIPivkiVwXKsyfgYWOYIumGqjX2Dzc3GxpqLEBywFgOXijyG34aRgFiKruwU4TE0lXw6X0fbtoEwHN5IOatauKPA3KjYi5SF4UVAWx8wp7Em6aS1qr5/uRpujSNGnGdbElpT3E3Mbv7GPL1wUrsQrBEekullrKIO+Sgik3F0DMpIFJgthqSG4yJznDz/KVT94ODO/Cj7nrKA/ja5vJXePp0BhRgn8b28epH4n/XlBV3sDjad5GwqRz35EmtshfSvlZC7yFgq+rzXLSZiaV1eDF244MqLFpnxWTUpCMEYTyfYS9QAgFmVDjLrz0tOiYtVYKI93fXozqNJBRXFK1kFZavLYWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(53546011)(6506007)(41300700001)(38100700002)(31686004)(6512007)(2906002)(5660300002)(86362001)(36756003)(54906003)(66946007)(66556008)(316002)(6666004)(66476007)(83380400001)(6486002)(8676002)(31696002)(478600001)(4326008)(2616005)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZjSUZVQW9tV2RVQVorVFAzVC90MjlvTVdZWnV5TzhQb3hBM00rV0FiSFRy?=
 =?utf-8?B?VWRhS2xWU1FEL1FaYVpPRUFUVE1zWVhRTWMwSmRjcTl3U1ZDL3NodDc0UjNZ?=
 =?utf-8?B?SjJMdmpQTHRBcks1a0VvdGRhK0pYZHdsRVloRitoZEZuNE9tdlpGcTN2OVU2?=
 =?utf-8?B?RWk0aTZjYnd4bFg5UDdZNWpxMEtFTVNGREZEUDFGc1NiYTNVdXdFQ294T0U5?=
 =?utf-8?B?VDRZVGJsUVdIVEY1RWdwenR2TlVFL2grZDZSQ1QwK2JYaFpzRkdhWGoyK0pS?=
 =?utf-8?B?VHlZaE05dUQ5K0h1VWUyeXFuWkZpOEh3NGJOMVNXTFFqbXRkMUQyL1JYd09l?=
 =?utf-8?B?cFpUcW5NV2lQWnk3djdJaTd6NGZoVUlYZmVnNUhTNzlyNENHTHFCZ0RLU2dm?=
 =?utf-8?B?c1JKRzc3TlFja1ZBb0xuTVAwRENKTXVKMGRaN0M5REJxMEMyS2ErZDdCQzF3?=
 =?utf-8?B?dUE4dmIrZTBwTjRKcFVWOE5QOWwzVW5XYzdMRCtvMVRkV0NTOFZBazk1ZWZ3?=
 =?utf-8?B?L25rOFNmVy9acnJZNUYwVTVTOGpCb2lnMXlQTGc0cW9UQWZaK3p3WHRhVEJv?=
 =?utf-8?B?SXdud2NlN0F2SWxFb0NOTUxlODZQdndKcSs4ZEg0N3MxM3VwdURZMnBxMnpu?=
 =?utf-8?B?WDB1R1JkRXNWbnl6Q0tTN1BSMlZzNEhMRFIxa3l3bUhuSnMrZm1lL1FFVjZC?=
 =?utf-8?B?cmsxSkU0dTlOY1g2ZHdjMGVCRHg3dEhzbzZnLzhrMk0yZUx0OTY5Mi9VVXYy?=
 =?utf-8?B?bnV2aXdYR3FNL0lsM003c2loNnBLTjhqaFlqVkwxNmZXR1orOUxKMk41dG9k?=
 =?utf-8?B?Q1Aybm83OUk3VENxZUVBOEFpOGllbmdCQjd5T1puOW11dlkvTVd0Zm52S3RG?=
 =?utf-8?B?VnFaNk4wVU45cnZNSmpHQzlBNllVV1BzRHJ5TDlBVUdlcG1JVGpVTDlvSEhR?=
 =?utf-8?B?M2wyMXFlYUVkYlVMalZBeit4SldOUm1UWUpadktEb2VVdU9kd1BpTkFNeWM3?=
 =?utf-8?B?VHdPcm0razk5dUpQa3NkZFc1OWtRQnBkYVlkc3JRNGk4eUlZMlU0b0tSaXlV?=
 =?utf-8?B?cEV1NEdWUVZCNGNMa0w4WUdZMlp5aXBreEF0VWF1d055U1loNStQUlFhRWZr?=
 =?utf-8?B?bDU0VmMvZjg5QkxXdGtab1c0N0NycWVpM3ZpcWNjK3YxRUt0STlFcGdZYXBa?=
 =?utf-8?B?T2xaalFNWktIYWU2SC9COWZRL3MvQmhxcVF3NElab3VvNTlPRitaWGZkaXJS?=
 =?utf-8?B?MU9XUHd1bDc1R2xHUFU2WXZMSzdDNkpuQkpqSmo0aGJQelMwWjhWb2ZmdUgw?=
 =?utf-8?B?M21wVGJCN3NnSTVMaUtQN1IzY2NlQTRKL01TaEI2aXArSkJjWVErYXIxdlNG?=
 =?utf-8?B?SHBDT3RxUkxpZlJKc1prTUJ3SWRaUk9oL3JaYzJOaStkUWZGTG1qTHFON0Jw?=
 =?utf-8?B?aG9tQTdxN08xblJQSkplU3Fxcm5uRVU1L0NkSnFDTHpHbTMwU2xyT2N2S0lT?=
 =?utf-8?B?TlFKV2FQNWdwZENJWDFIbk9BdlhiMWlldW0zNGhNVzhLMVR6SHl6ejJUZkxK?=
 =?utf-8?B?RkhpUmJDNDA4YkIyeEdrVksyWU1XMWxQTUJnRlE5YVRwTzJ0QnhxNGxGMitn?=
 =?utf-8?B?czRXU2FoMHdhSENKdDNXdTlSRGhHRFpla0JBQUJINVpIbU5kMFl5VGI5Y2Jm?=
 =?utf-8?B?bitCeHY3LzZlamw0Zk5tZjVKODhmNVhBNFlOMzZGL044Q3NvOEh1UUhrWTFX?=
 =?utf-8?B?aGROYnlpUWVrQ3RIWk9rQWUrUmxHdjBBY3VwKzZwTElTRnlxUU16bkRPVHps?=
 =?utf-8?B?MnJZUW0vQUVDMVU4Q09DTXB5cytvQ1dZNkpqWGJwRjJ2RzRwMHZSY2JmOUw3?=
 =?utf-8?B?TmRycXlyRURudVUvb3NlMzl4U1pvZU5MdmhyaWhnRmhDUUJrSVVhSHdKaGR1?=
 =?utf-8?B?QXlkSjZEZmwzSmdwRjB2NTFJOGkxQU14Z1RtQ2ZnektSd3dybSs4SVU0Vnp3?=
 =?utf-8?B?d3VPNExIb0FKNk1KVXh0VmluSHJTd2NKb01GdnFJUE1vR2ptMjdmbXZvMktJ?=
 =?utf-8?B?RE03VXdjSFhJQndCaUZINWpLdUd2MjJVY0RlcC9yZERqc05xSHVrSVJRZXJk?=
 =?utf-8?B?enhUNUdHUldKekVvcUdsTy9JSVJVbXhXMStra2lHTUhrOXUzM3o2azhWdzNI?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8970c5b-eb3f-46b2-7a56-08da9573b2ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 10:35:37.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXUxKLUce3I6KLP3yLW5riAXNGHaIFC4m3lrbSAWgkb5Fz+yWVQiMChcG30Vh/vR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2785
X-Proofpoint-GUID: q67_IZwmS1ZMLwCml-lFXyO8I1NTocB4
X-Proofpoint-ORIG-GUID: q67_IZwmS1ZMLwCml-lFXyO8I1NTocB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_04,2022-09-13_01,2022-06-22_01
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



On 9/12/22 11:11 AM, Dave Marchevsky wrote:
> After the previous patch, which added PTR_TO_MEM types to
> map_key_value_types, the only difference between map_key_value_types and
> mem_types sets is PTR_TO_BUF, which is in the latter set but not the
> former.

Add a selftest with PTR_TO_BUF as the map key/value?

> 
> Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
> already effectively expect a valid blob of arbitrary memory that isn't
> necessarily explicitly associated with a map. When validating a
> PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
> already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
> logic like that in process_timer_func or process_kptr_func.
> 
> So let's get rid of map_key_value_types and just use mem_types for those
> args.
> 
> This has the effect of adding PTR_TO_BUF to the set of compatible types
> for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/verifier.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d093618aed99..ae2259d782bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5619,18 +5619,6 @@ struct bpf_reg_types {
>   	u32 *btf_id;
>   };
>   
> -static const struct bpf_reg_types map_key_value_types = {
> -	.types = {
> -		PTR_TO_STACK,
> -		PTR_TO_PACKET,
> -		PTR_TO_PACKET_META,
> -		PTR_TO_MAP_KEY,
> -		PTR_TO_MAP_VALUE,
> -		PTR_TO_MEM,
> -		PTR_TO_MEM | MEM_ALLOC,
> -	},
> -};
> -
>   static const struct bpf_reg_types sock_types = {
>   	.types = {
>   		PTR_TO_SOCK_COMMON,
> @@ -5691,8 +5679,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
>   static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
>   
>   static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> -	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> -	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
> +	[ARG_PTR_TO_MAP_KEY]		= &mem_types,
> +	[ARG_PTR_TO_MAP_VALUE]		= &mem_types,
>   	[ARG_CONST_SIZE]		= &scalar_types,
>   	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
>   	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
