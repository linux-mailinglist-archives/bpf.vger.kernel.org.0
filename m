Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE06EA051
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjDTXyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjDTXyv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:54:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60E1FF1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:54:45 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KNoYPj005902;
        Thu, 20 Apr 2023 16:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IcYlrl1/5aoBY84K5bnFk3DUzWI7GEORXjJ0jTJ2l08=;
 b=WUAm5SfquJZZ7RSsbZQ9xGzk9Ml0Ao4AJLAZDBkmvvc1EKxxOuxOR5rh3wL1gK/Ep/a4
 8zafeq+z/r8r/uUQ0JT9IKMN6rqB6onjVsDbT9BuZDMVb2cNolPxlQAJJ+k9smeAyvv2
 yDoP8cK2/XFulIRNmCTzHo9Ns0b9jJxs2IXgGgB5gndBk5TGQ2ozzmlEt8GaA7wBceAT
 fUmJ0VPBH4XEYxpIkl3DSnscFmaAxj+hOJ8oz4nsWNJ3DdWee838VrcZVA6TtgC/uPzb
 FaKIc/BQHs1nTgd+pXF+kFha3R6ZjSkTYpLZuzsYqNAasGj6Ax/KgZuY6t73HDRzsTCh fg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q2ty1y300-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 16:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDhLeiwbia4+wtplFWeXf/9yyhmB1M7/Tdy7zIZE0O7Q6vRtVC0UdvGs2I1rBJGfCwzDKmxh03/tolpezvOQQqi1dDnQ2fuMZD+T4aKRuJyvhB3lf9A2q5V5OyMKYSysFzmupJkoRl1/dl2E04/N0T/5ZFV0oVfWpPdaK6FMcvMAqFVGLTVCDXRxbN0TCj19aboHJ7UbMPhFUL31qAOZgamenmLbSVaMyH1/3rB7Oh+/2HVLUHSK8rZgA4i6+WLVEf66YDB2rlzjwj+WQEOqM5AFRQf9Q+9zHDKvcAukZ3wWu74f8dFItWv6YHHQKy5rlvbsiwZKpnSmtOfwo8HXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcYlrl1/5aoBY84K5bnFk3DUzWI7GEORXjJ0jTJ2l08=;
 b=bSkdbLG9Ibnc0xESZ3QZgU2waJBoxAfeHPL+qhutgsou2g6baz5nbykclHcX0kZKh8ea9NbtXyfO0SYhtKo/l7OQ3NOytpdvJ1brY1e+hvhU6kNafFkvevjUq1UKSVDfA+0Ts1YYv30lH0FE4k5gCYej6I07vB39I9gm6XBoMc319zX7bOBLQzjAOjDiNunnlEPzQTSdTUDIOcEQj6kSbGRRVgA5jsnnFPDaNHvb+6BCSuLyJFNEJNa6PPy7mcYRjbDXt4NzA8mfZIeht5B+FWnQsXo3P8lXJQjwhbaxxPANtE8HHtlY7SUkPKa7Va/VD18LBFLS6M+1ovMb5S81ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CH0PR15MB6212.namprd15.prod.outlook.com (2603:10b6:610:191::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:54:37 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 23:54:37 +0000
Message-ID: <3c239d87-5163-bc3f-cc2c-a963494f0971@meta.com>
Date:   Thu, 20 Apr 2023 19:54:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>
References: <ZEEp+j22imoN6rn9@strlen.de>
 <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
 <20230420125252.GA12121@breakpoint.cc>
 <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
 <f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com>
 <167cbaa496d047803f3d7cf14e13abe2deffb147.camel@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <167cbaa496d047803f3d7cf14e13abe2deffb147.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CH0PR15MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a71b79e-6820-448c-3376-08db41fa9905
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RWDWWGFB1FnFLofMJlgeQuJ5YW1pNU3+4hy45Faw9xerTZRJhzaZEHm6jVpuj0Kc6X5smpbRMVTh3tYGsf6jZpkpLBErL5yePSCBS2/jN1bLwdhC79nHk2gsvErQ5rDwSn7TeX0B42u3t9hYqY0Yxl0owOVOZwy/81DlGT+eI3hWY9jm+0Ws/h3gGbNNnB/nQZfY5qQIg9NphCJrE5msfe5e5Ueq4IcRT4diKAVX9TGdLibCSQQiD+M4SOUvqDvlryKdO5CzFkWY4fdfHG+R01UNwzLNQZUrzfSp/cyjNNABefF0/615wkz+VMijJdpd5b9TMngtMjNJ16Tp52QVPaVM2KN7b/iaICQxGLJtQw75ON6czkyyr1nsYvlljc91rf8IGMsVXGfpYbMsp364z34bMkODRbUMRB6WeHQnuj/TfF5PKA8aAaMTL59NHFxuX7A3rR2u0AijgMX8fTyGCws69fxtfpXN5RezJB6au1boUIWhYhsL1GvvEt5623XoifVpVLpi6e/0v0pXvYWjsGljeOPr+FYfxAcZ+iYFEaQ9HqXTamsbWRTV7DiwNwOCNKKDpZN382s1zUzE7L4OJzmNcE0uKkCCvTk1a9wHmJ20OoJgccVyYw0HKzv6xr95ogyQ+m4RqjwdlxhjW3uhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36756003)(4326008)(110136005)(316002)(66946007)(66476007)(66556008)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(31696002)(38100700002)(6512007)(2616005)(53546011)(6506007)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0F4YXA4S1JYMWErRTI2OUpYaTdpc0xMWWJjYTZCTEpjUWJlSWtGRHNHV2hD?=
 =?utf-8?B?UEkwdklmZWFZK2dFUXFkcWQ2VHhrUGIvL0ozRWtBOEt6V2YzaFpObmdmTUtl?=
 =?utf-8?B?WFZiZDBYYlpOVzVZWmNpQWhMKzVtemI5MG9XdXhXSEkrN2x3QXBvZkxMTVdr?=
 =?utf-8?B?dUI4ZWFqeVMvL1k1ZlFWaEFlK3RSV0Y0dHJueDhpZld2YUwxV2F2d0FLcW91?=
 =?utf-8?B?RVNZL0hsaG4wNHVmK3RXRVFkdGFyS1h0VHRFa25XYytGZk5uK1htRVE2NnVH?=
 =?utf-8?B?c0g0UE5vOC9ZL1lMKzdlRFBUdm0zTU9IMWdQVlQ3MWZJb0RDUlArWkZmRVRq?=
 =?utf-8?B?NURONm9mL08xcEZTWkQ1N2JHa1cvWEZneUgveWhaLzZNQUhUSy9lRmFIaFRI?=
 =?utf-8?B?SUdBMGZTcjRLSFduZzhuTC84VDNQVzZLaDNMaTVmMlJBb2VpMm93OW5pUm1P?=
 =?utf-8?B?T3QzVGtucVJDSlNTcFNJQVFvWURxWThyd0U3UkxnTnFkZWFsSTE3NkthNUZO?=
 =?utf-8?B?ZnIzaGN0RC81TGRXYVVVa0dVd3dOTFlnUm50dHZHL2lSRUNkclVzNzZyRFVC?=
 =?utf-8?B?eEgxU0dlblErellaOGxGR1praHVxSzhOcFhMSW4wYTd2TUUxMjY3b2g2OXRr?=
 =?utf-8?B?Rk1LNk5QaUpsSStuTDdleTdyUWdHdTEvS2dwUkgvNzQvdXlhM1E5Q0pYeUJh?=
 =?utf-8?B?WWIvNXJFQVAxQnllazIzbU03QlRGVGdJbHQ0MFRSQ0U4eklYMVJRamlyQWtU?=
 =?utf-8?B?c2I3ejlJZTRORnFxY1J2c0Fua2hKdUt5aXJUVlZNWDhSMUpZWjlyYkpnZXpG?=
 =?utf-8?B?aEg5ZWZ3M1orUTQ2T0ZLYmJJRVJ3ek4zVEtKL1lNUVZ0bkg2S3RIc3kxTndT?=
 =?utf-8?B?N05RUkdQa2diZVlPWXAvNTgzd3FlN1pRVVZzb0UvaittMlpOMW43a2d6MU5x?=
 =?utf-8?B?ZVNNc2JrbWg1bmVyTFdZcll0eXZSTW5yMjRRY3g1Vm1HMnY1OWViTUorU3o4?=
 =?utf-8?B?cytzQ3NWUXpJNG1vT2crV25hTTZRcElFZ3FQNTFBZFdXOVByRDZEMWhwcmFi?=
 =?utf-8?B?UFcrUk1zMVBrb2Q3WTdwV1dwVERjWUJXdWR6RUYxNCtEOVZXaUJiamJFSURp?=
 =?utf-8?B?OFJrM1liT1F5dGxkL1FDSEN3clU5QkttVDJSR0lIYjRpcXBxVCtjYkRZT1U4?=
 =?utf-8?B?ODhPNnB4V0w2eGRTYzJmNkNnRFNkQ0ZEYnFadFhqN3VRdjU2V2pRQWdoemR4?=
 =?utf-8?B?WXZkZXY1ZW1qY2d0cWk1Z2hNODNqNzQ4Y1oraDhqRTc5QnR4VENMS21BMkZY?=
 =?utf-8?B?eVdoSWFrTXdvU3NJT1lOclVCR1YvMGQ1bU1QekRaMkdVaWIrYmhmcWJpRllV?=
 =?utf-8?B?S0ZuZE1IOTJlTmk5WGJhQVlRV1BXMDFjL2NQMldMK1B3ViszRWg4WDFWMjNE?=
 =?utf-8?B?anVvMEU1U3hxNVA3aUtXUVYzcFRZbzVqTjVQaDE5MnZteFVUVFEvZmZGdHcx?=
 =?utf-8?B?NHhVVEJpcFl0alZuc2RFNVVEd1k3blNNUzZ6aUY5OEp0a1c0NmhxMVBXWkJm?=
 =?utf-8?B?MkhxZGdhL0xTRWN0V3gvUkVWVWdkaWpkK3dsVXU4TGhDRDg5YTE5YjJVeFcw?=
 =?utf-8?B?aFAwZEUveFRiY0o3Nys4c0xUOVZRYVRaWkk0MjA3dzVTSUlHOTV5cUdvWkYv?=
 =?utf-8?B?VnJKVFU4cjZ6eDVTVm0rYmNtOVJZYnhHUkd5cG02bDQvbVptVWVmSzZ5UnZR?=
 =?utf-8?B?RWhxTGwrNWdkL3I4WU1yQXRkNXJ4QzRWSlE5c0dOc1ROSUJwUVMxdHJwd2tm?=
 =?utf-8?B?QmlIMGpWRlo2aDFXNm9KOFdsd1o0QzBWTWZwVWp5VFlwK3R1dmpqdEUvTGVV?=
 =?utf-8?B?aXArOG80NTFiQjh6NEFuSXZqaHAvRzhJc2N1MXZzMUI5c2F1aGU1N2F0Vmdx?=
 =?utf-8?B?T0xoME9PVFJOalhjQ0l1Z0cvb1FvRitOT1g2Mk9MY3ZTNkxTZ0p5cnFTYUpC?=
 =?utf-8?B?dVM1WmlkUER3Q0xKMTQ4TVFqQ20vQjVtcDNtUHpueit1SzZwR3JvdWIyZmcv?=
 =?utf-8?B?akFUWG5QSHY3MUtvRjRtem5sNTd0SzRaYkJIU0RWd2xuQWtSVU1CSnFwV2N1?=
 =?utf-8?B?L1cySFJxdmRxbUtuOGh5b3MweUJXbzZwNVY0eVllWmE2WWxma0pHdThCQ213?=
 =?utf-8?Q?0dHPYCEDGdOdEqPIPO88tEw=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a71b79e-6820-448c-3376-08db41fa9905
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:54:36.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A79/4IPhbxrQB8NXeXI2OqJ1qtIeGa/4hFoCD6i/HNhjScycO0cxyRmvhU68SwFKN74K6F6oDAl4mUnesMrHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6212
X-Proofpoint-GUID: s5_XrgjyHGQGb9E07O6ZAJotTQ74YqGR
X-Proofpoint-ORIG-GUID: s5_XrgjyHGQGb9E07O6ZAJotTQ74YqGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_16,2023-04-20_01,2023-02-09_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Eduard and Florian, thanks for finding this issue. I am looking into the
bpf_refcount side of things, and IIUC Eduard just submitted a series fixing
__retval / test infra.

I'm having trouble reproducing the refcount-specific splats, would you mind
sharing .config?

On 4/20/23 7:22 PM, Eduard Zingerman wrote:

[...] 
> Looking at the error and at the test source code, it appears to me
> that there is an API misuse for the `refcount_t` type.
> 
> The `bpf_refcount_acquire` invocation in the test expands as a call to
> bpf_refcount_acquire_impl(), which treats passed pointer as a value of
> `refcount_t`:
> 
>   /* Description
>    *	Increment the refcount on a refcounted local kptr, turning the
>    *	non-owning reference input into an owning reference in the process.
>    *
>    *	The 'meta' parameter is rewritten by the verifier, no need for BPF
>    *	program to set it.
>    * Returns
>    *	An owning reference to the object pointed to by 'kptr'
>    */
>   extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
>   
>   __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>   {
>   	...
>   	refcount_inc((refcount_t *)ref);
>   	return (void *)p__refcounted_kptr;
>   }
>   
> The comment for `refcount_inc` says:
> 
>   /**
>    * ...
>    * Will WARN if the refcount is 0, as this represents a possible use-after-free
>    * condition.
>    */
>   static inline void refcount_inc(refcount_t *r)
>   
> And looking at block/blk-core.c as an example, refcount_t is supposed
> to be used as follows:
> - upon object creation it's refcount is set to 1:
>   refcount_set(&q->refs, 1);
> - when reference is added the refcount is incremented:
>   refcount_inc(&q->refs);
> - when reference is removed the refcount is decremented and checked:
>   if (refcount_dec_and_test(&q->refs))
> 	  blk_free_queue(q);
> 
> So, 0 is not actually a valid value for refcount_t instance. And I
> don't see any calls to refcount_set() in kernel/bpf/helpers.c, which
> implements bpf_refcount_acquire_impl().
> 
> Dave, I see that bpf_refcount_acquire_impl() was recently added by you,
> could you please take a look?
> 

refcount_set is called from bpf_obj_init_field in include/linux/bpf.h .
Maybe there is some scenario where the bpf_refcount doesn't pass through
bpf_obj_init_field... Regardless, digging now.

> The TLDR: of a thread:
> - __retval is currently ignored;
> - to fix it apply the patch below;
> - running the following command several times produces lot's
>   of nasty errors in dmesg:
>   
>   $ for i in $(seq 1 4); do (./test_progs --allow=refcounted_kptr &); done
> 
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 47e9e076bc8f..e2a1bdc5a570 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -587,7 +587,7 @@ void run_subtest(struct test_loader *tester,
>                 /* For some reason test_verifier executes programs
>                  * with all capabilities restored. Do the same here.
>                  */
> -               if (!restore_capabilities(&caps))
> +               if (restore_capabilities(&caps))
>                         goto tobj_cleanup;
> 
>                 do_prog_test_run(bpf_program__fd(tprog), &retval);
> 
