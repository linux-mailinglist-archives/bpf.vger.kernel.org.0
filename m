Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AF5AF879
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIFXnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIFXnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:43:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E9868B4
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:43:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286MX3mF004552;
        Tue, 6 Sep 2022 16:43:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZCHUPfijNM1TBewFaRUJE4QSUPZHRZyVEQEd/sklHi4=;
 b=bQfCoyCsEKkkiVL160G8P+weAbP38sjhblHAiI+jy50SKh0dtPb1OveoZTEYadzMzK/U
 576w+z934MS9y6idLeBCB0XyIeQzJeSQufA1swG5ZBGMb/puExlCGWP28qmzrydDhmAM
 iT2HCZwzEosZz9S6lF84x6ORgCVy/YfuuUE= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3je0d0x8a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 16:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKH1AauFJBcMT1OV++Ku7uBqhRa8FIkS+fJ6+gL0Edt0xsWFWtaB541nB0i5KptmTb1iIHFXQxv4P+LFGW+I3kManHaQ1253RjAHuHcAVRomqWScbI8ETIQ5tj6FaPGsewLa3NWRU/LE/7iOfCv4wY10Dvnvp6uaFoIB1mdvRyRWFh9mgtBn+CuYEKjrhWK+mZKnwc7lJdMhSf3YnvUfmwE+JKxMwdz7SEp+BwjgtxAQYKgtusSFcUvu2hrLqTBzB6hcIDLOimgEXf4ee11xlQ46XtV5JeIXGmP77lr7kFHkcuCQDDrtvaxVhO2xemrM/Kr5Y6vAp2GlyNTINaEiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCHUPfijNM1TBewFaRUJE4QSUPZHRZyVEQEd/sklHi4=;
 b=fpe9mGaLsJUqFDy6Mm2TlMmeel/iJCi5dOy6sA49Dtz35iwH/JFeDMTLGSrATiBbDQMI1pyNld17Bn2GU4L7YJfIQfK0bIEdcspZVQRfH/UXGYLiYD4OF+jIKOUKbpi52NO9q1kJ6vJcrf9OeKtnA+Oc/dX72I3DCPL6RF81Z4wquvI5Q0MJtXGrQJrS3GGouhCbWHvpcmLun/ieUTmpum92G5HSm4x63PfreGvFqH1lNFV1DgRixMH0GOCvq0dvA3f1FKWI+4xhIR5ZC52VBadb2LBzz6YJTwIxv4KVi8Ic9I4caMV6Cjf2YtPyeipN19SdAyksk2cGuaUSzECVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by CY4PR15MB1669.namprd15.prod.outlook.com (2603:10b6:903:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 23:42:58 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 23:42:57 +0000
Message-ID: <93490d2e-6709-e21d-a38a-40296a456808@fb.com>
Date:   Tue, 6 Sep 2022 19:42:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
Content-Language: en-US
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
 <20220830172759.4069786-2-davemarchevsky@fb.com>
 <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b397edba-2541-4fc4-4454-08da90618701
X-MS-TrafficTypeDiagnostic: CY4PR15MB1669:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8YxO8Lc8uWT9GC2vhuUuRRD0IykbRRwYb+DvXN2hE4K2LyJIxlr8z58UJrIxksEVRjljVJ39zsbie+7at5NNVJLMxbM9iFADb+yxm2PDlCceHSDYwRTioqBwCZAR0kCCBJgrsb+rXkiSFyZqG1PFaxiY8KdtjFdIFQMhsTwDkk9QIGbyjSG0kmNtAj6Jmlh8QZWG0WpbQBm4ta5sajTQfLc965gfu5TKg2QDsU9BPRo8Pm5Tw5X/qP/8k0efJDYViz6PJvFDqLr71X4ltvKHvKfGZJcxHep3tG1ain4OIF+IkjSJVjQxcAwGR/e4nEe0moZkElrfn3Cs/oRsrO5w/m2qTh9HRgrd3Mpykrwn6vtc6MtfniLnFkSReRPtbLrxqrQtB1muhr1NqTI50jcSSnMbCqAqeXLTIlBu6HFUUypJ5L4gKWNp+4lrVZgV2L/rJyLQwA+QTKc9VLgx2T6OKYPd2H6n6bBE27j2H+dxcned7bh2JF654tkTvALLbSQI/lhJg+uEyGuPKNKmRSFr8pSSvYxShldIlgNdq1E5EpeCGTLj5McwfFG4BSDWNw3XewajUjngjK/+seP32ppco0udkOepMupjeIbipm2CpCfZbS0c1EW5EkpupdbPGeBaOo7YdQ6OsIEP3ToocnVyDIfehzA3RRdjQUwEjDqt7TxS2PBbrq4erNtVekIJ0qhClJtFS+kPQ5AUGWBP0BCv8jhEf235bCPGJoRKB/AkY6Zxvs5TUMgvQauccje4NzM+1BhzD+TU4D4KgOZYVMlZ8BihaTIf3l37IC5GpOONAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(2616005)(8936002)(5660300002)(186003)(2906002)(6512007)(41300700001)(53546011)(6506007)(36756003)(31686004)(31696002)(86362001)(83380400001)(6486002)(478600001)(8676002)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnljNFJNOVprSGl6ekNFNjhxK2FQUStNZTFPKzMzU21aVjhsRGwvOFduVkth?=
 =?utf-8?B?RVQrRmdtL2k1My9DUXFac1NkaFZENEUxTDNxaUNtRHZjR0JLTG1BUUdBTlNm?=
 =?utf-8?B?VlcxdjRPaWgrcmFTZVVNVC82NXdFTzBYclhadUZHcExlUnJvTG9GV1p4NlZv?=
 =?utf-8?B?c0YyTms5b09NWkV2MFVBM04vTnVxekdvMCtpQ21JemdhNkZWcGhiMkY4TlZj?=
 =?utf-8?B?c0s5a3Yyb211cjl4UEFBemFTdDBXc3AzVWc3eERid0ltdDdZZXVveGRMOE9B?=
 =?utf-8?B?d2Q0SlBhbVVHWTJwUTdLWFhxbHNuWG04SEgxcXc1ZFJXT1YrdVppNnk2NU9Q?=
 =?utf-8?B?UXo2Z09nVE9yRUNFTzBCYnJnR0pMRlg2VVVPSndsclppN3lvS1lRcDcwVjZN?=
 =?utf-8?B?VlZqYmVkbE5ZU1NpRkFVUGQrUUU0ODRUTXhmdHZOY21ONC9zcDI5cHJQTThK?=
 =?utf-8?B?TVNwZ1BhT0tKS3pUeURnWHRVckowbnhmN2lWNnRpbjEvOVhURlpCU29XSmt1?=
 =?utf-8?B?MWtTVHp6SUozSHRlblFOdzR1N2Jnckp4RUYvd1hCaHF3RUl2bmdzVWIzSkZr?=
 =?utf-8?B?S3pmSWVwa3ZHOUR5Rkg1S2lUUmRwRC9BRGhQMitSeFNOcTVqWjh2S3d6RFRy?=
 =?utf-8?B?aDVUSXlmbTc5dHlrREVkSURwRk4rMmJERmlpY01JN3lmaC9xSUdLY2k1OTA3?=
 =?utf-8?B?Tk1JQWJlTzFpY0c5RjBIdy9tVmZoMWRON0orQm5HYkF4RTgzZXZoYThKZFJM?=
 =?utf-8?B?UFVWWXhxc0F2WEdyeWYzei9KSUpHQWZtTGZyTy9SbWV4aHYybGxrSkZ4eExB?=
 =?utf-8?B?WmlHbzlWcVZselRCdHVGMkxQeWJSVXo0dHdtVHZ6USsrZXluYUErVHlWZm8x?=
 =?utf-8?B?Q3V3RnlpeGdFZkk4VjNOT2V5Q3NHVGNXWC9KSXE0bExUNitRWVBaS1dQMG9C?=
 =?utf-8?B?UkdUS1U4ZSt6bTRDV0FJdDlNbzd5aUMyNzc3YUU2SkhUbWRlVGVFVHFXTm9G?=
 =?utf-8?B?K2VPZ0oxUVgwTUFhZEF6bWFtMUVrN1ZFSVR2a1A5RzhsTG50RDgzZnpiMkR3?=
 =?utf-8?B?bEhGajRhN1ZDWE5OeXlTcisxWXhpd3VFd010ZTJTQUx6Mzl2KzZudmFOYzNP?=
 =?utf-8?B?S0czYndjTEpBMUhqU1crem5OZjdMekxqVzFvMXNVYTNyUkk3VzE5NzhJTmNE?=
 =?utf-8?B?b253OXV6clRUZGRLNUNkU0hXRXREamx4RW1ZTnc1LzNPQm9Fckx4bWtXQlN6?=
 =?utf-8?B?c1BpTmcwMXEyTXpGNUt6VzF4WUp1Z3FlQmxHQTBMK0M0dnMvZ0o2eXFXd1pW?=
 =?utf-8?B?QWw1b283dGxNWlZIcEtCTEIrQmpwbWFtQzdkNlhpL3FQam4rTG5WL2RROUR4?=
 =?utf-8?B?ZE56cUlHZ3prb2kwamx2aE9kdEdOT05QNmZhVGJxOTBteFMwd1hLSDFKSGxu?=
 =?utf-8?B?dU8yaDBrblFJc2FNTjZjUUNuMWY0T3M3YlBWRTRlSi9tbkRPRnhuTWMxNTJn?=
 =?utf-8?B?OFlsQ1dsQWdGUzJVRlhCUDFXZTNrYnpVREk3NHF2Vkk3eEtRL0dYMzIvZnNP?=
 =?utf-8?B?dGZrYVdqdHF3RU4vS09jL1hlUlB2Q1B0MlMyTkthUThvZHFXV2VEUWI3NHJU?=
 =?utf-8?B?eENXalFzMnpObXdCeTBKRlFmeUo3blVGdWp0RDg5VW5KVUhuOHVPSHJZQW1w?=
 =?utf-8?B?M05WMC82Tjl5c0haSzZKWFpLckE4MHRMb3FvRXFyOHYvd2hYLzduOVBXTm9M?=
 =?utf-8?B?dlNycTZtYnk5VWRkTlY1RjI1S2RoSDhHNjNYVjhTdlc2N1FTRlNYazA4MW1Y?=
 =?utf-8?B?cHVkOXlVOFEvdko3MWd6eU5LRkYyREZ3K1dFOEpaMy9JdDFHTFAyK2JnZ1Vz?=
 =?utf-8?B?bGtTMnFFR1ZFWExyOUpoTjdGRnVLQUZXamJDOW5acXc5QUZwNklWQmc3UUtU?=
 =?utf-8?B?eE9RaXR2QjN3NndhSlFCSlA2Q1RaZnlrdHpPTEw2UzdRdUdrVXR0c2R1bXl2?=
 =?utf-8?B?dGZhd0JZUEV6VlZ4Z2Nabmg3aVh0R3Z6WWNJWlI0MVZpWVhxOTF2bUhyMmVM?=
 =?utf-8?B?NUFTZzljOXlVMWdLZWx1RktoeVp0aE1BbG5ieVM3Q1IvcGh5YUdKRGJ1ejNu?=
 =?utf-8?B?b1U0OUorNnNPZ1I2L3hhL1l0VTVVUTRlSGFsNFgyNmI1NVlhZnAwWHVkc3Nk?=
 =?utf-8?Q?YxkFHT/eIz4akp7+VbsBt64=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b397edba-2541-4fc4-4454-08da90618701
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 23:42:57.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q45UVVoTrCx7a2Aafs4JhU/FuFrU1CEGNg+thu6tw7ICiHpCs3T00ZzLonqQ9z4mOugJVUPcI3Wt+7jVwWstg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1669
X-Proofpoint-GUID: 9CNIKRWaRv0BXDydrZxBARFr36d4ht-a
X-Proofpoint-ORIG-GUID: 9CNIKRWaRv0BXDydrZxBARFr36d4ht-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/1/22 5:01 PM, Joanne Koong wrote:
> On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> Verifier logic to confirm that a callback function returns 0 or 1 was
>> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
>> At the time, callback return value was only used to continue or stop
>> iteration.
>>
>> In order to support callbacks with a broader return value range, such as
>> those added further in this series, add a callback_ret_range to
>> bpf_func_state. Verifier's helpers which set in_callback_fn will also
>> set the new field, which the verifier will later use to check return
>> value bounds.
>>
>> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
>> value as the latter would prevent the valid range (0, U64_MAX) being
>> used.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  include/linux/bpf_verifier.h | 1 +
>>  kernel/bpf/verifier.c        | 4 +++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 2e3bad8640dc..9c017575c034 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -237,6 +237,7 @@ struct bpf_func_state {
>>          */
>>         u32 async_entry_cnt;
>>         bool in_callback_fn;
>> +       struct tnum callback_ret_range;
>>         bool in_async_callback_fn;
>>
>>         /* The following fields should be last. See copy_func_state() */
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9bef8b41e737..68bfa7c28048 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
>>         state->callsite = callsite;
>>         state->frameno = frameno;
>>         state->subprogno = subprogno;
>> +       state->callback_ret_range = tnum_range(0, 1);
>>         init_reg_state(env, state);
>>         mark_verifier_state_scratched(env);
>>  }
>> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>>         __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>>         __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>>         callee->in_callback_fn = true;
>> +       callee->callback_ret_range = tnum_range(0, 1);
> 
> Thanks for removing this restriction for callback functions!
> 
> One quick question: is this line above needed? I think in
> __check_func_call, we always call init_func_state() first before
> calling set_find_vma_callback_state(), so after the init_func_state()
> call, the callee->callback_ret_range will already be set to
> tnum_range(0,1).
> 

You're right, it's not strictly necessary. I think that the default range being
tnum_range(0, 1) - although necessary for backwards compat - is unintuitive. So
decided to be explicit with existing callbacks so folks didn't have to go
searching for the default to understand what the ret_range is, and it's more
obvious that callback_ret_range should be changed if existing helper code is
reused.

>>         return 0;
>>  }
>>
>> @@ -6906,7 +6908,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>         caller = state->frame[state->curframe];
>>         if (callee->in_callback_fn) {
>>                 /* enforce R0 return value range [0, 1]. */
>> -               struct tnum range = tnum_range(0, 1);
>> +               struct tnum range = callee->callback_ret_range;
>>
>>                 if (r0->type != SCALAR_VALUE) {
>>                         verbose(env, "R0 not a scalar value\n");
>> --
>> 2.30.2
>>
