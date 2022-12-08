Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43664753C
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLHSBk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLHSBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:01:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73138AD313;
        Thu,  8 Dec 2022 10:01:36 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Huh3m013851;
        Thu, 8 Dec 2022 10:01:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IKx0XOvt+Bq/1+YMwu6oCV2ooLxA/GlNshkW/f/mEW0=;
 b=G31xUuKCf+E5MPxQxZrpewvcXQKJFpvAOOczRXQ6HuccahxGyZ9MBVfRaAUCZnNEC3W5
 Sw0/uBJW9BdvIsKO98EWOCflyJzurbr6YQZL00U7FbHl7w3r4cwSVS5432LitfLllg2J
 udSnxnQoEFC/nyf07aJcdbaRSVU1ITzonVfoQYMTiaE/fo8DyR9CFm8lYayT2TP66nkQ
 g4UQ3qGWwvndTkJzjEDnzKKmoa/gl3MOuCUVfPdM8YMsuB5oYUK99eDQ6bwp6JuZpiAI
 DgV7rUADCL9Gg3VyFG20cOzC/PABsbs7oO8Ebv3FvPrj6HpkGEHPDzjaZVmK8epvfYdo Ng== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3maqx7bgmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 10:01:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJyQorycgDOi1PqI9g4JPYszhh3/38yAU0k3jH7t8Vea4nCYVVhMHmpS+MFba/zHeBsdohWLoPlHZAYQkGWyGDA5b2MCnTxGj2KSobPIpKZCMLoRtXALEYWMo1tFHFiqys9mkAUJUGTOLZZGOTN1rjJPhUpwdnLHx+dc/dtJo2SPq7wfrlByypY2q5misEkLBDhk+kouvka8myuvHjpxzQ2rtXd043MQsNSUOJ7UQDgbJGw/CePRf+J0imdUHkWI5nvaPosphGO4xtP243SzmFSYG3YKI56rY70BFO+676kT48/zamVq0+oPBTSdCV1YAu5DsRXN89OFSatTdW58dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKx0XOvt+Bq/1+YMwu6oCV2ooLxA/GlNshkW/f/mEW0=;
 b=GkTzQJMjEaDxIrwjMLq+jaiD2LUF+cgPrnEHXfGq6xCaM+Sv92H2DsCOYZda1XTvpDPxg60qdnYDa+5CrphkwpK0S95D700j2S0FM6Hm9tUPnfmIKSsJrajtk6F+ikN1gyZVJdEFiX3hdzqVMRAjEbZ59A8MaFq2e0uGKc6XeADBWn4wzrO7NDLDXiuFw/MboAEy0DRTNeUVDvHc5XxeGT61OY6yEOf8OH9zNRLLeYOF6bYEpfHDWBcx+V4pwLwR8xk0AZJZN7iEILAmeqOoY9VoYItzEcLlW7XtwmJFf7+o77B4CRxUKIhFMo3zH3SYu3rFNf0lNKpsnyu+dNkOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB5563.namprd15.prod.outlook.com (2603:10b6:610:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 8 Dec
 2022 18:01:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 18:01:11 +0000
Message-ID: <0b9023b6-9742-b317-7596-98026a0c5d03@meta.com>
Date:   Thu, 8 Dec 2022 10:01:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221109024155.2810410-1-connoro@google.com>
 <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
 <CALE1s+NfHYpE_=fNr47U2groVDwhdHJJDSo6-2gdN8mR5G700g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CALE1s+NfHYpE_=fNr47U2groVDwhdHJJDSo6-2gdN8mR5G700g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bcd4b8-507d-495f-a95d-08dad9463090
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAeib1NDmGqb+db/JdiBmFrn+4SfNBLBtgFnpKM98pJLiP3ysl8bsGYG5SLpp5VwWVs5EWypxu7BxhBH5ILKPgf35RVtv8eliOKc9pkNkb5Ke/aiXnfOHyCbHhTESf4JeEAOdvTgX7PuPhi0ipw1oMwShaJchfbtDu0/oFCgMZMTB1GjKmTvypsSjLWobHhHF/ta+1VAGPN5g9b/V/umDCxGB8qoaDsbtv4BeCrBHPdg5s0eoMJZUqzsKWpprclS8xTSUALEh1HUQU8h6kFHUOdWKw77/Okcjp20PpScM8NscbcRTgChLQ0Z++h/CXzFhFp43PDUeS/EWB0TYgZHUUsQaWDI5h7cy/k2q9TD3zanF/7D6zfqfJb1yfZZV1ebdv/g52m8tj/IVuUahjUT3KLWJec6TWlK44ZSIUCDeQHenTjPBaX4DbdqHGK+mzgdes9x86dJB5KJKMvYyL/S3NrKTC4vNWHP3ignN//o4gG3ZuQOYo8h4FIzGMRKA4XlO/Nl3NkBgaf3Yck9+1lCcfgbKTxaIpylhRbBe54gUd/qDu+2Oq2cIAAWaw2BHOGHs21WC/+mFOmIVx3jzenZZttLvOmWyNtb9bzQRmYRaKDY9UxKMeXATOpQcwOq+HQ1CFefLRc5/2wCPjYFHs5vVM/mrcovoOwe4vtIlXHvdVoWS+oQ8Mggv6+RFocVpdIRzDm+r16lBPXqvAlZPV3bhNEfbZIlAG8FHp1+KdJnwYXCctdQ0WfG1jnGJqheMjJaHQGJKo6NLgTytW06U6ByjPin6Ir9lY7jVXbo7QTHurM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(5660300002)(7416002)(6506007)(53546011)(316002)(8936002)(4326008)(66476007)(66556008)(66946007)(2616005)(6916009)(38100700002)(54906003)(6512007)(186003)(86362001)(36756003)(31696002)(8676002)(41300700001)(83380400001)(6666004)(2906002)(31686004)(478600001)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnRWWEN5eTl6OHkwTDA1d21yUzJWMkgvcEhkRGZCYWlVM0p5OVF1SlVzTUdz?=
 =?utf-8?B?MjNiVlZNbCthOG5PZnpmS0VhWi9wSWY3VExwT1NIWGhDakgyam5CMFVlanhS?=
 =?utf-8?B?eDJmV2dNRW5kUWplbG1kRmJmOHM1Z2xkTWo4c09PM1ZGa0U0bjRrWis3bnlO?=
 =?utf-8?B?ZytnWWZNV2I1NTVla2w1VjFtbU1wM3NSaU12T20zdkIraEdBRExNMlZkNW1v?=
 =?utf-8?B?aEZaVXZkSkhWcFluRC9ZNkpOcWY5QTJGalZ3WE5PWkMzSHlnODloS3BxT091?=
 =?utf-8?B?MDhYQSttTjBEVmxLOGEyMkJyRzJtemd2M25YeGVXTnk2emxUVlRtbGp3djNC?=
 =?utf-8?B?dkdXb2t4aVgwZ2t1WU1hV0ROQTAxNEdYUHdMRTlLbUFlWGJNV2FLZ0NDSUZi?=
 =?utf-8?B?RzlxaUlZeUVkaDV6Sk53ajdCUWlKa3RZTnZiVUxMRnFZTjhETGJ1elVTcldX?=
 =?utf-8?B?YlhnMVhIbXdWa3V5QllQL21OeHVGa2pBelJ6cnZ0bllJUWZ2dE5iVnprUFkr?=
 =?utf-8?B?OWlwOXhqUGRXUkNGcmpzb1NscjlNL0ZCT1VWRG9WM3RjWHlKY3JQdWVnZDdE?=
 =?utf-8?B?UkNDRUN6UG5HMFNwK2Fid0Y2VjFyVldZSWhVRWJZS1puNGU1QmxaU0w1Wkli?=
 =?utf-8?B?clNzUUJSME50OWJkKzFKSEFOZDBDRzNiYWNuaHpJTFdzMXFLaFhKayt4amp6?=
 =?utf-8?B?V20rRGxxZFExaGxmNWVkd25WbW5saUdsTTBMaEE1Zmk4S094d3h3WTY1aTRX?=
 =?utf-8?B?cXNROGd5cnNKZitxbk5Fa1p2REJVQURXVkJjQjhiYjNpc1A2eWV4amNnMXdq?=
 =?utf-8?B?eWxRWG8wWTdRKy8xNXRhRVJNM2J3Q2J4MU9xanNlcFp2YWZoUmIzNit1dk5n?=
 =?utf-8?B?Y1BiMDZnMVgxcnAvYStKeTNnN3hyWFZhOTNTY0MzYVZ0VkRpbkZ5ckZSSjNV?=
 =?utf-8?B?aEtuUTNLUERtM2x6bWRCR1kxM1Y3RDFVWUZ3WG5OZ25ySjZEcndGMEZrWnpZ?=
 =?utf-8?B?c3ExZTZobmdScE5UNmlqN2ZOYXB3QlFpcnZUdGw2aTZyMzJIZlNzbFIyMTg4?=
 =?utf-8?B?UTdCUUE3a1ZZaXEwQzZjRkFPVnVuVEVzS1Y3Ym1iUlEwZk44YTlGTFcrdWlp?=
 =?utf-8?B?bUlQcndGaEViaGdFQi9yak81NnFwL05oT0ltUGVkbEVGcjMxQkdtUE82WFMz?=
 =?utf-8?B?WUlOY0RrZUFHTnJheUdUVHZ0SFF3bEhXQmd2L3YvWERpb1hhUUdaWWtpOXNS?=
 =?utf-8?B?TXF4NWRsNDVENW9lY0o3UlplT2NmNUJGa3ZScDRxZTk5cWJ5S0ZiQkprSjRS?=
 =?utf-8?B?UmtUL0lXOUpHNHNOaDR4MmxlNjRFay9rclRaUGpldHJKUWFxdWlPcUI0aEw1?=
 =?utf-8?B?RHV3QWcrR1NweXpDMStNTGdaT0JnNm9QQk9WUzdzSmVka3pRK1RmZjZRUFVE?=
 =?utf-8?B?alpGMjM0MFdPTzZXNGt6Yi96WGtyUHBuWXBWdmRkZFZjbVFYNTdyNlJpL1Ni?=
 =?utf-8?B?ZUNhM0tMejc2RTRraEdRb0FtMEVnMWZjNkJKUXA2VlJMeWJJVGpQbEhXc0lm?=
 =?utf-8?B?YVB3VmdKR24yV0Q5TytDb0JtK2NLNUo3ek9VV1Exc3lmSWoySjNzRjNzbEps?=
 =?utf-8?B?RjBLcGs5RTJtbzRoY1J4QzJPUDFXdVgybGtwVW84bzhzL3hBc0ozUERQanJs?=
 =?utf-8?B?a25tOVJFWVBTZTZWTkRYRW4yZFVpTFQvV3cxU0pTNXNNTUVxV2ZBSlNvNEVL?=
 =?utf-8?B?QnAyZENiTVlEbDRHMm9LdkxremRTN1Y3RVpkVndsK1JTeTRjN0NjVm5GaEtk?=
 =?utf-8?B?RkVGMFVsYXg4TFhWbCtrTkJFVG1FdGRkSGd2bFRHempPOHFrTTV2bWlFUUNu?=
 =?utf-8?B?aEJGd09OdllUb29ONExiOVBhTmd0cjlUT3BOV29MVE9hbVJpVXh0NEVzdVBP?=
 =?utf-8?B?TDd4R3pRM0czQVNSZ0MxZk91UWlrcmk4WVE1M3FXd2ZsTEh0NkpWTFk1OXF2?=
 =?utf-8?B?WUppTTBOSHY1bTZpcEhjc3ZVMHQvTE0zNUpvZ3M5aXgxS2RVQ0lCYU04RTQz?=
 =?utf-8?B?cnRuUHBOeFFvTGU0MC9ydEorZXhvUWxHdGJOS1NYZXB3WjhWYzVpYmlYWkdp?=
 =?utf-8?B?amZPWnV1R2hYc2Fsdnd4bXVvN3FpZlYvcUd1ak1MUy9LTVpVME5LMERrejk3?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bcd4b8-507d-495f-a95d-08dad9463090
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 18:01:11.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb7Q91dBsCyJhisAix0ec0CeNCidEFS6IXyvzwO63Mjyty8JGfNC3a2C4FviZQud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5563
X-Proofpoint-GUID: 6yK3DitxOpjlaHUbkjymcyWZRppE7dpm
X-Proofpoint-ORIG-GUID: 6yK3DitxOpjlaHUbkjymcyWZRppE7dpm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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



On 12/7/22 6:19 PM, Connor O'Brien wrote:
> On Wed, Nov 9, 2022 at 8:45 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 11/8/22 6:41 PM, Connor O'Brien wrote:
>>> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
>>> mismatches are expected and module loading should proceed
>>> anyway. Logging with pr_warn() on every one of these "benign"
>>> mismatches creates unnecessary noise when many such modules are
>>> loaded. Instead, limit logging to the case where a BTF mismatch
>>> actually prevents a module form loading.
>>>
>>> Signed-off-by: Connor O'Brien <connoro@google.com>
>>> ---
>>>    kernel/bpf/btf.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 5579ff3a5b54..406370487413 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>>                }
>>>                btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
>>>                if (IS_ERR(btf)) {
>>> -                     pr_warn("failed to validate module [%s] BTF: %ld\n",
>>> -                             mod->name, PTR_ERR(btf));
>>
>> I think such warning still useful even with
>> CONFIG_MODULE_ALLOW_BTF_MISMATCH.
>> Can we use pr_warn_ratelimited instead of pr_warn in the above to
>> avoid excessive warnings?
> 
> I gave this a try on a Pixel 6 but I'm not sure it quite addresses the
> issue. The amount of logging doesn't seem to decrease much, I think
> because the interval between loading one mismatched module and the
> next can be greater than the default rate limit. To my mind, the issue
> is the total volume of these messages more so than their rate.
> 
> For context, Android devices using the GKI may load hundreds of
> separately-built modules, and BTF mismatches are possible for any/all
> of these. It was pointed out to me that btf_verifier_log_type can also
> print several more lines per mismatched module. ~5 lines of logging
> for each mismatched module can start to add up, in terms of both
> overhead and the noise added to the kernel logs.
> 
> This is more subjective but I think the warnings also read as though
> this is a more serious failure that might prevent affected modules
> from working correctly; anecdotally, I've gotten multiple questions
> about them asking if something is broken. This can be a red herring
> for anyone unfamiliar with BTF who is reading the logs to debug
> unrelated issues. In the CONFIG_MODULE_ALLOW_BTF_MISMATCH=y case the
> flood of warnings seems out of proportion to the actual result
> (modules still load successfully, just without debug info) especially
> since the user has explicitly enabled a config saying they expect
> mismatches.
> 
> If there needs to be some logging in the "mismatch allowed" case,
> could an acceptable middle ground be to use pr_warn_once to send a

So it looks like pr_warn_ratelimited still produces a lot of warning.
In this case, I guess pr_warn_once should be okay.

> single message reporting that mismatches were detected & module BTF
> debug info might be unavailable? Alternatively, if we could opt out of
> module BTF loading then that would also avoid this issue, but that's
> already been proposed before ([1], [2]) so I thought working with the
> existing config option might be preferred.
> 
> [1] https://lore.kernel.org/bpf/20220209052141.140063-1-connoro@google.com/
> [2] https://lore.kernel.org/bpf/20221004222725.2813510-1-sdf@google.com/
