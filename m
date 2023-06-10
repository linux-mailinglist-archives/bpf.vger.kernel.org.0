Return-Path: <bpf+bounces-2297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510772A8CE
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C180281ABD
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8515386;
	Sat, 10 Jun 2023 03:30:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D821847
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:30:24 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389E26B0;
	Fri,  9 Jun 2023 20:30:23 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A2v9PZ014982;
	Fri, 9 Jun 2023 20:29:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dwuA6GmHIHcqVUEFp7M6sF7feRuML94IG+avUv/YJU4=;
 b=Ml5l1msD84OwHR4xgVYLKo4li+HP6wsrSz6MeGA/ieY7Ht1deNXcnXJS88IwoCzTx/Vt
 imG0YZkxYPX8W4QAZrTfP7I2fYQ4vb9OBgvvZBqeO1w+4e5Z19NbhPAdPnMSmmJDGso6
 4awny7TDXASGpuZRfLYRcPUcmZU/Rm1XV3nESRquchLVuIZwDFF8KHqprvyCFdTgR/NT
 uz/0GlepBOGb8d3m8C6Jb2LXWbguNwQ+xBl7XFffKcSA6pdtTKvBN4M91CAunzVnCe1v
 tWn7hO58TFTqyl0ATxzmyL3YVmXcqskBhiZSNwbSejPtqRNn/+kvbUsR3wIESKfMtHfL 8A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r3fd6nw9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jun 2023 20:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxabWNl4QnQ1xe85Cb72qRY/1srS+u8qlYHGHsHk2bL4YLmAh2YVMsqWB2GFiYSJyc//dHsfEScpCVjBQZT8gc35/tMLYNeP+ru+cikLkBRfSwbyn6HfkAfAyt9WrQ9xl1GhUMQPUqq8IE/dbwCeM7Bi3fvjFRzlMUWt85wxtfNGxnL+kvyhb4Ugh4WpCWfR0P29WSqRsb43jPJdbOSZs9dylbC8msGk6lujrpmBpE8B/2zAa1PtP8ygB+UFHbz5zTw/hM3wIVHRmEewgoL3Uyhj4brEm/eN0kAwaSSYc3Z5A/QL/czV+v4sT3EMjWrgho7LzQQE8qS86Fxi4e/mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwuA6GmHIHcqVUEFp7M6sF7feRuML94IG+avUv/YJU4=;
 b=Trp5tMZ0IyT+tLOhbUy+OQjzC/vB5vBw7DM1XTqpn0lEO22q5uDf3+UBYySkbQNDTHMKVmN2XnPp3Imo3R/Sj+wLi36a6D89797PrISz90iuiVHyGL6gKGieyF0QgpN5PW0qHwNrXti5ScuzjFluyRISJAEzlFrxlL5FA1lv7VfrmVSoPdvnXGoUVzFvq6z+7Ax1NPnJOOykWuBUmPJboRJ4ZI5O57RVjwv+63rhPjJJT4kd6ViABMF1M2oYz8uwY934LxFTD2dZtqeST4Isii1Mg64NmpCdxzBauDhtCBfJ3m98omTaqZbCVTnekChSbYq40n97zvTLxaFzeLs1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4459.namprd15.prod.outlook.com (2603:10b6:303:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Sat, 10 Jun
 2023 03:29:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:29:37 +0000
Message-ID: <50d29ea7-09b8-9026-e127-8c21a4bb9706@meta.com>
Date: Fri, 9 Jun 2023 20:29:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase for
 FENTRY/FEXIT with 6+ arguments
Content-Language: en-US
To: menglong8.dong@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-4-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230609095653.1406173-4-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: d589ee0b-077e-4cbd-5aeb-08db6962eabd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hJCKeKwBbNWPoKjeGmmJ2xyUUoNS+CBYNWoyOsVTjniH+XBuekvV1aUol/XBhbgWopybwAeSb4BjEwmSsDGRwBBpe5Eity6+8saa+yC34sMCb5Dniq7yv+v1keBoR9SslGasC+3AOjF2Wxa+pdfwmiAl2VAf+DuHzk9Y9fGBeGpHog2n0N5RoqtP5mcyUuvJz5Eo8mybtv+BJ9eDs10Rp/tdw7JH8Pw5t26xL0pfWlQXSqYlKq/PJobTBv7I0QFg8aHijaX97Z2PPRMX6BgFB0cAAdF0QxTUU0dauCpUCNSJt9LLsXScxsbhuASpoYjrxs8wppHb0rP9m1Bj04NVR9PWFVEnq1Y6lxEJqTiyauF5AVqdaq3SbE2tOAj4sxnkmHVoGmER7LTIVWO7KvFekPY0hrssPyXphtmAEu5JtmcIacOyyVvmdgRQczWiu0kgplBFqs9YZfftbum865jr6EKAD6OU2QMb5wqyps3uNDvFJ2Z4wijCybpBo2PZ21BVZVhe51/gHZrtlf0jEHEFUX5WqJaRKShA0L6vgbh0FbQwX1jeGXU6/qQscRpGz1w6ijtqCf/VVIuC/XOsDCe1zYSTbk/+rWBK+/DBELBEWwCUgQK9vyTJgCy1qUSksCdMrDwhgAoSMusSDEqE/U3HWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6486002)(316002)(41300700001)(2616005)(86362001)(31696002)(83380400001)(6512007)(6506007)(7416002)(186003)(2906002)(38100700002)(53546011)(5660300002)(8676002)(36756003)(8936002)(66946007)(66556008)(66476007)(31686004)(478600001)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UldKQ1dLWVdvOVM1d2hOVUtUQWYwZ2pKYjFGOVZKMGFNT3puMVUwRzg1RmhV?=
 =?utf-8?B?c00xSVZXaUZ2TDBsMnhScG1NcHUvUGJ3YVZWdXhtT2dldjY4WnMzVGFwZDB0?=
 =?utf-8?B?WW1PRmVPS2JrVUNOUEx3NVJSMC95TlE2UG1zd29qQ0Nyalp0TmN0d2ViZitq?=
 =?utf-8?B?dDM4ZGZUWGVocFROQWJtclBIbzVuMURsNGRHQTlrSFdidlZnQU5KZ1pRZzRW?=
 =?utf-8?B?VWs3V3B2R0YwVjg2bSsrS0lEUFlzQ2VYV3NibFFIZEZBN0tEamxOT0xqLzRR?=
 =?utf-8?B?Sit3ZUVSMUQ5SjIyYzVTVGltZkRmRGx2V2NucU5NeXRGR09pbXFJUloxemZG?=
 =?utf-8?B?WStKNlNUS25NbXdudjNxejVtMHNZYUdTZVJxRDFsWnY0aUhuM29yL1M1Szkx?=
 =?utf-8?B?VGFYbkxiUEY1bk54L3BYWnIzanZsQ1JDeDdLZEYwOUgybXA3eXpIdU8zU1B0?=
 =?utf-8?B?RGUvWW5OMnFkcHovK2dIL1FlUUU2RVkrZ29FZGRkR0Mvcm1taDJ5OTFoZ1lI?=
 =?utf-8?B?VnBWeldyOEFqSzFGNFdOS0JTUjBvYmF3Z3dZWVh1Vm1XalFWR1pxblllNkxB?=
 =?utf-8?B?b1llYXd3MUVJWUFpa0htcDBjeEFnS1dQcm1hNUZmTGpyeTZhVTV3NzFPS1k1?=
 =?utf-8?B?U252S3I5Zis0dlNGWG5YelNSYmxiaFlxR2RDaG95THJvUnhTTEdTRmFiNTVZ?=
 =?utf-8?B?c0tkREtkRzNqMHMycHB6NGtRR01rMkMySjVGZkJkY2Zyb1V1L1FTMUZCQ1M5?=
 =?utf-8?B?SnNTbS9pUndDUEFlQm4zZ1Z0UStJbk5pT1FlSHBsM0pRWUJjUUNlVXFCdVRp?=
 =?utf-8?B?cEJEWjVpSVcrU05UN3Eyem9SellUVmxxOHNWS3hhREpwaVE2NXdJdEo5Zm8w?=
 =?utf-8?B?Z0p2ZnJJNTdwQTB2bzdhMGhTVU1mSTk4V2l0U09vc3ZYa2NIWkRNTXVTNmMz?=
 =?utf-8?B?emwyM1FHTmljb0tIdUpMSlB0Ui9KcTEvWDhsSWZmSWlFV0hmbkh5NDAzZkVp?=
 =?utf-8?B?R1RlR2JqSjd0WUN0Qmxma24vYWJvU0o3RTFtcjdMdTJRcG1DSk1ZalNaOFN4?=
 =?utf-8?B?TGo0VytlWEF6WHAwYlVzWUxLeXJqYXNsYndDMlVQU200MHBpdTZDVFRTK254?=
 =?utf-8?B?QXF5b1lKUnZyZE1xc3ZHYUVQQ2dZWHJRSGRTK0xISnhRTU12WjRPcFFWdEt0?=
 =?utf-8?B?Tk1hdHVZZU45SzdXOVZmNjBUVXA2a1FBeXdhWldHVlVLSnVIdklDd3o1MTds?=
 =?utf-8?B?TXYxSGNLMVZpRGM1NjhlY2xVdmg1cSt0aFBMUDNEd29yZE9LTEdjd0E3aVFw?=
 =?utf-8?B?U0JINW16bFRvVThVcmJReDV4dXFRTkluV3pSZWZNZDdrR3FxWkt6TVFnYVJS?=
 =?utf-8?B?NzRlWU4zb200ZmxrR1RremRQdmVHaHNVUXFyWHFTZ0ZLTEZEdC9sdEpaUllr?=
 =?utf-8?B?REtUZnIzNFByRFRIZ2JESitlUStXNWJsODFHcGFuRU9HNUlvQURSKzU1V3Jw?=
 =?utf-8?B?V29aNGVROHlUNWpvWEhZWVUvSUFJcVMrTHlZaHl3SkE2QTBDMzNlYURyNkZy?=
 =?utf-8?B?d29BaWxySlQ0OFhUVHEzN3RkbmNXR29kSitpOGc2VVVXaFNXcFpPbEYybkVG?=
 =?utf-8?B?Y1JIT1Ivb0gyRzBFQUUzODlXQU50VlNnWDdDajFKRXJpd0ZVZnNJdkhCT2U0?=
 =?utf-8?B?ZHJ4ZUhkU2l0OThTZEhGMW1WMUZOblRvb0NXT3FjOE9TVkNXTGF3L2d1TlRY?=
 =?utf-8?B?Q0FacFB2TjVYYzZlZ2FSQU5aVWx5V2wvRmY1SXM3QXhJOGFuNFpYMVdEMzBO?=
 =?utf-8?B?Y01WdlBvMlN5WDgxMDFYZXBkc0hFUXFFVDk2MGJuS3dXVkJXMi9SR0RmSTFi?=
 =?utf-8?B?bE91TVY5NldnM2k1WDh6bFpJQWpRVXBVQkxFblBTVXhQZDlKeWh6S3JoTTJ0?=
 =?utf-8?B?WTEwVDNXWnZoSGFnaDdPeGZxMy9FemNpUE9kYmRIeGsrTS80NDhEdEVxVElE?=
 =?utf-8?B?MGJmMTE1NEhLa2dLUjVGYmwvK2RTR3liZEc0dFJzWjU5dTJJcDI1RitwRm4z?=
 =?utf-8?B?SDJqSDFkNmg5OVgraXpaUFR1VzdGQS9OMHNkZmE5WEhUQU40T0VwNFdCdFRh?=
 =?utf-8?B?bkZEeXZhaFJzb2VHR0QxcFlSWno4M3lKWXNZdmdJMVBFTUhJMDY2YTE5d3Vn?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d589ee0b-077e-4cbd-5aeb-08db6962eabd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:29:37.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1D2ioCsk47JYncLpDXrqmj12pw0GWrPPEZTzzLLGgO0MjeYzrsnuBaoqGZcmc3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4459
X-Proofpoint-GUID: NnNa9Y_rddjxuzBCPUMGEfZAgEGXA0qt
X-Proofpoint-ORIG-GUID: NnNa9Y_rddjxuzBCPUMGEfZAgEGXA0qt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_18,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
> and fexit whose target function have 7/12 arguments.
> 
> Correspondingly, add bpf_testmod_fentry_test7() and
> bpf_testmod_fentry_test12() to bpf_testmod.c
> 
> And the testcases passed:
> 
> ./test_progs -t fexit
> Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t fentry
> Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v4:
> - use different type for args in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> v3:
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>    bpf_testmod_fentry_test{7,12} meanwhile
> - get return value by bpf_get_func_ret() in
>    "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast()
>    in this version
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++-
>   .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
>   .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
>   .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
>   .../testing/selftests/bpf/progs/fentry_test.c | 33 +++++++++++
>   .../testing/selftests/bpf/progs/fexit_test.c  | 57 +++++++++++++++++++
>   6 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index cf216041876c..66615fdbe3df 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -191,6 +191,19 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
>   	return a + b + c;
>   }
>   
> +noinline int bpf_testmod_fentry_test7(u64 a, void *b, short c, int d,
> +				      void *e, u64 f, u64 g)
> +{
> +	return a + (long)b + c + d + (long)e + f + g;
> +}
> +
> +noinline int bpf_testmod_fentry_test12(u64 a, void *b, short c, int d,
> +				       void *e, u64 f, u64 g, u64 h,
> +				       u64 i, u64 j, u64 k, u64 l)
> +{
> +	return a + (long)b + c + d + (long)e + f + g + h + i + j + k + l;
> +}

It would be great to add a couple cases with struct arguments
where each struct has 8 < struct_size <= 16.
>   __diag_pop();
>   
>   int bpf_testmod_fentry_ok;
> @@ -245,7 +258,11 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>   
>   	if (bpf_testmod_fentry_test1(1) != 2 ||
>   	    bpf_testmod_fentry_test2(2, 3) != 5 ||
> -	    bpf_testmod_fentry_test3(4, 5, 6) != 15)
> +	    bpf_testmod_fentry_test3(4, 5, 6) != 15 ||
> +	    bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
> +				     21, 22) != 133 ||
> +	    bpf_testmod_fentry_test12(16, (void *)17, 18, 19, (void *)20,
> +				      21, 22, 23, 24, 25, 26, 27) != 258)
>   		goto out;
>   
>   	bpf_testmod_fentry_ok = 1;
[...]
> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
> index 8f1ccb7302e1..a6d8e03ff5b7 100644
> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> @@ -78,3 +78,60 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
>   		test8_result = 1;
>   	return 0;
>   }
> +
> +__u64 test9_result = 0;
> +SEC("fexit/bpf_testmod_fentry_test7")
> +int BPF_PROG(test9, __u64 a, void *b, short c, int d, void *e, char f,
> +	     int g, int ret)
> +{
> +	test9_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
> +		e == (void *)20 && f == 21 && g == 22 && ret == 133;
> +	return 0;
> +}
> +
> +__u64 test10_result = 0;
> +SEC("fexit/bpf_testmod_fentry_test12")
> +int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f,
> +	     int g, unsigned int h, long i, __u64 j, unsigned long k,
> +	     unsigned char l)
> +{
> +	__u64 ret;
> +	int err;
> +
> +	/* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
> +	 * accessed yet. So we get the return value by bpf_get_func_ret()
> +	 * for now.
> +	 */
> +	err = bpf_get_func_ret(ctx, &ret);

Maybe just have 11 arguments for this test case?

> +	if (err)
> +		return 0;
> +
> +	test10_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
> +		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
> +		i == 24 && j == 25 && k == 26 && l == 27 &&
> +		(int)ret == 258;
> +	return 0;
> +}
> +
> +__u64 test11_result = 0;
> +SEC("fexit/bpf_testmod_fentry_test12")
> +int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
> +	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 l)
> +{
> +	__u64 ret;
> +	int err;
> +
> +	/* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
> +	 * accessed yet. So we get the return value by bpf_get_func_ret()
> +	 * for now.
> +	 */
> +	err = bpf_get_func_ret(ctx, &ret);
> +	if (err)
> +		return 0;
> +
> +	test11_result = a == 16 && b == 17 && c == 18 && d == 19 &&
> +		e == 20 && f == 21 && g == 22 && h == 23 &&
> +		i == 24 && j == 25 && k == 26 && l == 27 &&
> +		ret == 258;
> +	return 0;
> +}

