Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FAE591CFE
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiHMWXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Aug 2022 18:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiHMWXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Aug 2022 18:23:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3285B79C
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 15:23:45 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27DFP068027007;
        Sat, 13 Aug 2022 15:23:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=I/ICABDBYqoazr6JERTiIgg7vlcLakOk/LyZctM5z4s=;
 b=Qqk2sNbU6mOOJj6wc+S7XyQ2jHpsXu0Lq2PlxKEVekV1EZKX+i8oXNHfTP9PZ0Bl+4Jx
 LXomg09HGKVqa31HVh33fGq1YzGVnRXEVIHHRCLMH6UfXbUC3SPawySyAJx5V/ZFjQtW
 0W1338cEygJV4Z12xTFZdaYaphPpPI3gu50= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hxb93jacr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 15:23:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAFtic79EEGfP/AQ88JYuGX3ldPSQLPwciGBDamjzaFoG7Zp2cXtcnYdAVLsIvhl0zDb1UQWvuusRqTkSjaYMFrbV7g6ggVRA1dOhEPa4VGcJccp+NgC3eQAzJrNLIfsebK0QPc8gm9uHJGgbeFAuT02EgxdXJNEELkO7aNm37xX1/cfk8Na4cVH6YwUHBfuk3Ql4LpMkFWUWRoXKNYaNYo5Knws1CSqc/En+CbDWZ7X1Nk93w6W31SUwPOMp1o0NprJx8XNqbIx+Cajo5mn3ytxXWLqpiQm93MwsZm6JgG8xMP3Zw/AvVa4yrwJrSneAcsQP2IyLvvpsNbmaU6maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/ICABDBYqoazr6JERTiIgg7vlcLakOk/LyZctM5z4s=;
 b=cEoG2tA+8dYJ/jaW9iHW9TP5dae9cDPxqIqy3BJk0EuYojtl60uzNG6zTMO+9wxtjZjBkyai8mndhTafghL1nR77cdScfoNazB95BNFqaxsEJbO0u6K50j6WLztSqNOx09ZY7oaXXoQO0Tcwhq6158vWfyohb3YD+LH8VPeghWZSFrWjNp47xUyhm/GAPY8RxOwgMiA9TFMFk7NWWX8CXy5ZZBUHw0OA1XEkitOzTqzGlVnGzDJxqeEWSIx4l3h50U6AlfoyuOznbfKnUN+C+a86wwlb1Y+v4MgwKThxI0/+Hime0MY1BLBZj3L44SWQE7rGW8lspSbvlToN7Lv/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2746.namprd15.prod.outlook.com (2603:10b6:5:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 22:23:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Sat, 13 Aug 2022
 22:23:28 +0000
Message-ID: <2bfa7fb6-3041-046c-541f-9ab9c57b1cc1@fb.com>
Date:   Sat, 13 Aug 2022 15:23:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Handle bpf_link_info for the
 parameterized task BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220811001654.1316689-1-kuifeng@fb.com>
 <20220811001654.1316689-3-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220811001654.1316689-3-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df527b24-0c88-4656-2381-08da7d7a71ff
X-MS-TrafficTypeDiagnostic: DM6PR15MB2746:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXkKfWpJYgL9WqAbOcSNAaFOt9QbtSZLVIYMVGrUzK2GpDKAjcPtn5uwDj+c12jSXP5zBPa1uy1/L2CijyNx3pe/JKpr9cXdderrwQnZsl9gjxTnAjdnAE2WMTEjoP9XyHGUvd1ABH0gZbqBX7nVoA2FibwgCagJEr8BS1MqqCxNqcbvlJjgdQ0AI1xJb6v4HifImgq5WWV23e6CxX8eDz0M4raT4uaT93+FqVQKH+CNtlqXdUu1gx8bDtT9X21m40zFwkXmroxicMnwkItF4FUCMpBnPVawoRFmSnMYbgeHecHeqYBeKsjBK2QXeRTfiGqkW7+c0gnZ+ZfK4bD2zULEDIn/kIpaQvzmg+Eez+k+A+SDIAlR0xsJi1ASpw9PkAoEuS+RUsCOIDa9oMR0RqVC/V+cGGn17bS3sfPsH1x/M82B0Ibste8u8K38bf/Y23RXb5nKlvyfer3kC81LtuMABYkSh/HVoh1XAYMAZeUsf8LxMSf22MYudyIheyOqaXIGRjyzluEbW8NNwawdCF3FZUr4cUZqeK9D3IbdZ6SE/B18EnZqd4assJ+aYlQh6wuMVgdBiho3zqDnm7FbqWgKXhG442TTmV6kf66nagdgpAARzn6Kg0DAsTL4/rK/+EG6uIJ0JdHfjYLCSKAs1tfWF6+fw74+0eiMyFfw8vqA5MBzRjrgMcEIJ0/ZYEq391XfvPqDBmF2ubwTLrblrU2+eAkcFC9+f1htxe4ywT7xmUg7wuqPdDGZusi4lhprinIOm7rs+ch0kgAspPoV5WLhcmwnuKcgFTXuclBp7OXNHB0LVokdKdJ1LB2FyKbaZxlqIZTP/TDrkYtItup0aKKli/tAGbeHx6f4ziNZK9n6E3i32q665pxRDDqx4BfM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(316002)(966005)(38100700002)(6636002)(8676002)(478600001)(66556008)(36756003)(31686004)(6486002)(66946007)(31696002)(2906002)(5660300002)(8936002)(6666004)(6512007)(6506007)(41300700001)(66476007)(186003)(53546011)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BPa1EzaVExdFZaY2V0a0pENG1rMzJSbm5waTcycGNxamRMNWFZK1QwMnJz?=
 =?utf-8?B?Ni9WWE9qcFpxVkxiM3B1UHpSSmhFRFl2cm9XOHF1TmRzdldnR1hQc1hjdlhk?=
 =?utf-8?B?MWNjMXo4Zi9tNlFTaVdnaTRacm1naVYwd0trTVZJM1dIcis2RnZxL1VtRGgy?=
 =?utf-8?B?cVJGZk5kZS95ZTFiSXVNS09wQzhXdFg3NUptdG55ekY0ZDhzVk9WTDhHRWFQ?=
 =?utf-8?B?djhrTThoSlV2WHdFd0tFelpvcS80NFdnYmxZMW1SV2JQajJDRXB6YkhPMTV2?=
 =?utf-8?B?Zmc1aUpMNXJCK0xLRVFEWVR0NzhoWEhVWEdMVFBXRmZERTNTb21jRnZjNVgv?=
 =?utf-8?B?aTlGeWhFTVZLQ0pGYzBUWjloSlFZaldkTDFpNWJ5VitKSzNKZmpuQlFQZHQ2?=
 =?utf-8?B?YmhaWDlQWndDRnh6UFFXZ0diMEZQaEhaR3NPSGZDWldlK3BKNnZDS1VyOE9h?=
 =?utf-8?B?UnZ6MzZ2RzlIbVgrdHhkWmtmekJBelowVnYvbUZWZXlRMFVPaFRoYldQelFY?=
 =?utf-8?B?Y2llNTlvOGlFOXdpbDcwM1d0R1AybHAvVkpJcTZYT2RQK0xTYi9zeFlIbjZ6?=
 =?utf-8?B?N1h5UE1jNHRPUys2dTU5RG5WbXdud2dRS3J0aURva09NeWJhck4rTU9uZm9y?=
 =?utf-8?B?OGdETE9lM1RFVWp0eGRvaENjcHc1NkVZY1JleUoraXp2VGpSOGpURFNNRm9D?=
 =?utf-8?B?a0ZhRStwM1E1OWU1TmVocHgrcjYvN1B1Z0g0cGRIcGpIbXppZFlQZTJFMFYw?=
 =?utf-8?B?VTFEVHBlL1p6VmpwczA3czlwb0ZhazVycWtucndHdjJBbUV2RG00eXFzaG5R?=
 =?utf-8?B?bDQ5dkhhU2FXSHVLak9XeDBWb2pvekZPL094ZHgvVUF2MXdQak52ck4rUU5D?=
 =?utf-8?B?UmNib3ZiUDJGQlVSU2d6dXVYWmFCRmRNbHRiN1lZOWpIdk9pVFhiTUphS1VM?=
 =?utf-8?B?VlVSUG9XaWU5OXNQb0lzK1BmaEh6bXhsNUJVMGRLWW5QOHdSem93L0plYXhL?=
 =?utf-8?B?UTB4OG03R0NESzZONWdlV1R0Z3BCUml5bkRIUTc1eGtSaW1KL0x1aEpkVThW?=
 =?utf-8?B?bFVhcVFuQ0JhdU5HZHZ0RXRpUUZnMHo0Z3VkK0poREhucEJ5Yi9vc3dlaFpj?=
 =?utf-8?B?dnM1c05VcGNJaUpiNW94alhzeWNEMU9YdzNGZTM0TWRMOW1zNjZJYjZHMldo?=
 =?utf-8?B?K3o3c3IrSGordVZMak5Ga3lIbURydEJ6TDZXb2s5SW5aWFR4TUNlNkJaV2hV?=
 =?utf-8?B?UzN3S0x2ZVVMc3V0VDJKbS80WFVRelVqYlppbXJpZDhTSFNsazNySmhZd2V3?=
 =?utf-8?B?ZGlYdkJTSm9ZY24xVUNHZnJlL3V4dGVWWDdXa3pTcERBNENIZHE1ZnVkcjVp?=
 =?utf-8?B?RFF1UXRaeDZmeEJTTVM1clpxRUhYTjZZb3ZCTHFFNUs2RnhROGQ3aWhZa21o?=
 =?utf-8?B?enRCUVdLZmxsNWI5cURYNzcrc2lobCtydnFic2xGSmgxd0xXcC8xbVpwbXZS?=
 =?utf-8?B?Wi9CRTZ2MTlXWmtDOUdSY0d1clg5UjB4UGY2SEhnZHJYNDEvclA0dzVjaVcx?=
 =?utf-8?B?WjUvektlMlBsMHM1Zm9BTStXeHIvTHBFTnJicEo5ZmlWTlJGSllKamo3ZC8r?=
 =?utf-8?B?UXN5bzc4cGo4bGczamRDaFVrMThNRURNZ1VQbzdoZkZQWWJHZGRWcUg5cXcv?=
 =?utf-8?B?aGhnelFQTk1qUGQxS3ZvY1lHbEZMUzJ4UXpTMER1SmI0SUxqZXlBTXVLYkZh?=
 =?utf-8?B?U3NxWDRXTGQ3YzQvT1VUTEQxZDA2cWtQTUI3NDUxOVlRYk5OdHE3eUdaUnlJ?=
 =?utf-8?B?VUdLTS9kdUhFcHU2WE5lK1g5L1lEVWw1YWc1dTI0RlFmZXJva2tUQ1FKWlNl?=
 =?utf-8?B?bmpxZTllTm9KUzVJT1B6eGppaExmRVNYMndwVms4aHZDYlhRZTVDblMrTlVM?=
 =?utf-8?B?T2c3bmdYcUlGNG1IbjV0ZGs2MllmM1ZkeUtjNlRmd0ZCRDh4dzNFd1VVaG9v?=
 =?utf-8?B?UHh3dnNkL0VvY0p4QzFGM0hDazlsc3R4ZjlYamZsY3dEQnBGQmE3cCtxd1M2?=
 =?utf-8?B?UmFJc2UyaG12a3hDdHg0UnVJTE1lWGI0MGFwUDdVcHE2NE5pRk05a2t2aFZr?=
 =?utf-8?B?L09ZZFowNmh5Y2RZSEExOU56K1ZHa1hkWGhkVkREQkVPQWdwSFFXMGs5MlU0?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df527b24-0c88-4656-2381-08da7d7a71ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 22:23:27.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFVujvxHAGgHjFlnXJIvihyzHupUm0kT8csNVBJS/rKW42EnHLHgAMGLOIsKxFMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2746
X-Proofpoint-GUID: evkrGMoculpWcjNIA9Ot8KImNJP3nU6w
X-Proofpoint-ORIG-GUID: evkrGMoculpWcjNIA9Ot8KImNJP3nU6w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-13_11,2022-08-11_01,2022-06-22_01
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



On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
> Add new fields to bpf_link_info that users can query it through
> bpf_obj_get_info_by_fd().
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   include/uapi/linux/bpf.h       |  4 ++++
>   kernel/bpf/task_iter.c         | 18 ++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  4 ++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6328aca0cf5c..627a16981c90 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6143,6 +6143,10 @@ struct bpf_link_info {
>   				struct {
>   					__u32 map_id;
>   				} map;
> +				struct {
> +					__u32 tid;
> +					__u32 tgid;

pid/tgid or tid/pid?

> +				} task;

Please use another union outside of struct { ... } map.
Please see cgroup_iter patch for details:
   https://lore.kernel.org/bpf/20220812202802.3774257-2-haoluo@google.com/

>   			};
>   		} iter;
>   		struct  {
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index f2e21efe075d..d392b46c6d19 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -606,6 +606,21 @@ static const struct bpf_iter_seq_info task_seq_info = {
>   	.seq_priv_size		= sizeof(struct bpf_iter_seq_task_info),
>   };
>   
> +static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct bpf_link_info *info)
> +{
> +	switch (aux->task.type) {
> +	case BPF_TASK_ITER_TID:
> +		info->iter.task.tid = aux->task.tid;
> +		break;
> +	case BPF_TASK_ITER_TGID:
> +		info->iter.task.tgid = aux->task.tgid;
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>   static struct bpf_iter_reg task_reg_info = {
>   	.target			= "task",
>   	.attach_target		= bpf_iter_attach_task,
> @@ -616,6 +631,7 @@ static struct bpf_iter_reg task_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,

How about show_fdinfo?

>   };
>   
>   static const struct bpf_iter_seq_info task_file_seq_info = {
> @@ -637,6 +653,7 @@ static struct bpf_iter_reg task_file_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_file_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,
>   };
>   
>   static const struct bpf_iter_seq_info task_vma_seq_info = {
> @@ -658,6 +675,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_vma_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,
>   };
>   
[...]
