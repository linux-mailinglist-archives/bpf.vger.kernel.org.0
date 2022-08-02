Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94415587EA4
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiHBPKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiHBPKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 11:10:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04014186E2
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 08:10:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272CsbeS015719;
        Tue, 2 Aug 2022 08:10:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F2prLNBqWFTMfWEtA/7/ltniQeGYC+YnQ6AjfpoIbU0=;
 b=V8qMgj8wy8Q0U0s2Ya42YUlHXjXeCABgynzEJam7JabHkFEf5UemmTNnbsGAfN7rpqvh
 KPVQUGzYBxvLC0BUUoMb/1QFYe9U/xKYY1we8/ZcFZag4sd0nzaDjQ8Bv9pmUoyH1mso
 +bYAgEvt1Ui84HrcR4aQO7ao2O11E+iASUQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq4b7gy3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 08:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHvXlEdhkdAispS1ieKqKZQYf7OMKg7bJrRrOWpsgj2LoMBmAqjH+RBFGTBG0RJGaqFVRcqDyDQ2xcBmvSJDbhZbv3rp2+lGB2GqUcEMOWwxF3N0gVw4F9dpRON3cWz5+aM2vxzRE1S9Nwa4jFor50g2jomhtiGLKb8n9L4V7BU0FztYxIfi5KVjTNvr2kMGcnErLM6jwlDHpzGtlMc8MJ0kSRrZpMh8cqia/kSLrTvLqxCQ7SvikMhdRZI3Tpezyq+nT36e9fbYb3r0x6zwvvcBKbTsIBqcXNkIplmohXAAvTwJoCJkn33R+ZALc6eAlowgL/DU4YmzytT1aGjzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2prLNBqWFTMfWEtA/7/ltniQeGYC+YnQ6AjfpoIbU0=;
 b=cds5c11RdgNPmPgQyCo9+afu7N4yb3kmV6cd6BkekngxWy389q1dbidHTN4JCJMGpWHeiSfJfrxa7M+pxvEitfsjgaTGSMxyxb721pJ0DiLELheiNKkHms4jmTzOuLrxlIBfADuJ6P8j+0osMphJJmcwSBBt8attpWv1sa5ViUyz6W0qLcHEZadRcp56jpx8tiz+vPiuT0aPKULV1gneAaLND1LZkriiftrKMdrgc4P8I3G2ycYExtym0T0T93Q5Y/S5x9wtqeVY6c/fSMZUf8u8PoRS4bK4dvCI3KgNVU6YIdQ0s42fECbxvMOiRVknJiPqBOCArg2eKaFl8zcu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SA0PR15MB3854.namprd15.prod.outlook.com (2603:10b6:806:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 15:10:25 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 15:10:25 +0000
Message-ID: <c8c34c42-5592-b1f8-6581-ec5b722e66a8@fb.com>
Date:   Tue, 2 Aug 2022 08:10:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and
 PTR_ITER_END type flags
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-11-davemarchevsky@fb.com>
 <33123904-5719-9e93-4af2-c7d549221520@fb.com>
 <CAP01T754Hk3C23nYvZPR6oFQYPWVWwoGzDftEsRhXi231Ay2kA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAP01T754Hk3C23nYvZPR6oFQYPWVWwoGzDftEsRhXi231Ay2kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ec4561-8043-4a34-2c6a-08da749920b1
X-MS-TrafficTypeDiagnostic: SA0PR15MB3854:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1BY7g14Zr0zIyt6jAlFi97WfWlz4pqOO3ADAJhet0XWrHJos91j5kstyteWdESYe9TrJYXTxQlxPfxsoJ7YHbFOjVhnvnR4wq//XmP6O0pOaIPZPoppwbIZAGs8f4eIw+4PBlWQeTBK0eLSm18m0eLpSWYamcWYaSB+jfC7yzZFWZaEy03HEHr12kTINOeyVSjhGSW1mWeKAlXN/hW+VhM9dnbXuEPoGvq3voAcf5Dq6lSgsLFlSysSb+Ie8uaDU4QLjCV/16Up9arYPDWnVasDzEFyrtMae82QcviKcmX/BxK4DiZWAPejNZFAyF+oFa3cBKaNBhLnfQvUAiJj8dNerSFIubVD/O0Ne6LaxaSLfWABxhLwX3TMKysqJSDiuM4afBXRV6hmP4vwD0nfzxzHW4Ohn+8EwbS1z8DThUgkLwAXhUbur8VEHBF42WsyM2dO7UEniH811uvjmBjAVERcYJKT91jx9L3NSjbBm4F4ejLonR1/opYtOVd2kVUyeP0b/pskBVzhg7JxkGmRxhtmATE4wxXFboo46gCOBGMM3uGUsxz1WkCtOT/M6NEJLc4ggYkedAu73DtKLHTcehKp5AmObdTGXeQN1RFpYHeMkllzgLKQd+utw2Qqw6/dlbNhm23bRCA1rlfmwe2h16YDpAc+jKWDPi1Vg9nPJqItyo2Iqab9mvBGECN+KdG1SBYfBPAXOBWHfcTTAwlFB9JxO5eqnkhT8GrXBrYTVeCVmrFzk8YWR+GYO+a7n0qg/2qeexV67RoNaTKriVMMw+v4yPfiJmciUMw+x+CNbI6SVuFsc5018rrqS0Xm0Q7rbzscl6Uteot3riNX+CCmJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(8676002)(66556008)(54906003)(66946007)(36756003)(66476007)(6916009)(4326008)(8936002)(6486002)(31686004)(5660300002)(478600001)(316002)(2906002)(53546011)(41300700001)(52116002)(86362001)(2616005)(31696002)(6506007)(186003)(83380400001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjh2N2FxdHlOL29ydDlsSWZJNW1uc3JCazNCcTJjQ3RhYzI4WnRsVUlnY0Nh?=
 =?utf-8?B?eFVnRU1XYlhORzFPQjh2bDFtZ3NwZmVGRkt1TS9YbWdOcWxkbWNZaHlydC9I?=
 =?utf-8?B?R3NOeDJRZm4xOWs0T0h4UHJZQTlnTmhjeERyM3lpNHZOYklTT0V3UzhhVGU2?=
 =?utf-8?B?UFd5MGpQbG1HNERXNkN2enU0RXNTQjRRNGhrZzBPYStUK2M5M0FGWmIwcGlV?=
 =?utf-8?B?Qi85UW96TXE4ZlhqSmNWR0hBWnFhaDFYK01LcVQvRm4waHFaWFNGL0p6SVlY?=
 =?utf-8?B?d0F2Yi9ZVGpIVXAyUjRSZWRJSzlBSWV0T1Y4UXRZK2VRellRa08rc0VhZUFO?=
 =?utf-8?B?WTdralUvWnQ5WW4rV3lrUktzUkF5Q1A2Vi9odEZvaCtUb2ZpZHJBbkk3QUNp?=
 =?utf-8?B?ZTJkclA4R29aM2RnanArODVpQktjaCtFdFRHb3Q5Ky9rLzhycWhDeFJKdVc4?=
 =?utf-8?B?NkhHWXpOR3laSVJRVGxXMmpKVXgzOFF1WWhhcHNORDVKM09MQ3VnVHE3aHJV?=
 =?utf-8?B?SEdqMVpxK2c1d0pSRUJXVHQ3WDdQTGlDdEdaRjhRRTdkemJRZWZtQ0FKRk8y?=
 =?utf-8?B?eCs1RVplZ3pQWmg4ZXZNVWsyY0kvWDdoMHpxbHZyemw4L01PVEhxMTE5ekIz?=
 =?utf-8?B?dm1tR0R4Mlh5ZCsyb00yQTdDaHZUUDNNeXZLT2tGeVEydG84VWtxR0VHZmpQ?=
 =?utf-8?B?b2lCanBDMEFzZVlLdUdFUHcwS3Y2S3pGTUxuMEs2UzNDUXhJUkZCQk9HTlIx?=
 =?utf-8?B?N3JkWXY4Y3lHNC9uVnN5UlBNMmlsNVh4RHBZTHNEWVdEK0g0NThBcVN3WGVP?=
 =?utf-8?B?VHlSUXdYS2ViNGdjNGF4QTU0OUk2SWU5TjVCTXJTMktOejc1Q01uMjZIanlT?=
 =?utf-8?B?aTdBcEVIRWJCc0s4U1NiNlVuR0d2Nk9wd1N3R0VQTnJiMEprdHRDUWlzT2Fh?=
 =?utf-8?B?c0RqNHVZTHVyU1NFeGZHd3pJNkZHMUlsOGkySSszMnFydkt4aEZkN3VEbjFH?=
 =?utf-8?B?VFlJVkxvS056Q0V0S3phZlZ5TlFRaTkrT0gzQnl2VjV5UFBDWmQ2dXJ5N2NE?=
 =?utf-8?B?aHVlM1ZHTXR0S1lUUEZhTnFETS9FMU8rNTRGdS9pNERabHpTNS9FdFJmZVov?=
 =?utf-8?B?SjhaZWhjVVF1YkJadkV4U29jYzYyVkZWdTgxTmdzK1A2TkFrSUdNdG9iNFlT?=
 =?utf-8?B?cWhkemFEcUM0WjRZUTdUN0lwdmREcGNCWGVzL1h0bEhvTjZ4TnhubU1FZEFN?=
 =?utf-8?B?bk1Kcmd3RWVvdCsyenZsRDR0NE5QNDd5SC9abnJUNXJkYkg3T0xqSmk0U1cr?=
 =?utf-8?B?dzZIQ2JkK0toYTcvS0tKMXU3MmlHcmZuUHpnTUErbDRacE9vMGdWdG1tSTdD?=
 =?utf-8?B?c2xmRVZFcEhpWlhPbVJuUkNBRUxKbnhBVW0xNmxaQ2JWelM4blEvb2VjbWhi?=
 =?utf-8?B?bFpyZEplYnlVRFRhYkVZajU5MGZ0OVg0N0UvRmx0UGRaZTlXTHVJQzNvK1R1?=
 =?utf-8?B?NzViQmUwV2MvU0d1L3E4VmJoQzV3cFFzaHZVRGk0K1k2RUVxTldDdzl1dUR5?=
 =?utf-8?B?bnBFd1BGTmN3TlhTZS84aWxtMjNmd1EzWFA0MnVEN3NVT2xjZzVaVmN1U01v?=
 =?utf-8?B?Wm1sUjFSbnJ5azVnUzlqNjVOQkhXVngyOUdtQmphQWpzcExwNjBvVkdleTdn?=
 =?utf-8?B?TTlRdDJPS1Z2RzV6dnpFK1NMeWNmeUs1OU8yQkJZYmU3ZjFkdklheEYvRUJk?=
 =?utf-8?B?djhWendwN2VHaXJ0K2tybXlVZ2VwTm1RTlJlTnNIUEljaHFLUzREM0FPVHk2?=
 =?utf-8?B?eHdYWWIzRkJ3d2dFay8zME9yTWlVbElhSGh1aGp4d29rclpFRzFxMmJSdTB3?=
 =?utf-8?B?RENJOUNVZHNtdkNsS3IwNnNVTUhzUGZ3T0ZmSkgyOTVHUGs2blJ2eVFqZ3oy?=
 =?utf-8?B?TjFRM1pOdHIrOElBWk5wSW0vazVVZWNlRFlQNWtWUi9KbjVlNDd5NEF3d3BN?=
 =?utf-8?B?LzVJNDBkbTNQRDBOUHFBbks3U29LV1lUSE1Ja3Q0TUNtZkl6OGEvclNZZmg1?=
 =?utf-8?B?cTdPTUtBYUlWMEJzaStKWW9uMWxmOUo4eVJZTUVlSzdpWkZFUHUrNUdNbDlN?=
 =?utf-8?B?U3JHbXQzeHo2ZENxWVp4c2RiN2dvRDN2OVpyN0dXamhsSzc0MUI2UG9kWEhD?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ec4561-8043-4a34-2c6a-08da749920b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 15:10:25.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE8Y02+WZvici8Vbp+xhzG5F7S4nQ9a42BguV9gHfHjWPG2tcCtvKtroT3CEV7AV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3854
X-Proofpoint-ORIG-GUID: 7-iOwAdL31mE9zzyuZct7DiIWmZ5WFMI
X-Proofpoint-GUID: 7-iOwAdL31mE9zzyuZct7DiIWmZ5WFMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_09,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/2/22 6:05 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 2 Aug 2022 at 00:46, Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>>>        if (__is_pointer_value(false, reg)) {
>>> +             if (__is_iter_end(reg) && val == 0) {
>>> +                     __mark_reg_const_zero(reg);
>>> +                     switch (opcode) {
>>> +                     case BPF_JEQ:
>>> +                             return 1;
>>> +                     case BPF_JNE:
>>> +                             return 0;
>>> +                     default:
>>> +                             return -1;
>>> +                     }
>>> +             }
>>
>> as discussed the verifying the loop twice is not safe.
>> This needs more advanced verifier hacking.
>> Maybe let's postpone rbtree iters for now and resolve all the rest?
>> Or do iters with a callback, since that's more or less a clear path fwd?
>>
> 
> Can you elaborate a bit on what you think the challenges/concerns are
> (even just for educational purposes)? I am exploring a similar
> approach for one of my use cases.

struct node *elem = data_structure_iter_first(&some_map);
int i = 0;

while (elem) {
     array[i++] = 0;
     elem = data_structure_iter_next(&some_map, elem);
}

If the verifier checks the loop body only twice the array[] access
will go out of bounds.
We discussed downgrading all scalars to be not-precise (in the verifier 
terms) while verifying the body. Then we can catch such cases.
In other words the verifier need to look at any induction variable
as being unbounded, since the loop count is non deterministic.
