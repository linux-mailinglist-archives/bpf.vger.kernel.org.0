Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900DB66317D
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 21:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjAIUaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 15:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjAIUaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 15:30:24 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4E43D92;
        Mon,  9 Jan 2023 12:30:22 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309KSVJd009782;
        Mon, 9 Jan 2023 12:29:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=rBG/0NP8AemXbZObd3SbE/YW+0AypGvCSlHxSj0azG0=;
 b=HppH6rgbQTZw1T4CGYjgkAJu8e4e9mmtu1MAxy79XDr1aaHLJ9OHzysf1D6SnTjM3CuC
 n/IF/Qr4y58cZIXKrBZei5P61I2eiKeUyPVPJFp79XBBgsyQ/Hbu/APP2tvAsD0ECD4a
 1hiYB0zjzPLjNMSo//oVbx+5vYgXyX2wjzzjdDusaNzWVz6gQZi6fZykbKv0NrOKXrXU
 oldGiCeHT/g883NRUTqpPd7OLa1TfB/TRfn+TMhG45HjifFZgzFZAGqyNBONVjD9FS/F
 ByADtdY8FrROwhEm8oCLkm8UKihMy9VjlbuQm1i+IcokDd2wV7qUxFLUsaWl373LSwFS zg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n0next9q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 12:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szn4cVRXU9yw9Y4Fs+xfy3X9B4p968iNGpuRHUV+Kwdr2ow4fS0ud4M2N6hgGDNjSgzoMF8CDsJbS9+K8ZAGBurJ8989Zgu5/HnoEmEdOZwS5rcgTdr/kYXGpeGI8NS62qssXCPZp/oF1+bamWlY9vaqfm9L3EWTEhT1rjF+uEqocz14JRbi3IamCt0lfV1qQbE9WQXrtEmRCPsDbIbcYtLi0MCdlfvijueMAgrivYum9vlQAWJntSuCsrLaCY4A4gOuMvZV7FCES1nv6Tqs2KZJgKkMMkceXpDIRl/X4sxmrEkLn3grQUlRxonwJx1F4vAePOy/ibIe5ZntTRsNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBG/0NP8AemXbZObd3SbE/YW+0AypGvCSlHxSj0azG0=;
 b=cpzO4k9hida39AyzlRg29LKRcAF9tgGshc5wqsA9vyd+E/oxh4h/a0A2Asjm0YvzdbyQ5r3epYNF1VZeOMPBUK2iY08T4bzNRb2tBstlG8/7yhYEtFSd1k77KcW1ESY/8E6jVDdfirUB/aVDFgHCbflVu8V2VDY65Zqyzo/36v4h3WAJOpuJatSWIB50s+UrWBSCUyHhYwqSt3W7HsjXhTjXaOtBjeAYvCsHGQmqy1hj8Escsd6Dh3k7mXmiE4bzdK/6xQz9SepuiugS/39QNY2EO0mwnoR7/SuJsITOXguYWn9H4NT4bUZj0EWgeGpKla3+PhetWnAsyzFgRxbXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5747.namprd15.prod.outlook.com (2603:10b6:8:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:29:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 20:29:15 +0000
Message-ID: <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
Date:   Mon, 9 Jan 2023 12:29:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for
 kprobe
Content-Language: en-US
To:     menglong8.dong@gmail.com, daniel@iogearbox.net
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230109094247.1464856-1-imagedong@tencent.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230109094247.1464856-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4575a714-a017-45d3-3353-08daf2802cf7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw19c8eCI6wlpIaQ9/sRer9CZZp3XyMw7PkhsCpznc+tpqOFalysDs3FokNpjmsjvkASVPtOpWuyc1uCWkSagm7nbjdVUaj7M7Ng4yJddbckKtFi5D/jtKpGcTvP2kcKgq8Bq8QOBIccRRnpB3nH+c0rPy+eUQOuZ6OgX3PY5M8NQrVBiyUQfO58rdrBSqAAjsWIuS8olvEtTHTDCdsxkMH/QS97IPE3r65X/QArg4PwakYrD6PangX6eHkgnIwl9WpZ2gbrR9Qy2l7CziRa64OoBlq87A5E1N3YEUcw4RHsMDqptJLIU5vbTw8ZS6TJEbm/CsJ5L0PebxBESJqfRkVIi5WI9VgXOcku7zSRIqft8BbgHKXzle7YRY+7QPRpSjx9Rv6Y1R8JxD5u+TyNs3KoQj9MCmcaDuEYsWHxTndxWAkW4vFyvKfk1bp/OJnVMoqLjrnyiZVf0U8pbEFdlE44vBkMzmOkqvOKZOBNOaEdtl2wKGp3GZKMi/pxQlqEcKtPSMIAGhjIob60YXUcDR+PWFsnZ0Nvz7IPk2K0f/31jwv2t2Pcwwj93hAfZW33EueGGXXh4c5t7kcgxNw5PLGxKti4PEGF/qn+rQTTvmOEmZpqcmTLFjN8FsSlDKINJu6O+wzfZcpx8v4q5kIeApdDpTZ0GoWM9QscYIg0rOolAZz8Xtwd9ypc02Hzw09HZmC+orUpvVj72+EcGRp/3SMZGZX2stTO87OP/tbAsB2Z0B6o5LEECZsxWX/onZb3bVqcuPxMB/AgfU7IkT8DJiDNpfSZmcwsUJoScZy/iN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(478600001)(6506007)(53546011)(6486002)(6666004)(2616005)(4326008)(186003)(66476007)(66556008)(6512007)(8676002)(316002)(83380400001)(86362001)(38100700002)(31696002)(41300700001)(66946007)(31686004)(7416002)(36756003)(5660300002)(2906002)(8936002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJMNldpcmxObEFCdTBtQmxJL2RJdHE0a1VyNFFkQXdwZ2s1RFBYK2VraDhw?=
 =?utf-8?B?aXFhY1ozMDJJK212WnBpU2oyS1JxRVNKZFdxbnBoeUZCRzAybUROYmk5ZEhG?=
 =?utf-8?B?Y2ZpT2p2UDVZVmdPbTkvN1RZd0Q1TDkzclFUZFRKMU1MZE0rZUtmdUVIUmJt?=
 =?utf-8?B?Z3BzdFprcmN3bzhHcjNiSDU5bE1VVHpILzZaMVVHZkhhbHlEUEZ6aHowWG5Z?=
 =?utf-8?B?Zy9YUjQ1bEY3RnNIeHhOSzI3M1JjT3l4SzFtZEp4UWJCNHIyalBKNXdqdzRS?=
 =?utf-8?B?UVhneVBGTDVhZ1F4R2FBdktqNnhJUDBLVlUyUk5XOUVkNE45QitkRkpFUUh1?=
 =?utf-8?B?eUY5c3FGbXREZm5FbENtc2ZlbEs1Q1ZxbUJxWVNyUVFUVzRPMFQxWVpiTHRU?=
 =?utf-8?B?bEtoQ3c2ZTdCZzVkMUoyZ25oNjQyY2taQ2tLMlZUbVFpVUFMWEZrUDdUVGdv?=
 =?utf-8?B?Z24wSk5YbUM2RndHNEE2ZTFMOGxqakpzSFYrUUptLzFxREJteHFTaWV6QzdR?=
 =?utf-8?B?MXJEc0VUendMbGJ4M2hjMWxzM3pyOHFkTDhIb1ZWdUNFaHZtdHpDVFpQcmxa?=
 =?utf-8?B?Wkh2aU1uak9DbXBRT2czMWkzZUtOMVYwdGxYcjFYUEpQbXFwdFFNb1p5U1J0?=
 =?utf-8?B?ZFhYK1pqK05FRVQ5YWlvNFBubHF1RGRNbTlGZ3dQbWQrdTBlVEdzRGxLTjBj?=
 =?utf-8?B?cDRBemtrenhLMm82N2EzUngzeE1FREwwbklhQVo1L2FYSElXVGVIRkZuZjhH?=
 =?utf-8?B?UTFYYjdKdUVYc3Y2QkVKUXBkM1NvN0tEaFJjejV5Z05VYVZjQXRhM2dsZzZN?=
 =?utf-8?B?eUk3cTJ3QnYrTkxMcDFqeXBWQ1kvRnNNbW10WUNBMUVoNm1nUzFFd3JHcjI0?=
 =?utf-8?B?Q09hRmYxR0wzVHNhRVNJeVpWeVlldHhGdm9QQ3hGWHV3YUh6ZU02T2Iyalcx?=
 =?utf-8?B?Ym8xRmhqakRQNXFZYisxVUNVTE5sTnVSYjlNbGpTT0diK1BSRFdobWg3emNH?=
 =?utf-8?B?eTBJVzM2ZVNzOW4rL25aSThQWlc3UzJjdmg3YVhzaUdPaTg1OXA5RE5iRVp5?=
 =?utf-8?B?eVpxY3RMQlIvNnJhUUVaMkVvNDg1ZU5iT091dm9mYXA4aDRCQjVPQ2JKdk5V?=
 =?utf-8?B?eUlRWDNVUUFlcFEwQXFaRXErTkJkYkhVSGpqMUFGQ0JpSjJEUW5FcVp4RjB2?=
 =?utf-8?B?eEZFWUJSU2EzVmhzY0cvdXZTQ3Qrc0o2bUd3NnkvSXhJV0Z0anU2bkE2MUov?=
 =?utf-8?B?YUFSem9XbFhPN3AzSERGRGR6N2l6aU5RVWpINjBtVnVXMEU1VzZQSStCSHFX?=
 =?utf-8?B?Z0FDRE9YMEowWFgxbklkUXJWaEV4QmtMMGU3ODNacjlRUUZYeVE0OWR1K1Z2?=
 =?utf-8?B?RFJUd2ZQL1BkOW1tdVRqc0VMMDMxSHFRNzhLclBTT3doN1A3YXlxajBoZlRx?=
 =?utf-8?B?NGt1NzFTR1pZVENyak04Sld3M09ONjk4cGZ4OENmd3NKZGZBMHBwRnZadUdk?=
 =?utf-8?B?YlArbGpNcURTK0htYTRJNkE5dk5reHRzeHI1dm9RakFrRHJMZi80V3NWTk42?=
 =?utf-8?B?aGtpYnVUK3NZYlp6TXBRSW5PcW9BUnZJa1g0bVdmOFVUUmdnQnFIS2Q0QStF?=
 =?utf-8?B?RGlzVFM1aHdFU2VBT0Z3U2NBYVYxbnkrT0R5c3c5Q2JwV0dsenR6T3M4TFFY?=
 =?utf-8?B?SW9IWTNtN1R3dkxHTGw2MGpWcjlVUlhJMWtVMlAwTDBPRVlyaDl6dUFPK0RG?=
 =?utf-8?B?Kys5TURiUWNPOWJTN2h2MWZXSFFPRlhmekxadWMvVTIrUW9mdjhXMzJuSVAr?=
 =?utf-8?B?R3R0clJIL250VTBvUUxzOVNLV3pESFdCeEd5TUp3eUVBbG9TQVV6RTBTU0JF?=
 =?utf-8?B?cjR4c0dGQ1dlYUZNVnlvWUJJYWtpYk54Sk5teElacVZpc0V3TnVsUjQvUUcw?=
 =?utf-8?B?aXBQcHdDeHNQQm41ZWhkbTVpVlQ5a044YzRIZXdvWlZqSjAzWjhJVTc5aHB2?=
 =?utf-8?B?TFRHWXNSa1hjU0xvbUF5K2U4UCtEdnlHdjRpNjdpQ0VtZU1lTU5LenNCeHZI?=
 =?utf-8?B?YUJBK0ZGVStDYmlFQ20rT292azZPbkErRW14VWMwZ1FYS1kyV1hjMlBkbkxz?=
 =?utf-8?B?YUVEdUluc1d6ZzNFc2VjNjFUc1Vjd0htRUJMY0I1Ylh3T0RHWGltRXQ3M1hB?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4575a714-a017-45d3-3353-08daf2802cf7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:29:15.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2vKRyAmYRUZaP7Ir2IVCwT9iW6VWjpMZhT4cMsWJIERUN7cX2yO5zjzBB5yttyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5747
X-Proofpoint-GUID: KdrouCw4TwuX8JOJeuyrq_2Ps4C2oOb_
X-Proofpoint-ORIG-GUID: KdrouCw4TwuX8JOJeuyrq_2Ps4C2oOb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> The function name in kernel may be changed by the compiler. For example,
> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
> 
> This kind optimization can happen in any kernel function. Therefor, we
> should conside this case.
> 
> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
> kallsyms and check if there is a similar function end with '.xxx', and
> retry.

This might produce incorrect result, so this approach won't work
for all .isra.0 cases. When a function name is changed from
<func> to <func>.isra.<num>, it is possible that compiler may have
make some changes to the arguments, e.g., removing one argument,
chaning a semantics of argument, etc. if bpf program still
uses the original function signature, the bpf program may
produce unexpected result.

> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a5c67a3c93c5..fdfb1ca34ced 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>   	return libbpf_err_ptr(err);
>   }
>   
> +struct kprobe_resolve {
> +	char pattern[128];
> +	char name[128];
> +};
> +
> +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> +			      const char *sym_name, void *ctx)
> +{
> +	struct kprobe_resolve *res = ctx;
> +
> +	if (!glob_match(sym_name, res->pattern))
> +		return 0;
> +	strcpy(res->name, sym_name);
> +	return 1;
> +}
> +
>   static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>   {
>   	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> +	struct kprobe_resolve res = {};
>   	unsigned long offset = 0;
>   	const char *func_name;
>   	char *func;
> +	int err;
>   	int n;
>   
>   	*link = NULL;
> @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>   
>   	opts.offset = offset;
>   	*link = bpf_program__attach_kprobe_opts(prog, func, &opts);
> +	err = libbpf_get_error(*link);
> +
> +	if (!err || err != -ENOENT)
> +		goto out;
> +
> +	sprintf(res.pattern, "%s.*", func);
> +	if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
> +		goto out;
> +
> +	pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
> +		prog->name, opts.retprobe ? "kretprobe" : "kprobe",
> +		res.name, offset);
> +
> +	*link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
> +	err = libbpf_get_error(*link);
> +
> +out:
>   	free(func);
> -	return libbpf_get_error(*link);
> +	return err;
>   }
>   
>   static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
