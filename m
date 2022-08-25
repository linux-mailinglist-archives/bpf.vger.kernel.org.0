Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902D65A0751
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiHYCiz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 22:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHYCiy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 22:38:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8834785B4
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:38:53 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P0j6P6021556;
        Wed, 24 Aug 2022 19:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VMocUY6iUJgxfu7SFLUgCjPMhb1UvI5Y3cpuM/MObyc=;
 b=qVy7sBrTeT08nxmGYO/v2gWV8sqEaWlEo3tNXceH83n4n4KHz/E5Splyup8BudPZnunP
 AfV1TUWp8oNiMx3JrvmH7JA1GqqDONrYu5cCd3LLHXsncsCwX6+ceMIh2YIsZJtb2GNE
 eQ8J7h1BJ8/EKohEiTx0gqrcZCbbvUTTmPc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bejyqjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWxhTJaPWMlSxSs5h5/C47Ty/2JQ+EofMUBpQr3IWJAo1anlWu0ACrDUtbYjd7UqSbI4qDZ5drRXbbX3rDadJkjvuPGjUUrzNFQS5EH+DNoJ9PHqHwopRt9wd26FSbg6BbYz3oo46hEQXDPTU1ZUY0VgepTMgNfNfl4yoOe+zQ3FWimIhHTWaXSngwjOOpBShJqCVNP97rzN7LdLGLlfhqtL7IhoOBqTgt610ROl0tVz+YdlliULBg789afT4j0NVkgLQGOo7F0ShZnyCPPOPKYAHkGVGbPeD3BkTcAHUlG5TjOoyhXctyQFdnn87hlQDyHeyJOOBsSqVIO01GKDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMocUY6iUJgxfu7SFLUgCjPMhb1UvI5Y3cpuM/MObyc=;
 b=Chc+rApakIaPTW39mF1kIY3EY+rJ3snut9Guheykcd5tSuOEMFiDipdQUo9Ff74z3w0+cuzRs2/DVDTgxrBHbrpcbzE4M5T2VJjpT4ZCMZ+naZIYL/g3YuvaF5Qjz7QmlgRU/0MDP5Q+VhfzoZPw1k2z866W24AmOjOE/GaYFu48XMMC+8zJuUZfnc4BoA4qc9SanW5tmB8Zx24fouTyC6wE6yoRVgt/6oPjiQGMW5apMHrE8LiZ2hfQV0sMHF9lQ5+c+oappkR66lZ+H/BCwomrDHcTLxMF8xsyejXQ6Rc0nm1Em/CTL6bZUyeqTRM6k8xOOiPowaOE2J3K+ILFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3240.namprd15.prod.outlook.com (2603:10b6:a03:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:38:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 02:38:36 +0000
Message-ID: <de255464-f423-d2ee-70a4-a4c12c126997@fb.com>
Date:   Wed, 24 Aug 2022 19:38:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH RFC bpf-next 2/2] selftests/bpf: check nullness
 propagation for reg to reg comparisons
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-3-eddyz87@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220822094312.175448-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44299ba-28ac-4324-677d-08da8642e93f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3240:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bic7YHZChBxOT6azbgO3Gtae6Kw/cdbgG1qN4qNlV22EpmIHI726evivdn1Nlp0hYPLwUonjyGXLGPcs7jzSPw2Hn6uW7IENGyg0Ta2CuvA2AdSuxWSXC8+vO8Bc99moUTy1GTOZywPwmaVrEAnYpHoc4au+04NtwYsN4tjRFhQQ+1tvouO11YBrx7MoPseJcnhNlwlBQJsT/jXjMTPt/AJrVK5JqGCSghT+FjMoSTg1edCN/Azcz5HF0sETBjSvc3y0PwUP2auW8lhVoaO0hhVU0ESj9hf+oDpByDFWMtbzOyqEq0FIY3NPjrabVQn0S9r4AN45ad18IxMSnqTq+CkQzQjzd+MA6T/+t1Y9X8gU8cVgeo1+RaA3AbAwMPgtStBQmW3r7eV8TjJeghZYPF5IJXd2S8aMISOB+J6mOoPa9WV2SytZl9I6NU0RdrF6ehqEaV2mnxgCeMmU/AkydQmejGXWE8WeD51Hy6L7XdxpmPOI31clN51aY1FgGhG4h/oXp9bOU52JIvaGyHKXz7rPYBtunX9QnqKKdkgp7VBLrFVeHC4Mf+GMEHHF5nF3hNMgPF6ziGQy1cbD6CGMAwSFxoSlEg5Yv6GZ1daE8WMl4YIjhmLzD1qlcHGRYgTAAjV1PLq6l5D7/LMfj7g9NI8YfdK58bCs1yO3L3ZiCI/HK9bi2eC3uaDC0EmkwY3BcqAtU6CkK5dIlHufv6oww3o7qlGWLPRFqyg9KLRXSzqNsx5VluMFEtTYJzVw806/26ap0WR9NB0VRMhuneFiPj71l1+z0aNaQY9WYMSE9/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(53546011)(186003)(6506007)(2616005)(8936002)(5660300002)(6512007)(41300700001)(83380400001)(478600001)(36756003)(31686004)(6486002)(86362001)(31696002)(38100700002)(316002)(6636002)(2906002)(8676002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFYzSDJhOEFoenBvVCszdld4U3NWTWZCWUlSeDRsL09LVGlvUThhcXpuQS8z?=
 =?utf-8?B?RTkwSzJGK1FNOEs5aTRyalpaSHQ1SyszbWE5UkZUamJhSlA0KzlHbHdmTFpF?=
 =?utf-8?B?c0NoOGUzSUlhYnZsYjJpNStiMGsvUmZaa0JlM1J1RVRMRWhPblVVcEgyTkFQ?=
 =?utf-8?B?UG9NTXZpdzVvaEROR1gvR0VyampBUFN3Uk92d1hQOTJDQW00elB0OUpRZzR6?=
 =?utf-8?B?VlpleG0yTlozeU9oUm5CK1FtWEpnaUx3THR1ZG9MYlNZMHBiRjVCOHRYalBt?=
 =?utf-8?B?bUVPVlhYbGx4VTA1SVhiWTF1N29KZlNrSjJtNU1pS0ppRWJFR0E3WTNJcXN6?=
 =?utf-8?B?WHZJQklMMmsySU8xaFM3UTl4b0dIMjZBektwa1hLS0lWN0x3c043ZXpudEVm?=
 =?utf-8?B?MCtjSThjZHpLcU1mRituRGxUSlZFcVBKQnRKQ0NRZ1ZONllMNnoyYmhldVBw?=
 =?utf-8?B?N2pHcHpSMkNjYXVHcFBwcHVRbzRSVFZBeXQ1ZXZqYWt3SERxN0VNV3c0ZHB4?=
 =?utf-8?B?R0d6RFhxZjdkcTNXeDVjdE1vOU5HaVkzQXZTZmtDU2srMnNZbzc0Nkd1V1E4?=
 =?utf-8?B?WHo1alhqME1MSFc4ZURKdGFGdmJNWVN5ZXRyVHphRStid1hmdkx1ZmpLUTN6?=
 =?utf-8?B?aFVmVkZENmxTRysxS2ZKQTBSc1pUdFpOTk5KS1F6eDU4NlZoZmlBKy9vM2NJ?=
 =?utf-8?B?QjdtTXZTWDd4MDRLQlozLzJXWFlpVjc0V2RqS3Rxb09iRDZ2TXczN1RYaXZU?=
 =?utf-8?B?d3RPLzdRK2pyVitjeFpHQVJXMUdUellqc3JleTR3TXIwaFNJS05NMCsxaFlt?=
 =?utf-8?B?VnFvVFVBdUZTMGN0OFdiRm5WZ0R5Ti9UTXEvbDBZMzJtNkJsdHUzMTVXR2t2?=
 =?utf-8?B?bm0xa1k2RHM5R1BoY2NVaXlDTjd4SkFXWnRPczNZZ1EyNmEraDIyRlFubzA2?=
 =?utf-8?B?UDhCaGN5UDZxUkZrWUs3QVk5WktqSXVmZFg0NXJGN1gydHRCaS9MTWlndE1K?=
 =?utf-8?B?QmM4R2srWVZTMnNibXJlODBPc3Y0NFF0cENnaTd4ZVd2OCtFOWtKb25rbzVx?=
 =?utf-8?B?RjlQT0RKYXBwVmZwUmRqcDJtK0VLYjZ0QkVjdzdRRVYzVTVQZmQ1ZjN3elJz?=
 =?utf-8?B?bFBGd2dvQlNPT2N2TWlZaHlTQkZFQys4UnVuVndrS21rQkltNzA1c3NjR25X?=
 =?utf-8?B?WTVSM1FoQ2RURy9HWENQcldONXhHVkhwWkZJSU1qVHpHMFg5NXljSGx2ajlV?=
 =?utf-8?B?b1E1YmxBb2ozK2VKNDlZOUhKTUpWc0FSZTJhYmFCTXZpa3IwUDc4QkxoTklv?=
 =?utf-8?B?bjM3bW81QmE4d0Vtcks4eGsvUzlDcWMyUlVxYkJweGJIWU9hYTdGUXpLOXZC?=
 =?utf-8?B?N0o5VGVqbE1INzZtdW1SUWdaUzRRd1U1R3dQZEZjUVRzUzdNMWQ4RFJTRE5C?=
 =?utf-8?B?ZXdOeGJWL0llWGpSNnFQbElSNW04WFQ2WjNEY2JaRWU5aUtTM01qYzQ5d3ox?=
 =?utf-8?B?RU5pTjZFZFB1UmdhRWZBQWNONVpyVG5MbmtaUVIxVGZLems5aFFHcCtmSUNm?=
 =?utf-8?B?L1k5TWJLQnJyQTgwSmt6MUpiMzBqbVFIQ2dlSnlNVEU0aDFONitaQTVkNlVj?=
 =?utf-8?B?Q2I1ZE5jUmR1Vnd0aGtwUjJqdFdsR3J2QmJSZmNhU2tsbWVld3hwOTlmcjZ0?=
 =?utf-8?B?ZFZIWmxmcHF0OWV6MjZMc2U2Tzdjem5uMjIxUlNVeUhMcjZEdWdPVitXZUl5?=
 =?utf-8?B?VWRHck5tNjBYT2F5WlNkWlpDeVhYWk1SeVVKQnFpR0J5UDFlL2lSa3BpdVBn?=
 =?utf-8?B?N2lQRmQ5VlhVUlF1TmJjdDVrNFRzakRCZi9TQzllbVJCN0tITXFyU1ROcFBD?=
 =?utf-8?B?cVh5dDZVUE8xbDVzcmtMYWZCQjF0SnVLYlBiNER0MEkrVlAwcXIySThROC9k?=
 =?utf-8?B?VTNWblFBOHBzT0R4SUVpMis3YVN1MGh2WC9NU29TV0hUc2J0YWdJdDNSTDMx?=
 =?utf-8?B?K2xxb2MzbHUyQ2VyR0dIa3VqSUs3N1FuYUlsMWRTSUFvR3IwcmNYOFpVUGVr?=
 =?utf-8?B?RXdFZVp6RXJKM3FuT1N0cHlTQ1hjT254VW8yYXlvUUNoUTMreVBER0VFNERn?=
 =?utf-8?B?bDQ4QWxqcnF5cG5FYTJzZ1BKOWZKN05aa2YvTVhUMStxdk83U1poN2VuNUhn?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44299ba-28ac-4324-677d-08da8642e93f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 02:38:36.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsbEDT/B7UDWthFwgwIxW8QgV+XIK615MGPfDdT2asMBXdLdphFfmVgY/3JpqeUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3240
X-Proofpoint-ORIG-GUID: xJVxNO_w2ErmEdkJlR4eifEbw0DpXg8E
X-Proofpoint-GUID: xJVxNO_w2ErmEdkJlR4eifEbw0DpXg8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/22/22 2:43 AM, Eduard Zingerman wrote:
> Verify that nullness information is porpagated in the branches of
> register to register JEQ and JNE operations.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM with one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../bpf/verifier/jeq_infer_not_null.c         | 186 ++++++++++++++++++
>   1 file changed, 186 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> 
> diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> new file mode 100644
> index 000000000000..1af9fdd31f00
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> @@ -0,0 +1,186 @@
> +{
> +	/* This is equivalent to the following program:
> +	 *
> +	 *   r6 = skb->sk;
> +	 *   r7 = sk_fullsock(r6);
> +	 *   r0 = sk_fullsock(r6);
> +	 *   if (r0 == 0) return 0;    (a)
> +	 *   if (r0 != r7) return 0;   (b)
> +	 *   *r7->type;                (c)
> +	 *   return 0;
> +	 *
> +	 * It is safe to dereference r7 at point (c), because of (a) and (b).
> +	 * The test verifies that relation r0 == r7 is propagated from (b) to (c).
> +	 */
> +	"jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch",
> +	.insns = {
> +	/* r6 = skb->sk; */
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct __sk_buff, sk)),
> +	/* if (r6 == 0) return 0; */
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),

In general, for each test case, we only have one
	BPF_MOV64_IMM(BPF_REG_0, 0),
	BPF_EXIT_INSN()
to simulate the C generated code. It would be good if
we keep this way. The same for other test cases.

> +	/* r7 = sk_fullsock(skb); */
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
> +	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +	/* r0 = sk_fullsock(skb); */
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
> +	/* if (r0 == null) return 0; */
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	/* if (r0 == r7) r0 = *(r7->type); */
> +	BPF_JMP_REG(BPF_JNE, BPF_REG_0, BPF_REG_7, 1), /* Use ! JNE ! */
> +	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_7, offsetof(struct bpf_sock, type)),
> +	/* return 0 */
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
> +	.result = ACCEPT,
> +},
[...]
