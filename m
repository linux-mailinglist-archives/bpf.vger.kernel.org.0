Return-Path: <bpf+bounces-291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C56FDFBF
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 16:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EEF1C20DBE
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8B14AA5;
	Wed, 10 May 2023 14:15:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5220B54
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:15:02 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394296597;
	Wed, 10 May 2023 07:15:00 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A2BrYA003210;
	Wed, 10 May 2023 07:14:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3oNLsie+W4va13mY1ssg0ZqYd2C9vzs4m2iOF/Xi1pI=;
 b=kddCzNaGQi56jfhnteqXT9qkmQy7xbUqt1Gm3mJ8MiyTCeeGcigyQFXeXr9y8zJcC1Kn
 4H3meXSg0LBFDH+NHtw6UX7Xd2auIzrSd8BwaEeEfzy33FCpGtxvDhBKNRU4qYBpS81A
 UV29LhsWSVl/+DQ0RfUpLLyI5vNC7Gc8OxFbb9nD5/COT69QkmgngTwcKZwLLVQ4WKOd
 ODRF5WAHSd1jMAc7Vjcik+sp3+9DV2S4trjzbTB6SMLH2oYcHWhpLDiRzbiO6UfE5oRF
 lXeyvHu/yYixNjO86qENN3XqbEGSOVxbo/3vZbdaRTDSkBFTyg6uLGoELSVtpaaFlhB2 Sw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qg28kuq7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 07:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4s3McMutCnRqejeoS8SBwr4jwztypVJqhQeJZjjxxVkhNgbs5+9LtPaDWNJE61CbyZJESVPrVt8XiYXKTTD9XPQZcOrcEQkk35VoLo4PxlwpFzv4EvPlUnofIOL4hXyAWUgb4VF+p0/f7GeKvJqQcVQhxkjfSDq7A1pBKa27Deo0yG4w4qcy7t3KdZBfzF2CcIoLmDkEO8UlExye547+WSBY99jCNkYzItj01FyR0SBmqzYA0pihq9eNcD2R/IAFoeSNUi3fmU9mDDsrNzHDLlgT7Ha1xqTX8jnrCcGV969fdujUoz666/gFo1yZ2V0pFZ2uBDH8WBmxxhxZkINfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oNLsie+W4va13mY1ssg0ZqYd2C9vzs4m2iOF/Xi1pI=;
 b=QEHsXJbETSCxwMmIIG4GQB5l/W2HXuhA8tCkIXldef6qEUlg3yeV3zqEPYB32z+uNGSWFbpZ/8fwDQ0Q6hyYMIVJt5odwMMukdOnqXtrmgvXU5vifHYlK3pye4wrOQn5uKUPJc2VmY5DWTEvPw5U8BumWq0FB8quSdlC4LHlBKXjN0qvNC7zO2XJvQCtV20DmKZcesaIgMkXeeqxvfQN3e0ydwCzDE56LuIShg3lMAlWAKm4mOfU4JW2NVcNOVodoKviKsaSk355a+18jBg6Taat/uFYMNI/quRpNEDRP/V0czkdRvFxUr2kouV6J60daVwYqxOjM7Wq/9yICu2NiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4037.namprd15.prod.outlook.com (2603:10b6:5:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:14:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 14:14:06 +0000
Message-ID: <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
Date: Wed, 10 May 2023 07:13:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
Content-Language: en-US
To: Ze Gao <zegao2021@gmail.com>, Song Liu <song@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230510122045.2259-1-zegao@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230510122045.2259-1-zegao@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c846636-2b91-4a88-102a-08db5160d08e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rYCCzi7+feM00q5QFhYF/Cwng/665UXIJXUxulvXAQ4+OiJ+1pYvMiP8GHz9DxW/YBX7bN80uDWaUtlNSoniKcuOAIyziTJC9n3BLwj4SmQXkMXJFLjXF36Df79WBMZ+ZQWayqPuXZPhnmQFvREVY/a67zPpuwmD3KvorrXEszRC9AxGTj2LmU0EYAVRROehXCDoI1NSQ/xLqeuwh0trzSSzFlJIcD/ocwdIcTYKWMRi61SGnqAYJ6juLk22Dm8PWc+7Tyefa9wsPr7p36R8PyCtvh2XPnkqPb4sYB5wA9uvmhY5dPVhBqqqcwL4l2jSfdO4Skggu/8+20MyvrEF7wXVjf8JV5ffB6vcxQD+JFMYKNTkVdHsfAnxMzI88toyBpNb6D+45UwtMsDz0GzDYwNgP/qjGGEinJt1VOTHuSIjrbM5X/4ZzitA/SsunZfvxmW7L+tarhyqstMZflOuLY3WT88LLnW1RJjjZuGsrj0Tln0xNGavX+V2HiPh2a/+7Ai3rcnFuNQzVtJxC8nB+BCWIF8aaWeUeZeLcYOEiZJzRy2QYcdyZhWrG7SZUXL7MYXfZNsku03H5ac8Mzm/EJTBdOkjRnxsMnXDPfGT/MeCIubZbm+nr0zj6zrMD6/O2X+tvQnwDkKqt9+DZg2BEZeYIqeE03lclzPFhCnAxJ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(83380400001)(110136005)(31686004)(66946007)(66556008)(2616005)(66476007)(4326008)(31696002)(5660300002)(7416002)(86362001)(478600001)(316002)(921005)(38100700002)(53546011)(6512007)(6506007)(8936002)(8676002)(6666004)(36756003)(6486002)(2906002)(41300700001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LytQYm96cjlkdlNHTTNFcW9QWVFrN0Zrd051Qmd6K1ZDR2UzbW9mWnJNT1NH?=
 =?utf-8?B?d2R0aW96cmwxamJhaVNJN1k1U0Q4L1g4anJvS05xMGxXazY2bW5BaXQxTkJx?=
 =?utf-8?B?STQ0a1ZDUllsYkN5N3M0UlE5YzVtZzBaT1dJQmhtOHV0a3o0QTl4SHBrUGxP?=
 =?utf-8?B?TnArS1pWYXlTVEpUcVdGMDNENkdvTnk3dS9UUzlQTWZZQVFQT255dHkvWlBH?=
 =?utf-8?B?S3NmYUR6eEg5anlFc3ZIanlMb0V4WnREKzhlQmlFVDR0cWJKcW5qcVoxNktJ?=
 =?utf-8?B?Mnd2RVlsVC9HR2UwZVFENEUxbFFnTGJ0NE95TWVoRE5PazQwNTc1RVI5bVZU?=
 =?utf-8?B?TkVybzJ5NHJoTHR0VmJ4aStITFU2cG9Hb3VqT01VaFk1QTVvWVdjTmZkZGpk?=
 =?utf-8?B?aFMxSkJzQTh2MlpZQTk2czZwY1M3T3hkRFpGK3lydG9ONjgxWXBXaXlpZzZ6?=
 =?utf-8?B?cXlTNjM4UzVUYUhnNmJrbms4Uld6YVZRS25KR0hXVmhWWERWZFpRZ1lMUTcr?=
 =?utf-8?B?VjdQOVVKT0Q0eVljSTNUVGFRdkE5MGtOMUhOMnZmYklvQm1JbGVhNVl3QzI0?=
 =?utf-8?B?YVQzcXlOL203cS80WDN3d25jSFB5RUFZQlRjU2pQOFJpaUI0ZkVMK2RrWnJE?=
 =?utf-8?B?QnZJdm5MRXk2V0tBaWY3d08zdHM0QndvM0tFWFk3K2hESTAwRkYycFQ0VVdH?=
 =?utf-8?B?QzZZZE4yZjRsOStmQXZwVnRCZThCSW5ldDlyNGk1K2owZlFCazJFNkloKzBS?=
 =?utf-8?B?Z1d6dFVhR2ZzMGdWQVVsMjYxK0NHUnBETWdkY2JhekxpREtmVmVSdHJJZmEy?=
 =?utf-8?B?VlEvaWNJU3AvaU1BU2lRdGkyVUdXYVp3NDZnajBaMzJMWTFIdWRHK2tGTXZE?=
 =?utf-8?B?NFdSYXRlUFREN1hQZXhIRENpbUpDeWVlSytBMndoRmwrMHBFWkJYZ0RPbUZt?=
 =?utf-8?B?dE9Eb1UrdnhYMyt3bUh1K2JQOFJHd3JqZGlzb1hqdlljdzFZMEhYbkU5ZFow?=
 =?utf-8?B?NjgwSEZ5ZmN3ZnNQQVdIaGZCMnhCSVNRTDBNS0UxeHNxdVRsVlRLcXFkQkNL?=
 =?utf-8?B?VDhuRGxZdjdEeEJJaGlEMHY4S1ZQWVNZSkJ1UlM0MFBQUHIwNGZ2cVFDSnpz?=
 =?utf-8?B?Q3VWa2xvN0lUbXZobGpNTXlKUGZmQkZLMlhMcnJZT3FlWUd4dmFqTzgwK3Fy?=
 =?utf-8?B?SmNWanhQZERPU2dQRDFaZi84ZVY1bG5QalVsdFVWYVZ6cUtTL3MveXNVdXhQ?=
 =?utf-8?B?eCtja0VQNFhFTFRrNFk1TE9vcXVlSEZ5ZmRGbGhWeFJxUHpYYW9RM3hoQmpk?=
 =?utf-8?B?WXV2clkvRC9jb3psaXJpT3BlRWE4RTJJa1JZdzV2eEIwU1Y4aHlrVkF6T2hw?=
 =?utf-8?B?K0VpOWlFeXVpaWI1TU5NY2krSFhYNWluUXNZSlNpVjA2dWtleE1CZ0lmZWZO?=
 =?utf-8?B?L3FvTXpoNHVsY3FRYVR5YjQvU2lYY0QzclNKVnhzNDI5eXdqUWN5UUV4THpr?=
 =?utf-8?B?ZVFrcXhYcHU1ZGNrTDhObCtadFNJMTRHbWZpaXIwL2Z4dWJXYW52eWx0L1hv?=
 =?utf-8?B?enkwayt1TFNXNitlQk8zNE5VbGFLQ2JJTlBhQnhnU28yM1pQdW9ETURKT0NX?=
 =?utf-8?B?N2JNTG9GdzNiSy9teUV1QTd4S2pOdXJ6MGhkSlU2cnpVNkZtWHBkZ0tFZldC?=
 =?utf-8?B?UlVkV1dxUXpwdndoQ28yamIzRWtoSDg1ams4bnhuK0tMMXl4ZUR1WjJ0NTZN?=
 =?utf-8?B?b0FqVmhXK3JjYnlFbjdMdldySVl5NDZOclFFMlMzRjVoZHJ0cWVGdm9EMDVt?=
 =?utf-8?B?UGlZbGVGbm5jbjl0dXltRWtZZUJWZkU3dFdpK1o4T3VVWnhGMk5GQkVFazZB?=
 =?utf-8?B?M3duQ2dJenU1TEFSTGcwWXBKaDFrUDBwbFNhL3gxZHd2SFBqb1JuM1RCa2l0?=
 =?utf-8?B?NEcrSHFWVWxtQnhjNHR1OGlLTjlnenQxMzJiRHc4MmxnbmFpMVZOdVkrRzZU?=
 =?utf-8?B?MzVWYldrSHk4ei9JY1lQTVplV0NHRFlYQkU0dVZvMGxOWDVRcCtENjRsNisy?=
 =?utf-8?B?cTY0d3kvNzlQVlVJeFF1Mmd4Z2FNQ1I1eFhtZTRtR29hWEJLcEkzSmZqNmJ1?=
 =?utf-8?B?aFFOZE81T2NTZVk2NGN3UjVlb0JrakpKeEJXMWtCZ0YvSlpxK2p5V1ZjcTRI?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c846636-2b91-4a88-102a-08db5160d08e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:14:06.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SktuXtG0+oMWjYlNhPP55lZuaAb71aTzRK3kN44tmBhw39mXixj6aRhfYVpyPcRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4037
X-Proofpoint-GUID: fW6rhwKH5F7sNOr2HjgzAm2Qi9HMkxd9
X-Proofpoint-ORIG-GUID: fW6rhwKH5F7sNOr2HjgzAm2Qi9HMkxd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/10/23 5:20 AM, Ze Gao wrote:
> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> however it does not takes those kprobe blacklisted into consideration,
> which likely introduce recursive traps and blows up stacks.
> 
> this patch adds simple check and remove those are in kprobe_blacklist
> from one fprobe during bpf_kprobe_multi_link_attach. And also
> check_kprobe_address_safe is open for more future checks.
> 
> note that ftrace provides recursion detection mechanism, but for kprobe
> only, we can directly reject those cases early without turning to ftrace.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>   kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9a050e36dc6c..44c68bc06bbd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>   	return arr.mods_cnt;
>   }
>   
> +static inline int check_kprobe_address_safe(unsigned long addr)
> +{
> +	if (within_kprobe_blacklist(addr))
> +		return -EINVAL;
> +	else
> +		return 0;
> +}
> +
> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> +{
> +	int i, cnt;
> +	char symname[KSYM_NAME_LEN];
> +
> +	for (i = 0; i < num; ++i) {
> +		if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> +			lookup_symbol_name(addrs[i], symname);
> +			pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);

So user request cannot be fulfilled and a warning is issued and some
of user requests are discarded and the rest is proceeded. Does not
sound a good idea.

Maybe we should do filtering in user space, e.g., in libbpf, check
/sys/kernel/debug/kprobes/blacklist and return error
earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
requesting kprobe in the kernel.

> +			/* mark blacklisted symbol for remove */
> +			addrs[i] = 0;
> +		}
> +	}
> +
> +	/* remove blacklisted symbol from addrs */
> +	for (i = 0, cnt = 0; i < num; ++i) {
> +		if (addrs[i])
> +			addrs[cnt++]  = addrs[i];
> +	}
> +
> +	return cnt;
> +}
> +
>   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   {
>   	struct bpf_kprobe_multi_link *link = NULL;
> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>   	else
>   		link->fp.entry_handler = kprobe_multi_link_handler;
>   
> +	cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
> +	if (!cnt) {
> +		err = -EINVAL;
> +		goto error;
> +	}
> +
>   	link->addrs = addrs;
>   	link->cookies = cookies;
>   	link->cnt = cnt;

