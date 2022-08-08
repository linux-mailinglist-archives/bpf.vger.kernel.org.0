Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2458CC98
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 19:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiHHRSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiHHRSQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 13:18:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB3714D29
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 10:18:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278ClKgU018378;
        Mon, 8 Aug 2022 10:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hzDW1VRxbmvzKwrpXbdshr8ZzSq/bMfnqTeVtq0kiqc=;
 b=Or2l2vw1Hv0lRw+AOcrEu1LtKGYROsOsuJGlXqUnmZGhWFjVnxpJrdFr086up/rny7J6
 40zu2tXI3Hc7A43Sz+s7OYTdCTLuhd93QVZQpnMznGkQrLT/cHXv1Th03ySZVIHVqDJD
 saaeGXV+mxlX6j6Q2anYeTkSm7LSkLY6p98= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hskywkk7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 10:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO05NRsYjYj45QIqPTYJzPPvwAaoELVSFSmIqjik498q8570NRg4L4z4tDXGOFoZTv38RkAtCD6ZBnWyeixQquudl6p1YziyaDi9QT2Y4Vc6QVqV7I7xRPwszXAIg6YKVZJ8nAuSr+YYsV+1tbv0HIhVxC1iDWYnEJt1rekcgfozL/HVC+/RhhcSLuPokQ0qJfeFrXBb5D0NCdxstuHNGc2NLyQuEOzh4lnSQ+4uGi4rX1ayYQ6mLeAmTY6mWRa+gVeiY+Z71/07joDSDCP5AHcYIfPjyhWw/CzXDFkLh2clZFlLfxuTKxTvjwJE5iN872+nDReP/kDL4PpRf2p/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikCsQFzrv/UYmxt2uxt8OsafhUozTLRBTOJJz+kFd6Q=;
 b=QAkBJXh5FBWcaMqhCwELCZDPm6EfLyo4yL3pY8jfUpzgnqlNuPsSXtfjVgzKF6qS5vCU15ybrVQHDtxgByt33/W8+2fbce0LEyyliuWnrKtjm6YtvqRMQiqy4xzCbOq1x9eAKVJQ35aqHS6pfQ5IeExj665ZjbxmatwnnpbMchitRYNwv0HxyFjMCV8DBl3kxXwh1lQfUj3Is7v4RoFikwbxrfrC20nvUPwJijVIvpI9K49MdRDTkFqr/HTVeJDlAG+V9eW7ZfQRvcyBlKYs+e6CcCYHQ7eMdFPJUEJKR3MMjwYQ8v9wzzPoD6LoGyFcLUvXGTDosClF+mb3qoER0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2016.namprd15.prod.outlook.com (2603:10b6:805:8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 17:18:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 17:18:09 +0000
Message-ID: <4d99b1f7-3970-53e4-0d12-c65a0dca7885@fb.com>
Date:   Mon, 8 Aug 2022 10:18:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next] libbpf: Do not require executable permission for
 shared libraries
Content-Language: en-US
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org
Cc:     Goro Fuji <goro@fastly.com>
References: <20220806102021.3867130-1-hengqi.chen@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806102021.3867130-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e9e22a-9b3a-4416-b255-08da7961f6fd
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2016:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/GkWMf8x4Xf0Axit6rCXrFLpNCS8cPtbxZqN8CN676GQTRSEvq7XQIHDx3GdcfpC1aVryvICZ95NDf3JKk9tL0VTJyGqXIkaZcc5lSEPCslVupdaySV9jT3/BiQwZ2/9yY1ZVuI9BmvCF2i+3tQusJMRh0RsWbkpTTutTZwxhJrTpZqp9Qp5Go1XyTRr1tIbkehli4m83NR+FJvGyg3AJwoFQ1jfP4aEDwJ/c1qrGx5O1rEfTMpBPUk7x4blgE3fc81QI4VXt8oLAI/StHlMme/QuvBPhKbIGhLzzT7OfjO2tIfp5/uQlddsVm6y7V4FRSkYxnLnV9x1T45SiTaG/nsIMi+8AENgH9AL7Q8FbAt1Kax4Dpn32Ed1VsAYuJO73y00odv8GaiOmHUiuCjrBALzHbYUZSGsylZVcdx8s/5OrhuZG5KQ2RstTl3DizPbka3v14FKCrEuLLk6bdxbBvQsGcxzXMaMKz71N3LYiaWC/xtsp7lblC5cIFnvDhm/lTTH4DJM13/MrA0h9zkIukDBdJMFhEO+Zp50WMJDPIvMRuLxXlkWUdLmczQfIcCXdsH0hRfRl63R6PTq/Nmsvfhw8BG3yVH9/jai9BLsxMj+N+JiTZucl+Q9t6md5KvbiiXpkEH9AiPgqmKEDPDt3bHv9FzuzwgZyFy/TVEsxJ/DGCgntAG/Dhh+kvRGfOH/7gvzsm4MOEOIty/Nr6lbrOdxZI1XPgu6Z2xW1ucNqjtL7KLT0jKYYqYnKYbr1jrUOuxGi4CW/CKmyOWpWuh0aTUVAh0B3LfPrQ7MMdXOkg2nXFEtnUTwhtJtmLyp+chvEZMARDkpgH9eFTinuttevf3uydBvhlOJtJCi8CNxhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8936002)(66946007)(66476007)(66556008)(38100700002)(4326008)(8676002)(5660300002)(478600001)(2616005)(186003)(6666004)(6506007)(41300700001)(6512007)(53546011)(2906002)(316002)(6486002)(966005)(36756003)(83380400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFwb01lZFEralJCbm9NWG1NeXAybHpNcXZubDBpY2x3OXFQRHRuTktQQzJw?=
 =?utf-8?B?RUlVZC9tTVFyRFY2T3JDSGdFdTBrcGZFOXhDWUlhK3ppK1dVdmh5VjcwcHJi?=
 =?utf-8?B?SU1MbkdyNmpsRGx0dlcyb3BzcHI5N2tRSlhTcGFianNkaERSNUFuQ2NBMmFw?=
 =?utf-8?B?REE0TlBncnFJODhDRUcvRmo2L2JLM3NLbE1YUVZEUklBV3ZxMnZIMHZtL0gw?=
 =?utf-8?B?YjNCcHlHQ2ppUEZhQWFSTmdsVEdodUZWbnkxaTVhcTJRd2hiS1NFYXFqelhG?=
 =?utf-8?B?OStRVkJZRERPeGRWWFRGYklhZEI3bVQ0VzFxbm9kNFVod0VDRU9SLzVwbHFD?=
 =?utf-8?B?ZXRFeWlobGdERXBsOUlLSTFzaGFLTWZvSlRYWDRXYjFXZTRDQWRDTVFmSWRO?=
 =?utf-8?B?MGFTcFlTR0Y2ZEJVdjc3RnpVZWVsTVd2R3AydnQ4YktnaXZQYVh0UEs3TzNU?=
 =?utf-8?B?elZDNU9OZHJXUUpPaFY2Nml1RStIWGN3Y3FqbEhNS1lDUW5aSm9LRzdPSjVx?=
 =?utf-8?B?TmphbFh3VnovL0JqcDRDMjVwc1p5MUxrSHNwV3VNc2IzNUk1ckdZaW5lazh3?=
 =?utf-8?B?TUE3VGlyTkd6d0RaN1U2akdwTnc5VFBiRmhVbDNHdlpIU3FDckMwVWVjUFdI?=
 =?utf-8?B?bmozdVJXcW1SV2lQMkJuWWVOQ2VTdU1WOTVsclduc0VDTzRYYWkrR2NWTkZy?=
 =?utf-8?B?bmpNOTRmRU5BRnFCZTJmV2pmYklNazMzYnNaT1EzSFN6Wjd4SStoN0R4eWVX?=
 =?utf-8?B?U1VGcThpNzFDUUoyZlUrMlBFMFFaaFBrcVBNSUE2MWhnZ1JHQzlRMUhwSGJl?=
 =?utf-8?B?b1cyN0ZtOXNRbmxMQ242ZmZ5QVNXYmFYamhiZ1g0MWVISHdpTk5uanc0K0lH?=
 =?utf-8?B?Rk1hZmhrRk1TRm9Jbi9FV2llN2pHTHc4L0tHTC90bnZ2KzVsc3c4TEJIekhZ?=
 =?utf-8?B?aHY2WlNCZitFNUpKSHlyN3E2bmlJcXlWLzhEZzU0cEF3SkhqWGRPRklCUDF6?=
 =?utf-8?B?ZE9wRkZFVmFrQWFaaDZiUDJQZGtjcHBVY2hFNHFYeG1CTDdGZTE3UVhVUVhG?=
 =?utf-8?B?VWtVek8yak4vT3cyVUNzN2RubFU0VExWeUlRTXpSaFNSZ0dFSzFEamx0ZHZN?=
 =?utf-8?B?M285U1RGemVUb3k1SEhXdTg3dXlTWUVrQTQyemF0d21jYmprWG1jNEJXOTd6?=
 =?utf-8?B?bVVhZDlxaE8xTWZvRlhlR1NCMDZLaXFzdGVURXFzNHk2TlV0VkhxYmgvVjls?=
 =?utf-8?B?VXVwczgxZ1c2SXhpRHc0NGM5ZVFDSFNVMzFNaTgzcnVtMUxLRUJ5VzNOSG1r?=
 =?utf-8?B?Sm5vamtUbE9hZjk5SjUyam80bi9CV3crbEVrUXpWRkNUZkREOVZtTXNTODlZ?=
 =?utf-8?B?Y0srekZIS1pJVVdkVWJXV2JmQ3I5Ujd2TFJtU0VCY1Y0UnAvaUxUdHZTYzMv?=
 =?utf-8?B?ckxDNDIycGpFVGYvYUZ2VmkxN0hYaERBN2VqbG45aTY2TlhZdnNlWlpiQ3Ja?=
 =?utf-8?B?R29FU1I3Rk0vWkJLWVFteEVWQzJZdk1HOGFkYWRDS2lTdEY5WTJ2UmlZZGtB?=
 =?utf-8?B?b2ZVNks0WFJyVVRpR0QvQ0pqbFBqN0V5RkdpTmVqeW5HUjhnWW9Qbm82amN2?=
 =?utf-8?B?ZTRhMGxKdE1ObmRYbUtlaEpoYmErS0JHT0M0NDd1c2w0UTBZV0VVVDU1L0Zv?=
 =?utf-8?B?T0ZjcEhzczdhQXJWWFZTelc2b2RtY3dSWkh0S2lHYjZyZFU1QUFqZ3kzOXBn?=
 =?utf-8?B?S0RIZlUxVVc4ZS92OVVDc2E5NkxDWjVkZE9kSmg1OFlJcHhNUVc0aEZObSt4?=
 =?utf-8?B?YTBIQW9JdktvSUdqQjRuc3EvZEhmcVpQYy9WY1JKTUtkcmlMTFF4cUZHK05W?=
 =?utf-8?B?WWlMZU9HY3BlaHN4aFgxaEQ4cGVRVnJDOW9FNjJmNW5lTzZxY2krM1hnL2VL?=
 =?utf-8?B?US9oVkRsQ3FxNEkwL25wVDlIWWM5ZGowYkVsc3lzY0duZVhwdnQ4OTJNNFJt?=
 =?utf-8?B?UDM0T0xjbVQzVXpqMXBDVUxSdDE0LzZlbXFKR21VNlJBaDc5Uk53d0VET1di?=
 =?utf-8?B?VktRcUZSczhwMHgzeTRiZTJzT1RSWDY4RlBIUXVSeG9sYmdjYnloK1lRVUVJ?=
 =?utf-8?B?anlabVF1ZFlYSlorRGZkaENMU1ZEbHVzWS9WdCs4ZFRUU0lmOXZwZGlscHpi?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e9e22a-9b3a-4416-b255-08da7961f6fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 17:18:09.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lykoqMd63aalofZWQgjyv3b64AUP0WP168hHGzwXDgx393sG4A3ES+j4h9KFpbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2016
X-Proofpoint-GUID: SYIpS-LxB7L48Zhd2caydrkmxKdsclWu
X-Proofpoint-ORIG-GUID: SYIpS-LxB7L48Zhd2caydrkmxKdsclWu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_11,2022-08-08_01,2022-06-22_01
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



On 8/6/22 3:20 AM, Hengqi Chen wrote:
> Currently, resolve_full_path() requires executable permission for both
> programs and shared libraries. This causes failures on distos like Debian
> since the shared libraries are not installed executable ([0]). Let's remove
> executable permission check for shared libraries.
> 
>    [0]: https://www.debian.org/doc/debian-policy/

The document is too big. Could you be more specific about
which chapter and copy-paste related statements in the commit message?

> 
> Reported-by: Goro Fuji <goro@fastly.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 77e3797cf75a..f0ce7423afb8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10666,7 +10666,7 @@ static const char *arch_specific_lib_paths(void)
>   static int resolve_full_path(const char *file, char *result, size_t result_sz)
>   {
>   	const char *search_paths[3] = {};
> -	int i;
> +	int i, perm = R_OK;
>   
>   	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
>   		search_paths[0] = getenv("LD_LIBRARY_PATH");
> @@ -10675,6 +10675,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
>   	} else {
>   		search_paths[0] = getenv("PATH");
>   		search_paths[1] = "/usr/bin:/usr/sbin";
> +		perm |= X_OK;
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(search_paths); i++) {
> @@ -10693,8 +10694,8 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
>   			if (!seg_len)
>   				continue;
>   			snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
> -			/* ensure it is an executable file/link */
> -			if (access(result, R_OK | X_OK) < 0)
> +			/* ensure it has required permissions */
> +			if (access(result, perm) < 0)
>   				continue;
>   			pr_debug("resolved '%s' to '%s'\n", file, result);
>   			return 0;
