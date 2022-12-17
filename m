Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E764F648
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQA3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 19:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLQA3D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 19:29:03 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F6140B9
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 16:29:01 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGNKkMJ006743;
        Fri, 16 Dec 2022 16:28:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UyasfO7oLCSabGMRWul4aKGv+XSU0ElDgENFRffEVh8=;
 b=KBjVxARbp4tVKKb15aN1RhO4mFBERmEYYY0ilknzmtDsLcdcz7D2PQQc5Pd9BjXH2Y7E
 AJXuQfrsPRS5r6uju0tmxvDAeOfmiIxphAvyzMLh03uPpZs5MQ+1Xd9wrVHsCPWMXAKC
 N5E9BdVeB47Qrdffu0MTYK3ZCI6Tm308zb9fI/cDro9Mo1qPY1k1o8XOmRxeu2ZA46e1
 +iIQn9hQ82KGAK2r9/iWkJrMSVc4Ue8nQ++qxc3I27Xz3WXe/lAVhQ+E3NnbTkz/3NDn
 4ybeMDOrvIC2Cpybwg4TEJjMldFZfVGMRThi6O84G8b5sb+rbDqg1jyNfVkytoGr3lPg aA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgm45wcvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 16:28:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm01G7tErz2DacMOm2vcgGRw069iwa8dITYeS+HE7AweWtYltEshCF1Wh/P9sgYlmlYgwyagRdYTXmo4v6ljrhI70fwb/VLCPs8RlxqJZYSwjElu3dzGFrhmKgjGKNSnHNtEmCde9FLqO5Rw+baGCu4EJcd8KNDSCAZsmVRUAN6CFSJZ/vRNWhCCS7xkp3RLULk3+MoSRajzYbMGYV54GwwtfoSz+KFFcAua/so5eMOiqoaC4fF9xQBI4yMXhcKk+W4K4pdv7jUlErPnYbYq2GrocKpwEzJzk7gPJdNPTSAKnnDI4lnhQDtHSEXDgvaZv1Hl60F87RD5/Uqy7wxLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyasfO7oLCSabGMRWul4aKGv+XSU0ElDgENFRffEVh8=;
 b=PxvlWuzactU6zdTCBxHXLPbKyLSXxqsg+cWj+JZmRkqrlNa+SNn2Vp+EfJXHJ0h5Fj4d2cdjxv0gTET0MlMfW5lBJHWvCRo+C6E/KnrEPImMBkSDGqp1rAo5IMUKF/WZs49lWkNB3vttS/IxaselCVAlGW4FUpNxwJxlF3EtHg4CY7fBeC4zs5E3cm1lMCCJEHulomJiq7XRtHym5yivhEUe5rvVnKFswqT5817VyEknkxWj+IpPuC/rq818+qFr/EdqXzRKraZhYdF3jgTAJ7eO4ECWh+QAZ9nCu8hfFXhSFWC4ubQzJRcAz4QF+D7n+ayd51uZonXDB1lK4Iihmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5720.namprd15.prod.outlook.com (2603:10b6:a03:4ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Sat, 17 Dec
 2022 00:28:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 00:28:42 +0000
Message-ID: <76031eb7-9b68-1d53-e50d-6d328a54542d@meta.com>
Date:   Fri, 16 Dec 2022 16:28:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCHv3 bpf-next 3/3] bpf: Remove trace_printk_lock
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
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>
References: <20221215214430.1336195-1-jolsa@kernel.org>
 <20221215214430.1336195-4-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221215214430.1336195-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: a2334265-fc7f-4294-9159-08dadfc5a651
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iPjr2gGlyHDVRAWpD3kNUphdoKigQi/JHGY8rirx06/XPH5aoTi6OvFr1JFePvWRP16viYMm0xaPuQ3QAFdLD5GtdorRANe/HeO4G4yspLWLzss5J+oM5prxVDe2BwEWcgXQYWgsbvLeYZTg8ehvB8gXAWaPTx9Mn08czWzxHzm4NX1xe15NWzaFZSzmb27gkBoZpdYTZcP6Xly6aEC92RU6oLMjzmo32lNvLfDrLTd3Q2/hCf5zx6/1ccmzxQpNstAjOnSN02slU6ByNnvfu59q+2zx391EBE/zuGsP4E871b1DAAK5B0MSXAqc+JnD2Zs631la5QB1Bk9uWvnvPPn/rJPKcZlBrSgdpKt5Nh9dHFEUpAcft+WOlzeWiwYZP6GhLpCt+q/CjLgYUS3u44I5kZbsCJIncghoPO3CZq82YAji2i1lB5jgfRxexkHX4IumB7UYzb0cr/zLfG5UmWzRx4QChPIwIgxhNndJ8h4Y6Kv6wLc9aB4Ts7xqEYbK43/sW+1JEIpdoXyNjwj+DmCuvt1hboQtF1P6QhRyFPIMyWQNlcp52+Fh2owR4L/ex7wlzj/NtHHm4iYCxTDDZEzLaCS0MlmKtEAm/w5NqvBsw3QGXEGm3qE6iqkkiHx+1FuW2eQtuL202t4fug53iQVuNZt5O0vUN5d71+sjXZ5N4jD7I/eRclopEOsaBD4T8YngoodkUNp9c2uELjQlRj+JRqBzKxCr47j53WGj7uNBQnkKm4grDtA8xvwrufWZAozuMH7RMue//hxRIjxr2y0Cy2elwBHQXgHiqShQGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(2616005)(31696002)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(66556008)(41300700001)(6666004)(6486002)(6512007)(4326008)(966005)(66946007)(478600001)(66476007)(8676002)(53546011)(6506007)(38100700002)(110136005)(186003)(54906003)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXR1QzgxUWJjQVc2MXJxWWdrMS90R2x5M2lWVWtrTThFUzB2anBJM2RZaHlL?=
 =?utf-8?B?T3lNc0ZML3pDT1pydGNDSmo2eVdSdTc4ZXN1ODJCdEs1UGY2akQ5d2RhOVhP?=
 =?utf-8?B?QTZIRDNLdlVkT0dzaFdhRlg0WE8vNUNZaVhYSmVGbHJuT1dqSU84d0JnbmZl?=
 =?utf-8?B?MmI3RDVlQmM0cGFCUzZQaEJzRHRUQjJqTEJRZEtoYjR1dFhic1NBUnhyRVBp?=
 =?utf-8?B?UXNVV2w4OUx3Z21YK3hRMUlENXBkTFdwaHVIR2U4eXFnZXNEWTRLSU96bVdV?=
 =?utf-8?B?UG4zaDBBS082bXlzQ1RvSjdHNGRCN3Q2TW0vUm4vdk1wWThyMmM0WCtUSVFv?=
 =?utf-8?B?Q25mZGRNUUluaTNWU3JRRGxhZDRhbWJ1NHBCMnM5NTM4cWFSMnhVNnEwRFBs?=
 =?utf-8?B?N0o5SlJ2cGlkR2ZTbTN0eWl5U0J5cDVOWjdkS1VOQmcxdHM1Y2tKeUpjaUYx?=
 =?utf-8?B?UHhqVnFvcXRtbkJ3QXhLbnJ0YVJ2amkzaVdEc2pIbnNMN3pKQ2NJNDBBcHlu?=
 =?utf-8?B?MmxUQ0tYRlMrbDBPWURPNFhySEJLd2tmdWd6STczaERMdlpLZEUvUkkzMGVU?=
 =?utf-8?B?YlZraGYreGVrSHg5OFh0VGJ6dG1mWVprU0l1RTFDQjNFeDl0OFdhM0E5MVlt?=
 =?utf-8?B?NU5EMU5jTy9CcVpleVB3Lyt4WGgwVDIzZEdYM2tEQlVIekRZZW9ZbnIwcS9X?=
 =?utf-8?B?RFZEcTNMZDcyck5ibDJDbFZXK0s2SHMrRmpVVVVTLytoUlJZaXFLTTQ1UGtJ?=
 =?utf-8?B?QnVVa05Jc3VscS9ZVWJXTFh6dnV3S3NRdXJiZUVnQk93UjNzeDZXanZLOU1Y?=
 =?utf-8?B?KysxckJvdkUyRC9yVUsyaFhDSDZKQ0VrWUQ2U1JrMUZNNHFWRVptSTFaVmd3?=
 =?utf-8?B?S3BNWG5GcnVXRHY0Q3JIRVJRUGZaOFhjYUJhaHp2Z0gvNGRrNG5UUjB5a2xv?=
 =?utf-8?B?aHpodEVlTExlZTViVnV4dFVCYXJjV2FVVGhzdER5TkJEb09TdmQxK2hjaVRL?=
 =?utf-8?B?ekU0RGwvd3VXU0FIVFFBOEhTU0FxQzh3S2xWU0VDbWlqbGRaL3RkR05FYVhB?=
 =?utf-8?B?Ums3MmxtSy9xV0RFbUVKRXIraTZYVlprM1NXOWFHcUpvYk53YnJPODV2eG5X?=
 =?utf-8?B?a1dQUlpCOUh0YlNHVFlHQklud2s4U1RXcE5DZmRHdXdPVE9nWUpHNWN2cWxD?=
 =?utf-8?B?YnhMb28vdE1BNGcra2w3VGx6aDg5c05tZ2pqcXNvRkRGcnA5UU1Ya3EyazEv?=
 =?utf-8?B?NkNxbzlHUDZXRS8xK3RrY0dWNGFzWVhEY0ZrSkd4UUgvTzBONEpRYzZiaTc2?=
 =?utf-8?B?NVBkamZxS0RzSEh5Wk41OS85ekIrc21DcURtMGF0di85WFFPdjRaVnlCdE5j?=
 =?utf-8?B?YWRBbFBRRVoyTlJ4LzZNejYzZ29ZYkRIZFJvckpNc0twaHBuNElnTXVjckc2?=
 =?utf-8?B?VkRscE9BOEMydUg4ZnNQeHl6YzVuMm9MaWp4MHVXaS9HTmlvelpmNkh3bVNH?=
 =?utf-8?B?RGI5NnU3Vk1GaVJEMnFjQlpYeVRDbnl0dnhyelhWY0pPOTFJQ3hBbDIrbVJ2?=
 =?utf-8?B?dUFnMXJHS21VVDU3clFzdzR3VWVGRThVL3p1ZGhCcEJocStCaEtFRzJZekRD?=
 =?utf-8?B?K0MzVDBiOU5pVmQzQVRmQkdpT212dFk4RnduOGMvWXIzb2Y0aE9NZEJaMUh2?=
 =?utf-8?B?TVJ6bHJ2Ty9GYVYydHRIOUZSREMrK1lHOHErT3crejFpYXRaVmc3Skt2MUtU?=
 =?utf-8?B?blZYUFFBVWwxMFVzR0t3QVBWTUhhV1FTaTBNZnFEcDZGS3RUbDBLM0tsL2c2?=
 =?utf-8?B?Q1FMN2FObVE4akFmRytDbFJwYnpTL0RVQjRzWEZTcDM0M1dLc1BnS3pITUJT?=
 =?utf-8?B?S29HRVNTZENycnJkeHg5YnBlYWRsQittRzBRenVEZGIrQ1IvUnU0Y24vVE40?=
 =?utf-8?B?Vkp1M2RnVXFnWmlpYUZvU0w0QlhoQmdnUGdMVzN3VHd1emVPOVFmTVhtWkQ2?=
 =?utf-8?B?RUM2YmlzdW5SOCtyNm5RNWlKYkwwL0ZlYlk0eE5USWpCZHJnQWVNZEVxL3JH?=
 =?utf-8?B?bnUybEh1SWdRSzBXVzhQNEI5V2xVQllxTXhNUng2dzdwdlRTT2hjT1VXZ3gw?=
 =?utf-8?B?ckN2bTViN0V4RXpCNFFqNEtWcnVzQzZWOUdTNmVFNzg5cytXbTQyaUk0ZVlp?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2334265-fc7f-4294-9159-08dadfc5a651
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 00:28:41.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsnYIrT3KBvVTq3azhdM4h+80/f/Cg59iUrVKR5C7HmRbU8ISK+tECzLLYUiswLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5720
X-Proofpoint-ORIG-GUID: iDeBbBetEaMrAWE-ZfAR-sgj0jk5sWo5
X-Proofpoint-GUID: iDeBbBetEaMrAWE-ZfAR-sgj0jk5sWo5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 1:44 PM, Jiri Olsa wrote:
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
> Adding new return 'buf' argument to struct bpf_bprintf_data and making
> bpf_bprintf_prepare to return also the buffer for printk helpers.
> 
> [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Ack with a small nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   include/linux/bpf.h      |  3 +++
>   kernel/bpf/helpers.c     | 31 +++++++++++++++++++------------
>   kernel/trace/bpf_trace.c | 20 ++++++--------------
>   3 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 656879385fbf..5fec2d1be6d7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2795,10 +2795,13 @@ struct btf_id_set;
>   bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
>   
>   #define MAX_BPRINTF_VARARGS		12
> +#define MAX_BPRINTF_BUF			1024
>   
>   struct bpf_bprintf_data {
>   	u32 *bin_args;
> +	char *buf;
>   	bool get_bin_args;
> +	bool get_buf;
>   };
>   
>   int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9cca02e13f2e..23aa8cf8fd1a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -756,19 +756,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>   /* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
>    * arguments representation.
>    */
> -#define MAX_BPRINTF_BUF_LEN	512
> +#define MAX_BPRINTF_BIN_ARGS	512
>   
>   /* Support executing three nested bprintf helper calls on a given CPU */
>   #define MAX_BPRINTF_NEST_LEVEL	3
>   struct bpf_bprintf_buffers {
> -	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
> +	char bin_args[MAX_BPRINTF_BIN_ARGS];
> +	char buf[MAX_BPRINTF_BUF];
>   };
> -static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
> +
> +static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>   static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>   
> -static int try_get_fmt_tmp_buf(char **tmp_buf)
> +static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
>   {
> -	struct bpf_bprintf_buffers *bufs;
>   	int nest_level;
>   
>   	preempt_disable();
> @@ -778,15 +779,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
>   		preempt_enable();
>   		return -EBUSY;
>   	}
> -	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
> -	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
> +	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>   
>   	return 0;
>   }
>   
>   void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
>   {
> -	if (!data->bin_args)
> +	if (!data->bin_args && !data->buf)
>   		return;
>   	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
>   		return;
> @@ -811,7 +811,9 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
>   int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>   			u32 num_args, struct bpf_bprintf_data *data)
>   {
> +	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;

We might waste some memory if num_args is 0 here. This is unlikely case
and it is not worthwhile to optimize for that, so current
implementation sounds good to me.

>   	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
> +	struct bpf_bprintf_buffers *buffers = NULL;
>   	size_t sizeof_cur_arg, sizeof_cur_ip;
>   	int err, i, num_spec = 0;
>   	u64 cur_arg;
[...]
