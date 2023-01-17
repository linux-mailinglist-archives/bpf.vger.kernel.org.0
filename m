Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8066E4E5
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAQR1V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAQRZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:25:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62546705;
        Tue, 17 Jan 2023 09:25:28 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGBCti003854;
        Tue, 17 Jan 2023 09:25:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=/c2w4S44VJNdUsjpTliRPnyIKTJmpHPiqtZU7p8FXPE=;
 b=D3EsqNUpY/6oNvNT7CqFLzH8t8oCHqhybhAImsnamdtNPc7XQgEpTHxnVeD1zLKZbJpC
 flkYx4uzjN0dgMMrty6JkzoUlAFbg3AiBGFCSzClxilLW+Rb6PXroF0revOkmWbLFNEP
 tMrP411+jqbAXa7VkE+nVgSi+HPrwxYneMq+vpTdqiPE7lhn4g2dd/Jq7MxgGS+uJOSu
 KC3sJ/6Q994VdI4n7zlYY6VlLkOLK4K3TAHjPqRC/z/a2VAQ7KrWT2x28raRg+sFS5H1
 jrqoB7i9z4VLAF+UgFMtegFq1bXur5E9ZHrZmLr2yO+pN+gW9VktBqo4Qm7S9txmZbgc Gg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5jdx4atj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:25:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGtfmKqIJDLYBjbaRguAUDRWxoRg0gfePzBruUoaDmg2wIYbUQx85AuEyH28urrcZ2OD2/Der+k0ZvwLVjCBPXJ11OTqHy5sf7wDDSscJdXi7c9BH0Umui8Mx3HD3uQGYDlskSpM9e6qepb2aauGG/dJcBpbFhdyUASI4c4qPZZQBXX5ChFntWdz+hNSD6plJjh7tm/RVOiUIarGJWQ+i9a6ZlyNmyrWaySGGbGKGmVxVajGhmXzk7/HuK5ney5bDDi1iG+MfjtEBbrX+ZKQxqfxiLnvcE+aS9lP2xuTmk/S7J5D60oFlUBHNk1ilKm/XQnCd6oCO8+L1lalVSeYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c2w4S44VJNdUsjpTliRPnyIKTJmpHPiqtZU7p8FXPE=;
 b=YJlUioOQ04Yuj+snCtTpTRXJwAjvY4dRxF5Lnn1OQyGYs+u8lzzvgjIb07G2gQJdwGPqx93D+zNpIv8vmyFKul2H0t+4bn+kNhB1DzuYuN9adGtfLMrGiuIxSRmB9sCa7U3YgpjmJb/lTTta2WT1bXd9aFSTxklrDhFcf2BvObBnHoe3aZzlU65EvpSQGch1jmYWZIBaJs15ny9GHx9hAdS0e8F0qPnPUHb2V858LnYxyfplV8ToKITYrZhcksMdNmEjrVqLVdQWF0OSosc5gjHtve4kiIcBM7KrbcNyoDs8PnFfZuDhEgu91fvmEqMTjJKDgfGtEUsdUbaI0LaStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3799.namprd15.prod.outlook.com (2603:10b6:5:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:24:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:24:59 +0000
Message-ID: <f539bfef-c098-5ff0-51ef-bfa8fd0c4661@meta.com>
Date:   Tue, 17 Jan 2023 09:24:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] bpf: security enhancement by limiting the offensive eBPF
 helpers
Content-Language: en-US
To:     WritePaper <clangllvm@126.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com
Cc:     john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230117151256.605977-1-clangllvm@126.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230117151256.605977-1-clangllvm@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3799:EE_
X-MS-Office365-Filtering-Correlation-Id: eab1b4f9-6eb4-4f67-ffae-08daf8afc2c7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWMZf6wb3LLsETb/xE2kyVZAM+a8WV11lFcCH9we0Hb6W2wTSprtYK/A15dpGDPlGrInrYFcEU6SFDZvFBDi0GTOFQ5l9bj5ZVVVtHFOsvTNK47C6YaaZpxpkdOWmSrGfsCPFNmgLd32QulcjlVNQzolRYNLXzqgloOEUywgmhYJSVcpc1GJVsx++o1T5KHnf1qYPdzEvfkOIfAukKQs2MTlDSNtQQRJk9ueU6JrIe5Bpm7jO1sewUnz2Y29w+HfF1LX5eK+S+LayxVquxyDwPt81arquL0AixTy+OMv3zvicjLejG5SKzN4OH4gH6uYxeok1CeATdaGSUA2A1hIDPHRXP/kY8MquHqgcVUllqsd8ULRp7Xt5gIuO98KVAb7dUJth0yIDEb3ZrKqqo5G+F0HQFlsSB3Moz741sG9ulbkNU+R1fRqFxMcY6biSDAoa/0woKVzohkcjtDANw/pUXLubUlYQciHNBGc0AB/nsQV7c6cCnwGYiHK2Bpl9/BZYfhctbX7DVdVPp/ovdPrtbc9B1foCZFUrC+V5D9Q7GALUT08coC1zQBIy6vWN/hiYBWNsVm2fzG8Z1XO89H6LKfRhmgXn/7zuuFIHhHgCzZWwexLwQbX6MPaDVzaFD9SlixiZFW9g/jDOAS07jnFTzkv4yYP9tfEeSKycdMldnot+zyQ4K2T4xBJ0hl0696jZdgOA+G+oYwjD+vAPxn2XowfWljxlbFlm1o0/8nifA0nLssygUZmVugOxJp1IdW7yprjLt5DLXgL4iWHQNWzow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(31686004)(36756003)(2906002)(86362001)(8676002)(15650500001)(4326008)(66556008)(66946007)(66476007)(8936002)(31696002)(5660300002)(7416002)(83380400001)(38100700002)(316002)(478600001)(6666004)(41300700001)(2616005)(6512007)(53546011)(186003)(6506007)(6486002)(525324003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhId0xpQjM4dEJzMHordkwxRDlmNFdrcGl5Tm5ENUVVZ0IwOW14ME1zdFd0?=
 =?utf-8?B?SFlTRGRXejl1OHowcGdadGFlNjNiUCs0RzQ3T2Z4UEJVZ0Mwa3plN21RYldw?=
 =?utf-8?B?bVJZYUk1dmVPKzA2bHlkbWk3bWZoRnN6ZjlIOEFiWEMvRjBoaXQ4WHp5cUlE?=
 =?utf-8?B?WEpmcEI3RVNMNGE1YWxRS2ZTdEE3WkQ1SnBLZ1FpbHNOMlVNQjB3ZGVOWnky?=
 =?utf-8?B?TlZyWUZ1U0RiazV5Ty80aHM0NzZtYnl2Uk1Bd0NLZmZQTTlIYnNiQmRWSjlM?=
 =?utf-8?B?M2NWTVRRbGtSaDRVQ0h0cHY3elZHeTRJUDMrUGkwL3RJVWJPc3plRUtzdmpo?=
 =?utf-8?B?blUvUGN4REdKb05NUWNYcW4wbktpVVc1VmVyeUUveTM3TXZWYjlnUFh1UEN6?=
 =?utf-8?B?Q3dLUjVlckRJTWdiRDR3dldvZDgySGZKL3hjV0pRUW1Pd3hHZzltajJTSVBH?=
 =?utf-8?B?cWRYZUlyNTMzVHZLT1pRdHR4cnZibXUxZzZrL0lLb1hNR0ZmaDA2T0RBTHN5?=
 =?utf-8?B?T1Bmak9oWTdYQXBOQStDYVI1R2hON21xWTBiWFhBMGZoTHlKaTVadU0vODBz?=
 =?utf-8?B?QjV4bnJrTjAwdUdjWG5EMm5ma3Y1SDRpWEZ5RHF2dTBSaUJHMHdVRGxKUEg3?=
 =?utf-8?B?L3VhT2JvZHo2SW53NFJ0a0VkNllRMHhSS2ljNVJxbFJRYUszVG1sV1BPTG1O?=
 =?utf-8?B?ai9LS0MyeC9ra1lVYkNMYkdnbkNUSURXdEY4Y0h0NGN4YXJzM0JveUhKMHdK?=
 =?utf-8?B?b2l6ZUxPZkt4Z1pUZ2NELzBCY3V3WlQ4eDczY1A2bGdhYWJYL2t5RkZQT3ps?=
 =?utf-8?B?NkhaRlpDdnJvcmpyc3REaHo3TVJsRzhGMWc0cHQ5R3p4MkoxWlFWVk9DSVpF?=
 =?utf-8?B?ckxwMWxVMnFZTkY0c2pqakYwRlpUbmJacnh4QWszbzdVeld0TUp0aDFiRGZj?=
 =?utf-8?B?RWZtRi84THMyaVNYRUp1dGxQMGNmeEl4NTRZdTR1VmlDUzQ4YjlSTHBRSHRX?=
 =?utf-8?B?WHhqTTF0TlpSajdSWXR0OWdEanNMM0VTMUlUZC9UN0d2QmZXTCthMkVTaHM5?=
 =?utf-8?B?T0FwcHorbFVmaEtuZlI5NlJOemM3aUZMdzFFdTk3TmRzUE1YM0NhZWsxSEp3?=
 =?utf-8?B?MmhZYzJsQVUxcDhLZVBEZGluUlRDM25yNFJ4ZFVVakVROWZpeUxFVThyeEd1?=
 =?utf-8?B?Z2pHRndCZjRDSFBUcVoxY2FLcjZGek5aNkJsMVk3RC9wNjhxaFNlQjgrN1JM?=
 =?utf-8?B?eFVienBwWWVIWXhzVjNxVHl0UmNLbDhqNFZDZnI2dGRkMVJDWm0rMGVqbXRn?=
 =?utf-8?B?ck5FVDNVcjdiU2ZNVjUrbGR0T3N2K3UvSWZrSXpkdDRFQ2JCc0RwZGdNT2ti?=
 =?utf-8?B?clNxQ01pdElCTDdXWWRPcFhZQUxOWTk5VWJjYjNoS3krZms3aEFSOGEvZ2I2?=
 =?utf-8?B?cW95UmhJK2JoY2VmZnRXd1kwL2Vacmg4WmhyUkYyN0pXdDdtNEJXbmViajU0?=
 =?utf-8?B?VVhKbE91cVUycUUrWnZGUnRYTHl3Q2JRRDVRaGN5SUlOY3R3bzU0Q3JDSG5H?=
 =?utf-8?B?amNnTi9nRUVnbENCZ1ZIQ3ovWkMwK0xqbTkxUTd5ZEV5WTE4a2lHM3ovWm91?=
 =?utf-8?B?MERRSTVFYmdyb1dYbUhKRXZaQUZrSitIbFc5czErdmJFK0N5RUlMOWdkZ3BF?=
 =?utf-8?B?TnBmT2lOK2ZubGkxaUxHWC84WUJQdkt2WmJJUXFFWlg5UnVic0hLZkJLQ0pG?=
 =?utf-8?B?QVdzK0RXSGsyYzBBeVdMOEdKRExNa1FrSFo1d0RidlhQdG5rdGNadHlyMWg3?=
 =?utf-8?B?NTBsVk12T0s2bVF0QzZIdVg2Wk9sa0xyOGJVTWFKblJMWkQ4bW4rNk5zK3dh?=
 =?utf-8?B?TWZXY2psL1BPbTVLNU9iMUhLb1R5Y3pqK1J4M0JCc25RM2NOYWkvQkJ1RWtB?=
 =?utf-8?B?a080bzJxWlJPczNmam9FcnlIM2ZteVFDdjVIY0FpT0ZzVGp3aUo0RlZ4U0tn?=
 =?utf-8?B?VHJGMkxrQlVBdkdTUFV2c0Fnd2lPNEpNdEI0ZWIwZFFMMjQ3R3I4bHFxcTFC?=
 =?utf-8?B?cndNczJOVnNzL1hjNmR0VVM4Tk9ROGNjOGF4ekhhMzlma3Fta3BjUXZDZTRC?=
 =?utf-8?B?WTUxR0hoSTNKZFZHdWwzNmhCSWUraEx2TVZWcVJUV0RVbTRWSzk4WWR4RGZj?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab1b4f9-6eb4-4f67-ffae-08daf8afc2c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:24:59.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGrXcCYczCj2Guuqs28+VK35aBpM8QBFanak2KfS+L/201TLrHFl+Jv+5+GOCySM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3799
X-Proofpoint-ORIG-GUID: Ih4rGLEPaq3irxn-PFc9X08b07kzoQAe
X-Proofpoint-GUID: Ih4rGLEPaq3irxn-PFc9X08b07kzoQAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 7:12 AM, WritePaper wrote:
> The bpf_send_singal and bpf_override_return is similar to
> bpf_write_user and can affect userspace processes. Thus, these two
> helpers should also be constraint by security lockdown.
> 
> Signed-off-by: WritePaper <clangllvm@126.com>
> ---
>   include/linux/security.h | 3 +++
>   kernel/trace/bpf_trace.c | 6 ++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f..cb90b2860 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -123,6 +123,9 @@ enum lockdown_reason {
>   	LOCKDOWN_DEBUGFS,
>   	LOCKDOWN_XMON_WR,
>   	LOCKDOWN_BPF_WRITE_USER,
> +	LOCKDOWN_BPF_SEND_SIGNAL,
> +	LOCKDOWN_BPF_OVERRIDE_RETURN,
> +	LOCKDOWN_OFFENSIVE_BPF_MAX,

LOCKDOWN_OFFENSIVE_BPF_MAX is not used.

>   	LOCKDOWN_DBG_WRITE_KERNEL,
>   	LOCKDOWN_RTAS_ERROR_INJECTION,
>   	LOCKDOWN_INTEGRITY_MAX,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c8..3a80f4b6f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1463,7 +1463,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_cgrp_storage_delete_proto;
>   #endif
>   	case BPF_FUNC_send_signal:
> -		return &bpf_send_signal_proto;
> +		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +		       NULL : &bpf_send_signal_proto;

You should add the same security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) 
check with below bpf_send_signal_thread() helper.

>   	case BPF_FUNC_send_signal_thread:
>   		return &bpf_send_signal_thread_proto;
>   	case BPF_FUNC_perf_event_read_value:
> @@ -1531,7 +1532,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_stack_proto;
>   #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>   	case BPF_FUNC_override_return:
> -		return &bpf_override_return_proto;
> +		return security_locked_down(LOCKDOWN_BPF_OVERRIDE_RETURN) < 0 ?
> +		       NULL : &bpf_override_return_proto;
>   #endif
>   	case BPF_FUNC_get_func_ip:
>   		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
