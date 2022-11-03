Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22044618A18
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiKCVBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKCVBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:01:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367386427
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:01:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A3KwKE9026487;
        Thu, 3 Nov 2022 14:01:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AQOWtV8ztAuhlMeck43m9tldDZvNzBaCLj1NAMOiVQY=;
 b=NIsjvB/JF8ggZpHnWdSexs+YaTWCs5VMvW6MUmLpU/5q3bKCHM/Kj+mma3UzRlize06/
 eP70RRbqYG/d79DawceMLEWJYppQuRbYUv2BjSR9jOR+rQQx7flFwaAQIuxkW7eYWnk+
 4LHx5JD8Fr47zUnPU31bdn45SLwGtRxuY8sRvZZW+gNq3I+31HolGgs/+wOZKyk+iQl5
 4bO6lJKBlBLvBpSPnjiGmeVguK6D9DFeirVumJs+qatG/ROmwzMxdDdIN9pT9koq7YbU
 IjSTmqvktDwtgtVOPTCudJ2qIDAfkSqDuTCmDeQ7ufrjegzUimBkoy0AerAf80fNs4+a /g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kkshd7cea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFCgra9JXr8tHWeEUBLITd/hE2rbKH+HobNhN0E+eONHsOmxVic1rnwpOltJD520BUzQoDkXpKDDGbibfIlDx3TQ2Yo4FXUBJn8avcI1Eg5wDfTPbuSNIxvQB4lVehxUSGEqfKO7CLYxk5o9mvVVHhAwyc7Y9DQ4ySM2Ao33bE5AbHnsNWrsEM2obKzrd2wvOwhsgmXjdlL5wM9wIGN9VQLL5fFm+RsWKvZk1L6zL/diQmj0atPFSk+YNsINOzNqfxG0Y4PaEZeO+QiwuSdARgqpQreWyhDVG/F6cfCYuvdFNXviOpcLYYh2x/wJEQVuE18JZqvwcWJX0v2rNDJLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQOWtV8ztAuhlMeck43m9tldDZvNzBaCLj1NAMOiVQY=;
 b=Ykmf8xULaGSHDRF1Z3KZcg1XlVrr5aizpmU7HuZYflFJEz6pJPHmrGUc9j2b0zF+1t6HdCjxbEPTGOwmPBDdCYcae6vYaRi9tLWb/a+mL1k2+0roWG4iT47hjth9MR/lEr8TzsnxucQs5xsN7IzAqMd6byv+UozH2JprRbPDtsmC14uN4axKOI684j2s05i2qr7luHm7zL7Mhjd/zp8mFLiwFeMAYQtKSNWKPJc2Yz25sivmi1+dfP3JIjzFPru+WW3jm+zoIHjcYxZ6EyJB2g8daeawHLRv+CGzw7hUbwiVnsSqyOU7C312Gh79/iE9O3w7edvUdNu2h5azRgd3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2423.namprd15.prod.outlook.com (2603:10b6:a02:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 21:00:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:00:58 +0000
Message-ID: <7916c4e0-2957-f05d-a69b-fe74ae8a264c@meta.com>
Date:   Thu, 3 Nov 2022 14:00:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2423:EE_
X-MS-Office365-Filtering-Correlation-Id: 54736200-fc4c-4800-1bf4-08dabdde8179
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSI2Hxf8YcA65F7rLD2C8BTPjCdCt2H0HAP1sfXE9UzVjzhJJ3HEDuOw67Xo5+63ge7LIk4d1P7Ww7E8bfrOd6225FgbnRTeHSzZvGSS0XrawfCqm9evxoGnErj/pyWPRprNC9yfaq/XUquZXiKW64p3HRsD7AoVeVuZCMvigc8R24tGHQ/F7O7CDFgLaAiv/nWDCoAbdpOE4prIDvNl99nr2AMo/v9deTboMgsks5uAt9drbG2BuwkJ02oyy8PJFGK1rCKphdqwBMN7jfZ2joYJAET7UJwIRxH+SvQd6jGbb77qF9m5pCeqJaajxkbBtmk3Q5Z/ElnFme+wN5c1vidOIoeUBVBD6GsACvNFl4faibz4nasPZoQ4azSvgF6cfxbXj7aZa3DAHgs8H2Ytfk7v/Xq8IMehN+ILXAFlOmb6URKC0RrBbRxUsJ4ogOmV77h1UYhfLvwQQOJsUoM7Vj6t/yyI0G7yvzUwCWC9BUbDMsLm12dnPqdgPdLvRc28aog0yRTsrU97lUbVON9O5bAA9UWlXKUD1Suna8FIbhQEXescRtZkd5k2BcWZihA/c5RocL96T5WN/MRQ6e6746d52w7JOCfUux/ZioJEo7W9cRAHz4A4oCyGS+GHfl/1EAtd7dL8JQLDmWEdQ99I7SGdQUMD1gL1rxKPlE+onlahP3bTQfIBmm2Kk1Rp4LEbxWHwb7rEQgjNhkMM7QZNZzol8+cTfsOYJnhdl7LmiLjRFP1wbO61FNTEJv0cqr/6YDt9MGUM4slMZsYKjx9o5UT7MpJGcRApM+2EWaSijl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(6486002)(83380400001)(478600001)(110136005)(54906003)(31696002)(6666004)(38100700002)(41300700001)(8936002)(86362001)(316002)(2906002)(6506007)(8676002)(36756003)(6512007)(5660300002)(31686004)(4326008)(186003)(66556008)(2616005)(66946007)(66476007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdheG10SVBwUlpqeGdRYlRETSt2NUxlZFh2RUZ5QzhnbTQwLytoejI0OGlU?=
 =?utf-8?B?bXNXL3BzVmsrZ3hrM3VzdVRBWFVWcmZXWDNlNmpweGZnYWhsa3hvcVZwL1Fa?=
 =?utf-8?B?UHZLYjlhL1loM2RvdjNWVVhyZ2ZhTzc3Qng3N2JkM1pVcWM3WE02elg2bmdU?=
 =?utf-8?B?bkVYSFlvOSt2NUgzZXowN05GWEFBMTh0USs5cUNyVkVMNmxkczNIb0J0c0tw?=
 =?utf-8?B?eTVqOWVIWDc4aUVKenNRcHBoUXFJL29MUk5jSXVENlJMUTE1cWVNR1YrekRa?=
 =?utf-8?B?YjNPNVJ6MHA4b2VheUs5Y1M3WUE2azlyL0VHL3lIM2hvWkpDTmUrdmhOelNZ?=
 =?utf-8?B?c2F1ZWRSUzdJK1hGNGhVTnZVV3NIMDFwSmhKeWFTd01JdzVNZDhEejdKMGZ1?=
 =?utf-8?B?eFVWaDRaOXhpTDFzZDZ5TFpRRUxLalFXSE1OdVVEK1I4b0xwRGlwNE1SRlNS?=
 =?utf-8?B?a0g1TTlxdlJ5WlIrWkhtbVdLSkxqMjdFd2t4dzRhYmhRSG4wWXd3ZFQ4QzAw?=
 =?utf-8?B?NFRrRXNYR2dVUGJpK2ljNnN4QXRRZ29QV3NVZ1Z3b1FZbEVUT29ta0pOZ0hW?=
 =?utf-8?B?cDI4VE1sSnMxUmF2ODlwR0lnZU44UVFkSnhvK0RHSGRoMDB3TDA4dEFJSFlw?=
 =?utf-8?B?V0VtVGhuN1NrMzRZQXB2WjBod09iMExrSzZUVGtBcC9mUmRJbGQ3WnBqcXhj?=
 =?utf-8?B?ekovUVNuSkdZZTQ0a2Jzd0hiWStGemxFaURidzRRZkJsc0VlR2RmTDlSVjJU?=
 =?utf-8?B?emlrdHdlaDRJeUcyWVRBcWNxVXBCTDRPYnpDeWVRc0pZZjh1S09QWGd2blBS?=
 =?utf-8?B?NXVSRXMvcVVYbWUyRWRLMVVFZ1VDUkJReVRMTjdIRHUvbHl3anJucUlweXpF?=
 =?utf-8?B?Z3BKb0ZwM2hBRE5JZ05HR1NRdnQramVCZXB3UDdxemNOai9yODZ0VEdYK012?=
 =?utf-8?B?bkZCcTdnRnpYamJTdElkcW9KREhBWWFIbHVySEh6V1BkWG85cHkzaHRSR01O?=
 =?utf-8?B?aE1iNkdsaWdOdUR0OUtaeUxUY0lpT1dKVHZJbUVQWWFWSnlmWW1yK2NnMFR6?=
 =?utf-8?B?TStPTmVkZGZaWld2TVFxRDh5b3RKTFVCLzcrclNRMmpzSHFHSXdwbVRWSFJz?=
 =?utf-8?B?YmJDNzRIVkx4UTRnRVg2ZUJyUklhS1NwOWt4V3ZVSGhSWUhuZ0JkK2VUS240?=
 =?utf-8?B?eDNWdVY2WXU5ak9VRGNHRXV0TGFqYlFGS3RKQmdLb0VYMWJYczZDaDF1NEtC?=
 =?utf-8?B?RDZITElPZmJlc1laS3RnTG0veVJMZGNoS1BnZ0FTSTlNYjJuRHZXWWsvdXNB?=
 =?utf-8?B?U0c1TmhVeFJvbmFZWU84SW1aQXpMbDNWQzN5dkQ1SWJtZE9wYmJydEhpby85?=
 =?utf-8?B?R0RJWFlidEdTcjUvUkRiUVM1M3V2NnNaTkhxUGZTcWVkTWhKRWZHZkl0U1Fx?=
 =?utf-8?B?bUYrbFZuMWNOM3ZFaW51ZW9Dc2ZkTXQ1UC9MTXpaVUp4K2lMd1czelRvaDZV?=
 =?utf-8?B?TDBUSm55OC9FRzV4UDYxaDBRT2Z0M3hGWkZLeGlCNmJVbkFBUEpBY1RPaUh2?=
 =?utf-8?B?MG9aWld0VDdlUU9uVHB4STNjLzNhZ1Jvcmh0a1VjVGpVRzY3MTZQR3pQbUJN?=
 =?utf-8?B?dmdVck1DaFIvalhpQ0k1Z1VxTWRWZEh6Z1lTWG80WHM2K2NKQUZmdDBtZGpq?=
 =?utf-8?B?amZ3YldidVovY0xWY0lRbmNoSllnb2dSekpWejR0UkFxY1RFMDBIK1hVRk9Z?=
 =?utf-8?B?ZURpcXlzVDRKTHlkdzcra1BuYk43cE9HOENta0pMWndMdzg2TnlwOFhFNUV1?=
 =?utf-8?B?Q1B2M0dpdGxMZmZyYlpXRTJTREFraHp4dkJsQko0TmxuZXg3a0sxOHdURENM?=
 =?utf-8?B?ZXZJOUFHWStDUU1SZjVVbHB6ckkrQ1NFcUxLcW9rWDF0OVd4N3V1V1BCWFRu?=
 =?utf-8?B?MWV6MnhVbEV3RDdMMDM0MSsxQzVBeHl5RGtUQUdVS3BBSCswS2dtNjBUTUhC?=
 =?utf-8?B?eE9lQ2V2OTZDRHM4bDBsaCt5elFrVnBtVmIxMmZ2Q010dWJEd1N5N3QyU1Nj?=
 =?utf-8?B?V0ZrUitvKzRWa0wrVjdWUnlCNThTNlJTdnBFVDdBN20vM2kyNVRNYWNLT3RR?=
 =?utf-8?B?VytqS0lZcVBTWldrNXhUcmlLaU5ha3VDelpXN3A1REVJblRvbGFWSjB1MXZo?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54736200-fc4c-4800-1bf4-08dabdde8179
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:00:58.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slPaV0Z1uLIIEZUBwwem0MVwdhCfZ26b53EYDitygNwyrQ6BEssjyf1vwJq5ptNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2423
X-Proofpoint-ORIG-GUID: Ocg95TcpR356xFO3d3JCLWBl5OrXqutk
X-Proofpoint-GUID: Ocg95TcpR356xFO3d3JCLWBl5OrXqutk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/22 7:28 AM, KP Singh wrote:
> On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
>> Both helpers are available to all program types with
>> CAP_BPF capability.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h            |  2 ++
>>   include/uapi/linux/bpf.h       | 14 ++++++++++++++
>>   kernel/bpf/core.c              |  2 ++
>>   kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>>   5 files changed, 58 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8d948bfcb984..a9bda4c91fc7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
>> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>>
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 94659f6b3395..e86389cd6133 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5481,6 +5481,18 @@ union bpf_attr {
>>    *             0 on success.
>>    *
>>    *             **-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * void bpf_rcu_read_lock(void)
>> + *     Description
>> + *             Call kernel rcu_read_lock().
> 
> Simple wrapper around rcu_read_lock() and maybe explain where and how
> it is supposed to
> be used.
> 
> e.g. the verifier will check if __rcu pointers are being accessed with
> bpf_rcu_read_lock in
> sleepable programs.

Okay, I can add more descriptions.

> 
> Calling the helper from a non-sleepable program is inconsequential,
> but maybe we can even
> avoid exposing it to non-sleepable programs?

I actually debated myself whether to make bpf_rcu_read_lock()/unlock()
to be sleepable only. Although it won't hurt for non-sleepable program,
I guess I can make it as sleepable only so users don't make mistake
to use them in non-sleepable programs.

> 
>> + *     Return
>> + *             None.
>> + *
>> + * void bpf_rcu_read_unlock(void)
>> + *     Description
>> + *             Call kernel rcu_read_unlock().
>> + *     Return
>> + *             None.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>>          FN(unspec, 0, ##ctx)                            \
>> @@ -5695,6 +5707,8 @@ union bpf_attr {
>>          FN(user_ringbuf_drain, 209, ##ctx)              \
>>          FN(cgrp_storage_get, 210, ##ctx)                \
>>          FN(cgrp_storage_delete, 211, ##ctx)             \
>> +       FN(rcu_read_lock, 212, ##ctx)                   \
>> +       FN(rcu_read_unlock, 213, ##ctx)                 \
>>          /* */
>>
[...]
