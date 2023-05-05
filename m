Return-Path: <bpf+bounces-120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890146F856E
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81121C218E5
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684EC2D4;
	Fri,  5 May 2023 15:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D223BE7A
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:20:25 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE24AD28
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 08:20:21 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345BX1iC024142;
	Fri, 5 May 2023 08:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dqOF5O93FRyWMHAH46NMstWdYbb2ZjW1N3XJDvypUw8=;
 b=iFjYlOVVY6DJGajZuEIDa4P+CglCRcOryXO0FDGCsCMDzGtNPx9eP6GpMu8Vw+H5wxU6
 PCGd6xTG2iCvVFEddzCAsjQCKfXYlvqHu14v63vY4AqKYn3+/41ub86SLt0CfOBlhvdY
 93wPXFPxRYwxRJ5il+Z0bA6pY5qYkrAc9IcOByAkIv8+taqn5CL4pBR63HpgfwDZrtsm
 wu5K4UvbOWLhpjScu0YRWCva1vgnkeAfw9ZKxIeh6jfbla038kkI1fyN4el7oeYM/p48
 5YtEAt1nXdu5RndFvlC4yBgtNceiTqI2Gecbj7iTOKlYZrY89ApgU6UhgLkKZCYiDtGS bw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qce9tgqa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 May 2023 08:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdWYSg2ro0zREyPrZSQiacTzeWS1soXuQMw2oTX4tvFPRyvv0a9cefpWewzioxuHtUD1UYWEGLzrp/NVLRX73xDcadnmZTy1YjyGBZ4Eikh7W83RAt/Mnr9T0UUZzdPdrgqxOTtailU/cjrlnqWLBYClnP8+Mpr7X2J338o1kbMy10oGx+IJD3XxRzav6bknWEddqG1yeJXzsSc3brScCxyKRXTSsAUhllbqmzWkyyBy5nTzmA4h3Cc0U+gL1LE5GCB7x8zkN1I+p98iMTd2Fk3vQ73pKHyINX+KgH4/EjMssyoRZh/lTYk2dQJWLTTDeVVM9+wWLG4WPsHhsmX9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqOF5O93FRyWMHAH46NMstWdYbb2ZjW1N3XJDvypUw8=;
 b=ItYf1Nn4xSEhR4QAlyiXdlF2zoXPzM+FU4cjU6Ez0cLxRLaMfEMBN7r4voOco5493aClAtaub/kUtC4TFMSc5Hpxjqkmerjkm2okgDMJRBwOGVNoeDbRD1ZO41wSHI2lAiZm683Ac3TwHvOtE4Q6c5vwbZJ+DZYU+eT4pfj9YQ0JhydF3YM+V2CVCpxCURTdAUo9YSf6j7Adm3J9uC9SAJWMVp82u94idW1Do16XD9uRJ+VrmJP45ZtAzP698HNrfpJzeJ1vLAa6R/TrjbrxWn5+kublcy2mKc6iQexA81MWjtuE+oRcpMcoWGapI7Y79aRfctAPsvwpJP7H0/IW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB5514.namprd15.prod.outlook.com (2603:10b6:610:143::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 15:20:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 15:20:02 +0000
Message-ID: <251b33eb-f55a-fda1-44c1-385726de2916@meta.com>
Date: Fri, 5 May 2023 08:20:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: eBPF verifier does not check pointer's pointing location before
 doing memcpy.
To: Karthick Bhaskar <jetkarthick7@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <CABPHfyNEHsv_Jh7SprryfApMugvDkSg6fRSG6Q-LE9=Q1hEGZw@mail.gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CABPHfyNEHsv_Jh7SprryfApMugvDkSg6fRSG6Q-LE9=Q1hEGZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d30ad9-599b-436e-6fae-08db4d7c32c8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MLUZNiq0P323+442m7AnFEt/PGuITVR/UzVnkdr97lap2YXPn0mac+ohkbV5UVTYag3gverZu4HtMWqe0unP8pdMo0xkZfRGySiQ4RWayT0CPPnzFBqTKCnPxSKgRrlY1Ij6yODM8fPZmUE6cjQQYET1awOH1SGj5Q7S3ffdMYOyZ3cqTVkqGFW8nEslrYxl19sYBo7JXRiOHC4llMzk1zLZjr68HcwyOsj8hbVywQoPTyuhj2IM94iGcAsFdxU0VcHcTpGWvf6spbbovKOK+pHMrjnPQ/NRgi4gL05gcffq7LCWKnK9lMfdinazp+aVkK+YYGaREjZv1dpPVlgDLq4OFTkTDW3XoK85BKUZZZs2VAxBH5q4FmQUcrcgMbSGEf9Phd+SVMh+yvCMFn+6BnA1olBhRPG6pRTk3KbSb/Uf3skjBXEc2381q6LYoaisEUjc2XS8JphB2uozpM8kQWD5565S8iGy55QOSn+zOF1ncRBEX9RCho6C3oXlPJEw6C28cQDfU0dHgww/g0G1/lqsnz7Vm66HyrO2Nk6OfHBke8VKY9nt6or3KpXNT9msEnkIwuRzOc2asxBkGj6bDgqCWqnutWe90yl3umxIp4gYVfChfp19PYxRse4B2zriswaeqdEgKT7v5CD/UdRi6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(31686004)(5660300002)(36756003)(38100700002)(2906002)(316002)(86362001)(31696002)(8936002)(41300700001)(66946007)(4326008)(66556008)(66476007)(8676002)(83380400001)(186003)(6512007)(53546011)(6506007)(478600001)(2616005)(54906003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHRpbjhHbVRHR0VVRm5SMXBEUTB4amtWRmdkMm5abStmNEZuZiswMnpoWTNz?=
 =?utf-8?B?UEo3SStRVDlCdENtUytaMnBocmN0R1h0TGRwQ29BMkszRlB1WEZEOEF0ajYy?=
 =?utf-8?B?K25WaEdGSVUvSlFZL2djM1E4bWxTODVJMnFCcHg2LzlacndscWVzbkJKM21w?=
 =?utf-8?B?ODlkTmNOMElpb3RUc0FOWVFOeS94ZTFQM0hyMmRPMVJKVVRDN2dzSWJ0T29H?=
 =?utf-8?B?d28zdVRGSDFoS1hrTVo3N1VXOWxkRzk1OWRId1dOeWhHckpOTU13dHB0VVVU?=
 =?utf-8?B?TjdHdGhPdDRYbm5zWWZ2T2xmYzBraXRDTjZHaDNnRkdCKzE0MWJwakp4NXhW?=
 =?utf-8?B?UzBJQ1lBMmduT294MWpGK2hObEtUU01pdCszTS94ZjZ6MFZlbENNbWVxWmdz?=
 =?utf-8?B?eG1yaml5NGlyMDhvekUzbC9TQkdoanhlRFk0VGpPQlBUY2ZjTXhwL0V1SFFB?=
 =?utf-8?B?U1NpUThpaTYxL2ErbjRlZ0NzMTh3MnNWTE1rSk10dU0wZ0pTUnhSOXorQVlR?=
 =?utf-8?B?V0ROTFE0VmNuV3RWVFM3RXZaazVqMUhLMmZVbzB1alNnY3hVVUV5Z2gzcUIw?=
 =?utf-8?B?TnBjUVBkcit1U1JhMW1SZEJWdXZndE5VWm1VbVc3UXBhYTkzY0hHeE1WVTds?=
 =?utf-8?B?YVdibmZGTFhTd28yeEo4T0xMdUxDQjJLU0haVmV4SkRrb1ZNb1BRSVlzVkg0?=
 =?utf-8?B?bDBJditLdFVudkhWMXFjMTF5cU5nS3pjT052eENGMFVlcEVyR1FaOEE4bXFz?=
 =?utf-8?B?cFdyMjJtVUt6NExqWDI2SEFOTjhyL0RGdFRQbnk2bHg4aFZKNnlXNEpUNTJI?=
 =?utf-8?B?WFVDK3ZSR1d6dlRaNURBeUVpaDcwZ2lCL0x0NW9NR2FsMGhSaW95Z2tlc0RL?=
 =?utf-8?B?bG9PL0xTdlowS3AzOTlLYUs2YlZCSTR0NGZzeU16MVlIb0UvWVJKTW1MZnRh?=
 =?utf-8?B?cHhzQXZLR1pKVUtKSStOLzhwT1dUTlF1WFB3UWNhM2pMaUtpcmVianRBb3Qx?=
 =?utf-8?B?bWFsTEc1Q3RUOExtOHo1dGVXN09peFl3QkpnYTVmUXJyeXVTL0YvdUc5YWI5?=
 =?utf-8?B?cWhGQndPQ1NhZHhVNDdUTWRUWHNXRm90UCtuQUhWKzVEazd2L0hadmVGR3hF?=
 =?utf-8?B?OVV4Q1N0RGtkUFBDU2UzdDhsNmV5dG9wRm84WnlRbU84NnB2OS9DUHN2QnRk?=
 =?utf-8?B?M0Zwd0hUc3o5aXNBVDlPWnVOOTVoVWl1L1FiK0kxc2hZRldJa1NybDFEZGc3?=
 =?utf-8?B?Nkw4amFBcEtzRUxpUGRvTFU4TEFqa01LZzdsUmJ1YXgyRmtSQjZtZDhaR3JH?=
 =?utf-8?B?c0p5UFJ1ZWlTc2JjM2pXUW42WXdmTEtwNzNSU25kdDlrQlB2WG5lVDdxTk81?=
 =?utf-8?B?dk1JU1pHRTdmRGliTlhYOEtkWXZTZmJuUUU3TXNJR1l4WGRWUFdyWkYxUzla?=
 =?utf-8?B?WE5KOGNmYnI1NGRFVVpESGRQbHRhRW1DRDlEQ1Y5Q3k4R1c3Zjl4NXZTMDVI?=
 =?utf-8?B?aFZJVVFWQnRaRmRVMHRXc1VBZTZlTlN2MHQrOE9WVDhGdkYrYWtRNitvWWR1?=
 =?utf-8?B?Q1VpQTUwZDZKc1FSRVQ4a1dMQVJmTjkrWi9RQTFNOEdNZ3VzSXlzZjNZdmVE?=
 =?utf-8?B?RFNLOHlWd2kva2ZVV0N0bkNqZUVDNWpJQW9XQjArSEdNVVhaWWJxUk04aVZl?=
 =?utf-8?B?V2JDQ3N5eCtheEt4b2lMRExaSFBUOURCZ2V6dE5QMWNMUXJBdGhUcjlxM0hZ?=
 =?utf-8?B?dmlocFUrd3lKam10azBtQzd5d3FGQ0txWVB4VXU1UnByNCtEVTlxcUhSMTZo?=
 =?utf-8?B?eHZOSVZaT3BuK0wyOVdqNDhLOWdGZEUxQzI1eHRHSnlFQVV6VHFiQUw0Qmsx?=
 =?utf-8?B?MlJVY1JxL21BUjdSbW1xUWplQVA3V2krb3dSM3ZkeHlVVlhWVjdxK2hubktN?=
 =?utf-8?B?MU1RN0VGZGdQdnJxdTJXUHZNVzFTMk1vZVdFUjR3b3FySElFVnMrRkVRYzFj?=
 =?utf-8?B?TzlWb0oySU1OcmM1VXM0dkVoZHhsWHFuR0VCeGFTcFdhRjVhTVQrM0VlOXJa?=
 =?utf-8?B?cHM3UUN1bE9VZVk0OFZFOVdTaGZVUGlJWjUwdzBKMDFsWHcrdXl4MlRPcHM1?=
 =?utf-8?B?U1MzK0Z1ZmpPTlNwRnZ2OVRNYjJCSThtdHVIemlqTDFBUUx6SEc2MEljcjBh?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d30ad9-599b-436e-6fae-08db4d7c32c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 15:20:02.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdFehYMmn4FAjgE8RtqFgx+xT4YP0ncAqCXKoAImZld38tdCalrYzKyHN3qDxzir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5514
X-Proofpoint-ORIG-GUID: b5m_OQOFJiB6gvEqlwM9yPJ2IRXqs-cU
X-Proofpoint-GUID: b5m_OQOFJiB6gvEqlwM9yPJ2IRXqs-cU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_22,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/4/23 11:26 PM, Karthick Bhaskar wrote:
> Subject: eBPF verifier does not check pointer's pointing location
> before doing memcpy.
> Hi Team,
> 
>       static __always_inline void ebpf_memcpy(void *dst, const void
> *src, int len) {
>      for (int i = 0; i < 3; i++) {
>          ((char *)dst)[i] = ((const char *)src)[i];
>         }
> }
> 
> In the above code, i am passing a char pointer without allocating any
> memory to it. But the verifier didn't throw any error or warning, as a
> result, during run time it didn't execute " ((char *)dst)[i] = ((const
> char *)src)[i]; instruction and return. Fundamentally it is incorrect.

Since the memcpy is not executed at runtime, I suspect the verifier
decided it is dead code and hence no verification error.
If you think my above guess is not right, you can post complete
test here so people can help you to check whether there is a
verifier bug or not.

> 
> If we execute the same expression in the standard 'C' it must have
> thrown a "Segmentation fault" error.
> 
> Thanks,
> Karthick.
> 

