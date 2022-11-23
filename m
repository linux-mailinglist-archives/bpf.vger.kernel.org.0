Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133D63630C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiKWPOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiKWPOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 10:14:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752F898E8;
        Wed, 23 Nov 2022 07:14:32 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANB64ki016431;
        Wed, 23 Nov 2022 07:14:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=TLjmGsk3FZKX1evafT4YMKp4dx8i83TjjVSOOgudRjE=;
 b=Ve3wX7bezfJw81APvmTO3tF6ztnSh0w79RcCQ+wncQxAFfAkw/sKaNB6TT0YXZfVmP/6
 8DcrEWfxJ6GD/PcBbiMh80+u4aWvqfW/GfzEpvuNIOgdzhcpoMSCueHP3KWNV5Mu4K3t
 rLXJFXXebdSfY+bRsJv7CZ97GdUSOk57IZxV9J13TedoT14Def9DlFFWqx8GnYCXFGK7
 jC1UA4Sq9UCBHLplcSzhGeqaJFk2tnQbo6b8cJrin4HzRueCyd8tbvnb04zfBtdWf+3O
 BFYiRZ0oS2IgcjoFsrQP/YFHlKw5OzMjoYfLglOLpDg6FNnEduK6jfi04mpB3CDsW0pK GQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m1cg3kepw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 07:14:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmKbxroK+G2vudkyczSZzk1CVGqlgnS+jPn0uSk14X/DWVDF3dBXqdhJahYCNTlW8Mh39nFy6fot8nQn1lYFJKdeWosrYTw8hWIwViixmWjCSZ3AaLMt3iIIssgE+p+kamA/XRb2WJkvKQtmUySG5+d9utGA50/K8EzayMN50c86+GTUWuugzo6FC/kvX3emaobo95ZAvRyJTPlLvvoBwAu4xSDplsldEUuO1MW35zfCsEQOj0b+DdZFAa5fu7O0Rk0I9Gg0J2RqhNukxDFhha4hawIRRFNU+D++Ggq5sy0bW2Uz2e50cQpo2jxiwCDFgI8orPE4fDXaNOdeMviyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLjmGsk3FZKX1evafT4YMKp4dx8i83TjjVSOOgudRjE=;
 b=UjTs5rMDMXKVKFhpHTIyHlIHhxiaUAxxt8xRpixwH+MAjgSG89Wcd/10pf/ytDJIBQJHz7qt2dVFzHqppZvuI7IKG3OxWZLPVvCEbljXGC71ZAEIe/t6RGxM1fCibKDX5NNk5a0hNKF2NtwA+/HnV8PlNlxdZDT7MbwkXNYVWIQLCODIauy+DlBXhIhTGht5ZGrcgT1l4Achw37rTFmw2CKgKiYiyYiTSFC49g5WH07qIkUf1zKHk4zVlG2SpIcuOeee6cmAyb8rx+agVSXWTEcwEXeCAeLDUZE9G/XfTdFOKjWnQjpztUbVj0C5FvWOLhczzGeK/ZJDGOaCyilOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL1PR15MB5361.namprd15.prod.outlook.com (2603:10b6:208:390::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:14:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 15:14:07 +0000
Message-ID: <0cfe0b93-9f35-bdca-96af-f11593832037@meta.com>
Date:   Wed, 23 Nov 2022 07:14:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] bpf: Don't use idx variable when registering
 kfunc dtors
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20221123135253.637525-1-void@manifault.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221123135253.637525-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::49) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL1PR15MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a2a0e8-3baf-44b4-7fd9-08dacd655d85
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS0Xik56PG9n9uN+yhz9T/t+8QvdcZrGI9u2iaW72wHM7pO/dfCv+8G87qH9bwVJ8pL2+V8QWBeP/7OUtvtzaQ8MCz4VppyAz16HJAPgCkLY2oW6rvuhCf9/OsOt+xVO9qN8QC9nsrgAi/vHopEAHZaQIGvo+TOjx54o85EzlST3JWqaU7GFgBOMA+vYJKjKGJeVcuCPrZNCv8mUkmW8rDtU4PzN2i/arTdNytwk0v3KdYt9Z/2HMAQMLI2AXeptH5dK/upk2IvdbIRsKW3975wBo/Buv7EJhYnHpQnMHVpLl4UnIPb+IRbwnlmJcN2eDwkOLbWE3SN2fHXdW2MX1ceaZ6MyvgnSdqhkG7dNphoYtPS6ZOHtvStZwef36DKZFOgPO3TEFKkdit9WA5kWWSCME54psXoMRgxz7o+JhF+0jAuGYL01nlWV+DDRV+X+eSPM+ZKjRN760PFo/IVA/SU+Fsk6MWVqTgiBNcsdyrGvYaIZe1nTihCZgIaqFVS8CXLDZjSdLoJEkcWCVh+17FVtBLxtnp1myC6i/5Gt3c6TJGnLJfq1wmn1lGu1KzCMxwJJRhSk79FiL1w1lW7+DHYnTD9TXXveOHPG+/gB7Al5nK6XzP1IpkVmO2C7wQ1C2SrTPRYo6E++mfGJe0iwXt+fW993RAFsxEx/WYQNaTHxfMjLO0QFK+kx19zBRSVdlbIJsNl8Y6gBlHjxF8jnM883WQDczkjL3EmvPOS8yPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(86362001)(41300700001)(31696002)(66946007)(66476007)(2616005)(38100700002)(6666004)(186003)(5660300002)(4326008)(8936002)(478600001)(6486002)(7416002)(6512007)(316002)(6506007)(53546011)(66556008)(8676002)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllCY2xxcm9vSUNDSkpJQXdXMStyOCtCSGVMK1BlNUJTVHJRNlROYjYwYVln?=
 =?utf-8?B?NnZFK2h2M3Z2NVZueGRhaHRyMHZGUlR6RDJVRDhENmR1RDhSUUhTUGNUbHpn?=
 =?utf-8?B?OVBOZ3Uwb3JRQ0NaQUdBdGdXRjU5bjNkMFdDc0ttSGhZSHZ6K0hFUk9LUkhI?=
 =?utf-8?B?cGJmZklwams0M0tMLzU5Tm5rUHdwVWxVMVhlZXZhS0pITjlWTkNMcnlhTGIw?=
 =?utf-8?B?bXlvbExtNWFtT21RNjROTjJTeGpMVXJ2d1hPOHJGWDNRdUhObmVqRTA0QWtG?=
 =?utf-8?B?UTdLaTVOU2VtcjFuTUlFVEVhUHZWbDZLR2ZBemx0bXdweEZIVENDZndCWVhu?=
 =?utf-8?B?eTcyZThkT3d5OWpseElPYzVEUWdQZ0NyczUrbEUxc0xWZWVrdC9wcXBPNHR3?=
 =?utf-8?B?UFZIS3hQQjI0U2d5RHVablJFcjlFaU55U0prOTR2MFQxVnl1clhIN3VtQzZ3?=
 =?utf-8?B?dU5GdjVaZzhQaWR0dTdHYUNrci9MUnJiQmJvekFLZTA2N1d4M2d3Mm5TSHBj?=
 =?utf-8?B?cHB6UUpWMWVRV1JCYmxSZUpGUE82WjZwdDVJMHFIaXlYeFVXWXJZYnZZNUFx?=
 =?utf-8?B?bWk2VXo3YzBTV1lqWDBOOWNVbGVpZXBkajFBd3F3cXpNd1RrelNLUzB0ZmtT?=
 =?utf-8?B?MXJRcitPYnZSei9TTkdaMlFDUWNRUyt1a1l6MGFkemtscjA5Vm5qbVMyMnI1?=
 =?utf-8?B?OFVPUElMVmFWYjZJcEdQRlR2REpKQ1p0ZlJPcSs1U2QwYWQ2MVhieGlNY21Q?=
 =?utf-8?B?WDNkTjVIbGVObEk0RS9td1Nyc0UwMmdNbmZPMXU5NXgvYmE3Q0VST3BybHNs?=
 =?utf-8?B?QkZlYTVyamlYVXRFemQzMnVOeldtdHh6M0ljWkJacVhxUHRDMmo2d2RGQUJu?=
 =?utf-8?B?R1dHL2d5SkNqbG96dVdjaHBKYTNaaHgxN0htTmpjdGRGZ0Rnbloxd0ZwS3Vv?=
 =?utf-8?B?L05FUmZmMzU4QnJVbEJiUzNzWDcxTGdvTm11MnVUaExFbWpZL2NEZDdBUk1k?=
 =?utf-8?B?UDROWlhuTUZ0eWI3T05DZS9KUlRzbFRMdERVem9mRWQxTlJTdmxQVFVxdWpu?=
 =?utf-8?B?bEN6TEpNekZyTTZPeC9TalZYcTJEQXh4cjh6T0JEd3RQMDRjQjlZRkpTQVJ4?=
 =?utf-8?B?U3QrRVlPSCtsYnJia0V1cXJ5cXVCNnJ0YjcvRUVRdG1EUHpteVh3d2ZjTDhW?=
 =?utf-8?B?Skp5S1BxWWZkWHdKNEpqSmZ6QXY5TnU4ZnZWa3lQeHBjL1pwVkZSbi9UREZO?=
 =?utf-8?B?N29JZW8vbGI0Yi9jYjAybmlTOVRnWSthemF4K2Z0eTdJbi9LZjVPbmFhbWpN?=
 =?utf-8?B?YXFHWVBURTZQSVYrRGxtS1VHdG4ySmZTN2VXTWNFUXJ2MHVCMDEwbWhadnlC?=
 =?utf-8?B?MGtFS1plRlR0V0xOT1JIdXlvOXFYdGE4cjl5aktsaVRWT25TVUsxa2JJbVpL?=
 =?utf-8?B?ekJmVzEzVkYrUlR4Ni9qeFhoQmgvUWU4dllxdThRZHpGa1htalBrRWlhOTRI?=
 =?utf-8?B?c1Q5K3VPcDBjSktUMUtDSGJ2eDdyY3NoQXFITS9TRmRCSjVTcHRlOTJhTE5z?=
 =?utf-8?B?YmhOQmg1V3MzK3Fac1JuYzY4c3V4WXE0V2ZaMzhRZ3crbGx0UXFCRkk3Mm9P?=
 =?utf-8?B?QTlySWI5dmVGYU40dUF4V1ZOaGpGT3gyOUlYMWtadlZPT01MdHk3SWh5R0pr?=
 =?utf-8?B?blZpeEs1RDJCZzl5L0xaWnRvOUYxNG45dk1CdSsrb0ZWelM3TXZXdzFXdjZu?=
 =?utf-8?B?NldORFVyTnp6RVpJZGY4TkQ3cjFjMVJaMWt6OVdRRzFsWktZVTV2bUpROXIy?=
 =?utf-8?B?RmFOQXQ2T05BUGoxdmNyZTc4aFhGaDlzODgzOEVHdEROT0tjbWgyRk1ESEYv?=
 =?utf-8?B?djhjL0Q2cVh5ZUdhTTdYYjg1RnJSZ3RjK3g0emwvRWpueU5YeitNSEF6NGNR?=
 =?utf-8?B?SmFmZ0I1azdjY3YxN2ZhcUZ5YWltT3hhYkJSWXV1SVBnWmtrR3F5Qmphbkxk?=
 =?utf-8?B?TDdyNlo0dy9YRnl2VUl5MkcwZDMrOTVaY01iYzlKSitVL2dIWjZGaUEybGJE?=
 =?utf-8?B?ZE1GYnJRWllFVS9LOVZiK240SjFGbG1iNjVGM09sSDNOSXAxNmxqYTVETk5L?=
 =?utf-8?B?V0xUNkJFOXV4ZTQ5TVVxd3lBaVVCNFRZSXhoYXBPQkFsREFBOXgwc3A1WnUv?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a2a0e8-3baf-44b4-7fd9-08dacd655d85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:14:07.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34hhEZgxsQCR1GTdqWVsb5q11Rth/3/7yLBODLbqbp/+FryqNapwa/Nlbw7QEhJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5361
X-Proofpoint-ORIG-GUID: AZCAHUJ3D7NqJOxHAyyTIOsR_NEO3LE0
X-Proofpoint-GUID: AZCAHUJ3D7NqJOxHAyyTIOsR_NEO3LE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/22 5:52 AM, David Vernet wrote:
> In commit fda01efc6160 ("bpf: Enable cgroups to be used as kptrs"), I
> added an 'int idx' variable to kfunc_init() which was meant to
> dynamically set the index of the btf id entries of the
> 'generic_dtor_ids' array. This was done to make the code slightly less
> brittle as the struct cgroup * kptr kfuncs such as bpf_cgroup_aquire()
> are compiled out if CONFIG_CGROUPS is not defined. This, however, causes
> an lkp build warning:
> 
>>> kernel/bpf/helpers.c:2005:40: warning: multiple unsequenced
>     modifications to 'idx' [-Wunsequenced]
> 	.btf_id       = generic_dtor_ids[idx++],
> 
> Fix the warning by just hard-coding the indices.
> 
> Fixes: fda01efc6160 ("bpf: Enable cgroups to be used as kptrs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Vernet <void@manifault.com>

I hit the same issue with clang build and used the same workaround below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/helpers.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e4e9db301db5..da2681ebb7c3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2019,16 +2019,16 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
>   
>   static int __init kfunc_init(void)
>   {
> -	int ret, idx = 0;
> +	int ret;
>   	const struct btf_id_dtor_kfunc generic_dtors[] = {
>   		{
> -			.btf_id       = generic_dtor_ids[idx++],
> -			.kfunc_btf_id = generic_dtor_ids[idx++]
> +			.btf_id       = generic_dtor_ids[0],
> +			.kfunc_btf_id = generic_dtor_ids[1]
>   		},
>   #ifdef CONFIG_CGROUPS
>   		{
> -			.btf_id       = generic_dtor_ids[idx++],
> -			.kfunc_btf_id = generic_dtor_ids[idx++]
> +			.btf_id       = generic_dtor_ids[2],
> +			.kfunc_btf_id = generic_dtor_ids[3]
>   		},
>   #endif
>   	};
