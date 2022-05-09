Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3151F25C
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiEIBbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiEIAhf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:37:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7FB7FE
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:33:41 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2490AcS2004331;
        Sun, 8 May 2022 17:33:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hq30bOyma/KvYFRbqpSKGRPS4AXIHNdPkD9HW/C4zAY=;
 b=jIUYYKFW1udum1CLuYq1rmruMfw7EDCRbjLin5iS+JnBy09g8a9SuAOMiaIHAjxAVwei
 sQhvtuF07sR+j2O1PUcz6INw+d2vm6nAkvPydrmGg2ICCjH+nqm/neJOSB0QK/yyYCOQ
 hpmyzqo3B2UqIF8BjzyWBmwGteRNaouPgO8= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwr33dh1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 17:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8p7qQjefNNk1exy6gOAq9Dj2N0CNxMwUOR2Pdb6BP0bD0yE6c13y79X4Ubr5mtyzPM0rhKwVTCyuAXgihDdRkHA6FydPAv7L8UPqr5JY4iLqNvC1n69uMc4eFcGe16OhkPzmO6wkhA7pBURLKMrvHPxeJeoAGdo9qf+Zrx4MdGM+D//IRG0R440x2a68slIUsbsh9V7Vu6JNzv0f1NaLgOySlTLHpXGOdTDM4sAVzzqB9UYn2jzgnFpBYnDdhoNKvxiRVUAik0bmPfLz1eiwmDlsCXlk3V2FYK6tSjf6ZL84Jqn0cX+0MTrIsyVTD1ewLeLAFvj1uGl5wdcvvFh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq30bOyma/KvYFRbqpSKGRPS4AXIHNdPkD9HW/C4zAY=;
 b=ezTmj+Z07B7itCXO8pCl4QKaC/idRcVoH8aRQOhPDQ+HE7jV1c413ZUizjeS02y69A/yN887Ff8Fgj7zaeTFGnf5Oj3xVkTGXXo8iQSLV5GTr6wB5BUt9C8NBy6k9eZWsgM8BSBMkSXdHCA9Zq1p+KzWuKnCu974FwZ9N/dxGpzu27g6i7qgZfCXDN1kMQ74AuvUhZmEQzfJp0TuU39ZKzONEXyR4V8khccdUkDWPQPUT3ky2urVWDZQBR1NSYwcxGSOI8tCYhFLvP95h/j6h7hTOU0IdlNzvXspc479MgnL4XRlaRmswu/yv00AzNCQJ3JTdPtHa5jGPR0pTDKBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3894.namprd15.prod.outlook.com (2603:10b6:5:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 00:33:25 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 00:33:25 +0000
Message-ID: <87f15a70-7c89-a17e-957f-821f154e9ebd@fb.com>
Date:   Sun, 8 May 2022 20:33:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 01/12] bpf: Add btf enum64 support
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190007.2576808-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220501190007.2576808-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbafdac-77ee-4f08-3294-08da31538787
X-MS-TrafficTypeDiagnostic: DM6PR15MB3894:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB38940BDBF43D66CD664D037CA0C69@DM6PR15MB3894.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9ZD/z5cmRv+7fTLMn4ylxbpG/BomVINMqTOGBlFnXPcPU9sEXP9izEpj0kI8f8ZsI0PMsBVP+u0dD4B6/W38XK6/ihK1bJ1IrKSu1vS1J6qXKTl8UPRnNDGxDSo/hB6MUfEe6PLwjj0vjJAlHhLQXQMtkm6GdS8ArunS1jMoJihsJjJoao1ij50lj8W1OrfaMJSvei3D4wlDvUsdXf1Hjy8PdF3smhnp9bM7Jt6YRmll0lR0JclFYsnZjq3cWJCO1hkKfLeQoFGLtrk1RHK/ix8NpIpbYH2XLLbmWurXEb6KMa6Fkyz5HkzHfwK10GH6s+HFjxjleb7guiHc2o56BBsHaRckQ354SGsx1cfNKVTjaGO1Qlw41RNS6KZXHzeiRByu4t5f02v7kttwd8x3j7SBPzVRlJGdPsI9klfz9yUTFWUBbxEgk+SauWJqhWYliUuUz3TORItdnqOg39mDEuEyK+gsefHFEMooWaHLjdw4VJbtY+trJ8IO2qEk7/CVrhKFWgHEiQtUrUV4cY6TySkyQQY2shvX7TgJOpzsPKozQwidirNof32RcUuC7iSmD+/lUj2EQ+3cwpguq2/Z6uFxp0B0guVaJE8IeGClLAi81V+WUP5WT3hf5rQqpp7xcXTGid0z+3eJei35J0gIgiDMaIW/wchmr7fo/tM2IXgZ9NBBfGW/CshG4jzfz1+LBbiANqM7z6HYdDOdo2Mr1gsO4mKMEiQ0+I+LxQ15CsHPFxrb8g3xQ0JG6t63ry/il8j1i5Qt1jijbE58Cn5itzl/SWHJ6LgAD6FUxuJeKetrBwW3tfhn5eSoRyBFkzolWlMB7MCQ68LT8zqcWd67w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(83380400001)(6512007)(31686004)(5660300002)(36756003)(186003)(2616005)(2906002)(508600001)(8936002)(66556008)(31696002)(316002)(38100700002)(966005)(6486002)(66946007)(86362001)(4326008)(66476007)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRnRTM5WlNjc0xpc1lxQ051Y0dIUEtHNEQ2VTV2SFZwVXhNeGZKN3hmeS9i?=
 =?utf-8?B?TWEvazdnQVkwcTEyVFJDdm5NTGxjYUQvc0xraW5hbkx2TGpUbTl6QzVLbjFq?=
 =?utf-8?B?NE91STMxcnVLa2p3ckJXalh2R3dHSWpDcFYxc2V4NDMvVm1aSGx1TisrTEdi?=
 =?utf-8?B?U3lncGtLRWt0ZnhUcHRDcll4dUJpNEhoeTE2UW4rb21YdzVwNkZjLzBHQkNt?=
 =?utf-8?B?dUFHK0oxa3JqaGtvQnh1bzEzWkwzbi9tOFkxQWJlbzI5aEVSR09wcUdiU2Zh?=
 =?utf-8?B?bU1EUEZ5NGRJT20yOEo1cTBYckdSTVZvRWV4cVlkRVlKZDB2YXc2ZDkra21y?=
 =?utf-8?B?ZDhOZlYwYjgybGFFMXdrdE42OEtUbFFGK3VsR09vZ3pMUWRaRXZPeE81TGZR?=
 =?utf-8?B?NllOM3JheVBhVUoxeU5sd3Y5em5qclA2eHBBTUl4ZFlrc2NGaGV5QmtLaUIr?=
 =?utf-8?B?WGZIR0svQmpHYXM1Q3NTcFdDb0JYRWtWZDNFRHBuTUZmdlppVzYxaTMxNnh6?=
 =?utf-8?B?dENTbFV2K0FrQ29zaVBYQmkrQWdRcjcxNG5telY3TTJBaW9WaURCY0RBd0NB?=
 =?utf-8?B?QmFJc1MycHpPSFVYV1AzL2ovc3YzeGVqbW4vbC9LT2lFenVjcGNZeWJKaWF0?=
 =?utf-8?B?dk50eFdxbkJkQ3FIM0xLTVRMaTNVbmlrUDBNVWw2TnNKYll4TWZOdlQ4YjJo?=
 =?utf-8?B?R0VwNkNjdHp3QXluOG9oZElmSStxLzI4WGpSM1dNaVVrbFNFb0JIT2JyNkl0?=
 =?utf-8?B?MnVDS1VLTkZ4bkpKcmliaFNhZElPaTdvSk9NRW5uNHZGL2g0S1ZaY1dGaklB?=
 =?utf-8?B?WGJjeWo3VGZDWDMxOUdQOEpBZVRsNkN1clg3WG1yQWxqU1pKM1VsRWFUQzZs?=
 =?utf-8?B?RE5DZHRHQkVPbmJtWlFlS25xQzR0NlZoNlFvc3VCbTA5UHdId1FYOHZzY0VK?=
 =?utf-8?B?ZHQ1Yng0Y1BmM3J2RmVsWjluY2ZaeUNKd1JJdnZkV2dmVVJSdDlwd1lPb1lL?=
 =?utf-8?B?dU45dnhQQngwV2NkQ3IwMXd0eERGQ3I1L1V3NFV2T2o0ekFkZ0U2N25CQ0JD?=
 =?utf-8?B?TzMwTXpiTE9kYlJoZTdxMFZKcm5QdmRKVFNEbmk5aUhReEl4eUNFZFZ5eGVV?=
 =?utf-8?B?S29tTFlDbVhWcHRkVWZPcTkvVHZtSEhmL3BXS0xNSlV5UWs4ejI1aFNDQTR6?=
 =?utf-8?B?Wmp4T2JJdUpmVFMveTdHTFZ1bGxCNTJ1UVBRT1JvV3JnWkd5ZTkrcURhR0Rn?=
 =?utf-8?B?aTNRdVNlc0lnR0dIZStqRjl0MzFrdmVtV0Nnc2RsMDBwMS9aSDZxWmtoYnh5?=
 =?utf-8?B?SU0xWm5CTExEdmpEVElSWk1acEV3MnpBWXZuQVhaZlg4L1FlWXJQZGpGVGRJ?=
 =?utf-8?B?RENHUGltamdXeFBtdDBIbDB2eGdQTnpQa0U1NmZEUnllNjM1N0ZHenhVWDg5?=
 =?utf-8?B?akFRdzFVTEh5VXpzVVh5RG1uQmE5N0J3ZkVlZjZwUDJ3TlBlMzUwR0RNY3g0?=
 =?utf-8?B?U0xML1Z0NVVVL3d3MFNqYXQ5ZmZBY05PRXNURnFVRWZBSU1YME5nd1NKaGY1?=
 =?utf-8?B?MW1rNnpOWUdxdjdnRjZYNHpmY1hPbVFDdDk1eUI2ektjSnBGRjlQWWM0cW5I?=
 =?utf-8?B?emdEcW5vS1ZzNXdJRW1sbHFqd1p0Vk9MaklYR2IxQUNYSWExV25lWU5VUXpK?=
 =?utf-8?B?K3k3VTh2KytmbHpmRkhJd2YvY1pJMHliMTlDejZrOFM4aGQ5TTN1V2dZVDNB?=
 =?utf-8?B?dHdLNWUrc3VUS2VEaXhzUS9HSXR6MWk2dDllcVBzd3RFaTZyUFN5M3RZUFQr?=
 =?utf-8?B?eEpaYXVPMHlIY2dRYkhSc2JJbnM1THVuT1lIUk1GQnQrYURLclh4YUlnbE5Q?=
 =?utf-8?B?TWtKNm1uenVrYm8yQTVvRzlDRy9hcURCR01mQ3UzblZ4b25CdUZSVUtNbHcw?=
 =?utf-8?B?dkxvYkxlMGdtR01Xb2g5YWliSkRjYy94RWVDc0VvSFIxM09wc1l2aTRGMzg4?=
 =?utf-8?B?ZUlaeWd0T0FxTDZuWDlwNHgxNlVudytxb0RYMTArSFVJbm5QZ2x1dGJYbmw3?=
 =?utf-8?B?QjJtbTc3RENNNi9seGQ3OVNCVmpnMitBdUloWllIRUN1WnZLRjgxcEdjVnhC?=
 =?utf-8?B?a0ZlWVRSc095Mm41TjhBK0ZVbFVjZVRvek9KNGoyQkFsdDU5a3I5QjhmelFM?=
 =?utf-8?B?MlBjU1ZMYnIwRnkvUC85K3EzL2w1aGpzZWlZbG44ZzFLcC9kVFdLbGVoV2tZ?=
 =?utf-8?B?ekFuZnZYSDFzQkVGRkF1aGFtSXZVQ1BCMEYzRUlCNDZodHQrQ2dLV3o3dk5W?=
 =?utf-8?B?Q25JM01tUDByemlwWnFnRWlWQTRvbkQ5dEZvNTVwRkQ5OHowMFAvWjNoR1Zi?=
 =?utf-8?Q?yKhg7OTwqfylGf9VxM1oMaRrhX0IRjkiFt43s?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbafdac-77ee-4f08-3294-08da31538787
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 00:33:25.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU1qVcfe5lpSYbHyVEkPK96kjz1VL9HlMUUpjnhJ2GEIojs+ulyBiaIDgYKLaUH+Ba3xmEsTzHBtQ75ny8wv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3894
X-Proofpoint-ORIG-GUID: OoSNNGKt0UQ_5MxqPLdcVKysXZcb6zNG
X-Proofpoint-GUID: OoSNNGKt0UQ_5MxqPLdcVKysXZcb6zNG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/22 3:00 PM, Yonghong Song wrote:   
> Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
> But in kernel, some enum indeed has 64bit values, e.g.,
> in uapi bpf.h, we have
>   enum {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   };
> In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
> as 0, which certainly is incorrect.
> 
> This patch added a new btf kind, BTF_KIND_ENUM64, which permits
> 64bit value to cover the above use case. The BTF_KIND_ENUM64 has
> the following three bytes followed by the common type:
>   struct bpf_enum64 {
>     __u32 nume_off;
>     __u32 hi32;
>     __u32 lo32;
>   };
> Currently, btf type section has an alignment of 4 as all element types
> are u32. Representing the value with __u64 will introduce a pad
> for bpf_enum64 and may also introduce misalignment for the 64bit value.
> Hence, two members of hi32 and lo32 are chosen to avoid these issues.
> 
> The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
> to indicate whether the value is signed or unsigned. The kflag intends
> to provide consistent output of BTF C fortmat with the original
> source code. For example, the original BTF_KIND_ENUM bit value is 0xffffffff.
> The format C has two choices, print out 0xffffffff or -1 and current libbpf
> prints out as unsigned value. But if the signedness is preserved in btf,
> the value can be printed the same as the original source code.
> 
> The new BTF_KIND_ENUM64 is intended to support the enum value represented as
> 64bit value. But it can represent all BTF_KIND_ENUM values as well.
> The value size of BTF_KIND_ENUM64 is encoded to 8 to represent its intent.
> The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the value has
> to be represented with 64 bits.
> 
>   [1] https://reviews.llvm.org/D124641
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/btf.h            |  18 ++++-
>  include/uapi/linux/btf.h       |  17 ++++-
>  kernel/bpf/btf.c               | 132 ++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/btf.h |  17 ++++-
>  4 files changed, 168 insertions(+), 16 deletions(-)

[...]

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index a9162a6c0284..2aac226a27b2 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -36,10 +36,10 @@ struct btf_type {
>  	 * bits 24-28: kind (e.g. int, ptr, array...etc)
>  	 * bits 29-30: unused
>  	 * bit     31: kind_flag, currently used by
> -	 *             struct, union and fwd
> +	 *             struct, union, enum, fwd and enum64
>  	 */
>  	__u32 info;
> -	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
> +	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
>  	 * "size" tells the size of the type it is describing.
>  	 *
>  	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> @@ -63,7 +63,7 @@ enum {
>  	BTF_KIND_ARRAY		= 3,	/* Array	*/
>  	BTF_KIND_STRUCT		= 4,	/* Struct	*/
>  	BTF_KIND_UNION		= 5,	/* Union	*/
> -	BTF_KIND_ENUM		= 6,	/* Enumeration	*/
> +	BTF_KIND_ENUM		= 6,	/* Enumeration for int/unsigned int values */

nit: Maybe it would be more clear to say something like "Enumeration
representable in <= 32 bits", and something similar for ENUM64? This applies to
docs/bpf patch as well. I don't feel strongly about it.

>  	BTF_KIND_FWD		= 7,	/* Forward	*/
>  	BTF_KIND_TYPEDEF	= 8,	/* Typedef	*/
>  	BTF_KIND_VOLATILE	= 9,	/* Volatile	*/
> @@ -76,6 +76,7 @@ enum {
>  	BTF_KIND_FLOAT		= 16,	/* Floating point	*/
>  	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
>  	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
> +	BTF_KIND_ENUM64		= 19,	/* Enumeration for long/unsigned long values */
>  
>  	NR_BTF_KINDS,
>  	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
> @@ -186,4 +187,14 @@ struct btf_decl_tag {
>         __s32   component_idx;
>  };

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2f0b0440131c..17e24b362d3d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -307,6 +307,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_FLOAT]	= "FLOAT",
>  	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
>  	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
> +	[BTF_KIND_ENUM64]	= "ENUM64",
>  };
>  
>  const char *btf_type_str(const struct btf_type *t)
> @@ -664,6 +665,7 @@ static bool btf_type_has_size(const struct btf_type *t)
>  	case BTF_KIND_ENUM:
>  	case BTF_KIND_DATASEC:
>  	case BTF_KIND_FLOAT:
> +	case BTF_KIND_ENUM64:
>  		return true;
>  	}
>  

[...]

> @@ -1832,6 +1840,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>  		case BTF_KIND_UNION:
>  		case BTF_KIND_ENUM:
>  		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM64:
>  			size = type->size;
>  			goto resolved;

Is it possible to replace this check w/ btf_type_has_size that you also updated?
Looks like case's match, aside from BTF_KIND_DATASEC.
