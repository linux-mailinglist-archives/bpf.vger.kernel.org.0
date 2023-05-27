Return-Path: <bpf+bounces-1346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B867130E8
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 02:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8A72819DC
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09388380;
	Sat, 27 May 2023 00:41:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622E196
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 00:41:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98E125
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:41:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QMwZ2K029356;
	Fri, 26 May 2023 17:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZOO2rd+joy9/1OXUDxQdiAwdD5hvr0n+SzsjogedOpc=;
 b=nkUJEICEJj8IPIpx8mFgBj57nBnQBnvOpuAzsEX4Wy7f2RfzHsSFevQg5zc87v8RmthX
 oJhFaxJ/VB/JaEAikXhjwFWek1b7IL7zCN7pa4n2aH47d1XCpgklPZiuC0Vkj9QXmiE9
 mkmXu+nrr59FKCVs1j+TSZInaq8+YVSKKVjSKVk4HM9Ipf/mv5zFUVjNP/5D+kgaz7az
 cUkot0BSUwoeiF7bp/LfBFZOUY/mdOo768zB2+UbvvDzuqOMX0dDG8J3DZB+m5fp/0Dw
 NwtRQzNXixI8Z17zt2mTuzGMidW0FqpzenwbiuzGaZkrW1dRh/AGpd7A7JzChtzHEqhz ZA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qu4jw8uqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 May 2023 17:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7esou0JPyWCv49SSc7SXIL5RsQKndKgUZZyGCdI0+4FOUpalcTDoWoKoHyySiyjmLy8h+CPwKJ6WUXgZCj01xRTKHM3GrJMFW4tZNe7UFwXJ7Y8Ke4OVLbjh1PrPcGOpVzgWO7AJniHA7s92wVlBAJgzSUESTeadhrPkms0C51q5gd9axNecdN83BkfyKa9CVxWQQSleCYKANfkz3gf3jF3g9Hxq794StvUHb4iHZKXsnKYMdaPzyN9roRclQpFLXg0wtZgBldpixAqmBhUyL8SUeoIxK1bFFFd7QA/0RrM8Eo9endKeHNgovlNGT/mA4NWyF1B+6auNctQ1ccm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOO2rd+joy9/1OXUDxQdiAwdD5hvr0n+SzsjogedOpc=;
 b=dmUjw7TpwiF3dstS1I9LXQ5obmmCngUxFtfiyX5Muudl3A2CUSXojfVhTryJuehyG/CPoHZ5f53j2t3RBXvrq97q4LWb4cHEl8a/dMB0+lgTUZedcxAM01tLS65MqK3LxQ8k8kK8lwGzSYgq1sp3mGjU5y3PK9FK0Qhf+tMGOREZRyNIq1PiCCISb1ITmxUqpn5YzKt/Bhp2P29xRgl/GftedKvgt7xUN8eJbz2BbJxWVDJUVD71DG6etO9Ktvi2FEO7enuPKDp/7yT6ayGuu309r6dyBgb8CxNplXUHIIj7BMjYDQHaVfb2MsDabLncZNJBGEc49uY44F05Y+dv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 00:40:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%5]) with mapi id 15.20.6433.016; Sat, 27 May 2023
 00:40:40 +0000
Message-ID: <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
Date: Fri, 26 May 2023 17:40:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230526184126.3104040-1-eddyz87@gmail.com>
 <20230526184126.3104040-2-eddyz87@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230526184126.3104040-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: 10352e3a-f7fa-4c4b-795a-08db5e4aff25
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	msWcCjVCb0Nuw8JeEm9BCXqFqo8ITHl1ey46cCrnPLEsCLh8KgFL2t9eYUrFXBIRCuNXFrXFHojPuCtrX/JpUT0Kjeb4wMHylmNVbe2hhaS2Msi6yrpLIK5Y9ncTNYY1AW9Co8ZouwgensKfdQMt6SlTLpyktVzD/pLJaelHR2pTeo73dYssV180MGVXsNHg3HIz99YknkM+IqFKH0k3dgR19AAwWOTgasKz4GSblJfznLFhrS9ZrSnxIutYK9Vtpq49xr4gZioCcZK7I/vr2bcKwhnC1hRLrOo8Pjt4pMSFn1vwaKGpFytzbZLPxv8RHU/8h798BlFZtNC2Ympx0w/TX8vwUXar9hziMnqCvE+LPIRFlOn9MUM8kXMDlRwhV5I2LL3EtXCMX7yqN1etA3DecUMlXxuA1UVWqVYmj2EP+g58iSv1zI1R9WSxv4AaCCGW+pbtak/BOvGE10vfar41hTSmocKVI6SJ6ZG2rYmOzxviDmd2SoKllOzDg1yM1rfU7/qI6HT/gRiiAa5oxjP0f9KQpuqKsRaE7nHDh+4XjiVNr9ECXIPDXPws/ClZx4cIscCx6LyHgcprEA1dPV49G0DtOnMdBeGjTwNCXmW6OeKAY0GDPdTUxwRtioYKTf4k3Xy6nvL7TcvYJ/FnRw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(6666004)(316002)(36756003)(6506007)(53546011)(6512007)(4326008)(66946007)(66476007)(66556008)(38100700002)(5660300002)(41300700001)(6486002)(8936002)(8676002)(83380400001)(31696002)(478600001)(86362001)(31686004)(186003)(2906002)(15650500001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1lUNit1SXFOYlRkWTJSbU5oOG54Q01IYVFnNjB6Vm1iZUJ3c0FnakVGaUpN?=
 =?utf-8?B?OGJxR0N5WW50ZFRET3dSQzVpRnBnbisrbkQ0eWZKTkxkTkYvWXJMa2pSb2ps?=
 =?utf-8?B?a3VadFNoMHFTajRpNndlVjY0dmo4T0pQam9DNlBmVEJUbnplTG5sMVZNcUJh?=
 =?utf-8?B?RndzekE2U0dMV08xLzZLRFJyUkgvSUVoT2dGWk45QnhKcjVzN0d0ZFVIa21B?=
 =?utf-8?B?WWtPWXFCVzRYNlRURHlySXM1cExacEdmR09yQzduanEwak9mVlpVakwrYS9J?=
 =?utf-8?B?K0dmYlJnN0QyWlpQMzlCMGVZL1pmU2pJdlUxdWxTV1Q0aExqbmJDblZDTmVT?=
 =?utf-8?B?M3Facmw3U3Z2WmI1MWdVM2NoY1NQK2l0aCtzb1ZKTkhxUVdGOW5IUUJKZWhM?=
 =?utf-8?B?amhzdWYwaEJwdFVUZHh6elNUT0hKd2NoSGFFNC95bXBpR01qclZJWFpJU0ZH?=
 =?utf-8?B?LzR2cUdLY2VyTFhYS090VGlpemJ2UVRvdFRPN1dMZFJ2YUtuWko4OVEzZVg0?=
 =?utf-8?B?YWppa1daS1FEdU5wc2Z2alduNTFVbXlYdmYzL3pjd3NkUWhMRitoY21jOWla?=
 =?utf-8?B?dlZNSkc5QnJZQmh5b2VtaGJjNGk4ZWhKaWF5dmNMeG1ocnovemNtenlzMEZS?=
 =?utf-8?B?UUkvM2dRUSt6dWFrTFNVSjFNTTBhMklzTkdkMEsweGRLSy91aVkzRHFmbEJJ?=
 =?utf-8?B?cFhjVnNJUEU3c2xKZXFjNWFXVktlU3ZmRjdGcThURHM4TmRTZVJtRmJOSU1R?=
 =?utf-8?B?d3V1N1JzbVFxYXV0YXBNaWN2c3Z3dEp2dmJvbWJnbjY5cCt2enkxU1c4bjd4?=
 =?utf-8?B?SUFqYktBdC9WS0FtT3dkSENETWh5cUhDQnI5SlN2Skh5U3JTWFl3Rkp3MWZV?=
 =?utf-8?B?bVM1UzBqZ3NldkdENDM2T0VGMFlvQUNkcFgvMW5KcEtUU2FYZVgrWEZCa0xP?=
 =?utf-8?B?eElFNjdlWjIwNlJGTVVBUkdKUG1SR25rR2swVERXTUNUT1R0YjVxR04yQXlY?=
 =?utf-8?B?aWtieTk5bkhtbUJXZHVjNVcveDZjSTV3clNUT0tQS0J4Z25ScTdvbzhFeHRu?=
 =?utf-8?B?R0VkazU4UkhtSUhteFY4dXJFQzR2MlRZbWt0Z1JEaUFMUEZHeFVrSmx3Nk5s?=
 =?utf-8?B?aThkcm00MkVqcG93c1pYblM3Z1REQmdxU2loeWlTa1hTcXVjNW1RMFNMQVNI?=
 =?utf-8?B?SUovRlBzSzd3UERUUUhQaXcxK3Z1d3R0UTV4eDk5RmRyMFQvMGp6anRDZi96?=
 =?utf-8?B?M0NKYnJZVmVxUEVoYllJL3FrMy9WeVRtejdUaUQzTEhNM2Fid1A5V0czSDg4?=
 =?utf-8?B?ZW1GVnRYS2h4WjYxQkdtbi9XanFVTlZrQjlPT3Y5Q2JjRzRsUW1ySXpiS0xN?=
 =?utf-8?B?YWo2dk90NWZpSkVvZkJKNFRLL0ZnNWF4K0xMRzZoQmJHMy9xT2N5T1cxQXpS?=
 =?utf-8?B?UmJ6MGNxa0RnMkg5UEtSYUMxSWc2OVRxRllZNzkyR0twelJWOHBWZWZhaUtS?=
 =?utf-8?B?ZHpEdi8vOGgzT1BLVmhTUks1K0NjdlhzOEVjTlBUd1lyRjViNllHVUZPa2tN?=
 =?utf-8?B?MlpJR0lOVE1hUHdxcm5KUWxXbzZYUmRMWEFaZ3R0NTF3cGppU3RvamtRU2FW?=
 =?utf-8?B?ZnlpdFN0ZDgxWFd0NUFPSkptaDVCNDdsRmM0OUxLWGpLSHBROXdUaWlvZEYw?=
 =?utf-8?B?bmx0RXZjRmd5azB1cGFZYUQ0TUQ4SDd6OCtzRlN3Y3hZZU1CTDFBdFR6SC9O?=
 =?utf-8?B?N2h3YXdGL2pWTGtReVFrbU5TV3V1UzJzTmpxK2wwQStWL3NDbnVMTGx2SWVN?=
 =?utf-8?B?SW5YenNBN0liOHg0b0ZhMkFvSlV5MXN2bkNCTllEODZ5bys1Zkw2RkJKcFpB?=
 =?utf-8?B?NVJQVHdFN2I2aXpOeHNiSWhvRW5GdkttbGo2NDFIM0QxUkUyWSsrbm5wLzc2?=
 =?utf-8?B?cEh1dEhobkx5TnRveUVRV3FwZXF3ZGttdENyNHBUN0NzckpDSmFwOU1XQUQ3?=
 =?utf-8?B?TnZLMDNpZUpVdVExOTY5ZitRNGlnQmpBaE82WWRVR3FpdFp4WVY1ZDV3YWJD?=
 =?utf-8?B?SmdtVWNkcGYzem12YjlrYldHR1JYMndMN2RmTGJacUQ0VEVuVFE0MFJvNTdk?=
 =?utf-8?B?bGhFZTZ1TGZMVC9QM0RGMzd4SVRlRWVhRkxPdlRiMHR1c0lvSXg1SnJTd0gw?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10352e3a-f7fa-4c4b-795a-08db5e4aff25
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 00:40:40.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIhF5yl3bZxLiUwOgxnsYysZ/Pb0nfM7vIXfCFTDtwzW27HR0XxJczFPc+pizj1o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-Proofpoint-GUID: 6b_iF6OQ-KQ9a1-mOFYv0XKqv6S3DVvy
X-Proofpoint-ORIG-GUID: 6b_iF6OQ-KQ9a1-mOFYv0XKqv6S3DVvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_12,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/26/23 11:41 AM, Eduard Zingerman wrote:
> Make sure that the following unsafe example is rejected by verifier:
> 
> 1: r9 = ... some pointer with range X ...
> 2: r6 = ... unbound scalar ID=a ...
> 3: r7 = ... unbound scalar ID=b ...
> 4: if (r6 > r7) goto +1
> 5: r6 = r7
> 6: if (r6 > X) goto ...
> --- checkpoint ---
> 7: r9 += r7
> 8: *(u64 *)r9 = Y
> 
> This example is unsafe because not all execution paths verify r7 range.
> Because of the jump at (4) the verifier would arrive at (6) in two states:
> I.  r6{.id=b}, r7{.id=b} via path 1-6;
> II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
> 
> Currently regsafe() does not call check_ids() for scalar registers,
> thus from POV of regsafe() states (I) and (II) are identical. If the
> path 1-6 is taken by verifier first, and checkpoint is created at (6)
> the path [1-4, 6] would be considered safe.
> 
> This commit updates regsafe() to call check_ids() for scalar registers.
> 
> The change in check_alu_op() to avoid assigning scalar id to constants
> is performance optimization. W/o it the regsafe() change becomes
> costly for some programs, e.g. for
> tools/testing/selftests/bpf/progs/pyperf600.c the difference is:
> 
> File             Program   States (A)  States (B)  States    (DIFF)
> ---------------  --------  ----------  ----------  ----------------
> pyperf600.bpf.o  on_event       22200       37060  +14860 (+66.94%)
> 
> Where A -- this patch,
>        B -- this patch but w/o check_alu_op() changes.
> 
> Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af70dad655ab..624556eda430 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12806,10 +12806,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   				/* case: R1 = R2
>   				 * copy register state to dest reg
>   				 */
> -				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
> +				if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
> +				    !tnum_is_const(src_reg->var_off))
>   					/* Assign src and dst registers the same ID
>   					 * that will be used by find_equal_scalars()
>   					 * to propagate min/max range.
> +					 * Skip constants to avoid allocation of useless ID.
>   					 */

The above is for ALU64.

We also have ALU32 version:
    } else if (src_reg->type == SCALAR_VALUE) {
        bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;

        if (is_src_reg_u32 && !src_reg->id)
              src_reg->id = ++env->id_gen;
        copy_register_state(dst_reg, src_reg);
        ...

Do you think we should do the same thing if src_reg is a constant,
not to change src_reg->id?

If this is added, could you have a test case for 32-bit subregister
as well?

>   					src_reg->id = ++env->id_gen;
>   				copy_register_state(dst_reg, src_reg);
> @@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>   
>   	switch (base_type(rold->type)) {
>   	case SCALAR_VALUE:
> +		/* Why check_ids() for precise registers?
> +		 *
> +		 * Consider the following BPF code:
> +		 *   1: r6 = ... unbound scalar, ID=a ...
> +		 *   2: r7 = ... unbound scalar, ID=b ...
> +		 *   3: if (r6 > r7) goto +1
> +		 *   4: r6 = r7
> +		 *   5: if (r6 > X) goto ...
> +		 *   6: ... memory operation using r7 ...
> +		 *
> +		 * First verification path is [1-6]:
> +		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
> +		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
> +		 *   r7 <= X, because r6 and r7 share same id.
> +		 *
> +		 * Next verification path would start from (5), because of the jump at (3).
> +		 * The only state difference between first and second visits of (5) is
> +		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
> +		 * Thus, use check_ids() to distinguish these states.
> +		 *
> +		 * The `rold->precise` check is a performance optimization. If `rold->id`
> +		 * was ever used to access memory / predict jump, the `rold` or any
> +		 * register used in `rold = r?` / `r? = rold` operations would be marked
> +		 * as precise, otherwise it's ID is not really interesting.
> +		 */
> +		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, idmap))

Do we need rold->id checking in the above? check_ids should have 
rold->id = 0 properly. Or this is just an optimization?

regs_exact() has check_ids as well. Not sure whether it makes sense to
create a function regs_exact_scalar() just for scalar and include the
above code. Otherwise, it is strange we do check_ids in different
places.

> +			return false;
>   		if (regs_exact(rold, rcur, idmap))
>   			return true;
>   		if (env->explore_alu_limits)

