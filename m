Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B40671336
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 06:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjARF1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 00:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjARF07 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 00:26:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64B55865B;
        Tue, 17 Jan 2023 21:26:58 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I3v3L9030749;
        Tue, 17 Jan 2023 21:25:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8Up8yuHCVJCQmUn6AHQzBiZ0xSDVzGeon7blaLPO+GY=;
 b=EmQzcjWeQlDccuCkmRq1fxkYjjevCVuTFNb3qLqUhR+LFBDSNKoG8v7HcwgjAqQBNPTZ
 NNnO5g3HHZOoFcOqo8mU+dnho1R7LDNPJTOKzL5gQFuyQ15TzaOi+G0BbPVpwyOKkUc4
 TFblkxk4EKl1z0Rrg9PApae1vwwHekd1b6psvdGzAzNzcWXA3VS651yurdYpKH6D96DS
 Hp5b6tdAB1ox5OCPGNOYpu9vdGR1XnqhdqSjr60tcgrmapyDOicp68cDTYPGkYczs0Ao
 LHreAIoMgQezwjVMcJfdWLXQJUoNjkIYH4SWPa2/aiRL4gXmblwOTnRqw4sYY9lVBkui hg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5rcwp72w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:25:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEZQAp9lyPNyLTZXIGkxcMLO/rIHhxVz35Hnh3z4C08Qyi71LfYd0ngEm40MClgPA0eocO9eLpegoOSaNUWIhRAvBzoAIfPYnJeHc7j83CeD/mZh7qLUukiLpjM10VKgNDPtpD2W7pQXsiEsSIqiZLK7TVmZ/U3Ngrjq0lw/itOb11F1M4fNkCsgjRcyHCj0zsSKgv5P84UoShotziNj7EC0+aXjUB2ZFb93wYHjhgvT4NQlAhh7Lgdztyg+X34D/q/Oz9G438H6VNYwNZUWPhR02nYHJdHGPcycyHy6i9QoOeOAnFKw/KlKRWSNvyncV3no56MzxhLZzFn7AnT38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Up8yuHCVJCQmUn6AHQzBiZ0xSDVzGeon7blaLPO+GY=;
 b=e9vVVRhardSMC+TtvdXpYi/6ttOF2lIJOSNEGVpzmErecUxvKzI4carCnUSrpWfI1EZfV3PwbEQaBaFTyPgBmZ5FINka+LcqKtPRX5c4VONvo0tIP6eUW/B3FPgIzu6UiehGedCdiqurP5iYNQBbbEAXHSdUKgVfpVsUH17NE74uyc9eHzIc8szsqTlFRV7x+FqHJeedwKu8M55OEhWi6CJ6LutCa4i32EhpfXPO+mktj+tH2k/fWqO0AX2mg9WPWvwRRpNQea1Xo/DzPywz1m5sCnv5aSw3r1YAM/bYCxyixXDM/53Fj4SAhKu6JoLxgUB48ZBdKb73h4vTuV6afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5312.namprd15.prod.outlook.com (2603:10b6:303:16a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 05:25:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 05:25:25 +0000
Message-ID: <fff62f98-dd2b-21d1-2a3f-f63122b2c2cf@meta.com>
Date:   Tue, 17 Jan 2023 21:25:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH V2] bpf: security enhancement by limiting the offensive
 eBPF helpers
Content-Language: en-US
To:     Yi He <clangllvm@126.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com, linux-security-module@vger.kernel.org
References: <f539bfef-c098-5ff0-51ef-bfa8fd0c4661@meta.com>
 <20230118005432.634229-1-clangllvm@126.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230118005432.634229-1-clangllvm@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 086fd97d-18fd-4982-6bf1-08daf91466f9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mpmE6J9q6VodRgUjAfoYMNB3TOU1pXY2sxQ1TJhBo4xhcjh6XvGzfadE30qks8PAjjKZcq5iBEpsJ9DpIbVlupjDHa/iwXxNzo34wemMofY2C6ZXQnAppApZjrZecXj/24EcfdmLDQbSlQ6A24Przvg6jlRbjSD+UR+Q0H7S/xoDHZgC2Xz/sLONakRt3/ZR3bkV1rTBYSara12LaVRtLfe1ClvUPaEDPHcKb7tXIqjD4VjuHikAyc9qPbd//qeyhvn+gqFWN4Mk1uAUSKstfU44diCcPkIRQteoop1Vi0u5tbqQjW8m8l2LB6G8ZTf9jP0HP65HrmqQ6DUTewPbSzmTuezGLzvuU7f4p2Kv1nPff19zpyNoaS77ctU7mIE30v0PBT07lqnQrLzVILdyWNtth7l0sWavrOoQgpAsoFsRWgK5TsHV7vX+UyQ4HetXp/NZ+Wpwv10Labb8TJSl2mDJrO94IX89XQl2b70QKKdPToE4BqfroIaCzV5Yi8kDYd1mgKds6Qf6fM4ENdMe/Qgba541+cD/838qKLcJA1/gFI+Am4aa3qjPFkd7WpbNH++8ccNhbJwqnk9a63XYO0Hl15oE4yTf7SCskCHNoBJlYs+Bwn97i5KtWjrdVlHlZkAgy+P1UvAulN3ZNdVRiWJdPSVYo4eXHoMk6bDMH4tEghs09iigfx788MJmieGIRohI+HVQcjmdySDkW+T7Ey8RTx5kmgtOmcNg++G6c0+r8C9aiDywc9v0OS9AMzTIN8hSUGYRCNn1u+EwK8DQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(31686004)(316002)(41300700001)(83380400001)(6506007)(8676002)(8936002)(4326008)(66476007)(6666004)(6916009)(66556008)(5660300002)(7416002)(15650500001)(2616005)(53546011)(66946007)(2906002)(36756003)(38100700002)(86362001)(186003)(6486002)(31696002)(6512007)(478600001)(525324003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFQwNUxxMVIxU3Zuc3BuNFVZUTkzY1ZiNTZBaWFlS2pmeXZNWEw4eVdGb2Vi?=
 =?utf-8?B?VzBoUHYzbFhxZmdEZ3pscUFiUFR4WjIyVTkwMWlhOVlmOEdRRktlSXZMbjFS?=
 =?utf-8?B?QkJENk44aEducjY4akZINGpMa1F0NkFVSGYvRjlWVmhGOVRsbm5WbUliYTNk?=
 =?utf-8?B?VXNRblVSblRwaHRvTTdDbDdnSjZvcVZoYTZKc3FENG9xWUVMODY4YnNpcWwr?=
 =?utf-8?B?T3FEU3lJdzdiUkVRSzJCS0NabjBsZnkvYWx1MWF6NzE0Q3ZyVkpReVhaM0ox?=
 =?utf-8?B?SUJQYmsxTXR3cjVLUVBDdjREdjcxYlJ3a3VTUk9iWlpNTUd1dmkvQnF0aDBp?=
 =?utf-8?B?eTFZZ1cyUTFjQ1puQ1pKV1lpa1pkc3ZXRGtlUXYrRmdJb3VHOXcyRnhjQUg3?=
 =?utf-8?B?V1BCUDk2SFZtWndIclppUEtJWkI4TFArTzRsQlNMZkpVc0UwRDBESGNqK2RO?=
 =?utf-8?B?dFRmRVVIbmVzTUFvV0RpR1hlNTFyK0ZXS25heGlEcDFBYnNReFZyT29sNitE?=
 =?utf-8?B?VmJ0elA1cnBaUmZ2Wll0YkE0WUE4cW1xeElUWFhPOENiejZFYVFFLzJaSHJI?=
 =?utf-8?B?ZGNLaU1RUkZxOE1zMFRXR1JBdEwxQlBuNlBMZmJWcnFwai9WdFlyTFNlRlZs?=
 =?utf-8?B?VGZRbnhMbmxONnJqTzJYckQ3a3E0cmhzeDBaTjRRSHN0NktuaDZvMFJwM2FI?=
 =?utf-8?B?WmpKZjZxclBMVmJ2MlJLUnhBZmRkTEsyMFdkYVUvcGdnUTR1dnhaWkFWZU41?=
 =?utf-8?B?SDh2ZDdTR29iWjZuWTk1dzM1eXVVcEhScitQWjU5UTlRTTNZczJhQUZ4SVlM?=
 =?utf-8?B?dXc1UWNLL0xWQjZpaHgybGpHVmtDQjRmaFVST1lya3RxcEJiZ1loa2cwdkJt?=
 =?utf-8?B?WWcyMUVxSFpiN2xuNzd2SWROUVVtckZSS2hRRndzdVYrTlE5WERMaENrTUF3?=
 =?utf-8?B?MzM5eVBTd0ZsTmFEaUtQdnRta0ZPQm5TVmMxWDNtWVlEY3RCQjdRQStBaWhY?=
 =?utf-8?B?RGc3aCtJR2UxMkJDUUs3cFIyRUtubDZrREx4VDkxcS9mWFZKV0hMd0NFck1L?=
 =?utf-8?B?TVNXRFpSdDR5S21DWlkxeGRCMFJQeTF6eCtMUmtUU1VPaHF5QThuOFc2Qkt4?=
 =?utf-8?B?U2pWRDZraE95cHhiNEVWdDErS1c1VGY0THU5OWV4bEJhUVFmRTIxZnFNU0FB?=
 =?utf-8?B?TWMxSTJCNmVodjUvMWUvMXdUajZ3ekdDRndsTENvWExPd2Z6MzFMZ0xmZXYy?=
 =?utf-8?B?WXJNU2dsQjR4dDB5dEFJKzVaTkc3cDNxM01jYktBQ0NoRnB2c0RjUnBuczJ3?=
 =?utf-8?B?M1A5R2JTNTljcWNKQStOakRaaEV0S29TYjJyUk82N29jTGNEZ1VVenpwSlkz?=
 =?utf-8?B?Wm56RjRQS245MXN4aEZ0bVJWQ3pEeXB4QkZJeTVoQXIrcCtjRnNBbnZia2dC?=
 =?utf-8?B?MVZObCsxMU8vdm5YNzBieGY1VnFMbDl2SWpIYkNla3ZTWjZjRUJTVHQwY2h0?=
 =?utf-8?B?RG8ySEsxdStTVHcxL3hFSVBMRWNNMnVIQ1JOeDVrWDQ0RTNGcVlRdWdqWTNa?=
 =?utf-8?B?eDN0YkpHM0x3OTJFUHIwa2lyV3I0NE5yZGdWQXM4UmdHZGUrbXNHZXM2T0F6?=
 =?utf-8?B?VWVPMVNKTFRNNmZ2ODdQVUc0RUVtRkFEYTc0UEIrWkxyVmI2K2h1MUlKWE16?=
 =?utf-8?B?K3NVS2w4VWJTVGtRbS9lTjFzQ3p2VFl0M1h6YXJ4L2JzWS9iZ1pSZlZDSC9n?=
 =?utf-8?B?akZHbVpWeW9OR1c3OVREQzRzdEVSOEVxYXkySkRWUFlSa05ZZmZwbUhIS05K?=
 =?utf-8?B?SWVZMkhQSXgyL3A0MjUzd1h6aXRFOGw5a09PSkZpVjZ3aUdxU3JkQkpaT0Fa?=
 =?utf-8?B?SDZyVVRFYlc5aVFiQmswZnl3dkhDdFQxWlZWS0poTng1OFhTVW5NQjJPa0FU?=
 =?utf-8?B?ZzArTzYrdm1Qa3VVSW04MnBLeVhuVlhTNmc5WHR4VXZ1ZEZodG9UVlBSdXQv?=
 =?utf-8?B?eTlId2Z4QS9qOG1ZQ2FNWW0yOTNWZzlmY2JSRUoyN1ExL2RRZzkvS2JXU2h2?=
 =?utf-8?B?ZENzTVB1SThTRXZaTWx4enN3b3ZpQ0ZmK0tZcTIxeDFoZUhOS1dNSnBKMDdM?=
 =?utf-8?B?ODBFcWQvZjhnamFLbmxwbzhydThsVFVWOWJ4ek85U1g0T0plM3I4aEY5Y2Fs?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086fd97d-18fd-4982-6bf1-08daf91466f9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 05:25:25.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kakBL+2cZ7ez2u5SvVy8UoFwNCpQVN/bGT37oN44uSdVtNcMvsEHT+e3lSGMqpnp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5312
X-Proofpoint-ORIG-GUID: blwsCUM3t9drBKFpc7c5YVXx9SITNJGQ
X-Proofpoint-GUID: blwsCUM3t9drBKFpc7c5YVXx9SITNJGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 4:54 PM, Yi He wrote:
> The bpf_send_singal, bpf_send_singal_thread and bpf_override_return
> is similar to bpf_write_user and can affect userspace processes.
> Thus, these three helpers should also be restricted by security lockdown.
> 
> Signed-off-by: Yi He <clangllvm@126.com>
> ---
>   V1 -> V2: add security lockdown to bpf_send_singal_thread and remove
> 	the unused LOCKDOWN_OFFENSIVE_BPF_MAX.
> 
>   include/linux/security.h | 2 ++
>   kernel/trace/bpf_trace.c | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f..42420e620 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -123,6 +123,8 @@ enum lockdown_reason {
>   	LOCKDOWN_DEBUGFS,
>   	LOCKDOWN_XMON_WR,
>   	LOCKDOWN_BPF_WRITE_USER,
> +	LOCKDOWN_BPF_SEND_SIGNAL,
> +	LOCKDOWN_BPF_OVERRIDE_RETURN,
>   	LOCKDOWN_DBG_WRITE_KERNEL,
>   	LOCKDOWN_RTAS_ERROR_INJECTION,
>   	LOCKDOWN_INTEGRITY_MAX,

Also, do you need to add an entry in lockdown_reasons in 
security/security.c?

Also add linux-security-module@vger.kernel.org so security experts can
chime in as well.


> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c8..fdb94868d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1463,9 +1463,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_cgrp_storage_delete_proto;
>   #endif
>   	case BPF_FUNC_send_signal:
> -		return &bpf_send_signal_proto;
> +		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +		       NULL : &bpf_send_signal_proto;
>   	case BPF_FUNC_send_signal_thread:
> -		return &bpf_send_signal_thread_proto;
> +		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +		       NULL : &bpf_send_signal_thread_proto;
>   	case BPF_FUNC_perf_event_read_value:
>   		return &bpf_perf_event_read_value_proto;
>   	case BPF_FUNC_get_ns_current_pid_tgid:
> @@ -1531,7 +1533,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_stack_proto;
>   #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>   	case BPF_FUNC_override_return:
> -		return &bpf_override_return_proto;
> +		return security_locked_down(LOCKDOWN_BPF_OVERRIDE_RETURN) < 0 ?
> +		       NULL : &bpf_override_return_proto;
>   #endif
>   	case BPF_FUNC_get_func_ip:
>   		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
