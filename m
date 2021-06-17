Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D63AACAB
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQGrl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 02:47:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59118 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhFQGrl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 02:47:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H6j5ut015871;
        Wed, 16 Jun 2021 23:45:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=s8b13FPNpBwbdzb/2Fxw6aA1zwZ1brUowS9OLF5A0wQ=;
 b=ghEFvJtLHQRsNgC6S+SUdGF4bbswZcegSgoldt2dY/F7VSZbWAmZ/4bfIdQUK/FSZeIi
 yUFfk5ZmpQ4VTh1vsUVsD3jEHIoLuJEQ3K8rp6y6otMl/+PKIv7S9UXJKuvy95oy4g3B
 Xy55Qj4B3946Cxdm5vdMBo+XlJocvgG9MNA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 397hbap1j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 23:45:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 23:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSMtGMRZ+ci2vEx/sRlklcj6qDpL9krFKO7IG4ENTTvOjvFn9DPU7Zw4CCgeU4dOy71Naw57wbkqvGU38kkGsMoq384l2HWYaq/FwOpaGXjvFEsdKqkH/HS8nTmrnTyHbUyrhlCTSSXTz9J1y4oHUuYFtppbUfQYxStmH0ynJcuyUexkGKH33AKwS4Z9roKfX1bWyqHHmZ267bg8AJFfSKBpKIQbLya/zc5aiFFLus+YBapN9N39jHLFYD1pIbliiyh5FJV+HxtMTaK6iUJQQqHiy9vDSRsLr97iNp8i0ctLWQeEUIcor8+rDccvyc3y9nSYb+y/3dSMjS9EQhGJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8b13FPNpBwbdzb/2Fxw6aA1zwZ1brUowS9OLF5A0wQ=;
 b=T8U3ehviVKoPTep5ShA4IGRLg6M7HXXQ5zQ4gFZ+g3u8tUY8ktW+ulJSA2dtu4wgQ7txIVolPXvazOR+gWEodkjbrRXNkJ09TbQbGoME2Rsf8Gi9hld5aKxZN7KA8u+UTqYGofrQp/HYfsqMTuApmITiLdQvoJ8IBh3p55VZiNvm3ftYqRFbkFXE2qnTZgW/fhaYc5v9Jzokk35tmaBc/c5AhD+sgAi22XIaTYVGyKMmZi9f6WRn1dUMfCyl9ZwsTvt5H4p1w7OfehRGiiBOaP8zPzCEMbUMQv0XniD9jB7sxNcR7odN4ggelC5iPifXciKy+Xcn+2ZPhJvLE1+uzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2032.namprd15.prod.outlook.com (2603:10b6:805:9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 17 Jun
 2021 06:45:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 06:45:13 +0000
Subject: Re: [PATCH bpf-next v5 2/4] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
 <20210616224712.3243-3-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2633327b-fe6e-d12b-ab95-bd9f11dfa67e@fb.com>
Date:   Wed, 16 Jun 2021 23:45:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616224712.3243-3-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6d3c]
X-ClientProxiedBy: MW2PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:302:1::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:6d3c) by MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.0 via Frontend Transport; Thu, 17 Jun 2021 06:45:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85af6dc9-b65b-40ef-0ed6-08d9315b75c8
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2032F8FD8494CA220E668EFFD30E9@SN6PR1501MB2032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThyQN8a4MxcEgPI/xC7L8V/l0ih+wdLYCWeofwSF3jtnAcEz+lDykz/a+nlt/fD5/DxTn1AG3t9njGcuKJmQVi487TiXds0YC0bflZMN68sJmEH5w0e+jU9zF32qRKT1BpgbQ8ZaicU85TH32ZTBWMcaIRKF9tm6MFwdywZ9wxgnO0H8WpoTejZcQpuWikwIrGmYb8Xuh67n0s8tjzMOc1lvQP38Pi27BRnFwJKmXT9QF7p/rE/j2uBxF77ieIYy+MZleKgokKAPW2Lezm975OVZk8YtFrWKw391FeStbDKn6haRaaC3eTk49R3smFPBnCsJfLwhow1WlUd+k2Y+AqF8tWsCKQfKDkOBZnUPTFepmu1s2T1WqaIs3wc/03tngVZsbjXpu9Wj399J7OSl3yxvu/oIZ50+Um2mJoeSfUYnb/3qnfcZ1aK5QqCHNgCKvFV6mUC8/i05K7KWQsXhQlANT8Ud17vciOdPvAi8jC4ehZX2K+vFZjNIXLUosGipPijxbKXsgTvCf1tNWWjccydm+sdrLi/uwfkM1lgZILrNGrqNaYiRteBt5ilmaSjan/nSWGzlhomffCgOg+MCL8ynW8sYGB0wQtuPsajlStU2Hlx9C2pOGT+HFgRbaPTsVjwUueRtD29QqogmBzns4xGDGr9D0Nbg9h4h7L2CnytRmG3PPHi5m56/4/Icta38
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(2616005)(4326008)(316002)(66946007)(66476007)(54906003)(36756003)(31696002)(66556008)(8676002)(5660300002)(8936002)(2906002)(86362001)(52116002)(478600001)(53546011)(83380400001)(31686004)(7416002)(6486002)(38100700002)(16526019)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFkaXJ0K0dwa21EeEJRUEdSRTBlOG5KOTN1b1RrY1lISmdES3R6WldDdlB5?=
 =?utf-8?B?RnJZWGlFcmppcmdvajFpakRqemFBUVJRM25vc1hlR0hieU1TUVl2MThJRDBH?=
 =?utf-8?B?SFlockdPaVVmZUFicDM2c01xTkV5Z3hkc3ZmdzNOVlR5QUdsY2xka1UzWnBN?=
 =?utf-8?B?RExvNFlVZTZyYTNGc2RUNnFmT1BRRkJoL0xRZzZWaTdxclRmY2grUnZGZUxV?=
 =?utf-8?B?YS91OXEzcTBmZkQ2UnBveitKUGp6eWJNSVdhYW1UYzN2U2o1L0tBMHRPNlBL?=
 =?utf-8?B?TTl2L2crZTFRT05hMkhwTVRib3dHbkJ1WDVjbkY4S2dLTnEySklFNStGaStB?=
 =?utf-8?B?WkpGY3FySkY2S0dwOVNVWEFMVW1QaFJKOWgrU1B2T2pzV3BKMGZnSVZ4RSsw?=
 =?utf-8?B?a1VnTDc5ZThpNndUbk1zczRwbjBsMWxXRWhYaXkxVDk0ZzlaeFZ1UUJUWVBl?=
 =?utf-8?B?TS9jYTRwdElBcCtNYm1MOGZKMzdvaEE2MlFIOEo2dStRQ2NUOEJESUU4SDlj?=
 =?utf-8?B?TWplSDhRQnhOYnZ1WXdocUFCc1dHckc2WWF6cnIyVDdhaEJFTHF5bkZIV2Z3?=
 =?utf-8?B?b29HRUwvOGdSalgrc0xSTEg1c01FY2MwVmVQaTdIRzVqTXJ5SndUWVpUNEFG?=
 =?utf-8?B?b1dHOHFyUlRYOHJkWU1LN2dBTGpOZ0FOSStXSDBuMkZOSVh2ckJXZU9CZmhh?=
 =?utf-8?B?U2pjZkQzeS8yUnd4aGNxeHo0Y3lrano2Zlo3NlJuLy9od0lhc0hnYStqWXE0?=
 =?utf-8?B?Szl0aWhBVStVYTBSeklvZ0pCbEJtQjkrRG01WGltTWZZR1RRNEdnR1pCQU8z?=
 =?utf-8?B?WHVFeUw1TC83MlE1VGpxWEx1T1dqQ1lvSEZleEN4WmlSNGV3cWk3RE5tN1NL?=
 =?utf-8?B?WmhyNWl3bHdzNGhwNWZmNjlaU1p5ZGhCckYxT2xNZktvenVXZzEzbXM5Z2kx?=
 =?utf-8?B?a2VYYmZmLzBsMlRwcXpuUkdDb2JGanpiNVJiWk9OUUtzcFY1MDlLOWdXQnM4?=
 =?utf-8?B?NDA5cUpyc2w1OGsreDllT2huME13MUwwSkJuY0s0S3FUNmcxakEydjcxWS9Y?=
 =?utf-8?B?R05sdjNyR3dxaTcvdHNUL2NuRHhkRnh3ZWNTbkFKczVJM0ZlTFVUVlVGVXZa?=
 =?utf-8?B?ZG00S2dDaEFFUTFUMWFaVkRPZGtZbzM2dXZna2FoYXdBMUlWZU56QXg1eUFY?=
 =?utf-8?B?c0VsWmc5QnZtR2ZiT2pFamtUTUtBYlM5aFVKV3FibzZwWFpZRjhUaHJnVXl6?=
 =?utf-8?B?UTFQQml0N1UrSkFZNWxSSzhYYmM1RWhXNmxlNmRmbVlkc0NmdTVZRGZOOE1l?=
 =?utf-8?B?Yk1SdUJ5K0Jkd01pSDRqR3E0TU1IQ0graDM3MDZ3cGxmeE1TcFpWNU9XQnU1?=
 =?utf-8?B?VE9NcDl0Z3BFT2x3VVZ2QWNEdUhoejB4RXQ1dmVJaVZYeU1mVDVNT0hIcjJq?=
 =?utf-8?B?WWFYRFRXTDRPMzArQytGT0pHRXdjME9iQXhqZzM4Ung2eHhIU1NGUHd2VmNN?=
 =?utf-8?B?M2ZYUjVDaE05ZFJ5bEVDTFlvMFRvWWRmeG9SODQxTzlWelVqa2p0UXQ5WTho?=
 =?utf-8?B?cUdiOFN2MzFDSmxqZU5jNVNmYVNuZ0x0SGNwUllyZ0VlZkltNjIvZVlOMUp2?=
 =?utf-8?B?Q1dMZFZhNzlLM0Nna3JlUEh3cXduTGgxcm5hU3l0U0dOZTN1Tzlha25wNmVu?=
 =?utf-8?B?dUdwVjU2T1U1czA4a3VCelVRVE0yZmZFUmgxblBaOEpkamc0enFZMks3T3NR?=
 =?utf-8?B?ZGp1Q0k5MklWUDJ0REk1V2FxblA1OElPWVQ0Z2ZRU0tKa1FDTmkzbmw4WnBG?=
 =?utf-8?B?UTRRMFdDTU5qS2RPSEdXQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85af6dc9-b65b-40ef-0ed6-08d9315b75c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 06:45:13.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS8SiVcQTRrSlazmLddXGjRmUf2AWXTGH8gZJ6sSBsgoxDyLyO5/ZPPh8FVU3sIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2032
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yK06fczYInMYB6QyKr0aNRQFwmzvdmrr
X-Proofpoint-ORIG-GUID: yK06fczYInMYB6QyKr0aNRQFwmzvdmrr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 3:47 PM, Zvi Effron wrote:
> Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
> BPF_PROG_TEST_RUN.
> 
> The intended use case is to pass some XDP meta data to the test runs of
> XDP programs that are used as tail calls.
> 
> For programs that use bpf_prog_test_run_xdp, support xdp_md input and
> output. Unlike with an actual xdp_md during a non-test run, data_meta must
> be 0 because it must point to the start of the provided user data. From
> the initial xdp_md, use data and data_end to adjust the pointers in the
> generated xdp_buff. All other non-zero fields are prohibited (with
> EINVAL). If the user has set ctx_out/ctx_size_out, copy the (potentially
> different) xdp_md back to the userspace.
> 
> We require all fields of input xdp_md except the ones we explicitly
> support to be set to zero. The expectation is that in the future we might
> add support for more fields and we want to fail explicitly if the user
> runs the program on the kernel where we don't yet support them.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   include/uapi/linux/bpf.h |  3 --
>   net/bpf/test_run.c       | 68 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bf9252c7381e..b46a383e8db7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -324,9 +324,6 @@ union bpf_iter_link_info {
>    *		**BPF_PROG_TYPE_SK_LOOKUP**
>    *			*data_in* and *data_out* must be NULL.
>    *
> - *		**BPF_PROG_TYPE_XDP**
> - *			*ctx_in* and *ctx_out* must be NULL.
> - *
>    *		**BPF_PROG_TYPE_RAW_TRACEPOINT**,
>    *		**BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE**
>    *
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index aa47af349ba8..f3054f25409c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -15,6 +15,7 @@
>   #include <linux/error-injection.h>
>   #include <linux/smp.h>
>   #include <linux/sock_diag.h>
> +#include <net/xdp.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/bpf_test_run.h>
> @@ -687,6 +688,22 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	return ret;
>   }
>   
> +static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
> +{
> +	if (!xdp_md)
> +		return 0;
> +
> +	if (xdp_md->egress_ifindex != 0)
> +		return -EINVAL;
> +
> +	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +		return -EINVAL;
> +
> +	xdp->data = xdp->data_meta + xdp_md->data;
> +
> +	return 0;
> +}
> +
>   int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			  union bpf_attr __user *uattr)
>   {
> @@ -697,35 +714,74 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	struct netdev_rx_queue *rxqueue;
>   	struct xdp_buff xdp = {};
>   	u32 retval, duration;
> +	struct xdp_md *ctx;
>   	u32 max_data_sz;
>   	void *data;
>   	int ret;

Let us initialize ret = -EINVAL;

>   
> -	if (kattr->test.ctx_in || kattr->test.ctx_out)
> -		return -EINVAL;
> +	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	if (ctx) {
> +		/* There can't be user provided data before the meta data */
> +		if (ctx->data_meta)
> +			return -EINVAL;
> +		if (ctx->data_end != size)
> +			return -EINVAL;
> +		if (ctx->data > ctx->data_end)
> +			return -EINVAL;
> +		if (unlikely(xdp_metalen_valid(ctx->data)))
> +			return -EINVAL;

For all above four failures, "kfree(ctx)" is missed,
I suggest to add a label "free_ctx" in later code and jump there.

		if (ctx->data_meta || ctx->data_end != size ||
		    ctx->data > ctx->data_end ||
		    unlikely(xdp_metalen_invalid(ctx->data)))
			goto free_ctx;



> +		/* Meta data is allocated from the headroom */
> +		headroom -= ctx->data;
> +	}
>   
>   	/* XDP have extra tailroom as (most) drivers use full page */
>   	max_data_sz = 4096 - headroom - tailroom;
>   
>   	data = bpf_test_init(kattr, max_data_sz, headroom, tailroom);
> -	if (IS_ERR(data))
> +	if (IS_ERR(data)) {
> +		kfree(ctx);
>   		return PTR_ERR(data);

		err = PTR_ERR(data);
		goto free_ctx;

> +	}
>   
>   	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
>   	xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
>   		      &rxqueue->xdp_rxq);
>   	xdp_prepare_buff(&xdp, data, headroom, size, true);
>   
> +	ret = xdp_convert_md_to_buff(ctx, &xdp);
> +	if (ret) {
> +		kfree(data);
> +		kfree(ctx);
> +		return ret;

		goto free_data;
> +	}
> +
>   	bpf_prog_change_xdp(NULL, prog);
>   	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
>   	if (ret)
>   		goto out;
> -	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
> -		size = xdp.data_end - xdp.data;
> -	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
> +
> +	if (xdp.data_meta != data + headroom ||
> +	    xdp.data_end != xdp.data_meta + size)
> +		size = xdp.data_end - xdp.data_meta;
> +
> +	if (ctx) {
> +		ctx->data = xdp.data - xdp.data_meta;
> +		ctx->data_end = xdp.data_end - xdp.data_meta;
> +	}
> +
> +	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval,
> +			      duration);
> +	if (!ret)
> +		ret = bpf_ctx_finish(kattr, uattr, ctx,
> +				     sizeof(struct xdp_md));
> +
>   out:
>   	bpf_prog_change_xdp(prog, NULL);
     free_data:
>   	kfree(data);
     free_ctx:
> +	kfree(ctx);
>   	return ret;
>   }
>   
> 
