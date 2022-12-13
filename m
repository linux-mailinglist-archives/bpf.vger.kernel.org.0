Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA864AEB8
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 05:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLMEqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 23:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiLMEqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 23:46:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F68A1A8
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 20:46:10 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD04iSI006543;
        Mon, 12 Dec 2022 20:46:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0YtaZwz5eqBl0l+vGbT2LYflY9b1I4xhPMIghjGcCHE=;
 b=IdzZaemnVjlMyaLmvsFIo0YhJfWzVdhdHhV7XlzmPa6qt7Ao1+1noeVuIsKeiDwLSnC4
 zYXOMzXlKEaV6H7Ll6YnbU04+/0fEQugMPimQATZJ3ZuLjC4a1NwI6FyJElrh/SI0yqA
 Fta6jZ+ekTrd5VXFcgqd1tCBdPAL3ap4fO4wVAovGs8IO/5NX6n5vK03bM/Xo/uvq1WJ
 Y8tEpDtWPcv5oh90aflV8qGyPtpWMvpQ/hpejdcL6+XAOxt+MKefYWVdf97PKD3T4Iqc
 ctU5V0LVxghVPCsH8lQK2coOu4VTzXzMtRi0Ot8ajTATBefU9fJNF/R/UMxr+8ozjsYA eQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me49cr220-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 20:46:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZblNLMXkXqc8r9Ntljwb+n4VGTj1fN2pPb+GpJr9pybe2r49hfjbRw2caWoC/HQzwGTXDj8XSc1gp9eX5sb+JHRa4w3r/X6p6zWbtxbJuNM478c1QyCG7wbZ629vSoXqhkGZu1rj1Y7YkCtkSENRlellZWXxviJvF8XJGcb32Nktoljr5HpcSl1HWYlqnckH76+1XTLyDdTrM7jhRSAE9phqtwqSksKdXsp1qJO/joG/wq58Z6voIMG3ImsTVBz9udAlyn4AIgPWcMitvOuD5yP0iMK6FN/pvj0L3M77WACtiBTkvJc5Ok74MmgCKxi18ctOj0gVR72QON29ZBnMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YtaZwz5eqBl0l+vGbT2LYflY9b1I4xhPMIghjGcCHE=;
 b=TN9aEtlnFjLQIIZbekRjDIrf2jL61Fkh2DOizfpegPvNUkdF5LXjb+ICfrxzT3Cnnb2iws76erfqr2eVH7cflZ5hSsXR1FH9pSSuz0YfCSie3XBWbgqN/+ICuDflDX41sAHk/Pk34PrHiY1EI515Hud4KK3RNa6PYMzFXreFtQ7Tgx1IQqbh74Da9qeyYGYQK28Ytioxor81+6tuskycgYlVufRI5AYt9pgIXKBZOSRV6ek1xuspvMI0UldiMPEQUOyl47RjddeGv8EpKkmFvsdr8Ws8WbJfA5UaVdvOL1b6SYpiv1mJ8/EBdWa17qngfBDIYeurPCAyMnxeMTa7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3587.namprd15.prod.outlook.com (2603:10b6:a03:1f8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 04:46:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 04:46:03 +0000
Message-ID: <7fd8b8bf-713f-4bcf-4fbd-bf97e7137803@meta.com>
Date:   Mon, 12 Dec 2022 20:46:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2 1/9] selftests/bpf: Add missing section name
 tests for getpeername/getsockname
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-2-daan.j.demeyer@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221210193559.371515-2-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY5PR15MB3587:EE_
X-MS-Office365-Filtering-Correlation-Id: 9066cd77-2a18-4d6c-9169-08dadcc4f060
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkrPFwn0W8YXS9clDONOvg17sC2cdmESeAFzj46PpnKMA3Lio+xGcrR8CP1qe5Qom612qqURG2QmeTdKx2ZBF2DSrM/rtiHMTtZcL8xblttEUI35fEoPrbCw8dy7myeE3AaJAEk1L2pUzIuWGm2Wz9fSTRjeYnEeQyow6j4iS8AyvArvkZ6zRkj4+53iu6pabLKoOqWsemOT1UggZVuZvrR0u7OfAiU7QdJJvKX/arEHwi8sgbYE93gBAGnaPoo2jFD9Kgp+/eZiOI5kOK2JVhuOmflATEK7aXevexw4gkTvYfFR0AWwXPPacp5pKTnhAZgmrSesOR3kaLkG7TJpUDMr9QmL6w5PSsFFsjwLdh3xgLXxM29wB+y8F/tBmrb7uSn8lIbVQkMtuncbY/V0/FeWqIznR/cjISazgCVFHx7f8lyYeT1dDLWQmeXPJgUrfoS1uYyHLpi98/K1qlhZQ0cVW8jHyXEuJYaeUNNiwJePVXrG0xz+eMDL1vPq6+2YbmLDkYlhro/k8ZU2cLCm5eNBrH+nQ/IVYZTvnxwT7rF3Gm9Pe56VztN3APpQqAp+mUlVJYQy+JjVfNjZSwSelv7yVXroziQRk1RxBzRfj/XukSmSHSxCQ7LWY4c3aHXstAKVhQjSEUBzZe2JIg/RbLBz+ZJjq6/wGAQVGAzDr052CU85mVm3azkNWR4cP5rIpPon0RRgWwcZiqZy4zdaXOaZsfyW8pQjP0lTR7OVgQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(31686004)(2906002)(38100700002)(6512007)(31696002)(36756003)(66556008)(6506007)(53546011)(86362001)(107886003)(41300700001)(4326008)(5660300002)(8936002)(316002)(66946007)(66476007)(8676002)(6486002)(478600001)(186003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW4raHFZaitlcGxEWmRtb0Q2ZEZIMVFtYVFKZGdwcU9sVXNpTUJzVG5Vc0pY?=
 =?utf-8?B?N0hJODVsWE42T2Z5QW5ZUDFBMDU1WHRYK0pIOVZWQzJhYWhEOExHN3VpalNz?=
 =?utf-8?B?WEVnbndxUmpPNVhESUM0MmoyRFpjdDdrNWVFUFRXdm5acGY0bzFKUUpVMEk3?=
 =?utf-8?B?WlRTc0MrdkNrY0dZdEEwbDVNM3pENmNoN29oRzJyVVpOckMyMFE4cU1iSU9E?=
 =?utf-8?B?YUJxVjROM1dKTlkwSlBRMTBvTHRISFYzUGFNWmx3MEtzcjFCQStZOFdHVXp6?=
 =?utf-8?B?cnE3RForemNkMUxWd2dlWjArYk1QZUs5cTB0WjlzZWpqNXlHQzdMbldDZmFk?=
 =?utf-8?B?UnplN29JM1pBdnREOHR6S1lzWk11NlZqdnZ6ZzlWeGJDb3VyUjdHZ0Z5bVFH?=
 =?utf-8?B?REYwbzZyRTBoRzZyT2RSbW1zTTJRSjJoc1pubjV5R2UzcExjVzA5bG1selZy?=
 =?utf-8?B?UnNnOGV6cSsvQk5PcnpremFQLzJZc1doODM0L1RQdDMvWjY5RS8yQmU3Mlg0?=
 =?utf-8?B?eEhrV3BwbDRnYW91Ti9Ld0hlRGtIVGFDSVo2eEZ0bUhWcHgzVGV0M3pjRUVw?=
 =?utf-8?B?RHZaY200V0RSNVdFWHMwSXV5ZURWYnAyK1pFZEVQa0dRanV0ZEp3c3N6Nlgw?=
 =?utf-8?B?UHUzcXhYZWUrUDRaTVBMUkE1M1NOTWxRNyt6WjdUcVV0eHE1eGZtOGdUSnA4?=
 =?utf-8?B?UVZqbmhKRHVoWnVER1BIaGRYZE03RjlJSllGdkpFdmlYM3pUOVdpS2d2azVR?=
 =?utf-8?B?ZmVXV3U0MDJpeHhFREZaNVl2SDhRNkxaeTBTWVB4ZTJiN3RJWXorUHZOaTRw?=
 =?utf-8?B?SG15UHNLUGRtc3NuMjg5cjhnVWM5MFVHQ2tGYzZhUFJhdWJHbWMySjJ2VE1n?=
 =?utf-8?B?Y2tTS0FUOWN1akZaQUpBSXUzZUgrZ3dNb3dFenNmR2p6QzNwcmdMTVV3eU9U?=
 =?utf-8?B?d25KTktCMUM4eldVRVdVZzJvWWJtTzA3QTVvK09mTE9iRE1QQzI1bE5DUmNs?=
 =?utf-8?B?cTg0TCtkbldFeU9XRDJxZHJja2p1UUxnMFNtRm4rZGs3UXZvd1hrcjV6UVBE?=
 =?utf-8?B?eUIzbVNLYWJjZ1dUelNWSUVZTmV3QU1ucXJ0Rm52ZGZGditGSjZheVl5b0Rs?=
 =?utf-8?B?aXBQTWNjdllKcm9rOHRBdDFXb0YrYTdRblFOT2V6RFBLVEQvb09jbDQzVDRC?=
 =?utf-8?B?YXY1bmE5SCtQVXlUTk9pRnVyeWVPM1JyOVY3aDdpQ3NkclNkZWV2T0VyMDE0?=
 =?utf-8?B?ZlBZbzZtbDJLUDN5cks4WExGa1pNeThQNERjOVBLdHNHQWtCV2FtM3lqS1ZE?=
 =?utf-8?B?TlhtNU1Ba2tMZithZXEraWw1OENlcnY4SDhzSG9hL1dlcFQxemJjaHF3VldY?=
 =?utf-8?B?NFcycHluSUc4VlIrS1d1YUQyV0U0UmN6QWY0UkNzVVJwbDhNUkJiUjVMYm5i?=
 =?utf-8?B?Ui8yZE1NWUwyOE9KYXdIdG5Kdi9tbTB0VXMwUEpjK2VpY2UrbHlqaFhmVnpo?=
 =?utf-8?B?R0ZFVnpoTE1KZzByVTllaWRCSEhCQnR2K3Z2VUVFamMrZVZLZU1paElVamdI?=
 =?utf-8?B?VXJFRmZNS1Frb1Vvc05LOWgycUdDRSs2b2h2ZXdxdm1sbTFXTFhIOFZaRE4y?=
 =?utf-8?B?MUVmak5qVW5YTWRET0FrRTdKa2p6NkcrSEtkRWs1K3krb2M3NnpjWmN2bmJx?=
 =?utf-8?B?bFRtMEFzay9ZenRkVHhPaEgxU29NR2pCOG95aWdyZUU1WU9zT0Z2Lys3bTZ3?=
 =?utf-8?B?VkFOdnRCcy80YjNrbFhzVHJBZGtuWmF0RFlpK2d0ZHF4VW5TbmZMbGdyTHNa?=
 =?utf-8?B?NHFpU0tGLzNBWnk4STlmMTNRMmJ2QTFYL3V3MWNLWjQrbDI1a2phdWc4allV?=
 =?utf-8?B?ZFArUXJnQTBDRkxYMUtWN3pMZEtGWmttSzlnMWRlSXZVMnFoUkU5RWZkVzZs?=
 =?utf-8?B?SmVtSUg3SmZvQ0RnOG5mbFpBMXlSSS94TEowNWZXRkFqV3g1cWoxK3lZUjNL?=
 =?utf-8?B?WjJ6RlVrcW9XR2ZsdUxJS0tpUE5rY1RrKzJpKy85cmZJdHZkWTlPZTF0cXZ0?=
 =?utf-8?B?UVpMR0UrMkVpcW05TXlWZ3RIU3hlYzVTRWZmNG16SWFLanNsSDV1OE1ucUwz?=
 =?utf-8?B?SkUxR0ZnUzVyK2Rxcm4xYlUxRkM2TXZqNWxDZU00MXNhUm5WUVd2LzROeURR?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9066cd77-2a18-4d6c-9169-08dadcc4f060
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 04:46:03.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70f2xPCotIRfi0ZqvR/VTFIJ7E1FeGnDwIitr0/RdMsygrcO9Pbez/UjXGSnUi8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3587
X-Proofpoint-GUID: E2FPhO1-VTAUgYZqfj5PV11JHZkoVKv1
X-Proofpoint-ORIG-GUID: E2FPhO1-VTAUgYZqfj5PV11JHZkoVKv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_01,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/22 11:35 AM, Daan De Meyer wrote:
> ---
>   .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)

Please add some commit message, even if it is short and mimics
the subject line.

> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
> index 8b571890c57e..fc5248e94a01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/section_names.c
> +++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
> @@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
>   		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
>   		{0, BPF_CGROUP_SETSOCKOPT},
>   	},
> +	{
> +		"cgroup/getpeername4",
> +		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
> +		{0, BPF_CGROUP_INET4_GETPEERNAME},
> +	},
> +	{
> +		"cgroup/getpeername6",
> +		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
> +		{0, BPF_CGROUP_INET6_GETPEERNAME},
> +	},
> +	{
> +		"cgroup/getsockname4",
> +		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
> +		{0, BPF_CGROUP_INET4_GETSOCKNAME},
> +	},
> +	{
> +		"cgroup/getsockname6",
> +		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
> +		{0, BPF_CGROUP_INET6_GETSOCKNAME},
> +	},
>   };
>   
>   static void test_prog_type_by_name(const struct sec_name_test *test)
