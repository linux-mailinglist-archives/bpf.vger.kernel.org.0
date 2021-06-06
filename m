Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E497C39CC6B
	for <lists+bpf@lfdr.de>; Sun,  6 Jun 2021 05:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFDTN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Jun 2021 23:19:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44804 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhFFDTM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Jun 2021 23:19:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1563Gb2A025895;
        Sat, 5 Jun 2021 20:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PTWaD6aa5XhMm0GCOmNoc+rbOlzD+F6wQna6ogk6A3I=;
 b=UbE4cdR4Bpydjylw8zLD6l2LCXrJlYUlK/6N+YyafxvZ7OlaGVyEFKQyTMNNzdlCcULS
 4h8afqj0TSJrVVLY33tG9uq30j5N3cGtp3bq6UKbPjqfsP8652vLfEtPHpSulmELsILQ
 EDS+HPLeSYAbs6mFXlRDQAt3TgR2iVeu6Mk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3906sx2vsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 05 Jun 2021 20:17:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 20:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9hqrkGC1z/5CwZCsJBL+6QiwElnjd7vbjE4f06/lVpdFtoLkMrY5Un8eWnu/v5Ba+DVe8kWDKkjQMdQc9de+RJXT9LIaHo7uOE0ybNfrXBMHSKNpbCb4Ozy4v/yoFrfPeeE+9mHmBNEtpCP5lEx5brSHBIBwged4+uqC6bEscuvugd+JiFJCqNGWZKLc/dTrtUun/G2IG2vV6w8Xn917IZzWoGFJzy82J8lbAiOsukOa3JA4/LiU7ivhk6BGBKyVi96+/BMPSA3YLDw/FtrEZxW6AMX29OJS7unVYTDnoM6+3s9Kvfg8PCbW5JSh+NNsY1OGGT7vztg2O7FLyvNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTWaD6aa5XhMm0GCOmNoc+rbOlzD+F6wQna6ogk6A3I=;
 b=NhIQZPKJmN4V9XafOQOeCendEzYKiASZvPV0zulHCX/LIXBbXZEZBAQo8rPWc7LtrjEPNLiZeNELnV3WXr2dBGQ9oT9OU/+uei16hw0LKgS12S7LYVuFSnQjUTE2phAwjEHqaJNCvtp3QKu8B8TdSmWhPxl+YJaR6fF9agAimSxH1sAbK4ukJr5tE0Z/7iph4mnyxFN0KmxB8zfYb+JXimHdGtCUif5rE8GOH3R+1MxTeeNroHl41x4GnuzJrgVcYfcHbonoQa3VF4oynn3Tomo8K8blOf7xgsEiTRNoZnQgTjcOtTvUUO18BlhhLWpTIhc7lNXZboxHkOwYXjcfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5032.namprd15.prod.outlook.com (2603:10b6:806:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 03:17:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.026; Sun, 6 Jun 2021
 03:17:04 +0000
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input xdp_md context in
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
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-2-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
Date:   Sat, 5 Jun 2021 20:17:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210604220235.6758-2-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f8c6]
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a79] (2620:10d:c090:400::5:f8c6) by MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Sun, 6 Jun 2021 03:17:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7385141-36d4-40c0-9f1d-08d928998ebd
X-MS-TrafficTypeDiagnostic: SA1PR15MB5032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50324A1E298C2BA1B4D9E951D3399@SA1PR15MB5032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFry0IkgfRNkqJd2xjkLePfdofUQBLpZF+fbhNPfDdWNetKULhW3TiKUSBx60fXbe/TRLFz42x6GvhfJkHKhQL5gkAhettKOIyRevzCTDoPExP45ayacnxPs4ExFvcReYKB4f/engQ6rVsEBh7AcbcETEgrza/eGnpiJZJZyF57k4Ethv6fnqmnaPUdj+U8UnfnlW87Pf83FXTvrkgmP6CJtLiEp6XS7jNYA0PYlZdj5q+WEyN8RgFKqbEWxB85zTNIGk8SgwBMdW0N48kHPvCVL1W3dh6xyhfn1XgsrPFuSoAjqKFP+H6YyKBtRmglwoGYqjL2tuRVLLO9zj0LpmwzFPbiG9YdNGoR0wa0AVKrAGJJySEo9/2+mJ6ciRT/EfSbws/ii6ui8J7jnWadcbkVXaxz3BRn3agYZp9PXPto3haDjWcvg8+xoFkmkrHlLeeClmo5EmEbqwIokKZ8f5yZW0oT7BTI3doBB0oyYaUvGpGt7CyoXLiLC3AuN7WogUbsf/WFdQkFNm0/MZ+32I8mHkUH0BfJ4dQ0XEYHkY5G6oszlM/5yDHnuDCLfl8Lf+FwpLtpHJrGahIZXw3DdQfJCkw4psGXFw5VIqITz/GoqJZV1hPi/IOwaIlmd7ISYYFEMI0RhsCMalE/6kv8WqUuSE26LAlMRVjiZmNvt1It43WOSjMy/3RPBIiluOo5d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(316002)(6486002)(54906003)(8936002)(8676002)(52116002)(16526019)(53546011)(186003)(31686004)(66556008)(36756003)(31696002)(66476007)(5660300002)(2616005)(86362001)(478600001)(4326008)(83380400001)(38100700002)(7416002)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1pjaDloOUZrYllnd3p5UHBpUnpEQzNvekxlTHBGM1RGQ3Mzd3Z4WWdqZ0Fq?=
 =?utf-8?B?VFpINnFpVzliREhUSVFXVnRzSHh5ZmpRM2VKS3N0VXJRaGplUjhCREQxUzZj?=
 =?utf-8?B?czgrSFkwSm0rMkdhSHpzSWxXWEl0WEZKaGZldDhUV3MwcVBRL3ZTdHFMZTI1?=
 =?utf-8?B?TWtQOHE0QkxtSFliMVhGZFUvQlI4NFdSbEl1c2VBTEtvTHF2cFFXTmFianRt?=
 =?utf-8?B?bURhaDRXN2VzcEZOSDVsS1oxK1luVzIvaWE3b1ZWV1RmRlFoaGlqUCtDaHJE?=
 =?utf-8?B?bEgxdm5BMDdqRG5DT1ZsSGs5YXB3VXBaYWZXZ2VJdllhdUhYNEp1dUdTNkVE?=
 =?utf-8?B?RSsydHhUQXRtTEpQMm1qNmxtRlc5SFgxYUdPMitiYktLelBhYnU4SFN2cGpW?=
 =?utf-8?B?TVkxTkp2Vzg1UWliV3hLN0tJeHFnUEZzdFN2RzJkdWdXcUpDWHhCLzd2RDdT?=
 =?utf-8?B?ajBOL2dWeEVWMllQWlN2SzVLcEZjYS9rSTR1OUVFZXNsQlFhb0JDbnh2UVJX?=
 =?utf-8?B?SnBwMjJtODNqajR0NXh2d2lzRmtDQnNycEx3R25FL21RK2ZWTldEL3B1M2pE?=
 =?utf-8?B?N2J3c0Nyc2JYcEVWaEJyc3dncHJCTldMSyt5OWVyV3lEOWJ0eUFxbnpkL2NX?=
 =?utf-8?B?MUc3ZzB0L0ZnNzZBZUJxUDd6NlRLUFo4RFJyNDFiMmxZMlZPbTU3blhuUnFx?=
 =?utf-8?B?Y1BEMEVlcVpqYURIRS93YWxKbjZwSkhtbWFBWW9QY0VadlpQdEM0ZlNpdlJV?=
 =?utf-8?B?bi9GeHB1bFh1L21GVDNYNTVVNDBXbTd6UzEybms3V0c0a1BjdXhyRS9XUUE0?=
 =?utf-8?B?TGVWUHVUUWZ4YVBwWE5HSXU3YTUyWDZIdEwzUjV2dGpIaXY4VUFZcEF4Q1li?=
 =?utf-8?B?eVhGVUpzbXE2d1pJbmhJajI4ZFh2azgyUHpBdGdCNDVHWE9TWFRZMzVWWmxU?=
 =?utf-8?B?SnNuVlo1Nm1CaVdXYVBmZ0g5S09aSXdSYnBWYWc3OVBHN0VOWUNCMkMwUmJK?=
 =?utf-8?B?TDFsYVRMcHBmNzAzOTNaV3R3Ukx0YjJYR3dDbDRscERpMHZjSnc5TjI2WDNF?=
 =?utf-8?B?SHljMjhpaWRxZzNpeEVVMGV0VEtzaDltTGpZK3NEdktnazZ0R1pjVW42UG5x?=
 =?utf-8?B?MnNrMUNFN1kvb3N4NFg2MWRPRjNLUHZRYlgrV3pEeVBpL3NSMUVqYis1QjBS?=
 =?utf-8?B?L0VwS3VGV2dWQjA3N3NnYzhsakJvWVhqTjhzKzgydko0dEZyTHhtT0p5Nk01?=
 =?utf-8?B?YUJWZDIyK1lYeEcrZmpVREc2NXEvaDAyTXVZbXJncDhXdkxkbCt1MHRZc3A5?=
 =?utf-8?B?Y2RLOERwc2pLRHJCVm1Db1MyQi9GNTM3cHB4T2ZsZmlVSnU5ekZMZnQveEdh?=
 =?utf-8?B?T0JsRzZMNEVqQnZ3dWVQNklwQk5xN1JIbWNSbFgvQTlIY2JZMkpiZm5VSk5N?=
 =?utf-8?B?Tmc0VU5waHNKODMxZDl4ejFGU0sxekRoRStUTThmSlphRVAydEJyNExUSGdr?=
 =?utf-8?B?TFdFMGpxWGRUVTUzY1hxeWJGeWJ4Z0twb1EvS3lCRjlzOHIwTUV3cGJoa1NB?=
 =?utf-8?B?eDlISGQ5eHhzRFBSMno2azR5TXZ5NjZpaHl2ZC85a2JkckJVdlNybkI3alpU?=
 =?utf-8?B?MG5QWDI0L2J5azE0bHJ0S2Yrd2RsS1NSaHMvdGRyVGJiRFNPYnNNUnFWUWta?=
 =?utf-8?B?eXlUaG9ndnZUaWtWQ3BwcStCaWt5Qm1JU3E0UStnK1JKL0M1Uis2d2M3MHpw?=
 =?utf-8?B?UERWU2Y2RFZQdjBldHBKR1RHQXdQaUJVRElUUnFnMTNiTjVQRGNiUFkvaUxi?=
 =?utf-8?B?S3hSVmpRQUo2Tlg4amZpdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7385141-36d4-40c0-9f1d-08d928998ebd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 03:17:04.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A18dAb39IOhehT9ZJ/2gp/x7wTyhwMEJS1AhI5iA00+eQxTC041K5ysONiNSy31O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5032
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ihbBN9pNqk1CIWKPLDJibuXqag6JXRkn
X-Proofpoint-ORIG-GUID: ihbBN9pNqk1CIWKPLDJibuXqag6JXRkn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_01:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106060024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/4/21 3:02 PM, Zvi Effron wrote:
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
>   net/bpf/test_run.c       | 77 ++++++++++++++++++++++++++++++++++++----
>   2 files changed, 70 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2c1ba70abbf1..a9dcf3d8c85a 100644
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
> index aa47af349ba8..698618f2b27e 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -687,6 +687,38 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	return ret;
>   }
>   
> +static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)

Should the order of parameters be switched to (xdp_md, xdp)?
This will follow the convention of below function xdp_convert_buff_to_md().

> +{
> +	void *data;
> +
> +	if (!xdp_md)
> +		return 0;
> +
> +	if (xdp_md->egress_ifindex != 0)
> +		return -EINVAL;
> +
> +	if (xdp_md->data > xdp_md->data_end)
> +		return -EINVAL;
> +
> +	xdp->data = xdp->data_meta + xdp_md->data;
> +
> +	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +		return -EINVAL;

It would be good if you did all error checking before doing xdp->data
assignment. Also looks like xdp_md error checking happens here and
bpf_prog_test_run_xdp(). If it is hard to put all error checking
in bpf_prog_test_run_xdp(), at least put "xdp_md->data > 
xdp_md->data_end) in bpf_prog_test_run_xdp(), so this function only
checks *_ifindex and rx_queue_index?


> +
> +	return 0;
> +}
> +
> +static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md *xdp_md)
> +{
> +	if (!xdp_md)
> +		return;
> +
> +	/* xdp_md->data_meta must always point to the start of the out buffer */
> +	xdp_md->data_meta = 0;
> +	xdp_md->data = xdp->data - xdp->data_meta;
> +	xdp_md->data_end = xdp->data_end - xdp->data_meta;
> +}
> +
>   int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			  union bpf_attr __user *uattr)
>   {
> @@ -696,36 +728,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	u32 repeat = kattr->test.repeat;
>   	struct netdev_rx_queue *rxqueue;
>   	struct xdp_buff xdp = {};
> +	struct xdp_md *ctx;

Let us try to maintain reverse christmas tree?

>   	u32 retval, duration;
>   	u32 max_data_sz;
>   	void *data;
>   	int ret;
>   
> -	if (kattr->test.ctx_in || kattr->test.ctx_out)
> -		return -EINVAL;
> +	ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	/* There can't be user provided data before the metadata */
> +	if (ctx) {
> +		if (ctx->data_meta)
> +			return -EINVAL;
> +		if (ctx->data_end != size)
> +			return -EINVAL;
> +		if (unlikely((ctx->data & (sizeof(__u32) - 1)) ||
> +			     ctx->data > 32))

Why 32? Should it be sizeof(struct xdp_md)?

> +			return -EINVAL;

As I mentioned in early comments, it would be good if we can
do some or all input parameter validation here.

> +		/* Metadata is allocated from the headroom */
> +		headroom -= ctx->data;

sizeof(struct xdp_md) should be smaller than headroom 
(XDP_PACKET_HEADROOM), so we don't need to a check, but
some comments might be helpful so people looking at the
code doesn't need to double check.

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
> +	}
>   
>   	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
>   	xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
>   		      &rxqueue->xdp_rxq);
>   	xdp_prepare_buff(&xdp, data, headroom, size, true);
>   
> +	ret = xdp_convert_md_to_buff(&xdp, ctx);
> +	if (ret) {
> +		kfree(data);
> +		kfree(ctx);
> +		return ret;
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
> +	if (xdp.data_meta != data + headroom || xdp.data_end != xdp.data_meta + size)
> +		size = xdp.data_end - xdp.data_meta;
> +
> +	xdp_convert_buff_to_md(&xdp, ctx);
> +
> +	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval, duration);
> +	if (!ret)
> +		ret = bpf_ctx_finish(kattr, uattr, ctx,
> +				     sizeof(struct xdp_md));
>   out:
>   	bpf_prog_change_xdp(prog, NULL);
>   	kfree(data);
> +	kfree(ctx);
>   	return ret;
>   }
>   
> @@ -809,7 +873,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   	if (!ret)
>   		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
>   				     sizeof(struct bpf_flow_keys));
> -
>   out:
>   	kfree(user_ctx);
>   	kfree(data);
> 
