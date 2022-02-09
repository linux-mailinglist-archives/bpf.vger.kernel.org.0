Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F94AEAED
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiBIHTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 02:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiBIHTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:19:11 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A60CC0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:19:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218NebU2022307;
        Tue, 8 Feb 2022 23:19:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TKfpr65R8Yzitq3WSv+P3GAvnyp0k2lPcl8ygh34r5M=;
 b=cYsAhxCb1HO5LvnyBraPaWsudcclEWsC5VX9xl9D690v15+Ol8Hb49zUfZhq3dAD4gzp
 vsd3a5hBbFUegjV9iiphGlo/81YiRRETsls2X7g9lryrR2wzfjwN9WMUr/vmt8HsX6w4
 HNDvnJNRHfSOIFBghacwNfV8n+Tq6QbKl0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3tybdmu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 23:19:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 23:18:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvBQGs3HyPc65s00jKZ0dmom65h8G5cJNacMDjfXZw7OaB5pBElhHJkD9jZkLFXuVPs+V90lIPFED48HlF7oWSnbK6qojP/z3MUwY8h69MsiG31ZUfxGRTzYl/rVoMbvXFHcvXI25zbYvy1MKUQed0WZjPssKgL8OTZf0xN9VhjWgA+eTEIH1Q4Ob3bMCDG6h1brWCvEmbG09ZcvJguLX3DrJOszx28Fd364esFndN15gDyqAZOKX7Ooib1oueb5r9U7WY1p3UmGXyT308i12osc/rbwM0BJt4FOhPE7zphkrXayOSDV1UI4hp6nOX6LTBpSLNtczsVU1qzXoMbfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKfpr65R8Yzitq3WSv+P3GAvnyp0k2lPcl8ygh34r5M=;
 b=nx07dugg9fOpxr/6iypnCxh7omA+mXS0HfhvDRq2RRiGu2069aKyZZCcduU3ucH3JYSXVFp6XXtNYJdPH90moeTXdf4VUKE2jVhwkCQ4OhTkSIvOm7NNjfmBtuw2gOOGSNG0iteQ3c2+lLFYWB4oQrGcjWZ/ZtvGGp7yvkMbhk56M1C5sLcuTkmLScMNhPRqIJuAVXgt4YaYgXcdOQaGw/CRpyvm0Pr993SIUhluOeVLhsmIg0RKbxfMLuN4nB2xsO5IfWkyfPODBJwXv2U9rQfEnONAfoGREAV4+bbVIedUSHf5asfZhTxbLqhhmQ4IsjX0ptr00J4VSlYGtqSxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3627.namprd15.prod.outlook.com (2603:10b6:5:1fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 07:18:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 07:18:51 +0000
Message-ID: <00d2caf2-27a8-b46c-060b-dde41477526e@fb.com>
Date:   Tue, 8 Feb 2022 23:18:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next] libbpf: fix compilation warning due to
 mismatched printf format
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20220209063909.1268319-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209063909.1268319-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:301:4a::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec9ea24-5ca8-47b3-6ef4-08d9eb9c6c24
X-MS-TrafficTypeDiagnostic: DM6PR15MB3627:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB36271920430864B12370C667D32E9@DM6PR15MB3627.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/Eiw0UQ8cFX+fL2dBF5dLUx5YTwfm0Ml1n4Qy4IkSUUbux4l3JNHfl6mQYKTEaPW/nea2RCty6ptBhDYk2Shq/NEmvmq8ng+eIR0KogTgi4EehU/7YxE+SPPyrrO9NS5FWIoaC/ZAX1oLkA6xkM1V43aqIzWLC+FXwzqg/ZELbCKsZMYs2bJSLFcSKzwu/WFjV+1TbT0c1GJouJQz6hQrbbiBGgr0Lt8zxLk2QQQWzscYHA1caX+i133+Vapo9xPa/2dxZzsVLRP1LRmg5npCU3Bl7dUaD0OqxF53L4oPbFOXdNWoe4U1hnrZbL7g/ZcvGp2mB/5KXis+mX7pWsBA8qJcCtj/nsZSM4saNwBiJDJ+bcpJ37esA9PMD8bJpMGP/66vMDrJjDzWKDXfatZrt/86mifGiHb7KM5zgGcz39EGYM2zbztoswxXySlJ1PZ7A1wNt9dBY2xSBxNsHLZC5e7Lko6peMjkcsvBj6a9C5+DRo18Cj9vPasOqgKbiFT4gDqUSCGV0HLXJ8FWLuCnMLebnC15ECjVsSskKa13fEAX6iJjx5eBT1SgyvyS3Yke/JQtIoo3VPFH/kOgyzqpuoMFarQIkNAcuIW9kGhk9pVBUX1FuL4ef4Fl0COGOwRs9oqCv9wCIPjxEzT4WSAt9rLci2yA5yjcgGn6cvxxzaNFMkEWKpolPe1oFsRkwWYajJzESjsNU3JrA3x0OEKooo1O3NueJaR+AG80BEj4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(31686004)(66556008)(8936002)(66946007)(66476007)(36756003)(316002)(186003)(8676002)(2616005)(4326008)(83380400001)(508600001)(6506007)(6512007)(31696002)(53546011)(86362001)(52116002)(5660300002)(2906002)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFvOU9OSXd6Qjd1SlNNbTM0NUNpTkt5dFIrUG52OUl2eVpwSnY4dmszTGQv?=
 =?utf-8?B?aTcvWjkwNGpkTFdpbHZIQjBpY1lMVHZZK2YzMUtxY1JZNEpBZXJmbkJEL1VX?=
 =?utf-8?B?bTFQL1l6QlhyeVdQT0psUmJZVlBwU0ViRXBvdTdTMTFvM1BQZW0zQTNaayt3?=
 =?utf-8?B?QThVZHRlaUJ5QXZZMmhqZGxwU2lJckNlQUJYZUNzc0VkZFNNYisyclFVUld0?=
 =?utf-8?B?U0I5K3lyd2c3RGJIYTZzTjMvMDRmR0xDVHZaRWJyVVVud3F0K2ZNTC9haElE?=
 =?utf-8?B?S3JUSTM1MkVwdytnUjBCZ21zUG9xaVEzNVYrdDd2OStwR3UrY1hWcldWRk94?=
 =?utf-8?B?RFdBMUFVK1JnU1U3TG1qN0h5bHdiM2JQVlBKNmc5a1pOOFo3dy9LcEVCalJm?=
 =?utf-8?B?b3JZY05yelI0M000QzQyS2MyVzVpWldDd2NQb09VTVZTakoxVmtlRWZyRE1Q?=
 =?utf-8?B?OCthZ212RkoyMjlqM2xZVHJ1Wk9jMGZSdkRRd2NMZUZOM2lKaUNIeWZJSlJm?=
 =?utf-8?B?cnBOcjdsMTU5dnJZZ2hkU0ZNQ2E1QklTWkFFZExkVTNkMW0zV1ZEN3gyQjN2?=
 =?utf-8?B?S1RaL3hSZCtYc3RWTlpyRitTbHJ4V25BQ0hOV2F6T2V1YjFLa1RDeVBnRFFF?=
 =?utf-8?B?OU9SbEtmTTdFdDJEay9hcFR3Slhza2hHRjFxZ3BCVDJqUFNiK3NvWklJa0Vp?=
 =?utf-8?B?NWQ0ZXVsYVZaV3FleEZ1RTNMQUdHVjc2YWZiT3JWcmtXNEhoNHlobFREeExu?=
 =?utf-8?B?NERwaHVPRTZibkR6Sy90d2JLbnJvaW5VbU02SlI1S0dxT3dzQ1BNZzhUQUFm?=
 =?utf-8?B?aW05ellqWmZJN01telJiWXVPdktkY05MUTVabXFKVXlPZEI0dlJPaU8zZ2tr?=
 =?utf-8?B?bi9XVEdJM3MzMzNhK2tQUEhiS3I1dVNyaVhST2x1ejRLNGZUeTZQdStqNW9F?=
 =?utf-8?B?SFNCSEVMZHJnUkZhVTZjeVpIK2Zyb3JWRkVDc05DNWNPTEEvQldlWkVBV3p4?=
 =?utf-8?B?Rk5NY0Y0RnlCcUh1ZnVTZDVvLzhSR3RGSWxxNEhsaXRXR0ZQSGZHZUdsSTJX?=
 =?utf-8?B?VUtZNXpwTE1yd0JWckhsVWNtR0w2dDRYem1FOUVGbU96ZVBhRCtmcWlkemVS?=
 =?utf-8?B?L29tMDRXd3dGREFjSzlnSHR3dFR6VzZyZXl5Wkl6R0s5ZU5rYVl3U2d0eTZl?=
 =?utf-8?B?MXhuRHFDSnBucTR5dUNQNXh1cVpQdVJDMC9LMnhDalNObG1iN2Q1Yjl5Z3g2?=
 =?utf-8?B?NGRSb3Q0WnNnNmpzYzd2VFpVOUNBZnA5WlZLa3lHUDdZWlRvNk10NVhVOU9o?=
 =?utf-8?B?MkQ1c2F4WEhhcU90TnJ4ckJiM25JL2pwUHVFT3AwbG1JRXF4MkpjVGFNc0E3?=
 =?utf-8?B?dnp3NU5FNFcxSmdSTm56bTAzYS9iUk9DQVRWQ29JMG5NZXEvRDVUVXdvNUZC?=
 =?utf-8?B?YVpxdVAwTTNyUWhFdDNaL254T1VWVGpnZENSaUI0dXR5ckk2S3crdXBydldO?=
 =?utf-8?B?WktUb2VHWmNER21tMTRaQjhVcFNpVEdJblNsWWFTKzNKVU4rYUpYL2NrN0JV?=
 =?utf-8?B?TUlVdmRuZGxCdzFJM1NJUDRCclVLK0wxbkYwU2ZYSFVySEJ4Y1pzZkxsZndI?=
 =?utf-8?B?dmRoQWFIMmh5Rlo3TmtGby9USTBINlNaemdjQ05xSURRa3IyWjFKcUpVYXhV?=
 =?utf-8?B?cWpRK0xsZTRFUDRmV0VEWlU3dDBkK0QwWVo4bUJmbnh0bG1Hb3dXS3NMUnFN?=
 =?utf-8?B?RzBDMWZxb1V0Mk1lYmdCY0RDbnlEbytvbnI5WlNzMWkzdndCWnl2UmhBUGdQ?=
 =?utf-8?B?eFpOSm9WODdBWnpUQ3JqT1pYeVY3SmNLZjlLc1B4N0t1MHZOVVcxbVMrLzFS?=
 =?utf-8?B?NjUrZ0pxRlFRUXNmS1QxMUd4SmtCRldMNVhyaW5odTE2K01XaGswZmNrUFRW?=
 =?utf-8?B?QmoraWlZRmJOUGhrQWgwMXR5ZGttQVl6bnpJWGZFNmpTRmVNNXZvaDI5NTMv?=
 =?utf-8?B?RVM2ZkNMRFF6WmgwZ2Q3aVUrendvcGZqdEpwTUtXbVh4ZDBJMkxkRkJzM2Y1?=
 =?utf-8?B?UDZIT0lnRG5pc01jN2hyV3Z4dm80VzhxczlpMjhGSk5kRlFoc2NwR2kzMUpC?=
 =?utf-8?Q?qLVc32uV2lzfHrzxG8UqqxdQO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec9ea24-5ca8-47b3-6ef4-08d9eb9c6c24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:18:51.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAMSY8FvxsuQAlOgiuJ51i+jqtrNXDaVjR2ar0LjbfF9Rlc4kL0sQgCKDtp8kXF+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3627
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pCLlqN8ar3R3mkBy3I-OgGTLCYiIfKEv
X-Proofpoint-GUID: pCLlqN8ar3R3mkBy3I-OgGTLCYiIfKEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_03,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=992 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090050
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



On 2/8/22 10:39 PM, Andrii Nakryiko wrote:
> On ppc64le architecture __s64 is long int and requires %ld. Cast to
> ssize_t and use %zd to avoid architecture-specific specifiers.
> 
> Fixes: 4172843ed4a3 ("libbpf: Fix signedness bug in btf_dump_array_data()")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/btf_dump.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 55aed9e398c3..07ebe70d3a30 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1869,7 +1869,8 @@ static int btf_dump_array_data(struct btf_dump *d,
>   	elem_type = skip_mods_and_typedefs(d->btf, elem_type_id, NULL);
>   	elem_size = btf__resolve_size(d->btf, elem_type_id);
>   	if (elem_size <= 0) {
> -		pr_warn("unexpected elem size %lld for array type [%u]\n", elem_size, id);
> +		pr_warn("unexpected elem size %zd for array type [%u]\n",
> +			(ssize_t)elem_size, id);

Does using "%ld" and "(long)elem_size" work?

>   		return -EINVAL;
>   	}
>   
