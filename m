Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1F68D05C
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 08:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjBGHPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 02:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBGHPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 02:15:37 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41542F7A0
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 23:15:35 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3173wV2Q023276;
        Mon, 6 Feb 2023 23:15:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=08yEzG+xaU9zdEuACh3S484sflnt8LGXuX5EpzUpDBc=;
 b=d/mIiL9bj2/nT9SN1195hd50YTWjSsDAHRc7/LIg7uPIj1YYMKH0rONlVgbmeH+3cv9P
 gVwTYXzH5qrueTukDts+L0//iBg5p5cNdHQ08gh1OU8Xx4HcOfoPmAP+5pyfuSgjpan2
 o3UXZUU9oBFM4YPZyhoYruG2nAungxDS5BebU9TGDIdGOHkq9u4uAiTSj/IJ7C1+xfYy
 pRiyukkkC9vQciSro8Xd9nxcwqasM9K99UZOSaRBl0jjG8AIG3DS8Esfj3aNa4eKZ1HO
 oCZa/WmR/rTuXW//s0WUOG8SCRy9dasDzE7xm3eHvuTufNN0LyWafTLYm1TNDliaaPGv JQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nk2x6y4s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 23:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoR/7DEZN3GD/LL4qntmJC5ODTGS+ERG3FXXhfvaRrOw2R8xollQN69g4sV7OMbKab4zmT6CtUlWvUjztxTztLOCHDZyGzBMeNs4sIe9ZnGxf43ikAYN+3pHm4EVeGIVfxVN3FzxyyPKZtCUtEHV180HT3ENLWmHGY9ndqIj5veF174tjZoZlidwh9SICqyX+ZOcl/kaBdTdQ/q5cvoGQU7M19R2vb/qlH6mpY7j7EKWGvS89V3ZB23/soEOv3fBQy+geDa0ofpKT3SnY263t3YDMX3Yz6ZTg+UyuNkoRF6LR+coRRbqoH/DUwSHyi9Fi3iUkG2zJo++9HpMautXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08yEzG+xaU9zdEuACh3S484sflnt8LGXuX5EpzUpDBc=;
 b=E1rFz3tgLezdSvj8TNNX8UNI9eQbxK5NrhgL5yoAKxo+j5kFZ+IK+P7degrk4uKh+ZIwLcs0B6pIq1lvXfFYiw2olxIoL0t+cRBHR0qVzdYUupeqWTfXZA5/wv7Ju2V512ckjeXJtFWA1d28KrPHIQzd8Sj+eICmGq0HfrFHBYSEycDmUH/bCiZzCHGszNJk+62VR+MTs0j+xlJbKKvXTZ9ExxGO3sZNbn14YUWUV42zoLaVm1owrbqa04YheLVlWeLh+uTPtX2MkbMt2tdpthyncyVBbTtmhd7ZYnnn2armSICsWJtFJOJhZ9YrREp4p7Ki+3blHJgGGFtbIoXvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4525.namprd15.prod.outlook.com (2603:10b6:510:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:15:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:15:30 +0000
Message-ID: <b79b2fac-bfb5-7c8b-1649-b6ad768861e3@meta.com>
Date:   Mon, 6 Feb 2023 23:15:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v3] libbpf: Add sample_period to creation options
To:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
References: <20230206133532.2973474-1-arilou@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230206133532.2973474-1-arilou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf7949d-a856-412c-046c-08db08db187d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbBdYtvJWeUPUV6+2hzUn/ONoIWsRXXeY8OQ3SqeReocEyf4S2og/zlCASoxeM03/FyO+e9+tqr5peUSzqTYpRe9sKRpGn1fmfOs0P7elx7y1gdLsbqerti9JQX3UsHDftheKXCmDIOA8NpxhxgokcKyVPTybuKuzMzLnnk2T/uhftBCY/JfAw01zHQEIk76Rd7PF+CQo+0Aaq7IL5G1uw1mnIbYOf4tceFywwLLar+Cxg7b7ANLJcfNb5ahJLhYo5caYzklMU+cRFC7QbQsZBdxyhmZSx56G5SFHLmaJKGulL8Uicb56BMEWQq5Tp2G7T6eRTaxi2/kzS+Vtxhopa3Ktl/hydWVWwiM3AH4HSJV1nvbouYF0dLhmkczz4aPX6RmZFUso/M3N2hO3SRH7nrKDmrXE1T2PV3DW6ytljQmjhj7JUf2TmgjffvgQp9NF2cBASLxn8x2e26K1WE5++iNaQjJ5cqYtI6Qh8gEqRS/69+l/gdBykxN/0b+ztwit4gWDG+xVJ4++gf5iMHIoQwvPmWOCUNDBPxTDgFRuFBY6hBlhL3Fenvl9vLxgA4Gv4Jk0KHeFE9gn9VnoD8Qd/8ZaVQnPCzOyQPB/xJP+4Zjf71GjZkuokcY5f9/aXTQSiFClmSbZbs3OudwvekghgHixKkoZsqKz5OQca7c6N/4Ko0NmNOTGfwdEIXeD39RP1VbQgKv/KGr6m9x+oNBHzMmWv38EtdgACpO8au2YSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(31686004)(38100700002)(6486002)(36756003)(86362001)(31696002)(478600001)(2906002)(2616005)(83380400001)(53546011)(8676002)(66476007)(66946007)(6512007)(186003)(6506007)(41300700001)(316002)(66556008)(4326008)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjM1QlUvakEvRlp2TEIwalZCM3ZISG85cUltdDU1MWlQL24yeHJJNWgwbktV?=
 =?utf-8?B?b0ZZY2tGcStuMTY0VzE2YXJzSEJqcFhQb0lHNUVGOHVoazF1MEtZdWxCcHRk?=
 =?utf-8?B?czdkRXF3SWhFWTB5cm9KcFJ0ajdoSlp1VmtMWXpyTXRXZUR2VUI3UnNIN0Mz?=
 =?utf-8?B?M0RYMm5RMTRoai9SRk1obkRNOE5wcmtmWm5MN0srMFRoQWozMHk3NXpsSi9O?=
 =?utf-8?B?VGNCZU5UdHhPZ1A2ZEY2RXBqMkxVK3ZwMkYyTmJkUGZBTGQzUjQ4eTU1cUw3?=
 =?utf-8?B?M3pLYURGRmw4SEVtT0w5eVIwYWdESmQ3L256RE02ZGhqRXVrV3UyYVpkNlBD?=
 =?utf-8?B?S3k3ZDFlZEJQTngreDdTRmdobE5seVR6WE1wUHVoN2RrZFd2OHh0ZTgrOWNi?=
 =?utf-8?B?ZUpqV2QzcmJmMUZkMU5WQ1B5SmxvME5JMVpobTcwdnEyaUxWcXNNVXdmcDgw?=
 =?utf-8?B?NGlKM0x0dkxMM1hLNHV5U2Y5cThnS0gwc3N4U1YvZ0hEdkhuSVh3Ry94Nmsw?=
 =?utf-8?B?UmI0TjF4c04rN1FYRXVOQmt6YS8rdkUyRjRjeWRDa21pWkVXMmxUUEdpVWQr?=
 =?utf-8?B?Wm9lcmdBeTk4bVA1K3FEQkhsdDkxSzA1T1JBVjVBQ2JXTVl1bktGVmo3QSt3?=
 =?utf-8?B?TUtUVFBlZTRENmlLaEEweDA4dEt0bDdJS3h1QU10RG9QVGgwUXQxcWRzU0x5?=
 =?utf-8?B?b1dPc1Nib3UzSkZacy9KYXdXTkEvNVdJRUtjWVRVVGFCbVhvSEo2Y1lSRjgy?=
 =?utf-8?B?NE1hLzNTa1pGeDZTUVdpN3lCWnNpRUl4dkd2VjZpZkVzemZRbGZ3Q3ZVMWcw?=
 =?utf-8?B?UWMvbExLbUVGa0RrZExLL2dqNjZCUDFQM0NUaVFiTnFQNkRPdzdNS1A2TVpU?=
 =?utf-8?B?WmRBQkdNeEUwMmJjOHdqKy85MjdDVFBWcGhMcUNrdmg4azJEVFpmckZIRlpW?=
 =?utf-8?B?MnVESFRCcCtvNTZ1UGpSSnBnMXRWRmRlWVNySFZSNEtZNjd6VktGdmNDQ1ky?=
 =?utf-8?B?dldBLzBNUVdrcVM2a0krKzZaV0dVeWVYWnFPRUtJT2FYM0tQSVBURk5Kc2k5?=
 =?utf-8?B?dmhFYXhWbEQ3OGtTRk00bVBOWnNTdWsvY3JZV0xvMzNVQVdYYkZTWFhQOEda?=
 =?utf-8?B?d3UrSmNjR3JQYUo2dlEySEI0cS9NU0RSWUg5aUI3NkVUbmxhSTI2V3dDMk1j?=
 =?utf-8?B?UThDS1QvUFF1VjBuclZ6K3dIWXBsbU4yc2RVaitpZEdsMkd0RjZISEk5TVRm?=
 =?utf-8?B?R3h1S1BrL0dUOTMrcGVXTnhadWVScDZuRmRSZ0hPT1RQZ3NZWWFGOTJyWHkw?=
 =?utf-8?B?MUp4RDBLSlB1VW1ObGNyTHVmeXBObkdsUzhKUWNpOHhkWjAyeWVHQU1zTlBh?=
 =?utf-8?B?L3U4R1FLNFpwUkh3dUlIMHBLY2tXQU5ybjNZNW50K0NaeEE0RHJrcWFJTlMy?=
 =?utf-8?B?RzJqdll5b0hGamNqZ090anlmckNtekFFc0dheC9GYTdRb0xxYmxUQm1NUXE5?=
 =?utf-8?B?c0ZKMlkraTNSOEo5RnZkZXNSNU5VMjRHN3ErTnpNbDFPeW41T1pTNm9CaXQr?=
 =?utf-8?B?UFV5ZGF4YWhRVWdJQVh5UEF6UWwyOHhwNG8vc1plb1pFM2xtYUtDSjdwRHlt?=
 =?utf-8?B?djd3a1IxSk50dHB3S3JyOWcwK0RENTFCNXdwU3BNU3VDaHdNTHhWU0RXUWJk?=
 =?utf-8?B?RmJldkQ4UTZBNktlS3Y5MU83V3hKWXc1c2JzbnEzcTU4dkZ5bWp0Rk5Mc2Rm?=
 =?utf-8?B?M3Frdi9jdm9yV29LVzh3RXluSy9wTTlsbUlQN3pRL21CbHJSNXRSenVvekYv?=
 =?utf-8?B?dXEySWpyeitCWHB3VGRCNUdpZTVmUDhlUVlIT1dxUmJMcmR4UXBuOHhLQVE0?=
 =?utf-8?B?ZzcvUDJQQ211ZGFJRzZxZXp0WUFTdnFrVnBIS1FMdzVhaHg4UUpjZ3Q5Qncr?=
 =?utf-8?B?cUZSeUxxc3F5Kytaa0tZQlJlVlg0RlZsWW5XN3VjOHlYTXY2N2x5bTJUNUJI?=
 =?utf-8?B?KzNzdEpZTXNkYlpoZThDZ0pGcXE2dWlIMFpxV0hRY1JSSjlRYVNVTmtuTHdS?=
 =?utf-8?B?ZDNublNNdE4yNFRVSXJ1RS95VXdmVVB5WE9JK3lpSU5MZUQxcnRsM05rS01I?=
 =?utf-8?B?cCtCODh3eThWRnFUQ2JrbHFPZm5kMXlwdmlLVENwMXlYaW1TYTBWYm01ZzQ3?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf7949d-a856-412c-046c-08db08db187d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:15:30.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WynjK880Zrek2h5O5Zih4J/wuA16gZUqRoIVMHH8/w08J+wyJC9aYkYcwBfvL7p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4525
X-Proofpoint-GUID: v0lB7yXuG-7IvP3f1eoMLztFJM23tYq1
X-Proofpoint-ORIG-GUID: v0lB7yXuG-7IvP3f1eoMLztFJM23tYq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/6/23 5:35 AM, Jon Doron wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add option to set when the perf buffer should wake up, by default the
> perf buffer becomes signaled for every event that is being pushed to it.
> 
> In case of a high throughput of events it will be more efficient to wake
> up only once you have X events ready to be read.
> 
> So your application can wakeup once and drain the entire perf buffer.
> 
> Signed-off-by: Jon Doron <jond@wiz.io>

LGTM  with one possible change below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/libbpf.c | 9 +++++++--
>   tools/lib/bpf/libbpf.h | 3 ++-
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..cd0bce5482b2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11710,17 +11710,22 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>   	const size_t attr_sz = sizeof(struct perf_event_attr);
>   	struct perf_buffer_params p = {};
>   	struct perf_event_attr attr;
> +	__u32 sample_period;
>   
>   	if (!OPTS_VALID(opts, perf_buffer_opts))
>   		return libbpf_err_ptr(-EINVAL);
>   
> +	sample_period = OPTS_GET(opts, sample_period, 1);
> +	if (!sample_period)
> +		sample_period = 1;
> +
>   	memset(&attr, 0, attr_sz);
>   	attr.size = attr_sz;
>   	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = 1;
> -	attr.wakeup_events = 1;
> +	attr.sample_period = sample_period;
> +	attr.wakeup_events = sample_period;
>   
>   	p.attr = &attr;
>   	p.sample_cb = sample_cb;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8777ff21ea1d..5d3b75a5acde 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>   /* common use perf buffer options */
>   struct perf_buffer_opts {
>   	size_t sz;
> +	__u32 sample_period;
>   };

The data structure now may be 16 bytes for 64bit system and we have
4 byte padding at the end which could be arbitrary value. The libbpf
convention is to add "size_t :0;" at the end of structure to zero
out tail padding during declaration.

> -#define perf_buffer_opts__last_field sz
> +#define perf_buffer_opts__last_field sample_period
>   
>   /**
>    * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
