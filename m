Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447A5BDA2D
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiITCdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 22:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITCd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 22:33:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC4578AB
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 19:33:21 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMswPr026618;
        Mon, 19 Sep 2022 19:33:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rCsSw5EFHHkaDS5p6TAhUPy8tWvSFgu+SM0hSBfmnXg=;
 b=pFvPxuAb2cg7PXBS31WOilrM7c4wSxmE4qIDCubnib2WXnSb7KXFX1GpUagvodXK3RcV
 IhAvr5kvBCwG7dCsgpX+gkfb8kZwl+qN8eabBgMivyW7ClwGv8oLliMi95cQ2TpAIFi1
 kZ+MWV9wll0gGJb1mAxWljxgxIP06zO9qkY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jn9jm0gkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC47KjcPOdHUYMx6bgyTZITUMiv4EqopvuQKDwyW3qbSt614vB6UidFLLJg+J6VE0HegXedblnsH1J6KPwOzMzZbgZJIJsCod5FIc6QY1ysp2NQCsU65h/P1SCYIJlrCZGgEklB4bBaQ4+QPYMDuyesnnuyUuRukfWaGX0pSLECQSW1En4uxzRUgcjX3GE+F11Jw7GWGFu/vCTKtOKgk3VY6WUtW8J3jAKaAoVFccs6sOW3fdWq03/KWyV5P4R4fWjlBM9Xqv3WyCiO+E80hNMkf2dF3i74cQNTZW/VtBXfha+1VC7I962VGcIWDCuL9sz1M1PxOoi1feth8/fHYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCsSw5EFHHkaDS5p6TAhUPy8tWvSFgu+SM0hSBfmnXg=;
 b=SmWPXK2o8xY4YHsayhdr7zcsNw/d5RweXV9pvp+hMLSsLEOyMWyWzAQNk+upC13o8KjUo+a9uPhTU92v55iXc7OdqT2B27PGIMFXmMP4lmkTyoi3StyQAXLoyNyrmRdkuzsCAwzVhHN3oaAgf32AfVG78X0N0iEGHVpOxaUT1PHuSJlUh3dk7fLfU1Tjxg/ia3MTTHTmk6TWe/bY5SXBsancHDUdCi3N6Ii+jW9ZnDW2C9Ley1tzDXuy9PRc9FJn4U/9Xg0HQ6xWGd3YieKs6eE3K08TzN2oABCOdffGTzI8cYe0MndLcPPWUK0nt354AvwV0/pkopLPHeVgD2uBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4920.namprd15.prod.outlook.com (2603:10b6:806:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 02:33:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 02:33:02 +0000
Message-ID: <e4e3c6e6-4214-a827-8a1b-3b31528717cc@fb.com>
Date:   Mon, 19 Sep 2022 19:32:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v7 bpf-next 1/4] bpf: Export 'bpf_dynptr_get_data,
 bpf_dynptr_get_size' helpers
Content-Language: en-US
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
 <20220911122328.306188-2-shmulik.ladkani@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220911122328.306188-2-shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:208:134::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 18377ce9-8a1f-4595-77cf-08da9ab07088
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALQCVsOg7yYvYAJDuFszUSQtWnG5fzbzCPWzLUy8qkPI3RDjTwga1+8Uy3YkyKbQmAzp4zq62znUiZxDTyUhMOT8XHQ4i5sBGq3IwbvUH2jsUO8XCIho99XIZV8dTnZ9rZyySxQw45cnB7+KCX4RPPOH/BAi3519A51psaefChp5EJ16R0C50r7v+ng5TW/Mr24wvulCrY0Yk+SSR2iHW/CAC5B9w09Wo/Xk1n1cBOZ1RXKEJNYdz6Gtlw5Jd+bubRaMZRxCWykh/IuhBp48B0TVTqjjZxVCZ+yEnALoOfe8wdoqPuhLomcKyYKPoZlTxh/0vimE4VeC8gPmXqsDo8eyXvuVQieamWHU3afQ7YWkkjm7YXSlIQPkiLQAdeFR9pw+blI84IhvsAj9iq5Vy1AhoP9ppDdYcH/8/yC4dH1yNBNLerQA3zTqryFJyrk4NYRwxLIua8+sSF8y/SzF1itXFWF4pcnmMNkDJNKTEY7tcp45DqXj4ilQ0404tEad6VUOlSjXrVOKCRNJ+iuctrW/gBku4FydnLepQTwI80HhBPUYnHf4GUCcAbjr3VTcpTslF4dAeyjfK6wRVJimK4OKqZ76OZ4yKzVj2E7afDlQWTfHn0fGB3B/SbH1G0pVDSPPGvcM1+ZIfuP1Eo8FDR4SlMkaqLe8L158EJmEuc0Equtw83diRhV4opfN4FJghDJJ3/fKpJggx33FAm0N+8o0AwQilFo7BeGShBCHY0uGfmybg5GrFwsuiWn8KV+ChopBq8W4yOdelR9agzYj1xLrcphpnKcvCGaks58r/v0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(2616005)(53546011)(6506007)(186003)(110136005)(2906002)(6512007)(86362001)(31696002)(316002)(6486002)(54906003)(558084003)(4326008)(41300700001)(8676002)(66946007)(66476007)(6666004)(66556008)(478600001)(36756003)(7416002)(31686004)(8936002)(5660300002)(66899012)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Nkbm5SRFR4eEd0WFdhOUc2YTA1VXlJcEwwaFB6TFI4dlBMK0o4cG54SXNO?=
 =?utf-8?B?NGhCOCtFRXorOEZHbUpscm9PQmpwb0NIM0ZHeFVOTkppQjA1QS8xTG1LaG9M?=
 =?utf-8?B?cDE2ZGJET0RvZ3NRYUZXb3dLYzhsNGlkandTMFdFTjA5MWt3MSt6bFNsL21D?=
 =?utf-8?B?STJMaTRvampVa1ZmRms1V2lSbExiQkpEWnNPSFl4WllZc3M2TXo0YVhUZ2ti?=
 =?utf-8?B?Qm14L1BaKys5M25WVCt1OWRzbUwzMENkd3VGRWtwZ3ZPeTdMcko1RnJZemZQ?=
 =?utf-8?B?NEgyQ1pTZlhvQ1BGQ3NYWWhUaEZoNWs2Wmw2S1RGWVVYS25LVEtxcUlXZHNu?=
 =?utf-8?B?RThOeXViM3hReCtIM0FHclRHV3N6N0ZZYVdiNkFJdXc2eFZpMnQ2RHlJWnY5?=
 =?utf-8?B?SFhZWW9Dek1lazdQdU9VZFA0TVdnTWl0RDFXczFVbW80ZWpHUlZVYVNZZHRI?=
 =?utf-8?B?TDMwS2I2cVVHYno0ZVFicEwyZ1dhZmxmWCtMb2J4MmxrM2J4U053RVlocFVU?=
 =?utf-8?B?MTVRMDR6NGZKN0lxc1AvMU52Nm5pTysxWDNsTkNMKzJMWmwzZ0htT29UcGx3?=
 =?utf-8?B?a0ZoMERrNnplOTAyUVdiVUEyRWE1bEFUMHdXdDV4a2g1dUVkcmlGUmRsZ3FD?=
 =?utf-8?B?Z1BockZRTnkwQmpodlJjcGhONjZhVnVHZmJ3eGVUWGlwQUlTVEV5SHRiT3VS?=
 =?utf-8?B?NVJmL3IvNVJzWkx6b2Y5S09MU2hDVStzcjR1MXk1S3FHelA0YTdURXphT0ph?=
 =?utf-8?B?WnlsYVVRWUR0ZE53NzdmVHdTbnBkVkV3NTJPRUxESlB1c1J0NTBpSFVyZTRo?=
 =?utf-8?B?S1FSN2NZRXkrbnFhSzBoYXJJK3RtUGxPSkx6Y0x6SmhGUm1QSkZydDJYRXNy?=
 =?utf-8?B?NXBuMFovMkJYZGY3dkpUWUtuV2I5VUVXd28rYmMwQnd4eC9YNlFkZTY5cmt0?=
 =?utf-8?B?cVNqcE5PdkZIZk40SHlGNVUxMHVFL1JFaFY1akdyYVplQndHT2ZVM3h4R1JL?=
 =?utf-8?B?cGVtWlVvN2NJNmlnbGdDR3pBV1ROQlFnalArQTRoeWhranNMOVE2M2o2Y2dE?=
 =?utf-8?B?Y2wvOTUxb3p6WWxFK2tsNG81dGtNNVk0OGh6VjFKL2d5ck43ajN2Y3JzQUxv?=
 =?utf-8?B?dDFXdnJieDI2aTdnNUQ4TGxXcXpiL2hwT0V2TCs5SmtRcEp2NGNSZkhhZEx1?=
 =?utf-8?B?OU8vdHhodi9NMU9EcFNCRmI0T1ZCeWd0U3lPN08vays4dUhmNFVCZ3loZnNP?=
 =?utf-8?B?UEljcmhsVnozaVBITkd1b3RxUU9zTFhNNzBCRGc3NERvM3NqR2tnL0NYTmR3?=
 =?utf-8?B?TmxVR1dXOGxkUU8xQmg1UHpBZFdyOGk0ZFlpTXo2emd6bnJQNC93bnp2OFVF?=
 =?utf-8?B?WDg4bThxR0R4eGIyY0VTR080OVdYZGhVaytLL2ZmK0V1SHRyNGNYb3hNVEpt?=
 =?utf-8?B?ZUtkQ0x3SnQzcUIwVEZpL1ErNE1MOVRsQ2FRZUo3WWpraDcrcDVFcEY1UU5R?=
 =?utf-8?B?VnoxSzF0Q2NrZXE2UXlGYkVXellnSFZ4N2JIUEloWnhkNEdSSVY4S0htbkgy?=
 =?utf-8?B?QWNPZjdXNWRRdG8rbUdWQjcvRFFZYWlmbVpOZkN0RTgrRFMvS3lybE5iS29i?=
 =?utf-8?B?U0RBMWtaZHVENzZ6MnArdWp2Nk5YOXQxdUlLVXhTUDc4cEhkOEV2UnVvK1B3?=
 =?utf-8?B?L1NSK2FGdVZVNWljL3NxWjVsVDUzZk9xaFZXZ3JIMlBlcmNnc3ZPMEhiQU9M?=
 =?utf-8?B?bE9zYVA3TTBOTWo2ZGw1dnI2eW1zVlI3ZXBNTkFEZE9ROFJ2Y0MxZE9nMTg5?=
 =?utf-8?B?Q0tzNGs2QnBsZUZCUjN3MVBGc2ZYWTR6Qi9KQmtweVpvY1E5em9saE5NNmdz?=
 =?utf-8?B?QmN4MTB0SVJ5S1I5c1YrREREZUVvQzgzOTRqOEZPRG9lUXpWVjQrdXRtRUFj?=
 =?utf-8?B?dWQzd1B1RndhdHNERDNwNk9PWGNQbFpndmo4YkNac1IzUFFwYVZ1QnhOZXdM?=
 =?utf-8?B?dmJ2RWZEanlneEQvRU8wNm1DWmJJWW40UVdKOGQvY3c4aXU5L2dpalIwTDBQ?=
 =?utf-8?B?dHJ5ZFI3UXZaMmo4bm1NNENNdld0c1gvZzBJQTNqOXVKQjJOaENValQvUTMz?=
 =?utf-8?Q?bHnrnYxDlUDQ3KzNB3Jy/VPcn?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18377ce9-8a1f-4595-77cf-08da9ab07088
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:33:02.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft10K8ldLNFCfYm2GLLh2aVdiFAOLrVfIEBdXg+r0fnsXAgU4PWH1uy/+DyLm+1g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4920
X-Proofpoint-ORIG-GUID: kE0v5KHB_aJDSMnjWWsxld8gLgERHvqJ
X-Proofpoint-GUID: kE0v5KHB_aJDSMnjWWsxld8gLgERHvqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/22 5:23 AM, Shmulik Ladkani wrote:
> This allows kernel code dealing with dynptrs obtain dynptr's available
> size and current (w. proper offset) data pointer.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
