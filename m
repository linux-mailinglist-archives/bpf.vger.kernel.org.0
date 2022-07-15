Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24445758A3
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiGOA3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 20:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiGOA3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 20:29:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D031F2612D
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 17:29:50 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcYnI006682;
        Thu, 14 Jul 2022 17:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vtqr2ziaPmWSfIhwuiYtGU7P1bzJNG852E8ai5c55+4=;
 b=BoXZME4070TrAyiW7+hKtKNu2IEOsfUT+5SiiC7+m1wfDShwaBc4lgdANpFjdYjMBHSx
 ktXOXajP9nc/skXbESMAbjsQ+Emos7PCMPmQQlnIq7Z2RUntqzcBzN0OzA9OpydWgxDX
 V50xVGztJbl+h9Ps9R4b1pDBlZaAfYkk1KQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hak0ecg5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 17:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3GKG06q+/jbOVlDb9/2k4tIR70mJSNI6/SzmOUOEZtRaXCugAiShA7LgFtot+hMBB8IB4Jf/Rt3bKae8Vc0T6C0ZB/BdByaiYO4Lsy3zHPCbvxRsUI+YwGv5Yl2JBZ3EsdLUmkPUybbxC+YWZHKW6cYtawBu4ZmTUz3meejkSFMnC5dL62uRJYgA3Shrnj7VRCpnrmPzUCZaQF+qe5Z9+TjnhcXQrhNF6pVaXuTs4+4BliLKrK1+V6F6YST+prwTibTTUpbIrw+7exT1gJWnZ3ywfi34iSr7EVh9W8TuIRmRZS03JuaD+mvm1tV9jZuGOJ2FXOC3V0A8Li/VTTL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtqr2ziaPmWSfIhwuiYtGU7P1bzJNG852E8ai5c55+4=;
 b=MHi+k9tTgD8OcoRxfihgn/Yg3Dj3IuXtrCdhHE0qD8elS0zrjvV5tHn6eM5wyQeaaGFK+WyNfvHapo2NCnqKFcN3BgrgABQHgac92RkeCfLEpkolO2wWTemsGNS53popwVX6RB5/QXct4pg3yuvBrJ91PB6+FzZvcZaWpTQHz2vgOHq8IvZoc0wYwaD2uOgKDrb7ApLUlrWLilwHfVxH9mJvWH/sVYTe3ycNV5mXhrPxBl8PgxVcXeKiALYtEnkSTH6woPsTPQ17+jaj4C5BCniFqYDB5Qq07EMUiLSgjJ/0oTwI5Vg/4VmoMzAiYWlKaDI/7qx88uFR0ZeGuRu4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3201.namprd15.prod.outlook.com (2603:10b6:408:74::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Fri, 15 Jul
 2022 00:29:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 00:29:32 +0000
Message-ID: <fc3dfc6c-25f8-a7a5-7ec1-b929712ed9b5@fb.com>
Date:   Thu, 14 Jul 2022 17:29:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] libbpf: fallback to tracefs mount point if
 debugfs is not mounted
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Connor O'Brien <connoro@google.com>
References: <20220714232143.3728834-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220714232143.3728834-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f49fbb96-4a23-49f1-44b9-08da65f91690
X-MS-TrafficTypeDiagnostic: BN8PR15MB3201:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMnkuyL/sbCxlE/pv/FD4Vg+5L/eCqCzzCVYfhHKzLJ0DBxhoiG6Soz7hNv/ktj9QFmvywW1Kl5WEQaledIRMkohi7UlomibB5bajdUGpUVKaLaImgzvqDQKwYuUrA0PGxND1JSA1zvLlzAM+sx18GVaH7qAim8TQJ3+WKIqGYfBZ866XtELLjdmHDrK9hIndrTknOedmm9wPQZC9bgrBuBxjDDwbhad4oEHHUwTQpuCdgA9y9v4Q0vRGXj0DQGqeKgorpuvqnBZSpT2htCeZYgnHgHW6k6/+YrpdaasmQ13tj1sNR7zPFDGh2SrbPxrdD15Q3e4koqKlVy0WmhDyi6GJ1LLnyAhO29+nUCODBIYpySGf6GVs3gmrmAhX9ChUslUX4XXp25qxa+LEkt19koyTvJu4znsSuGA2xC1oxJIm2dEU/F/iSlwrJ0/bEIxL/6zwZ6kP9cwncy+YrvzfhmeqQJo6HQdM2a3Vem4INcq/y3TSIFfMJspGoRxdbcACoeLvMe6ChKA3BvkBjngNj+2HAGfhe6jaci/f9YtV463fRTdgJWNLnvHUqTrls9hA9tJ19UZ5S141Ep0CC1mS1JWbz+WEZNMHXVkmc5EKo+o0kgGZapP7Io7KA0igFtUmsCp1LTuull8lsoQMcmcbivfIHN24Gz5697slWGh884WTwAbPNe8I4BznUw2AncogB/6Z1rKzlcRUvlZaTAvx2VRaKv39wJvF5wNU0zhyNI4bgQodTOHUj2wA1aDqk/K9UIKBPC3ioEVHs/jj5X21RvNacdmhcdY9WlurlKFTq62b9QSwW8nrXNlXGOZdataL9W11TMyIt+kgJgZnNzOFTWEHAcGOAm6RGFJG2C4fio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(66946007)(2616005)(41300700001)(8676002)(186003)(4326008)(66476007)(478600001)(6486002)(316002)(66556008)(6512007)(38100700002)(5660300002)(2906002)(86362001)(36756003)(53546011)(31696002)(8936002)(83380400001)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtuYm0rSjd6K0JqQzdqTjFxTWlUdXVER0VoaVdkUTVCZFJHODlyem9DUWxT?=
 =?utf-8?B?MlVoV0lNaStKa2N0RlhES29xbDMraWFZN0YrbkgyNWY2ZTFENkNTVkQyd3R3?=
 =?utf-8?B?MjA1TzV0cWZqK0ltVzNNSHhjc2p2QmpyL0h1d2xhRFdBVkhxNndOQmUrVEtG?=
 =?utf-8?B?QmJRMGdxdENsRHJZdldSTC9rd1BTMmIwTGFVQWhST2djZDZuV1E1aXpXRWRm?=
 =?utf-8?B?UnlReDBuVi9HZ0Z0cmYwNlo4N0ZXaEFXd29wUUxGaCtWdm5ORE5lQUFtellS?=
 =?utf-8?B?L2ZUVE5KSWRIWmc4aXpYQnNYMVY5Q3FnQ3V1cWpzb3BUM0x0QWY2ZnJWQ0Vw?=
 =?utf-8?B?Q1RQbG5rR2NXVERUc2pIUHd3VFlkT0loZk1SUVovVVFOcXM5QTdmeUJOQzdZ?=
 =?utf-8?B?V3lBVFhZTUVnT243M3EvTkxmek9XRTRDWlBPc2lFK2kzd1VWaktiVUVwcDBC?=
 =?utf-8?B?RnQ3NWlCdkUxdW1XVzROaG5xWFZIU1ZNSnl0T05IOTVkYW8ydE44eW1WZXM2?=
 =?utf-8?B?Nmt3azlLR1Y0VWFZazJXUkxHNmpJc2VMa0pWczdlT1NBYTVFNFpPd2JWdDJt?=
 =?utf-8?B?WmNKZDNSRzNMckt5cHpwVDhuQ3Rpak5kckgyY2lFK3BSTjVxbklFcXo1ZVpS?=
 =?utf-8?B?TnFpamVqOUlReG9jc050WUF1d0VUUXdodWw1blRRejNxN2hLVmRnYXpoZjlO?=
 =?utf-8?B?TXRwUENPR3pNbE1sdTFBczh0WGJRWFJKc0lPc09JSUpJRXVMZmwyaTZTRXl3?=
 =?utf-8?B?c0hnRGZ3UXIxcXRFMDBRVjJGVnF2c1o3T1ZPUGE2WjBEVjRINHpFRmpUaldL?=
 =?utf-8?B?TjRYZ3VhVWxYcDA5Ky9Jd2Y1TXdWZ2VlNW9WNjBmLzlCL2lCOTdCZkZVeGsx?=
 =?utf-8?B?ai8vanVSRmtKRDZPZ0hmb05ndUJJUkF6QmtRM1ZZM0lpcVlKZVhKNC84T1Na?=
 =?utf-8?B?bzVKTFdUelJyUWMrUk5aTTRCdGhGYWs5MEo2SjBHYnZjdVFCRzN6TUtTdlJT?=
 =?utf-8?B?LytXN1hsZm9Gc3M3dThiVGlQc2U1cmczd0NSeEpXTGxoeWJ2NysvRmx0cmUv?=
 =?utf-8?B?M1VFTEtmK0RLY3pTOG12RWxpeG5SM0RYWUkvZHF2UnFlaGkyTUZPZ2pmTzVO?=
 =?utf-8?B?a0F3K29vUi9CRHgweTByWFY3eGRsN2VmSCtaTmx2enZINWExYzdVV1Z5K2FQ?=
 =?utf-8?B?eWZJNVJzQXpQMjZSMkpJbE8zc3o3SlhHK3Q4WnhxQ2hKYjZmUFk5SjZGdXNV?=
 =?utf-8?B?ZXdpWVdnZHB2Mnorc3hITnRQUlZId2ZmWmN3em5BTzNXNnA5dVVTc2kzbUFl?=
 =?utf-8?B?Tkt2eE0zaGZpUVRueDRQRzBaQ21Rdlhvd2JPcDFSTlJrbzR1K29jREZLeXVU?=
 =?utf-8?B?Z2k5NWd3UzRmREhKZUZ2L25LM3QzOUJQclE3NWlFUnRrbHdiSDVYcitXbG1l?=
 =?utf-8?B?RWxDRTR1WFFpTlUwWGNoZDlvengyTjJwQmd1OEVGd3RvcU54Z0JWTnprZDlY?=
 =?utf-8?B?VGlzSDJrL016TEwvdmNwUUhudVJkSnN4NEEvRk5QU2llbU1ObzFlVStVNEU1?=
 =?utf-8?B?dHJSSm5jcXMrZUNqQkoxVWNlVWJjRENwODg5S2dueXhMNW0zTmZPNmtsdWxD?=
 =?utf-8?B?OHlDV2ZoQmdxK1Z4MjAyU3gxSlZSVVM2YjhDZmZEVWVaQlJaNTR1WklhTDdl?=
 =?utf-8?B?YUhsOFlXZ1N3TlhiN1BzMmoxNW1qUU5OWEN3bDcvQlpmblo3citIUStQODlT?=
 =?utf-8?B?VjBzRzFjb21PSE5QNU56eEQ2WDZTRmlWRkZTMHE1cnBEakF3ajZQcEdBSTJP?=
 =?utf-8?B?VWhXN1h2K05ZM0dqcjdnVW1PZklvemoxNHN3Rm9CbWVTcmd2UTkzZlJvNTBv?=
 =?utf-8?B?NXU3cU1pWXJsK0pSVlA0YnN2UFRHUzhCdDdJRmRMV2lkT1hZNEM0UTNEQlVw?=
 =?utf-8?B?dXJUcmVnM0hsWlpra2w3NlB0cUxqZ3kwUTNKZmlCMkRpVWpETWhMSTlaOC9X?=
 =?utf-8?B?eEQ4djVEd3o1amRhSElxdm5ncGZzQmJIbC9hM3dHMzJ4L0NuNi80dGFiMEFI?=
 =?utf-8?B?QUVyRVkvN29HS2FPMytnTjlUQ0ZnM21tc3hUZGpOa0srNDI1dEhEeXVRY05Z?=
 =?utf-8?B?ZFVZZG5CL0t4TTdHS2ZyUjFxTHpJWlVsVmlmQ2ZvcEpsd1RvN2RlUi9BY0ZX?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49fbb96-4a23-49f1-44b9-08da65f91690
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 00:29:32.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF5nZkVg4uXs/Dmd/0jUoF1zAiCl8vrjR2Hlna9YUI4eq8QyAe2E6lCEWC8lThZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3201
X-Proofpoint-GUID: LbZwBuDQ6snik_NDm9DcMqNq2CBSGDGk
X-Proofpoint-ORIG-GUID: LbZwBuDQ6snik_NDm9DcMqNq2CBSGDGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_19,2022-07-14_01,2022-06-22_01
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



On 7/14/22 4:21 PM, Andrii Nakryiko wrote:
> Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
> debugfs (/sys/kernel/debug/tracing) isn't mounted.
> 
> Suggested-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Ack with a few suggestions below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 68da1aca406c..4acdc174cc73 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9828,6 +9828,19 @@ static int append_to_file(const char *file, const char *fmt, ...)
>   	return err;
>   }
>   
> +#define DEBUGFS "/sys/kernel/debug/tracing"
> +#define TRACEFS "/sys/kernel/tracing"
> +
> +static bool use_debugfs(void)
> +{
> +	static int has_debugfs = -1;
> +
> +	if (has_debugfs < 0)
> +		has_debugfs = access(DEBUGFS, F_OK) == 0;
> +
> +	return has_debugfs == 1;
> +}
> +
>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>   					 const char *kfunc_name, size_t offset)
>   {
> @@ -9840,7 +9853,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>   static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>   				   const char *kfunc_name, size_t offset)
>   {
> -	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +	const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";

I am wondering whether we can have a helper function to return
   use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
so use_debugfs() won't appear in add_kprobe_event_legacy() function.

>   
>   	return append_to_file(file, "%c:%s/%s %s+0x%zx",
>   			      retprobe ? 'r' : 'p',
> @@ -9850,7 +9863,7 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>   
>   static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
>   {
> -	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +	const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
>   
>   	return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
>   }
> @@ -9859,8 +9872,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
>   {
>   	char file[256];
>   
> -	snprintf(file, sizeof(file),
> -		 "/sys/kernel/debug/tracing/events/%s/%s/id",
> +	snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> +		 use_debugfs() ? DEBUGFS : TRACEFS,

The same here, a helper function can hide the details of use_debugfs().

>   		 retprobe ? "kretprobes" : "kprobes", probe_name);
>   
>   	return parse_uint_from_file(file, "%d\n");
> @@ -10213,7 +10226,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>   static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
>   					  const char *binary_path, size_t offset)
>   {
> -	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
> +	const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>   
>   	return append_to_file(file, "%c:%s/%s %s:0x%zx",
>   			      retprobe ? 'r' : 'p',
[...]
