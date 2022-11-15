Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58D62A36B
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiKOUwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiKOUwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:52:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A731F83
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:51:32 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AFK8aBC007752;
        Tue, 15 Nov 2022 12:51:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=buDG7QrGkUTogq0LtzvCIL6bRP9PxKEGbq2KtZ1xffc=;
 b=MPphmi8OLLoRTovQa0DcmfDGZ35Lk40p7EUEORirwEfzKwdCsd4M1KE52jfspuAx4dYh
 D7UsN53LerrVEAI71jTHP95/LTxSwpj/Gfxmpcme9WBERpAOB5SgdNHpLrsKT8PSRJrs
 cVfs4Ri+RYR7xjSXT15OakaiqH5arUf6q54tqEKRrFuZgAbFxRkG6WPrxrWDbEpEECmP
 8xCnc31FYfrTNzM06Qvg1oKcuEC1ZPxYeEqBh1NN53LfBuqIBVdkTcHn/pC1r/Lxv0HL
 SDsrW/f9Nn1ZgMTB2aJRZvVrXtD1X921eEGkgJKcTDLbHM+MMnSBQgIM5CK53E16c4Ai UA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kvhhsr9t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:51:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvfJuOoY7BZMa4VVaZtcI+mEaPXNormVwzrYlSiGljk2ks0WiBp+HD1ZAfZY1Kje9nR7iQKrAsR6/skMVNaFN4akgaV53WLTlV2+sRWiK5K/s3vp7QHUHLkzWXaGCLFYV1n9xf4OB5TXAWjcdhTNUGUKBs6xOKQmJpB74GA3Hqf7wVP60QDASndkTWSPgLu1FVAzjRqrgmPU9Gukf3KAb5CwAtu0GODuYk0uF5VTA6soanwPTtbLcs5v1QQio92honQRpm6MCWcQXhcjdfHhe8pA7vTuu/wTeZGYUZxAfiIijK6d9gZVlQsVFVPAdAkRsm4nYpCIqq9t5RjPhzcqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buDG7QrGkUTogq0LtzvCIL6bRP9PxKEGbq2KtZ1xffc=;
 b=dtFEJx8V7GnDAyBOkhKiwcRIjeojMvDHF2vY7a6q9MrP7O+5A0nfpgcMfvxFxppZ9BhYpanoY4YqsnCbq3YAkE1EHB99ZDlymA5pi6F5JkUrTI7xHZccS6JpwvSdUTm3cIyZV7c9NLFbRs9nAuSi1WLjqJsEhw+cjqDr0B6glEd02P9fWkVDWtV/pEd2nS0G2BDqaOGBuamG+EdDiP7XBv9Ls4SDiuZSQSqfQXcxQD97aagHHYZ1+/cWnixMAs5mM3sAXj5drXEgmmBv1i4noFgmmSjNKxilNn/7rVu91qgj/GVNZV0QOXfDIxpdqg8Qbg3mIpF5aGA14gUbHf2jLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by DM6PR15MB2410.namprd15.prod.outlook.com (2603:10b6:5:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:51:15 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:51:15 +0000
Message-ID: <389de1f4-b9fe-7b4c-b383-31908a063d59@meta.com>
Date:   Tue, 15 Nov 2022 12:51:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: check nullness propagation
 for reg to reg comparisons
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
 <20220826172915.1536914-3-eddyz87@gmail.com>
 <CAADnVQLhcEduU3JahFSGEhv3V56FuWhFfwsgGE1JHSrCBiOf2Q@mail.gmail.com>
 <9c6f292415c36ea8409eaee466b197bb0ba7f02d.camel@gmail.com>
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <9c6f292415c36ea8409eaee466b197bb0ba7f02d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|DM6PR15MB2410:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbd639f-01c5-4b02-7b6c-08dac74b235a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3gCWXefBZSzHFjB6Jm47Mdd5lTYjYQnwJSQsSmzsWYKwyAh2USK0XFLZYguGjbtHNgdK1RQ4BHNH7IKH++8/R7Eu5cLG/BfvoFQtfk8EYbfAZXlHLxyRA9SUe/T1SpXfCZ6KLETGk9ppd07H0vuWhSS4inHCNQQCRuEXdRUT/WPV5qq1pFoBIpSBaFT3tXJA4C09uLosSg8x/wK8c8fpytdd1SI0hu3BaYSb0qBKjxwqxz5yLGOP327hZWW2uu3oOq8gugHAqg0UddVuy6p/hs2ksEBj52x4hCVDtKw6TM35scgEmVjTEIryP9sbWW7pDsN0w+fRCjrBHhOKt66oXFTKYMvl27VkgcUyYoVpCA0prg/rYD6d4hIJBg4nFNZJuvqYw53UTegSjka5ofpEM7QfhYdopLUzEot5gq0FPZgTMwtlLPM5MqALp9Jsa8AshBG+hLNB3dIUxH938ggh3z/vVVSnLxWKVhN9iUNy9BSdN0nOqs+AAqNVBK6bjXH4tlgT3dvA8B8jcypQtqNeTJsl3pXDalv9LJZ33vRQ314blLTih1VKIXV4G3o8Ny0WrzMz8oh1+ckYvNYjdi5l9qiA5QfTLQCZSdfNBeSzVAuI/6Nx0eBIsf6FYoUApPxq7xYwE0J02Bm+71rl3gydyV/IeWARhPA2TDI8EHPrFLK0k2y5mYlEcxBme45o07M3MHUArwJtPMuMTPx209YbTkjeh0gx5v3fY7QnMMRu6cwMgFRLgs1g/eb1QS/v04Yx5gLuvbGSxpJjsjGfe9HHxXWgT20RGRAGNf+YK3H1hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(66556008)(8676002)(41300700001)(66476007)(2616005)(66946007)(2906002)(4001150100001)(186003)(36756003)(5660300002)(8936002)(4326008)(316002)(6512007)(38100700002)(86362001)(83380400001)(31696002)(478600001)(31686004)(53546011)(6486002)(54906003)(110136005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlIMi9SKzB6Z2djaThwOHdJSDVnZlE2UmwwOVA3WnlubkNVZGNkZTIrU2tP?=
 =?utf-8?B?cUo2VlFKU2NsZlRuL2RzS2ZJMUhTMGp4aVhFbnVNeHFta000cjRPRHR3TW9q?=
 =?utf-8?B?aFBJR1RjRk0xWTVMeFd6Q3QyY0p6U3l1N0FZQjEzWUR5NEZFMWlYVVhUdEgr?=
 =?utf-8?B?UTdpV3o3c2gyZ3lvTVpkYUFXOVZjZWlqZ2JHMDQ3UHhBdlZSNlc4a0xjTXlM?=
 =?utf-8?B?SGNUODNKT0kzc0ZYTnRhWGN0S0U3SVpnUnFUMkt5ci94SVRvNWhhUUVJalY0?=
 =?utf-8?B?NSs1d291TzBha2VZbGUyTVlrNnVKc2F5MlBqY2RBWk9hSkQ5SUdmb0gwTmhh?=
 =?utf-8?B?YUNZbmlUQjZVNjZyd1htd2tFTi81MysyNXpyMVBTQWtsUWdEd3NaK1EvWGRJ?=
 =?utf-8?B?OU5jaFh6Ky93L1gxalZtVXFIYmdnYy9MMnA4ZUE2SXAwS2U0QTlaVmNQYU5P?=
 =?utf-8?B?aFJuK3QvUmhoMEVlMjBIS2tjQXJnNnRXeVJyM241NTg1M05TR1ZtNi9QSDFD?=
 =?utf-8?B?V1JKTUtLUTFNd09iSyszV21jSDJtQ0doREE2QU1UdHAwL3Jja0VpT25KeFlk?=
 =?utf-8?B?WXF3MEp4ZEllTDRyUlo0dlF0dDlycW1CMkpOdDJobU1pYjFjOWt6WG5udjdG?=
 =?utf-8?B?YzhxeG9tYkhqYmJFQzB4VkZnQ0kwRnpDUHA5bmZnTTVNeTMwQTU3SzB3TnIz?=
 =?utf-8?B?UDRKQktOV2VSTEs5Wkx2L1VQbTZyR1JZWk9PbjBicHdPMkVvSVRYZTlSSlZa?=
 =?utf-8?B?elNxVlRVc1U0Y244bnlVT2pMMmlkZjR2Q3RwUmlieGhjN0tiUXc5S2xMY2VT?=
 =?utf-8?B?TklBbnFoQ3pTVElZTjBQMHROS1ZuVHFiWFBua2thdWhBcGd3cWxCL2JldGQ5?=
 =?utf-8?B?UFVYcEtyemp5ajE1ZzZwL0Qvcml6QWlrTzhlWENOMCtFTG9LcWlvbnQyaEtB?=
 =?utf-8?B?dE1LbkN5eUZOSGluODRSM1VsdkVNZ1QvOFhmanE1U1M3N2pDQ0w2KzFON3B3?=
 =?utf-8?B?RXZPNldRTlkrWDlrQTZ2RTY1RE1hdi85OHA1L3dNbmdpNVNRMzNKKzgrdTVR?=
 =?utf-8?B?OTJMUWFnR1ZzNHpjRFUwYVhhbGFWTFl5TnowZXdjblVTUEd2K29vQlc2L0Zo?=
 =?utf-8?B?Yk5WZ1QyaGdRTTVOTE9XWHVpU3hERVdrRXMxRk1tYmhJNUhPWk5KTFR3dGJQ?=
 =?utf-8?B?Z0Z2bUl1djZLUUxUa0VNK1NuSXRmY0RrMk5MaDJaa3BUQmxvNkZRcitYMm1j?=
 =?utf-8?B?S2xOb21WajIxVzdQR0czNnRTSmphM0Rvd2ZqcWVUTzYwWHZ5WmV6OVZFd3hY?=
 =?utf-8?B?ZW5JaTNnRktLcmpnb0lCMnNRODRZTEpsODFqUkViVEdJbElNTzY3bE5QTVRI?=
 =?utf-8?B?K2lhVTBYR1VRQk5FKzdGV2IzUjVpU0lwZTYvZWdQWmdGWWFCMVpjYXlYUFEx?=
 =?utf-8?B?ajBhbEE4VUoyN1ZnQ0JtWEZ2R1ZlaSsra0Q5UEpYTWtFZmlHcVM4V1JmTnB3?=
 =?utf-8?B?T0VXNG51VmkxUTVjYk8zZkJ6VmdrVUZ1V1ZNM1BpSWl6NnlCbEZGVWc1QjAy?=
 =?utf-8?B?T3dhdkxCcmpyejRuN0dvbE96ZFRRSW5xejRncHFpQmRNcW95TStjcTcvODFB?=
 =?utf-8?B?cUc0TVJ2cGROQTNVMmpYcXlBNnJ4QVJjcm5hRXBZQVY0Yk1jak5PMkNXMnZq?=
 =?utf-8?B?QndFMHRVZlNKUE05dkd5MjNRZGtrajI1UUlsTGJtWmNKZEQ4RXpUTUx5NFNV?=
 =?utf-8?B?cWhTeWd3VnpjMjNXZllpaVEzNVhVQi9FV3BHK200ZDJxL2xHb1BGQzhRSGJ3?=
 =?utf-8?B?dHBma0MvQUZJZnRJeHoxTE0yWEh3cVNKd1JCVGErNDM2WVRuSWlraVcvQUJ2?=
 =?utf-8?B?SjYvZncxTFdkSDloZnkrV2RlV1kvcmMrZWZBZTNyZTN2M0lMSFFkNGdYdlJO?=
 =?utf-8?B?OU5yRTRQUE5xWUovMVo0aTZ5eFV6NlMxaThUalpqVWQxRUl6RjJpK2t4L2NP?=
 =?utf-8?B?dE4rNCthM3NEL1JjWEpHZlZxZ0FkWUtMaWQ3eTlSVXhXc20yR09FY0xvTGFu?=
 =?utf-8?B?azdJRDJGcms2cGp3eGljL0RzV0grMHpzeEh6ZzlzalBMWm0vVk9jcEhHOWVR?=
 =?utf-8?B?dlRneExpcFAzRFZBNENlSXFmNnFMMnZXbTRKUkh3WVBTbGx6WjRsNWdQTk5m?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd639f-01c5-4b02-7b6c-08dac74b235a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:51:15.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w1LDUjNH8q1rYqRXTOBkfbl0oRqpCxsuM421AQQd0rJpz8P1EGJKDaNY1D2CsDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2410
X-Proofpoint-ORIG-GUID: Wp8-nod5HDFaOGsdkL1G-18TPZLfRXbx
X-Proofpoint-GUID: Wp8-nod5HDFaOGsdkL1G-18TPZLfRXbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/22 12:31 PM, Eduard Zingerman wrote:
> On Mon, 2022-11-14 at 10:01 -0800, Alexei Starovoitov wrote:
>> On Fri, Aug 26, 2022 at 10:30 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>
>>> Verify that nullness information is porpagated in the branches of
>>> register to register JEQ and JNE operations.
>>>
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
>>>   1 file changed, 166 insertions(+)
>>>   create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
>>
>> These 4 new tests are failing in unpriv.
> 
> This is interesting. 'test_verifier' passed for me because of
> kernel.unprivileged_bpf_disabled = 1 on my test VM.
> But It also passed on CI ([1]) with the following log:
> 
> 2022-11-06T21:15:53.2873411Z #686/u jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch SKIP
> 2022-11-06T21:15:53.2908232Z #686/p jne/jeq infer not null, PTR_TO_SOCKET_OR_NULL -> PTR_TO_SOCKET for JNE false branch OK
> 
> To skip or not to skip is decided by test_verifier.c:do_test:
> 
> 		if (test_as_unpriv(test) && unpriv_disabled) {
> 			printf("#%d/u %s SKIP\n", i, test->descr);
> 			skips++;
> 		}
> 
> The 'test_as_unpriv(test)' is true for my tests because of the
> .prog_type == BPF_PROG_TYPE_CGROUP_SKB.
> 'unpriv_disabled' is a global set by test_verifier.c:get_unpriv_disabled:
> 
> static void get_unpriv_disabled()
> {
> 	char buf[2];
> 	FILE *fd;
> 
> 	fd = fopen("/proc/sys/"UNPRIV_SYSCTL, "r");
>          // ...
> 	if (fgets(buf, 2, fd) == buf && atoi(buf))
> 		unpriv_disabled = true;
> 	fclose(fd);
> }
> 
> Might it be the case that CI configuration needs an update as below:
> sysctl kernel.unprivileged_bpf_disabled=0
> ?

Yeah. Makes sense to enable unpriv in CI, since it's missing tests
in the current form.
