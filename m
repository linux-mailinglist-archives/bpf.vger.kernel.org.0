Return-Path: <bpf+bounces-3044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA3738BE0
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C81C20F77
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B318C2D;
	Wed, 21 Jun 2023 16:45:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB217722
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:45:18 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00C10F2;
	Wed, 21 Jun 2023 09:45:15 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35LG4sIK018429;
	Wed, 21 Jun 2023 09:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IYxFhYmMvufTwWOINNswnhZTvx5qzVkx+2jv8Bf86FA=;
 b=cR289+9JwZMcbjP2WOeI8nrHQWIhIfu5gQXy+rbgdQ6Gg+UZkTfPKzk9xg2CkyHe5EXK
 aaJvSqKde7UtKPZrqjuWNVzLGZw20M2izePixxMDf0knhOrYWPWjr5TR1v5JPgM2NWTx
 ryz3R3p+bzuTtidkc4LQz2PjpCi2BiQiWbzDELr2PIpEm50PNBqvySf1LJn7XN8f7cF5
 j76A4DOBjd+/EkgUuGVj+Q4dWSVOJoA+KZhZYWWLZIfNAQLWefYON1Op4cZHE2poN8D3
 IsEn+NESqXYmGcaAjBgcUW3NKCcyJSuTnlKnu5OBcnps5spbT2/KvTh4DyzDlqb/7Gye Gw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by m0089730.ppops.net (PPS) with ESMTPS id 3rbnmnxc5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 09:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkzpJLvB8fCETiHyol4IQoJipk0G/24I5cwPTEXZi6thhK9cAwRegAn2F57mT1ObG8rCgBE/fA+e1b1k/CdjF9uJyQkUfEfX9hWC23CZYyWBONj72fGotDARSrrm1r9msJlrExRoCnjjzdE6veAKRdPHVQ+1iqTTh3rlc44BhbkFBSkGNpv4+g+cBq4NfYarAdYNjwX8AXOyDCjJDiMllQWFhUVUtzab+YGo/V2CrL9ZaydOH9+xfAhIsdH5mhFayH/otsxeBNnbuIzH4XYzlNQ/cHord5QOrPwsqXLIdWxhH5iqND1/bFHsDDhO5bMOx4wSTdwSNuvE5YJjJ2ckAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYxFhYmMvufTwWOINNswnhZTvx5qzVkx+2jv8Bf86FA=;
 b=mYTcLgVYVjiNMbuH1Ly6ltmf/EaszsN2Zrc+sydedIdjB/Rw5PyEcu6d8dL8Ui+SrWTxTo2Ewfue4U/N2s6GYZ6GxgHwm9dJC2WaPAWRonqavwdtyhP3Yz7SznGmsdUt4gg34328QMqfzqNJWHh2p+IiYIbN7oi09lgkcfyAdXmHrzkVFJyD5iqQwSSUb5b7uJxMxiw+TCb62ot6RXjPScAiGJWSBZm0uyL6KekPfFlAP3j40lbJZBOtox1mz76c/ABHQJS3mFpGn3ZciM9kBQj89hhtXqWsOXtqv1DI/ItLJq4ZdPLf3LoDikh1Zo5AyhiyxcA3bEV2K3pg3kz9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3899.namprd15.prod.outlook.com (2603:10b6:303:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:44:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 16:44:23 +0000
Message-ID: <ffed1ab2-dec3-ee41-a64b-30dd1113823e@meta.com>
Date: Wed, 21 Jun 2023 09:43:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v6 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: menglong8.dong@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20230619114947.1543848-1-imagedong@tencent.com>
 <20230619114947.1543848-3-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230619114947.1543848-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3899:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c32394-6332-4739-eb86-08db7276c4d1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oer1wE9Z/KwLtyJQWfqjL4v442ZWjYn7ymv8OWvP0OnLc9H3sNpn+URsEqaQjtwFo8CEPmyPZ66VljYx61os9nbcOCwvRC3w0NHLiix7eYweKwc7woFxr/lqEy75u7jmesDfIIW5x0WznGfTSgxXvfxzWliDO2vrco3LI2c987FsWneB48EE6ydOUVBRmrw5l9pAswCPIdmxnMqZ8SM4MvwgitM7Pgo9d80SpOQr86EunLmBh62OnOq4ar8LAhh9HRz+4aL1Ln0fXfPqPhjcjUgCLTL/3j/McFW5u3ZaqvCNN5mV2NOmoGq5oi9klXp0AcHQ3B0DIgNnSdp84lAwRQ0LMcTAe1NbvAwe7gOK/ofq+XE0FRtzzylvP5/nVo8k6vnez+HvQj8yOr1q62jKCsy98N7xYgXZZQruRza2yGhsHTR1+sGYtpraYqVI9CroxEm97EuMenrRX2lr+A4oheV4SpvIDFUJjsrmwkRPv+G3M3BXdVB7R0051pI8tEJoBObv2UjlCyVnwxHMIbwpappR+ejKojrzcsN28dryE7kK1L6BcrEXJ5qnzH7lSQxvcOZdwKKo6ZjttBH/eIQhNHrzd1qrRerREhEshTECVisOcP5KmJisbN4ByPGcqmkob9gEBX20qkvl0WkPQ7ZRKbztFnIu2PNss7jLNAk7hdY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(31686004)(6666004)(478600001)(4326008)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2616005)(2906002)(30864003)(186003)(53546011)(6506007)(6512007)(6486002)(66946007)(66556008)(66476007)(8676002)(41300700001)(7416002)(8936002)(316002)(5660300002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vlh6OGxmMTEvVHhWRUlKQXVsdzVnMlRTSU9KNWgrVDB4YzZKUlpGODZxZHJJ?=
 =?utf-8?B?OVZwWE1HTGY3Ym4xcW80MXFScHhkdGlmQjRQVmhPUTR3RkFLMnI0RlFSakFF?=
 =?utf-8?B?SWpZMTZCeC93M0FvOXJOcE5icEpSdXJ6ZEh3STQxSytIWTdvV2t6R3pTMitm?=
 =?utf-8?B?cEIyVWhuNU9HRU5waHVsekcxTENkR1NRL1I2eGVXUGdPNFhSamtoYi83VFph?=
 =?utf-8?B?ZEZZWHpONzVWclFyUFp6bkplWnVNRVhhMzJxenVJVlp4VVBmQjhlenJZb0FT?=
 =?utf-8?B?SFRqZjgwemlyazBHcEpFRmNrY3hTTnZ6NjVZOHkvNjRRVkNxNVRIWXJnS3Fn?=
 =?utf-8?B?WmVnK3lNOGh6bEtTUHdBUjV2SDBYWHp4VTRWK0dXTEVQK25WUVhOelJRa211?=
 =?utf-8?B?eDBZNjB2dElxNzc4WEFEOVI3S3A5WkE3UHdaTUdDbDBFQlZKWENNdkFpTmJy?=
 =?utf-8?B?YTNJbTJWN20zcmdvWDVjMVdHSkJwTHljOE94LzM5a25Xblh6Ui9TS3dHd2RQ?=
 =?utf-8?B?T2JSVE9kS0t3L2VnOTArREZKek81NUpoTEV5WjZKRmYrMjhXOWxnbk8yeHlH?=
 =?utf-8?B?aUNsYlN5SFRwTkltcW50TXlyNGwxWGxjVmx0L1d3NU5QcS9idFlvN2hFK2pC?=
 =?utf-8?B?WTkvRmFjZE1iSW03NzZmYzZLTk1IZVFkRXprN2NkTFFSNVJQdEVlbkoyR1Zp?=
 =?utf-8?B?SlRLL05kWUt5bFpWbnJTVi9XQUpoMXpyRkVvMWRTLzNwaUt2eTdqZmNvL2RB?=
 =?utf-8?B?Q084dnJGQS9UMVc2K1ltUHg4VWhRMlErQ0ZhanRLclRVbm9BQUlLSTVIMjVE?=
 =?utf-8?B?Y1B2ZytacEVTZDErak12d0s2OHc0WEdYRG41dFhzYUU1QVJPWGNPZHpJemtH?=
 =?utf-8?B?dVlaU0puaktZdGViREpWdVdoRS9ZSlRRQkxIMThWdzh0QjFUUUJ0ZnZVL3pY?=
 =?utf-8?B?cUxaRFJQWWtQMFJhdUpGektjSFVTd0xmcjQ3bkFQM1ozaStra1UwZlJVUHI0?=
 =?utf-8?B?d2wrT1pqcFlacTlNdnp6c2l4dGhCcTQ2Vm1DMlUxVmtVbnZVWXVsblJjelVt?=
 =?utf-8?B?OGpHZGR5c2dBaG9mNVRQZ1JkS2t2WTZTYm5lczV1dzBVMTR5V04xdXl2L3hi?=
 =?utf-8?B?Wi9DTHowUzRMSzkyVGlPVU5hWGFNSHR1ejNqRGFaS3ozalo2KzkzVGM2Sll2?=
 =?utf-8?B?eWtUazV5OUJCVkIrQWN6cXVqUVdLdTd4Q1c1clNyMTlTQmEyRGJmd3VqVXFU?=
 =?utf-8?B?M0ZiTFJUMEMyRWh0bVVzNWxtK1dLcStsNEZ1b3V5V3RVWE5GRkZSUlByczlO?=
 =?utf-8?B?U09YWTRwbFJOUGFEbzdkUURaekkxZi9aYitGRjFua0s1ZFl1cWVaOGtWcFRs?=
 =?utf-8?B?R0gyOGtYaXNMRDVuNmFxRUdHYVFyVXRRSnFhdGU5cUIvNmdCMTB3OHgvQmNW?=
 =?utf-8?B?bEcwcTlWcUFiV0owTU5OYzJHUi9YcCtPRVMwQWV4MFJJTWJVeFFMWXFrYkZI?=
 =?utf-8?B?VGxDQ0s2NEJrbDBRQ0Zzc1lYOFJyN29veVF5M3J5WWg5UndjSjZGYmpCVkl3?=
 =?utf-8?B?TmkzbFJwbUgyUXdjVTNTSnNab0gvaDU3UGpZblBQZk1oQWhDbm41QmpLanN5?=
 =?utf-8?B?eGk2cWxjSzdoNzM3WlhYS2JxSHhkMC9GeUlGTzQ1SzFmUjRsNTZhT3hFbDZM?=
 =?utf-8?B?dXdseStnZHluWGl4YlNFRDdFUGRudUNROGo3U29lVnRYODVtT045N1hmYWwx?=
 =?utf-8?B?bzdSK1lZQklJNlVsMEd1NUlOb3dSY1lkSmduLzRtRGEyM1grYmFTa21MT3Ir?=
 =?utf-8?B?MC9WMnIzTFFIVVhzOGxvZm5ZNG1oZXNNVlBJNXNRVDlBODFyb01sOWhrWlF0?=
 =?utf-8?B?clpreFRJbHc2S0VxT0FtSEw4aEdDendUVWludVdwVkJadzZZRkcrZnZTcnlH?=
 =?utf-8?B?STFjSEMxZ0R5MVkwekhodFo4RjQ5N2hwMTdHc3VLbG5zaEpIQmlhNUlMa0Jm?=
 =?utf-8?B?VVhnZEU2cnREZHNLcTlESXZFcEpKNklrRFl5ZGdoS3JYSDR0NXVJeHFsRmxN?=
 =?utf-8?B?NkNvd2phRXVlQXdpRlBsLy9jeXI1N2FHa2xLcWJCOTBielh1SXZScXJObVov?=
 =?utf-8?B?YnEyajUrN2drRGs1enVKeUNhcUxpa1ZLdE1hcHJaakgzaGhuaDAxUGhrMHZO?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c32394-6332-4739-eb86-08db7276c4d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:44:23.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuaW1b9GdAjLWmmQWVdR3A5N3MmNkkKt3uSi+4ezaJBvpoV+rUadLLhn7Io7h1t+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3899
X-Proofpoint-GUID: p4SwmIze080zeauKZDBsuRwKwueBvZ3J
X-Proofpoint-ORIG-GUID: p4SwmIze080zeauKZDBsuRwKwueBvZ3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_09,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/19/23 4:49 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than 6. This is not

less than or equal to 6, if not considering '> 8 bytes' struct
argument.

> friendly at all, as too many functions have arguments count more than 6.
> 
> According to the current kernel version, below is a statistics of the
> function arguments count:
> 
> argument count | function count
> 7              | 704
> 8              | 270
> 9              | 84
> 10             | 47
> 11             | 47
> 12             | 27
> 13             | 22
> 14             | 5
> 15             | 0
> 16             | 1
> 
> Therefore, let's enhance it by increasing the function arguments count
> allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.
> 
> For the case that we don't need to call origin function, which means
> without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
> that stored in the frame of the caller to current frame. The arguments
> of arg6-argN are stored in "$rbp + 0x18", we need copy them to
> "$rbp - regs_off + (6 * 8)".

The 7th and later arguments are stored in "$rbp + 0x18", and they will
be copied to the stack area following where register values are saved.

> 
> For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
> in stack before call origin function, which means we need alloc extra
> "8 * (arg_count - 6)" memory in the top of the stack. Note, there should
> not be any data be pushed to the stack before call the origin function.

call -> calling

> Then, we have to store rbx with 'mov' instead of 'push'.

So 'rbx' value will be stored on a stack position higher than
where stack arguments are stored for BPF_TRAMP_F_CALL_ORIG.

> 
> According to the research of Yonghong, struct members should be all in
> register or all on the stack. Meanwhile, the compiler will pass the
> argument on regs if the remaining regs can hold the argument. Therefore,
> we need save the arguments in order. Otherwise, disorder of the args can
> happen. For example:
> 
>    struct foo_struct {
>        long a;
>        int b;
>    };
>    int foo(char, char, char, char, char, struct foo_struct,
>            char);
> 
> the arg1-5,arg7 will be passed by regs, and arg6 will by stack. Therefore,
> we should save/restore the arguments in the same order with the
> declaration of foo(). And the args used as ctx in stack will be like this:
> 
>    reg_arg6   -- copy from regs
>    stack_arg2 -- copy from stack
>    stack_arg1
>    reg_arg5   -- copy from regs
>    reg_arg4
>    reg_arg3
>    reg_arg2
>    reg_arg1
> 
> We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
> imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
> we use EMIT3_off32() instead if the imm out of the range.
> 
> It works well for the FENTRY/FEXIT/MODIFY_RETURN.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

LGTM with some nits for commit messages and below codes.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v6:
> - introduce get_nr_regs() to get the space that used to pass args on
>    stack correct
> - rename some args and fix some spelling mistake
> v5:
> - consider the case of the struct in arguments can't be hold by regs
> v4:
> - make the stack 16-byte aligned if passing args on-stack is needed
> - add the function arguments statistics to the commit log
> v3:
> - use EMIT3_off32() for "lea" and "sub" only on necessary
> - make 12 as the maximum arguments count
> v2:
> - instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
> - make MAX_BPF_FUNC_ARGS as the maximum argument count
> ---
>   arch/x86/net/bpf_jit_comp.c | 238 ++++++++++++++++++++++++++++++++----
>   1 file changed, 212 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a407fbbffecd..c0637f2b5398 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1857,37 +1857,181 @@ st:			if (is_imm8(insn->off))
>   	return proglen;
>   }
>   
> -static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
> -		      int stack_size)
> +static inline void clean_stack_garbage(const struct btf_func_model *m,
> +				       u8 **pprog, int nr_stack_slots,
> +				       int stack_size)

Please remove 'inline' here. Let us compiler to decide
whether inlining is needed or not.

>   {
> -	int i;
> +	int arg_size, off;
> +	u8 *prog;
> +
> +	/* Generally speaking, the compiler will pass the arguments
> +	 * on-stack with "push" instruction, which will take 8-byte
> +	 * on the stack. In this case, there won't be garbage values
> +	 * while we copy the arguments from origin stack frame to current
> +	 * in BPF_DW.
> +	 *
> +	 * However, sometimes the compiler will only allocate 4-byte on
> +	 * the stack for the arguments. For now, this case will only
> +	 * happen if there is only one argument on-stack and its size
> +	 * not more than 4 byte. In this case, there will be garbage
> +	 * values on the upper 4-byte where we store the argument on
> +	 * current stack frame.
> +	 *
> +	 * arguments on origin stack:
> +	 *
> +	 * stack_arg_1(4-byte) xxx(4-byte)
> +	 *
> +	 * what we copy:
> +	 *
> +	 * stack_arg_1(8-byte): stack_arg_1(origin) xxx
> +	 *
> +	 * and the xxx is the garbage values which we should clean here.
> +	 */
> +	if (nr_stack_slots != 1)
> +		return;
> +
> +	/* the size of the last argument */
> +	arg_size = m->arg_size[m->nr_args - 1];
> +	if (arg_size <= 4) {
> +		off = -(stack_size - 4);
> +		prog = *pprog;
> +		/* mov DWORD PTR [rbp + off], 0 */
> +		if (!is_imm8(off))
> +			EMIT2_off32(0xC7, 0x85, off);
> +		else
> +			EMIT3(0xC7, 0x45, off);
> +		EMIT(0, 4);
> +		*pprog = prog;
> +	}
> +}
> +
> +/* get the count of the regs that are used to pass arguments * > +static inline int get_nr_regs(const struct btf_func_model *m)

Again, remove 'inline' keyword here.
Also rename function name 'get_nr_regs' to 'get_nr_used_regs'
to reflect that it counts for the number of registers
used to pass arguments?

> +{
> +	int i, arg_regs, nr_regs = 0;

nr_regs => nr_used_regs for clarity?

> +
> +	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
> +		arg_regs = (m->arg_size[i] + 7) / 8;
> +		if (nr_regs + arg_regs <= 6)
> +			nr_regs += arg_regs;
> +
> +		if (nr_regs >= 6)
> +			break;
> +	}
> +
> +	return nr_regs;
> +}
> +
> +static void save_args(const struct btf_func_model *m, u8 **prog,
> +		      int stack_size, bool for_call_origin)
> +{
> +	int arg_regs, first_off, nr_regs = 0, nr_stack = 0;

To be consistent with clean_stack_garbage(),
nr_stack -> nr_stack_slots?

> +	int i, j;
>   
>   	/* Store function arguments to stack.
>   	 * For a function that accepts two pointers the sequence will be:
>   	 * mov QWORD PTR [rbp-0x10],rdi
>   	 * mov QWORD PTR [rbp-0x8],rsi
>   	 */
> -	for (i = 0; i < min(nr_regs, 6); i++)
> -		emit_stx(prog, BPF_DW, BPF_REG_FP,
> -			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -			 -(stack_size - i * 8));
> +	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
> +		arg_regs = (m->arg_size[i] + 7) / 8;
> +
> +		/* According to the research of Yonghong, struct members
> +		 * should be all in register or all on the stack.
> +		 * Meanwhile, the compiler will pass the argument on regs
> +		 * if the remaining regs can hold the argument.
> +		 *
> +		 * Disorder of the args can happen. For example:
> +		 *
> +		 * struct foo_struct {
> +		 *     long a;
> +		 *     int b;
> +		 * };
> +		 * int foo(char, char, char, char, char, struct foo_struct,
> +		 *         char);
> +		 *
> +		 * the arg1-5,arg7 will be passed by regs, and arg6 will
> +		 * by stack.
> +		 *
> +		 * Therefore, we should keep the same logic as here when
> +		 * we restore the regs in restore_regs.

The above two line comments are not needed. A similar comments exists
in restore_regs() already.

> +		 */
> +		if (nr_regs + arg_regs > 6) {
> +			/* copy function arguments from origin stack frame
> +			 * into current stack frame.
> +			 *
> +			 * The starting address of the arguments on-stack
> +			 * is:
> +			 *   rbp + 8(push rbp) +
> +			 *   8(return addr of origin call) +
> +			 *   8(return addr of the caller)
> +			 * which means: rbp + 24
> +			 */
> +			for (j = 0; j < arg_regs; j++) {
> +				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> +					 nr_stack * 8 + 0x18);
> +				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> +					 -stack_size);
> +
> +				if (!nr_stack)
> +					first_off = stack_size;
> +				stack_size -= 8;
> +				nr_stack++;
> +			}
> +		} else {
> +			/* Only copy the arguments on-stack to current
> +			 * 'stack_size' and ignore the regs, used to
> +			 * prepare the arguments on-stack for orign call.
> +			 */
> +			if (for_call_origin) {
> +				nr_regs += arg_regs;
> +				continue;
> +			}
> +
> +			/* copy the arguments from regs into stack */
> +			for (j = 0; j < arg_regs; j++) {
> +				emit_stx(prog, BPF_DW, BPF_REG_FP,
> +					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
> +					 -stack_size);
> +				stack_size -= 8;
> +				nr_regs++;
> +			}
> +		}
> +	}
> +
> +	clean_stack_garbage(m, prog, nr_stack, first_off);
>   }
>   
> -static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
> +static void restore_regs(const struct btf_func_model *m, u8 **prog,
>   			 int stack_size)
>   {
> -	int i;
> +	int i, j, arg_regs, nr_regs = 0;
>   
>   	/* Restore function arguments from stack.
>   	 * For a function that accepts two pointers the sequence will be:
>   	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
>   	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
> +	 *
> +	 * The logic here is similar to what we do in save_args()
>   	 */
> -	for (i = 0; i < min(nr_regs, 6); i++)
> -		emit_ldx(prog, BPF_DW,
> -			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -			 BPF_REG_FP,
> -			 -(stack_size - i * 8));
> +	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
> +		arg_regs = (m->arg_size[i] + 7) / 8;
> +		if (nr_regs + arg_regs <= 6) {
> +			for (j = 0; j < arg_regs; j++) {
> +				emit_ldx(prog, BPF_DW,
> +					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
> +					 BPF_REG_FP,
> +					 -stack_size);
> +				stack_size -= 8;
> +				nr_regs++;
> +			}
> +		} else {
> +			stack_size -= 8 * arg_regs;
> +		}
> +
> +		if (nr_regs >= 6)
> +			break;
> +	}
>   }
>   
>   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> @@ -1915,7 +2059,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	/* arg1: mov rdi, progs[i] */
>   	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
>   	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
> -	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
> +	if (!is_imm8(-run_ctx_off))
> +		EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
> +	else
> +		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
>   
>   	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
>   		return -EINVAL;
> @@ -1931,7 +2078,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	emit_nops(&prog, 2);
>   
>   	/* arg1: lea rdi, [rbp - stack_size] */
> -	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> +	if (!is_imm8(-stack_size))
> +		EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
> +	else
> +		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
>   	/* arg2: progs[i]->insnsi for interpreter */
>   	if (!p->jited)
>   		emit_mov_imm64(&prog, BPF_REG_2,
> @@ -1961,7 +2111,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>   	/* arg2: mov rsi, rbx <- start time in nsec */
>   	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
>   	/* arg3: lea rdx, [rbp - run_ctx_off] */
> -	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
> +	if (!is_imm8(-run_ctx_off))
> +		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
> +	else
> +		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
>   	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
>   		return -EINVAL;
>   
> @@ -2113,7 +2266,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   				void *func_addr)
>   {
>   	int i, ret, nr_regs = m->nr_args, stack_size = 0;
> -	int regs_off, nregs_off, ip_off, run_ctx_off;
> +	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -2127,8 +2280,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>   			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
>   
> -	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
> -	if (nr_regs > 6)
> +	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
> +	 * are passed through regs, the remains are through stack.
> +	 */
> +	if (nr_regs > MAX_BPF_FUNC_ARGS)
>   		return -ENOTSUPP;
>   
>   	/* Generated trampoline stack layout:
> @@ -2147,7 +2302,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	 *
>   	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>   	 *
> +	 * RBP - rbx_off   [ rbx value       ]  always
> +	 *
>   	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
> +	 *
> +	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
> +	 *                     [ ...        ]
> +	 *                     [ stack_arg2 ]
> +	 * RBP - arg_stack_off [ stack_arg1 ]
>   	 */
>   
>   	/* room for return value of orig_call or fentry prog */
> @@ -2167,9 +2329,26 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   
>   	ip_off = stack_size;
>   
> +	stack_size += 8;
> +	rbx_off = stack_size;
> +
>   	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
>   	run_ctx_off = stack_size;
>   
> +	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
> +		/* the space that used to pass arguments on-stack */
> +		stack_size += (nr_regs - get_nr_regs(m)) * 8;
> +		/* make sure the stack pointer is 16-byte aligned if we
> +		 * need pass arguments on stack, which means
> +		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
> +		 * should be 16-byte aligned. Following code depend on
> +		 * that stack_size is already 8-byte aligned.
> +		 */
> +		stack_size += (stack_size % 16) ? 0 : 8;
> +	}
> +
> +	arg_stack_off = stack_size;
> +
>   	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>   		/* skip patched call instruction and point orig_call to actual
>   		 * body of the kernel function.
> @@ -2189,8 +2368,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	x86_call_depth_emit_accounting(&prog, NULL);
>   	EMIT1(0x55);		 /* push rbp */
>   	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> -	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
> -	EMIT1(0x53);		 /* push rbx */
> +	if (!is_imm8(stack_size))
> +		/* sub rsp, stack_size */
> +		EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
> +	else
> +		/* sub rsp, stack_size */
> +		EMIT4(0x48, 0x83, 0xEC, stack_size);
> +	/* mov QWORD PTR [rbp - rbx_off], rbx */
> +	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>   
>   	/* Store number of argument registers of the traced function:
>   	 *   mov rax, nr_regs
> @@ -2208,7 +2393,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
>   	}
>   
> -	save_regs(m, &prog, nr_regs, regs_off);
> +	save_args(m, &prog, regs_off, false);
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		/* arg1: mov rdi, im */
> @@ -2238,7 +2423,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_regs(m, &prog, nr_regs, regs_off);
> +		restore_regs(m, &prog, regs_off);
> +		save_args(m, &prog, arg_stack_off, true);
>   
>   		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>   			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> @@ -2279,7 +2465,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   		}
>   
>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_regs(m, &prog, nr_regs, regs_off);
> +		restore_regs(m, &prog, regs_off);
>   
>   	/* This needs to be done regardless. If there were fmod_ret programs,
>   	 * the return value is only updated on the stack and still needs to be
> @@ -2298,7 +2484,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   	if (save_ret)
>   		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
>   
> -	EMIT1(0x5B); /* pop rbx */
> +	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
>   	EMIT1(0xC9); /* leave */
>   	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>   		/* skip our return address and return to parent */

