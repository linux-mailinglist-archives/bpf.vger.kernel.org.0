Return-Path: <bpf+bounces-2433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6872CC68
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CE01C20B60
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFF22D53;
	Mon, 12 Jun 2023 17:23:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02822610
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:23:17 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D8DB;
	Mon, 12 Jun 2023 10:23:15 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHFhZE025358;
	Mon, 12 Jun 2023 10:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=P+m83mVO6qJhNQBlK23zTov4anrrqAU1+uIM0ec4dzg=;
 b=jGU+TzcaKrlK3JvbjVNY7gzNfhQwJQdNugiIW0f0IeWYKhBeS9OdkUQPhvuGeCqH8Vzv
 CyTccnOmSUWmdsexuclN2Cf+EHZhuRFwHAO3Q1NSPgRky0Fz1fDdlkXoGhr+syhTdC4U
 znn5Ha2t7U8YyGtRpN7dpJSW0fU/tBLnDCRcV4WOU8CDkb0DS6hU2SQbzVKBL/KLx3Qr
 yFCPtk6KHK/icb5WwC5xoR4WbxSc8EYi1bPnmkO/KLP/NDzhEdbWMgWtR5SRDOE5AEWW
 L/+VJ9aZUa2mkJPvsXR81Q+XDrhjTfBYf5Qo6R8As3TnPXa7jIMi4cYjEY91FynftdGA GA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xdwkm1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 10:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFaL8CHWm8UOCeWhPaCOLH6hSiqPnmghbam09zUvgB1z8bDpQP+NvcfymGadc0ccMj5d0WlbPpeALKEav1qhRxN8p7pU2ryqOWlvOfMvqZioDV+INl4o5lGt4Cxjoo443SPAlQD3UYpRrkfTX3WvTZSf2GLtsG7sQzcsNrV+mNvFHTNxe2mUiZymrXQmaIvIIoxxtCYMLqoqwnQBw5JwQhJ7tAR4XlpI1XyXcYNMzKiHyK/xOkE2ltQJUEzcrSGiorO4IcfCdRC3mlZJ2KPryrTPnX5ALcxV6OSCujPoTbNQvBeYQgiQ2+F889NCk51S0xVzxq7FH5H80EBu9MWj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+m83mVO6qJhNQBlK23zTov4anrrqAU1+uIM0ec4dzg=;
 b=H7aeFEUfBY9oLHVbi+9yPeoO2mtW2FYWGdUzD4GlXBp+HYu0kQ2ODyC1TjR9sdYZecR8TcEU6emX3oCPkb1o835IvQithBJF+r/feIcCABxTWsRQFpVC2HOxz9MhS+GUQM2+a6lStHqE5Ln1rofdNcwRjsPkI97dKZz55ilYz/S/iyI2eUiIMcBo649v8dFEy+yh4cJPvUVYB3CxLxP8gjOCDd7IkNE3zpi5eSBgL6/5EIRwZQhlMHJt/MdMBcOL4TUD/O9Ejj/D8pn0hTJ5jhYMF7R78Y4OXknkPflPOP5KeStfJc1sMNolarxZwcnokeJ8i3j8Igkl+w9KIIPxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5820.namprd15.prod.outlook.com (2603:10b6:806:330::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 17:22:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 17:22:51 +0000
Message-ID: <80c805d5-8077-74b4-ebc3-7e8fbc8c767f@meta.com>
Date: Mon, 12 Jun 2023 10:22:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 05/10] bpf: Clear the probe_addr for uprobe
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-6-laoar.shao@gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230612151608.99661-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 82735026-ad87-4689-daea-08db6b69a67c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tpEu2ABpi+HbyHVy+WlzGOZRppa9UOJCxpkgGehqdqzuss1jrxLxKNFL8yhvC47n7P2paN3nKUCuCafm7snEYk3KYBbsWFNrOFovlesu6/Yyae/YLMST/fGemB1WdXNNhyfcfuMd9Kd3hRcJV6tz5Yl3X4DnTuSyee4uUdME4RVpnX8YBh8YtpG6n/ElzyieDP3E1GXkdbdH3HuvTNF7MyrmpYz1PPUWaqi5R8MHCL0UkZKFfHtumIOEPCD9V2GtqZsfjiNJEkS1qIyvvlfb0XMgYJ9jJ4+hxkwYAmWuhIpVBzaEBta3RGxmdPtvRQJyPFU5RFp6P9kRVmAUbMPeciCakmrxJHkpt1zRgpwTGIb4gkCTV4AcPCQYKYFGIMorQeayoGnR6szNMcylpDrkH6sqO2gRwZbOf+4sAEsBOm3HqRawEtCdzTew7zo6FicPSKig6di0eKkfSqwvnFt6CZPUUtHWfZx4nE/q1pW7TtZWIDtU50qTUAzkypfsI4gCJxwV12mnU0geBqYYwUiIFjvl7DiEUIZQZC/aZvGG7hjcd1xlUXgtu2yqwFGmDTo3in7KPCR3+IGTs+E7MXFzy5FVD3l9h/+2oiC/LysZbFNKllcuyfL9t1X/cBNKFzBNuSZ89QryU9qjYeteJz52fFkEdpRPEAI80EBvVXr3He0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(478600001)(8936002)(66556008)(7416002)(66476007)(8676002)(36756003)(5660300002)(2906002)(86362001)(31696002)(4326008)(66946007)(921005)(316002)(6506007)(41300700001)(38100700002)(2616005)(6512007)(53546011)(83380400001)(186003)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVJxakxNUGpIMG1ING9IenBmTFZIY2FMclh6VkJlY3FuWmltenhHbksva0Fn?=
 =?utf-8?B?MFl4SU13MmdLU3hhZmM3dFlVUlprQVJRODZha3k2c3EweXQwWklHNzFFdmJt?=
 =?utf-8?B?MG4ycGxWaEprYmFnREd2bzVtcnNIREFBY3lRL2F3NnZ4NjJ6d2FCN3dmSzRr?=
 =?utf-8?B?Mkd6SHZ3Qjc5ZUExOFUyWWtRN0s2dE54WkdHNWF4bDhLMVQwV1ZaVkduWCsw?=
 =?utf-8?B?MWlIZmxFTkh6dGd4S2ZWTmVXMDdzM2RhM1N3dkFZM0tkRjR1ZkcyU1creXdQ?=
 =?utf-8?B?ZnN3K1JKUEF0V0FpSFBiMGIzSitPQ0QvRFNLVzY4blZKT0g2WWtNcVEvTHZx?=
 =?utf-8?B?OExoczkyZ2FFNmJIRDF6NWUxZnlOb0JQWi84bkpmekNTNnhMVVRqVnE2OXRR?=
 =?utf-8?B?NkVtVVZaTlVJaElIZDRsc0h5bXZjVXhqbzNodG5rNEREZkE4cGkrdkVZMFZ6?=
 =?utf-8?B?TkphQlg1N0FBSkQvTGVPTysvM2IvRVhTcFIzcDlPdFBmWU9YZzc5MVNkRkRh?=
 =?utf-8?B?a3dWb1dld2s1YzF4bVJITDlDZHpRRVM3amcvTk5GUzdDeGtLUEFBWkZOb1pl?=
 =?utf-8?B?dk1NRFRVK2tFRWFZQmxvYmFRY1JVTXd3U2tvamduUWRYTjhSMm1tSThGVDE0?=
 =?utf-8?B?Vy9YMERyaUUzcWhGbHE0S1BxV1NtbFUxVXFwNHYxSlV1TnQvblZJbmtmOCt4?=
 =?utf-8?B?dWpESFZEL2FhaEFQQXRHY1huOGR2UGFMMWJoWjdQdUx3dGdNS0Y5UFUvbE9F?=
 =?utf-8?B?bnRROGlXM3diT0dmZm8zTHhlNE9uc1B6djV0VmgreGVYYlRaTnA2cWxvK1hv?=
 =?utf-8?B?dE50a1FPNTRIVTM0d0cvZTBxdUExeFlnRmdmeFlMQURNeHBoQnJubVNGWFVu?=
 =?utf-8?B?RS8ra21mU0xrRjVaSWpiUFE1L2FQTllMTXhlWSttcU4waUhJNnhwQTAzY0hV?=
 =?utf-8?B?U2pxdk5UYnRXVnF0ZGpLbFlFcnpMWkhKTXNjTlNzQlUzT2hRVVNhd29tMlE4?=
 =?utf-8?B?MldLTUg1N1VidGo3dDExN3l3WEdwWWVUV3AwbEtmZGJyNVIySlFWZG1TbmJt?=
 =?utf-8?B?T2hmeVJSbXllZEZDY2s5ZTJoWktrTEk1UjhubFRjT3lkSllNbmNQWnJBcE1a?=
 =?utf-8?B?NFpqdzgrdXc4WjRCVFJpM2VDMllYUkFLR0E5T2kzU1RUUmdqU3oxNWxOZjVI?=
 =?utf-8?B?TmMvL2VzUjBlY1QrY2lxTVFkdlRrQjVYVUNReFhXOWxGd0huNkhIeGhmT3ph?=
 =?utf-8?B?U2NMSDZnc0orb09lUy9KMkJwSnRvRkhzTTRjNTV2WkNac01OTHowQWZpWTRM?=
 =?utf-8?B?eDlMMkdHSG5jVXI2UWFQSWpwVG1PM3BRRU9uSnc5aFZQYzRyRmduVmQrbGlL?=
 =?utf-8?B?SGYxS0UvZTNucDh4bzdDQVlxVFhKM2E2S08wdjVLTGtMNFllcXBpblA4Szg0?=
 =?utf-8?B?dkNJZU1UVlpXMGJJZ2tmS2kyaVArY0VmRldQTGQ5UXVZS3kzaUFnMEVINFE0?=
 =?utf-8?B?cGw1bEtSZ0o2SFJUaEdXWTZnQ1I0S0hoWDBvV0dmckZyOXZnRXEwaUN6RXJh?=
 =?utf-8?B?a1B1cDIyS1kvSTM4UmpQN2tOckVXQmIrcTVIa0N4R3hrS0wwMUtWSTFnbWpv?=
 =?utf-8?B?dU9YNEZSU0d4OVN5RUFLaEYwUW5vdDYrS292SDZjRk1SaXNIK2NUQ3RuMnBU?=
 =?utf-8?B?OUNtM3hqMnBhRkU2T09DcWo3d0pCTzc5TU9wd2JsRFl3WFljb0xQbnhhblFw?=
 =?utf-8?B?V3l6M3AvU0ZJV1U4Mmp5Sm9jL3B1czJUNjVMUW9YdHlPeHk1cVBiZDNIYnM1?=
 =?utf-8?B?YmdqejdHeGxkSGNML3FhWVU2M3NudE5RUEdnLytVTHRnUVRYK0h5U2RmQTNP?=
 =?utf-8?B?dkdRVjNJeUxxam1IWCtOZHprOVZRUjBhNXE0VVcwTGVQT0dYZGR6QmFWc1JO?=
 =?utf-8?B?dmNCTnE3WklyWTNia1JsWkFZVDQ4NjRjT0E5MnB2azNFZWluUDVQcXRod2Nx?=
 =?utf-8?B?bHM4djIvS2FzbmhGbjNwc1FIZzQyYklTSWx6dmpkVStWbEU2MTF0QkdqRzg0?=
 =?utf-8?B?bUFrTGorcFFXZHdUemI4MSsvQ0ZTdmRlakFPUmwza09Fb1U5bmdhV2EzZ3pp?=
 =?utf-8?B?TkYreit5SFNKN0x1NzFud1J2czB4MnV6cnNxdGpOYkJrUlBPNXYzNmJsR05H?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82735026-ad87-4689-daea-08db6b69a67c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 17:22:51.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY6UShj3CNG+sU17EDzrsyJtLOKfFqlW0kJnmqxWchPQhTkFnlq36FyFkNgSprnJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5820
X-Proofpoint-ORIG-GUID: _dYahA3Rw4vGeuQ2-JoSm6R8ztsujbGF
X-Proofpoint-GUID: _dYahA3Rw4vGeuQ2-JoSm6R8ztsujbGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_12,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 8:16 AM, Yafang Shao wrote:
> To avoid returning uninitialized or random values when querying the file
> descriptor (fd) and accessing probe_addr, it is necessary to clear the
> variable prior to its use.
> 
> Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Yonghong Song <yhs@fb.com>

Thanks for the fix! LGTM.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/trace/bpf_trace.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 742047c..97a5235 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2372,10 +2372,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>   						  event->attr.type == PERF_TYPE_TRACEPOINT);
>   #endif
>   #ifdef CONFIG_UPROBE_EVENTS
> -		if (flags & TRACE_EVENT_FL_UPROBE)
> +		if (flags & TRACE_EVENT_FL_UPROBE) {
>   			err = bpf_get_uprobe_info(event, fd_type, buf,
>   						  probe_offset,
>   						  event->attr.type == PERF_TYPE_TRACEPOINT);
> +			*probe_addr = 0x0;
> +		}
>   #endif
>   	}
>   

