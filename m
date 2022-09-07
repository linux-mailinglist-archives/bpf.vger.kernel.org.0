Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A335AF984
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 03:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIGBxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIGBxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 21:53:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5184EE8
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 18:53:34 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Nhr6L004428;
        Tue, 6 Sep 2022 18:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RtOf2JgKdkPd90N07G003ifNjYfd1P5DS9clmrAX1l4=;
 b=DQUzKMk13ScanOa7sG/cAP6kL+YPYggGlMci9Y35QW67bHjUn/U/Zdd8tSEXorR2tELa
 U/WCb1+8z2efhWb2xEoest2IzH/tmCIETlbHPMj0DL66BCYq4oz++vcmQGYYYWnu/oqG
 MGSPul6JytIvdpFMh/oRTIwYi5YGGg7UF7s= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3je0d0xsyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 18:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL9cIkCT7XzDAwdMVm3HOTySUnP2ryu8iyR+UDyELLPPGzBT0UDN6TD4En4owjsWGT4ywZq5rbekxpWrms/qUf5Yqkg6U6Sqr7AGeutKszHXzf8dEyJ4J3Nh5+rxg3QZQv2z2Ua+S61WmxSlnikh/CPcHRurbdwKDt5M9lH2yLGZgUXJHu7DIzTRvTF//Uae9OTONYyGb97dgtU2I8lVCuIELIUYk+xhrLoqlPjYKHRKbaZmhn7eZ8A1fyJrDP6Iqe6eM+h/QU4k8GLuF0rEipAPUUBCAYj0M8J2LUVZ+MnI9cIeOREoJ09sW/FXp/mdkdAWPQ9j7ViyRM7NfMi86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtOf2JgKdkPd90N07G003ifNjYfd1P5DS9clmrAX1l4=;
 b=oZxFnEmjUCAZ9fMzb9op58EolvuskI+cUNK4faaxC9GzM59Yyu+ZlQaqLd/oIN2QoGv/ILH4OYYwEzkkMD0tuuOlpCKZsnD31DV/SqCQ4HyWlv+T5ToEOQE9KFdE67B5Mioo8A5dxQ7QHrkKArZY8h+ADfaJZDDc5LwdH+tAyrsC1CT/bAxTf2futfF8+P3A5TT9uSgMP1RdysZ0bCLHr+bh4RAh6wci0NJaXcVdw/iN3v/1NFH8P1vOfEvXhaTG+cFlKfzfQGE2ShhopWmdF2NFgRFh8yx9zbE7GG2fXcbh5rC4y4WmDiaAZcf0Lek9t3kXlsHKtmCSg2wHMjWB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SA1PR15MB4498.namprd15.prod.outlook.com (2603:10b6:806:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 01:53:17 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::ac96:fa9e:9a44:4a23]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::ac96:fa9e:9a44:4a23%4]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 01:53:17 +0000
Message-ID: <2d2bd4ef-e8c8-194e-1d12-a45bb63c9b44@fb.com>
Date:   Tue, 6 Sep 2022 18:53:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFCv2 PATCH bpf-next 01/18] bpf: Add verifier support for custom
 callback return range
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
 <20220830172759.4069786-2-davemarchevsky@fb.com>
 <CAJnrk1ZpZ1uLtyiaOK5Sij1nANa8xhOsxMq7PKzyKjVEcL0VtA@mail.gmail.com>
 <93490d2e-6709-e21d-a38a-40296a456808@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <93490d2e-6709-e21d-a38a-40296a456808@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|SA1PR15MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ada307e-7cf0-4cf0-60ee-08da9073bb74
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0aqSvrO5n7lWPZngUWZEE8K7GhsoCTqjWfnu4YNv44xZh9pTJ/E5lhDdEG1SCeIEQPEg0u9MBJtYRlx4Ozw6kP+f6Kky9+LFu88KozjSjUPOd6ZLVL9tW80IpO5tHJz0dvyRH4A8dgBX9GhyqH3jne6x67clxXnozMcRMbPUEtmOsFga/XaNMO6TYuVSLwgWwWHZxnsw4Uhvxz8WZJ+0b7b6DdKMH77EOBM+k88hNTe/juOoGHotoMvtAhcIZiSYHqUq1gL2OvsbEROJyVbq/yU/pculPe4hxM72kgQFO+PVwhkWmdfHAw5rSESKEFWKXRSVswqMw2sg114a9iGX1Kn1ONPxnbYVemnXOyj6BE8wjcCdKNefwp6JrkBIAlWuUzs3NcKEw2G3mH1QLNJlOganvlhsLn5HTiM8IF3E+KDxnARutdGZlbxNtBuVok0ZUPYMfQZp7aBExcSEBz+4VctbjFGciXuglERbv8BI8/95C4iVIlH8yf2mAXM759sgTiGgHP3hb04taDKHmYneIsGXKK0kJeq3N7QiVXdX7G2kcmVIzYQ7eTJR08Cj+7TcSQPC+clbL3ZTuX4VPCztGKK5rNaNXXTRUtEKq/Cj/PsmVKASfA/gYvxvq37gYy8YcKHQbeaCvfdQkelw6uA9sjMyvLgpfwec2o6VXq1TDfjrKRvxWdiUicrZP8Yw0etn8cLsnvJ7My7z2HaxloqRje6J0xzXxuXzlgWg3P7mMo50C9ak4JgVw7nXtMyGNSk00HTNpBEReKk2jLSWfdI/LB5K/4X+mLr0XIJjtMnVrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(66476007)(53546011)(83380400001)(66946007)(4326008)(8676002)(8936002)(5660300002)(52116002)(66556008)(41300700001)(6506007)(478600001)(6486002)(6512007)(6666004)(186003)(2616005)(316002)(54906003)(31696002)(110136005)(86362001)(31686004)(38100700002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dpZk5oNmhuVUVueHl4eXlKZkdkRnFybUFRNzZLVkEwYmZUSUczREFmQVVW?=
 =?utf-8?B?c1NrcjZpM1BxV3U4dGVubkpFbWJBM1FLaFBkZTdtYVVsTkpMMjFtK1RPRkpo?=
 =?utf-8?B?di9BbTF3UzRQdXpnL2xmaVpPcDRPWVRTV1RxRmEwK0NhMTBYTk9jTE1rTysr?=
 =?utf-8?B?em5oNWdpS2NJS0FTWXlYOFJXenoyYjNjakl5T1krbjlsYWlwQ3NPMUtMV0pR?=
 =?utf-8?B?RjBnc3BxYTBSS0lSN3Z6K0oybDJ5T3Z4Uzh5bTgzNmg1eXBlRGxPNlRvQ0N1?=
 =?utf-8?B?RHJOV2JEaUVzZ3hxWEViVDdSVVRtSWgwMGxxZ2RJVTFKYWk4T1ZLdlVRSi9p?=
 =?utf-8?B?WHpteW5pV2FnYWhOWXFOelhPdGl0SHZEL2hjL1IrRFJXNTdNU0p4L2VRZWZ5?=
 =?utf-8?B?TjZaNG85azNwRW95VHZFL0RnTlliOXZsblEwWjNTS0xNVFBQT2lxSGdtdDM3?=
 =?utf-8?B?bUNGYkhwSnkrQUVsc0NQK1VzY25Pd1ZXTGs3eEpjN3ZoVzhRMTdQQ05HMHg2?=
 =?utf-8?B?enZrOVNVZDFSbDBiVlVrMjNJVnZJZFBLTTRLZFk5cTFLaGRrZ0JKWUZwTEVN?=
 =?utf-8?B?Z29LdEJ2TG95MXBWYUdZeTBmaVZBMTg5YXdSRlNRN1lQMjExRTBvZldSS3cy?=
 =?utf-8?B?YlRsQnZoRDhXWGxzTjNPcjNzUXp5VWVFZW4zUzA4S3VCWjY0RENudkdSUi9K?=
 =?utf-8?B?aGh3dVoxNU9keFpaSkJIdTI0UkN1c2VLc2pKeFhzVHR3NGJja1ViQ3hSSG51?=
 =?utf-8?B?QUVBR04rZlE4dm8rZGtFdTZSalRORHFwR21Uc1dmTk1RZFY1aGJpWjEzb3BL?=
 =?utf-8?B?STJzVWpHL0E1VHExWW40eWNmcUhpaVNPbEF6Ulk5dDk5SnBENjVIVm1ma2hj?=
 =?utf-8?B?RUhHOVhGVm9VVTNGSUdwN1dnYzBMUnpEUXdQVDFSNlZvdFUrRHJTMGZ3cVMx?=
 =?utf-8?B?VXdDM1BtYkxMU0N2eERmVEx3MGkxT0hSUVBhWjZSSWV1UXdLeXB5T0JQVnZz?=
 =?utf-8?B?QVlUZFRveWFOckZIUTU5bjg5YUZrVkR2WHZjNHRkOWZSY1VPd2huRTI5eW5r?=
 =?utf-8?B?akxUV1JGVmdxMnMxcWVZYmdGaThsMHA0empNdENKbHQ3Q0xCRGR2Skt3b0Yx?=
 =?utf-8?B?STViOC9Tb0NJaFl4aTNLZ1l4S2FLT3ZLNnBPT3c0aUhoanc1dVZ0SG9YUmtv?=
 =?utf-8?B?bVBLUUU2RHFCM2hlT2plVnZ6cndGa21Ja0pGczM1NDRydmdjWlFReHlyUjRV?=
 =?utf-8?B?akhLQVl3dDlaaHNnRGEwbnA2dTc3RW1SaHJhZ0YrSzdzWkc3Y2k0VHpCeG12?=
 =?utf-8?B?N1ovWVRxdkU1YlRnNDU5elhUQWdsemYxYUlEaStkcUpZYjZEWWx6Q0huOFc4?=
 =?utf-8?B?eUhsdVVOTTlTTmxwditQY2dWelpIRTFVbWFBZS90cDAzUDl5WDZjeGVJaEwy?=
 =?utf-8?B?L015eWNYcDRKK2lZMjY3eXhldW8wMVpSa2lYTk5hWStFR3M0SXRmMUVOZzBz?=
 =?utf-8?B?Wm1sV3orU1JKc2dlcEx1OFlkNmIxU3IybjR1NkNTWXVUdmhWaDYxaGtKN0Zj?=
 =?utf-8?B?OWdlMmpKaCt1S0FycXpqanNXZXByRTRCYjZnTGJERmUxZnVmZTlxVXF1bTkr?=
 =?utf-8?B?WUEvSlg1b3NuNXZXM2dJNnFQYi9zNTJEL1B5b0VpdnhvUmNGRWRMbTRDbU4v?=
 =?utf-8?B?azNNUnVOZHF6U3VBK0t3ZHhOaFBCS3JUUmdoYmFqbWFIWlg4UFFIbU5RdVJV?=
 =?utf-8?B?NkJxaVowdXBOVVdFaFExdmwxNmdVcW1PS01TZWVJWXloZ2pUbjR5aTIvWTdq?=
 =?utf-8?B?amRqUzgyQTlidklFYWp6Njg4ckY5ZlJnUnNMTkp4VnhIUXJXc3dsVGdnYk5n?=
 =?utf-8?B?eWdkMFZzbkY5MWlnSFhvQ0ZXWDBJVm5ka2FJZDFYTVNjRlVKWUE5Q0QrRUJ3?=
 =?utf-8?B?cHd5VVFlejluZk96SkdHcTRhNWEzekJlU0x1aGRWSGdoSy9JM2Y3eUFxOEl3?=
 =?utf-8?B?amhVZjFGNlBhQ3F4YlV2Mlp3RnNTdlkvRzZKSy9LSWZGQUZRTnRUbDlnTzZT?=
 =?utf-8?B?NjlCZlQ2bjlHK0NiWHl3TXRWZEFrOU1kcXJaSm80SW45ZXd5RjQ1d0VZVlJS?=
 =?utf-8?Q?CGEw1NED5SZCOSqR7qGvoPWRS?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ada307e-7cf0-4cf0-60ee-08da9073bb74
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 01:53:16.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5ONcNsBz0cdqprAlKsdkZVsLZaSbrCYd/rHIJvkO1BAatSmMvR5HCyJEUGAIt/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4498
X-Proofpoint-GUID: ZOYkAtsmAyGCD3Z7X_kD_7a-Nbt04kTV
X-Proofpoint-ORIG-GUID: ZOYkAtsmAyGCD3Z7X_kD_7a-Nbt04kTV
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

On 9/6/22 4:42 PM, Dave Marchevsky wrote:
> On 9/1/22 5:01 PM, Joanne Koong wrote:
>> On Tue, Aug 30, 2022 at 11:03 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>
>>> Verifier logic to confirm that a callback function returns 0 or 1 was
>>> added in commit 69c087ba6225b ("bpf: Add bpf_for_each_map_elem() helper").
>>> At the time, callback return value was only used to continue or stop
>>> iteration.
>>>
>>> In order to support callbacks with a broader return value range, such as
>>> those added further in this series, add a callback_ret_range to
>>> bpf_func_state. Verifier's helpers which set in_callback_fn will also
>>> set the new field, which the verifier will later use to check return
>>> value bounds.
>>>
>>> Default to tnum_range(0, 1) instead of using tnum_unknown as a sentinel
>>> value as the latter would prevent the valid range (0, U64_MAX) being
>>> used.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> ---
>>>   include/linux/bpf_verifier.h | 1 +
>>>   kernel/bpf/verifier.c        | 4 +++-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>> index 2e3bad8640dc..9c017575c034 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -237,6 +237,7 @@ struct bpf_func_state {
>>>           */
>>>          u32 async_entry_cnt;
>>>          bool in_callback_fn;
>>> +       struct tnum callback_ret_range;
>>>          bool in_async_callback_fn;
>>>
>>>          /* The following fields should be last. See copy_func_state() */
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 9bef8b41e737..68bfa7c28048 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -1745,6 +1745,7 @@ static void init_func_state(struct bpf_verifier_env *env,
>>>          state->callsite = callsite;
>>>          state->frameno = frameno;
>>>          state->subprogno = subprogno;
>>> +       state->callback_ret_range = tnum_range(0, 1);
>>>          init_reg_state(env, state);
>>>          mark_verifier_state_scratched(env);
>>>   }
>>> @@ -6879,6 +6880,7 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>>>          __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>>>          callee->in_callback_fn = true;
>>> +       callee->callback_ret_range = tnum_range(0, 1);
>>
>> Thanks for removing this restriction for callback functions!
>>
>> One quick question: is this line above needed? I think in
>> __check_func_call, we always call init_func_state() first before
>> calling set_find_vma_callback_state(), so after the init_func_state()
>> call, the callee->callback_ret_range will already be set to
>> tnum_range(0,1).
>>
> 
> You're right, it's not strictly necessary. I think that the default range being
> tnum_range(0, 1) - although necessary for backwards compat - is unintuitive. So
> decided to be explicit with existing callbacks so folks didn't have to go
> searching for the default to understand what the ret_range is, and it's more
> obvious that callback_ret_range should be changed if existing helper code is
> reused.

Maybe then it's better to keep callback_ret_range as range(0,0)
in init_func_state() to nudge/force other places to set it explicitly ?
