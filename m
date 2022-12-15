Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53664E4BE
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 00:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOXio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 18:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOXil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 18:38:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9E4B982
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 15:38:40 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFJ0PLC025503;
        Thu, 15 Dec 2022 15:38:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6/ZO417rnnIFlIWW95uMnP4pKR2fe/CK5KmDzc9vEP4=;
 b=UVrG08169rU2oMUdlwM/Bu0IDEULxi9RIrESjxotVnpdXrfwAvAuEgR145Pc8eUhKUVu
 DaKW9ooNTDiPWpTpp6/J7PWhUw5ECLSkAEJiK8wmU4j5txFWvCCJp3MEenpJ44TmH8uz
 9f0iocL2+vjFKPNap6PoKFDmGl5SVS/d3F7gtHBPh3+BxR5Mpa5/UzWNLPoVg9vuv32/
 EqRZfj8FO0YV8gNYpOJPenAHjZFmpeDdMlPrhhDWiho9kxFQyDqcxxz6/P0Oh1SIuzn1
 RgCJghBzq6OybIjT/bdP+UVrMJ6W5Rs8Aj5VfTz3hnBZvkGPER+/VF+8p5kgbYPv4Bfc +Q== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mfux90064-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:38:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr/YS04+7kyQ7xtsWP1ltjGhmrwzhD/oIHEoqMoNThEhQ4Abm7o/db8l3g7V/svWsBdAMF6oTko4a9kTqiZitpHtzcOt8ep0op7HofoM+cHz+81c8YJczDc7OsK3ScMJ+74VUeHXTUrXm30iGV23lEUNiSO6pi6SA3UKS0+eqJk06pNnBVZLeWdDQ2aCY2q4aqQNtcGQeK9K+NhgKEFJIHjd4Vfb3/5LceXD8Tk4CFQr3n+3b29FlTZWHRIg+Thc7WPWQOY1mh6KMfbtSxbABmxwVijkAsNKKy8zhu7IjtRUIwaBxbS8qYCEvSP69gohcYYFza89sim227xxPcou2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/ZO417rnnIFlIWW95uMnP4pKR2fe/CK5KmDzc9vEP4=;
 b=YULabk+achyELzG3THD9m14hCS/kJTDUoxIgnboP25lbWu8+pP2SHEhv69CLQ7/1InigbdsHuZ6l+dgT9yycCEpFC17uo19AOSatEpf8uWgUwuMk4I5CgWTT8194sJUq3x66Tm8edOuZVLlJrFiCOz2VS/R8Y1BSLecsFbNH8lBfZNtLVoF/76HIT38196mBzmewkUWl8R8xE6Lv7ElgB19XyaMcktVaeEq2WkgEpL3xXdcJoTYTei44eBVPdzmffQDpY95YIJ5g4Wn0yVT3HvggPnsHyhKhJaws0tRmn1JA9oYHH0XpsQve9bqvhB1ZpW+mgvYZCIX/rhO2mOZL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1160.namprd15.prod.outlook.com (2603:10b6:903:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 23:38:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 23:38:21 +0000
Message-ID: <2a558ee1-e86a-6cc8-1d03-26dc81980ec8@meta.com>
Date:   Thu, 15 Dec 2022 15:38:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: Improve PROBE_MEM runtime load
 check
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20221213182726.325137-1-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221213182726.325137-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1160:EE_
X-MS-Office365-Filtering-Correlation-Id: 98537361-0336-47e3-065d-08dadef57303
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrT34E00gWczZ8nESGGspzKyNg2cwjVwrKwwEePVEk28lWeoJYH908iM801M1stkMr0SeWLtx1dnpXr4Xzs5ZC27xO+ba3ab+s4TDJfLxPDjxGvGVD2EjUnWTrEn2Gq5q8CXg95fxgNnZJk+NVhivvIK9OggW/r6PENVQfvF84f2Nc0xAAG6xuKyXFH4Lc5UeleK8N9T/KEEuMeDub/PZPSqKjO8NTPjDblMFkAZ1uGOYiiCEFVU61OcRuxH89kuBfRHNbkGLMZew7OhfTUWSoEXXybiTfCJoLRaJSJ+oRsMd3sIN3A53COfxQ9lW8RLtxTp7He5HM+u3DesX7UY1KLzpYtQskf/2f/e9cN/wI9c4V6/UjToC6w4G0cVH1cDW/4uI4whHKYD9HQ8lufwmDocP+JraiTG47kdiAlFYX+JK6m43L3MlWaYmHOD7hJrZb2RSvg9i1cpjrRCukYxrVEzcbhu1mZNraIUDmlji+QkwW+t8G+pNvH34cwOzc0ib2cZHtRPqQzm1UrTRHkStaVIA0LmLhIMpSm7UthqwHHm+93jZTR1VZHMxjlEopiUZzTNzunF8gHCGg5TAkV0450e+TyeKMUG3NDbFoAEkNTSGmXosClHroEuo2A/RBJCUEVbXqJ8gmR5t1MxAY2SOy1TANrXvna0ewSHqUeNH9iqReeyWV7mdDW1jV3MIZ+NPzIP5ToX0OXf8Rif+gjy/Kw3p3KiQtuwdD02LNlyyGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(41300700001)(478600001)(8936002)(2616005)(6666004)(8676002)(36756003)(53546011)(6512007)(6506007)(4326008)(6486002)(54906003)(31696002)(316002)(86362001)(38100700002)(66556008)(66476007)(66946007)(186003)(2906002)(5660300002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlFak1lbk8wbzVTb2loc2lyNE91bnV6TGhYQWtEOXgvU2piY3E5M3lNZUM5?=
 =?utf-8?B?NEY1WTNaUXJnZ2hSeHk5MjltZ0dzdzZLWTE1Wkx2MU9FWW1nRjl4aHdydDVE?=
 =?utf-8?B?dmtUUmRNOUFaWmJZOUpvanRKeWQvazNrOE1ZLzFpbW9XbHYvcElrMVB1UURL?=
 =?utf-8?B?SG10Wk5aTExGcmNtbmg5cnZpRWNydnlaOWh3MTlpOTdZaXFRUDczcGJ2TDJQ?=
 =?utf-8?B?Z3lhamJ5RTErVVZuVE9MZjFTcDdaVU1xRUVLR3o1MWM2cHo3N1BuclV4dHVT?=
 =?utf-8?B?SUozREd3RG1OcXd0S2REU1Zwdnc1d0ZtcDBXLy9jbGpwWXBFbWdQcmY0VTBt?=
 =?utf-8?B?NlNLeVAybmlCZG9WMFoxeVVNektxaTBPRFVpK0dIeGt6NDE3VTJsSngyUFBH?=
 =?utf-8?B?SndNS3AzVGpEUGp6UkY4YVRLQTQ2d2FVWHRycWxEam5zQm1jV2dmNHlQVlRt?=
 =?utf-8?B?bFdIaVQ4VVg4RUNHbGs3NXQ3NnYwRE9JY2lhNFFQbUJlNzA1MHdmUEt3RVRl?=
 =?utf-8?B?c21QOFVmQnB3MVFDcU5sc1BzS2FPT0dUYjVKNGpxTE50Z3VqS2dqcmdReHJi?=
 =?utf-8?B?ZENBdlJGMkVXTTBmajQ1Y3JIT01hK2pSb1MxVEsrNFNneUtISFI4bS8rdEh3?=
 =?utf-8?B?MldZYkJ0ZGtGYm5tOUdaRHVJc01MalYrVndQQzZ0Yjd1a0Voc2xicng3NFR6?=
 =?utf-8?B?dk5EeEh6YVhSVDRYUmdjUnNvNWN3QmcxOGFiUVg3NlJSK0NabzhZU0N5eGln?=
 =?utf-8?B?MmhsZXVLYU9rYlp4WUJiRGw3Y3dqOVVtSHlsN2lPYmNQdGtoZTY5ZWRxbmo2?=
 =?utf-8?B?alFxekY5RE9VUzFyaEdvMmNlWXZ1c2dGRkdpbVVJK1lIZlc3Y2toZnZYaE9X?=
 =?utf-8?B?QS8zY0kzcmZyU2xxNjBnL0JJWjkwZ3ZGVU9OU0M2VmlWaFRScTQ3dGRVQXdh?=
 =?utf-8?B?WmVYRkNWVFF3NkxVYXNPWUxVMTUvczgvNkRlcExuMG8xRVowaENlOWZ4NVZJ?=
 =?utf-8?B?UVg5OW5iQ2l0WXBwMllsZW1Fc3dXTlRhc09uT0lLR2lWaHRPRVhBbEovQmoy?=
 =?utf-8?B?dHBHRGd3UlRKU0pFYjhPVm85M3dzTnlSaFpiVjFDZ1R0ZXFxUENmMFo1NndB?=
 =?utf-8?B?QmNvVTFURFEwZldSM2RUUzIveG9hWVU2MjVTcTBiZXdIWUEwUVVlWTQzWVhL?=
 =?utf-8?B?MFdyZFgvMks3U3p2VFFZSmR1TUpHcUx4SFFaTXdGMmJjRzJaVzZxUUR5U2JD?=
 =?utf-8?B?RjVKc3F5Q1FCNUcwSHhJN0xxMHIySitVRHR1QTFSMEVvL3JRb2ZQaVB5OHdN?=
 =?utf-8?B?TlA5V2hVVi9Wa3NnR3ZFOERDVzVZaGFwaHcwRHJtUDFTZ1B6VWJKTUdhdldm?=
 =?utf-8?B?UlRhdVhHWS9pR0lIOG5CMFFJa1JMNlVBc2hyenY2aXBRSXdaMFp4N2tvNTFU?=
 =?utf-8?B?MzVuVVJGOUlxS2xzek1kU2wrWXJpNE1VWUZtY21Qdkp4ZTdMQnpxaGRQNmI3?=
 =?utf-8?B?Nk9idzl5SzlNZGNGV2E4WGYzWk1MZ3FRMHhtbWxVOStJb2RwMEtwNzh0a0M0?=
 =?utf-8?B?NHFPby9NNXk2d2tNK1lvaCtCd0lyd1RiTU1odHRmRWFEVE1IaUhFblRWenJP?=
 =?utf-8?B?NzdUdXpSQVdMeTRUa1hCTnhPWmpibHdLN0JFVTVsUlZzbll0Yy9zSnpveW8z?=
 =?utf-8?B?UDI0ODBqMDJIU0Q1Mll0NWh3ZElGUDhRN28zSHdETEtSSm5WWXJmSW5rZ05y?=
 =?utf-8?B?TXpteHMwOHVsWFY2YmdyeU1yZ3hpVmZHMnJ3cnpsOXg4QmJ4cFJLb0ZpSXly?=
 =?utf-8?B?RzVVdFFPM1lleGg2d0Y5K3ZBYWZ6VGEvWkdwTzQyTnBzM2lYMUppSCtYWmpP?=
 =?utf-8?B?MXJhUWNObVJpVFhHM2U4WWFzUzBhRDNmY3hrOVpONkUzZFoxbWllOGsxd2dF?=
 =?utf-8?B?cXRRckVjNXI2VXBxcGIwSjN3OE5iQnFpemJ0UHRSb2htbVN2MEEvVjViem0w?=
 =?utf-8?B?M2ltQVBMRklFb0Q5S1k0WXVmQ0RONHVWZ0p5TkhrNGt1Y3dFcHhFSHg0NDJP?=
 =?utf-8?B?cFE1MjZrRWRqYVJwQ1Z1NjN0S3dJWWdKRDd2K3dOWjVndGxUR3R0MU8xN0pU?=
 =?utf-8?B?VkVrRTBBY2QyVklWK3BhZlB6RVBBdVdRMnhZb24weWRmNHJNUjdoWTdhek9o?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98537361-0336-47e3-065d-08dadef57303
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 23:38:20.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d4n2fcby7WIB3FeCUU/xwrDDkqjnh+o8HjmXs+5q1p3/RMa6ykM9go+yPmPiUvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1160
X-Proofpoint-ORIG-GUID: fpjvL0F7KgGaLuMcGPJV1ODKUeeItlLV
X-Proofpoint-GUID: fpjvL0F7KgGaLuMcGPJV1ODKUeeItlLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/13/22 10:27 AM, Dave Marchevsky wrote:
> This patch rewrites the runtime PROBE_MEM check insns emitted by the BPF
> JIT in order to ensure load safety. The changes in the patch fix two
> issues with the previous logic and more generally improve size of
> emitted code. Paragraphs between this one and "FIX 1" below explain the
> purpose of the runtime check and examine the current implementation.
> 
> When a load is marked PROBE_MEM - e.g. due to PTR_UNTRUSTED access - the
> address being loaded from is not necessarily valid. The BPF jit sets up
> exception handlers for each such load which catch page faults and 0 out
> the destination register.
> 
> Arbitrary register-relative loads can escape this exception handling
> mechanism. Specifically, a load like dst_reg = *(src_reg + off) will not
> trigger BPF exception handling if (src_reg + off) is outside of kernel
> address space, resulting in an uncaught page fault. A concrete example
> of such behavior is a program like:
> 
>    struct result {
>      char space[40];
>      long a;
>    };
> 
>    /* if err, returns ERR_PTR(-EINVAL) */
>    struct result *ptr = get_ptr_maybe_err();
>    long x = ptr->a;
> 
> If get_ptr_maybe_err returns ERR_PTR(-EINVAL) and the result isn't
> checked for err, 'result' will be (u64)-EINVAL, a number close to
> U64_MAX. The ptr->a load will be > U64_MAX and will wrap over to a small
> positive u64, which will be in userspace and thus not covered by BPF
> exception handling mechanism.
> 
> In order to prevent such loads from occurring, the BPF jit emits some
> instructions which do runtime checking of (src_reg + off) and skip the
> actual load if it's out of range. As an example, here are instructions
> emitted for a %rdi = *(%rdi + 0x10) PROBE_MEM load:
> 
>    72:   movabs $0x800000000010,%r11 --|
>    7c:   cmp    %r11,%rdi              |- 72 - 7f: Check 1
>    7f:    jb    0x000000000000008d   --|
>    81:   mov    %rdi,%r11             -----|
>    84:   add    $0x0000000000000010,%r11   |- 81-8b: Check 2
>    8b:   jnc    0x0000000000000091    -----|
>    8d:   xor    %edi,%edi             ---- 0 out dest
>    8f:   jmp    0x0000000000000095
>    91:   mov    0x10(%rdi),%rdi       ---- Actual load
>    95:
> 
> The JIT considers kernel address space to start at MAX_TASK_SIZE +
> PAGE_SIZE. Determining whether a load will be outside of kernel address
> space should be a simple check:
> 
>    (src_reg + off) >= MAX_TASK_SIZE + PAGE_SIZE
> 
> But because there is only one spare register when the checking logic is
> emitted, this logic is split into two checks:
> 
>    Check 1: src_reg >= (MAX_TASK_SIZE + PAGE_SIZE - off)
>    Check 2: src_reg + off doesn't wrap over U64_MAX and result in small pos u64
> 
> Emitted insns implementing Checks 1 and 2 are annotated in the above
> example. Check 1 can be done with a single spare register since the
> source reg by definition is the left-hand-side of the inequality.
> Since adding 'off' to both sides of Check 1's inequality results in the
> original inequality we want, it's equivalent to testing that inequality.
> Except in the case where src_reg + off wraps past U64_MAX, which is why
> Check 2 needs to actually add src_reg + off if Check 1 passes - again
> using the single spare reg.
> 
> FIX 1: The Check 1 inequality listed above is not what current code is
> doing. Current code is a bit more pessimistic, instead checking:
> 
>    src_reg >= (MAX_TASK_SIZE + PAGE_SIZE + abs(off))
> 
> The 0x800000000010 in above example is from this current check. If Check
> 1 was corrected to use the correct right-hand-side, the value would be
> 0x7ffffffffff0. This patch changes the checking logic more broadly (FIX
> 2 below will elaborate), fixing this issue as a side-effect of the
> rewrite. Regardless, it's important to understand why Check 1 should've
> been doing MAX_TASK_SIZE + PAGE_SIZE - off before proceeding.
> 
> FIX 2: Current code relies on a 'jnc' to determine whether src_reg + off
> addition wrapped over. For negative offsets this logic is incorrect.
> Consider Check 2 insns emitted when off = -0x10:
> 
>    81:   mov    %rdi,%r11
>    84:   add    0xfffffffffffffff0,%r11
>    8b:   jnc    0x0000000000000091
> 
> 2's complement representation of -0x10 is a large positive u64. Any
> value of src_reg that passes Check 1 will result in carry flag being set
> after (src_reg + off) addition. So a load with any negative offset will
> always fail Check 2 at runtime and never do the actual load. This patch
> fixes the negative offset issue by rewriting both checks in order to not
> rely on carry flag.
> 
> The rewrite takes advantage of the fact that, while we only have one
> scratch reg to hold arbitrary values, we know the offset at JIT time.
> This we can use src_reg as a temporary scratch reg to hold src_reg +
> offset since we can return it to its original value by later subtracting
> offset. As a result we can directly check the original inequality we
> care about:
> 
>    (src_reg + off) >= MAX_TASK_SIZE + PAGE_SIZE
> 
> For a load like %rdi = *(%rsi + -0x10), this results in emitted code:
> 
>    43:   movabs $0x800000000000,%r11
>    4d:   add    $0xfffffffffffffff0,%rsi --- src_reg += off
>    54:   cmp    %r11,%rsi                --- Check original inequality
>    57:   jae    0x000000000000005d
>    59:   xor    %edi,%edi
>    5b:   jmp    0x0000000000000061
>    5d:   mov    0x0(%rdi),%rsi           --- Actual Load
>    61:   sub    $0xfffffffffffffff0,%rsi --- src_reg -= off
> 
> Note that the actual load is always done with offset 0, since previous
> insns have already done src_reg += off. Regardless of whether the new
> check succeeds or fails, insn 61 is always executed, returning src_reg
> to its original value.
> 
> Because the goal of these checks is to ensure that loaded-from address
> will be protected by BPF exception handler, the new check can safely
> ignore any wrapover from insn 4d. If such wrapped-over address passes
> insn 54 + 57's cmp-and-jmp it will have such protection so the load can
> proceed.
> 
> As an aside, since offset in above calculations comes from
> bpf_insn, it's a s16 and thus won't wrap under unless src_reg is
> an anomalously low address in user address space. But again, if such a
> wrapunder results in an address in kernelspace, it's fine for the
> purpose of this check.

Not sure how useful the above paragraph is. Are we talking about
'offset' wraparound here? If src_reg is indeed a very low address in
user space, the following compare
    (src_reg + off) >= MAX_TASK_SIZE + PAGE_SIZE
should be force and everything is fine. What exactly this paragraph
will convey?

> 
> IMPROVEMENTS: The above improved logic is 8 insns vs original logic's 9,
> and has 1 fewer jmp. The number of checking insns can be further
> improved in common scenarios:
> 
> If src_reg == dst_reg, the actual load insn will clobber src_reg, so
> there's no original src_reg state for the sub insn immediately following
> the load to restore, so it can be omitted. In fact, it must be omitted
> since it would incorrectly subtract from the result of the load if it
> wasn't. So for src_reg == dst_reg, JIT emits these insns:
> 
>    3c:   movabs $0x800000000000,%r11
>    46:   add    $0xfffffffffffffff0,%rdi
>    4d:   cmp    %r11,%rdi
>    50:   jae    0x0000000000000056
>    52:   xor    %edi,%edi
>    54:   jmp    0x000000000000005a
>    56:   mov    0x0(%rdi),%rdi
>    5a:
> 
> The only difference from larger example being the omitted sub, which
> would've been insn 5a in this example.
> 
> If offset == 0, we can similarly omit the sub as in previous case, since
> there's nothing added to subtract. For the same reason we can omit the
> addition as well, resulting in JIT emitting these insns:
> 
>    46:   movabs $0x800000000000,%r11
>    4d:   cmp    %r11,%rdi
>    50:   jae    0x0000000000000056
>    52:   xor    %edi,%edi
>    54:   jmp    0x000000000000005a
>    56:   mov    0x0(%rdi),%rdi
>    5a:
> 
> Although the above example also has src_reg == dst_reg, the same
> offset == 0 optimization is valid to apply if src_reg != dst_reg.
> 
> To summarize the improvements in emitted insn count for the
> check-and-load:
> 
> BEFORE:                8 check insns, 3 jmps
> AFTER (general case):  7 check insns, 2 jmps (12.5% fewer insn, 33% jmp)
> AFTER (src == dst):    6 check insns, 2 jmps (25% fewer insn)
> AFTER (offset == 0):   5 check insns, 2 jmps (37.5% fewer insn)
> 
> (Above counts don't include the 1 load insn, just checking around it)
> 
> Based on BPF bytecode + JITted x86 insn I saw while experimenting with
> these improvements, I expect the src_reg == dst_reg case to occur most
> often, followed by offset == 0, then the general case.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
