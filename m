Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1EB63F6D8
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiLARvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 12:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiLARvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 12:51:02 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D126104
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 09:47:45 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1GXq5v029720;
        Thu, 1 Dec 2022 09:47:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7Wielzc2IiNUjyT4XeL5AWoSt0V3l8HFADxc2zxcpGs=;
 b=E6ZjXctqj3+/pBXGldpb5OVpfsTVFSBkgxJ9LCTf+Ih5SEG1w+l2dv7fMORJZXgETfOy
 FB/8PqGv6EJLaxsx7DOAEP8qg2/SuWS8SuUG/zbLlM4ULxZoUQs+mt5a9qZrzgQ4UhDC
 T1QFKvmcFbMtBR4VE6W4ATMKZKtkkX4pl9kaQC4aYP1AJgzT4niu4GTfX07m6MKorkKg
 I7bYhmQwPl/6liIYcd9Zzl8rSUk5DP1DWuGF+B2Ty2lTmsHdxbj7jLxVC2oKe6MsDymH
 wOx57FHDcqG1IgL+hgEe0qobxI9rXyZqfnHGnMxpmZU9m9VVQnHp+pj29/A/kY2PenXH mw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6vrutem7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 09:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PehK1cF4zKp6hwFpGdnCVTqmo5gcQduWDzte0A2iY8ur37E/H8AwhUSSvem6ol0k5Yi74EyA1BcVJd+j76V3ldgPLyMdTDZNothPFJBZUNaJMHHI2ATyrS/jjcG62rp3v+Ff0Sko+I7zwrrVn+NVHAdCRBslfGW3NeR1/G2xSzX1gk/hO94Uk2LHN+nN125UdWBtB2U27qyQpo8MTb7jDO+PG6KfXFmwSCyuV+p/UNJ6eh3fw8X/Namc61PYgHmKNsnkUljh/uLNyE7TXdZ5TecIKeng0bKC5ZSXvOp8AgII2M36wBF+vuTM5Cge9QOCmIiHONXlxfHhMuFDuYDAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Wielzc2IiNUjyT4XeL5AWoSt0V3l8HFADxc2zxcpGs=;
 b=MZDYNgerRoYguZtQ6RgaW7eh1fZ6DwS+idUTbFta0EDjQAjYlOjdHoVevViaUPG82e6mZBdeLbWYh81ABMvnjKwZl/sm7BgqR+cCVuRHNb0NlZc4SJKXcVfnDrTm9MRjKjPdVYIVBsaBxEKGjZRN426iBYMh8ux89tih7GDfw+vjUZ7O/DHPVTFkTT7vzcEZqjZbU4SdQ4dAyf0nKay47N9X73zjdjjAfom37PGtCOmO5Tw93/i9rrVMY2RkenrvE8/Cmscfd9AyKNWs7sGiGnOkwzoU6LAY+STlAZtU/CI6Y22niLNZEXZ3b+3dERsjUsLIdWaRKiefpH+ru/uPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by SA1PR15MB4739.namprd15.prod.outlook.com (2603:10b6:806:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 1 Dec
 2022 17:47:25 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::ee4e:4b1a:9220:2c46]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::ee4e:4b1a:9220:2c46%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 17:47:25 +0000
Message-ID: <1a534022-5629-8f98-c8ad-f1c335652af5@meta.com>
Date:   Thu, 1 Dec 2022 09:47:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221129023713.2216451-1-yhs@fb.com>
 <d46efd51-e6f5-dbb5-ab38-238b6d2ea314@linux.dev>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d46efd51-e6f5-dbb5-ab38-238b6d2ea314@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|SA1PR15MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c206c1-4085-4dcc-a8e0-08dad3c41b32
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCjTSR0IbNL4cIH4KiJId4roFxrf4+SIIwdp07gfijEebF6uCSWjiMIZgHMBW6fEHbyRpVAaGS20E093xRu9Bw7oZDb8HrBYWkCPH1SedNdhKNu3/Gfnq8ofIO8hcYhlwsF6cdKlC1DaX8JEeyMMPA0hcyVCMLI2MvI00AIQ6srGqdxIhfj0k5BnMRFCH4oN/g6Z6NVv97/e9ixc+aFXldvaRWHekBoRUDu4pliZFrC0f/JIVFdLQISSdJbuw+QRhidCWQcNMUxau0b+G6GZpGkkaREur8FzhFyc5e20s9AB8InwzcJti4TQ8K4CPaeWxWHCzN1uRcUNnAgNWpqggDaRnOs5ReuvIxks+hp58MtONLkby5G/HtTSy38xsoojgPiI1uImqCcqIbYrrsx4oGADKUAmlv385GFN0CXzvuCDERJEURaz369wnG+U5SHrOn08LFhi8yjB9GaIh6htBgCMagbg+/rZjFhlfVG5oL8/XswKh2ylrtz2SS9/xLRd9XLDfUY9bfZ4QDXxxP3EK13L5YMhtLnew9T9ET5WssQcl8vx3TgcyUQHq/mW8OO5eDUqbj3dOpTBh58lfKCJ1lktMzSrsio83bWvHrPBygA842++nEXaAIcfj37Te2zoL9ci98UGYruYUbZWS6ADhynoCMykr2Vprgtp+B7DfyjeSzEAxyNQ5ppY8B71WkIlAH22AyE3c4nYEBLnkY0ODuc8/sFEBp7CGVCS0E/ZX3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(186003)(31696002)(86362001)(53546011)(4326008)(6506007)(6666004)(66476007)(8936002)(6512007)(8676002)(66556008)(2616005)(478600001)(6486002)(316002)(110136005)(5660300002)(38100700002)(41300700001)(31686004)(2906002)(66946007)(83380400001)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlcrRTBUS01leEY1a0FaTm12eEFxQ3J0SjZGR1hZcGZneFNzZURWWE14MFdS?=
 =?utf-8?B?eEpuUDZmZ0xMbEZWcWdXKy80ZHBRNkdDeUQ2NmhwVTgxSTZSVnVyMVhJaFFT?=
 =?utf-8?B?SXp2YkhBQVhHa3RjUkJOa25tTkRJa296dElLVTh2NDNuV2pNd0NyblhOWmtj?=
 =?utf-8?B?MlM2K20zWEhIaEpYKzFvaVphNkR2aW84TnM2M0VzRFhObFlsK3BoVkhzWWVk?=
 =?utf-8?B?dktEaU9CdWJXWHlmVUk3dmdxZDVGcGVqKy9ZMC9nYVNNSnhRUDZ0MUxsK0tR?=
 =?utf-8?B?TzZPSGNSSkJ6VW5Ob3lIS1drWVA5ZnNyZUwyenJmT1kvbldtdk5kRmp6b2E2?=
 =?utf-8?B?VUhKaWVxRHdZdXljM2xYMFprZHFWekhMSytScjVzcXBqdk5aL1F5VzRldkJu?=
 =?utf-8?B?Rm1mNU15VFB0b1oyb0hKU2h1SGx1TW9YT2theW1SSVRkMDVxbGRFZUxobHNy?=
 =?utf-8?B?d1JTNnRubG9VZnI4d09ROTVQVisrNURrM0E0NkRyamc2N24xc0IwbUdSc0tu?=
 =?utf-8?B?c1BBcXhNdUxkZ2tWM3FDNmR1SVgyWG9GOGpHQWNBNEptMFRsL1FqVzZIR2ZS?=
 =?utf-8?B?b3hmNUxMcERkanBJRzQvYTJYc3pKcjBNUVpzMGtTMVJYRjBOcHBsRG5hblpz?=
 =?utf-8?B?YTNINnloTGFDTDd5RU5FWWdxMXR3VmVkWGZQbS82NytmQm1yNlNjZzgzVnU5?=
 =?utf-8?B?cnI1N0t3emprMDBXNFlnOG9vMTdYS3ZHamFjMW13R1dUZy92MmFCQXlPRVBj?=
 =?utf-8?B?KzdwQUVuYjV1bEVnejYzUEFMeG9XYzBUdzhwc0FpSUhNTjBKd00waTBpbHc2?=
 =?utf-8?B?Y3BCdE1jMitaZzJIQVhNSkZiMjh4RnE2QWFuR2ltSUNpOHAwd0s3UzZNSFZE?=
 =?utf-8?B?T3VvZVRwVHBnRFBZbnluTG5tL0JYMXp6UGpTOHhrZUJadUo1N3NQb2E4RkJB?=
 =?utf-8?B?VFRkeWdmOUJ1YWRCK2FmWnlZOUUzeUdmMS94SGROUXNuekxtT2ExcCtaZGhh?=
 =?utf-8?B?dUp5Tk1oTWptS2hwS2MwdWU2ZU9keEdvUVdjTjM4MW8wc093ejFuRTdwdXpw?=
 =?utf-8?B?aWdreXcvaGpjOWU0bWZXeXBFQzBXNmM4OVhKM2M2NjRtdlN4UWI0WG5PeUFP?=
 =?utf-8?B?eCtwSlA4R1NKbXNsaEZjcm9URmdyYlJLMWZReXJsSE5PTTVIdkZCZFJpVWRq?=
 =?utf-8?B?a3ZQWHdtWklwUmx2SFNBdGlnUy9uR1lMU1dRWEtFQldBeU1LbndIeEhERGVL?=
 =?utf-8?B?Njc0RGFSOTVLM3NKdmt4My9HNkI5YldEVkloQ3g2MlJGT0hGVytHb1AvVjR3?=
 =?utf-8?B?MWVBTkxzZHRGSnR4L2tNT1laVEpNRXEvQTJCbVZsdGw2dmcvOUlWQm9FRGxV?=
 =?utf-8?B?MERiQ05BV0VVZ0VhenJ3bVVTVVF0MVFYNEl4RSt4T2xldXJVYzlNbThxUUhV?=
 =?utf-8?B?Z2RvakJGK2FFbWF3T0NIK0tQVWdHT1d1dHdSV1RPU2NZcHZrM05CU2l5YnEv?=
 =?utf-8?B?dkQ0cC8vQ1c2L3ptdW9yd1FkNnl5NnZPYlV3Tk1mWFN1bUd2VFJwOTVadmJy?=
 =?utf-8?B?bCtseUtVeVBPejdJdFQ2c25oZ3puUFFDT1lkbXZFakdyaWVhMmkzZTFuVzBV?=
 =?utf-8?B?L0NhUzJ3TUdGeVlnU3hKbm5KejBycC9reGY5dVNvc0NMbjIvdzVyaSt0Q21m?=
 =?utf-8?B?bGM4Q1hicDJtdXgrWWNJUXR2LzcrcTNTRzYvZEdTNWhQUW9WY1hnNmVEOHU0?=
 =?utf-8?B?aE1lQll0bzkrYkdQcUs3Q2d6V2kvbjJmTnFVMFBjZi84Y3ZEUzBmVEpIKytS?=
 =?utf-8?B?dGlCeGptWk9NemZpYUNUUndrZWNlVXhyRmRxanZheVIrMVNEUHhYUmNqUGNE?=
 =?utf-8?B?bGZQQ2xLUG1QTDY5SXUxR0pIRUY1VDJVbmhHMVltQnk4Vm8zS2tPWVpCTDRG?=
 =?utf-8?B?cGFMRkcrUjRtaWcveTF1dlgxQkI0Nk5TUVluTU5PcGtDQjRsQ2ZYRGpTeFZi?=
 =?utf-8?B?TEU2UDllSnpEYkhhUTkwWkxwQ0ZrS3VTb1d3UVVnUmhyMUFNQVBCNmFMZnlZ?=
 =?utf-8?B?VkQ4N3JqaTJBR2JaQmpLYzBPT1F0ZE4xL2IzdUtFdlFseS9Nd0FjYzJVMCtr?=
 =?utf-8?B?eTYrU0tMUElvajBkYVg2Vk9KZTIrVDIrZ3VKK29uQTlLU1lHKzhqS0JiS2ZZ?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c206c1-4085-4dcc-a8e0-08dad3c41b32
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:47:25.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGdhRMpFY2Lrh6AF4Gj1YG7AoZCqwqgWnPV5vqqzkJmf+5ewhC0W+ve1AD9rpBw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4739
X-Proofpoint-GUID: rGJ4DatPLGrpS39PbAWdHVhLhjMA-RBo
X-Proofpoint-ORIG-GUID: rGJ4DatPLGrpS39PbAWdHVhLhjMA-RBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/30/22 11:05 PM, Martin KaFai Lau wrote:
> On 11/28/22 6:37 PM, Yonghong Song wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index c05aa6e1f6f5..6f192dd9025e 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const 
>> struct bpf_prog *prog)
>>       }
>>   }
>> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
>> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
> 
> [ ... ]
> 
>> +static bool is_rcu_reg(const struct bpf_reg_state *reg)
>> +{
>> +    return reg->type & MEM_RCU;
>> +}
>> +
>>   static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
>>                      const struct bpf_reg_state *reg,
>>                      int off, int size, bool strict)
>> @@ -4775,12 +4780,10 @@ static int check_ptr_to_btf_access(struct 
>> bpf_verifier_env *env,
>>           /* Mark value register as MEM_RCU only if it is protected by
>>            * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
>>            * itself can already indicate trustedness inside the rcu
>> -         * read lock region. Also mark it as PTR_TRUSTED.
>> +         * read lock region.
>>            */
>>           if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
>>               flag &= ~MEM_RCU;
> 
> How about dereferencing a PTR_TO_BTF_ID | MEM_RCU, like:
> 
>      /* parent: PTR_TO_BTF_ID | MEM_RCU */
>      parent = current->real_parent;
>      /* gparent: PTR_TO_BTF_ID */
>      gparent = parent->real_parent;
> 
> Should "gparent" have MEM_RCU also?

Currently, no. We have logic in the code like

         if (flag & MEM_RCU) {
                 /* Mark value register as MEM_RCU only if it is 
protected by
                  * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
                  * itself can already indicate trustedness inside the rcu
                  * read lock region.
                  */
                 if (!env->cur_state->active_rcu_lock || 
!is_trusted_reg(reg))
                         flag &= ~MEM_RCU;
         }

Since 'parent' is not trusted, so it will not be marked as MEM_RCU.
It can be marked as MEM_RCU if we do (based on the current patch)

	parent = current->real_parent;
	parent2 = bpf_task_acquire_rcu(parent);
	if (!parent2) goto out;
	gparent = parent2->real_parent;

Now gparent will be marked as MEM_RCU.

> 
> Also, should PTR_MAYBE_NULL be added to "parent"?

I think we might need to do this. Although from kernel code,
task->real_parent, current->cgroups seem not NULL. But for sure
there are cases where the rcu ptr could be NULL. This might
be conservative for some cases, and if it is absolutely
performance critical, we later could tag related __rcu member
with btf_decl_tag to indicate its non-null status.

> 
>> -        else
>> -            flag |= PTR_TRUSTED;
>>       } else if (reg->type & MEM_RCU) {
>>           /* ptr (reg) is marked as MEM_RCU, but the struct field is 
>> not tagged
>>            * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
>> @@ -5945,7 +5948,7 @@ static const struct bpf_reg_types btf_ptr_types = {
>>       .types = {
>>           PTR_TO_BTF_ID,
>>           PTR_TO_BTF_ID | PTR_TRUSTED,
>> -        PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
>> +        PTR_TO_BTF_ID | MEM_RCU,
>>       },
>>   };
>>   static const struct bpf_reg_types percpu_btf_ptr_types = {
>> @@ -6124,7 +6127,7 @@ int check_func_arg_reg_off(struct 
>> bpf_verifier_env *env,
>>       case PTR_TO_BTF_ID:
>>       case PTR_TO_BTF_ID | MEM_ALLOC:
>>       case PTR_TO_BTF_ID | PTR_TRUSTED:
>> -    case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
>> +    case PTR_TO_BTF_ID | MEM_RCU:
>>       case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>>           /* When referenced PTR_TO_BTF_ID is passed to release function,
>>            * it's fixed offset must be 0.    In the other cases, fixed 
>> offset
>> @@ -8022,6 +8025,11 @@ static bool is_kfunc_destructive(struct 
>> bpf_kfunc_call_arg_meta *meta)
>>       return meta->kfunc_flags & KF_DESTRUCTIVE;
>>   }
>> +static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +    return meta->kfunc_flags & KF_RCU;
>> +}
>> +
>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta 
>> *meta, int arg)
>>   {
>>       return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>> @@ -8706,13 +8714,19 @@ static int check_kfunc_args(struct 
>> bpf_verifier_env *env, struct bpf_kfunc_call_
>>           switch (kf_arg_type) {
>>           case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>>           case KF_ARG_PTR_TO_BTF_ID:
>> -            if (!is_kfunc_trusted_args(meta))
>> +            if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
>>                   break;
>> -            if (!is_trusted_reg(reg)) {
>> -                verbose(env, "R%d must be referenced or trusted\n", 
>> regno);
>> +            if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
>> +                verbose(env, "R%d must be referenced, trusted or 
>> rcu\n", regno);
>>                   return -EINVAL;
>>               }
>> +
>> +            if (is_kfunc_rcu(meta) != is_rcu_reg(reg)) {
> 
> I think is_trusted_reg(reg) should also be acceptable to 
> bpf_task_acquire_rcu().

Yes, good point. trusted is a super set of rcu.

> 
> nit. bpf_task_acquire_not_zero() may be a better kfunc name.

Will use this one.

> 
>> +                verbose(env, "R%d does not match kf arg rcu 
>> tagging\n", regno);
>> +                return -EINVAL;
>> +            }
>> +
>>               fallthrough;
>>           case KF_ARG_PTR_TO_CTX:
>>               /* Trusted arguments have the same offset checks as 
>> release arguments */
>> @@ -8823,7 +8837,7 @@ static int check_kfunc_args(struct 
>> bpf_verifier_env *env, struct bpf_kfunc_call_
>>           case KF_ARG_PTR_TO_BTF_ID:
>>               /* Only base_type is checked, further checks are done 
>> here */
>>               if ((base_type(reg->type) != PTR_TO_BTF_ID ||
>> -                 bpf_type_has_unsafe_modifiers(reg->type)) &&
>> +                 (bpf_type_has_unsafe_modifiers(reg->type) && 
>> !is_rcu_reg(reg))) &&
>>                   !reg2btf_ids[base_type(reg->type)]) {
>>                   verbose(env, "arg#%d is %s ", i, reg_type_str(env, 
>> reg->type));
>>                   verbose(env, "expected %s or socket\n",
>> @@ -8938,7 +8952,7 @@ static int check_kfunc_call(struct 
>> bpf_verifier_env *env, struct bpf_insn *insn,
>>           } else if (rcu_unlock) {
>>               bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>>                   if (reg->type & MEM_RCU) {
>> -                    reg->type &= ~(MEM_RCU | PTR_TRUSTED);
>> +                    reg->type &= ~MEM_RCU;
>>                       reg->type |= PTR_UNTRUSTED;
>>                   }
>>               }));
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c 
>> b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>> index 973f0c5af965..5fbd9edd2c4c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>> @@ -93,10 +93,10 @@ static struct {
>>       const char *prog_name;
>>       const char *expected_err_msg;
>>   } failure_tests[] = {
>> -    {"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or 
>> trusted"},
>> +    {"cgrp_kfunc_acquire_untrusted", "R1 must be referenced, trusted 
>> or rcu"},
>>       {"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must 
>> point"},
>>       {"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported 
>> for arg#0 function"},
>> -    {"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or 
>> trusted"},
>> +    {"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced, 
>> trusted or rcu"},
>>       {"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup 
>> must point"},
>>       {"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
>>       {"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map 
>> value"},
>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c 
>> b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>> index ffd8ef4303c8..80708c073de6 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>> @@ -87,10 +87,10 @@ static struct {
>>       const char *prog_name;
>>       const char *expected_err_msg;
>>   } failure_tests[] = {
>> -    {"task_kfunc_acquire_untrusted", "R1 must be referenced or 
>> trusted"},
>> +    {"task_kfunc_acquire_untrusted", "R1 must be referenced, trusted 
>> or rcu"},
>>       {"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct 
>> must point"},
>>       {"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported 
>> for arg#0 function"},
>> -    {"task_kfunc_acquire_trusted_walked", "R1 must be referenced or 
>> trusted"},
>> +    {"task_kfunc_acquire_trusted_walked", "R1 must be referenced, 
>> trusted or rcu"},
> 
> hmm... why this description is changed here?  The bpf_task_acquire 
> kfunc-flags has not changed.

This is due to my code change below.

-                       if (!is_trusted_reg(reg)) {
-                               verbose(env, "R%d must be referenced or 
trusted\n", regno);
+                       if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
+                               verbose(env, "R%d must be referenced, 
trusted or rcu\n", regno);
                                 return -EINVAL;
                         }

I will change code differently to avoid verifier log change.
