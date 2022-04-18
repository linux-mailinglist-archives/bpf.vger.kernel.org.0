Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE7A505EC4
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 21:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbiDRT4e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347788AbiDRT4d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 15:56:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930E2CC83
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 12:53:53 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23IGiBVp022420;
        Mon, 18 Apr 2022 12:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=N5IjHB7+2Jvq3pEUVC1oC63A3cE4FvK6pKrbqbr/gi0=;
 b=BOxkQA40bNc3yyvzezT1D65WAt/qv3c5CFKP4qo9nsB3kQAOceiwEwOXyIYHSrXbBS3X
 ZdUvX3Ng9nwbL1oVSGzMyKC0Y3ZBmnlO1iu3I+7OUlJXiAHf3sRD30YnHSs7hZCKbbzw
 nW90vv+0ZTpTiL1P/roBx1hyNakJ8Po69Zs= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ffsfw2yue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 12:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvgJ72oGfaBib2QQvvPgnmqd28Bz+7GoLZ+o0M9Hk8q8UdvS5ChSq4SSI8I1F2z8ZJLaBRlc3M2ZwrkGI/CHAvDXgjdbBi68rafDpah5kUBUPUXCpisdMq03KoWWLSx3RknhZYS8/ACRvuQRNvhCwPJpNFe6zFG6CYvICEulHlWIA4iLpRmLTSpdLXlTOL+qowCHSzZJMFChPLfKUKLqBvmTuAYwaF1C4YgVjw7hi5oXCPGwa7utnLsIR6Qrv29HE31xYDag20DXmsiZiip5PCzId0Tz/97OKR0splXPmXY9tdQRRwr/1XFofum9IN/ONUjpmrkiyfnt3hVhjZ14SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5IjHB7+2Jvq3pEUVC1oC63A3cE4FvK6pKrbqbr/gi0=;
 b=IEBlxrNY/lfkStK4emEOd8dV0LCNOrb+bX9us1ylKokImWlgOLti8XQXJvJ/YuW20qmsx5FHn0o2igXAp26VxkU5JvjVgWlhYctwGGFYigmUJRa+1xhcdLvZmDg5etpYCX8S5S2xgjae6ADSJ5aBG+2Icd3nClKDUobXtt4251kSEMJaV7G+wYehKsopz8HpfUQjn1lRMLlbqM3TmSYzHwQwEpHBAdgTD4M4huaEPPWy65kSCis3maH4w2+ZZsK19nVtyQLjkCGvRXFd4drL2h45+tw5DiC7PE2dDuaSeDBTvW5Sbftea0BTFHs4lYg7RVG3z/Z0XVBROZf4blib2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3670.namprd15.prod.outlook.com (2603:10b6:610:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 19:53:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 19:53:35 +0000
Message-ID: <47fe6f32-fe4d-2e1d-6297-36c30d8c6586@fb.com>
Date:   Mon, 18 Apr 2022 12:53:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Ensure type tags precede modifiers
 in BTF
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220406004121.282699-1-memxor@gmail.com>
 <20220406004121.282699-2-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220406004121.282699-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c995e57-f03b-42a1-8b39-08da21751ff8
X-MS-TrafficTypeDiagnostic: CH2PR15MB3670:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB36709567781B006A04D1FAC9D3F39@CH2PR15MB3670.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOK5ITyYhqWza1vrBWZFxD9elNvKT8uXKjTTc7Se/WyhnXK4jSspDXxHuq5V/Bjx7qIn8GDKKLzwoFLH+RExHimME95GnNpYweHcnCgLrYTewDMf/t/h/Tnq8FQtO6J0XOXB2EbyCsW6asa6D+SzAOdIHlQ53nG9tX3Mr7moVC/6cNmuvdKVNCNts8Wzy1SEJRrNmoaKvSp8V5bQajGJ7gCLEVJixUWY9PpcH0FPOceTKS3vplus+7ctH+zh/Q5zMiVQ5mhmt5PieGFaucSVZPM0FAhl4TlxjlZC4LmiPaeDm2MXlhXVfInrTN33yh0B9xGBKe73qCgU+SuRBr15IQ9MYjmVz/h8UDedJrzaN/oldbWf7Lna+GgjPFKsvh2/8QV7X04b1p3IlgDaigZN9aY/rSIAprc2e/ANDZ+753iHF7dRkuE+lGGUMiGBJ77pZfnru8C7WO8GQdSAcVBdA+CPZCOtA9kcDC9f2mpJAiL+hnUNQHbQYJp3Ae49J7rK+Jlbl5xoyWmslPxDyi6/YM23cHyJdgqchtTmGjxHyJ7GsUWFPhCx3MbSGx2D1pc4GMSZ35AlJpVjFIzS/LPTNI7kPd36WV47lpgMelgQ+/ufqCS1jkn9xc3JSuVlaJtHkFscFv3oH7k97xgUc3ZV2Shox6Jaj4/q3/3ma/Tr6+Y4nu7mN2UG6/QONcMJu9eQBn/oaagnE+HqfbiklCBCpw4eza1MYPsE+JfhsGf+e/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(8676002)(83380400001)(6506007)(54906003)(31686004)(2906002)(508600001)(316002)(6512007)(31696002)(6486002)(86362001)(66556008)(66946007)(66476007)(53546011)(4326008)(186003)(36756003)(2616005)(5660300002)(6666004)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdUNEZVV2FTNzZ6QUxiL1Z5MVJmRUY1Y093S3MwVGxUeW13TDc2L1hlOGZp?=
 =?utf-8?B?aW5JZ00wb25hK2V4UFhnM0MweGdPUC9oelJDVTRtNWlNM0J5YlpWODdQSDJa?=
 =?utf-8?B?L3E5OHZ1UWVxendNMStiR3g5MHFFc1RZYkQ2RVl3bTVkdUZHZnVoaXJDMWM4?=
 =?utf-8?B?VGN1VW1ZZHpRWC80d05zNDZZWEpHclg0bThiT3JmWHpNZ3plMzNIeXZiR0hJ?=
 =?utf-8?B?UDc0L0NqL1RaYit6dVRNN3ZTdXBNeUZuTUUzbnJyazA2T2tJQWV2SjFYbEls?=
 =?utf-8?B?YitGRVYvZG4vU0ZtWjFDWCtDOXliMEh5SW0wU0I1Q3c3bG5Nb1BpTzdVNzUw?=
 =?utf-8?B?aVBJVVdiTWhvRWQ2eDQ0a3RTSUNPWm9VYmRKNlhCZjR1bHNaUFk4MkxCNWo3?=
 =?utf-8?B?WmRNNXBScHFYZllJVWlkSERUbitRQTlmZ2QxemFFZjBkTTFhVEJKZURZZmZM?=
 =?utf-8?B?MFZHTUQzSy9aWTJ5MnpDYk9Mdk1yOUlGOCs2SjRXd01nOXU3RzR2cForVEJ1?=
 =?utf-8?B?QWxDZU9BRVRadXM5aTJ5NnBsSmVmOU1PK3YzV0YrWGFYZXhNZlFsVTBDMnVu?=
 =?utf-8?B?a2EvL0FJR1E2QnkveHl3UURHandqSy9sUWdJaWZ0bGtDR0V0dmpTRVB6RXJz?=
 =?utf-8?B?R3FURlRSTnl3ejJ3SEE1U2xKMGtYakpjRGErSis2K0ZrTk1yYlJLSTV1a0I2?=
 =?utf-8?B?S3BJc2tiYUpDOTd2QzFxMG5nOFI0Z2RoUzlkQitjWll2a2UxckV3KzY2Z2w1?=
 =?utf-8?B?OXMzMmg2dDN3L3MvUkZ2cFVrTWZWbUdJTlZEaHhudUxoa21GU0VwcDBRNGJL?=
 =?utf-8?B?UFdLU3NBakZBcjRNSkNUU0pIOXFxbDB1Y0VLY2pLNWl4ckQzNSthcVdyQmZl?=
 =?utf-8?B?aXhTU1p0eWdvazRGR0t0SGYzRkFhQlZSR1lSNjRWcFgyYmE4NjFNUzJlb2gx?=
 =?utf-8?B?K3A0QWYrWHJ4UkFPTEp0YWl2S1N4TWx4Q1JTQVVkcVVDSjIxc2s1VFB2TXla?=
 =?utf-8?B?ZytiaGdrellJb1JnbG1vazZCOXRWOXNPV0tYRy93QzFscUVrdjRRS282Zng4?=
 =?utf-8?B?NFpJSEFuaDVUejk3cVNiY3gxa3ZxOEhtMHUxV3ZzR2VPZnhJWlc2Y0RxYVhO?=
 =?utf-8?B?SFlPT0tCbCtjaXVQTXNqL0dhQ3NMVEJwUlZ6M0dnbGZHeVR5TTB5bG1rdTJJ?=
 =?utf-8?B?bEZobFFDdks4eEhsazlYbE9qdW1FSGtBbmFHV2FTbGtRMlFoeW94MmFuenpo?=
 =?utf-8?B?MERZQXFSWllTTHgrZFpnK3ZGb2dOWnpnNzZWNVRsYWUwbjM0bHIzQ0U3ajZQ?=
 =?utf-8?B?NmFFWFFMZ2c4anJEUUtFQnNYdU1OU0JqRmhUZ0Q2TVUydC93L01KRFBjR3JM?=
 =?utf-8?B?V1RuNkhSeE9kVUxMcXd6TlJUN0h0bm12cmF2Uk1CUUM2QUFyb0t5LzR1aWVO?=
 =?utf-8?B?dWtKZFpNYU1SNGVVUkdBTnY1REFuQ2czSThramhBTHVaaDZRZkRiWjFPemdm?=
 =?utf-8?B?QktuTVQ4ZEpvbU1FcHJKRGFyZC9lZ2MzVVdCTU95RldqcDVNanBTYm9DR3ky?=
 =?utf-8?B?azd1MUwwS2VEcFRtQ2ltaHpIWjJpWC9TSjBoaS9nZ25lZG1YKytXZG1NWmY4?=
 =?utf-8?B?RDhhNCttd2krVVh0TEd0dDEwSmdla0xNUlY4SFMzMU1sMk1nYUpUMXdEY0V3?=
 =?utf-8?B?OUFGckpkUFRuYlNTbDhuVnJzbFR0ZVRGbnU0a3BRRmdtU3JPcEE3QUlIOTZM?=
 =?utf-8?B?U1lhbGxDcW9IU3pLSWtqOEtETUpROEhUMTNHZHJPcEVQZzlGd2NKbHhTQXNs?=
 =?utf-8?B?bnNhKzY4cU1CSGJrL3ZtcDczUmxMVHB5Y205UEROWlhVWWh4U2xSK3d3dDdR?=
 =?utf-8?B?NEtqeFhUOWJQcndIVTg2dzF6YjdueGJnTkRiVkc0NFpKRXlucGZBVVZNdXNN?=
 =?utf-8?B?Z1FkTmdKcm40N3JDREltR0E4eWsvaXh3dEI5MHYvR1dQMXZlUHlVbnN5YzdB?=
 =?utf-8?B?Q1RqdG9tNytGbHIwcU83Q0loRlM1QkpxYU5ITUhsdWE4V0tTYlB4bWM1cHFB?=
 =?utf-8?B?R2JVcGdEL0Z1VlVWQmJvZ2xRakZQbUJGZSt4TUVkOWpZa3BUS1pkdGtrdUxt?=
 =?utf-8?B?aDI2N1ViMmp6cElHaTI0dTc1SDRpUXlXTXhLQ3g0R3d2TEpGUEtRUEx2MlJp?=
 =?utf-8?B?YkhxVTBSUy9BNE1nTjRVZ3JDN2ZqeVY0aUJQMDkvZ1ZzYzlyaHNYK2dWR1Jm?=
 =?utf-8?B?NDdYanM2QXB4YkxmMjRvWmZuZ3ptbVo4OVJJU3ZiMW4vRyt2aGtNNDdQVndE?=
 =?utf-8?B?dEsycXlSU0Y4bEtxay85R21BWkc2N3RVb1BiS2RXeUVkVTA1ZXErSVNSdFZy?=
 =?utf-8?Q?Uck6ddyYmzUcPnck=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c995e57-f03b-42a1-8b39-08da21751ff8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 19:53:35.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1vCMyPCGmyb7ut9U0nYGMvSSJFwPPUMicmTMTRO86rQVclGmUH1M54MVPpGMgec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3670
X-Proofpoint-ORIG-GUID: Z7aLOSdoDYzhLQ5hOiE6dEj9CgNpjgj9
X-Proofpoint-GUID: Z7aLOSdoDYzhLQ5hOiE6dEj9CgNpjgj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/5/22 5:41 PM, Kumar Kartikeya Dwivedi wrote:
> It is guaranteed that for modifiers, clang always places type tags
> before other modifiers, and then the base type. We would like to rely on
> this guarantee inside the kernel to make it simple to parse type tags
> from BTF.
> 
> However, a user would be allowed to construct a BTF without such
> guarantees. Hence, add a pass to check that in modifier chains, type
> tags only occur at the head of the chain, and then don't occur later in
> the chain.
> 
> If we see a type tag, we can have one or more type tags preceding other
> modifiers that then never have another type tag. If we see other
> modifiers, all modifiers following them should never be a type tag.
> 
> Instead of having to walk chains we verified previously, we can remember
> the last good modifier type ID which headed a good chain. At that point,
> we must have verified all other chains headed by type IDs less than it.
> This makes the verification process less costly, and it becomes a simple
> O(n) pass.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/btf.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0918a39279f6..4a73f5b8127e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4541,6 +4541,45 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
>   	return 0;
>   }
>   
> +static int btf_check_type_tags(struct btf_verifier_env *env,
> +			       struct btf *btf, int start_id)
> +{
> +	int i, n, good_id = start_id - 1;
> +	bool in_tags;
> +
> +	n = btf_nr_types(btf);
> +	for (i = start_id; i < n; i++) {
> +		const struct btf_type *t;
> +
> +		t = btf_type_by_id(btf, i);
> +		if (!t)
> +			return -EINVAL;
> +		if (!btf_type_is_modifier(t))
> +			continue;
> +
> +		cond_resched();
> +
> +		in_tags = btf_type_is_type_tag(t);
> +		while (btf_type_is_modifier(t)) {
> +			if (btf_type_is_type_tag(t)) {
> +				if (!in_tags) {
> +					btf_verifier_log(env, "Type tags don't precede modifiers");
> +					return -EINVAL;
> +				}
> +			} else if (in_tags) {
> +				in_tags = false;
> +			}
> +			if (t->type <= good_id)
> +				break;

General approach looks good. Currently verifier does assume type_tag 
immediately following ptr type and before all other modifiers we do
need to ensure

I think we may have an issue here though. Suppose we have the
following types
    1 ptr -> 2
    2 tag -> 3
    3 const -> 4
    4 int
    5 ptr -> 6
    6 const -> 2

In this particular case, when processing modifier 6, we
have in_tags is false, but t->type (2) <= good_id (5).
But this is illegal as we have ptr-> const -> tag -> const -> int.

> +			t = btf_type_by_id(btf, t->type);
> +			if (!t)
> +				return -EINVAL;
> +		}
> +		good_id = i;
> +	}
> +	return 0;
> +}
> +
>   static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
[...]
