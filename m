Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD464CE75
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiLNQ4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 11:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiLNQ4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 11:56:13 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9729828
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:56:12 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEGLJpt006382;
        Wed, 14 Dec 2022 08:55:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=rk5O8L6FQBy6oW601MnUIXz1qeL+FQ+Vj7N+qq/80XU=;
 b=kQCgLDWcWiVFjG2+N3B7Cp2l3FLEHZJM+YuIb4FLsoUN5RMktjRvwsNVDZJtKMHRtBOu
 6ZmHPjZpk8pf6vY+0XTQwtFX5jbjAMG26gM/WQ0CqtQ5JUuEYqqT/XaxCVWzXvaQj7fe
 40N85OJasYaTsISYzdQ+SyiV1xNb/6xpEpL2hTr+xBLkcj7Oqz68qg5A/uAGdVNO1OhM
 dmqyV5ZwinDnnYW8IGdjGve+x11iT7RxDfn87UtQ+V0qmVeEmI680f54cNlCcdV/eUyU
 6vkiolsQW2Nh+qiTO+4IRlg0ocV805J6q7e4/Ow60Bj4h/qEBNP858dLKqaetGzOsSHO lw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3meyg3qpcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 08:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvfpLgQxDy/E2pXBS0R2yBuZLHz9X5Xp14ERAnMoawUHi8vsMEJwMlDDKUT7FJzIH6cF4iIB5dYpRbwDg9I5orwPPc/vPb6WPFhDh2M9KyzRcyyAQXejSAbKh+tUeW+6zrlKJm2GwCn5lAoFtBJdy9ARHdY0ik+eSzjd8/Vpykkk57ugQ1/3tJoW7qWzL27LEnxhdDWPID75ty7BLFgntff3M/uP1jfadou16/1wdhmR61nMRcz/bn3qTw4YsX9SsXji6YpX2aHUsPZGWiQGf91LxNTUka2JyCMWpshoqP2/0KWLMxeRd5lP7bIO+zrsUhVgwh5Un+m8u01x9BqIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk5O8L6FQBy6oW601MnUIXz1qeL+FQ+Vj7N+qq/80XU=;
 b=KuJEJdVThxMLn4TaeP1HWxYWFza2JXFDoC3013hJfJdB+Y+HMlCWgAzZ/HStKJyHDpleewausX78tEvyK45VUvIVOBBk5EA4sgldwU3wOZqstR899KVCag/XInR/I02fYbCslQ3LczJmjX/kyH/Onm6H1mBZtaCNTOuMH8HHCKZ8hnPlFDzD4FzULXQ/7E4IyGrvre6tz/ex3CeDJrqKQOuHHsl3CwELft5Jpjh6XFoj7SJQIc/oEDY05fHrdZ+WDOgiGL2C4fd5gfJcCpr5QrYygm75lhUHC5Kx7QiEFn6sqFIdpjTsbySBbq+5di9NNUwf30Xlec+9HZ25wEDqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5637.namprd15.prod.outlook.com (2603:10b6:510:28f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 14 Dec
 2022 16:55:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 16:55:51 +0000
Message-ID: <00f0c6eb-46fd-6dfa-8757-90dc296aaf7b@meta.com>
Date:   Wed, 14 Dec 2022 08:55:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCHv2 bpf-next] bpf: Remove trace_printk_lock
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20221214100424.1209771-1-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221214100424.1209771-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: e41969c4-65b7-409f-a684-08daddf40e57
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KC9z7UpV/+68nyz3+2PPzYmkdpHQgdL0B5JVMHiHXtYNeYRE2yHWUiy/Gr6JWEYaDOt4LQ85kMkm21gjwJG01/8nzJtQKGjDpZWk8d4vUBkLx/Ji//6BlniJPYTm2xtcfdUfoPDpXa+XWyIsxaj4aEbs1tESIdxXV4m8vW55aYcs6IG/dYTJPelztJWeSmN6JfUn+Z4BDkXM5XBqBunCM4F+baydFh8i7MxeNJJKo0X2QutO3MfSJIHz1SWufkT7NcK2D7DPNPCAHzSFp27L0CIQD3YsrhdRVfthWBJf04OaWcdKmI8d1S9e8QHHlAAOwkrS6wr/DS3MtX5VlSnAXdyCCG/v7gI9P9Ppcbu62LV/0qGffWpISFNpjyRPbxoIpWDfibp8lgsUn3VVZCSCQXHN92Jw0RSYvnJ3bIrtzBM8+FFuyQIvW6vgV/9s2gfthTT0NydFUfYYf7I0XzxdLlyXbIE/OP01L8SSu9aGq4AUON54hLvtE8ZqFqsSfxxNMiq8PM0E4jYQK+bLTx3WaKXhIrTzcYdV0xOPKnemEoGXC5M93pL2CP0B8aPUnRM4YMjcEQC/4XiECuYzphja8mLRHBld2opAemsaf26WNlGfod2UIbsIIjRK6gnz0uNHi+ZmYgn+DH5Y0j+Cag0Jt6WlsodIlqdGOS/ql0ssuYfCYeL4IBy4JUXVACtdjZgJJ6g69P1TqvjpBJgI8u6ROURlZUecgpuYrUhs2fQZFmvoDemairpuFNokwCWniLHFwrabxDT1VEY5eCbZw9ppkL4yI4HFWrNmnWUs1MI9rdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(31686004)(7416002)(2906002)(316002)(110136005)(54906003)(8936002)(8676002)(4326008)(66946007)(66556008)(36756003)(66476007)(41300700001)(5660300002)(966005)(6486002)(6666004)(478600001)(86362001)(31696002)(2616005)(186003)(6506007)(6512007)(53546011)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlRWnUzcnlUQnFIZlpJb3prdDU3Z0ZsdTVKNjROc3dRU28vSTBoRWRDUzg5?=
 =?utf-8?B?Z0RGeUgrQXpQazU3bU5QZ0swUnU3anVSWTB4aDFMWTh3UkJIZEpDNlM3MTdG?=
 =?utf-8?B?NTFNbDN0dWFsT2pDbTRPUWZ2MHJ2aFVxS0plM0p3Kyt0bDFPaUc5bFJsanFI?=
 =?utf-8?B?MXlOUGE2TGxSTE5TRC9DNXhmRUcvQnVyQlVoaFpjYzkra2JuVzlvRHF6Z3BB?=
 =?utf-8?B?Ty9ZenhUTTdMQlUxNnovb3ViSWZFUTBHa24xdGliTU1ZU2p2RUUzTkVseGdt?=
 =?utf-8?B?dmhNaDdHcnNWZ2FEUnlLRDNBUmVDLzV3RWRDM0N0elcyMzE3MjJkcmxvZ0lY?=
 =?utf-8?B?eFpjTldrekVtV05jUjErUnJZUENtRTE5NWUyK2hKNm9Jam1FVkJyYThMcDBw?=
 =?utf-8?B?YkpXamMra1lvSkFMUEd6Q2lwN0doWG1MNGppMlVUMkF0enJBOXFtTTEwU3J4?=
 =?utf-8?B?ZWRaU1VDZkpaSm12N2d4cTB4RG9sZUxleTZSNGEzWElFOVE5Mm9xT0JTblJZ?=
 =?utf-8?B?ZkM5d0JoV3FQelBaN1hwdE5QSFRhZG1NQk92WFA3VUQxdExLVzluQmYrSWt1?=
 =?utf-8?B?UUZwL0FPTVo4QUlrSGJqR3lLOU9VNUFVeVZKNFFvbWIvU29QaWVGZHRIWExl?=
 =?utf-8?B?R2NDVWNwa1FaWWc2M21iMVpPVFdpQ3VlRG1QRlV2VzFiaXUzTEFIVFBoZW5l?=
 =?utf-8?B?S0lDVlRwM1pLYk1ySjhYcngwODZab1NDb0R3NHYrRjVpMk1sM09GTzIvanlV?=
 =?utf-8?B?b1I3WG5IRUROV1lZSDg2QTZ1Qnh3L1lwOUpNa3hHZnN2dlZKa1FzcFRjQXNq?=
 =?utf-8?B?a2kvOFlJR3Y0TGVDR3djYmdJaWZaZWVJOE9GWTlQMXBLUno5VUQ1T3NNalky?=
 =?utf-8?B?eG5PNzhpSWk1cG8wVE9uamNEL2U3RmZUbEROaFVEckJxK2M5eEtqMVBoQnlR?=
 =?utf-8?B?SklaQ1JxZldwZ2VVMFFGRE1lYVlhTjZkUWRqbDlkQ3h1NkJyWE5uYnpYR2pM?=
 =?utf-8?B?T1dIYy9jQkQrWEo1UjFoR1dKaUxxMk41YzhVS3NIWkZwVGdPNnN6bVl1Rnlz?=
 =?utf-8?B?dEtFS0xrMXBjZGRMS1hyM25IdUs1MTlXVnMzUUxGaEloSld0dFNyeVVnKzdm?=
 =?utf-8?B?Q0FGbGNmd0lvcWZjMmpYb3ladUJJb0ZMbHhmb29manlrcmFSWS9WYTEraDFD?=
 =?utf-8?B?MDUyWUV1TDRQeGhTZERJUzF4YmFQeVNFemVmV0FZUytkYnJ5MlZkTE9YK1hh?=
 =?utf-8?B?YW1USWJjQzZmd3ozZkJwOG9iWFVoTDRQWGNTYnFCcWRGS0liV1pNTWpVNjdi?=
 =?utf-8?B?ckpZajhSUTh3bkhXblk2RjBtWUZHT3pIdzRmNmo1bjlSSjBxVDkvWVdFWUZK?=
 =?utf-8?B?TGE3Q3RnVXVBTjJCZDlYdkxyVGVISEZYSmxFak5CS2hsdmNwSzAycWVucGt1?=
 =?utf-8?B?TnY3ZjBsYXRXeiswbWpxWDUraVZ0ZmpmWEN1amdxQWs0NzJMYlJaeklhZmhl?=
 =?utf-8?B?QVU3R1ZwOHg5cHJDbWhIM0xBeHZGclR0QWhMVkNDT2FSY3VvUGoyckd2QW43?=
 =?utf-8?B?QkhQblBMVmp0SjFpOXJRRm02TVJDRTBrVXMxWVVObkJGbHFOQmdON3RIalBG?=
 =?utf-8?B?dWQybHF5YVZnbDE5OGM3ZE9QcjJETnArV3R2eEk1WEltd0VTTmMwWG84TXYz?=
 =?utf-8?B?ZHIzakhhZ1FCcEFRMGhqRnVtdmMwb0QrMzQvWWdZTEtlY3Y0ZzdzblhwRHdB?=
 =?utf-8?B?QU84dVVRdm00L0x3Q0RSb3JMU3ViRjF1NXMyTGx2UnU1RGRIT2JGK0cySmZp?=
 =?utf-8?B?VDRnaFBUNEM2aTlYL3JLeno4UThGTnhNcVY3Sk11VHFkc1VjRGUzNnJXZDVQ?=
 =?utf-8?B?NkY4VGtaNzQ1SEViZFRiVVZwcnVnbkh4QmRhZEF0U0F3ZStuUUs4OTJEOEtK?=
 =?utf-8?B?VTJ4WlY1aEk0OXJKV1pRVzZHS3puaDgyc2E1ZHFydUxla3V4MkR0ZjhoWVFK?=
 =?utf-8?B?Q053WjJJbXVXRk9tYXlnK3c1MTRQMDhYUE9ZVjZ3M0Q5RU45RkU4QUt3YlFw?=
 =?utf-8?B?blZucUFIcEtocmtVbVVkclVteHRocUtCZE1vWkhWdkJYa1ZGYXdRM1N4dVFH?=
 =?utf-8?B?dm53eExSRWU1NHNuNUtNdzJza3R3c0V2MVhOWkdJa0FZanlFd2dCUjh3Ung5?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41969c4-65b7-409f-a684-08daddf40e57
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 16:55:51.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMSLdjX99uqZtWF3dXdetRJpH7OZx6hHzmMP1nEfo9rkJ241jIT6fAWAe3Pt08M3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5637
X-Proofpoint-ORIG-GUID: 03LxFzyc_hMm24ZtwL9Xxuwr-OObJouJ
X-Proofpoint-GUID: 03LxFzyc_hMm24ZtwL9Xxuwr-OObJouJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 2:04 AM, Jiri Olsa wrote:
> Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
> guarded with trace_printk_lock spin lock.
> 
> The spin lock contention causes issues with bpf programs attached to
> contention_begin tracepoint [1] [2].
> 
> Andrii suggested we could get rid of the contention by using trylock,
> but we could actually get rid of the spinlock completely by using
> percpu buffers the same way as for bin_args in bpf_bprintf_prepare
> function.
> 
> Adding 4 per cpu buffers (1k each) which should be enough for all
> possible nesting contexts (normal, softirq, irq, nmi) or possible
> (yet unlikely) probe within the printk helpers.
> 
> In very unlikely case we'd run out of the nesting levels the printk
> will be omitted.
> 
> [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
>    - changed subject [Yonghong]
>    - added WARN_ON_ONCE to get_printk_buf [Song]
> 
>   kernel/trace/bpf_trace.c | 61 +++++++++++++++++++++++++++++++---------
>   1 file changed, 47 insertions(+), 14 deletions(-)

Ack with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..a992b5a47fd6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -369,33 +369,62 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>   	return &bpf_probe_write_user_proto;
>   }
>   
> -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> -
>   #define MAX_TRACE_PRINTK_VARARGS	3
>   #define BPF_TRACE_PRINTK_SIZE		1024
> +#define BPF_TRACE_PRINTK_LEVELS		4
> +
> +struct trace_printk_buf {
> +	char data[BPF_TRACE_PRINTK_LEVELS][BPF_TRACE_PRINTK_SIZE];
> +	int level;
> +};
> +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> +
> +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> +{
> +	if (WARN_ON_ONCE(this_cpu_read(buf->level) == 0))
> +		return;

The above WARN_ON_ONCE is not needed as it never happens based on
implementation. There are a few other similar cases in bpf_trace.c and 
none of them has WARN_ON_ONCE.

> +	this_cpu_dec(buf->level);
> +	preempt_enable();
> +}
> +
> +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
> +{
> +	int level;
> +
> +	preempt_disable();
> +	level = this_cpu_inc_return(buf->level);
> +	if (WARN_ON_ONCE(level > BPF_TRACE_PRINTK_LEVELS)) {
> +		put_printk_buf(buf);
> +		return false;
> +	}
> +	*data = (char *) this_cpu_ptr(&buf->data[level - 1]);
> +	return true;
> +}
>   
[...]
