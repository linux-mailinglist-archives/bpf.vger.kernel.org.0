Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884068A20D
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjBCSb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 13:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjBCSb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 13:31:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BEA1462
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 10:31:55 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 313I8feG018171;
        Fri, 3 Feb 2023 10:31:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MzB21wI9OZ+o/wvSYA4OIVUrwqS/NzBhySC+9uLg/3U=;
 b=aLYK/pjLloGs4Sy1aTePj3IkFZ2CAW8JcaFFgGH9j994RgkK+7AJBiZT5mErlQ4qS9YB
 8ZH5yA7ZIoFIdbMQMXC9TOilkosW3IGE0g/TGfWcY0Y9vXPWlVjq92uN2f17QHfsOs1a
 BXSeG5+hytJ/DZJ+RCOED2oB3yf+Jw6a0q3iAN9nlNPTXMjc6H+T9tw2Q/vCEQMUimd8
 LaTFO4J61WmDRmoX60x5bsF+RoEaOkLTSJVfNVR3Co+vGFfXsZXkml6ty04Cjd49dzDh
 9bMIyA+1/nPWSMjqzfxooSX3UrIZxs4ezOKL2ld9WrNRZtmCQoTHjpfBK67xOaHQdwCK WA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ng3r6pbj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 10:31:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGhIKc2gtvLGUvsd+TnzrkKh6F3LlXJa8WvdFxOeqa0K6K2l3YK0kZ0gxznnD0IMisrDY92T2YuQA0gPZeRA+C5H9Qpmf6CyaKkV2hDOB7wRr3I4Wv/lx4TGAgaZruyyHioXY0rVx1r5LoO06D8ELcgpSYaCmHnb/wlRSac/N4XR3OGFcZjSiZ5jDn7d/PNdiV2w420MhOUHGWiMR3bFFA9rYaRWRkglb0KamKB4HUA0ouHVNRtd4z4kstyCwfXInEtTGXfegLavUS/YpeCHAXZqWeqRUBZZq3JcJlHCwEIA84DETzAo2zPwbZxUHdH4C/TKqxGTFdTUoUDVElallg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzB21wI9OZ+o/wvSYA4OIVUrwqS/NzBhySC+9uLg/3U=;
 b=Jy11pAunjhbdUrxKkZ5R8524CfPuI0KFUIcn4LhS9LYAdd2xM7+1g8Wmtrk94+07j4kiA2Tm83NBQkzq68iNWbrDVkMdqdtZnoG8UD0TuORNxpA4kz5Z3NbiO9We39CYz428UPXjXy28qQruh6lLXdZQQ98WvFVbXYfIDRnq/HmMsyvNw98LQ4VmN+r1zwxCwxhiwkpCOExL1MQIJbstWio0sCNi8LaD8GDPz1RUZuNBHmYiMBIk2ywU5dXjsxIin5Kj84qJHMklX1yh9QNnhGXH+gMci6jtkrJKKLDU60ESBUtoYZz4M2LaZabh30d+MJi+ebqQidC3T8AjohUe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4907.namprd15.prod.outlook.com (2603:10b6:303:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 18:31:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 18:31:48 +0000
Message-ID: <479c7e94-9502-6f94-c465-ac051f99b2ae@meta.com>
Date:   Fri, 3 Feb 2023 10:31:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
To:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
References: <20230202062549.632425-1-arilou@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230202062549.632425-1-arilou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 9527c66c-88df-4de1-0c65-08db0614e904
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51HHO3BkmlXkuKmf7lrZZ4KqZL45womdenceFHVC8kbNRJGQww+XkodhBZ8HYGXdMQorj8DTqWV+kLZoL6DEVzgOu1m0xl4E6c6U7FI8ILuI3n6/naKBbicaAQ6gSfqPC7gjQd7sQQZqxq5dXRAO18sduT5k3xFjq/+Ye9GCgnN7phgGBwTD7L9EZERebOX9TYzUdZS4oND1A7xDrmgM2j1CGdpFaWhsFepGqkYagu0r4RAA2JUfR+JWvaG9waF63uOVse89tmLbTF6tFzYApRnJHYIlp55rAHKS/JQ//gZciG3A41RjIA6nYykOL4LzIKmNSdlkMY4ozZkQeT+bhFuHkoH311bLMyh5EfI1Ty3KKQQ9WWTggN+Tb+wEzcU9teltDLNYwFBSOz3UH58gY02DyJs/+NF/+PVOx48+Rrsje90eCijm+RUIB9amSXGDL6Ad/NKiKRT7RgE2Sb8E9cukBHjDGMfx3oJYtuPbW9if3o397sjFhpbDPyYr6OAEoj7fyfana5Lqi2ftvoN2tzWMn9jiSp8Qa3ME8fMwxgDQewmSWg+3Oj0sKvk6hSvCGTUXjYTFUPrq07jz2t2wAK4I68zGH6TTlWZWvpCuaMwI74GIrm+gPirm6L7YO6mOTSWBh1W+j8heXVkQd7dVAjrkunAvY3Xc2DzJWDbkKe9ymN9WGYWDMQ8bZgZkwvw9HO2NaVsa2QlMzZzsNta8N3itzMQOEBHrICeniNi/TJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(36756003)(41300700001)(478600001)(66556008)(4326008)(38100700002)(8676002)(66476007)(83380400001)(316002)(5660300002)(6512007)(186003)(53546011)(31696002)(6506007)(86362001)(6486002)(2616005)(8936002)(31686004)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhOam83UlJmbld0RHYvbnlONWtKQzAyaWRJdFZEYXVPZDFEK1VnM09QTVQ4?=
 =?utf-8?B?RmlZUURkT3U4dnlKa3Z4eHU1ZnB4VkN6SkNGTTFFTjBqblJxbXQ1ZWY5NkVH?=
 =?utf-8?B?bWUva3hZaUc2bWpLY3h2TmtFYmhnQlFJK2R3MU9UNEl5d0RMNmpRblRVdVVL?=
 =?utf-8?B?SUV0ZndMajE4QmY4YlpJS3V5SnlmSjVWOFh6ZG1MN3N3VnBQOUZaT3lwVkpx?=
 =?utf-8?B?RmJQNWdxYkltQnUzbkRLdlc0NlB1VUVxWmg3UHlvY2hMUUpJRGl4NCtnQUVu?=
 =?utf-8?B?RHpoU0tYSUdrR3NBdlYvdnhaZ2RSNk1EZTl1WVQvcjNSUTkwUWZnc1VPb2or?=
 =?utf-8?B?NU1sQ1NQVTJMNGZ2eldnWVJaS0Z5SGU0THF4OVVVWmppZWtoYWEyV3AxOURD?=
 =?utf-8?B?K3RJVFlJNlVML3lHeEZINHpkT0MrODhIbS9iY2dqOW9WdndldnBJZnRKK3ds?=
 =?utf-8?B?OWkwd2I0b3g1S2I3ZExEQ2VQWkhNWTBWOGRyUTI3d3NzVXdXRElFRXBBV0tW?=
 =?utf-8?B?Unpmd3lVTi9ZRjRKYkFRRlpwQldTVlV0QnYybHl1Z2dWdHRXQ3l4eUR1RnJJ?=
 =?utf-8?B?Q21kbFFvbldGQlVPWHl4aDNZb0tPQ2ZZRGs5aTRmazRFclJWRjlYRDhHb3Ju?=
 =?utf-8?B?YzNtc0NsZ3N6MjBxVnFkNnNFNENOUko5RFc2ZzFoVWNoaGR1d1J3VnBFUnh1?=
 =?utf-8?B?Vkh3bzMremlBd1dCa2UrMFMwVStiRGJXTkxhejV3SWtpSU95UWU2bmFsNkkz?=
 =?utf-8?B?TzhTSGlSMEErYXlQakp0WmdRUkF2SDBaL2g0YTJSSjBIem9GV1B4VXoxWkIy?=
 =?utf-8?B?V2xnK1JjaEV3c1RFSkswQnpOdHFoRTRTdlVwZi9lUFhYUGM3Vmw3NUo1Nlhh?=
 =?utf-8?B?MXJmQm5xSE1ScmdPUWk4UHdsVk1RdFFiV25XaDVncVg3SDRIbXpUclpaS01m?=
 =?utf-8?B?Y0dZeEFVK1VuWEtRY3FYWDh2YU9iTTZkeTM1Y0FzRkNJQ1BZL1NTMTJiWTFh?=
 =?utf-8?B?V29lSWlpTWtOdmNwTmQ0SHlOOGtlLzUzeDk4T2hZMzNyZDRVRWdJemVxbFNO?=
 =?utf-8?B?Ry90aFpTVlZhbWdVMWtHVkdpUUdNL2hCVzRvNmltOU5VYSsxcmJ5YWlVbmZH?=
 =?utf-8?B?bXBpV3NQYjZMUkZaWnphdi9LZUZUTFAwZkRoQXZEU2JQUTF0Yi9ZYm9INHpZ?=
 =?utf-8?B?VnRVWEtOTDNCMEF4aFlPMTNoUmcvbjNJbGRlaWxHMWFvYXZTQUljc2VEMzB0?=
 =?utf-8?B?b0EyTElvRFpUbEpaRkM4TEZHVjVuczB0b3gvMzVKR0FjemhuUUhHT0VHZ3ZP?=
 =?utf-8?B?NS9jbzVUa0c0ekVBVVdTK21TRE12MzIyaW9CVzNaOHhsOTFncjVZL3FaWnRP?=
 =?utf-8?B?bzBDQ28rZjRIRUkrL0ZvUnUzcEpQbWlTbGl0azB0N3h3L3kzTkZUSmt2ZEdn?=
 =?utf-8?B?bkZRaVpZelJLejlQakpWbU1SbjVGYyswMm5aZlJLZHhKZjFMaGE3Q0h3T3d6?=
 =?utf-8?B?SGwwYUJzUUExWkc5Q0JaZXE2bzdxOHl0WkVkcjNoOXRmMFhYbDdYZmVjaXFo?=
 =?utf-8?B?WUZybWVzdG1UTzY5UmNDLy95M0dDNkJZKzBERXZ0a2htT01zUnhNei9ETmN6?=
 =?utf-8?B?ZFVmVWIya1ZFSzZoeGRIek5mQlE2YWROSDhTWUhCa2JMb2JEelN1aW03dklt?=
 =?utf-8?B?TGdxSDRVb3hJWEo5NHROTVFRclltK3VUWmQyT2Y5Q0ZmdDU2bjNSTTQyV3hl?=
 =?utf-8?B?azg1bWxjOWFJQ2tSL2VLSVJrQTdzQXg4dmEzTFZmbHVRa1dTOWh6ZU9UZzdB?=
 =?utf-8?B?RDgvM1FtZEpoODhQQ2ttUURTYU5ra1BrNHpJbVdoTHdrZDJaMDJDdUtkUHRp?=
 =?utf-8?B?YVR5akVNQ3gxVVQ3akxiSm9FVnlKWjJwOXVXZjdURmdaU244azUyR1NaNmt1?=
 =?utf-8?B?bjZBc1ZTZG1mMEtEZ0ZUTTc5OEJXMHBacXh4RVhuaWhOSHJxT1ZwQzZueDhO?=
 =?utf-8?B?TU1BcmUrUE9wRDF4UFBoOXEvK0xINHhwVVNSK3lhL04rSittR3pDalRrdGY3?=
 =?utf-8?B?c2lTRXlMVC95cGVqWWFJWVNCcURZOXQxNy9sdVJlTTFYTDFxR241eTE2R2tW?=
 =?utf-8?B?U3R0Uk1YQStpUmFBWGVLWERqZGwrcTkrYi9oMGxBSWEySTkxNWhZb3VwYSsx?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9527c66c-88df-4de1-0c65-08db0614e904
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:31:48.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgSYT4GXnJQNgOHWJxUglkxXqtTvs5KW1ju46bbuvKQx5riPd9eokQL1cDfHxbnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4907
X-Proofpoint-GUID: 0VEquaOW9_c3wLUn1_8Yqy2WqC_k99SY
X-Proofpoint-ORIG-GUID: 0VEquaOW9_c3wLUn1_8Yqy2WqC_k99SY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_17,2023-02-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/1/23 10:25 PM, Jon Doron wrote:
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
> ---
>   tools/lib/bpf/libbpf.c | 4 ++--
>   tools/lib/bpf/libbpf.h | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..6b30ff13922b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>   	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = 1;
> -	attr.wakeup_events = 1;
> +	attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
> +	attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>   
>   	p.attr = &attr;
>   	p.sample_cb = sample_cb;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8777ff21ea1d..e83c0a915dc7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>   /* common use perf buffer options */
>   struct perf_buffer_opts {
>   	size_t sz;
> +	__u32 wakeup_events;

Since you are adding wakeup_events here, do you think it make sense
to add sample_period to struct perf_buffer_opts as well? In some cases,
users might want to have different values for sample_period and 
wakeup_events, e.g., smaller sample_period to accumulate data and
larger wakeup_events to wakeup user space poll?

>   };
> -#define perf_buffer_opts__last_field sz
> +#define perf_buffer_opts__last_field wakeup_events
>   
>   /**
>    * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
