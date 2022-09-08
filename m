Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E15B29EB
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIHXKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIHXKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:10:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D4B07D2
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:10:21 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Ml8ho026885;
        Thu, 8 Sep 2022 16:10:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Kayux+20FxnmuSheiUdmvGeoGRcv62XzuygkLttTs4k=;
 b=Vkqpki7bPoFKsDMxnA/GFFYL2FECe21tLKS1DlwdngkF9PToefcSYV0a4pisQN4vdjwO
 4O3V19UQhmLrzRaafsDRU2d9N7fpRxyU1iqeJrqaUYmAVO0h0rdaeyyXVnvkKWAWxwpR
 Vp5o42LtLhoj9oMNIULv98RxAhAwSrQoaq8= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jffdxcsns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 16:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYpvFqNP/Fap+1nD5VcvqEqsut3kH52ZjitX0+21+Br3ljhrQ1BMvfB/IKIeUQlFkm9fxc6zwi+9BhCl8pAba93HO8YlNntQdp4Z5UxSblTAz1SWKGOqr4Be1tJJj5+92DJ32bwwh6nkhk23mp/G0YbYX/mBY/OV/X6zKci4px+zJ+vlQJYZJMVU6+nbeqEbWmiMILwBjeOYLB02jBUSWM8kJjfTqVyfohFnQrfIDNvk6maChpUAf4j5Ai2BO0Fxrz5/ivOzQkTAeW8e2AZwX9KA1Kg7MlsmFHc/H3/Bvo399jnpmV3vpwmzULL/zrsBuBYjO8WD6S2zR5RVZMai3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kayux+20FxnmuSheiUdmvGeoGRcv62XzuygkLttTs4k=;
 b=g+aS4zP8grapxxl1H5D2ajT41i9JBLNETIZuK7QVrlQ8jdEi5UYPEnIRSMPXrdi8y+ru3OU9e1PALgcrkQixIqI3XbFvM56sfIbRWUS+hviANh7jv6wQuMnDWJBYSp4paUS2QCcICgfybUhxPBnyGPpfq5GUaOn2hdqQttFDoZcZS+ER6TZ3MecRB8fwHo7eMJ+7PdkHDsVdOLH3USrpeMhENonN0oAIV8hgoMqfP/DCXZGDkRdtJuFboL3a3HUtx85IWEResC/SvOIPI9WqUYvwpuw/rXn1du3rc7d0WKb4BbPdBFCLA53dE4RnHmFsVHfJ1hIq1WYM0KOYzp9H0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BY5PR15MB3620.namprd15.prod.outlook.com (2603:10b6:a03:1f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 23:10:05 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 23:10:03 +0000
Message-ID: <054496ea-abfa-4ffc-e30f-4a05f851a36a@fb.com>
Date:   Thu, 8 Sep 2022 19:10:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
 <20220830172759.4069786-2-davemarchevsky@fb.com>
 <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
 <93490d2e-6709-e21d-a38a-40296a456808@fb.com>
 <2d2bd4ef-e8c8-194e-1d12-a45bb63c9b44@fb.com>
 <687d070e-6607-7aef-0d84-6c7dbc0b574d@fb.com>
 <CAADnVQJDNLjPUuAK7ONLswwJq-qXZEVUj2Q8bvQbRG7DQuobyg@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAADnVQJDNLjPUuAK7ONLswwJq-qXZEVUj2Q8bvQbRG7DQuobyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a37f71bb-01b2-4565-7bc7-08da91ef433a
X-MS-TrafficTypeDiagnostic: BY5PR15MB3620:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2He/jLxBLXePwMWa48ELuyahGIBnXSJuwBZvkoy5TnpAe4iAUcVXz5WSCtlhVe7DY7HeBahsC9T6fmztIyNBzCuFEXkE4YOqnJleGYNBLwXL5wWtOcERO7/PCcbyAXVwupOrgyz/Oc4nQpEzKFMaSnm1D4EAiOOORhJIt3XlQkgs8vlrOwikwvqpWabxbIieDqFUBvXB47ivObva5Srz1r2RCiemXiWtMuGux+EYcsPn9vI0RJAOnEfK1SEX8YPOoOLBKcPYw4zpvmM8/Ts/EcuP9eO/FyH6utvYzC1DI1scroQwN4DAv7Stn+EbmyNCjLKquLk50R0kEaBa40HKB9/PlBL285oFQ42pd/hJzNMaNo7YLTDlrC3Rj/xx6XG5g2BvjjgVBIUDxtW+C7qBfy2yr/YfpG/b0HrX3rCuY8ax2CkVVmQlvRxkJYu0fB/Y1frbeYCB7AfvRGP2v0FlBf3SnTYg5gne7whQ0OB/yccFs22riWeJ/xrjB3vTCTrOauzJnCfXyF8i/qIEpkVxbFcvxKtJJAGVdpZ4ciwd+ktwXMsOEAqGs6co+LaWMzDi35sv1g+dnEeNNN8xzXBCpMaJUq/nlLKJYBp4usUB1gDS0x6kBGsI++ihIQkMUESH+GdM7kJF/3EFvZzGdssIR5ek8Xm8/bZd7dr7dKSntQZvVpRxOaOwr/QIhH8jTBlUD9sHZ6wC12XkbbBZWWneXvr+//c5W87dkZli/QtDhlo5BPKsDUKrbrNftSM8Z0CbStixNaQvpScd6La6bX2YBxJ54ZL2Fm0l2J1hF4AHP6T98D3Ml72VFBs8vknvatF0e4ZedNBDIz+qhSN1lLmdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(66946007)(38100700002)(31696002)(36756003)(66556008)(66476007)(8676002)(4326008)(316002)(86362001)(31686004)(83380400001)(6486002)(6506007)(186003)(478600001)(41300700001)(6512007)(54906003)(966005)(6916009)(5660300002)(8936002)(2906002)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5Vd1NpT3lMTkdLQVp6MEFIYW9FcFphcDFXck5ZSGQ2TUhuNFFnNFE2NEp6?=
 =?utf-8?B?TjdVcU82YU5iS3lkNFpweHVLMzc1UDBaZitnR0l5WmF3R1R6YTRBclEwM1lv?=
 =?utf-8?B?TVpjS0NWemRNdHZMMlpPdFJyQ1I0WThnM2ZKWU1EbnVuWnZBRkliZ2lCTGVF?=
 =?utf-8?B?M1JtQ3lHeU52TDdMc2F0OURiNTdDUkhJazhRZHgzVjBGYlhqakhtS2VpV0xi?=
 =?utf-8?B?V211THZkTnFLNFRkbUdFaHdKV1h3TkF4di8zc0xTSW1YQmFYbUdmQkE0UVBH?=
 =?utf-8?B?NXhKbndtYzBabGVxa2lRTTA3SGFVOE44ZDVDK3BIamVJY2hyRHJrclROTzFR?=
 =?utf-8?B?OTA5QkxOckhVc1BrN2gxT0pOSWtBR0c4UFdMUjBGcVRjS2RMdjNjNVMxSENz?=
 =?utf-8?B?NGs1LzN3eGc5bHNmd1VjOG1vazBGRFJVVzFVMWE0QU5ZcHozenhzOFEzeUpT?=
 =?utf-8?B?N0hEb3JyN29mNEY3UTlGTnpVODBpMStOUlNpeGZmazVUTElqU054MUhkeDVi?=
 =?utf-8?B?YitSOXJoN0luQk0yaXlhYit3ZFpWbEtqMUZhRmdYbkJ3YXU0VnNTejhSdktS?=
 =?utf-8?B?ejR3MHN0dmtiWTczbExvYzV5MklaNmljUnY0bUlsQ0QyYW02NmE2WTFTZGtW?=
 =?utf-8?B?dk80R3ZPVGQ4OUFlU1lLSDNHSlhWOEs3NCtPNDFraGwrR2xWdlhmNWQ1Q3k2?=
 =?utf-8?B?SGlTWEh2Q1FOeGtpakdYQmhxSk9JMm41bzRJY0lTQ0Q4UmQzMjhsNXM1TGZy?=
 =?utf-8?B?aUMvdFB0S084NnBkc2NhSjdpZFRTR0pMcGVXR0JOQ1dEd1RSLzdIalFuZmty?=
 =?utf-8?B?RDRPTzVNbHp1Zko2VTJZMW1CRUMvSVFUUE1Rb09yOWh1clVtRElSM1RmTzhI?=
 =?utf-8?B?UnZUeWZROCtsNm95cU1CdnloRWRtR2JYMVNXYkp0L204V1lzUTNDWVVzZmdB?=
 =?utf-8?B?aDlNemZwVk5nSFlrZXF0bStHaEkwZENUZi9oTVozMU1UOUpKa0xNUHdSSE8w?=
 =?utf-8?B?SHdDbmhVY05XSFBtb2FDcEgwYnMzNzgzVkUrL0l2TTNlMG1WZTlPV3djUHlL?=
 =?utf-8?B?c05udWY2THE3V3N6amtCN0xrUkdTUkE1YjU4SHFXdGpqam9icUFIMHdWTGEx?=
 =?utf-8?B?RjlSK3JsWk9wNkFrRnNNSUluRFRLTDFDRE13THJoRW0wUk9LcW5pMHBhcE83?=
 =?utf-8?B?c2tFMXBHaFpXQ1FFWmVzQzhJUldaMEVkL2pONXRJSFdKenJZSExFNURKTzl0?=
 =?utf-8?B?RGM1bTBhWVIvcDlkVmZaSXlFVjdJSENxNG9zNUt5SGd6aUwvcDZlWlJnLzRE?=
 =?utf-8?B?dkdCcFRXN0lGcW90aFRJaGZ5NzNSeTBtQUdJNlZObkovQ0k2N2JIak1zeXFZ?=
 =?utf-8?B?SnJoKy9Ud0dtaW9VZC9GMkJRVi9CeGE0anJBd01RWnRBdEFPT2hydVBvOVVK?=
 =?utf-8?B?Uk1JSklLaDVyZk5haDFRbW9nc3Z6d3ozc040b3Jva0RqWURkcm1lQU9pditM?=
 =?utf-8?B?K1VmT2JZakJMWGxWNHFEMGh2bURqNzhUak5EalFwRCt5VEVkTU1mUE9BOTZB?=
 =?utf-8?B?K1VsS25WSTN4clJVWVFoN0ZmUk1MK3VtVzBMSjdLOXV2Vmt4N01nT1BFQVBi?=
 =?utf-8?B?NVJiS0pZd0YxK1lZVzczTVlqN09iZndzaU5sOWlFMXdHV2lRWjFRRnpSSFpH?=
 =?utf-8?B?VzQ2b3JBcitoa1J4VkxNOUxLa1BqZjJOeEpHTmlnWlExVlZUbjVwRWZBUU9a?=
 =?utf-8?B?bkZNTVo0bTVEcm85L3lFOVBTK3dnQ1dXSEo2aE9PMHVQNVBLNUNCbmE3QnY0?=
 =?utf-8?B?Zjl0OGg2UUszZWdKNnpTM2U3dkh2d011RnpROUVIZzIyUzFaRzU2bEZwdysw?=
 =?utf-8?B?YlkwSDJmZ1N4cEoraXhYclNvQ2xSVEt1NW9PZGc0b2VmaGhRdTUzTEZEWTRx?=
 =?utf-8?B?RFlRdVpINXhHZmozTWNiYUJPbmNhZzNNLzhSUjFuc3N3RnFCNkZPK3RDUlVK?=
 =?utf-8?B?R1JaQkhZV1FEUXp5cUdhcDNRdjdkdS9RdmJkMHlrdzF3N1Y0NW9DZ0xoQ3VL?=
 =?utf-8?B?dFFjY0VnYjNydWN4MEdmbXdneU5FN2Q2VjQyMG1kTnB4YzUzZXFKclVoOUdx?=
 =?utf-8?B?NTVvUE9RM2h2aENyNzdFYzRTdEkwT3h1SXBEOWE0Q0R5aDRDbGgvUWJseWhl?=
 =?utf-8?Q?5kzyeEYw+ZFkdS6kkwUDQPw=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f71bb-01b2-4565-7bc7-08da91ef433a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 23:10:03.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7koBE4sJ1+Gb5bncHgOA83MkJUiSylY1bQtsPKmU1l0J5KF+SkFA6q6SnRxcwqRQDN1xinmduXaIsWEGdIQDTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3620
X-Proofpoint-GUID: oZDs7ezospWmNupCZMAaf7OvWwWy5adM
X-Proofpoint-ORIG-GUID: oZDs7ezospWmNupCZMAaf7OvWwWy5adM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

On 9/8/22 5:40 PM, Alexei Starovoitov wrote:
> On Thu, Sep 8, 2022 at 2:37 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> On 9/6/22 9:53 PM, Alexei Starovoitov wrote:
>>> On 9/6/22 4:42 PM, Dave Marchevsky wrote:
>>>> On 9/1/22 5:01 PM, Joanne Koong wrote:
>>>>> On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>>>>
>>>>>> Verifier logic to confirm that a callback function returns 0 or 1 was
>>>>>> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
>>>>>> At the time, callback return value was only used to continue or stop
>>>>>> iteration.
>>>>>>
>>>>>> In order to support callbacks with a broader return value range, such as
>>>>>> those added further in this series, add a callback_ret_range to
>>>>>> bpf_func_state. Verifier's helpers which set in_callback_fn will also
>>>>>> set the new field, which the verifier will later use to check return
>>>>>> value bounds.
>>>>>>
>>>>>> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
>>>>>> value as the latter would prevent the valid range (0, U64_MAX) being
>>>>>> used.
>>>>>>
>>>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>>>> ---
>>>>>>   include/linux/bpf_verifier.h | 1 +
>>>>>>   kernel/bpf/verifier.c        | 4 +++-
>>>>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>>>> index 2e3bad8640dc..9c017575c034 100644
>>>>>> --- a/include/linux/bpf_verifier.h
>>>>>> +++ b/include/linux/bpf_verifier.h
>>>>>> @@ -237,6 +237,7 @@ struct bpf_func_state {
>>>>>>           */
>>>>>>          u32 async_entry_cnt;
>>>>>>          bool in_callback_fn;
>>>>>> +       struct tnum callback_ret_range;
>>>>>>          bool in_async_callback_fn;
>>>>>>
>>>>>>          /* The following fields should be last. See copy_func_state() */
>>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>>> index 9bef8b41e737..68bfa7c28048 100644
>>>>>> --- a/kernel/bpf/verifier.c
>>>>>> +++ b/kernel/bpf/verifier.c
>>>>>> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
>>>>>>          state->callsite = callsite;
>>>>>>          state->frameno = frameno;
>>>>>>          state->subprogno = subprogno;
>>>>>> +       state->callback_ret_range = tnum_range(0, 1);
>>>>>>          init_reg_state(env, state);
>>>>>>          mark_verifier_state_scratched(env);
>>>>>>   }
>>>>>> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>>>>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>>>>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>>>>>>          callee->in_callback_fn = true;
>>>>>> +       callee->callback_ret_range = tnum_range(0, 1);
>>>>>
>>>>> Thanks for removing this restriction for callback functions!
>>>>>
>>>>> One quick question: is this line above needed? I think in
>>>>> __check_func_call, we always call init_func_state() first before
>>>>> calling set_find_vma_callback_state(), so after the init_func_state()
>>>>> call, the callee->callback_ret_range will already be set to
>>>>> tnum_range(0,1).
>>>>>
>>>>
>>>> You're right, it's not strictly necessary. I think that the default range being
>>>> tnum_range(0, 1) - although necessary for backwards compat - is unintuitive. So
>>>> decided to be explicit with existing callbacks so folks didn't have to go
>>>> searching for the default to understand what the ret_range is, and it's more
>>>> obvious that callback_ret_range should be changed if existing helper code is
>>>> reused.
>>>
>>> Maybe then it's better to keep callback_ret_range as range(0,0)
>>> in init_func_state() to nudge/force other places to set it explicitly ?
>>
>> tnum_range(0, 0) sounds good to me.
>>
>> Would you like me to send this separately with that change, so it can be applied
>> independently of rest of these changes?
> 
> Whichever way is faster.
> We can always apply a patch or a few patches out of a bigger set.

Updated + rebased and sent as https://lore.kernel.org/bpf/20220908230716.2751723-1-davemarchevsky@fb.com/
