Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982015B289B
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIHVhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIHVhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 17:37:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F2B655F
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 14:37:03 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288LHCQx006796;
        Thu, 8 Sep 2022 14:36:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MyRKTK//TsGRrxsVMZgv5Q6yQjQfXKsYnVu+8GfK9U0=;
 b=IjjTwnEB494Vc+mHEmPkStuEEtb4YURpDyhEFbNImM6VQZBOl/NMCaMAbD0+3if2SsUy
 cwp83UgLjp/bGY2y+0sXh6cxxRXf3ucYbSHFidbnQ1oQCTnajwo1kcDKiZmiocXngTdb
 2nOtlX8JeBTewLGAP8JBqJifd2C1ma6746E= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfhthbe9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 14:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmBWomBVZkFFFQHQAx5nD+k6Nc8Xia3DsCR8QgdoSQtdvPHySrwxQtN0xvMwLutINHXFDx8B2Li7EMCWxn2O0tm30opuEk/pub2ujrwkjaDNV8z9IZixPvfTSUpR3t8b4QSk49H+EVSa7wDoWuQD3h79GPecZ9qXvkosSvN84uSNJOMr5kn+VdX2OVlN/eSLj21exDWgwkZRGVDvFRpnbdIH1leliBAsdEMlM/ojCWyGjx7nrOToh5UXMkGZmdHBkp3KQYltpZW9qrGgyzuRttjtKfph3Wex9BlI5HMJbFRnzu9QMszj5mPBoD4WinDSR+R7Bod7JDmjljMJdaJeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyRKTK//TsGRrxsVMZgv5Q6yQjQfXKsYnVu+8GfK9U0=;
 b=gAiq6uGyUOZSeL1P1rNQ/uYrIEVQc9DDYsU+QVrWkJ0URHTxpKmJmO6HZNX0Sxw7rViTpUkcsdPL+/YK5xhNxy8zA9PFZPZfjIPLAFujtVSuYsIvbfqg8UCq/uugTPBG9zE/k2Ys3ANL1+UVqd34XxRNOJKuK5Edx605dA47ZWui1Vj/07VSjM144gOQzslLsNrcDphxV7Ia30YMLpUe9VlCAxebuwY4LWlgvj8ogouEWt8pOBQYXW1rW29nqkuph8kMGB3Er18e/XpDm+VCZ5N62cXPg3xfmwR2/QWDQJcJ3khgRZLbutSBJp2JJL2zr+qJoFQUEeGrdL6KO8h2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MWHPR15MB1120.namprd15.prod.outlook.com (2603:10b6:320:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 21:36:45 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 21:36:45 +0000
Message-ID: <687d070e-6607-7aef-0d84-6c7dbc0b574d@fb.com>
Date:   Thu, 8 Sep 2022 17:36:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
Content-Language: en-US
To:     Alexei Starovoitov <ast@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
 <20220830172759.4069786-2-davemarchevsky@fb.com>
 <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
 <93490d2e-6709-e21d-a38a-40296a456808@fb.com>
 <2d2bd4ef-e8c8-194e-1d12-a45bb63c9b44@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <2d2bd4ef-e8c8-194e-1d12-a45bb63c9b44@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12268215-52b7-43e8-60a8-08da91e23a6c
X-MS-TrafficTypeDiagnostic: MWHPR15MB1120:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwEPj1Fy8+rXYovxWyvV2YHzV+fHgGfN4RzywNLvAwGkFPvCyaqFkh5rZOQbsRHytlhg3ZTirrAfHyEGCrrkmnMBo6PPCaOsEHUaq0DfR0QQpIE72IsLWInSP793yJebtYeEDOE7ij+f+dT3Cl50whmEg6sk1xLUb0f0wNr7JbSfOvvtPkaQx0FocSFo/m6r1nKZc4uzij3DHbFjxYcDEmOVp4ki7JS4ftAHbwwcybYGqO5UKPHR00ppZRhJBtgJgv3EmWnPyivdVFmSUT1zt+3FHyEAjHEQrUTkjfXz7eqlHiDulPMZwHysUwVUcHlJDxAzOYVZOqI9IZGoydY7Tla9+cBf8pNiYNJftC6c7uVCoNoqOreANqZDN1+3S/TQaEWE7ZU78bPDpE9jPf/6KV/9qjc8HDlK+rwyS2rYCFh81Yn4blIGwn7NZAWzWonZLE9F/2XVvzy2pvNrqVF89MsadLEogWNXy4HJxZAfNhq4N7daJqqrLcXrmbtrXiQ5Cs9Vu3NZfbKP98QvOtkT2csWo6oFAkx85RccGM/+wN5tVJ9dOb7HERf/rWGtvqIvceH2byYY5oz8OdQYAJJgw5qtBwrvmwArue4qVY62TmXqsHq0B6JPDq+SO5qmXjpZ0b8+NJTMjJ506jWbo1B7ws0GMxGFYXnECzMdF9teTySz7DNMGRlDh8aolaqtHe1G5n62JKTyZvXCgdV2hXK/NWEpZt9/vNTa/g6trP+6S2MNJ3rBE0JpmI6D72QR93pZnklzNDbCjrqDgdIIMLn3/c4zYKjiRZlgoRv0LVAtvVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(6506007)(4326008)(86362001)(6486002)(8676002)(53546011)(66946007)(31696002)(186003)(66476007)(66556008)(478600001)(2616005)(8936002)(5660300002)(31686004)(2906002)(36756003)(41300700001)(110136005)(316002)(6512007)(83380400001)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXRCV3I1eW8yM3VndkxETDZJK2gwMm9KSGZkWVpETDRlbm1XKzBJNWQ0Y1NM?=
 =?utf-8?B?SGZhM1dtTzVjQWNPMERBU0RueVJSTkQzVTVuYkJBWWRpZmpOczNyMWhFa3Vw?=
 =?utf-8?B?ZWZjSkxxUUIzaUp3YTc2ZWZnb01HWExrTjRQNGlaSHRqbUNqR2Q5U0QrRDRp?=
 =?utf-8?B?M2NMdnVUUnRVT0tZUGJMVm15Tk9nUzN2S2owV01VcUZwdDQyU3piNG9ua1Bk?=
 =?utf-8?B?K01RT0R2ZUp0Ym9WKzI1NHJoUEhKcFgxaHptTDI4Y1pnWEpCZTNTVmwydkd1?=
 =?utf-8?B?Ty9JRTllRzRmYXBnSjhzanNyOE5PUUNkZk9jdExpb3I2bWsyL0RIMEFDU0V2?=
 =?utf-8?B?YWFiSTY4R1hxb29oUHcvMjhaSHRTVE56SUNHQkpZN3o2cWwwbHhJaXpnNFFo?=
 =?utf-8?B?bDJObkRnV3pHMjZ0dExVYXZNVjBHRjNnN09ic2JLaFJmcW9XaUhETzFzckxh?=
 =?utf-8?B?UUdEQjVRb1RJSXhrdzdiREl5aXBxU25rYkF6dTRhT2l4ZE5YbXZPdy9nblBu?=
 =?utf-8?B?Tk16Vm1TTzBhVFM3RjhJZEhiRGJEUmZ5TVV6OEFRbGFvd2c2aWUrWStaVVdO?=
 =?utf-8?B?UXJFd2ZkRzdTOE5ZZEE3bHRpQ2J1VVVaWU9ydC9FQ1ZVUGVKOVk3WW5Wd2NV?=
 =?utf-8?B?Zm40Q1VnWXY2QnZHd0J2Y2dIV0tEZFU3YVlUejdWY2YwRzcvK093VkpXTzAx?=
 =?utf-8?B?dHhsN0ZCS0QvQjNmN3dOc1hOdmsvN0swSWtOVFlBSVVjeSs3bmJxU3d1SnFw?=
 =?utf-8?B?ek1wNHZ6Y3RGckVET3VOc0l1ZVJkaFFlekRwdGhwcWY0UWtaT3RLU1ZvaG9n?=
 =?utf-8?B?MkRScmxsbzBEcGJ0dlJaYTQ4eGYveUt2SGNXOHB0eWlEOWt2UnhmT1N3Lzcx?=
 =?utf-8?B?OTdpZEovUlJFQnplQzlNZkRIclRzNUtMejVSVi9ZclkwTXZIMVozMXF4Y0g1?=
 =?utf-8?B?dDBEcENTeGJJclZMaEgxcjFFeEdjR3NVb1Z5bU5PM1l5R1hOQzlvZElWWU8r?=
 =?utf-8?B?Vnl1WStCa3Q1TVdqRkNFL0VLd1N0S1hqcWJ1Z0NwbnBSU0NibHAySEs3MElm?=
 =?utf-8?B?QWdJc1RrWm5XVE84MGdYenBYZDZQOTcwOWF6bmxuUUlVejVBQlVTVk9lMGti?=
 =?utf-8?B?aHhLVHZoTXN0MGJjUkk3Q05kSCtuaWdsYWIyc1BhSEQvT1Y5SDJyL1psWWZK?=
 =?utf-8?B?UlJmNkZjeEh0OHVDSjZVcHFVaUFZcS9SZTdBWHZGYlV4L29BdDFwOXk0bFQ1?=
 =?utf-8?B?M0FsSzZTamk0ZS9iRFpsZ1lQUUVCR05iWlRCL0I1SXNuZEMrMU1VOGpab1gv?=
 =?utf-8?B?aGFtRHpSbVRsMmE2elBZZ3dVaklmd3NMcC9nbE1CMmRBTThQTDNLZFZ0aHZH?=
 =?utf-8?B?NjZtYjZKZ0VsTStlSDRrTW5ubnhva0QxVUN3dnhpS3JzMHdaNWFoQnF2OE1n?=
 =?utf-8?B?SkN4REdUODRYcEttcW9SSFFxSjNZYzBQVTZ3NU90VXRBbThpR0VzaWl0NUt3?=
 =?utf-8?B?emI4NmgwMzF2VURQNGhjUzR4VE1ZNkd0SWxDY3IvVmpDanZoQktBMlNtSmVE?=
 =?utf-8?B?RkFNMzd4MEVMaGtNOGtpUkdEeFdLMWFnTzRONjRvc1NYdHM4TU52UENPd3hL?=
 =?utf-8?B?M0F2Q01uakZUMUNKaEpkVk9MTVVtTERiMjdPb0NaWHFwdWhURnJ6Sk9qTFMy?=
 =?utf-8?B?QWx0amNham8xUTQ4MEgwckFQa2F1WG1wNUtSYWZCZUxac093NWdCRTFUZTJm?=
 =?utf-8?B?K3NjYU56K2VBRVhYem9zRlM5Z2JBTktLMXNvbVcwR3FoQ3FtWDR3c2hpamZF?=
 =?utf-8?B?bVQzL0h4TXp0cUFsY3FtZEpVY01jQXRiWjlJaFpoWlBXRXNVbFV0UzlVQmQv?=
 =?utf-8?B?TlZCdThwVEFUWnN2NEZKOWZQb3crRHgrYWIyaGhMNDdibSt4TXJQTzM5c28z?=
 =?utf-8?B?SmlwNVNxRElCbEZPaVNqWFZ3cEVia0l4L0JZcXU1U3JSdDBLVDNVT1F4VjE3?=
 =?utf-8?B?L2JNOWd3TitTTmdFRTBUUnVBS2FINmZUa09OZWhlNVhiNVhFTXowazdiRkUv?=
 =?utf-8?B?OEdsdnQ0R1hsVlpDcHljN2FQZWVzWXQ4TVFoQW52Q3ozY0VDbmp6NzBqUDJl?=
 =?utf-8?B?dHdhRksrTTBYeHV1NXYvR1hlZlBlNnAyaHE5REdUM211RGZFQmpMQUxubFB1?=
 =?utf-8?Q?iM6f1CI+FuRB+/e2c8l+oMQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12268215-52b7-43e8-60a8-08da91e23a6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 21:36:45.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/Ap53Vi8oDjf5EZ74vaDFBLIHPELJKlgVwHeke12opal4Ql3Rh6RxDq+1tGcf1X3nbNQiUbli7t6siuZgw1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1120
X-Proofpoint-GUID: TlQU5a1UUOlR0nu8SPXfEblJDqfALeS8
X-Proofpoint-ORIG-GUID: TlQU5a1UUOlR0nu8SPXfEblJDqfALeS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/6/22 9:53 PM, Alexei Starovoitov wrote:
> On 9/6/22 4:42 PM, Dave Marchevsky wrote:
>> On 9/1/22 5:01 PM, Joanne Koong wrote:
>>> On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>>
>>>> Verifier logic to confirm that a callback function returns 0 or 1 was
>>>> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
>>>> At the time, callback return value was only used to continue or stop
>>>> iteration.
>>>>
>>>> In order to support callbacks with a broader return value range, such as
>>>> those added further in this series, add a callback_ret_range to
>>>> bpf_func_state. Verifier's helpers which set in_callback_fn will also
>>>> set the new field, which the verifier will later use to check return
>>>> value bounds.
>>>>
>>>> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
>>>> value as the latter would prevent the valid range (0, U64_MAX) being
>>>> used.
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> ---
>>>>   include/linux/bpf_verifier.h | 1 +
>>>>   kernel/bpf/verifier.c        | 4 +++-
>>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index 2e3bad8640dc..9c017575c034 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -237,6 +237,7 @@ struct bpf_func_state {
>>>>           */
>>>>          u32 async_entry_cnt;
>>>>          bool in_callback_fn;
>>>> +       struct tnum callback_ret_range;
>>>>          bool in_async_callback_fn;
>>>>
>>>>          /* The following fields should be last. See copy_func_state() */
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 9bef8b41e737..68bfa7c28048 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
>>>>          state->callsite = callsite;
>>>>          state->frameno = frameno;
>>>>          state->subprogno = subprogno;
>>>> +       state->callback_ret_range = tnum_range(0, 1);
>>>>          init_reg_state(env, state);
>>>>          mark_verifier_state_scratched(env);
>>>>   }
>>>> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>>>>          callee->in_callback_fn = true;
>>>> +       callee->callback_ret_range = tnum_range(0, 1);
>>>
>>> Thanks for removing this restriction for callback functions!
>>>
>>> One quick question: is this line above needed? I think in
>>> __check_func_call, we always call init_func_state() first before
>>> calling set_find_vma_callback_state(), so after the init_func_state()
>>> call, the callee->callback_ret_range will already be set to
>>> tnum_range(0,1).
>>>
>>
>> You're right, it's not strictly necessary. I think that the default range being
>> tnum_range(0, 1) - although necessary for backwards compat - is unintuitive. So
>> decided to be explicit with existing callbacks so folks didn't have to go
>> searching for the default to understand what the ret_range is, and it's more
>> obvious that callback_ret_range should be changed if existing helper code is
>> reused.
> 
> Maybe then it's better to keep callback_ret_range as range(0,0)
> in init_func_state() to nudge/force other places to set it explicitly ?

tnum_range(0, 0) sounds good to me.

Would you like me to send this separately with that change, so it can be applied
independently of rest of these changes?
