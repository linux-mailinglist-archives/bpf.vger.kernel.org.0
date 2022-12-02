Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FF63FC91
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 01:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiLBAK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 19:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiLBAKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 19:10:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D9913E2B
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 16:10:24 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B1N4PCW024479;
        Thu, 1 Dec 2022 16:10:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=K0+v5zonrMfmQt0STpYvPMFcYdGrv79NgCvJINm00Ic=;
 b=SC4o/wDD7ipLjeGim8EL/y+9Q96hqM0xGhUX/dWTKLDUsJ9d+jHRS6eFtH0Kd0dCOhBZ
 0gL+aAS4lkDo8UeUIBpSmGOUwPxqbZzpe7VtPmrkGEy7uxb+4LXyQY8pgYOhKMaM62vW
 z0sKC3M2Q1gmBQndArlB11MLyp8PNPpdeIupXzWpxyt3xFnVJKyFT9MoPhfCEJ65/bYu
 e/mQXj0maqxnvoDKsL02haClhdIozsOncxSixVJtzxTg0itUZrR8a3Km/TkB8yC38aHc
 bKjQEzK/h8D0CM8TlC1DhXNd8/qjr/7XNOnQyDEr5TLxlaGYmWz0rUsD6BAXmtm2XAmY 4Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m6w6xd5nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzRfu+HzvZxjfVdkS3XJqKITT7KW8XXsfeoH+1xTj1iBxErTPupGxOje5dL4Jka5SBaUMjSHAOUn2FAq53XDrRMRgq5mdr/Rf7O2AHNsQliKFpQxwo4B+RnwSUFzr3wDt007QA2CrSqtclX0lWM0QwMguYCqhkK8yzRp/loATQI+pAj2UGxweg4RZBCqvmhJWjQBu2hOhA6mVXNL+ut4xn0MTXnrmYk4mxGqmT/IzTPLAfS9o6OJTQjJBRGiKELtFLnBwqgNvrwC/WyZVc5CNm9TCfPiYS7YGtF/zTr+DhtaTbAlRuzLW6+c14GShHJqujFn87bp/y4iK5CaUDGLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0+v5zonrMfmQt0STpYvPMFcYdGrv79NgCvJINm00Ic=;
 b=BOpWbfkMKE0HdE3nibmfEa4P8QAJ+fUVkuW1pSZwQhXFpFeO0D3AKaWn3PwtwKWwIdoSGD0lRqMhl4BeHfbv9qSegaJDUoOlEtY1r0ice+moLq1QG6XthBWefWdojYQxb0cFD+k1X6QLvwWFE8GEGMNZyAS28cMQdhVNOaOxlSMFVipUmPSRReaNjOkqlILMto9ZRJnSbCqSA7M7P+ATPWptONg6PENt4kAmW6l1IoQiv4WU2pXlPk38LCpo6UN82l1CcZJboE0mKLCEoWM5QC1p5sKviIZrj90m9xlz5oju6ae/eUzSjo83fOqxGkYh9tMtCAGAg4CGQ7tjaNdUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1629.namprd15.prod.outlook.com (2603:10b6:300:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 2 Dec
 2022 00:10:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 00:10:07 +0000
Message-ID: <800ebe54-1f66-7704-984e-815ecdfd5b64@meta.com>
Date:   Thu, 1 Dec 2022 16:10:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix release_on_unlock release logic
 for multiple refs
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20221201183406.1203621-1-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221201183406.1203621-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MWHPR15MB1629:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c58e95-542f-4bbb-e254-08dad3f9919b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7owz7JCT79mfVai8fAPvQEND+tm9FgjpG/1xv28iW6BXjOg+S1JdQ/Z4k0IfO4UkM8d+e0arvcRDsF2sZoX26IUUm1Uh2pj0KUu4FRkmIJn2pMvsBgr8+QkfissborvY541SZiWN4QvKImIYlp93PQW1cQnpqAalO8XoA7iWhTHYUzH167fqNAt74iOSbAaWWcB7rFK87LklTzdySqMlsqGjKjollCyhfFwz0Laqfgjc0j1oPI4CuYLARbu7gHJ2rnQeJLRjXZm7Ap2dZHJy9VYE0onyOoraUAerXHflIZFA7XiPbHJUJQdD7FqHx9boj/7jV9KRaal/XRHmgOCfZNUqYCJwBAZmGIp4lupSFfBRhzB64KwXhw5ilM4hpR1Q5awfTaSxfjS3hZc6se2AF1ExyogJIZkq7525yaX95XDCSXfPVSYIUl7gzK36+JjQ/E3LPjrj+9UDBxfR2+F8E3ZsS4k2FJGwbngtmsVzj+cCaqMkkpIzwyudv/Qnt3XH9jb2MtOoeXTV5nYlUaYlfOUnT11o/x+FtByKmIQam4RdlO+o5cp1SQo3Yq7ltf3Jcy1dGenzsM0RmKq9jpVvxd2eujWs5O5Sr1U8w0f16pkjd67MKI7+QPDjL6GJA1lrWSrhBOjST+Un3FUBqxSlSOVpF28coa3vT7R7dN2ggPgM30tWm98dCsSgc1CH++om53CbPBo3tqzBpW34pvGJFB5bpNEelVpQpd1/AGgM8fcLKrVYe2d1HtDS2Nf3sLBr90YPlUbWI7BWCcajSYoE7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(2906002)(84970400001)(31686004)(86362001)(36756003)(316002)(66476007)(66946007)(66556008)(4326008)(8936002)(5660300002)(31696002)(41300700001)(6486002)(478600001)(8676002)(38100700002)(6512007)(6506007)(53546011)(83380400001)(6666004)(54906003)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9pWVFaMWtHc2R6dHIxb0x5emRzMjZmRGY5M0NMb1BFRzA0WURsN1pNNE1x?=
 =?utf-8?B?VVlJTlN3WEtqQlNXUVhGZDBPeWY1MGxWNnNFSzY3MlQ0N3ZSZWhsTmQ3U0hU?=
 =?utf-8?B?dzJ3QUQvN1NtV1RJM3JCTFF4S25iYjFBN0YzdjZoNWE5SWZsa2pOSUlaazZL?=
 =?utf-8?B?Q2Z4VGxlazUrZDNEaDhGdWI2VkJIVUN0ekREV1RZcWsrM1ZndG54Q0gzanlx?=
 =?utf-8?B?RTgrU3loQ3BWUTdBZWQxcDMwTzFpMWNDMHVVbEhOV2pkSkcwVEhnWCtrakNv?=
 =?utf-8?B?YVRJUWEyVGw5WUEzRk5VZjZsRXdQMERZdHRPa1hLY3RtN2xualVtVksvaEhT?=
 =?utf-8?B?R0lkUFRQSXo0ckJ2d3ZxYzYvVkVJZmNOZkJENVNNMlFyZEtqL2NTS2tHV2xp?=
 =?utf-8?B?N3ZIRnBKYm9UaUZIQ2NzSmczVVd1U0ozYVQxRzZScUdYU2JwR0RqZ3BMSklB?=
 =?utf-8?B?c29DM2xGRkx1dUhlNGRnRFJ4ODNzYlFtOXhPOGdhNFk0aVRxVURyeVBCNWxE?=
 =?utf-8?B?djRuM24zaVkvSGVMSHhQKzFKRCtQR0s3ZC8rbFFsdjNRbHNNdU8rOGIreVU1?=
 =?utf-8?B?WHIxZE8rVGpmZThPT0NIMDJia2ltWE44Z1BScHg3emhDK1ptcU9yNEpoYkdr?=
 =?utf-8?B?YW5yL2dEajVwekcwbE81OE9XZUJESSttR3hWVGhGQWJJQzl1Q05rY0ZhMmVV?=
 =?utf-8?B?Ui9uSXhiS3BXVFh5OU9lQms0Vmk3LzlxT2tBK1lhTWVWeWRrcTR5RmJKY1Zn?=
 =?utf-8?B?WjZ6RklsaStFaW9XTmc3YVpVWVE0TDQ1anptNC9WenNpZE1VODNHc1d2S2Yy?=
 =?utf-8?B?UzRhRFg2b3crVFpCRlFuVm1yUjNDR3krSEs0aVlTUDJmdVJ0RGk2d0VHc0xV?=
 =?utf-8?B?ZkdnVFY3RnQrNE1hU0hERVh1M1E4dTVQa1FWQ1pIcTRTVjVRM0NienFrcE9h?=
 =?utf-8?B?V05OT3RaT1lUTm1NV0s3eUtZQTRhOGVZcjRpVUtoT3hDeFM2RjM4Sm9LKyt3?=
 =?utf-8?B?RDdLMXpVbjQycC91M0lLR3M0dEU3a25LVG0yWHhHV2hoUE0xNm9HYXd6SzIr?=
 =?utf-8?B?VzE0U1pmV2xzSUxtM2hBSitxb1JUN0hNTVRuQVppV1I1WGtYWkcyVUFrUi9E?=
 =?utf-8?B?MWZNTjVBeWNNcklOdzI5bmdDR0o0VGswdXpYSnliSlNleXU5bS8zU2lHRHYv?=
 =?utf-8?B?c2RlSHZ6UFh2Q3NsUllNcWhFa3JtbzdXTjdGNmUxOGFkZk1nN05oN2ZIbWdG?=
 =?utf-8?B?L1dYVHBmbWFmMlBwdWlBNlBlOXF2YUFZVEZQVC9na01QUVNWbDZsT1RQQmRQ?=
 =?utf-8?B?WmgzcmdXNHc4RXVhQ2JKRFIrTSs4SmRRU2J4ZFZHL3RUMjFCcVdIbno0bkNq?=
 =?utf-8?B?bm9kWGdmTHBPTW5wMjFzZ1BPS0Z6ODBzSWNFLzRoVDVzLytxS1h5L09haC9T?=
 =?utf-8?B?QXJiTXNjZTNiR0t4YlQyTUc5eHp2clViQ3owU0RHQkRuZVhudXRyOGZHblBS?=
 =?utf-8?B?aVlnMEpsU3FnYWkzVmNUUWl1NWsxU0hTR0U3MW5nZjdwQTZKQWovZXFRRzNq?=
 =?utf-8?B?OEpCOThFd1IyYVdwSERxQklJMlZEMVNqcWUwc2ErelV2R2poYTBPeTJyYlBw?=
 =?utf-8?B?aXozQUt0Y1NJVnBCb1RVWDRuZmxsM1M4U0diWER5TW5tWUtWWlNQNjJNUXpW?=
 =?utf-8?B?RmpyZnZqQktVNjNqb1VLcVVEanZ1Zy9jYUk3dllYSWdkZFhMSTVYT3dyWGpw?=
 =?utf-8?B?K3hBZ1JXZFdCdm15M1RqbzVxNksrNm5JaVNwL05sVkZDNDVld0dpeStoRUs5?=
 =?utf-8?B?VTY1UnFFNmE1QnRXKzdSbkpqczRiMUtRZUlJZncyS0MvOS9PaHZ2dktaUHpF?=
 =?utf-8?B?SHFMMStzS1k5ZlMxUStUQ2k0UlBKeFBHY0VqQjVybkFKZmlrTzR4czl1Q2d1?=
 =?utf-8?B?SzYycmtQa3E0MVZDaUMxc2RCYWs5clk2WnVXNmVuYjU1Rit1NGJNNFEvOHBG?=
 =?utf-8?B?S0FNNnNnR0t5eXdHaUtaVmwzNFhHbjBqUThtMkJmR2hRQXEvRE9SajljK2l5?=
 =?utf-8?B?Rnh6N3R6b1V2Y1BoMXdQdlM2ZXVDcnBCTWZ3L0tKOWcwZU4wWUpQQkxFQW03?=
 =?utf-8?B?WDNzOWJFUmlVazVBMkNTZ0Y3ZTE2cVdpUzEvenhmY0F5RFJaVVYwWU1iN2Z6?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c58e95-542f-4bbb-e254-08dad3f9919b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:10:07.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX2BZASiEmmmBSfv92m7BjJmHP4j061yC0JqryjPWEBJTIhSlkJrTLBWBBlVGnkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1629
X-Proofpoint-ORIG-GUID: ow6m4yAR7xdsHslxNiHgaJbun3-QYXt-
X-Proofpoint-GUID: ow6m4yAR7xdsHslxNiHgaJbun3-QYXt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/22 10:34 AM, Dave Marchevsky wrote:
> Consider a verifier state with three acquired references, all with
> release_on_unlock = true:
> 
>              idx  0 1 2
>    state->refs = [2 4 6]
> 
> (with 2, 4, and 6 being the ref ids).
> 
> When bpf_spin_unlock is called, process_spin_lock will loop through all
> acquired_refs and, for each ref, if it's release_on_unlock, calls
> release_reference on it. That function in turn calls
> release_reference_state, which removes the reference from state->refs by
> swapping the reference state with the last reference state in
> refs array and decrements acquired_refs count.
> 
> process_spin_lock's loop logic, which is essentially:
> 
>    for (i = 0; i < state->acquired_refs; i++) {
>      if (!state->refs[i].release_on_unlock)
>        continue;
>      release_reference(state->refs[i].id);
>    }
> 
> will fail to release release_on_unlock references which are swapped from
> the end. Running this logic on our example demonstrates:
> 
>    state->refs = [2 4 6] (start of idx=0 iter)
>      release state->refs[0] by swapping w/ state->refs[2]
> 
>    state->refs = [6 4]   (start of idx=1)
>      release state->refs[1], no need to swap as it's the last idx
> 
>    state->refs = [6]     (start of idx=2, loop terminates)
> 
> ref_id 6 should have been removed but was skipped.
> 
> Fix this by looping from back-to-front, which results in refs that are
> candidates for removal being swapped with refs which have already been
> examined and kept.
> 
> If we modify our initial example such that ref 6 is replaced with ref 7,
> which is _not_ release_on_unlock, and loop from the back, we'd see:
> 
>    state->refs = [2 4 7] (start of idx=2)
> 
>    state->refs = [2 4 7] (start of idx=1)
> 
>    state->refs = [2 7]   (start of idx=0, refs 7 and 4 swapped)
> 
>    state->refs = [7]     (after idx=0, 7 and 2 swapped, loop terminates)

Thanks, new description is much better.

> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 534e86bc6c66 ("bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}")
> ---
> v1 -> v2 lore.kernel.org/bpf/b5d46fd5-2693-cd46-9515-700fef1a110b@meta.com:
> 
>    * Update second example in patch summary to use a new ref_id for the
>      non-release_on_unlock ref. (Yonghong)
>    * Add Yonghong's ack
[...]
