Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D171632D95
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 21:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKUUBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 15:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiKUUBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 15:01:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E96CD97C
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 12:01:27 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALJuUQS029825;
        Mon, 21 Nov 2022 12:01:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5Q/6H1GSoXjmt3lgM69XNuJV3vPlVumRvarVLRhf5S0=;
 b=CEF2ApG2WhBPz+6Q/FzCQJOjtxGpldnAzF0ocqQHPA0GqriEBQEXg6luiBOHOrO4Njh4
 2Kp1NjOSj5po4osh3I5TU5IuXcF6t/07HdiGBOAc7jgy0DUnHdBralW8EPwPa56mPUw2
 r8LxaAnxUIC/9ve6mmjGHN3YaaA6SS6839Ax7RQ30QBAlh4PFanfz+d9Pq/jlJcDYOFx
 tnooUxKkMulnj0gIRB12baSPWcTSn8uETHRywtHA7R54XNd31jRbyXrCciROxZ0CF9Oc
 pqutafjCqgxIYyD+JcKnpAohvw8MXJewaz5zxgyVZTYjzXwBnJlVHz42nxtp2TCxvmB9 jA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m08k53qf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 12:01:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYCf6MpzK+lPdW6ZQossjiS/lIpzJAZIUYyV8kk0+G4e3S1QwYqguHbzl1BK+PQLmsg/SlbF9VNDQ1eOUNcC6MVs/eW+DAFqJdfz4SNwIa9P816Lc5FEqwrGEFSmCk6EMMP1QetBd9LQm+sbhx9uHIgYEeRDK8X0t3BdSqwmwQfisEPnH1Bc1nZrQ+Nn0fojOtRZsmXrgEWpwBUzHcsTRAEqH72Hyc7IACqZ8A70G+fFDFfgVvw5p1kVpQJmEnYYQ3cplGmUkQqaes+meNg+fi3VnrPPcRFbPjLnP3/8w9FhK/zR+7oRe/zS2lHaEltKSoOXtxdut7ik8sr+03WZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q/6H1GSoXjmt3lgM69XNuJV3vPlVumRvarVLRhf5S0=;
 b=d6tw6il2YAo+jpbWx+ahTVQm3fx6ekq8w6EQcTI+XGDygCq3Z9eCpTs23xl/0avnScqAFAThb5yNIh5285ptIHAVfKlXGNrLiFRb95E1w8qH/X09facqt9nEl6oktf5pPerPnxs+XHVj1knqsmtjWUYCxS2lvlIvWAs+axv0yXUvxfup7Yczx5MDYPoFCyCNykcr7DK3J0GXNh0ptuvWCsvo6KMpY0JWXFA9SKXG308pUxUg3Rwq8E6o7WxFVvWGrQCCFF/4ERP95D43Tqf4x8Vx/jP5Ycg1eiXTBt6nfFHIVrloPMNVeN+cION9omo47BpDc9PNY59ZSkC+JYqNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2774.namprd15.prod.outlook.com (2603:10b6:a03:15d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 20:01:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 20:01:04 +0000
Message-ID: <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
Date:   Mon, 21 Nov 2022 12:01:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2774:EE_
X-MS-Office365-Filtering-Correlation-Id: 969d940a-9dc8-4d31-f16a-08dacbfb1f34
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Za1qVA4Bx04Ilx8VuYtFc/SU3mztV9Iv6wI9MKCZ0NM1uR8kTzk7hj555/vK9gml7CD9rt4w1ye/DX/gD1VNr7UQZaS/MLvLwW+zUWtWKaw9eA4dbUmslWZ1AC7pwEsEeBbbzocETtfKm7tM2ZCqt/gyIOF+hMPcqVQvSX7mbuaetcOQ/4xDszmhKiK4f39vUr7yK+ZcZ1hglT2WSCzcRrW9D7dQPYfy1b2FcQ63Bw6E2XL9PFbZHgK0URvBZ5Mugj+5yYP5D1OEYFdTYm+EsOr0ZrEu+HwD3Lhmyqgi8u4cJd5BaLta5cMB2+ZjKfHnD/Bn/Bc0B/YtsMAjA11NSfVaZAqRmN6g3z9Vxg4IVgcXDCa89VsjkFh/Nv1uBRuMwhIz2GUCEqKO6NVd8m29S+LF+pIO2HDsDywljY8xxd95va7x4+6z1iDNAXm+7GQXQwORRLT3Sv5RS9/oZ4jeV/gEXQkatLj4ilIlA/PxquLE5wEbb7WjOW3H1IbdzckLeJLCKcVRe86kRIv/GZZSiKmvvp/B6MJJf4KU3CLIW8MYDMlLKH4JkZwnApxVfe5O/BKrysJHRZ/NNCzjEPecl1Q1Ai7/ylZGFnwkvzkxSqgbdD+MA/TDfahRoP2sSMn6KhpXuPO+ZH7gLGXnUOmh5Z2QcRx6pS+WegOehfW1wL2/QuhFS/9o7F5uFPna2obzUHDu5lJxvRYc81IwhzOkf0+ZvEfCKJwZ38Qqk3qX8K4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(316002)(54906003)(110136005)(36756003)(53546011)(83380400001)(2616005)(186003)(6666004)(6506007)(6486002)(478600001)(6512007)(31696002)(66899015)(41300700001)(8936002)(31686004)(5660300002)(38100700002)(86362001)(2906002)(4326008)(66476007)(8676002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFTUUo4dGk1U29sdXo4QmZFaU9iL0xPZWE5ZVdtdEc3RnVEZ1YzWUJXanVq?=
 =?utf-8?B?UWNGdFRxNE95eTc5dDZmNFVSdjBxMUx3eEorNkMzTEkyTXNnQmo1djJJUDJ0?=
 =?utf-8?B?am5jUjZ6ek1pTnZqeGRLQ3VEbE1uZUNHQlZJTXZpTDI5OUlsM0NDdUVkMU1t?=
 =?utf-8?B?SGxJSWdiRVhsSHFGVXNkUWdBMHN3N3hVMFFoKzh0TFIzTGZTby9BcTlSeUE1?=
 =?utf-8?B?UEJPRFBFejc0Y0tDSDl1NzhZVUx2ZWxsMlhFZWY4WW5zallEa2dTdHlDS3Vu?=
 =?utf-8?B?Q1F5cEVTSGlwSml0aHBYeC95SzdJZ0dLbGM0a0NKYjhWb25Gei9pZ0V5Y1lI?=
 =?utf-8?B?ZEhJYytDS0swL0xMZk9kN0F3ZzFaR0hMMjJlL1JSdnlacDNGUzlENVJDa0Z5?=
 =?utf-8?B?NnZTQm1WdTZzY0t2ZkhVZHVQUDZXZTIreXpiVzNDcFV4RjNwUTVOczFpRm9L?=
 =?utf-8?B?V1U0SjJoQ0VlclF5RDdXTG9ROFJRK3JwdEhoRG9jb2crMWJwVzgwbnZIYWlj?=
 =?utf-8?B?ZmwraUlaaGg1OWx3TWpKQUhtU2NnSnhoYXlMeWFid0FueXFSaWxhbkdob05F?=
 =?utf-8?B?Z2puVTVFR3dmc09KNkVCdjg5ZjhtVzJGRzAvWkthdTJqSVQ0ajczckVTK0dK?=
 =?utf-8?B?cnM3MWUvNWhWZXI4aldFaVVZVDBtOXNYYjVZVnF2c3NZWWFYcFFFWHVHVzdm?=
 =?utf-8?B?cFE1OUdWYzVFSDlqOWNWZS9NejJabldXRmpUNGg2VlhGQ1h1WE45WktSYmFI?=
 =?utf-8?B?SjF4TTcyNVNOWnVOeFhjOTlwRTIxSUFJVC9iK282Wm9FM1phMWVhSEhaeTY4?=
 =?utf-8?B?SzRtbm1xOUk1RDk4QWFyNFc5ZEEvdmg0L04yQmVzNWhsRThVNlpYKy84YmNh?=
 =?utf-8?B?TW5UVndDODFNZW1OVUUrdDR0U0RPYzNhNG5LQ284cjZmWUszcG5tNldMZFEv?=
 =?utf-8?B?bjVpallKME9SanVITlZqenk4dDk4UUtXb0RDMXIvNU04VlhMYUhMNjcvcEhi?=
 =?utf-8?B?NnJKdUxxazljVmd2Z2ZCTFJpaU53STlHdERqQVNqNExtcDlZS1NXd1dCc2E4?=
 =?utf-8?B?WitKYXJ2S2NDbmx4TllhbjBsRnhYRXo4MHZCb0U3SVF3RXBjMm85OXRzRDlK?=
 =?utf-8?B?bTFIa2RYQ1p3R2xQL0xhRG1mRDBDejJORVFMOHA0MUxRTG9abUhzeGtvcWdq?=
 =?utf-8?B?Y0VEZGlvNndVODNEcXpKdEszTjlLTWhHTDlFOENUMytvRURIMDVnVU9HTlo1?=
 =?utf-8?B?cEN4eEpyLzlJVkVQNWdDOStvREZsbTM4S1BWaGVxNDQxRUtSYnQ3NHlxTlAx?=
 =?utf-8?B?NVlnRVZ0S1d5RGh6a2hFRjJGSVQxeGEzcHdHRzJEK3BIWmNDS2FuVjBlZW5M?=
 =?utf-8?B?SDhyTWp6L0VObElaZUhTNWtLUWlZNkVzamZCa1QwSTY5eHZ3UDVzQTZJdjFC?=
 =?utf-8?B?bFNqWDFRVnZtZURlM1o3NmpLZlBGTmJyMUFGcEIvVHVUZTh2Z1VFZm9vNUFU?=
 =?utf-8?B?SE8wTTVtZmtLeWQxOUluSTZnQWtWV2loNzI4WExvUUs3RmE1WEVtUzBtUjhS?=
 =?utf-8?B?Y0NyZ2hBUnhCWE5vRXB3blY1aHlNZEJCaHlPRXVDcjIzb3cxckFnZUVVcS9F?=
 =?utf-8?B?ZHVja1o3UzZ2eENUQWtFa3lBRTF0TUc5R29kSVRUYUI3UEJtVlJpV3BscVlE?=
 =?utf-8?B?Q0lDYTE2SUpXTVdtSjNVT0pXMUR0L3drelJlNU5qMGErN25Yd1N1aVZmVWNX?=
 =?utf-8?B?Z0U2cE8za2dUT1J2UjhGakxNd0NQY2Y2NCt1UTZIbDUrRTNFaFBYTnpBY1pH?=
 =?utf-8?B?MUVRT3Z5YWg3aTJJY1JQWHlnNzZZd2dicUhxUEdxNy9OTXQ3aTlXaERsY2Ra?=
 =?utf-8?B?SjBvV29UejZQSGsrRzlmeXlRSmZWb21tNk1WY0NyVW1hNG5GbzRJWjQ2UGJw?=
 =?utf-8?B?a2pFNzBsRXZNSmIxa3UxaGFDaXVDL0krYkxJUi9Gc0ZRd2U1bE9YWFZYZDhu?=
 =?utf-8?B?Ymt4aS8xVHBydy9aZTRxSUd3YjQ0ZU5vcG9QQ3NIRXZPaWdVV1c2WkNoK0FM?=
 =?utf-8?B?dVUrbGVjRkh2d01XalE1YWwyUlo4cTQ1TDN1cE9RaGVxRTllMDRhUXdCMjBW?=
 =?utf-8?B?SGpaWVZhQXVxTXgxSjIwUzVKQy9VVzFKa1l5TjVVMDdvWi9PYkhZN0c0OW9D?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969d940a-9dc8-4d31-f16a-08dacbfb1f34
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 20:01:04.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5U/kkA0s6VLC2GpSUyKFOb6DhNLtvxIdXd7+CvjIHKMlOHJq8Vdiknhn5Xkr4lU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2774
X-Proofpoint-ORIG-GUID: GxFa1KGFmvYT56O882rzaGpoogGMkeaG
X-Proofpoint-GUID: GxFa1KGFmvYT56O882rzaGpoogGMkeaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/22 11:41 AM, Martin KaFai Lau wrote:
> On 11/21/22 9:05 AM, Yonghong Song wrote:
>> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct 
>> bpf_verifier_env *env,
>>           return -EACCES;
>>       }
>> +    /* Access rcu protected memory */
>> +    if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
>> +        !env->cur_state->active_rcu_lock) {
>> +        verbose(env,
>> +            "R%d is ptr_%s access rcu-protected memory with off=%d, 
>> not rcu protected\n",
>> +            regno, tname, off);
>> +        return -EACCES;
>> +    }
>> +
>>       if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
>>           if (!btf_is_kernel(reg->btf)) {
>>               verbose(env, "verifier internal error: reg->btf must be 
>> kernel btf\n");
>> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct 
>> bpf_verifier_env *env,
>>       if (ret < 0)
>>           return ret;
>> +    /* The value is a rcu pointer. The load needs to be in a rcu lock 
>> region,
>> +     * similar to rcu_dereference().
>> +     */
>> +    if ((flag & MEM_RCU) && env->prog->aux->sleepable && 
>> !env->cur_state->active_rcu_lock) {
>> +        verbose(env,
>> +            "R%d is rcu dereference ptr_%s with off=%d, not in 
>> rcu_read_lock region\n",
>> +            regno, tname, off);
>> +        return -EACCES;
>> +    }
> 
> Would this make the existing rdonly use case fail?
> 
> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
> int task_real_parent(void *ctx)
> {
>      struct task_struct *task, *real_parent;
> 
>      task = bpf_get_current_task_btf();
>          real_parent = task->real_parent;
>          bpf_printk("pid %u\n", real_parent->pid);
>          return 0;
> }

Right, it will fail. To fix the issue, user can do
    bpf_rcu_read_lock();
    real_parent = task->real_parent;
    bpf_printk("pid %u\n", real_parent->pid);
    bpf_rcu_read_unlock();

But this raised a good question. How do we deal with
legacy sleepable programs with newly-added rcu tagging
capabilities.

My current option is to error out if rcu usage is not right.
But this might break existing sleepable programs.

Another option intends to not break existing, like above,
codes. In this case, MEM_RCU will not tagged if it is
not inside bpf_rcu_read_lock() region. In this case,
the above non-rcu-protected code should work. And the
following should work as well although it is a little
bit awkward.
    real_parent = task->real_parent; // real_parent not tagged with rcu
    bpf_rcu_read_lock();
    bpf_printk("pid %u\n", real_parent->pid);
    bpf_rcu_read_unlock();

Maybe we should take the second choice in the above instead?

> 
