Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A326474EC
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHRUM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 12:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLHRUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 12:20:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503089AE4;
        Thu,  8 Dec 2022 09:20:09 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8GeGrP026561;
        Thu, 8 Dec 2022 09:19:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=TUmmpEYbhOQtmIOou2geUaoQ4Pak7I+1t9OnuwGZs+M=;
 b=PfZTq2J/wzIdJ+JRbxi0jFsXXrcRR+3bUj0wz09LMpMav4ZFrvRnyhHq5hMArtFABUfT
 Iol54J1Pd6hccVLxdyM61DkKSW3G9nJbensaBMA3PWosn7cIJWh5u3L3ORRyMKrd0ytn
 LV4tulQqxD/hyoV3/62hukkWUosTt6z8D7woC9XL7shxiqfpzlZHn9RNJknXn8RtXVOo
 +u0DDQbU3k6ogfHe1+xTbmTWPdv6ddxLysPSk5+jsCHXO4+PBu4yEaiq6Q0SMcvVNR2t
 UPTbzTn6yL0eQRCamBYxwI6zCswWDT4mGvUGwqR1ZG3/FksTthxIGCvlxUfSFKGXQtec wA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mavtesh6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 09:19:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T21d+fXXbsJzQdnBOMSJGIJLi1cMSwNdhT2QkN4fai20yk6pFSgtltyMeK0HN0Vq6Lkj7OSS7RHSH0sxguQaEc28B5EOliejUAMrpRhKGByWax/2UOGWVnJpQEqDVhRB10K/H2cXj7BMFnkzTpUKkl/G4O98K5tq7CNIrcd+YPt0JeAaGJmczNyjb2o1vIb5uvOum4O0GgZIIAyS+ioD0/H/RcsmO0J6AR9om+u1b0HLeN1+4Ydozx+H/5VqdnROyuSTT/xOj2sSYLUXQLB9BKgOKzVP/VvjZBwh15q26A5xP5bSzQw9fUEhymeuNhXXjp2ELVR2pLXnCAupWcemkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUmmpEYbhOQtmIOou2geUaoQ4Pak7I+1t9OnuwGZs+M=;
 b=IpWBNxqTIOFg8X8U9zaQCFt7UIgqVgHTL692Eh90cjBt0zmiAgP52xF61PenVG8yf+slsojBFYLaAkw5cBziYxWzbSL7rMxp/z600yEQ7LdzgUmiTXrI18VcGuB4CtOMB6vcVMkmMmY6i61pCtyXKEmO74faiDcHjoh7S+auhReyYmUmXTkOjrA6AmqvqTegoV1wbqA3s4ADZMUjM+xz/gXZjY8zSB7ufj3GC3dE86j1VsOlVkTw59TivVoglTT7MfWu5VOVl3yf/nJDlfl+5hmsFPDENXqUnELwIKVP+qp+CugVNlL0CIP5rB9ne0LPWNy0imGyVr15QxgCiBFpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL3PR15MB5385.namprd15.prod.outlook.com (2603:10b6:208:3b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 8 Dec
 2022 17:19:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 17:19:51 +0000
Message-ID: <36eec74e-684f-aa12-8249-1929282dae7b@meta.com>
Date:   Thu, 8 Dec 2022 09:19:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221207102721.33378-1-donald.hunter@gmail.com>
 <Y5EB5E5NgtN/ihG/@maniforge.lan> <m2r0xagkwp.fsf@gmail.com>
 <m2wn71yhtp.fsf@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <m2wn71yhtp.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL3PR15MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3a93a9-c67e-48f0-1385-08dad9406a5d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPpRuZ9RdNzGVNl7Kkdwjf2A5hZ/ugF7M24s82YRLCZXtThuBihuOch54+mnAUVHSbXz/2Gjni1RHHBU3HDUYMlb69Qzjrt/h36Ck3HJdm9PKpFj1XA53kacUn7PBt1frdvkjTVM/ScXrmKZKB/2YOfqgFjpxPYhU7dFdpvPylnyqafcozQQtUi8kLMuJD2Jf0fXgf1bFGbcmMGsa3sJvDAfhR0bnkirnt50pXXtMZTQyAt5alnE+pPvJa2Bjc8Hn39qSnKHTp664MLcah0w5YOBgcFcqnEhdZ9AA4Ywo5/iC9x10LEXnNL9WJ/qC26QD4VQvQ+GTUJi7r+5iVLD5TVJPXwvAYvu0lsrZegcCXBH7dg2jeNGQdvSQdeimLCMI6+q/eda4Y2/e/B7PWzFThaB3Sux1MJb63m3MDbkSY9ncOPXfchp5IrYV+i5JgQD4erGMUx6nROukvhcpy0lYqxj1TZCMeahHOdm9OuxxMQ2HaiY5VAFufYuKwJLRIo/TTUhVvin7fWTI8ox6p0RxkJvFo7cAEk6DK8h2d7eXdaPj7XzmUEeAaVPdaWWuIOYwzYnRDANz4UiXFuIjRvTq9G7oK/XzpS8XfCmbIfJgidu9ZOPYW2QMPYUi/5Hfz2vOn6Tp/gRtcYCjL23R5j78WVVkQayYawYiqljKvabskk94KvkQNKOHibwHO5GmtP8VQ8ybiIRVplOzo0u5TtaPkhGi3RxtXFMA5qXbOFl6Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(6506007)(38100700002)(6512007)(316002)(36756003)(31696002)(86362001)(31686004)(53546011)(110136005)(2906002)(41300700001)(54906003)(186003)(8676002)(5660300002)(83380400001)(6666004)(66476007)(478600001)(8936002)(66946007)(6486002)(2616005)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStjdytjT2VObVZZdmFDa2NPMmFuNEd5OGU4anhvYWx5clBEMkp5Sk1Yd1hQ?=
 =?utf-8?B?KzhGbkI5bmUzemlVZWVHaHRYWDF3N1JQQlhTcmh3L2EwYzd3ZlNvQTl0clZS?=
 =?utf-8?B?L0tPc0hzWFFhaWpvRUkxZ1hVZUxiQ0Zvb09vek0rTUsxNE5qNWx5ZnhHOUFL?=
 =?utf-8?B?WlliWTdzUTZyeEFFSWRWdXJseHJ0bCtwa0RGZENtMkY5c0ZaRTQ4aFhQVytW?=
 =?utf-8?B?Q2dxUWdLNXhRaUJXVnNiSTZCSE9yNnk1QnVnV2h4Zko2ZFpQUGQydVZiOVNx?=
 =?utf-8?B?Y0xSTFBNcWt6N2p2NysrUGYrWWtrVFkxNFdaK0twR3VhRFVLeW5raEtBSUJo?=
 =?utf-8?B?QW1MTitHR1J1VXB4U3RqQ1lvWklHUUtCWUM5aWxzNWNGUTdodGlTWndBdGlE?=
 =?utf-8?B?ZmZiamNDaTdwZ2NCV2dKTXJxOGpPT3hBQXJzcXo2LzV2OXNFbVNpak9sTEZj?=
 =?utf-8?B?c3NKajlCeUtPRWtwcW4rYnkwenhLWUFseXQ4cjBMVGcwUVMzZVY1VE5VZXhS?=
 =?utf-8?B?UGNWOENSZzA0Y3g3dGlxeUNtbnRTVGhpQ0pyeXF2N1N3NkxDS01kNGNueFNH?=
 =?utf-8?B?UTUzd0llQXVHdUh4TlluanJVbERKNVJNRTlIcDNQZkl6SzNOWEcxczAxam5q?=
 =?utf-8?B?QXlLa3NrYUFmbDVrMFNIeGpNUTBBVHRSTC9vcGI2N2ZYK1A2N1hXdDVhSmZM?=
 =?utf-8?B?Ymk4M0JVZGZpeU1pV3E1enFIN2NTT2tURzhrV3k1d1lqUjNORXZJZjNNQzdy?=
 =?utf-8?B?M1RTdzNFT01SaW1xT1greExseXdSbkZNMFp2MGRkd0dUb0RXWDc0OEx5QWw3?=
 =?utf-8?B?S3N5UEU3NjYxYS82VFBCSWFCMVpRa2NKSm43eW84NjRkUnBzaHhNU0tHeXB3?=
 =?utf-8?B?ODQwbVBDTDBseEhyVTRucVBBdDFHZ25yQS8xdWhxeGd1c3hqK2J3M2NTQkZK?=
 =?utf-8?B?ZGFUVmZ5SEhENUM0QzZlc29nTThJZ0lJd0IyMnNMWnY0cWNNb2JMcStHUnBl?=
 =?utf-8?B?ZnpKRzcwTjVDWFhEN0tWMk9wSzFnVEp3S2VYbkJncWgwZVhITTlIK09NQ29m?=
 =?utf-8?B?c2NCMk5WUDRYWG9qRXBwaTh4Z1VqUXFKaVJmY0habm05YkJFQ1ZYRjJGdnAz?=
 =?utf-8?B?bWdFN2VIWC9hK2RNYU9QeU96TTJvZXhoQld3cVg5NXRmU3A4bnRBeGduQ1Q4?=
 =?utf-8?B?VXkwbHVENWVNZlhpdHRJdVVYK1ovNS9WMGRUeFNxYVlGZW83djVBNVpjRjg3?=
 =?utf-8?B?cXVHZUM0amphR2dReVAzNVJFYUpzSm0wSXJKVTZXNG5QbVRJZjFwRWE0MzlO?=
 =?utf-8?B?TWh0aUpldXY0RDlyUm5XcmxIZy9obVJvazZRczU4eHFTQ3RubG1FbjhJVjJ2?=
 =?utf-8?B?RitPS3BlNkhTejNqQlJUMnc0YlJTTGhxQkhkNkRlZC9FZmxCeStEMC9IclRO?=
 =?utf-8?B?VFVwbUpaZU1pbXNQaDliT3ZvWjJMaWFnVmJpZzl2dkZLMkxQMFVBTnhhWFpT?=
 =?utf-8?B?djlsUGV2TjBOYjg3dExLVlgzdUM3MUIvMUJNQjg3ek56bVlYWGZsa3VmNWpQ?=
 =?utf-8?B?RHhoV2VTVktiMGhwSmJ3eWgrNmRxUlJGbjg4OUVxTFRsWFpZUEI4a29jWFRB?=
 =?utf-8?B?VzRIelBTUmNNL3Q4Z3EwMzA0RmQ0TWVWekFJN2g3cG1XVFROZGluUjRNcENH?=
 =?utf-8?B?SzFZUlo5bkhBV1ZZQVU0RVZJQUc4Um9ab1BFaXh4ZWlYcHFtQkhORytTajFS?=
 =?utf-8?B?d3VKMEFYR1ZUYVZOZkJGM0hxbVA5Ukg4TXg3ZllGQkp3aXQzemtDNjBpNkpJ?=
 =?utf-8?B?b1NzMFNwcmhTZWJOWXVWeGtMMkZwSHhZVUFNU1MrZVRpcG0wTUhkOEtaUkk2?=
 =?utf-8?B?Y2s0djYvaGNrUzd3VXdvYi91clhuOVhwYkxBbFFhOGszdlN4Z2VZN3d6Zmhn?=
 =?utf-8?B?SHY5YkFCV3pHTEpTUHl2ZXpETmxlS3crY1NCWGVMS2tRRkRRWmRvVzJtclR5?=
 =?utf-8?B?STk0NmovZHNGUjVZMzUwQUJkQkl0WEJacWVWRDJqK1MrbitJZEhVeGNoYkRX?=
 =?utf-8?B?bWJtc2ZrNHJrYzU1UG1NdDE2Wi9WeTNxQmJyMFQvdXRzNEppakdTRWJJQW5u?=
 =?utf-8?B?ZXRGTmpSTnpyNHpSc2VsRXNuMk54VFVmNHIyNld2VmN2ZHVOeGRRdEIrY0Fv?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3a93a9-c67e-48f0-1385-08dad9406a5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 17:19:51.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j62hO1fyL5STuWirGNYZjQS755O26ZGU5Yl8fnzIuK6b10/4SJqRBU6OH+enIzTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5385
X-Proofpoint-GUID: j_9nkR_eeu0XPNSP41mqERTstEOyhD2_
X-Proofpoint-ORIG-GUID: j_9nkR_eeu0XPNSP41mqERTstEOyhD2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/8/22 8:35 AM, Donald Hunter wrote:
> Donald Hunter <donald.hunter@gmail.com> writes:
> 
>> David Vernet <void@manifault.com> writes:
>>
>>> On Wed, Dec 07, 2022 at 10:27:21AM +0000, Donald Hunter wrote:
>>>> +
>>>> +This snippet shows how to retrieve socket-local storage in a BPF program:
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +    SEC("sockops")
>>>> +    int _sockops(struct bpf_sock_ops *ctx)
>>>> +    {
>>>> +            struct my_storage *storage;
>>>> +            struct bpf_sock *sk;
>>>> +
>>>> +            sk = ctx->sk;
>>>> +            if (!sk)
>>>> +                    return 1;
>>>
>>> Don't feel strongly about this one, but IMO it's nice for examples to
>>> illustrate code that's as close to real and pristine as possible. To
>>> that point, should this example perhaps be updated to return -ENOENT
>>> here, and -ENOMEM below?
>>
>> Will do.
>>
> 
> After digging into this a bit more I notice that the sockops programs in
> tools/testing/selftests/bpf/progs mostly return 1 in all cases.
> 
> I'm assuming that sockops programs should return valid values for
> some op types such as BPF_SOCK_OPS_TIMEOUT_INIT. Other than that I can't
> find a definitive list. Do you know if valid return values are
> enumerated anywhere, or do I need to dig some more?

It can return any integer.

static inline u32 tcp_timeout_init(struct sock *sk)
{
         int timeout;

         timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT, 0, NULL);

         if (timeout <= 0)
                 timeout = TCP_TIMEOUT_INIT;
         return min_t(int, timeout, TCP_RTO_MAX);
}

In uapi bpf.h,

         BPF_SOCK_OPS_TIMEOUT_INIT,      /* Should return SYN-RTO value 
to use or
                                          * -1 if default value should 
be used
                                          */

I think the above code is from selftests tcp_rtt.c. You can add a
reference to provide more context. If people are really interested,
they can go to selftest to find more.

> 
>>>> +
>>>> +            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
>>>> +                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
>>>> +            if (!storage)
>>>> +                    return 1;
>>>> +
>>>> +            /* Use 'storage' here */
>>>
>>> Let's return 0 at the end to make the example program technically
>>> correct.
>>
>> Will do.

In this case, 'return 0' probably not correct. I suggest keep the
code as is to sync with selftests. Add a reference to selftest
for more reference.

>>
>>>> +    }
>>>
>>> Thanks,
>>> David
