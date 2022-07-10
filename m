Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF956D0A1
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGJRwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiGJRwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 13:52:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78414019
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 10:51:58 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AAtlm2027324;
        Sun, 10 Jul 2022 10:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CAK+J7T3wwSo0HrzbnzHUCPoYb34dRoM7+cn63zEZq0=;
 b=N0xoP5+H9Vf0cHi09zYj4XvAHcoQTgWtDruTd+0kH/Hu4coxZqlZAVaFzJZ+yVhBGPUL
 zYDiInYuMQw8FYIRSTR/UBWaEU32z37u6dhjxpHr+aBlakd6ZWsSCuP0xcTEqwwL/v/4
 ghCmErOVV2pFRHOmanfvLcld6ri19lCxe0M= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h776xd41h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Jul 2022 10:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNrcAt83yoT/TjNCSn4/6bAvaOSYAYowZ20VJezBhg9uaqoEAiM6sgJFzvyTotFWEA+SafoF5T4zZBwyZRXraSb/2u6fscg7P8+yzVy+2OI8lkIIIyAd0bzw7F8sgGdt9olVEOB29ZW7nRPAKhnuRSvvyoKLa0Ipnqrm1MvqngrzPyEkvFdTlox2mVTlajAiVUFqBuuavKN+TvgkIFuhA8O8t6rdvL4l82/fx/lpRl/Q78jHNgd7FBEtD15tw4i3w7dBs5CJ4bi7XzRMBT0zWWMe3j3nTD4sWwx6eyn7xUCkwz3gFyKsmfqZrvz8SsIwczuRcbApiETXqgyHEDC6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAK+J7T3wwSo0HrzbnzHUCPoYb34dRoM7+cn63zEZq0=;
 b=K6zggQehJo4mfbtwZv8cQpm86L0q6WojQPCsyTQsO6yHs0GUfZnvR4JJMqf3mA08TqJFH+P/mUbkmkyItyiCLAHMn1hiT8zbThGsgljPhLk2Ijx4edNdyWI5WxC0gFjsNQxLwktpARz9AsXhix4tq/1gPiXs7SIGTJ9dspS6yy7YGf9u11iu6G9qI9ob0BSwBGKeHkLjP8E48lU4ARg/gqUV6zTzz33b+Mkcga67oCr9bg1v7iPDcPouwnbjNgb4pRck2BfZcCAcPtFDf619K4KcXDyKwRqDzPkDRfJhD88cz/u3wd+qhv6wyviQYoCLe73OqXWwo0KgR2eJyty1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2429.namprd15.prod.outlook.com (2603:10b6:805:1c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Sun, 10 Jul
 2022 17:51:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.025; Sun, 10 Jul 2022
 17:51:27 +0000
Message-ID: <05e5931e-98a7-d7b4-4775-7c17fad57450@fb.com>
Date:   Sun, 10 Jul 2022 10:51:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Warn on non-preallocated case for
 missed trace types
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, quentin@isovalent.com,
        roman.gushchin@linux.dev, haoluo@google.com, shakeelb@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org
References: <20220709154457.57379-1-laoar.shao@gmail.com>
 <20220709154457.57379-3-laoar.shao@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220709154457.57379-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc4ed7a-209b-43b9-3323-08da629ccfe4
X-MS-TrafficTypeDiagnostic: SN6PR15MB2429:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MenEFhhkdT3d4c1exh1dy4Oc80ENN7l8PwgdoVCLDosOZPGlOt59b7tTR5zSciz/TDSVdewTVI3mR0l6y0cWOjU7canp4ZlLHS2OBO82UVk1rxdd1FHwSNKHQQJvZpsGigUHFrH99v+FjrRedaLJiaFt42OSdHSIIkZRFAW9eG0OLogUMOzLI+jIy8qklHvWhhPXNSwAI13PCoS6dE7RR9LtGX9S6osywtQz9yxzVhOX3lnom4YXRuNOQUnFAAUnoDPOAApUybLaej05mCO5jSHO1Rr3bvS0zfUGtZMF/shr45dfPn2mQxGcpOFhrw/ePBbUZPMZUscXgbXeBnOPoC4QRzwB/F8ekNcNrGzGOHLCmi4li5TBGaya9xAE1rYvNj+fTMioDuCRyk2PiHY2z+opW5QckYOOYdGmqqyU9hPGE7LJCyYIpSLhfZhKWjePkx8nlRBQSKIkLC8lmyIi0D8sw453pCdbsUbtpD7Vu/qcrRTIwl8fUSFCRhhtmsQhAjVqNFI2lKyfZvut4A9YwlmzBLa/e8AM7HPbt8iqoSq7H3qE8Og21gdNkJf0DH+T7U7uo8x3Jnej4jbR3QDsBpsScfQlS2Zxq6g4FiuQ61y4qCZOYfNd5IyiOzQ0sguiJR333cXzko7h4LhYVg/7g/V0RuiNhCVxQWkglkoCg4HbFImRRNhMGvxD/LDKgY/z3moWhu9pR3aDGntd9oBvp0drQEurS+3h7qjsJuR0ggZ98qjE7/RgsHxMZhyzyrvGnFFkj6hsQHK6sydKDcbVNOyHtgC5FLWvKryflHVC1R95YFX5wFwLqut/ynNHptHPSCHaJFWKs2TL/MrFqGcr0LtF2iFsT5EHYVpBiuz00eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(38100700002)(921005)(2616005)(83380400001)(186003)(5660300002)(8936002)(7416002)(4326008)(8676002)(66556008)(66946007)(66476007)(2906002)(41300700001)(6666004)(6512007)(6506007)(53546011)(478600001)(316002)(36756003)(86362001)(31696002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHphY3orTFN4ZjBTcHVsU2Z3cGduMmpkUlFJbVVkbG5pN3pwcWhTTjM0RlJa?=
 =?utf-8?B?ekt0ZjB5d0N5QzViWXliR2RMdEJlQy9YaU5UaGowandIRkhtYkNGWENoNE9C?=
 =?utf-8?B?RGtCRm82c3R2ampWRmlqUFRNOTdlMk9lTkpFTjg2S0trM1VMWDBOeWw0STA0?=
 =?utf-8?B?WVRIT2hGZXdNUkp4ZTRQOVZNVFdnaEN2WEpUbzVmNzVlNEoxT3lTZGE0YTFh?=
 =?utf-8?B?L0p2MFVSQU9PbEVKZVVaRDNXVzRoRk14OUJGaVl0RkpiSDZtNlpGS2U3ZEkx?=
 =?utf-8?B?L3Z5aUtLbFdkR1VucUR5aHpQQ1NGbk1mckNrT2lsSExqd0l4R3RFVWJUUENh?=
 =?utf-8?B?UU1pRDZEWWVrSnZNY3BqTG02TjNOZDljclVRNGk2b3lLekN6dGNVZWZBSHV2?=
 =?utf-8?B?c054UVVHdUlUQWJlbEx3azdrcEpJSnNHOEVjQWxYaHVNSkszc095V3IrSk96?=
 =?utf-8?B?UThoM1hLanFpVEdEaCtWUnZmdTM5VkVwTW9jczFWNzFBSG1pbXlWOE15SWRL?=
 =?utf-8?B?T2JGb1huYW9LRjF3K3h3QTNLVFdHZ2RhUUFYRHVHSlBvSmVBakZWZGRyNVl4?=
 =?utf-8?B?cmRTUGs1TXhvOTdXaHViZ21Hb25aYzh1R2RGdjJhZXhoblMvcmRDczhybW93?=
 =?utf-8?B?YkE3N2x0R0swWWF1NEdvZURNRldkQ25MZlhtbDU5RTFsSTlnbmw2blk5aVd1?=
 =?utf-8?B?YU9XMXRkZmxVNkFwUW9JWlN1Vm9icFlueFA3dlBSanNLeXF0amN0VHpya2tj?=
 =?utf-8?B?VU5YQ0c5cDdkLy9BNmE1RnVUR1pYUGlWTzd2Z1FXT2JUTW5xQ3VIcUp5WnRp?=
 =?utf-8?B?THpwaW9UeU4rTGYzNDlBdHRaWFVkMGN1RFIzZzAwM0p2UXZMbXpPa2k5RDV6?=
 =?utf-8?B?TXN0QSsrVVdEbjVMMlBSaG4xanU1VmFGNmV6cm93QUVEa3ZNd0txaGwxWlRy?=
 =?utf-8?B?TTBKMStjNnU3N2Z5QXlPazQ0dzRpN2t1MFIyV0VoakNTK0NjUjJrQ1VJRlVn?=
 =?utf-8?B?RXdsU08wcERsaVJ1V0toblZ0WUY0U0lqWGF1QlhvcTM2aFZoRjF3WUxlbDUr?=
 =?utf-8?B?MzNtNk9OUnNLS2RKVVRsbmFTNDBQUmtHTW5pbHJTVUpIS2U4SDFwellGUERV?=
 =?utf-8?B?NWNMNThTNkt6SFdkWGY0M1luVnJSSWp1MFdxTUlZUzQ3NUFxNXdvMzZJVUtK?=
 =?utf-8?B?VVpBUVk3TkQ5S2FmUDVoUEcxbUxhaXNBTFFhcE1nZzdkUFZFWkc4SlZseDU0?=
 =?utf-8?B?NGZKdU9Tak14UzB0TExiUXBZWlBKTXBRYjBOZ2grb2E5aWFxN1BrL3JwcXdT?=
 =?utf-8?B?Z3hHMEtmaW1DV3dtQU9DL2Q1akRBaE5XTUNxY21ncmRCZ01nTFRQNTdDSGZ2?=
 =?utf-8?B?Z2dvV3dydmRFckc0Z3E2WVQwSXRLbFI2ZmhJL2lsdDhYZm9lNnJOS2hxN2dE?=
 =?utf-8?B?RndadjhaRHIxdHlqNlg5V3JaRHNXMXh3dDMrNUUzb25Gc256M0NsbUowWHN4?=
 =?utf-8?B?SmNQWDZlZWxjZ3kyTHBSc3JucTJHd0NmeVg5U0JMMktpemVZait6SGpoUFRP?=
 =?utf-8?B?WVdSVnhFeWVaQjltWGxZOEpXUUhLUG1PclZyYW96WlJBaGpNSlRmRHVvdWhR?=
 =?utf-8?B?ZE5neXlzS0RWRktISnNKaU5iM0pJMUN4cFkzSFZnM0hTa1RtcFhiMDBOVHZX?=
 =?utf-8?B?ZlZ4RHo2M09nSEcrSU9YT043ZUNvV1BvcWhwdmttSnYvNGpKdlg1TFpLOEx4?=
 =?utf-8?B?aS92K242Yk1hWi9yRFZsaXA3RXRZWDBXVTAzenNFU1Irb1k5SzVJMUpyNDBm?=
 =?utf-8?B?aWRyMHQ1d0hNSTd1OE11VlE5UnJUN1Z6T0JjTFpJOHI2clloVVR2VmYwYWtF?=
 =?utf-8?B?OGRUa3dJaFpKUlNXRzFUd2RKc1BVL2JhZFY5eSsrcXh4TVlIZFM5cHl5eUF5?=
 =?utf-8?B?WURaNVY3c2lxTVVRcEhjS3NzV0EzdENFeXJNVmRJdnAvb1A1bnpzK3AvT3Vn?=
 =?utf-8?B?V2NvV0lSeGlsZ2ZHVjFxVENXTGVmNDlWNWNDZ05qSzhnMzBkS0NTODZzUWNR?=
 =?utf-8?B?NStTWmtmUXVOYWdJTzYydFpFeFkyV2wvYkhZL1g0WjVsdi9qNnZWOGFvYm9Y?=
 =?utf-8?Q?OGoMDPQZPDuZAjuEX0uTlcv9U?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc4ed7a-209b-43b9-3323-08da629ccfe4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 17:51:27.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikQfgkMbFT1f/fAf00beCr0lxnjPJQUJKX553Na19JLfGcuWuFlP87tyYZZbUXaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2429
X-Proofpoint-GUID: TDHVj5u7aQgGh9gK4lsQN0pNQZIgmt8P
X-Proofpoint-ORIG-GUID: TDHVj5u7aQgGh9gK4lsQN0pNQZIgmt8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-10_18,2022-07-08_01,2022-06-22_01
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



On 7/9/22 8:44 AM, Yafang Shao wrote:
> The raw tracepoint may cause unexpected memory allocation if we set
> BPF_F_NO_PREALLOC. So let's warn on it.

Please extend raw_tracepoint to other attach types which
may cause runtime map allocations.

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   kernel/bpf/verifier.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e3cf6194c24f..3cd8260827e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12574,14 +12574,20 @@ static int check_map_prealloc(struct bpf_map *map)
>   		!(map->map_flags & BPF_F_NO_PREALLOC);
>   }
>   
> -static bool is_tracing_prog_type(enum bpf_prog_type type)
> +static bool is_tracing_prog_type(enum bpf_prog_type prog_type,
> +				 enum bpf_attach_type attach_type)
>   {
> -	switch (type) {
> +	switch (prog_type) {
>   	case BPF_PROG_TYPE_KPROBE:
>   	case BPF_PROG_TYPE_TRACEPOINT:
>   	case BPF_PROG_TYPE_PERF_EVENT:
>   	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
>   		return true;
> +	case BPF_PROG_TYPE_TRACING:
> +		if (attach_type == BPF_TRACE_RAW_TP)
> +			return true;

As Alexei mentioned earlier, here we should have
		if (attach_type != BPF_TRACE_ITER)
			return true;

For attach types with BPF_PROG_TYPE_TRACING programs,
BPF_TRACE_ITER attach type can only appear in process context.
All other attach types may appear in non-process context.

> +		return false;
>   	default:
>   		return false;
>   	}
> @@ -12601,7 +12607,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>   					struct bpf_prog *prog)
>   
>   {
> +	enum bpf_attach_type attach_type = prog->expected_attach_type;
>   	enum bpf_prog_type prog_type = resolve_prog_type(prog);
> +
[...]
