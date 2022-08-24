Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050E5A0237
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiHXTmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHXTmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:42:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F86DFA1
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:42:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OIsx2f024575;
        Wed, 24 Aug 2022 12:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Oy5g1o0P1lGsRn1onWplxsKo9pWSGRBC8cctv+TlkZ8=;
 b=b5eR2RGWmGoGJkNbY8TjV6NtPa59KbujNfSR2shVh4nK/clCyzaMfpm4rfLHfFZQRXIk
 JWMTatWw5+C22VdKMi39Bz//fUJixzvUrdITBT0Mg2yBf05PfecTkIikk3omvbN+7Kr1
 U3EI4/iDwQ1JwRpPlGr7pTqkaoQ/StMhRZA= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5a8qwxq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 12:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw3lUUsf7JcC8KmkliZKL0L+M0n3QEe39mODyPm451h4Yh7aQWMlJq9q0rdsGFHqyhfZNsqVoB5wWlY6eMfCq5jUpa+MOVsr5QaBjFLw4KVC4V3ld4Sm5Sg8hZfpplgUoMR9W63uFVsQuS7LqvEVAKhYJ2/6uGUdXWse6WgEFM1wmPOiE6SpjI8uiW3Pb7vKkv0e/sr/cWNzKclNzooL4OD1/ygxCqWKG9vY2ub6JQ8ZLBAfrAXQh0j/9V7m+puh/vJAY0WiVEYVVNGrlkNDqXy1+TOHR58oUd5XcdUeOmGIiJk8VTQ3QlGrZRtICsW1fvRZ43aRiu5OC3QV0iiroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy5g1o0P1lGsRn1onWplxsKo9pWSGRBC8cctv+TlkZ8=;
 b=DVmrIBG1/H2UniFy+tu3ZB0jjCAqTSnH0+6vLk/loxiUKHFRb9WC40pNxsi1bvqd4g0GFj+S1skBfoR+m9j0degXBMnaMVcuKUr99ZvIujUvwsBHBMxKsEGNJZ5rSlpsjtTDkGcTC9MwXa3TrR9b9wi5BvzvH6FA2BvWtaNI6pzT2m3M+OqfqWSscxEVYQUfRlOOLVCkjK4Ha3hdfOq6xm/qRzGfKP4iDsc2BpL7FD9vrmGde5npUEXvNCRqeR76s6Oa5ENevYwegVBtKr6P4CPcU7ZvZY5jvYtZoFZ0iGIyxCmHcv+tBkxc1cJ6z7elCsTSY2qUObJfHwuUpqAyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3077.namprd15.prod.outlook.com (2603:10b6:a03:b1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 19:42:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 19:42:00 +0000
Message-ID: <ff82d012-55b7-216a-914c-5ed4666a53a2@fb.com>
Date:   Wed, 24 Aug 2022 12:41:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v6 2/4] bpf: Handle bpf_link_info for the
 parameterized task BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220819220927.3409575-1-kuifeng@fb.com>
 <20220819220927.3409575-3-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220819220927.3409575-3-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50806f46-b28f-4568-a1ed-08da8608b614
X-MS-TrafficTypeDiagnostic: BYAPR15MB3077:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZniwbc2YH0EJd9JbYlRskuYrOcFdbg2UejHHA+qAxO64/fCAmcMaKAxbqCr90Y0YSqtNVXz0VoN5hQg0SxcHJhftAlmSNpjnhVWxTH/on8Dmr/u+cF+m0+SfvTY+GqqLp4PhRt8v6ysJ5B7wfO0C0k9Z77mjJkHiwTIK4W7KHkLxXyENj8QxvWMIT0+7NIBTYYctY/VhrvXsJ2zTk5/dAYGlw8XbOo1zGx0e2imYADjkpLP2h/gAnCSSvr7FDGcRwQB0oDi58afq01u2U48uatgo78PnGEYCzxQmTr1DNjkclJPAymHRAnRA/3ALIZyeEkaiu2/Pio0xzWxW9/AGVSm0iU9zWCPGvnYNkC937lGEsKSaSjp0tr8XBwI2W6tQGn9nXJeJ4+R6q0xU421I4gWOHo3U90yxmHzJ/mynOEJIAgbGZr3TVTcBi2a/eC9WLPkxaf37iBN78XcP0IjCTkmsa2X+z3uvserk2Aigbc1iDyTzteLaWuDRrXglu2LnvewOT/dHwJhhFva+e2K9YwYvQ9xmlnXjHY9gdsuVJjcUP4Gl6vhnTEd6jK78JPuNsiHDYn0Ppt+Lk+TG7qPzH2jWxh7sHryPyAN96zaNU/KXqTBsPJWMimBh/PpRqeJp0mlMcstevKgXfLA8zc1q9zd/AnZlJ9CVESva0eQm1NBpDEd4ximlQxVOB7c9WIzo6U4HmFPZ2ipjo4dTQCExyGNL3yJJsTDXFG18mt80sZlF79n/PmgEqyn7JKiszysurhptjMETHAhnANLgXp9znsWBtRxOuwCq5KkV8rE9Co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(8936002)(36756003)(6636002)(316002)(5660300002)(2616005)(478600001)(2906002)(31686004)(186003)(6486002)(6512007)(38100700002)(6666004)(66946007)(66476007)(66556008)(41300700001)(8676002)(6506007)(86362001)(31696002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdnYmxHRUtYZWxuejRXYjJWZ2J3bS9uUjJpbUdpQXFPK2tDZUk2OEdIanI5?=
 =?utf-8?B?UC9MaGdSWU5VejZja0d0RStJdURUam1qRmJDSzJtaXhxMW5oSTNhS09zeEht?=
 =?utf-8?B?MW9JdS9ZK21tc1ZBQmxaSTllclk5Qkozb3ZuMUJkWnZJRXNIWlYrR2l0NUlH?=
 =?utf-8?B?Y0NIVkRMTzN6OGdUcjJBVVc5d1J4UzUyWnhIM0sra1h2SENiR3huZkgrVGJV?=
 =?utf-8?B?bkpUakZEZ2xkUnNiRVRlNy9JdllTcmlnejZsb3c3Q0RXZHlEUlIxZEdmTWRS?=
 =?utf-8?B?d2VjeFlwcEllVm8vUG9sWk1IUGtXSlZEc2tLUXZhbDl2L2ZRVTlqTVFXY3pG?=
 =?utf-8?B?VW9HV3pzdnp5OGxiaWIzdFZXL3VraFlMWTNHenQ3L1RReWllQm1yekhwYlJi?=
 =?utf-8?B?TkVkOVYyS1FXZFc2YW8zNXBUaTB4ZmZCMlZzbi9ZTVJiT1hlZ3lCZW1rTzFU?=
 =?utf-8?B?NDc4TCt2RHpnS1VlWG9iN3NaSUVKMkhxd0dhVzNGM3NmeW1pdVVLajIzU3Jv?=
 =?utf-8?B?aFlHYnF2OWRZQ1Ywb0NOZXAvcGFabnJPTGdFSDZ3cXdGUVB6SGR3MnFtZ1ZM?=
 =?utf-8?B?WmQrK1hVbXJTWjFiQU50L1RYSHFVakZidHJsa2JEM2loN3ZCRXBYc29yVlkv?=
 =?utf-8?B?Z3JJOHBSTExmd1QvV0pGTkM1blcrenZNcndpNEFoVW1HY2tqSzFCZDZyR24y?=
 =?utf-8?B?WVNLblRSMEhGdGVobjNTZmU3Z1BoeWZ3UlNHQzJYWmhjR0RIYUNFY3lPb3NJ?=
 =?utf-8?B?ZEFrZkpuZGZTenhiNjZJVGo4VVRFWlM4RGRiTUthWW4vUUdsVm5IVXozQlps?=
 =?utf-8?B?UDZ3WEZmdG9HT05jaTNoMGVjMXpYaVp3MHJkTm9lNEtTZjBVUnNPdCtrYXc2?=
 =?utf-8?B?WkI4MnpVV2p0eWp0SXJIN1NmQ0dMTndmZ29kNFJEWVUwTlE1Um1wYWROcks2?=
 =?utf-8?B?NW9kTWNXQ0ZDU1pHbEw3dUJaT2VGZFRrODdXaXZMOGVFSnc4K1UzQjlKZFgy?=
 =?utf-8?B?ZWZVTXBhV1VUbGdkOVV6U2VaMkhkL2hPb1dpVHJZVi92UFEwL2pHUkpydEhC?=
 =?utf-8?B?VWo3cDQxYVJSdHdJSnRzYVpUdlVaVVRhSU9pa2F3SjF3RExPUzJUU0pPbXR0?=
 =?utf-8?B?c0EwUnpsQzZONUwwTmlKM2h1d0ltd2RHZURhSjdYajkrOUdxWlNqS0Y4d1VC?=
 =?utf-8?B?SWZsNzg0WWRMOXpPNTJONEUzU0sweGxFSXE3aEVoQlJTalJLRzUzNndWOG42?=
 =?utf-8?B?cWFsL3hHK2h5VlFSenBwR0F1RkNjSWVGYW9qeGphRTFQZWdKQzVsY3lqbXFR?=
 =?utf-8?B?VmNyZ0J5azhKdDFoajAvWUZtdlRZNEgwK20vZGZrdDVqVTl6eXlHTlZQTU5J?=
 =?utf-8?B?OUJ4T05oVmRPSi9PTXB5YkQ5N1VOMlM5TU9tRGlFU1pwcldKSnZ0UE9SR1FQ?=
 =?utf-8?B?T1AveDN5dlpLK1lDbGpMZDJqYm1KVkNHNlRXMldmeHJkTVUvdXJnM29MMFEv?=
 =?utf-8?B?TlRidWxZK1pkajhyY2g3K0pDK3A3ZVN1clpXMWRrY2NSQkVFYjZENFA1WVVD?=
 =?utf-8?B?bFBqaXdoV0psUEpDeC8rdGpEVXN2RXh2L0s2dXZKWUpiNnJQVlg3RTE1NU9t?=
 =?utf-8?B?a1hKV2h4UjJiV3lTbUdwUHlEOWVBVGxVbUNwdGlsQVRBcWNSdzNCNmpQRFN1?=
 =?utf-8?B?VnplV0pqdmZham5NK2EvbG9kRnIzS256WFNjM0hyVE15MEFJREE2RVBFWEFK?=
 =?utf-8?B?eDFaaldOS3BFR2NqM1V6RXFKdmdEN3kzQmwyNHpJZ1RGeVlHd05XR0FaR3NE?=
 =?utf-8?B?TkRGYzRxc3I3MjBvd3BmeVk4QUVORE15OVdzd0o3bWdONld5N3A1NmFvZjNO?=
 =?utf-8?B?MXZmMGNkWmlkRVBXOGtUM29leGl2V0R3T09xd0I5V0Mzdnl4N0VCZjBPWVg2?=
 =?utf-8?B?WHFFR1p3MmduQjJwZ3R2RGM5S3JPbU1tV0xQRWVuemRjbklEMk0xeFJlQk5Z?=
 =?utf-8?B?TnFBTG9pQ0V2bVZ0UDluODl3eTNuSy8rM1ZVbU1WZU1xK3Z3L3NLODVCQzRE?=
 =?utf-8?B?djMvSHpKS3V5ZDlHR1FNakhFM2FkSkFmZXZUYmtFWWNVb0MwY29RT3lsMGVB?=
 =?utf-8?B?dkNjb2JDYzZuODVjR0tyWUlBeFFZWk9QMVk4ZEQvTzhqQktoWm5WRjc1ZG1j?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50806f46-b28f-4568-a1ed-08da8608b614
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 19:41:59.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s8frSKtjLVNd/IcxEfpr+VqApVLvqB0q5JWQn+/J3nbA+9OliG9f7Yw3p7Xb+Sy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3077
X-Proofpoint-GUID: fITVjM4MTRfcWXiTjq-G144OPi11h1T_
X-Proofpoint-ORIG-GUID: fITVjM4MTRfcWXiTjq-G144OPi11h1T_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/22 3:09 PM, Kui-Feng Lee wrote:
> Add new fields to bpf_link_info that users can query it through
> bpf_obj_get_info_by_fd().
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>

But we are missing bpftool implementation which actually dumps the
tid/pid here. So you need another bpftool patch to do this.
See file tools/bpf/bpftool/link.c to see how map_id is
printed.

> ---
>   include/uapi/linux/bpf.h       |  6 ++++++
>   kernel/bpf/task_iter.c         | 18 ++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  6 ++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 778fbf11aa00..6647e052dd00 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6170,6 +6170,12 @@ struct bpf_link_info {
>   					__u32 map_id;
>   				} map;
>   			};
> +			union {
> +				struct {
> +					__u32 tid;
> +					__u32 pid;
> +				} task;
> +			};
>   		} iter;
>   		struct  {
>   			__u32 netns_ino;
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 2f5fc6602917..927b3a1cf354 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -596,6 +596,21 @@ static const struct bpf_iter_seq_info task_seq_info = {
>   	.seq_priv_size		= sizeof(struct bpf_iter_seq_task_info),
>   };
>   
> +static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct bpf_link_info *info)
> +{
> +	switch (aux->task.type) {
> +	case BPF_TASK_ITER_TID:
> +		info->iter.task.tid = aux->task.pid;
> +		break;
> +	case BPF_TASK_ITER_TGID:
> +		info->iter.task.pid = aux->task.pid;
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
> @@ -606,6 +621,7 @@ static struct bpf_iter_reg task_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,
>   };
>   
>   static const struct bpf_iter_seq_info task_file_seq_info = {
> @@ -627,6 +643,7 @@ static struct bpf_iter_reg task_file_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_file_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,
>   };
>   
>   static const struct bpf_iter_seq_info task_vma_seq_info = {
> @@ -648,6 +665,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
>   		  PTR_TO_BTF_ID_OR_NULL },
>   	},
>   	.seq_info		= &task_vma_seq_info,
> +	.fill_link_info		= bpf_iter_fill_link_info,
>   };
>   
>   BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 7a0268749a48..177722c5dd62 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6170,6 +6170,12 @@ struct bpf_link_info {
>   					__u32 map_id;
>   				} map;
>   			};
> +			union {
> +				struct {
> +					__u32 tid;
> +					__u32 pid;
> +				} task;
> +			};
>   		} iter;
>   		struct  {
>   			__u32 netns_ino;
